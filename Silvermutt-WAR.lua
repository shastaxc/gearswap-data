-- File Status: Good. Missing acc sets. Missing DW sets.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: HasteInfo
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable GearInfo, disable RollTracker

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
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
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
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c weaponset current')
  end, 5)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(13)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('LightDef', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(true, "Attack Capped")

  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger','Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Naegling', 'Shining One', 'Club', 'Dagger', 'Staff'}
  -- state.WeaponSet = M{['description']='Weapon Set', 'Ukon', 'Chango', 'Naegling', 'Shining One', 'Club', 'Dagger', 'Magic Axe', 'Phys Axe', 'Great Sword', 'Staff'}
  state.EnmityMode = M{['description']='Enmity Mode', 'Normal', 'Low', 'Schere'}

  -- Set to 'True' if you want to dual wield weapons if you have the trait available
  -- You may not want to dual wield because it will disable the Fencer trait
  use_dw_if_available = false

  skill_ids_2h = S{4, 6, 7, 8, 10, 12} -- DO NOT MODIFY
  fencer_tp_bonus = {200, 300, 400, 450, 500, 550, 600, 630} -- DO NOT MODIFY
  warcry_self = buffactive['Warcry'] or false -- DO NOT MODIFY
  
  -- DO NOT MODIFY
  activate_AM_mode = {
    ["Conqueror"] = S{"Aftermath: Lv.3"},
    ["Bravura"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ragnarok"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Farsha"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ukonvasara"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
  }

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !e input /ja "Hasso" <me>')
  send_command('bind !q input /ja "Meditate" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end

  update_melee_groups()

  select_default_macro_book()
end

function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind ^f8')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}

  -- Enmity sets
  sets.Enmity = {
    ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    ear1="Friomisi Earring",
    ear2="Cryptic Earring",
    ring1="Moonlight Ring",
    ring2="Defending Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Engraved Belt",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Sapience Orb",
    -- head="Volte Salade",
    -- body={ name="Odyss. Chestplate", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','AGI+1','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    hands=gear.Leyline_Gloves, --8
    -- legs="Volte Hose",
    -- feet={ name="Odyssean Greaves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','MND+7','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
    neck="Orunmila's Torque", --5
    ear1="Etiolation Earring",
    ear2="Loquacious Earring", --2
    ring1="Defending Ring",
    ring2="Weatherspoon Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Flume Belt +1",
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    ring1="Prolix Ring",
    ring2="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ammo="Impatiens",
    ring1="Weatherspoon Ring", --5
  })

  sets.precast.JA['Berserk'] = {
    body="Pummeler's Lorica +2",
    feet="Agoge Calligae +1",
    back="Cichol's Mantle",
    -- body="Pummeler's Lorica +3",
    -- feet="Agoge Calligae +3",
  }
  sets.precast.JA['Warcry'] = {
    head="Agoge Mask +1",
    -- head="Agoge Mask +3",
  }
  sets.precast.JA['Defender'] = {}
  sets.precast.JA['Aggressor'] = {}
  sets.precast.JA['Mighty Strikes'] = {}
  sets.precast.JA["Warrior's Charge"] = {}
  sets.precast.JA['Tomahawk'] = {
    feet="Agoge Calligae +1",
    -- ammo="Throwing Tomahawk",
    -- feet="Agoge Calligae +3",
  }
  sets.precast.JA['Retaliation'] = {
    feet="Boii Calligae +2",
    -- feet="Boii Calligae +3",
  }
  sets.precast.JA['Restraint'] = {}
  sets.precast.JA['Blood Rage'] = {
    body="Boii Lorica +2",
    -- body="Boii Lorica +3",
  }
  sets.precast.JA['Brazen Rush'] = {}
  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }
  sets.precast.Step = {
    head="Flamma Zucchetto +2",
    body=gear.Nyame_B_body,
    hands="Flamma Manopolas +2",
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Schere Earring", -- R20+
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    back=gear.WAR_STR_DA_Cape,
    waist="Olseni Belt",
    -- neck="Warrior's Bead Necklace +2",
  }
  sets.precast.Flourish1 = {
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,               -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Warrior's Bead Necklace +1",    -- 12, __, 20, 20, __, __ [__/__, ___]
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    ear2="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- 251 STR, 161 MND, 403 Attack, 267 Accuracy, 82 WSD, 3 PDL [48 PDT/38 MDT, 674 M.Eva]

    -- hands="Boii Mufflers +3",          -- 24, 38, 62, 62, 12, __ [__/__,  82]
    -- neck="Warrior's Bead Necklace +2", -- 15, __, 25, 25, __, __ [__/__, ___]
    -- 261 STR, 159 MND, 405 Attack, 294 Accuracy, 83 WSD, 3 PDL [41 PDT/31 MDT, 644 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Schere Earring",                --  5, __, 15, 15, __, __ [__/__, ___]
    -- 266 STR, 159 MND, 420 Attack, 305 Accuracy, 83 WSD, 3 PDL [41 PDT/31 MDT, 644 M.Eva]
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",            --  3, __, __, __, __,  3 [ 3/ 3, ___]
    head="Sakpata's Helm",                -- 33, 23, 70, 55, __,  5 [ 7/ 7, 123]
    body="Sakpata's Breastplate",         -- 42, 28, 70, 55, __,  8 [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 33, 70, 55, __,  6 [ 8/ 8, 112]
    legs="Sakpata's Cuisses",             -- 53, 21, 70, 55, __,  7 [ 9/ 9, 150]
    feet="Sakpata's Leggings",            -- 29, 19, 70, 55, __,  4 [ 6/ 6, 150]
    -- 269 STR, 124 MND, 410 Attack, 324 Accuracy, 18 WSD, 36 PDL [53 PDT/43 MDT, 674 M.Eva]

    -- legs="Boii Cuisses +3",            -- 53, 27, 73, 63, __, 10 [__/__, 130]; TP Bonus+100
    -- 269 STR, 130 MND, 348 Attack, 332 Accuracy, 18 WSD, 39 PDL [44 PDT/34 MDT, 654 M.Eva]
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear2="Ishvara Earring",               -- __, __, __, __,  2, __ [__/__, ___]
    -- 269 STR, 130 MND, 348 Attack, 328 Accuracy, 20 WSD, 39 PDL [44 PDT/34 MDT, 654 M.Eva]
  })

  -- 50% STR/50% MND
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Savage Blade'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 85% VIT; 4 hit, dmg varies with TP
  -- DA Dmg does not apply to WS, but DA itself will cause the WS to deal more dmg
  sets.precast.WS['Upheaval'] = {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 30, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,               -- 24, 65, 53, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Warrior's Bead Necklace +1",    -- __, 20, 20, __, __ < 6, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Regal Ring",                   -- 10, 20, __, __, __ <__, __, __> [__/__, ___]
    ring2="Gelatinous Ring +1",           -- 15, __, __, __, __ <__, __, __> [ 7/-1, ___]
    back=gear.WAR_STR_WSD_Cape,           -- __, 20, 20, 10, __ <__, __, __> [10/__, ___]; DA Dmg +20%
    waist="Ioskeha Belt +1",              -- __, __, 17, __, __ < 9, __, __> [__/__, ___]
    -- WAR Traits                            __, __, __, __, __ <33, __, __> [__/__, ___]
    -- 212 VIT, 423 Attack, 267 Accuracy, 77 WSD, 0 PDL <67 DA, 2 TA, QA> [55 PDT/37 MDT, 674 M.Eva]

    -- hands="Boii Mufflers +3",          -- 47, 62, 62, 12, __ <__, __, __> [__/__,  82]
    -- neck="Warrior's Bead Necklace +2", -- __, 25, 25, __, __ < 7, __, __> [__/__, ___]
    -- back=gear.WAR_VIT_WSD_Cape,        -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]; DA Dmg +20%
    -- 235 VIT, 410 Attack, 311 Accuracy, 78 WSD, 0 PDL <72 DA, 0 TA, QA> [48 PDT/30 MDT, 644 M.Eva]
  }
  sets.precast.WS['Upheaval'].MaxTP = set_combine(sets.precast.WS['Upheaval'], {
    ear1="Schere Earring",                -- __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })
  sets.precast.WS['Upheaval'].AttCapped = set_combine(sets.precast.WS['Upheaval'], {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head="Sakpata's Helm",                -- 40, 70, 55, __,  5 < 5, __, __> [ 7/ 7, 123]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 51, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    legs="Sakpata's Cuisses",             -- 34, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Sakpata's Leggings",            -- 30, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Warrior's Bead Necklace +1",    -- __, 20, 20, __, __ < 6, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Regal Ring",                   -- 10, 20, __, __, __ <__, __, __> [__/__, ___]
    ring2="Gelatinous Ring +1",           -- 15, __, __, __, __ <__, __, __> [ 7/-1, ___]
    back=gear.WAR_STR_WSD_Cape,           -- __, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Ioskeha Belt +1",              -- __, __, 17, __, __ < 9, __, __> [__/__, ___]
    -- WAR Traits                            __, __, __, __, __ <33, __, __> [__/__, ___]
    -- 232 VIT, 433 Attack, 336 Accuracy, 19 WSD, 30 PDL <78 DA, 0 TA, 0 QA> [57 PDT/39 MDT, 674 M.Eva]

    -- hands="Boii Mufflers +3",          -- 47, 62, 62, 12, __ <__, __, __> [__/__,  82]
    -- legs="Boii Cuisses +3",            -- 40, 73, 63, __, 10 < 8, __, __> [__/__, 130]; TP Bonus+100
    -- neck="Warrior's Bead Necklace +2", -- __, 25, 25, __, __ < 7, __, __> [__/__, ___]
    -- back=gear.WAR_VIT_WSD_Cape,        -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    -- 264 VIT, 433 Attack, 356 Accuracy, 31 WSD, 27 PDL <74 DA, 0 TA, 0 QA> [40 PDT/22 MDT, 624 M.Eva]
  })
  sets.precast.WS['Upheaval'].AttCappedMaxTP = set_combine(sets.precast.WS['Upheaval'].AttCapped, {
    ear1="Schere Earring",                -- __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })

  -- 80% STR; 2 hit, crit varies with TP
  sets.precast.WS["Ukko's Fury"] = {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 65, 50, 11, __ (__, __) < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet="Boii Calligae +2",              -- 26, 50, 50, __, __ (__, 12) <__, __, __> [ 9/ 9, 120]
    neck="Warrior's Bead Necklace +1",    -- 12, 20, 20, __, __ (__, __) < 6, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- 30, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]; DA Dmg+20%
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- WAR Traits                            __, __, __, __, __ (__, __) <33, __, __> [__/__, ___]
    -- 264 STR, 365 Attack, 264 Accuracy, 60 WSD, 3 PDL (2 Crit Rate, 18 Crit Dmg) <67 DA, 2 TA, 3 QA> [50 PDT/40 MDT, 644 M.Eva]

    -- feet="Boii Calligae +3",           -- 31, 60, 60, __, __ (__, 13) <__, __, __> [10/10, 130]
    -- neck="Warrior's Bead Necklace +2", -- 15, 25, 25, __, __ (__, __) < 7, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
    -- 277 STR, 375 Attack, 299 Accuracy, 57 WSD, 3 PDL (10 Crit Rate, 19 Crit Dmg) <77 DA, 2 TA, 3 QA> [51 PDT/41 MDT, 654 M.Eva]
  }
  sets.precast.WS["Ukko's Fury"].MaxTP = set_combine(sets.precast.WS["Ukko's Fury"], {
    ear1="Schere Earring",                --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    
    -- ear1="Thrud Earring",              -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
  })
  sets.precast.WS["Ukko's Fury"].AttCapped = {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Sakpata's Helm",                -- 33, 70, 55, __,  5 (__, __) < 5, __, __> [ 7/ 7, 123]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 ( 5, __) < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 (__, __) < 6, __, __> [ 8/ 8, 112]
    legs="Sakpata's Cuisses",             -- 53, 70, 55, __,  7 (__, __) < 7, __, __> [ 9/ 9, 150]
    feet="Boii Calligae +2",              -- 26, 50, 50, __, __ (__, 12) <__, __, __> [ 9/ 9, 120]
    neck="Warrior's Bead Necklace +1",    -- 12, 20, 20, __, __ (__, __) < 6, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- 30, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- WAR Traits                            __, __, __, __, __ (__, __) <33, __, __> [__/__, ___]
    -- 270 STR, 385 Attack, 314 Accuracy, 13 WSD, 29 PDL (7 Crit Rate, 18 Crit Dmg) <70 DA, 2 TA, 3 QA> [53 PDT/43 MDT, 644 M.Eva]

    -- legs="Boii Cuisses +3",            -- 53, 73, 63, __, 10 (__, __) < 8, __, __> [__/__, 130]; TP Bonus+100
    -- feet="Boii Calligae +3",           -- 31, 60, 60, __, __ (__, 13) <__, __, __> [10/10, 130]
    -- neck="Warrior's Bead Necklace +2", -- 15, 25, 25, __, __ (__, __) < 7, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
    -- 283 STR, 403 Attack, 358 Accuracy, 10 WSD, 32 PDL (15 Crit Rate, 19 Crit Dmg) <81 DA, 2 TA, 3 QA> [45 PDT/35 MDT, 634 M.Eva]
  }
  sets.precast.WS["Ukko's Fury"].AttCappedMaxTP = set_combine(sets.precast.WS["Ukko's Fury"].AttCapped, {
    ear1="Schere Earring",                --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    
    -- ear1="Thrud Earring",              -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
  })
  
  -- 85% STR; 5 hit, transfers ftp
  sets.precast.WS['Resolution'] = {
    ammo="Seething Bomblet +1",           -- 15, 13, 13, __, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,               -- 23, 65, 53, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Regal Ring",                   -- 10, 20, __, __, __ <__, __, __> [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]; DA Dmg+20%
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- WAR Traits                            __, __, __, __, __ <33, __, __> [__/__, ___]
    -- 244 STR, 382 Attack, 256 Accuracy, 71 WSD, 0 PDL <61 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 674 M.Eva]

    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ < 9, __, __> [__/__, ___]
    -- 249 STR, 382 Attack, 276 Accuracy, 68 WSD, 0 PDL <70 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 674 M.Eva]
  }
  sets.precast.WS['Resolution'].MaxTP = set_combine(sets.precast.WS['Resolution'], {
    ear1="Ishvara Earring",               -- __, __, __,  2, __ <__, __, __> [__/__, ___]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]

    -- ear1="Thrud Earring",              -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ < 9, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCapped = set_combine(sets.precast.WS['Resolution'], {
    ammo="Seething Bomblet +1",           -- 15, 13, 13, __, __ <__, __, __> [__/__, ___]
    head="Sakpata's Helm",                -- 33, 70, 55, __,  5 < 5, __, __> [ 7/ 7, 123]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    legs="Sakpata's Cuisses",             -- 53, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Sakpata's Leggings",            -- 30, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Sroda Ring",                   -- 15, __, __, __,  3 <__, __, __> [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- WAR Traits                            __, __, __, __, __ <33, __, __> [__/__, ___]
    -- 262 STR, 387 Attack, 308 Accuracy, 13 WSD, 33 PDL <63 DA, 0 TA, 3 QA> [50 PDT/40 MDT, 674 M.Eva]
    
    -- legs="Boii Cuisses +3",            -- 53, 73, 63, __, 10 < 8, __, __> [__/__, 130]; TP Bonus+100
    -- 262 STR, 390 Attack, 316 Accuracy, 13 WSD, 36 PDL <64 DA, 0 TA, 3 QA> [41 PDT/31 MDT, 654 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ear1="Ishvara Earring",               -- __, __, __,  2, __ <__, __, __> [__/__, ___]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]

    -- ear1="Thrud Earring",              -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ < 9, __, __> [__/__, ___]
  })

  -- 50% STR; 3 hits, transfers ftp, acc varies with tp
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})
  
  -- 40% STR/40% MND; lightning elemental, dmg varies with TP
  sets.precast.WS['Cloudsplitter'] = {
    ammo="Seething Bomblet +1",           --  7, __, __, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 30, __, 40, 11 [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 30, __, 40, 13 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 30, __, 40, 11 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 30, __, 40, 12 [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,               -- 30, __, 40, 11 [ 7/ 7, 150]
    neck="Baetyl Pendant",                -- 13, __, __, __ [__/__, ___]
    ear1="Friomisi Earring",              -- 10, __, __, __ [__/__, ___]
    ear2="Moonshade Earring",             -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ring1="Shiva Ring +1",                --  3, __, __, __ [__/__, ___]
    ring2="Regal Ring",                   -- __, __, __, __ [__/__, ___]
    back=gear.WAR_STR_WSD_Cape,           -- __, __, __, __ [10/__, ___]
    waist="Eschan Stone",                 --  7, __,  7, __ [__/__, ___]
    -- 190 MAB, 0 M.Dmg, 207 M.Acc, 58 WSD [48 PDT/38 MDT, 674 M.Eva]

    -- back=gear.WAR_STR_MAB_Cape,        -- 10, 20, 20, __ [10/__, ___]
    -- waist="Skrymir Cord +1",           --  7, 35,  7, __ [__/__, ___]
    -- 200 MAB, 55 M.Dmg, 227 M.Acc, 58 WSD [48 PDT/38 MDT, 674 M.Eva]
  }
  sets.precast.WS['Cloudsplitter'].MaxTP = set_combine(sets.precast.WS['Cloudsplitter'], {
    ear2="Novio Earring",
  })
  sets.precast.WS['Cloudsplitter'].AttCapped = set_combine(sets.precast.WS['Cloudsplitter'], {})
  sets.precast.WS['Cloudsplitter'].AttCappedMaxTP = set_combine(sets.precast.WS['Cloudsplitter'].AttCapped, {
    ear2="Novio Earring",
  })
  
  -- 30% STR/30% INT; darkness elemental, dmg varies with TP
  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Cloudsplitter'], {
    head="Pixie Hairpin +1",
    ring2="Archon Ring",
    -- back=gear.WAR_INT_MAB_Cape,
  })
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Cloudsplitter'].MaxTP, {
    head="Pixie Hairpin +1",
    ring2="Archon Ring",
    -- back=gear.WAR_INT_MAB_Cape,
  })
  sets.precast.WS['Cataclysm'].AttCapped = set_combine(sets.precast.WS['Cloudsplitter'].AttCapped, {
    head="Pixie Hairpin +1",
    ring2="Archon Ring",
    -- back=gear.WAR_INT_MAB_Cape,
  })
  sets.precast.WS['Cataclysm'].AttCappedMaxTP = set_combine(sets.precast.WS['Cloudsplitter'].AttCappedMaxTP, {
    head="Pixie Hairpin +1",
    ring2="Archon Ring",
    -- back=gear.WAR_INT_MAB_Cape,
  })

  -- 40% DEX/40% INT; wind elemental, dmg varies with TP
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Cataclysm'], {})
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Cataclysm'].MaxTP, {})
  sets.precast.WS['Aeolian Edge'].AttCapped = set_combine(sets.precast.WS['Cataclysm'].AttCapped, {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Cataclysm'].AttCappedMaxTP, {})

  -- Polearm sets use a crit build since you should be using Shining One
  -- 100% STR; 2 hit, dmg varies with TP
  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS["Ukko's Fury"], {})
  sets.precast.WS['Impulse Drive'].MaxTP = set_combine(sets.precast.WS["Ukko's Fury"].MaxTP, {})
  sets.precast.WS['Impulse Drive'].AttCapped = set_combine(sets.precast.WS["Ukko's Fury"].AttCapped, {})
  sets.precast.WS['Impulse Drive'].AttCappedMaxTP = set_combine(sets.precast.WS["Ukko's Fury"].AttCappedMaxTP, {})

  -- 85% STR; 4 hit, dmg varies with TP
  sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS["Ukko's Fury"], {})
  sets.precast.WS['Stardiver'].MaxTP = set_combine(sets.precast.WS["Ukko's Fury"].MaxTP, {})
  sets.precast.WS['Stardiver'].AttCapped = set_combine(sets.precast.WS["Ukko's Fury"].AttCapped, {})
  sets.precast.WS['Stardiver'].AttCappedMaxTP = set_combine(sets.precast.WS["Ukko's Fury"].AttCappedMaxTP, {})

  -- 40% STR / 40% DEX; aoe, dmg varies with TP
  sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS["Ukko's Fury"], {
    ring1="Regal Ring",
  })
  sets.precast.WS['Sonic Thrust'].MaxTP = set_combine(sets.precast.WS["Ukko's Fury"].MaxTP, {
    ring1="Regal Ring",
  })
  sets.precast.WS['Sonic Thrust'].AttCapped = set_combine(sets.precast.WS["Ukko's Fury"].AttCapped, {
    ring1="Regal Ring",
  })
  sets.precast.WS['Sonic Thrust'].AttCappedMaxTP = set_combine(sets.precast.WS["Ukko's Fury"].AttCappedMaxTP, {
    ring1="Regal Ring",
  })



  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  sets.midcast.Utsusemi = {
    ammo="Impatiens", -- SIRD
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    legs=gear.Nyame_B_legs, -- DT
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ring1="Defending Ring", -- DT
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Odnowa Earring +1",
    ear2="Eabani Earring",
    ring1="Moonlight Ring",
    ring2="Gelatinous Ring +1",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- neck="Warrior's Bead Necklace +2",
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    -- head="Valorous Mask",
    -- head="Wakido Kabuto +3",
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    -- ring2="Chirich Ring +1",
    -- body="Sacro Breastplate", --10
  }
  sets.latent_refresh = {
    ring1="Stikini Ring +1", -- 1
    -- ring2="Stikini Ring +1", -- 1
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
  })

  sets.idle = set_combine(sets.defense.PDT, {})

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

  sets.idle.HeavyDef = set_combine(sets.defense.PDT, {})

  sets.idle.Weak = set_combine(sets.defense.PDT, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Focus STP > DA
  sets.engaged = {
    ammo="Coiste Bodhar",             -- [__/__, ___]  3 <__, __,  3> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53]  6 <__,  5, __> __,  4
    body="Hjarrandi Breastplate",     -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",      -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Tatenashi Haidate +1",      -- [__/__,  80]  8 <__,  3, __> __,  5
    feet="Tatenashi Sune-ate +1",     -- [__/__,  80]  8 <__,  3, __> __,  3
    neck="Vim Torque +1",             -- [__/__, ___] 10 <__, __, __> __, __
    ear1="Schere Earring",            -- [__/__, ___]  5 <__, __,  6> __, __
    ear2="Telos Earring",             -- [__/__, ___]  5 <__, __,  1> __, __
    ring1="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,        -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Sailfi Belt +1",           -- [__/__, ___] __ <__,  2,  5> __,  9
    -- WAR Traits                        [__/__, ___] __ <__, __, 33> __, __
    -- [40 PDT/30 MDT, 394 MEVA] 73 STP <0 QA, 13 TA, 64 DA> 13 Crit Rate, 25 Haste; DA dmg+20%

    -- back=gear.WAR_STP_Cape,        -- [10/__, ___] 10 <__, __, __> __, __; DA dmg+20%
    -- [40 PDT/30 MDT, 394 MEVA] 83 STP <0 QA, 13 TA, 54 DA> 13 Crit Rate, 25 Haste; DA dmg+20%
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
  })

  sets.engaged.LowDW = set_combine(sets.engaged,{
    ear2="Eabani Earring",
    -- back=gear.WAR_DW_Cape,
  })
  sets.engaged.MidDW = set_combine(sets.engaged.LowDW, {})
  sets.engaged.HighDW = set_combine(sets.engaged.LowDW, {})
  sets.engaged.SuperDW = set_combine(sets.engaged.LowDW, {})
  sets.engaged.MaxDW = set_combine(sets.engaged.LowDW, {})

  -- Focus capped DA > STP
  sets.engaged.TwoHanded = {
    ammo="Coiste Bodhar",                 -- [__/__, ___]  3 <__, __,  3> __, __
    head="Hjarrandi Helm",                -- [10/10,  53]  7 <__, __,  6> __, __
    body="Boii Lorica +2",                -- [13/13,  99] 10 <__, __, __> __,  3
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Agoge Cuisses +3",              -- [__/__, 100] __ <__, __,  6> __,  6; DA dmg+11%
    feet="Pummeler's Calligae +3",        -- [__/__, 100]  4 <__, __,  9> __,  4
    neck="Warrior's Bead Necklace +1",    -- [__/__, ___] __ <__, __,  6> __, __
    ear1="Schere Earring",                -- [__/__, ___]  5 <__, __,  6> __, __
    ear2="Boii Earring",                  -- [__/__, ___] __ <__, __,  7> __, __
    ring1="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [51 PDT/41 MDT, 464 MEVA] 47 STP <0 QA, 0 TA, 101 DA> 0 Crit Rate, 25 Haste; DA dmg+31%

    -- ammo="Coiste Bodhar",              -- [__/__, ___]  3 <__, __,  3> __, __
    -- head="Hjarrandi Helm",             -- [10/10,  53]  7 <__, __,  6> __, __
    -- body="Boii Lorica +3",             -- [14/14, 109] 11 <__, __, __> __,  3
    -- hands="Sakpata's Gauntlets",       -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    -- legs=gear.Odyssean_STP_legs,       -- [__/__,  86] 13 <__, __,  2> __,  5
    -- feet="Pummeler's Calligae +3",     -- [__/__, 100]  4 <__, __,  9> __,  4
    -- neck="Warrior's Bead Necklace +2", -- [__/__, ___] __ <__, __,  7> __, __
    -- ear1="Schere Earring",             -- [__/__, ___]  5 <__, __,  6> __, __
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9> __, __
    -- ring1="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- ring2="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- back=gear.WAR_STR_DA_Cape,         -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    -- waist="Ioskeha Belt +1",           -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [52 PDT/42 MDT, 460 MEVA] 61 STP <0 QA, 0 TA, 100 DA> 0 Crit Rate, 24 Haste; DA dmg+31%
  }
  sets.engaged.TwoHanded.LowAcc = set_combine(sets.engaged.TwoHanded, {})
  sets.engaged.TwoHanded.MidAcc = set_combine(sets.engaged.TwoHanded.LowAcc, {})
  sets.engaged.TwoHanded.HighAcc = set_combine(sets.engaged.TwoHanded.MidAcc, {})

  -- Focus white damage
  sets.engaged.UkonvasaraAM = {
    ammo="Coiste Bodhar",                 -- [__/__, ___]  3 <__, __,  3> __, __
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ <__, __,  5> __,  4; DA dmg +15%
    body="Boii Lorica +2",                -- [13/13,  99] 10 <__, __, __> __,  3
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Agoge Cuisses +3",              -- [__/__, 100] __ <__, __,  6> __,  6; DA dmg+11%
    feet="Pummeler's Calligae +3",        -- [__/__, 100]  4 <__, __,  9> __,  4
    neck="Warrior's Bead Necklace +1",    -- [__/__, ___] __ <__, __,  6> __, __
    ear1="Schere Earring",                -- [__/__, ___]  5 <__, __,  6> __, __
    ear2="Boii Earring",                  -- [__/__, ___] __ <__, __,  7> __, __
    ring1="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [48 PDT/38 MDT, 534 MEVA] 40 STP <0 QA, 0 TA, 100 DA> 0 Crit Rate, 29 Haste; DA dmg+46%

    -- body="Boii Lorica +3",             -- [14/14, 109] 11 <__, __, __> __,  3
    -- neck="Warrior's Bead Necklace +2", -- [__/__, ___] __ <__, __,  7> __, __
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9> __, __
    -- [49 PDT/39 MDT, 544 MEVA] 41 STP <0 QA, 0 TA, 103 DA> 0 Crit Rate, 29 Haste; DA dmg+46%
  }
  sets.engaged.UkonvasaraAM.LowAcc = set_combine(sets.engaged.UkonvasaraAM, {})
  sets.engaged.UkonvasaraAM.MidAcc = set_combine(sets.engaged.UkonvasaraAM.LowAcc, {})
  sets.engaged.UkonvasaraAM.HighAcc = set_combine(sets.engaged.UkonvasaraAM.MidAcc, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = {
    ammo="Coiste Bodhar",                 -- [__/__, ___]  3 <__, __,  3> __, __
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ <__, __,  5> __,  4; DA dmg +15%
    body="Hjarrandi Breastplate",         -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Tatenashi Haidate +1",          -- [__/__,  80]  8 <__,  3, __> __,  5
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ <__, __,  4> __,  2
    neck="Warrior's Bead Necklace +1",    -- [__/__, ___] __ <__, __,  6> __, __
    ear1="Dedition Earring",              -- [__/__, ___]  8 <__, __, __> __, __
    ear2="Telos Earring",                 -- [__/__, ___]  5 <__, __,  1> __, __
    ring1="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [53 PDT/43 MDT, 534 MEVA] 52 STP <0 QA, 3 TA, 77 DA> 13 Crit Rate, 23 Haste; DA dmg+35%

    -- body="Boii Lorica +3",             -- [14/14, 109] 11 <__, __, __> __,  3
    -- legs=gear.Odyssean_STP_legs,       -- [__/__,  86] 13 <__, __,  2> __,  5
    -- neck="Ainia Collar",               -- [__/__, ___]  8 <__, __, __> __, __
    -- ear2="Schere Earring",             -- [__/__, ___]  5 <__, __,  6> __, __; R30
    -- ring1="Epona's Ring",              -- [__/__, ___] __ <__,  3,  3> __, __
    -- back=gear.WAR_STP_Cape,            -- [10/__, ___] 10 <__, __, __> __, __; DA dmg+20%
    -- [50 PDT/40 MDT, 580 MEVA] 71 STP <0 QA, 3 TA, 71 DA> 0 Crit Rate, 26 Haste; DA dmg+35%
  }
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LightDef, {})
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.LightDef, {})
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.LightDef, {})

  -- Focus capped DA > STP
  sets.engaged.TwoHanded.LightDef = {
    ammo="Coiste Bodhar",                 -- [__/__, ___]  3 <__, __,  3> __, __
    head="Hjarrandi Helm",                -- [10/10,  53]  7 <__, __,  6> __, __
    body="Boii Lorica +2",                -- [13/13,  99] 10 <__, __, __> __,  3
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Agoge Cuisses +3",              -- [__/__, 100] __ <__, __,  6> __,  6; DA dmg+11%
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ <__, __,  4> __,  2
    neck="Warrior's Bead Necklace +1",    -- [__/__, ___] __ <__, __,  6> __, __
    ear1="Schere Earring",                -- [__/__, ___]  5 <__, __,  6> __, __
    ear2="Boii Earring",                  -- [__/__, ___] __ <__, __,  7> __, __
    ring1="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Chirich Ring +1",              -- [__/__, ___]  6 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [52 PDT/42 MDT, 514 MEVA] 44 STP <0 QA, 0 TA, 96 DA> 0 Crit Rate, 23 Haste; DA dmg+31%
    
    -- body="Boii Lorica +3",             -- [14/14, 109] 11 <__, __, __> __,  3
    -- feet="Pummeler's Calligae +3",     -- [__/__, 100]  4 <__, __,  9> __,  4
    -- ring2="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- [52 PDT/42 MDT, 474 MEVA] 48 STP <0 QA, 0 TA, 101 DA> 0 Crit Rate, 25 Haste; DA dmg+31%

    -- ammo="Coiste Bodhar",              -- [__/__, ___]  3 <__, __,  3> __, __
    -- head="Sakpata's Helm",             -- [ 7/ 7, 123] __ <__, __,  5> __,  4; DA dmg +15%
    -- body="Sakpata's Breastplate",      -- [10/10, 139] __ <__, __,  8> __,  2
    -- hands="Sakpata's Gauntlets",       -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    -- legs=gear.Odyssean_STP_legs,       -- [__/__,  86] 13 <__, __,  2> __,  5
    -- feet="Sakpata's Leggings",         -- [ 6/ 6, 150] __ <__, __,  4> __,  2
    -- neck="Warrior's Bead Necklace +2", -- [__/__, ___] __ <__, __,  7> __, __
    -- ear1="Schere Earring",             -- [__/__, ___]  5 <__, __,  6> __, __
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9> __, __
    -- ring1="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- ring2="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- back=gear.WAR_STR_DA_Cape,         -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    -- waist="Ioskeha Belt +1",           -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [51 PDT/41 MDT, 610 MEVA] 39 STP <0 QA, 0 TA, 102 DA> 0 Crit Rate, 25 Haste; DA dmg+35%
  }
  sets.engaged.TwoHanded.LowAcc.LightDef = set_combine(sets.engaged.TwoHanded.LightDef, {
  })
  sets.engaged.TwoHanded.MidAcc.LightDef = set_combine(sets.engaged.TwoHanded.LightDef, {
  })
  sets.engaged.TwoHanded.HighAcc.LightDef = set_combine(sets.engaged.TwoHanded.LightDef, {
  })

  sets.engaged.UkonvasaraAM.LightDef = {
    ammo="Coiste Bodhar",                 -- [__/__, ___]  3 <__, __,  3> __, __
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ <__, __,  5> __,  4; DA dmg +15%
    body="Sakpata's Breastplate",         -- [10/10, 139] __ <__, __,  8> __,  2
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    legs="Agoge Cuisses +3",              -- [__/__, 100] __ <__, __,  6> __,  6; DA dmg+11%
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ <__, __,  4> __,  2
    neck="Warrior's Bead Necklace +1",    -- [__/__, ___] __ <__, __,  6> __, __
    ear1="Schere Earring",                -- [__/__, ___]  5 <__, __,  6> __, __
    ear2="Boii Earring",                  -- [__/__, ___] __ <__, __,  7> __, __
    ring1="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",               -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [51 PDT/41 MDT, 624 MEVA] 26 STP <0 QA, 0 TA, 103 DA> 0 Crit Rate, 26 Haste; DA dmg+46%

    -- ammo="Yetshila +1",                -- [__/__, ___] __ <__, __, __>  2, __
    -- neck="Warrior's Bead Necklace +2", -- [__/__, ___] __ <__, __,  7> __, __
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9>  8, __
    -- [51 PDT/41 MDT, 624 MEVA] 23 STP <0 QA, 0 TA, 103 DA> 10 Crit Rate, 26 Haste; DA dmg+44%
    
    -- ammo="Yetshila +1",                -- [__/__, ___] __ <__, __, __>  2, __
    -- head="Sakpata's Helm",             -- [ 7/ 7, 123] __ <__, __,  5> __,  4; DA dmg +15%
    -- body="Sakpata's Breastplate",      -- [10/10, 139] __ <__, __,  8> __,  2
    -- hands="Sakpata's Gauntlets",       -- [ 8/ 8, 112]  8 <__, __,  6> __,  4
    -- legs=gear.Odyssean_STP_legs,       -- [__/__,  86] 13 <__, __,  2> __,  5
    -- feet="Sakpata's Leggings",         -- [ 6/ 6, 150] __ <__, __,  4> __,  2
    -- neck="Warrior's Bead Necklace +2", -- [__/__, ___] __ <__, __,  7> __, __
    -- ear1="Schere Earring",             -- [__/__, ___]  5 <__, __,  6> __, __
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9>  8, __
    -- ring1="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- ring2="Moonlight Ring",            -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- back=gear.WAR_STR_DA_Cape,         -- [10/__, ___] __ <__, __, 10> __, __; DA dmg+20%
    -- waist="Ioskeha Belt +1",           -- [__/__, ___] __ <__, __,  9> __,  8
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __
    -- [51 PDT/41 MDT, 610 MEVA] 36 STP <0 QA, 0 TA, 99 DA> 10 Crit Rate, 25 Haste; DA dmg+35%
  }
  sets.engaged.UkonvasaraAM.LowAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })
  sets.engaged.UkonvasaraAM.MidAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })
  sets.engaged.UkonvasaraAM.HighAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })

  sets.engaged.SubtleBlow = {
    ammo="Seething Bomblet +1",           -- [__/__, ___] __ <__, __, __> __,  5, __(__)
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ <__, __,  5> __,  4, __(__); DA dmg +15%
    body="Dagon Breastplate",             -- [__/__,  86] __ <__,  5, __>  4,  1, __(10)
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 <__, __,  6> __,  4,  8(__)
    legs="Sakpata's Cuisses",             -- [ 9/ 9, 150] __ <__, __,  7> __,  4, __(__)
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ <__, __,  4> __,  2, 13(__)
    neck="Loricate Torque +1",            -- [ 6/ 6, ___] __ <__, __, __> __, __, __(__)
    ear1="Schere Earring",                -- [__/__, ___]  5 <__, __,  6> __, __,  3(__)
    ear2="Boii Earring",                  -- [__/__, ___] __ <__, __,  7> __, __,  5(__)
    ring1="Chirich Ring +1",              -- [__/__, ___]  6 <__, __, __> __, __, 10(__)
    ring2="Niqmaddu Ring",                -- [__/__, ___] __ < 3, __, __> __, __, __( 5)
    back=gear.WAR_STR_DA_Cape,            -- [10/__, ___] __ <__, __, 10> __, __, __(__); DA dmg+20%
    waist="Ioskeha Belt +1",              -- [__/__, ___] __ <__, __,  9> __,  8, __(__)
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __, __(__)
    -- [46 PDT/36 MDT, 621 MEVA] 19 STP <3 QA, 5 TA, 87 DA> 4 Crit Rate, 28 Haste, 39(15) Subtle Blow; DA dmg+35%

    -- ammo="Seething Bomblet +1",        -- [__/__, ___] __ <__, __, __> __,  5, __(__)
    -- head="Sakpata's Helm",             -- [ 7/ 7, 123] __ <__, __,  5> __,  4, __(__); DA dmg +15%
    -- body="Dagon Breastplate",          -- [__/__,  86] __ <__,  5, __>  4,  1, __(10)
    -- hands="Sakpata's Gauntlets",       -- [ 8/ 8, 112]  8 <__, __,  6> __,  4,  8(__)
    -- legs="Volte Tights",               -- [__/__, 107]  8 <__, __, __> __,  9,  8(__)
    -- feet="Sakpata's Leggings",         -- [ 6/ 6, 150] __ <__, __,  4> __,  2, 13(__)
    -- neck="Loricate Torque +1",         -- [ 6/ 6, ___] __ <__, __, __> __, __, __(__)
    -- ear1="Schere Earring",             -- [__/__, ___]  5 <__, __,  6> __, __,  3(__)
    -- ear2="Boii Earring +2",            -- [__/__, ___] __ <__, __,  9>  8, __,  7(__)
    -- ring1="Defending Ring",            -- [10/10, ___] __ <__, __, __> __, __, __(__)
    -- ring2="Niqmaddu Ring",             -- [__/__, ___] __ < 3, __, __> __, __, __( 5)
    -- back=gear.WAR_STP_Cape,            -- [10/__, ___] 10 <__, __, __> __, __, __(__); DA dmg+20%
    -- waist="Peiste Belt +1",            -- [__/__, ___] __ <__, __, __> __, __, 10(__)
    -- WAR Traits                            [__/__, ___] __ <__, __, 33> __, __, __(__)
    -- [47 PDT/37 MDT, 578 MEVA] 31 STP <3 QA, 5 TA, 63 DA> 12 Crit Rate, 25 Haste, 49(15) Subtle Blow; DA dmg+35%
  }
  sets.engaged.LowAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.MidAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.HighAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})

  -----------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.Sleepyhead = { head="Frenzy Sallet", }
  sets.Special.LowEnmity = { ear2="Novia Earring", } -- Assumes -Enmity merits and Dirge
  sets.Special.Schere = { ear2="Schere Earring", }

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.Kiting = {
    feet="Hermes' Sandals",
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
    ammo="Perfect Lucky Egg", --1
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = {
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Ukon'] = {
    -- main="Ukonvasara",
    sub="Utu Grip",
  }
  sets.WeaponSet['Chango'] = {
    main="Chango",
    sub="Utu Grip",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Ternion Dagger +1",
    -- sub="Sangarius +1",
  }
  sets.WeaponSet['Shining One'] = {
    main="Shining One",
    sub="Utu Grip",
  }
  sets.WeaponSet['Club'] = {
    main="Loxotic Mace +1",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Club'].DW = {
    main="Loxotic Mace +1",
    sub="Ternion Dagger +1",
    -- sub="Sangarius +1",
  }
  sets.WeaponSet['Dagger'] = {
    main="Malevolence",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Dagger'].DW = {
    main="Malevolence",
    sub="Malevolence",
  }
  sets.WeaponSet['Magic Axe'] = {
    -- main="Farsha",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Magic Axe'].DW = {
    -- main="Farsha",
    sub="Malevolence",
  }
  sets.WeaponSet['Phys Axe'] = {
    -- main="Dolichenus",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Phys Axe'].DW = {
    -- main="Dolichenus",
    -- sub="Sangarius +1",
  }
  sets.WeaponSet['Great Sword'] = {
    -- main="Montante +1",
    sub="Utu Grip",
  }
  sets.WeaponSet['Staff'] = {
    main="Xoanon",
    sub="Utu Grip",
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    -- Don't gearswap for weaponskills when Defense is on.
    if state.DefenseMode.current ~= 'None' then
      eventArgs.handled = true
    elseif buffactive['Sekkanoki'] then
      equip(sets.precast.JA['Sekkanoki'])
    end
  end

  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    -- Handle belts for elemental WS
    if elemental_ws:contains(spell.english) then
      local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
      local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
      local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)
      local has_obi = true -- Change if you do or don't have Hachirin-no-Obi
      local has_orpheus = false -- Change if you do or don't have Orpheus's Sash
  
      -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
      if has_obi and (obi_mult >= orpheus_mult or not has_orpheus) and (obi_mult > base_day_weather_mult) then
        -- Obi is better than orpheus and better than nothing
        equip({waist="Hachirin-no-Obi"})
      elseif has_orpheus and (orpheus_mult > base_day_weather_mult) then
        -- Orpheus is better than obi and better than nothing
        equip({waist="Orpheus's Sash"})
      end
    end

    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end

    if state.EnmityMode.current == 'Low' then
      equip(sets.Special.LowEnmity)
    elseif state.EnmityMode.current == 'Schere' and player.mp > 0 then
      equip(sets.Special.Schere)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.english == 'Warcry' and not spell.interrupted then
    warcry_self = true
  end

  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
  classes.CustomMeleeGroups:clear()

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.Sleepyhead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "doom" then
    status_change(player.status)
  end

  if buff == "Aftermath: Lv.3" then
    if gain then
        send_command('timers create "Aftermath Tier III" 180 down')
        send_command('input /echo Tier III Aftermath!!!')
    else
        send_command('timers delete "Aftermath Tier III";gs c -cd AM3 Lost!!!')
        send_command('input /echo Tier III Aftermath OFF!!!')
    end
  end
  if buff == "Aftermath: Lv.2" then
      if gain then
          send_command('timers create "Aftermath Tier II" 120 down')
          send_command('input /echo Tier II Aftermath!!')
      else
          send_command('timers delete "Aftermath Tier II";gs c -cd AM3 Lost!!!')
      end
  end
  if buff == "Aftermath: Lv.1" then
      if gain then
          send_command('timers create "Aftermath Tier I" 60 down')
          send_command('input /echo Tier I Aftermath!')
      else
          send_command('timers delete "Aftermath Tier I";gs c -cd AM3 Lost!!!')
      end
  end

  if buff == 'Warcry' and not gain and warcry_self then
    warcry_self = false
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
  update_combat_form()
end

function update_combat_form()
  if not use_dw_if_available or silibs.get_dual_wield_needed() <= 0 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
  else
    if silibs.get_dual_wield_needed() > 0 and silibs.get_dual_wield_needed() <= 6 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 6 and silibs.get_dual_wield_needed() <= 13 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 13 and silibs.get_dual_wield_needed() <= 26 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 26 and silibs.get_dual_wield_needed() <= 37 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 37 then
      state.CombatForm:set('MaxDW')
    end
  end
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

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
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if sets.WeaponSet[state.WeaponSet.current] then
      if use_dw_if_available and silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current].DW then
        return sets.WeaponSet[state.WeaponSet.current].DW
      else
        return sets.WeaponSet[state.WeaponSet.current]
      end
    end
  end
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
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
  equip(select_weapons())
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'
  end

  -- Calculate if need TP bonus
  local buffer = 100
  -- Start TP bonus at 0 and accumulate based on equipped gear
  local tp_bonus_from_weapons = 0
  for slot,gear in pairs(tp_bonus_weapons) do
    local equipped_item = player.equipment[slot]
    if equipped_item and gear[equipped_item] then
      tp_bonus_from_weapons = tp_bonus_from_weapons + gear[equipped_item]
    end
  end
  local buff_bonus = T{
    warcry_self and 700 or 0,
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  local trait_bonus = T{
    calc_fencer_tp_bonus()
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-trait_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in defensive mode put on move speed gear
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

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if state.EnmityMode.current == 'Low' then
    equip(sets.Special.LowEnmity)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.Special.Sleepyhead)
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

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.Special.Sleepyhead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function user_customize_idle_set(idleSet)
  -- Any non-silibs modifications should go in customize_idle_set function
  return silibs.customize_idle_set(idleSet)
end

function user_customize_melee_set(meleeSet)
  -- Any non-silibs modifications should go in customize_melee_set function
  return silibs.customize_melee_set(meleeSet)
end

function user_customize_defense_set(defenseSet)
  -- Any non-silibs modifications should go in customize_defense_set function
  return silibs.customize_defense_set(defenseSet)
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

function update_melee_groups()
  if player then
    classes.CustomMeleeGroups:clear()

    if state.Buff['Brazen Rush'] or state.Buff["Warrior's Charge"] then
      classes.CustomMeleeGroups:append('Charge')
    end

    if state.Buff['Mighty Strikes'] then
      classes.CustomMeleeGroups:append('Mighty')
    end

    for weapon,am_list in pairs(activate_AM_mode) do
      if player.equipment.main == weapon or player.equipment.ranged == weapon then
        for am_level,_ in pairs(am_list) do
          if buffactive[am_level] then
            classes.CustomMeleeGroups:append(weapon..'AM')
          end
        end
      end
    end

    -- If no AM melee group, check for 2 handed weapon
    if player and player.equipment and player.equipment.main and player.equipment.main ~= 'empty' then
      if not classes.CustomMeleeGroups:map(function(group)
            return group:slice(#group-2)
          end):contains('AM') then
        local main_weapon_skill = res.items:with('en', player.equipment.main).skill
        if skill_ids_2h:contains(main_weapon_skill) then
          classes.CustomMeleeGroups:append('TwoHanded')
        end
      end
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1] == 'test' then
    test()
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
  -- Default macro set/book: (set, book)
  set_macro_page(2, 14)
end

-- Calculate Fencer tier. Fencer active if not two-handed weapon, and offhand is empty or shield.
function calc_fencer_tier()
  local fencer = 0
  if not classes.CustomMeleeGroups:contains('TwoHanded') then
    if player.equipment.sub == 'empty' then
      fencer = 5
    else
      local is_using_shield = res.items:with('en', player.equipment.sub).category == 'Armor'
      if is_using_shield then
        fencer = 5
        if player.equipment.sub == 'Blurred Shield +1' then
          fencer = fencer + 1
        end
      end
    end
  end
  if fencer > 0 then
    -- Can also assume any single handed ws will use JSE neck for another fencer+1
    fencer = fencer + 1
  end
  -- Fencer caps at level 8
  return math.min(fencer, 8)
end

function calc_fencer_tp_bonus()
  local total_fencer_tp_bonus = 0
  local fencer_tier = calc_fencer_tier()
  if fencer_tier > 0 then
    -- Add Fencer TP bonus based on base trait
    total_fencer_tp_bonus = fencer_tp_bonus[fencer_tier]
    -- Add TP Bonus based on JP gifts
    local jp_spent = player.job_points.war.jp_spent
    if jp_spent >= 1805 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 230
    elseif jp_spent >= 980 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 160
    elseif jp_spent >= 405 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 100
    elseif jp_spent >= 80 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 50
    end
  end
  return total_fencer_tp_bonus
end

function test()
end
