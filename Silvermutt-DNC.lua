--[[
File Status: Good.
TODO: Acc modes for engaged sets are outdated. Add Terpsichore AM engaged set variants with less multihit.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: HasteInfo, DistancePlus
Recommended addons: WSBinder, Reorganizer, Metronome
Misc Recommendations: Disable GearInfo, disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Offense Mode: Changes melee accuracy level
* Hybrid Mode: Changes damage taken level while engaged
  * Normal: Highest damage output
  * HeavyDef: Defensive set with decent offensive stats
  * Safe: Very defensive set. Causes weaponskills with a "Safe" variant to be used.
* Idle Mode: Determines which set to use when not engaged
  * Normal: Allows automatically equipping Regen, Refresh, and Regain gear as needed
  * HeavyDef: Uses defensive set and disables automatically equipping Regen, Refresh, and Regain gear
  * Regain: Equips maximum Regain gear. This set is not balanced with other stats and may overwrite movement speed
    gear. This is intended for short term use only when needed.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Main Step: Selects the step to use as main step
* Alt Step: Selects the step to use as alternate step

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* All other sets (like precast, midcast, idle, etc.) should exclude weapons (main, sub, range).
  * Ammo will be ignored and handled through a library function based on the configs you set in the setup.
* If you enable one of the ToyWeapons modes, it will lock your weapons into low level weapons. This can be
  useful if you are intentionally trying not to kill something, like low level enemies where you may need
  to proc them with a WS without killing them. This overrides all other weapon modes and weapon equip logic.
  * Memorize the keybind to turn it off in case you toggle it by accident.

Abilities
* It is typical to maintain 2 different steps during longer (boss) fights. To aid in this, you should set your
  main and alt step cycles to the steps you intend to use and then use the keybinds to execute them for convenience.
* The recommended Metronome addon will display Step level and timers so you don't have to risk steps falling off or
  wasting a step cooldown on one that is already max level.
* Using a step will automatically use Presto first if it's not on cooldown.

Other
* If you are not using my reorganizer addon, remove all the sets.org sets (including in character global file).
* I generally plan out best-in-slot (BiS) pieces for each set even before I acquire the pieces. These BiS pieces are
  left commented out in the set, while placeholders that I do have in the meantime are uncommented for that slot.
* I like to list out the important stats for each piece of item in most of my sets, and then have a total at
  the bottom of the set. If you ever change any pieces of gear, you should recalculate the stats for the new piece
  and then recalculate for the set total, or just remove those stat comments entirely to avoid confusion. However,
  if you choose to ignore them, it doesn't not actually affect anything.
* Equipping certain gear such as warp rings or ammo belts will automatically lock that slot until you manually
  unequip it or change zones.
* Set named sets.SleepyHead will be equipped if you are asleep. This should have a piece of gear in it that
  will deal damage to you to wake you up.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                      Keybinds
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

Modes:
  [ F9 ]              Cycle Melee Accuracy
  [ CTRL+F9 ]         Cycle Melee Defense
  [ ALT+F9 ]          Cycle Ranged Accuracy
  [ F10 ]             Toggle Emergency -PDT
  [ ALT+F10 ]         Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]             Toggle Emergency -MDT
  [ F12 ]             Report current status
  [ CTRL+F12 ]        Cycle Idle modes
  [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
  [ WIN+C ]           Toggle Capacity Points Mode
  [ CTRL+- ]          Cycleback Main Step
  [ CTRL+= ]          Cycle Main Step
  [ ALT+- ]           Cycleback Alt Step
  [ ALT+= ]           Cycle Alt Step
  [ CTRL+F8 ]         Toggle Attack Capped mode

Weapons:
  [ CTRL+Insert ]     Cycle Weapon Sets
  [ CTRL+Delete ]     Cycleback Weapon Sets
  [ ALT+Delete ]      Reset to default Weapon Set
  [ CTRL+Home ]       Cycle Ranged Weapon Sets
  [ CTRL+End ]        Cycleback Ranged Weapon Sets
  [ ALT+End ]         Reset to default Ranged Weapon Set
  [ CTRL+PageUp ]     Cycle Toy Weapon Sets
  [ CTRL+PageDown ]   Cycleback Toy Weapon Sets
  [ ALT+PageDown ]    Reset to default Toy Weapon Set

Spells:
  ============ /NIN ============
  [ ALT+Numpad0 ]     Utsusemi: Ichi
  [ ALT+Numpad. ]     Utsusemi: Ni

Abilities:
  [ ALT+` ]           Chocobo Jig II
  [ ALT+Q ]           Saber Dance
  [ ALT+W ]           Reverse Flourish
  [ ALT+E ]           Contradance
  [ CTRL+Numpad+ ]    Climactic Flourish
  [ CTRL+NumpadEnter ]Building Flourish
  [ Numpad0 ]         Execute main step
  [ Numpad. ]         Execute alt step
  ============ /WAR ============
  [ CTRL+Numlock ]    Defender
  [ CTRL+Numpad/ ]    Berserk
  [ CTRL+Numpad* ]    Warcry
  [ CTRL+Numpad- ]    Aggressor
  ============ /SAM ============
  [ CTRL+Numlock ]    Third Eye
  [ CTRL+Numpad/ ]    Meditate
  [ CTRL+Numpad* ]    Sekkanoki
  [ CTRL+Numpad- ]    Hasso
  ============ /THF ============
  [ CTRL+Numpad0 ]    Sneak Attack
  [ CTRL+Numpad. ]    Trick Attack
  ============ /DRG ============
  [ CTRL+Numlock ]    Ancient Circle
  [ CTRL+Numpad/ ]    Jump
  [ CTRL+Numpad* ]    High Jump
  [ CTRL+Numpad- ]    Super Jump

Other:
  [ Numpad0 ]         Ranged Attack

SilverLibs keybinds:
  [ ALT+D ]           Interact
  [ ALT+S ]           Turn 180 degrees in place
  [ WIN+W ]           Toggle Rearming Lock
                      (off = re-equip previous weapons if you go barehanded)
                      (on = prevent weapon auto-equipping)
  [ CTRL+` ]          Cycle Treasure Hunter Mode

For more info and available functions, see SilverLibs documentation at:
https://github.com/shastaxc/silver-libs

Global-Binds.lua contains additional non-job-related keybinds.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  Custom Commands
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Prepend with /console to use these in in-game macros.

gs c step             Uses the currently configured step on the current target.
gs c altstep          Uses the currently configured "alt" step on the current target.

gs c bind             Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] NoFootRi       /ja "No Foot Rise" <me>
[ CTRL+2 ] Stun           /ja "Violent Flourish" <t>
[ CTRL+3 ] Animated       /ja "Animated Flourish" <stnpc>
[ CTRL+4 ] Haste          /ja "Haste Samba" <me>
[ CTRL+9 ] Trance         /ja "Trance" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Cure           /ja "Curing Waltz" <stpc>
[ ALT+2 ]  Divine1        /ja "Divine Waltz" <stpc>
[ ALT+3 ]  Divine2        /ja "Divine Waltz II" <stpc>
[ ALT+9 ]  GrandPas       /ja "Grand Pas" <me>
[ ALT+0 ]  FanDance       /ja "Fan Dance" <me>

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

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(20)
  silibs.enable_waltz_refiner({
    bonus_chr = 195,
    bonus_vit = 117,
    waltz_potency = 50,
    waltz_self_potency = 8,
    est_non_party_target_hp = 2000,
  })
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false

  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AltStep = M{['description']='Alt Step', 'Feather Step', 'Stutter Step', 'Box Step', 'Quickstep'}

  state.CP = M(false, 'Capacity Points Mode')
  state.AttCapped = M(true, 'Attack Capped')

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Safe', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef', 'Regain')

  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.RangedWeaponSet = M{['description']='Ranged Weapon Set', 'None', 'Throwing', 'Pulling'}

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^home'] = 'gs c rangedweaponset cycle',
      ['^end'] = 'gs c rangedweaponset cycleback',
      ['!end'] = 'gs c rangedweaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^-'] = 'gs c cycleback mainstep',
      ['^='] = 'gs c cycle mainstep',
      ['!-'] = 'gs c cycleback altstep',
      ['!='] = 'gs c cycle altstep',
      ['!`'] = 'input /ja "Chocobo Jig II" <me>',
      ['!q'] = 'input /ja "Saber Dance" <me>',
      ['!w'] = 'input /ja "Reverse Flourish" <me>',
      ['!e'] = 'input /ja "Contradance" <me>',
      ['^numpad+'] = 'input /ja "Climactic Flourish" <me>',
      ['^numpadenter'] = 'input /ja "Building Flourish" <me>',
      ['%numpad0'] = 'gs c step',
      ['%numpad.'] = 'gs c altstep',
      ['%e'] = 'input /ra <t>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['SAM'] = {
      ['^numlock'] = 'input /ja "Third Eye" <me>',
      ['^numpad/'] = 'input /ja "Meditate" <me>',
      ['^numpad*'] = 'input /ja "Sekkanoki" <me>',
      ['^numpad-'] = 'input /ja "Hasso" <me>',
    },
    ['THF'] = {
      ['^numpad0'] = 'input /ja "Sneak Attack" <me>',
      ['^numpad.'] = 'input /ja "Trick Attack" <me>',
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

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if S{'PLD','WAR','MNK','BLM','DRG','SMN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Onion', 'OnionAcc', 'Twashtar', 'TwashtarAcc', 'Terpsichore', 'Cleaving', 'Healing', 'SubtleBlow', 'H2H', 'Staff'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Onion', 'OnionAcc', 'Twashtar', 'TwashtarAcc', 'Terpsichore', 'Cleaving', 'Healing', 'SubtleBlow', 'H2H'}
  end

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
    sets.org.job[1] = {range="Albin Bane"}
  end

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    feet="Skadi's Jambeaux +1"
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

  -- Enmity set
  sets.Enmity = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Halitus Helm",              --  8 [__/__,  43]
    body="Emet Harness +1",           -- 10 [ 6/__,  64]
    hands="Horos Bangles +3",         --  9 [__/__,  57]
    legs=gear.Nyame_B_legs,           -- __ [ 8/ 8, 150]
    feet="Ahosi Leggings",            --  7 [ 4/__, 107]
    ear1="Cryptic Earring",           --  4 [__/__, ___]
    ear2="Trux Earring",              --  5 [__/__, ___]
    ring1="Eihwaz Ring",              --  5 [__/__, ___]
    ring2="Supershear Ring",          --  5 [__/__, ___]
    neck="Unmoving Collar +1",        -- 10 [__/__, ___]
    back=gear.DNC_TP_DA_Cape,         -- __ [10/__, ___]
    waist="Kasiri Belt",              --  3 [__/__, ___]
    -- 68 Enmity [28 PDT/8 MDT, 421 M.Eva]

    -- hands="Horos Bangles +4",      --  9 [__/__,  97]
    -- back=gear.DNC_Enmity_Cape,     -- 10 [10/__, ___]
    -- 78 Enmity [28 PDT/8 MDT, 461 M.Eva]
  }

  sets.HybridAcc = {
    ammo="Yamarang",                  -- 15, 15 [__/__, ___]
    head="Maculele Tiara +3",         -- 61, 61 [__/__,  99]
    body="Horos Casaque +3",          -- 50, 40 [ 6/__,  84]
    hands="Maculele Bangles +3",      -- 62, 62 [11/11,  83]
    legs="Malignance Tights",         -- 50, 50 [ 7/ 7, 150]
    feet="Maculele Toe Shoes +3",     -- 60, 60 [10/10, 115]
    neck="Null Loop",                 -- 50, 50 [ 5/ 5, ___]
    ear1="Dignitary's Earring",       -- 10, 10 [__/__, ___]
    ear2="Maculele Earring +1",       -- 14, 14 [__/__, ___]
    ring1="Etana Ring",               -- 10, 10 [__/__, ___]
    ring2="Defending Ring",           -- __, __ [10/10, ___]
    back="Null Shawl",                -- 50, 50 [__/__,  50]
    waist="Null Belt",                -- 30, 30 [__/__,  30]
    -- 462 Acc, 452 MAcc [49 PDT/43 MDT, 611 M.Eva]
    
    -- body="Horos Casaque +4",       -- 55, 45 [ 6/__, 124]
    -- 467 Acc, 457 MAcc [49 PDT/43 MDT, 651 M.Eva]
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Onion'] = {main="Onion Sword III", sub="Centovente"}
  sets.WeaponSet['OnionAcc'] = {main="Onion Sword III", sub="Gleti's Knife"}
  sets.WeaponSet['Twashtar'] = {main="Twashtar", sub="Centovente"}
  sets.WeaponSet['TwashtarAcc'] = {main="Twashtar", sub={name="Gleti's Knife", priority=1}}
  sets.WeaponSet['Terpsichore'] = {main="Terpsichore", sub="Twashtar"}
  sets.WeaponSet['Cleaving'] = {main="Tauret", sub="Twashtar"}
  sets.WeaponSet['Healing'] = {main="Terpsichore", sub="Enchufla"}
  sets.WeaponSet['SubtleBlow'] = {
    main=gear.Setan_Kober_B,
    sub="Twashtar"
  }
  sets.WeaponSet['H2H'] = {main="Karambit", sub="empty"}
  sets.WeaponSet['Staff'] = {main="Gozuki Mezuki", sub="Tzacab Grip"}

  -- Ranged weapon sets
  sets.RangedWeaponSet = {}
  sets.RangedWeaponSet['Throwing'] = {
    ranged="Albin Bane",
    ammo="empty",
  }
  sets.RangedWeaponSet['Pulling'] = {
    ranged="Jinx Discus",
    ammo="empty",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- Overcapped DT to account for regain gear swap
  sets.HeavyDef = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs=gear.Nyame_B_legs,     --  8/ 8, 150
    feet=gear.Nyame_B_feet,     --  7/ 7, 150
    neck="Loricate Torque +1",  --  5/ 5, ___
    ear1="Arete Del Luna +1",   -- __/__, ___
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.DNC_TP_DW_Cape,   -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
    -- 68 PDT/60 MDT, 689 MEVA
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head="Turms Cap +1",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
  }
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

  sets.idle = set_combine(sets.HeavyDef, {
    head="Turms Cap +1",        -- __/__, 109
    body="Gleti's Cuirass",     --  9/__, 102
    hands="Gleti's Gauntlets",  --  7/__, 75
    legs="Gleti's Breeches",    --  8/__, 112
  })

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = set_combine(sets.HeavyDef, {})

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    ring2="Gelatinous Ring +1", --  7/-1, ___
    back="Moonlight Cape",      --  6/ 6, ___
  })

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
  sets.precast.JA['No Foot Rise'] = {
    body="Horos Casaque +3", -- Grant TP return based on merits; +1 is acceptable
    -- body="Horos Casaque +4", -- Grant TP return based on merits; +1 is acceptable
  }
  sets.precast.JA['Trance'] = {
    head="Horos Tiara +3" -- Duration +20s; +1 is acceptable
    -- head="Horos Tiara +4" -- Duration +20s; +1 is acceptable
  }

  -- Waltz Potency/CHR
  sets.precast.Waltz = {
    ammo="Staunch Tathlum +1",        -- __(_), __, __ <__> [ 3/ 3, ___]
    head=gear.Anwig_Salade,           -- __(_),  4, __ <-2> [__/__, ___]
    body="Maxixi Casaque +3",         -- 19(8), 33, 34 <-2> [__/__,  84]
    hands="Maculele Bangles +3",      -- __(_), 28, 40 <__> [11/11,  83]
    legs="Dashing Subligar",          -- 10(_), 11, 16 <__> [__/__,  69]; Gives Blink
    feet="Maxixi Toe Shoes +3",       -- 14(_), 40, 22 <__> [__/__,  89]
    neck="Etoile Gorget +2",          -- 10(_), 25, __ <__> [__/__, ___]
    ear1="Genmei Earring",            -- __(_), __,  2 <__> [ 2/__, ___]
    ear2="Odnowa Earring +1",         -- __(_), __,  3 <__> [ 3/ 5, ___]
    ring1="Metamorph Ring +1",        -- __(_), 16, __ <__> [__/__, ___]
    ring2="Defending Ring",           -- __(_), __, __ <__> [10/10, ___]
    back=gear.DNC_WTZ_Cape,           -- __(_), 30, __ <__> [10/__, ___]; Enmity-10
    waist="Aristo Belt",              -- __(_),  8, __ <__> [__/__, ___]
    -- 53 Potency (8 Self Potency), 195 CHR, 117 VIT <-4 Delay> [39 PDT/29 MDT, 325 M.Eva]
    
    -- body="Maxixi Casaque +4",      -- 19(8), 35, 34 <-2> [__/__, 109]
    -- feet="Maxixi Toe Shoes +4",    -- 14(_), 42, 22 <__> [__/__, 114]
  }
  -- Waltz effects received
  sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
    body="Maxixi Casaque +3",         -- 19(8), 33, 34 <-2> [__/__,  84]
    -- 53 Potency (8 Self Potency), 195 CHR, 117 VIT <-4 Delay> [39 PDT/29 MDT, 325 M.Eva]
    
    -- body="Maxixi Casaque +4",      -- 19(8), 35, 34 <-2> [__/__, 109]
  })
  sets.precast.WaltzSafe = {
    ammo="Staunch Tathlum +1",        -- __(_), __, __ <__> [ 3/ 3, ___]
    head=gear.Nyame_B_head,           -- __(_), 24, 24 <__> [ 7/ 7, 123]
    body="Maxixi Casaque +3",         -- 19(8), 33, 34 <-2> [__/__,  84]
    hands="Maculele Bangles +3",      -- __(_), 28, 40 <__> [11/11,  83]
    legs=gear.Nyame_B_legs,           -- __(_), 24, 30 <__> [ 8/ 8, 150]
    feet="Maxixi Toe Shoes +3",       -- 14(_), 40, 22 <__> [__/__,  89]
    neck="Etoile Gorget +2",          -- 10(_), 25, __ <__> [__/__, ___]
    -- ear1="Sjofn Earring",          -- 10(_), __, __ <__> [__/__, ___]
    ear2="Odnowa Earring +1",         -- __(_), __,  3 <__> [ 3/ 5, ___]
    ring1="Moonlight Ring",           -- __(_), __,  3 <__> [ 3/ 5, ___]
    ring2="Defending Ring",           -- __(_), __, __ <__> [10/10, ___]
    back=gear.DNC_WTZ_Cape,           -- __(_), 30, __ <__> [10/__, ___]; Enmity-10
    waist="Null Belt",                -- __(_), __, __ <__> [__/__,  30]
    -- 53 Potency (8 Self Potency), 204 CHR, 156 VIT <-2 Delay> [55 PDT/49 MDT, 559 M.Eva]
    
    -- body="Maxixi Casaque +4",      -- 19(8), 35, 34 <-2> [__/__, 109]
    -- feet="Maxixi Toe Shoes +4",    -- 14(_), 42, 22 <__> [__/__, 114]
  }

  -- Focus Waltz delay. Dashing Subligar does not give shadows for healing waltz on others
  sets.precast.Waltz['Healing Waltz'] = {
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]; Resist+
    head=gear.Anwig_Salade,           -- -2 [__/__, ___]
    body="Maxixi Casaque +3",         -- -2 [__/__,  84]
    hands=gear.Nyame_B_hands,         -- __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___]; DEF+
    ear1="Arete Del Luna +1",         -- __ [__/__, ___]; Resist+
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___]
    ring1="Moonlight Ring",           -- __ [ 5/ 5, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.DNC_TP_DW_Cape,         -- __ [10/__, ___]
    waist="Engraved Belt",            -- __ [__/__, ___]; Resist+
    -- -4 Waltz Delay [59 PDT/51 MDT, 496 M.Eva]
    
    -- body="Maxixi Casaque +4",      -- -2 [__/__, 109]
  }
  sets.precast.Waltz['Healing Waltz'].Self = set_combine(sets.precast.Waltz['Healing Waltz'], {
    legs="Dashing Subligar",          -- 10(_), 11, 16 <__> [__/__,  69]; Gives Blink
  })
  sets.precast.Samba = {
    head="Maxixi Tiara +3", -- Duration +45s; +1 is acceptable
    back=gear.DNC_TP_DW_Cape,

    -- head="Maxixi Tiara +4", -- Duration +45s; +1 is acceptable
  }
  sets.precast.Jig = {
    legs="Horos Tights +3", -- Increase duration; +2 is acceptable
    feet="Maxixi Toe Shoes +3", -- Increase duration
    
    -- legs="Horos Tights +4", -- Increase duration; +2 is acceptable
    -- feet="Maxixi Toe Shoes +4", -- Increase duration
  }

  -- Acc
  sets.precast.Step = {
    ammo="Staunch Tathlum +1",    --  3/ 3, __ (__)
    head="Maxixi Tiara +3",       -- __/__, 47 (35)
    body="Maculele Casaque +3",   -- 14/14, 64 (__)
    hands="Maxixi Bangles +4",    -- __/__, 58 (40)
    legs="Malignance Tights",     --  7/ 7, 50 (__)
    feet="Horos Toe Shoes +3",    -- __/__, 42 (24); Step TP -20
    neck="Null Loop",             --  5/ 5, 50 (__)
    ear1="Telos Earring",         -- __/__, 10 (__)
    ear2="Odnowa Earring +1",     --  3/ 5, __ (__)
    ring1="Moonlight Ring",       --  5/ 5,  8 (__)
    ring2="Defending Ring",       -- 10/10, __ (__)
    back="Null Shawl",            -- __/__, 50 (__)
    waist="Null Belt",            -- __/__, 30 (__)
    -- Maxixi set bonus           -- __/__, 15 (__)
    -- 47 PDT / 49 MDT, 424 Acc (99 Step Acc)
    
    -- head="Maxixi Tiara +4",    -- __/__, 57 (35)
    -- feet="Horos Toe Shoes +4", -- __/__, 47 (24); Step TP -20
    -- 47 PDT / 49 MDT, 439 Acc (99 Step Acc)
  }

  sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {
    feet="Maculele Toe Shoes +3", -- Increase critical hit effect
  })
  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Animated Flourish'] = set_combine(sets.Enmity, {})

  -- Acc, Magic Accuracy
  sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.HybridAcc, {
    body="Horos Casaque +3",          -- 50, 40 [ 6/__,  84]; +41 V. Flourish Acc
    -- 438 Acc, 404 MAcc [44 PDT/28 MDT, 531 M.Eva]
    
    -- body="Horos Casaque +4",       -- 55, 45 [ 6/__, 124]; +41 V. Flourish Acc
    -- 443 Acc, 409 MAcc [44 PDT/28 MDT, 571 M.Eva]
  })

  -- Magic Accuracy
  sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.HybridAcc, {})

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {
    hands="Maculele Bangles +3", -- Increase TP return
    back=gear.DNC_Adoulin_Cape,
  }
  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {
    body="Maculele Casaque +3", -- Increase critical hit rate and double attack
  }
  sets.precast.Flourish3['Climactic Flourish'] = {
    head="Maculele Tiara +3", -- Force additional critical hit, increase critical hit damage
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Herculean Helm",            --  7 [__/__,  59]
    body=gear.Taeon_FC_body,          --  9 [__/__,  64]
    hands=gear.Leyline_Gloves,        --  8 [__/__,  62]
    legs=gear.Taeon_FC_legs,          --  5 [__/__,  69]
    feet=gear.Taeon_FC_feet,          --  5 [__/__,  69]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Etiolation Earring",        --  1 [__/ 3, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Weatherspoon Ring",        --  5 [__/__, ___]
    ring2="Prolix Ring",              --  2 [__/__, ___]
    back=gear.DNC_TP_DA_Cape,         -- __ [10/__, ___]
    waist="Platinum Moogle Belt",     -- __ [ 3/ 3,  15]
    -- 51 FC [13/ 6, 338 M.Eva]
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Sapience Orb",              --  2 [__/__, ___] __
    head="Herculean Helm",            --  7 [__/__,  59] __
    body="Passion Jacket",            -- __ [__/__,  80] 10
    hands=gear.Leyline_Gloves,        --  8 [__/__,  62] __
    legs=gear.Taeon_FC_legs,          --  5 [__/__,  69] __
    feet=gear.Taeon_FC_feet,          --  5 [__/__,  69] __
    neck="Magoraga Beads",            -- __ [__/__, ___] 10
    ear1="Etiolation Earring",        --  1 [__/ 3, ___] __
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    ring1="Weatherspoon Ring",        --  5 [__/__, ___] __
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back=gear.DNC_TP_DA_Cape,         -- __ [10/__, ___] __
    waist="Platinum Moogle Belt",     -- __ [ 3/ 3,  15] __
    -- 33 FC [26/21, 354 M.Eva] 20 Utsusemi FC
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {})


  ------------------------------------------------------------------------------------------------
  --     Ranged
  ------------------------------------------------------------------------------------------------

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


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default WS set. Used if no specific set is defined.
  sets.precast.WS = {
    ammo="Coiste Bodhar",             -- 10, 10, 15, __, __ < 3, __, __> [__/__, ___]
    head="Maculele Tiara +3",         -- 31, 38, 71, 12, __ <__, __, __> [__/__,  99]
    body=gear.Nyame_B_body,           -- 45, 24, 65, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands="Maxixi Bangles +4",        -- 21, 48, 40, 12, __ <__, __, __> [__/__,  82]
    legs=gear.Nyame_B_legs,           -- 58, __, 65, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 26, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",              -- __, __, __, __, __ <__, __, __> [__/__, ___]; fTP bonus
    ear1="Sherida Earring",           --  5,  5, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ring1="Ephramad's Ring",          -- 10, 10, 20, __, 10 <__, __, __> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.DNC_WS1_Cape,           -- __, 30, __, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __, __ <__, __, __> [__/__, ___]; fTP bonus
    -- 203 STR, 191 DEX, 341 Att, 70 WSD, 10 PDL <29 DA, 3 TA, 0 QA> [34 PDT/24 MDT, 620 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Odr Earring",               -- __, 10, __, __, __ <__, __, __> [__/__, ___]
  })

  -- 73-85% AGI, 1.0 FTP, ftp replicating
  -- Multihit > AGI
  sets.precast.WS['Exenterator'] = {
    ammo="Coiste Bodhar",             -- __, 15, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 23, 65, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 33, 65, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 12, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 34, 65, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 46, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",              -- __, __, __, __ <__, __, __> [__/__, ___]; fTP bonus
    ear1="Sherida Earring",           -- __, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Brutal Earring",            -- __, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Gere Ring",                -- __, 16, __, __ <__,  5, __> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.DNC_TP_DA_Cape,         -- __, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __ <__, __, __> [__/__, ___]; fTP bonus
    -- 148 AGI, 376 Att, 58 WSD, 0 PDL <54 DA, 8 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]

    -- back=gear.DNC_WS4_Cape,        -- 30, __, 20, __ <10, __, __> [10/__, ___]
    -- 178 AGI, 376 Att, 58 WSD, 0 PDL <54 DA, 8 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]
  }

  -- 40% STR / 40% DEX; 4 hit, ftp replicating
  sets.precast.WS['Pyrrhic Kleos'] = {
    ammo="Coiste Bodhar",             -- 10, 10, 15, __, __ < 3, __, __> [__/__, ___]
    head="Maculele Tiara +3",         -- 31, 38, 71, 12, __ <__, __, __> [__/__,  99]
    body="Horos Casaque +3",          -- 34, 39, 86, __, __ <__,  4, __> [ 6/__,  84]
    hands=gear.Nyame_B_hands,         -- 17, 42, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, __, 65, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Lustratio_D_feet,       -- 47, 48, __, __, __ <__, __, __> [__/__, ___]
    neck="Fotia Gorget",              -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Sherida Earring",           --  5,  5, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Mache Earring +1",          -- __,  8, __, __, __ < 2, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 10, 20, __, 10 <__, __, __> [__/__, ___]
    ring2="Gere Ring",                -- 10, __, 16, __, __ <__,  5, __> [__/__, ___]
    back=gear.DNC_WS1_Cape,           -- __, 30, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- 222 STR, 230 DEX, 358 Att, 45 WSD, 10 PDL <21 DA, 9 TA, 0 QA> [31 PDT/15 MDT, 445 M.Eva]

    -- body="Horos Casaque +4",       -- 37, 39, 96, __, __ <__,  4, __> [ 6/__, 124]
    -- 225 STR, 230 DEX, 368 Att, 45 WSD, 10 PDL <21 DA, 9 TA, 0 QA> [31 PDT/15 MDT, 485 M.Eva]
  }
  sets.precast.WS['Pyrrhic Kleos'].MaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
  sets.precast.WS['Pyrrhic Kleos'].AttCapped = {
    ammo="Coiste Bodhar",             -- 10, 10, 15, __, __ < 3, __, __> [__/__, ___]
    head="Maculele Tiara +3",         -- 31, 38, 71, 12, __ <__, __, __> [__/__,  99]
    body="Gleti's Cuirass",           -- 39, 34, 70, __,  9 <10, __, __> [ 9/__, 102]
    hands="Gleti's Gauntlets",        -- 20, 47, 70, __,  9 <__, __, __> [ 7/__,  75]
    legs="Gleti's Breeches",          -- 49, __, 70, __,  8 <__,  5, __> [ 8/__, 112]
    feet=gear.Lustratio_D_feet,       -- 47, 48, __, __, __ <__, __, __> [__/__, ___]
    neck="Etoile Gorget +2",          -- __, 25, __, __, 10 <__, __, __> [__/__, ___]
    ear1="Sherida Earring",           --  5,  5, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Maculele Earring +1",       -- __, __, __, __,  8 <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 10, 20, __, 10 <__, __, __> [__/__, ___]
    ring2="Gere Ring",                -- 10, __, 16, __, __ <__,  5, __> [__/__, ___]
    back=gear.DNC_WS1_Cape,           -- __, 30, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __, __ <__, __, __> [__/__, ___]; +0.1 ftp
    -- 221 STR, 247 DEX, 352 Att, 22 WSD, 54 PDL <18 DA, 10 TA, 0 QA> [34 PDT/0 MDT, 388 M.Eva]

    -- ear2="Maculele Earring +2",    -- __, 15, __, __,  9 <__, __, __> [__/__, ___]
    -- 221 STR, 262 DEX, 352 Att, 22 WSD, 55 PDL <18 DA, 10 TA, 0 QA> [34 PDT/0 MDT, 388 M.Eva]
  }
  sets.precast.WS['Pyrrhic Kleos'].AttCappedMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].AttCapped, {})
  sets.precast.WS['Pyrrhic Kleos'].Safe = {
    ammo="Coiste Bodhar",             -- 10, 10, 15, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 25, 65, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 24, 65, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 42, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, __, 65, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 26, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Warder's Charm +1",         -- __, __, __, __, __ <__, __, __> [__/__, ___]; Ele resist
    ear1="Sherida Earring",           --  5,  5, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Odnowa Earring +1",         --  3, __, __, __, __ <__, __, __> [ 5/ 5, ___]
    ring1="Defending Ring",           -- __, __, __, __, __ <__, __, __> [10/10, ___]
    ring2="Gere Ring",                -- 10, __, 16, __, __ <__,  5, __> [__/__, ___]
    back=gear.DNC_WS2_Cape,           -- __, 30, 20, __, __ <10, __, __> [10/__, ___]
    waist="Engraved Belt",            --  7, __, __, __, __ <__, __, __> [__/__, ___]; Ele resist
    -- 204 STR, 162 DEX, 376 Att, 58 WSD, 0 PDL <46 DA, 5 TA, 0 QA> [63 PDT/53 MDT, 674 M.Eva]
  }
  sets.precast.WS['Pyrrhic Kleos'].SafeMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].Safe, {})
  sets.precast.WS['Pyrrhic Kleos'].SafeAttCapped = set_combine(sets.precast.WS['Pyrrhic Kleos'].Safe, {})
  sets.precast.WS['Pyrrhic Kleos'].SafeAttCappedMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].SafeAttCapped, {})
  -- Required to prevent extra gear from equipping during Climactic
  -- Is overlaid, don't set_combine; this WS should not swap gear for climactic flourish
  sets.precast.WS['Pyrrhic Kleos'].Climactic = {}

  -- 50% DEX, 1.25 FTP, can crit, ftp replicating
  sets.precast.WS['Evisceration'] = {
    ammo="Charis Feather",            --  5, __, __, __ (__,  5) <__, __, __> [__/__, ___]
    head=gear.Adhemar_B_head,         -- 33, 56, __, __ (__,  6) <__,  4, __> [__/__,  59]
    body="Meghanada Cuirie +2",       -- 45, 46, __, __ (__,  6) <__, __, __> [ 8/__,  64]
    hands="Gleti's Gauntlets",        -- 47, 70, __,  7 ( 6, __) <__, __, __> [ 7/__,  75]
    legs=gear.Lustratio_B_legs,       -- 43, 38, __, __ ( 3, __) <__, __, __> [__/__, ___]
    feet=gear.Herc_DEX_CritDmg_feet,  -- 24, 19, __, __ (__,  5) <__,  2, __> [ 2/__,  75]
    neck="Fotia Gorget",              -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]; fTP+
    ear1="Moonshade Earring",         -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]
    ear2="Odr Earring",               -- 10, __, __, __ ( 5, __) <__, __, __> [__/__, ___]
    ring1="Ilabrat Ring",             -- 10, 25, __, __ (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, __, __, 10 (__, __) <__, __, __> [__/__, ___]
    back=gear.DNC_WS3_Cape,           -- 30, 20, __, __ (10,  5) <__, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]; fTP+
    -- 257 DEX, 274 Att, 0 WSD, 17 PDL (24 Crit Rate, 27 Crit Dmg) <0 DA, 6 TA, 0 QA> [27 PDT/0 MDT, 273 M.Eva]
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Sherida Earring",           --  5, __, __, __ (__, __) < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Charis Feather",            --  5, __, __, __ (__,  5) <__, __, __> [__/__, ___]
    head=gear.Adhemar_B_head,         -- 33, 56, __, __ (__,  6) <__,  4, __> [__/__,  59]
    body="Meghanada Cuirie +2",       -- 45, 46, __, __ (__,  6) <__, __, __> [ 8/__,  64]
    hands="Gleti's Gauntlets",        -- 47, 70, __,  7 ( 6, __) <__, __, __> [ 7/__,  75]
    legs=gear.Lustratio_B_legs,       -- 43, 38, __, __ ( 3, __) <__, __, __> [__/__, ___]
    feet=gear.Herc_DEX_CritDmg_feet,  -- 24, 19, __, __ (__,  5) <__,  2, __> [ 2/__,  75]
    neck="Etoile Gorget +2",          -- 25, __, __, 10 (__, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]
    ear2="Odr Earring",               -- 10, __, __, __ ( 5, __) <__, __, __> [__/__, ___]
    ring1="Ilabrat Ring",             -- 10, 25, __, __ (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, __, __, 10 (__, __) <__, __, __> [__/__, ___]
    back=gear.DNC_WS3_Cape,           -- 30, 20, __, __ (10,  5) <__, __, __> [10/__, ___]
    waist="Fotia Belt",               -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]; fTP+
    -- 282 DEX, 274 Att, 0 WSD, 30 PDL (24 Crit Rate, 22 Crit Dmg) <0 DA, 6 TA, 0 QA> [27 PDT/0 MDT, 273 M.Eva]
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear1="Sherida Earring",           --  5, __, __, __ (__, __) < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Evisceration'].Safe = {
    ammo="Charis Feather",            --  5, __, __, __ (__,  5) <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 25, 65, 11, __ (__, __) < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 24, 65, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 42, 65, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, 65, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 26, 65, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Warder's Charm +1",         -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]; Ele resist
    ear1="Moonshade Earring",         -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]
    ear2="Odr Earring",               -- 10, __, __, __ ( 5, __) <__, __, __> [__/__, ___]
    ring1="Moonlight Ring",           -- __,  8, __, __ (__, __) <__, __, __> [ 5/ 5, ___]
    ring2="Defending Ring",           -- __, __, __, __ (__, __) <__, __, __> [10/10, ___]
    back=gear.DNC_WS3_Cape,           -- 30, 20, __, __ (10,  5) <__, __, __> [10/__, ___]
    waist="Engraved Belt",            -- __, __, __, __ (__, __) <__, __, __> [__/__, ___]; Ele resist
    -- 162 DEX, 353 Att, 58 WSD, 0 PDL (15 Crit Rate, 10 Crit Dmg) <28 DA, 0 TA, 0 QA> [63 PDT/53 MDT, 674 M.Eva]
  }
  sets.precast.WS['Evisceration'].SafeMaxTP = set_combine(sets.precast.WS['Evisceration'].Safe, {
    ear1="Sherida Earring",           --  5, __, __, __ (__, __) < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Evisceration'].SafeAttCapped = set_combine(sets.precast.WS['Evisceration'].Safe, {})
  sets.precast.WS['Evisceration'].SafeAttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].SafeAttCapped, {})
  -- Is overlaid, don't set_combine
  sets.precast.WS['Evisceration'].Climactic = {}

  -- 25% DEX / 25% AGI. 4 hit, dmg varies with TP. 5.375 - 23 FTP.
  sets.precast.WS["Ruthless Stroke"] = {
    ammo="Coiste Bodhar",           -- 10, __, 15, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body=gear.Nyame_B_body,         -- 24, 65, 13, __ [ 9/ 9, 139]
    hands="Maxixi Bangles +4",      -- 48, 40, 12, __ [__/__,  82]
    legs=gear.Nyame_B_legs,         -- __, 65, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Odr Earring",             -- 10, __, __, __ [__/__, ___]
    ring1="Ilabrat Ring",           -- 10, 25, __, __ [__/__, ___]
    ring2="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 241 DEX, 371 Att, 85 WSD, 20 PDL [34 PDT/24 MDT, 620 M.Eva]
  }
  sets.precast.WS["Ruthless Stroke"].MaxTP = set_combine(sets.precast.WS["Ruthless Stroke"], {
    ear1="Ishvara Earring",         -- __, __,  2, __ [__/__, ___]
  })
  sets.precast.WS["Ruthless Stroke"].AttCapped = {
    ammo="Crepuscular Pebble",      -- __, __, __,  3 [ 3/ 3, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body="Gleti's Cuirass",         -- 34, 70, __,  9 [ 9/__, 102]
    hands="Maxixi Bangles +4",      -- 48, 40, 12, __ [__/__,  82]
    legs="Gleti's Breeches",        -- __, 70, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Maculele Earring +1",     -- __, __, __,  8 [__/__, ___]
    ring1="Epaminondas's Ring",     -- __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 221 DEX, 356 Att, 50 WSD, 48 PDL [37 PDT/10 MDT, 545 M.Eva]
    
    -- legs="Maculele Tights +3",   -- __, 63, __, 10 [__/__, 115]
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 236 DEX, 349 Att, 50 WSD, 51 PDL [29 PDT/10 MDT, 548 M.Eva]
  }
  sets.precast.WS["Ruthless Stroke"].AttCappedMaxTP = set_combine(sets.precast.WS["Ruthless Stroke"].AttCapped, {
    ear1="Odr Earring",             -- 10, __, __, __ [__/__, ___]
  })
  sets.precast.WS["Ruthless Stroke"].Safe = {
    ammo="Coiste Bodhar",           -- 10, 15, __, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body=gear.Nyame_B_body,         -- 24, 65, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,       -- 42, 65, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,         -- __, 65, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Odr Earring",             -- 10, __, __, __ [__/__, ___]
    ring1="Ilabrat Ring",           -- 10, 25, __, __ [__/__, ___]
    ring2="Defending Ring",         -- __, __, __, __ [10/10, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 225 DEX, 391 Att, 69 WSD, 10 PDL [51 PDT/41 MDT, 650 M.Eva]

    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 230 DEX, 391 Att, 69 WSD, 19 PDL [51 PDT/41 MDT, 650 M.Eva]
  }
  sets.precast.WS["Ruthless Stroke"].SafeMaxTP = set_combine(sets.precast.WS["Ruthless Stroke"].Safe, {
    ear1="Ishvara Earring",         -- __, __,  2, __ [__/__, ___]
    
    -- ear1="Odr Earring",          -- 10, __, __, __ [__/__, ___]
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
  })
  sets.precast.WS["Ruthless Stroke"].SafeAttCapped = {
    ammo="Coiste Bodhar",           -- 10, 15, __, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body="Gleti's Cuirass",         -- 34, 70, __,  9 [ 9/__, 102]
    hands="Gleti's Gauntlets",      -- 47, 70, __,  7 [ 7/__,  75]
    legs=gear.Nyame_B_legs,         -- __, 65, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Maculele Earring +1",     -- __, __, __,  8 [__/__, ___]
    ring1="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    ring2="Defending Ring",         -- __, __, __, __ [10/10, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 230 DEX, 396 Att, 45 WSD, 44 PDL [51 PDT/25 MDT, 576 M.Eva]
    
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 245 DEX, 396 Att, 45 WSD, 45 PDL [51 PDT/25 MDT, 576 M.Eva]
  }
  sets.precast.WS["Ruthless Stroke"].SafeAttCappedMaxTP = set_combine(sets.precast.WS["Ruthless Stroke"].SafeAttCapped, {
    ear1="Odr Earring",             -- 10, __, __, __ [__/__, ___]
  })
  -- Is overlaid, don't set_combine
  sets.precast.WS["Ruthless Stroke"].Climactic = {
    ammo="Charis Feather",          --  5, __, __, __ [__/__, ___]; Crit dmg+5
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]; Crit dmg+31
  }

  -- 80% DEX
  sets.precast.WS["Rudra's Storm"] = {
    ammo="Coiste Bodhar",           -- 10, __, 15, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body=gear.Nyame_B_body,         -- 24, 65, 13, __ [ 9/ 9, 139]
    hands="Maxixi Bangles +4",      -- 48, 40, 12, __ [__/__,  82]
    legs=gear.Lustratio_B_legs,     -- 43, 38, __, __ [__/__, ___]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Odr Earring",             -- 10, __, __, __ [__/__, ___]
    ring1="Ilabrat Ring",           -- 10, 25, __, __ [__/__, ___]
    ring2="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 284 DEX, 359 Att, 58 WSD, 20 PDL [26 PDT/16 MDT, 470 M.Eva]
  }
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    ear1="Ishvara Earring",         -- __, __,  2, __ [__/__, ___]
  })
  sets.precast.WS["Rudra's Storm"].AttCapped = {
    ammo="Coiste Bodhar",           -- 10, 15, __, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body="Gleti's Cuirass",         -- 34, 70, __,  9 [ 9/__, 102]
    hands="Maxixi Bangles +4",      -- 48, 40, 12, __ [__/__,  82]
    legs="Gleti's Breeches",        -- __, 70, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Maculele Earring +1",     -- __, __, __,  8 [__/__, ___]
    ring1="Epaminondas's Ring",     -- __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 231 DEX, 371 Att, 50 WSD, 45 PDL [34 PDT/7 MDT, 545 M.Eva]
    
    -- legs="Maculele Tights +3",   -- __, 63, __, 10 [__/__, 115]
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 246 DEX, 364 Att, 50 WSD, 48 PDL [26 PDT/7 MDT, 548 M.Eva]
  }
  sets.precast.WS["Rudra's Storm"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {
    ear1="Odr Earring",             -- 10, __, __, __ [__/__, ___]
  })
  sets.precast.WS["Rudra's Storm"].Safe = {
    ammo="Coiste Bodhar",           -- 10, 15, __, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body=gear.Nyame_B_body,         -- 24, 65, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,       -- 42, 65, 11, __ [ 7/ 7, 112]
    legs=gear.Lustratio_B_legs,     -- 43, 38, __, __ [__/__, ___]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Odr Earring",             -- 10, __, __, __ [__/__, ___]
    ring1="Ilabrat Ring",           -- 10, 25, __, __ [__/__, ___]
    ring2="Defending Ring",         -- __, __, __, __ [10/10, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Flume Belt +1",          -- __, __, __, __ [ 4/__, ___]
    -- 258 DEX, 364 Att, 57 WSD, 10 PDL [47 PDT/33 MDT, 500 M.Eva]

    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 263 DEX, 364 Att, 57 WSD, 19 PDL [47 PDT/33 MDT, 500 M.Eva]
  }
  sets.precast.WS["Rudra's Storm"].SafeMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].Safe, {
    ear1="Ishvara Earring",         -- __, __,  2, __ [__/__, ___]
    
    -- ear1="Odr Earring",          -- 10, __, __, __ [__/__, ___]
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
  })
  sets.precast.WS["Rudra's Storm"].SafeAttCapped = {
    ammo="Coiste Bodhar",           -- 10, 15, __, __ [__/__, ___]
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]
    body="Gleti's Cuirass",         -- 34, 70, __,  9 [ 9/__, 102]
    hands="Gleti's Gauntlets",      -- 47, 70, __,  7 [ 7/__,  75]
    legs=gear.Nyame_B_legs,         -- __, 65, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,         -- 26, 65, 11, __ [ 7/ 7, 150]
    neck="Etoile Gorget +2",        -- 25, __, __, 10 [__/__, ___]
    ear1="Moonshade Earring",       -- __, __, __, __ [__/__, ___]; TP Bonus+250
    ear2="Maculele Earring +1",     -- __, __, __,  8 [__/__, ___]
    ring1="Ephramad's Ring",        -- 10, 20, __, 10 [__/__, ___]
    ring2="Defending Ring",         -- __, __, __, __ [10/10, ___]
    back=gear.DNC_WS1_Cape,         -- 30, 20, 10, __ [10/__, ___]; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __ [__/__, ___]
    -- 230 DEX, 396 Att, 45 WSD, 44 PDL [51 PDT/25 MDT, 576 M.Eva]
    
    -- ear2="Maculele Earring +2",  -- 15, __, __,  9 [__/__, ___]
    -- 245 DEX, 396 Att, 45 WSD, 45 PDL [51 PDT/25 MDT, 576 M.Eva]
  }
  sets.precast.WS["Rudra's Storm"].SafeAttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].SafeAttCapped, {
    ear1="Odr Earring",             -- 10, __, __, __ [__/__, ___]
  })
  -- Is overlaid, don't set_combine
  sets.precast.WS["Rudra's Storm"].Climactic = {
    ammo="Charis Feather",          --  5, __, __, __ [__/__, ___]; Crit dmg+5
    head="Maculele Tiara +3",       -- 38, 71, 12, __ [__/__,  99]; Crit dmg+31
  }

  -- 40% DEX / 40% AGI; fTP 4.5-8.5
  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS["Rudra's Storm"], {})
  sets.precast.WS["Shark Bite"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"].MaxTP, {})
  sets.precast.WS["Shark Bite"].AttCapped = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {})
  sets.precast.WS["Shark Bite"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCappedMaxTP, {})
  sets.precast.WS["Shark Bite"].Safe = set_combine(sets.precast.WS["Rudra's Storm"].Safe, {})
  sets.precast.WS["Shark Bite"].SafeMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].SafeMaxTP, {})
  sets.precast.WS["Shark Bite"].SafeAttCapped = set_combine(sets.precast.WS["Rudra's Storm"].SafeAttCapped, {})
  sets.precast.WS["Shark Bite"].SafeAttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].SafeAttCappedMaxTP, {})
  sets.precast.WS["Shark Bite"].Climactic = set_combine(sets.precast.WS["Rudra's Storm"].Climactic, {})

  -- 40% DEX/40% INT; Wind magic aoe; fTP 2.0-4.5
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Ghastly Tathlum +1",        -- __, 11, __ {__, 21, __} [__/__, ___]
    head=gear.Nyame_B_head,           -- 25, 28, 11 {30, __, 40} [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 24, 42, 13 {30, __, 40} [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 42, 28, 11 {30, __, 40} [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, 44, 12 {30, __, 40} [ 8/ 8, 150]
    feet=gear.Herc_MAB_feet,          -- 24, __, __ {57, __, 28} [ 2/__,  75]
    neck="Sibyl Scarf",               -- __, 10, __ {10, __, __} [__/__, ___]
    ear1="Friomisi Earring",          -- __, __, __ {10, __, __} [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __ {__, __, __} [__/__, ___]; TP Bonus+250
    ring1="Shiva Ring +1",            -- __,  9, __ { 3, __, __} [__/__, ___]
    ring2="Metamorph Ring +1",        -- __, 16, __ {__, __, 15} [__/__, ___]
    back=gear.DNC_WS1_Cape,           -- 30, __, 10 {__, __, __} [10/__, ___]
    waist="Skrymir Cord",             -- __, __, __ { 5, 30,  5} [__/__, ___]
    -- 145 DEX, 188 INT, 57 WSD {205 MAB, 51 M.Dmg, 208 M.Acc} [43 PDT/31 MDT, 599 M.Eva]
    
    -- back=gear.DNC_MAB_Cape,        -- __, 30, __ {10, 20, 20} [10/__, ___]
    -- waist="Skrymir Cord +1",       -- __, __, __ { 7, 35,  7} [__/__, ___]
    -- 115 DEX, 218 INT, 47 WSD {217 MAB, 76 M.Dmg, 230 M.Acc} [43 PDT/31 MDT, 599 M.Eva]
  }
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring",             -- __, __, __ { 7, __, __} [__/__, ___]
  })
  sets.precast.WS['Aeolian Edge'].AttCapped = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MaxTP, {})
  sets.precast.WS['Aeolian Edge'].Safe = set_combine(sets.precast.WS['Aeolian Edge'], {
    feet=gear.Nyame_B_feet,           -- 26, 25, 11 {30, __, 40} [ 7/ 7, 150]
  })
  sets.precast.WS['Aeolian Edge'].SafeMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].Safe, {
    ear2="Novio Earring",             -- __, __, __ { 7, __, __} [__/__, ___]
  })
  sets.precast.WS['Aeolian Edge'].SafeAttCapped = set_combine(sets.precast.WS['Aeolian Edge'].Safe, {})
  sets.precast.WS['Aeolian Edge'].SafeAttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].SafeMaxTP, {})
  -- Is overlaid, don't set_combine; this WS should not swap gear for climactic flourish
  -- Required to prevent extra gear from equipping during Climactic; AE cannot crit
  sets.precast.WS["Aeolian Edge"].Climactic = {}

  -- 80% DEX, 1.8-5.0 FTP, ftp replicating, 2 hit
  sets.precast.WS['Fast Blade II'] = {
    ammo="Coiste Bodhar",             -- 10, 15, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 25, 65, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 24, 65, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 42, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Lustratio_B_legs,       -- 43, 38, __, __ <__, __, __> [__/__, ___]
    feet=gear.Nyame_B_feet,           -- 26, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",              -- __, __, __, __ <__, __, __> [__/__, ___]; fTP+
    ear1="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           --  5, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Gere Ring",                -- __, 16, __, __ <__,  5, __> [__/__, ___]
    back=gear.DNC_WS2_Cape,           -- 30, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- __, 15, __, __ < 5,  2, __> [__/__, ___]
    -- 205 DEX, 364 Att, 46 WSD, 0 PDL <48 DA, 10 TA, 0 QA> [40 PDT/30 MDT, 524 M.Eva]
  }
  sets.precast.WS['Fast Blade II'].MaxTP = set_combine(sets.precast.WS['Fast Blade II'], {
    ear1="Brutal Earring",            -- __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Fast Blade II'].AttCapped = {
    ammo="Coiste Bodhar",             -- 10, 15, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 25, 65, 11, __ < 5, __, __> [ 7/ 7, 123]
    body="Gleti's Cuirass",           -- 34, 65, __,  9 < 9, __, __> [ 9/__, 102]
    hands=gear.Nyame_B_hands,         -- 42, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Gleti's Breeches",          -- __, 70, __,  8 <__,  5, __> [ 8/__, 112]
    feet=gear.Nyame_B_feet,           -- 26, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Etoile Gorget +2",          -- 25, __, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           --  5, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Gere Ring",                -- __, 16, __, __ <__,  5, __> [__/__, ___]
    back=gear.DNC_WS2_Cape,           -- 30, 20, __, __ <10, __, __> [10/__, ___]
    waist="Windbuffet Belt +1",       -- __, __, __, __ <__,  2,  2> [__/__, ___]
    -- 197 DEX, 381 Att, 33 WSD, 27 PDL <45 DA, 15 TA, 2 QA> [48 PDT/21 MDT, 599 M.Eva]
  }
  sets.precast.WS['Fast Blade II'].AttCappedMaxTP = set_combine(sets.precast.WS['Fast Blade II'].AttCapped, {
    ear1="Brutal Earring",            -- __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Fast Blade II'].Safe = {
    ammo="Coiste Bodhar",             -- 10, 15, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 25, 65, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 24, 65, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 42, 65, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, 65, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 26, 65, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Warder's Charm +1",         -- __, __, __, __ <__, __, __> [__/__, ___]; Ele resist
    ear1="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           --  5, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Gere Ring",                -- __, 16, __, __ <__,  5, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __, __ <__, __, __> [10/10, ___]
    back=gear.DNC_WS2_Cape,           -- 30, 20, __, __ <10, __, __> [10/__, ___]
    waist="Engraved Belt",            --  7, __, __, __ <__, __, __> [__/__, ___]; Ele resist
    -- 169 DEX, 376 Att, 58 WSD, 0 PDL <46 DA, 5 TA, 0 QA> [58 PDT/48 MDT, 674 M.Eva]
  }
  sets.precast.WS['Fast Blade II'].SafeMaxTP = set_combine(sets.precast.WS['Fast Blade II'].Safe, {
    ear1="Brutal Earring",            -- __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Fast Blade II'].SafeAttCapped = set_combine(sets.precast.WS['Fast Blade II'].Safe, {})
  sets.precast.WS['Fast Blade II'].SafeAttCappedMaxTP = set_combine(sets.precast.WS['Fast Blade II'].SafeAttCapped, {})
  -- Is overlaid, don't set_combine
  sets.precast.WS['Fast Blade II'].Climactic = {
    head="Maculele Tiara +3",         -- 38, 71, 12, __ <__, __, __> [__/__,  99]; Crit dmg+31
  }

  sets.precast.WS['Shell Crusher'] = set_combine(sets.HybridAcc, {})


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
  --    Ranged
  ------------------------------------------------------------------------------------------------

  sets.midcast.RA = {
    head="Malignance Chapeau",        -- 33,  8, 50/__ [ 6/ 6, 123]
    body="Malignance Tabard",         -- 42, 11, 50/__ [ 9/ 9, 139]
    hands="Malignance Gloves",        -- 24, 12, 50/__ [ 5/ 5, 112]
    legs="Malignance Tights",         -- 42, 10, 50/__ [ 7/ 7, 150]
    feet="Malignance Boots",          -- 49,  9, 50/__ [ 4/ 4, 150]
    neck="Null Loop",                 -- __, __, 50/__ [ 5/ 5, ___]
    ear1="Telos Earring",             -- __,  5, 10/10 [__/__, ___]
    ear2="Enervating Earring",        -- __,  4,  7/ 7 [__/__, ___]
    ring1="Crepuscular Ring",         -- __,  6, 10/__ [__/__, ___]
    ring2="Defending Ring",           -- __, __, __/__ [10/10, ___]
    back="Null Shawl",                -- __,  7, 50/__ [__/__,  50]
    waist="Yemaya Belt",              -- __,  4, 10/10 [__/__, ___]
    -- 190 AGI, 76 STP, 387 racc / 27 ratt [46 PDT/46 MDT, 724 M.Eva]
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.

  -- No DW (0-1 needed from gear)
  sets.engaged = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Windbuffet Belt +1",     -- __,  2, __ <__,  2,  2> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 0 DW, 67 STP, 282 Acc <25 DA, 17 TA, 2 QA> [35 PDT/25 MDT, 495 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    legs="Meghanada Chausses +2",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Ephramad's Ring",
    waist="Olseni Belt",
  })

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 7 DW, 69 STP, 292 Acc <25 DA, 15 TA, 0 QA> [35 PDT/25 MDT, 495 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
    ring1="Chirich Ring +1",
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    hands="Mummu Wrists +2",
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    ammo="Cath Palug Stone",
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring2="Ephramad's Ring",
    -- waist="Olseni Belt",
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 21 DW, 64 STP, 282 Acc <14 DA, 15 TA, 0 QA> [35 PDT/25 MDT, 503 M.Eva] 38 Subtle Blow
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
    hands="Mummu Wrists +2",
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    legs="Horos Tights +3",
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Ephramad's Ring",
    -- waist="Olseni Belt",
  })

  -- High DW (28 needed from gear)
  sets.engaged.HighDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 28 DW, 58 STP, 306 Acc <15 DA, 15 TA, 0 QA> [40 PDT/30 MDT, 465 M.Eva] 52 Subtle Blow
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear1="Dignitary's Earring",
    ring2="Ephramad's Ring",
    -- waist="Olseni Belt",
  })

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 48 STP, 296 Acc <9 DA, 15 TA, 0 QA> [40 PDT/30 MDT, 473 M.Eva] 47 Subtle Blow
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    ring1="Chirich Ring +1",
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    -- waist="Olseni Belt",
  })

  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Floral Gauntlets",       --  5, __, 36 <__,  3, __> [__/ 4,  37] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 42 DW, 41 STP, 280 Acc <9 DA, 14 TA, 0 QA> [40 PDT/34 MDT, 467 M.Eva] 47 Subtle Blow
  }
  sets.engaged.MaxDW.LowAcc = set_combine(sets.engaged.MaxDW, {
  })
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW.LowAcc, {
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  -- No DW (0-1 needed from gear)
  sets.engaged.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Windbuffet Belt +1",     -- __,  2, __ <__,  2,  2> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 35 DW, 80 STP, 323 Acc <19 DA, 7 TA, 2 QA> [52 PDT/42 MDT, 639 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {})
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.MidAcc.HeavyDef, {})

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 7 DW, 74 STP, 290 Acc <22 DA, 8 TA, 0 QA> [50 PDT/40 MDT, 564 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowDW.LowAcc.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {})
  sets.engaged.LowDW.MidAcc.HeavyDef = set_combine(sets.engaged.LowDW.LowAcc.HeavyDef, {})
  sets.engaged.LowDW.HighAcc.HeavyDef = set_combine(sets.engaged.LowDW.MidAcc.HeavyDef, {})

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts          -- __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 21 DW, 69 STP, 250 Acc <11 DA, 8 TA, 0 QA> [50 PDT/40 MDT, 572 M.Eva] 38 Subtle Blow
  }
  sets.engaged.MidDW.LowAcc.HeavyDef = set_combine(sets.engaged.MidDW.HeavyDef, {})
  sets.engaged.MidDW.MidAcc.HeavyDef = set_combine(sets.engaged.MidDW.LowAcc.HeavyDef, {})
  sets.engaged.MidDW.HighAcc.HeavyDef = set_combine(sets.engaged.MidDW.MidAcc.HeavyDef,{})

  -- High DW (28 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 28 DW, 55 STP, 306 Acc <9 DA, 12 TA, 0 QA> [53 PDT/43 MDT, 465 M.Eva] 52 Subtle Blow
  }
  sets.engaged.HighDW.LowAcc.HeavyDef = set_combine(sets.engaged.HighDW.HeavyDef, {})
  sets.engaged.HighDW.MidAcc.HeavyDef = set_combine(sets.engaged.HighDW.LowAcc.HeavyDef, {})
  sets.engaged.HighDW.HighAcc.HeavyDef = set_combine(sets.engaged.HighDW.MidAcc.HeavyDef, {})

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 56 STP, 329 Acc <6 DA, 8 TA, 0 QA> [52 PDT/42 MDT, 617 M.Eva] 47 Subtle Blow
  }
  sets.engaged.SuperDW.LowAcc.HeavyDef = set_combine(sets.engaged.SuperDW.HeavyDef, {})
  sets.engaged.SuperDW.MidAcc.HeavyDef = set_combine(sets.engaged.SuperDW.LowAcc.HeavyDef, {})
  sets.engaged.SuperDW.HighAcc.HeavyDef = set_combine(sets.engaged.SuperDW.MidAcc.HeavyDef,{})

  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet=gear.Herc_DW_feet,         --  5, __, 23 <__,  2, __> [ 2/__,  75] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 42 DW, 49 STP, 300 Acc <3 DA, 7 TA, 0 QA> [49 PDT/37 MDT, 577 M.Eva] 47 Subtle Blow
  }
  sets.engaged.MaxDW.LowAcc.HeavyDef = set_combine(sets.engaged.MaxDW.HeavyDef, {})
  sets.engaged.MaxDW.MidAcc.HeavyDef = set_combine(sets.engaged.MaxDW.LowAcc.HeavyDef, {})
  sets.engaged.MaxDW.HighAcc.HeavyDef = set_combine(sets.engaged.MaxDW.MidAcc.HeavyDef,{})


  ------------------------------------------------------------------------------------------

  -- No DW (0-1 needed from gear)
  sets.engaged.Safe = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Warder's Charm +1",       -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist, Occ. absorb magic
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    ring2="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    back="Null Shawl",              -- __,  7, 50 < 7, __, __> [__/__,  50] __(__)
    waist="Engraved Belt",          -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 35 DW, 70 STP, 320 Acc <13 DA, 5 TA, 0 QA> [50 PDT/50 MDT, 689 M.Eva] 33(5) Subtle Blow
  }
  sets.engaged.LowAcc.Safe = set_combine(sets.engaged.Safe, {})
  sets.engaged.MidAcc.Safe = set_combine(sets.engaged.LowAcc.Safe, {})
  sets.engaged.HighAcc.Safe = set_combine(sets.engaged.MidAcc.Safe, {})

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW.Safe = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Warder's Charm +1",       -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist, Occ. absorb magic
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    ring2="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    back="Null Shawl",              -- __,  7, 50 < 7, __, __> [__/__,  50] __(__)
    waist="Engraved Belt",          -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 46 DW, 64 STP, 342 Acc <13 DA, 5 TA, 0 QA> [50 PDT/50 MDT, 659 M.Eva] 47(5) Subtle Blow
  }
  sets.engaged.LowDW.LowAcc.Safe = set_combine(sets.engaged.LowDW.Safe, {})
  sets.engaged.LowDW.MidAcc.Safe = set_combine(sets.engaged.LowDW.LowAcc.Safe, {})
  sets.engaged.LowDW.HighAcc.Safe = set_combine(sets.engaged.LowDW.MidAcc.Safe, {})

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.Safe = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Warder's Charm +1",       -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist, Occ. absorb magic
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    ring2="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    back="Null Shawl",              -- __,  7, 50 < 7, __, __> [__/__,  50] __(__)
    waist="Engraved Belt",          -- __, __, __ <__, __, __> [__/__, ___] __(__); Ele resist
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 55 DW, 54 STP, 332 Acc <7 DA, 5 TA, 0 QA> [50 PDT/50 MDT, 667 M.Eva] 47(0) Subtle Blow
  }
  sets.engaged.MidDW.LowAcc.Safe = set_combine(sets.engaged.MidDW.Safe, {})
  sets.engaged.MidDW.MidAcc.Safe = set_combine(sets.engaged.MidDW.LowAcc.Safe, {})
  sets.engaged.MidDW.HighAcc.Safe = set_combine(sets.engaged.MidDW.MidAcc.Safe,{})

  -- High DW (28 needed from gear)
  sets.engaged.HighDW.Safe = set_combine(sets.engaged.MidDW.Safe, {})
  sets.engaged.HighDW.LowAcc.Safe = set_combine(sets.engaged.HighDW.Safe, {})
  sets.engaged.HighDW.MidAcc.Safe = set_combine(sets.engaged.HighDW.LowAcc.Safe, {})
  sets.engaged.HighDW.HighAcc.Safe = set_combine(sets.engaged.HighDW.MidAcc.Safe, {})

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW.Safe = set_combine(sets.engaged.HighDW.Safe, {})
  sets.engaged.SuperDW.LowAcc.Safe = set_combine(sets.engaged.SuperDW.Safe, {})
  sets.engaged.SuperDW.MidAcc.Safe = set_combine(sets.engaged.SuperDW.LowAcc.Safe, {})
  sets.engaged.SuperDW.HighAcc.Safe = set_combine(sets.engaged.SuperDW.MidAcc.Safe,{})

  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW.Safe = set_combine(sets.engaged.SuperDW.Safe, {})
  sets.engaged.MaxDW.LowAcc.Safe = set_combine(sets.engaged.MaxDW.Safe, {})
  sets.engaged.MaxDW.MidAcc.Safe = set_combine(sets.engaged.MaxDW.LowAcc.Safe, {})
  sets.engaged.MaxDW.HighAcc.Safe = set_combine(sets.engaged.MaxDW.MidAcc.Safe,{})


  ------------------------------------------------------------------------------------------------
  --    Subtle Blow Engaged
  ------------------------------------------------------------------------------------------------

  -- No DW (0-1 needed from gear)
  sets.engaged.SubtleBlow = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Chirich Ring +1",        -- __,  6, 10 <__, __, __> [__/__, ___] 10(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Peiste Belt +1",         -- __, __, __ <__, __, __> [__/__, ___] 10(__)
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 35 DW, 84 STP, 333 Acc <19 DA, 0 TA, 0 QA> [52 PDT/42 MDT, 639 M.Eva] 53(5) Subtle Blow
  }
  sets.engaged.LowAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  sets.engaged.MidAcc.SubtleBlow = set_combine(sets.engaged.LowAcc.SubtleBlow, {})
  sets.engaged.HighAcc.SubtleBlow = set_combine(sets.engaged.MidAcc.SubtleBlow, {})

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW.SubtleBlow = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Windbuffet Belt +1",     -- __,  2, __ <__,  2,  2> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 11 DW, 66 STP, 302 Acc <22 DA, 10 TA, 2 QA> [50 PDT/40 MDT, 534 M.Eva] 47(5) Subtle Blow
  }
  sets.engaged.LowDW.LowAcc.SubtleBlow = set_combine(sets.engaged.LowDW.SubtleBlow, {})
  sets.engaged.LowDW.MidAcc.SubtleBlow = set_combine(sets.engaged.LowDW.LowAcc.SubtleBlow, {})
  sets.engaged.LowDW.HighAcc.SubtleBlow = set_combine(sets.engaged.LowDW.MidAcc.SubtleBlow, {})

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.SubtleBlow = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts          -- __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 22 DW, 63 STP, 302 Acc <21 DA, 8 TA, 0 QA> [50 PDT/40 MDT, 542 M.Eva] 47(5) Subtle Blow
  }
  sets.engaged.MidDW.LowAcc.SubtleBlow = set_combine(sets.engaged.MidDW.SubtleBlow, {})
  sets.engaged.MidDW.MidAcc.SubtleBlow = set_combine(sets.engaged.MidDW.LowAcc.SubtleBlow, {})
  sets.engaged.MidDW.HighAcc.SubtleBlow = set_combine(sets.engaged.MidDW.MidAcc.SubtleBlow,{})

  -- High DW (28 needed from gear)
  sets.engaged.HighDW.SubtleBlow = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 28 DW, 55 STP, 306 Acc <9 DA, 12 TA, 0 QA> [53 PDT/43 MDT, 465 M.Eva] 47(5) Subtle Blow
  }
  sets.engaged.HighDW.LowAcc.SubtleBlow = set_combine(sets.engaged.HighDW.SubtleBlow, {})
  sets.engaged.HighDW.MidAcc.SubtleBlow = set_combine(sets.engaged.HighDW.LowAcc.SubtleBlow, {})
  sets.engaged.HighDW.HighAcc.SubtleBlow = set_combine(sets.engaged.HighDW.MidAcc.SubtleBlow, {})

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW.SubtleBlow = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +3",   -- __, 12, 60 <__, __, __> [10/10, 115] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 56 STP, 329 Acc <6 DA, 8 TA, 0 QA> [52 PDT/42 MDT, 617 M.Eva] 47 Subtle Blow
  }
  sets.engaged.SuperDW.LowAcc.SubtleBlow = set_combine(sets.engaged.SuperDW.SubtleBlow, {})
  sets.engaged.SuperDW.MidAcc.SubtleBlow = set_combine(sets.engaged.SuperDW.LowAcc.SubtleBlow, {})
  sets.engaged.SuperDW.HighAcc.SubtleBlow = set_combine(sets.engaged.SuperDW.MidAcc.SubtleBlow,{})

  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW.SubtleBlow = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +3",     -- 11, __, 64 <__, __, __> [14/14, 109] 14(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet=gear.Herc_DW_feet,         --  5, __, 23 <__,  2, __> [ 2/__,  75] __(__)
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Moonlight Ring",         -- __,  5,  8 <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 42 DW, 49 STP, 300 Acc <3 DA, 7 TA, 0 QA> [49 PDT/37 MDT, 577 M.Eva] 47 Subtle Blow
  }
  sets.engaged.MaxDW.LowAcc.SubtleBlow = set_combine(sets.engaged.MaxDW.SubtleBlow, {})
  sets.engaged.MaxDW.MidAcc.SubtleBlow = set_combine(sets.engaged.MaxDW.LowAcc.SubtleBlow, {})
  sets.engaged.MaxDW.HighAcc.SubtleBlow = set_combine(sets.engaged.MaxDW.MidAcc.SubtleBlow,{})

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { head="Frenzy Sallet", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  -- This is overlaid on TP set during Climactic Flourish
  sets.buff['Climactic Flourish'] = {
    head="Maculele Tiara +3",
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Automatically use Presto for steps when it's available
function job_pretarget(spell, action, spellMap, eventArgs)
  if spell.type == 'Step' then
    local allRecasts = windower.ffxi.get_ability_recasts()
    local prestoCooldown = allRecasts[236]

    if player.main_job_level >= 77 and prestoCooldown < 1 and not buffactive.Presto then
      cast_delay(1.1)
      send_command('input /ja "Presto" <me>')
    end
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Cancel conflicting buffs
  if spell.type == 'Waltz' and buffactive['Saber Dance'] then
    cast_delay(0.2)
    send_command('cancel saber dance')
  elseif spell.type == 'Samba' and buffactive['Fan Dance'] then
    cast_delay(0.2)
    send_command('cancel fan dance')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    local climacticSet = sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Climactic
    if state.Buff['Climactic Flourish'] and climacticSet then
      equip(climacticSet)
    end
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end
  if spell.type=='Waltz' then
    if spell.english:startswith('Curing') then
      if spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
      end
      if (state.HybridMode.value == 'Safe' or state.DefenseMode.value == 'Safe') then
        equip(sets.precast.WaltzSafe)
      end
    elseif spell.english == 'Healing Waltz' and spell.target.type == 'SELF' then
      equip(sets.precast.Waltz['Healing Waltz'].Self)
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
end

function job_midcast(spell, action, spellMap, eventArgs)
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
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
    state.Buff['Trick Attack'] = false
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
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
    equip(sets.SleepyHead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Saber Dance" or buff == "Climactic Flourish" or buff == "Fan Dance" or buff == "doom" then
    status_change(player.status)
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
  update_combat_form()
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 1 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
  else
    if silibs.get_dual_wield_needed() > 1 and silibs.get_dual_wield_needed() <= 8 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 8 and silibs.get_dual_wield_needed() <= 21 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 21 and silibs.get_dual_wield_needed() <= 28 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 28 and silibs.get_dual_wield_needed() <= 39 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 39 then
      state.CombatForm:set('MaxDW')
    end
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if state.HybridMode.value == 'Safe' then
    wsmode = wsmode..'Safe'
  end

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = wsmode..'AttCapped'
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
  if state.Buff['Climactic Flourish'] then
    meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
  end
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

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
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

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local s_msg = state.MainStep.current..'/'..state.AltStep.current

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
      ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-- Requires DistancePlus addon
function update_dp_type()
  local weapon = nil
  local weapon_type = nil
  local weapon_subtype = nil

  -- Handle unequipped case
  if player.equipment.ranged ~= nil and player.equipment.ranged ~= 0 and player.equipment.ranged ~= 'empty' then
    weapon = res.items:with('name', player.equipment.ranged)
    weapon_type = res.skills[weapon.skill].en
    if weapon_type == 'Throwing' then
      weapon_subtype = 'throwing'
    end
  end

  -- Update addon if weapon type changed
  if weapon_subtype ~= current_dp_type then
    current_dp_type = weapon_subtype
    if current_dp_type ~= nil then
      coroutine.schedule(function()
        if current_dp_type ~= nil then
          send_command('dp '..current_dp_type)
        end
      end,3)
    end
  end
end

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

function cycle_ranged_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.RangedWeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.RangedWeaponSet:cycleback()
  elseif cycle_dir == 'set' then
    state.RangedWeaponSet:set(set_name)
  else
    state.RangedWeaponSet:reset()
  end

  add_to_chat(141, 'RA Weapon Set to '..string.char(31,1)..state.RangedWeaponSet.current)
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
  if state.ToyWeapons.current ~= 'None' then
    weapons_to_equip = set_combine(sets.ToyWeapon[state.ToyWeapons.current], {})
  elseif sets.WeaponSet[state.WeaponSet.current] then
    weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current], {})
  end

  -- Equip ranged weapon
  local ranged_set = sets.RangedWeaponSet[state.RangedWeaponSet.current]
  if ranged_set then
    weapons_to_equip = set_combine(weapons_to_equip, ranged_set)
  end

  return weapons_to_equip
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

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
  if not eventArgs.handled then
    if cmdParams[1] == 'step' then
      send_command('@input /ja "'..state.MainStep.value..'" <t>')
    elseif cmdParams[1] == 'altstep' then
      send_command('@input /ja "'..state.AltStep.value..'" <t>')
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
  set_macro_page(1, 20)
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
