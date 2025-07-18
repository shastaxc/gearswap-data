--[[
File Status: Ok. Silvermutt's COR is better.
TODO: Update bis sets to Silver's latest.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: HasteInfo, DistancePlus
Recommended addons: WSBinder, Reorganizer, Roller
Misc Recommendations: Disable GearInfo, disable RollTracker

]]--

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
    send_command('hi report')
  end, 3)
  coroutine.schedule(function()
    send_command('gs c equipweapons')
  end, 4)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(17)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)
  silibs.enable_custom_roll_timers() -- Requires Timers plugin
  -- This map will be used by SilverLibs to determine which ammo to use
  -- Default: Used most of the time. It is also the fallback option in case you don't have any of the other ammo.
  -- Accuracy: Used in high accuracy situations.
  -- Physical_Weaponskill_Ranged: Used for ranged physical weaponskills.
  -- Magic_Damage: Used when you are dealing magic damage.
  -- Magic_Accuracy: Used for Light Shot and Dark Shot.
  -- Quick_Draw: Used when performing Quick Draws (not Light or Dark). This ammo is never consumed.
  -- Physical_Weaponskill_Melee: Used for melee physical weaponskills.
  -- Magical_Weaponskill_Melee: Used for melee magical weaponskills.
  silibs.enable_handle_ammo_swaps({
    Gun_or_Cannon = {
      Default = "Chrono Bullet",
      Accuracy = "Chrono Bullet",
      Physical_Weaponskill_Ranged = "Chrono Bullet",
      Magic_Damage = "Chrono Bullet",
      Magic_Accuracy = "Chrono Bullet",
      Quick_Draw = "Hauksbok Bullet", -- Does not get consumed
      Physical_Weaponskill_Melee = "Hauksbok Bullet", -- Does not get consumed
      Magical_Weaponskill_Melee = "Hauksbok Bullet", -- Does not get consumed
    }
  })

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Safe', 'SubtleBlow', 'Normal')
  state.RangedMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.IdleMode:options('Normal', 'HeavyDef')

  state.WeaponSet = M{['description']='Weapon Set', 'Savage Blade', 'Cleaving', 'Fomalhaut_M', 'Fomalhaut_R', 'QuickDraw'}

  state.CP = M(false, 'Capacity Points Mode')

  -- QuickDraw Selector
  state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.UseAltqd = M(false, 'Use Secondary Shot')
  state.SelectqdTarget = M(false, 'Select Quick Draw Target')
  state.IgnoreTargetting = M(false, 'Ignore Targetting')
  state.QDMode = M{['description']='Quick Draw Mode', 'Potency', 'STP', 'Enhance'}
  state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
  state.CritMode = M(false, 'Crit')
  state.RollMode = M{['description']='Roll Mode', 'Adaptive', 'Always Rostam', 'Never Rostam'}

  -- Whether to use Luzaf's Ring
  state.LuzafRing = M(true, "Luzaf's Ring")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  no_swap_waists = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver", "Liv. Bul. Pouch"}

  options.ammo_warning_limit = 10

  -- Update DistancePlus addon with weapon type
  -- Corsair only uses guns for ranged weapons
  send_command('dp gun')

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['@`'] = 'gs c toggle LuzafRing',
      ['^/'] = 'gs c toggle critmode',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^\\\\'] = 'gs c cycle QDMode',
      ['^-'] = 'gs c cycleback mainqd',
      ['^='] = 'gs c cycle mainqd',
      ['!-'] = 'gs c cycleback altqd',
      ['!='] = 'gs c cycle altqd',
      ['!f8'] = 'gs c cycle RollMode',
      ['!`'] = 'input /ja "Bolter\'s Roll" <me>',
      ['!q'] = 'input /ja "Double-up" <me>',
      ['!w'] = 'input /ja "Triple Shot" <me>',
      ['!e'] = 'input /ja "Random Deal" <me>',
      ['%numpad0'] = 'input /ra <t>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['NIN'] = {
      ['!numpad0'] = 'input /ma "Utsusemi: Ichi" <me>',
      ['!numpad.'] = 'input /ma "Utsusemi: Ni" <me>',
    },
    ['DRG'] = {
      ['^numlock'] = 'input /ja "Ancient Circle" <me>',
      ['^numpad/'] = 'input /ja "Jump" <t>',
      ['^numpad*'] = 'input /ja "High Jump" <t>',
      ['^numpad-'] = 'input /ja "Super Jump" <t>',
    },
  }

  set_main_keybinds:schedule(2)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  current_dp_type = nil -- Do not modify
  locked_waist = false -- Do not modify

  -- Additional local binds
  include('Global-Binds.lua')

  select_default_macro_book()
  set_sub_keybinds:schedule(2)

  if initialized then
    send_command:schedule(1, 'gs c equipweapons')
  end
  initialized = true -- DO NOT MODIFY
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Common
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  if sets.org then
    sets.org.job = {}
    sets.org.job[1] = {ammo="Chrono Bullet"}
    sets.org.job[2] = {ammo="Hauksbok Bullet"}
  end

  sets.TreasureHunter = {
    -- body=gear.Herc_TH_body, --2
    -- hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.CP = {
    back="Mecisto. Mantle",
  }

  sets.Reive = {
    -- neck="Ygnas's Resolve +1",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet.DeathPenalty_M = {
    -- main=gear.Lanun_A,
    sub="Tauret",
    -- ranged="Death Penalty",
    -- main="Rostam",
  }
  sets.WeaponSet.DeathPenalty_R = {
    -- main=gear.Lanun_A,
    sub="Nusku Shield",
    -- ranged="Death Penalty",
    -- main="Rostam",
  }
  sets.WeaponSet.Armageddon_M = {
    -- main=gear.Lanun_A,
    sub="Tauret",
    -- main="Rostam",
    -- ranged="Armageddon",
  }
  sets.WeaponSet.Armageddon_R = {
    sub="Nusku Shield",
    -- main="Fettering Blade",
    -- ranged="Armageddon",
  }
  sets.WeaponSet.Fomalhaut_M = {
    main="Naegling",
    sub="Blurred Knife +1",
    ranged="Fomalhaut",
  }
  sets.WeaponSet.Fomalhaut_R = {
    main="Tauret",
    sub="Nusku Shield",
    ranged="Fomalhaut",
    -- main=gear.Lanun_A,
  }
  sets.WeaponSet["Savage Blade"] = {
    main="Naegling",
    sub="Blurred Knife +1",
    ranged="Anarchy +2",
  }
  sets.WeaponSet.Cleaving = {
    main="Tauret",
    sub="Blurred Knife +1",
    ranged="Anarchy +2",
    -- main=gear.Lanun_A,
    -- sub="Tauret",
  }
  sets.WeaponSet.QuickDraw = {
    main="Naegling",
    sub="Tauret",
    -- ranged="Death Penalty",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.HybridDT = {
    head="Malignance Chapeau",        --  6/ 6, 123
    body="Malignance Tabard",         --  9/ 9, 139
    hands="Malignance Gloves",        --  5/ 5, 112
    legs="Malignance Tights",         --  7/ 7, 150
    feet="Malignance Boots",          --  4/ 4, 150
    ring2="Defending Ring",           -- 10/10, ___
    -- 10 PDT from JSE cape
    -- 51 PDT / 41 MDT, 674 MEVA

    -- legs="Chasseur's Culottes +2", -- 11/11, 115; Remove feet
    -- 55 PDT / 45 MDT, 639 MEVA
  }

  sets.HeavyDef = {
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Arete Del Luna +1",   -- __/__, ___; Resists
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Chirich Ring +1",    -- __/__, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.COR_TP_Cape,      -- 10/__, ___
    waist="Carrier's Sash",     -- __/__, ___; Ele Resist+15
  } -- 60 PDT / 52 MDT, 697 MEVA

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    ring1="Chirich Ring +1",
    -- ear1="Infused Earring",
    -- ring2="Chirich Ring +1",
    -- back=gear.COR_Regen_Cape,
  }
  sets.latent_refresh = {
    legs="Rawhide Trousers",
    -- head=gear.Herc_Refresh_head,
    -- feet=gear.Herc_Refresh_feet,
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.idle = set_combine(sets.HeavyDef, {})

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

  sets.idle.HeavyDef = set_combine(sets.idle, sets.HybridDT)
  sets.idle.HeavyDef.Regain = set_combine(sets.idle.Regain, sets.HybridDT)
  sets.idle.HeavyDef.Regen = set_combine(sets.idle.Regen, sets.HybridDT)
  sets.idle.HeavyDef.Refresh = set_combine(sets.idle.Refresh, sets.HybridDT)
  sets.idle.HeavyDef.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.HybridDT)
  sets.idle.HeavyDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.HybridDT)
  sets.idle.HeavyDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.HybridDT)
  sets.idle.HeavyDef.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.HybridDT)
  sets.idle.HeavyDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.HybridDT)
  sets.idle.HeavyDef.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.HybridDT)
  sets.idle.HeavyDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.HybridDT)
  sets.idle.HeavyDef.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.HybridDT)

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    neck="Loricate Torque +1",  --  6/ 6, ___
    ring2="Gelatinous Ring +1", --  7/-1, ___
    -- back="Moonlight Cape",      --  6/ 6, ___
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Snake Eye'] = {
    legs="Lanun Trews", -- Increase chance of 0 recast; +1 is acceptable
    -- legs="Lanun Trews +3", -- Increase chance of 0 recast; +1 is acceptable
  }
  sets.precast.JA['Wild Card'] = {
    feet="Lanun Bottes", -- Reduce chance of rolling 1 or 2; +1 is acceptable
    -- feet="Lanun Bottes +3", -- Reduce chance of rolling 1 or 2; +1 is acceptable
  }
  sets.precast.JA['Random Deal'] = {
    body="Lanun Frac", -- Reduce failure chance, allow restoring 2 JAs ; +1 is acceptable
    -- body="Lanun Frac +3", -- Reduce failure chance, allow restoring 2 JAs ; +1 is acceptable
  }

  sets.precast.CorsairRoll = {
    head="Lanun Tricorne +1",       -- __/__,  36 (__, __, __); 50% chance of job align bonus
    body="Malignance Tabard",       --  9/ 9, 139 (__, __, __)
    hands="Chasseur's Gants +2",    -- __/__,  83 (__, 55, __)
    legs=gear.Nyame_B_legs,         --  8/ 8, 150 (__, __, __)
    feet=gear.Nyame_B_feet,         --  7/ 7, 150 (__, __, __)
    neck="Regal Necklace",          -- __/__, ___ ( 7, 20, __)
    ear2="Etiolation Earring",      -- __/ 3, ___ (__, __, __)
    ring1="Luzaf's Ring",           -- __/__, ___ (__, __, __); Double PR range
    ring2="Defending Ring",         -- 10/10, ___ (__, __, __)
    back=gear.COR_TP_Cape,          -- 10/__, ___ (__, 30, __)
    waist="Flume Belt +1",          --  4/__, ___ (__, __, __)
    -- 48 PDT / 37 MDT, 518 M.Eva (7 PR Potency, 105 PR Duration, 0 PR Delay)

    -- head="Lanun Tricorne +3",    -- __/__,  73 (__, __, __); 50% chance of job align bonus
    -- legs="Desultor Tassets",     -- __/__, ___ (__, __,  5); PR Delay -5
    -- ear1="Genmei Earring",       --  2/__, ___ (__, __, __)
    -- 45 PDT / 31 MDT, 445 M.Eva (7 PR Potency, 105 PR Duration, 5 PR Delay)
  }
  sets.precast.CorsairRoll.Duration = {
    -- main=gear.Rostam_C,          -- __/__, ___ ( 8, 60, __)
    -- range="Compensator",         -- __/__, ___ (__, 20, __)
    -- 45 PDT / 31 MDT, 445 M.Eva (7 PR Potency, 185 PR Duration, 5 PR Delay)
  }
  sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- legs="Chasseur's Culottes +1", -- Increase roll potency; +1 is acceptable
  })
  sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- feet="Chasseur's Bottes +1", -- Increase roll potency; +1 is acceptable
  })
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- head="Chasseur's Tricorne +1", -- Increase roll potency; +1 is acceptable
  })
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- body="Chasseur's Frac +1", -- Increase roll potency; +1 is acceptable
  })
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {
    hands="Chasseur's Gants +2", -- Increase roll potency; +1 is acceptable
  })

  sets.precast.LuzafRing = {
    ring1="Luzaf's Ring",
  }
  sets.precast.FoldDoubleBust = {
    -- hands="Lanun Gants +3", -- Add chance to clear 2 Busts; +1 is acceptable
  }

  -- Dmg is based on Gun DMG, bullet DMG, Quick Draw+ stat, elemental bonuses, MAB.
  -- Acc is based on AGI & M.Acc only.
  -- Dmg is NOT affected by M.Dmg.
  -- TP returned is affected by Store TP.
  sets.precast.CorsairShot = {
    ammo=gear.QDbullet,             -- 10, 40, __, __, __/__
    head="Ikenga's Hat",            -- 29, 45, 55,  8, __/__
    -- body="Lanun Frac +3",        -- 43, 61, 40, __,  6/__
    -- hands="Carmine Fin. Ga. +1", -- 12, 42, __,  6, __/__
    legs=gear.Nyame_B_legs,         -- 34, 30, 40, __,  8/ 8
    -- feet="Lanun Bottes +3",      -- 49, 61, 36, __,  6/__
    neck="Commodore Charm +1",      -- 12,  6, 20, __, __/__
    ear1="Friomisi Earring",        -- __, 10, __, __, __/__
    ear2="Novio Earring",           -- __,  7, __, __, __/__
    ring1="Dingir Ring",            -- 10, 10, __, __, __/__
    -- ring2="Shiva Ring +1",       -- __,  3, __, __, __/__
    back=gear.COR_RA_Cape,          -- 30, __, __, 10, 10/__
    -- waist="Eschan Stone",        -- __,  7,  7, __, __/__
    -- neck="Commodore Charm +2",   -- 15,  7, 25, __, __/__
    -- back=gear.COR_QD_Cape,       -- 30, 10, 20, __, 10/__
    -- 229 AGI, 322 MAB, 198 M.Acc, 24 STP, 30PDT/8MDT
  }

  -- Full STP; and more recast reduction
  sets.precast.CorsairShot.STP = {
    ammo=gear.MAbullet,               -- __, 35, 25, __, __/__
    body="Malignance Tabard",         -- 42, __, 50, 11,  9/ 9
    hands="Malignance Gloves",        -- 24, __, 50, 12,  5/ 5
    legs="Ikenga's Trousers",         -- 40, __, 55, 10, 10/10
    feet="Malignance Boots",          -- 49, __, 50,  9,  4/ 4
    ear1="Dedition Earring",          -- __, __, __,  8, __/__
    ear2="Cessance Earring",          -- __, __, __,  3, __/__
    ring1="Chirich Ring +1",          -- __, __, __,  6, __/__
    back=gear.COR_RA_Cape,            -- 30, __, __, 10, 10/__
    waist="Reiki Yotai",              -- __, __, __,  4, __/__
    -- 155 AGI, 35 MAB, 230 M.Acc, 63 STP, 28PDT/28MDT

    -- head="Blood Mask",             -- __, __,  3, __, __/__ Recast -5
    -- legs="Chasseur's Culottes +3", -- 43, __, 63, 12, 12/12
    -- neck="Iskur Gorget",           -- __, __, __,  8, __/__
    -- ear2="Telos Earring",          -- __, __, __,  5, __/__
    -- ring2="Crepuscular Ring",      -- __, __, 10,  6, __/__
    -- ear2="Crepuscular Earring",    -- __, __, 10,  5, __/__
    -- 188 AGI, 35 MAB, 261 M.Acc, 91 STP, 40PDT/30MDT
  }

  -- Full MAcc (to land debuff effects)
  sets.precast.CorsairShot['Light Shot'] = {
    ammo=gear.MAbullet,               -- __, 35, 25, __, __/__
    head="Malignance Chapeau",        -- 33, __, 50,  8,  6/ 6
    body="Malignance Tabard",         -- 42, __, 50, 11,  9/ 9
    hands="Malignance Gloves",        -- 24, __, 50, __, __/__
    legs="Ikenga's Trousers",         -- 40, __, 55, 10, 10/10
    feet="Malignance Boots",          -- 49, __, 50,  9,  4/ 4
    neck="Commodore Charm +1",        -- 12,  6, 20, __, __/__
    -- ear1="Hermetic Earring",       -- __,  3,  7, __, __/__
    ear2="Dignitary's Earring",       -- __, __, 10,  3, __/__
    ring1="Ephramad's Ring",          -- 10, __, __, __, __/__
    ring2="Stikini Ring +1",          -- __, __, 11, __, __/__
    back=gear.COR_WS1_Cape,           -- 30, __, 20, __, 10/__
    -- waist="K. Kachina Belt +1",    --  8, __, 20, __, __/__
    -- AF Set Effect                  -- __, __, __, __, __/__
    -- M.Acc from Quick Draw+ stat    -- __, __, __, __, __/__
    -- 248 AGI, 44 MAB, 368 M.Acc, 41 STP, 39PDT/29MDT

    -- head="Laksamana's Tricorne +3",-- 39, __, 56, __, __/__; Quick Draw+20
    -- hands="Laksamana's Gants +3",  -- 17, __, 57, __, __/__
    -- legs="Chasseur's Culottes +3", -- 43, __, 63, 12, 12/12
    -- feet="Laksamana's Bottes +3",  -- 49, __, 52, __, __/__; Quick Draw+20
    -- neck="Commodore Charm +2",     -- 15,  7, 25, __, __/__
    -- ear1="Crepuscular Earring",    -- __, __, 10,  5, __/__
    -- AF Set Effect                  -- __, __, 45, __, __/__
    -- M.Acc from Quick Draw+ stat    -- __, __, 40, __, __/__
    -- 253 AGI, 42 MAB, 484 M.Acc, 31 STP, 31PDT/21MDT
  }
  sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

  sets.precast.CorsairShot.Enhance = {
    -- head="Blood Mask", -- Recast -5
    -- feet="Chasseur's Bottes +2", -- Increase subsequent elemental damage of the same type
  }

  sets.precast.Waltz = {
    body="Passion Jacket",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    -- head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Carmine_D_feet, --8
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    -- ring1="Prolix Ring", --2
    ring2="Kishar Ring", --4
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Passion Jacket", --10
    neck="Magoraga Beads", --10
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    -- ring1="Weatherspoon Ring", --5
  })


  ------------------------------------------------------------------------------------------------
  --     Ranged
  ------------------------------------------------------------------------------------------------

  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA = {
    ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1",    -- __/14 [__/__,  59]
    body="Oshosi Vest",               -- 12/__ [__/__,  96]
    hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Commodore Charm +1",        --  3/__ [__/__, ___]
    ear1="Eabani Earring",            -- __/__ [__/__,   8]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",         --  3/__ [__/__, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",              -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- 66 Snapshot / 73 Rapid Shot [26 PDT/15 MDT, 350 M.Eva]
    
    -- Good
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- body="Oshosi Vest +1",         -- 14/__ [__/__, 106]
    -- hands="Lanun Gants +3",        -- 13/__ [__/__,  57]
    -- legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",           -- 10/__ [ 3/__,  69]
    -- neck="Loricate Torque +1",     -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",         -- __/__ [ 2/__, ___]
    -- ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",      --  3/__ [__/__, ___]
    -- ring2="Defending Ring",        -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- 70 Snapshot / 64 Rapid Shot [43 PDT/30 MDT, 406 M.Eva]
    
    -- Ideal
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- body="Oshosi Vest +1",         -- 14/__ [__/__, 106]
    -- hands=gear.Carmine_D_hands,    --  8/11 [__/__,  43]
    -- legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",           -- 10/__ [ 3/__,  69]
    -- neck="Commodore Charm +2",     --  4/__ [__/__, ___]
    -- ear1="Genmei Earring",         -- __/__ [ 2/__, ___]
    -- ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",      --  3/__ [__/__, ___]
    -- ring2="Defending Ring",        -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- 69 Snapshot / 75 Rapid Shot [37 PDT/24 MDT, 392 M.Eva]
  }
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- body="Laksamana's Frac +3",    -- __/20 [__/__,  84]
    -- hands="Lanun Gants +3",        -- 13/__ [__/__,  57]
    legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    feet="Meg. Jam. +2",           -- 10/__ [ 3/__,  69]
    neck="Loricate Torque +1",     -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",         -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",      --  3/__ [__/__, ___]
    ring2="Defending Ring",        -- __/__ [10/10, ___]
    back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 1                          15/__
    -- 71 Snapshot / 84 Rapid Shot [43 PDT/30 MDT, 384 M.Eva]
  })
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
    hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    -- feet=gear.Pursuer_A_feet,         -- __/10 [__/__,  69]
    -- 34 Snapshot / 73 Rapid Shot
    
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1", -- __/14 [__/__,  59]
    -- body="Laksamana's Frac +3",    -- __/20 [__/__,  84]
    -- hands=gear.Carmine_D_hands,    --  8/11 [__/__,  43]
    -- legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    -- feet=gear.Pursuer_A_feet,      -- __/10 [__/__,  69]
    -- neck="Commodore Charm +1",     --  3/__ [__/__, ___]
    -- ear1="Eabani Earring",         -- __/__ [__/__,   8]
    -- ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",      --  3/__ [__/__, ___]
    -- ring2="Defending Ring",        -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 2                          30/__
    -- 74 Snapshot / 103 Rapid Shot [23 PDT/15 MDT, 338 M.Eva]
    
    -- Ideal
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- body="Laksamana's Frac +3",    -- __/20 [__/__,  84]
    -- hands=gear.Carmine_D_hands,    --  8/11 [__/__,  43]
    -- legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    -- feet=gear.Pursuer_A_feet,      -- __/10 [__/__,  69]
    -- neck="Commodore Charm +2",     --  4/__ [__/__, ___]; +1 also fine
    -- ear1="Genmei Earring",         -- __/__ [ 2/__, ___]
    -- ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",    -- __/__ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]
    -- waist="Flume Belt +1",         -- __/__ [ 4/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 2                          30/__
    -- 72 Snapshot / 100 Rapid Shot [45 PDT/23 MDT, 370 M.Eva]
  })
  
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Safe = {
    ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1", -- __/14 [__/__,  59]
    -- body="Oshosi Vest +1",         -- 14/__ [__/__, 106]
    -- hands="Lanun Gants +3",           -- 13/__ [__/__,  57]
    legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Loricate Torque +1",        -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",              -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- 67 Snapshot / 62 Rapid Shot [41 PDT/20 MDT, 366 M.Eva]

    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- 67 Snapshot / 64 Rapid Shot [50 PDT/29 MDT, 406 M.Eva]
  }
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry1.Safe = {
    ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1", -- __/14 [__/__,  59]
    -- body="Laksamana's Frac +3",       -- __/20 [__/__,  84]
    -- hands="Lanun Gants +3",           -- 13/__ [__/__,  57]
    legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Loricate Torque +1",        -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]
    -- waist="Yemaya Belt",              -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 1                          15/__
    -- 68 Snapshot / 82 Rapid Shot [41 PDT/20 MDT, 344 M.Eva]

    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- 68 Snapshot / 84 Rapid Shot [50 PDT/29 MDT, 384 M.Eva]
  }
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry2.Safe = {
    ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1", -- __/14 [__/__,  59]
    -- body="Laksamana's Frac +3",       -- __/20 [__/__,  84]
    hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    -- feet=gear.Pursuer_A_feet,         -- __/10 [__/__,  69]
    neck="Commodore Charm +1",        --  3/__ [__/__, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]
    waist="Flume Belt +1",            -- __/__ [ 4/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 2                          30/__
    -- 71 Snapshot / 98 Rapid Shot [36 PDT/14 MDT, 330 M.Eva]

    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- 71 Snapshot / 100 Rapid Shot [45 PDT/23 MDT, 370 M.Eva]
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo=gear.WSbullet,
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Ephramad's Ring",
    ring2="Epaminondas's Ring",
    back=gear.COR_WS2_Cape,
    -- hands="Meg. Gloves +2",
    -- feet="Lanun Bottes +3",
    -- neck="Fotia Gorget",
    -- waist="Fotia Belt",
    -- back=gear.COR_WS3_Cape,
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS.LowAcc = set_combine(sets.precast.WS, {
  })
  sets.precast.WS.LowAccMaxTP = set_combine(sets.precast.WS.LowAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS.MidAcc = set_combine(sets.precast.WS.LowAcc, {
  })
  sets.precast.WS.MidAccMaxTP = set_combine(sets.precast.WS.MidAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
  })
  sets.precast.WS.HighAccMaxTP = set_combine(sets.precast.WS.HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Last Stand'] = {
    ammo=gear.WSbullet,
    head=gear.Nyame_B_head,
    body="Ikenga's Vest",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    -- neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Ephramad's Ring",
    ring2="Epaminondas's Ring",
    back=gear.COR_WS1_Cape,
    -- waist="Fotia Belt",
    -- back=gear.COR_WS3_Cape,
  }
  sets.precast.WS['Last Stand'].MaxTP = set_combine(sets.precast.WS['Last Stand'], {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].LowAcc = set_combine(sets.precast.WS['Last Stand'], {
  })
  sets.precast.WS['Last Stand'].LowAccMaxTP = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].MidAcc = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
  })
  sets.precast.WS['Last Stand'].MidAccMaxTP = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    ammo=gear.RAccbullet,
    -- neck="Iskur Gorget",
    -- ear1="Beyla Earring",
    -- ear2="Telos Earring",
    ring2="Hajduk Ring +1",
    -- waist="K. Kachina Belt +1",
  })
  sets.precast.WS['Last Stand'].HighAccMaxTP = set_combine(sets.precast.WS['Last Stand'].HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Wildfire'] = {
    ammo=gear.MAbullet,
    head=gear.Nyame_B_head, --30; WSD
    body=gear.Nyame_B_body, --30; WSD
    hands=gear.Nyame_B_hands, --30; WSD
    legs=gear.Nyame_B_legs, --30; WSD
    feet=gear.Nyame_B_feet, --30; WSD
    neck="Commodore Charm +1", --6
    ear1="Friomisi Earring", --10
    ear2="Novio Earring", --7
    ring1="Dingir Ring", --10
    ring2="Epaminondas's Ring",
    back=gear.COR_WS1_Cape, --0
    -- body="Lanun Frac +3", --61
    -- feet="Lanun Bottes +3", --55; WSD
    -- waist="Skrymir Cord", --5

    -- neck="Comm. Charm +2",
    -- waist="Skrymir Cord +1",
  }
  sets.precast.WS['Wildfire'].MaxTP = set_combine(sets.precast.WS['Wildfire'], {
  })
  sets.precast.WS['Wildfire'].LowAcc = set_combine(sets.precast.WS['Wildfire'], {
  })
  sets.precast.WS['Wildfire'].LowAccMaxTP = set_combine(sets.precast.WS['Wildfire'].LowAcc, {
  })
  sets.precast.WS['Wildfire'].MidAcc = set_combine(sets.precast.WS['Wildfire'].LowAcc, {
  })
  sets.precast.WS['Wildfire'].MidAccMaxTP = set_combine(sets.precast.WS['Wildfire'].MidAcc, {
  })
  sets.precast.WS['Wildfire'].HighAcc = set_combine(sets.precast.WS['Wildfire'].MidAcc, {
  })
  sets.precast.WS['Wildfire'].HighAccMaxTP = set_combine(sets.precast.WS['Wildfire'].HighAcc, {
  })

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
    ear2="Moonshade Earring",
    back=gear.COR_TP_Cape,
    -- back=gear.COR_WS4_Cape,
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].LowAcc = set_combine(sets.precast.WS['Aeolian Edge'], {
  })
  sets.precast.WS['Aeolian Edge'].LowAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].MidAcc = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {
  })
  sets.precast.WS['Aeolian Edge'].MidAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].HighAcc = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {
  })
  sets.precast.WS['Aeolian Edge'].HighAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].HighAcc, {
    ear2="Novio Earring",
  })

  sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
    head="Pixie Hairpin +1",
    ear2="Moonshade Earring",
    ring1="Archon Ring",
  })
  sets.precast.WS['Leaden Salute'].MaxTP = set_combine(sets.precast.WS['Leaden Salute'], {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].LowAcc = set_combine(sets.precast.WS['Leaden Salute'], {
  })
  sets.precast.WS['Leaden Salute'].LowAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].MidAcc = set_combine(sets.precast.WS['Leaden Salute'].LowAcc, {
  })
  sets.precast.WS['Leaden Salute'].MidAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].HighAcc = set_combine(sets.precast.WS['Leaden Salute'].MidAcc, {
  })
  sets.precast.WS['Leaden Salute'].HighAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].HighAcc, {
    ear2="Novio Earring",
  })

  sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {})
  sets.precast.WS['Hot Shot'].MaxTP = set_combine(sets.precast.WS['Wildfire'].MaxTP, {})
  sets.precast.WS['Hot Shot'].LowAcc = set_combine(sets.precast.WS['Wildfire'].LowAcc, {})
  sets.precast.WS['Hot Shot'].LowAccMaxTP = set_combine(sets.precast.WS['Wildfire'].LowAccMaxTP, {})
  sets.precast.WS['Hot Shot'].MidAcc = set_combine(sets.precast.WS['Wildfire'].MidAcc, {})
  sets.precast.WS['Hot Shot'].MidAccMaxTP = set_combine(sets.precast.WS['Wildfire'].MidAccMaxTP, {})
  sets.precast.WS['Hot Shot'].HighAcc = set_combine(sets.precast.WS['Wildfire'].HighAcc, {})
  sets.precast.WS['Hot Shot'].HighAccMaxTP = set_combine(sets.precast.WS['Wildfire'].HighAccMaxTP, {})

  sets.precast.WS['Evisceration'] = {
    -- head=gear.Adhemar_B_head,
    hands="Mummu Wrists +2",
    feet="Mummu Gamash. +2",
    -- neck="Fotia Gorget",
    -- ear1="Odr Earring",
    ear2="Moonshade Earring",
    ring1="Ephramad's Ring",
    back=gear.COR_TP_Cape,
    -- waist="Fotia Belt",
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    -- ear2="Telos Earring",
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
  })
  sets.precast.WS['Evisceration'].LowAccMaxTP = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
    -- ear2="Telos Earring",
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAccMaxTP = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
    body=gear.Adhemar_A_body,
    -- head="Meghanada Visor +2",
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Savage Blade'] = {
    head=gear.Nyame_B_head,       -- 26, 26, 65, 50, 11, __, ___
    body=gear.Nyame_B_body,       -- 45, 37, 65, 40, 13, __, ___
    hands=gear.Nyame_B_hands,     -- 17, 40, 65, 40, 11, __, ___
    legs=gear.Nyame_B_legs,       -- 58, 32, 65, 40, 12, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 65, 53, 11, __, ___
    neck="Commodore Charm +1",    -- 12, __, __, __, __, __, ___
    ear1="Ishvara Earring",       -- __, __, __, __,  2, __, ___
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ring1="Ephramad's Ring",      -- 10, __, 20, 20, __, 10, ___
    ring2="Epaminondas's Ring",   -- __, __, __, __,  5, __, ___
    back=gear.COR_WS2_Cape,       -- 30, __, 20, 20, 10, __, ___
    waist="Sailfi Belt +1",       -- 15, __, 15, __, __ ,__, ___
    -- 236 STR, 161 MND, 380 Attack, 267 Accuracy, 75 WSD, 10 PDL, 250 TP Bonus

    -- body="Ikenga's Vest",      -- 33, 25, __, __, __,  7, 200
    -- neck="Commodore Charm +2", -- 15, __, __, __, __, __, ___
    -- waist="Sailfi Belt +1",    -- 15, __, 15, __, __, __, ___
    -- 227 STR, 149 MND, 315 Attack, 227 Accuracy, 62 WSD, 17 PDL, 450 TP Bonus

  }
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].LowAcc = set_combine(sets.precast.WS['Savage Blade'], {
    ear1="Dignitary's Earring",
  })
  sets.precast.WS['Savage Blade'].LowAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
    ring1="Chirich Ring +1",
  })
  sets.precast.WS['Savage Blade'].MidAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
    -- body=gear.Herc_WSD_body,
  })
  sets.precast.WS['Savage Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
    -- head=gear.Adhemar_B_head,
    body=gear.Adhemar_A_body,
    hands=gear.Adhemar_A_hands,
    -- legs="Meg. Chausses +2",
    feet=gear.Herc_TA_feet,
    -- neck="Fotia Gorget",
    ear1="Cessance Earring",
    -- ear2="Brutal Earring",
    ring1="Ephramad's Ring",
    ring2="Epona's Ring",
    back=gear.COR_WS2_Cape,
    -- waist="Fotia Belt",
  })
  sets.precast.WS['Swift Blade'].MaxTP = set_combine(sets.precast.WS['Swift Blade'], {
  })
  sets.precast.WS['Swift Blade'].LowAcc = set_combine(sets.precast.WS['Swift Blade'], {
  })
  sets.precast.WS['Swift Blade'].LowAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].LowAcc, {
  })
  sets.precast.WS['Swift Blade'].MidAcc = set_combine(sets.precast.WS['Swift Blade'].LowAcc, {
  })
  sets.precast.WS['Swift Blade'].MidAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].MidAcc, {
  })
  sets.precast.WS['Swift Blade'].HighAcc = set_combine(sets.precast.WS['Swift Blade'].MidAcc, {
    hands=gear.Adhemar_A_hands,
    -- head="Meghanada Visor +2",
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Swift Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].HighAcc, {
  })

  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
    -- hands="Meg. Gloves +2",
    -- ear1="Telos Earring",
    ear2="Moonshade Earring",
    ring2="Rufescent Ring",
  }) --MND
  sets.precast.WS['Requiescat'].MaxTP = set_combine(sets.precast.WS['Requiescat'], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].LowAcc = set_combine(sets.precast.WS['Requiescat'], {
  })
  sets.precast.WS['Requiescat'].LowAccMaxTP = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].MidAcc = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
  })
  sets.precast.WS['Requiescat'].MidAccMaxTP = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    ear1="Cessance Earring",
    -- head="Meghanada Visor +2",
  })
  sets.precast.WS['Requiescat'].HighAccMaxTP = set_combine(sets.precast.WS['Requiescat'].HighAcc, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS['Sniper Shot'] = {
    head="Malignance Cheapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112]
    legs="Malignance Tights",
    feet="Malignance Boots",          -- 49,  9, 50/__ <__> {2} (__) [ 4/ 4, 150]
    neck="Commodore Charm +1",        -- 12, __, 20/__ <__> {_} (__) [__/__, ___]
    ear1="Enervating Earring",        -- __,  4,  7/ 7 <__> {_} (__) [__/__, ___]
    ring1="Hajduk Ring +1",           -- __, __, 17/__ <__> {_} (__) [__/__, ___]
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___]
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    waist="Reiki Yotai",              -- __,  4, 10/__ <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 213 AGI, 73 STP, 322 racc/242 ratt <5 crit> {23 PDL} (68 Recycle) [29 PDT/19 MDT, 593 M.Eva]
    
    -- head="Ikenga's Hat",           -- 29,  8, 55/70 <__> {4} (__) [__/__,  96]; R30
    -- body="Chasseur's Frac +3",     -- 49, __, 64/74 <__> {_} (__) [13/13, 119]
    -- hands="Ikenga's Gloves",       -- 19,  9, 55/70 <__> {5} (10) [__/__,  86]; R30
    -- feet="Ikenga's Clogs",         -- 57,  7, 55/70 <__> {3} (__) [__/__, 123]; R30
    -- legs="Chasseur's Culottes +3", -- 43, 12, 63/63 <__> {_} (__) [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear1="Beyla Earring",          -- __, __, 15/__ <__> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    -- ring2="Crepuscular Ring",      -- __,  6, 10/__ <__> {_} (__) [__/__, ___]
    -- waist="Kwahu Kachina Belt +1", --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- 235 AGI, 65 STP, 449 racc/407 ratt <5 crit> {12 PDL} (68 Recycle) [35 PDT/25 MDT, 549 M.Eva]
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  sets.midcast.Utsusemi = {
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    -- legs=gear.Carmine_A_legs, -- SIRD
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ear2="Odnowa Earring +1", -- DT
    ring1="Defending Ring", -- DT
  }


  ------------------------------------------------------------------------------------------------
  --    Ranged
  ------------------------------------------------------------------------------------------------

  sets.midcast.RA = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    head="Malignance Cheapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112]
    legs="Malignance Tights",
    feet="Malignance Boots",          -- 49,  9, 50/__ <__> {2} (__) [ 4/ 4, 150]
    neck="Commodore Charm +1",        -- 12, __, 20/__ <__> {_} (__) [__/__, ___]
    ear1="Enervating Earring",        -- __,  4,  7/ 7 <__> {_} (__) [__/__, ___]
    ring1="Dingir Ring",              -- 10, __, __/25 <__> {_} (10) [__/__, ___]
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___]
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    waist="Reiki Yotai",              -- __,  4, 10/__ <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 213 AGI, 73 STP, 322 racc/242 ratt <5 crit> {23 PDL} (68 Recycle) [29 PDT/19 MDT, 593 M.Eva]
    
    -- head="Ikenga's Hat",           -- 29,  8, 55/70 <__> {4} (__) [__/__,  96]; R30
    -- body="Ikenga's Vest",          -- 39, 11, 55/70 < 5> {7} (__) [__/__, 112]; R30
    -- legs="Chasseur's Culottes +3", -- 43, 12, 63/63 <__> {_} (__) [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    -- waist="Yemaya Belt",           --  7,  4, 10/10 <__> {_} (__) [__/__, ___]
    -- 241 AGI, 88 STP, 370 racc/305 ratt <5 crit> {17 PDL} (68 Recycle) [31 PDT/21 MDT, 595 M.Eva]
  }
  sets.midcast.RA.LowAcc = set_combine(sets.midcast.RA, {
    -- ammo=gear.RAccbullet,          -- __, __, 35/__ <__> {_} (__) [__/__, ___]
    -- ear1="Beyla Earring",          -- __, __, 15/__ <__> {_} (__) [__/__, ___]
    -- ring2="Crepuscular Ring",      -- __,  6, 10/__ <__> {_} (__) [__/__, ___]
    -- 231 AGI, 85 STP, 403 racc/298 ratt <5 crit> {17 PDL} (68 Recycle) [31 PDT/21 MDT, 595 M.Eva]
  })
  sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA.LowAcc, {
    ring1="Hajduk Ring +1",           -- __, __, 17/__ <__> {_} (__) [__/__, ___]
    -- waist="Kwahu Kachina Belt +1", --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- 222 AGI, 81 STP, 430 racc/263 ratt <10 crit> {17 PDL} (58 Recycle) [31 PDT/21 MDT, 595 M.Eva]
  })
  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.MidAcc, {
    -- body="Chasseur's Frac +3",     -- 49, __, 64/74 <__> {_} (__) [13/13, 119]
    -- hands="Ikenga's Gloves",       -- 19,  9, 55/70 <__> {5} (10) [__/__,  86]; R30
    -- feet="Ikenga's Clogs",         -- 57,  7, 55/70 <__> {3} (__) [__/__, 123]; R30
    -- 235 AGI, 65 STP, 449 racc/407 ratt <5 crit> {12 PDL} (68 Recycle) [35 PDT/25 MDT, 549 M.Eva]
  })
  
  sets.midcast.RA.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    head="Malignance Cheapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112]
    legs="Malignance Tights",
    feet="Malignance Boots",          -- 49,  9, 50/__ <__> {2} (__) [ 4/ 4, 150]
    neck="Commodore Charm +1",        -- 12, __, 20/__ <__> {_} (__) [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __/__ <__> {_} (__) [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___]
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    waist="Reiki Yotai",              -- __,  4, 10/__ <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 193 AGI, 64 STP, 315 racc/210 ratt <5 crit> {23 PDL} (58 Recycle) [49 PDT/33 MDT, 593 M.Eva]

    -- head="Ikenga's Hat",           -- 29,  8, 55/70 <__> {4} (__) [__/__,  96]; R30
    -- body="Ikenga's Vest",          -- 39, 11, 55/70 < 5> {7} (__) [__/__, 112]; R30
    -- legs="Chasseur's Culottes +3", -- 43, 12, 63/63 <__> {_} (__) [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    -- waist="Yemaya Belt",           --  7,  4, 10/10 <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 221 AGI, 79 STP, 363 racc/273 ratt <5 crit> {17 PDL} (58 Recycle) [51 PDT/35 MDT, 595 M.Eva]
  }

  sets.midcast.RA.Critical = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    head="Ikenga's Hat",              -- 29,  8, 55/70 <__> {4} (__) [__/__,  96]
    body="Ikenga's Vest",             -- 39, 11, 55/70 < 5> {7} (__) [__/__, 112]
    hands="Chasseur's Gants +2",      -- 21, __, 52/52 < 7> {_} (__) [__/__,  83]
    -- legs="Mummu Kecks +2",         -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107]
    -- feet="Oshosi Leggings +1",     -- 56, __, 43/__ <10> {_} (__) [__/__, 131]
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear1="Odr Earring",            -- __, __, __/__ < 5> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    -- ring1="Begrudging Ring",       -- __, __, __/__ < 5> {_} (__)[-10/__, ___]
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___]
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="K. Kachina Belt +1",    --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 238 AGI, 47 STP, 350 racc/252 ratt <44 crit rate> {11 PDL} (58 Recycle) [5 PDT/5 MDT, 529 M.Eva]
    
    -- ring2="Mummu Ring",            -- __, __,  6/__ < 3> {_} (__) [__/__, ___]
    -- 228 AGI, 42 STP, 356 racc/252 ratt <47 crit rate> {11 PDL} (58 Recycle) [5 PDT/5 MDT, 529 M.Eva]
  }
  sets.midcast.RA.Critical.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    head="Malignance Chapeau",        -- 33,  8, 50/__ <__> {3} (__) [ 6/ 6, 123]
    body="Malignance Tabard",         -- 42, 11, 50/__ <__> {6} (__) [ 9/ 9, 139]
    hands="Chasseur's Gants +2",      -- 21, __, 52/52 < 7> {_} (__) [__/__,  83]
    -- legs="Mummu Kecks +2",         -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107]
    -- feet="Oshosi Leggings +1",     -- 56, __, 43/__ <10> {_} (__) [__/__, 131]
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear1="Odr Earring",            -- __, __, __/__ < 5> {_} (__) [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __/__ <__> {_} (__) [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___]
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="K. Kachina Belt +1",    --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 235 AGI, 37 STP, 330 racc/102 ratt <34 crit rate> {9 PDL} (58 Recycle) [50 PDT/34 MDT, 583 M.Eva]
    
    -- neck="Loricate Torque +1",     -- __, __, __/__ <__> {_} (__) [ 6/ 6, ___]
    -- ring1="Mummu Ring",            -- __, __,  6/__ < 3> {_} (__) [__/__, ___]
    -- 235 AGI, 29 STP, 306 racc/72 ratt <37 crit rate> {9 PDL} (58 Recycle) [49 PDT/41 MDT, 583 M.Eva]
  }

  -- 60% from traits/gifts
  sets.TripleShot = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- head="Oshosi Mask +1",            -- 44, __, 45/__ <__> {_} (__) [__/__,  90] ( 6, 25) ( 5, 13)
    -- body="Chasseur's Frac +1",        -- 34, __, 22/22 <__> {_} (__) [__/__,  69] (__, __) (12, __)
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112] (__, __) (__, __)
    -- legs="Oshosi Trousers +1",        -- 43, __, 46/__ <__> {_} (__) [__/__, 131] ( 7, __) ( 6, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ear1="Enervating Earring",        -- __,  4,  7/ 7 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ring1="Dingir Ring",              -- 10, __, __/25 <__> {_} (10) [__/__, ___] (__, __) (__, __)
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="Yemaya Belt",              --  7,  4, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 258 AGI, 48 STP, 303 racc/124 ratt <10 crit> {4 PDL} (68 Recycle) [15 PDT/5 MDT, 533 M.Eva] (17 DS Rate, 25 DS Dmg) (91 TS Rate, 13 TS Dmg)

    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- hands="Lanun Gants +3",        -- 22, __, 44/76 <__> {_} (__) [__/__,  84] (__, __) (__, __); Occ. Quad Shot
    -- 266 AGI, 36 STP, 329 racc/242 ratt <10 crit> {0 PDL} (68 Recycle) [22 PDT/12 MDT, 545 M.Eva] (17 DS Rate, 25 DS Dmg) (92 TS Rate, 13 TS Dmg)
  }
  sets.TripleShot.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- head="Oshosi Mask +1",            -- 44, __, 45/__ <__> {_} (__) [__/__,  90] ( 6, 25) ( 5, 13)
    -- body="Chasseur's Frac +1",        -- 34, __, 22/22 <__> {_} (__) [__/__,  69] (__, __) (12, __)
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112] (__, __) (__, __)
    -- legs="Oshosi Trousers +1",        -- 43, __, 46/__ <__> {_} (__) [__/__, 131] ( 7, __) ( 6, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ear1="Odnowa Earring +1",         -- __, __, __/__ <__> {_} (__) [ 3/ 5, ___] (__, __) (__, __)
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7,-1, ___] (__, __) (__, __)
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___] (__, __) (__, __)
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="Yemaya Belt",              --  7,  4, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 238 AGI, 39 STP, 296 racc/92 ratt <10 crit> {4 PDL} (58 Recycle) [35 PDT/19 MDT, 533 M.Eva] (17 DS Rate, 25 DS Dmg) (91 TS Rate, 13 TS Dmg)
    
    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- hands="Lanun Gants +3",        -- 22, __, 44/76 <__> {_} (__) [__/__,  84] (__, __) (__, __); Occ. Quad Shot
    -- ear1="Enervating Earring",     -- __,  4,  7/ 7 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- 246 AGI, 31 STP, 329 racc/217 ratt <10 crit> {0 PDL} (58 Recycle) [39 PDT/21 MDT, 545 M.Eva] (17 DS Rate, 25 DS Dmg) (92 TS Rate, 13 TS Dmg)
  }

  sets.TripleShot.Critical = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- head="Oshosi Mask +1",            -- 44, __, 45/__ <__> {_} (__) [__/__,  90] ( 6, 25) ( 5, 13)
    -- body="Chasseur's Frac +1",        -- 34, __, 22/22 <__> {_} (__) [__/__,  69] (__, __) (12, __)
    hands="Chasseur's Gants +2",      -- 21, __, 52/52 < 7> {_} (__) [__/__,  83] (__, __) (__, __)
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107] (__, __) (__, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ring1="Begrudging Ring",          -- __, __, __/__ < 5> {_} (__)[-10/__, ___] (__, __) (__, __)
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 248 AGI, 28 STP, 307 racc/134 ratt <39 crit> {0 PDL} (58 Recycle) [5 PDT/5 MDT, 480 M.Eva] (10 DS Rate, 25 DS Dmg) (85 TS Rate, 13 TS Dmg)
    
    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- ring2="Mummu Ring",            -- __, __,  6/__ < 3> {_} (__) [__/__, ___] (__, __) (__, __)
    -- 248 AGI, 23 STP, 345 racc/176 ratt <42 crit> {0 PDL} (58 Recycle) [17 PDT/17 MDT, 520 M.Eva] (10 DS Rate, 25 DS Dmg) (86 TS Rate, 13 TS Dmg)
  }
  sets.TripleShot.Critical.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- head="Oshosi Mask +1",            -- 44, __, 45/__ <__> {_} (__) [__/__,  90] ( 6, 25) ( 5, 13)
    -- body="Chasseur's Frac +1",        -- 34, __, 22/22 <__> {_} (__) [__/__,  69] (__, __) (12, __)
    hands="Chasseur's Gants +2",      -- 21, __, 52/52 < 7> {_} (__) [__/__,  83] (__, __) (__, __)
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107] (__, __) (__, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    neck="Loricate Torque +1",        -- __, __, __/__ <__> {_} (__) [ 6/ 6, ___] (__, __) (__, __)
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7,-1, ___] (__, __) (__, __)
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___] (__, __) (__, __)
    back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 238 AGI, 15 STP, 277 racc/104 ratt <34 crit> {0 PDL} (58 Recycle) [38 PDT/20 MDT, 480 M.Eva] (10 DS Rate, 25 DS Dmg) (85 TS Rate, 13 TS Dmg)
    
    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- 248 AGI, 23 STP, 339 racc/176 ratt <34 crit> {0 PDL} (58 Recycle) [44 PDT/26 MDT, 520 M.Eva] (10 DS Rate, 25 DS Dmg) (86 TS Rate, 13 TS Dmg)
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.

  sets.engaged = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs=gear.Samnuha_legs,           -- __,  7, 15 < 3,  3, __> [__/__,  75]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]

    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 0 DW, 58 STP, 255 Acc <20 DA, 12 TA, 2 QA> [39 PDT/29 MDT, 530 M.Eva]
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- 0 DW, 58 STP, 255 Acc <20 DA, 12 TA, 2 QA> [39 PDT/29 MDT, 530 M.Eva]
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 0 DW, 69 STP, 277 Acc <20 DA, 7 TA, 0 QA> [39 PDT/29 MDT, 530 M.Eva]
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring2="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- 0 DW, 78 STP, 345 Acc <11 DA, 4 TA, 0 QA> [41 PDT/31 MDT, 580 M.Eva]
  })

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.LowDW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 36 DW, 52 STP, 282 Acc <13 DA, 13 TA, 2 QA> [42 PDT/32 MDT, 510 MEVA]
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 36 DW, 49 STP, 302 Acc <14 DA, 13 TA, 2 QA> [42 PDT/32 MDT, 510 MEVA]
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 36 DW, 51 STP, 312 Acc <11 DA, 10 TA, 2 QA> [42 PDT/32 MDT, 510 MEVA]
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 31 DW, 57 STP, 336 Acc <14 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.MidDW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    -- 43 DW, 56 STP, 290 Acc <13 DA, 11 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 43 DW, 53 STP, 310 Acc <14 DA, 11 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 43 DW, 55 STP, 320 Acc <11 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    -- 38 DW, 58 STP, 330 Acc <11 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.HighDW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 57 DW, 48 STP, 300 Acc <3 DA, 11 TA, 0 QA> [42 PDT/32 MDT, 518 MEVA]
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 57 DW, 54 STP, 310 Acc <0 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 518 MEVA]
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 57 DW, 50 STP, 310 Acc <0 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 518 MEVA]
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 48 DW, 58 STP, 330 Acc <1 DA, 8 TA, 0 QA> [42 PDT/32 MDT, 510 MEVA]
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.SuperDW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- hands="Floral Gauntlets",      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 67 DW, 39 STP, 237 Acc <3 DA, 6 TA, 0 QA> [35 PDT/29 MDT, 448 MEVA]
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 67 DW, 36 STP, 253 Acc <4 DA, 6 TA, 0 QA> [35 PDT/29 MDT, 448 MEVA]
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 67 DW, 38 STP, 263 Acc <1 DA, 3 TA, 0 QA> [35 PDT/29 MDT, 448 MEVA]
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    -- 63 DW, 37 STP, 294 Acc <1 DA, 8 TA, 0 QA> [26 PDT/16 MDT, 384 MEVA]
  })

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.MaxDW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- hands="Floral Gauntlets",      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 73 DW, 28 STP, 242 Acc <0 DA, 7 TA, 0 QA> [33 PDT/19 MDT, 378 MEVA]
  }
  sets.engaged.MaxDW.LowAcc = set_combine(sets.engaged.MaxDW, {
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 73 DW, 25 STP, 258 Acc <1 DA, 7 TA, 0 QA> [33 PDT/19 MDT, 378 MEVA]
  })
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW.LowAcc, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 73 DW, 21 STP, 258 Acc <1 DA, 7 TA, 0 QA> [33 PDT/19 MDT, 378 MEVA]
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    -- 63 DW, 31 STP, 284 Acc <1 DA, 8 TA, 0 QA> [33 PDT/15 MDT, 384 MEVA]
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 25 DW, 68 STP, 287 Acc <14 DA, 9 TA, 2 QA> [51 PDT/41 MDT, 580 MEVA]
  }
  sets.engaged.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Flume Belt +1",            -- __, __, __ <__, __, __> [ 4/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 25 DW, 57 STP, 278 Acc <21 DA, 7 TA, 0 QA> [50 PDT/36 MDT, 605 M.Eva]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 25 DW, 68 STP, 287 Acc <14 DA, 9 TA, 2 QA> [51 PDT/41 MDT, 580 M.Eva]
  }
  sets.engaged.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 25 DW, 73 STP, 313 Acc <20 DA, 3 TA, 0 QA> [53 PDT/35 MDT, 649 M.Eva]
  }
  sets.engaged.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Iskur Gorget",           -- __,  8, __ <__, __, __> [__/__, ___]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 25 DW, 79 STP, 327 Acc <14 DA, 0 TA, 0 QA> [53 PDT/35 MDT, 649 M.Eva]
  }

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.LowDW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 36 DW, 44 STP, 282 Acc <10 DA, 10 TA, 2 QA> [55 PDT/37 MDT, 510 MEVA]
  }
  sets.engaged.LowDW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 36 DW, 50 STP, 300 Acc <11 DA, 6 TA, 2 QA> [54 PDT/36 MDT, 579 MEVA]
  }
  sets.engaged.LowDW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 67 STP, 328 Acc <11 DA, 0 TA, 0 QA> [56 PDT/46 MDT, 649 MEVA]
  }
  sets.engaged.LowDW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 38 DW, 52 STP, 320 Acc <11 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 67 STP, 328 Acc <11 DA, 0 TA, 0 QA> [56 PDT/46 MDT, 649 MEVA]
  }

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.MidDW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 43 DW, 48 STP, 290 Acc <10 DA, 8 TA, 0 QA> [55 PDT/37 MDT, 510 MEVA]
  }
  sets.engaged.MidDW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 43 DW, 47 STP, 291 Acc <11 DA, 10 TA, 0 QA> [51 PDT/39 MDT, 504 MEVA]
  }
  sets.engaged.MidDW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 43 DW, 47 STP, 282 Acc <11 DA, 10 TA, 0 QA> [51 PDT/39 MDT, 504 MEVA]
  }
  sets.engaged.MidDW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 48 DW, 52 STP, 320 Acc <1 DA, 4 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
  }

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.HighDW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 57 DW, 40 STP, 280 Acc <0 DA, 8 TA, 0 QA> [55 PDT/37 MDT, 518 MEVA]
  }
  sets.engaged.HighDW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill +15
    -- 57 DW, 47 STP, 285 Acc <0 DA, 4 TA, 0 QA> [49 PDT/31 MDT, 612 MEVA]
  }
  sets.engaged.HighDW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]

    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 57 DW, 44 STP, 300 Acc <0 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 612 MEVA]
  }
  sets.engaged.HighDW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 48 DW, 52 STP, 320 Acc <1 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
  }

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.SuperDW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- hands="Floral Gauntlets",      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- ear2="Dedition Earring",       -- __,  8,-10 <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 67 DW, 32 STP, 246 Acc <0 DA, 7 TA, 0 QA> [51 PDT/37 MDT, 423 MEVA]
  }
  sets.engaged.SuperDW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- hands="Floral Gauntlets",      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 67 DW, 23 STP, 257 Acc <0 DA, 3 TA, 0 QA> [51 PDT/39 MDT, 448 MEVA]
  }
  sets.engaged.SuperDW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- hands="Floral Gauntlets",      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 58 DW, 32 STP, 296 Acc <0 DA, 3 TA, 0 QA> [49 PDT/37 MDT, 529 MEVA]
  }
  sets.engaged.SuperDW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 48 DW, 52 STP, 320 Acc <1 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
  }

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.MaxDW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- hands=gear.Floral_Gauntlets,   --  5, __, 36 <__,  3, __> [__/ 4,  37]
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 71 DW, 24 STP, 256 Acc <0 DA, 7 TA, 0 QA> [51 PDT/37 MDT, 431 MEVA]
  }
  sets.engaged.MaxDW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 66 DW, 35 STP, 261 Acc <0 DA, 0 TA, 0 QA> [53 PDT/35 MDT, 531 MEVA]
  }
  sets.engaged.MaxDW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Subtlety Spectacles",    -- __, __, 15 <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 60 DW, 52 STP, 284 Acc <0 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 566 MEVA]
  }
  sets.engaged.MaxDW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    
    -- legs="Chasseur's Culottes +3", -- __, 12, 63 <__, __, __> [12/12, 125]
    -- neck="Subtlety Spectacles",    -- __, __, 15 <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- back=gear.COR_DW_Cape,         -- 10, __, 20 <__, __, __> [10/__, ___]
    -- 60 DW, 53 STP, 290 Acc <0 DA, 0 TA, 0 QA> [52 PDT/42 MDT, 576 MEVA]
  }

  sets.engaged.Safe = set_combine(sets.engaged.HeavyDef, {})
  sets.engaged.LowAcc.Safe = set_combine(sets.engaged.LowAcc.HeavyDef, {})
  sets.engaged.MidAcc.Safe = set_combine(sets.engaged.MidAcc.HeavyDef, {})
  sets.engaged.HighAcc.Safe = set_combine(sets.engaged.HighAcc.HeavyDef, {})

  sets.engaged.LowDW.Safe = set_combine(sets.engaged.LowDW.HeavyDef, {})
  sets.engaged.LowDW.LowAcc.Safe = set_combine(sets.engaged.LowDW.LowAcc.HeavyDef, {})
  sets.engaged.LowDW.MidAcc.Safe = set_combine(sets.engaged.LowDW.MidAcc.HeavyDef, {})
  sets.engaged.LowDW.HighAcc.Safe = set_combine(sets.engaged.LowDW.HighAcc.HeavyDef, {})

  sets.engaged.MidDW.Safe = set_combine(sets.engaged.MidDW.HeavyDef, {})
  sets.engaged.MidDW.LowAcc.Safe = set_combine(sets.engaged.MidDW.LowAcc.HeavyDef, {})
  sets.engaged.MidDW.MidAcc.Safe = set_combine(sets.engaged.MidDW.MidAcc.HeavyDef, {})
  sets.engaged.MidDW.HighAcc.Safe = set_combine(sets.engaged.MidDW.HighAcc.HeavyDef, {})

  sets.engaged.HighDW.Safe = set_combine(sets.engaged.HighDW.HeavyDef, {})
  sets.engaged.HighDW.LowAcc.Safe = set_combine(sets.engaged.HighDW.LowAcc.HeavyDef, {})
  sets.engaged.HighDW.MidAcc.Safe = set_combine(sets.engaged.HighDW.MidAcc.HeavyDef, {})
  sets.engaged.HighDW.HighAcc.Safe = set_combine(sets.engaged.HighDW.HighAcc.HeavyDef, {})

  sets.engaged.SuperDW.Safe = set_combine(sets.engaged.SuperDW.HeavyDef, {})
  sets.engaged.SuperDW.LowAcc.Safe = set_combine(sets.engaged.SuperDW.LowAcc.HeavyDef, {})
  sets.engaged.SuperDW.MidAcc.Safe = set_combine(sets.engaged.SuperDW.MidAcc.HeavyDef, {})
  sets.engaged.SuperDW.HighAcc.Safe = set_combine(sets.engaged.SuperDW.HighAcc.HeavyDef, {})

  sets.engaged.MaxDW.Safe = set_combine(sets.engaged.MaxDW.HeavyDef, {})
  sets.engaged.MaxDW.LowAcc.Safe = set_combine(sets.engaged.MaxDW.LowAcc.HeavyDef, {})
  sets.engaged.MaxDW.MidAcc.Safe = set_combine(sets.engaged.MaxDW.MidAcc.HeavyDef, {})
  sets.engaged.MaxDW.HighAcc.Safe = set_combine(sets.engaged.MaxDW.HighAcc.HeavyDef, {})
  
  sets.engaged.SubtleBlow = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",    -- [ 6/ 6, 123]
    body="Malignance Tabard",     -- [ 9/ 9, 139]
    hands="Malignance Gloves",    -- [ 5/ 5, 112]
    legs="Malignance Tights",     -- [ 7/ 7, 150]
    feet="Malignance Boots",      -- [ 4/ 4, 150]
    neck="Bathy Choker +1",       -- [__/__, ___] __, 11
    ear1="Cessance Earring",      -- [__/__, ___]
    ear2="Dignitary's Earring",   -- [__/__, ___] __,  5
    ring1="Chirich Ring +1",      -- [__/__, ___] __, 10
    ring2="Defending Ring",       -- [10/10, ___]
    back=gear.COR_TP_Cape,        -- [10/__, ___]
    -- waist="Windbuffet Belt +1",   -- [__/__, ___]
  } -- [51 PDT/41 MDT, 674 MEVA] 0 DW, 26 Subtle Blow
  sets.engaged.LowDW.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.MidDW.SubtleBlow = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",    -- [ 6/ 6, 123]
    body="Malignance Tabard",     -- [ 9/ 9, 139]
    hands="Malignance Gloves",    -- [ 5/ 5, 112]
    legs="Malignance Tights",     -- [ 7/ 7, 150]
    feet="Malignance Boots",      -- [ 4/ 4, 150]
    neck="Bathy Choker +1",       -- [__/__, ___] __, 11
    ear1="Dignitary's Earring",   -- [__/__, ___] __,  5
    ear2="Eabani Earring",        -- [__/__, ___]  4, __
    ring1="Chirich Ring +1",      -- [__/__, ___] __, 10
    ring2="Defending Ring",       -- [10/10, ___]
    -- back=gear.COR_DW_Cape,        -- [10/__, ___] 10
    waist="Reiki Yotai",          -- [__/__, ___]  7
  } -- [51 PDT/41 MDT, 674 MEVA] 21 DW, 26 Subtle Blow
  sets.engaged.HighDW.SubtleBlow = set_combine(sets.engaged.MidDW.SubtleBlow, {})
  sets.engaged.SuperDW.SubtleBlow = set_combine(sets.engaged.MidDW.SubtleBlow, {})
  sets.engaged.MaxDW.SubtleBlow = set_combine(sets.engaged.MidDW.SubtleBlow, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
  end

  -- Gear
  if spell.type == 'CorsairRoll' then
    -- Check RollMode to determine whether or not to equip duration set.
    -- The duration set causes weapons to swap which drops all your TP so not always desirable.
    if (state.RollMode.value == 'Adaptive' and player.status ~= 'Engaged')
        or state.RollMode.value == 'Always Rostam' then
      equip(sets.precast.CorsairRoll.Duration)
    end
    if state.LuzafRing.value then
      equip(sets.precast.LuzafRing)
    end
  end

  if spell.english == 'Fold' and buffactive['Bust'] == 2 then
    if sets.precast.FoldDoubleBust then
      equip(sets.precast.FoldDoubleBust)
      eventArgs.handled = true
    end
  end
  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    if state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef' then
      if flurry == 0 then
        equip(sets.precast.RA.Safe)
      elseif flurry == 1 then
        equip(sets.precast.RA.Flurry1.Safe)
      elseif flurry == 2 then
        equip(sets.precast.RA.Flurry2.Safe)
      end
    else
      if flurry == 0 then
        equip(sets.precast.RA)
      elseif flurry == 1 then
        equip(sets.precast.RA.Flurry1)
      elseif flurry == 2 then
        equip(sets.precast.RA.Flurry2)
      end
    end
  elseif spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  elseif spell.type == 'CorsairShot' and (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
    -- Equip corsair shot set
    if state.QDMode.value == 'Enhance' then
      equip(sets.precast.CorsairShot.Enhance)
    elseif state.QDMode.value == 'STP' then
      equip(sets.precast.CorsairShot.STP)
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

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    -- Equip safe sets if available
    if buffactive['Triple Shot'] and ((player.equipment.ranged == 'Armageddon' and buffactive['Aftermath: Lv.3']) or state.CritMode.current == 'on') then
      if (state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef') and sets.TripleShot.Critical.Safe then
        equip(sets.TripleShot.Critical.Safe)
      else
        equip(sets.TripleShot.Critical)
      end
    elseif buffactive['Triple Shot'] then
      if (state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef') and sets.TripleShot.Safe then
        equip(sets.TripleShot.Safe)
      else
        equip(sets.TripleShot)
      end
    elseif (player.equipment.ranged == 'Armageddon' and buffactive['Aftermath: Lv.3']) or state.CritMode.current == 'on' then
      if (state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef') and sets.midcast.RA.Critical.Safe then
        equip(sets.midcast.RA.Critical.Safe)
      else
        equip(sets.midcast.RA.Critical)
      end
    else
      if (state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef') and sets.midcast.RA[state.RangedMode.value] and sets.midcast.RA[state.RangedMode.value].Safe then
        equip(sets.midcast.RA[state.RangedMode.value].Safe)
      elseif (state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'HeavyDef') and sets.midcast.RA.Safe then
        equip(sets.midcast.RA.Safe)
      elseif sets.midcast.RA[state.RangedMode.value] then
        equip(sets.midcast.RA[state.RangedMode.value])
      else
        equip(sets.midcast.RA)
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.english == "Light Shot" then
    send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
  if S{'flurry'}:contains(buff:lower()) then
    if not gain then
      flurry = nil
    end
    if not silibs.midaction() then
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  silibs.update_combat_form()
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

-- Modify the default idle set after it was constructed.
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

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
  if spell.type == 'CorsairShot' then
    if state.IgnoreTargetting.value == true then
      state.IgnoreTargetting:reset()
      eventArgs.handled = true
    end

    eventArgs.SelectNPCTargets = state.SelectqdTarget.value
  end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

  local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'

  local e_msg = state.Mainqd.current
  if state.UseAltqd.value == true then
    e_msg = e_msg .. '/'..state.Altqd.current
  end

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local r_msg = state.RollMode.value

  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Rolls: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
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
      elseif isRefreshing==false and player.mpp < 80 then
        classes.CustomIdleGroups:append('Refresh')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.raw_register_event('action',
  function(act)
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
  end
)

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1] == 'qd' then
    if cmdParams[2] == 't' then
      state.IgnoreTargetting:set()
    end

    local doqd = ''
    if state.UseAltqd.value == true then
      doqd = state[state.Currentqd.current..'qd'].current
      state.Currentqd:cycle()
    else
      doqd = state.Mainqd.current
    end

    send_command('@input /ja "'..doqd..'" <t>')
  elseif cmdParams[1] == 'equipweapons' then
    equip(select_weapons())
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_weapons('set', cmdParams[3])
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_toy_weapons('set', cmdParams[3])
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds:schedule(2)
    set_sub_keybinds:schedule(2)
    print('Set keybinds!')
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
  if locked_waist then equip({ waist=empty }) end
  job_handle_equipping_gear()
end)

function cycle_weapons(cycle_dir, set_name)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'set' then
    state.WeaponSet:set(set_name)
  else
    state.WeaponSet:reset()
  end
  state.ToyWeapons:reset()

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_toy_weapons(cycle_dir, set_name)
  if cycle_dir == 'forward' then
    state.ToyWeapons:cycle()
  elseif cycle_dir == 'back' then
    state.ToyWeapons:cycleback()
  elseif cycle_dir == 'set' then
    state.ToyWeapons:set(set_name)
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

function select_weapons()
  local weapons_to_equip = {}
  local can_dw = silibs.can_dual_wield()
  if state.ToyWeapons.current ~= 'None' then
    weapons_to_equip = set_combine(sets.ToyWeapon[state.ToyWeapons.current], {})
  else
    if can_dw and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current].DW, {})
    elseif sets.WeaponSet[state.WeaponSet.current] then
      weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current], {})
    end
  end

  -- If trying to equip weapon in offhand but cannot DW, equip empty
  if not can_dw and weapons_to_equip.sub and silibs.is_weapon(weapons_to_equip.sub) then
    local sub_to_use = sets.FallbackShield and sets.FallbackShield.sub or 'empty'
    weapons_to_equip = set_combine(weapons_to_equip, {sub=sub_to_use})
  end

  -- Equip appropriate ammo
  local range_weapon_name = weapons_to_equip.ranged or weapons_to_equip.range
  if range_weapon_name and silibs.is_weapon(range_weapon_name) and silibs.ammo_assignment then
    local ammo_map = silibs.ammo_assignment['Gun_or_Cannon']
    if ammo_map then
      local default_ammo = ammo_map.Default
      if default_ammo then
        if silibs.has_item(default_ammo, silibs.equippable_bags) then
          weapons_to_equip.ammo = default_ammo
        else
          add_to_chat(3, default_ammo..' ammo unavailable. Leaving empty.')
        end
      else
        add_to_chat(3, 'Default ammo not defined for '..range_type..'.')
      end
    end
  else
    weapons_to_equip.ammo = 'empty'
  end

  return weapons_to_equip
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(1, 17)
end

function set_main_keybinds()
  local main_keybinds = job_keybinds['main']
  if main_keybinds then
    for key,cmd in pairs(main_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end

  construct_unbind_command()
end

function set_sub_keybinds()
  local sub_keybinds = job_keybinds[player.sub_job]
  if sub_keybinds then
    for key,cmd in pairs(sub_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end
end

function construct_unbind_command()
  local commands = L{}
  local main_keybinds = job_keybinds['main']
  local sub_keybinds = job_keybinds[player.sub_job]
  if main_keybinds then
    for key in pairs(main_keybinds) do
      commands:append(('unbind %s'):format(key))
    end
  end
  if sub_keybinds then
    for key in pairs(sub_keybinds) do
      commands:append(('unbind %s'):format(key))
    end
  end
  unbind_command = commands:concat(';')
end

function unbind_keybinds()
  windower.send_command(unbind_command)
end

function test()
end
