--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: HasteInfo, DistancePlus
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable GearInfo, disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Offense Mode: Changes melee accuracy level
* Hybrid Mode: Changes damage taken level while engaged
* Casting Mode: Changes casting type
  * Resistant: Allows you to make high magic accuracy set variants for higher level mobs who may resist more frequently
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
  * There is a Cait Sith PDT mode you can use during fight with the HTBF Cait Sith. Tweak the set to have the
    correct amount of HP for the fight (not divisible by 2, 3, 4, 5, or 6).
* Idle Mode: Determines which set to use when not engaged
  * Normal: Allows automatically equipping Regen, Refresh, and Regain gear as needed
  * HeavyDef: Uses defensive set and disables automatically equipping Regen, Refresh, and Regain gear
* Weaponskill Mode
  * Proc: When using an Abyssea red proc weaponskill, uses a sets.precast.WS['Proc'] set which should have low damage.
    Mainly for not killing enemies by accident while proccing, especially with the Katana elemental WSs.
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Magic Burst Mode: Toggle Magic Burst mode on or off. If on, when casting elemental ninjutsu, will
  use MB set variant to deal more damage. You are expected to know when your spell is going to MB or not, and
  toggle this mode manually as needed. Good rule of thumb is to leave it on when in a party doing planned skillchains
  and off otherwise.
* Elemental Mode: Changes the focused element for elemental ninjutsu. The selected element is used for ninjutsu
  keybinds.

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* All other sets (like precast, midcast, idle, etc.) should exclude weapons (main, sub, range).
* If you enable one of the ToyWeapons modes, it will lock your weapons into low level weapons. This can be
  useful if you are intentionally trying not to kill something, like low level enemies where you may need
  to proc them with a WS without killing them. This overrides all other weapon modes and weapon equip logic.
  * Memorize the keybind to turn it off in case you toggle it by accident.

Spells
* While under Yonin, set variant will be used for Utsusemi that prioritizes Enmity+ over Fast Cast (reduces recast
  time) in the midcast set.

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


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                      Keybinds
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes:
  [ F9 ]                Cycle Melee Accuracy
  [ CTRL+F9 ]           Cycle Melee Defense
  [ F10 ]               Toggle Emergency -PDT
  [ ALT+F10 ]           Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]               Toggle Emergency -MDT
  [ F12 ]               Report current status
  [ CTRL+F12 ]          Cycle Idle modes
  [ ALT+F12 ]           Cancel Emergency -PDT/-MDT Mode
  [ WIN+F9 ]            Cycle Weaponskill Mode
  [ WIN+C ]             Toggle Capacity Points Mode
  [ ALT+` ]             Toggle Magic Burst mode
  [ CTRL+- ]            Cycleback Elemental Mode
  [ CTRL+= ]            Cycle Elemental Mode
  [ CTRL+F8 ]           Toggle Attack Capped mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set
  [ CTRL+PageUp ]       Cycle Toy Weapon Sets
  [ CTRL+PageDown ]     Cycleback Toy Weapon Sets
  [ ALT+PageDown ]      Reset to default Toy Weapon Set

Spells:
  ============ /NIN ============
  [ ALT+Q ]             Utsusemi: Ichi
  [ ALT+W ]             Utsusemi: Ni
  [ ALT+E ]             Utsusemi: San
  [ CTRL+Numpad+ ]      Execute elemental ninjutsu

Abilities:
  [ ALT+Numpad+ ]       Futae
  [ CTRL+NumpadEnter ]  Innin
  [ ALT+NumpadEnter ]   Yonin
  ============ /WAR ============
  [ CTRL+Numlock ]      Defender
  [ CTRL+Numpad/ ]      Berserk
  [ CTRL+Numpad* ]      Warcry
  [ CTRL+Numpad- ]      Aggressor

SilverLibs keybinds:
  [ ALT+D ]             Interact
  [ ALT+S ]             Turn 180 degrees in place
  [ WIN+W ]             Toggle Rearming Lock
                          (off = re-equip previous weapons if you go barehanded)
                          (on = prevent weapon auto-equipping)
  [ CTRL+` ]            Cycle Treasure Hunter Mode

For more info and available functions, see SilverLibs documentation at:
https://github.com/shastaxc/silver-libs

Global-Binds.lua contains additional non-job-related keybinds.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  Custom Commands
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Prepend with /console to use these in in-game macros.

gs c ninelemental       Execute elemental ninjutsu corresponding to the element that is selected in the Elemental
                        Mode
gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this
                        manually fixes it.
gs c equipweapons       Equips weapons based on your current states that you've set.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] Issekigan      /ja "Issekigan" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  StoreTP        /ma "Kakka: Ichi" <me>
[ ALT+2 ]  Migawari       /ma "Migawari: Ichi" <me>
[ ALT+3 ]  SubtlBlo       /ma "Myoshu: Ichi" <me>
[ ALT+9 ]  Mikage         /ja "Mikage" <me>

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
    send_command('gs c weaponset current')
  end, 4)
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
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'HeavyDef', 'Gokotai')
  state.WeaponskillMode:options('Normal', 'Proc')

  state.CP = M(false, 'Capacity Points Mode')
  state.AttCapped = M(true, 'Attack Capped')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Heishi', 'Naegling', 'Gokotai', 'Aeolian'}
  state.MagicBurst = M(true, 'Magic Burst')
  state.ElementalMode = M{['description']='Elemental Mode', 'Fire', 'Ice', 'Wind', 'Earth', 'Thunder', 'Water'}
  nin_element_map = {
    ['Fire'] = 'Katon',
    ['Ice'] = 'Hyoton',
    ['Wind'] = 'Huton',
    ['Earth'] = 'Doton',
    ['Thunder'] = 'Raiton',
    ['Water'] = 'Suiton',
  }

  state.Buff.Migawari = buffactive.migawari or false
  state.Buff.Doom = buffactive.doom or false
  state.Buff.Yonin = buffactive.Yonin or false
  state.Buff.Innin = buffactive.Innin or false
  state.Buff.Futae = buffactive.Futae or false
  state.Buff.Sange = buffactive.Sange or false

  options.ninja_tool_warning_limit = 10
  state.warned = M(false) -- Whether a warning has been given for low ninja tools

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['!`'] = 'gs c toggle MagicBurst',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^-'] = 'gs c cycleback ElementalMode',
      ['^='] = 'gs c cycle ElementalMode',
      ['^numpadenter'] = 'input /ja "Innin" <me>',
      ['!numpadenter'] = 'input /ja "Yonin" <me>',
      ['!numpad+'] = 'input /ja "Futae" <me>',
      ['^numpad+'] = 'gs c ninelemental',
      ['!q'] = 'input /ma "Utsusemi: Ichi" <me>',
      ['!w'] = 'input /ma "Utsusemi: Ni" <me>',
      ['!e'] = 'input /ma "Utsusemi: San" <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
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

  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
  set_sub_keybinds:schedule(2)

  if initialized then
    send_command:schedule(1, 'gs c equipweapons')
  end
  initialized = true -- DO NOT MODIFY
end

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
  end

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    feet="Danzo sune-ate",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.Kiting.DayMovement = {
    feet="Danzo sune-ate",
  }
  sets.Kiting.NightMovement = {
    feet="Hachiya Kyahan +3",
    -- feet="Hachiya Kyahan +4",
  }

  sets.CP = {
    back=gear.CP_Cape,
  }

  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  sets.Enmity = {
    ammo="Sapience Orb",                                -- __/__, ___ [___] < 2>
    head="Hattori Zukin +2",                            --  9/ 9, 109 [ 61] <__>
    body="Emet Harness +1",                             --  6/__,  64 [ 61] <10>
    hands="Kurys Gloves",                               --  2/ 2,  57 [ 25] < 9>
    legs="Hattori Hakama +2",                           -- 11/11, 125 [ 70] <__>
    feet="Mochizuki Kyahan +3",                         -- __/__,  84 [ 33] < 8>
    neck="Moonlight Necklace",                          -- __/__,  15 [___] <15>
    ear1="Odnowa Earring +1",                           --  3/ 5, ___ [110] <__>
    ear2="Cryptic Earring",                             -- __/__, ___ [ 40] < 4>
    ring1="Defending Ring",                             -- 10/10, ___ [___] <__>
    ring2="Eihwaz Ring",                                -- __/__, ___ [ 70] < 5>
    waist="Kasiri Belt",                                -- __/__, ___ [ 30] < 3>

    -- head="Hattori Zukin +3",                         -- 10/10, 119 [ 71] <__>
    -- legs="Hattori Hakama +3",                        -- 12/12, 135 [ 80] <__>
    -- feet="Mochizuki Kyahan +4",                      -- __/__, 124 [ 43] < 8>
    -- ear1="Pluto's Pearl",                            -- __/__, ___ [___] < 4>
    -- back=gear.NIN_Enmity_Cape,                       -- 10/__, ___ [___] <10>
    -- 50 PDT / 34 MDT, 514 M.Eva [420 HP] <70 Enmity>
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Heishi'] = {
    main="Heishi Shorinken",
    sub="Kunimitsu",
    range="empty",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Kunimitsu",
    -- sub="Hitaki",
    range="empty",
  }
  sets.WeaponSet['Enmity'] = {
    -- main=gear.Fudo_Masamune_C,
    sub="Tsuru",
    range="empty",
  }
  sets.WeaponSet['Aeolian'] = {
    main="Tauret",
    sub=gear.Malevolence_1,
    range="empty",
  }
  sets.WeaponSet['Gokotai'] = {
    main="Gokotai",
    sub=gear.Malevolence_1,
    range="Ullr",
    ammo="empty",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.defense.PDT = {
    range="empty",
    ammo="Staunch Tathlum +1",        -- [ 3/ 3, ___] ___, 11
    head=gear.Nyame_B_head,           -- [ 7/ 7, 123]  91, __
    body=gear.Nyame_B_body,           -- [ 9/ 9, 139] 102, __
    hands=gear.Nyame_B_hands,         -- [ 7/ 7, 112]  80, __
    legs=gear.Nyame_B_legs,           -- [ 8/ 8, 150]  85, __
    feet=gear.Nyame_B_feet,           -- [ 7/ 7, 150] 119, __
    neck="Warder's Charm +1",         -- [__/__, ___] ___, __; Absorb magic dmg
    ear1="Eabani Earring",            -- [__/__,   8]  15, __
    ear2="Arete Del Luna +1",         -- [__/__, ___] ___, __; Resists
    ring1="Shadow Ring",              -- [__/__, ___] ___, __; Annul magic dmg
    ring2="Defending Ring",           -- [10/10, ___] ___, __
    back="Shadow Mantle",             -- [__/__, ___] ___, __; Annul physical dmg
    waist="Engraved Belt",            -- [__/__, ___] ___, __; Element resist

    -- body="Hattori Ningi +3",       -- [13/13, 129]  95, __; Migawari+16
    -- [51 PDT/51 MDT, 682 M.Eva] 492 Eva, 11 Status Resist
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
  }
  sets.latent_regen = {
    body="Hizamaru Haramaki +2",
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

  sets.idle = set_combine(sets.defense.PDT, {})

  -- Max out DW; Regain from DW caps at 100
  sets.idle.Gokotai = {
    head=gear.Ryuo_C_head,            --  9 [__/__,  48]  36
    body="Mochizuki Chainmail +3",    --  9 [__/__,  73]  72
    hands=gear.Floral_Gauntlets,      --  5 [__/ 2,  37]  24; Taeon alt
    legs="Mochizuki Hakama +3",       -- 10 [__/__,  84]  63
    feet=gear.Taeon_DW_feet,          --  9 [__/__,  69]  72
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] ___
    ear1="Eabani Earring",            --  4 [__/__,   8]  15
    ear2="Suppanomimi",               --  5 [__/__, ___] ___
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] ___
    ring2="Defending Ring",           -- __ [10/10, ___] ___
    back=gear.NIN_DW_Cape,            -- 10 [10/__, ___] ___
    waist="Reiki Yotai",              --  7 [__/__, ___] ___
    -- Traits                            35
    -- 103 DW [33 PDT/17 MDT, 319 M.Eva] 282 Evasion

    -- body="Mochizuki Chainmail +4", --  9 [__/__, 113]  97
    -- hands="Floral Gauntlets",      --  5 [__/ 4,  37]  24
    -- legs="Mochizuki Hakama +4",    -- 10 [__/__, 124]  88
    -- 103 DW [33 PDT/19 MDT, 399 M.Eva] 332 Evasion
  }

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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
  sets.precast.JA['Mijin Gakure'] = {
    legs="Mochizuki Hakama +3", -- Damage +50%; +1 is acceptable
    -- legs="Mochizuki Hakama +4", -- Damage +50%; +1 is acceptable
  }
  sets.precast.JA['Sange'] = {
    body="Mochizuki Chainmail +3", -- Increase ranged attack based on merits; +1 is acceptable
    -- body="Mochizuki Chainmail +4", -- Increase ranged attack based on merits; +1 is acceptable
  }

  sets.precast.Waltz = {
    range="empty",
    ammo="Yamarang",
    body="Passion Jacket",
    legs="Dashing Subligar",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    range="empty",
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head=gear.Herc_Refresh_head,      --  7 [__/__,  59]
    body=gear.Taeon_FC_body,          --  9 [__/__,  64]
    hands="Leyline Gloves",           --  8 [__/__,  62]
    legs="Rawhide Trousers",          --  5 [__/__,  69]
    feet=gear.Herc_MAB_feet,          --  2 [ 2/__,  75]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Loquacious Earring",        --  2 [__/__, ___]
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    -- back=gear.NIN_FC_Cape,         -- 10 [10/__, ___]
    waist="Audumbla Sash",            -- __ [ 4/__, ___]
    -- 54 FC [29 PDT/15 MDT, 329 M.Eva]
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Mochizuki Chainmail +3",    -- 14 [__/__,  73]
    legs="Hattori Hakama +2",         -- __ [11/11, 125]
    neck="Magoraga Bead Necklace",    -- 10 [__/__, ___]
    -- JP/Merit/Gifts                    20 [__/__, ___]
    -- 84 FC [29 PDT/15 MDT, 338 M.Eva]

    -- body="Mochizuki Chainmail +4", -- 14 [__/__, 113]
    -- legs="Hattori Hakama +3",      -- __ [12/12, 135]
    -- 79 FC [41 PDT/27 MDT, 444 M.Eva]
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    range="empty",
    ammo="Seething Bomblet +1",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Lugra Earring +1",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
    
    -- feet="Hattori Kyahan +3",
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Hattori Earring +1",
    -- ear2="Hattori Earring +2",
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    range="empty",
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Hattori Earring +1",
    ring1="Sroda Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- head="Hachiya Hatsuburi +4",
    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Lugra Earring +1",
  })

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Savage Blade'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  sets.HybridWS = {
    range="empty",
    ammo="Seething Bomblet +1",
    head="Mochizuki Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Eschan Stone",
    
    -- head="Mochizuki Hatsuburi +4",
  }
  sets.HybridWS.MaxTP = set_combine(sets.HybridWS, {
    ear1="Novio Earring",
  })
  sets.HybridWS.AttCapped = {
    range="empty",
    ammo="Seething Bomblet +1",
    head="Mochizuki Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Hattori Earring +1",
    ring1="Sroda Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Eschan Stone",

    -- head="Mochizuki Hatsuburi +4",
    -- ear2="Hattori Earring +2"
  }
  sets.HybridWS.AttCappedMaxTP = set_combine(sets.HybridWS.AttCapped, {
    ear1="Novio Earring",
  })

  sets.precast.WS['Blade: To'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: To'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: To'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: To'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Teki'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: Teki'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: Teki'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: Teki'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Chi'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: Chi'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: Chi'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: Chi'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Ei'] = {
    range="empty",
    ammo="Seething Bomblet +1",
    head="Mochizuki Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Sibyl Scarf",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Archon Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_MAB_Cape,
    waist="Eschan Stone",
    
    -- head="Mochizuki Hatsuburi +4",
  }
  sets.precast.WS['Blade: Ei'].MaxTP = set_combine(sets.precast.WS['Blade: Ei'], {
    ear1="Novio Earring",
  })
  sets.precast.WS['Blade: Ei'].AttCapped = set_combine(sets.precast.WS['Blade: Ei'], {})
  sets.precast.WS['Blade: Ei'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ei'].AttCapped, {
    ear1="Novio Earring",
  })

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    range="empty",
    ammo="Ghastly Tathlum +1",
    head="Mochizuki Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Sibyl Scarf",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_MAB_Cape,
    waist="Eschan Stone",
    
    -- head="Mochizuki Hatsuburi +4",
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear1="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].AttCapped = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].AttCapped, {
    ear1="Novio Earring",
  })

  sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Blade: Yu'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MaxTP, {})
  sets.precast.WS['Blade: Yu'].AttCapped = set_combine(sets.precast.WS['Aeolian Edge'].AttCapped, {})
  sets.precast.WS['Blade: Yu'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].AttCappedMaxTP, {})

  sets.precast.WS['Blade: Hi'] = {
    range="empty",
    ammo="Yetshila +1",
    head="Hachiya Hatsuburi +3",
    body="Hattori Ningi +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Ishvara Earring",
    ring1="Ilabrat Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- head="Hachiya Hatsuburi +4",
    -- body="Hattori Ningi +3",
    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_Crit_AGI_Cape,
    -- waist="Gerdr Belt +1",
  }
  sets.precast.WS['Blade: Hi'].MaxTP = set_combine(sets.precast.WS['Blade: Hi'], {})
  sets.precast.WS['Blade: Hi'].AttCapped = {
    range="empty",
    ammo="Yetshila +1",
    head="Hachiya Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Hattori Earring +1",
    ring1="Epaminondas's Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- head="Hachiya Hatsuburi +4",
    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_Crit_AGI_Cape,
    -- waist="Gerdr Belt +1",
  }
  sets.precast.WS['Blade: Hi'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Hi'].AttCapped, {})

  sets.precast.WS['Blade: Kamu'] = {
    range="empty",
    ammo="Crepuscular Earring",
    head="Hachiya Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +1",
    ring1="Ephramad's Ring",
    ring2="Gere Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
    
    -- head="Hachiya Hatsuburi +4",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_WSD_STR_Cape,
  }

  sets.precast.WS['Blade: Ku'] = {
    range="empty",
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Lugra Earring +1",
    ear2="Brutal Earring",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",

    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_DA_STR_Cape,
  }
  sets.precast.WS['Blade: Ku'].MaxTP = set_combine(sets.precast.WS['Blade: Ku'], {})
  sets.precast.WS['Blade: Ku'].AttCapped = {
    range="empty",
    ammo="Coiste Bodhar",
    head="Blistering Sallet +1",
    body=gear.Nyame_B_body,
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",

    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_DA_STR_Cape,
  }
  sets.precast.WS['Blade: Ku'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ku'].AttCapped, {})

  sets.precast.WS['Blade: Metsu'] = {
    range="empty",
    ammo="Coiste Bodhar",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Mache Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_WSD_DEX_Cape,
  }
  sets.precast.WS['Blade: Metsu'].MaxTP = set_combine(sets.precast.WS['Blade: Metsu'], {})
  sets.precast.WS['Blade: Metsu'].AttCapped = {
    range="empty",
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,
    body="Malignance Tabard",
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Kentarch Belt +1",
    
    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_WSD_DEX_Cape,
  }
  sets.precast.WS['Blade: Metsu'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Metsu'].AttCapped, {})

  sets.precast.WS['Blade: Shun'] = {
    range="empty",
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body=gear.Nyame_B_head,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",
    
    -- feet="Hattori Kyahan +3",
    -- back=gear.NIN_DA_DEX_Cape,
  }
  sets.precast.WS['Blade: Shun'].MaxTP = set_combine(sets.precast.WS['Blade: Shun'], {
    ammo="Crepuscular Pebble",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +1",

    -- ear2="Hattori Earring +2",
  })
  sets.precast.WS['Blade: Shun'].AttCapped = {
    range="empty",
    ammo="Crepuscular Pebble",
    head="Mpaca's Cap",
    body=gear.Nyame_B_head,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Hattori Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",

    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_DA_DEX_Cape,
  }
  sets.precast.WS['Blade: Shun'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Shun'].AttCapped, {
    ear1="Lugra Earring +1",
  })

  sets.precast.WS['Blade: Ten'] = {
    range="empty",
    ammo="Seething Bomblet +1",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Regal Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- feet="Hattori Kyahan +3",
    -- back=gear.NIN_WSD_STR_Cape,
  }
  sets.precast.WS['Blade: Ten'].MaxTP = set_combine(sets.precast.WS['Blade: Ten'], {
    head=gear.Nyame_B_head,
    ear1="Mache Earring +1",

    -- ear1="Lugra Earring +1",
    -- ear2="Hattori Earring +2",
  })
  sets.precast.WS['Blade: Ten'].AttCapped = {
    range="empty",
    ammo="Crepuscular Pebble",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Hattori Earring +1",
    ring1="Regal Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",

    -- feet="Hattori Kyahan +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_WSD_STR_Cape,
  }
  sets.precast.WS['Blade: Ten'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ten'].AttCapped, {
    head=gear.Nyame_B_head,
    ear1="Lugra Earring +1",

    -- head="Hachiya Hatsuburi +4",
  })

  sets.precast.WS['Evisceration'] = {
    range="empty",
    ammo="Yetshila +1",
    head=gear.Adhemar_B_head,
    body="Hattori Ningi +2",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet="Kendatsuba Sune-Ate +1",
    neck="Fotia Gorget",
    ear1="Odr Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",

    -- body="Hattori Ningi +3",
    -- back=gear.NIN_Crit_DEX_Cape,
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Evisceration'].AttCapped = {
    range="empty",
    ammo="Yetshila +1",
    head=gear.Adhemar_B_head,
    body="Hattori Ningi +2",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet="Kendatsuba Sune-Ate +1",
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Hattori Earring +1",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Fotia Belt",

    -- body="Hattori Ningi +3",
    -- ear2="Hattori Earring +2",
    -- back=gear.NIN_Crit_DEX_Cape,
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear2="Lugra Earring +1",
  })

  -- Used for "Proc" mode, when you typically don't want it to do a lot of damage. Focus acc.
  sets.precast.WS['Proc'] = {
    range="empty",
    ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="empty",
    ear1="empty",
    ear2="empty",
    ring1="empty",
    ring2="empty",
    back="empty",
    waist="empty",
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

  -- DT > FC > +Enmity > SIRD
  sets.midcast.Utsusemi = {
    range="empty",
    ammo="Staunch Tathlum +1",        -- __, __, __, 11 [ 3/ 3, ___]
    head=gear.Herc_Refresh_head,      -- __,  7, __, __ [__/__,  59]
    body=gear.Taeon_FC_body,          -- __,  9, __, __ [__/__,  64]
    hands="Leyline Gloves",           -- __,  8, __, __ [__/__,  62]
    legs="Hattori Hakama +2",         -- __, __, __, __ [11/11, 125]
    feet="Hattori Kyahan +2",         --  1, __, __, __ [__/__, 125]
    neck="Orunmila's Torque",         -- __,  5, -3, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ear2="Loquacious Earring",        -- __,  2, __, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.NIN_MAB_Cape,           --  1, __, __, __ [10/__, ___]
    waist="Audumbla Sash",            -- __, __, __, 10 [ 4/__, ___]
    -- Merits                                         8
    -- 2 Shadows, 31 FC, -3 Enmity, 29 SIRD [48 PDT / 28 MDT, 435 M.Eva]

    -- legs="Hattori Hakama +3",      -- __, __, __, __ [12/12, 135]
    -- feet="Hattori Kyahan +3",      --  1, __, __, __ [__/__, 135]
    -- back=gear.NIN_FC_Cape,         --  1, 10, __, __ [10/__, ___]
    -- Merits                                         8
    -- 2 Shadows, 41 FC, -3 Enmity, 21 SIRD [49 PDT / 29 MDT, 455 M.Eva]
  }

  -- DT > +Enmity > FC > SIRD
  sets.midcast.Utsusemi.Yonin = {
    range="empty",
    ammo="Sapience Orb",              -- __,  2,  2, __ [__/__, ___]
    head="Hattori Zukin +2",          -- __, __, __, __ [ 9/ 9, 109]
    body="Emet Harness +1",           -- __, __, 10, __ [ 6/__,  64]
    hands="Kurys Gloves",             -- __, __,  9, __ [ 2/ 2,  57]
    legs="Hattori Hakama +2",         -- __, __, __, __ [11/11, 125]
    feet="Hattori Kyahan +2",         --  1, __, __, __ [__/__, 125]
    neck="Moonlight Necklace",        -- __, __, 15, 15 [__/__,  15]
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ear2="Cryptic Earring",           -- __, __,  4, __ [__/__, ___]
    ring1="Eihwaz Ring",              -- __, __,  5, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.NIN_MAB_Cape,           --  1, __, __, __ [10/__, ___]
    waist="Kasiri Belt",              -- __, __,  3, __ [__/__, ___]
    -- Merits                                     8
    -- 2 Shadows, 2 FC, 56 Enmity, 15 SIRD [51 PDT / 37 MDT, 495 M.Eva]

    -- head="Hattori Zukin +3",       -- __, __, __, __ [10/10, 119]
    -- legs="Hattori Hakama +3",      -- __, __, __, __ [12/12, 135]
    -- feet="Hattori Kyahan +3",      --  1, __, __, __ [__/__, 135]
    -- ear1="Pluto's Pearl",          -- __, __,  4, __ [__/__, ___]
    -- back=gear.NIN_Enmity_Cape,     --  1, __, 10, __ [10/__, ___]
    -- 2 Shadows, 2 FC, 62 Enmity, 23 SIRD [50 PDT / 34 MDT, 525 M.Eva]
  }

  -- Ninjustu skill cap for damage calculations: Ichi=250, Ni=349, San=499
  -- NIN99 with merits has 469 Ninjusu skill, so naturally capped on Ichi and Ni. San could use more Ninjutsu skill for dmg.
  -- Ninjutsu skill is capped for San at Master Level 30 so we do not need to use any in gear.
  sets.midcast.ElementalNinjutsu = {
    range="empty",
    ammo="Ghastly Tathlum +1",        -- 11, __, __, __, 21 (__, __) [__/__, ___]
    head="Mochizuki Hatsuburi +3",    -- 32, 82, __, 37, __ (__, __) [__/__,  63]
    body=gear.Nyame_B_body,           -- 42, 30, __, 40, __ ( 7, __) [ 9/ 9, 139]
    hands="Hattori Tekko +2",         -- 22, 16, __, 52, __ (10, __) [__/__, 103]; Ninjutsu dmg +16%
    legs=gear.Nyame_B_legs,           -- 44, 30, __, 40, __ ( 6, __) [ 8/ 8, 150]
    feet="Mochizuki Kyahan +3",       -- __, __, 23, 36, __ (__, __) [__/__,  84]; MAB+25%
    neck="Sibyl Scarf",               -- 10, 10, __, __, __ (__, __) [__/__, ___]
    ear1="Friomisi Earring",          -- __, 10, __, __, __ (__, __) [__/__, ___]
    ear2="Novio Earring",             -- __,  7, __, __, __ (__, __) [__/__, ___]
    ring1="Shiva Ring +1",            --  9,  3, __, __, __ (__, __) [__/__, ___]
    ring2="Dingir Ring",              -- __, 10, __, __, __ (__, __) [__/__, ___]
    back=gear.NIN_MAB_Cape,           -- 30, 10, __, 20, 20 (__, __) [10/__, ___]
    waist="Eschan Stone",             -- __,  7, __,  7, __ (__, __) [__/__, ___]
    -- 200 INT, 215 MAB, 23 MAccSk, 232 M.Acc, 41 MDmg (23 MB Dmg%, 0 MB2 Dmg%) [27 PDT/17 MDT, 539 M.Eva]

    -- head="Mochizuki Hatsuburi +4", -- 35, 85, __, 42, __ (__, __) [__/__, 103]
    -- hands="Hattori Tekko +3",      -- 27, 18, __, 62, __ (15, __) [__/__, 103]; Ninjutsu dmg +18%
    -- feet="Mochizuki Kyahan +4",    -- __, __, 24, 41, __ (__, __) [__/__, 124]; MAB+25%
  }
  sets.midcast.ElementalNinjutsu.MB = {
    range="empty",
    ammo="Ghastly Tathlum +1",        -- 11, __, __, __, 21 (__, __) [__/__, ___]
    head="Mochizuki Hatsuburi +3",    -- 32, 82, __, 37, __ (__, __) [__/__,  63]
    body=gear.Nyame_B_body,           -- 42, 30, __, 40, __ ( 7, __) [ 9/ 9, 139]
    hands="Hattori Tekko +2",         -- 22, 16, __, 52, __ (10, __) [__/__, 103]; Ninjutsu dmg +16%
    legs=gear.Nyame_B_legs,           -- 44, 30, __, 40, __ ( 6, __) [ 8/ 8, 150]
    feet="Mochizuki Kyahan +3",       -- __, __, 23, 36, __ (__, __) [__/__,  84]; MAB+25%
    neck="Warder's Charm +1",         -- __, __, __, __, __ (10, __) [__/__, ___]
    ear1="Friomisi Earring",          -- __, 10, __, __, __ (__, __) [__/__, ___]
    ear2="Novio Earring",             -- __,  7, __, __, __ (__, __) [__/__, ___]
    ring1="Dingir Ring",              -- __, 10, __, __, __ (__, __) [__/__, ___]
    ring2="Mujin Band",               -- __, __, __, __, __ (__,  5) [__/__, ___]
    back=gear.NIN_MAB_Cape,           -- 30, 10, __, 20, 20 (__, __) [10/__, ___]
    waist="Eschan Stone",             -- __,  7, __,  7, __ (__, __) [__/__, ___]
    -- 181 INT, 202 MAB, 23 MAccSk, 232 M.Acc, 41 MDmg (33 MB Dmg%, 5 MB2 Dmg%) [27 PDT/17 MDT, 539 M.Eva]

    -- head="Mochizuki Hatsuburi +4", -- 35, 85, __, 42, __ (__, __) [__/__, 103]
    -- hands="Hattori Tekko +3",      -- 27, 18, __, 62, __ (15, __) [__/__, 103]; Ninjutsu dmg +18%
    -- feet="Mochizuki Kyahan +4",    -- __, __, 24, 41, __ (__, __) [__/__, 124]; MAB+25%
  }

  -- Mostly for Ongo who has 445 INT at v25. Your dINT is less than -70 so INT is too low to help with M.Acc.
  -- Stack M.Acc from gear instead. Expect no help from buffs in that fight. Aim for 1365 m.acc (including 
  -- m.acc bonuses from ninjutsu skill).
  -- Aim for 700 m.acc from gear/weapons (including skill bonuses)
  sets.midcast.ElementalNinjutsu.Resistant = {
    range="empty",
    ammo="Yamarang",                  -- __, __, __, 15, __ (__, __) [__/__,  15]
    head="Hachiya Hatsuburi +3",      -- 31, __, 17, 54, __ (__, __) [__/__,  63]
    body=gear.Nyame_B_body,           -- 42, 30, __, 40, __ ( 7, __) [ 9/ 9, 139]
    hands="Hattori Tekko +2",         -- 22, 16, __, 52, __ (10, __) [__/__, 103]; Ninjutsu dmg +16%
    legs=gear.Nyame_B_legs,           -- 44, 30, __, 40, __ ( 6, __) [ 8/ 8, 150]
    feet="Mochizuki Kyahan +3",       -- __, __, 23, 36, __ (__, __) [__/__,  84]; MAB+25%
    neck="Sanctity Necklace",         -- __, 10, __, 10, __ (__, __) [__/__, ___]
    ear1="Friomisi Earring",          -- __, 10, __, __, __ (__, __) [__/__, ___]
    ear2="Hattori Earring +1",        -- __, __, __, 12, __ (__, __) [__/__, ___]
    ring1="Stikini Ring +1",          -- __, __,  8, 11, __ (__, __) [__/__, ___]
    ring2="Metamorph Ring +1",        -- 16, __, __, 16, __ (__, __) [__/__, ___]
    back=gear.NIN_MAB_Cape,           -- 30, 10, __, 20, 20 (__, __) [10/__, ___]
    waist="Eschan Stone",             -- __,  7, __,  7, __ (__, __) [__/__, ___]
    -- 185 INT, 113 MAB, 48 MAccSk, 313 M.Acc, 20 MDmg (23 MB Dmg%, 0 MB2 Dmg%) [27 PDT/17 MDT, 554 M.Eva]

    -- head="Hachiya Hatsuburi +4",   -- 31, __, 18, 64, __ (__, __) [__/__,  88]
    -- hands="Hattori Tekko +3",      -- 27, 18, __, 62, __ (15, __) [__/__, 103]; Ninjutsu dmg +18%
    -- feet="Mochizuki Kyahan +4",    -- __, __, 24, 41, __ (__, __) [__/__, 124]; MAB+25%
    -- ear2="Novio Earring",          -- __,  7, __, __, __ (__, __) [__/__, ___]; Equip when Hattori Tekko +3
    -- 190 INT, 122 MAB, 48 MAccSk, 322 M.Acc, 20 MDmg (28 MB Dmg%, 0 MB2 Dmg%) [27 PDT/17 MDT, 579 M.Eva]
  }
  sets.midcast.ElementalNinjutsu.Resistant.MB = set_combine(sets.midcast.ElementalNinjutsu.Resistant, {})

  sets.midcast.EnfeeblingNinjutsu = {
    range="empty",
    ammo="Yamarang",                  -- 15, __ [__/__,  15]
    head="Hachiya Hatsuburi +3",      -- 54, 17 [__/__,  63]
    body="Hattori Ningi +2",          -- 54, __ [12/12, 119]
    hands="Hattori Tekko +2",         -- 52, __ [__/__,  93]
    legs="Hattori Hakama +2",         -- 53, __ [11/11, 125]
    feet="Mochizuki Kyahan +3",       -- 36, 23 [__/__,  84]
    neck="Incanter's Torque",         -- __, 10 [__/__, ___]
    ear1="Dignitary's Earring",       -- 10, __ [__/__, ___]
    ear2="Hattori Earring +1",        -- 11, __ [__/__, ___]
    ring1="Stikini Ring +1",          -- 11,  8 [__/__, ___]
    ring2="Defending Ring",           -- __, __ [10/10, ___]
    back=gear.NIN_MAB_Cape,           -- 20, __ [10/__, ___]
    waist="Eschan Stone",             --  7, __ [__/__, ___]
    -- 323 M.Acc, 58 Ninjutsu [43 PDT/33 MDT, 499 M.Eva]
    
    -- head="Hachiya Hatsuburi +4",   -- 64, 18 [__/__,  88]
    -- body="Hattori Ningi +3",       -- 64, __ [13/13, 129]
    -- hands="Hattori Tekko +3",      -- 62, __ [__/__, 103]
    -- legs="Hattori Hakama +3",      -- 63, __ [12/12, 135]
    -- feet="Mochizuki Kyahan +4",    -- 41, 24 [__/__, 124]
    -- ear2="Hattori Earring +2",     -- 20, __ [__/__, ___]
    -- 377 M.Acc, 60 Ninjutsu [45 PDT/35 MDT, 594 M.Eva]
  }

  -- The only enhancing ninjutsu that scales with skill is Migawari, but at ML50 the threshold is already down
  -- to about 50%. Lowering it further will just cause non-threatening attacks to wear off Migawari so I am
  -- choosing not to stack Ninjutsu skill in this set. Focusing Ninja Tool Expertise and defensive stats.
  sets.midcast.EnhancingNinjutsu = {
    range="empty",
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Hattori Zukin +2",          -- __ [ 9/ 9, 109]
    body="Hattori Ningi +2",          -- __ [12/12, 119]
    legs="Hattori Hakama +2",         -- __ [11/11, 125]
    feet="Hattori Kyahan +2",         -- __ [__/__, 135]; Tactical parry+23
    neck="Moonlight Necklace",        -- __ [__/__,  15]; SIRD+15
    ear1="Arete Del Luna +1",         -- __ [__/__, ___]; Resists
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___]
    ring1="Shadow Ring",              -- __ [__/__, ___]; Annul magic dmg
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Shadow Mantle",             -- __ [__/__, ___]; Annul physical dmg
    -- Merits/Gifts                      25
    -- 25 Ninja Tool Expertise [48 PDT/50 MDT, 503 M.Eva]

    -- head="Hattori Zukin +3",       -- __ [10/10, 119]
    -- body="Hattori Ningi +3",       -- __ [13/13, 129]
    -- hands="Mochizuki Tekko +4",    -- 38 [__/__,  86]
    -- legs="Hattori Hakama +3",      -- __ [12/12, 135]
    -- feet="Hattori Kyahan +3",      -- __ [__/__, 125]; Tactical parry+26
    -- waist="Gosha Sarashi",         --  5 [__/__, ___]
    -- Merits/Gifts                      25
    -- 68 Ninja Tool Expertise [51 PDT/53 MDT, 609 M.Eva]
  }

  sets.midcast.Stun = set_combine(sets.midcast.EnfeeblingNinjutsu, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Tatenashi Haramaki +1",     -- __,  9,  65/__ <__,  5, __> [__/__,  59]  44, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Windbuffet Belt +1",       -- __, __,   2/__ <__,  2,  2> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 0 DW, 75 STP, 314 Acc/207 R.Acc <4 DA, 14 TA, 2 QA> [37 PDT/27 MDT, 525 M.Eva] 375 Evasion, 79 Daken

    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 0 DW, 78 STP, 324 Acc/197 R.Acc <3 DA, 14 TA, 2 QA> [37 PDT/27 MDT, 525 M.Eva] 375 Evasion, 79 Daken

  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ear2="Dignitary's Earring",       -- __,  3,  10/__ <__, __, __> [__/__, ___] ___, __
    
    -- ear1="Telos Earring",          -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ammo="Date Shuriken",             -- __, __,   5/ 5 <__, __, __> [__/__, ___]   5, __
    waist="Kentarch Belt +1",         -- __,  5,  14/__ < 3, __, __> [__/__, ___] ___, __
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ring2="Chirich Ring +1",          -- __,  6,  10/__ <__, __, __> [__/__, ___] ___, __
    waist="Olseni Belt",              -- __,  3,  20/__ <__, __, __> [__/__, ___] ___, __
  })

  -- Low DW (15 needed from gear)
  sets.engaged.LowDW = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Tatenashi Sune-ate +1",     -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 16 DW, 81 STP, 307 Acc/152 R.Acc <4 DA, 14 TA, 0 QA> [37 PDT/23 MDT, 455 M.Eva] 335 Evasion, 79 Daken
    
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 16 DW, 84 STP, 317 Acc/142 R.Acc <3 DA, 14 TA, 0 QA> [37 PDT/17 MDT, 407 M.Eva] 335 Evasion, 79 Daken
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ear2="Dignitary's Earring",       -- __,  3,  10/__ <__, __, __> [__/__, ___] ___, __
    
    -- ear1="Telos Earring",          -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    ammo="Date Shuriken",             -- __, __,   5/ 5 <__, __, __> [__/__, ___]   5, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mochizuki Chainmail +3",    --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    
    -- body="Mochizuki Chainmail +4", --  9, __,  56/52 <__, __, __> [__/__, 113]  97, 10
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    waist="Olseni Belt",              -- __,  3,  20/__ <__, __, __> [__/__, ___] ___, __
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body=gear.Adhemar_A_body,         --  6, __,  55/35 <__,  4, __> [__/__,  69]  55, __
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 22 DW, 79 STP, 295 Acc/255 R.Acc <4 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
    
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 22 DW, 82 STP, 305 Acc/245 R.Acc <3 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
  })

  -- High DW (25 needed from gear)
  sets.engaged.HighDW = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mochizuki Chainmail +3",    --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Tatenashi Sune-ate +1",     -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 25 DW, 78 STP, 301 Acc/217 R.Acc <4 DA, 6 TA, 0 QA> [32 PDT/22 MDT, 463 M.Eva] 349 Evasion, 89 Daken
    
    -- body="Mochizuki Chainmail +4", --  9, __,  56/52 <__, __, __> [__/__, 113]  97, 10
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 25 DW, 81 STP, 316 Acc/212 R.Acc <3 DA, 6 TA, 0 QA> [32 PDT/22 MDT, 503 M.Eva] 374 Evasion, 89 Daken
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
  })

  -- Super DW (32 needed from gear)
  sets.engaged.SuperDW = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body=gear.Adhemar_A_body,         --  6, __,  55/35 <__,  4, __> [__/__,  69]  55, __
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 32 DW, 69 STP, 295 Acc/255 R.Acc <4 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
    
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 32 DW, 72 STP, 305 Acc/245 R.Acc <3 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
  })

  -- Max DW (39 needed from gear)
  sets.engaged.MaxDW = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mochizuki Chainmail +3",    --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Eabani Earring",            --  4, __,  __/__ <__, __, __> [__/__,   8]  15, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 39 DW, 64 STP, 281 Acc/257 R.Acc <3 DA, 3 TA, 0 QA> [36 PDT/26 MDT, 541 M.Eva] 407 Evasion, 89 Daken
    
    -- body="Mochizuki Chainmail +4", --  9, __,  56/52 <__, __, __> [__/__, 113]  97, 10
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 39 DW, 64 STP, 316 Acc/272 R.Acc <3 DA, 3 TA, 0 QA> [36 PDT/26 MDT, 581 M.Eva] 432 Evasion, 89 Daken
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

  -- No DW (0 needed from gear)
  sets.engaged.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Windbuffet Belt +1",       -- __, __,   2/__ <__,  2,  2> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 0 DW, 69 STP, 304 Acc/197 R.Acc <3 DA, 13 TA, 2 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 0 DW, 69 STP, 334 Acc/207 R.Acc <3 DA, 13 TA, 2 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
  }
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {
  })
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {
  })
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.MidAcc.HeavyDef, {
  })

  -- Low DW (15 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 17 DW, 63 STP, 312 Acc/207 R.Acc <3 DA, 11 TA, 0 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 17 DW, 63 STP, 342 Acc/217 R.Acc <3 DA, 11 TA, 0 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
  }
  sets.engaged.LowDW.LowAcc.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {
  })
  sets.engaged.LowDW.MidAcc.HeavyDef = set_combine(sets.engaged.LowDW.LowAcc.HeavyDef, {
  })
  sets.engaged.LowDW.HighAcc.HeavyDef = set_combine(sets.engaged.LowDW.MidAcc.HeavyDef, {
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Eabani Earring",            --  4, __,  __/__ <__, __, __> [__/__,   8]  15, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 21 DW, 55 STP, 322 Acc/217 R.Acc <3 DA, 11 TA, 0 QA> [50 PDT/32 MDT, 560 M.Eva] 448 Evasion, 79 Daken
  }
  sets.engaged.MidDW.LowAcc.HeavyDef = set_combine(sets.engaged.MidDW.HeavyDef, {
  })
  sets.engaged.MidDW.MidAcc.HeavyDef = set_combine(sets.engaged.MidDW.LowAcc.HeavyDef, {
  })
  sets.engaged.MidDW.HighAcc.HeavyDef = set_combine(sets.engaged.MidDW.MidAcc.HeavyDef, {
  })

  -- High DW (25 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +2",          --  7, __,  51/51 <__, __, __> [ 9/ 9, 109]  79, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Tatenashi Sune-ate +1",     -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 24 DW, 54 STP, 323 Acc/158 R.Acc <3 DA, 14 TA, 0 QA> [49 PDT/31 MDT, 468 M.Eva] 378 Evasion, 79 Daken
    
    -- head="Hattori Zukin +3",       --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 24 DW, 54 STP, 363 Acc/178 R.Acc <3 DA, 14 TA, 0 QA> [50 PDT/32 MDT, 478 M.Eva] 388 Evasion, 79 Daken
  }
  sets.engaged.HighDW.LowAcc.HeavyDef = set_combine(sets.engaged.HighDW.HeavyDef, {
  })
  sets.engaged.HighDW.MidAcc.HeavyDef = set_combine(sets.engaged.HighDW.LowAcc.HeavyDef, {
  })
  sets.engaged.HighDW.HighAcc.HeavyDef = set_combine(sets.engaged.HighDW.MidAcc.HeavyDef, {
  })

  -- Super DW (32 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +2",          --  7, __,  51/51 <__, __, __> [ 9/ 9, 109]  79, __
    body="Mochizuki Chainmail +3",    --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Gelatinous Ring +1",       -- __, __,  __/__ <__, __, __> [ 7/-1, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 33 DW, 47 STP, 309 Acc/255 R.Acc <0 DA, 4 TA, 0 QA> [51 PDT/35 MDT, 525 M.Eva] 391 Evasion, 89 Daken

    -- head="Hattori Zukin +3",       --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    -- body="Mochizuki Chainmail +4", --  9, __,  56/52 <__, __, __> [__/__, 113]  97, 10
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
    -- 33 DW, 47 STP, 354 Acc/280 R.Acc <0 DA, 4 TA, 0 QA> [51 PDT/35 MDT, 575 M.Eva] 426 Evasion, 89 Daken
  }
  sets.engaged.SuperDW.LowAcc.HeavyDef = set_combine(sets.engaged.SuperDW.HeavyDef, {
  })
  sets.engaged.SuperDW.MidAcc.HeavyDef = set_combine(sets.engaged.SuperDW.LowAcc.HeavyDef, {
  })
  sets.engaged.SuperDW.HighAcc.HeavyDef = set_combine(sets.engaged.SuperDW.MidAcc.HeavyDef, {
  })

  -- Max DW (39 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    range="empty",
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +2",          --  7, __,  51/51 <__, __, __> [ 9/ 9, 109]  79, __
    body="Mochizuki Chainmail +3",    --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Suppanomimi",               --  5, __,  __/__ <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Gelatinous Ring +1",       -- __, __,  __/__ <__, __, __> [ 7/-1, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 38 DW, 39 STP, 319 Acc/265 R.Acc <0 DA, 4 TA, 0 QA> [50 PDT/34 MDT, 525 M.Eva] 391 Evasion, 89 Daken

    -- head="Hattori Zukin +3",       --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    -- body="Mochizuki Chainmail +4", --  9, __,  56/52 <__, __, __> [__/__, 113]  97, 10
    -- 38 DW, 39 STP, 334 Acc/280 R.Acc <0 DA, 4 TA, 0 QA> [51 PDT/35 MDT, 575 M.Eva] 426 Evasion, 89 Daken
  }
  sets.engaged.MaxDW.LowAcc.HeavyDef = set_combine(sets.engaged.MaxDW.HeavyDef, {
  })
  sets.engaged.MaxDW.MidAcc.HeavyDef = set_combine(sets.engaged.MaxDW.LowAcc.HeavyDef, {
  })
  sets.engaged.MaxDW.HighAcc.HeavyDef = set_combine(sets.engaged.MaxDW.MidAcc.HeavyDef, {
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.buff['Futae'] = {
    hands="Hattori Tekko +2",
    -- hands="Hattori Tekko +3",
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  if spell.skill == 'Ninjutsu' then
    do_ninja_tool_checks(spell, spellMap, eventArgs)
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
    if state.WeaponskillMode.value == 'Proc' and silibs.proc_ws_abyssea_red:contains(spell.english) then
      equip(sets.precast.WS['Proc'])
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  equip(select_weapons())
end

function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'ElementalNinjutsu' then
    -- Select set based on tier of nuke and whether MB mode is on or off
    if not state.MagicBurst.value then
      local casting_mode = state.CastingMode.value
      if sets.midcast.ElementalNinjutsu[casting_mode] then
        equip(sets.midcast.ElementalNinjutsu[casting_mode])
      else
        equip(sets.midcast.ElementalNinjutsu)
      end
    else
      local casting_mode = state.CastingMode.value
      if sets.midcast.ElementalNinjutsu[casting_mode] then
        if sets.midcast.ElementalNinjutsu[casting_mode].MB then
          equip(sets.midcast.ElementalNinjutsu[casting_mode].MB)
        else
          equip(sets.midcast.ElementalNinjutsu[casting_mode])
        end
      else
        if sets.midcast.ElementalNinjutsu.MB then
          equip(sets.midcast.ElementalNinjutsu.MB)
        else
          equip(sets.midcast.ElementalNinjutsu)
        end
      end
    end

    if state.Buff.Futae then
      equip(sets.buff['Futae'])
    end
  elseif spellMap == 'Utsusemi' then
    if buffactive['Yonin'] then
      equip(sets.midcast.Utsusemi.Yonin)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  equip(select_weapons())
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  if not spell.interrupted and spell.english == "Migawari: Ichi" then
    state.Buff.Migawari = true
  end
  
  equip(select_weapons())
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
  if buff == "Migawari" and not gain then
    add_to_chat(61, "*** MIGAWARI DOWN ***")
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
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
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 1 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
  else
    if silibs.get_dual_wield_needed() > 1 and silibs.get_dual_wield_needed() <= 15 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 15 and silibs.get_dual_wield_needed() <= 21 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 21 and silibs.get_dual_wield_needed() <= 25 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 25 and silibs.get_dual_wield_needed() <= 32 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 32 then
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      if world.time >= (17*60) or world.time <= (7*60) then
        idleSet = set_combine(idleSet, sets.Kiting.NightMovement)
      else
        idleSet = set_combine(idleSet, sets.Kiting.DayMovement)
      end
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

  idleSet = set_combine(idleSet, select_weapons())

  return idleSet
end

-- Modify the default melee set after it was constructed.
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

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  meleeSet = set_combine(meleeSet, select_weapons())

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

  defenseSet = set_combine(defenseSet, select_weapons())

  return defenseSet
end

-- Function to display the current relevant user state when doing an update.
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

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local toy_msg = state.ToyWeapons.current

    local msg = ''
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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
  if state.ToyWeapons.current ~= 'None' then
    weapons_to_equip = set_combine(sets.ToyWeapon[state.ToyWeapons.current], {})
  elseif sets.WeaponSet[state.WeaponSet.current] then
    weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current], {})
  end

  -- Equip appropriate ammo
  local range_weapon = weapons_to_equip.ranged or weapons_to_equip.range
  local range_weapon_name = type(range_weapon) == 'table' and range_weapon.name or range_weapon
  if range_weapon_name and silibs.is_weapon(range_weapon_name) then
    weapons_to_equip.ammo = 'empty'
  end

  return weapons_to_equip
end

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
  if cmdParams[1] == 'ninelemental' then
    local ninjutsu = nin_element_map[state.ElementalMode.current]

    local target = cmdParams[2] or 't'

    send_command('@input /ma "'..ninjutsu..': San" <'..target..'>')
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

-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
  local ninja_tool_name

  -- Only checks for universal tools and shihei
  if spell.skill == 'Ninjutsu' then
    if spellMap == 'Utsusemi' then
      ninja_tool_name = 'Shihei'
    elseif spellMap == 'ElementalNinjutsu' then
      ninja_tool_name = "Inoshishinofuda"
    elseif spellMap == 'EnfeeblingNinjutsu' then
      ninja_tool_name = 'Chonofuda'
    elseif spellMap == 'EnhancingNinjutsu' then
      ninja_tool_name = 'Shikanofuda'
    else
      return
    end
  end

  local available_ninja_tools = player.inventory[ninja_tool_name]

  -- If no tools are available, end.
  if not available_ninja_tools then
    if spell.skill == "Ninjutsu" then
      return
    end
  end

  -- Low ninja tools warning.
  if spell.skill == "Ninjutsu" and state.warned.value == false
      and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
    local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
    --local border = string.repeat("*", #msg)
    local border = ""
    for i = 1, #msg do
      border = border .. "*"
    end

    add_to_chat(104, border)
    add_to_chat(104, msg)
    add_to_chat(104, border)

    state.warned:set()
  elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
    state.warned:reset()
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
  set_macro_page(1, 13)
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
