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
--              [ WIN+W ]           Toggle Weapon Lock
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
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  lockstyleset = 1

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
  state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'DT')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Normal', 'Acc', 'LowBuff')
  state.IdleMode:options('Normal', 'DT')
  state.CP = M(false, "Capacity Points Mode")
  state.WeaponLock = M(false, 'Weapon Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle WeaponLock')

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
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Third Eye" <me>')
  elseif player.sub_job == 'DNC' then
    send_command('bind ^- gs c cycleback mainstep')
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind numpad0 gs c step t')
    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind !, input /ma "Utsusemi: Ichi" <me>')
    send_command('bind !. input /ma "Utsusemi: Ni" <me>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
  set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^,')
  send_command('unbind @a')
  send_command('unbind @c')
  send_command('unbind @r')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
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
  
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind numpad0')
  send_command('unbind ^numlock')
  send_command('unbind !,')
  send_command('unbind !.')

  send_command('unbind #`')
  send_command('unbind #1')
  send_command('unbind #2')
  send_command('unbind #3')
  send_command('unbind #4')
  send_command('unbind #5')
  send_command('unbind #6')
  send_command('unbind #7')
  send_command('unbind #8')
  send_command('unbind #9')
  send_command('unbind #0')

end


-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.TreasureHunter = {
    hands="Plunderer's Armlets +1", --3
    feet="Skulk. Poulaines +1", --3
    -- head=gear.Herc_TH_head, --2
    -- hands="Plun. Armlets +3", --4
    -- feet="Skulk. Poulaines +1", --3
    -- waist="Chaac Belt", --1
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
    -- ammo="Yamarang",
    -- body="Passion Jacket",
    -- legs="Dashing Subligar",
    -- ring1="Asklepian Ring",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head=gear.Herc_WSD_head, --7
    body=gear.Taeon_FC_body, --9
    hands="Leyline Gloves", --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Prolix Ring", --2
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
    ammo="Seething Bomblet",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat Ring",
    ring2="Karieyh Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- head=gear.Herc_WSD_head,
    -- body=gear.Herc_WS_body,
    -- hands="Meg. Gloves +2",
    -- legs="Plun. Culottes +3",
    -- feet=gear.Herc_WSD_feet,
    -- neck="Fotia Gorget",
    -- ear1="Ishvara Earring",
    -- ear2="Moonshade Earring",
    -- ring1="Regal Ring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.THF_WS1_Cape,
    -- waist="Fotia Belt",
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
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Meghanada Cuirie +2",
    hands=gear.Adhemar_B_hands,
    legs="Meghanada Chausses +2",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- head=gear.Adhemar_B_head,
    -- body=gear.Adhemar_B_body,
    -- legs="Meg. Chausses +2",
    -- feet="Meg. Jam. +2",
    -- ear1="Sherida Earring",
    -- ear2="Telos Earring",
    -- ring2="Ilabrat Ring",
  })

  sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
    -- head="Dampening Tam",
  })
  
  -- 50% DEX
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    head=gear.Adhemar_B_head,
    body="Meghanada Cuirie +2",
    hands="Mummu Wrists +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Begrudging Ring",
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

  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
    -- ammo="Voluspa Tathlum",
    -- legs="Pill. Culottes +3",
    -- ring1="Regal Ring",
  })

  -- 80% DEX
  sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
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
    ring2="Karieyh Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- neck="Caro Necklace",
    -- ear1="Sherida Earring",
    -- waist="Artful Belt +1",
  })

  sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
    -- ammo="Voluspa Tathlum",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- waist="Grunfeld Rope",
  })

  sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS['Mandalic Stab'].Acc = sets.precast.WS["Rudra's Storm"].Acc

  -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Seething Bomblet", --6
    head="Highwing Helm", --20
    body=gear.Samnuha_body, --25
    hands="Leyline Gloves", --30
    legs=gear.Herc_MAB_legs, --24
    feet=gear.Herc_WSD_feet, --10
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Karieyh Ring",
    waist="Eschan Stone", --7
    -- ammo="Seeth. Bomblet +1",
    -- head=gear.Herc_MAB_head,
    -- feet=gear.Herc_MAB_feet,
    -- back="Argocham. Mantle",
    -- waist="Orpheus's Sash",
  })

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
    ring2="Karieyh Ring",
  }
  sets.latent_regen = {
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Meghanada Chausses +2",
    feet="Meghanada Jambeaux +2",
    neck="Lissome Necklace",
    ear1="Infused Earring",
  }
  sets.latent_refresh = {
    legs="Rawhide Trousers",
  }

  sets.resting = {}

  sets.idle = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
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

  sets.DT = {
    ammo="Staunch Tathlum", --2/2
    neck="Twilight Torque", --5/5
    ring1=gear.Dark_Ring, --5/4
    ring2="Defending Ring", --10/10
    -- ammo="Staunch Tathlum +1", --3/3
    -- head="Malignance Chapeau", --6/6
    -- body="Malignance Tabard", --9/9
    -- hands="Malignance Gloves", --5/5
    -- legs="Malignance Tights", --7/7
    -- feet="Malignance Boots", --4/4
    -- neck="Warder's Charm +1",
    -- ear1="Sanare Earring",
    -- ring1="Purity Ring", --0/4
    -- ring2="Defending Ring", --10/10
    -- back="Moonlight Cape", --6/6
  }

  sets.idle.DT = set_combine(sets.idle, sets.DT)
  sets.idle.DT.Regain = set_combine(sets.idle.Regain, sets.DT)
  sets.idle.DT.Regen = set_combine(sets.idle.Regen, sets.DT)
  sets.idle.DT.Refresh = set_combine(sets.idle.Refresh, sets.DT)
  sets.idle.DT.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.DT)
  sets.idle.DT.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.DT)
  sets.idle.DT.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.DT)
  sets.idle.DT.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.DT)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.idle.DT
  sets.defense.MDT = sets.idle.DT


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Yamarang",
    -- head=gear.Adhemar_B_head,
    -- body=gear.Adhemar_B_body,
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Herc_TA_feet,
    -- neck="Anu Torque",
    -- ear1="Sherida Earring",
    -- ear2="Brutal Earring",
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_TP_Cape,
    -- waist="Windbuffet Belt +1",
  }

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ear2="Telos Earring",
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- body="Pillager's Vest +3",
    -- ear1="Cessance Earring",
    -- ring2="Ilabrat Ring",
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Mache Earring +1",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.STP = set_combine(sets.engaged, {
    -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- * THF Native DW Trait: 30% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 44% from gear)
  sets.engaged.DW = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5%
    ear2="Eabani Earring", -- 4%
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Yamarang",
    -- head=gear.Adhemar_B_head,
    -- body=gear.Adhemar_B_body, -- 6
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Taeon_DW_feet, --9
    -- neck="Erudit. Necklace",
    -- ear1="Eabani Earring", --4
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_DW_Cape, --10
    -- waist="Reiki Yotai", --7
  } -- 41%

  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- body="Pillager's Vest +3",
    -- ring2="Ilabrat Ring",
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
    -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 37% from gear)
  sets.engaged.DW.LowHaste = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5%
    ear2="Eabani Earring", -- 4%
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Yamarang",
    -- head=gear.Adhemar_B_head,
    -- body=gear.Adhemar_B_body, -- 6
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Taeon_DW_feet, --9
    -- neck="Erudit. Necklace",
    -- ear1="Cessance Earring",
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_DW_Cape, --10
    -- waist="Reiki Yotai", --7
  } -- 37%

  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- body="Pillager's Vest +3",
    -- ring2="Ilabrat Ring",
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 26% from gear)
  sets.engaged.DW.MidHaste = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5%
    ear2="Eabani Earring", -- 4%
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Yamarang",
    -- head=gear.Adhemar_B_head,
    -- body="Pillager's Vest +3",
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Herc_TA_feet,
    -- neck="Erudit. Necklace",
    -- ear1="Eabani Earring", --4
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_DW_Cape, --10
    -- waist="Reiki Yotai", --7
  } -- 26%

  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- ear1="Cessance Earring",
    -- ring2="Ilabrat Ring",
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ear1="Sherida Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- High Magic/Gear/JA Haste (51% DW to cap, 21% from gear)
  sets.engaged.DW.HighHaste = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5%
    ear2="Eabani Earring", -- 4%
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Yamarang",
    -- head=gear.Adhemar_B_head,
    -- body="Pillager's Vest +3",
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Herc_TA_feet,
    -- neck="Erudit. Necklace",
    -- ear1="Sherida Earring",
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_DW_Cape, --10
    -- waist="Reiki Yotai", --7
  } -- 22%

  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- ear1="Cessance Earring",
    -- ring2="Ilabrat Ring",
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
      -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ear1="Sherida Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Max Magic/Gear/JA Haste (36% DW to cap, 6% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo="Seething Bomblet",
    head=gear.Adhemar_B_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5%
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_TP_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- head=gear.Adhemar_B_head,
    -- body="Pillager's Vest +3",
    -- hands=gear.Adhemar_A_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Herc_TA_feet,
    -- neck="Erudit. Necklace",
    -- ear1="Sherida Earring",
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.THF_TP_Cape,
    -- waist="Windbuffet Belt +1",
  } -- 5%

  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    -- head="Skulker's Bonnet +1",
    -- neck="Combatant's Torque",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    -- ammo="Yamarang",
    -- head="Dampening Tam",
    -- ear1="Cessance Earring",
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    -- ammo="C. Palug Stone",
    -- legs="Pill. Culottes +3",
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    -- head=gear.Herc_STP_head,
    -- neck="Anu Torque",
    -- ear1="Sherida Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Kentarch Belt +1",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.Hybrid = {
    neck="Twilight Torque", --5/5
    ring1=gear.Dark_Ring, --5/4
    ring2="Defending Ring", --10/10
    -- head="Malignance Chapeau", --6/6
    -- body="Malignance Tabard", --9/9
    -- hands="Malignance Gloves", --5/5
    -- legs="Malignance Tights", --7/7
    -- feet="Malignance Boots", --4/4
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
  sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)


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
    back="Mecistopins Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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
function job_buff_change(buff,gain)

  if buff == "doom" then
    if gain then
      equip(sets.buff.Doom)
      send_command('@input /p Doomed.')
      disable('neck','ring2','waist')
    else
      if player.hpp > 0 then
        send_command('@input /p Doom Removed.')
      end
      enable('neck','ring2','waist')
      handle_equipping_gear(player.status)
    end
  end

  if not midaction() then
    handle_equipping_gear(player.status)
  end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
  if state.WeaponLock.value == true then
    disable('main','sub')
  else
    enable('main','sub')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  update_weapons()
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
  update_weaponskill_binds()
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
  if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
    wsmode = 'Acc'
  end

  --if state.Buff['Sneak Attack'] then
  --  wsmode = 'SA'
  --end
  --if state.Buff['Trick Attack'] then
  --  wsmode = (wsmode or '') .. 'TA'
  --end

  return wsmode
end

function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current ~= 'DT' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
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

  local ws_msg = state.WeaponskillMode.value

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
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
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
    if isRefreshing==true and player.mpp < 100 then
      classes.CustomIdleGroups:append('Refresh')
    elseif isRefreshing==false and player.mpp < 85 then
      classes.CustomIdleGroups:append('Refresh')
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 6 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 6 and DW_needed <= 22 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 22 and DW_needed <= 26 then
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
    send_command('cancel Invisible; cancel Hide; cancel Gestation')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      elseif has_item('Inventory','Skeleton Key') then
        send_command('@input /item "Skeleton Key" <t>')
      elseif has_item('Inventory','Living Key') then
        send_command('@input /item "Living Key" <t>')
      elseif has_item('Inventory','Thief\'s Tools') then
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
  if no_swap_gear:contains(player.equipment.ring1) then
    disable("ring1")
  else
    enable("ring1")
  end
  if no_swap_gear:contains(player.equipment.ring2) then
    disable("ring2")
  else
    enable("ring2")
  end
end

windower.register_event('zone change',
  function()
    if no_swap_gear:contains(player.equipment.ring1) then
      enable("ring1")
      equip(sets.idle)
    end
    if no_swap_gear:contains(player.equipment.ring2) then
      enable("ring2")
      equip(sets.idle)
    end
  end
)

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

function set_lockstyle()
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
