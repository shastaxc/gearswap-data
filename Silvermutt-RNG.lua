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
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  lockstyleset = 1

  current_ranged_weapon_type = nil -- Do not modify
  current_dp_type = nil -- Do not modify

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef')
  state.RangedMode:options('Normal', 'Acc', 'HighAcc', 'Critical')
  state.WeaponskillMode:options('Normal', 'Acc', 'Enmity')
  state.IdleMode:options('Normal', 'LightDef')
  state.WeaponSet = M{['description']='Weapon Set', 'Pharaoh\'s Bow', 'Grosveneur\'s Bow', 'Ribauldequin', 'Annihilator', 'Fomalhaut', 'Armageddon'}
  state.CP = M(false, "Capacity Points Mode")

  state.Buff.Barrage = buffactive.Barrage or false
  state.Buff.Camouflage = buffactive.Camouflage or false
  state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
  state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
  state.Buff['Double Shot'] = buffactive['Double Shot'] or false

  -- Whether a warning has been given for low ammo
  state.warned = M(false)

  elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}
  no_swap_waist = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}
  
  marksman_weapon_subtypes = {
    ['Grosveneur\'s Bow'] = "xbow",
    ['Ribauldequin'] = "gun",
    ['Annihilator'] = "gun",
    ['Armageddon'] = "gun",
    ['Gastraphetes'] = "xbow",
    ['Fomalhaut'] = "gun",
  }

  DefaultAmmo = {
    ['Pharaoh\'s Bow'] = "Demon Arrow",
    ['Grosveneur\'s Bow'] = "Darksteel Bolt",
    ['Ribauldequin'] = "Dweomer Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
  }
  AccAmmo = {
    ['Pharaoh\'s Bow'] = "Demon Arrow",
    ['Grosveneur\'s Bow'] = "Darksteel Bolt",
    ['Ribauldequin'] = "Dweomer Bullet",
    ['Yoichinoyumi'] = "Yoichi's Arrow",
    ['Gandiva'] = "Yoichi's Arrow",
    ['Fail-Not'] = "Yoichi's Arrow",
    ['Annihilator'] = "Eradicating Bullet",
    ['Armageddon'] = "Eradicating Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
  }
  WSAmmo = {
    ['Pharaoh\'s Bow'] = "Demon Arrow",
    ['Grosveneur\'s Bow'] = "Darksteel Bolt",
    ['Ribauldequin'] = "Dweomer Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
  }
  MagicAmmo = {
    ['Pharaoh\'s Bow'] = "Demon Arrow",
    ['Grosveneur\'s Bow'] = "Darksteel Bolt",
    ['Ribauldequin'] = "Dweomer Bullet",
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Devastating Bullet",
    ['Armageddon'] = "Devastating Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
  }

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')

  send_command('bind @c gs c toggle CP')
  send_command('bind ^insert gs c cycle WeaponSet')
  send_command('bind ^delete gs c cycleback WeaponSet')

  send_command('bind !q input /ja "Velocity Shot" <me>')
  send_command('bind !` input /ja "Scavenge" <me>')
  send_command('bind ^numlock input /ja "Double Shot" <me>')
  send_command('bind numpad0 input /ra <t>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  locked_style = false -- Do not modify
  Haste = 0 -- Do not modify
  flurry = nil -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

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
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
  set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')

  send_command('unbind @c')
  send_command('unbind @e')
  send_command('unbind @r')

  send_command('unbind !q')
  send_command('unbind !`')

  send_command('unbind !w')

  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad+')
  send_command('unbind ^numpadenter')
  send_command('unbind ^numpad9')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad3')
  send_command('unbind ^numpad2')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind numpad0')

  send_command('unbind !numpad9')
  send_command('unbind !numpad8')
  send_command('unbind !numpad7')
  send_command('unbind !numpad6')
  send_command('unbind !numpad5')
  send_command('unbind !numpad4')
  send_command('unbind !numpad3')
  send_command('unbind !numpad2')
  send_command('unbind !numpad1')
end


-- Set up all gear sets.
function init_gear_sets()
  
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Eagle Eye Shot'] = {
    legs="Arc. Braccae +3"
  }
  sets.precast.JA['Bounty Shot'] = {
    hands="Amini Glove. +1"
}
  sets.precast.JA['Camouflage'] = {
    body="Orion Jerkin +3"
}
  sets.precast.JA['Scavenge'] = {
    feet="Orion Socks +3"
}
  sets.precast.JA['Shadowbind'] = {
    hands="Orion Bracers +3"
}
  sets.precast.JA['Sharpshot'] = {
    legs="Orion Braccae +1"
}


  -- Fast cast sets for spells

  sets.precast.Waltz = {
    body="Passion Jacket",
    ring1="Asklepian Ring",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    head="Carmine Mask +1", --14
    body=gear.Taeon_FC_body, --8
    hands="Leyline Gloves", --8
    legs="Rawhide Trousers", --5
    feet="Carmine Greaves +1", --8
    neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    ear2="Enchntr. Earring +1", --2
    ring1="Weather. Ring +1", --6(4)
    waist="Rumination Sash",
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Passion Jacket",
    ring2="Lebeche Ring",
  })

  -- (10% Snapshot, 5% Rapid from Merits)
  sets.precast.RA = {
    head=gear.Taeon_RA_head, --10/0
    body="Oshosi Vest +1", --14/0
    hands="Carmine Fin. Ga. +1", --8/11
    legs=gear.Adhemar_D_legs, --10/13
    feet="Meg. Jam. +2", --10/0
    back=gear.RNG_SNP_Cape, --10/0
    waist="Yemaya Belt", --0/5
  } --61/26

  sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
    head="Orion Beret +3", --0/18
    body="Amini Caban +1",
    neck="Scout's Gorget +1", --3/0
    waist="Impulse Belt", --3/0
  }) --43/39

  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
    feet="Arcadian Socks +3", --0/10
    waist="Yemaya Belt", --0/5
  }) --30/54

  --sets.precast.RA.Gastra = {head="Mummu Bonnet +2"}
  --sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {})
  --sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {})


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    head="Orion Beret +3",
    body=gear.Herc_RA_body,
    hands="Meg. Gloves +2",
    legs="Arc. Braccae +3",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Epaminondas's Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
  }

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    feet="Arcadian Socks +3",
    neck="Combatant's Torque",
    ear1="Beyla Earring",
    waist="K. Kachina Belt +1",
  })

  sets.precast.WS.Enmity = set_combine(sets.precast.WS, {
    hands="Arc. Bracers +3",
    feet="Arcadian Socks +3",
    ear1="Beyla Earring",
  })

  sets.precast.WS['Apex Arrow'] = sets.precast.WS

  sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
    feet="Orion Socks +3",
    ear1="Beyla Earring",
    waist="K. Kachina Belt +1",
  })

  sets.precast.WS['Apex Arrow'].Enmity = set_combine(sets.precast.WS['Apex Arrow'], {
    hands="Arc. Bracers +3",
    feet="Arcadian Socks +3",
    ear1="Beyla Earring",
  })

  sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {
    head="Mummu Bonnet +2",
    body="Abnoba Kaftan",
    hands="Mummu Wrists +2",
    feet="Thereoid Greaves",
    ear1="Sherida Earring",
    ring1="Begrudging Ring",
    ring2="Mummu Ring",
  })

  sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
    legs="Mummu Kecks +2",
    feet="Arcadian Socks +3",
    neck="Iskur Gorget",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Hajduk Ring +1",
    waist="K. Kachina Belt +1",
  })

  sets.precast.WS['Jishnu\'s Radiance'].Enmity = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
    hands="Arc. Bracers +3",
    feet="Arcadian Socks +3",
    ear1="Beyla Earring",
  })

  sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
    neck="Scout's Gorget +1",
  })

  sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
    ammo=gear.ACCbullet,
    feet="Orion Socks +3",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    ring2="Hajduk Ring +1",
    waist="K. Kachina Belt +1",
  })

  sets.precast.WS['Last Stand'].Enmity = set_combine(sets.precast.WS['Last Stand'], {
    hands="Arc. Bracers +3",
    feet="Arcadian Socks +3",
    ear1="Beyla Earring",
  })

  sets.precast.WS["Coronach"] = set_combine(sets.precast.WS['Last Stand'], {
    neck="Scout's Gorget +1",
    ear1="Sherida Earring",
    ear2="Mache Earring +1",
  })

  sets.precast.WS["Coronach"].Acc = set_combine(sets.precast.WS['Coronach'], {
    ear1="Beyla Earring",
    ear2="Telos Earring",
  })

  sets.precast.WS["Coronach"].Enmity = set_combine(sets.precast.WS['Coronach'], {
    ear1="Beyla Earring",
  })

  sets.precast.WS["Trueflight"] = {
    head="Orion Beret +3",
    body="Carm. Sc. Mail +1",
    hands="Carmine Fin. Ga. +1",
    legs=gear.Herc_WSD_legs,
    feet=gear.Herc_WSD_feet,
    neck="Scout's Gorget +1",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Weather. Ring +1",
    ring2="Epaminondas's Ring",
    back=gear.RNG_WS1_Cape,
    waist="Eschan Stone",
  }

  sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
    ring1="Regal Ring"
  })

  sets.precast.WS['Evisceration'] = {
    head=gear.Adhemar_B_head,
    body="Abnoba Kaftan",
    hands="Mummu Wrists +2",
    legs="Zoar Subligar +1",
    feet=gear.Herc_STP_feet,
    neck="Fotia Gorget",
    ear2="Mache Earring +1",
    ring1="Begrudging Ring",
    ring2="Mummu Ring",
    back=gear.RNG_TP_Cape,
    waist="Fotia Belt",
  }

  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
    head="Dampening Tam",
    body=gear.Adhemar_B_body,
    legs=gear.Herc_WS_legs,
    ring1="Regal Ring",
  })

  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['Evisceration'], {
    feet=gear.Herc_TA_feet
  })
  sets.precast.WS['Rampage'].Acc = sets.precast.WS['Evisceration'].Acc


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast recast for spells

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    legs="Carmine Cuisses +1", --20
    ring1="Evanescence Ring", --5
    waist="Rumination Sash", --10
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  -- Ranged sets

  sets.midcast.RA = {
    head="Arcadian Beret +3",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Scout's Gorget +1",
    ear1="Enervating Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Dingir Ring",
    back=gear.RNG_RA_Cape,
    waist="Yemaya Belt",
  }

  sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    feet="Orion Socks +3",
    ear1="Beyla Earring",
    ring2="Hajduk Ring +1",
  })

  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
    head="Orion Beret +3",
    body="Orion Jerkin +3",
    hands="Orion Bracers +3",
    waist="K. Kachina Belt +1",
  })

  sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands="Kobo Kote",
    legs="Mummu Kecks +2",
    feet="Osh. Leggings +1",
    ring1="Begrudging Ring",
    ring2="Mummu Ring",
    waist="K. Kachina Belt +1",
  })

  sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
    neck="Iskur Gorget",
    ear1="Dedition Earring",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  sets.DoubleShot = {
    head="Arcadian Beret +3",
    body="Arc. Jerkin +3",
    hands="Oshosi Gloves +1", -- 5
    legs="Osh. Trousers +1", --7
    feet="Osh. Leggings +1", --4
  } --25

  sets.DoubleShot.Critical = {
    head="Meghanada Visor +2",
    waist="K. Kachina Belt +1",
  }


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.resting = {}

  -- Idle sets
  sets.idle = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Scout's Gorget +1",
    neck="Bathy Choker +1",
    ear1="Sanare Earring",
    ear2="Eabani Earring",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    back="Moonlight Cape",
    waist="Carrier's Sash",
  }

  sets.LightDef = {
    head="Malignance Chapeau", --6/6
    body="Malignance Tabard", --9/9
    hands="Malignance Gloves", --5/5
    legs="Malignance Tights", --7/7
    feet="Malignance Boots", --4/4
    neck="Warder's Charm +1",
    ring1="Purity Ring", --0/4
    ring2="Defending Ring", --10/10
    back="Moonlight Cape", --6/6
  }

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)

  sets.idle.Town = set_combine(sets.idle, {
    head="Orion Beret +3",
    body="Oshosi Vest +1",
    hands="Oshosi Gloves +1",
    legs="Arc. Braccae +3",
    feet="Osh. Leggings +1",
    neck="Scout's Gorget +1",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    back=gear.RNG_RA_Cape,
    waist="K. Kachina Belt +1",
  })

  sets.HeavyDef = {
    head="Turms Cap +1", --0/0, 109
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Mummu Kecks +1", --4/4, 107
    feet="Turms Leggings", --0/0, 137
    neck="Twilight Torque", --5/5, 0
    ear1="Eabani Earring", --0/0, 8
    ear2="Odnowa Earring +1", --3/5, 0
    ring1=gear.Dark_Ring, --5/4, 0
    ring2="Defending Ring", --10/10, 0
  }

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
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_TP_Cape,
    waist="Windbuffet Belt +1",
  }

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    head="Dampening Tam",
    hands=gear.Adhemar_A_hands,
    neck="Combatant's Torque",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    head="Carmine Mask +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.STP = set_combine(sets.engaged, {
    head=gear.Herc_STP_head,
    feet="Carmine Greaves +1",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25%

  -- No Magic Haste (74% DW to cap)
  sets.engaged.DW = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands="Floral Gauntlets", --5
    legs="Carmine Cuisses +1", --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_DW_Cape, --10
    waist="Reiki Yotai", --7
  } -- 52%

  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    head="Dampening Tam",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    hands=gear.Adhemar_A_hands,
    neck="Combatant's Torque",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    head="Carmine Mask +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring1="Regal Ring",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
    head=gear.Herc_STP_head,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- 15% Magic Haste (67% DW to cap)
  sets.engaged.DW.LowHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands="Floral Gauntlets", --5
    legs="Carmine Cuisses +1", --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 42%

  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    head="Dampening Tam",
    neck="Combatant's Torque",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    hands=gear.Adhemar_A_hands,
    ear2="Telos Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    head="Carmine Mask +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring1="Regal Ring",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    head=gear.Herc_STP_head,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- 30% Magic Haste (56% DW to cap)
  sets.engaged.DW.MidHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 31%

  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    head="Dampening Tam",
    hands=gear.Adhemar_A_hands,
    neck="Combatant's Torque",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    head="Carmine Mask +1",
    legs="Carmine Cuisses +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring1="Regal Ring",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    head=gear.Herc_STP_head,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- 35% Magic Haste (51% DW to cap)
  sets.engaged.DW.HighHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 27%

  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    head="Dampening Tam",
    hands=gear.Adhemar_A_hands,
    neck="Combatant's Torque",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    head="Carmine Mask +1",
    legs="Carmine Cuisses +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring1="Regal Ring",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    head=gear.Herc_STP_head,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- 45% Magic Haste (36% DW to cap)
  sets.engaged.DW.MaxHaste = {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Telos Earring",
    ring1="Hetairoi Ring",
    ring2="Epona's Ring",
    back=gear.RNG_TP_Cape,
    waist="Windbuffet Belt +1",
  } -- 11%

  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    head="Dampening Tam",
    hands=gear.Adhemar_A_hands,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    waist="Kentarch Belt +1",
  })

  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    legs="Meg. Chausses +2",
    neck="Combatant's Torque",
    ring2="Ilabrat Ring",
  })

  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    head="Carmine Mask +1",
    legs="Carmine Cuisses +1",
    feet=gear.Herc_STP_feet,
    ear1="Cessance Earring",
    ear2="Mache Earring +1",
    ring1="Regal Ring",
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    waist="Olseni Belt",
  })

  sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    head=gear.Herc_STP_head,
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=gear.RNG_DW_Cape})
  sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=gear.RNG_DW_Cape})


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
    hands="Orion Bracers +3"
  }
  sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {
    body="Amini Caban +1",
    back=gear.RNG_TP_Cape
  })
  sets.buff.Camouflage = {
    body="Orion Jerkin +3"
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Skd. Jambeaux +1"
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
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
    -- head=gear.Herc_TH_head, --2
  }

  sets.FullTP = {
    ear1="Crematio Earring"
  }
  sets.Obi = {
    waist="Hachirin-no-Obi"
  }

  sets['Pharaoh\'s Bow'] = {
    ranged="Pharaoh\'s Bow"
  }
  sets['Grosveneur\'s Bow'] = {
    ranged="Grosveneur\'s Bow"
  }
  sets['Ribauldequin'] = {
    ranged="Ribauldequin"
  }
  sets.Annihilator = {
    ranged="Annihilator"
  }
  sets.Fomalhaut = {
    ranged="Fomalhaut"
  }
  sets.Armageddon = {
    ranged="Armageddon"
  }
  sets.Gastraphetes = {
    ranged="Gastraphetes"
  }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Don't gearswap if status forbids the action
  local forbidden_statuses = action_type_blocks[spell.action_type]
  for k,status in pairs(forbidden_statuses) do
    if buffactive[status] then
      add_to_chat(167, 'Stopped due to status.')
      eventArgs.cancel = true -- Stops the rest of the pipeline from executing
      return -- Ends execution of this function
    end
  end

  if spell.action_type == 'Ranged Attack' then
    state.CombatWeapon:set(player.equipment.range)
  end
  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
    check_ammo(spell, action, spellMap, eventArgs)
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    -- if state.Buff['Velocity Shot'] then
    --     equip( sets.buff['Velocity Shot'])
    -- end
    if spell.action_type == 'Ranged Attack' and state.WeaponSet.current == "Gastraphetes" then
      if flurry == 2 then
        equip(sets.precast.RA.Gastra.Flurry2)
      elseif flurry == 1 then
        equip(sets.precast.RA.Gastra.Flurry1)
      else
        equip(sets.precast.RA.Gastra)
      end
    elseif spell.action_type == 'Ranged Attack' then
      if flurry == 2 then
        equip(sets.precast.RA.Flurry2)
      elseif flurry == 1 then
        equip(sets.precast.RA.Flurry1)
      end
    end
    -- Replace TP-bonus gear if not needed.
    if spell.english == 'Trueflight' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
      equip(sets.FullTP)
    end
    -- Equip obi if weather/day matches for WS.
    if elemental_ws:contains(spell.name) then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 1.7 yalms.
      elseif spell.target.distance < (1.7 + spell.target.model_size) then
        equip({waist="Orpheus's Sash"})
      -- Matching day and weather.
      elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 8 yalms.
      elseif spell.target.distance < (8 + spell.target.model_size) then
        equip({waist="Orpheus's Sash"})
      -- Match day or weather.
      elseif spell.element == world.day_element or spell.element == world.weather_element then
        equip({waist="Hachirin-no-Obi"})
      end
    end
  end
  if spell.type == "WeaponSkill" and buffactive['Reive Mark'] then
    equip(sets.Reive)
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    if buffactive['Double Shot'] then
      equip(sets.DoubleShot)
      if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
        equip(sets.DoubleShotCritical)
      end
    elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
      equip(sets.midcast.RA.Critical)
    end
    if state.Buff.Barrage then
      equip(sets.buff.Barrage)
    end
--        if state.Buff['Velocity Shot'] and state.RangedMode.value == 'STP' then
--            equip(sets.buff['Velocity Shot'])
--        end
  end
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
      add_to_chat(122, "Flurry status cleared.")
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
  -- if state.WeaponLock.value == true then
  --   disable('ranged')
  -- else
  --   enable('ranged')
  -- end
  if stateField == 'Weapon Set' then
    equip(sets[state.WeaponSet.current])
  end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_combat_form()
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  update_weaponskill_binds()
  update_ranged_weaponskill_binds()
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
  local wsmode
  if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
      wsmode = 'Acc'
      add_to_chat(1, 'WS Mode Auto Acc')
    end
  elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
    if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
      wsmode = 'Acc'
    end
  end

  return wsmode
end

function customize_idle_set(idleSet)
  -- Equip weapons (weapons won't set properly on load or job change without this here)
  idleSet = set_combine(idleSet, sets[state.WeaponSet.current])

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

  local ws_msg = state.WeaponskillMode.value

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
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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
        --add_to_chat(122, 'Flurry Status: Flurry I')
        flurry = 1
      elseif param == 846 then
        --add_to_chat(122, 'Flurry Status: Flurry II')
        flurry = 2
      end
    end
  end
end)

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 11 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 11 and DW_needed <= 21 then
      classes.CustomMeleeGroups:append('MaxHastePlus')
    elseif DW_needed > 21 and DW_needed <= 27 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 27 and DW_needed <= 31 then
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
  if spell.action_type == 'Ranged Attack' then
    if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
      if DefaultAmmo[player.equipment.range] then
        if player.inventory[DefaultAmmo[player.equipment.range]] then
          --add_to_chat(3,"Using Default Ammo")
          equip({ammo=DefaultAmmo[player.equipment.range]})
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
        equip({ammo=MagicAmmo[player.equipment.range]})
        add_to_chat(1, 'Magic Ammo')
      else
        add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
        equip({ammo=DefaultAmmo[player.equipment.range]})
      end
    --physical weaponskills
    else
      if state.RangedMode.value == 'Acc' then
        if player.inventory[AccAmmo[player.equipment.range]] then
          equip({ammo=AccAmmo[player.equipment.range]})
          add_to_chat(1, 'Acc Ammo')
        else
          add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
          equip({ammo=DefaultAmmo[player.equipment.range]})
        end
      else
        if player.inventory[WSAmmo[player.equipment.range]] then
          equip({ammo=WSAmmo[player.equipment.range]})
        else
          add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
          equip({ammo=DefaultAmmo[player.equipment.range]})
        end
      end
    end
  end
  if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
    add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
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
  if no_swap_gear:contains(player.equipment.left_ring) then
    disable("ring1")
  else
    enable("ring1")
  end
  if no_swap_gear:contains(player.equipment.right_ring) then
    disable("ring2")
  else
    enable("ring2")
  end
  if no_swap_waist:contains(player.equipment.waist) then
    disable("waist")
  else
    enable("waist")
  end
end

windower.register_event('zone change', function()
  if no_swap_gear:contains(player.equipment.left_ring) then
    enable("ring1")
    equip(sets.idle)
  end
  if no_swap_gear:contains(player.equipment.right_ring) then
    enable("ring2")
    equip(sets.idle)
  end
  if no_swap_waist:contains(player.equipment.waist) then
    enable("waist")
    equip(sets.idle)
  end
end)

windower.raw_register_event('outgoing chunk', function(id, data, modified, injected, blocked)
  if id == 0x053 then -- Send lockstyle command to server
    local type = data:unpack("I",0x05)
    if type == 0 then -- This is lockstyle 'disable' command
      locked_style = false
    else -- Various diff ways to set lockstyle
      locked_style = true
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  set_macro_page(1, 6)
end

function set_lockstyle()
  -- Set lockstyle 2 seconds after changing job, trying immediately will error
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 2)
  -- In case lockstyle was on cooldown for first command, try again (lockstyle has 10s cd)
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 10)
end

function update_ranged_weaponskill_binds()
  local weapon = nil
  local weapon_type = nil

  --Handle unequipped case
  if player.equipment.ranged ~= nil and player.equipment.ranged ~= 0 and player.equipment.ranged ~= 'empty' then
    weapon = res.items:with('name', player.equipment.ranged)
    weapon_type = res.skills[weapon.skill].en
  end

  --Change keybinds if weapon type changed
  if weapon_type ~= current_ranged_weapon_type then
    current_ranged_weapon_type = weapon_type
    --Set weaponskill bindings by weapon type
    if current_ranged_weapon_type == 'Archery' then
      send_command('bind !numpad7 input /ws "Apex Arrow" <t>') -- Aeonic
      send_command('bind !numpad8 input /ws "Namas Arrow" <t>') -- Relic
      send_command('bind !numpad9 input /ws "Jishnu\'s Radiance" <t>') -- Empyrean
      send_command('bind !numpad4 input /ws "Empyreal Arrow" <t>') -- Quested
      send_command('bind !numpad1 input /ws "Blast Arrow" <t>') -- Melee Range
      send_command('bind !numpad2 input /ws "Sidewinder" <t>') -- High dmg, inaccurate
    elseif current_weapon_type == 'Marksmanship' then
      send_command('bind !numpad7 input /ws "Last Stand" <t>') -- Aeonic
      send_command('bind !numpad8 input /ws "Coronach" <t>') -- Relic
      send_command('bind !numpad9 input /ws "Wildfire" <t>') -- Empyrean
      send_command('bind !numpad4 input /ws "Detonator" <t>') -- Quested
      send_command('bind !numpad6 input /ws "True Flight" <t>') -- Mythic
      send_command('bind !numpad1 input /ws "Numbing Shot" <t>') -- Melee Range
      send_command('bind !numpad2 input /ws "Slug Shot" <t>') -- High dmg, inaccurate
      send_command('bind !numpad3 input /ws "Sniper Shot" <t>') -- Lower enemy INT
    end
  end
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
    send_command('dp '..current_dp_type)
  end
end

function test()
end
