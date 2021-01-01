-- Original: Motenten/Arislan || Modified: Silvermutt
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ ALT+` ]           Flee
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  None                 Will never equip TH gear
--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,
--
--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             Fulltime - Will keep TH gear equipped fulltime


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function() 
    send_command('gs c weaponset current')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  silibs.use_weapon_rearm = true

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false
  state.Buff['Feint'] = buffactive['feint'] or false
  
  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.RangedMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'LightDef')
  state.IdleMode:options('Normal', 'LightDef')
  state.CP = M(false, 'Capacity Points Mode')
  state.RearmingLock = M(false, 'Rearming Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Normal', 'Cleaving'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')
  
  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` input /ja "Flee" <me>')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
  send_command('bind ^numpad. input /ja "Trick Attack" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.set_lockstyle(1)
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
    send_command('bind ^numpad- input /ja "Third Eye" <me>')
  elseif player.sub_job == 'DNC' then
    send_command('bind ^- gs c cycleback mainstep')
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind numpad0 gs c step t')
    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind !numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind !numpad. input /ma "Utsusemi: Ni" <me>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @c')

  send_command('unbind !w')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind numpad0')
  
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind !numpad0')
  send_command('unbind !numpad.')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands="Plunderer's Armlets +1", --3
    feet="Skulk. Poulaines +1", --3
    waist="Chaac Belt", --1
    -- head=gear.Herc_TH_head, --2
    -- hands="Plun. Armlets +3", --4
    -- feet="Skulk. Poulaines +1", --3
  }

  sets.buff['Sneak Attack'] = {}
  sets.buff['Trick Attack'] = {}

  -- Actions we want to use to tag TH.
  sets.precast.Step = sets.TreasureHunter
  sets.precast.Flourish1 = sets.TreasureHunter
  sets.precast.JA.Provoke = sets.TreasureHunter


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, {
    -- head="Skulker's Bonnet +1",
  })
  sets.precast.JA['Accomplice'] = {
    -- head="Skulker's Bonnet +1",
  }
  sets.precast.JA['Flee'] = {
    -- feet="Pill. Poulaines +3",
  }
  sets.precast.JA['Hide'] = {
    -- body="Pillager's Vest +3",
  }
  sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, {
    -- body="Skulker's Vest +1",
  })

  sets.precast.JA['Steal'] = {
    -- ammo="Barathrum", --3
    -- head="Asn. Bonnet +2",
    -- hands="Pillager's Armlets +1",
    -- feet="Pill. Poulaines +3",
  }

  sets.precast.JA['Despoil'] = {
    feet="Skulk. Poulaines +1",
    -- ammo="Barathrum",
    -- legs="Skulk. Culottes +1",
    -- feet="Skulk. Poulaines +1",
  }
  sets.precast.JA['Perfect Dodge'] = {
    -- hands="Plun. Armlets +3",
  }
  sets.precast.JA['Feint'] = {
    -- legs="Plun. Culottes +3",
  }
  -- sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
  -- sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

  sets.precast.Waltz = {
    legs="Dashing Subligar",
    waist="Gishdubar Sash",
    -- ammo="Yamarang",
    -- body="Passion Jacket",
    -- ring1="Asklepian Ring",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
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
    -- ring1="Lebeche Ring",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    locked_ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- body=gear.Herc_WS_body,
    -- legs="Plun. Culottes +3",
    -- ring2="Epaminondas's Ring",
    -- back=gear.THF_WS1_Cape,
  } -- default set

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    -- ammo="Voluspa Tathlum",
    -- ear2="Telos Earring",
  })

  sets.precast.WS.Critical = {
    -- ammo="Yetshila +1",
    -- head="Pill. Bonnet +3",
    -- body="Meg. Cuirie +2",
  }

  -- AGI
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    ammo="Seething Bomblet +1",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs="Meghanada Chausses +2",
    feet="Meg. Jam. +2",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
  })
  sets.precast.WS['Exenterator'].MaxTP = set_combine(sets.precast.WS['Exenterator'], {
  })
  sets.precast.WS['Exenterator'].LowAcc = set_combine(sets.precast.WS['Exenterator'], {
    head="Dampening Tam",
  })
  sets.precast.WS['Exenterator'].LowAccMaxTP = set_combine(sets.precast.WS['Exenterator'].LowAcc, {
  })
  sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS['Exenterator'].LowAcc, {
  })
  sets.precast.WS['Exenterator'].MidAccMaxTP = set_combine(sets.precast.WS['Exenterator'].MidAcc, {
  })
  sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS['Exenterator'].MidAcc, {
  })
  sets.precast.WS['Exenterator'].HighAccMaxTP = set_combine(sets.precast.WS['Exenterator'].HighAcc, {
  })
  
  -- 50% DEX
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Meghanada Cuirie +2",
    hands="Mummu Wrists +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    waist="Fotia Belt",
    back=gear.THF_TP_Cape,
    -- ammo="Yetshila +1",
    -- head=gear.Adhemar_B_head,
    -- body="Pillager's Vest +3",
    -- hands="Mummu Wrists +2",
    -- legs="Zoar Subligar +1",
    -- feet=gear.Herc_TA_feet,
    -- ear1="Sherida Earring",
    -- ear2="Mache Earring +1",
    -- ring1="Begrudging Ring",
    -- ring2="Mummu Ring",
    -- back=gear.THF_WS2_Cape,
  })
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Dignitary's Earring",
    -- ammo="Voluspa Tathlum",
    -- legs="Pill. Culottes +3",
  })
  sets.precast.WS['Evisceration'].LowAccMaxTP = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAccMaxTP = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
  })

  -- 80% DEX
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Grunfeld Rope",
    ear1="Moonshade Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- neck="Caro Necklace",
    -- ear1="Sherida Earring",
    -- waist="Artful Belt +1",
  })
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
  })
  sets.precast.WS["Rudra's Storm"].LowAcc = set_combine(sets.precast.WS["Rudra's Storm"], {
    -- ammo="Voluspa Tathlum",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- waist="Grunfeld Rope",
  })
  sets.precast.WS["Rudra's Storm"].LowAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {
  })
  sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {
  })
  sets.precast.WS["Rudra's Storm"].MidAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {
  })
  sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {
  })
  sets.precast.WS["Rudra's Storm"].HighAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].HighAcc, {
  })

  sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS['Mandalic Stab'].MaxTP = sets.precast.WS["Rudra's Storm"].MaxTP
  sets.precast.WS['Mandalic Stab'].LowAcc = sets.precast.WS["Rudra's Storm"].LowAcc
  sets.precast.WS['Mandalic Stab'].LowAccMaxTP = sets.precast.WS["Rudra's Storm"].LowAccMaxTP
  sets.precast.WS['Mandalic Stab'].MidAcc = sets.precast.WS["Rudra's Storm"].MidAcc
  sets.precast.WS['Mandalic Stab'].MidAccMaxTP = sets.precast.WS["Rudra's Storm"].MidAccMaxTP
  sets.precast.WS['Mandalic Stab'].HighAcc = sets.precast.WS["Rudra's Storm"].HighAcc
  sets.precast.WS['Mandalic Stab'].HighAccMaxTP = sets.precast.WS["Rudra's Storm"].HighAccMaxTP

  -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Seething Bomblet +1", --7
    head=gear.Herc_MAB_head, --25
    body=gear.Samnuha_body, --33
    hands=gear.Leyline_Gloves, --30
    legs=gear.Herc_MAB_legs, --33
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Dingir Ring", --10
    back="Argochampsa Mantle", --12
    waist="Eschan Stone", --7
    -- waist="Orpheus's Sash",
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring", --7
  })
  sets.precast.WS['Aeolian Edge'].LowAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].LowAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP
  sets.precast.WS['Aeolian Edge'].MidAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].MidAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP
  sets.precast.WS['Aeolian Edge'].HighAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].HighAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Impatiens", --10
    -- ring1="Evanescence Ring", --5
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Turms Cap +1",
  }
  sets.latent_regen = {
    head="Turms Cap +1",
    body="Meghanada Cuirie +2",
    hands="Turms Mittens",
    legs="Meghanada Chausses +2",
    feet="Turms Leggings",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }

  sets.resting = {}

  sets.idle = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
  }

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.LightDef = {
    ammo="Staunch Tathlum", --2/2, 0
    head="Turms Cap +1", --0/0, 109
    body="Malignance Tabard", --9/9, 139 
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
  } --27 PDT/27 MDT, 660 MEVA

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)

  sets.HeavyDef = {
    ammo="Staunch Tathlum", --2/2, 0
    head="Turms Cap +1", --0/0, 109
    body="Malignance Tabard", --9/9, 139 
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
    neck="Twilight Torque", --5/5, 0
    ear1="Eabani Earring", --0/0, 8
    ear2="Odnowa Earring +1", --3/5, 0
    ring1=gear.Dark_Ring, --5/4, 0
    ring2="Defending Ring", --10/10, 0
  } --50 PDT/51 MDT, 668 MEVA

  sets.idle.Weak = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ring1="Chirich Ring +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    head="Dampening Tam",
    ear1="Cessance Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- ammo="Yamarang",
    -- body="Pillager's Vest +3",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    -- ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- * THF Native DW Trait: 30% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 44% from gear)
  sets.engaged.DW = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, -- 6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Samnuha_legs,
    feet=gear.Taeon_DW_feet, --9
    neck="Anu Torque",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- neck="Erudit. Necklace",
    -- back=gear.THF_DW_Cape, --10
  }--36
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    ring1="Chirich Ring +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    head="Dampening Tam",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- ammo="Yamarang",
    -- body="Pillager's Vest +3",
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 37% from gear)
  sets.engaged.DW.LowHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Samnuha_legs,
    feet=gear.Taeon_DW_feet, --9
    neck="Anu Torque",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Erudit. Necklace",
    -- ear1="Sherida Earring",
    -- ear2="Suppanomimi", --5
    -- back=gear.THF_DW_Cape, --10
  }

  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ring1="Chirich Ring +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })

  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    head="Dampening Tam",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- ammo="Yamarang",
    -- body="Pillager's Vest +3",
  })

  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ear2="Telos Earring",
    ring1="Regal Ring",
    -- ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 26% from gear)
  sets.engaged.DW.MidHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    ear1="Eabani Earring", --4
    ear2="Suppanomimi", --5
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- body="Pillager's Vest +3",
    -- hands=gear.Adhemar_B_hands,
    -- feet=gear.Herc_TA_feet,
    -- neck="Erudit. Necklace",
    -- back=gear.THF_DW_Cape, --10
  }--27

  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ring1="Chirich Ring +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })

  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    head="Dampening Tam",
    ear1="Cessance Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- ammo="Yamarang",
  })

  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    ear2="Telos Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 13% from gear)
  sets.engaged.DW.HighHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- body="Pillager's Vest +3",
    -- neck="Erudit. Necklace",
  }
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ring1="Chirich Ring +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    head="Dampening Tam",
    ear1="Cessance Earring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- ammo="Yamarang",
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    ear2="Telos Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (36% DW to cap, 6% from gear)
  sets.engaged.DW.SuperHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Windbuffet Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- body="Pillager's Vest +3",
    -- neck="Erudit. Necklace",
  }
  sets.engaged.DW.LowAcc.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, {
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.SuperHaste = set_combine(sets.engaged.DW.LowAcc.SuperHaste, {
    head="Dampening Tam",
    ear1="Cessance Earring",
    ring2="Ilabrat Ring",
    -- ammo="Yamarang",
  })
  sets.engaged.DW.HighAcc.SuperHaste = set_combine(sets.engaged.DW.MidAcc.SuperHaste, {
    ear2="Telos Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- Max Magic/Gear/JA Haste (0-30% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Windbuffet Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- body="Pillager's Vest +3",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Erudit. Necklace",
  }
  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    head="Dampening Tam",
    ear1="Cessance Earring",
    ring2="Ilabrat Ring",
    -- ammo="Yamarang",
  })
  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    ear2="Telos Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
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

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Skadi's Jambeaux +1",
    -- feet="Pill. Poulaines +3",
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

  sets.WeaponSet = {}
  sets.WeaponSet['Normal'] = {main="Aeneas", sub="Taming Sari"}
  sets.WeaponSet['Cleaving'] = {main="Malevolence", sub="Malevolence"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
  silibs.cancel_outranged_ws(spell, eventArgs)
  silibs.cancel_on_blocking_status(spell, eventArgs)
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spellMap == 'Utsusemi' then
    if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      cancel_spell()
      add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
      eventArgs.handled = true
      return
    elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
      send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
    end
  end
  if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
    if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
      equip(sets.TreasureHunter)
    end
  end
  if spell.type == "WeaponSkill" then
    if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
      equip(sets.precast.WS.Critical)
    end
  end
  if spell.type == 'WeaponSkill' then
    if spell.english == 'Aeolian Edge' then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip({waist="Hachirin-no-Obi"})
      end
    end
  end
  
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
    state.Buff['Trick Attack'] = false
    state.Buff['Feint'] = false
  end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
  -- If Feint is active, put that gear set on on top of regular gear.
  -- This includes overlaying SATA gear.
  check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Sneak Attack" or buff == "Trick Attack" or buff == "doom" then
    status_change(player.status)
  end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
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

  -- Check for SATA when equipping gear.  If either is active, equip
  -- that gear specifically, and block equipping default gear.
  check_buff('Sneak Attack', eventArgs)
  check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  th_update(cmdParams, eventArgs)
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

  if state.OffenseMode.value ~= 'Normal' then
    wsmode = state.OffenseMode.value
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

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end
  
  -- add_to_chat(001, 'idle set: '..inspect(idleSet))

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  
  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
  
  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

  local msg = ''
  if state.TreasureMode.value ~= 'None' then
    msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
  end
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if player.sub_job == 'DNC' then
    local s_msg = state.MainStep.current
    msg = msg ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(sets.WeaponSet[state.WeaponSet.current])
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
      if isRefreshing==true and player.mpp < 100 then
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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 0 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 0 and DW_needed <= 6 then
      classes.CustomMeleeGroups:append('SuperHaste')
    elseif DW_needed > 6 and DW_needed <= 13 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 13 and DW_needed <= 26 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 26 and DW_needed <= 37 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 37 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1] == 'step' then
    send_command('@input /ja "'..state.MainStep.Current..'" <t>')
  elseif cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      elseif silibs.has_item('Inventory','Skeleton Key') then
        send_command('@input /item "Skeleton Key" <t>')
      elseif silibs.has_item('Inventory','Living Key') then
        send_command('@input /item "Living Key" <t>')
      elseif silibs.has_item('Inventory','Thief\'s Tools') then
        send_command('@input /item "Thief\'s Tools" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  elseif cmdParams[1]:lower() == 'toyweapon' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2]:lower() == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1]:lower() == 'weaponset' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2]:lower() == 'current' then
      cycle_weapons('current')
    end
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

function job_pretarget(spell, action, spellMap, eventArgs)
  
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
  if state.Buff[buff_name] then
    equip(sets.buff[buff_name] or {})
    if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
      equip(sets.TreasureHunter)
    end
    eventArgs.handled = true
  end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
  if category == 2 or -- any ranged attack
    --category == 4 or -- any magic action
    (category == 3 and param == 30) or -- Aeolian Edge
    (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
    (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
    then return true
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
  -- Default macro set/book
  if player.sub_job == 'DNC' then
    set_macro_page(1, 8)
  elseif player.sub_job == 'WAR' then
    set_macro_page(2, 8)
  elseif player.sub_job == 'NIN' then
    set_macro_page(3, 8)
  else
    set_macro_page(1, 8)
  end
end
