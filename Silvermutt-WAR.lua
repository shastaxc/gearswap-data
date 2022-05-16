-- Author: Silvermutt

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
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(1)
  silibs.enable_premade_commands()
  silibs.enable_th()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('LightDef', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')

  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger','Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Ukon', 'Naegling', 'Shining One', 'Dagger', 'Staff'}
  -- state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Ukon', 'Naegling', 'Shining One', 'Farsha', 'DW Axe', 'Dagger', 'Great Sword', 'Club', 'Staff'}
  state.EnmityMode = M{['description']='Enmity Mode', 'Normal', 'Low', 'Schere'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !e input /ja "Hasso" <me>')
  send_command('bind !q input /ja "Meditate" <me>')
  
  activate_AM_mode = {
    ["Conqueror"] = S{"Aftermath: Lv.3"},
    ["Bravura"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ragnarok"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Farsha"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ukonvasara"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
  }
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

  update_combat_form()
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
    back=gear.WAR_Crit_Cape,
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
    back="Cichol's Mantle",
    -- body="Pummeler's Lorica +3",
    -- feet="Agoge Calligae +3",
  }
	sets.precast.JA['Warcry'] = {
    -- head="Agoge Mask +3",
  }
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {}
	sets.precast.JA['Mighty Strikes'] = {}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = {
    -- ammo="Throwing Tomahawk",
    -- feet="Agoge Calligae +3",
  }
	sets.precast.JA['Retaliation'] = {
    -- feet="Boii Calligae +1",
  }
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {
    -- body="Boii Lorica +1",
    -- feet="Boii Calligae +1",
  }
	sets.precast.JA['Brazen Rush'] = {}
  sets.precast.JA['Provoke'] = sets.Enmity

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
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",           -- 10, __, 20, __, __, __, ___
    ring2="Epaminondas's Ring",   -- __, __, __, __,  5, __, ___
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- body="Pummeler's Lorica +3",
    -- neck="Warrior's Bead Necklace +2",
    -- ring1="Sroda Ring",
  } -- ? STR, ? MND, ? Attack, ? Accuracy, ? WSD, ? PDL, ? TP Bonus
  sets.precast.WS.MaxTP = sets.precast.WS
  sets.precast.WS.AttCapped = sets.precast.WS
  sets.precast.WS.AttCappedMaxTP = sets.precast.WS.MaxTP

  sets.precast.WS["Savage Blade"] = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands="Sakpata's Gauntlets",
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",           -- 10, __, 20, __, __, __, ___
    ring2="Epaminondas's Ring",   -- __, __, __, __,  5, __, ___
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- neck="Warrior's Bead Necklace +2",
    -- ring1="Sroda Ring",
  } -- ? STR, ? MND, ? Attack, ? Accuracy, ? WSD, ? PDL, ? TP Bonus
  sets.precast.WS["Savage Blade"].MaxTP = set_combine(sets.precast.WS["Savage Blade"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Savage Blade"].AttCapped = set_combine(sets.precast.WS["Savage Blade"], {})
  sets.precast.WS["Savage Blade"].AttCappedMaxTP = set_combine(sets.precast.WS["Savage Blade"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    body="Sakpata's Plate",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Gelatinous Ring +1",
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- neck="Warrior's Bead Necklace +2",
    -- back=gear.WAR_VIT_WSD_Cape,
	})
  sets.precast.WS["Upheaval"].MaxTP = set_combine(sets.precast.WS["Upheaval"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Upheaval"].AttCapped = set_combine(sets.precast.WS["Upheaval"], {
    ammo="Knobkierrie",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Gelatinous Ring +1",
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- body="Pummeler's Lorica +3",
    -- neck="Warrior's Bead Necklace +2",
    -- back=gear.WAR_VIT_WSD_Cape,
  })
  sets.precast.WS["Upheaval"].AttCappedMaxTP = set_combine(sets.precast.WS["Upheaval"].AttCapped, {
    ear2="Ishvara Earring",
  })
  
  sets.precast.WS["Resolution"] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
    -- ammo="Seething Bomblet +1",
  })
  sets.precast.WS["Resolution"].MaxTP = set_combine(sets.precast.WS["Resolution"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Resolution"].AttCapped = set_combine(sets.precast.WS["Resolution"], {
  })
  sets.precast.WS["Resolution"].AttCappedMaxTP = set_combine(sets.precast.WS["Resolution"].AttCapped, {
    ear2="Ishvara Earring",
  })
  
  sets.precast.WS['Armor Break'] =  set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
    -- ammo="Seething Bomblet +1",
  })
  sets.precast.WS["Armor Break"].MaxTP = set_combine(sets.precast.WS["Armor Break"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Armor Break"].AttCapped = set_combine(sets.precast.WS["Armor Break"], {
  })
  sets.precast.WS["Armor Break"].AttCappedMaxTP = set_combine(sets.precast.WS["Armor Break"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS['Full Break'] =  set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
    -- ammo="Seething Bomblet +1",
  })
  sets.precast.WS["Full Break"].MaxTP = set_combine(sets.precast.WS["Full Break"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Full Break"].AttCapped = set_combine(sets.precast.WS["Full Break"], {
  })
  sets.precast.WS["Full Break"].AttCappedMaxTP = set_combine(sets.precast.WS["Full Break"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS['Decimation'] =  set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Brutal Earring",
    ear2="Schere Earring",
    ring2="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
    -- ammo="Seething Bomblet +1",
    -- neck="Warrior's Bead Necklace +2",
    -- ring1="Sroda Ring",
  })
  sets.precast.WS["Decimation"].MaxTP = set_combine(sets.precast.WS["Decimation"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Decimation"].AttCapped = set_combine(sets.precast.WS["Decimation"], {
  })
  sets.precast.WS["Decimation"].AttCappedMaxTP = set_combine(sets.precast.WS["Decimation"].AttCapped, {
    ear2="Ishvara Earring",
  })

	sets.precast.WS['Calamity'] =  set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    hands=gear.Nyame_B_hands,
    legs="Sakpata's Cuisses",
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring2="Epaminondas's Ring",
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- body="Pummeler's Lorica +3",
    -- neck="Warrior's Bead Necklace +2",
    -- ring1="Sroda Ring",
  })
  sets.precast.WS["Calamity"].MaxTP = set_combine(sets.precast.WS["Calamity"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Calamity"].AttCapped = set_combine(sets.precast.WS["Calamity"], {
  })
  sets.precast.WS["Calamity"].AttCappedMaxTP = set_combine(sets.precast.WS["Calamity"].AttCapped, {
    ear2="Ishvara Earring",
  })
  
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Baetyl pendant",
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    ring2="Regal Ring",
    back=gear.WAR_STR_WSD_Cape,
    waist="Eschan Stone",
    -- ring1="Beithir Ring",
    -- back=gear.WAR_MND_WSD_Cape,
  })
  sets.precast.WS['Cloudsplitter'].MaxTP = set_combine(sets.precast.WS['Cloudsplitter'], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Cloudsplitter"].AttCapped = set_combine(sets.precast.WS["Cloudsplitter"], {
  })
  sets.precast.WS["Cloudsplitter"].AttCappedMaxTP = set_combine(sets.precast.WS["Cloudsplitter"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    neck="Warrior's Bead Necklace +1",
    ear1="Schere Earring",
    ring1="Niqmaddu Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Sailfi Belt +1",
    -- head="Blistering Sallet +1",
    -- feet="Boii Calligae +1",
    -- neck="Warrior's Bead Necklace +2",
    -- ear2="Lugra Earring +1",
    -- ring2="Sroda Ring",
  })
  sets.precast.WS["Ukko's Fury"].MaxTP = set_combine(sets.precast.WS["Ukko's Fury"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Ukko's Fury"].AttCapped = {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Schere Earring",
    ring1="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Sailfi Belt +1",
    -- neck="Warrior's Bead Necklace +2",
    -- ear2="Lugra Earring +1",
    -- ring2="Sroda Ring",
  }
  sets.precast.WS["Ukko's Fury"].AttCappedMaxTP = set_combine(sets.precast.WS["Ukko's Fury"].AttCapped, {
    ear2="Ishvara Earring",
  })
  
  -- Polearm sets use a crit build since you should be using Shining One
  -- Impulse Drive - 100% STR
  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=gear.WAR_Crit_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- body="Pummeler's Lorica +3",
    -- neck="Warrior's Bead Necklace +2",
  })
  sets.precast.WS["Impulse Drive"].MaxTP = set_combine(sets.precast.WS["Impulse Drive"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Impulse Drive"].AttCapped = set_combine(sets.precast.WS["Impulse Drive"], {
  })
  sets.precast.WS["Impulse Drive"].AttCappedMaxTP = set_combine(sets.precast.WS["Impulse Drive"].AttCapped, {
    ear2="Ishvara Earring",
  })

  -- Stardiver - 85% STR
  sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Regal Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
    -- ammo="Seething Bomblet +1",
  })
  sets.precast.WS["Stardiver"].MaxTP = set_combine(sets.precast.WS["Stardiver"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Stardiver"].AttCapped = set_combine(sets.precast.WS["Stardiver"], {
  })
  sets.precast.WS["Stardiver"].AttCappedMaxTP = set_combine(sets.precast.WS["Stardiver"].AttCapped, {
    ear2="Ishvara Earring",
  })

  -- Sonic Thrust - 40% STR / 40% DEX
  sets.precast.WS["Sonic Thrust"] = sets.precast.WS["Impulse Drive"]
  sets.precast.WS["Sonic Thrust"].MaxTP = sets.precast.WS["Impulse Drive"].MaxTP
  sets.precast.WS["Sonic Thrust"].AttCapped = sets.precast.WS["Impulse Drive"].AttCapped
  sets.precast.WS["Sonic Thrust"].AttCappedMaxTP = sets.precast.WS["Impulse Drive"].AttCappedMaxTP

	sets.precast.WS['Cataclysm'] = sets.precast.WS['Cloudsplitter']
	sets.precast.WS['Cataclysm'].MaxTP = sets.precast.WS['Cloudsplitter'].MaxTP
	sets.precast.WS['Cataclysm'].AttCapped = sets.precast.WS['Cloudsplitter'].AttCapped
	sets.precast.WS['Cataclysm'].AttCappedMaxTP = sets.precast.WS['Cloudsplitter'].AttCappedMaxTP

	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Cloudsplitter']
	sets.precast.WS['Aeolian Edge'].MaxTP = sets.precast.WS['Cloudsplitter'].MaxTP
	sets.precast.WS['Aeolian Edge'].AttCapped = sets.precast.WS['Cloudsplitter'].AttCapped
	sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = sets.precast.WS['Cloudsplitter'].AttCappedMaxTP

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Moonshade earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu Ring",
    ring2="Gere Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Fotia Belt",
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Asuran Fists"].AttCapped = set_combine(sets.precast.WS["Asuran Fists"], {
  })
  sets.precast.WS["Asuran Fists"].AttCappedMaxTP = set_combine(sets.precast.WS["Asuran Fists"].AttCapped, {
    ear2="Ishvara Earring",
  })

	sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Warrior's Bead Necklace +1",
    ear2="Moonshade Earring",
    ring2="Epaminondas's Ring",
    back=gear.WAR_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    -- head="Agoge Mask +3",
    -- neck="Warrior's Bead Necklace +2",
    -- ear1="Lugra Earring +1",
    -- ring1="Sroda Ring",
  })
  sets.precast.WS["Spiral Hell"].MaxTP = set_combine(sets.precast.WS["Spiral Hell"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Spiral Hell"].AttCapped = set_combine(sets.precast.WS["Spiral Hell"], {
  })
  sets.precast.WS["Spiral Hell"].AttCappedMaxTP = set_combine(sets.precast.WS["Spiral Hell"].AttCapped, {
    ear2="Ishvara Earring",
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
    body="Sakpata's Plate",
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
  sets.defense.MDT = sets.defense.PDT

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

  sets.idle = sets.defense.PDT

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

  sets.idle.HeavyDef = sets.defense.PDT

  sets.idle.Weak = sets.defense.PDT


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",             -- [__/__, ___] __,  3 <__, __,  3> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53] __,  6 <__,  5, __> __,  4
    body="Dagon Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Tatenashi Haidate +1",      -- [__/__,  80] __,  8 <__,  3, __> __,  5
    feet="Tatenashi Sune-ate +1",
    neck="Vim Torque +1",
    ear1="Schere Earring",
    ear2="Brutal Earring",
    ring1="Moonlight Ring",
    ring2="Moonlight Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
  } -- [? PDT/? MDT, ? MEVA] ? Hasso, ? STP <? QA, ? TA, ? DA> ? Crit Rate, ? Haste
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Dignitary's Earring",
    ear2="Telos Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- ammo="Seething Bomblet +1",
    -- body="Pummeler's Lorica +3",
    -- neck="Warrior's Bead Necklace +2",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ammo="Aurgelmir Orb",
    head="Flamma Zucchetto +2",
    legs="Sulevia's Cuisses +2",
    feet="Flamma Gambieras +2",
    neck="Warrior's Bead Necklace +1",
    ear1="Dignitary's Earring",
    ear2="Telos Earring",
    ring1="Flamma Ring",
    ring2="Niqmaddu Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- neck="Warrior's Bead Necklace +2",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- ring2="Ramuh Ring +1",
  })

  -- For Ukon AM
	sets.engaged.UkonvasaraAM = {
    ammo="Coiste Bodhar",
    head="Flamma Zucchetto +2",
    body="Dagon Breastplate",
    legs="Tatenashi Haidate +1",
    feet="Tatenashi Sune. +1",
    neck="Vim Torque +1",
    ear1="Telos Earring",
    ear2="Dedition Earring",
    ring1="Moonlight Ring",
    ring2="Moonlight Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- hands="Tatenashi Gote +1",
  }
  sets.engaged.UkonvasaraAM.LowAcc = set_combine(sets.engaged.UkonvasaraAM, {})
  sets.engaged.UkonvasaraAM.MidAcc = set_combine(sets.engaged.UkonvasaraAM.LowAcc, {})
  sets.engaged.UkonvasaraAM.HighAcc = set_combine(sets.engaged.UkonvasaraAM.MidAcc, {})

  -- This set is never used. But why need separate set for Naegling?
  sets.engaged.Naegling = {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    neck="Vim Torque +1",
    ear1="Schere Earring",
    ear2="Dedition Earring",
    ring1="Petrov Ring",
    ring2="Niqmaddu Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- feet="Pummeler's Calligae +3 ",
  }

  sets.engaged.DW = set_combine(sets.engaged,{
    ear2="Eabani Earring",
    -- back=gear.WAR_DW_Cape,
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = {
    ammo="Yetshila +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    feet="Sakpata's Leggings",
    neck="Warrior's Bead Necklace +1",
    ear1="Schere Earring",
    ear2="Brutal Earring",
    ring1="Chirich Ring +1",
    ring2="Defending Ring",           -- [10/10, ___] __ <__, __, __> __, __
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- legs="Agoge Cuisses +3",
    -- neck="Warrior's Bead Necklace +2",
    -- ring1="Sroda Ring",
  } -- [? PDT/? MDT, ? MEVA] ? STP <? QA, ? TA, ? DA> ? Crit Rate, ? Haste
  sets.engaged.LowAcc.LightDef = {
    ammo="Staunch Tathlum +1",
    body="Sakpata's Plate",
    neck="Warrior's Bead Necklace +1",
    ear1="Odnowa Earring +1",
    ear2="Telos Earring",
    ring1="Defending Ring",
    ring2="Moonlight Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- head="Hjarrandi Helm",
    -- hands="Agoge Mufflers +3",
    -- legs="Agoge Cuisses +3",
    -- feet="Pummeler's Calligae +3 ",
    -- neck="Warrior's Bead Necklace +2",
  }
  sets.engaged.MidAcc.LightDef = sets.engaged.LowAcc.LightDef
  sets.engaged.HighAcc.LightDef = sets.engaged.LowAcc.LightDef

	sets.engaged.UkonvasaraAM.LightDef = {
    ammo="Coiste Bodhar",
    head="Flamma Zucchetto +2",
    body="Dagon Breastplate",
    legs="Tatenashi Haidate +1",
    feet="Tatenashi Sune. +1",
    neck="Vim Torque +1",
    ear1="Telos Earring",
    ear2="Dedition Earring",
    ring1="Moonlight Ring",
    ring2="Moonlight Ring",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
    -- hands="Tatenashi Gote +1",
  }
	sets.engaged.UkonvasaraAM.LowAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })
	sets.engaged.UkonvasaraAM.MidAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })
	sets.engaged.UkonvasaraAM.HighAcc.LightDef = set_combine(sets.engaged.UkonvasaraAM.LightDef, {
  })

  sets.engaged.SubtleBlow = {
    ammo="Coiste Bodhar",
    head="Sakpata's Helm",
    body="Dagon Breastplate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Vim Torque +1",
    ear1="Schere Earring",
    ear2="Dignitary's Earring",
    ring1="Niqmaddu Ring",
    ring2="Chirich Ring +1",
    back=gear.WAR_STR_DA_Cape,
    waist="Ioskeha Belt +1",
  } -- [? PDT/? MDT, ? MEVA] ? STP <? QA, ? TA, ? DA> ? Crit Rate, ? Haste, ?(?) Subtle Blow
  sets.engaged.LowAcc.SubtleBlow = sets.engaged.SubtleBlow
  sets.engaged.MidAcc.SubtleBlow = sets.engaged.SubtleBlow
  sets.engaged.HighAcc.SubtleBlow = sets.engaged.SubtleBlow


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

  sets.WeaponSet = {}
  sets.WeaponSet['Chango'] = {
    main="Chango",
    sub="Utu Grip",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Shining One'] = {
    main="Shining One",
    sub="Utu Grip",
  }
	sets.WeaponSet['Farsha'] = {
    -- main="Farsha",
    sub="Blurred Shield +1",
  }
	sets.WeaponSet['DW Axe'] = {
    -- main="Dolichenus",
    sub="Blurred Shield +1",
  }
	sets.WeaponSet['Dagger'] = {
    main="Malevolence",
    sub="Blurred Shield +1",
  }
	sets.WeaponSet['DW Dagger'] = {
    main="Malevolence",
    sub="Levante Dagger",
  }
	sets.WeaponSet['Great Sword'] = {
    -- main="Montante +1",
    sub="Utu Grip",
  }
	sets.WeaponSet['Ukon'] = {
    main="Ukonvasara",
    sub="Utu Grip",
  }
	sets.WeaponSet['Club'] = {
    -- main="Loxotic Mace +1",
    sub="Blurred Shield +1",
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
  state.CombatForm:reset()
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_combat_form()
  update_melee_groups()
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

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

function test()
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

function update_combat_form()
  state.CombatForm:reset()
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

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if not midaction() then
      job_update()
    end
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
  if player.sub_job == 'SAM' then
    set_macro_page(1, 14)
  elseif player.sub_job == 'NIN' then
    set_macro_page(1, 14)
  elseif player.sub_job == 'DRG' then
    set_macro_page(1, 14)
  else
    set_macro_page(1, 14)
  end
end