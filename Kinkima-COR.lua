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
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


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
    send_command('gs c equipweapons')
    send_command('gs c equiprangedweapons')
  end, 2)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(1)
  silibs.enable_premade_commands()
  silibs.enable_th()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Safe', 'SubtleBlow', 'Normal')
  state.RangedMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.IdleMode:options('Normal', 'HeavyDef')

  state.WeaponSet = M{['description']='Weapon Set', 'Savage Blade', 'Cleaving', 'DeathPenalty_M', 'DeathPenalty_R', 'Fomalhaut_M', 'Fomalhaut_R', 'QuickDraw'}

  state.CP = M(false, "Capacity Points Mode")

  -- QuickDraw Selector
  state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.UseAltqd = M(false, 'Use Secondary Shot')
  state.SelectqdTarget = M(false, 'Select Quick Draw Target')
  state.IgnoreTargetting = M(false, 'Ignore Targetting')
  state.QDMode = M{['description']='Quick Draw Mode', 'Potency', 'STP', 'Enhance'}
  state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}
  state.CritMode = M(false, 'Crit')

  -- Whether to use Luzaf's Ring
  state.LuzafRing = M(true, "Luzaf's Ring")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}
  no_swap_waists = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver", "Liv. Bul. Pouch"}

  gear.RAbullet = "Chrono Bullet"
  gear.RAccbullet = "Devastating Bullet"
  gear.WSbullet = "Chrono Bullet"
  gear.MAbullet = "Living Bullet"
  gear.QDbullet = "Hauksbok Bullet"
  options.ammo_warning_limit = 10

  -- Update DistancePlus addon with weapon type
  -- Corsair only uses guns for ranged weapons
  send_command('dp gun')

  define_roll_values()

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

  send_command('bind ^\\\\ gs c cycle QDMode')
  send_command('bind ^[ gs c cycleback mainqd')
  send_command('bind ^] gs c cycle mainqd')
  send_command('bind ^; gs c cycleback altqd')
  send_command('bind ^\' gs c cycle altqd')
  send_command('bind ^p c toggle selectqdtarget')
  send_command('bind ^l gs c toggle usealtqd')
  send_command('bind @` gs c toggle LuzafRing')
  send_command('bind ^/ gs c toggle critmode')

  send_command('bind !q input /ja "Double-up" <me>')
  send_command('bind !` input /ja "Bolter\'s Roll" <me>')
  send_command('bind !e input /ja "Random Deal" <me>')
  send_command('bind ^numlock input /ja "Triple Shot" <me>')
  send_command('bind %numpad0 input /ra <t>')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  Haste = 0
  DW_needed = 0
  DW = false
  current_dp_type = nil -- Do not modify
  locked_waist = false -- Do not modify

  -- Additional local binds
  include('Global-Binds.lua')

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
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

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^\\\\')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ^;')
  send_command('unbind ^\'')
  send_command('unbind ^p')
  send_command('unbind ^l')
  send_command('unbind @`')

  send_command('unbind !q')
  send_command('unbind !`')
  send_command('unbind !e')
  send_command('unbind ^numlock')
  send_command('unbind %numpad0')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}
  sets.org.job[1] = {ammo=gear.RAbullet}
  sets.org.job[2] = {ammo=gear.RAccbullet}
  sets.org.job[3] = {ammo=gear.WSbullet}
  sets.org.job[4] = {ammo=gear.MAbullet}
  sets.org.job[5] = {ammo=gear.QDbullet}
  sets.org.job[6] = {waist="Chrono bullet pouch"}
  sets.org.job[7] = {waist="Devastating Bullet Pouch"}
  sets.org.job[8] = {waist="Living Bullet Pouch"}

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  sets.precast.JA['Snake Eye'] = {
    -- legs="Lanun Trews +1",
    -- legs="Lanun Trews +3",
  }
  sets.precast.JA['Wild Card'] = {
    -- feet="Lanun Bottes +3",
}
  sets.precast.JA['Random Deal'] = {
    -- body="Lanun Frac +3",
}

  -- DT > PR Potency > PR Duration; PR Potency does not stack, uses highest piece
  sets.precast.CorsairRoll = {
    -- head="Lanun Tricorne +1",       -- __/__,  36 (__, __); 50% chance of job align bonus
    body="Malignance Tabard",       --  9/ 9, 139 (__, __)
    -- hands="Chasseur's Gants +1",    -- __/__,  43 (__, 50)
    legs=gear.Nyame_B_legs,         --  8/ 8, 150 (__, __)
    feet=gear.Nyame_B_feet,         --  7/ 7, 150 (__, __)
    neck="Regal Necklace",          -- __/__, ___ ( 7, 20)
    -- ear1="Genmei Earring",          --  2/__, ___ (__, __)
    ear2="Etiolation Earring",      -- __/ 3, ___ (__, __)
    ring1="Luzaf's Ring",           -- __/__, ___ (__, __); Double PR range
    ring2="Defending Ring",         -- 10/10, ___ (__, __)
    -- back=gear.COR_TP_Cape,          -- 10/__, ___ (__, 30)
    waist="Flume Belt +1",          --  4/__, ___ (__, __)

    -- head="Lanun Tricorne +3",    -- __/__,  73 (__, __); 50% chance of job align bonus
    -- hands="Chasseur's Gants +2", -- __/__,  83 (__, 55)
    -- legs="Desultor Tassets",     -- __/__, ___ (__, __); PR Delay -5
    -- 45 PDT / 31 MDT, 445 M.Eva (7 PR Potency, 105 PR Duration)
  } -- 50 PDT / 37 MDT, 518 M.Eva (7 PR Potency, 100 PR Duration)

  sets.precast.CorsairRoll.Duration = {
    -- main="Rostam",
    -- range="Compensator",
  }
  sets.precast.CorsairRoll.LowerDelay = {
    -- back=gear.COR_Adoulin_Cape,
  }
  sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- legs="Chasseur's Culottes +1",
  })
  sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- feet="Chasseur's Bottes +1",
  })
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- head="Chasseur's Tricorne +1",
  })
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- body="Chasseur's Frac +1",
  })
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- hands="Chasseur's Gants +1",
  })

  sets.precast.LuzafRing = {
    ring1="Luzaf's Ring",
  }
  sets.precast.FoldDoubleBust = {
    -- hands="Lanun Gants +3",
  }

  sets.precast.Waltz = {
    -- body="Passion Jacket",
    -- waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Carmine_D_feet, --8
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ring1="Prolix Ring", --2
    ring2="Kishar Ring", --4
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    -- body="Passion Jacket", --10
    -- neck="Magoraga Beads", --10
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    -- ring1="Weatherspoon Ring", --5
  })

  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA = {
    ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +1",    -- __/14 [__/__,  59]
    -- body="Oshosi Vest",               -- 12/__ [__/__,  96]
    -- hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    -- legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Commodore Charm +1",        --  3/__ [__/__, ___]
    -- ear1="Eabani Earring",            -- __/__ [__/__,   8]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",         --  3/__ [__/__, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,           -- 10/__ [__/__, ___]; Respec with PDT
    -- waist="Yemaya Belt",              -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    
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
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]; Respec with PDT
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
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]; Respec with PDT
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- 69 Snapshot / 75 Rapid Shot [37 PDT/24 MDT, 392 M.Eva]
  } -- 66 Snapshot / 73 Rapid Shot [16 PDT/15 MDT, 350 M.Eva]
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
    -- ammo=gear.RAbullet,
    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- body="Laksamana's Frac +3",    -- __/20 [__/__,  84]
    -- hands="Lanun Gants +3",        -- 13/__ [__/__,  57]
    -- legs=gear.Adhemar_D_legs,      -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",           -- 10/__ [ 3/__,  69]
    -- neck="Loricate Torque +1",     -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",         -- __/__ [ 2/__, ___]
    -- ear2="Odnowa Earring +1",      -- __/__ [ 3/ 5, ___]
    -- ring1="Crepuscular Ring",      --  3/__ [__/__, ___]
    -- ring2="Defending Ring",        -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]; Respec with PDT
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 1                          15/__
    -- 71 Snapshot / 84 Rapid Shot [43 PDT/30 MDT, 384 M.Eva]
  })
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
    hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    feet=gear.Pursuer_A_feet,         -- __/10 [__/__,  69]
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
    -- back=gear.COR_SNP_Cape,        -- 10/__ [__/__, ___]; Respec with PDT
    -- waist="Yemaya Belt",           -- __/ 5 [__/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 2                          30/__
    -- 74 Snapshot / 103 Rapid Shot [13 PDT/15 MDT, 338 M.Eva]
    
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
    -- back=gear.COR_SNP_Cape,        -- 10/__ [10/__, ___]; Respec with PDT
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
    -- legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Loricate Torque +1",        -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]; Respec with PDT
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
    -- legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    -- feet="Meg. Jam. +2",              -- 10/__ [ 3/__,  69]
    neck="Loricate Torque +1",        -- __/__ [ 6/ 6, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]; Respec with PDT
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
    -- hands=gear.Carmine_D_hands,       --  8/11 [__/__,  43]
    -- legs=gear.Adhemar_D_legs,         -- 10/13 [__/__,  75]
    -- feet=gear.Pursuer_A_feet,         -- __/10 [__/__,  69]
    neck="Commodore Charm +1",        --  3/__ [__/__, ___]
    -- ear1="Genmei Earring",            -- __/__ [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __/__ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __/__ [ 7/-1, ___]
    ring2="Defending Ring",           -- __/__ [10/10, ___]
    -- back=gear.COR_SNP_Cape,           -- 10/__ [10/__, ___]; Respec with PDT
    -- waist="Flume Belt +1",            -- __/__ [ 4/__, ___]
    -- Merits/Traits/Gifts               10/30
    -- Flurry 2                          30/__
    -- 71 Snapshot / 98 Rapid Shot [36 PDT/14 MDT, 330 M.Eva]

    -- head="Chasseur's Tricorne +2", -- __/16 [ 9/ 9,  99]
    -- 71 Snapshot / 100 Rapid Shot [45 PDT/23 MDT, 370 M.Eva]
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo=gear.WSbullet,
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    -- hands="Meg. Gloves +2",
    legs=gear.Nyame_B_legs,
    -- feet="Lanun Bottes +3",
    -- neck="Fotia Gorget",
    -- ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    -- ring1="Regal Ring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.COR_WS2_Cape,
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
    -- body="Ikenga's Vest",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    -- neck="Fotia Gorget",
    -- ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    -- ring1="Regal Ring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.COR_WS1_Cape,
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
    -- ring2="Hajduk Ring +1",
    -- waist="K. Kachina Belt +1",
  })
  sets.precast.WS['Last Stand'].HighAccMaxTP = set_combine(sets.precast.WS['Last Stand'].HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Wildfire'] = {
    ammo=gear.MAbullet,
    head=gear.Nyame_B_head, --30; WSD
    -- body="Lanun Frac +3", --61
    hands=gear.Nyame_B_hands, --30; WSD
    legs=gear.Nyame_B_legs, --30; WSD
    -- feet="Lanun Bottes +3", --55; WSD
    neck="Commodore Charm +1", --6
    ear1="Friomisi Earring", --10
    ear2="Novio Earring", --7
    ring1="Dingir Ring", --10
    -- ring2="Epaminondas's Ring",
    -- back=gear.COR_WS1_Cape, --0
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
    -- back=gear.COR_TP_Cape,
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
    -- head="Pixie Hairpin +1",
    ear2="Moonshade Earring",
    -- ring1="Archon Ring",
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

  sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
  sets.precast.WS['Hot Shot'].MaxTP = sets.precast.WS['Wildfire'].MaxTP
  sets.precast.WS['Hot Shot'].LowAcc = sets.precast.WS['Wildfire'].LowAcc
  sets.precast.WS['Hot Shot'].LowAccMaxTP = sets.precast.WS['Wildfire'].LowAccMaxTP
  sets.precast.WS['Hot Shot'].MidAcc = sets.precast.WS['Wildfire'].MidAcc
  sets.precast.WS['Hot Shot'].MidAccMaxTP = sets.precast.WS['Wildfire'].MidAccMaxTP
  sets.precast.WS['Hot Shot'].HighAcc = sets.precast.WS['Wildfire'].HighAcc
  sets.precast.WS['Hot Shot'].HighAccMaxTP = sets.precast.WS['Wildfire'].HighAccMaxTP

  sets.precast.WS['Evisceration'] = {
    -- head=gear.Adhemar_B_head,
    -- hands="Mummu Wrists +2",
    -- feet="Mummu Gamash. +2",
    -- neck="Fotia Gorget",
    -- ear1="Odr Earring",
    ear2="Moonshade Earring",
    -- ring1="Regal Ring",
    -- back=gear.COR_TP_Cape,
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
    -- head="Meghanada Visor +2",
    -- body=gear.Adhemar_B_body,
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Savage Blade'] = {
    head=gear.Nyame_B_head,       -- 26, 26, 60, 40, 10, __, ___
    -- body="Ikenga's Vest",         -- 33, 25, __, __, __,  7, 190
    hands=gear.Nyame_B_hands,     -- 17, 40, 60, 40, 10, __, ___
    legs=gear.Nyame_B_legs,       -- 43, 32, 60, 40, 11, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 60, 40, 10, __, ___
    neck="Commodore Charm +1",    -- 12, __, __, __, __, __, ___
    -- ear1="Ishvara Earring",       -- __, __, __, __,  2, __, ___
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    -- ring1="Sroda Ring",           -- 15, __, __, __, __,  3, ___
    -- ring2="Epaminondas's Ring",   -- __, __, __, __,  5, __, ___
    -- back=gear.COR_WS2_Cape,       -- 30, __, 20, 20, 10, __, ___
    -- waist="Sailfi Belt +1",       -- 15, __, 15, __, __, __, ___
    -- neck="Commodore Charm +2", -- 15, __, __, __, __, __, ___
    -- 217 STR, 149 MND, 275 Attack, 184 Accuracy, 58 WSD, 10 PDL, 440 TP Bonus
  } -- 214 STR, 149 MND, 275 Attack, 184 Accuracy, 58 WSD, 10 PDL, 440 TP Bonus
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
    -- ring1="Chirich Ring +1",
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
    -- body=gear.Adhemar_B_body,
    -- hands=gear.Adhemar_B_hands,
    -- legs="Meg. Chausses +2",
    -- feet=gear.Herc_TA_feet,
    -- neck="Fotia Gorget",
    -- ear1="Cessance Earring",
    -- ear2="Brutal Earring",
    -- ring1="Regal Ring",
    -- ring2="Epona's Ring",
    -- back=gear.COR_WS2_Cape,
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
    -- head="Meghanada Visor +2",
    -- hands=gear.Adhemar_A_hands,
    -- ear2="Telos Earring",
  })
  sets.precast.WS['Swift Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].HighAcc, {
  })

  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
    -- hands="Meg. Gloves +2",
    -- ear1="Telos Earring",
    ear2="Moonshade Earring",
    -- ring2="Rufescent Ring",
  }) --MND
  sets.precast.WS['Requiescat'].MaxTP = set_combine(sets.precast.WS['Requiescat'], {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].LowAcc = set_combine(sets.precast.WS['Requiescat'], {
  })
  sets.precast.WS['Requiescat'].LowAccMaxTP = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].MidAcc = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
  })
  sets.precast.WS['Requiescat'].MidAccMaxTP = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    -- head="Meghanada Visor +2",
    -- ear1="Cessance Earring",
  })
  sets.precast.WS['Requiescat'].HighAccMaxTP = set_combine(sets.precast.WS['Requiescat'].HighAcc, {
    -- ear2="Ishvara Earring",
  })

  sets.precast.WS['Sniper Shot'] = {
    ammo=gear.RAccbullet,
    head="Malignance Chapeau",    -- 33, 50
    -- body="Laksamana's Frac +3",   -- 45, 57
    hands="Malignance Gloves",    -- 24, 50
    legs="Malignance Tights",     -- 42, 50
    feet="Malignance Boots",      -- 49, 50
    -- neck="Iskur Gorget",          -- __, 30
    -- ear1="Beyla Earring",         -- __, 15
    -- ear2="Telos Earring",         -- __, 10
    -- ring1="Regal Ring",           -- 10, __
    -- ring2="Hajduk Ring +1",       -- __, 17
    -- back=gear.COR_RA_Cape,        -- 30, 20
    -- waist="Kwahu Kachina Belt +1",  --  8, 20
    -- legs="Laksamana's Trews +3", -- 33, 49
    -- AF+Regal set bonus           -- __, 30
  } -- 236 AGI, 360 R.Acc
  sets.precast.WS['Sniper Shot'].MaxTP = set_combine(sets.precast.WS['Sniper Shot'], {
  })
  sets.precast.WS['Sniper Shot'].LowAcc = set_combine(sets.precast.WS['Sniper Shot'], {
  })
  sets.precast.WS['Sniper Shot'].LowAccMaxTP = set_combine(sets.precast.WS['Sniper Shot'].LowAcc, {
  })
  sets.precast.WS['Sniper Shot'].MidAcc = set_combine(sets.precast.WS['Sniper Shot'].LowAcc, {
  })
  sets.precast.WS['Sniper Shot'].MidAccMaxTP = set_combine(sets.precast.WS['Sniper Shot'].MidAcc, {
  })
  sets.precast.WS['Sniper Shot'].HighAcc = set_combine(sets.precast.WS['Sniper Shot'].MidAcc, {
  })
  sets.precast.WS['Sniper Shot'].HighAccMaxTP = set_combine(sets.precast.WS['Sniper Shot'].HighAcc, {
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

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

  -- Ranged gear
  sets.midcast.RA = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    -- head="Ikenga's Hat",              -- 29,  8, 50/65 <__> {4} (__) [__/__,  96]
    -- body="Ikenga's Vest",             -- 39, 11, 50/65 <__> {7} (__) [__/__, 112]
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112]
    -- legs="Ikenga's Trousers",         -- 40, 10, 50/65 <__> {6} (__) [ 9/ 9, 123]
    feet="Malignance Boots",          -- 49,  9, 50/__ <__> {2} (__) [ 4/ 4, 150]
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    ear1="Enervating Earring",        -- __,  4,  7/ 7 <__> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    ring1="Dingir Ring",              -- 10, __, __/25 <__> {_} (10) [__/__, ___]
    -- ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___]
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="Yemaya Belt",              --  7,  4, 10/10 <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
  } -- 238 AGI, 86 STP, 347 racc/297 ratt <0 crit> {23 PDL} (68 Recycle) [28 PDT/18 MDT, 593 M.Eva]
  sets.midcast.RA.LowAcc = set_combine(sets.midcast.RA, {
    -- ear1="Beyla Earring",             -- __, __, 15/__ <__> {_} (__) [__/__, ___]
    -- ring2="Crepuscular Ring",         -- __,  6, 10/__ <__> {_} (__) [__/__, ___]
    -- ammo=gear.RAccbullet,          -- __, __, 35/__ <__> {_} (__) [__/__, ___]
    -- 228 AGI, 83 STP, 380 racc/290 ratt <0 crit> {23 PDL} (68 Recycle) [28 PDT/18 MDT, 593 M.Eva]
  })
  sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA.LowAcc, {
    body="Malignance Tabard",         -- 42, 11, 50/__ <__> {6} (__) [ 9/ 9, 139]
    -- legs=gear.Adhemar_C_legs,         -- 42,  8, 54/20 <__> {_} (16) [__/__,  75]
    -- ring1="Hajduk Ring +1",           -- __, __, 17/__ <__> {_} (__) [__/__, ___]
    -- 223 AGI, 81 STP, 401 racc/155 ratt <0 crit> {16 PDL} (74 Recycle) [28 PDT/18 MDT, 572 M.Eva]
  })
  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.MidAcc, {
    -- waist="Kwahu Kachina Belt +1",    --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- body="Laksamana's Frac +3",       -- 45, __, 57/35 <__> {_} (19) [__/__,  84]
    -- legs="Laksamana's Trews +3",   -- 33, __, 49/__ <__> {_} (__) [__/__,  89]
    -- AF set bonus                   -- __, __, 15/__ <__> {_} (__) [__/__, ___]
    -- 218 AGI, 58 STP, 428 racc/160 ratt <5 crit> {10 PDL} (77 Recycle) [19 PDT/9 MDT, 531 M.Eva]
  })
  
  sets.midcast.RA.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    -- head="Ikenga's Hat",              -- 29,  8, 50/65 <__> {4} (__) [__/__,  96]
    -- body="Ikenga's Vest",             -- 39, 11, 50/65 <__> {7} (__) [__/__, 112]
    hands="Malignance Gloves",        -- 24, 12, 50/__ <__> {4} (__) [ 5/ 5, 112]
    -- legs="Ikenga's Trousers",         -- 40, 10, 50/65 <__> {6} (__) [ 9/ 9, 123]
    feet="Malignance Boots",          -- 49,  9, 50/__ <__> {2} (__) [ 4/ 4, 150]
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __/__ <__> {_} (__) [ 3/ 5, ___]
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___]
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="Yemaya Belt",              --  7,  4, 10/10 <__> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
  } -- 218 AGI, 77 STP, 340 racc/265 ratt <0 crit> {23 PDL} (58 Recycle) [48 PDT/32 MDT, 593 M.Eva]

  sets.midcast.RA.Critical = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    -- head="Ikenga's Hat",              -- 29,  8, 50/65 <__> {4} (__) [__/__,  96]
    -- body="Ikenga's Vest",             -- 39, 11, 50/65 <__> {7} (__) [__/__, 112]
    -- hands="Mummu Wrists +2",          -- 22, __, 43/__ < 6> {_} (__) [__/__,  43]
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107]
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131]
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___]
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___]
    -- ring1="Begrudging Ring",          -- __, __, __/__ < 5> {_} (__)[-10/__, ___]
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___]
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 239 AGI, 47 STP, 331 racc/190 ratt <38 crit rate> {11 PDL} (58 Recycle) [5 PDT/5 MDT, 489 M.Eva]
    
    -- hands="Chasseur's Gants +2",   -- 21, __, 52/52 < 7> {_} (__) [__/__,  83]
    -- ring2="Mummu Ring",            -- __, __,  6/__ < 3> {_} (__) [__/__, ___]
    -- 228 AGI, 42 STP, 346 racc/242 ratt <42 crit rate> {11 PDL} (58 Recycle) [5 PDT/5 MDT, 529 M.Eva]
  }
  sets.midcast.RA.Critical.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___]
    head="Malignance Chapeau",        -- 33,  8, 50/__ <__> {3} (__) [ 6/ 6, 123]
    body="Malignance Tabard",         -- 42, 11, 50/__ <__> {6} (__) [ 9/ 9, 139]
    -- hands="Mummu Wrists +2",          -- 22, __, 43/__ < 6> {_} (__) [__/__,  43]
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107]
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131]
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___]
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __/__ <__> {_} (__) [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___]
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___]
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___]
    -- Merits/Traits/Gifts                                      (58)
    -- 236 AGI, 37 STP, 321 racc/50 ratt <33 crit rate> {9 PDL} (58 Recycle) [50 PDT/34 MDT, 543 M.Eva]
    
    -- hands="Chasseur's Gants +2",   -- 21, __, 52/52 < 7> {_} (__) [__/__,  83]
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
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
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
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
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
    -- hands="Mummu Wrists +2",          -- 22, __, 43/__ < 6> {_} (__) [__/__,  43] (__, __) (__, __)
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107] (__, __) (__, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    -- neck="Iskur Gorget",              -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ring1="Begrudging Ring",          -- __, __, __/__ < 5> {_} (__)[-10/__, ___] (__, __) (__, __)
    ring2="Ilabrat Ring",             -- 10,  5, __/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 249 AGI, 28 STP, 298 racc/82 ratt <38 crit> {0 PDL} (58 Recycle) [5 PDT/5 MDT, 440 M.Eva] (10 DS Rate, 25 DS Dmg) (85 TS Rate, 13 TS Dmg)
    
    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- hands="Chasseur's Gants +2",   -- 21, __, 52/52 < 7> {_} (__) [__/__,  83] (__, __) (__, __)
    -- ring2="Mummu Ring",            -- __, __,  6/__ < 3> {_} (__) [__/__, ___] (__, __) (__, __)
    -- 248 AGI, 23 STP, 345 racc/176 ratt <42 crit> {0 PDL} (58 Recycle) [17 PDT/17 MDT, 520 M.Eva] (10 DS Rate, 25 DS Dmg) (86 TS Rate, 13 TS Dmg)
  }
  sets.TripleShot.Critical.Safe = {
    ammo=gear.RAbullet,               -- __, __, 20/__ <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- head="Oshosi Mask +1",            -- 44, __, 45/__ <__> {_} (__) [__/__,  90] ( 6, 25) ( 5, 13)
    -- body="Chasseur's Frac +1",        -- 34, __, 22/22 <__> {_} (__) [__/__,  69] (__, __) (12, __)
    -- hands="Mummu Wrists +2",          -- 22, __, 43/__ < 6> {_} (__) [__/__,  43] (__, __) (__, __)
    -- legs="Mummu Kecks +2",            -- 45, __, 45/__ < 7> {_} (__) [ 5/ 5, 107] (__, __) (__, __)
    -- feet="Oshosi Leggings +1",        -- 56, __, 43/__ <10> {_} (__) [__/__, 131] ( 4, __) ( 3, __)
    neck="Loricate Torque +1",        -- __, __, __/__ <__> {_} (__) [ 6/ 6, ___] (__, __) (__, __)
    -- ear1="Odr Earring",               -- __, __, __/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- ear2="Telos Earring",             -- __,  5, 10/10 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    ring1="Gelatinous Ring +1",       -- __, __, __/__ <__> {_} (__) [ 7,-1, ___] (__, __) (__, __)
    ring2="Defending Ring",           -- __, __, __/__ <__> {_} (__) [10/10, ___] (__, __) (__, __)
    -- back=gear.COR_RA_Cape,            -- 30, 10, 20/20 <__> {_} (__) [10/__, ___] (__, __) ( 5, __)
    -- waist="K. Kachina Belt +1",       --  8, __, 20/__ < 5> {_} (__) [__/__, ___] (__, __) (__, __)
    -- JA                                                                                  (40, __)
    -- Merits/Traits/Gifts                                      (58)                       (20, __)
    -- 239 AGI, 15 STP, 268 racc/52 ratt <33 crit> {0 PDL} (58 Recycle) [38 PDT/20 MDT, 440 M.Eva] (10 DS Rate, 25 DS Dmg) (85 TS Rate, 13 TS Dmg)
    
    -- body="Chasseur's Frac +2",     -- 44, __, 54/64 <__> {_} (__) [12/12, 109] (__, __) (13, __)
    -- hands="Chasseur's Gants +2",   -- 21, __, 52/52 < 7> {_} (__) [__/__,  83] (__, __) (__, __)
    -- neck="Iskur Gorget",           -- __,  8, 30/30 <__> {_} (__) [__/__, ___] (__, __) (__, __)
    -- 248 AGI, 23 STP, 339 racc/176 ratt <34 crit> {0 PDL} (58 Recycle) [44 PDT/26 MDT, 520 M.Eva] (10 DS Rate, 25 DS Dmg) (86 TS Rate, 13 TS Dmg)
  }

  -- Dmg is based on Gun DMG, bullet DMG, Quick Draw+ stat, elemental bonuses, MAB.
  -- Acc is based on AGI & M.Acc only.
  -- Dmg is NOT affected by M.Dmg.
  -- TP returned is affected by Store TP.
  sets.midcast.CorsairShot = {
    ammo=gear.QDbullet,           -- 10, 40, __, __, __/__
    -- head="Ikenga's Hat",          -- 29, 40, 50,  8, __/__
    -- body="Lanun Frac +3",         -- 43, 61, 40, __,  6/__
    -- hands="Carmine Fin. Ga. +1",  -- 12, 42, __,  6, __/__
    legs=gear.Nyame_B_legs,       -- 34, 30, 40, __,  8/ 8
    -- feet="Lanun Bottes +3",       -- 49, 61, 36, __,  6/__
    neck="Commodore Charm +1",    -- 12,  6, 20, __, __/__
    ear1="Friomisi Earring",      -- __, 10, __, __, __/__
    ear2="Novio Earring",         -- __,  7, __, __, __/__
    ring1="Dingir Ring",          -- 10, 10, __, __, __/__
    -- ring2="Shiva Ring +1",        -- __,  3, __, __, __/__
    -- back=gear.COR_RA_Cape,        -- 30, __, __, 10, 10/__
    -- waist="Eschan Stone",         -- __,  7,  7, __, __/__
    -- neck="Commodore Charm +2", -- 15,  7, 25, __, __/__
    -- back=gear.COR_QD_Cape,     -- 30, 10, 20, __, 10/__
  } -- 229 AGI, 317 MAB, 193 M.Acc, 24 STP, 30PDT/8MDT

  -- Full STP; and more recast reduction
  sets.midcast.CorsairShot.STP = {
    ammo=gear.MAbullet,           -- __, 35, 25, __, __/__
    -- head="Blood Mask",            -- __, __,  3, __, __/__ Recast -5
    body="Malignance Tabard",     -- 42, __, 50, 11,  9/ 9
    hands="Malignance Gloves",    -- 24, __, 50, 12,  5/ 5
    -- legs="Ikenga's Trousers",     -- 40, __, 50, 10,  9/ 9
    feet="Malignance Boots",      -- 49, __, 50,  9,  4/ 4
    -- neck="Iskur Gorget",          -- __, __, __,  8, __/__
    -- ear1="Dedition Earring",      -- __, __, __,  8, __/__
    -- ear2="Telos Earring",         -- __, __, __,  5, __/__
    -- ring1="Chirich Ring +1",      -- __, __, __,  6, __/__
    -- ring2="Crepuscular Ring",     -- __, __, 10,  6, __/__
    -- back=gear.COR_RA_Cape,        -- 30, __, __, 10, 10/__
    -- waist="Reiki Yotai",          -- __, __, __,  4, __/__
    -- ear2="Crepuscular Earring",-- __, __, 10,  5, __/__
    -- 185 AGI, 35 MAB, 248 M.Acc, 89 STP, 37PDT/27MDT
  } -- 185 AGI, 35 MAB, 238 M.Acc, 89 STP, 37PDT/27MDT

  -- Full MAcc (to land debuff effects)
  sets.midcast.CorsairShot['Light Shot'] = {
    ammo=gear.MAbullet,               -- __, 35, 25, __, __/__
    head="Malignance Chapeau",        -- 33, __, 50,  8,  6/ 6
    body="Malignance Tabard",         -- 42, __, 50, 11,  9/ 9
    hands="Malignance Gloves",        -- 24, __, 50, __, __/__
    -- legs="Ikenga's Trousers",         -- 40, __, 50, 10,  9/ 9
    feet="Malignance Boots",          -- 49, __, 50,  9,  4/ 4
    neck="Commodore Charm +1",        -- 12,  6, 20, __, __/__
    -- ear1="Hermetic Earring",          -- __,  3,  7, __, __/__
    ear2="Dignitary's Earring",       -- __, __, 10,  3, __/__
    -- ring1="Regal Ring",               -- 10, __, __, __, __/__
    ring2="Stikini Ring +1",          -- __, __, 11, __, __/__
    -- back=gear.COR_WS1_Cape,           -- 30, __, 20, __, 10/__
    -- waist="K. Kachina Belt +1",       --  8, __, 20, __, __/__
    -- AF Set Effect                  -- __, __, __, __, __/__
    -- M.Acc from Quick Draw+ stat    -- __, __, __, __, __/__

    -- head="Laksamana's Tricorne +3",-- 39, __, 56, __, __/__; Quick Draw+20
    -- hands="Laksamana's Gants +3",  -- 17, __, 57, __, __/__
    -- feet="Laksamana's Bottes +3",  -- 49, __, 52, __, __/__; Quick Draw+20
    -- neck="Commodore Charm +2",     -- 15,  7, 25, __, __/__
    -- ear1="Crepuscular Earring",    -- __, __, 10,  5, __/__
    -- AF Set Effect                  -- __, __, 45, __, __/__
    -- M.Acc from Quick Draw+ stat    -- __, __, 40, __, __/__
    -- 250 AGI, 42 MAB, 471 M.Acc, 29 STP, 28PDT/18MDT
  } -- 248 AGI, 44 MAB, 363 M.Acc, 41 STP, 38PDT/28MDT
  sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

  -- Empy feet for enhancement effect; and more recast reduction
  sets.midcast.CorsairShot.Enhance = {
    -- head="Blood Mask", -- Recast -5
    -- feet="Chasseur's Bottes +1",
    
    -- feet="Chasseur's Bottes +2",
  }

  sets.midcast.Cure = {
    -- neck="Incanter's Torque",
    -- ring1="Lebeche Ring",
    -- ear1="Roundel Earring",
    -- ear2="Mendi. Earring",
    -- ring2="Haoma's Ring",
    -- waist="Bishop's Sash",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.HybridDT = {
    head="Malignance Chapeau",        --  6/ 6, 123
    body="Malignance Tabard",         --  9/ 9, 139
    hands="Malignance Gloves",        --  5/ 5, 112
    legs="Malignance Tights",         --  7/ 7, 150
    feet="Malignance Boots",          --  4/ 4, 150
    ring2="Defending Ring",           -- 10/10, ___
    -- 10 PDT from JSE cape

    -- legs="Chasseur's Culottes +2", -- 11/11, 115; Remove feet
    -- 55 PDT / 45 MDT, 639 MEVA
  } -- 51 PDT / 41 MDT, 674 MEVA

  sets.HeavyDef = {
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Loricate Torque +1",  --  6/ 6, ___
    -- ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    -- ring1="Chirich Ring +1",    -- __/__, ___
    ring2="Defending Ring",     -- 10/10, ___
    -- back=gear.COR_TP_Cape,      -- 10/__, ___
    waist="Carrier's Sash",     -- __/__, ___; Ele Resist+15
  } -- 60 PDT / 52 MDT, 697 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    -- ear1="Infused Earring",
    -- ring1="Chirich Ring +1",
    -- back=gear.COR_Regen_Cape,
    -- ring2="Chirich Ring +1",
  }
  sets.latent_refresh = {
    -- head=gear.Herc_Refresh_head,
    -- legs="Rawhide Trousers",
    -- feet=gear.Herc_Refresh_feet,
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.resting = {}

  -- Idle sets
  sets.idle = sets.HeavyDef

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


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs=gear.Samnuha_legs,           -- __,  7, 15 < 3,  3, __> [__/__,  75]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __,  1, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
  } -- 0 DW, 45 STP, 198 Acc <24 DA, 18 TA, 2 QA> [37 PDT/25 MDT, 455 M.Eva]
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
    -- 0 DW, 60 STP, 255 Acc <21 DA, 9 TA, 2 QA> [39 PDT/29 MDT, 530 M.Eva]
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 0 DW, 69 STP, 277 Acc <20 DA, 7 TA, 0 QA> [39 PDT/29 MDT, 530 M.Eva]
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 0 DW, 71 STP, 325 Acc <11 DA, 4 TA, 0 QA> [50 PDT/40 MDT, 570 M.Eva]
  })


  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25% (assumed)

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands="Floral Gauntlets",         --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 73 DW, 28 STP, 218 Acc <0 DA, 7 TA, 0 QA> [33 PDT/19 MDT, 378 MEVA]
  }
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- head="Carmine Mask +1",
    -- ear1="Mache Earring +1",
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.LowHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Floral Gauntlets",         --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 67 DW, 39 STP, 233 Acc <3 DA, 6 TA, 0 QA> [35 PDT/29 MDT, 448 MEVA]
  }
  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
  })
  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- head="Carmine Mask +1",
    -- ear1="Mache Earring +1",
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.MidHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 57 DW, 46 STP, 247 Acc <3 DA, 11 TA, 0 QA> [37 PDT/27 MDT, 543 MEVA]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- feet=gear.Herc_TA_feet,        -- __, __, 23 <__,  6, __> [ 2/__,  75]
    -- 57 DW, 38 STP, 223 Acc <3 DA, 17 TA, 0 QA> [39 PDT/27 MDT, 433 MEVA]
  }
  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
  })
  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- head="Carmine Mask +1",
    -- ear1="Mache Earring +1",
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.DW.HighHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __,  1, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 43 DW, 38 STP, 220 Acc <18 DA, 17 TA, 0 QA> [35 PDT/23 MDT, 460 MEVA]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 43 DW, 39 STP, 223 Acc <18 DA, 17 TA, 0 QA> [39 PDT/27 MDT, 425 MEVA]
  }
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- head="Carmine Mask +1",
    -- ear1="Mache Earring +1",
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.DW.SuperHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 36 DW, 38 STP, 222 Acc <14 DA, 19 TA, 2 QA> [35 PDT/23 MDT, 460 MEVA]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 36 DW, 39 STP, 225 Acc <14 DA, 19 TA, 2 QA> [39 PDT/27 MDT, 425 MEVA]
  }
  sets.engaged.DW.LowAcc.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- hands=gear.Adhemar_A_hands,    -- __,  7, 52 <__,  4, __> [__/__,  43]
  })
  sets.engaged.DW.MidAcc.SuperHaste = set_combine(sets.engaged.DW.LowAcc.SuperHaste, {
    legs="Meg. Chausses +2",
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- head="Carmine Mask +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.HighAcc.SuperHaste = set_combine(sets.engaged.DW.MidAcc.SuperHaste, {
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- ear1="Mache Earring +1",
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  -- Max Magic/Gear/JA Haste (0-25% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = sets.engaged
  -- 0 DW, 45 STP, 198 Acc <24 DA, 18 TA, 2 QA> [37 PDT/25 MDT, 455 M.Eva]
  sets.engaged.DW.LowAcc.MaxHaste = sets.engaged.LowAcc
  -- 0 DW, 60 STP, 255 Acc <21 DA, 9 TA, 2 QA> [39 PDT/29 MDT, 530 M.Eva]
  sets.engaged.DW.MidAcc.MaxHaste = sets.engaged.MidAcc
  -- 0 DW, 69 STP, 277 Acc <20 DA, 7 TA, 0 QA> [39 PDT/29 MDT, 530 M.Eva]
  sets.engaged.DW.HighAcc.MaxHaste = sets.engaged.HighAcc
  -- 0 DW, 71 STP, 325 Acc <11 DA, 4 TA, 0 QA> [50 PDT/40 MDT, 570 M.Eva]


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __,  1, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Flume Belt +1",            -- __, __, __ <__, __, __> [ 4/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 25 DW, 48 STP, 231 Acc <21 DA, 13 TA, 0 QA> [48 PDT / 32 MDT, 530 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 25 DW, 49 STP, 234 Acc <21 DA, 13 TA, 0 QA> [52 PDT/36 MDT, 495 MEVA]
  }
  sets.engaged.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __,  1, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Flume Belt +1",            -- __, __, __ <__, __, __> [ 4/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 25 DW, 57 STP, 258 Acc <21 DA, 7 TA, 0 QA> [50 PDT/36 MDT, 605 M.Eva]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- waist="Windbuffet Belt +1",    -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 25 DW, 58 STP, 263 Acc <21 DA, 9 TA, 2 QA> [50 PDT/40 MDT, 570 M.Eva]
  }
  sets.engaged.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __,  1, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 25 DW, 67 STP, 290 Acc <24 DA, 3 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ring2="Gelatinous Ring +1",    -- __, __, __ <__, __, __> [ 7/-1, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 25 DW, 68 STP, 293 Acc <24 DA, 3 TA, 0 QA> [52 PDT/34 MDT, 639 M.Eva]
  }
  sets.engaged.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 25 DW, 75 STP, 320 Acc <11 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ring2="Gelatinous Ring +1",    -- __, __, __ <__, __, __> [ 7/-1, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 25 DW, 76 STP, 323 Acc <11 DA, 0 TA, 0 QA> [52 PDT/34 MDT, 639 M.Eva]
  }

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Nyame_B_hands,         -- __, __, 40 < 4, __, __> [ 7/ 7, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 68 DW, 12 STP, 242 Acc <4 DA, 4 TA, 0 QA> [49 PDT/33 MDT, 453 MEVA]
  }
  sets.engaged.DW.LowAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 66 DW, 35 STP, 257 Acc <0 DA, 0 TA, 0 QA> [53 PDT/35 MDT, 531 MEVA]
  }
  sets.engaged.DW.MidAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 66 DW, 35 STP, 257 Acc <0 DA, 0 TA, 0 QA> [53 PDT/35 MDT, 531 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- neck="Subtlety Spectacles",    -- __, __, 15 <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 60 DW, 52 STP, 280 Acc <0 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 566 MEVA]
  }
  sets.engaged.DW.HighAcc.HeavyDef = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 57 DW, 50 STP, 295 Acc <0 DA, 0 TA, 0 QA> [50 PDT/40 MDT, 612 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- feet=gear.Taeon_DW_feet,       --  9, __, 22 <__, __, __> [__/__,  69]
    -- neck="Subtlety Spectacles",    -- __, __, 15 <__, __, __> [__/__, ___]
    -- 60 DW, 52 STP, 280 Acc <0 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 566 MEVA]
  }

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.HeavyDef.LowHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Floral Gauntlets",         --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 67 DW, 23 STP, 253 Acc <0 DA, 3 TA, 0 QA> [51 PDT/39 MDT, 448 MEVA]
    
    -- body=gear.Adhemar_B_body,      --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ear2="Dedition Earring",       -- __,  8,-10 <__, __, __> [__/__, ___]
    -- 67 DW, 31 STP, 216 Acc <0 DA, 7 TA, 0 QA> [50 PDT/36 MDT, 413 MEVA]
  }
  sets.engaged.DW.LowAcc.HeavyDef.LowHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Floral Gauntlets",         --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 67 DW, 23 STP, 253 Acc <0 DA, 3 TA, 0 QA> [51 PDT/39 MDT, 448 MEVA]
  }
  sets.engaged.DW.MidAcc.HeavyDef.LowHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Floral Gauntlets",         --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 58 DW, 32 STP, 296 Acc <0 DA, 3 TA, 0 QA> [49 PDT/37 MDT, 529 MEVA]
  }
  sets.engaged.DW.HighAcc.HeavyDef.LowHaste = {
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
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 48 DW, 47 STP, 320 Acc <0 DA, 0 TA, 0 QA> [54 PDT/38 MDT, 604 MEVA]
  }

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.HeavyDef.MidHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 57 DW, 38 STP, 247 Acc <0 DA, 8 TA, 0 QA> [50 PDT/32 MDT, 543 MEVA]

    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- feet=gear.Herc_TA_feet,        -- __, __, 23 <__,  6, __> [ 2/__,  75]
    -- 57 DW, 30 STP, 223 Acc <0 DA, 14 TA, 0 QA> [52 PDT/32 MDT, 433 MEVA]
  }
  sets.engaged.DW.LowAcc.HeavyDef.MidHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 57 DW, 43 STP, 280 Acc <0 DA, 4 TA, 0 QA> [49 PDT/31 MDT, 612 MEVA]
  }
  sets.engaged.DW.MidAcc.HeavyDef.MidHaste = {
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
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 57 DW, 44 STP, 300 Acc <0 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 612 MEVA]
  }
  sets.engaged.DW.HighAcc.HeavyDef.MidHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 48 DW, 52 STP, 320 Acc <1 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
  }

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.DW.HeavyDef.HighHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, 10 <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 43 DW, 29 STP, 230 Acc <10 DA, 14 TA, 0 QA> [51 PDT/33 MDT, 460 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 43 DW, 35 STP, 233 Acc <11 DA, 14 TA, 0 QA> [52 PDT/32 MDT, 425 MEVA]
  }
  sets.engaged.DW.LowAcc.HeavyDef.HighHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 43 DW, 43 STP, 257 Acc <11 DA, 8 TA, 0 QA> [50 PDT/32 MDT, 535 MEVA]
    
    -- hands="Malignance Gloves",     -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 43 DW, 46 STP, 261 Acc <11 DA, 10 TA, 0 QA> [50 PDT/38 MDT, 494 MEVA]
  }
  sets.engaged.DW.MidAcc.HeavyDef.HighHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_B_body,         --  6, __, 35 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 43 DW, 48 STP, 290 Acc <11 DA, 4 TA, 0 QA> [49 PDT/31 MDT, 604 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- neck="Loricate Torque +1",     -- __, __, __ <__, __, __> [ 6/ 6, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 43 DW, 46 STP, 261 Acc <11 DA, 10 TA, 0 QA> [50 PDT/38 MDT, 494 MEVA]
  }
  sets.engaged.DW.HighAcc.HeavyDef.HighHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 48 DW, 52 STP, 320 Acc <1 DA, 4 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
  }

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.DW.HeavyDef.SuperHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_B_hands,       -- __,  7, 32 <__,  4, __> [__/__,  43]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 36 DW, 31 STP, 242 Acc <11 DA, 12 TA, 2 QA> [50 PDT/30 MDT, 460 MEVA]

    -- body=gear.Adhemar_B_body,      --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 36 DW, 31 STP, 225 Acc <11 DA, 16 TA, 2 QA> [52 PDT/32 MDT, 425 MEVA]
  }
  sets.engaged.DW.LowAcc.HeavyDef.SuperHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 36 DW, 36 STP, 275 Acc <11 DA, 8 TA, 2 QA> [49 PDT/29 MDT, 529 MEVA]
    
    -- body=gear.Adhemar_B_body,      --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- 36 DW, 36 STP, 258 Acc <11 DA, 12 TA, 2 QA> [51 PDT/31 MDT, 494 MEVA]
  }
  sets.engaged.DW.MidAcc.HeavyDef.SuperHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 38 DW, 43 STP, 293 Acc <11 DA, 6 TA, 0 QA> [49 PDT/29 MDT, 529 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ear1="Suppanomimi",            --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 57 STP, 291 Acc <11 DA, 6 TA, 0 QA> [53 PDT/41 MDT, 564 MEVA]
  }
  sets.engaged.DW.HighAcc.HeavyDef.SuperHaste = {
    ammo=gear.RAbullet,
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.COR_TP_Cape,            -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- Traits/Merits/Gifts               25, __, __ <__, __, __> [__/__, ___]
    -- 38 DW, 52 STP, 320 Acc <11 DA, 0 TA, 0 QA> [51 PDT/33 MDT, 604 MEVA]
    
    -- legs="Chasseur's Culottes +2", -- __, 11, 53 <__, __, __> [11/11, 115]
    -- ear1="Suppanomimi",            --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 66 STP, 318 Acc <11 DA, 0 TA, 0 QA> [55 PDT/45 MDT, 639 MEVA]
  }

  sets.engaged.DW.HeavyDef.MaxHaste = sets.engaged.HeavyDef
  sets.engaged.DW.LowAcc.HeavyDef.MaxHaste = sets.engaged.LowAcc.HeavyDef
  sets.engaged.DW.MidAcc.HeavyDef.MaxHaste = sets.engaged.MidAcc.HeavyDef
  sets.engaged.DW.HighAcc.HeavyDef.MaxHaste = sets.engaged.HighAcc.HeavyDef

  sets.engaged.Safe = sets.engaged.HeavyDef
  sets.engaged.LowAcc.Safe = sets.engaged.LowAcc.HeavyDef
  sets.engaged.MidAcc.Safe = sets.engaged.MidAcc.HeavyDef
  sets.engaged.HighAcc.Safe = sets.engaged.HighAcc.HeavyDef

  sets.engaged.DW.Safe = sets.engaged.DW.HeavyDef
  sets.engaged.DW.LowAcc.Safe = sets.engaged.DW.LowAcc.HeavyDef
  sets.engaged.DW.MidAcc.Safe = sets.engaged.DW.MidAcc.HeavyDef
  sets.engaged.DW.HighAcc.Safe = sets.engaged.DW.HighAcc.HeavyDef
  
  sets.engaged.DW.Safe.LowHaste = sets.engaged.DW.HeavyDef.LowHaste
  sets.engaged.DW.LowAcc.Safe.LowHaste = sets.engaged.DW.LowAcc.HeavyDef.LowHaste
  sets.engaged.DW.MidAcc.Safe.LowHaste = sets.engaged.DW.MidAcc.HeavyDef.LowHaste
  sets.engaged.DW.HighAcc.Safe.LowHaste = sets.engaged.DW.HighAcc.HeavyDef.LowHaste

  sets.engaged.DW.Safe.MidHaste = sets.engaged.DW.HeavyDef.MidHaste
  sets.engaged.DW.LowAcc.Safe.MidHaste = sets.engaged.DW.LowAcc.HeavyDef.MidHaste
  sets.engaged.DW.MidAcc.Safe.MidHaste = sets.engaged.DW.MidAcc.HeavyDef.MidHaste
  sets.engaged.DW.HighAcc.Safe.MidHaste = sets.engaged.DW.HighAcc.HeavyDef.MidHaste

  sets.engaged.DW.Safe.HighHaste = sets.engaged.DW.HeavyDef.HighHaste
  sets.engaged.DW.LowAcc.Safe.HighHaste = sets.engaged.DW.LowAcc.HeavyDef.HighHaste
  sets.engaged.DW.MidAcc.Safe.HighHaste = sets.engaged.DW.MidAcc.HeavyDef.HighHaste
  sets.engaged.DW.HighAcc.Safe.HighHaste = sets.engaged.DW.HighAcc.HeavyDef.HighHaste

  sets.engaged.DW.Safe.SuperHaste = sets.engaged.DW.HeavyDef.SuperHaste
  sets.engaged.DW.LowAcc.Safe.SuperHaste = sets.engaged.DW.LowAcc.HeavyDef.SuperHaste
  sets.engaged.DW.MidAcc.Safe.SuperHaste = sets.engaged.DW.MidAcc.HeavyDef.SuperHaste
  sets.engaged.DW.HighAcc.Safe.SuperHaste = sets.engaged.DW.HighAcc.HeavyDef.SuperHaste

  sets.engaged.DW.Safe.MaxHaste = sets.engaged.DW.HeavyDef.MaxHaste
  sets.engaged.DW.LowAcc.Safe.MaxHaste = sets.engaged.DW.LowAcc.HeavyDef.MaxHaste
  sets.engaged.DW.MidAcc.Safe.MaxHaste = sets.engaged.DW.MidAcc.HeavyDef.MaxHaste
  sets.engaged.DW.HighAcc.Safe.MaxHaste = sets.engaged.DW.HighAcc.HeavyDef.MaxHaste

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
    waist="Windbuffet Belt +1",   -- [__/__, ___]
  } -- [51 PDT/41 MDT, 674 MEVA] 0 DW, 26 Subtle Blow
  sets.engaged.LowAcc.SubtleBlow = sets.engaged.SubtleBlow
  sets.engaged.MidAcc.SubtleBlow = sets.engaged.SubtleBlow
  sets.engaged.HighAcc.SubtleBlow = sets.engaged.SubtleBlow

  sets.engaged.DW.SubtleBlow = {
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
    back=gear.COR_DW_Cape,        -- [10/__, ___] 10
    waist="Reiki Yotai",          -- [__/__, ___]  7
  } -- [51 PDT/41 MDT, 674 MEVA] 21 DW, 26 Subtle Blow
  sets.engaged.DW.LowAcc.SubtleBlow = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow = sets.engaged.DW.SubtleBlow
  
  sets.engaged.DW.SubtleBlow.LowHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.LowAcc.SubtleBlow.LowHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow.LowHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow.LowHaste = sets.engaged.DW.SubtleBlow

  sets.engaged.DW.SubtleBlow.MidHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.LowAcc.SubtleBlow.MidHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow.MidHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow.MidHaste = sets.engaged.DW.SubtleBlow

  sets.engaged.DW.SubtleBlow.HighHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.LowAcc.SubtleBlow.HighHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow.HighHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow.HighHaste = sets.engaged.DW.SubtleBlow

  sets.engaged.DW.SubtleBlow.SuperHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.LowAcc.SubtleBlow.SuperHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow.SuperHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow.SuperHaste = sets.engaged.DW.SubtleBlow

  sets.engaged.DW.SubtleBlow.MaxHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.LowAcc.SubtleBlow.MaxHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.MidAcc.SubtleBlow.MaxHaste = sets.engaged.DW.SubtleBlow
  sets.engaged.DW.HighAcc.SubtleBlow.MaxHaste = sets.engaged.DW.SubtleBlow

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {
    waist="Hachirin-no-Obi",
  }
  sets.Special.SubtleBlow = {
    head="Adhemar Bonnet +1", --8
    ring1="Chirich Ring +1", --10
    neck="Bathy Choker +1", --11
    ear1="Dignitary's Earring", --5
    ear2="Beyla Earring", --5
  }
  sets.CP = {
    back="Mecisto. Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1",
  }

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = sets.TreasureHunter

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.WeaponSet = {}
  sets.WeaponSet.DeathPenalty_M = {
    main="Lanun Knife",
    sub="Tauret",
    ranged="Death Penalty",
    -- main="Rostam",
  }
  sets.WeaponSet.DeathPenalty_R = {
    main="Lanun Knife",
    sub="Nusku Shield",
    ranged="Death Penalty",
    -- main="Rostam",
  }
  sets.WeaponSet.Armageddon_M = {
    main="Lanun Knife",
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
    main="Lanun Knife",
    sub="Nusku Shield",
    ranged="Fomalhaut",
  }
  sets.WeaponSet["Savage Blade"] = {
    main="Naegling",
    sub="Blurred Knife +1",
    ranged="Holliday",
    -- ranged="Anarchy +2",
  }
  sets.WeaponSet.Cleaving = {
    main="Lanun Knife",
    sub="Tauret",
    ranged="Anarchy +2",
  }
  sets.WeaponSet.QuickDraw = {
    main="Naegling",
    sub="Tauret",
    ranged="Death Penalty",
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

  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
    silibs.equip_ammo(spell)
  end

  -- Gear
  if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
    if player.status ~= 'Engaged' then
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
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
  if locked_waist then equip({ waist=player.equipment.waist }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.type == 'CorsairShot' and (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
    -- Equip elemental waist
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
    -- Equip corsair shot set
    if state.QDMode.value == 'Enhance' then
      equip(sets.midcast.CorsairShot.Enhance)
    elseif state.QDMode.value == 'STP' then
      equip(sets.midcast.CorsairShot.STP)
    end
  elseif spell.action_type == 'Ranged Attack' then
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

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  state.CastingMode:reset()

  if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
    display_roll_info(spell)
  end
  if spell.english == "Light Shot" then
    send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

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
end

function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Weapon Set' then
    equip_weapons()
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
      ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
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
windower.register_event('action',
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
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

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
    equip_weapons()
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'test' then
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

function define_roll_values()
  rolls = {
    ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
    ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
    ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
    ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
    ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
    ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
    ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
    ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
    ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
    ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
    ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
    ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
    ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
    ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
    ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
    ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
    ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
    ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
    ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
    ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
    ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
    ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
    ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
    ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
    ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
    ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
    ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
    ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
    ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
    ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
    ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
  }
end

function display_roll_info(spell)
  rollinfo = rolls[spell.english]
  local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

  if rollinfo then
    add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
        ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
        '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
        ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
        '  ' ..rollsize)
  end
end

-- Returns details of item if you have it. Optional get_count boolean will
-- also return count of all instances of the item with that name that you
-- have in all wardrobes and inventory. get_count defaults to true
function get_item(item_name, --[[optional]]get_count)
  if get_count == nil then
    get_count = true
  end
  local item = nil
  local count = 0
  if item_name and item_name ~= '' then
    local bags = L{'inventory','wardrobe','wardrobe2','wardrobe3','wardrobe4','wardrobe5','wardrobe6','wardrobe7','wardrobe8'}
    for bag,_ in bags:it() do
      if player[bag] and player[bag][item_name] then
        item = player[bag][item_name]
        if not get_count then return end
        count = count + (item.count or 1)
      end
    end
  end
  if item then
    item.count = count
  end
  return item
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
end)

function equip_weapons()
  equip(sets.WeaponSet[state.WeaponSet.current])

  -- Equip appropriate ammo
  local ranged = sets.WeaponSet[state.WeaponSet.current].ranged
  if ranged and gear.RAbullet then
    if player.inventory[gear.RAbullet] then
      equip({ammo=gear.RAbullet})
    else
      add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
    end
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(2, 3)
end

function test()
  print('mob_list: '..inspect(windower.ffxi.get_mob_list('Pilgrim Moogle')))
end