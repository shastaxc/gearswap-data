--[[
  FOR MOTE'S ONLY, NOT SELINDRILE
  To checks your bags for extra gear that you're not using in any of your job's gearswap files...
  1. Put the checkgear-mote.lua file in your gearswap/data folder.
  2. Edit the variables if you want. There is a "job_whitelist" at the top. If you want it to check all your job files, just delete that whole whitelist.
  3. Run command in game: //gs load checkgear-mote.lua
  4. Check each of your bags individually for extra gear: //gs validate w, //gs validate w2, //gs validate sack, etc. Full list of options is:
      sets = 'sets', set = 'sets', s = 'sets',
      inventory = 'inventory', inv = 'inventory', i = 'inventory',
      mogsafe = 'safe', safe = 'safe', ms = 'safe', bank = 'safe',
      mogsafe2 = 'safe2', safe2 = 'safe2', ms2 = 'safe2', bank2 = 'safe2',
      storage = 'storage', st = 'storage',
      moglocker = 'locker', locker = 'locker', ml = 'locker',
      mogsatchel = 'satchel', satchel = 'satchel', sa = 'satchel',
      mogsack = 'sack', sack = 'sack', sk = 'sack',
      mogcase = 'case', case = 'case', c = 'case',
      wardrobe = 'wardrobe', w = 'wardrobe',
      wardrobe2 = 'wardrobe2', w2 = 'wardrobe2',
      wardrobe3 = 'wardrobe3', w3 = 'wardrobe3',
      wardrobe4 = 'wardrobe4', w4 = 'wardrobe4',
      wardrobe5 = 'wardrobe5', w5 = 'wardrobe5',
      wardrobe6 = 'wardrobe6', w6 = 'wardrobe6',
      wardrobe7 = 'wardrobe7', w7 = 'wardrobe7',
      wardrobe8 = 'wardrobe8', w8 = 'wardrobe8',
  5. When you're done, reload gearswap to get it back to normal working condition: //lua reload gearswap

  For debugging purposes, your gearsets are also printed out to a file at gearswap/data/checkgear/sets.txt.
]]--


--================================================================================================================
-- Set user preferences
--================================================================================================================
log_path = 'data/checkgear'

-- Edit the job_whitelist below to include only the jobs from which you want to check sets
-- If you want ALL your job files to load, delete or comment out the job_whitelist variable below
job_whitelist = T{'BLU', 'BST', 'COR', 'DNC', 'DRG', 'DRK', 'GEO', 'MNK', 'NIN', 'PLD', 'PUP', 'RNG', 'RUN', 'SAM', 'THF', 'WAR'}
-- job_whitelist = T{'BLM', 'BLU', 'COR', 'GEO', 'RDM', 'SCH', 'SMN', 'THF', 'WHM'}

--================================================================================================================
-- Include needed libraries
--================================================================================================================
res = include('resources')
files = include('files')

--================================================================================================================
-- Define helper functions
--================================================================================================================

-- Redefine event register calls so they don't fire when we load up all these files
function windower.register_event()
end
function windower.raw_register_event()
end

function init_include(job_name)
  -- Used to define various types of data mappings.  These may be used in the initialization, so load it up front.
  include('Mote-Mappings')

  -- Modes is the include for a mode-tracking variable class.  Used for state vars, below.
  include('Modes')

  -- Var for tracking state values
  state = {}

  -- General melee offense/defense modes, allowing for hybrid set builds, as well as idle/resting/weaponskill.
  -- This just defines the vars and sets the descriptions.  List modes with no values automatically
  -- get assigned a 'Normal' default value.
  state.OffenseMode         = M{['description'] = 'Offense Mode'}
  state.HybridMode          = M{['description'] = 'Hybrid Mode'}
  state.RangedMode          = M{['description'] = 'Ranged Mode'}
  state.WeaponskillMode     = M{['description'] = 'Weaponskill Mode'}
  state.CastingMode         = M{['description'] = 'Casting Mode'}
  state.IdleMode            = M{['description'] = 'Idle Mode'}
  state.RestingMode         = M{['description'] = 'Resting Mode'}

  state.DefenseMode         = M{['description'] = 'Defense Mode', 'None', 'Physical', 'Magical'}
  state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT'}
  state.MagicalDefenseMode  = M{['description'] = 'Magical Defense Mode', 'MDT'}

  state.Kiting              = M(false, 'Kiting')
  state.SelectNPCTargets    = M(false, 'Select NPC Targets')
  state.PCTargetMode        = M{['description'] = 'PC Target Mode', 'default', 'stpt', 'stal', 'stpc'}

  state.EquipStop           = M{['description'] = 'Stop Equipping Gear', 'off', 'precast', 'midcast', 'pet_midcast'}

  state.CombatWeapon        = M{['description']='Combat Weapon', ['string']=''}
  state.CombatForm          = M{['description']='Combat Form', ['string']=''}

  -- Non-mode vars that are used for state tracking.
  state.MaxWeaponskillDistance = 0
  state.Buff = {}

  -- Classes describe a 'type' of action.  They are similar to state, but
  -- may have any free-form value, or describe an entire table of mapped values.
  classes = {}
  -- Basic spell mappings are based on common spell series.
  -- EG: 'Cure' for Cure, Cure II, Cure III, Cure IV, Cure V, or Cure VI.
  classes.SpellMaps = spell_maps
  -- List of spells and spell maps that don't benefit from greater skill (though
  -- they may benefit from spell-specific augments, such as improved regen or refresh).
  -- Spells that fall under this category will be skipped when searching for
  -- spell.skill sets.
  classes.NoSkillSpells = no_skill_spells_list
  classes.SkipSkillCheck = false
  -- Custom, job-defined class, like the generic spell mappings.
  -- Takes precedence over default spell maps.
  -- Is reset at the end of each spell casting cycle (ie: at the end of aftercast).
  classes.JAMode = nil
  classes.CustomClass = nil
  -- Custom groups used for defining melee and idle sets.  Persists long-term.
  classes.CustomMeleeGroups = L{}
  classes.CustomRangedGroups = L{}
  classes.CustomIdleGroups = L{}
  classes.CustomDefenseGroups = L{}

  -- Class variables for time-based flags
  classes.Daytime = false
  classes.DuskToDawn = false


  -- Var for tracking misc info
  info = {}
  options = {}

  -- Special control flags.
  mote_vars = {}
  mote_vars.set_breadcrumbs = L{}
  mote_vars.res_buffs = S{}
  for index,struct in pairs(gearswap.res.buffs) do
      mote_vars.res_buffs:add(struct.en)
  end

  -- Sub-tables within the sets table that we expect to exist, and are annoying to have to
  -- define within each individual job file.  We can define them here to make sure we don't
  -- have to check for existence.  The job file should be including this before defining
  -- any sets, so any changes it makes will override these anyway.
  sets.precast = {}
  sets.precast.FC = {}
  sets.precast.JA = {}
  sets.precast.WS = {}
  sets.precast.RA = {}
  sets.midcast = {}
  sets.midcast.RA = {}
  sets.midcast.Pet = {}
  sets.idle = {}
  sets.resting = {}
  sets.engaged = {}
  sets.defense = {}
  sets.buff = {}

  gear = {}
  gear.default = {}

  gear.ElementalGorget = {name=""}
  gear.ElementalBelt = {name=""}
  gear.ElementalObi = {name=""}
  gear.ElementalCape = {name=""}
  gear.ElementalRing = {name=""}
  gear.FastcastStaff = {name=""}
  gear.RecastStaff = {name=""}

  -- Used to define misc utility functions that may be useful for this include or any job files.
  include('Mote-Utility')

  -- Include general user globals, such as custom binds or gear tables.
  -- Load Mote-Globals first, followed by User-Globals, followed by <character>-Globals.
  -- Any functions re-defined in the later includes will overwrite the earlier versions.
  include('Mote-Globals')
  optional_include({'user-globals.lua'})
  optional_include({player.name..'-globals.lua'})

  -- *-globals.lua may define additional sets to be added to the local ones.
  if define_global_sets then
    define_global_sets()
  end

  -- Load a sidecar file for the job (if it exists) that may re-define init_gear_sets and file_unload.
  load_sidecar(job_name)

  -- General var initialization and setup.
  if job_setup then
    job_setup()
  end

  -- User-specific var initialization and setup.
  if user_setup then
    user_setup()
  end

  -- Load up all the gear sets.
  init_gear_sets()
end

function get_user_filename(job_id)
  job_id = tonumber(job_id)

  local long_job = res.jobs[job_id].english
  local short_job = res.jobs[job_id].english_short
  local tab = {player.name..'_'..short_job..'.lua',player.name..'-'..short_job..'.lua',
      player.name..'_'..long_job..'.lua',player.name..'-'..long_job..'.lua',
      player.name..'.lua',short_job..'.lua',long_job..'.lua','default.lua'}
  local path,base_dir,filename = gearswap.pathsearch(tab)

  if not path then
    return
  end

  return filename
end

-- Returns a concatenated string list, separated by whitespaces, for the chat output function.
-- Converts any kind of object type to a string, so it's type-safe.
-- Concatenates all provided arguments with whitespaces.
function arrstring(...)
  local str = ''
  local args = {...}

  for i = 1, select('#', ...) do
    if i > 1 then
      str = str..' '
    end
    str = str .. tostring(args[i])
  end

  return str
end

-- Prints the arguments provided to a file, analogous to log(...) in functionality.
-- If the first argument ends with '.log', it will print to that output file, otherwise to 'lua.log' in the addon directory.
function flog(filename, ...)
  local fh, err = io.open(lua_base_path..filename, 'w+')
  if fh == nil then
    if err ~= nil then
      print('File error: '..err)
    else
      print('File error: Unknown error.')
    end
  else
    fh:write(os.date('%Y-%m-%d %H:%M:%S') .. '| ' .. arrstring(...) .. '\n')
    fh:close()
  end
end

-- Checks if job exists on a whitelist. If no whitelist exists or is empty, allow it.
function is_job_whitelisted(job_name)
  if not job_whitelist then return true end
  if job_whitelist:length() == 0 then return true end

  return job_whitelist:contains(job_name)
end

--================================================================================================================
-- Run main function
--================================================================================================================

-- Tracks the super table of all job's sets
mysets = {}

for job_id,job_info in pairs(res.jobs) do
  local job_name = job_info.english_short

  -- Check whitelist
  if is_job_whitelisted(job_name) then
    -- Get filename for job
    filename = get_user_filename(job_id)
    if filename then
      print('Loading '..filename)
      -- Load the file
      include(filename)

      init_include(job_name)

      mysets[job_name] = sets
      sets = {}
    end
  end
end

-- Stops gearswap from running the get_sets function from the last loaded job file
function get_sets()
end

sets = mysets
files.create_path(log_path)
flog(log_path..'/sets.txt', table.tovstring(sets))
