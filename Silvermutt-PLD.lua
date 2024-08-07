--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: N/A
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* The way I handle modes with tanks is different than all my other jobs. What I do is keep the PDT mode enabled while
  tanking (it is enabled by default). This still allows for gear to swap during spells or JAs, but for the most part
  will equip defensive sets while idle or engaged.
  * When the defense mode is enabled, all spells, JAs, and WSs sets will use their "Safe" variant if it exists.
  * Kiting Mode is enabled by default. This causes movement speed gear to always remain equipped when idle or engaged.
    This is obviously not a tanky piece of gear so when you actually need the defense, you have to manually toggle the
    Kiting Mode off, then manually turn it back on when you want to move fast again.
* Hybrid Mode: Changes damage taken level while engaged
  * LightDef: Higher defense than "Normal" mode
  * Normal: Lower defense, more offense
* Casting Mode: Changes casting type. This is toggled automatically on this job. Do not try to control it manually.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
  * While there is both a PDT and MDT mode, there is no difference between them in this file. As long as either is
    enabled, defensive gear will be used.
* Idle Mode: Determines which set to use when not engaged
  * Normal: What will normally be used, defensive gear.
  * Refresh: Equips a set of gear with Refresh in it. Do not use this while tanking. You'll need to turn off defensive
    mode for this idle set to apply.
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Runes: Select a rune to use when issuing the custom rune command while subbing RUN.

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* There are separate keybinds for your offhand weapon called SubWeaponSet. This allows you to mix and match your
  weapons and shields.
* The WeaponSet and SubWeaponSet cycles have an "Any" option (the default). When this is selected, it will allow
  all other sets (like precast, midcast, idle, etc.) to use the weapons that are specified (main, sub) on those sets.
  Otherwise, it will have those slots ignored and the selected WeaponSet and SubWeaponSet will override it.
  * The benefit to allowing the swaps is some of your abilities will be stronger (such as Phalanx or Enmity abilities),
    while the downside is that you will constantly lose TP and it may make you less tanky.

Spells
* Sets are built assuming at least 4/5 Spell Interruption Rate merits are enabled.
* 5/5 Iron Will merits plus 4/5 SIRD merits will cap you so while Rampart is active. If you don't have Rampart
  active or if you don't have the appropriate merits, certain spells which we want to always be SIRD-capped, will
  equip one of the SIRD sets defined by the map named midcast_SIRD_sets. Modify this if you wish, but I don't
  recommend changing it.
  * In the case you do have SIRD capped through merits + Rampart, regular sets will be used. For example, a Cure
    will use sets.midcast.Cure instead of sets.SIRDCure. But the sets.SIRDCure set will be used most of the time.
* There is a separate set and keybind for regular Phalanx vs SIRD-capped Phalanx. Use the SIRD-capped one if you
  are tanking lots of enemies or else they will simply interrupt you. Even a weak Phalanx is better than none.
* Spell sets are managed in the AzureSets addon. Make sure there is a set in there called pldsub because that will
  attempt to equip automatically when you change jobs.

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
* If you get under 10 HP, the sets.SafeShield set will be equipped. This is to prevent you from killing yourself
  while AFK if wearing an early stage Duban that still has the Soul Drain effect.


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
  [ CTRL+F8 ]           Toggle Attack Capped mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set
  [ CTRL+Home ]         Cycle Sub Weapon Sets
  [ CTRL+End ]          Cycleback Sub Weapon Sets
  [ ALT+End ]           Reset to default Sub Weapon Set

Spells:
  [ ALT+O ]             Phalanx
  [ ALT+L ]             SIRD-capped Phalanx
  ============ /BLU ============
  [ ALT+W ]             Cocoon
  ============ /NIN ============
  [ ALT+Numpad0 ]       Utsusemi: Ichi
  [ ALT+Numpad. ]       Utsusemi: Ni

Abilities:
  [ ALT+` ]             Chivalry
  [ ALT+Q ]             Shield Bash
  [ ALT+E ]             Holy Circle
  ============ /WAR ============
  [ CTRL+Numlock ]      Defender
  [ CTRL+Numpad/ ]      Berserk
  [ CTRL+Numpad* ]      Warcry
  [ CTRL+Numpad- ]      Aggressor
  ============ /DRK ============
  [ CTRL+Numlock ]      Weapon Bash
  [ CTRL+Numpad/ ]      Last Resort
  [ CTRL+Numpad* ]      Arcane Circle
  [ CTRL+Numpad- ]      Souleater
  ============ /SAM ============
  [ CTRL+Numlock ]      Third Eye
  [ CTRL+Numpad/ ]      Meditate
  [ CTRL+Numpad* ]      Sekkanoki
  [ CTRL+Numpad- ]      Hasso
  ============ /RUN ============
  [ CTRL+- ]            Cycleback Rune
  [ CTRL+= ]            Cycle Rune
  [ Numpad0 ]           Execute Rune

SilverLibs keybinds:
  [ ALT+D ]             Interact
  [ ALT+S ]             Turn 180 degrees in place
  [ WIN+W ]             Toggle Rearming Lock
                          (off = re-equip previous weapons if you go barehanded)
                          (on = prevent weapon auto-equipping)

For more info and available functions, see SilverLibs documentation at:
https://github.com/shastaxc/silver-libs

Global-Binds.lua contains additional non-job-related keybinds.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  Custom Commands
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Prepend with /console to use these in in-game macros.

gs c phalanxsird        Use SIRD-capped Phalanx.
gs c rune               Uses current rune
gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this
                        manually fixes it.
gs c equipweapons       Equips weapons based on your current states that you've set.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] Reprisal       /ma "Reprisal" <me>
[ CTRL+2 ] Majesty        /ja "Majesty" <me>
[ CTRL+3 ] Banishga       /ma "Banishga" <stnpc>
[ CTRL+4 ] Cure4          /ma "Cure IV" <stpc>
[ CTRL+5 ] C4A1           /ma "Cure IV" <a10>
[ CTRL+6 ] Rampart        /ja "Rampart" <me>
[ CTRL+7 ] Sentinel       /ja "Sentinel" <me>
[ CTRL+8 ] Palisade       /ja "Palisade" <me>
[ CTRL+9 ] Invincib       /ja "Invincible" <me>
[ CTRL+0 ] GeistWal       /ma "Geist Wall" <stnpc>
[ ALT+1 ]  Crusade        /ma "Crusade" <me>
[ ALT+3 ]  Flash          /ma "Flash" <stnpc>
[ ALT+3 ]  BlankGze       /ma "Blank Gaze" <stnpc>
[ ALT+4 ]  C4A2           /ma "Cure IV" <a20>
[ ALT+8 ]  Fealty         /ja "Fealty" <me>
[ ALT+9 ]  Interven       /ja "Intervene" <me>
[ ALT+0 ]  SheepSon       /ma "Sheep Song" <stnpc>

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                              Sub-job /BLU Spell Set
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
<slot01>cocoon</slot01>
<slot02>mysterious light</slot02>
<slot03>sheep song</slot03>
<slot04>healing breeze</slot04>
<slot05>claw cyclone</slot05>
<slot06>foot kick</slot06>
<slot07>mandibular bite</slot07>
<slot08>blank gaze</slot08>
<slot09>wild oats</slot09>
<slot10>sprout smack</slot10>
<slot11>power attack</slot11>
<slot12>geist wall</slot12>

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
  coroutine.schedule(function()
    send_command('gs c subweaponset current')
  end, 6)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(7)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus, function()
    return state.DefenseMode.value == 'None'
  end)

  -- /BLU Spell Maps
  blue_magic_maps = {}
  blue_magic_maps.BLUEnmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
      'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
  blue_magic_maps.BLUCure = S{'Wild Carrot', 'Healing Breeze', 'Magic Fruit'}
  blue_magic_maps.BLUBuffs = S{'Cocoon', 'Refueling'}

  state.Kiting:set('On')
  state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT', 'Phalanx'}
  state.DefenseMode:set('Physical') -- Default to PDT mode
  state.CastingMode:options('Normal', 'Safe')
  state.HybridMode:options('LightDef', 'Normal')
  state.IdleMode:options('Normal', 'Refresh')
  state.AttCapped = M(false, 'Attack Capped')
  state.WeaponSet = M{['description']='Weapon Set', 'Any', 'Burtgang', 'Naegling', 'Aeolian'}
  state.SubWeaponSet = M{['description']='Sub Weapon Set', 'Any', 'Duban', 'Aegis'}
  state.CP = M(false, 'Capacity Points Mode')
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

  enable_phalanx_sird = false -- Do not modify
  has_soul_drain_shield = false -- Do not modify
  self_rampart = false -- Do not modify

  -- These spells' normal sets will use the specified set based on Iron Will and SIRD merits.
  -- Both spell names and spellmaps can be used as indices. Spell names take precedence if both are included.
  midcast_SIRD_sets = {
    ['Enhancing Magic'] = 'SIRD',
    ['Crusade'] = 'SIRD',
    ['Reprisal'] = 'SIRD',
    ['Aquaveil'] = 'SIRD',
    ['Utsusemi'] = 'SIRD',
    ['BLUBuffs'] = 'SIRD',

    ['Foil'] = 'SIRDEnmity',
    ['Geist Wall'] = 'SIRDEnmity',
    ['Sheep Song'] = 'SIRDEnmity',
    ['Bomb Toss'] = 'SIRDEnmity',
    ['Poison'] = 'SIRDEnmity',
    ['Poisonga'] = 'SIRDEnmity',
    ['Banish'] = 'SIRDEnmity',
    ['Dia'] = 'SIRDEnmity',

    ['Cure'] = 'SIRDCure',
    ['BLUCure'] = 'SIRDCure',
  }

  check_for_prime_shield()

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^home'] = 'gs c subweaponset cycle',
      ['^end'] = 'gs c subweaponset cycleback',
      ['!end'] = 'gs c subweaponset reset',
      ['!`'] = 'input /ja "Chivalry" <me>',
      ['!q'] = 'input /ja "Shield Bash" <t>',
      ['!e'] = 'input /ja "Holy Circle" <me>',
      ['!o'] = 'input /ma "Phalanx" <me>',
      ['!l'] = 'gs c phalanxsird',
    },
    ['BLU'] = {
      ['!w'] = 'input /ma "Cocoon" <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['DRK'] = {
      ['^numlock'] = 'input /ja "Weapon Bash" <t>',
      ['^numpad/'] = 'input /ja "Last Resort" <me>',
      ['^numpad*'] = 'input /ja "Arcane Circle" <me>',
      ['^numpad-'] = 'input /ja "Souleater" <me>',
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
    ['RUN'] = {
      ['^-'] = 'gs c cycleback Runes',
      ['^='] = 'gs c cycle Runes',
      ['%numpad0'] = 'gs c rune',
    },
  }

  set_main_keybinds:schedule(2)
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'BLU' then
    coroutine.schedule(function()
      send_command('aset set pldsub')
    end, 2)
  elseif player.sub_job == 'NIN' then
    state.SubWeaponSet = M{['description']='Sub Weapon Set', 'Any', 'Duban', 'Aegis', 'Aeolian'}
  else
    state.SubWeaponSet = M{['description']='Sub Weapon Set', 'Any', 'Duban', 'Aegis'}
  end

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
    ammo="Perfect Lucky Egg",
    hands="Volte Bracers",
    waist="Chaac Belt",
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    legs=gear.Carmine_D_legs,
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

  -- Enmity caps at +200
  sets.Enmity = {
    main="Burtgang",                                -- 18 Enmity
    sub="Srivatsa",                                 -- 15 Enmity
    ammo="Sapience Orb",                            -- __/__, ___ [___] < 2>
    head="Loess Barbuta +1",                        -- 20/20, ___ [105] <24>
    body={name=gear.Souveran_C_body.name,
      augments=gear.Souveran_C_body.augments,
      priority=1},                                  -- 10/10,  69 [171] <20>
    hands={name=gear.Souveran_C_hands.name,
      augments=gear.Souveran_C_hands.augments,
      priority=1},                                  -- __/ 5,  48 [239] < 9>
    legs="Caballarius Breeches +3",                 --  7/__,  84 [ 72] < 9>
    feet="Chevalier's Sabatons +2",                 -- __/__, 126 [ 42] <13>
    neck={name="Unmoving Collar +1",priority=1},    -- __/__, ___ [200] <10>
    ear1="Trux Earring",                            -- __/__, ___ [___] < 5>
    ear2="Cryptic Earring",                         -- __/__, ___ [ 40] < 4>
    ring1={name="Gelatinous Ring +1",priority=1},   --  7/-1, ___ [135] <__>
    ring2="Apeile Ring +1",                         -- __/__, ___ [___] < 9>
    back=gear.PLD_Enmity_Cape,                      -- 10/__,  20 [ 80] <10>
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 [___] <__>; HP+10%
    -- HP from belt                                                312
    -- 57 PDT / 37 MDT, 362 M.Eva [1084/1396 HP] <148 Enmity>
    
    -- feet="Chevalier's Sabatons +3",              -- __/__, 136 [ 52] <15>
    -- HP from belt                                                313
    -- 57 PDT / 37 MDT, 372 M.Eva [1094/1407 HP] <150 Enmity>
  }

  -- SIRD sets will automatically be swapped in according to functional logic
  -- 102% SIRD required to cap; can get 10% from merits
  sets.SIRD = {
    main="Burtgang",
    sub="Srivatsa",
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] {11} __
    head={name=gear.Souveran_C_head.name,
      augments=gear.Souveran_C_head.augments,
      priority=1},                                  -- __/__,  53 [280] {20}  9
    body="Sakpata's Breastplate",                   -- 10/10, 139 [136] {__} __
    hands={name="Regal Gauntlets",priority=1},      -- __/__,  48 [205] {10} __
    legs=gear.Founders_Hose,                        -- __/__,  80 [ 54] {30} __
    feet="Sakpata's Leggings",                      --  6/ 6, 150 [ 68] {__} __
    neck="Moonlight Necklace",                      -- __/__,  15 [___] {15} 15
    ear1="Magnetic Earring",                        -- __/__, ___ [___] { 8} __
    ear2="Chevalier's Earring +1",                  --  4/ 4, ___ [___] {__} __
    ring1={name="Gelatinous Ring +1",priority=1},   --  7/-1, ___ [135] {__} __
    ring2="Defending Ring",                         -- 10/10, ___ [___] {__} __
    back={name="Moonlight Cape",priority=1},        --  6/ 6, ___ [275] {__} __
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 [___] {__}; HP+10%
    -- SIRD merits                                                      { 8}
    -- HP from belt                                                319
    -- 49 PDT / 41 MDT, 500 M.Eva [1153/1472 HP] {102 SIRD} 24 Enmity
    
    -- ear2="Chevalier's Earring +2",               --  8/ 8, ___ [___] {__} __
    -- 53 PDT / 45 MDT, 500 M.Eva [1153/1472 HP] {102 SIRD} 24 Enmity
  }

  sets.SIRDEnmity = {
    main="Burtgang",                                --                       18
    sub="Srivatsa",                                 --                       15
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] {11} __
    head={name=gear.Souveran_C_head.name,
      augments=gear.Souveran_C_head.augments,
      priority=1},                                  -- __/__,  53 [280] {20}  9
    body=gear.Souveran_C_body,                      -- 10/10,  69 [171] {__} 20
    hands={name="Regal Gauntlets",priority=1},      -- __/__,  48 [205] {10} __
    legs="Caballarius Breeches +3",                 --  7/__,  84 [ 72] {10}  9
    feet=gear.Odyssean_Enmity_feet,                 -- __/__,  86 [ 20] {20}  8
    neck="Moonlight Necklace",                      -- __/__,  15 [___] {15} 15
    ear1="Magnetic Earring",                        -- __/__, ___ [___] { 8} __
    ear2="Chevalier's Earring +1",                  --  4/ 4, ___ [___] {__} __
    ring1={name="Gelatinous Ring +1", priority=1},  --  7/-1, ___ [135] {__} __
    ring2={name="Moonlight Ring", priority=1},      --  5/ 5, ___ [110] {__} __
    back=gear.PLD_Enmity_Cape,                      -- 10/__,  20 [ 80] {__} 10
    waist={name="Platinum Moogle Belt", priority=1},--  3/ 3,  15 [___] {__} __; HP+10%
    -- SIRD merits                                                      { 8}
    -- HP from belt                                                311
    -- 49 PDT/24 MDT, 390 M.Eva [1073/1384 HP] {102 SIRD} 81 Enmity

    -- ear2="Chevalier's Earring +2",               --  8/ 8, ___ [___] {__} __
    -- 53 PDT/28 MDT, 390 M.Eva [1073/1384 HP] {102 SIRD} 104 Enmity
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- Weapon Sets
  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Burtgang'] = {
    main="Burtgang",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
  }
  sets.WeaponSet['Aeolian'] = {
    main=gear.Malevolence_1,
  }

  -- Reprisal Block rates from Martel: https://www.ffxiah.com/forum/topic/46016/first-and-final-line-of-defense-v20/96/
  ---+-------------+--------+-------+--------+-------+--------+-------+
  -- |             | 139    |       | 145    |       | 150    |       |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Shield      | block% | dmg-  | block% | dmg-  | block% | dmg-  |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Duban       | 100.00 | ???   | 100.00 | ???   | 100.00 | ???   |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Ochain      | 97.89  | 58.73 | 85.50  | 51.30 | 74.25  | 44.55 |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Srivatsa    | 53.5   | 40.13 | 48.38  | 36.29 | 37.13  | 27.85 |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Aegis       | 10.28  | 7.71  | 5.00   | 5.63  | 5.00   | 5.63  |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Priwen      | 86.06  | 68.85 | 59.10  | 47.28 | 36.60  | 29.28 |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Nibiru      | 43.56  | 34.85 | 29.52  | 23.62 | 18.27  | 14.62 |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Deliverance | 46.77  | 32.04 | 32.96  | 22.57 | 21.71  | 14.87 |
  -- +-------------+--------+-------+--------+-------+--------+-------+
  -- | Beatific+1  | 63.63  | 21.63 | 50.27  | 17.09 | 39.02  | 13.27 |
  -- +-------------+--------+-------+--------+-------+--------+-------+

  sets.SubWeaponSet = {}
  sets.SubWeaponSet['Duban'] = {
    sub="Duban",
  }
  sets.SubWeaponSet['Aegis'] = {
    sub="Aegis",
  }
  sets.SubWeaponSet['Aeolian'] = {
    sub=gear.Malevolence_2,
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- Base HP (Elvaan + ML0 + Sub BLU + Full merits) = 1829 HP
  -- Base HP at ML30 = 2039 HP
  -- Platinum Moogle Belt HP bonuses will be calculated based on ML30 average

  sets.HeavyDef = {
    main="Burtgang",
    sub="Duban",
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ (___) [___] __, __; Resist Status+11
    head="Chevalier's Armet +2",                    -- 10/10,  93 (138) [135] __, __; 7% Dmg to MP
    body="Sakpata's Breastplate",                   -- 10/10, 139 (194) [136] __, __; Resist Status+15
    hands="Chevalier's Gauntlets +3",               -- 11/11,  98 (136) [ 64] __, __; Shield Def. Bonus+5
    legs={name="Chevalier's Cuisses +2",priority=1},-- 12/12, 126 (150) [117] __, __; Retain enmity
    feet="Sakpata's Leggings",                      --  6/ 6, 150 (125) [ 68]  5,  5
    neck={name="Unmoving Collar +1",priority=1},    -- __/__, ___ ( 41) [200] __, __
    ear1="Arete del Luna +1",                       -- __/__, ___ (___) [___] __, __; Resists
    ear2={name="Etiolation Earring",priority=1},    -- __/ 3, ___ (___) [ 50] __, __; Resist Silence+15
    ring1={name="Gelatinous Ring +1",priority=1},   --  7/-1, ___ (___) [135] __, __
    ring2={name="Moonlight Ring",priority=1},       --  5/ 5, ___ (___) [110] __, __
    back=gear.PLD_Block_Cape,                       -- __/__,  20 ( 20) [ 80]  8, __; 5% Dmg to MP
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 (___) [___] __, __; HP+10%
    -- HP from belt                                                      313
    -- 67 PDT / 62 MDT, 641 MEVA (804 Defense) [1095/1408 HP] 13 Block, 5 Counter

    -- head="Chevalier's Armet +3",                    -- 11/11, 103 (148) [145] __, __; 8% Dmg to MP
    -- legs={name="Chevalier's Cuisses +3",priority=1},-- 13/13, 136 (160) [127] __, __; Retain enmity
    -- HP from belt                                                         315
    -- 69 PDT / 64 MDT, 661 MEVA (824 Defense) [1115/1430 HP] 13 Block, 5 Counter
  }

  -- Add Counter stats, still focused on defense and tankiness
  sets.HeavyDef.Engaged = {
    main="Burtgang",
    sub="Duban",
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ (___) [___] __, __; Resist Status+11
    head="Chevalier's Armet +2",                    -- 10/10,  93 (138) [135] __, __; 7% Dmg to MP
    body="Sakpata's Breastplate",                   -- 10/10, 139 (194) [136] __, __; Resist Status+15
    hands={name=gear.Souveran_C_hands.name,
      augments=gear.Souveran_C_hands.augments,
      priority=1},                                  -- __/ 5,  48 (112) [239] __, __; Cure received+15%
    legs="Chevalier's Cuisses +2",                  -- 12/12, 126 (150) [117] __, __; Retain enmity
    feet="Sakpata's Leggings",                      --  6/ 6, 150 (125) [ 68]  5,  5
    neck="Bathy Choker +1",                         -- __/__, ___ ( 10) [ 35] __, 10; Regen+3
    ear1="Arete del Luna +1",                       -- __/__, ___ (___) [___] __, __; Resists
    ear2={name="Cryptic Earring",priority=1},       -- __/__, ___ (___) [ 40] __,  3
    ring1={name="Gelatinous Ring +1",priority=1},   --  7/-1, ___ (___) [135] __, __
    ring2={name="Moonlight Ring",priority=1},       --  5/ 5, ___ (___) [110] __, __
    back=gear.PLD_Counter_Cape,                     -- __/__,  20 ( 20) [ 80]  3, 10; 5% Dmg to MP
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 (___) [___] __, __; HP+10%
    -- HP from belt                                                      313
    -- 56 PDT / 53 MDT, 591 MEVA (749 Defense) [1095/1408 HP] 8 Block, 28 Counter
    
    -- head="Chevalier's Armet +3",                    -- 11/11, 103 (148) [145] __, __; 8% Dmg to MP
    -- legs={name="Chevalier's Cuisses +3",priority=1},-- 13/13, 136 (160) [127] __, __; Retain enmity
    -- HP from belt                                                         315
    -- 58 PDT / 55 MDT, 611 MEVA (769 Defense) [1115/1430 HP] 8 Block, 28 Counter
  }

  sets.LightDef = {
    head="Chevalier's Armet +2",          -- 10/10,  93
    hands="Chevalier's Gauntlets +3",     -- 11/11,  98
    legs="Chevalier's Cuisses +2",        -- 12/12, 126
    ring2="Defending Ring",               -- 10/10, ___
    -- 43 PDT / 43 MDT, 317 MEVA

    -- head="Chevalier's Armet +3",       -- 11/11, 103
    -- legs="Chevalier's Cuisses +3",     -- 13/13, 136
    -- 45 PDT / 45 MDT, 337 MEVA
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
  }
  sets.latent_regen = {
    hands="Regal Gauntlets", --10
    neck="Bathy Choker +1", --3
    ear1="Infused Earring", --1
    ring1="Chirich Ring +1", --2
  }
  sets.latent_refresh = {
    ammo="Homiliary", --1
    hands="Regal Gauntlets", --1
    neck="Sibyl Scarf", --1
    ring1="Stikini Ring +1", --1
    -- ring2="Stikini Ring +1",
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.idle = set_combine(sets.defense.MDT, {})

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

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.LightDef)

  sets.idle.Town = set_combine(sets.idle.Regain.Regen.Refresh, {
    sub="Priwen",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA = set_combine(sets.Enmity, {})

  sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {
    legs="Caballarius Breeches +3", -- Duration +10s; +1 is acceptable
  })

  -- Scales off MND
  sets.precast.JA['Chivalry'] = set_combine(sets.Enmity, {
    hands="Caballarius Gauntlets +2", -- Increases MP restored; +1 is acceptable
    -- hands="Caballarius Gauntlets +3", -- Increases MP restored; +1 is acceptable
  })

  sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {
    body="Caballarius Surcoat +1", -- Increase duration based on merits; +1 is acceptable
    -- body="Caballarius Surcoat +3", -- Increase duration based on merits; +1 is acceptable
  })

  sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {
    head="Caballarius Coronet +1", -- Duration +30s; +1 is acceptable
    -- head="Caballarius Coronet +3", -- Duration +30s; +1 is acceptable
  })

  sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {
    hands="Caballarius Gauntlets +2", -- Increase damage, add Dispel effect; +2 is acceptable
    -- hands="Caballarius Gauntlets +3", -- Increase damage, add Dispel effect; +2 is acceptable
  })

  sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {
    feet="Reverence Leggings +2", -- Duration +50%, potency +2%; +1 is acceptable
    -- feet="Reverence Leggings +3", -- Duration +50%, potency +2%; +1 is acceptable
  })

  sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, {
    feet="Chevalier's Sabatons +2", -- Increase enmity bonus
    -- feet="Chevalier's Sabatons +3", -- Increase enmity bonus
  })


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    main="Sakpata's Sword",                               -- {10}
    sub=gear.Nibiru_Shield_B,                             -- { 7}
    ammo="Sapience Orb",                                  -- { 2} __/__, ___ [___]
    head="Chevalier's Armet +2",                          -- { 8} 10/10,  93 [135]
    body={name="Reverence Surcoat +3", priority=1},       -- {10} 11/11,  68 [254]
    hands=gear.Leyline_Gloves,                            -- { 8} __/__,  62 [ 25]
    legs="Sakpata's Cuisses",                             -- {__}  9/ 9, 150 [114]
    feet="Chevalier's Sabatons +2",                       -- {10} __/__, 126 [ 42]
    neck={name="Unmoving Collar +1", priority=1},         -- {__} __/__, ___ [200]
    ear1="Loquacious Earring",                            -- { 2} __/__, ___ [___]
    ear2="Enchanter's Earring +1",                        -- { 2} __/__, ___ [___]
    ring1="Gelatinous Ring +1",                           -- {__}  7/-1, ___ [135]
    ring2="Kishar Ring",                                  -- { 4} __/__, ___ [___]
    back=gear.PLD_FC_Cape,                                -- {10} 10/__,  20 [ 80]
    waist={name="Platinum Moogle Belt",priority=1},       -- {__}  3/ 3,  15 [___]; HP+10%
    -- HP from belt                                                           302
    -- 73% Fast Cast, 50 PDT/32 MDT, 534 M.Eva [985/1287 HP]

    -- head="Chevalier's Armet +3",                       -- { 9} 11/11, 103 [145]
    -- feet="Chevalier's Sabatons +3",                    -- {13} __/__, 136 [ 52]
    -- HP from belt                                                           304
    -- 77% Fast Cast, 51 PDT/33 MDT, 554 M.Eva [1005/1309 HP]
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Oshasha's Treatise",                      -- __,  5,  5,  3, __ [__/__, ___] ___
    head=gear.Nyame_B_head,                         -- 26, 65, 50, 11, __ [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,                         -- 45, 65, 40, 13, __ [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,                       -- 17, 65, 40, 11, __ [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,                         -- 58, 65, 40, 12, __ [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,                         -- 23, 65, 53, 11, __ [ 7/ 7, 150]  68
    neck="Fotia Gorget",                            -- __, __, 10, __, __ [__/__, ___] ___; FTP+0.1
    ear1="Moonshade Earring",                       -- __, __,  4, __, __ [__/__, ___] ___; TP Bonus+250
    ear2="Lugra Earring +1",                        -- 16, __, __, __, __ [__/__, ___] ___
    ring1="Ephramad's Ring",                        -- 10, 20, 20, __, 10 [__/__, ___] ___
    ring2="Epaminondas's Ring",                     -- __, __, __,  5, __ [__/__, ___] ___
    back=gear.PLD_Enmity_Cape,                      -- __, __, __, __, __ [10/__, ___]  80
    waist="Sailfi Belt +1",                         -- 15, 15, __, __, __ [__/__, ___] ___
    -- 210 STR, 365 Attack, 262 Accuracy, 66 WSD, 10 PDL [48 PDT/38 MDT, 674 M.Eva] 580 HP

    -- back=gear.PLD_WS1_Cape,                      -- 30, 20, 20, 10, __ [10/__, ___] ___
    -- 240 STR, 385 Attack, 282 Accuracy, 76 WSD, 10 PDL [48 PDT/38 MDT, 674 M.Eva] 500 HP
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Thrud Earring",                           -- 10, __, __,  3, __ [__/__, ___] ___
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Oshasha's Treatise",                      -- __,  5,  5,  3, __ [__/__, ___] ___
    head="Sakpata's Helm",                          -- 33, 70, 55, __,  5 [ 7/ 7, 123]  91
    body="Sakpata's Breastplate",                   -- 42, 70, 55, __,  8 [10/10, 139] 136
    hands="Sakpata's Gauntlets",                    -- 24, 70, 55, __,  6 [ 8/ 8, 112]  91
    legs="Sakpata's Cuisses",                       -- 53, 70, 55, __,  7 [ 9/ 9, 150] 114
    feet="Sakpata's Leggings",                      -- 29, 70, 55, __,  4 [ 6/ 6, 150]  68
    neck="Fotia Gorget",                            -- __, __, 10, __, __ [__/__, ___] ___; FTP+0.1
    ear1="Moonshade Earring",                       -- __, __,  4, __, __ [__/__, ___] ___; TP Bonus+250
    ear2="Lugra Earring +1",                        -- 16, __, __, __, __ [__/__, ___] ___
    ring1="Ephramad's Ring",                        -- 10, 20, 20, __, 10 [__/__, ___] ___
    ring2="Epaminondas's Ring",                     -- __, __, __,  5, __ [__/__, ___] ___
    back=gear.PLD_Enmity_Cape,                      -- __, __, __, __, __ [10/__, ___]  80
    waist="Sailfi Belt +1",                         -- 15, 15, __, __, __ [__/__, ___] ___
    -- 222 STR, 390 Attack, 314 Accuracy, 8 WSD, 40 PDL [50 PDT/40 MDT, 674 M.Eva] 580 HP

    -- back=gear.PLD_WS1_Cape,                      -- 30, 20, 20, 10, __ [10/__, ___] ___
    -- 252 STR, 410 Attack, 334 Accuracy, 18 WSD, 40 PDL [50 PDT/40 MDT, 674 M.Eva] 500 HP
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",                           -- 10, __, __,  3, __ [__/__, ___] ___
  })
  sets.precast.WS.Safe = set_combine(sets.Enmity, {
    ammo="Oshasha's Treatise",                      -- __,  5,  5,  3, __ [__/__, ___] ___
    head=gear.Nyame_B_head,                         -- 26, 65, 50, 11, __ [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,                         -- 45, 65, 40, 13, __ [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,                       -- 17, 65, 40, 11, __ [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,                         -- 58, 65, 40, 12, __ [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,                         -- 23, 65, 53, 11, __ [ 7/ 7, 150]  68
    neck={name="Unmoving Collar +1", priority=1},   -- __, __,  5, __, __ [__/__, ___] 200
    ear1="Moonshade Earring",                       -- __, __,  4, __, __ [__/__, ___] ___; TP Bonus+250
    ear2="Chevalier's Earring +1",                  -- __, __, 12, __, __ [ 4/ 4, ___] ___
    ring1={name="Gelatinous Ring +1", priority=1},  -- __, __, __, __, __ [ 7/-1, ___] 135
    ring2="Epaminondas's Ring",                     -- __, __, __,  5, __ [__/__, ___] ___
    back={name="Moonlight Cape", priority=1},       -- __, __, __, __, __ [ 6/ 6, ___] 275
    waist={name="Platinum Moogle Belt", priority=1},-- __, __, __, __, __ [ 3/ 3,  15] ___
    -- HP from belt                                                                    314
    -- 169 STR, 330 Attack, 249 Accuracy, 66 WSD, 0 PDL [58 PDT/50 MDT, 689 M.Eva] 1110/1424 HP

    -- ear2="Chevalier's Earring +2",               -- 15, __, 20, __, __ [ 8/ 8, ___] ___
    -- 184 STR, 330 Attack, 257 Accuracy, 66 WSD, 0 PDL [62 PDT/54 MDT, 689 M.Eva] 1110/1424 HP
  })
  sets.precast.WS.SafeMaxTP = set_combine(sets.precast.WS.Safe, {
    ear1="Lugra Earring +1",                        -- 16, __, __, __, __ [__/__, ___] ___
  })

  sets.precast.WS['Atonement'] = set_combine(sets.Enmity, {})

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",          -- __, 11, __, __, __ [__/__, ___] ___
    head=gear.Nyame_B_head,             -- 25, 28, 11, 30, 40 [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,             -- 24, 42, 13, 30, 40 [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,           -- 42, 28, 11, 30, 40 [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,             -- __, 44, 12, 30, 40 [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,             -- 26, 25, 11, 30, 40 [ 7/ 7, 150]  68
    neck="Sibyl Scarf",                 -- __, 10, __, 10, __ [__/__, ___] ___
    ear1="Friomisi Earring",            -- __, __, __, 10, __ [__/__, ___] ___
    ear2="Novio Earring",               -- __, __, __,  7, __ [__/__, ___] ___
    ring1="Metamorph Ring +1",          -- __, 16, __, __, 16 [__/__, ___] -60
    ring2="Shiva Ring +1",              -- __,  9, __,  3, __ [__/__, ___] ___
    back="Moonlight Cape",              -- __, __, __, __, __ [ 6/ 6, ___] 275
    waist="Skrymir Cord",               -- __, __, __,  5,  5 [__/__, ___] ___
    -- 117 DEX, 213 INT, 58 WSD, 185 MAB, 221 M.Acc [44 PDT/44 MDT, 674 M.Eva] 715 HP
    
    -- back=gear.PLD_WS2_Cape,          -- __, 30, __, 10, 20 [10/__, ___] ___
    -- 117 DEX, 236 INT, 58 WSD, 199 MAB, 249 M.Acc [48 PDT/38 MDT, 674 M.Eva] 440 HP
  })
  sets.precast.WS['Aeolian Edge'].Safe = set_combine(sets.precast.WS['Aeolian Edge'], {
    ammo="Ghastly Tathlum +1",                      -- __, 11, __, __, __ [__/__, ___] ___
    head=gear.Nyame_B_head,                         -- 25, 28, 11, 30, 40 [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,                         -- 24, 42, 13, 30, 40 [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,                       -- 42, 28, 11, 30, 40 [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,                         -- __, 44, 12, 30, 40 [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,                         -- 26, 25, 11, 30, 40 [ 7/ 7, 150]  68
    neck={name="Unmoving Collar +1",priority=1},    -- __, __, __, __, __ [__/__, ___] 200
    ear1="Friomisi Earring",                        -- __, __, __, 10, __ [__/__, ___] ___
    ear2="Novio Earring",                           -- __, __, __,  7, __ [__/__, ___] ___
    ring1={name="Gelatinous Ring +1",priority=1},   -- __, __, __, __, __ [ 7/-1, ___] 135
    ring2="Shiva Ring +1",                          -- __,  9, __,  3, __ [__/__, ___] ___
    back={name="Moonlight Cape",priority=1},        -- __, __, __, __, __ [ 6/ 6, ___] 275
    waist={name="Platinum Moogle Belt",priority=1}, -- __, __, __, __, __ [ 3/ 3,  15] ___
    -- HP from belt                                                                    314
    -- 117 DEX, 187 INT, 58 WSD, 170 MAB, 200 M.Acc [54 PDT/46 MDT, 1110 M.Eva] 1110/1424 HP
  })
  sets.precast.WS['Aeolian Edge'].SafeMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].Safe, {})


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

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

  -- SIRD_options                           PDT/MDT, M.Eva [HP] {SIRD} Enmity
  -- ammo="Staunch Tathlum +1",                   --  3/ 3, ___ [___] {11} __
  -- head=gear.Souveran_C_head,                   -- __/__,  53 [280] {20}  9
  -- hands="Regal Gauntlets",                     -- __/__,  48 [205] {10} __
  -- body="Chevalier's Cuirass +3",               -- __/__, 119 [151] {20} 16; Bugged, don't use in dynamis
  -- legs=gear.Carmine_A_legs,                    -- __/__,  80 [130] {20} __
  -- legs=gear.Founders_Hose,                     -- __/__,  80 [ 54] {30} __
  -- legs="Caballarius Breeches +3",              --  7/__,  84 [ 72] {10}  9
  -- feet=gear.Odyssean_Enmity_feet,              -- __/__,  86 [ 20] {20}  8
  -- neck="Moonlight Necklace",                   -- __/__,  15 [___] {15} 15
  -- ear1="Magnetic Earring",                     -- __/__, ___ [___] { 8} __
  -- ear1="Knightly Earring",                     -- __/__, ___ [___] { 9} __
  -- ear1="Halasz Earring",                       -- __/__, ___ [___] { 5} __
  -- back=gear.PLD_SIRD_Cape,                     -- 10/__,  20 [ 80] {10} __
  -- waist="Audumbla Sash",                       --  4/__, ___ [___] {10} __

  sets.midcast.Protect = {
    main="Burtgang",
    sub="Srivatsa",                                 -- Shield def is added to Protect potency
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] {11} __
    head={name=gear.Souveran_C_head.name,
    augments=gear.Souveran_C_head.augments,
    priority=1},                                    -- __/__,  53 [280] {20} __
    body="Shabti Cuirass +1",                       -- __/__,  42 [115] {__} 10
    hands={name="Regal Gauntlets", priority=1},     -- __/__,  48 [205] {10} 20
    legs=gear.Founders_Hose,                        -- __/__,  80 [ 54] {30} __
    feet={name=gear.Souveran_C_feet.name,
      augments=gear.Souveran_C_feet.augments,
      priority=1},                                  --  5/__,  86 [227] {__} __
    neck="Moonlight Necklace",                      -- __/__,  15 [___] {15} __
    ear1="Magnetic Earring",                        -- __/__, ___ [___] { 8} __
    ear2="Chevalier's Earring +1",                  --  4/ 4, ___ [___] {__} __
    ring1={name="Gelatinous Ring +1", priority=1},  --  7/-1, ___ [135] {__} __; Enhances Protect/Shell
    ring2="Defending Ring",                         -- 10/10, ___ [___] {__} __
    back=gear.PLD_Enmity_Cape,                      -- 10/__,  20 [ 80] {__} __
    waist={name="Platinum Moogle Belt", priority=1},--  3/ 3,  15 [___] {__} __; HP+10%
    -- SIRD merits                                                      { 8}
    -- HP from belt                                                313
    -- 42 PDT / 19 MDT, 359 M.Eva [1096/1409 HP] {102 SIRD} 30 Enh Duration
    
    -- ear2="Chevalier's Earring +2",               --  8/ 8, ___ [___] {__} __
    -- 46 PDT / 23 MDT, 359 M.Eva [1096/1409 HP] {102 SIRD} 30 Enh Duration
  }
  sets.midcast.Shell = set_combine(sets.midcast.Protect, {})

  -- Phalanx Tiers: 300, 329, 358, 386, 415, 443, 472, 500
  --                +28  +29  +30  +31  +32  +33  +34  +35
  sets.midcast['Phalanx'] = {
    main="Sakpata's Sword",                         -- 4, ___, __ [10/10, ___] 100
    sub="Priwen",                                   -- 2, ___, __ [ 6/ 6, ___]  30
    ammo="Staunch Tathlum +1",                      -- _, ___, 11 [ 3/ 3, ___] ___
    head=gear.Odyssean_Phalanx_head,                -- 3, ___, __ [ 2/__,  53] 112
    body=gear.Valorous_Phalanx_body,                -- 4, ___, __ [ 2/__,  59]  61
    hands={name=gear.Souveran_C_hands.name,
      augments=gear.Souveran_C_hands.augments,
      priority=1},                                  -- 5, ___, __ [__/ 5,  48] 239
    legs="Sakpata's Cuisses",                       -- 5, ___, __ [ 9/ 9, 150] 114
    feet={name=gear.Souveran_C_feet.name,
      augments=gear.Souveran_C_feet.augments,
      priority=1},                                  -- 5, ___, __ [ 5/__,  86] 227
    neck="Incantor's Torque",                       -- _,  10, __ [__/__, ___] ___
    ear1="Mimir Earring",                           -- _,  10, __ [__/__, ___] ___
    ear2="Chevalier's Earring +1",                  -- _, ___, __ [ 4/ 4, ___] ___
    ring1="Stikini Ring +1",                        -- _,   8, __ [__/__, ___] ___
    ring2="Stikini Ring +1",                        -- _,   8, __ [__/__, ___] ___
    back={name="Moonlight Cape",priority=1},        -- _, ___, __ [ 6/ 6, ___] 275
    waist={name="Platinum Moogle Belt",priority=1}, -- _, ___, __ [ 3/ 3,  15] ___; HP+10%
    -- Base/Traits/Gifts                               _, 350,  8 [__/__, ___] ___
    -- Master Levels                                        0
    -- HP from belt                                                            319
    -- 28 Phalanx, 386 Enh Skill, 19% SIRD [50 PDT/46 MDT, 411 M.Eva] 1158/1477 HP
    -- 59 Total Phalanx

    -- main="Sakpata's Sword",                         -- 4, ___, __ [10/10, ___] 100
    -- sub="Priwen",                                   -- 2, ___, __ [ 6/ 6, ___]  30
    -- ammo="Staunch Tathlum +1",                      -- _, ___, 11 [ 3/ 3, ___] ___
    -- head=gear.Odyssean_Phalanx_head,                -- 5, ___, __ [ 2/__,  53] 112
    -- body=gear.Valorous_Phalanx_body,                -- 5, ___, __ [ 2/__,  59]  61
    -- hands={name=gear.Souveran_C_hands.name,
    --   augments=gear.Souveran_C_hands.augments,
    --   priority=1},                                  -- 5, ___, __ [__/ 5,  48] 239
    -- legs="Sakpata's Cuisses",                       -- 5, ___, __ [ 9/ 9, 150] 114
    -- feet={name=gear.Souveran_C_feet.name,
    --   augments=gear.Souveran_C_feet.augments,
    --   priority=1},                                  -- 5, ___, __ [ 5/__,  86] 227
    -- neck="Moonlight Necklace",                      -- _, ___, 15 [__/__,  15] ___
    -- ear1="Magnetic Earring",                        -- _, ___,  8 [__/__, ___] ___
    -- ear2="Chevalier's Earring +2",                  -- _, ___, __ [ 8/ 8, ___] ___
    -- ring1="Stikini Ring +1",                        -- _,   8, __ [__/__, ___] ___
    -- ring2="Stikini Ring +1",                        -- _,   8, __ [__/__, ___] ___
    -- back={name="Moonlight Cape",priority=1},        -- _, ___, __ [ 6/ 6, ___] 275
    -- waist={name="Platinum Moogle Belt",priority=1}, -- _, ___, __ [ 3/ 3,  15] ___; HP+10%
    -- Base/Traits/Gifts                                  _, 350,  8 [__/__, ___] ___
    -- Master Levels                                          50
    -- HP from belt                                                               319
    -- 31 Phalanx, 416 Enh Skill, 42% SIRD [50 PDT/50 MDT, 426 M.Eva] 1158/1477 HP
    -- 63 Total Phalanx
  }

  sets.SIRDPhalanx = {
    main="Sakpata's Sword",                         -- 4, ___, __ [10/10, ___] 100
    sub="Priwen",                                   -- 2, ___, __ [ 6/ 6, ___]  30
    ammo="Staunch Tathlum +1",                      -- _, ___, 11 [ 3/ 3, ___] ___
    head={name=gear.Souveran_C_head.name,
      augments=gear.Souveran_C_head.augments,
      priority=1},                                  -- _, ___, 20 [__/__,  53] 280
    body=gear.Valorous_Phalanx_body,                -- 4, ___, __ [ 2/__,  59]  61
    hands={name="Regal Gauntlets",priority=1},      -- _, ___, 10 [__/__,  48] 205
    legs=gear.Founders_Hose,                        -- _, ___, 30 [__/__,  80]  54
    feet={name=gear.Souveran_C_feet.name,
      augments=gear.Souveran_C_feet.augments,
      priority=1},                                  -- 5, ___, __ [ 5/__,  86] 227
    neck="Moonlight Necklace",                      -- _, ___, 15 [__/__,  15] ___
    ear1="Magnetic Earring",                        -- _, ___,  8 [__/__, ___] ___
    ear2="Chevalier's Earring +1",                  -- _, ___, __ [ 4/ 4, ___] ___
    ring1={name="Gelatinous Ring +1",priority=1},   -- _, ___, __ [ 7/-1, ___] 135
    ring2="Defending Ring",                         -- _, ___, __ [10/10, ___] ___
    back=gear.PLD_Enmity_Cape,                      -- _, ___, __ [10/__, ___]  80
    waist={name="Platinum Moogle Belt",priority=1}, -- _, ___, __ [ 3/ 3,  15] ___; HP+10%
    -- SIRD merits                                              8
    -- HP from belt                                                            321
    -- 15 Phalanx, 416 Enh Skill, 102% SIRD [44 PDT/19 MDT, 356 M.Eva] 1172/1493 HP

    -- body=gear.Valorous_Phalanx_body,             -- 5, ___, __ [ 2/__,  59]  61
    -- 16 Phalanx, 416 Enh Skill, 102% SIRD [44 PDT/19 MDT, 356 M.Eva] 1172/1493 HP
  }

  sets.midcast['Enhancing Magic'] = set_combine(sets.Enmity, {})
  sets.midcast['Crusade'] = set_combine(sets.Enmity, {})
  sets.midcast['Reprisal'] = set_combine(sets.Enmity, {})
  sets.midcast['Aquaveil'] = set_combine(sets.Enmity, {})
  sets.midcast['Utsusemi'] = set_combine(sets.Enmity, {})

  sets.midcast['Foil'] = set_combine(sets.Enmity, {})
  sets.midcast['Geist Wall'] = set_combine(sets.Enmity, {})
  sets.midcast['Sheep Song'] = set_combine(sets.Enmity, {})
  sets.midcast['Bomb Toss'] = set_combine(sets.Enmity, {})
  sets.midcast['Poison'] = set_combine(sets.Enmity, {})
  sets.midcast['Poisonga'] = set_combine(sets.Enmity, {})
  sets.midcast['Banish'] = set_combine(sets.Enmity, {})
  sets.midcast['Dia'] = set_combine(sets.Enmity, {})

  sets.midcast.Flash = set_combine(sets.Enmity, {})

  -- cure_opts         MND, VIT, Heal skill, Cure Pot (self pot) [PDT/MDT, M.Eva] HP {SIRD} Enmity
  -- head=gear.Souveran_C_head,                   --  8, 38, __, __(15) [__/__,  53] 280 {20}  9
  -- head="Sakpata's Helm",                       -- 23, 40, __,  5(__) [ 7/ 7, 123]  91 {__} __
  -- body=gear.Souveran_C_body,                   -- 16, 32, __, 10(15) [10/10,  69] 171 {__} 20
  -- body="Sakata's Breastplate",                 -- 28, 42, __, __(10) [10/10, 139] 136 {__} __
  -- hands=gear.Souveran_C_hands,                 -- 21, 34, __, __(15) [__/ 5,  48] 239 {__}  9
  -- hands="Buremte Gloves",                      -- 26, 27, __, __(13) [__/__,  32]  19 {__} __
  -- legs=gear.Souveran_C_legs,                   -- 10, 23, __, __(23) [ 4/ 4,  86] 162 {__}  9
  -- feet=gear.Souveran_C_feet,                   --  7, 20, __, __(15) [ 5/__,  86] 227 {__}  9
  -- feet=gear.Odyssean_Cure_feet,                -- 10, 19, __, 13(__) [__/__,  86]  20 {20} __
  -- neck="Phalaina Locket",                      --  3, __, __,  4( 4) [__/__, ___] ___ {__} __
  -- neck="Sacro Gorget",                         -- __, __, __, 10(__) [__/__, ___]  50 {__}  5
  -- ear1="Mendicant's Earring",                  -- __, __, __,  5(__) [__/__, ___] ___ {__} __
  -- ear1="Nourishing Earring +1",                --  4, __, __,  7(__) [__/__, ___] ___ { 5} __
  -- ear2="Chevalier's Earring +2",               -- __, 15, __, 12(__) [ 8/ 8, ___] ___ {__} __
  -- ring1="Lebeche Ring",                        -- __, __, __,  3(__) [__/__, ___] ___ {__} -5
  -- ring1="Menelaus's Ring",                     -- __, __, 15,  5(__) [__/__, ___] ___ {__} __
  -- back=gear.PLD_Cure_Cape,                     -- 30, __, __, 10(__) [10/__,  20]  80 {__} __
  -- waist="Sroda Belt",                          -- __, __, __, 35(__) [__/__, ___] ___ {__} __; MP cost+25%
  -- waist="Gishdubar Sash",                      -- __, __, __, __(10) [__/__, ___] ___ {__} __

  sets.midcast.Cure = {
    main="Burtgang",
    sub="Srivatsa",
    ammo="Sapience Orb",                            -- __, __, __, __(__) [__/__, ___] ___ {__}  2
    head="Sakpata's Helm",                          -- 23, 40, __,  5(__) [ 7/ 7, 123]  91 {__} __
    body=gear.Souveran_C_body,                      -- 16, 32, __, 10(15) [10/10,  69] 171 {__} 20
    hands={name=gear.Souveran_C_hands.name,
      augments=gear.Souveran_C_hands.augments,
      priority=1},                                  -- 21, 34, __, __(15) [__/ 5,  48] 239 {__}  9
    legs="Caballarius Breeches +3",                 -- 27, 36, __, __(__) [ 7/__,  84]  72 {10}  9
    feet={name=gear.Souveran_C_feet.name,
      augments=gear.Souveran_C_feet.augments,
      priority=1},                                  --  7, 20, __, __(15) [ 5/__,  86] 227 {__}  9
    neck="Sacro Gorget",                            -- __, __, __, 10(__) [__/__, ___]  50 {__}  5
    ear1="Nourishing Earring +1",                   --  4, __, __,  7(__) [__/__, ___] ___ { 5} __
    ear2="Chevalier's Earring +1",                  -- __, __, __, 11(__) [ 4/ 4, ___] ___ {__} __
    ring1={name="Gelatinous Ring +1", priority=1},  -- __, 15, __, __(__) [ 7/-1, ___] 135 {__} __
    ring2="Menelaus's Ring",                        -- __, __, 15,  5(__) [__/__, ___] ___ {__} __
    back=gear.PLD_Enmity_Cape,                      -- 30, __, __, __(__) [10/__,  20]  80 {__} 10
    waist={name="Platinum Moogle Belt",priority=1}, -- __, __, __, __(__) [ 3/ 3,  15] ___ {__} __; HP+10%
    -- HP from belt                                                                    289
    -- SIRD merits                                                                         { 8}
    -- Base stats                                     109,109,415
    -- ML1                                              1,  1,  1
    -- 238 MND, 287 VIT, 431 Heal skill, 48 Cure Pot (45 self pot) [53 PDT/28 MDT, 445 M.Eva] 1065/1354 HP {23 SIRD} 64 Enmity
    -- Power = 621, 608 cure 4 base
    
    -- ear2="Chevalier's Earring +2",               -- __, 15, __, 12(__) [ 8/ 8, ___] ___ {__} __
    -- HP from belt                                                                    310
    -- ML30                                            30, 30, 30
    -- 267 MND, 331 VIT, 460 Heal skill, 49 Cure Pot (45 self pot) [57 PDT/32 MDT, 445 M.Eva] 1065/1375 HP {23 SIRD} 64 Enmity
    -- Power = 675, 630 cure 4 base
  }

  sets.SIRDCure = set_combine(sets.midcast.Cure, {
    main="Burtgang",
    sub="Sacro Bulwark",
    ammo="Staunch tathlum +1",                      -- __, __, __, __(__) [ 3/ 3, ___] ___ {11} __
    head={name=gear.Souveran_C_head.name,
      augments=gear.Souveran_C_head.augments,
      priority=1},                                  --  8, 38, __, __(15) [__/__,  53] 280 {20}  9
    body=gear.Souveran_C_body,                      -- 16, 32, __, 11(15) [10/10,  69] 171 {__} 20
    hands={name="Regal Gauntlets",priority=1},      -- 40, 40, __, __(__) [__/__,  48] 205 {10} __
    legs="Founder's Hose",                          -- 25, 28, __, __(__) [__/__,  80]  54 {30} __
    feet=gear.Odyssean_Cure_feet,                   -- 10, 19, __, 13(__) [__/__,  86]  20 {20} __
    neck={name="Unmoving Collar +1", priority=1},   -- __,  9, __, __(__) [__/__, ___] 200 {__} 10
    ear1="Nourishing Earring +1",                   --  4, __, __,  7(__) [__/__, ___] ___ { 5} __
    ear2="Chevalier's Earring +1",                  -- __, __, __, 11(__) [ 4/ 4, ___] ___ {__} __
    ring1={name="Gelatinous Ring +1", priority=1},  -- __, 15, __, __(__) [ 7/-1, ___] 135 {__} __
    ring2="Defending Ring",                         -- __, __, __, __(__) [10/10, ___] ___ {__} __
    back=gear.PLD_Enmity_Cape,                      -- 30, __, __, __(__) [10/__,  20]  80 {__} 10
    waist={name="Platinum Moogle Belt",priority=1}, -- __, __, __, __(__) [ 3/ 3,  15] ___ {__} __; HP+10%
    -- HP from belt                                                                    297
    -- SIRD merits                                                                         { 8}
    -- Base stats                                     109,109,415
    -- ML1                                              1,  1,  1
    -- 243 MND, 291 VIT, 416 Heal skill, 42 Cure Pot (30 self pot) [47 PDT/29 MDT, 371 M.Eva] 1145/1442 HP {104 SIRD} 49 Enmity
    -- Power = 609, 603 cure 4 base

    -- ear2="Chevalier's Earring +2",               -- __, 15, __, 12(__) [ 8/ 8, ___] ___ {__} __
    -- HP from belt                                                                    318
    -- ML30                                            30, 30, 30
    -- 272 MND, 335 VIT, 445 Heal skill, 43 Cure Pot (30 self pot) [51 PDT/33 MDT, 371 M.Eva] 1145/1463 HP {104 SIRD} 49 Enmity
    -- Power = 664, 625 cure 4 base
  })

  sets.midcast['Blue Magic'] = {}
  sets.midcast.BLUEnmity = set_combine(sets.Enmity, {})
  -- BLU cures are affected by MND, VIT, and blue skill. The MND has BY FAR the greatest effect.
  -- Ignore skill entirely. It only seems to give curing at 1/10 the rate, MND is at least 3x better.
  sets.midcast.BLUCure = set_combine(sets.midcast.Cure, {})
  sets.midcast.BLUBuffs = set_combine(sets.Enmity, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",             -- 10,  3, __, __ < 3, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 25, __, 50,  6 < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,           -- 24, __, 50,  3 < 7, __, __> [ 9/ 9, 139] 136
    hands="Sakpata's Gauntlets",      -- 35,  8, 55,  4 < 6, __, __> [ 8/ 8, 112]  91
    legs=gear.Odyssean_STP_legs,      -- __, 13, 15,  5 < 2, __, __> [__/__,  86]  54
    feet=gear.Carmine_D_feet,         -- 16,  8, __,  4 < 4, __, __> [ 4/__,  80]  95
    neck="Ainia Collar",              -- __,  8,-10, __ <__, __, __> [__/__, ___] ___
    ear1="Telos Earring",             -- __,  5, 10, __ < 1, __, __> [__/__, ___] ___
    ear2="Dedition Earring",          -- __,  8,-10, __ <__, __, __> [__/__, ___] ___
    ring1="Chirich Ring +1",          -- __,  6, 10, __ <__, __, __> [__/__, ___] ___
    ring2="Chirich Ring +1",          -- __,  6, 10, __ <__, __, __> [__/__, ___] ___
    back=gear.PLD_TP_Cape,            -- 20, 10, 30, __ <__, __, __> [10/__, ___] ___
    waist="Kentarch Belt +1",         -- 10,  5, 14, __ < 3, __, __> [__/__, ___] ___
    -- 140 DEX, 80 STP, 224 Acc, 22 Haste <31 DA, 0 TA, 0 QA> [38 PDT/24 MDT, 540 M.Eva] 467 HP
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    neck="Subtlety Spectacles",       -- __, __, 15, __ <__, __, __> [__/__, ___] ___
    ear2="Cessance Earring",          -- __,  3,  6, __ < 3, __, __> [__/__, ___] ___

    -- neck="Combatant's Torque",     -- __,  4, __, __ <__, __, __> [__/__, ___] ___; skill+15
    -- 140 DEX, 71 STP, 250 Acc, 22 Haste <34 DA, 0 TA, 0 QA> [38 PDT/24 MDT, 540 M.Eva] 467 HP
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    feet=gear.Nyame_B_feet,           -- 26, __, 53,  3 < 5, __, __> [ 7/ 7, 150]  68
    ear2="Dignitary's Earring",       -- __,  3, 10, __ <__, __, __> [__/__, ___] ___
    -- 150 DEX, 63 STP, 307 Acc, 21 Haste <32 DA, 0 TA, 0 QA> [41 PDT/31 MDT, 610 M.Eva] 440 HP
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    legs=gear.Nyame_B_legs,           -- __, __, 40,  5 < 6, __, __> [ 8/ 8, 150] 114
    waist="Olseni Belt",              -- __,  3, 20, __ <__, __, __> [__/__, ___] ___
    -- 140 DEX, 48 STP, 338 Acc, 21 Haste <33 DA, 0 TA, 0 QA> [49 PDT/39 MDT, 674 M.Eva] 500 HP
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, {})
  sets.engaged.LightDef.LowAcc = set_combine(sets.engaged.LowAcc, {})
  sets.engaged.LightDef.MidAcc = set_combine(sets.engaged.MidAcc, {})
  sets.engaged.LightDef.HighAcc = set_combine(sets.engaged.HighAcc, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { sub="Duban", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  -- Used to swap out Duban if low HP in certain conditions so the "soul drain" doesn't kill you
  sets.SafeShield = { sub="Priwen" }

  sets.defense.Phalanx = set_combine(sets.HeavyDef, sets.midcast.Phalanx)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.english == 'Rampart' then
    self_rampart = true
  end

  if runes:contains(spell.english) then
    eventArgs.handled = true
  end

  -- Use defensive "safe" sets if any are defined. Falls back to normal sets if a "safe" set is not defined.
  if state.DefenseMode.value ~= 'None'
      or (state.HybridMode.value ~= 'Normal' and player.in_combat)
      or (state.IdleMode.value ~= 'Normal' and not player.in_combat) then
    if spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' then
      classes.JAMode = 'Safe'
    elseif spell.action_type == 'Magic' then
      state.CastingMode:set('Safe')
    end
  end

  -- Cancel shadows if casting more shadows
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
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- Equip Reive set for ws if in a Reive
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  equip(select_weapons())

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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  -- Use Phalanx SIRD set if flag is set
  if spell.english == 'Phalanx' and enable_phalanx_sird then
    equip(sets.SIRDPhalanx)
  else
    -- Use SIRD set if you're not capped from merits + Rampart
    if not is_naturally_sird_capped() then
      -- Select proper midcast set for SIRD-defined spells and spell maps
      local setname = midcast_SIRD_sets[spell.english] or midcast_SIRD_sets[spellMap] or nil

      if setname and sets[setname] then
        equip(sets[setname])
      end
    end

    -- Override with weapons to be equipped
    equip(select_weapons())
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

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  classes.JAMode = nil
  state.CastingMode:reset()

  enable_phalanx_sird = false

  if spell.interrupted then
    if spell.english == 'Rampart' then
      self_rampart = false
    end
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  equip(select_weapons())

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
  if buff == "terror" then
    if gain then
      equip(sets.defense.PDT)
    end
  end

  if buff == 'sleep' and gain and player.vitals.hp > 1000 then
    equip(sets.SleepyHead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  if buff == 'Rampart' and not gain then
    self_rampart = false
  end

  -- Update gear for these specific buffs
  if buff == "terror" or buff == "doom" then
    status_change(player.status)
  end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
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
  if buffactive['terror'] then
    idleSet = set_combine(idleSet, sets.defense.PDT)
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
  
  if has_soul_drain_shield and player.hp < 10 then
    idleSet =  set_combine(idleSet, sets.SafeShield)
  end
  
  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if buffactive['terror'] then
    meleeSet = set_combine(meleeSet, sets.defense.PDT)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 1000 then
    meleeSet = set_combine(meleeSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  meleeSet = set_combine(meleeSet, select_weapons())
  
  if has_soul_drain_shield and player.hp < 10 then
    meleeSet =  set_combine(meleeSet, sets.SafeShield)
  end
  
  return meleeSet
end

function customize_defense_set(defenseSet)
  -- Swap to "engaged" tank set if defense mode is engaged and weapon is drawn
  if player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.HeavyDef.Engaged)
  end

  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 1000 then
    defenseSet = set_combine(defenseSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end
  
  -- Allow weapon swaps for Phalanx
  if state[state.DefenseMode.value .. 'DefenseMode'].value ~= 'Phalanx' then
    defenseSet = set_combine(defenseSet, select_weapons())
  end

  -- Use town idle set even if in defense mode
  if areas.Cities:contains(world.area) then
    defenseSet =  set_combine(defenseSet, sets.idle.Town)
  end
  
  if has_soul_drain_shield and player.hp < 10 then
    defenseSet =  set_combine(defenseSet, sets.SafeShield)
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


  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(1, string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
  if spell.skill == 'Blue Magic' then
    for category,spell_list in pairs(blue_magic_maps) do
      if spell_list:contains(spell.english) then
        return category
      end
    end
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if state.DefenseMode.value ~= 'None' then
    wsmode = 'Safe'
  else
    if player.tp > 2900 then
      wsmode = wsmode..'MaxTP'
    end
  end

  return wsmode
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine base mode
  if state.DefenseMode.value ~= 'None' then
    wsmode = 'Safe'
  elseif state.AttCapped.value then
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

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_sub_weapons(cycle_dir, set_name)
  if cycle_dir == 'forward' then
    state.SubWeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.SubWeaponSet:cycleback()
  elseif cycle_dir == 'set' then
    state.SubWeaponSet:set(set_name)
  else
    state.SubWeaponSet:reset()
  end

  add_to_chat(141, 'Sub Weapon Set to '..string.char(31,1)..state.SubWeaponSet.current)
  equip(select_weapons())
end

function select_weapons()
  local set = {}
  if sets.WeaponSet[state.WeaponSet.current] then
    set = set_combine(set, sets.WeaponSet[state.WeaponSet.current])
  end
  if sets.SubWeaponSet[state.SubWeaponSet.current] then
    set = set_combine(set, sets.SubWeaponSet[state.SubWeaponSet.current])
  end

  return set
end

function check_for_prime_shield()
  local my_items = windower.ffxi.get_items()
  for bag_name, contents in pairs(my_items) do
    if contents and type(contents) == 'table' then
      for _, item in pairs(contents) do
        if item and type(item) == 'table' and (item.id == 26491 or item.id == 26492) then
          -- Is a soul draining shield
          has_soul_drain_shield = true
          break
        end
      end
      if has_soul_drain_shield then break end
    end
  end
end

function is_naturally_sird_capped()
  return self_rampart and player.merits.iron_will == 5 and player.merits.spell_interruption_rate >= 4
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

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'phalanxsird' then
    if not is_naturally_sird_capped() then
      enable_phalanx_sird = true
    end
    send_command('@input /ma "Phalanx <me>')
  elseif cmdParams[1] == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_weapons('set', cmdParams[3])
    else
      cycle_weapons(cmdParams[2])
    end
  elseif cmdParams[1] == 'subweaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_sub_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_sub_weapons('back')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_sub_weapons('set', cmdParams[3])
    else
      cycle_sub_weapons(cmdParams[2])
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
end

windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
end)

windower.raw_register_event('action', function(act)
  if act.param == 92 and act.actor_id ~= player.id then -- Someone besides self is using Rampart
    for k,v in pairs(act.targets) do
      if v and v.id and v.id == player.id and param ~= 0 then -- If you are hit with it, set self_rampart flag
        self_rampart = false
        break
      end
    end
  end
end)

timer = os.clock()
windower.raw_register_event('prerender',function()
  now = os.clock()
  -- Every 3 seconds, check if Rampart is off and reset flag if it's still on
  if now - timer > 3 then
    timer = now
    if self_rampart and not buffactive['Rampart'] then
      self_rampart = false
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'WAR' then
    set_macro_page(2, 7)
  else
    set_macro_page(1, 7)
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
