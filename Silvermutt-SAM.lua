-- File Status: Good. Missing acc sets.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: N/A
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable RollTracker

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
  silibs.enable_auto_lockstyle(7)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'HeavyDef', 'SubtleBlow')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(true, "Attack Capped")

  state.CP = M(false, 'Capacity Points Mode')
  state.ToyWeapons = M{['description']='Toy Weapons','None','GreatKatana','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Masa', 'Doji', 'Shining One'}
  state.EnmityMode = M{['description']='Enmity Mode', 'Normal', 'Low', 'Schere'}

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  update_melee_groups()

  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}

  -- Enmity sets
  sets.Enmity = {
    head="Loess Barbuta +1",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    ear1="Cryptic Earring",
    ear2="Trux Earring",
    ring1="Supershear Ring",
    ring2="Eihwaz Ring",
    -- ammo="Sapience Orb",
    -- legs=gear.Valorous_Enmity_legs,
    -- feet=gear.Valorous_Enmity_feet,
    -- neck="Unmoving Collar +1",
    -- back=gear.SAM_Enmity_Cape,
    -- waist="Trance Belt",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    hands=gear.Leyline_Gloves, --8
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ring2="Prolix Ring", --2
    -- body="Sacro Breastplate", --10
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

  -- Precast sets to enhance JAs on use
  sets.precast.JA['Meikyo Shisui'] = {
    feet="Sakonji Sune-ate +1",
    -- feet="Sakonji Sune-ate +3",
  }

  sets.precast.JA['Warding Circle'] = {
    head="Wakido Kabuto +2",
    -- head="Wakido Kabuto +3",
  }

  sets.precast.JA['Third Eye'] = {
    legs="Sakonji Haidate +1",
    -- legs="Sakonji Haidate +3",
  }

  sets.precast.JA['Meditate'] = {
    head="Wakido Kabuto +2",
    hands="Sakonji Kote +1",
    back="Smertrios's Mantle",
    -- head="Wakido Kabuto +3",
    -- hands="Sakonji Kote +3",
  }

  sets.precast.JA['Seigan'] = {
    head="Kasuga Kabuto +2",
  }

  sets.precast.JA['Sekkanoki'] = {
    hands="Kasuga Kote +1",
  }

  sets.precast.JA['Shikikoyo'] = {
    legs="Sakonji Haidate +1",
    -- legs="Sakonji Haidate +3",
  }

  sets.precast.JA['Blade Bash'] = {
    hands="Sakonji Kote +1",
    -- hands="Sakonji Kote +3",
  }

  sets.precast.JA['Sengikori'] = {
    feet="Kasuga Sune-ate +1",
  }

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }
  sets.precast.Step = {
    head="Flam. Zucchetto +2",
    body=gear.Nyame_B_body,
    hands="Flam. Manopolas +2",
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Dignitary's Earring",
    ear2="Telos Earring",
    ring1="Ephramad's Ring",
    ring2="Chirich Ring +1",
    back=gear.stp_jse_back,
    waist="Olseni Belt",
    -- ear1="Schere Earring", -- R20+
  }
  sets.precast.Flourish1 = {
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    ring1="Sroda Ring",
    ring2="Epaminondas's Ring",
    back=gear.SAM_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    
    -- hands="Kasuga Kote +3",
    -- ear2="Kasuga Earring +2",
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,
    ear1="Thrud Earring",
    ear2="Kasuga Earring +1",

    -- ear2="Kasuga Earring +2",
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",
    legs="Mpaca's Hose",
    ring2="Ephramad's Ring",

    -- feet="Kasuga Sune-Ate +3",
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    head=gear.Nyame_B_head,
    ear1="Thrud Earring",
    ear2="Kasuga Earring +1",

    -- ear2="Kasuga Earring +2",
  })

  -- 80% STR; dmg varies with TP
  sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Fudo'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Fudo'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 80% STR; STP scales with TP (aftermath effect)
  sets.precast.WS['Tachi: Kaiten'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Kaiten'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Kaiten'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Kaiten'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 75% STR; dmg varies with TP
  sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Gekko'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Gekko'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Gekko'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 75% STR; dmg varies with TP
  sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Yukikaze'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Yukikaze'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Yukikaze'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 75% STR; dmg varies with TP
  sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Kasha'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Kasha'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Kasha'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 85% STR; 2 hit, dmg varies with TP
  sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Thrud Earring",
    ring1="Niqmaddu Ring",
    ring2="Epaminondas's Ring",
    back=gear.SAM_STR_WSD_Cape,
    waist="Sailfi Belt +1",
    
    -- ear2="Kasuga Earring +2",
  })
  sets.precast.WS['Tachi: Shoha'].MaxTP = set_combine(sets.precast.WS['Tachi: Shoha'], {
    ear1="Schere Earring",
    ear2="Thrud Earring",
    
    -- ear1="Thrud Earring",
    -- ear2="Kasuga Earring +2",
  })
  sets.precast.WS['Tachi: Shoha'].AttCapped = set_combine(sets.precast.WS['Tachi: Shoha'], {
    ammo="Crepuscular Pebble",
    legs="Mpaca's Hose",
    ring1="Sroda Ring",
    ring2="Ephramad's Ring",

    -- feet="Kasuga Sune-Ate +3",
  })
  sets.precast.WS['Tachi: Shoha'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Shoha'].AttCapped, {
    head=gear.Nyame_B_head,
    ear1="Schere Earring",
    ear2="Thrud Earring",
    
    -- ear1="Thrud Earring",
    -- ear2="Kasuga Earring +2",
  })

  -- 50% STR; 3 hit, acc varies with TP
  sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS['Tachi: Shoha'].MaxTP, {})
  sets.precast.WS['Tachi: Rana'].MaxTP = set_combine(sets.precast.WS['Tachi: Shoha'].MaxTP, {})
  sets.precast.WS['Tachi: Rana'].AttCapped = set_combine(sets.precast.WS['Tachi: Shoha'].AttCappedMaxTP, {})
  sets.precast.WS['Tachi: Rana'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Shoha'].AttCappedMaxTP, {})

  -- 30% STR; 2 hit, hybrid wind elemental, dmg varies with TP
  sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Sroda Ring",
    ring2="Epaminondas's Ring",
    back=gear.SAM_STR_WSD_Cape,
    waist="Orpheus's Sash",
  })
  sets.precast.WS['Tachi: Jinpu'].MaxTP = set_combine(sets.precast.WS['Tachi: Jinpu'], {
    ear1="Novio Earring",
  })
  sets.precast.WS['Tachi: Jinpu'].AttCapped = set_combine(sets.precast.WS['Tachi: Jinpu'], {
    ring2="Ephramad's Ring",
  })
  sets.precast.WS['Tachi: Jinpu'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Jinpu'].MaxTP, {})

  -- 60% CHR / 40% STR; More important to stack magic acc to ensure the defense down effect lands
  sets.precast.WS['Tachi: Ageha'] = {
    ammo="Pemphredo Tathlum",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands="Mpaca's Gloves",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Samurai's Nodowa +2",
    ear1="Dignitary's Earring",
    ear2="Kasuga Earring +1",
    ring1="Metamorph Ring +1",
    ring2="Stikini Ring +1",
    back=gear.SAM_TP_Cape,
    waist="Eschan Stone",

    -- body="Kasuga Domaru +3",
    -- hands="Kasuga Kote +3",
    -- legs="Kasuga Haidate +3",
    -- feet="Kasuga Sune-Ate +3",
    -- neck="Sanctity Necklace",
  }

  -- Polearm sets use a crit build since you should be using Shining One
  -- 100% STR; 2 hit, dmg varies with TP
  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Ryuo_A_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Schere Earring",
    ring1="Niqmaddu Ring",
    ring2="Epaminondas's Ring",
    back=gear.SAM_STR_WSD_Cape,
    waist="Sailfi belt +1",

    -- hands="Kasuga Kote +3",
    -- ear2="Kasuga Earring +2",
    -- back=gear.SAM_Crit_Cape,
  })
  sets.precast.WS['Impulse Drive'].MaxTP = set_combine(sets.precast.WS['Impulse Drive'], {
    head=gear.Nyame_B_head,
    ear1="Thrud Earring",
    ear2="Schere Earring",
    
    -- ear1="Schere Earring",
    -- ear2="Kasuga Earring +2",
  })
  sets.precast.WS['Impulse Drive'].AttCapped = set_combine(sets.precast.WS['Impulse Drive'], {
    ammo="Crepuscular Pebble",
    legs="Mpaca's Hose",
    ring2="Sroda Ring",

    -- feet="Kasuga Sune-Ate +3",
  })
  sets.precast.WS['Impulse Drive'].AttCappedMaxTP = set_combine(sets.precast.WS['Impulse Drive'].AttCapped, {
    head=gear.Nyame_B_head,
    ear1="Thrud Earring",
    ear2="Schere Earring",
    
    -- ear1="Schere Earring",
    -- ear2="Kasuga Earring +2",
  })

  -- 40% STR / 40% DEX; aoe, dmg varies with TP
  sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS['Impulse Drive'], {})
  sets.precast.WS['Sonic Thrust'].MaxTP = set_combine(sets.precast.WS['Impulse Drive'].MaxTP, {})
  sets.precast.WS['Sonic Thrust'].AttCapped = set_combine(sets.precast.WS['Impulse Drive'].AttCapped, {})
  sets.precast.WS['Sonic Thrust'].AttCappedMaxTP = set_combine(sets.precast.WS['Impulse Drive'].AttCappedMaxTP, {})

  -- 85% STR; 4 hit, dmg varies with TP
  sets.precast.WS['Stardiver'] = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body="Tatenashi Haramaki +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Samurai's Nodowa +2",
    ear1="Schere Earring",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    ring2="Ephramad's Ring",
    back=gear.SAM_STR_WSD_Cape,
    waist="Fotia Belt",

    -- feet=gear.Valo_Crit_feet,
    -- back=gear.SAM_STR_DA_Cape,
  }
  sets.precast.WS['Stardiver'].MaxTP = set_combine(sets.precast.WS['Stardiver'], {
    head=gear.Nyame_B_head,
    ear2="Thrud Earring",

    -- ear2="Kasuga Earring +2",
  })
  sets.precast.WS['Stardiver'].AttCapped = set_combine(sets.precast.WS['Stardiver'], {
    ammo="Crepuscular Pebble",
    ring2="Sroda Ring",

    -- feet="Kasuga Sune-Ate +3",
  })
  sets.precast.WS['Stardiver'].AttCappedMaxTP = set_combine(sets.precast.WS['Stardiver'].AttCapped, {
    head=gear.Nyame_B_head,
    ear2="Thrud Earring",

    -- ear2="Kasuga Earring +2",
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
    ammo="Coiste Bodhar",       -- __/__, ___
    head=gear.Nyame_B_head,     --  7/ 7, 123
    body=gear.Nyame_B_body,     --  9/ 9, 139
    hands=gear.Nyame_B_hands,   --  7/ 7, 112
    legs=gear.Nyame_B_legs,     --  8/ 8, 150
    feet=gear.Nyame_B_feet,     --  7/ 7, 150
    neck="Samurai's Nodowa +2", -- __/__, ___
    ear1="Arete Del Luna +1",   -- __/__, ___; Resists
    ear2="Hearty Earring",      -- __/__, ___; Resist all +5
    ring1="Niqmaddu Ring",      -- __/__, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.SAM_TP_Cape,      -- 10/__, ___
    waist="Ioskeha Belt +1",    -- __/__, ___
    --58 PDT/48 MDT, 674 MEVA
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Valorous Mask",       -- 3
    -- head="Wakido Kabuto +3", -- 4
  }
  sets.latent_regen = {
    body="Hizamaru Haramaki +2",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    -- hands="Rao Kote +1",
    -- legs="Rao Haidate +1",
    -- feet="Rao Sune-Ate +1",
    -- ring2="Chirich Ring +1",
    -- body="Sacro Breastplate", --10
  }
  sets.latent_refresh = {
    -- ring1="Stikini Ring +1", -- 1
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

  sets.engaged = {
    ammo="Coiste Bodhar",             -- [__/__, ___] __,  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53] __,  6 <__,  5, __> __,  4
    body="Mpaca's Doublet",           -- [10/__,  86] __,  8 <__,  4, __>  7,  4
    hands="Mpaca's Gloves",           -- [ 8/__,  59] __, __ <__,  4, __>  5,  4; TA Dmg+9%
    legs="Kasuga Haidate +2",         -- [10/10, 120]  3, 10 <__, __, __> __,  5
    feet="Mpaca's Boots",             -- [ 6/__,  96] __, __ <__,  3, __>  3,  3
    neck="Samurai's Nodowa +2",       -- [__/__, ___] __, 14 <__, __, __> __, __
    ear1="Dedition Earring",          -- [__/__, ___] __,  8 <__, __, __> __, __
    ear2="Kasuga Earring +1",         -- [__/__, ___] __,  8 <__, __, __> __, __
    ring1="Chirich Ring +1",          -- [__/__, ___] __,  6 <__, __, __> __, __
    ring2="Defending Ring",           -- [10/10, ___] __, __ <__, __, __> __, __
    back=gear.SAM_TP_Cape,            -- [10/__, ___] __, __ <10, __, __> __, __
    waist="Sailfi Belt +1",           -- [__/__, ___] __, __ < 5,  2, __> __,  9
    -- [54 PDT/20 MDT, 414 MEVA] 3 Hasso, 63 STP <18 DA, 18 TA, 0 QA> 15 Crit Rate, 29 Haste

    -- legs="Kasuga Haidate +3",      -- [11/11, 130]  3, 11 <__, __, __> __,  5
    -- ear2="Kasuga Earring +2",      -- [__/__, ___] __,  9 <__, __, __> __, __
    -- [55 PDT/21 MDT, 424 MEVA] 3 Hasso, 65 STP <18 DA, 18 TA, 0 QA> 15 Crit Rate, 29 Haste
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {})
  sets.engaged.MidAcc = set_combine(sets.engaged, {})
  sets.engaged.HighAcc = set_combine(sets.engaged, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------


  sets.engaged.HeavyDef = {
    ammo="Coiste Bodhar",             -- [__/__, ___] __,  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53] __,  6 <__,  5, __> __,  4
    body="Mpaca's Doublet",           -- [10/__,  86] __,  8 <__,  4, __>  7,  4
    hands=gear.Nyame_B_hands,         -- [ 7/ 7, 112] __, __ < 5, __, __> __,  3
    legs="Kasuga Haidate +2",         -- [10/10, 120]  3, 10 <__, __, __> __,  5
    feet="Mpaca's Boots",             -- [ 6/__,  96] __, __ <__,  3, __>  3,  3
    neck="Samurai's Nodowa +2",       -- [__/__, ___] __, 14 <__, __, __> __, __
    ear1="Dedition Earring",          -- [__/__, ___] __,  8 <__, __, __> __, __
    ear2="Kasuga Earring +1",         -- [__/__, ___] __,  8 <__, __, __> __, __
    ring1="Niqmaddu Ring",            -- [__/__, ___] __, __ <__, __,  3> __, __
    ring2="Defending Ring",           -- [10/10, ___] __, __ <__, __, __> __, __
    back=gear.SAM_TP_Cape,            -- [10/__, ___] __, __ <10, __, __> __, __
    waist="Sailfi Belt +1",           -- [__/__, ___] __, __ < 5,  2, __> __,  9
    -- [53 PDT/27 MDT, 467 MEVA] 3 Hasso, 57 STP <23 DA, 14 TA, 3 DA> 10 Crit Rate, 28 Haste

    -- legs="Kasuga Haidate +3",      -- [11/11, 130]  3, 11 <__, __, __> __,  5
    -- ear2="Kasuga Earring +2",      -- [__/__, ___] __,  9 <__, __, __> __, __
    -- [54 PDT/28 MDT, 477 MEVA] 3 Hasso, 59 STP <23 DA, 14 TA, 3 QA> 10 Crit Rate, 28 Haste
  }
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})

  sets.engaged.SubtleBlow = {
    ammo="Crepuscular Pebble",        -- [ 3/ 3, ___] __, __ <__, __, __> __, __, __(__)
    head="Kasuga Kabuto +2",          -- [ 9/ 9,  88] __, 11 <__, __, __> __,  7, __(__)
    body="Dagon Breastplate",         -- [__/__,  86] __, __ <__,  5, __>  4,  1, __(10)
    hands=gear.Nyame_B_hands,         -- [ 7/ 7, 112] __, __ < 5, __, __> __,  3, __(__)
    legs="Mpaca's Hose",              -- [ 9/__, 106] __, __ <__,  4, __>  6,  9, __( 5)
    feet="Kendatsuba Sune-Ate +1",    -- [__/__, 139] __, __ <__,  4, __>  5,  3,  8(__)
    neck="Bathy Choker +1",           -- [__/__, ___] __, __ <__, __, __> __, __, 11(__)
    ear1="Dignitary's Earring",       -- [__/__, ___] __,  3 <__, __, __> __, __,  5(__)
    ear2="Odnowa Earring +1",         -- [ 3/ 5, ___] __, __ <__, __, __> __, __, __(__)
    ring1="Defending Ring",           -- [10/10, ___] __, __ <__, __, __> __, __, __(__)
    ring2="Niqmaddu Ring",            -- [__/__, ___] __, __ <__, __,  3> __, __, __( 5)
    back=gear.SAM_TP_Cape,            -- [10/__, ___] __, __ <10, __, __> __, __, __(__)
    waist="Peiste Belt +1",           -- [__/__, ___] __, __ <__, __, __> __, __, 10(__)
    -- [51 PDT/34 MDT, 531 MEVA] 0 Hasso, 14 STP <15 DA, 13 TA, 3 QA> 15 Crit Rate, 23 Haste, 34(20) Subtle Blow
    
    -- head="Kasuga Kabuto +3",       -- [10/10,  98] __, 12 <__, __, __> __,  7, __(__)
    -- [52 PDT/35 MDT, 541 MEVA] 0 Hasso, 15 STP <15 DA, 13 TA, 3 QA> 15 Crit Rate, 23 Haste, 34(20) Subtle Blow
  }
  sets.engaged.LowAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.MidAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.HighAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})

  -----------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }
  sets.Special.LowEnmity = { ear2="Novia Earring", } -- Assumes -Enmity merits and Dirge
  sets.Special.Schere = { ear2="Schere Earring", }

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.Kiting = {
    feet="Danzo Sune-Ate",
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
  sets.WeaponSet['Doji'] = {main="Dojikiri Yasutsuna", sub="Utu Grip"}
  sets.WeaponSet['Masa'] = {main="Masamune", sub="Utu Grip"}
  sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip"}
  -- sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip"}
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
  classes.CustomMeleeGroups:clear()

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.SleepyHead)
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
  update_melee_groups()
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
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

  add_to_chat(002, '| '
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
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
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

  -- TODO: Update for WAR buffs/traits
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
    meleeSet = set_combine(meleeSet, sets.Special.SleepyHead)
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
    defenseSet = set_combine(defenseSet, sets.Special.SleepyHead)
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
  classes.CustomMeleeGroups:clear()
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
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
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
  set_macro_page(2, 10)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !e input /ja "Hasso" <me>')
  send_command('bind !q input /ja "Meditate" <me>')
end

function set_sub_keybinds()
  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^f8')
  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

function test()
end
