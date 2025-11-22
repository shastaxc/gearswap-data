--[[
File Status: Good.
TODO: Missing acc sets.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: cancel
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Offense Mode: Changes melee accuracy level
* Hybrid Mode: Changes damage taken level while engaged
  * Normal: Highest damage output
  * HeavyDef: Defensive set with decent offensive stats
  * SubtleBlow: Uses Subtle Blow capped engaged set
* Idle Mode: Determines which set to use when not engaged
  * Normal: Allows automatically equipping Regen, Refresh, and Regain gear as needed
  * HeavyDef: Uses defensive set and disables automatically equipping Regen, Refresh, and Regain gear
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Enmity Mode: Swaps gear on WS to lower enmity
  * Normal: Does not swap any -enmity gear during WS
  * Low: If you have Dirge and -Enmity merits, a simple Novia Earring will cap your -Enmity
  * Schere: Uses Schere earring during WS to actively lower enmity (only if MP > 0)

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* All other sets (like precast, midcast, idle, etc.) should exclude weapons (main, sub, range).
* If you enable one of the ToyWeapons modes, it will lock your weapons into low level weapons. This can be
  useful if you are intentionally trying not to kill something, like low level enemies where you may need
  to proc them with a WS without killing them. This overrides all other weapon modes and weapon equip logic.
  * Memorize the keybind to turn it off in case you toggle it by accident.

Abilities
* The Samurai SP Meikyo Shisui has a quirk in that it does not allow you to gain any TP from your autoattacks when
  it is active, but it lasts a long time. After using all your TP, you are then stuck unable to weaponskill until you
  manually remove the buff or wait for it to time out. This lua has an automatic function that removes the buff from
  you automatically if you are under 1000 TP.

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
  [ F9 ]                Cycle Melee Accuracy
  [ CTRL+F9 ]           Cycle Melee Defense
  [ F10 ]               Toggle Emergency -PDT
  [ ALT+F10 ]           Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]               Toggle Emergency -MDT
  [ F12 ]               Report current status
  [ CTRL+F12 ]          Cycle Idle modes
  [ ALT+F12 ]           Cancel Emergency -PDT/-MDT Mode
  [ WIN+C ]             Toggle Capacity Points Mode
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
  [ ALT+Numpad0 ]       Utsusemi: Ichi
  [ ALT+Numpad. ]       Utsusemi: Ni

Abilities:
  [ ALT+Q ]             Meditate
  [ ALT+W ]             Hamanoha
  [ ALT+E ]             Hasso
  ============ /WAR ============
  [ CTRL+Numlock ]      Defender
  [ CTRL+Numpad/ ]      Berserk
  [ CTRL+Numpad* ]      Warcry
  [ CTRL+Numpad- ]      Aggressor
  ============ /DRG ============
  [ CTRL+Numlock ]      Ancient Circle
  [ CTRL+Numpad/ ]      Jump
  [ CTRL+Numpad* ]      High Jump
  [ CTRL+Numpad- ]      Super Jump

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

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] Konzen         /ja "Konzen-ittai" <t>
[ CTRL+2 ] Sengikor       /ja "Sengikori" <me>
[ CTRL+3 ] Sekkanok       /ja "Sekkanoki" <me>
[ CTRL+9 ] Meikyo         /ja "Meikyo Shisui" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Hagakure       /ja "Hagakure" <me>
[ ALT+2 ]  ThirdEye       /ja "Third Eye" <me>
[ ALT+3 ]  Seigan         /ja "Seigan" <me>
[ ALT+9 ]  Yaegasum       /ja "Yaegasumi" <me>

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
    send_command('gs c weaponset current')
  end, 4)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(12)
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
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['!q'] = 'input /ja "Meditate" <me>',
      ['!w'] = 'input /ja "Hamanoha" <me>',
      ['!e'] = 'input /ja "Hasso" <me>',
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

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  update_melee_groups()

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
    ammo="Perfect Lucky Egg", --1
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = {
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
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

  -- Enmity sets
  sets.Enmity = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Loess Barbuta +1",          -- 24 [10/10, ___]
    body="Emet Harness +1",           -- 10 [ 6/__,  64]
    hands="Kurys Gloves",             --  9 [ 2/ 2,  57]
    legs=gear.Nyame_B_legs,           -- __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150]
    neck="Unmoving Collar +1",        -- 10 [__/__, ___]
    ear1="Trux Earring",              --  5 [__/__, ___]
    ear2="Cryptic Earring",           --  4 [__/__, ___]
    ring1="Moonlight Ring",           -- __ [ 5/ 5, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Reiki Cloak",               --  6 [__/ 8, ___]
    waist="Platinum Moogle Belt",     -- __ [ 3/ 3,  15]
    -- 70 Enmity [51 PDT/53 MDT, 436 M.Eva]
  }

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Doji'] = {main="Dojikiri Yasutsuna", sub="Utu Grip"}
  sets.WeaponSet['Masa'] = {main="Masamune", sub="Utu Grip"}
  sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip"}


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head="Wakido Kabuto +3", -- 4
    -- head="Wakido Kabuto +4", -- 4
  }
  sets.latent_regen = {
    body="Sacro Breastplate", --10
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    -- hands="Rao Kote +1",
    -- legs="Rao Haidate +1",
    -- feet="Rao Sune-Ate +1",
    -- ring2="Chirich Ring +1",
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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Meikyo Shisui'] = {
    feet="Sakonji Sune-ate +1", -- Reduce WS cost to 750 TP; +1 is acceptable
    -- feet="Sakonji Sune-ate +4", -- Reduce WS cost to 750 TP; +1 is acceptable
  }

  sets.precast.JA['Warding Circle'] = {
    head="Wakido Kabuto +3", -- Duration +50%, potency +2%; +1 is acceptable
    -- head="Wakido Kabuto +4", -- Duration +50%, potency +2%; +1 is acceptable
  }

  sets.precast.JA['Third Eye'] = {
    legs="Sakonji Haidate +1", -- Increase counter rate under Seigan
    -- legs="Sakonji Haidate +4", -- Increase counter rate under Seigan
  }

  sets.precast.JA['Meditate'] = {
    head="Wakido Kabuto +3", -- Increase duration
    hands="Sakonji Kote +3", -- Increase duration
    back="Smertrios's Mantle", -- Increase duration
    
    -- head="Wakido Kabuto +4", -- Increase duration
    -- hands="Sakonji Kote +4", -- Increase duration
  }

  sets.precast.JA['Seigan'] = {
    head="Kasuga Kabuto +2", -- Add counter effect to Seigan
  }

  sets.precast.JA['Shikikoyo'] = {
    legs="Sakonji Haidate +1", -- Retain some TP based on merits
    -- legs="Sakonji Haidate +4", -- Retain some TP based on merits
  }

  sets.precast.JA['Blade Bash'] = {
    hands="Sakonji Kote +3", -- +1 is acceptable
    -- hands="Sakonji Kote +4", -- +1 is acceptable
  }

  sets.precast.JA['Sengikori'] = {
    feet="Kasuga Sune-ate +1", -- Increase duration based on merits
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
    ear1="Schere Earring", -- R20+
    ear2="Telos Earring",
    ring1="Ephramad's Ring",
    ring2="Chirich Ring +1",
    back=gear.stp_jse_back,
    waist="Olseni Belt",
  }
  sets.precast.Flourish1 = {
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    body="Sacro Breastplate", --10
    hands=gear.Leyline_Gloves, --8
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ring2="Prolix Ring", --2
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


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP Bonus
    ear2="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",            -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- 266 STR, 388 Att, 269 Acc, 71 WSD, 10 PDL <28 DA, 5 TA, 3 QA> [48 PDT/31 MDT, 620 M.Eva]
    
    -- hands="Kasuga Kote +3",        -- 24, 62, 62, 12, __ <__, __, __> [__/__,  82]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    ear1="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ear2="Kasuga Earring +1",         -- __, __, 15,  3, __ <__, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS.AttCapped = {
    ammo="Crepuscular Pebble",        --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Mpaca's Hose",              -- 49, 70, 55, __,  8 <__,  4, __> [ 9/__, 106]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP Bonus
    ear2="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",            -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- 270 STR, 390 Att, 304 Acc, 48 WSD, 31 PDL <27 DA, 9 TA, 3 QA> [52 PDT/26 MDT, 576 M.Eva]
    
    -- feet="Kasuga Sune-Ate +3",     -- 31, 70, 60, __, 10 <__, __, __> [__/__, 130]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
    -- 283 STR, 395 Att, 344 Acc, 39 WSD, 41 PDL <22 DA, 9 TA, 3 QA> [45 PDT/19 MDT, 556 M.Eva]
  }
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    head=gear.Nyame_B_head,
    ear1="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ear2="Kasuga Earring +1",         -- __, __, 15,  3, __ <__, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
  })

  -- 85% STR; 2 hit, dmg varies with TP
  sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Shoha'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Shoha'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Shoha'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 50% STR; 3 hit, acc varies with TP
  sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Tachi: Rana'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Tachi: Rana'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Tachi: Rana'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 80% STR; 1 hit, dmg varies with TP
  sets.precast.WS['Tachi: Fudo'] = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP Bonus
    ear2="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- 266 STR, 408 Att, 289 Acc, 71 WSD, 20 PDL <33 DA, 5 TA, 0 QA> [48 PDT/31 MDT, 620 M.Eva]
    
    -- body="Sakonji Domaru +4",      -- 47, 90, 52, 12, __ <__, __, __> [__/__, 113]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
    -- 273 STR, 433 Att, 321 Acc, 72 WSD, 20 PDL <26 DA, 5 TA, 0 QA> [39 PDT/22 MDT, 594 M.Eva]
  }
  sets.precast.WS['Tachi: Fudo'].MaxTP = set_combine(sets.precast.WS['Tachi: Fudo'], {
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    ear1="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ear2="Kasuga Earring +1",         -- __, __, 15,  3, __ <__, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Tachi: Fudo'].AttCapped = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP Bonus
    ear2="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- 266 STR, 408 Att, 289 Acc, 71 WSD, 20 PDL <33 DA, 5 TA, 0 QA> [48 PDT/31 MDT, 620 M.Eva]
    
    -- feet="Kasuga Sune-Ate +3",     -- 31, 70, 60, __, 10 <__, __, __> [__/__, 130]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
    -- 279 STR, 413 Att, 329 Acc, 62 WSD, 30 PDL <28 DA, 5 TA, 0 QA> [41 PDT/24 MDT, 600 M.Eva]
  }
  sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].AttCapped, {
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    ear1="Thrud Earring",             -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    ear2="Kasuga Earring +1",         -- __, __, 15,  3, __ <__, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ <__, __, __> [__/__, ___]
  })

  -- 75% STR; 1 hit, dmg varies with TP
  sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS['Tachi: Fudo'], {})
  sets.precast.WS['Tachi: Gekko'].MaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].MaxTP, {})
  sets.precast.WS['Tachi: Gekko'].AttCapped = set_combine(sets.precast.WS['Tachi: Fudo'].AttCapped, {})
  sets.precast.WS['Tachi: Gekko'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP, {})

  -- 75% STR; 1 hit, dmg varies with TP
  sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS['Tachi: Fudo'], {})
  sets.precast.WS['Tachi: Yukikaze'].MaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].MaxTP, {})
  sets.precast.WS['Tachi: Yukikaze'].AttCapped = set_combine(sets.precast.WS['Tachi: Fudo'].AttCapped, {})
  sets.precast.WS['Tachi: Yukikaze'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP, {})

  -- 75% STR; 1 hit, dmg varies with TP
  sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS['Tachi: Fudo'], {})
  sets.precast.WS['Tachi: Kasha'].MaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].MaxTP, {})
  sets.precast.WS['Tachi: Kasha'].AttCapped = set_combine(sets.precast.WS['Tachi: Fudo'].AttCapped, {})
  sets.precast.WS['Tachi: Kasha'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP, {})

  -- 80% STR; 1 hit, STP scales with TP (aftermath effect)
  sets.precast.WS['Tachi: Kaiten'] = set_combine(sets.precast.WS['Tachi: Fudo'].MaxTP, {})
  sets.precast.WS['Tachi: Kaiten'].MaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].MaxTP, {})
  sets.precast.WS['Tachi: Kaiten'].AttCapped = set_combine(sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP, {})
  sets.precast.WS['Tachi: Kaiten'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Fudo'].AttCappedMaxTP, {})

  -- 30% STR; 2 hit, hybrid wind elemental, dmg varies with TP
  sets.precast.WS['Tachi: Jinpu'] = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ {__, __, __, __} <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ {__, 30, __, 40} < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ {__, 30, __, 40} < 6, __, __> [ 8/ 8, 150]
    feet="Mpaca's Boots",             -- 28, 70, 55, __, __ {__, 45, __, 55} <__,  3, __> [ 6/__,  96]
    neck="Fotia Gorget",              -- __, __, 10, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",         -- __, __,  4, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; TP Bonus+
    ear2="Schere Earring",            --  5, 15, 15, __, __ {__, __, __, __} < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ {__, __, __, __} <__, __,  3> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __, __, __ {__, __, __, __} < 3,  3, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ {__, __, __, __} <__, __, __> [10/__, ___]
    waist="Orpheus's Sash",           -- __, __, __, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; Magic dmg+15%
    -- 219 STR, 388 Att, 274 Acc, 63 WSD, 0 PDL {0 Wind MAB, 165 MAB, 0 M.Dmg, 215 M.Acc} <32 DA, 6 TA, 3 QA> [47 PDT/31 MDT, 620 M.Eva]
  }
  sets.precast.WS['Tachi: Jinpu'].MaxTP = set_combine(sets.precast.WS['Tachi: Jinpu'], {
    ear1="Friomisi Earring",          -- __, __, __, __, __ {__, 10, __, __} <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Tachi: Jinpu'].AttCapped = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ {__, __, __, __} <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ {__, 30, __, 40} < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ {__, 30, __, 40} < 6, __, __> [ 8/ 8, 150]
    feet="Mpaca's Boots",             -- 28, 70, 55, __, __ {__, 45, __, 55} <__,  3, __> [ 6/__,  96]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 {__, __, __, __} <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; TP Bonus+
    ear2="Schere Earring",            --  5, 15, 15, __, __ {__, __, __, __} < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ {__, __, __, __} <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 {__, __, __, __} <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ {__, __, __, __} <__, __, __> [10/__, ___]
    waist="Orpheus's Sash",           -- __, __, __, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; Magic dmg+15%
    -- 254 STR, 408 Att, 314 Acc, 63 WSD, 20 PDL {0 Wind MAB, 165 MAB, 0 M.Dmg, 215 M.Acc} <29 DA, 3 TA, 3 QA> [47 PDT/31 MDT, 620 M.Eva]
  }
  sets.precast.WS['Tachi: Jinpu'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Jinpu'].MaxTP, {
    ear1="Friomisi Earring",          -- __, __, __, __, __ {__, 10, __, __} <__, __, __> [__/__, ___]
  })

  -- 75% STR; 1 hit, hybrid fire elemental, dmg varies with TP
  sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ {__, __, __, __} <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ {__, 30, __, 40} < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ {__, 30, __, 40} < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",              -- __, __, 10, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",         -- __, __,  4, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; TP Bonus+
    ear2="Schere Earring",            --  5, 15, 15, __, __ {__, __, __, __} < 6, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 {__, __, __, __} <__, __, __> [__/__, ___]
    ring2="Regal Ring",               -- 10, 20, 20, __, __ {__, __, __, __} <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ {__, __, __, __} <__, __, __> [10/__, ___]
    waist="Orpheus's Sash",           -- __, __, __, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; Magic dmg+15%
    -- 224 STR, 423 Att, 299 Acc, 74 WSD, 10 PDL {0 Fire MAB, 150 MAB, 0 M.Dmg, 200 M.Acc} <34 DA, 0 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]
  })
  sets.precast.WS['Tachi: Kagero'].MaxTP = set_combine(sets.precast.WS['Tachi: Kagero'], {
    ear1="Friomisi Earring",          -- __, __, __, __, __ {__, 10, __, __} <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Tachi: Kagero'].AttCapped = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ {__, __, __, __} <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 65, 50, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ {__, 30, __, 40} < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ {__, 30, __, 40} < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 40, 11, __ {__, 30, __, 40} < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 {__, __, __, __} <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; TP Bonus+
    ear2="Thrud Earring",             -- 10, __, __,  3, __ {__, __, __, __} <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 {__, __, __, __} <__, __, __> [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __,  5, __ {__, __, __, __} <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ {__, __, __, __} <__, __, __> [10/__, ___]
    waist="Orpheus's Sash",           -- __, __, __, __, __ {__, __, __, __} <__, __, __> [__/__, ___]; Magic dmg+15%
    -- 244 STR, 388 Att, 284 Acc, 82 WSD, 20 PDL {0 Fire MAB, 150 MAB, 0 M.Dmg, 200 M.Acc} <28 DA, 0 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ {__, __, __, __} <__, __, __> [__/__, ___]
  }
  sets.precast.WS['Tachi: Kagero'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Kagero'].AttCapped, {
    ear1="Friomisi Earring",          -- __, __, __, __, __ {__, 10, __, __} <__, __, __> [__/__, ___]
  })

  -- 50% STR/30% MND; 1 hit, hybrid light elemental, dmg varies with TP
  sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS['Tachi: Kagero'], {
    ring2="Weatherspoon Ring",
  })
  sets.precast.WS['Tachi: Koki'].MaxTP = set_combine(sets.precast.WS['Tachi: Kagero'].MaxTP, {
    ring2="Weatherspoon Ring",
  })
  sets.precast.WS['Tachi: Koki'].AttCapped = set_combine(sets.precast.WS['Tachi: Kagero'].AttCapped, {
    ring2="Weatherspoon Ring",
  })
  sets.precast.WS['Tachi: Koki'].AttCappedMaxTP = set_combine(sets.precast.WS['Tachi: Kagero'].AttCappedMaxTP, {
    ring2="Weatherspoon Ring",
  })

  -- 60% CHR / 40% STR; Stack acc and magic acc to ensure the defense down effect lands
  sets.precast.WS['Tachi: Ageha'] = {
    ammo="Pemphredo Tathlum",         -- __, __, __, __, __, __ { 8} [__/__, ___]
    head="Mpaca's Cap",               -- 20, 33, 70, 55, __, __ {55} [ 7/__,  69]; TP Bonus
    body="Mpaca's Doublet",           -- 28, 39, 70, 55, __, __ {55} [10/__,  86]
    hands="Mpaca's Gloves",           -- 25, 20, 70, 55, __, __ {55} [ 8/__,  59]
    legs="Mpaca's Hose",              -- 19, 49, 70, 55, __,  8 {55} [ 9/__, 106]
    feet="Mpaca's Boots",             -- 28, 28, 70, 55, __, __ {55} [ 6/__,  96]
    neck="Null Loop",                 -- __, __, __, 50, __, __ {50} [ 5/ 5, ___]
    ear1="Moonshade Earring",         -- __, __, __,  4, __, __ {__} [__/__, ___]; TP Bonus
    ear2="Kasuga Earring +1",         -- __, __, __, 15,  3, __ {15} [__/__, ___]
    ring1="Metamorph Ring +1",        -- 16, __, __, __, __, __ {15} [__/__, ___]
    ring2="Stikini Ring +1",          -- __, __, __, __, __, __ {11} [__/__, ___]
    back="Null Shawl",                -- __, __, __, 50, __, __ {50} [__/__,  50]
    waist="Null Belt",                -- __, __, __, 30, __, __ {30} [__/__,  30]
    -- 136 CHR, 169 STR, 350 Att, 424 Acc, 3 WSD, 8 PDL {454 M.Acc} [45 PDT/5 MDT, 496 M.Eva]

    -- hands="Kasuga Kote +3",        -- 31, 24, 62, 62, 12, __ {62} [__/__,  82]
    -- legs="Kasuga Haidate +3",      -- 25, 53, 63, 63, __, __ {63} [11/11, 130]
    -- feet="Kasuga Sune-Ate +3",     -- 34, 31, 70, 60, __, 10 {60} [__/__, 130]
    -- ear2="Kasuga Earring +2",      -- __, 15, __, 20,  5, __ {20} [__/__, ___]
    -- 154 CHR, 195 STR, 335 Att, 449 Acc, 17 WSD, 10 PDL {479 M.Acc} [33 PDT/16 MDT, 577 M.Eva]
  }

  -- Polearm sets use a crit build since you should be using Shining One
  -- 100% STR; 2 hit, dmg varies with TP
  sets.precast.WS['Impulse Drive'] = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ (__, __) <__, __, __> [__/__, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ ( 4, __) < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 (__, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus
    ear2="Schere Earring",            --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    ring2="Begrudging Ring",          -- __,  7,  7, __, __ ( 5, __) <__, __, __> [-10/-10, _]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- 261 STR, 410 Att, 304 Acc, 63 WSD, 10 PDL (9 Crit Rate, 0 Crit Dmg) <39 DA, 5 TA, 3 QA> [38 PDT/21 MDT, 620 M.Eva]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
    -- back=gear.SAM_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 271 STR, 395 Att, 309 Acc, 58 WSD, 10 PDL (19 Crit Rate, 0 Crit Dmg) <33 DA, 5 TA, 3 QA> [38 PDT/21 MDT, 620 M.Eva]
  }
  sets.precast.WS['Impulse Drive'].MaxTP = set_combine(sets.precast.WS['Impulse Drive'], {
    ear1="Thrud Earring",             -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    
    -- ear1="Schere Earring",         --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Impulse Drive'].AttCapped = {
    ammo="Knobkierrie",               -- __, 23, __,  6, __ (__, __) <__, __, __> [__/__, ___]
    head="Mpaca's Cap",               -- 33, 70, 55, __, __ ( 4, __) < 5,  3, __> [ 7/__,  69]; TP Bonus
    body=gear.Nyame_B_body,           -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Mpaca's Hose",              -- 49, 70, 55, __,  8 ( 6, __) <__,  4, __> [ 9/__, 106]
    feet=gear.Nyame_B_feet,           -- 23, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, 30, __, 10 (__, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus
    ear2="Schere Earring",            --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    back=gear.SAM_STR_WSD_Cape,       -- 30, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- 262 STR, 428 Att, 332 Acc, 51 WSD, 28 PDL (10 Crit Rate, 0 Crit Dmg) <33 DA, 9 TA, 3 QA> [49 PDT/23 MDT, 576 M.Eva]

    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
    -- back=gear.SAM_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 272 STR, 413 Att, 337 Acc, 46 WSD, 28 PDL (20 Crit Rate, 0 Crit Dmg) <27 DA, 9 TA, 3 QA> [49 PDT/23 MDT, 576 M.Eva]
  }
  sets.precast.WS['Impulse Drive'].AttCappedMaxTP = set_combine(sets.precast.WS['Impulse Drive'].AttCapped, {
    ear1="Thrud Earring",             -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    
    -- ear1="Schere Earring",         --  5, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    -- ear2="Kasuga Earring +2",      -- 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
  })

  -- 85% STR; 4 hit, dmg varies with TP
  sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS['Impulse Drive'], {})
  sets.precast.WS['Stardiver'].MaxTP = set_combine(sets.precast.WS['Impulse Drive'].MaxTP, {})
  sets.precast.WS['Stardiver'].AttCapped = set_combine(sets.precast.WS['Impulse Drive'].AttCapped, {})
  sets.precast.WS['Stardiver'].AttCappedMaxTP = set_combine(sets.precast.WS['Impulse Drive'].AttCappedMaxTP, {})

  -- 40% STR / 40% DEX; 1 hit, aoe, dmg varies with TP
  sets.precast.WS['Sonic Thrust'] = {
    ammo="Knobkierrie",               -- __, __, 23, __,  6, __ (__, __) <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 25, 65, 50, 11, __ (__, __) < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 24, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 42, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, __, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 26, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, __, 30, __, 10 (__, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus
    ear2="Schere Earring",            --  5, __, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Begrudging Ring",          -- __, __,  7,  7, __, __ ( 5, __) <__, __, __> [-10/-10, _]
    back=gear.SAM_STR_WSD_Cape,       -- 30, __, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, __, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- 254 STR, 127 DEX, 425 Att, 279 Acc, 74 WSD, 20 PDL (5 Crit Rate, 0 Crit Dmg) <39 DA, 2 TA, 0 QA> [38 PDT/28 MDT, 674 M.Eva]

    -- body="Sakonji Domaru +4",      -- 47, 37, 90, 52, 12, __ (__, __) <__, __, __> [__/__, 113]
    -- hands="Kasuga Kote +3",        -- 24, 47, 62, 62, 12, __ (__, __) <__, __, __> [__/__,  82]
    -- ear2="Kasuga Earring +2",      -- 15, 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
    -- back=gear.SAM_Crit_Cape,       -- 30, __, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 273 STR, 160 DEX, 432 Att, 358 Acc, 69 WSD, 20 PDL (15 Crit Rate, 0 Crit Dmg) <21 DA, 2 TA, 0 QA> [22 PDT/18 MDT, 618 M.Eva]
  }
  sets.precast.WS['Sonic Thrust'].MaxTP = set_combine(sets.precast.WS['Sonic Thrust'], {
    ear1="Schere Earring",            --  5, __, 15, 15, __, __ (__, __) < 6, __, __> [__/__, ___]
    ear2="Lugra Earring +1",          -- 16, 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Sonic Thrust'].AttCapped = {
    ammo="Knobkierrie",               -- __, __, 23, __,  6, __ (__, __) <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 25, 65, 50, 11, __ (__, __) < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 24, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 42, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Mpaca's Hose",              -- 49, __, 70, 55, __,  8 ( 6, __) <__,  4, __> [ 9/__, 106]
    feet=gear.Nyame_B_feet,           -- 23, 26, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Samurai's Nodowa +2",       -- 25, __, __, 30, __, 10 (__, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",         -- __, __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus
    ear2="Lugra Earring +1",          -- 16, 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Begrudging Ring",          -- __, __,  7,  7, __, __ ( 5, __) <__, __, __> [-10/-10, _]
    back=gear.SAM_STR_WSD_Cape,       -- 30, __, 20, 20, 10, __ (__, __) <__, __, __> [10/__, ___]
    waist="Kentarch Belt +1",         -- 10, 10, __, 14, __, __ (__, __) < 3, __, __> [__/__, ___]
    -- 251 STR, 153 DEX, 335 Att, 333 Acc, 62 WSD, 28 PDL (11 Crit Rate, 0 Crit Dmg) <28 DA, 4 TA, 0 QA> [39 PDT/20 MDT, 630 M.Eva]

    -- hands="Kasuga Kote +3",        -- 24, 47, 62, 62, 12, __ (__, __) <__, __, __> [__/__,  82]
    -- feet="Kasuga Sune-Ate +3",     -- 31, 34, 70, 60, __, 10 (__, __) <__, __, __> [__/__, 130]
    -- ear2="Kasuga Earring +2",      -- 15, 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
    -- back=gear.SAM_Crit_Cape,       -- 30, __, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 265 STR, 165 DEX, 402 Att, 382 Acc, 47 WSD, 38 PDL (21 Crit Rate, 0 Crit Dmg) <15 DA, 4 TA, 0 QA> [25 PDT/6 MDT, 580 M.Eva]
  }
  sets.precast.WS['Sonic Thrust'].AttCappedMaxTP = set_combine(sets.precast.WS['Sonic Thrust'].AttCapped, {
    ear1="Lugra Earring +1",          -- 16, 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    ear2="Thrud Earring",             -- 10, __, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]

    -- ear2="Kasuga Earring +2",      -- 15, 15, __, 20,  5, __ (__, __) <__, __, __> [__/__, ___]
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
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
  --    Hybrid Engaged
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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { head="Frenzy Sallet", }
  sets.LowEnmity = { ear2="Novia Earring", } -- Assumes -Enmity merits and Dirge
  sets.Schere = { ear2="Schere Earring", }

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.buff['Sekkanoki'] = {
    hands="Kasuga Kote +1",
  }

  sets.FallbackShield = {sub="Regis"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    -- Don't gearswap for weaponskills when Defense is on.
    if state.DefenseMode.current ~= 'None' then
      eventArgs.handled = true
    elseif buffactive['Sekkanoki'] and player.tp > 2000 then
      equip(sets.buff['Sekkanoki'])
    end
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end

    if state.EnmityMode.current == 'Low' then
      equip(sets.LowEnmity)
    elseif state.EnmityMode.current == 'Schere' and player.mp > 0 then
      equip(sets.Schere)
    end
  end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

function job_post_midcast(spell, action, spellMap, eventArgs)end

function job_aftercast(spell, action, spellMap, eventArgs)
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
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

function check_sp_tp_status()
  if buffactive['Meikyo Shisui'] and player.tp < 1000 then
    send_command('cancel Meikyo Shisui')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  update_idle_groups()
  update_melee_groups()
  check_sp_tp_status()
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

  return weapons_to_equip
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
    equip(sets.LowEnmity)
  end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.SleepyHead)
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

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
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
  if cmdParams[1] == 'equipweapons' then
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(1, 12)
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
