-- File Status: Good.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: HasteInfo, DistancePlus
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable GearInfo, disable RollTracker

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
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c equipweapons')
    send_command('gs c equiprangedweapons')
  end, 5)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(6)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'HeavyDef')
  state.RangedMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.WeaponSet = M{['description']='Weapon Set', 'MagicRA', 'PhysRA', 'PhysRA RangedOnly', 'Melee'}
  state.RangedWeaponSet = M{['description']='Ranged Weapon Set', 'Gastraphetes', 'Fomalhaut', 'Sparrowhawk +2'}
  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.Buff.Barrage = buffactive.Barrage or false
  state.Buff.Camouflage = buffactive.Camouflage or false
  state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
  state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
  state.Buff['Double Shot'] = buffactive['Double Shot'] or false

  options.ammo_warning_limit = 10

  no_swap_waists = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

  DefaultAmmo = {
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
    ['Accipiter'] = "Eminent Arrow",
    ['Anarchy'] = "Chrono Bullet",
    ['Anarchy +1'] = "Chrono Bullet",
    ['Anarchy +2'] = "Chrono Bullet",
    ['Anarchy +3'] = "Chrono Bullet",
    ['Ataktos'] = "Chrono Bullet",
  }
  AccAmmo = {
    ['Yoichinoyumi'] = "Yoichi's Arrow",
    ['Gandiva'] = "Yoichi's Arrow",
    ['Fail-Not'] = "Yoichi's Arrow",
    ['Annihilator'] = "Eradicating Bullet",
    ['Armageddon'] = "Eradicating Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
    ['Accipiter'] = "Eminent Arrow",
    ['Anarchy'] = "Chrono Bullet",
    ['Anarchy +1'] = "Chrono Bullet",
    ['Anarchy +2'] = "Chrono Bullet",
    ['Anarchy +3'] = "Chrono Bullet",
    ['Ataktos'] = "Chrono Bullet",
  }
  WSAmmo = {
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Chrono Bullet",
    ['Armageddon'] = "Chrono Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Chrono Bullet",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
    ['Accipiter'] = "Eminent Arrow",
    ['Anarchy'] = "Chrono Bullet",
    ['Anarchy +1'] = "Chrono Bullet",
    ['Anarchy +2'] = "Chrono Bullet",
    ['Anarchy +3'] = "Chrono Bullet",
    ['Ataktos'] = "Chrono Bullet",
  }
  MagicAmmo = {
    ['Yoichinoyumi'] = "Chrono Arrow",
    ['Gandiva'] = "Chrono Arrow",
    ['Fail-Not'] = "Chrono Arrow",
    ['Annihilator'] = "Devastating Bullet",
    ['Armageddon'] = "Devastating Bullet",
    ['Gastraphetes'] = "Quelling Bolt",
    ['Fomalhaut'] = "Devastating Bullet",
    ['Sparrowhawk +2'] = "Eminent Arrow",
    ['Sparrowhawk +3'] = "Eminent Arrow",
    ['Accipiter'] = "Eminent Arrow",
    ['Anarchy'] = "Chrono Bullet",
    ['Anarchy +1'] = "Chrono Bullet",
    ['Anarchy +2'] = "Chrono Bullet",
    ['Anarchy +3'] = "Chrono Bullet",
    ['Ataktos'] = "Chrono Bullet",
  }

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
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
  send_command('bind !e input /ja "Hover Shot" <me>')
  send_command('bind !` input /ja "Scavenge" <me>')
  send_command('bind ^numlock input /ja "Double Shot" <me>')
  send_command('bind %numpad0 input /ra <t>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  flurry = nil -- Do not modify
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
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end

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
  send_command('unbind !e')
  send_command('unbind !`')

  send_command('unbind !w')

  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind %numpad0')
end


-- Set up all gear sets.
function init_gear_sets()
  sets.org.job = {}
  sets.org.job[1] = {ammo="Chrono Bullet"}
  sets.org.job[2] = {ammo="Eminent Arrow"}
  sets.org.job[3] = {ammo="Quelling Bolt"}
  sets.org.job[4] = {waist="Quelling bolt quiver"}
  sets.org.job[5] = {waist="Chrono bullet pouch"}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Eagle Eye Shot'] = {
    legs="Arcadian Braccae +3",
  }
  sets.precast.JA['Bounty Shot'] = {
    hands="Amini Glovelettes +2",
  }
  sets.precast.JA['Camouflage'] = {
    body="Orion Jerkin +2",
    -- body="Orion Jerkin +3",
  }
  sets.precast.JA['Scavenge'] = {
    feet="Orion Socks +1",
    -- feet="Orion Socks +3",
  }
  sets.precast.JA['Shadowbind'] = {
    hands="Orion Bracers +3",
  }
  sets.precast.JA['Sharpshot'] = {
    legs="Orion Braccae +3",
  }

  sets.precast.Waltz = {
    body="Passion Jacket",
    waist="Gishdubar Sash",
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
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Passion Jacket", --10
    neck="Magoraga Beads", --10
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ring1="Weatherspoon Ring", --5
  })
  
  -- Possible flurry tiers: 0, 10, 15, 25, 30, 40, 50, 55, 65
  -- Snapshot (70% cap) > Rapid Shot (99% cap)
  sets.precast.RA = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Oshosi Vest +1",          -- 14/__ [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Meg. Jam. +2",            -- 10/__ [ 3/__,  69] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- 71 Snapshot / 77 Rapid Shot [28 PDT/15 MDT, 386 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry10 = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Oshosi Vest +1",          -- 14/__ [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Flurry (weapons/magic)          10/__
    -- 71 Snapshot / 87 Rapid Shot [28 PDT/15 MDT, 386 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry15 = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Arcadian Jerkin +3",      -- __/16 [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Meg. Jam. +2",            -- 10/__ [ 3/__,  69] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Flurry (weapons/magic)          15/__
    -- 72 Snapshot / 93 Rapid Shot [28 PDT/15 MDT, 386 M.Eva] {12% Velocity Shot}
    
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- waist="Yemaya Belt",         -- __/ 5 [__/__, ___] {__}
    -- 70 Snapshot / 98 Rapid Shot [28 PDT/15 MDT, 386 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry25 = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Arcadian Jerkin +3",      -- __/16 [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Flurry (weapons/magic)          25/__
    -- 72 Snapshot / 103 Rapid Shot [25 PDT/15 MDT, 406 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry30 = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Arcadian Jerkin +3",      -- __/16 [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Loricate Torque +1",      -- __/__ [ 6/ 6, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Gelatinous Ring +1",     -- __/__ [ 7/-1, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Flurry (weapons/magic)          30/__
    -- 71 Snapshot / 103 Rapid Shot [38 PDT/20 MDT, 406 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry40 = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Arcadian Jerkin +3",      -- __/16 [__/__, 106] {__}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Pursuer_A_legs,       -- __/19 [__/__,  69] {__}
    feet=gear.Nyame_B_feet,         -- __/__ [ 7/ 7, 150] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Flurry (weapons/magic)          40/__
    -- 77 Snapshot / 99 Rapid Shot [25 PDT/15 MDT, 406 M.Eva] {12% Velocity Shot}
  }
  sets.precast.RA.Flurry50 = set_combine(sets.precast.RA.Flurry40, {})
  sets.precast.RA.Flurry55 = set_combine(sets.precast.RA.Flurry40, {})
  sets.precast.RA.Flurry65 = set_combine(sets.precast.RA.Flurry40, {})

  -- Snapshot (70% cap) > Velocity Shot (no cap) > Rapid Shot (99% cap)
  sets.precast.RA.Velocity = {
    head=gear.Taeon_RA_head,        -- 10/__ [__/__,  53] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs="Orion Braccae +3",        -- 15/__ [__/__,  89] {__}
    feet="Meg. Jam. +2",            -- 10/__ [ 3/__,  69] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- 72 Snapshot / 46 Rapid Shot [28 PDT/15 MDT, 383 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- waist="Yemaya Belt",         -- __/ 5 [__/__, ___] {__}
    -- 70 Snapshot / 51 Rapid Shot [28 PDT/15 MDT, 393 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry10.Velocity = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs="Orion Braccae +3",        -- 15/__ [__/__,  89] {__}
    feet="Meg. Jam. +2",            -- 10/__ [ 3/__,  69] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- Flurry (weapons/magic)          10/__
    -- 72 Snapshot / 64 Rapid Shot [28 PDT/15 MDT, 403 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- waist="Yemaya Belt",         -- __/ 5 [__/__, ___] {__}
    -- 70 Snapshot / 69 Rapid Shot [28 PDT/15 MDT, 413 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry15.Velocity = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Meg. Jam. +2",            -- 10/__ [ 3/__,  69] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- Flurry (weapons/magic)          15/__
    -- 72 Snapshot / 77 Rapid Shot [28 PDT/15 MDT, 369 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- waist="Yemaya Belt",         -- __/ 5 [__/__, ___] {__}
    -- 70 Snapshot / 82 Rapid Shot [28 PDT/15 MDT, 399 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry25.Velocity = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Impulse Belt",           --  3/__ [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- Flurry (weapons/magic)          25/__
    -- 72 Snapshot / 87 Rapid Shot [25 PDT/15 MDT, 409 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- waist="Yemaya Belt",         -- __/ 5 [__/__, ___] {__}
    -- 70 Snapshot / 92 Rapid Shot [25 PDT/15 MDT, 419 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry30.Velocity = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Adhemar_D_legs,       -- 10/13 [__/__,  75] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Yemaya Belt",            -- __/ 5 [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- Flurry (weapons/magic)          30/__
    -- 74 Snapshot / 92 Rapid Shot [25 PDT/15 MDT, 409 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- 75 Snapshot / 92 Rapid Shot [25 PDT/15 MDT, 419 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry40.Velocity = {
    head="Orion Beret +3",          -- __/18 [__/__,  73] {__}
    body="Amini Caban +2",          -- __/__ [__/__, 109] { 9}
    hands=gear.Carmine_D_hands,     --  8/11 [__/__,  43] {__}
    legs=gear.Pursuer_A_legs,       -- __/19 [__/__,  69] {__}
    feet="Arcadian Socks +3",       -- __/10 [__/__,  89] {__}
    neck="Scout's Gorget +1",       --  3/__ [__/__, ___] {__}
    ear1="Genmei Earring",          -- __/__ [ 2/__, ___] {__}
    ear2="Odnowa Earring +1",       -- __/__ [ 3/ 5, ___] {__}
    ring1="Crepuscular Ring",       --  3/__ [__/__, ___] {__}
    ring2="Defending Ring",         -- __/__ [10/10, ___] {__}
    back=gear.RNG_SNP_Cape,         -- 10/__ [10/__,  20] { 2}
    waist="Yemaya Belt",            -- __/ 5 [__/__, ___] {__}
    -- Merits/Traits/Gifts             10/35 [__/__, ___] {10}
    -- Velocity Shot Ability           __/__ [__/__, ___] {15}
    -- Flurry (weapons/magic)          40/__
    -- 74 Snapshot / 98 Rapid Shot [25 PDT/15 MDT, 403 M.Eva] {36% Velocity Shot}

    -- body="Amini Caban +3",       -- __/__ [__/__, 119] {11}
    -- neck="Scout's Gorget +2",    --  4/__ [__/__, ___] {__}
    -- 75 Snapshot / 98 Rapid Shot [25 PDT/15 MDT, 413 M.Eva] {38% Velocity Shot}
  }
  sets.precast.RA.Flurry50.Velocity = set_combine(sets.precast.RA.Flurry40.Velocity, {})
  sets.precast.RA.Flurry55.Velocity = set_combine(sets.precast.RA.Flurry40.Velocity, {})
  sets.precast.RA.Flurry65.Velocity = set_combine(sets.precast.RA.Flurry40.Velocity, {})



  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    head="Orion Beret +3",
    body=gear.Nyame_B_body,
    hands="Meg. Gloves +2",
    legs="Arcadian Braccae +3",
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Epaminondas's Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Telos Earring",
  })
  sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
    feet="Arcadian Socks +3",
    ear1="Beyla Earring",
    waist="Kwahu Kachina Belt +1",
  })
  sets.precast.WS.HighAccMaxTP = set_combine(sets.precast.WS.HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Apex Arrow'].MaxTP = set_combine(sets.precast.WS['Apex Arrow'], {
  })
  sets.precast.WS['Apex Arrow'].HighAcc = set_combine(sets.precast.WS['Apex Arrow'], {
    feet="Orion Socks +1",
    ear1="Beyla Earring",
    waist="Kwahu Kachina Belt +1",
    -- feet="Orion Socks +3",
  })
  sets.precast.WS['Apex Arrow'].HighAccMaxTP = set_combine(sets.precast.WS['Apex Arrow'].HighAcc, {
  })

  -- 80% DEX, 1.75 FTP, ftp replicating
  sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {
    head="Mummu Bonnet +2",
    hands="Mummu Wrists +2",
    legs="Arcadian Braccae +3",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Begrudging Ring",
    ring2="Mummu Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
    -- body="Abnoba Kaftan",
    -- feet="Thereoid Greaves",
  })
  sets.precast.WS['Jishnu\'s Radiance'].MaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
  })
  sets.precast.WS['Jishnu\'s Radiance'].HighAcc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
    feet="Arcadian Socks +3",
    legs="Mummu Kecks +2",
    neck="Iskur Gorget",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Hajduk Ring +1",
    waist="Kwahu Kachina Belt +1",
  })
  sets.precast.WS['Jishnu\'s Radiance'].HighAccMaxTP = set_combine(sets.precast.WS['Jishnu\'s Radiance'].HighAcc, {
  })

  sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
    head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs="Arcadian Braccae +3",
    feet=gear.Nyame_B_feet,
    neck="Scout's Gorget +1",
    ear1="Moonshade Earring",
    ear2="Amini Earring",
    ring1="Regal Ring",
    ring2="Epaminondas's Ring",
    back=gear.RNG_WS2_Cape,
    waist="Fotia Belt",
    -- neck="Scout's Gorget +2",
    -- ear2="Amini Earring +2",
  })
  sets.precast.WS['Last Stand'].MaxTP = set_combine(sets.precast.WS['Last Stand'], {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'], {
    feet="Orion Socks +1",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    ring2="Hajduk Ring +1",
    waist="Kwahu Kachina Belt +1",
    -- feet="Orion Socks +3",
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
  sets.precast.WS["Coronach"].HighAcc = set_combine(sets.precast.WS['Coronach'], {
    ear1="Telos Earring",
    ear2="Beyla Earring",
  })
  sets.precast.WS["Coronach"].HighAccMaxTP = set_combine(sets.precast.WS['Coronach'].HighAcc, {
  })

  sets.precast.WS["Trueflight"] = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Herc_MAB_feet,
    neck="Scout's Gorget +1",
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Weatherspoon Ring", --10 (light only)
    ring2="Dingir Ring", --10
    back=gear.RNG_WS1_Cape,
    waist="Skrymir Cord",
    -- waist="Skrymir Cord +1",
  } -- AGI / MAB
  sets.precast.WS["Trueflight"].MaxTP = set_combine(sets.precast.WS["Trueflight"], {
    ear2="Novio Earring",
  })
  sets.precast.WS["Trueflight"].HighAcc = set_combine(sets.precast.WS["Trueflight"], {
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
    feet=gear.Nyame_B_feet,
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
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'], {
    head="Dampening Tam",
    ring2="Chirich Ring +1",
    ear2="Dignitary's Earring",
    body=gear.Adhemar_A_body,
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
  })

  sets.precast.WS['Savage Blade'] = {
    head=gear.Nyame_B_head,       -- 26, 26, 65, 50, 11, __, ___
    body="Ikenga's Vest",         -- 33, 25, __, __, __,  7, 200
    hands=gear.Nyame_B_hands,     -- 17, 40, 65, 40, 11, __, ___
    legs=gear.Nyame_B_legs,       -- 58, 32, 65, 40, 12, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 65, 53, 11, __, ___
    neck="Scout's Gorget +1",     -- __, __, __, __, __,  8, ___
    ear1="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ear2="Amini Earring",         -- __, __, __, __, __,  7, ___
    ring1="Sroda Ring",           -- 15, __, __, __, __,  3, ___
    ring2="Epaminondas's Ring",   -- __, __, __, __,  5, __, ___
    back=gear.RNG_WS3_Cape,       -- 30, __, 20, 20, 10, __, ___
    waist="Sailfi Belt +1",       -- 15, __, 15, __, __, __, ___
    -- 217 STR, 149 MND, 295 Attack, 207 Accuracy, 62 WSD, 18 PDL, 450 TP Bonus

    -- neck="Scout's Gorget +2",  -- __, __, __, __, __, 10, ___
    -- ear2="Amini Earring +2",   -- 15, __, __, 20, __,  9, ___
    -- 232 STR, 149 MND, 295 Attack, 217 Accuracy, 62 WSD, 20 PDL, 450 TP Bonus
  }
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
    ring1="Rufescent Ring",       --  6,  6, __,  7, __, __, ___
    ear1="Telos Earring",         -- __, __, 10, 10, __, __, ___
  })
  sets.precast.WS['Savage Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].HighAcc, {
    ear1="Telos Earring",
    ear2="Amini Earring",
    
    -- ear2="Amini Earring +2",
  })

  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['Evisceration'], {
    feet=gear.Herc_TA_feet
  })
  sets.precast.WS['Rampage'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Rampage'].HighAcc = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Rampage'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {})

  sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS["Trueflight"], {
    neck="Baetyl Pendant", --13
    ring1="Shiva Ring +1", --3
  })
  sets.precast.WS["Aeolian Edge"].MaxTP = set_combine(sets.precast.WS["Trueflight"].MaxTP, {
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
    legs=gear.Carmine_D_legs, -- SIRD
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ear2="Odnowa Earring +1", -- DT
    ring1="Defending Ring", -- DT
  }

  -- Ranged sets
  sets.midcast.RA = {
    head="Arcadian Beret +3",       -- 37 [__]  37/ 62 <_> {__} (38) __/__
    body="Ikenga's Vest",           -- 39 [11]  55/ 70 <5> { 7} (__) __/__
    hands="Malignance Gloves",      -- 24 [12]  50/ __ <_> { 4} (__)  5/ 5
    legs="Ikenga's Trousers",       -- 40 [10]  55/ 70 <_> { 6} (__) 10/10
    feet="Malignance Boots",        -- 49 [ 9]  50/ __ <_> { 2} (__)  4/ 4
    neck="Scout's Gorget +1",       -- 20 [ 6]  20/ __ <_> { 8} (__) __/__
    ear1="Dedition Earring",        -- __ [ 8] -10/-10 <_> {__} (__) __/__
    ear2="Telos Earring",           -- __ [ 5]  10/ 10 <_> {__} (__) __/__
    ring1="Crepuscular Ring",       -- __ [ 6]  10/ __ <_> {__} (__) __/__
    ring2="Chirich Ring +1",        -- __ [ 6]  __/ __ <_> {__} (__) __/__
    back=gear.RNG_RA_Cape,          -- 30 [10]  20/ 20 <_> {__} (__) 10/__
    waist="Kwahu Kachina Belt +1",  --  8 [__]  20/ __ <5> {__} (__) __/__
    -- Merits/Traits/Gifts                                      (55)
    -- 247 AGI [83 STP] 317 racc / 222 ratt <10 crit> {27 PDL} (93 Recycle) 29 PDT/19 MDT
    
    -- hands="Amini Glovelettes +3",-- 26 [11]  62/ 62 <_> {__} (__) 11/11; Archery+38
    -- neck="Scout's Gorget +2",    -- 25 [ 7]  25/ __ <_> {10} (__) __/__
    -- 254 AGI [83 STP] 334 racc / 284 ratt <10 crit> {25 PDL} (93 Recycle) 35 PDT/25 MDT
  }
  sets.midcast.RA.LowAcc = set_combine(sets.midcast.RA, {
    ring2="Regal Ring",             -- 10 [__]  __/ 20 <_> {__} (__) __/__
    -- body="Orion Jerkin +3",      -- 40 [ 8]  60/ 41 <_> {__} (__) __/__
    -- AF set bonus                    __ [__]  15/ __ <_> {__} (__) __/__
    -- 265 AGI [74 STP] 354 racc / 275 ratt <5 crit> {18 PDL} (93 Recycle) 35 PDT/25 MDT
  })
  sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA.LowAcc, {
    ear1="Beyla Earring",           -- __ [__]  15/ __ <_> {__} (__) __/__
    -- feet="Amini Bottillons +3",  -- 56 [__]  60/ 60 <_> {__} (__) __/__; Marksmanship+38
    -- AF set bonus                    __ [__]  15/ __ <_> {__} (__) __/__
    -- 272 AGI [57 STP] 389 racc / 345 ratt <5 crit> {16 PDL} (93 Recycle) 31 PDT/21 MDT
  })
  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.MidAcc, {
    head="Orion Beret +3",          -- 39 [__]  47/ 34 <_> {__} (__) __/__
    ring1="Hajduk Ring +1",         -- __ [__]  17/ __ <_> {__} (__) __/__
    ring2="Regal Ring",             -- 10 [__]  __/ 20 <_> {__} (__) __/__
    -- feet="Amini Bottillons +3",  -- 56 [__]  60/ 60 <_> {__} (__) __/__; Marksmanship+38
    -- AF set bonus                    __ [__]  30/ __ <_> {__} (__) __/__
    -- 274 AGI [51 STP] 421 racc / 317 ratt <5 crit> {16 PDL} (55 Recycle) 31 PDT/21 MDT
  })

  sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    body="Meg. Cuirie +2",
    hands="Mummu Wrists +2",
    ring1="Begrudging Ring",
    legs="Amini Bragues +2",
    feet="Oshosi Leggings +1",
    waist="Kwahu Kachina Belt +1",
    -- body="Nisroch Jerkin",
    -- legs="Amini Bragues +3",
    -- ear2="Amini Earring +2",
  })

  sets.DoubleShot = {
    head="Arcadian Beret +3",
    body="Arcadian Jerkin +3",
    hands="Oshosi Gloves", -- 4
    legs="Oshosi Trousers +1", --7
    feet="Oshosi Leggings +1", --4
    -- hands="Oshosi Gloves +1", -- 5
  }
  sets.DoubleShot.Acc = {
    head="Arcadian Beret +3",
    body="Arcadian Jerkin +3",
    legs="Oshosi Trousers +1", --7
    feet="Oshosi Leggings +1", --4
  }

  sets.DoubleShot.Critical = {
    ring1="Begrudging Ring",
    waist="Kwahu Kachina Belt +1",
    -- ear2="Amini Earring +2",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.HybridDT = {
    head="Malignance Chapeau",        --  6/ 6, 123
    body="Malignance Tabard",         --  9/ 9, 139
    hands="Malignance Gloves",        --  5/ 5, 112
    legs="Amini Bragues +2",          -- 12/12, 115
    ring2="Defending Ring",           -- 10/10, ___
    -- 10 PDT from JSE cape
  } -- 52 PDT / 42 MDT, 489 MEVA

  sets.HeavyDef = {
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Chirich Ring +1",    -- __/__, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.RNG_DW_Cape,      -- __/__,  15
    waist="Carrier's Sash",     -- __/__, ___
  } -- 50 PDT / 52 MDT, 697 MEVA

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
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
    back="Moonlight Cape",      --  6/ 6, ___
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.

  -- No DW (0 needed from gear)
  sets.engaged = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.RNG_STP_Cape,           -- __, 10, 20 <__, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 0 DW, 71 STP, 270 Acc <9 DA, 15 TA, 2 QA> [39 PDT/27 MDT, 495 M.Eva]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 0 DW, 72 STP, 280 Acc <9 DA, 15 TA, 2 QA> [40 PDT/28 MDT, 505 M.Eva]
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 0 DW, 73 STP, 306 Acc <15 DA, 13 TA, 0 QA> [40 PDT/28 MDT, 505 M.Eva]
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring2="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 0 DW, 86 STP, 335 Acc <7 DA, 4 TA, 0 QA> [42 PDT/32 MDT, 580 M.Eva]
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __, __, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 0 DW, 77 STP, 360 Acc <1 DA, 4 TA, 0 QA> [42 PDT/32 MDT, 580 M.Eva]
  })

  -- Low DW (11 needed from gear)
  sets.engaged.LowDW = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_STP_Cape,           -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 11 DW, 39 STP, 255 Acc <18 DA, 19 TA, 2 QA> [40 PDT/28 MDT, 425 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 11 DW, 40 STP, 265 Acc <18 DA, 19 TA, 2 QA> [41 PDT/29 MDT, 435 MEVA]
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 11 DW, 42 STP, 275 Acc <15 DA, 16 TA, 2 QA> [41 PDT/29 MDT, 435 MEVA]
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 13 DW, 60 STP, 320 Acc <16 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 6 DW, 57 STP, 336 Acc <14 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })

  -- Mid DW (18 needed from gear)
  sets.engaged.MidDW = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_STP_Cape,           -- __, __, 20 <10, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 18 DW, 43 STP, 263 Acc <18 DA, 17 TA, 0 QA> [40 PDT/28 MDT, 425 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 18 DW, 44 STP, 273 Acc <18 DA, 17 TA, 0 QA> [41 PDT/29 MDT, 435 MEVA]
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 18 DW, 46 STP, 283 Acc <15 DA, 14 TA, 0 QA> [41 PDT/29 MDT, 435 MEVA]
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 18 DW, 55 STP, 320 Acc <11 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 6 DW, 57 STP, 336 Acc <14 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })

  -- High DW (31 needed from gear)
  sets.engaged.HighDW = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Ilabrat Ring",             -- __,  5, __ <__, __, __> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 32 DW, 52 STP, 290 Acc <3 DA, 11 TA, 0 QA> [32 PDT/22 MDT, 508 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 32 DW, 53 STP, 300 Acc <3 DA, 11 TA, 0 QA> [33 PDT/23 MDT, 518 MEVA]
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 32 DW, 54 STP, 310 Acc <3 DA, 11 TA, 0 QA> [33 PDT/23 MDT, 518 MEVA]
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
    ring2="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 32 DW, 56 STP, 320 Acc <0 DA, 8 TA, 0 QA> [33 PDT/23 MDT, 518 MEVA]
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 6 DW, 74 STP, 346 Acc <4 DA, 8 TA, 0 QA> [33 PDT/23 MDT, 510 MEVA]
  })

  -- Super DW (42 needed from gear)
  sets.engaged.SuperDW = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Floral_Gauntlets,      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 42 DW, 36 STP, 246 Acc <8 DA, 10 TA, 0 QA> [38 PDT/32 MDT, 413 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 42 DW, 37 STP, 256 Acc <8 DA, 10 TA, 0 QA> [39 PDT/33 MDT, 423 MEVA]
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 42 DW, 33 STP, 266 Acc <4 DA, 10 TA, 0 QA> [39 PDT/33 MDT, 423 MEVA]
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 46 STP, 292 Acc <1 DA, 8 TA, 0 QA> [39 PDT/29 MDT, 429 MEVA]
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 57 STP, 336 Acc <4 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })

  -- Max DW (49 needed from gear)
  sets.engaged.MaxDW = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Floral_Gauntlets,      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 46 DW, 37 STP, 256 Acc <0 DA, 7 TA, 0 QA> [38 PDT/32 MDT, 413 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 46 DW, 38 STP, 266 Acc <0 DA, 7 TA, 0 QA> [39 PDT/33 MDT, 423 MEVA]
  }
  sets.engaged.MaxDW.LowAcc = set_combine(sets.engaged.MaxDW, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 42 DW, 39 STP, 276 Acc <1 DA, 7 TA, 0 QA> [39 PDT/33 MDT, 423 MEVA]
  })
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- 28 DW, 51 STP, 310 Acc <4 DA, 7 TA, 0 QA> [43 PDT/37 MDT, 504 MEVA]
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Dignitary's Earring",       -- __, __, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 50 STP, 355 Acc <1 DA, 8 TA, 0 QA> [43 PDT/33 MDT, 510 MEVA]
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear1="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_STP_Cape,           -- __, 10, 20 <__, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 0 DW, 65 STP, 260 Acc <9 DA, 15 TA, 2 QA> [49 PDT/37 MDT, 495 M.Eva]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 0 DW, 66 STP, 270 Acc <9 DA, 15 TA, 2 QA> [50 PDT/38 MDT, 505 M.Eva]
  }
  sets.engaged.HeavyDef.LowAcc = set_combine(sets.engaged.HeavyDef, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 0 DW, 60 STP, 276 Acc <7 DA, 15 TA, 2 QA> [50 PDT/38 MDT, 505 M.Eva]
  })
  sets.engaged.HeavyDef.MidAcc = set_combine(sets.engaged.HeavyDef.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 0 DW, 74 STP, 315 Acc <10 DA, 7 TA, 0 QA> [52 PDT/42 MDT, 580 M.Eva]
  })
  sets.engaged.HeavyDef.HighAcc = set_combine(sets.engaged.HeavyDef.MidAcc, {
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 0 DW, 78 STP, 331 Acc <4 DA, 4 TA, 0 QA> [52 PDT/42 MDT, 580 M.Eva]
  })

  -- Low DW (11 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_STP_Cape,           -- __, 10, 20 <__, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    -- 11 DW, 41 STP, 255 Acc <5 DA, 16 TA, 2 QA> [53 PDT/33 MDT, 425 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 11 DW, 42 STP, 265 Acc <5 DA, 16 TA, 2 QA> [54 PDT/34 MDT, 435 MEVA]
  }
  sets.engaged.LowDW.HeavyDef.LowAcc = set_combine(sets.engaged.LowDW.HeavyDef, {
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Kentarch Belt +1",         -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 11 DW, 47 STP, 287 Acc <4 DA, 14 TA, 0 QA> [54 PDT/34 MDT, 435 MEVA]
  })
  sets.engaged.LowDW.HeavyDef.MidAcc = set_combine(sets.engaged.LowDW.HeavyDef.LowAcc, {
    hands="Amini Glovelettes +3",     -- __, 11, 62 <__, __, __> [11/11,  93]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- 11 DW, 59 STP, 297 Acc <7 DA, 13 TA, 0 QA> [52 PDT/40 MDT, 485 MEVA]
  })
  sets.engaged.LowDW.HighAcc.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef.MidAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 6 DW, 65 STP, 336 Acc <7 DA, 7 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })

  -- Mid DW (18 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_STP_Cape,           -- __, 10, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 18 DW, 45 STP, 263 Acc <5 DA, 14 TA, 0 QA> [53 PDT/33 MDT, 425 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 18 DW, 46 STP, 273 Acc <5 DA, 14 TA, 0 QA> [54 PDT/34 MDT, 435 MEVA]
  }
  sets.engaged.MidDW.HeavyDef.LowAcc = set_combine(sets.engaged.MidDW.HeavyDef, {
    hands="Amini Glovelettes +3",     -- __, 11, 62 <__, __, __> [11/11,  93]
    neck="Iskur Gorget",              -- __,  8, __ <__, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- 18 DW, 58 STP, 293 Acc <4 DA, 13 TA, 0 QA> [52 PDT/40 MDT, 485 MEVA]
  })
  sets.engaged.MidDW.HeavyDef.MidAcc = set_combine(sets.engaged.MidDW.HeavyDef.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 18 DW, 69 STP, 330 Acc <1 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })
  sets.engaged.MidDW.HeavyDef.HighAcc = set_combine(sets.engaged.MidDW.HeavyDef.MidAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 6 DW, 71 STP, 346 Acc <4 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })

  -- High DW (31 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Adhemar_A_hands,       -- __,  7, 52 <__,  4, __> [__/__,  43]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Herc_TA_feet,           -- __, __, 23 <__,  6, __> [ 2/__,  75]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 32 DW, 30 STP, 263 Acc <0 DA, 14 TA, 0 QA> [53 PDT/33 MDT, 433 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 32 DW, 31 STP, 273 Acc <0 DA, 14 TA, 0 QA> [54 PDT/34 MDT, 443 MEVA]
  }
  sets.engaged.HighDW.HeavyDef.LowAcc = set_combine(sets.engaged.HighDW.HeavyDef, {
    hands="Amini Glovelettes +3",     -- __, 11, 62 <__, __, __> [11/11,  93]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 32 DW, 39 STP, 283 Acc <3 DA, 13 TA, 0 QA> [52 PDT/40 MDT, 493 MEVA]
  })
  sets.engaged.HighDW.HeavyDef.MidAcc = set_combine(sets.engaged.HighDW.HeavyDef.LowAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 32 DW, 54 STP, 320 Acc <0 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 568 MEVA]
  })
  sets.engaged.HighDW.HeavyDef.HighAcc = set_combine(sets.engaged.HighDW.HeavyDef.MidAcc, {
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 61 STP, 346 Acc <4 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })

  -- Super DW (42 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Floral_Gauntlets,      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 42 DW, 28 STP, 246 Acc <5 DA, 7 TA, 0 QA> [51 PDT/37 MDT, 413 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 42 DW, 29 STP, 256 Acc <5 DA, 7 TA, 0 QA> [52 PDT/38 MDT, 423 MEVA]
  }
  sets.engaged.SuperDW.HeavyDef.LowAcc = set_combine(sets.engaged.SuperDW.HeavyDef, {
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 42 DW, 29 STP, 266 Acc <1 DA, 7 TA, 0 QA> [52 PDT/38 MDT, 423 MEVA]
  })
  sets.engaged.SuperDW.HeavyDef.MidAcc = set_combine(sets.engaged.SuperDW.HeavyDef.LowAcc, {
    hands="Amini Glovelettes +3",     -- __, 11, 62 <__, __, __> [11/11,  93]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 37 DW, 44 STP, 292 Acc <4 DA, 7 TA, 0 QA> [50 PDT/40 MDT, 479 MEVA]
  })
  sets.engaged.SuperDW.HeavyDef.HighAcc = set_combine(sets.engaged.SuperDW.HeavyDef.MidAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 61 STP, 336 Acc <4 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })

  -- Max DW (49 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands=gear.Floral_Gauntlets,      --  5, __, 36 <__,  3, __> [__/ 4,  37]
    legs="Amini Bragues +2",          -- __, 11, 53 <__, __, __> [12/12, 115]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Gelatinous Ring +1",       -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RNG_DW_Cape,            -- 10, __, 20 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 46 DW, 23 STP, 246 Acc <0 DA, 7 TA, 0 QA> [51 PDT/37 MDT, 421 MEVA]
    
    -- legs="Amini Bragues +3",       -- __, 12, 63 <__, __, __> [13/13, 125]
    -- 46 DW, 24 STP, 256 Acc <0 DA, 7 TA, 0 QA> [52 PDT/38 MDT, 431 MEVA]
  }
  sets.engaged.MaxDW.HeavyDef.LowAcc = set_combine(sets.engaged.MaxDW.HeavyDef, {
    hands="Amini Glovelettes +3",     -- __, 11, 62 <__, __, __> [11/11,  93]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills +15
    -- 41 DW, 39 STP, 282 Acc <3 DA, 7 TA, 0 QA> [50 PDT/40 MDT, 487 MEVA]
  })
  sets.engaged.MaxDW.HeavyDef.MidAcc = set_combine(sets.engaged.MaxDW.HeavyDef.LowAcc, {
    ear2="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 37 DW, 50 STP, 302 Acc <1 DA, 4 TA, 0 QA> [50 PDT/40 MDT, 479 MEVA]
  })
  sets.engaged.MaxDW.HeavyDef.HighAcc = set_combine(sets.engaged.MaxDW.HeavyDef.MidAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 61 STP, 346 Acc <4 DA, 4 TA, 0 QA> [54 PDT/44 MDT, 560 MEVA]
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.HauksbokArrow = {
    ammo="Hauksbok Arrow"
  }

  sets.buff.Barrage = {
    hands="Orion Bracers +3"
  }
  sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {
    body="Amini Caban +2",
  })
  sets.buff.Camouflage = {
    body="Orion Jerkin +2"
    -- body="Orion Jerkin +3"
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    legs=gear.Carmine_A_legs,
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
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Special.ElementalObi = {
    waist="Hachirin-no-Obi"
  }

  sets.WeaponSet = {}
  -- Melee weapon sets
  sets.WeaponSet['MagicRA'] = {
    main="Tauret",
    sub="Malevolence",
  }
  sets.WeaponSet['PhysRA'] = {
    main="Ternion Dagger +1",
    sub="Odium",
  }
  sets.WeaponSet['PhysRA RangedOnly'] = {
    main="Ternion Dagger +1",
    sub={name="Nusku Shield", priority=1},
  }
  sets.WeaponSet['Melee'] = {
    main="Naegling",
    sub="Ternion Dagger +1",
  }
  sets.WeaponSet['CritRA'] = {
    -- main="Oneiros Knife",
    sub="Nusku Shield",
  }

  -- Ranged weapon sets
  sets.WeaponSet['Gastraphetes'] = {
    ranged="Gastraphetes",
  }
  sets.WeaponSet['Fomalhaut'] = {
    ranged="Fomalhaut",
  }
  sets.WeaponSet['Sparrowhawk +2'] = {
    ranged="Sparrowhawk +2",
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

  if spell.action_type == 'Ranged Attack' then
    -- Determine weapon flurry
    local totalFlurry = 0
    if player.equipment.range == 'Gastraphetes' then
      totalFlurry = totalFlurry + 10
    end

    -- Determine magic flurry
    if flurry == 1 then
      totalFlurry = totalFlurry + 15
    elseif flurry == 2 then
      totalFlurry = totalFlurry + 30
    end

    if buffactive['Embrava'] then
      totalFlurry = totalFlurry + 25
    end

    -- Possible results of total flurry: 0, 10, 15, 25, 30, 40, 50, 55, 65
    if not buffactive['Velocity Shot'] then
      if totalFlurry == 0 then
        equip(sets.precast.RA)
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      else
        equip(sets.precast.RA['Flurry'..tostring(totalFlurry)])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      end
    else
      if totalFlurry == 0 then
        equip(sets.precast.RA.Velocity)
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      else
        equip(sets.precast.RA['Flurry'..tostring(totalFlurry)]['Velocity'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      end
    end
  end

  -- Check that proper ammo is available and equip it.
  silibs.equip_ammo(spell, action, spellMap, eventArgs)
end

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
        equip(sets.DoubleShot.Critical)
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

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.english == "Shadowbind" then
    send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
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
  update_dp_type() -- Requires DistancePlus addon
  check_gear()
  update_idle_groups()
  silibs.update_combat_form()
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''
  -- Ranged WS
  if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    if state.RangedMode.value == 'HighAcc' then
      wsmode = 'HighAcc'
    end
  else -- Melee WS
    if state.OffenseMode.value == 'HighAcc' then
      wsmode = 'HighAcc'
    end
  end

  -- Calculate if need TP bonus
  local buffer = 100
  -- Start TP bonus at 0 and accumulate based on equipped weapons
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
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'equipweapons' then
    equip_weapons()
  elseif cmdParams[1] == 'equiprangedweapons' then
    equip_ranged_weapons()
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(2, 9)
end

-- Requires DistancePlus addon
function update_dp_type()
  local weapon = player.equipment.ranged ~= nil and player.equipment.ranged ~= 'empty' and res.items:with('name', player.equipment.ranged)
  local range_type = (weapon and weapon.range_type) or nil -- Either: Crossbow, Gun, Bow

  -- Account for command discrepancy between items value 'Crossbow' and distanceplus accepted command 'xbow'
  if range_type == 'Crossbow' then
    range_type = 'xbow'
  end

  -- Update addon if weapon type changed
  if range_type ~= current_dp_type then
    current_dp_type = range_type
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
    if silibs.has_item(DefaultAmmo[ranged], silibs.equippable_bags) then
      equip({ammo=DefaultAmmo[ranged]})
    else
      add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
    end
  end
end

function test()
end
