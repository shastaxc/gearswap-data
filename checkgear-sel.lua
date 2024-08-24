-- Initialization function for this job file.

require('strings')

-- Edit these to jobs you have gear sets defined for:
local jobs = T{'BLM', 'BLU', 'BRD', 'BST', 'COR', 'DNC', 'DRG', 'DRK', 'GEO', 'MNK', 'NIN', 'PLD', 'PUP', 'RDM', 'RNG', 'RUN', 'SAM', 'SCH', 'SMN', 'THF', 'WAR', 'WHM',}

mysets = {}

for k,v in pairs(jobs) do
  -- Initialize base sets
  sets = {}
  sets.TreasureHunter = {}
  sets.precast = {}
  sets.precast.FC = {}
  sets.precast.JA = {}
  sets.precast.WS = {}
  sets.precast.RA = {}
  sets.precast.Item = {}
  sets.midcast = {}
  sets.midcast.RA = {}
  sets.midcast.Pet = {}
  sets.idle = {}
  sets.resting = {}
  sets.engaged = {}
  sets.defense = {}
  sets.buff = {}
  sets.element = {}
  sets.passive = {}
  sets.weapons = {}
  sets.DuskIdle = {}
  sets.DayIdle = {}
  sets.NightIdle = {}
  gear = {}
  gear.default = {}
  gear.ElementalGorget = {name=""}
  gear.ElementalBelt = {name=""}
  gear.ElementalObi = {name=""}
  gear.ElementalCape = {name=""}
  gear.ElementalRing = {name=""}
  gear.FastcastStaff = {name=""}
  gear.RecastStaff = {name=""}

  include('Playername_' .. v:lower() .. '_gear.lua')
	-- General var initialization and setup.
  if job_setup then
    job_setup()
  end

  -- User-specific var initialization and setup.
  if user_setup then
    user_setup()
  end

  if character_setup then
    character_setup()
  end

  -- Job-User-specific var initialization and setup.
  if user_job_setup then
    user_job_setup()
  end

  if extra_user_setup then
    extra_user_setup()
  end

  init_gear_sets()

  if not sets.Reive then
    if item_owned("Adoulin's Refuge +1") then
      sets.Reive = {neck="Adoulin's Refuge +1"}
    elseif item_owned("Arciela's Grace +1") then
      sets.Reive = {neck="Arciela's Grace +1"}
    elseif item_owned("Ygnas's Resolve +1") then
      sets.Reive = {neck="Ygnas's Resolve +1"}
    else
      sets.Reive = {}
    end
  end

  mysets[v] = sets
  sets = {}
end

function get_sets()
  for k,v in pairs(mysets) do sets[k] = v end
end