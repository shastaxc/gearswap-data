--[[
File Status: Good.
TODO: Fill in dual wield sets.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: HasteInfo
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable GearInfo, disable RollTracker

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
* High Enmity Mode: When on, equips high enmity variant gear sets for certain actions.

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* All other sets (like precast, midcast, idle, etc.) should exclude weapons (main, sub, range).
* If you enable one of the ToyWeapons modes, it will lock your weapons into low level weapons. This can be
  useful if you are intentionally trying not to kill something, like low level enemies where you may need
  to proc them with a WS without killing them. This overrides all other weapon modes and weapon equip logic.
  * Memorize the keybind to turn it off in case you toggle it by accident.
* The "DW" variants of sets will be used automatically if the Dual Wield trait is available.

Abilities
* Souleater and Last Resort make you take more damage. To allow quickly cancelling these buffs, there's a custom
  gs command to remove the buffs quickly: gs c clear_risky_buffs

Spells
* Aspir and Drain have a degrade array capability which means if you try to cast Drain III and it's on cooldown or
  you don't have enough MP, it will then check if it can do Drain II, and then Drain.

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
* DRK can actually get so much PDL that under Aria of Passion, they can hit the 100% cap. To avoid wasting stats,
  WS sets have variants that allow you to tailor the PDL amount in your gear and fit in extra useful stats such
  as WSD instead.


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
  [ ALT+F8 ]            Toggle High Enmity mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set
  [ CTRL+PageUp ]       Cycle Toy Weapon Sets
  [ CTRL+PageDown ]     Cycleback Toy Weapon Sets
  [ ALT+PageDown ]      Reset to default Toy Weapon Set

Spells:
  [ ALT+` ]             Endark II
  [ ALT+E ]             Drain III
  [ ALT+R ]             Aspir II
  ============ /NIN ============
  [ ALT+Numpad0 ]       Utsusemi: Ichi
  [ ALT+Numpad. ]       Utsusemi: Ni

Abilities:
  [ ALT+Q ]             Nether Void
  [ CTRL+Q ]            Weapon Bash
  [ ALT+W ]             Dark Seal
  [ ALT+Z ]             Arcane Circle
  [ ALT+X ]             Arcane Crest
  ============ /WAR ============
  [ CTRL+Numlock ]      Defender
  [ CTRL+Numpad/ ]      Berserk
  [ CTRL+Numpad* ]      Warcry
  [ CTRL+Numpad- ]      Aggressor
  ============ /SAM ============
  [ CTRL+Numlock ]      Third Eye
  [ CTRL+Numpad/ ]      Meditate
  [ CTRL+Numpad* ]      Sekkanoki
  [ CTRL+Numpad- ]      Hasso
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

gs c clear_risky_buffs  Removes Souleater and Last Resort buffs from self.

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] LastReso       /ja "Last Resort" <me>
[ CTRL+2 ] Souleate       /ja "Souleater" <me>
[ CTRL+3 ] Drain2         /ma "Drain II" <t>
[ CTRL+4 ] Bio            /ma "Bio II" <t>
[ CTRL+8 ] Scarlet        /ja "Scarlet Delirium" <me>
[ CTRL+9 ] BloodWea       /ja "Blood Weapon" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Ab-STR         /ma "Absorb-STR" <stnpc>
[ ALT+2 ]  Ab-VIT         /ma "Absorb-VIT" <stnpc>
[ ALT+3 ]  Ab-INT         /ma "Absorb-INT" <stnpc>
[ ALT+4 ]  Ab-TP          /ma "Absorb-TP" <t>
[ ALT+8 ]  Dread          /ma "Dread Spikes" <me>
[ ALT+9 ]  SoulEnsl       /ja "Soul Enslavement" <me>
[ ALT+0 ]  NoBuffs        /console gs c clear_risky_buffs

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
  silibs.enable_auto_lockstyle(8)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)
  silibs.enable_auto_reraise({
    set = {head="Crepuscular Helm", body="Crepuscular Mail"},
    mode = 'off',
    hpp = 10,
  })

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(true, 'Attack Capped')

  state.CP = M(false, 'Capacity Points Mode')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger','Sword','Club','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Caladbolg', 'Anguta', 'Lycurgos', 'Naegling', 'Club', 'DaggerAcc', 'Dagger'}
  -- state.WeaponSet = M{['description']='Weapon Set', 'Anguta', 'Foenaria', 'Apocalypse', 'Caladbolg', 'Naegling', 'Club', 'Dagger'}
  state.HighEnmityMode = M(false, 'High Enmity Mode')

  skill_ids_2h = S{4, 6, 7, 8, 10, 12} -- DO NOT MODIFY
  fencer_tp_bonus = {200, 300, 400, 450, 500, 550, 600, 630} -- DO NOT MODIFY
  activate_AM_mode = {
    ['Liberator'] = S{'Aftermath: Lv.3'},
    ['Apocalypse'] = S{'Aftermath: Lv.1', 'Aftermath: Lv.2', 'Aftermath: Lv.3'},
    ['Foenaria'] = S{'Aftermath: Lv.1', 'Aftermath: Lv.2', 'Aftermath: Lv.3'},
  }
  degrade_array = {
    ['Aspir'] = {'Aspir','Aspir II'},
    ['Drain'] = {'Drain', 'Drain II', 'Drain III'}
  }

  spell_maps['Absorb-STR'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-DEX'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-VIT'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-AGI'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-INT'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-MND'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-CHR'] = 'Absorb' -- DO NOT MODIFY
  spell_maps['Absorb-ACC'] = 'Absorb' -- DO NOT MODIFY

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['!f8'] = 'gs c toggle HighEnmityMode',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^q'] = 'input /ja "Weapon Bash" <stnpc>',
      ['!q'] = 'input /ja "Nether Void" <me>',
      ['!w'] = 'input /ja "Dark Seal" <me>',
      ['!z'] = 'input /ja "Arcane Circle" <me>',
      ['!x'] = 'input /ja "Arcane Crest" <t>',
      ['!`'] = 'Endark II',
      ['!e'] = 'input /ja "Drain III" <t>',
      ['!r'] = 'input /ja "Aspir II" <t>',
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
    sets.org.job[1] = {ammo="Crepuscular Helm"}
    sets.org.job[2] = {ammo="Crepuscular Mail"}
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

  -- Enmity sets
  sets.Enmity = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Loess Barbuta +1",          -- 24 [10/10, ___]
    body="Emet Harness +1",           -- 10 [ 6/__,  64]
    hands="Sakpata's Gauntlets",      -- __ [ 8/ 8, 112]
    legs="Sakpata's Cuisses",         -- __ [ 9/ 9, 150]
    feet="Sakpata's Leggings",        -- __ [ 6/ 6, 150]
    neck="Unmoving Collar +1",        -- 10 [__/__, ___]
    ear1="Trux Earring",              --  5 [__/__, ___]
    ear2="Cryptic Earring",           --  4 [__/__, ___]
    ring1="Moonlight Ring",           -- __ [ 5/ 5, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Reiki Cloak",               --  6 [__/ 8, ___]
    waist="Platinum Moogle Belt",     -- __ [ 3/ 3,  15]
    -- 61 Enmity [57 PDT/59 MDT, 491 M.Eva]

    -- body="Obviation Cuirass +1",   -- 13 [ 8/__, 129]
    -- hands=gear.Yorium_Enmity_hands,-- 14 [ 5/ 3,  56]
    -- feet=gear.Eschite_A_feet,      -- 15 [ 4/ 3,  64]
    -- 93 Enmity [54 PDT/51 MDT, 414 M.Eva]
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Sangarius +1",
  }
  sets.WeaponSet['Anguta'] = {
    main="Anguta",
    sub="Utu Grip",
  }
  sets.WeaponSet['Apocalypse'] = {
    -- main="Apocalypse",
    sub="Utu Grip",
  }
  sets.WeaponSet['Caladbolg'] = {
    main="Caladbolg",
    sub="Utu Grip",
  }
  sets.WeaponSet['Lycurgos'] = {
    main="Lycurgos",
    sub="Utu Grip",
  }
  sets.WeaponSet['Club'] = {
    main="Loxotic Mace +1",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Club'].DW = {
    main="Loxotic Mace +1",
    sub="Sangarius +1",
  }
  sets.WeaponSet['Dagger'] = {
    main=gear.Malevolence_1,
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Dagger'].DW = {
    main=gear.Malevolence_1,
    sub=gear.Malevolence_2,
  }
  sets.WeaponSet['DaggerAcc'] = {
    main=gear.Malevolence_1,
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['DaggerAcc'].DW = {
    main=gear.Malevolence_1,
    sub="Naegling",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",                -- __ [ 3/ 3, ___]
    head={name="Ratri Sallet +1",priority=1}, -- __ [-8/-8, 101]; Used for HP balance
    body="Sakpata's Breastplate",             -- 10 [10/10, 139]; Resist status+15
    hands="Heathen's Gauntlets +3",           --  5 [10/10,  82]
    legs="Heathen's Flanchards +3",           --  8 [12/12, 119]; Realistically this will be move speed
    feet="Sakpata's Leggings",                --  7 [ 6/ 6, 150]
    neck="Loricate Torque +1",                -- __ [ 6/ 6, ___]
    ear1="Hearty Earring",                    -- __ [__/__, ___]; Resists
    ear2="Arete Del Luna +1",                 -- __ [__/__, ___]; Resists
    ring1="Moonlight Ring",                   -- __ [ 5/ 5, ___]
    ring2="Defending Ring",                   -- __ [10/10, ___]
    back=gear.DRK_FC_Cape,                    -- __ [10/__, ___]
    waist="Null Belt",                        --  3 [__/__,  30]
    -- 33 M.Def [64 PDT/54 MDT, 621 M.Eva]
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head={name="Ratri Sallet +1", priority=1}, -- 5
  }
  sets.latent_regen = {
    body="Sacro Breastplate", -- 13
    ear1="Infused Earring",   --  1
    waist="Null Belt",        --  3
  }
  sets.latent_refresh = {
    neck="Sibyl Scarf", -- Must be Windurstian
    ring1="Stikini Ring +1"
  }

  sets.idle = set_combine(sets.defense.PDT, {})

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = set_combine(sets.defense.PDT, {})

  sets.idle.Weak = set_combine(sets.defense.PDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Blood Weapon'] = {
    body="Fallen's Cuirass +3", -- Duration +10s; +1 is acceptable
    -- body="Fallen's Cuirass +4", -- Duration +10s; +1 is acceptable
  }
  sets.precast.JA['Arcane Circle'] = {
    feet="Ignominy Sollerets +1", -- Duration +50%, potency +2%; +1 is acceptable
    -- feet="Ignominy Sollerets +4", -- Duration +50%, potency +2%; +1 is acceptable
  }
  sets.precast.JA['Last Resort'] = {
    back=gear.DRK_FC_Cape,
  }
  sets.precast.JA['Weapon Bash'] = {
    hands="Ignominy Gauntlets +2", -- Increase damage, add Chainbound effect
    -- hands="Ignominy Gauntlets +4", -- Increase damage, add Chainbound effect
  }
  sets.precast.JA['Weapon Bash'].Enmity = set_combine(sets.Enmity, {
    hands="Ignominy Gauntlets +2", -- Increase damage, add Chainbound effect
    -- hands="Ignominy Gauntlets +4", -- Increase damage, add Chainbound effect
  })
  sets.precast.JA['Souleater'] = {
    head="Ignominy Burgeonet +1", -- Increase HP consumption and attack boost
    -- head="Ignominy Burgeonet +4", -- Increase HP consumption and attack boost
  }
  sets.precast.JA['Diabolic Eye'] = {
    hands="Fallen's Finger Gauntlets +3", -- Increase duration based on merits; +1 is acceptable
    -- hands="Fallen's Finger Gauntlets +4", -- Increase duration based on merits; +1 is acceptable
  }
  sets.precast.JA['Nether Void'] = {
    legs="Heathen's Flanchards +3", -- Increase potency
  }
  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    ammo="Sapience Orb",                            --  2 [__/__, ___]
    head=gear.Carmine_D_head,                       -- 14 [__/__,  53]
    body={name="Sacro Breastplate",priority=1},     -- 10 [__/__, 129]
    hands=gear.Leyline_Gloves,                      --  8 [__/__,  62]
    legs=gear.Odyssean_FC_legs,                     --  6 [__/__,  86]
    feet=gear.Odyssean_FC_feet,                     -- 11 [__/__,  86]
    neck="Orunmila's Torque",                       --  5 [__/__, ___]
    ear1="Malignance Earring",                      --  4 [__/__, ___]
    ear2="Loquacious Earring",                      --  2 [__/__, ___]
    ring1="Kishar Ring",                            --  4 [__/__, ___]
    ring2={name="Moonlight Ring",priority=1},       -- __ [ 5/ 5, ___]; Helps HP balance for Drain
    back={name=gear.DRK_FC_Cape.name,
             augments=gear.DRK_FC_Cape.augments,
             priority=1},                           -- 10 [10/__, ___]
    waist={name="Platinum Moogle Belt",priority=1}, -- __ [ 3/ 3,  15]; Helps HP balance for Drain
    -- 78 FC [13 PDT/3 MDT, 431 M.Eva]

    -- legs="Enif Cosciales",                       --  8 [__/__, ___]
    -- 80 FC [13 PDT/3 MDT, 345 M.Eva]
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    ring2="Defending Ring",
  })
  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ring1="Weatherspoon Ring", --5
  })
  sets.precast.FC.Impact = set_combine(sets.precast.FC,{
    -- head="empty",
    -- body="Crepuscular Cloak",
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 12,  2,  8 [__/__, ___]
    ring1="Epaminondas's Ring",           -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRK_STR_WSD_Cape,           -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                   8, 50
    -- 259 STR, 161 MND, 455 Attack, 301 Accuracy, 90 WSD, 78 PDL [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 269 STR, 161 MND, 455 Attack, 297 Accuracy, 93 WSD, 78 PDL [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 42, 27, 61, 61, __, 10 [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 12,  2,  8 [__/__, ___]
    ring1="Epaminondas's Ring",           -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRK_STR_WSD_Cape,           -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                   8, 50
    -- 275 STR, 162 MND, 451 Attack, 312 Accuracy, 79 WSD, 88 PDL [34 PDT/24 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 285 STR, 162 MND, 451 Attack, 308 Accuracy, 82 WSD, 88 PDL [34 PDT/24 MDT, 607 M.Eva]
  })

  -- 50% MND / 30% STR. Dark elemental. Absorbs HP. dStat = INT
  sets.precast.WS['Sanguine Blade'] = {
    ammo="Seething Bomblet +1",       -- __, 15, __, __ {__,  7, __, __} [__/__, ___]
    head="Pixie Hairpin +1",          -- __, __, 27, __ {28, __, __, __} [__/__, ___]
    body=gear.Nyame_B_body,           -- 37, 45, 42, 13 {__, 30, __, 40} [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 40, 17, 28, 11 {__, 30, __, 40} [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 32, 58, 44, 12 {__, 30, __, 40} [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 26, 33, 22, 12 {__, 50, __, 60} [__/__, 119]
    neck="Baetyl Pendant",            -- __, __, __, __ {__, 13, __, __} [__/__, ___]
    ear1="Malignance Earring",        --  8, __,  8, __ {__,  8, __, 10} [__/__, ___]
    ear2="Friomisi Earring",          -- __, __, __, __ {__, 10, __, __} [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __,  5 {__, __, __, __} [__/__, ___]
    ring2="Archon Ring",              -- __, __, __, __ { 5, __, __,  5} [__/__, ___]
    back=gear.DRK_MAB_Cape,           -- __, __, 30, __ {__, 10, 20, 20} [10/__, ___]
    waist="Eschan Stone",             -- __, __, __, __ {__,  7, __,  7} [__/__, ___]
    -- DRK traits/gifts/etc                           8
    -- 143 MND, 168 STR, 201 INT, 61 WSD {33 Dark MAB, 195 MAB, 20 M.Dmg, 222 M.Acc} [34 PDT/24 MDT, 520 M.Eva]
  }

  -- 80% VIT; Damage varies with TP
  sets.precast.WS['Torcleaver'] = {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 30, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 30, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 <__, __, __> [__/__, ___]
    ring1="Regal Ring",                   -- 10, 20, __, __, __ <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    back=gear.DRK_VIT_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                               8, 50
    -- 233 VIT, 455 Attack, 281 Accuracy, 85 WSD, 68 PDL <33 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Torcleaver'].MaxTP = set_combine(sets.precast.WS['Torcleaver'], {
    ear1="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCapped = {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 33, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 30, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 30, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 <__, __, __> [__/__, ___]
    ring1="Epaminondas's Ring",           -- __, __, __,  5, __ <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRK_VIT_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; FTP+
    -- DRK traits/gifts/etc                               8, 50
    -- 222 VIT, 436 Attack, 312 Accuracy, 79 WSD, 88 PDL <29 DA, 0 TA, 0 QA> [34 PDT/24 MDT, 607 M.Eva]
  }
  sets.precast.WS['Torcleaver'].AttCappedMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })

  -- 85% STR; 5 hit, transfers ftp
  sets.precast.WS['Resolution'] = {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 47, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, __, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRK_STR_DA_Cape,            -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                               8, 50
    -- 260 STR, 392 Attack, 273 Accuracy, 58 WSD, 78 PDL <42 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 607 M.Eva]
  }
  sets.precast.WS['Resolution'].MaxTP = set_combine(sets.precast.WS['Resolution'], {
    ear1="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCapped = set_combine(sets.precast.WS['Resolution'], {
    ammo="Crepuscular Pebble",            --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 42, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Sakpata's Leggings",            -- 29, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRK_STR_DA_Cape,            -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                               8, 50
    -- 248 STR, 397 Attack, 318 Accuracy, 22 WSD, 99 PDL <40 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 638 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
  })

  -- 70% INT/30% STR; Dark elemental. Att down varies with TP
  sets.precast.WS['Infernal Scythe'] = {
    ammo="Seething Bomblet +1",       -- 15, __, __ {__,  7, __, __} [__/__, ___]
    head="Pixie Hairpin +1",          -- __, 27, __ {28, __, __, __} [__/__, ___]
    body=gear.Nyame_B_body,           -- 45, 42, 13 {__, 30, __, 40} [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 28, 11 {__, 30, __, 40} [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 44, 12 {__, 30, __, 40} [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 33, 22, 12 {__, 50, __, 60} [__/__, 119]
    neck="Sibyl Scarf",               -- __, 10, __ {__, 10, __, __} [__/__, ___]
    ear1="Malignance Earring",        -- __,  8, __ {__,  8, __, 10} [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __ {__, __, __, __} [__/__, ___]; TP bonus
    ring1="Metamorph Ring +1",        -- __, 16, __ {__, __, __, 15} [__/__, ___]
    ring2="Archon Ring",              -- __, __, __ { 5, __, __,  5} [__/__, ___]
    back=gear.DRK_MAB_Cape,           -- __, 30, __ {__, 10, 20, 20} [10/__, ___]
    waist="Eschan Stone",             -- __, __, __ {__,  7, __,  7} [__/__, ___]
    -- DRK traits/gifts/etc                       8
    -- 168 STR, 227 INT, 56 WSD {33 Dark MAB, 182 MAB, 20 M.Dmg, 237 M.Acc} [34 PDT/24 MDT, 520 M.Eva]
  }
  sets.precast.WS['Infernal Scythe'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'], {
    ear2="Friomisi Earring",          -- __, __, __ {__, 10, __, __} [__/__, ___]
  })
  sets.precast.WS['Infernal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})

  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Dark Harvest'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Dark Harvest'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})

  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Shadow of Death'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})

  -- 100% STR; 1 hit, crit varies with TP
  sets.precast.WS['Vorpal Scythe'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Blistering Sallet +1",          -- 41, __, 53, __, __ (10, __) < 3, __, __> [ 3/__,  53]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ (__, __) <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, 40, 15, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Regal Ring",                   -- 10, 20, __, __, __ (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    back=gear.DRK_STR_DA_Cape,            -- 30, 20, 20, __, __ (__, __) <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                               8, 50
    -- 284 STR, 387 Attack, 304 Accuracy, 58 WSD, 78 PDL (16 Crit Rate, 6 Crit Dmg) <36 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
    
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 284 STR, 387 Attack, 304 Accuracy, 58 WSD, 78 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].MaxTP = set_combine(sets.precast.WS['Vorpal Scythe'], {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCapped = {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Blistering Sallet +1",          -- 41, __, 53, __, __ (10, __) < 3, __, __> [ 3/__,  53]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ (__, __) <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, 40, 15, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 12,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Regal Ring",                   -- 10, 20, __, __, __ (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    back=gear.DRK_STR_DA_Cape,            -- 30, 20, 20, __, __ (__, __) <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                               8, 50
    -- 284 STR, 387 Attack, 304 Accuracy, 58 WSD, 78 PDL (16 Crit Rate, 6 Crit Dmg) <36 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
    
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    -- 284 STR, 387 Attack, 304 Accuracy, 58 WSD, 78 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  }
  sets.precast.WS['Vorpal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })

  -- 50% MND/30% STR; 4 hit, silence duration varies with TP
  sets.precast.WS['Guillotine'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Guillotine'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Guillotine'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Guillotine'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})

  -- 60% STR/60% MND. 2 hit attack, damage varies with TP.
  sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Cross Reaper'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Cross Reaper'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Cross Reaper'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})

  -- 60% STR/60% MND. 1 hit. Defense ignored based on TP.
  sets.precast.WS['Quietus'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Quietus'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Quietus'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Quietus'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 73~85% INT. 4 hit, dmg varies with TP. ftp replicating
  sets.precast.WS['Entropy'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Entropy'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Entropy'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Entropy'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})

  -- 20% STR/20% INT; 4 hit, dmg varies with TP
  sets.precast.WS['Insurgency'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Insurgency'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Insurgency'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Insurgency'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})

  -- 40% STR/40% INT; Drains target's HP. Add effect: Haste
  sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Catastrophe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 50% STR; 3 hits, transfers ftp, acc varies with tp
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})

  -- 40% DEX/40% INT; wind elemental, dmg varies with TP
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Ghastly Tathlum +1",                -- __, 11, __ {__, 21, __} [__/__, ___]
    head=gear.Nyame_B_head,                   -- 25, 28, 11 {30, __, 40} [ 7/ 7, 123]
    body="Fallen's Cuirass +3",               -- 32, 32, __ {60, __, 40} [__/__,  68]
    hands="Fallen's Finger Gauntlets +3",     -- 39, 24, __ {62, __, 38} [__/__,  46]
    legs=gear.Nyame_B_legs,                   -- __, 44, 12 {30, __, 40} [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",            -- 25, 22, 12 {50, __, 60} [__/__, 119]
    neck="Sibyl Scarf",                       -- __, 10, __ {10, __, __} [__/__, ___]
    ear1="Malignance Earring",                -- __,  8, __ { 8, __, 10} [__/__, ___]
    ear2="Friomisi Earring",                  -- __, __, __ {10, __, __} [__/__, ___]
    ring1="Metamorph Ring +1",                -- __, 16, __ {__, __, 15} [__/__, ___]
    ring2="Defending Ring",                   -- __, __, __ {__, __, __} [10/10, ___]
    back=gear.DRK_MAB_Cape,                   -- __, 30, __ {10, 20, 20} [10/__, ___]
    waist="Eschan Stone",                     -- __, __, __ { 7, __,  7} [__/__, ___]
    -- DRK traits/gifts/etc                               8
    -- 121 DEX, 225 INT, 43 WSD {277 MAB, 41 M.Dmg, 270 M.Acc} [35 PDT/25 MDT, 506 M.Eva]
    
    -- body="Fallen's Cuirass +4",            -- 32, 35, __ {63, __, 45} [__/__, 108]
    -- hands="Fallen's Finger Gauntlets +4",  -- 39, 27, __ {65, __, 43} [__/__,  86]
    -- 121 DEX, 231 INT, 43 WSD {283 MAB, 41 M.Dmg, 280 M.Acc} [35 PDT/25 MDT, 586 M.Eva]
  }

  sets.precast.WS['Armor Break'] = {
    ammo="Pemphredo Tathlum",             -- __,  8,  4 [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 61, 61, 31 [__/__,  87]
    body="Heathen's Cuirass +2",          -- 54, 54, 30 [12/12,  93]
    hands="Heathen's Gauntlets +3",       -- 62, 62, 25 [10/10,  82]
    legs="Heathen's Flanchards +3",       -- 63, 63, 41 [12/12, 119]
    feet="Sakpata's Leggings",            -- 55, 55, __ [ 6/ 6, 150]
    neck="Abyssal Beads +2",              -- 15, 15, __ [__/__, ___]
    ear1="Dignitary's Earring",           -- 10, 10, __ [__/__, ___]
    ear2="Heathen's Earring +1",          -- 12, 12, __ [__/__, ___]
    ring1="Etana Ring",                   --  7,  7, __ [__/__, ___]
    ring2="Metamorph Ring +1",            -- __, 16, 16 [__/__, ___]
    back=gear.DRK_MAB_Cape,               -- __, 20, 30 [10/__, ___]
    waist="Null Belt",                    -- 15, 30, __ [__/__,  30]
    -- 354 Accuracy, 413 M.Acc, 177 INT [50 PDT/40 MDT, 561 M.Eva]
    
    -- body="Heathen's Cuirass +3",       -- 64, 64, 35 [13/13, 103]
    -- 364 Accuracy, 423 M.Acc, 182 INT [51 PDT/41 MDT, 571 M.Eva]
  }
  sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Armor Break'], {})
  sets.precast.WS['Shield Break'] = set_combine(sets.precast.WS['Armor Break'], {})
  sets.precast.WS['Full Break'] = set_combine(sets.precast.WS['Armor Break'], {})
  sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS['Armor Break'], {})
  sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS['Armor Break'], {})


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

  sets.midcast['Enfeebling Magic'] = {
    ammo="Pemphredo Tathlum",         --  4,  8, __ [__/__, ___]
    head=gear.Carmine_D_head,         -- 26, 50, 11 [__/__,  53]
    body="Heathen's Cuirass +2",      -- 30, 54, __ [__/__,  93]
    hands="Heathen's Gauntlets +3",   -- 25, 62, __ [10/10,  82]
    legs="Heathen's Flanchards +3",   -- 41, 63, __ [12/12, 119]
    feet="Heathen's Sollerets +3",    -- 22, 60, __ [__/__, 119]
    neck="Erra Pendant",              -- __, 17, __ [__/__, ___]
    ear1="Malignance Earring",        --  8, 10, __ [__/__, ___]
    ear2="Heathen's Earring +1",      -- __, 12, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- 16, 15, __ [__/__, ___]
    ring2="Stikini Ring +1",          -- __, 11,  8 [__/__, ___]
    back=gear.DRK_MAB_Cape,           -- 30, 20, __ [10/__, ___]
    waist="Null Belt",                -- __, 30, __ [__/__,  30]
    -- 202 INT, 412 M.Acc, 19 Enfeeb Skill [32 PDT/22 MDT, 496 M.Eva]

    -- body="Heathen's Cuirass +3",   -- 35, 64, __ [__/__, 103]
    -- 207 INT, 422 M.Acc, 19 Enfeeb Skill [32 PDT/22 MDT, 506 M.Eva]
  }

  sets.midcast.Poison = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Poisonga = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Bind = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Break = set_combine(sets.midcast['Enfeebling Magic'],{})

  ------- Dark magic: Absorb-spells, Aspir, Bio, Drain, Dread Spikes, Endark, Stun -------
  -- Bio II dark skill cap at 291. DRK hits this without gear.
  sets.midcast.Bio = {
    ammo="Staunch Tathlum +1",                  -- [ 3/ 3, ___]
    head="Fallen's Burgeonet +3",               -- [__/__,  52]; Duration+50%
    body=gear.Nyame_B_body,                     -- [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,                   -- [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,                     -- [ 8/ 8, 150]
    feet={name="Ratri Sollerets +1",priority=1},-- [-6/-6, 139]; Duration+25%
    neck="Incanter's Torque",                   -- [__/__, ___]; MP cost 0 sometimes
    ear1="Eabani Earring",                      -- [__/__,   8]
    ear2="Arete Del Luna +1",                   -- [__/__, ___]; Resists
    ring1="Moonlight Ring",                     -- [ 5/ 5, ___]
    ring2="Defending Ring",                     -- [10/10, ___]
    back=gear.DRK_FC_Cape,                      -- [10/__, ___]
    waist="Platinum Moogle Belt",               -- [ 3/ 3,  15]
    -- [49 PDT/39 MDT, 615 M.Eva]
    
    -- head="Fallen's Burgeonet +4",            -- [__/__,  92]; Duration+50%
    -- [49 PDT/39 MDT, 655 M.Eva]
  }

  -- Not affected by skill.
  -- Potency affected by max HP at cast time.
  sets.midcast['Dread Spikes'] = {
    ammo="Egoist's Tathlum",          --  45 [___/___, ___]
    head="Ratri Sallet +1",           -- 510 [ -8/ -8, 101]
    body="Heathen's Cuirass +2",      --  83 [ 12/ 12,  93]; Potency+45%
    hands="Ratri Gadlings +1",        -- 499 [-10/-10,  90]
    legs="Ratri Cuisses +1",          -- 521 [-12/-12, 139]
    feet="Ratri Sollerets +1",        -- 487 [ -6/ -6, 139]; Duration+25%
    neck="Unmoving Collar +1",        -- 200 [___/___, ___]
    ear1="Odnowa Earring +1",         -- 110 [  3/  5, ___]
    ear2="Genmei Earring",            -- ___ [  2/___, ___]
    ring1="Moonlight Ring",           -- 110 [  5/  5, ___]
    ring2="Gelatinous Ring +1",       -- 135 [  7/ -1, ___]
    back="Moonlight Cape",            -- 275 [  6/  6, ___]
    waist="Platinum Moogle Belt",     -- ___ [  3/  3,  15]

    -- body="Heathen's Cuirass +3",   --  98 [ 13/ 13, 103]; Potency+55%
    -- Base HP at ML30                  2019
    -- HP from belt                      500
    -- 5009/5509 HP [3 PDT/-5 MDT, 587 M.Eva]
  }
  sets.DreadSpikesWeapon = {
    -- main="Crepuscular Scythe",     -- ___ [___/___, ___]; Potency+50%
    -- sub="Utu Grip",
  }

  -- Potency Formula = 12 + floor(Dark Skill ÷ 20)×3 - floor(Dark Skill ÷ 40)
  -- Highest achievable skill = 594 ML0, 644 ML50
  -- Highest achievable dmg   = 113 ML0, 124 ML50
  -- Grants attack bonus based on potency also.
  sets.midcast.Endark ={
    ammo="Staunch Tathlum +1",              -- __ [ 3/ 3, ___]
    head="Fallen's Burgeonet +3",           -- __ [__/__,  52]; Duration+50%
    body=gear.Carmine_C_body,               -- 16 [__/ 4,  64]
    hands="Fallen's Finger Gauntlets +3",   -- 18 [__/__,  46]
    legs="Heathen's Flanchards +3",         -- 30 [12/12, 119]
    feet="Ratri Sollerets +1",              -- __ [-6/-6, 139]; Duration+25%
    neck="Incanter's Torque",               -- 10 [__/__, ___]
    ear1="Odnowa Earring +1",               -- __ [ 3/ 5, ___]
    ear2="Mani Earring",                    -- 10 [__/__, ___]
    ring1="Stikini Ring +1",                --  8 [__/__, ___]
    ring2="Evanescence Ring",               -- 10 [__/__, ___]
    back=gear.DRK_Adoulin_Cape,             -- 10 [__/__, ___]
    waist="Platinum Moogle Belt",           -- __ [ 3/ 3,  15]
    -- ML30 traits                            483
    -- 595 Dark skill [15 PDT/21 MDT, 435 M.Eva]
    
    -- head="Fallen's Burgeonet +4",        -- __ [__/__,  92]; Duration+50%
    -- hands="Fallen's Finger Gauntlets +4",-- 19 [__/__,  86]
    -- 596 Dark skill [15 PDT/21 MDT, 515 M.Eva]
  }

  -- Dark skill only affects acc, not potency.
  sets.midcast.Absorb = {
    ammo="Pemphredo Tathlum",               --  4,  8, __, __ [__/__, ___]
    head="Fallen's Burgeonet +3",           -- 22, 37, __, __ [__/__,  52]; Duration+50%
    body=gear.Carmine_C_body,               -- 38, 38, 16, __ [__/ 4,  64]
    hands="Heathen's Gauntlets +3",         -- 25, 62, __, __ [10/10,  82]
    legs="Heathen's Flanchards +3",         -- 41, 63, 30, __ [12/12, 119]
    feet="Ratri Sollerets +1",              -- __, 43, __, __ [-6/-6, 139]; Duration+25%
    neck="Erra Pendant",                    -- __, 17, 10,  5 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",               -- __, __, __, __ [ 3/ 5, ___]
    ring1="Kishar Ring",                    -- __,  5, __, __ [__/__, ___]; Duration+10%
    ring2="Stikini Ring +1",                -- __, 11,  8, __ [__/__, ___]
    back="Chuparrosa Mantle",               -- __, __, __, 10 [__/__, ___]; Duration+20s
    waist="Null Belt",                      -- __, 30, __, __ [__/__,  30]
    -- 138 INT, 324 M.Acc, 64 Dark skill, 15 Absorb Potency% [19 PDT/25 MDT, 486 M.Eva]
    
    -- head="Fallen's Burgeonet +4",        -- 25, 42, __, __ [__/__,  92]; Duration+50%
    -- 141 INT, 329 M.Acc, 64 Dark skill, 15 Absorb Potency% [19 PDT/25 MDT, 526 M.Eva]
  }
  sets.AbsorbWeapon = {
    -- main="Liberator",
    -- sub="Khonsu",
    -- range="Ullr",
    -- ammo="empty",
  }

  -- Don't care about duration
  sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
    ammo="Pemphredo Tathlum",               --  4,  8, __, __ [__/__, ___]
    head="Heathen's Burgeonet +3",          -- 31, 61, __, __ [__/__,  87]
    body=gear.Carmine_C_body,               -- 38, 38, 16, __ [__/ 4,  64]
    hands="Heathen's Gauntlets +3",         -- 25, 62, __, __ [10/10,  82]; Enhances Absorb-TP
    legs="Heathen's Flanchards +3",         -- 41, 63, 30, __ [12/12, 119]
    feet="Heathen's Sollerets +3",          -- 22, 60, __, __ [__/__, 119]
    neck="Erra Pendant",                    -- __, 17, 10,  5 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __, __ [__/__, ___]
    ear2="Heathen's Earring +1",            -- __, 12, __, __ [__/__, ___]
    ring1="Metamorph Ring +1",              -- 16, 15, __, __ [__/__, ___]
    ring2="Stikini Ring +1",                -- __, 11,  8, __ [__/__, ___]
    back=gear.DRK_MAB_Cape,                 -- 30, 20, __, __ [10/__, ___]; Duration +10s
    waist="Null Belt",                      -- __, 30, __, __ [__/__,  30]
    -- 215 INT, 407 M.Acc, 64 Dark skill, 5 Absorb Potency% [32 PDT/26 MDT, 501 M.Eva]
    
    -- ear2="Heathen's Earring +2",         -- 15, 20, __, __ [__/__, ___]
    -- 230 INT, 415 M.Acc, 64 Dark skill, 5 Absorb Potency% [32 PDT/26 MDT, 501 M.Eva]
  })
  sets.midcast['Absorb-Attri'] = set_combine(sets.midcast['Absorb-TP'], {})

  -- Drain Base Potency = [(Dark Magic Skill)×5/8] + 132.5
  -- Drain II Base Potency = Dark Magic Skill + 165
  -- Drain III Base Potency = [(Dark Magic Skill)×3/2] + 105
  -- Amount Drained = (Base Potency) × (Drain/Aspir Gear Potency) × (Dark Elemental Magic Affinity)
  --                  × (Weather/Day Bonuses) × (Nether Void Bonus) × (Orpheus Sash Bonus)
  sets.midcast.Drain = {
    ammo="Pemphredo Tathlum",                   --  4,  8, __, __, __ [__/__, ___]
    head="Fallen's Burgeonet +3",               -- 22, 37, __, __, __ [__/__,  52]  96; Duration+50%
    body=gear.Carmine_C_body,                   -- 38, 38, 16, __, __ [__/ 4,  64]  96
    hands="Fallen's Finger Gauntlets +3",       -- 24, 38, 18, 16, __ [__/__,  46]  49
    legs="Heathen's Flanchards +3",             -- 41, 63, 30, __, __ [12/12, 119]  82
    feet={name="Ratri Sollerets +1",priority=1},-- __, 43, __, __, __ [-6/-6, 139] 487; Duration+25%
    neck="Erra Pendant",                        -- __, 17, 10,  5, __ [__/__, ___] ___
    ear1="Hirudinea Earring",                   -- __, __, __,  3, __ [__/__, ___]  -5
    ear2="Nehalennia Earring",                  -- __, __, __, __, __ [__/__, ___] -60
    ring1="Archon Ring",                        -- __, __, __, __,  5 [__/__, ___] ___
    ring2="Evanescence Ring",                   -- __, __, 10, 10, __ [__/__, ___] ___
    back=gear.DRK_Adoulin_Cape,                 -- __, __, 10, 25, __ [__/__, ___] ___
    waist="Orpheus's Sash",                     -- __, __, __, __, __ [__/__, ___] ___; +1-15% damage
    -- ML30 traits                                        483
    -- 129 INT, 244 M.Acc, 577 Dark skill, 59 Drain/Aspir Potency, 5 Dark Affinity [6 PDT/10 MDT, 380 M.Eva] 745 HP
    -- D2 Potency = 742, Drained = 2777 w/ nether void
    -- D3 Potency = 970.5, Drained = 3633 w/ nether void
    
    -- head="Fallen's Burgeonet +4",            -- 25, 42, __, __, __ [__/__,  92]  96; Duration+50%
    -- 132 INT, 249 M.Acc, 577 Dark skill, 59 Drain/Aspir Potency, 5 Dark Affinity [6 PDT/10 MDT, 420 M.Eva] 745 HP
    -- D2 Potency = 742, Drained = 2777 w/ nether void
    -- D3 Potency = 970.5, Drained = 3633 w/ nether void
  }
  sets.DrainWeapon = {
    -- main="Father Time",
    -- sub="Dark Grip",
    -- range="Ullr",
    -- ammo="empty",
  }
  
  sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
  
  sets.midcast.Stun = {
    ammo="Pemphredo Tathlum",               --  4,  8, __ [__/__, ___]
    head="Heathen's Burgeonet +3",          -- 31, 61, __ [__/__,  87]
    body=gear.Carmine_C_body,               -- 38, 38, 16 [__/ 4,  64]
    hands="Fallen's Finger Gauntlets +3",   -- 24, 38, 18 [__/__,  46]
    legs="Heathen's Flanchards +3",         -- 41, 63, 30 [12/12, 119]
    feet="Heathen's Sollerets +3",          -- 22, 60, __ [__/__, 102]
    neck="Incanter's Torque",               -- __, __, 10 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __ [__/__, ___]
    ear2="Heathen's Earring +1",            -- __, 12, __ [__/__, ___]
    ring1="Stikini Ring +1",                -- __, 11,  8 [__/__, ___]
    ring2="Metamorph Ring +1",              -- 16, 15, __ [__/__, ___]
    back=gear.DRK_MAB_Cape,                 -- 30, 20, __ [10/__, ___]
    waist="Null Belt",                      -- __, 30, __ [__/__,  30]
    -- 214 INT, 366 M.Acc, 82 Dark skill [22 PDT/16 MDT, 448 M.Eva]
    
    -- hands="Fallen's Finger Gauntlets +4",-- 27, 43, 19 [__/__,  86]
    -- 217 INT, 371 M.Acc, 83 Dark skill [22 PDT/16 MDT, 488 M.Eva]
  }
  sets.midcast.Stun.Enmity = set_combine(sets.Enmity, {})

  sets.midcast['Elemental Magic'] = {
    ammo="Pemphredo Tathlum",               --  4,  8,  4, __ [__/__, ___]
    head=gear.Nyame_B_head,                 -- 28, 40, 30, __ [ 7/ 7, 123]
    body="Fallen's Cuirass +3",             -- 32, 40, 60, __ [__/__,  68]
    hands="Fallen's Finger Gauntlets +3",   -- 24, 38, 62, __ [__/__,  46]
    legs=gear.Nyame_B_legs,                 -- 44, 40, 30, __ [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",          -- 22, 60, 50, __ [__/__, 119]
    neck="Sibyl Scarf",                     -- 10, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",              --  8, 10,  8, __ [__/__, ___]
    ear2="Friomisi Earring",                -- __, __, 10, __ [__/__, ___]
    ring1="Metamorph Ring +1",              -- 16, 15, __, __ [__/__, ___]
    ring2="Defending Ring",                 -- __, __, __, __ [10/10, ___]
    back=gear.DRK_MAB_Cape,                 -- 30, 20, 10, 20 [10/__, ___]
    waist="Skrymir Cord",                   -- __,  5,  5, 30 [__/__, ___]
    -- 218 INT, 276 M.Acc, 279 MAB, 50 M.Dmg [35 PDT/25 MDT, 506 M.Eva]
    
    -- body="Fallen's Cuirass +4",          -- 35, 45, 63, __ [__/__, 108]
    -- hands="Fallen's Finger Gauntlets +4",-- 27, 43, 65, __ [__/__,  86]
    -- 224 INT, 286 M.Acc, 285 MAB, 50 M.Dmg [35 PDT/25 MDT, 586 M.Eva]
  }

  -- Elemental magic
  sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Pemphredo Tathlum",
    -- head="empty",
    -- body="Crepuscular Cloak",
    hands="Heathen's Gauntlets +3",
    legs="Heathen's Flanchards +3",
    feet="Heathen's Sollerets +3",
    neck="Erra Pendant",
    ear1="Malignance Earring",
    ear2="Heathen's Earring +1",
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1",
    back=gear.DRK_MAB_Cape,
    waist="Null Belt",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",                           --  3, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Flamma Zucchetto +2",                     --  6, 44 <__,  5, __> (__, __) [__/__,  53]  4
    body={name="Hjarrandi Breastplate",priority=1}, -- 10, 47 <__, __, __> (13, __) [12/12,  69] __
    hands="Sakpata's Gauntlets",                    --  8, 55 < 6, __, __> (__, __) [ 8/ 8, 112]  4
    legs="Ignominy Flanchard +3",                   -- __, 49 <10, __, __> (__, __) [__/__,  84]  5
    feet="Flamma Gambieras +2",                     --  6, 42 < 6, __, __> (__, __) [__/__,  86]  2
    neck="Abyssal Beads +2",                        --  7, 15 <__, __, __> ( 4, __) [__/__, ___] __
    ear1="Telos Earring",                           --  5, 10 < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dedition Earring",                        --  8,-10 < 1, __, __> (__, __) [__/__, ___] __
    ring1={name="Moonlight Ring",priority=1},       --  5,  8 <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2={name="Moonlight Ring",priority=1},       --  5,  8 <__, __, __> (__, __) [ 5/ 5, ___] __
    back=gear.DRK_STP_Cape,                         -- 10, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Sailfi Belt +1",                         -- __, __ < 5,  2, __> (__, __) [__/__, ___]  9
    -- 73 STP, 288 Acc <32 DA, 7 TA, 0 QA> (17 Crit Rate, 0 Crit Dmg) [40 PDT/30 MDT, 404 MEVA] 24 Haste
    
    -- legs="Ignominy Flanchard +4",                -- __, 59 <10, __, __> (__, __) [__/__, 109]  5
    -- 73 STP, 288 Acc <32 DA, 7 TA, 0 QA> (17 Crit Rate, 0 Crit Dmg) [40 PDT/30 MDT, 429 MEVA] 24 Haste
  }
  -- TODO
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ear2="Cessance Earring",                        -- [__/__, ___]  3 < 3, __, __> __, __
  })
  -- TODO
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
  })
  -- TODO
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
  })

  -- TODO
  sets.engaged.LowDW = set_combine(sets.engaged,{
    waist="Reiki Yotai",
  })
  sets.engaged.MidDW = set_combine(sets.engaged.LowDW, {
    ear2="Eabani Earring",
    -- back=gear.DRK_DW_Cape,
  })
  -- TODO
  sets.engaged.HighDW = set_combine(sets.engaged.LowDW, {})
  -- TODO
  sets.engaged.SuperDW = set_combine(sets.engaged.LowDW, {})
  -- TODO
  sets.engaged.MaxDW = set_combine(sets.engaged.LowDW, {})


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = {
    ammo="Coiste Bodhar",                           --  3, __ < 3, __, __> (__, __) [__/__, ___] __
    head="Flamma Zucchetto +2",                     --  6, 44 <__,  5, __> (__, __) [__/__,  53]  4
    body={name="Hjarrandi Breastplate",priority=1}, -- 10, 47 <__, __, __> (13, __) [12/12,  69] __
    hands="Sakpata's Gauntlets",                    --  8, 55 < 6, __, __> (__, __) [ 8/ 8, 112]  4
    legs="Sakpata's Cuisses",                       -- __, 55 < 7, __, __> (__, __) [ 9/ 9, 150]  4
    feet="Flamma Gambieras +2",                     --  6, 42 < 6, __, __> (__, __) [__/__,  86]  2
    neck="Abyssal Beads +2",                        --  7, 15 <__, __, __> ( 4, __) [__/__, ___] __
    ear1="Telos Earring",                           --  5, 10 < 1, __, __> (__, __) [__/__, ___] __
    ear2="Dedition Earring",                        --  8,-10 < 1, __, __> (__, __) [__/__, ___] __
    ring1={name="Moonlight Ring",priority=1},       --  5,  8 <__, __, __> (__, __) [ 5/ 5, ___] __
    ring2={name="Moonlight Ring",priority=1},       --  5,  8 <__, __, __> (__, __) [ 5/ 5, ___] __
    back=gear.DRK_STP_Cape,                         -- 10, 20 <__, __, __> (__, __) [10/__, ___] __
    waist="Sailfi Belt +1",                         -- __, __ < 5,  2, __> (__, __) [__/__, ___]  9
    -- 73 STP, 294 Acc <29 DA, 7 TA, 0 QA> (17 Crit Rate, 0 Crit Dmg) [49 PDT/39 MDT, 470 MEVA] 23 Haste
  }
  -- TODO
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {
    ear2="Cessance Earring",                        -- [__/__, ___]  3 < 3, __, __> __, __
  })
  -- TODO
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})
  -- TODO
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {})
  
  -- TODO
  sets.engaged.LowDW.HeavyDef = set_combine(sets.engaged.HeavyDef,{
    waist="Reiki Yotai",
  })
  sets.engaged.MidDW.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {
    ear2="Eabani Earring",
    -- back=gear.DRK_DW_Cape,
  })
  -- TODO
  sets.engaged.HighDW.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {})
  -- TODO
  sets.engaged.SuperDW.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {})
  -- TODO
  sets.engaged.MaxDW.HeavyDef = set_combine(sets.engaged.LowDW.HeavyDef, {})

  sets.engaged.SubtleBlow = {
    ammo="Coiste Bodhar",                 --  3, __ < 3, __, __> (__, __) [__/__, ___] __, __(__)
    head="Sakpata's Helm",                -- __, 55 < 5, __, __> (__, __) [ 7/ 7, 123]  4, __(__)
    body="Dagon Breastplate",             -- __, 45 <__,  5, __> ( 4, __) [__/__,  86]  1, __(10)
    hands="Sakpata's Gauntlets",          --  8, 55 < 6, __, __> (__, __) [ 8/ 8, 112]  4,  8(__)
    legs="Volte Tights",                  --  8, 38 <__, __, __> (__, __) [__/__, 107]  9,  8(__)
    feet="Sakpata's Leggings",            -- __, 55 < 4, __, __> (__, __) [ 6/ 6, 150]  2, 15(__)
    neck="Loricate Torque +1",            -- __, __ <__, __, __> (__, __) [ 6/ 6, ___] __, __(__)
    ear1="Telos Earring",                 --  5, 10 < 1, __, __> (__, __) [__/__, ___] __, __(__)
    ear2="Brutal Earring",                --  1, __ < 5, __, __> (__, __) [__/__, ___] __, __(__)
    ring1="Chirich Ring +1",              --  6, 10 <__, __, __> (__, __) [__/__, ___] __, 10(__)
    ring2="Chirich Ring +1",              --  6, 10 <__, __, __> (__, __) [__/__, ___] __, 10(__)
    back=gear.DRK_STP_Cape,               -- 10, 20 <__, __, __> (__, __) [10/__, ___] __, __(__)
    waist="Ioskeha Belt +1",              -- __, 17 < 9, __, __> (__, __) [__/__, ___]  8, __(__)
    -- 47 STP, 315 Acc <33 DA, 5 TA, 0 QA> (4 Crit Rate, 0 Crit Dmg) [37 PDT/27 MDT, 578 MEVA] 28 Haste, 51(10) Subtle Blow
  }
  -- TODO
  sets.engaged.LowAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {
    ear2="Cessance Earring",          -- [__/__, ___]  3 < 3, __, __> __, __
  })
  -- TODO
  sets.engaged.MidAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  -- TODO
  sets.engaged.HighAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { neck="Vim Torque +1", }

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.FallbackShield = {sub="Blurred Shield +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'BlackMagic' then
    refine_various_spells(spell, action, spellMap, eventArgs)
  end

  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    -- Don't gearswap for weaponskills when Defense is on.
    if state.DefenseMode.current ~= 'None' then
      eventArgs.handled = true
    end
  end

  if spell.english == 'Weapon Bash'
    and sets.precast.JA['Weapon Bash'].Enmity
    and state.HighEnmityMode.value
  then
    equip(sets.precast.JA['Weapon Bash'].Enmity)
    eventArgs.handled = true
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
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
end

function job_midcast(spell, action, spellMap, eventArgs)
  if spell.english == 'Stun'
    and sets.midcast.Stun.Enmity
    and state.HighEnmityMode.value
  then
    equip(sets.midcast.Stun.Enmity)
    eventArgs.handled = true
  end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'Absorb' and silibs.get_day_weather_multiplier('Dark', true, false) > 1 then
    equip({waist='Hachirin-no-Obi'})
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

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

  if buff == 'doom' then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == 'doom' then
    status_change(player.status)
  end

  if buff == 'Aftermath: Lv.3' then
    if gain then
        send_command('timers create "Aftermath Tier III" 180 down')
        send_command('input /echo Tier III Aftermath!!!')
    else
        send_command('timers delete "Aftermath Tier III";gs c -cd AM3 Lost!!!')
        send_command('input /echo Tier III Aftermath OFF!!!')
    end
  end
  if buff == 'Aftermath: Lv.2' then
      if gain then
          send_command('timers create "Aftermath Tier II" 120 down')
          send_command('input /echo Tier II Aftermath!!')
      else
          send_command('timers delete "Aftermath Tier II";gs c -cd AM3 Lost!!!')
      end
  end
  if buff == 'Aftermath: Lv.1' then
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
  update_combat_form()
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 0 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
    
    if player and player.equipment and player.equipment.main and player.equipment.main ~= 'empty' then
      for weapon,am_list in pairs(activate_AM_mode) do
        if player.equipment.main == weapon or player.equipment.ranged == weapon then
          for am_level,_ in pairs(am_list) do
            if buffactive[am_level] then
              state.CombatForm:set(weapon..'AM')
              break
            end
          end
        end
      end
    end
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

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

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

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

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

function update_melee_groups()
  if player then
    classes.CustomMeleeGroups:clear()
  end
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
  elseif cmdParams[1] == 'clear_risky_buffs' then
    send_command('cancel Souleater')
    send_command('cancel Last Resort')
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
  set_macro_page(1, 8)
end

-- Calculate Fencer tier. Fencer active if not two-handed weapon, and offhand is empty or shield.
function calc_fencer_tier()
  local fencer = 0
  local main_weapon_skill = res.items:with('en', player.equipment.main).skill
  if not skill_ids_2h:contains(main_weapon_skill) then
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

function refine_various_spells(spell, action, spellMap, eventArgs)
  local selected_spell
  local arr

  if spell.name:startswith('Aspir') then
    arr = degrade_array['Aspir']
  elseif spell.name:startswith('Drain') then
    arr = degrade_array['Drain']
  end

  -- Select spell
  if arr then
    -- Find start index. Start with specified spell (e.g. if using Drain II, don't try Drain III)
    local start_yet = false
    for i=#arr,1,-1 do
      if not start_yet then
        if arr[i] == spell.english then
          start_yet = true
        end
      end

      if start_yet then
        local spell_detail = silibs.spells_by_name[arr[i]]
        local is_spell_available = silibs.can_access_spell(nil, spell_detail) and silibs.actual_cost(spell_detail) <= player.mp
        local timer = windower.ffxi.get_spell_recasts()[spell_detail.recast_id] -- Divide by 60 to get time in seconds
        if is_spell_available and timer < 6 then
          selected_spell = spell_detail
          break
        end
      end
    end
  end
  
  -- If selected spell is the original that was input, cast it and proceed as normal
  -- Otherwise, cast the new selected spell and cancel the original
  if selected_spell and selected_spell.english ~= spell.english then
    send_command('@input /ma '..selected_spell.english..' '..tostring(spell.target.raw))
    eventArgs.cancel = true
  end
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
