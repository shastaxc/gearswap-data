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
[ CTRL+9 ] BloodWea       /ja "Blood Weapon" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Ab-STR         /ma "Absorb-STR" <t>
[ ALT+2 ]  Ab-INT         /ma "Absorb-INT" <t>
[ ALT+3 ]  Ab-Attr        /ma "Absorb-attri" <t>
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
  equip({main=empty,sub=empty})
  
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
  silibs.enable_auto_lockstyle(8)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(true, 'Attack Capped')

  state.CP = M(false, 'Capacity Points Mode')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger','Sword','Club','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Anguta', 'Caladbolg', 'Naegling', 'Club', 'DaggerAcc', 'Dagger'}
  -- state.WeaponSet = M{['description']='Weapon Set', 'Anguta', 'Foenaria', 'Apocalypse', 'Caladbolg', 'Naegling', 'Club', 'Dagger'}

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
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^q'] = 'input /ja "Weapon Bash" <t>',
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
    -- back=???
    -- waist=???
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
    hands="Heathen's Gauntlets +2",           --  4 [ 9/ 9,  72]
    legs="Heathen's Flanchards +2",           --  7 [11/11, 109]; Realistically this will be move speed
    feet="Sakpata's Leggings",                --  7 [ 6/ 6, 150]
    neck="Loricate Torque +1",                -- __ [ 6/ 6, ___]
    ear1="Hearty Earring",                    -- __ [__/__, ___]; Resists
    ear2="Arete Del Luna +1",                 -- __ [__/__, ___]; Resists
    ring1="Moonlight Ring",                   -- __ [ 5/ 5, ___]
    ring2="Defending Ring",                   -- __ [10/10, ___]
    back=gear.DRK_FC_Cape,                    -- __ [10/__, ___]
    waist="Carrier's Sash",                   -- __ [__/__, ___]; Resists
    -- 28 M.Def [62 PDT/52 MDT, 571 M.Eva]

    -- hands="Heathen's Gauntlets +3",        --  5 [10/10,  82]
    -- legs="Heathen's Flanchards +3",        --  8 [12/12, 119]; Realistically this will be move speed
    -- 30 M.Def [64 PDT/54 MDT, 591 M.Eva]
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head={name="Ratri Sallet +1", priority=1}, -- 5
  }
  sets.latent_regen = {
    body="Sacro Breastplate", --13
    ear1="Infused Earring",
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
  }
  sets.precast.JA['Arcane Circle'] = {
    feet="Ignominy Sollerets +1", -- Duration +50%, potency +2%; +1 is acceptable
    -- feet="Ignominy Sollerets +3", -- Duration +50%, potency +2%; +1 is acceptable
  }
  sets.precast.JA['Last Resort'] = {
    back=gear.DRK_FC_Cape,
  }
  sets.precast.JA['Weapon Bash'] = {
    hands="Ignominy Gauntlets +2", -- Increase damage, add Chainbound effect
    -- hands="Ignominy Gauntlets +3", -- Increase damage, add Chainbound effect
  }
  sets.precast.JA['Souleater'] = {
    head="Ignominy Burgeonet +1", -- Increase HP consumption and attack boost
    -- head="Ignominy Burgeonet +3", -- Increase HP consumption and attack boost
  }
  sets.precast.JA['Diabolic Eye'] = {
    hands="Fallen's Finger Gauntlets +3", -- Increase duration based on merits; +1 is acceptable
  }
  sets.precast.JA['Nether Void'] = {
    legs="Heathen's Flanchard +2", -- Increase potency
    -- legs="Heathen's Flanchard +3", -- Increase potency
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
    -- head=empty,
    -- body="Crepuscular Cloak",
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  -- PDL caps at 100. Don't overcap it.
  -- Aria of Passion = assume +22% PDL (max song+ bonus)
  -- PrimeAM = assume 12% PDL (stage 4 AM3)
  sets.precast.WS = {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ [__/__, ___]
    back=gear.DRK_STR_WSD_Cape,           -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 264 STR, 161 MND, 435 Attack, 280 Accuracy, 82 WSD, 71 PDL [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 274 STR, 161 MND, 435 Attack, 276 Accuracy, 85 WSD, 71 PDL [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",            --  3, __, __, __, __,  3 [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 42, 27, 61, 61, __, 10 [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 21, 70, 55, __,  7 [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRK_STR_WSD_Cape,           -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 288 STR, 151 MND, 433 Attack, 326 Accuracy, 48 WSD, 101 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 298 STR, 151 MND, 433 Attack, 322 Accuracy, 51 WSD, 101 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAM = set_combine(sets.precast.WS.AttCapped, {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    -- Prime AM3                                                 12
    -- 269 STR, 150 MND, 460 Attack, 315 Accuracy, 65 WSD, 100 PDL [42 PDT/32 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS.AttCappedPrimeAM, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 279 STR, 150 MND, 460 Attack, 311 Accuracy, 68 WSD, 100 PDL [42 PDT/32 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCappedAria = set_combine(sets.precast.WS.AttCapped, {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    -- Aria                                                      22
    -- 274 STR, 161 MND, 455 Attack, 300 Accuracy, 77 WSD, 103 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedAriaMaxTP = set_combine(sets.precast.WS.AttCappedAria, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 284 STR, 161 MND, 455 Attack, 296 Accuracy, 80 WSD, 103 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAMAria = set_combine(sets.precast.WS.AttCappedAria, {})
  sets.precast.WS.AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS.AttCappedAriaMaxTP, {})

  -- 50% MND / 30% STR. Dark elemental. Absorbs HP. dStat = INT
  sets.precast.WS['Sanguine Blade'] = {
    ammo="Seething Bomblet +1",       -- __, 15, __,  7, __ [__/__, ___]
    head="Pixie Hairpin +1",          -- __, __, 27, __, __ [__/__, ___]; Dark MAB+28
    body=gear.Nyame_B_body,           -- 37, 45, 42, 30, 13 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 40, 17, 28, 30, 11 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 32, 58, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 26, 33, 22, 50, 12 [__/__, 119]
    neck="Baetyl Pendant",            -- __, __, __, 13, __ [__/__, ___]
    ear1="Malignance Earring",        --  8, __,  8,  8, __ [__/__, ___]
    ear2="Friomisi Earring",          -- __, __, __, 10, __ [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __, __,  5 [__/__, ___]
    ring2="Archon Ring",              -- __, __, __, __, __ [__/__, ___]; Dark MAB+5
    back=gear.DRK_MAB_Cape,           -- __, __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",             -- __, __, __,  7, __ [__/__, ___]
    -- 143 MND, 168 STR, 201 INT, 195 MAB, 53 WSD [34 PDT/24 MDT, 520 M.Eva]
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
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRK_VIT_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; FTP+
    -- DRK traits/gifts/etc                                  50
    -- 223 VIT, 440 Attack, 300 Accuracy, 77 WSD, 78 PDL <28 DA, 0 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Torcleaver'].MaxTP = set_combine(sets.precast.WS['Torcleaver'], {
    ear1="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCapped = {
    ammo="Crepuscular Pebble",            --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 33, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 34, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 30, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRK_VIT_WSD_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 239 VIT, 433 Attack, 326 Accuracy, 48 WSD, 98 PDL <35 DA, 2 TA, 3 QA> [38 PDT/28 MDT, 607 M.Eva]
  }
  sets.precast.WS['Torcleaver'].AttCappedMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAM = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    -- Prime AM3                                             12
    -- 230 VIT, 437 Attack, 315 Accuracy, 59 WSD, 100 PDL <34 DA, 2 TA, 3 QA> [45 PDT/35 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedPrimeAM, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedAria = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    -- Aria                                                  22
    -- 223 VIT, 455 Attack, 300 Accuracy, 77 WSD, 100 PDL <33 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedAria, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    -- Prime AM3 + Aria                                      34
    -- 233 VIT, 438 Attack, 289 Accuracy, 78 WSD, 104 PDL <33 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedPrimeAMAria, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })

  -- 85% STR; 5 hit, transfers ftp
  sets.precast.WS['Resolution'] = {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 47, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Sakpata's Leggings",            -- 29, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, __, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                                  50
    -- 260 STR, 395 Attack, 286 Accuracy, 12 WSD, 88 PDL <48 DA, 0 TA, 3 QA> [42 PDT/32 MDT, 638 M.Eva]
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
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                                  50
    -- 248 STR, 397 Attack, 317 Accuracy, 14 WSD, 99 PDL <40 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 638 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAM = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
    -- Prime AM3                                             12
    -- 247 STR, 375 Attack, 315 Accuracy, 0 WSD, 100 PDL <52 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAM, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]

    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedAria = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
    -- Aria                                                  22
    -- 247 STR, 375 Attack, 315 Accuracy, 0 WSD, 110 PDL <52 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedAria, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]

    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]
    -- Prime AM3 + Aria                                      34
    -- 247 STR, 375 Attack, 315 Accuracy, 0 WSD, 122 PDL <52 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAria, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __ < 3, __, __> [__/__, ___]

    -- ear1="Brutal Earring",             -- __, __, __, __, __ < 5, __, __> [__/__, ___]
    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })

  -- 70% INT/30% STR; Dark elemental. Att down varies with TP
  sets.precast.WS['Infernal Scythe'] = {
    ammo="Seething Bomblet +1",       -- 15, __,  7, __ [__/__, ___]
    head="Pixie Hairpin +1",          -- __, 27, __, __ [__/__, ___]; Dark MAB+28
    body=gear.Nyame_B_body,           -- 45, 42, 30, 13 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 28, 30, 11 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 33, 22, 50, 12 [__/__, 119]
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8,  8, __ [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __, __ [__/__, ___]; TP bonus
    ring1="Metamorph Ring +1",        -- __, 16, __, __ [__/__, ___]
    ring2="Archon Ring",              -- __, __, __, __ [__/__, ___]; Dark MAB+5
    back=gear.DRK_MAB_Cape,           -- __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",             -- __, __,  7, __ [__/__, ___]
    -- 168 STR, 227 INT, 182 MAB, 48 WSD [34 PDT/24 MDT, 520 M.Eva]
  }
  sets.precast.WS['Infernal Scythe'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'], {
    ear2="Friomisi Earring",          -- __, __, 10, __ [__/__, ___]
  })
  sets.precast.WS['Infernal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  
  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Dark Harvest'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Dark Harvest'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP, {})

  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Shadow of Death'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP, {})

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
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 81 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].MaxTP = set_combine(sets.precast.WS['Vorpal Scythe'], {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Blistering Sallet +1",          -- 41, __, 53, __, __ (10, __) < 3, __, __> [ 3/__,  53]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 ( 5, __) < 8, __, __> [10/10, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 70, 55, __,  7 (__, __) < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ (__, __) <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, 40, 15, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 281 STR, 377 Attack, 333 Accuracy, 25 WSD, 96 PDL (31 Crit Rate, 6 Crit Dmg) <28 DA, 2 TA, 0 QA> [39 PDT/26 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAM = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Prime AM3                                             12
    -- 286 STR, 372 Attack, 318 Accuracy, 37 WSD, 101 PDL (31 Crit Rate, 6 Crit Dmg) <27 DA, 2 TA, 0 QA> [38 PDT/25 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAM, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedAria = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Aria                                                  22
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 103 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedAria, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Prime AM3 + Aria                                      34
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 115 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAria, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })

  -- 50% MND/30% STR; 4 hit, silence duration varies with TP
  sets.precast.WS['Guillotine'] = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Brutal Earring",                -- __, __, __, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 269 STR, 161 MND, 427 Attack, 276 Accuracy, 66 WSD, 68 PDL <46 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Guillotine'].MaxTP = set_combine(sets.precast.WS['Guillotine'], {})
  sets.precast.WS['Guillotine'].AttCapped = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 42, 27, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 21, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Brutal Earring",                -- __, __, __, __, __, __ < 5, __, __> [__/__, ___]
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 295 STR, 151 MND, 448 Attack, 322 Accuracy, 38 WSD, 98 PDL <48 DA, 2 TA, 0 QA> [35 PDT/25 MDT, 607 M.Eva]
  }
  sets.precast.WS['Guillotine'].AttCappedMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCapped, {})
  sets.precast.WS['Guillotine'].AttCappedPrimeAM = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3                                                 12
    -- 295 STR, 162 MND, 443 Attack, 307 Accuracy, 50 WSD, 100 PDL <47 DA, 2 TA, 3 QA> [34 PDT/24 MDT, 607 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedPrimeAM, {})
  sets.precast.WS['Guillotine'].AttCappedAria = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Aria                                                      22
    -- 279 STR, 161 MND, 447 Attack, 296 Accuracy, 61 WSD, 100 PDL <46 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedAria, {})
  sets.precast.WS['Guillotine'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3 + Aria                                          34
    -- 279 STR, 161 MND, 447 Attack, 296 Accuracy, 61 WSD, 112 PDL <46 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedPrimeAMAria, {})

  -- 20% STR/20% INT; 4 hit, dmg varies with TP
  sets.precast.WS['Insurgency'] = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 42, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 28, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 22, 60, 60, 12, __ <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus
    ear2="Lugra Earring +1",              -- 16, 16, __, __, __, __ < 3, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 285 STR, 180 INT, 410 Attack, 269 Accuracy, 64 WSD, 60 PDL <44 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Insurgency'].MaxTP = set_combine(sets.precast.WS['Insurgency'], {
    ear1="Brutal Earring",                -- __, __, __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCapped = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 42, 31, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 42, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 28, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 32, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 22, 60, 60, 12, __ <__, __, __> [__/__, 119]
    neck="Abyssal Beads +2",              -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 305 STR, 155 INT, 448 Attack, 326 Accuracy, 38 WSD, 98 PDL <43 DA, 2 TA, 0 QA> [35 PDT/25 MDT, 607 M.Eva]
  }
  sets.precast.WS['Insurgency'].AttCappedMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    ear1="Lugra Earring +1",              -- 16, 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAM = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3                                                 12
    -- 295 STR, 167 INT, 443 Attack, 311 Accuracy, 50 WSD, 100 PDL <42 DA, 2 TA, 3 QA> [34 PDT/24 MDT, 607 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedPrimeAM, {
    ear1="Lugra Earring +1",              -- 16, 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedAria = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Aria                                                      22
    -- 279 STR, 164 INT, 447 Attack, 300 Accuracy, 61 WSD, 100 PDL <41 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedAria, {
    ear1="Lugra Earring +1",              -- 16, 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3 + Aria                                          34
    -- 279 STR, 164 INT, 447 Attack, 300 Accuracy, 61 WSD, 112 PDL <41 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedPrimeAMAria, {
    ear1="Lugra Earring +1",              -- 16, 16, __, __, __, __ < 3, __, __> [__/__, ___]
  })

  -- 40% STR/40% INT; Drains target's HP. Add effect: Haste
  sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Catastrophe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})
  sets.precast.WS['Catastrophe'].AttCappedPrimeAM = set_combine(sets.precast.WS.AttCappedPrimeAM, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS.AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Catastrophe'].AttCappedAria = set_combine(sets.precast.WS.AttCappedAria, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS.AttCappedAriaMaxTP, {})
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMAria = set_combine(sets.precast.WS.AttCappedPrimeAMAria, {
    ear1="Lugra Earring +1",
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS.AttCappedPrimeAMAriaMaxTP, {})

  -- 50% STR; 3 hits, transfers ftp, acc varies with tp
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAM = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAM, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedAria = set_combine(sets.precast.WS['Resolution'].AttCappedAria, {})
  sets.precast.WS['Decimation'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAria, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAriaMaxTP, {})
  
  -- 40% DEX/40% INT; wind elemental, dmg varies with TP
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Ghastly Tathlum +1",                -- __, 11, __, __ [__/__, ___]
    head=gear.Nyame_B_head,                   -- 25, 28, 30, 11 [ 7/ 7, 123]
    body="Fallen's Cuirass +3",               -- 32, 32, 60, __ [__/__,  68]
    hands="Fallen's Finger Gauntlets +3",     -- 39, 24, 62, __ [__/__,  46]
    legs=gear.Nyame_B_legs,                   -- __, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",            -- 25, 22, 50, 12 [__/__, 119]
    neck="Sibyl Scarf",                       -- __, 10, 10, __ [__/__, ___]
    ear1="Malignance Earring",                -- __,  8,  8, __ [__/__, ___]
    ear2="Friomisi Earring",                  -- __, __, 10, __ [__/__, ___]
    ring1="Metamorph Ring +1",                -- __, 16, __, __ [__/__, ___]
    ring2="Defending Ring",                   -- __, __, __, __ [10/10, ___]
    back=gear.DRK_MAB_Cape,                   -- __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",                     -- __, __,  7, __ [__/__, ___]
    -- 121 DEX, 225 INT, 277 MAB, 35 WSD [35 PDT/25 MDT, 506 M.Eva]
  }


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
    body="Heathen's Cuirass +3",      -- 35, 64, __ [__/__, 103]
    hands="Heathen's Gauntlets +2",   -- 20, 52, __ [ 9/ 9,  72]
    legs="Heathen's Flanchard +2",    -- 36, 53, __ [11/11, 109]
    feet="Heathen's Sollerets +3",    -- 22, 60, __ [__/__, 119]
    neck="Erra Pendant",              -- __, 17, __ [__/__, ___]
    ear1="Malignance Earring",        --  8, 10, __ [__/__, ___]
    ear2="Heathen's Earring +1",      -- __, 11, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- 16, 15, __ [__/__, ___]
    ring2="Stikini Ring +1",          -- __, 11,  8 [__/__, ___]
    back=gear.DRK_MAB_Cape,           -- 30, 20, __ [10/__, ___]
    waist="Eschan Stone",             -- __,  7, __ [__/__, ___]
    -- 197 INT, 378 M.Acc, 19 Enfeeb Skill [30 PDT/20 MDT, 456 M.Eva]

    -- hands="Heathen's Gauntlets +3",-- 25, 62, __ [10/10,  82]
    -- legs="Heathen's Flanchard +3", -- 41, 63, __ [12/12, 119]
    -- 207 INT, 398 M.Acc, 19 Enfeeb Skill [32 PDT/22 MDT, 476 M.Eva]
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
  }

  -- Not affected by skill.
  -- Potency affected by max HP at cast time.
  sets.midcast['Dread Spikes'] = {
    ammo="Egoist's Tathlum",          --  45 [___/___, ___]
    head="Ratri Sallet +1",           -- 510 [ -8/ -8, 101]
    body="Heathen's Cuirass +3",      --  98 [ 13/ 13, 103]; Potency+55%
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
    legs="Heathen's Flanchard +2",          -- 25 [11/11, 109]
    feet="Ratri Sollerets +1",              -- __ [-6/-6, 139]; Duration+25%
    neck="Incanter's Torque",               -- 10 [__/__, ___]
    ear1="Odnowa Earring +1",               -- __ [ 3/ 5, ___]
    ear2="Mani Earring",                    -- 10 [__/__, ___]
    ring1="Stikini Ring +1",                --  8 [__/__, ___]
    ring2="Evanescence Ring",               -- 10 [__/__, ___]
    back=gear.DRK_Adoulin_Cape,             -- 10 [__/__, ___]
    waist="Platinum Moogle Belt",           -- __ [ 3/ 3,  15]
    -- ML30 traits                            483
    -- 588 Dark skill [14 PDT/20 MDT, 415 M.Eva]
    
    -- legs="Heathen's Flanchard +3",       -- 30 [12/12, 119]
    -- 595 Dark skill [15 PDT/21 MDT, 435 M.Eva]
  }

  -- Dark skill only affects acc, not potency.
  sets.midcast.Absorb = {
    ammo="Pemphredo Tathlum",               --  4,  8, __, __ [__/__, ___]
    head="Fallen's Burgeonet +3",           -- 22, 37, __, __ [__/__,  52]; Duration+50%
    body=gear.Carmine_C_body,               -- 38, 38, 16, __ [__/ 4,  64]
    hands="Heathen's Gauntlets +2",         -- 20, 52, __, __ [ 9/ 9,  72]
    legs="Heathen's Flanchard +2",          -- 36, 53, 25, __ [11/11, 109]
    feet="Ratri Sollerets +1",              -- __, 43, __, __ [-6/-6, 139]; Duration+25%
    neck="Erra Pendant",                    -- __, 17, 10,  5 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",               -- __, __, __, __ [ 3/ 5, ___]
    ring1="Kishar Ring",                    -- __,  5, __, __ [__/__, ___]; Duration+10%
    ring2="Stikini Ring +1",                -- __, 11,  8, __ [__/__, ___]
    back="Chuparrosa Mantle",               -- __, __, __, 10 [__/__, ___]; Duration+20s
    waist="Eschan Stone",                   -- __,  7, __, __ [__/__, ___]
    -- 128 INT, 281 M.Acc, 59 Dark skill, 15 Absorb Potency% [17 PDT/23 MDT, 436 M.Eva]
    
    -- hands="Heathen's Gauntlets +3",      -- 25, 62, __, __ [10/10,  82]
    -- legs="Heathen's Flanchard +3",       -- 41, 63, 30, __ [12/12, 119]
    -- 138 INT, 301 M.Acc, 64 Dark skill, 15 Absorb Potency% [19 PDT/25 MDT, 456 M.Eva]
  }
  sets.AbsorbWeapon = {
    -- main="Liberator",
    -- sub="Khonsu",
    -- range="Ullr",
    -- ammo=empty,
  }

  -- Don't care about duration
  sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
    ammo="Pemphredo Tathlum",               --  4,  8, __, __ [__/__, ___]
    head="Heathen's Burgeonet +3",          -- 31, 61, __, __ [__/__,  87]
    body=gear.Carmine_C_body,               -- 38, 38, 16, __ [__/ 4,  64]
    hands="Heathen's Gauntlets +2",         -- 20, 52, __, __ [ 9/ 9,  72]; Enhances Absorb-TP
    legs="Heathen's Flanchard +2",          -- 36, 53, 25, __ [11/11, 109]
    feet="Heathen's Solleretes +3",         -- 22, 60, __, __ [__/__, 119]
    neck="Erra Pendant",                    -- __, 17, 10,  5 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",               -- __, __, __, __ [ 3/ 5, ___]
    ring1="Metamorph Ring +1",              -- 16, 15, __, __ [__/__, ___]
    ring2="Stikini Ring +1",                -- __, 11,  8, __ [__/__, ___]
    back=gear.DRK_MAB_Cape,                 -- 30, 20, __, __ [10/__, ___]; Duration +10s
    waist="Eschan Stone",                   -- __,  7, __, __ [__/__, ___]
    -- 205 INT, 352 M.Acc, 59 Dark skill, 5 Absorb Potency% [33 PDT/29 MDT, 451 M.Eva]
    
    -- hands="Heathen's Gauntlets +3",      -- 25, 62, __, __ [10/10,  82]; Enhances Absorb-TP
    -- legs="Heathen's Flanchard +3",       -- 41, 63, 30, __ [12/12, 119]
    -- 215 INT, 372 M.Acc, 64 Dark skill, 5 Absorb Potency% [35 PDT/31 MDT, 471 M.Eva]
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
    legs="Heathen's Flanchard +2",              -- 36, 53, 25, __, __ [11/11, 109]  72
    feet={name="Ratri Sollerets +1",priority=1},-- __, 43, __, __, __ [-6/-6, 139] 487; Duration+25%
    neck="Erra Pendant",                        -- __, 17, 10,  5, __ [__/__, ___] ___
    ear1="Hirudinea Earring",                   -- __, __, __,  3, __ [__/__, ___]  -5
    ear2="Nehalennia Earring",                  -- __, __, __, __, __ [__/__, ___] -60
    ring1="Archon Ring",                        -- __, __, __, __,  5 [__/__, ___] ___
    ring2="Evanescence Ring",                   -- __, __, 10, 10, __ [__/__, ___] ___
    back=gear.DRK_Adoulin_Cape,                 -- __, __, 10, 25, __ [__/__, ___] ___
    waist="Orpheus's Sash",                     -- __, __, __, __, __ [__/__, ___] ___; +1-15% damage
    -- ML30 traits                                        483
    -- 124 INT, 234 M.Acc, 572 Dark skill, 59 Drain/Aspir Potency, 5 Dark Affinity [5 PDT/9 MDT, 410 M.Eva] 735 HP

    -- legs="Heathen's Flanchard +3",           -- 41, 63, 30, __, __ [12/12, 119]  82
    -- 129 INT, 244 M.Acc, 577 Dark skill, 59 Drain/Aspir Potency, 5 Dark Affinity [6 PDT/10 MDT, 380 M.Eva] 745 HP
    -- D2 Potency = 742, Drained = 2777 w/ nether void
    -- D3 Potency = 970.5, Drained = 3633 w/ nether void
  }
  sets.DrainWeapon = {
    -- main="Father Time",
    -- sub="Dark Grip",
    -- range="Ullr",
    -- ammo=empty,
  }
  
  sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
  
  sets.midcast.Stun = {
    ammo="Pemphredo Tathlum",               --  4,  8, __ [__/__, ___]
    head="Heathen's Burgeonet +3",          -- 31, 61, __ [__/__,  87]
    body=gear.Carmine_C_body,               -- 38, 38, 16 [__/ 4,  64]
    hands="Fallen's Finger Gauntlets +3",   -- 24, 38, 18 [__/__,  46]
    legs="Heathen's Flanchard +2",
    feet="Heathen's Sollerets +3",          -- 22, 60, __ [__/__, 102]
    neck="Incanter's Torque",               -- __, __, 10 [__/__, ___]
    ear1="Malignance Earring",              --  8, 10, __ [__/__, ___]
    ear2="Heathen's Earring +1",            -- __, 11, __ [__/__, ___]
    ring1="Stikini Ring +1",                -- __, 11,  8 [__/__, ___]
    ring2="Metamorph Ring +1",              -- 16, 15, __ [__/__, ___]
    back=gear.DRK_MAB_Cape,                 -- 30, 20, __ [10/__, ___]
    waist="Eschan Stone",                   -- __,  7, __ [__/__, ___]
    
    -- legs="Heathen's Flanchard +3",       -- 41, 63, 30 [12/12, 119]
    -- 214 INT, 342 M.Acc, 82 Dark skill [22 PDT/16 MDT, 418 M.Eva]
  }

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
  }

  -- Elemental magic
  sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Pemphredo Tathlum",
    -- head=empty,
    -- body="Crepuscular Cloak",
    hands="Heathen's Gauntlets +2",
    legs="Heathen's Flanchard +2",
    feet="Heathen's Sollerets +3",
    neck="Erra Pendant",
    ear1="Malignance Earring",
    ear2="Heathen's Earring +1",
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1",
    back=gear.DRK_MAB_Cape,
    waist="Eschan Stone",
    
    -- hands="Heathen's Gauntlets +3",
    -- legs="Heathen's Flanchard +3",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",                           -- [__/__, ___]  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",                     -- [__/__,  53]  6 <__,  5, __> __,  4
    body={name="Hjarrandi Breastplate",priority=1}, -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",                    -- [ 8/ 8, 112]  8 < 6, __, __> __,  4
    legs="Ignominy Flanchard +3",                   -- [__/__,  84] __ <10, __, __> __,  5
    feet="Flamma Gambieras +2",                     -- [__/__,  86]  6 < 6, __, __> __,  2
    neck="Abyssal Beads +2",                        -- [__/__, ___]  7 <__, __, __>  4, __
    ear1="Telos Earring",                           -- [__/__, ___]  5 < 1, __, __> __, __
    ear2="Dedition Earring",                        -- [__/__, ___]  8 < 1, __, __> __, __
    ring1={name="Moonlight Ring",priority=1},       -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2={name="Moonlight Ring",priority=1},       -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.DRK_STP_Cape,                         -- [10/__, ___] 10 <__, __, __> __, __
    waist="Sailfi Belt +1",                         -- [__/__, ___] __ < 5,  2, __> __,  9
    -- [40 PDT/30 MDT, 404 MEVA] 73 STP <32 DA, 7 TA, 0 QA> 17 Crit Rate, 24 Haste
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
    ammo="Coiste Bodhar",                           -- [__/__, ___]  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",                     -- [__/__,  53]  6 <__,  5, __> __,  4
    body={name="Hjarrandi Breastplate",priority=1}, -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",                    -- [ 8/ 8, 112]  8 < 6, __, __> __,  4
    legs="Sakpata's Cuisses",                       -- [ 9/ 9, 150] __ < 7, __, __> __,  4
    feet="Flamma Gambieras +2",                     -- [__/__,  86]  6 < 6, __, __> __,  2
    neck="Abyssal Beads +2",                        -- [__/__, ___]  7 <__, __, __>  4, __
    ear1="Telos Earring",                           -- [__/__, ___]  5 < 1, __, __> __, __
    ear2="Dedition Earring",                        -- [__/__, ___]  8 < 1, __, __> __, __
    ring1={name="Moonlight Ring",priority=1},       -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2={name="Moonlight Ring",priority=1},       -- [ 5/ 5, ___]  5 <__, __, __> __, __
    back=gear.DRK_STP_Cape,                         -- [10/__, ___] 10 <__, __, __> __, __
    waist="Sailfi Belt +1",                         -- [__/__, ___] __ < 5,  2, __> __,  9
    -- [49 PDT/39 MDT, 470 MEVA] 73 STP <29 DA, 7 TA, 0 QA> 17 Crit Rate, 23 Haste
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
    ammo="Seething Bomblet +1",           -- [__/__, ___] __ <__, __, __> __,  5, __(__)
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ < 5, __, __> __,  4, __(__)
    body="Dagon Breastplate",             -- [__/__,  86] __ <__,  5, __>  4,  1, __(10)
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 < 6, __, __> __,  4,  8(__)
    legs="Sakpata's Cuisses",             -- [ 9/ 9, 150] __ < 7, __, __> __,  4, __(__)
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ < 4, __, __> __,  2, 13(__)
    neck="Loricate Torque +1",            -- [ 6/ 6, ___] __ <__, __, __> __, __, __(__)
    ear1="Telos Earring",                 -- [__/__, ___]  5 < 1, __, __> __, __, __(__)
    ear2="Dedition Earring",              -- [__/__, ___]  8 <__, __, __> __, __, __(__)
    ring1="Chirich Ring +1",              -- [__/__, ___]  6 <__, __, __> __, __, 10(__)
    ring2="Niqmaddu Ring",                -- [__/__, ___] __ <__, __,  3> __, __, __( 5)
    back=gear.DRK_STP_Cape,               -- [10/__, ___] 10 <__, __, __> __, __, __(__)
    waist="Peiste Belt +1",               -- [__/__, ___] __ <__, __, __> __, __, 10(__)
    -- [46 PDT/36 MDT, 621 MEVA] 37 STP <23 DA, 5 TA, 3 QA> 4 Crit Rate, 20 Haste, 41(15) Subtle Blow
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
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.type == 'BlackMagic' then
    refine_various_spells(spell, action, spellMap, eventArgs)
  end

  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    -- Don't gearswap for weaponskills when Defense is on.
    if state.DefenseMode.current ~= 'None' then
      eventArgs.handled = true
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

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if sets.WeaponSet[state.WeaponSet.current] then
      if silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current].DW then
        return sets.WeaponSet[state.WeaponSet.current].DW
      else
        return sets.WeaponSet[state.WeaponSet.current]
      end
    end
  end
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
  equip(select_weapons())
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
  equip(select_weapons())
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'

    if state.CombatForm.value == 'FoenariaAM' then
      wsmode = wsmode..'PrimeAM'
    end

    if buffactive['Aria'] then
      wsmode = wsmode..'Aria'
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

-- Combining these all into one send_command to avoid race condition with
-- setting keybinds for the next job.
function unbind_keybinds()
  windower.send_command(unbind_command)
end

function test()
end
