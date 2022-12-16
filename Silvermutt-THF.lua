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
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+F8 ]         Toggle Attack Capped mode
--
--  Weapons:    [ CTRL+Insert ]     Cycle Main/Sub Weapon
--              [ CTRL+Delete ]     Cycleback Main/Sub Weapon
--              [ ALT+Delete ]      Reset Main/Sub Weapon
--              [ CTRL+Home ]       Cycle Ranged Weapon
--              [ CTRL+End ]        Cycleback Ranged Weapon
--              [ ALT+End ]         Reset Ranged Weapon
--              [ CTRL+PageUp ]     Cycle Toy Weapon
--              [ CTRL+PageDown ]   Cycleback Toy Weapon
--              [ ALT+PageDown ]    Reset Toy Weapon
--
--  Abilities:  [ ALT+` ]           Flee
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
-- 
--  Subjob:     == WAR ==
--              [ ALT+W ]           Defender
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              == SAM ==
--              [ ALT+W ]           Third Eye
--              [ CTRL+Numpad/ ]    Meditate
--              [ CTRL+Numpad* ]    Sekkanoki
--              [ CTRL+Numpad- ]    Hasso
--              == DNC ==
--              [ CTRL+- ]          Cycle Step Mode
--              [ CTRL+= ]          Cycleback Step Mode
--              [ Numpad0 ]         Execute Step
--              [ CTRL+Numlock ]    Reverse Flourish
--              == NIN ==
--              [ Numpad0 ]         Utsusemi: Ichi
--              [ Numpad. ]         Utsusemi: Ni
--              == RUN ==
--              [ CTRL+- ]          Cycle Rune Mode
--              [ CTRL+= ]          Cycleback Rune Mode
--              [ Numpad0 ]         Execute Rune
--              == DRG ==
--              [ ALT+W ]           Ancient Circle
--              [ CTRL+Numpad/ ]    Jump
--              [ CTRL+Numpad* ]    High Jump
--              [ CTRL+Numpad- ]    Super Jump
--
--  Other:      [ E ]               Ranged Attack Current Target
--
--  SilverLibs keybinds:
--              [ ALT+D ]           Interact
--              [ ALT+S ]           Turn 180 degrees in place
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--  For more info and available functions, see SilverLibs documentation at:
--  https://github.com/shastaxc/silver-libs
--
--  Global-Binds.lua contains additional non-job-related keybinds


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
  silibs.enable_auto_lockstyle(9)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  current_dp_type = nil -- Do not modify

  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false
  state.Buff['Feint'] = buffactive['feint'] or false
  
  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.RangedMode:options('Normal', 'Acc')
  state.HybridMode:options('HeavyDef', 'Evasion', 'Normal')
  state.IdleMode:options('Normal', 'Regain', 'HeavyDef', 'Evasion')
  state.CP = M(false, 'Capacity Points Mode')
  state.AttCapped = M(true, "Attack Capped")
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  -- Customizable Weapon Sets. Name must match set name (far below)
  state.WeaponSet = M{['description']='Weapon Set', 'WhiteGlass', 'Normal', 'Naegling', 'NaeglingAcc', 'H2H', 'Staff', 'Cleaving'}
  state.RangedWeaponSet = M{['description']='Ranged Weapon Set', 'None', 'Throwing', 'Pulling', 'Archery'}

  -- Indicate if a marksmanship weapon is xbow or gun (archery and throwing not needed here)
  marksman_weapon_subtypes = {
    -- ['Gastraphetes'] = "xbow",
    -- ['Fomalhaut'] = "gun",
  }

  DefaultAmmo = {
    ['Ullr'] = "Eminent Arrow",
  }
  AccAmmo = {
    ['Ullr'] = "Eminent Arrow",
  }
  WSAmmo = {
    ['Ullr'] = "Eminent Arrow",
  }
  MagicAmmo = {
    ['Ullr'] = "Eminent Arrow",
  }

  -- Main job keybinds
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')
  
  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')
  send_command('bind ^home gs c rangedweaponset cycle')
  send_command('bind ^end gs c rangedweaponset cycleback')
  send_command('bind !end gs c rangedweaponset reset')
  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')
  
  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` input /ja "Flee" <me>')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
  send_command('bind ^numpad. input /ja "Trick Attack" <me>')
  send_command('bind %e input /ra <t>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  -- Subjob keybinds
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
  elseif player.sub_job == 'DNC' then
    send_command('bind ^- gs c cycleback mainstep')
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind %numpad0 gs c step t')
    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind !numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind !numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'RUN' then
    send_command('bind %numpad0 input //gs c rune')
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^home')
  send_command('unbind ^end')
  send_command('unbind !end')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^f8')
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @c')

  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind %e')

  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind %numpad0')
  send_command('unbind ^numlock')
  send_command('unbind !numpad0')
  send_command('unbind !numpad.')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Set to use in normal TH situations
  sets.TreasureHunter = {
    hands="Plunderer's Armlets +3", --4
    feet="Skulker's Poulaines +2", --4
  }
  -- Set to use with TH enabled while performing ranged attacks
  sets.TreasureHunter.RA = {
    hands="Plunderer's Armlets +3", --4
    feet="Skulker's Poulaines +2", --4
  }

  sets.buff['Sneak Attack'] = {}
  sets.buff['Trick Attack'] = {}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Collaborator'] = {
    -- head="Skulker's Bonnet +1",
  }
  sets.precast.JA['Accomplice'] = {
    -- head="Skulker's Bonnet +1",
  }
  sets.precast.JA['Flee'] = {
    -- feet="Pillager's Poulaines +3",
  }
  sets.precast.JA['Hide'] = {
    -- body="Pillager's Vest +3",
  }
  sets.precast.JA['Conspirator'] = {
    -- body="Skulker's Vest +1",
  }

  sets.precast.JA['Steal'] = {
    -- ammo="Barathrum", --3
    -- head="Plunderer's Bonnet +1",
    -- feet="Pillager's Poulaines +3",
  }

  sets.precast.JA['Despoil'] = {
    feet="Skulker's Poulaines +2",
    -- ammo="Barathrum",
    -- legs="Skulker's Culottes +1",
  }
  sets.precast.JA['Perfect Dodge'] = {
    hands="Plunderer's Armlets +3",
  }
  sets.precast.JA['Feint'] = {
    -- legs="Plunderer's Culottes +3", -- This needs to be kept equipped for the hit that applies Feint
  }

  sets.precast.Waltz = {
    ammo="Yamarang",
    body="Passion Jacket",
    legs="Dashing Subligar",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    body="Passion Jacket", --10
    neck="Magoraga Beads", --10
    ring1="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ammo="Impatiens",
    ring1="Weatherspoon Ring", --5
    ring2="Prolix Ring",
  })


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default WS set
  sets.precast.WS = {
    ammo="Coiste Bodhar",               -- 10, __, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head=gear.Nyame_B_head,             -- 25, 11, 65, __ < 5, __, __> (__, __) [ 7/ 7, 123] __
    body=gear.Nyame_B_body,             -- 24, 13, 65, __ < 7, __, __> (__, __) [ 9/ 9, 139] __
    hands=gear.Nyame_B_hands,           -- 42, 11, 65, __ < 5, __, __> (__, __) [ 7/ 7, 112] __
    legs=gear.Nyame_B_legs,             -- __, 12, 65, __ < 6, __, __> (__, __) [ 8/ 8, 150] __
    feet=gear.Nyame_B_feet,             -- 26, 11, 65, __ < 5, __, __> (__, __) [ 7/ 7, 150] __
    neck="Fotia Gorget",                -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    ear1="Ishvara Earring",             -- __,  2, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Moonshade Earring",           -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; tp bonus+250
    ring1="Regal Ring",                 -- 10, __, 20, __ <__, __, __> (__, __) [__/__, ___] __
    ring2="Epaminondas's Ring",         -- __,  5, __, __ <__, __, __> (__, __) [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Fotia Belt",                 -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    -- Traits/Merits/Gifts              -- __, __, __, __ <__, 19, __> (__, 22) [__/__, ___] __
    -- 167 DEX, 75 WSD, 365 Att, 20 TA Dmg <31 DA, 19 TA, 0 QA> (0 Crit Rate, 22 Crit Dmg) [48 PDT/38 MDT, 674 M.Eva] 0 PDL
  }
  -- When Sneak Attack active, overlaid on top of normal set
  sets.precast.WS.SA = {
    ammo="Yetshila +1",                 -- __, __, __, __ <__, __, __> ( 2,  6) [__/__, ___] __
    head="Pillager's Bonnet +3",        -- 37,  6, __, __ <__, __, __> (__,  5) [__/__,  83] __
    -- hands="Skulker's Armlets +3",    -- 53, __, 72, __ <__, __, __> (__, __) [11/11,  93] __; SA+30
  }
  sets.precast.WS.TA = {
    ammo="Yetshila +1",                 -- __, __, __, __ <__, __, __> ( 2,  6) [__/__, ___] __
    head="Pillager's Bonnet +3",        -- 37,  6, __, __ <__, __, __> (__,  5) [__/__,  83] __
    hands="Pillager's Armlets +3",      -- 45, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; TA+20
  }

  -- 73-85% AGI, 1.0 FTP, ftp replicating
  -- Multihit > AGI > WSD
  sets.precast.WS['Exenterator'] = {
    ammo="Cath Palug Stone",            -- 10, __, __, __ <__, __, __> [__/__, ___] __
    head=gear.Adhemar_B_head,           -- 19, __, 56, __ <__,  4, __> [__/__,  59] __
    body=gear.Nyame_B_body,             -- 33, 13, 65, __ < 7, __, __> [ 9/ 9, 139] __
    hands=gear.Adhemar_A_hands,         -- 19, __, 20, __ <__,  4, __> [__/__,  43] __
    legs="Meghanada Chausses +2",       -- 42, __, 45, __ <__,  5, __> [__/__,  69] __
    feet="Plunderer's Poulaines +3",    -- 47, __, 61, 11 <__,  5, __> [__/__,  89] __
    neck="Fotia Gorget",                -- __, __, __, __ <__, __, __> [__/__, ___] __; ftp+
    ear1="Sherida Earring",             -- __, __, __, __ < 5, __, __> [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> [__/__, ___] __
    ring1="Gere Ring",                  -- __, __, 16, __ <__,  5, __> [__/__, ___] __
    ring2="Ilabrat Ring",               -- 10, __, 25, __ <__, __, __> [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, 20 <__, __, __> [10/__, ___] __
    waist="Fotia Belt",                 -- __, __, __, __ <__, __, __> [__/__, ___] __; ftp+
    -- Traits/Merits/Gifts              -- __, __, __, __ <__, 19, __> [__/__, ___] __
    -- 210 AGI, 23 WSD, 308 Att, 31 TA Dmg <12 DA, 45 TA, 0 QA> [19 PDT/9 MDT, 399 M.Eva] 0 PDL

    -- head="Skulker's Bonnet +3",      -- 39, __, 61, __ <__,  6, __> [__/__, 109] 10
    -- body="Pillager's Vest +3",       -- 38, __, __, __ <__,  7, __> [__/__,  94] __
    -- ear2="Skulker's Earring +2",     -- 15, __, __, __ <__,  5, __> [__/__, ___] __
    -- back=gear.THF_WS3_Cape,          -- 30, __, 20, 20 <10, __, __> [10/__, ___] __
    -- 250 AGI, 0 WSD, 248 Att, 31 TA Dmg <15 DA, 56 TA, 0 QA> [10 PDT/0 MDT, 404 M.Eva] 10 PDL
  }
  sets.precast.WS['Exenterator'].MaxTP = sets.precast.WS['Exenterator']
  sets.precast.WS['Exenterator'].AttCapped = sets.precast.WS['Exenterator']
  sets.precast.WS['Exenterator'].AttCappedMaxTP = sets.precast.WS['Exenterator'].AttCapped
  
  -- 50% DEX, 1.25 FTP, can crit, ftp replicating
  sets.precast.WS['Evisceration'] = {
    ammo="Yetshila +1",                 -- __, __, __, __ <__, __, __> ( 2,  6) [__/__, ___] __
    head="Gleti's Mask",                -- 28, __, 70, __ <__, __, __> ( 5, __) [ 6/__,  86]  6
    body="Plunderer's Vest +3",         -- 46, __, 65, __ <__, __, __> ( 6,  5) [__/__,  84] __
    hands="Gleti's Gauntlets",          -- 47, __, 70, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs=gear.Lustratio_B_legs,         -- 43, __, 38, __ <__, __, __> ( 3, __) [__/__, ___] __
    feet=gear.Herc_DEX_CritDmg_feet,    -- 33, __, 10, __ <__,  2, __> (__,  3) [ 2/__,  75] __; adhemar good alt
    neck="Fotia Gorget",                -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    ear1="Odr Earring",                 -- 10, __, __, __ <__, __, __> ( 5, __) [__/__, ___] __
    ear2="Moonshade Earring",           -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; tp bonus+250
    ring1="Mummu Ring",                 -- __, __, __, __ <__, __, __> ( 3, __) [__/__, ___] __
    ring2="Hetairoi Ring",              -- __, __, __,  5 <__,  2, __> ( 1, __) [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Fotia Belt",                 -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    -- Traits/Merits/Gifts              -- __, __, __, __ <__, 19, __> (__, 22) [__/__, ___] __
    -- 237 DEX, 10 WSD, 273 Att, 25 TA Dmg <0 DA, 23 TA, 0 QA> (31 Crit Rate, 36 Crit Dmg) [25 PDT/0 MDT, 320 M.Eva] 13 PDL

    -- legs="Pillager's Culottes +3",   -- 15, __, 30, __ <__,  5, __> (__,  5) [__/__,  99] __
    -- back=gear.THF_WS4_Cape,          -- 30, __, 20, 20 <__, __, __> (10, __) [10/__, ___] __
    -- 209 DEX, 6 WSD, 265 Att, 25 TA Dmg <0 DA, 28 TA, 0 QA> (38 Crit Rate, 41 Crit Dmg) [25 PDT/0 MDT, 419 M.Eva] 13 PDL
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear2="Sherida Earring",             --  5, __, __, __ < 5, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- 15, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Yetshila +1",                 -- __, __, __, __ <__, __, __> ( 2,  6) [__/__, ___] __
    head="Pillager's Bonnet +3",        -- 37,  6, __, __ <__, __, __> (__,  5) [__/__,  83] __
    body="Plunderer's Vest +3",         -- 46, __, 65, __ <__, __, __> ( 6,  5) [__/__,  84] __
    hands="Gleti's Gauntlets",          -- 47, __, 70, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs=gear.Lustratio_B_legs,         -- 43, __, 38, __ <__, __, __> ( 3, __) [__/__, ___] __
    feet=gear.Herc_DEX_CritDmg_feet,    -- 33, __, 10, __ <__,  2, __> (__,  3) [ 2/__,  75] __; adhemar good alt
    neck="Fotia Gorget",                -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    ear1="Odr Earring",                 -- 10, __, __, __ <__, __, __> ( 5, __) [__/__, ___] __
    ear2="Moonshade Earring",           -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; tp bonus+250
    ring1="Mummu Ring",                 -- __, __, __, __ <__, __, __> ( 3, __) [__/__, ___] __
    ring2="Hetairoi Ring",              -- __, __, __,  5 <__,  2, __> ( 1, __) [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Fotia Belt",                 -- __, __, __, __ <__, __, __> (__, __) [__/__, ___] __; ftp+
    -- Traits/Merits/Gifts              -- __, __, __, __ <__, 19, __> (__, 22) [__/__, ___] __
    -- 246 DEX, 16 WSD, 203 Att, 25 TA Dmg <0 DA, 23 TA, 0 QA> (26 Crit Rate, 41 Crit Dmg) [19 PDT/0 MDT, 317 M.Eva] 7 PDL
    
    -- legs="Pillager's Culottes +3",   -- 15, __, 30, __ <__,  5, __> (__,  5) [__/__,  99] __
    -- back=gear.THF_WS4_Cape,          -- 30, __, 20, 20 <__, __, __> (10, __) [10/__, ___] __
    -- 218 DEX, 6 WSD, 195 Att, 25 TA Dmg <0 DA, 28 TA, 0 QA> (33 Crit Rate, 46 Crit Dmg) [19 PDT/0 MDT, 416 M.Eva] 7 PDL
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear2="Sherida Earring",             --  5, __, __, __ < 5, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- 15, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- 80% DEX
  -- TP Bonus > DEX <> WSD
  sets.precast.WS["Rudra's Storm"] = {
    ammo="Cath Palug Stone",            -- 10, __, __ [__/__, ___] __
    head=gear.Nyame_B_head,             -- 25, 11, 65 [ 7/ 7, 123] __
    body=gear.Nyame_B_body,             -- 24, 13, 65 [ 9/ 9, 139] __
    hands=gear.Nyame_B_hands,           -- 42, 11, 65 [ 7/ 7, 112] __
    legs=gear.Nyame_B_legs,             -- __, 12, 65 [ 8/ 8, 150] __
    feet=gear.Nyame_B_feet,             -- 26, 11, 65 [ 7/ 7, 150] __
    neck="Assassin's Gorget +2",        -- 15, __, __ [__/__, ___] __
    ear1="Moonshade Earring",           -- __, __, __ [__/__, ___] __; tp bonus+250
    ear2="Odr Earring",                 -- 10, __, __ [__/__, ___] __
    ring1="Ilabrat Ring",               -- 10, __, 25 [__/__, ___] __
    ring2="Epaminondas's Ring",         -- __,  5, __ [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20 [10/__, ___] __
    waist="Kentarch Belt +1",           -- 10, __, __ [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __ [__/__, ___] __
    -- 202 DEX, 73 WSD, 370 Att [48 PDT/38 MDT, 674 M.Eva] 0 PDL
    
    -- ammo="Coiste Bodhar",            -- 10, __, 15 [__/__, ___] __; R30
    -- body="Skulker's Vest +3",        -- 51, 12, 64 [__/__, 119] __
    -- legs="Plunderer's Culottes +3",  -- 21,  6, 64 [__/__,  89] __
    -- ear2="Skulker's Earring +2",     -- 15, __, __ [__/__, ___] __
    -- 255 DEX, 66 WSD, 432 Att [31 PDT/21 MDT, 593 M.Eva] 0 PDL
  }
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    -- ear1="Odr Earring",              -- 10, __, __ [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- 15, __, __ [__/__, ___] __
  })
  sets.precast.WS["Rudra's Storm"].AttCapped = {
    ammo="Cath Palug Stone",            -- 10, __, __ [__/__, ___] __
    head=gear.Nyame_B_head,             -- 25, 11, 65 [ 7/ 7, 123] __
    body=gear.Nyame_B_body,             -- 24, 13, 65 [ 9/ 9, 139] __
    hands=gear.Nyame_B_hands,           -- 42, 11, 65 [ 7/ 7, 112] __
    legs=gear.Lustratio_B_legs,         -- 43, __, 38 [__/__, ___] __
    feet=gear.Lustratio_D_feet,         -- 48, __, __ [__/__, ___] __
    neck="Assassin's Gorget +2",        -- 15, __, __ [__/__, ___] __
    ear1="Moonshade Earring",           -- __, __, __ [__/__, ___] __; tp bonus+250
    ear2="Odr Earring",                 -- 10, __, __ [__/__, ___] __
    ring1="Ilabrat Ring",               -- 10, __, 25 [__/__, ___] __
    ring2="Epaminondas's Ring",         -- __,  5, __ [__/__, ___] __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20 [10/__, ___] __
    waist="Kentarch Belt +1",           -- 10, __, __ [__/__, ___] __
    -- Lustratio set bonus              -- __,  4, __ [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __ [__/__, ___] __
    -- 267 DEX, 54 WSD, 278 Att [33 PDT/23 MDT, 374 M.Eva] 0 PDL
    
    -- ammo="Coiste Bodhar",            -- 10, __, 15 [__/__, ___] __; R30
    -- head="Skulker's Bonnet +3",      -- 43, __, 61 [__/__, 109] 10
    -- ear2="Skulker's Earring +2",     -- 15, __, __ [__/__, ___] __
    -- 290 DEX, 43 WSD, 274 Att [26 PDT/16 MDT, 360 M.Eva] 10 PDL
  }
  sets.precast.WS["Rudra's Storm"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {
  })
  -- Is overlaid, don't set_combine
  sets.precast.WS["Rudra's Storm"].SA = {
    ammo="Yetshila +1",                 -- __, __, __ [__/__, ___] __
    head="Pillager's Bonnet +3",        -- 37,  6, __ [__/__,  83] __
    -- head="Skulker's Bonnet +3",      -- 43, __, 61 [__/__, 109] 10
    -- hands="Skulker's Armlets +3",    -- 53, __, 72 [11/11,  93] __; SA+30
  }
  sets.precast.WS["Rudra's Storm"].TA = { -- TA uses AGI; do not use lustratio
    ammo="Yetshila +1",                 -- __, __, __ [__/__, ___] __
    head="Pillager's Bonnet +3",        -- 37,  6, __ [__/__,  83] __
    body="Plunderer's Vest +3",         -- 46, __, 65 [__/__,  84] __; TA+10
    hands="Pillager's Armlets +3",      -- 45, __, 48 [__/__,  67] __; TA+20
    legs=gear.Nyame_B_legs,             -- __, 12, 65 [ 8/ 8, 150] __
    feet=gear.Nyame_B_feet,             -- 26, 11, 65 [ 7/ 7, 150] __
    -- head="Skulker's Bonnet +3",      -- 43, __, 61 [__/__, 109] 10
    -- legs="Plunderer's Culottes +3",  -- 21,  6, 64 [__/__,  89] __
  }

  -- 40% DEX / 40% AGI; fTP 4.5-8.5
  -- Since it uses dex and agi, lustratio is not ideal
  sets.precast.WS["Shark Bite"] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS["Shark Bite"].MaxTP = sets.precast.WS["Rudra's Storm"].MaxTP
  sets.precast.WS["Shark Bite"].AttCapped = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {
    feet=gear.Nyame_B_feet,             -- 26, 11, 65, __ < 5, __, __> (__, __) [ 7/ 7, 150] __
    -- legs="Plunderer's Culottes +3",  -- 21,  6, 64, __ <__, __, __> (__, __) [__/__,  89] __
  })
  sets.precast.WS["Shark Bite"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCappedMaxTP, {
    feet=gear.Nyame_B_feet,             -- 26, 11, 65, __ < 5, __, __> (__, __) [ 7/ 7, 150] __
    -- legs="Plunderer's Culottes +3",  -- 21,  6, 64, __ <__, __, __> (__, __) [__/__,  89] __
  })

  sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS['Mandalic Stab'].MaxTP = sets.precast.WS["Rudra's Storm"].MaxTP
  sets.precast.WS['Mandalic Stab'].AttCapped = sets.precast.WS["Rudra's Storm"].AttCapped
  sets.precast.WS['Mandalic Stab'].AttCappedMaxTP = sets.precast.WS["Rudra's Storm"].AttCappedMaxTP
  
  -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Seething Bomblet +1",         -- __, __, __,  7 [__/__, ___]
    head=gear.Nyame_B_head,             -- 25, 28, 11, 30 [ 7/ 7, 123]
    body=gear.Nyame_B_body,             -- 24, 42, 13, 30 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,           -- 42, 28, 11, 30 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- __, 44, 12, 30 [ 8/ 8, 150]
    feet=gear.Herc_MAB_feet,            -- 24, __, __, 57 [ 2/__,  75]
    neck="Baetyl Pendant",              -- __, __, __, 13 [__/__, ___]
    ear1="Friomisi Earring",            -- __, __, __, 10 [__/__, ___]
    ear2="Moonshade Earring",           -- __, __, __, __ [__/__, ___]; tp bonus+250
    ring1="Epaminondas's Ring",         -- __, __,  5, __ [__/__, ___]
    ring2="Dingir Ring",                -- __, __, __, 10 [__/__, ___]
    back=gear.THF_WS1_Cape,             -- 30, __, 10, __ [10/__, ___]
    waist="Skrymir Cord",               -- __, __, __,  5 [__/__, ___]
    -- 145 DEX, 142 INT, 62 WSD, 222 MAB [43 PDT/31 MDT, 599 M.Eva]

    -- back=gear.THF_WS5_Cape,          -- __, 30, __, 10 [10/__, ___]
    -- waist="Skrymir Cord +1",         -- __, __, __,  7 [__/__, ___]
    -- 115 DEX, 172 INT, 52 WSD, 234 MAB [43 PDT/31 MDT, 599 M.Eva]
  }
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring",               -- __, __, __,  7 [__/__, ___]
  })
  sets.precast.WS['Aeolian Edge'].AttCapped = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring",               -- __, __, __,  7 [__/__, ___]
  })

  -- 50% STR / 50% MND
  -- TP Bonus > WSD > STR > MND
  sets.precast.WS['Savage Blade'] = {
    ammo="Seething Bomblet +1",         -- 15, __, 13, 13, __, __ [__/__, ___]
    head=gear.Nyame_B_head,             -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,             -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,           -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Fotia Gorget",                -- __, __, __, __, __, __ [__/__, ___]; fTP+0.1
    ear1="Ishvara Earring",             -- __, __, __, __,  2, __ [__/__, ___]
    ear2="Moonshade Earring",           -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ring1="Sroda Ring",                 -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Epaminondas's Ring",         -- __, __, __, __,  5, __ [__/__, ___]
    back=gear.THF_WS2_Cape,             -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __ [__/__, ___]
    -- 244 STR, 161 MND, 373 Attack, 260 Accuracy, 75 WSD, 3 PDL [48 PDT/38 MDT, 674 M.Eva]
  }
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Sherida Earring",             --  5, __, __, __, __, __ [__/__, ___]
  })
  sets.precast.WS['Savage Blade'].AttCapped = {
    ammo="Seething Bomblet +1",         -- 15, __, 13, 13, __, __ [__/__, ___]
    head="Gleti's Mask",                -- 33, 19, 70, 55, __,  6 [ 6/__,  86]
    body=gear.Nyame_B_body,             -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,           -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs="Gleti's Breeches",            -- 49, 20, 70, 55, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Fotia Gorget",                -- __, __, __, __, __, __ [__/__, ___]; fTP+0.1
    ear1="Ishvara Earring",             -- __, __, __, __,  2, __ [__/__, ___]
    ear2="Moonshade Earring",           -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ring1="Sroda Ring",                 -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Epaminondas's Ring",         -- __, __, __, __,  5, __ [__/__, ___]
    back=gear.THF_WS2_Cape,             -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __ [__/__, ___]
    -- 242 STR, 142 MND, 383 Attack, 280 Accuracy, 52 WSD, 17 PDL [47 PDT/23 MDT, 599 M.Eva]

    -- head="Skulker's Bonnet +3",      -- 31, 23, 61, 61, __, 10 [__/__, 109]
    -- 240 STR, 146 MND, 374 Attack, 286 Accuracy, 52 WSD, 21 PDL [41 PDT/23 MDT, 622 M.Eva]
  }
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS['Savage Blade'].AttCapped, {
    ear2="Sherida Earring",             --  5, __, __, __, __, __ [__/__, ___]
  })

  -- Asuran Fists: 15% STR / 15% VIT, 1.25 fTP, 8 hit, ftp replicating
  -- WSD > STR > VIT
  sets.precast.WS['Asuran Fists'] = {
    ammo="Seething Bomblet +1",         -- 15, __, 13, 13, __, __ [__/__, ___]
    head=gear.Nyame_B_head,             -- 26, 24, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,             -- 45, 35, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,           -- 17, 54, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- 58, 30, 65, 40, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,             -- 23, 24, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Fotia Gorget",                -- __, __, __, __, __, __ [__/__, ___]; fTP+0.1
    ear1="Ishvara Earring",             -- __, __, __, __,  2, __ [__/__, ___]
    ear2="Sherida Earring",             --  5, __, __, __, __, __ [__/__, ___]
    ring1="Regal Ring",                 -- 10, 10, 20, __, __, __ [__/__, ___]
    ring2="Epaminondas's Ring",         -- __, __, __, __,  5, __ [__/__, ___]
    back=gear.THF_WS2_Cape,             -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Fotia Belt",                 -- __, __, __, __, __, __ [__/__, ___]; fTP+0.1
    -- 229 STR, 177 VIT, 378 Attack, 256 Accuracy, 75 WSD, 0 PDL [48 PDT/38 MDT, 674 M.Eva]
  }
  sets.precast.WS['Asuran Fists'].MaxTP = sets.precast.WS['Asuran Fists']
  sets.precast.WS['Asuran Fists'].AttCapped = set_combine(sets.precast.WS['Asuran Fists'], {
    ring1="Sroda Ring",                 -- 15, __, __, __, __,  3 [__/__, ___]
  })
  sets.precast.WS['Asuran Fists'].AttCappedMaxTP = set_combine(sets.precast.WS['Asuran Fists'], {
    ring1="Sroda Ring",                 -- 15, __, __, __, __,  3 [__/__, ___]
  })

  sets.precast.RA = {
    head=gear.Herc_Snap_head,           --  6/__
    legs=gear.Adhemar_D_legs,           -- 10/13
    feet="Meg. Jam. +2",                -- 10/__
    ring1="Crepuscular Ring",           --  3/__
    waist="Yemaya Belt",                -- __/ 5
    -- 29 Snapshot / 18 Rapid Shot

    -- body=gear.Herc_Snap_body,        --  6/__
    -- hands=gear.Herc_Snap_hands,      --  6/__
    -- back=gear.THF_Snapshot_Cape,     -- 10/__
    -- 51 Snapshot / 18 Rapid Shot
  }

  -- 20% AGI/20% STR
  -- AGI, STR, WSD, R.Att, R.Acc, TP Bonus all good
  sets.precast.WS['Empyreal Arrow'] = {
    head=gear.Nyame_B_head,             -- 23, 26, 11 (60, 40) [ 7/ 7, 123]
    body=gear.Nyame_B_body,             -- 33, 45, 13 (60, 40) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,           -- 12, 17, 11 (60, 40) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- 34, 58, 12 (60, 40) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,             -- 46, 23, 11 (60, 53) [ 7/ 7, 150]
    neck="Iskur Gorget",                -- __, __, __ (30, 30) [__/__, ___]
    ear1="Telos Earring",               -- __, __, __ (10, 10) [__/__, ___]
    ring1="Regal Ring",                 -- 10, 10, __ (10, __) [__/__, ___]
    ring2="Dingir Ring",                -- 10, __, __ (25, __) [__/__, ___]
    back=gear.THF_WS2_Cape,             -- __, 30, 10 (__, __) [10/__, ___]
    waist="Yemaya Belt",                --  7, __, __ (10, 10) [__/__, ___]
    -- 175 AGI, 209 STR, 68 WSD (385 R.Att, 263 R.Acc) [48 PDT/38 MDT, 674 M.Eva]

    -- ear2="Crepuscular Earring",      -- __, __, __ (__, 10) [__/__, ___]
    -- back=gear.THF_WS6_Cape,          -- 30, __, 10 (20, 20) [10/__, ___]
    -- 205 AGI, 179 STR, 68 WSD (405 R.Att, 293 R.Acc) [48 PDT/38 MDT, 674 M.Eva]
  }


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
    ammo="Impatiens", -- SIRD
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    legs=gear.Nyame_B_legs, -- DT
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ring1="Defending Ring", -- DT
  }

  sets.midcast.RA = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    ear1="Telos Earring",
    ear2="Enervating Earring",
    ring1="Crepuscular Ring",
    ring2="Dingir Ring",
    back=gear.THF_TP_Cape,
    waist="Yemaya Belt",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Evasion = {
    ammo="Yamarang",              -- __/__,  15,  15
    head="Malignance Chapeau",    --  6/ 6, 123,  91
    body="Malignance Tabard",     --  9/ 9, 139, 102
    hands="Malignance Gloves",    --  5/ 5, 112,  80
    legs="Malignance Tights",     --  7/ 7, 150,  85
    feet="Malignance Boots",      --  4/ 4, 150, 119
    neck="Assassin's Gorget +2",  -- __/__, ___,  25
    ear1="Eabani Earring",        -- __/__,   8,  15
    ear2="Infused Earring",       -- __/__, ___,  10
    ring1="Moonlight Ring",       --  5/ 5, ___, ___
    ring2="Moonlight Ring",       --  5/ 5, ___, ___
    waist="Kasiri Belt",          -- __/__, ___,  13
    -- Cape                          10/__, ___, ___
    -- 51 PDT / 41 MDT, 697 MEVA, 555 Evasion
  }

  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139 
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    ring2="Moonlight Ring",     --  5/ 5, ___
    -- Cape                     -- 10/__, ___
    -- 49 PDT/39 MDT, 674 MEVA
  }

  sets.defense.PDT = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Assassin's Gorget +2",-- __/__, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
    -- 54 PDT/46 MDT, 697 MEVA
  }
  sets.defense.MDT = sets.defense.PDT


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regen = {
    head="Turms Cap +1",
    hands="Turms Mittens +1",
    feet="Turms Leggings +1",
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
    ammo="Yamarang",            -- __/__,  15
    head="Turms Cap +1",        -- __/__, 109
    body="Gleti's Cuirass",     --  9/__, 102
    hands="Gleti's Gauntlets",  --  7/__,  75
    legs="Gleti's Breeches",    --  8/__, 112
    feet="Gleti's Boots",       --  5/__, 112
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
    -- 63 PDT/26 MDT, 533 M.Eva
  }

  sets.idle.Regain = sets.idle
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = set_combine(sets.idle, sets.HeavyDef)
  sets.idle.HeavyDef.Regain = set_combine(sets.idle.Regain, sets.HeavyDef)
  sets.idle.HeavyDef.Regen = set_combine(sets.idle.Regen, sets.HeavyDef)
  sets.idle.HeavyDef.Refresh = set_combine(sets.idle.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.HeavyDef)

  sets.idle.Evasion = set_combine(sets.idle, sets.Evasion)

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    neck="Loricate Torque +1",  --  6/ 6, ___
    ring1="Gelatinous Ring +1", --  7/-1, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back="Moonlight Cape",      --  6/ 6, ___
  })

  -- Gear to show off when in cities. Optional.
  sets.idle.Town = {
    ammo="Coiste Bodhar",
    head="Gleti's Mask",
    body=gear.Nyame_B_body,
    hands="Plunderer's Armlets +3",
    legs=gear.Samnuha_legs,
    feet="Gleti's Boots",
    neck="Assassin's Gorget +2",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Sroda Ring",
    ring2="Epaminondas's Ring",
    back="Moonlight Cape",
    waist="Reiki Yotai",
  }
  

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Malignance Tabard",           -- __, 11, 50, __ <__, __, __> (__, __) [ 9/ 9, 139]  6
    hands=gear.Adhemar_A_hands,         -- __,  7, 52, __ <__,  4, __> (__, __) [__/__,  43] __
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Dedition Earring",            -- __,  8,-10, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Chiner's Belt +1",           -- __, __, __,  5 <__,  2, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 0 DW, 62 STP, 281 Acc, 61 TA Dmg <3 DA, 42 TA, 0 QA> (0 Crit Rate, 22 Crit Dmg) [37 PDT/27 MDT, 544 MEVA] 14 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 0 DW, 70 STP, 301 Acc, 61 TA Dmg <3 DA, 44 TA, 0 QA> (0 Crit Rate, 22 Crit Dmg) [37 PDT/27 MDT, 544 MEVA] 14 PDL
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    waist="Olseni Belt",                -- __,  3, 20, __ <__, __, __> (__, __) [__/__, ___] __
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    hands="Malignance Gloves",          -- __, 11, 50, __ <__, __, __> (__, __) [ 5/ 5, 112]  4
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- Low DW (6 needed from gear)
  sets.engaged.LowDW = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands=gear.Adhemar_A_hands,         -- __,  7, 52, __ <__,  4, __> (__, __) [__/__,  43] __
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Dedition Earring",            -- __,  8,-10, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 7 DW, 50 STP, 273 Acc, 66 TA Dmg <3 DA, 40 TA, 0 QA> (6 Crit Rate, 27 Crit Dmg) [33 PDT/23 MDT, 489 MEVA] 8 PDL
    
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 7 DW, 58 STP, 293 Acc, 66 TA Dmg <3 DA, 40 TA, 0 QA> (6 Crit Rate, 27 Crit Dmg) [33 PDT/23 MDT, 489 MEVA] 8 PDL
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    hands="Malignance Gloves",          -- __, 11, 50, __ <__, __, __> (__, __) [ 5/ 5, 112]  4
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- Mid DW (13 needed from gear)
  sets.engaged.MidDW = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands=gear.Adhemar_A_hands,         -- __,  7, 52, __ <__,  4, __> (__, __) [__/__,  43] __
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 12 DW, 42 STP, 283 Acc, 66 TA Dmg <3 DA, 40 TA, 0 QA> (6 Crit Rate, 27 Crit Dmg) [33 PDT/23 MDT, 489 MEVA] 8 PDL
    
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 12 DW, 50 STP, 303 Acc, 66 TA Dmg <3 DA, 42 TA, 0 QA> (6 Crit Rate, 27 Crit Dmg) [33 PDT/23 MDT, 489 MEVA] 8 PDL
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
    hands="Malignance Gloves",          -- __, 11, 50, __ <__, __, __> (__, __) [ 5/ 5, 112]  4
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- High DW (26 needed from gear)
  sets.engaged.HighDW = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands=gear.Adhemar_A_hands,         -- __,  7, 52, __ <__,  4, __> (__, __) [__/__,  43] __
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 26 DW, 32 STP, 283 Acc, 66 TA Dmg <3 DA, 37 TA, 0 QA> (6 Crit Rate, 27 Crit Dmg) [33 PDT/23 MDT, 497 MEVA] 8 PDL
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
    hands="Malignance Gloves",          -- __, 11, 50, __ <__, __, __> (__, __) [ 5/ 5, 112]  4
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- Super DW (37 needed from gear)
  sets.engaged.SuperDW = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body=gear.Adhemar_A_body,           --  6, __, 55, __ <__,  4, __> (__, __) [__/__,  69] __
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 37 DW, 25 STP, 294 Acc, 56 TA Dmg <3 DA, 37 TA, 0 QA> (0 Crit Rate, 26 Crit Dmg) [33 PDT/23 MDT, 506 MEVA] 8 PDL
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })

  -- Max DW (44 needed from gear)
  sets.engaged.MaxDW = {
    ammo="Coiste Bodhar",               -- __,  3, __, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body=gear.Adhemar_A_body,           --  6, __, 55, __ <__,  4, __> (__, __) [__/__,  69] __
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet=gear.Herc_DW_feet,             --  5, __, 23, __ <__,  2, __> (__, __) [ 2/__,  75] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 42 DW, 25 STP, 281 Acc, 45 TA Dmg <0 DA, 34 TA, 0 QA> (0 Crit Rate, 26 Crit Dmg) [35 PDT/23 MDT, 492 MEVA] 8 PDL
  }
  sets.engaged.MaxDW.LowAcc = set_combine(sets.engaged.MaxDW, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
  })
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW.LowAcc, {
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Malignance Tabard",           -- __, 11, 50, __ <__, __, __> (__, __) [ 9/ 9, 139]  6
    hands="Gleti's Gauntlets",          -- __,  7, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Odnowa Earring +1",           -- __, __, __, __ <__, __, __> (__, __) [ 3/ 5, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Chiner's Belt +1",           -- __, __, __,  5 <__,  2, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 0 DW, 51 STP, 294 Acc, 61 TA Dmg <0 DA, 38 TA, 0 QA> (6 Crit Rate, 22 Crit Dmg) [50 PDT/35 MDT, 576 MEVA] 21 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 0 DW, 59 STP, 314 Acc, 61 TA Dmg <0 DA, 38 TA, 0 QA> (6 Crit Rate, 22 Crit Dmg) [50 PDT/35 MDT, 576 MEVA] 21 PDL
  }
  sets.engaged.HeavyDef.LowAcc = set_combine(sets.engaged.HeavyDef, {
    waist="Olseni Belt",                -- __,  3, 20, __ <__, __, __> (__, __) [__/__, ___] __
  })
  sets.engaged.HeavyDef.MidAcc = set_combine(sets.engaged.HeavyDef.LowAcc, {
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
  })
  sets.engaged.HeavyDef.HighAcc = set_combine(sets.engaged.HeavyDef.MidAcc, {
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
  })

  -- Low DW (6 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands="Gleti's Gauntlets",          -- __,  7, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Dedition Earring",            -- __,  8,-10, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gelatinous Ring +1",         -- __, __, __, __ <__, __, __> (__, __) [ 7/-1, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 7 DW, 47 STP, 276 Acc, 66 TA Dmg <0 DA, 31 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/25 MDT, 521 MEVA] 15 PDL
    
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 7 DW, 55 STP, 296 Acc, 66 TA Dmg <0 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/25 MDT, 521 MEVA] 15 PDL
  }
  sets.engaged.LowDW.HeavyDef.LowAcc = set_combine(sets.engaged.LowDW.HeavyDef, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    ear1="Odnowa Earring +1",           -- __, __, 10, __ <__, __, __> (__, __) [ 3/ 5, ___] __
    -- 7 DW, 42 STP, 311 Acc, 66 TA Dmg <0 DA, 31 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/27 MDT, 536 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 7 DW, 50 STP, 331 Acc, 66 TA Dmg <0 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/27 MDT, 536 MEVA] 15 PDL
  })
  sets.engaged.LowDW.HeavyDef.MidAcc = set_combine(sets.engaged.LowDW.HeavyDef.LowAcc, {
    feet="Skulker's Poulaines +2",      -- __, __, 50, __ <__, __, __> (__, __) [10/10, 115] __
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 7 DW, 47 STP, 325 Acc, 55 TA Dmg <1 DA, 31 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 7 DW, 55 STP, 345 Acc, 55 TA Dmg <1 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
  })
  sets.engaged.LowDW.HeavyDef.HighAcc = set_combine(sets.engaged.LowDW.HeavyDef.MidAcc, {
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Olseni Belt",                -- __,  3, 20, __ <__, __, __> (__, __) [__/__, ___] __
    -- 10 DW, 46 STP, 351 Acc, 55 TA Dmg <1 DA, 26 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 10 DW, 54 STP, 371 Acc, 55 TA Dmg <1 DA, 28 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
  })

  -- Mid DW (13 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands="Gleti's Gauntlets",          -- __,  8, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Skulker's Earring",           -- __, __, __, __ <__,  3, __> (__, __) [__/__, ___] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gelatinous Ring +1",         -- __, __, __, __ <__, __, __> (__, __) [ 7/-1, ___] __
    back=gear.THF_TP_Cape,              -- __, 10, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 12 DW, 40 STP, 286 Acc, 66 TA Dmg <0 DA, 31 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/25 MDT, 521 MEVA] 15 PDL
    
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 12 DW, 48 STP, 306 Acc, 66 TA Dmg <0 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/25 MDT, 521 MEVA] 15 PDL
  }
  sets.engaged.MidDW.HeavyDef.LowAcc = set_combine(sets.engaged.MidDW.HeavyDef, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    feet="Skulker's Poulaines +2",      -- __, __, 50, __ <__, __, __> (__, __) [10/10, 115] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 12 DW, 43 STP, 315 Acc, 55 TA Dmg <0 DA, 31 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
    
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 12 DW, 51 STP, 335 Acc, 55 TA Dmg <0 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
  })
  sets.engaged.MidDW.HeavyDef.MidAcc = set_combine(sets.engaged.MidDW.HeavyDef.LowAcc, {
    ear2="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    -- 12 DW, 58 STP, 341 Acc, 55 TA Dmg <1 DA, 23 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __  <__,  5, __>(__, __) [__/__, ___] __
    -- 12 DW, 51 STP, 335 Acc, 55 TA Dmg <0 DA, 33 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
  })
  sets.engaged.MidDW.HeavyDef.HighAcc = set_combine(sets.engaged.MidDW.HeavyDef.MidAcc, {
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Olseni Belt",                -- __,  3, 20, __ <__, __, __> (__, __) [__/__, ___] __
    -- 10 DW, 50 STP, 361 Acc, 55 TA Dmg <1 DA, 23 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 10 DW, 55 STP, 371 Acc, 55 TA Dmg <1 DA, 28 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 562 MEVA] 15 PDL
  })

  -- High DW (26 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body="Plunderer's Vest +3",         -- __, __, 40, 10 <__, __, __> ( 6,  5) [__/__,  84] __; 5% TA from behind target
    hands="Gleti's Gauntlets",          -- __,  8, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gelatinous Ring +1",         -- __, __, __, __ <__, __, __> (__, __) [ 7/-1, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 26 DW, 30 STP, 286 Acc, 66 TA Dmg (12 Crit Rate, 27 Crit Dmg) <0 DA, 28 TA, 0 QA> [50 PDT/25 MDT, 529 MEVA] 15 PDL
  }
  sets.engaged.HighDW.HeavyDef.LowAcc = set_combine(sets.engaged.HighDW.HeavyDef, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    feet="Skulker's Poulaines +2",      -- __, __, 50, __ <__, __, __> (__, __) [10/10, 115] __
    ring2="Gere Ring",                  -- __, __, __, __ <__,  5, __>  (__, __)[__/__, ___] __
    -- 26 DW, 33 STP, 315 Acc, 55 TA Dmg <0 DA, 28 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [50 PDT/33 MDT, 570 MEVA] 15 PDL
    
    -- feet="Skulker's Poulaines +3",   -- __, __, 60, __ <__, __, __> (__, __) [11/11, 125] __
    -- 26 DW, 33 STP, 325 Acc, 55 TA Dmg <0 DA, 28 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [51 PDT/34 MDT, 580 MEVA] 15 PDL
  })
  sets.engaged.HighDW.HeavyDef.MidAcc = set_combine(sets.engaged.HighDW.HeavyDef.LowAcc, {
    ring1="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    -- 26 DW, 43 STP, 325 Acc, 55 TA Dmg <0 DA, 23 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [51 PDT/34 MDT, 580 MEVA] 15 PDL
  })
  sets.engaged.HighDW.HeavyDef.HighAcc = set_combine(sets.engaged.HighDW.HeavyDef.MidAcc, {
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- 17 DW, 51 STP, 361 Acc, 55 TA Dmg <1 DA, 23 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [51 PDT/34 MDT, 572 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 17 DW, 56 STP, 371 Acc, 55 TA Dmg <1 DA, 28 TA, 0 QA> (12 Crit Rate, 27 Crit Dmg) [51 PDT/34 MDT, 572 MEVA] 15 PDL
  })

  -- Super DW (37 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body=gear.Adhemar_A_body,           --  6, __, 55, __ <__,  4, __> (__, __) [__/__,  69] __
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet="Plunderer's Poulaines +3",    -- __, __, 36, 11 <__,  5, __> (__, __) [__/__,  89] __
    neck="Loricate Torque +1",          -- __, __, __, __ <__, __, __> (__, __) [ 6/ 6, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Gelatinous Ring +1",         -- __, __, __, __ <__, __, __> (__, __) [ 7/-1, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 37 DW, 22 STP, 269 Acc, 51 TA Dmg <0 DA, 28 TA, 0 QA> (0 Crit Rate, 26 Crit Dmg) [49 PDT/31 MDT, 506 MEVA] 8 PDL
  }
  sets.engaged.SuperDW.HeavyDef.LowAcc = set_combine(sets.engaged.SuperDW.HeavyDef, {
    feet="Skulker's Poulaines +2",      -- __, __, 50, __ <__, __, __> (__, __) [10/10, 115] __
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    -- 37 DW, 27 STP, 316 Acc, 45 TA Dmg <0 DA, 27 TA, 0 QA> (0 Crit Rate, 26 Crit Dmg) [51 PDT/41 MDT, 532 MEVA] 8 PDL
    
    -- feet="Skulker's Poulaines +3",   -- __, __, 60, __<__, __, __> (__, __)  [11/11, 125] __
    -- 37 DW, 27 STP, 326 Acc, 45 TA Dmg  <0 DA, 27 TA, 0 QA>(0 Crit Rate, 26 Crit Dmg) [52 PDT/42 MDT, 542 MEVA] 8 PDL
  })
  sets.engaged.SuperDW.HeavyDef.MidAcc = set_combine(sets.engaged.SuperDW.HeavyDef.LowAcc, {
    ammo="Yamarang",                    -- __,  3, 15, __ <__, __, __> (__, __) [__/__,  15] __
    hands="Gleti's Gauntlets",          -- __,  8, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    -- 32 DW, 43 STP, 356 Acc, 45 TA Dmg <0 DA, 27 TA, 0 QA> (6 Crit Rate, 22 Crit Dmg) [51 PDT/34 MDT, 565 MEVA] 15 PDL
  })
  sets.engaged.SuperDW.HeavyDef.HighAcc = set_combine(sets.engaged.SuperDW.HeavyDef.MidAcc, {
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- 23 DW, 51 STP, 376 Acc, 45 TA Dmg <1 DA, 27 TA, 0 QA> (6 Crit Rate, 22 Crit Dmg) [51 PDT/34 MDT, 557 MEVA] 15 PDL

    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
    -- 23 DW, 56 STP, 386 Acc, 45 TA Dmg <1 DA, 32 TA, 0 QA> (6 Crit Rate, 22 Crit Dmg) [51 PDT/34 MDT, 557 MEVA] 15 PDL
  })

  -- Max DW (44 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    ammo="Staunch Tathlum +1",          -- __, __, __, __ <__, __, __> (__, __) [ 3/ 3, ___] __
    head="Malignance Chapeau",          -- __,  8, 50, __ <__, __, __> (__, __) [ 6/ 6, 123]  3
    body=gear.Adhemar_A_body,           --  6, __, 55, __ <__,  4, __> (__, __) [__/__,  69] __
    hands="Pillager's Armlets +3",      --  5, __, 48, __ <__, __, __> (__,  4) [__/__,  67] __; AF set
    legs="Malignance Tights",           -- __, 10, 50, __ <__, __, __> (__, __) [ 7/ 7, 150]  5
    feet=gear.Herc_DW_feet,             --  5, __, 23, __ <__,  2, __> (__, __) [ 2/__,  75] __
    neck="Loricate Torque +1",          -- __, __, __, __ <__, __, __> (__, __) [ 6/ 6, ___] __
    ear1="Suppanomimi",                 --  5, __, __, __ <__, __, __> (__, __) [__/__, ___] __
    ear2="Eabani Earring",              --  4, __, __, __ <__, __, __> (__, __) [__/__,   8] __
    ring1="Defending Ring",             -- __, __, __, __ <__, __, __> (__, __) [10/10, ___] __
    ring2="Moonlight Ring",             -- __,  5,  8, __ <__, __, __> (__, __) [ 5/ 5, ___] __
    back=gear.THF_DW_Cape,              -- 10, __, 20, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Reiki Yotai",                --  7,  4, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- Traits/Merits/Gifts              -- __, __, __, 20 <__, 19, __> (__, 22) [__/__, ___] __
    -- 42 DW, 27 STP, 264 Acc, 40 TA Dmg <0 DA, 25 TA, 0 QA> (0 Crit Rate, 26 Crit Dmg) [49 PDT/37 MDT, 492 MEVA] 8 PDL
  }
  sets.engaged.MaxDW.HeavyDef.LowAcc = set_combine(sets.engaged.MaxDW.HeavyDef, {
    hands="Gleti's Gauntlets",          -- __,  8, 55, __ <__, __, __> ( 6, __) [ 7/__,  75]  7
    neck="Assassin's Gorget +2",        -- __, __, 25,  5 <__,  4, __> (__, __) [__/__, ___] __
  })
  sets.engaged.MaxDW.HeavyDef.MidAcc = set_combine(sets.engaged.MaxDW.HeavyDef.LowAcc, {
    feet="Malignance Boots",            -- __,  9, 50, __ <__, __, __> (__, __) [ 4/ 4, 150]  2
  })
  sets.engaged.MaxDW.HeavyDef.HighAcc = set_combine(sets.engaged.MaxDW.HeavyDef.MidAcc, {
    ear1="Telos Earring",               -- __,  5, 10, __ < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dignitary's Earring",         -- __,  3, 10, __ <__, __, __> (__, __) [__/__, ___] __
    -- ear2="Skulker's Earring +2",     -- __,  8, 20, __ <__,  5, __> (__, __) [__/__, ___] __
  })


  -- Evasion Hybrid
  sets.engaged.Evasion = set_combine(sets.Evasion, { back=gear.THF_TP_Cape })
  sets.engaged.LowDW.Evasion = set_combine(sets.Evasion, { back=gear.THF_DW_Cape })
  sets.engaged.MidDW.Evasion = set_combine(sets.Evasion, { back=gear.THF_DW_Cape })
  sets.engaged.HighDW.Evasion = set_combine(sets.Evasion, { back=gear.THF_DW_Cape })
  sets.engaged.SuperDW.Evasion = set_combine(sets.Evasion, { back=gear.THF_DW_Cape })
  sets.engaged.MaxDW.Evasion = set_combine(sets.Evasion, { back=gear.THF_DW_Cape })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Skadi's Jambeaux +1",
    -- feet="Pillager's Poulaines +3",
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
  sets.WeaponSet['WhiteGlass'] = {
    main="Twashtar",
    sub={name="Centovente", priority=1},
  }
  sets.WeaponSet['Normal'] = {
    main="Twashtar",
    sub="Gleti's Knife",
  }
  sets.WeaponSet['LowAtt'] = {
    -- main="Vajra",
    -- sub="Centovente",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Centovente",
  }
  sets.WeaponSet['NaeglingAcc'] = {
    main="Naegling",
    sub="Ternion Dagger +1",
  }
  sets.WeaponSet['H2H'] = {
    main="Karambit",
    sub=empty,
  }
  sets.WeaponSet['SoloCleaving'] = {
  --   main=gear.Gandring_C,
  --   sub="Tauret",
  }
  sets.WeaponSet['Cleaving'] = {
    main="Tauret",
    sub="Twashtar",
  }
  sets.WeaponSet['Staff'] = {
    main="Gozuki Mezuki",
    sub="empty",
  }

  -- Ranged weapon sets
  sets.WeaponSet['Archery'] = {
    -- ranged="Ullr",
    -- ammo="Eminent Arrow",
  }
  sets.WeaponSet['Throwing'] = {
    ranged="Antitail +1",
    ammo=empty,
  }
  sets.WeaponSet['Pulling'] = {
    ranged="Jinx Discus",
    ammo=empty,
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
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
  if spell.type == 'WeaponSkill' then
    if state.Buff['Sneak Attack'] then
    -- If set isn't found for specific ws, overlay the default set
      local set = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].SA) or sets.precast.WS.SA or {}
      equip(set)
    end
    if state.Buff['Trick Attack'] then
    -- If set isn't found for specific ws, overlay the default set
      local set = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].TA) or sets.precast.WS.TA or {}
      equip(set)
    end
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

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
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
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
    state.Buff['Trick Attack'] = false
    state.Buff['Feint'] = false
  end
end

-- Called after the default aftercast handling is complete.
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
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)

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
  update_dp_type() -- Requires DistancePlus addon
  check_gear()
  update_idle_groups()
  update_combat_form()

  -- Check for SATA when equipping gear.  If either is active, equip
  -- that gear specifically, and block equipping default gear.
  check_buff('Sneak Attack', eventArgs)
  check_buff('Trick Attack', eventArgs)
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 0 or not silibs.is_dual_wielding() then
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

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    idleSet = set_combine(idleSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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

function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    meleeSet = set_combine(meleeSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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
  
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    defenseSet = set_combine(defenseSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

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
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
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

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  else
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(sets.WeaponSet[state.WeaponSet.current])
end

function cycle_ranged_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.RangedWeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.RangedWeaponSet:cycleback()
  else
    state.RangedWeaponSet:reset()
  end

  add_to_chat(141, 'RA Weapon Set to '..string.char(31,1)..state.RangedWeaponSet.current)
  equip(sets.WeaponSet[state.RangedWeaponSet.current])
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

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'step' then
    send_command('@input /ja "'..state.MainStep.Current..'" <t>')
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_toy_weapons('current')
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
  elseif cmdParams[1] == 'rangedweaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_ranged_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_ranged_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_ranged_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_ranged_weapons('current')
    end
  elseif cmdParams[1] == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
  if state.Buff[buff_name] then
    equip(sets.buff[buff_name] or {})
    eventArgs.handled = true
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
  if player.sub_job == 'RUN' then
    set_macro_page(4, 8)
  else
    set_macro_page(5, 8)
  end
end

function test()
end