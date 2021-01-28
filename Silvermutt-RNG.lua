-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+NumLock ]    Double Shot
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+Ins/Del ]    Cycles between available Weapon Sets
--
--  WS:         [ ALT+Numpad 1-9 ]  Dependent on ranged weapon equipped
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs c equipweapons')
    send_command('gs c equiprangedweapons')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  silibs.use_weapon_rearm = true

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef')
  state.RangedMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.IdleMode:options('Normal', 'LightDef')
  state.WeaponSet = M{['description']='Weapon Set', 'MagicRA', 'PhysRA', 'PhysRA RangedOnly', 'PhysRA NoBuff', 'Melee', 'CritRA'}
  state.RangedWeaponSet = M{['description']='Ranged Weapon Set', 'Doomsday', "Pharaoh's Bow", "Grosveneur's Bow", 'Gastraphetes', 'Sparrowhawk'}
  state.CP = M(false, "Capacity Points Mode")
  state.RearmingLock = M(false, 'Rearming Lock')
  -- Whether a warning has been given for low ammo
  state.warned = M(false)
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.Buff.Barrage = buffactive.Barrage or false
  state.Buff.Camouflage = buffactive.Camouflage or false
  state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
  state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
  state.Buff['Double Shot'] = buffactive['Double Shot'] or false

  elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}
  no_swap_waists = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

  marksman_weapon_subtypes = {
    ["Grosveneur's Bow"] = "xbow",
    ['Doomsday'] = "gun",
    ['Gastraphetes'] = "xbow",
  }

  DefaultAmmo = {
    ["Pharaoh's Bow"] = "Eminent Arrow",
    ["Grosveneur's Bow"] = "Eminent Bolt",
    ['Doomsday'] = "Eminent Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    -- ['Gastraphetes'] = "Quelling Bolt",
    ['Gastraphetes'] = "Eminent Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
    ['Sparrowhawk'] = "Eminent Arrow",
    ['Sparrowhawk +1'] = "Eminent Arrow",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
  }
  AccAmmo = {
    ["Pharaoh's Bow"] = "Eminent Arrow",
    ["Grosveneur's Bow"] = "Eminent Bolt",
    ['Doomsday'] = "Eminent Bullet",
    ['Yoichinoyumi'] = "Yoichi's Arrow",
    ['Gandiva'] = "Yoichi's Arrow",
    ['Fail-Not'] = "Yoichi's Arrow",
    ['Annihilator'] = "Eradicating Bullet",
    ['Armageddon'] = "Eradicating Bullet",
    -- ['Gastraphetes'] = "Quelling Bolt",
    ['Gastraphetes'] = "Eminent Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
    ['Sparrowhawk'] = "Eminent Arrow",
    ['Sparrowhawk +1'] = "Eminent Arrow",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
  }
  WSAmmo = {
    ["Pharaoh's Bow"] = "Eminent Arrow",
    ["Grosveneur's Bow"] = "Eminent Bolt",
    ['Doomsday'] = "Eminent Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    -- ['Gastraphetes'] = "Quelling Bolt",
    ['Gastraphetes'] = "Eminent Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
    ['Sparrowhawk'] = "Eminent Arrow",
    ['Sparrowhawk +1'] = "Eminent Arrow",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
  }
  MagicAmmo = {
    ["Pharaoh's Bow"] = "Eminent Arrow",
    ["Grosveneur's Bow"] = "Eminent Bolt",
    ['Doomsday'] = "Eminent Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Devastating Bullet",
    ['Armageddon'] = "Devastating Bullet",
    -- ['Gastraphetes'] = "Quelling Bolt",
    ['Gastraphetes'] = "Eminent Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
    ['Sparrowhawk'] = "Eminent Arrow",
    ['Sparrowhawk +1'] = "Eminent Arrow",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
  }

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
  send_command('bind ^insert gs c cycle WeaponSet')
  send_command('bind ^delete gs c cycleback WeaponSet')
  send_command('bind ^home gs c cycle RangedWeaponSet')
  send_command('bind ^end gs c cycleback RangedWeaponSet')

  send_command('bind !q input /ja "Velocity Shot" <me>')
  send_command('bind !` input /ja "Scavenge" <me>')
  send_command('bind ^numlock input /ja "Double Shot" <me>')
  send_command('bind numpad0 input /ra <t>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.set_lockstyle(6)
  Haste = 0 -- Do not modify
  flurry = nil -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify
  current_dp_type = nil -- Do not modify
  locked_waist = false -- Do not modify

  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'THF' then
    send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
    send_command('bind ^numpad. input /ja "Trick Attack" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('bind ^`')
  send_command('unbind @c')
  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind ^home')
  send_command('unbind ^end')

  send_command('unbind !q')
  send_command('unbind !`')

  send_command('unbind !w')

  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind numpad0')
end


-- Set up all gear sets.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Eagle Eye Shot'] = {
    legs="Arcadian Braccae +3",
  }
  sets.precast.JA['Bounty Shot'] = {
    -- hands="Amini Glove. +1"
  }
  sets.precast.JA['Camouflage'] = {
    body="Orion Jerkin +1"
    -- body="Orion Jerkin +3"
  }
  sets.precast.JA['Scavenge'] = {
    feet="Orion Socks +1"
    -- feet="Orion Socks +3"
  }
  sets.precast.JA['Shadowbind'] = {
    hands="Orion Bracers +2"
    -- hands="Orion Bracers +3"
  }
  sets.precast.JA['Sharpshot'] = {
    legs="Orion Braccae +1"
  }

  sets.precast.Waltz = {
    waist="Gishdubar Sash",
    -- body="Passion Jacket",
    -- ring1="Asklepian Ring",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    head=gear.Herc_WSD_head, --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Weatherspoon Ring", --5
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    -- body="Passion Jacket",
  })

  -- (10% Snapshot, 5% Rapid from Merits)
  sets.precast.RA = {
    head=gear.Taeon_RA_head, --10/0
    hands=gear.Carmine_D_hands, --8/11
    legs="Orion Braccae +1", --12/0
    feet="Meg. Jam. +2", --10/0
    neck="Scout's Gorget +1", --3/0
    back=gear.RNG_SNP_Cape, --10/0
    waist="Impulse Belt", --3/0

    -- Goal:
    -- head=gear.Taeon_RA_head, --10/0
    -- body="Amini Caban +1", --0/0
    -- hands=gear.Carmine_D_hands, --8/11
    -- legs="Orion Braccae +3", --15/0
    -- feet="Meg. Jam. +2", --10/0
    -- neck="Scout's Gorget +2" --4/0
    -- back=gear.RNG_SNP_Cape, --10/0
    -- waist="Impulse Belt", --3/0
    --60 Snapshot / 11 Rapid Shot

    -- Best:
    -- head=gear.Taeon_RA_head, --10/0
    -- body="Oshosi Vest +1", --14/0
    -- hands=gear.Carmine_D_hands, --8/11
    -- legs=gear.Adhemar_D_legs, --10/13
    -- feet="Meg. Jam. +2", --10/0
    -- back=gear.RNG_SNP_Cape, --10/0
    -- waist="Yemaya Belt", --0/5
    --62 Snapshot / 29 Rapid Shot
  } --56 Snapshot / 11 Rapid Shot

  -- (15% Flurry, 10% Snapshot, 5% Rapid from Merits)
  sets.precast.RA.Flurry1 = {
    head=gear.Taeon_RA_head, --10/0
    hands=gear.Carmine_D_hands, --8/11
    feet="Meg. Jam. +2", --10/0
    neck="Scout's Gorget +1", --3/0
    back=gear.RNG_SNP_Cape, --10/0
    waist="Impulse Belt", --3/0

    -- Goal:
    -- head="Orion Beret +3", --0/18
    -- body="Amini Caban +1", --0/0
    -- hands=gear.Carmine_D_hands, --8/11
    -- legs=gear.Adhemar_D_legs, --10/13
    -- feet="Meg. Jam. +2", --10/0
    -- neck="Scout's Gorget +2", --4/0
    -- back=gear.RNG_SNP_Cape, --10/0
    -- waist="Impulse Belt", --3/0
    --45 Snapshot / 42 Rapid Shot
  } --44 Snapshot / 11 Rapid Shot

  -- (30% Flurry, 10% Snapshot, 5% Rapid from Merits)
  sets.precast.RA.Flurry2 = {
    head="Orion Beret +2", --0/16
    hands=gear.Carmine_D_hands, --8/11
    feet="Meg. Jam. +2", --10/0
    neck="Scout's Gorget +1", --3/0
    back=gear.RNG_SNP_Cape, --10/0
    waist="Impulse Belt", --3/0

    -- Goal:
    -- head="Orion Beret +3", --0/18
    -- body="Amini Caban +1", --0/0
    -- hands=gear.Carmine_D_hands, --8/11
    -- legs=gear.Adhemar_D_legs, --10/13
    -- feet="Arcadian Socks +3", --0/10
    -- neck="Scout's Gorget +2", --4/0
    -- back=gear.RNG_SNP_Cape, --10/0
    -- waist="Yemaya Belt", --0/5
    --32 Snapshot / 57 Rapid Shot
  } --34 Snapshot / 27 Rapid Shot

  sets.precast.RA.Gastra = set_combine(sets.precast.RA, {
    -- head="Orion Beret +3", --0/18
  })
  sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Flurry1, {
    -- feet="Arcadian Socks +3", --0/10
  })
  sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Flurry2, {
    -- legs=gear.Pursuers_A_legs, --0/19
  })


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    head="Orion Beret +2",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Arcadian Braccae +3",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Dingir Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
    -- head="Orion Beret +3",
    -- body=gear.Herc_RA_WSD_body,
    -- feet=gear.Herc_RA_WSD_feet,
    -- ring2="Epaminondas's Ring",
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Telos Earring",
  })
  sets.precast.WS.LowAcc = set_combine(sets.precast.WS, {
    waist="Kwahu Kachina Belt +1",
    ear1="Beyla Earring",
  })
  sets.precast.WS.LowAccMaxTP = set_combine(sets.precast.WS.LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS.MidAcc = set_combine(sets.precast.WS.LowAcc, {
    -- feet="Arcadian Socks +3",
  })
  sets.precast.WS.MidAccMaxTP = set_combine(sets.precast.WS.MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
  })
  sets.precast.WS.HighAccMaxTP = set_combine(sets.precast.WS.HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Apex Arrow'] = sets.precast.WS
  sets.precast.WS['Apex Arrow'].MaxTP = set_combine(sets.precast.WS['Apex Arrow'], {
  })
  sets.precast.WS['Apex Arrow'].LowAcc = set_combine(sets.precast.WS['Apex Arrow'], {
    waist="Kwahu Kachina Belt +1",
    ear1="Beyla Earring",
  })
  sets.precast.WS['Apex Arrow'].LowAccMaxTP = set_combine(sets.precast.WS['Apex Arrow'].LowAcc, {
  })
  sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'].LowAcc, {
    feet="Orion Socks +1",
    -- feet="Orion Socks +3",
  })
  sets.precast.WS['Apex Arrow'].MidAccMaxTP = set_combine(sets.precast.WS['Apex Arrow'].MidAcc, {
  })
  sets.precast.WS['Apex Arrow'].HighAcc = set_combine(sets.precast.WS['Apex Arrow'].MidAcc, {
  })
  sets.precast.WS['Apex Arrow'].HighAccMaxTP = set_combine(sets.precast.WS['Apex Arrow'].HighAcc, {
  })

  sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {
    head="Mummu Bonnet +2",
    hands="Mummu Wrists +2",
    legs="Arcadian Braccae +3",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Begrudging Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
    -- body="Abnoba Kaftan",
    -- feet="Thereoid Greaves",
    -- ring2="Mummu Ring",
  })
  sets.precast.WS['Jishnu\'s Radiance'].MaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
  })
  sets.precast.WS['Jishnu\'s Radiance'].LowAcc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
    ear2="Telos Earring",
    waist="Kwahu Kachina Belt +1",
  })
  sets.precast.WS['Jishnu\'s Radiance'].LowAccMaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'].LowAcc, {
  })
  sets.precast.WS['Jishnu\'s Radiance'].MidAcc = set_combine(sets.precast.WS['Jishnu\'s Radiance'].LowAcc, {
    legs="Mummu Kecks +2",
    neck="Iskur Gorget",
    ring1="Regal Ring",
  })
  sets.precast.WS['Jishnu\'s Radiance'].MidAccMaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'].MidAcc, {
  })
  sets.precast.WS['Jishnu\'s Radiance'].HighAcc = set_combine(sets.precast.WS['Jishnu\'s Radiance'].MidAcc, {
    ear1="Beyla Earring",
    ring2="Hajduk Ring +1",
    -- feet="Arcadian Socks +3",
  })
  sets.precast.WS['Jishnu\'s Radiance'].HighAccMaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'].HighAcc, {
  })

  sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
    head="Orion Beret +2",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Arcadian Braccae +3",
    feet=gear.Herc_WSD_feet,
    neck="Scout's Gorget +1",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Dingir Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
    -- head="Orion Beret +3",
    -- body=gear.Herc_RA_WSD_body,
    -- feet=gear.Herc_RA_WSD_feet,
    -- neck="Scout's Gorget +2",
    -- ring2="Epaminondas's Ring",
  })
  sets.precast.WS['Last Stand'].MaxTP = set_combine(sets.precast.WS['Last Stand'], {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].LowAcc = set_combine(sets.precast.WS['Last Stand'], {
    ear2="Telos Earring",
    waist="Kwahu Kachina Belt +1",
  })
  sets.precast.WS['Last Stand'].LowAccMaxTP = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].MidAcc = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
    feet="Orion Socks +1",
    ring2="Hajduk Ring +1",
    -- feet="Orion Socks +3",
  })
  sets.precast.WS['Last Stand'].MidAccMaxTP = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    ear1="Beyla Earring",
  })
  sets.precast.WS['Last Stand'].HighAccMaxTP = set_combine(sets.precast.WS['Last Stand'].HighAcc, {
  })

  sets.precast.WS["Coronach"] = set_combine(sets.precast.WS['Last Stand'], {
    ear2="Sherida Earring",
    neck="Scout's Gorget +1",
    -- neck="Scout's Gorget +2",
  })
  sets.precast.WS["Coronach"].MaxTP = set_combine(sets.precast.WS['Coronach'], {
  })
  sets.precast.WS["Coronach"].LowAcc = set_combine(sets.precast.WS['Coronach'], {
    ear1="Telos Earring",
  })
  sets.precast.WS["Coronach"].LowAccMaxTP = set_combine(sets.precast.WS['Coronach'].LowAcc, {
  })
  sets.precast.WS["Coronach"].MidAcc = set_combine(sets.precast.WS['Coronach'].LowAcc, {
    ear2="Beyla Earring",
  })
  sets.precast.WS["Coronach"].MidAccMaxTP = set_combine(sets.precast.WS['Coronach'].MidAcc, {
  })
  sets.precast.WS["Coronach"].HighAcc = set_combine(sets.precast.WS['Coronach'].MidAcc, {
  })
  sets.precast.WS["Coronach"].HighAccMaxTP = set_combine(sets.precast.WS['Coronach'].HighAcc, {
  })

  sets.precast.WS["Trueflight"] = {
    head=empty,
    body="Cohort Cloak +1",
    hands=gear.Carmine_D_hands,
    legs="Arcadian Braccae +3",
    feet=gear.Herc_MAB_feet, --50
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    ring1="Weatherspoon Ring",
    ring2="Dingir Ring",
    neck="Scout's Gorget +1",
    back=gear.RNG_WS2_Cape,
    waist="Eschan Stone",
    -- hands=gear.Herc_MAB_hands,
    -- ring1="Epaminondas's Ring",
    -- back=gear.RNG_WS1_Cape,
    -- waist="Orpheus's Sash",
  } -- AGI / MAB
  sets.precast.WS["Trueflight"].MaxTP = set_combine(sets.precast.WS["Trueflight"], {
    ear2="Novio Earring",
  })
  sets.precast.WS["Trueflight"].LowAcc = set_combine(sets.precast.WS["Trueflight"], {
  })
  sets.precast.WS["Trueflight"].LowAccMaxTP = set_combine(sets.precast.WS["Trueflight"].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS["Trueflight"].MidAcc = set_combine(sets.precast.WS["Trueflight"].LowAcc, {
  })
  sets.precast.WS["Trueflight"].MidAccMaxTP = set_combine(sets.precast.WS["Trueflight"].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS["Trueflight"].HighAcc = set_combine(sets.precast.WS["Trueflight"].MidAcc, {
  })
  sets.precast.WS["Trueflight"].HighAccMaxTP = set_combine(sets.precast.WS["Trueflight"].HighAcc, {
    ear2="Novio Earring",
  })

  sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].MaxTP = set_combine(sets.precast.WS["Trueflight"].MaxTP, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].LowAcc = set_combine(sets.precast.WS["Trueflight"].LowAcc, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].LowAccMaxTP = set_combine(sets.precast.WS["Trueflight"].LowAccMaxTP, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].MidAcc = set_combine(sets.precast.WS["Trueflight"].MidAcc, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].MidAccMaxTP = set_combine(sets.precast.WS["Trueflight"].MidAccMaxTP, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].HighAcc = set_combine(sets.precast.WS["Trueflight"].HighAcc, {
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Wildfire"].HighAccMaxTP = set_combine(sets.precast.WS["Trueflight"].HighAccMaxTP, {
    ring1="Shiva Ring +1",
  })

  sets.precast.WS['Evisceration'] = {
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs=gear.Samnuha_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Odr Earring",
    ear2="Moonshade Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",

    -- Goal:
    -- body="Abnoba Kaftan",
    -- legs="Zoar Subligar +1",
    -- back=gear.RNG_Melee_Crit_Cape
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear2="Sherida Earring",
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
    head="Dampening Tam",
    ring2="Chirich Ring +1",
  })
  sets.precast.WS['Evisceration'].LowAccMaxTP = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
    ear2="Sherida Earring",
  })
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
    ear2="Dignitary's Earring",
    body=gear.Adhemar_B_body,
  })
  sets.precast.WS['Evisceration'].MidAccMaxTP = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
  })

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    head="Orion Beret +2",
    hands="Meghanada Gloves +2",
    legs="Arcadian Braccae +3",
    feet=gear.Herc_WSD_feet,
    neck="Scout's Gorget +1",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Sailfi Belt +1",
    -- head="Orion Beret +3",
    -- body=gear.Herc_STR_WSD_body,
    -- feet=gear.Herc_STR_WSD_feet,
    -- neck="Scout's Gorget +2",
    -- ring2="Epaminondas's Ring",
    -- back=gear.RNG_STR_WSD_Cape,
  })
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
  })
  sets.precast.WS['Savage Blade'].LowAcc = set_combine(sets.precast.WS['Savage Blade'], {
    ear1="Telos Earring",
    ring2="Chirich Ring +1",
  })
  sets.precast.WS['Savage Blade'].LowAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
  })
  sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
  })
  sets.precast.WS['Savage Blade'].MidAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
  })
  sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
  })
  sets.precast.WS['Savage Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].HighAcc, {
  })

  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['Evisceration'], {
    feet=gear.Herc_TA_feet
  })
  sets.precast.WS['Rampage'].MaxTP = sets.precast.WS['Evisceration']
  sets.precast.WS['Rampage'].LowAcc = sets.precast.WS['Evisceration']
  sets.precast.WS['Rampage'].LowAccMaxTP = sets.precast.WS['Evisceration'].LowAcc
  sets.precast.WS['Rampage'].MidAcc = sets.precast.WS['Evisceration'].LowAcc
  sets.precast.WS['Rampage'].MidAccMaxTP = sets.precast.WS['Evisceration'].MidAcc
  sets.precast.WS['Rampage'].HighAcc = sets.precast.WS['Evisceration'].MidAcc
  sets.precast.WS['Rampage'].HighAccMaxTP = sets.precast.WS['Evisceration'].HighAcc

  sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS["Trueflight"], {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].MaxTP = set_combine(sets.precast.WS["Trueflight"].MaxTP, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].LowAcc = set_combine(sets.precast.WS["Trueflight"].LowAcc, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].LowAccMaxTP = set_combine(sets.precast.WS["Trueflight"].LowAccMaxTP, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].MidAcc = set_combine(sets.precast.WS["Trueflight"].MidAcc, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].MidAccMaxTP = set_combine(sets.precast.WS["Trueflight"].MidAccMaxTP, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].HighAcc = set_combine(sets.precast.WS["Trueflight"].HighAcc, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })
  sets.precast.WS["Aeolian Edge"].HighAccMaxTP = set_combine(sets.precast.WS["Trueflight"].HighAccMaxTP, {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast recast for spells
  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    legs=gear.Carmine_D_legs, --20
    -- ring1="Evanescence Ring", --5
    -- waist="Rumination Sash", --10
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  -- Ranged sets
  sets.midcast.RA = {
    head="Arcadian Beret +2", --32 [0] 27/47 <0> {0} (36)
    body="Malignance Tabard", --42 [11] 50/0 <0> {6} (0)
    hands="Malignance Gloves", --24 [12] 50/0 <0> {4} (0)
    legs="Malignance Tights", --42 [10] 50/0 <0> {5} (0)
    feet="Malignance Boots", --49 [9] 50/0 <0> {2} (0)
    neck="Scout's Gorget +1",
    ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    ear2="Sherida Earring",
    ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    ring2="Dingir Ring", --10 [0] 0/25 <0> {0} (10)
    back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)

    -- Goal:
    -- head="Arcadian Beret +3", --37 [0] 37/62 <0> {0} (38)
    -- body="Malignance Tabard", --42 [11] 50/0 <0> {6} (0)
    -- hands="Malignance Gloves", --24 [12] 50/0 <0> {4} (0)
    -- legs="Malignance Tights", --42 [10] 50/0 <0> {5} (0)
    -- feet="Malignance Boots", --49 [9] 50/0 <0> {2} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Enervating Earring", --0 [4] 7/7 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Dingir Ring", --10 [0] 0/25 <0> {0} (10)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Yemaya Belt", --7 [4] 10/10 <0> {0} (0)
    --276 AGI [72 STP] 309 racc / 154 ratt <0 crit> {27 dmg limit} (48 Recycle)

    -- Best:
    -- head="Arcadian Beret +3", --37 [0] 37/62 <0> {0} (38)
    -- body="Nisroch Jerkin", --40 [7] 45/45 <10> {0} (0)
    -- hands="Malignance Gloves", --24 [12] 50/0 <0> {4} (0)
    -- legs=gear.Adhemar_C_legs, --42 [8] 54/54 <0> {0} (16)
    -- feet="Malignance Boots", --49 [9] 50/0 <0> {2} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Dedition Earring", --0 [8] -10/-10 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Ilabrat Ring", --10 [5] 0/0 <0> {0} (0)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)
    --275 AGI [71 STP] 301 racc / 201 ratt <15 crit> {16 dmg limit} (54 Recycle)
  }
  sets.midcast.RA.LowAcc = set_combine(sets.midcast.RA, {
    legs="Mummu Kecks +2",
  })
  sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA.LowAcc, {
    ear2="Beyla Earring", --0 [0] 15/0 <0> {0} (0)
    ring2="Hajduk Ring +1", --0 [0] 17/0 <0> {0} (0)
    -- Goal:
    -- head="Arcadian Beret +3", --37 [0] 37/62 <0> {0} (38)
    -- body="Malignance Tabard", --42 [11] 50/0 <0> {6} (0)
    -- hands="Malignance Gloves", --24 [12] 50/0 <0> {4} (0)
    -- legs="Malignance Tights", --42 [10] 50/0 <0> {5} (0)
    -- feet="Orion Socks +3", --49 [0] 54/36 <0> {0} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Beyla Earring", --0 [0] 15/0 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Hajduk Ring +1", --0 [0] 17/0 <0> {0} (0)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)
    -- Includes set bonus 15 racc from orion + regal
    -- 267 AGI [55 STP] 363 racc / 148 ratt <5 crit> {25 dmg limit} (48 Recycle)

    -- Best:
    -- head="Arcadian Beret +3", --37 [0] 37/62 <0> {0} (38)
    -- body="Nisroch Jerkin", --40 [7] 45/45 <10> {0} (0)
    -- hands="Malignance Gloves", --24 [12] 50/0 <0> {4} (0)
    -- legs=gear.Adhemar_C_legs, --42 [8] 54/54 <0> {0} (16)
    -- feet="Orion Socks +3", --49 [0] 54/36 <0> {0} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Beyla Earring", --0 [0] 15/0 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Hajduk Ring +1", --0 [0] 17/0 <0> {0} (0)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)
    -- Includes set bonus 15 racc from orion + regal
    -- 265 AGI [49 STP] 362 racc / 247 ratt <15 crit> {14 dmg limit} (54 Recycle)
  })
  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.MidAcc, {
    -- Goal:
    -- head="Orion Beret +3", --39 [0] 47/34 <0> {0} (0)
    -- body="Orion Jerkin +3", --40 [8] 60/41 <0> {0} (0)
    -- hands="Orion Bracers +3", --27 [0] 48/0 <0> {0} (0)
    -- legs="Malignance Tights", --42 [10] 50/0 <0> {5} (0)
    -- feet="Orion Socks +3", --49 [0] 54/36 <0> {0} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Beyla Earring", --0 [0] 15/0 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Hajduk Ring +1", --0 [0] 17/0 <0> {0} (0)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)
    -- Includes set bonus 15 racc from orion + regal
    -- 270 AGI [40 STP] 426 racc / 161 ratt <5 crit> {15 dmg limit} (0 Recycle)

    -- Best:
    -- head="Orion Beret +3", --39 [0] 47/34 <0> {0} (0)
    -- body="Orion Jerkin +3", --40 [8] 60/41 <0> {0} (0)
    -- hands="Orion Bracers +3", --27 [0] 48/0 <0> {0} (0)
    -- legs=gear.Adhemar_C_legs, --42 [8] 54/54 <0> {0} (16)
    -- feet="Orion Socks +3", --49 [0] 54/36 <0> {0} (0)
    -- neck="Scout's Gorget +2", --25 [7] 25/0 <0> {10} (0)
    -- ear1="Telos Earring", --0 [5] 10/10 <0> {0} (0)
    -- ear2="Beyla Earring", --0 [0] 15/0 <0> {0} (0)
    -- ring1="Regal Ring", --10 [0] 0/20 <0> {0} (0)
    -- ring2="Hajduk Ring +1", --0 [0] 17/0 <0> {0} (0)
    -- back=gear.RNG_RA_Cape, --30 [10] 20/20 <0> {0} (0)
    -- waist="Kwahu Kachina Belt +1" --8 [0] 20/0 <5> {0} (0)
    -- Includes set bonus 60 racc from orion + regal
    --270 AGI [38 STP] 430 racc / 215 ratt <5 crit> {10 dmg limit} (16 Recycle)
  })

  sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands="Mummu Wrists +2",
    ring1="Begrudging Ring",
    legs="Mummu Kecks +2",
    feet="Oshosi Leggings",
    waist="Kwahu Kachina Belt +1",
    -- body="Nisroch Jerkin",
    -- feet="Oshosi Leggings +1",
  })

  sets.DoubleShot = {
    head="Arcadian Beret +2",
    legs="Oshosi Trousers", --6
    feet="Oshosi Leggings", --3
    -- head="Arcadian Beret +3",
    -- body="Arcadian Jerkin +3",
    -- hands="Oshosi Gloves +1", -- 5
    -- legs="Oshosi Trousers +1", --7
    -- feet="Oshosi Leggings +1", --4
  }
  sets.DoubleShot.Acc = {
    head="Arcadian Beret +2",
    legs="Oshosi Trousers", --6
    feet="Oshosi Leggings", --3
    -- head="Arcadian Beret +3",
    -- body="Arcadian Jerkin +3",
    -- legs="Oshosi Trousers +1", --7
    -- feet="Oshosi Leggings +1", --4
  }

  sets.DoubleShot.Critical = {
    head="Meghanada Visor +2",
    waist="Kwahu Kachina Belt +1",
  }


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Meghanada Chausses +2",
    feet="Meghanada Jambeaux +2",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.resting = {}

  -- Idle sets
  sets.idle = {
    head="Meghanada Visor +2", --5/0, 53
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
    neck="Loricate Torque", --5/5, 0
    ear1="Eabani Earring", --0/0, 8
    ear2="Odnowa Earring +1", --3/5, 0
    ring1=gear.Dark_Ring, --5/4, 0
    ring2="Defending Ring", --10/10, 0
    back=gear.RNG_DW_Cape, --0/0, 15
    waist="Windbuffet Belt +1", --0/0, 0
  }

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.RefreshSub50 = set_combine(sets.idle, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regain.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh_sub50)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh_sub50)

  sets.LightDef = {
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
    ring2="Defending Ring", --10/10, 0
    -- head="Malignance Chapeau", --6/6
    -- neck="Warder's Charm +1",
    -- ring1="Purity Ring", --0/4
    -- back="Moonlight Cape", --6/6
  }

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.LightDef)

  sets.HeavyDef = {
    head="Meghanada Visor +2", --5/0, 53
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
    neck="Loricate Torque", --5/5, 0
    ear1="Eabani Earring", --0/0, 8
    ear2="Odnowa Earring +1", --3/5, 0
    ring1=gear.Dark_Ring, --5/4, 0
    ring2="Defending Ring", --10/10, 0
    back=gear.RNG_DW_Cape, --0/0, 15
    waist="Kasiri Belt", --0/0, 0
  } -- 53 PDT / 49 MDT, 612 MEVA

  sets.idle.Weak = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape,
    waist="Windbuffet Belt +1",
    -- back=gear.RNG_DA_Cape,
  }

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    feet=gear.Herc_STP_feet,
    ear1="Dignitary's Earring",
    ring1="Chirich Ring +1",
  })

  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25% -- Assumed to be used for these sets

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Carmine_D_legs, --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Eabani Earring", --4
    ear2="Suppanomimi", --5
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
  } -- 45%

  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
  })

  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    feet="Malignance Boots",
    hands="Malignance Gloves",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    body="Malignance Tabard",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- head="Malignance Chapeau",
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.LowHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Carmine_D_legs, --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Eabani Earring", --4
    ear2="Suppanomimi", --5
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
  } -- 42%

  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
  })

  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    feet="Malignance Boots",
    hands="Malignance Gloves",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    body="Malignance Tabard",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- head="Malignance Chapeau",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.MidHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Carmine_D_legs, --6
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Suppanomimi", --5
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
  } -- 32%

  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    feet="Malignance Boots",
    hands="Malignance Gloves",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    body="Malignance Tabard",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- head="Malignance Chapeau",
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.DW.HighHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Eabani Earring", --4
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
  } -- 20%

  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    feet="Malignance Boots",
    hands="Malignance Gloves",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    body="Malignance Tabard",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- head="Malignance Chapeau",
  })

  -- High Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.DW.SuperHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
    -- ear2="Suppanomimi", --5
    -- back=gear.RNG_DA_Cape,
  } -- 21%
  sets.engaged.DW.LowAcc.SuperHaste = {
  }
  sets.engaged.DW.MidAcc.SuperHaste = {
  }
  sets.engaged.DW.HighAcc.SuperHaste = {
  }

  -- Max Magic/Gear/JA Haste (0-25% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Windbuffet Belt +1",
    -- back=gear.RNG_DA_Cape,
  } -- 16%

  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    hands="Malignance Gloves",
    feet="Malignance Boots",
  })

  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    body="Malignance Tabard",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- head="Malignance Chapeau",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, sets.LightDef)
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, sets.LightDef)
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, sets.LightDef)
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, sets.LightDef)

  sets.engaged.DW.LightDef = set_combine(sets.engaged.DW, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef = set_combine(sets.engaged.DW.LowAcc, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef = set_combine(sets.engaged.DW.MidAcc, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef = set_combine(sets.engaged.DW.HighAcc, sets.LightDef)

  sets.engaged.DW.LightDef.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.LightDef)

  sets.engaged.DW.LightDef.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.LightDef)

  sets.engaged.DW.LightDef.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.LightDef)

  sets.engaged.DW.LightDef.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.LightDef)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff.Barrage = {
    hands="Orion Bracers +2"
    -- hands="Orion Bracers +3"
  }
  sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {
    -- body="Amini Caban +1",
    -- back=gear.RNG_DA_Cape,
  })
  sets.buff.Camouflage = {
    body="Orion Jerkin +1"
    -- body="Orion Jerkin +3"
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    legs="Carmine Cuisses +1",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }

  sets.Obi = {
    waist="Hachirin-no-Obi"
  }

  sets.WeaponSet = {}
  -- Melee weapon sets
  sets.WeaponSet['MagicRA'] = {
    main="Malevolence",
    sub="Malevolence",
  }
  sets.WeaponSet['PhysRA'] = {
    main="Ternion Dagger +1",
    sub="Odium",
  }
  sets.WeaponSet['PhysRA RangedOnly'] = {
    main="Ternion Dagger +1",
    sub="Nusku Shield",
  }
  sets.WeaponSet['PhysRA NoBuff'] = {
    main="Perun +1",
    sub="Nusku Shield",
  }
  sets.WeaponSet['Melee'] = {
    main="Naegling",
    sub="Ternion Dagger +1",
  }
  sets.WeaponSet['CritRA'] = {
    main="Oneiros Knife",
    sub="Nusku Shield",
  }

  -- Ranged weapon sets
  sets.WeaponSet["Pharaoh's Bow"] = {
    ranged="Pharaoh's Bow",
  }
  sets.WeaponSet["Grosveneur's Bow"] = {
    ranged="Grosveneur's Bow",
  }
  sets.WeaponSet['Doomsday'] = {
    ranged="Doomsday",
  }
  sets.WeaponSet['Gastraphetes'] = {
    ranged="Gastraphetes",
  }
  sets.WeaponSet['Sparrowhawk'] = {
    ranged="Sparrowhawk",
  }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.cancel_outranged_ws(spell, eventArgs)
  silibs.cancel_on_blocking_status(spell, eventArgs)

  if spell.action_type == 'Ranged Attack' then
    state.CombatWeapon:set(player.equipment.range)
  end
  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
    check_ammo(spell, action, spellMap, eventArgs)
  end

  -- If using a WS and ranged weapon set to sparrowhawk, equip WSD ammo
  if spell.type == 'WeaponSkill' and state.RangedWeaponSet.current == 'Sparrowhawk' then
    equip({ammo="Hauksbok Arrow"})
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    -- Equip obi if weather/day matches for WS.
    if elemental_ws:contains(spell.english) then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 1.7 yalms.
      elseif spell.target.distance < (1.7 + spell.target.model_size) then
        equip({waist="Hachirin-no-Obi"})
        -- equip({waist="Orpheus's Sash"})
      -- Matching day and weather.
      elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 8 yalms.
      elseif spell.target.distance < (8 + spell.target.model_size) then
        equip({waist="Hachirin-no-Obi"})
        -- equip({waist="Orpheus's Sash"})
      -- Match day or weather.
      elseif spell.element == world.day_element or spell.element == world.weather_element then
        equip({waist="Hachirin-no-Obi"})
      end
    end

    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  elseif spell.action_type == 'Ranged Attack' then
    if state.RangedWeaponSet.current == "Gastraphetes" then
      if flurry == 2 then
        equip(sets.precast.RA.Gastra.Flurry2)
      elseif flurry == 1 then
        equip(sets.precast.RA.Gastra.Flurry1)
      else
        equip(sets.precast.RA.Gastra)
      end
    else
      if flurry == 2 then
        equip(sets.precast.RA.Flurry2)
      elseif flurry == 1 then
        equip(sets.precast.RA.Flurry1)
      end
    end
  end
  
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
  if locked_waist then equip({ waist=player.equipment.waist }) end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    if buffactive['Double Shot'] then
      if state.RangedMode.current ==  'HighAcc' then
        equip(sets.DoubleShot.Acc)
      else
        equip(sets.DoubleShot)
      end
      if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
        equip(sets.DoubleShotCritical)
      end
    elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
      equip(sets.midcast.RA.Critical)
    end
    if state.Buff.Barrage then
      equip(sets.buff.Barrage)
    end
  end
  
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
  if locked_waist then equip({ waist=player.equipment.waist }) end
end

function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.english == "Shadowbind" then
    send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
  if S{'flurry'}:contains(buff:lower()) then
    if not gain then
      flurry = nil
    end
    if not midaction() then
      handle_equipping_gear(player.status)
    end
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Camouflage" or buff == "doom" then
    status_change(player.status)
  end

end

function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Weapon Set' then
    equip_weapons()
  end
  if stateField == 'Ranged Weapon Set' then
    equip_ranged_weapons()
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_combat_form()
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  update_dp_type() -- Requires DistancePlus addon
end

function update_combat_form()
  if DW == true then
    state.CombatForm:set('DW')
  elseif DW == false then
    state.CombatForm:reset()
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''
  -- Ranged WS
  if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    if state.RangedMode.value ~= 'Normal' then
      wsmode = state.RangedMode.value
    end
  else -- Melee WS
    if state.OffenseMode.value ~= 'Normal' then
      wsmode = state.OffenseMode.value
    end
  end

  if player.tp > 2900 then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end
  if buffactive.Camouflage then
    idleSet = set_combine(idleSet, sets.buff.Camouflage)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end
  if locked_waist then idleSet = set_combine(idleSet, { waist=player.equipment.waist }) end

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if buffactive.Camouflage then
    meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end
  if locked_waist then meleeSet = set_combine(meleeSet, { waist=player.equipment.waist }) end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
  if buffactive.Camouflage then
    defenseSet = set_combine(defenseSet, sets.buff.Camouflage)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end
  if locked_waist then defenseSet = set_combine(defenseSet, { waist=player.equipment.waist }) end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local r_msg = state.RangedMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,210).. ' Ranged: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_toy_weapons(cycle_dir)
  --If current state is None, save current weapons to switch back later
  if state.ToyWeapons.current == 'None' then
    sets.ToyWeapon.None.main = player.equipment.main
    sets.ToyWeapon.None.sub = player.equipment.sub
  end

  if cycle_dir == 'forward' then
    state.ToyWeapons:cycle()
  elseif cycle_dir == 'back' then
    state.ToyWeapons:cycleback()
  else
    state.ToyWeapons:reset()
  end

  local mode_color = 001
  if state.ToyWeapons.current == 'None' then
    mode_color = 006
  end
  add_to_chat(012, 'Toy Weapon Mode: '..string.char(31,mode_color)..state.ToyWeapons.current)
  equip(sets.ToyWeapon[state.ToyWeapons.current])
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if player.tp < 3000 then
      classes.CustomIdleGroups:append('Regain')
    end
    if isRegening==true and player.hpp < 100 then
      classes.CustomIdleGroups:append('Regen')
    elseif isRegening==false and player.hpp < 85 then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('RefreshSub50')
      elseif isRefreshing==true and player.mpp < 100 then
        classes.CustomIdleGroups:append('Refresh')
      elseif isRefreshing==false and player.mpp < 85 then
        classes.CustomIdleGroups:append('Refresh')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action', function(act)
  --check if you are a target of spell
  local actionTargets = act.targets
  playerId = windower.ffxi.get_player().id
  isTarget = false
  for _, target in ipairs(actionTargets) do
    if playerId == target.id then
      isTarget = true
    end
  end
  if isTarget == true then
    if act.category == 4 then
      local param = act.param
      if param == 845 and flurry ~= 2 then
        flurry = 1
      elseif param == 846 then
        flurry = 2
      end
    end
  end
end)

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 0 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 0 and DW_needed <= 11 then
      classes.CustomMeleeGroups:append('SuperHaste')
    elseif DW_needed > 11 and DW_needed <= 18 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 18 and DW_needed <= 31 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 31 and DW_needed <= 42 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 42 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  elseif cmdParams[1]:lower() == 'equipweapons' then
    equip_weapons()
  elseif cmdParams[1]:lower() == 'equiprangedweapons' then
    equip_ranged_weapons()
  elseif cmdParams[1]:lower() == 'toyweapon' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2]:lower() == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1]:lower() == 'test' then
    test()
  end

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if type(tonumber(cmdParams[2])) == 'number' then
      if tonumber(cmdParams[2]) ~= DW_needed then
        DW_needed = tonumber(cmdParams[2])
        DW = true
      end
    elseif type(cmdParams[2]) == 'string' then
      if cmdParams[2] == 'false' then
        DW_needed = 0
        DW = false
      end
    end
    if type(tonumber(cmdParams[3])) == 'number' then
      if tonumber(cmdParams[3]) ~= Haste then
        Haste = tonumber(cmdParams[3])
      end
    end
    if not midaction() then
      job_update()
    end
  end
end

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
  local swapped_ammo = nil
  if spell.action_type == 'Ranged Attack' then
    if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
      if DefaultAmmo[player.equipment.range] then
        if player.inventory[DefaultAmmo[player.equipment.range]] then
          swapped_ammo = DefaultAmmo[player.equipment.range]
          equip({ammo=swapped_ammo})
        else
          add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
        end
      else
        add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
      end
    end
  elseif spell.type == 'WeaponSkill' then
    -- magical weaponskills
    if elemental_ws:contains(spell.english) then
      if player.inventory[MagicAmmo[player.equipment.range]] then
        swapped_ammo = MagicAmmo[player.equipment.range]
        equip({ammo=swapped_ammo})
      else
        add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
        swapped_ammo = DefaultAmmo[player.equipment.range]
        equip({ammo=swapped_ammo})
      end
    --physical weaponskills
    else
      if state.RangedMode.value == 'Acc' then
        if player.inventory[AccAmmo[player.equipment.range]] then
          swapped_ammo = AccAmmo[player.equipment.range]
          equip({ammo=swapped_ammo})
        else
          add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
          swapped_ammo = DefaultAmmo[player.equipment.range]
          equip({ammo=swapped_ammo})
        end
      else
        if player.inventory[WSAmmo[player.equipment.range]] then
          swapped_ammo = WSAmmo[player.equipment.range]
          equip({ammo=swapped_ammo})
        else
          add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
          swapped_ammo = DefaultAmmo[player.equipment.range]
          equip({ammo=swapped_ammo})
        end
      end
    end
  end
  if player.equipment.ammo ~= 'empty' and player.inventory[swapped_ammo] ~= nil and player.inventory[swapped_ammo].count < 5 then
    add_to_chat(39,"*** Ammo '"..player.inventory[swapped_ammo].shortname.."' running low! *** ("..player.inventory[swapped_ammo].count..")")
  end
end

function update_offense_mode()
  if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    state.CombatForm:set('DW')
  else
    state.CombatForm:reset()
  end
end

function check_gear()
  if no_swap_necks:contains(player.equipment.neck) then
    locked_neck = true
  else
    locked_neck = false
  end
  if no_swap_earrings:contains(player.equipment.ear1) then
    locked_ear1 = true
  else
    locked_ear1 = false
  end
  if no_swap_earrings:contains(player.equipment.ear2) then
    locked_ear2 = true
  else
    locked_ear2 = false
  end
  if no_swap_rings:contains(player.equipment.ring1) then
    locked_ring1 = true
  else
    locked_ring1 = false
  end
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
  if no_swap_waists:contains(player.equipment.waist) then
    locked_waist = true
  else
    locked_waist = false
  end
end

windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  set_macro_page(1, 9)
end

-- Requires DistancePlus addon
function update_dp_type()
  local weapon = nil
  local weapon_type = nil
  local weapon_subtype = nil

  --Handle unequipped case
  if player.equipment.ranged ~= nil and player.equipment.ranged ~= 0 and player.equipment.ranged ~= 'empty' then
    weapon = res.items:with('name', player.equipment.ranged)
    weapon_type = res.skills[weapon.skill].en
    if weapon_type == 'Archery' then
      weapon_subtype = 'bow'
    elseif weapon_type == 'Marksmanship' then
      weapon_subtype = marksman_weapon_subtypes[weapon.en]
    end
  end

  --Change keybinds if weapon type changed
  if weapon_subtype ~= current_dp_type then
    current_dp_type = weapon_subtype
    if current_dp_type ~= nil then
      coroutine.schedule(function()
        if current_dp_type ~= nil then
          send_command('dp '..current_dp_type)
        end
      end,3)
    end
  end
end

function equip_weapons()
  equip(sets.WeaponSet[state.WeaponSet.current])
end

function equip_ranged_weapons()
  equip(sets.WeaponSet[state.RangedWeaponSet.current])

  -- Equip appropriate ammo
  local ranged = sets.WeaponSet[state.RangedWeaponSet.current].ranged
  if DefaultAmmo[ranged] then
    if player.inventory[DefaultAmmo[ranged]] then
      equip({ammo=DefaultAmmo[ranged]})
    else
      add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
    end
  end
end

function test()
end
