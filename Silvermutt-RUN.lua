--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: Cancel, Timers
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
* Offense Mode: Changes melee accuracy level
* Hybrid Mode: Changes damage taken level while engaged
  * HeavyDef: Higher defense than "Normal" mode
  * Normal: Lower defense, more offense
* Casting Mode: Changes casting type. This is toggled automatically on this job. Do not try to control it manually.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
  * While there is both a PDT and MDT mode, there is no difference between them in this file. As long as either is
    enabled, defensive gear will be used.
  * Encumbrance mode will lock you into the sets.Encumbrance set for everything, not even allowing JA swaps
    except for SPs. This is meant to be used in fights where you will spend a significant time Encumbered. This set
    has a good mix of stats for defense, resistances, and enmity to roughly cover most situations.
* Idle Mode: Determines which set to use when not engaged
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Runes: Select a rune to use when issuing the custom rune command.
* Death Resist: Equips death resistance gear.

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* There are separate keybinds for your offhand weapon called SubWeaponSet. This allows you to mix and match your
  weapons and grips/shields.
  * Sub weapon is only overridden when in Encumbrance PDT mode. The whole idea of the Encumbrance mode is to lock
    into this set for everything, not even allowing JA swaps. This forces a specific grip to stay equipped.

Abilities:
* If Valiance is attampted to be used but it is on cooldown, Vallation will be used instead. This allows combining
  a single macro to be used for both abilities simply by making a macro for Valiance.
* Activating Battuta will overlay the sets.defense.Parry set on top of your current defense set.

Spells
* Sets are built assuming at least 4/5 Spell Interruption Rate merits are enabled.
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
  [ WIN+F9 ]            Cycle Weaponskill Mode
  [ WIN+C ]             Toggle Capacity Points Mode
  [ CTRL+F8 ]           Toggle Attack Capped mode
  [ WIN+D ]             Toggle Death Resist Mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set
  [ CTRL+Home ]         Cycle Sub Weapon Sets
  [ CTRL+End ]          Cycleback Sub Weapon Sets
  [ ALT+End ]           Reset to default Sub Weapon Set

Spells:
  [ ALT+U ]             Blink
  [ ALT+I ]             Stoneskin
  [ ALT+O ]             Phalanx
  [ ALT+P ]             Aquaveil
  [ ALT+; ]             Regen IV
  [ ALT+' ]             Refresh
  [ ALT+Z ]             Temper
  [ ALT+, ]             Blaze Spikes
  [ ALT+. ]             Ice Spikes
  [ ALT+/ ]             Shock Spikes
  ============ /BLU ============
  [ ALT+Q ]             Wild Carrot
  [ ALT+W ]             Cocoon
  [ ALT+E ]             Refueling
  ============ /NIN ============
  [ ALT+Numpad0 ]       Utsusemi: Ichi
  [ ALT+Numpad. ]       Utsusemi: Ni

Abilities:
  [ CTRL+- ]            Cycleback Rune
  [ CTRL+= ]            Cycle Rune
  [ Numpad0 ]           Execute Rune
  [ ALT+` ]             Vivacious Pulse
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

gs c rune               Uses current rune
gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this
                        manually fixes it.
gs c equipweapons       Equips weapons based on your current states that you've set.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
For sub /BLU:
__Keybind___Name______________Command_____________
[ CTRL+1 ] Lunge          /ja "Lunge" <stnpc>
[ CTRL+2 ] Gambit         /ja "Gambit" <stnpc>
[ CTRL+3 ] Rayke          /ja "Rayke" <stnpc>
[ CTRL+4 ] Liement        /ja "Liement" <me>
[ CTRL+5 ] Pflug          /ja "Pflug" <me>
[ CTRL+6 ] Valiance       /ja "Valiance" <me>
[ CTRL+7 ] Battuta        /ja "Battuta" <me>
[ CTRL+8 ] HealingB       /ma "Healing Breeze" <me>
[ CTRL+9 ] Sforzo         /ja "Elemental Sforzo" <me>
[ CTRL+0 ] GeistWal       /ma "Geist Wall" <stnpc>
[ ALT+1 ]  Crusade        /ma "Crusade" <me>
[ ALT+2 ]  Foil           /ma "Foil" <me>
[ ALT+3 ]  Flash          /ma "Flash" <stnpc>
[ ALT+4 ]  BlankGze       /ma "Blank Gaze" <stnpc>
[ ALT+6 ]  BombToss       /ma "Bomb Toss" <stnpc>
[ ALT+7 ]  Embolden       /ja "Embolden" <me>
[ ALT+8 ]  Swordpla       /ja "Swordplay" <me>
[ ALT+9 ]  Odyllic        /ja "Odyllic Subterfuge" <stnpc>
[ ALT+0 ]  One4All        /ja "One For All" <me>

For sub /DRK or /BLM:
__Keybind___Name______________Command_____________
[ CTRL+1 ] Lunge          /ja "Lunge" <stnpc>
[ CTRL+2 ] Gambit         /ja "Gambit" <stnpc>
[ CTRL+3 ] Rayke          /ja "Rayke" <stnpc>
[ CTRL+4 ] Liement        /ja "Liement" <me>
[ CTRL+5 ] Pflug          /ja "Pflug" <me>
[ CTRL+6 ] Valiance       /ja "Valiance" <me>
[ CTRL+7 ] Battuta        /ja "Battuta" <me>
[ CTRL+9 ] Sforzo         /ja "Elemental Sforzo" <me>
[ CTRL+0 ] Poisonga       /ma "Poisonga" <stnpc>
[ ALT+1 ]  Crusade        /ma "Crusade" <me>
[ ALT+2 ]  Foil           /ma "Foil" <me>
[ ALT+3 ]  Flash          /ma "Flash" <stnpc>
[ ALT+4 ]  Stun           /ma "Stun" <stnpc>
[ ALT+7 ]  Embolden       /ja "Embolden" <me>
[ ALT+8 ]  Swordpla       /ja "Swordplay" <me>
[ ALT+9 ]  Odyllic        /ja "Odyllic Subterfuge" <stnpc>
[ ALT+0 ]  One4All        /ja "One For All" <me>

For sub /WAR:
__Keybind___Name______________Command_____________
[ CTRL+1 ] Lunge          /ja "Lunge" <stnpc>
[ CTRL+2 ] Gambit         /ja "Gambit" <stnpc>
[ CTRL+3 ] Rayke          /ja "Rayke" <stnpc>
[ CTRL+4 ] Liement        /ja "Liement" <me>
[ CTRL+5 ] Pflug          /ja "Pflug" <me>
[ CTRL+6 ] Valiance       /ja "Valiance" <me>
[ CTRL+7 ] Battuta        /ja "Battuta" <me>
[ CTRL+9 ] Sforzo         /ja "Elemental Sforzo" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Crusade        /ma "Crusade" <me>
[ ALT+2 ]  Foil           /ma "Foil" <me>
[ ALT+3 ]  Flash          /ma "Flash" <stnpc>
[ ALT+7 ]  Embolden       /ja "Embolden" <me>
[ ALT+8 ]  Swordpla       /ja "Swordplay" <me>
[ ALT+9 ]  Odyllic        /ja "Odyllic Subterfuge" <stnpc>
[ ALT+0 ]  One4All        /ja "One For All" <me>

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                              Sub-job /BLU Spell Set
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
<slot01>cocoon</slot01>
<slot02>wild oats</slot02>
<slot03>sprout smack</slot03>
<slot04>claw cyclone</slot04>
<slot05>blank gaze</slot05>
<slot06>mandibular bite</slot06>
<slot07>healing breeze</slot07>
<slot08>power attack</slot08>
<slot09>geist wall</slot09>
<slot10>foot kick</slot10>
<slot11>pollen</slot11>
<slot12>wild carrot</slot12>
<slot13>smite of rage</slot13>
<slot14>bludgeon</slot14>
<slot15>bomb toss</slot15>

]]--


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  equip({main="empty",sub="empty"})
  
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
  silibs.enable_auto_lockstyle(22)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()

  rayke_duration = 46
  gambit_duration = 92

  expended_runes={} -- Do not modify
  rayke_tracker={} -- Do not modify
  gambit_tracker={} -- Do not modify

  -- /BLU Spell Maps
  blue_magic_maps = {}
  blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
      'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
  blue_magic_maps.Cure = S{'Wild Carrot', 'Healing Breeze', 'Magic Fruit'}
  blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

  state.Kiting:set('On')
  state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT', 'Encumbrance'}
  state.DefenseMode:set('Physical') -- Default to PDT mode
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.CastingMode:options('Normal', 'Safe')
  state.HybridMode:options('HeavyDef', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(false, 'Attack Capped')
  state.DeathResist = M(false, 'Death Resist Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Lycurgos', 'Naegling', 'Axe'}
  state.SubWeaponSet = M{['description']='Sub Weapon Set', 'Refined', 'Utu', 'Alber', 'Shield'}
  state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
  state.CP = M(false, 'Capacity Points Mode')
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['@d'] = 'gs c toggle DeathResist',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^home'] = 'gs c subweaponset cycle',
      ['^end'] = 'gs c subweaponset cycleback',
      ['!end'] = 'gs c subweaponset reset',
      ['^-'] = 'gs c cycleback Runes',
      ['^='] = 'gs c cycle Runes',
      ['!`'] = 'input /ja "Vivacious Pulse" <me>',
      ['%numpad0'] = 'gs c rune',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!o'] = 'input /ma "Phalanx" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
      ['!;'] = 'input /ma "Regen IV" <stpc>',
      ['!\''] = 'input /ma "Refresh" <stpc>',
      ['!z'] = 'input /ma "Temper" <me>',
      ['!,'] = 'input /ma "Blaze Spikes" <me>',
      ['!.'] = 'input /ma "Ice Spikes" <me>',
      ['!/'] = 'input /ma "Shock Spikes" <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['BLU'] = {
      ['!q'] = 'input /ma "Wild Carrot" <stpc>',
      ['!w'] = 'input /ma "Cocoon" <me>',
      ['!e'] = 'input /ma "Refueling" <me>',
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
      send_command('aset set runsub')
    end, 2)
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
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
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
    ammo="Sapience Orb",                            -- __/__, ___ [___] < 2>
    head="Halitus Helm",                            -- __/__,  43 [ 88] < 8>
    body="Emet Harness +1",                         --  6/__,  64 [ 61] <10>
    hands="Kurys Gloves",                           --  2/ 2,  57 [ 25] < 9>
    legs="Erilaz Leg Guards +3",                    -- 13/13, 157 [100] <13>
    feet="Erilaz Greaves +3",                       -- 11/11, 157 [ 48] < 8>
    neck={name="Unmoving Collar +1",priority=1},    -- __/__, ___ [200] <10>
    ear1={name="Odnowa Earring +1",priority=1},     --  3/ 5, ___ [110] <__>
    ear2="Cryptic Earring",                         -- __/__, ___ [ 40] < 4>
    ring1="Eihwaz Ring",                            -- __/__, ___ [ 70] < 5>
    ring2="Moonlight Ring",                         --  5/ 5, ___ [110] <__>
    back=gear.RUN_HPD_Cape,                         -- 10/__,  20 [ 80] <10>
    waist="Platinum Moogle Belt",                   --  3/ 3,  15 [___] <__>; HP+10%
    -- HP from belts                                               342
    -- 53 PDT / 39 MDT, 513 M.Eva [932/1274 HP] <79 Enmity>
  }

  -- SIRD Options                                     PDT/MDT, M.Eva [HP] {SIRD}
  -- ammo="Staunch Tathlum +1",                         --  3/ 3, ___ [___] {11}
  -- head="Agwu's Cap",                                 -- __/__, 107 [ 38] {10}
  -- head="Erilaz Galea +3",                            -- __/__, 119 [111] {20}
  -- hands="Regal Gauntlets",                           -- __/__,  48 [205] {10}
  -- hands=gear.Rawhide_B_hands,                        -- __/__,  37 [ 75] {15}
  -- legs=gear.Carmine_A_legs,                          -- __/__,  80 [130] {20}
  -- feet="Agwu's Pigaches",                            -- __/__, 134 [ 27] {10}
  -- feet=gear.Taeon_SIRD_feet,                         -- __/__,  89 [ 63] {10}
  -- neck="Moonlight Necklace",                         -- __/__,  15 [___] {15}
  -- ear2="Magnetic Earring",                           -- __/__, ___ [___] { 8}
  -- ear2="Halasz Earring",                             -- __/__, ___ [___] { 5}
  -- back=gear.RUN_SIRD_Cape,                           -- __/__,  20 [ 80] {10}
  -- waist="Audumbla Sash",                             --  4/__, ___ [___] {10}

  -- 102% SIRD required to cap; can get 10% from merits
  sets.SIRD = {
    ammo="Staunch Tathlum +1",                            --  3/ 3, ___ [___] {11}
    head="Erilaz Galea +3",                               -- __/__, 119 [111] {20}
    body=gear.Nyame_B_body,                               --  9/ 9, 139 [136] {__}
    hands=gear.Rawhide_B_hands,                           -- __/__,  37 [ 75] {15}
    legs={name=gear.Carmine_A_legs.name,
      augments=gear.Carmine_A_legs.augments,priority=1},  -- __/__,  80 [130] {20}
    feet="Erilaz Greaves +3",                             -- 11/11, 157 [ 48] {__}
    neck="Moonlight Necklace",                            -- __/__,  15 [___] {15}
    ear1="Magnetic Earring",                              -- __/__, ___ [___] { 8}
    ear2="Halasz Earring",                                -- __/__, ___ [___] { 5}
    ring1="Gelatinous Ring +1",                           --  7/-1, ___ [135] {__}
    ring2="Defending Ring",                               -- 10/10, ___ [___] {__}
    back={name="Moonlight Cape",priority=1},              --  6/ 6, ___ [275] {__}
    waist="Platinum Moogle Belt",                         --  3/ 3,  15 [___] {__}; HP+10%
    -- HP from belt                                                      340
    -- SIRD merits                                                            { 8}
    -- 49 PDT / 41 MDT, 562 M.Eva [910/1250 HP] {102 SIRD}
  }

  sets.HybridAcc = {
    ammo="Hydrocera",               -- __,  6 [__/__, ___] ___
    head="Erilaz Galea +3",         -- 61, 61 [__/__, 119] 111
    body=gear.Nyame_B_body,         -- 40, 40 [ 9/ 9, 139] 136
    hands="Erilaz Gauntlets +3",    -- 62, 62 [11/11,  87]  59
    legs="Erilaz Leg Guards +3",    -- 63, 63 [13/13, 157] 100
    feet="Erilaz Greaves +3",       -- 60, 60 [11/11, 157]  48
    neck="Erra Pendant",            -- __, 17 [__/__, ___] ___
    ear1="Dignitary's Earring",     -- 10, 10 [__/__, ___] ___
    ear2="Erilaz Earring",          --  7,  7 [__/__,  10] ___
    ring1="Etana Ring",             -- 10, 10 [__/__, ___]  60
    ring2="Metamorph Ring +1",      -- __, 16 [__/__, ___] ___
    back=gear.RUN_WS2_Cape,         -- 20, __ [10/__, ___] ___
    -- 333 Acc, 352 Magic Acc [54 PDT/44 MDT, 669 M.Eva] 514 HP

    -- body="Erilaz Surcoat +3",    -- 64, 64 [__/__, 130] 143; If you have jse ear +2
    -- ear2="Erilaz Earring +2",    -- 20, 20 [ 8/ 8,  12] ___
    -- back=gear.RUN_Nuke_Cape,     -- __, 20 [10/__, ___] ___
    -- waist="Luminary Sash",       -- __, 10 [__/__, ___] ___
    -- 350 Acc, 419 Magic Acc [53 PDT/43 MDT, 662 M.Eva] 521 HP
  }
  sets.HybridAcc.Safe = {
    ammo="Hydrocera",                             -- __,  6 [__/__, ___] ___
    head="Erilaz Galea +3",                       -- 61, 61 [__/__, 119] 111
    body="Erilaz Surcoat +3",                     -- 64, 64 [__/__, 130] 143
    hands="Erilaz Gauntlets +3",                  -- 62, 62 [11/11,  87]  59
    legs="Erilaz Leg Guards +3",                  -- 63, 63 [13/13, 157] 100
    feet="Erilaz Greaves +3",                     -- 60, 60 [11/11, 157]  48
    neck="Erra Pendant",                          -- __, 17 [__/__, ___] ___
    ear1="Odnowa Earring +1",                     -- 10, __ [ 3/ 5, ___] 110
    ear2="Erilaz Earring",                        --  7,  7 [__/__,  10] ___
    ring1="Moonlight Ring",                       --  8, __ [ 5/ 5, ___] 110
    ring2="Metamorph Ring +1",                    -- __, 16 [__/__, ___] ___
    back={name="Moonlight Cape",priority=1},      -- __, __ [ 6/ 6, ___] 275
    waist="Platinum Moogle Belt",                 -- __, __ [ 3/ 3,  15] ___; HP+10%
    -- HP from belt                                                      340
    -- 335 Acc, 356 Magic Acc [52 PDT/54 MDT, 675 M.Eva] 956/1296 HP

    -- ear2="Erilaz Earring +2",                  -- 20, 20 [ 8/ 8,  12] ___
    -- ring1="Etana Ring",                        -- 10, 10 [__/__, ___]  60
    -- 350 Acc, 379 Magic Acc [55 PDT/57 MDT, 677 M.Eva] 906/1246 HP
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet["Naegling"] = {
    main="Naegling",
  }
  sets.WeaponSet["Epeolatry"] = {
    main="Epeolatry",
  }
  sets.WeaponSet["Lionheart"] = {
    main="Lionheart",
  }
  sets.WeaponSet["Lycurgos"] = {
    main="Lycurgos",
  }
  sets.WeaponSet['Axe'] = {
    main="Dolichenus",
  }

  sets.SubWeaponSet = {}
  sets.SubWeaponSet["Utu"] = {
    sub="Utu Grip",
  }
  sets.SubWeaponSet["Refined"] = {
    sub="Refined Grip +1",
  }
  sets.SubWeaponSet["Alber"] = {
    sub="Alber Strap",
  }
  sets.SubWeaponSet["Shield"] = {
    sub="Regis", -- Chanter's Shield good alt
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] __
    head=gear.Nyame_B_head,                         --  7/ 7, 123 [ 91] __
    body="Erilaz Surcoat +3",                       -- __/__, 130 [143] __; Retain enmity, Convert dmg to MP
    hands="Turms Mittens +1",                       -- __/__, 101 [ 74] __; HP+100 on parry
    legs="Erilaz Leg Guards +3",                    -- 13/13, 157 [100]  4
    feet="Turms Leggings +1",                       -- __/__, 147 [ 76]  5
    neck="Futhark Torque +2",                       --  7/ 7,  30 [ 60] __
    ear1={name="Odnowa Earring +1",priority=1},     --  3/ 5, ___ [110] __
    ear2="Arete del Luna +1",                       -- __/__, ___ [___] __; Resists
    ring1={name="Gelatinous Ring +1",priority=1},   --  7/-1, ___ [135] __
    ring2={name="Moonlight Ring",priority=1},       --  5/ 5, ___ [110] __
    back=gear.RUN_HPP_Cape,                         -- __/__,  20 [ 80]  8
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 [___] __; HP+10%
    -- Merits/Traits/Gifts                                              19
    -- HP from belt                                                347
    -- 48 PDT / 42 MDT, 723 MEVA [979/1326 HP] 36 Inquartata
  }

  sets.HeavyDefForIdle = {
    -- Assume Utu Grip              -- [__/__, ___]  70
    ammo="Staunch Tathlum +1",      -- [ 3/ 3, ___] ___
    head=gear.Nyame_B_head,         -- [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,         -- [ 9/ 9, 139] 136
    legs=gear.Nyame_B_legs,         -- [ 8/ 8, 150] 114
    ear1="Odnowa Earring +1",       -- [ 3/ 5, ___] 110
    ring2="Defending Ring",         -- [10/10, ___] ___
    back=gear.RUN_TP_Cape,          -- [10/__, ___] ___
    waist="Platinum Moogle Belt",   -- [ 3/ 3,  15] ___; HP+10%
    -- HP bonus from belt                           301
    -- 53 PDT / 45 MDT, 427 MEVA [521/822 HP]
  }

  -- PDT cap is 50%, Protect V = 0%
  sets.defense.PDT = set_combine(sets.HeavyDef, {
    -- Assume Refined Grip +1                       --  3/ 3, ___ [ 35] __
    -- 51 PDT / 45 MDT, 723 MEVA [1014/1365 HP] 36 Inquartata
  })

  -- MDT cap is 50%, Shell V = 29%
  sets.defense.MDT = {
    -- Assume Utu Grip                              -- __/__, ___ [ 70] (__, __)
    ammo="Thunder Sachet",                          -- __/__, ___ [___] (__, __); Elemental resist & absorb
    head="Erilaz Galea +3",                         -- __/__, 119 [111] (__, __)
    body="Erilaz Surcoat +3",                       -- __/__, 130 [143] (__, __); Retain enmity, Convert dmg to MP
    hands="Erilaz Gauntlets +3",                    -- 11/11,  87 [ 59] ( 8, __)
    legs="Erilaz Leg Guards +3",                    -- 13/13, 157 [100] (__, __)
    feet="Erilaz Greaves +3",                       -- 11/11, 157 [ 48] (__, 35)
    neck="Warder's Charm +1",                       -- __/__, ___ [___] (__, 20); Absorb magic dmg
    ear1="Sanare Earring",                          -- __/__,   6 [___] (__, __); M. Def Bonus+4
    ear2="Neptune's Pearl",                         -- __/__, ___ [___] (__, __); Resists
    ring1="Shadow Ring",                            -- __/__, ___ [___] (__, __); Absorb magic dmg, resist death
    ring2={name="Moonlight Ring",priority=1},       --  5/ 5, ___ [110] (__, __)
    back="Moonlight Cape",                          --  6/ 6, ___ [275] (__, __)
    waist={name="Platinum Moogle Belt",priority=1}, --  3/ 3,  15 [___] __; HP+10%
    -- HP from belt                                                341
    -- 49 PDT / 49 MDT, 671 MEVA [916/1257 HP] (19 Status Resist, 55 Element Resist)
  }

  sets.defense.Parry = {
    hands="Turms Mittens +1",       -- Parry: Recover HP+100
    legs="Erilaz Leg Guards +3",    -- Inquartata+4
    feet="Turms Leggings +1",       -- Inquartata+5
    back=gear.RUN_HPP_Cape,         -- Parry Rate+5
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head="Turms Cap +1",
  }
  sets.latent_regen = {
    head="Turms Cap +1", --7
    body="Futhark Coat +3", --5
    hands="Regal Gauntlets", --10
    feet="Turms Leggings +1", --5
    neck="Bathy Choker +1", --3
    ear1="Infused Earring", --1
    ring1="Chirich Ring +1", --2
  }
  sets.latent_refresh = {
    ammo="Homiliary", --1
    head=gear.Herc_Refresh_head, --1
    body="Runeist Coat +3", --3
    hands="Regal Gauntlets", --1
    legs="Rawhide Trousers", --1
    feet=gear.Herc_Refresh_feet, --2
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

  sets.idle.HeavyDef = set_combine(sets.idle, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain = set_combine(sets.idle.Regain, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regen = set_combine(sets.idle.Regen, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Refresh = set_combine(sets.idle.Refresh, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.HeavyDefForIdle)
  sets.idle.HeavyDef.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.HeavyDefForIdle)

  sets.idle.Weak = set_combine(sets.defense.MDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA = set_combine(sets.Enmity, {})

  sets.precast.JA['Vallation'] = {
    ammo="Sapience Orb",                                -- __/__, ___ [___] < 2>
    head="Halitus Helm",                                -- __/__,  43 [ 88] < 8>
    body={name="Runeist Coat +3",priority=1},           -- __/__,  94 [218] <__>; Augments Valiance/Vallation
    hands="Kurys Gloves",                               --  2/ 2,  57 [ 25] < 9>
    legs="Erilaz Leg Guards +3",                        -- 13/13, 157 [100] <13>
    feet="Erilaz Greaves +3",                           -- 11/11, 157 [ 48] < 8>
    neck={name="Unmoving Collar +1",priority=1},        -- __/__, ___ [200] <10>
    ear1={name="Odnowa Earring +1",priority=1},         --  3/ 5, ___ [110] <__>
    ear2="Cryptic Earring",                             -- __/__, ___ [ 40] < 4>
    ring1="Eihwaz Ring",                                -- __/__, ___ [ 70] < 5>
    ring2="Defending Ring",                             -- 10/10, ___ [___] <__>
    back=gear.RUN_HPD_Cape,                             -- 10/__,  20 [ 80] <10>
    waist="Platinum Moogle Belt",                       --  3/ 3,  15 [___] <__>; HP+10%
    -- HP from belt                                                    347
    -- 52 PDT / 44 MDT, 543 M.Eva [979/1326 HP] <69 Enmity>
  }
  sets.precast.JA['Valiance'] = set_combine(sets.precast.JA['Vallation'], {})
  sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {
    head="Futhark Bandeau +3", --  Increase counter damage
  })
  sets.precast.JA['Liement'] = set_combine(sets.Enmity, {
    body="Futhark Coat +3", -- Increase duration
  })

  sets.precast.JA['Lunge'] = {
    ammo="Seething Bomblet +1",                     --  7, __/__ [___]
    head="Agwu's Cap",                              -- 35, __/__ [ 38]; R0
    body=gear.Nyame_B_body,                         -- 30,  9/ 9 [136]
    hands=gear.Carmine_D_hands,                     -- 42, __/__ [ 27]
    legs="Agwu's Slops",                            -- 60, 10/10 [ 50]; R30
    feet=gear.Herc_MAB_feet,                        -- 57,  2/__ [  9]
    neck="Sibyl Scarf",                             -- 10, __/__ [___]
    ear1="Friomisi Earring",                        -- 10, __/__ [___]
    ear2="Novio Earring",                           --  7, __/__ [___]
    ring1="Gelatinous Ring +1",                     -- __,  7/-1 [135]
    ring2="Shiva Ring +1",                          --  3, __/__ [___]
    back="Argochampsa Mantle",                      -- 12, __/__ [___]
    waist="Orpheus's Sash",
    -- 273 MAB, 28 PDT / 18 MDT [415 HP]

    -- head="Agwu's Cap",                           -- 60, __/__ [ 38]; R30
    -- body="Agwu's Robe",                          -- 60, __/__ [ 61]; R30
    -- hands="Agwu's Gages",                        -- 60, __/__ [ 38]; R30
    -- feet="Agwu's Pigaches",                      -- 60, __/__ [ 27]; R30
    -- back=gear.RUN_Nuke_Cape,                     -- 10, 10/__ [___]
    -- 349 MAB, 27 PDT / 9 MDT [369 HP]
  }
  sets.precast.JA['Lunge'].Safe = {
    ammo="Seething Bomblet +1",                     --  7, __/__ [___]
    head=gear.Nyame_B_head,                         -- 30,  7/ 7 [ 91]
    body=gear.Nyame_B_body,                         -- 30,  9/ 9 [136]
    hands="Agwu's Gages",                           -- 56, __/__ [ 38]; R21
    legs="Agwu's Slops",                            -- 60, 10/10 [ 50]; R30
    feet=gear.Herc_MAB_feet,                        -- 57,  2/__ [  9]
    neck="Futhark Torque +2",                       -- __,  7/ 7 [ 60]
    ear1="Friomisi Earring",                        -- 10, __/__ [___]
    ear2="Novio Earring",                           --  7, __/__ [___]
    ring1={name="Gelatinous Ring +1",priority=1},   -- __,  7/-1 [135]
    ring2="Moonlight Ring",                         -- __,  5/ 5 [110]
    back={name="Moonlight Cape",priority=1},        -- __,  6/ 6 [275]
    waist="Platinum Moogle Belt",                   -- __,  3/ 3 [___]; HP+10%
    -- 257 MAB, 56 PDT / 46 MDT [904 HP]
    
    -- hands="Agwu's Gages",                        -- 60, __/__ [ 38]; R30
    -- feet="Agwu's Pigaches",                      -- 60, __/__ [ 27]; R30
    -- HP from belt                                               341
    -- 264 MAB, 54 PDT / 46 MDT [922/1263 HP]
  }

  sets.precast.JA['Swipe'] = set_combine(sets.precast.JA['Lunge'], {})
  sets.precast.JA['Swipe'].Safe = set_combine(sets.precast.JA['Lunge'].Safe, {})

  sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {
    hands="Runeist Mitons +3", -- Increase duration
  })
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {
    feet="Futhark Boots +1", -- Enhance effect (exact effect unknown); +1 is acceptable
  })
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {
    body="Futhark Coat +3", -- Duration +10s; +1 is acceptable
  })
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {
    hands="Futhark Mitons", -- Increase Subtle Blow effect
  })

  -- Divine Magic skill
  sets.precast.JA['Vivacious Pulse'] = {
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] __
    head="Erilaz Galea +3",                         -- __/__, 119 [111] __; Enhance JA
    body=gear.Nyame_B_body,                         --  9/ 9, 139 [136] __
    hands="Turms Mittens +1",                       -- __/__, 101 [ 74] __
    legs="Erilaz Leg Guards +3",                    -- 13/13, 157 [100] __
    feet="Turms Leggings +1",                       -- __/__, 147 [ 76] __
    neck="Incanter's Torque",                       -- __/__, ___ [___] 10
    ear1="Odnowa Earring +1",                       --  3/ 5, ___ [110] __
    ear2="Arete del Luna +1",                       -- __/__, ___ [___] __; Resists
    ring1="Gelatinous Ring +1",                     --  7/-1, ___ [135] __
    ring2="Defending Ring",                         -- 10/10, ___ [___] __
    back={name="Moonlight Cape",priority=1},        --  6/ 6, ___ [275] __
    waist="Platinum Moogle Belt",                   --  3/ 3,  15 [___] __; HP+10%
    -- HP from belt                                                351
    -- Merits/Traits/Gifts                                              16
    -- Master Level 50                                                  50
    -- Base skill                                                      398
    -- 54 PDT/48 MDT, 678 M.Eva [1017/1368 HP] 474 Divine Skill
  }

  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    ammo="Sapience Orb",                                  -- { 2} __/__, ___ [___]
    head="Runeist Bandeau +3",                            -- {14} __/__,  83 [109]
    body="Erilaz Surcoat +3",                             -- {13} __/__, 130 [143]
    hands=gear.Leyline_Gloves,                            -- { 8} __/__,  62 [ 25]
    legs="Agwu's Slops",                                  -- { 7} 10/10, 134 [ 50]; R30
    feet={name=gear.Carmine_D_feet.name,
      augments=gear.Carmine_D_feet.augments,priority=1},  -- { 8}  4/__,  80 [ 95]
    neck="Futhark Torque +2",                             -- {__}  7/ 7,  30 [ 60]
    ear1="Odnowa Earring +1",                             -- {__}  3/ 5, ___ [110]
    ear2="Enchanter's Earring +1",                        -- { 2} __/__, ___ [___]
    ring1="Gelatinous Ring +1",                           -- {__}  7/-1, ___ [135]
    ring2="Moonlight Ring",                               -- {__}  5/ 5, ___ [110]
    back=gear.RUN_FC_Cape,                                -- {10} 10/__,  20 [ 80]
    waist="Platinum Moogle Belt",                         -- {__}  3/ 3,  15 [___]; HP+10%
    -- HP from belt                                                           341
    -- 64% Fast Cast, 49 PDT/29 MDT, 554 M.Eva [917/1258 HP]
  }

  sets.precast.FC['Enhancing Magic'] = {
    ammo="Staunch Tathlum +1",                            -- {__}  3/ 3, ___ [___]
    head="Runeist Bandeau +3",                            -- {14} __/__,  83 [109]
    body="Erilaz Surcoat +3",                             -- {13} __/__, 130 [143]
    hands=gear.Leyline_Gloves,                            -- { 8} __/__,  62 [ 25]
    legs={name="Futhark Trousers +3",priority=1},         -- {15} __/__,  89 [107]
    feet={name=gear.Carmine_D_feet.name,
      augments=gear.Carmine_D_feet.augments,priority=1},  -- { 8}  4/__,  80 [ 95]
    neck="Futhark Torque +2",                             -- {__}  7/ 7,  30 [ 60]
    ear1="Odnowa Earring +1",                             -- {__}  3/ 5, ___ [110]
    ear2={name="Eabani Earring",priority=1},              -- {__} __/__,   8 [ 45]
    ring1="Gelatinous Ring +1",                           -- {__}  7/-1, ___ [135]
    ring2="Defending Ring",                               -- {__} 10/10, ___ [___]
    back=gear.RUN_FC_Cape,                                -- {10} 10/__,  20 [ 80]
    waist="Platinum Moogle Belt",                         -- {__}  3/ 3,  15 [___]; HP+10%
    -- HP from belt                                                           340
    -- 68% Fast Cast, 47 PDT/27 MDT, 517 M.Eva [909/1249 HP]
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Futhark Torque +2",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat Ring",
    ring2="Niqmaddu Ring",
    back=gear.RUN_WS1_Cape,
    waist="Sailfi Belt +1",
    
    -- back=gear.RUN_WS3_Cape,
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Ishvara Earring",
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {})
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS.Safe = set_combine(sets.Enmity, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Futhark Torque +2",
    ring1="Ephramad's Ring",
    waist="Platinum Moogle Belt",
  })
  sets.precast.WS.SafeMaxTP = set_combine(sets.precast.WS.Safe, {})

  -- 85% STR mod, 5 hit, 0.718-2.25 FTP, ftp replicating
  sets.precast.WS['Resolution'] = {
    ammo="Coiste Bodhar",             -- 10, __, 15, __, __ < 3, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 26, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,           -- 35, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,           -- 23, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck="Fotia Gorget",              -- __, 10, __, __, __ <__, __, __> [__/__, ___] ___; ftp+
    ear1="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ear2="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ <__, __,  3> [__/__, ___] ___
    ring2="Epona's Ring",             -- __, __, __, __, __ < 3,  3, __> [__/__, ___] ___
    back=gear.RUN_WS1_Cape,           -- 30, 20, 20, __, __ <10, __, __> [10/__, ___] ___
    waist="Fotia Belt",               -- __, 10, __, __, __ <__, __, __> [__/__, ___] ___; ftp+
    -- 214 STR, 267 Acc, 360 Att, 58 WSD, 0 PDL <49 DA, 3 TA, 3 QA> [48 PDT/38 MDT, 674 M.Eva] 500 HP
  }
  sets.precast.WS['Resolution'].MaxTP = set_combine(sets.precast.WS['Resolution'], {
    ear1="Brutal Earring",            -- __, __, __, __, __ < 5, __, __> [__/__, ___] ___
  })
  sets.precast.WS['Resolution'].AttCapped = {
    ammo="Coiste Bodhar",             -- 10, __, 15, __, __ < 3, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 26, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,           -- 35, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,           -- 23, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck="Fotia Gorget",              -- __, 10, __, __, __ <__, __, __> [__/__, ___] ___; ftp+
    ear1="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ear2="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    ring1="Niqmaddu Ring",            -- 10, __, __, __, __ <__, __,  3> [__/__, ___] ___
    ring2="Epona's Ring",             -- __, __, __, __, __ < 3,  3, __> [__/__, ___] ___
    back=gear.RUN_WS1_Cape,           -- 30, 20, 20, __, __ <10, __, __> [10/__, ___] ___
    waist="Fotia Belt",               -- __, 10, __, __, __ <__, __, __> [__/__, ___] ___; ftp+
    -- 214 STR, 267 Acc, 360 Att, 58 WSD, 0 PDL <49 DA, 3 TA, 3 QA> [48 PDT/38 MDT, 674 M.Eva] 500 HP
  }
  sets.precast.WS['Resolution'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ear1="Brutal Earring",            -- __, __, __, __, __ < 5, __, __> [__/__, ___] ___
  })
  sets.precast.WS['Resolution'].Safe = {
    ammo="Coiste Bodhar",                       -- 10, __, 15, __, __ < 3, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,                     -- 26, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,                     -- 35, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands={name=gear.Nyame_B_hands,priority=1}, -- 17, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs={name=gear.Nyame_B_legs,priority=1},   -- 58, 40, 65, 12, __ < 6, __, __> [ 8/ 8, 150] 114
    feet=gear.Nyame_B_feet,                     -- 23, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck="Fotia Gorget",                        -- __, 10, __, __, __ <__, __, __> [__/__, ___] ___; ftp+
    ear1="Moonshade Earring",                   -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ear2="Sherida Earring",                     --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    ring1="Niqmaddu Ring",                      -- 10, __, __, __, __ <__, __,  3> [__/__, ___] ___
    ring2="Moonlight Ring",                     -- __,  8,  8, __, __ <__, __, __> [ 5/ 5, ___] 110
    back={name="Moonlight Cape",priority=1},    -- __, __, __, __, __ <__, __, __> [ 6/ 6, ___] 275
    waist="Platinum Moogle Belt",               -- __, __, __, __, __ <__, __, __> [ 3/ 3,  15] ___; HP+10%
    -- HP from belt                                                                             338
    -- 184 STR, 245 Acc, 348 Att, 58 WSD, 0 PDL <36 DA, 0 TA, 3 QA> [52 PDT/52 MDT, 689 M.Eva] 885/1223 HP
  }
  sets.precast.WS['Resolution'].SafeMaxTP = set_combine(sets.precast.WS['Resolution'].Safe, {
    ear1="Brutal Earring",                      -- __, __, __, __, __ < 5, __, __> [__/__, ___] ___
    ear2="Sherida Earring",                     --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    -- 184 STR, 241 Acc, 348 Att, 58 WSD, 0 PDL <41 DA, 0 TA, 3 QA> [52 PDT/52 MDT, 689 M.Eva] 885/1223 HP
  })

  -- 80% DEX mod, 2 hit
  sets.precast.WS['Dimidiation'] = {
    ammo="Knobkierrie",               -- __, __, 23,  6, __ <__, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 25, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,           -- 24, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,         -- 42, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs=gear.Lustratio_B_legs,       -- 43, 20, 38, __, __ <__, __, __> [__/__, ___]  28
    feet=gear.Nyame_B_feet,           -- 26, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck="Caro Necklace",             --  6, __, 10, __, __ <__, __, __> [__/__, ___] ___
    ear1="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ear2="Odr Earring",               -- 10, 10, __, __, __ <__, __, __> [__/__, ___] ___
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___] ___
    ring2="Ilabrat Ring",             -- 10, __, 25, __, __ <__, __, __> [__/__, ___]  60
    back=gear.RUN_WS2_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___] ___
    waist="Grunfeld Rope",            --  5, 10, 20, __, __ < 2, __, __> [__/__, ___] ___
    -- 231 DEX, 267 Acc, 416 Att, 62 WSD, 10 PDL <24 DA, 0 TA, 0 QA> [40 PDT/30 MDT, 524 M.Eva] 474 HP
  }
  sets.precast.WS['Dimidiation'].MaxTP = set_combine(sets.precast.WS['Dimidiation'], {
    ear1="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    -- 236 DEX, 263 Acc, 416 Att, 62 WSD, 10 PDL <29 DA, 0 TA, 0 QA> [40 PDT/30 MDT, 524 M.Eva] 474 HP
  })
  sets.precast.WS['Dimidiation'].AttCapped = {
    ammo="Knobkierrie",               -- __, __, 23,  6, __ <__, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 25, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,           -- 24, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands=gear.Nyame_B_hands,         -- 42, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs=gear.Lustratio_B_legs,       -- 43, 20, 38, __, __ <__, __, __> [__/__, ___]  28
    feet=gear.Nyame_B_feet,           -- 26, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck="Caro Necklace",             --  6, __, 10, __, __ <__, __, __> [__/__, ___] ___
    ear1="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ear2="Odr Earring",               -- 10, 10, __, __, __ <__, __, __> [__/__, ___] ___
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> [__/__, ___] ___
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___] ___
    back=gear.RUN_WS2_Cape,           -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___] ___
    waist="Kentarch Belt +1",         -- 10, 14, __, __, __ < 3, __, __> [__/__, ___] ___
    -- 226 DEX, 271 Acc, 371 Att, 67 WSD, 10 PDL <25 DA, 0 TA, 0 QA> [40 PDT/30 MDT, 524 M.Eva] 414 HP
  }
  sets.precast.WS['Dimidiation'].AttCappedMaxTP = set_combine(sets.precast.WS['Dimidiation'].AttCapped, {
    ear1="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    -- 231 DEX, 267 Acc, 371 Att, 67 WSD, 10 PDL <30 DA, 0 TA, 0 QA> [40 PDT/30 MDT, 524 M.Eva] 414 HP
  })
  sets.precast.WS['Dimidiation'].Safe = {
    ammo="Knobkierrie",                         -- __, __, 23,  6, __ <__, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,                     -- 25, 50, 65, 11, __ < 5, __, __> [ 7/ 7, 123]  91
    body=gear.Nyame_B_body,                     -- 24, 40, 65, 13, __ < 7, __, __> [ 9/ 9, 139] 136
    hands={name=gear.Nyame_B_hands,priority=1}, -- 42, 40, 65, 11, __ < 5, __, __> [ 7/ 7, 112]  91
    legs=gear.Lustratio_B_legs,                 -- 43, 20, 38, __, __ <__, __, __> [__/__, ___]  28
    feet=gear.Nyame_B_feet,                     -- 26, 53, 65, 11, __ < 5, __, __> [ 7/ 7, 150]  68
    neck={name="Unmoving Collar +1",priority=1},-- __,  5, __, __, __ <__, __, __> [__/__, ___] 200
    ear1="Odnowa Earring +1",                   -- __, 10, __, __, __ <__, __, __> [ 3/ 5, ___] 110
    ear2="Moonshade Earring",                   -- __,  4, __, __, __ <__, __, __> [__/__, ___] ___; tp bonus
    ring1="Gelatinous Ring +1",                 -- __, __, __, __, __ <__, __, __> [ 7/-1, ___] 135
    ring2="Ilabrat Ring",                       -- 10, __, 25, __, __ <__, __, __> [__/__, ___]  60
    back=gear.RUN_WS2_Cape,                     -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___] ___
    waist="Platinum Moogle Belt",               -- __, __, __, __, __ <__, __, __> [ 3/ 3,  15] ___; HP+10%
    -- HP from belt                                                                             341
    -- 200 DEX, 242 Acc, 366 Att, 62 WSD, 0 PDL <22 DA, 0 TA, 0 QA> [53 PDT/37 MDT, 539 M.Eva] 919/1260 HP
  }
  sets.precast.WS['Dimidiation'].SafeMaxTP = set_combine(sets.precast.WS['Dimidiation'].Safe, {
    ear2="Sherida Earring",                     --  5, __, __, __, __ < 5, __, __> [__/__, ___] ___
    -- 205 DEX, 238 Acc, 366 Att, 62 WSD, 0 PDL <27 DA, 0 TA, 0 QA> [53 PDT/37 MDT, 539 M.Eva] 919/1260 HP
  })

  -- 50% STR/50% MND.
  sets.precast.WS['Savage Blade'] = {
    ammo="Knobkierrie",                         -- __, __, __, 23,  6, __ [__/__] ___
    head=gear.Nyame_B_head,                     -- 26, 26, 50, 65, 11, __ [ 7/ 7]  91
    body=gear.Nyame_B_body,                     -- 35, 37, 40, 65, 13, __ [ 9/ 9] 136
    hands=gear.Nyame_B_hands,                   -- 17, 40, 40, 65, 11, __ [ 7/ 7]  91
    legs=gear.Nyame_B_legs,                     -- 58, 32, 40, 65, 12, __ [ 8/ 8] 114
    feet=gear.Nyame_B_feet,                     -- 23, 26, 53, 65, 11, __ [ 7/ 7]  68
    neck="Futhark Torque +2",                   -- 15, 15, __, __, __, __ [ 7/ 7]  60
    ear1="Moonshade Earring",                   -- __, __,  4, __, __, __ [__/__] ___; tp bonus+
    ear2="Ishvara Earring",                     -- __, __, __, __,  2, __ [__/__] ___
    ring1="Sroda Ring",                         -- 15, __, __, __, __,  3 [__/__] ___
    ring2="Epaminondas's Ring",                 -- __, __, __, __,  5, __ [__/__] ___
    back=gear.RUN_WS1_Cape,                     -- 30, __, 20, 20, __, __ [10/__] ___
    waist="Sailfi Belt +1",                     -- 15, __, __, 15, __, __ [__/__] ___
    -- 234 STR, 176 MND, 247 Accuracy, 383 Attack, 66 WSD, 0 PDL [55PDT/45MDT] 560 HP
    
    -- ear2="Erilaz Earring +2",                -- 15, 15, __, 20, __, __ [ 8/ 8] ___
    -- back=gear.RUN_WS3_Cape,                  -- 30, __, 20, 20, 10, __ [10/__] ___
    -- 249 STR, 191 MND, 247 Accuracy, 403 Attack, 74 WSD, 0 PDL [63PDT/53MDT] 560 HP
  }
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP, {
    ear1="Sherida Earring",                     --  5, __, __, __, __, __ [__/__] ___
    -- 239 STR, 176 MND, 243 Accuracy, 383 Attack, 76 WSD, 0 PDL [55PDT/45MDT] 560 HP
    
    -- ear1="Ishvara Earring",                  -- __, __, __, __,  2, __ [__/__] ___
    -- ear2="Erilaz Earring +2",                -- 15, 15, __, 20, __, __ [ 8/ 8] ___
    -- 249 STR, 191 MND, 247 Accuracy, 403 Attack, 76 WSD, 0 PDL [63PDT/53MDT] 560 HP
  })
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP, {})
  sets.precast.WS['Savage Blade'].Safe = {
    ammo="Knobkierrie",                         -- __, __, __, 23,  6, __ [__/__] ___
    head=gear.Nyame_B_head,                     -- 26, 26, 50, 65, 11, __ [ 7/ 7]  91
    body=gear.Nyame_B_body,                     -- 35, 37, 40, 65, 13, __ [ 9/ 9] 136
    hands=gear.Nyame_B_hands,                   -- 17, 40, 40, 65, 11, __ [ 7/ 7]  91
    legs=gear.Nyame_B_legs,                     -- 58, 32, 40, 65, 12, __ [ 8/ 8] 114
    feet=gear.Nyame_B_feet,                     -- 23, 26, 53, 65, 11, __ [ 7/ 7]  68
    neck="Futhark Torque +2",                   -- 15, 15, __, __, __, __ [ 7/ 7]  60
    ear1="Odnowa Earring +1",                   --  3, __, __, __, __, __ [ 3/ 5] 110
    ear2="Moonshade Earring",                   -- __, __,  4, __, __, __ [__/__] ___; tp bonus+
    ring1="Gelatinous Ring +1",                 -- __, __, __, __, __, __ [ 7/-1] 135
    ring2="Moonlight Ring",                     -- __, __,  8,  8, __, __ [ 5/ 5] 110
    back=gear.RUN_WS1_Cape,                     -- 30, __, 20, 20, __, __ [10/__] ___
    waist="Platinum Moogle Belt",               -- __, __, __, __, __, __ [ 3/ 3] ___; HP+10%
    -- HP from belt                                                               341
    -- 202 STR, 176 MND, 255 Accuracy, 376 Attack, 64 WSD, 0 PDL [73PDT/57MDT] 915/1256 HP
    
    -- back=gear.RUN_WS3_Cape,                  -- 30, __, 20, 20, 10, __ [10/__] ___
    -- 207 STR, 176 MND, 255 Accuracy, 376 Attack, 74 WSD, 0 PDL [73PDT/57MDT] 915/1256 HP
    
  }
  sets.precast.WS['Savage Blade'].SafeMaxTP = set_combine(sets.precast.WS['Savage Blade'].Safe, {
    ear2="Ishvara Earring",                     -- __, __, __, __,  2, __ [__/__] ___

    -- ear2="Erilaz Earring +2",                -- 15, 15, 20, __, __, __ [ 8/ 8] ___
  })

  -- Magic accuracy required for sleep effect
  sets.precast.WS['Shockwave'] = set_combine(sets.HybridAcc, {
    ear2="Moonshade Earring",
  })
  sets.precast.WS['Shockwave'].AttCappedMaxTP = set_combine(sets.HybridAcc, {})
  sets.precast.WS['Shockwave'].Safe = set_combine(sets.HybridAcc.Safe, {
    ear2="Moonshade Earring",
  })
  sets.precast.WS['Shockwave'].SafeMaxTP = set_combine(sets.HybridAcc.Safe, {})

  -- Magic accuracy required for paralyze effect
  sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS['Shockwave'], {})
  sets.precast.WS['Herculean Slash'].AttCappedMaxTP = set_combine(sets.precast.WS['Shockwave'].AttCappedMaxTP, {})
  sets.precast.WS['Herculean Slash'].Safe = set_combine(sets.precast.WS['Shockwave'].Safe, {})
  sets.precast.WS['Herculean Slash'].SafeMaxTP = set_combine(sets.precast.WS['Shockwave'].SafeMaxTP, {})

  -- Accuracy and magic accuracy required for break effects
  sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Shockwave'], {})
  sets.precast.WS['Armor Break'].AttCappedMaxTP = set_combine(sets.precast.WS['Shockwave'].AttCappedMaxTP, {})
  sets.precast.WS['Armor Break'].Safe = set_combine(sets.precast.WS['Shockwave'].Safe, {})
  sets.precast.WS['Armor Break'].SafeMaxTP = set_combine(sets.precast.WS['Shockwave'].SafeMaxTP, {})

  sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Shockwave'], {})
  sets.precast.WS['Weapon Break'].AttCappedMaxTP = set_combine(sets.precast.WS['Shockwave'].AttCappedMaxTP, {})
  sets.precast.WS['Weapon Break'].Safe = set_combine(sets.precast.WS['Shockwave'].Safe, {})
  sets.precast.WS['Weapon Break'].SafeMaxTP = set_combine(sets.precast.WS['Shockwave'].SafeMaxTP, {})

  sets.precast.WS['Full Break'] = set_combine(sets.precast.WS['Shockwave'], {})
  sets.precast.WS['Full Break'].AttCappedMaxTP = set_combine(sets.precast.WS['Shockwave'].AttCappedMaxTP, {})
  sets.precast.WS['Full Break'].Safe = set_combine(sets.precast.WS['Shockwave'].Safe, {})
  sets.precast.WS['Full Break'].SafeMaxTP = set_combine(sets.precast.WS['Shockwave'].SafeMaxTP, {})

  sets.precast.WS['Freezebite'] = set_combine(sets.HeavyDef, sets.TreasureHunter)


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

  sets.midcast.Silence = set_combine(sets.HybridAcc, {})

  sets.midcast.EnhancingDuration = {
    head="Erilaz Galea +3",                         -- __/__, 119 [111] (25, __)
    hands={name="Regal Gauntlets",priority=1},      -- __/__,  48 [205] (20, __)
    legs={name="Futhark Trousers +3",priority=1},   -- __/__,  89 [107] (30, __)
  }

  sets.midcast.Crusade = {
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] __
    head="Erilaz Galea +3",                         -- __/__, 119 [111] 25
    body=gear.Nyame_B_body,                         --  9/ 9, 139 [136] __
    hands={name="Regal Gauntlets",priority=1},      -- __/__,  48 [205] 20
    legs="Futhark Trousers +3",                     -- __/__,  89 [107] 30
    feet="Erilaz Greaves +3",                       -- 11/11, 157 [ 48] __
    neck="Futhark Torque +2",                       --  7/ 7,  30 [ 60] __
    ear1="Odnowa Earring +1",                       --  3/ 5, ___ [110] __
    ear2="Arete del Luna +1",                       -- __/__, ___ [___] __; Resists
    ring1="Moonlight Ring",                         --  5/ 5, ___ [110] __
    ring2="Defending Ring",                         -- 10/10, ___ [___] __
    back=gear.RUN_HPP_Cape,                         -- __/__,  20 [ 80] __
    waist="Platinum Moogle Belt",                   --  3/ 3,  15 [___] __; HP+10%
    -- HP from belt                                                346
    -- 51 PDT/53 MDT, 617 M.Eva [967/1313 HP] 95 Enh Duration
  }

  -- Cap at 500 skill
  sets.midcast.BarElement = {
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] (__, __)
    head="Erilaz Galea +3",                         -- __/__, 119 [111] (25, __)
    body=gear.Nyame_B_body,                         --  9/ 9, 139 [136] (__, __)
    hands={name="Regal Gauntlets",priority=1},      -- __/__,  48 [205] (20, __)
    legs=gear.Carmine_D_legs,                       -- __/__,  80 [ 50] (__, 18)
    feet="Erilaz Greaves +3",                       -- 11/11, 157 [ 48] (__, __)
    neck="Futhark Torque +2",                       --  7/ 7,  30 [ 60] (__, __)
    ear1="Andoaa Earring",                          -- __/__, ___ [___] (__,  5)
    ear2="Mimir Earring",                           -- __/__, ___ [___] (__, 10)
    ring1="Stikini Ring +1",                        -- __/__, ___ [___] (__,  8)
    ring2="Defending Ring",                         -- 10/10, ___ [___] (__, __)
    back={name="Moonlight Cape",priority=1},        --  6/ 6, ___ [275] (__, __)
    waist="Platinum Moogle Belt",                   --  3/ 3,  15 [___] (__, __); HP+10%
    -- HP from belt                                                338
    -- Merits/Traits/Gifts                                              (20, 52)
    -- Master Levels                                                    (__, 28)
    -- Base skill                                                       (__, 388)
    -- 49 PDT/49 MDT, 588 M.Eva [885/1223 HP] (65 Enh Duration, 509 Enh Skill)

    -- ammo="Staunch Tathlum +1",                   --  3/ 3, ___ [___] (__, __)
    -- head="Erilaz Galea +3",                      -- __/__, 119 [111] (25, __)
    -- body=gear.Nyame_B_body,                      --  9/ 9, 139 [136] (__, __)
    -- hands={name="Regal Gauntlets",priority=1},   -- __/__,  48 [205] (20, __)
    -- legs="Futhark Trousers +3",                  -- __/__,  89 [107] (30, __)
    -- feet="Erilaz Greaves +3",                    -- 11/11, 157 [ 48] (__, __)
    -- neck="Futhark Torque +2",                    --  7/ 7,  30 [ 60] (__, __)
    -- ear1="Andoaa Earring",                       -- __/__, ___ [___] (__,  5)
    -- ear2="Mimir Earring",                        -- __/__, ___ [___] (__, 10)
    -- ring1="Stikini Ring +1",                     -- __/__, ___ [___] (__,  8)
    -- ring2="Defending Ring",                      -- 10/10, ___ [___] (__, __)
    -- back={name="Moonlight Cape",priority=1},     --  6/ 6, ___ [275] (__, __)
    -- waist="Platinum Moogle Belt",                --  3/ 3,  15 [___] (__, __); HP+10%
    -- HP from belt                                                330
    -- Merits/Traits/Gifts                                              (20, 52)
    -- Master Levels                                                    (__, 37)
    -- Base skill                                                       (__, 388)
    -- 49 PDT/49 MDT, 597 M.Eva [942/1272 HP] (95 Enh Duration, 500 Enh Skill)

    -- ammo="Staunch Tathlum +1",                   --  3/ 3, ___ [___] (__, __)
    -- head="Erilaz Galea +3",                      -- __/__, 119 [111] (25, __)
    -- body=gear.Nyame_B_body,                      --  9/ 9, 139 [136] (__, __)
    -- hands={name="Regal Gauntlets",priority=1},   -- __/__,  48 [205] (20, __)
    -- legs="Futhark Trousers +3",                  -- __/__,  89 [107] (30, __)
    -- feet="Erilaz Greaves +3",                    -- 11/11, 157 [ 48] (__, __)
    -- neck="Futhark Torque +2",                    --  7/ 7,  30 [ 60] (__, __)
    -- ear1="Mimir Earring",                        -- __/__, ___ [___] (__, 10)
    -- ear2="Arete del Luna +1",                    -- __/__, ___ [___] (__, __); Resists
    -- ring1="Wuji Ring",                           -- __/__, ___ [___] (__, __); Resists
    -- ring2="Defending Ring",                      -- 10/10, ___ [___] (__, __)
    -- back={name="Moonlight Cape",priority=1},     --  6/ 6, ___ [275] (__, __)
    -- waist="Platinum Moogle Belt",                --  3/ 3,  15 [___] (__, __); HP+10%
    -- HP from belt                                                343
    -- Merits/Traits/Gifts                                              (20, 52)
    -- Master Levels                                                    (__, 50)
    -- Base skill                                                       (__, 388)
    -- 49 PDT/49 MDT, 597 M.Eva [942/1285 HP] (95 Enh Duration, 500 Enh Skill)
  }
  sets.midcast.BarStatus = set_combine(sets.midcast.BarElement, {})
  sets.midcast.Temper = { -- No skill cap
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] (__, __)
    head="Erilaz Galea +3",                         -- __/__, 119 [111] (25, __)
    body=gear.Nyame_B_body,                         --  9/ 9, 139 [136] (__, __)
    hands={name="Runeist Mitons +3",priority=1},    --  3/__,  67 [ 85] (__, 19)
    legs=gear.Carmine_D_legs,                       -- __/__,  80 [ 50] (__, 18)
    feet="Erilaz Greaves +3",                       -- 11/11, 157 [ 48] (__, __)
    neck="Incanter's Torque",                       -- __/__, ___ [___] (__, 10)
    ear1="Andoaa Earring",                          -- __/__, ___ [___] (__,  5)
    ear2="Mimir Earring",                           -- __/__, ___ [___] (__, 10)
    ring1="Stikini Ring +1",                        -- __/__, ___ [___] (__,  8)
    ring2="Defending Ring",                         -- 10/10, ___ [___] (__, __)
    back={name="Moonlight Cape",priority=1},        --  6/ 6, ___ [275] (__, __)
    waist="Platinum Moogle Belt",                   --  3/ 3,  15 [___] (__, __); HP+10%
    -- HP from belt                                                320
    -- Merits/Traits/Gifts                                              (20, 52)
    -- Master Levels                                                    (__, 28)
    -- Base skill                                                       (__, 388)
    -- 45 PDT/42 MDT, 577 M.Eva [1025 HP] (45 Enh Duration, 538 Enh Skill)
  }
  sets.midcast.Temper.Safe = set_combine(sets.midcast.BarElement, {})
  sets.midcast.Protect = {
    ammo="Staunch Tathlum +1",                        --  3/ 3, ___ [___] (__, __)
    head="Erilaz Galea +3",                           -- __/__, 119 [111] (25, __)
    body=gear.Nyame_B_body,                           --  9/ 9, 139 [136] (__, __)
    hands={name="Regal Gauntlets", priority=1},       -- __/__,  48 [205] (20, __)
    legs={name="Futhark Trousers +3", priority=1},    -- __/__,  89 [107] (30, __)
    feet="Erilaz Greaves +3",                         -- 11/11, 157 [ 48] (__, __)
    neck="Futhark Torque +2",                         --  7/ 7,  30 [ 60] (__, __)
    ear1="Sanare Earring",                            -- __/__,   6 [___] (__, __); M. Def Bonus+4
    ear2="Arete del Luna +1",                         -- __/__, ___ [___] (__, __); Resists
    ring1="Sheltered Ring",                           -- __/__, ___ [___] (__, __); Enhances Protect/Shell
    ring2="Defending Ring",                           -- 10/10, ___ [___] (__, __)
    back={name="Moonlight Cape", priority=1},         --  6/ 6, ___ [275] (__, __)
    waist="Platinum Moogle Belt",                     --  3/ 3,  15 [___] (__, __); HP+10%
    -- HP from belt                                                  343
    -- Merits/Traits/Gifts                                                (20, 52)
    -- 49 PDT/49 MDT, 603 M.Eva [942/1285 HP] (95 Enh Duration, N/A Enh Skill)
  }
  sets.midcast.Shell = set_combine(sets.midcast.Protect, {})

  sets.midcast['Phalanx'] = {
    ammo="Staunch Tathlum +1",                  -- _, ___, 11 [ 3/ 3, ___] ___
    head="Futhark Bandeau +3",                  -- 7, ___, __ [ 6/__,  73]  56
    body=gear.Herc_Phalanx_body,                -- 5, ___, __ [__/__,  69]  61
    hands=gear.Herc_Phalanx_hands,              -- 5, ___, __ [ 2/__,  43]  20
    legs=gear.Herc_Phalanx_legs,                -- 5, ___, __ [ 2/__,  75]  38
    feet=gear.Herc_Phalanx_feet,                -- 5, ___, __ [ 2/__,  75]   9
    neck="Futhark Torque +2",                   -- _, ___, __ [ 7/ 7,  30]  60
    ear1="Odnowa Earring +1",                   -- _, ___, __ [ 3/ 5, ___] 110
    ear2="Mimir Earring",                       -- _,  10, __ [__/__, ___] ___
    ring1="Gelatinous Ring +1",                 -- _, ___, __ [ 7/-1, ___] 135
    ring2={name="Moonlight Ring",priority=1},   -- _, ___, __ [ 5/ 5, ___] 110
    back={name="Moonlight Cape",priority=1},    -- _, ___, __ [ 6/ 6, ___] 275
    waist="Platinum Moogle Belt",               -- _, ___, __ [ 3/ 3,  15] ___; HP+10%
    -- HP from belt                                                        337
    -- Base/Traits/Gifts                           _, 440,  8 [__/__, ___] ___
    -- Master Levels                                   28
    -- 27 Phalanx, 478 Enh Skill, 19% SIRD [46 PDT/28 MDT, 380 M.Eva] 874/1211 HP
    -- 61 Total Phalanx
    
    -- Master Levels                                   50
    -- 27 Phalanx, 500 Enh Skill, 19% SIRD [46 PDT/28 MDT, 380 M.Eva] 874/1211 HP
    -- 62 Total Phalanx
  }
  sets.midcast['Phalanx'].Embolden = set_combine(sets.midcast['Phalanx'], {
    back=gear.RUN_Adoulin_Cape, -- +15% duration
  })

  sets.midcast['Aquaveil'] = set_combine(sets.SIRD, {})

  -- Regen 4 base potency 30 hp/tic. Base duration 60s.
  sets.midcast['Regen'] = {
    ammo="Staunch Tathlum +1",                  -- __, __, __, __ [ 3/ 3, ___] ___
    head="Runeist Bandeau +3",                  -- __, 27, __, __ [__/__,  83] 109
    body=gear.Nyame_B_body,                     -- __, __, __, __ [ 9/ 9, 139] 136
    hands="Regal Gauntlets",                    -- __, __, 20, __ [__/__,  48] 205
    legs="Futhark Trousers +3",                 -- __, __, 30, __ [__/__,  89] 107
    feet="Erilaz Greaves +3",                   -- __, __, __, __ [11/11, 157]  48
    neck="Sacro Gorget",                        -- 10, __, __, __ [__/__, ___]  50
    ear1="Odnowa Earring +1",                   -- __, __, __, __ [ 3/ 5, ___] 110
    ear2="Erilaz Earring",                      -- __, 10, __, __ [__/__,  10] ___
    ring1="Gelatinous Ring +1",                 -- __, __, __, __ [ 7/-1, ___] 135
    ring2="Defending Ring",                     -- __, __, __, __ [10/10, ___] ___
    back="Moonlight Cape",                      -- __, __, __, __ [ 6/ 6, ___] 275
    waist="Sroda Belt",                         -- 20, __, __, 15 [__/__, ___] ___
    -- Merits/Traits/Gifts                         __, __, 20, __
    -- 30% Regen Potency, 37 Regen Potency, 70 Enh Duration %, 15 Regen Duration [49 PDT/43 MDT, 526 M.Eva] 1175 HP
    -- Regen IV 76 hp/tic @117 sec

    -- main=gear.Morgelai_C,                    -- __, 25, __, __ [__/__, ___] 130
    -- ammo="Staunch Tathlum +1",               -- __, __, __, __ [ 3/ 3, ___] ___
    -- head="Runeist Bandeau +3",               -- __, 27, __, __ [__/__,  83] 109
    -- body=gear.Taeon_Regen_body,              -- __,  3, __, __ [__/__,  84]  59
    -- hands="Regal Gauntlets",                 -- __, __, 20, __ [__/__,  48] 205
    -- legs="Futhark Trousers +3",              -- __, __, 30, __ [__/__,  89] 107
    -- feet="Erilaz Greaves +3",                -- __, __, __, __ [11/11, 157]  48
    -- neck="Sacro Gorget",                     -- 10, __, __, __ [__/__, ___]  50
    -- ear1="Odnowa Earring +1",                -- __, __, __, __ [ 3/ 5, ___] 110
    -- ear2="Erilaz Earring +2",                -- __, 12, __, __ [ 6/ 6,  12] ___
    -- ring1="Gelatinous Ring +1",              -- __, __, __, __ [ 7/-1, ___] 135
    -- ring2="Defending Ring",                  -- __, __, __, __ [10/10, ___] ___
    -- back="Moonlight Cape",                   -- __, __, __, __ [ 6/ 6, ___] 275
    -- waist="Sroda Belt",                      -- 20, __, __, 15 [__/__, ___] ___
    -- Merits/Traits/Gifts                         __, __, 20, __
    -- 30% Regen Potency, 67 Regen Potency, 70 Enh Duration %, 15 Regen Duration [49 PDT/43 MDT, 473 M.Eva] 1263 HP
    -- Regen IV 106 hp/tic @117 sec
  }

  sets.midcast.Refresh = set_combine(sets.HeavyDef, sets.midcast.EnhancingDuration, {
    head="Erilaz Galea +3",
    back={name="Moonlight Cape", priority=1},
    waist="Gishdubar Sash",
  })

  sets.midcast.Stoneskin = {
    ammo="Staunch Tathlum +1",                      --  3/ 3, ___ [___] __
    head=gear.Nyame_B_head,                         --  7/ 7, 123 [ 91] __
    body=gear.Nyame_B_body,                         --  9/ 9, 139 [136] __
    hands={name="Turms Mittens +1",priority=1},     -- __/__, 101 [ 74] __
    legs="Erilaz Leg Guards +3",                    -- 13/13, 157 [100] __
    feet="Turms Leggings +1",                       -- __/__, 147 [ 76] __
    neck={name="Unmoving Collar +1",priority=1},    -- __/__, ___ [200] __
    ear1="Odnowa Earring +1",                       --  3/ 5, ___ [110] __
    ear2="Arete del Luna +1",                       -- __/__, ___ [___] __; Resist stun, bind, gravity, sleep, charm, light
    ring1="Gelatinous Ring +1",                     --  7/-1, ___ [135] __
    ring2={name="Moonlight Ring", priority=1},      --  5/ 5, ___ [110] __
    back={name="Moonlight Cape", priority=1},       --  6/ 6, ___ [275] __
    waist="Siegel Sash",                            -- __/__, ___ [___] 20
    -- 53 PDT/47 MDT, 667 M.Eva [1307 HP] 20 Stoneskin Potency

    -- hands={name="Stone Mufflers", priority=1},   -- __/__, ___ [ 10] 30
    -- 53 PDT/47 MDT, 566 M.Eva [1243 HP] 50 Stoneskin Potency
  }
  sets.midcast.Flash = set_combine(sets.Enmity, {})
  sets.midcast.Foil = set_combine(sets.Enmity, {})
  sets.midcast.Stun = set_combine(sets.Enmity, {})

  sets.midcast.Utsusemi = set_combine(sets.SIRD, {})
  sets.midcast['Geist Wall'] = set_combine(sets.SIRD, {})
  sets.midcast['Sheep Song'] = set_combine(sets.SIRD, {})
  sets.midcast['Bomb Toss'] = set_combine(sets.SIRD, {})
  sets.midcast['Poisonga'] = set_combine(sets.SIRD, {})

  sets.midcast['Dia'] = set_combine(sets.SIRD, {})
  sets.midcast['Dia II'] = set_combine(sets.SIRD, {})
  sets.midcast['Diaga'] = set_combine(sets.SIRD, {})

  -- Cure Options      MND, VIT, Heal skill, Cure Pot (self pot) [PDT/MDT, M.Eva] HP
  -- body="Vrikodara Jupon",        -- 29, 21, __, 13(__) [ 3/__,  80]  54
  -- hands="Buremte Gloves",        -- 26, 27, __, __(13) [__/__,  32]  19
  -- hands="Weatherspoon Cuffs +1", -- 33, 25, __,  9(__) [__/__,  37]  37
  -- feet="Skaoi Boots",            -- 17, 12, __,  7(__) [__/__, 107]  65
  -- neck="Phalaina Locket",        --  3, __, __,  4( 4) [__/__, ___] ___
  -- neck="Sacro Gorget",           -- __, __, __, 10(__) [__/__, ___]  50
  -- ear1="Roundel Earring",        -- __, __, __,  5(__) [__/__, ___] ___
  -- ear1="Mendicant's Earring",    -- __, __, __,  5(__) [__/__, ___] ___
  -- ring1="Lebeche Ring",          -- __, __, __,  3(__) [__/__, ___] ___
  -- ring1="Menelaus's Ring",       -- __, __, 15,  5(__) [__/__, ___] ___
  -- waist="Sroda Belt",            -- __, __, __, 35(__) [__/__, ___] ___
  -- waist="Gishdubar Sash",        -- __, __, __, __(10) [__/__, ___] ___

  sets.midcast['Blue Magic'] = {}
  sets.midcast['Blue Magic'].Enmity = set_combine(sets.Enmity, {})
  sets.midcast['Blue Magic'].Buffs = set_combine(sets.SIRD, {})
  -- BLU cures are affected by MND, VIT, and blue skill. The MND has BY FAR the greatest effect.
  -- Ignore skill entirely. It only seems to give curing at 1/10 the rate, MND is at least 3x better.
  sets.midcast['Blue Magic'].Cure = {
    ammo="Staunch Tathlum +1",                  -- __, __, __(__) [ 3/ 3, ___] ___ {11}
    head={name=gear.Nyame_B_head,priority=1},   -- 26, 24, __(__) [ 7/ 7, 123]  91 {__}
    body=gear.Nyame_B_body,                     -- 37, 45, __(__) [ 9/ 9, 139] 136 {__}
    hands={name="Regal Gauntlets",priority=1},  -- 40, 40, __(__) [__/__,  48] 205 {10}
    legs={name=gear.Nyame_B_legs,priority=1},   -- 32, 30, __(__) [ 8/ 8, 150] 114 {__}
    feet=gear.Nyame_B_feet,                     -- 26, 24, __(__) [ 7/ 7, 150]  68 {__}
    neck="Sacro Gorget",                        -- __, __, 10(__) [__/__, ___]  50 {__}
    ear1="Odnowa Earring +1",                   -- __,  3, __(__) [ 3/ 5, ___] 110 {__}
    ear2="Mendicant's Earring",                 -- __, __,  5(__) [__/__, ___] ___ {__}
    ring1="Gelatinous Ring +1",                 -- __, 15, __(__) [ 7/-1, ___] 135 {__}
    ring2={name="Moonlight Ring",priority=1},   -- __, __, __(__) [ 5/ 5, ___] 110 {__}
    back={name="Moonlight Cape",priority=1},    -- __, __, __(__) [ 6/ 6, ___] 275 {__}
    waist="Sroda Belt",                         -- __, __, 35(__) [__/__, ___] ___ {__}
    -- SIRD merits                                                                 { 8}
    -- 161 MND, 181 VIT, 50 Cure Pot (0 self pot) [55 PDT/49 MDT, 610 M.Eva] 1294 HP {29 SIRD}
  }
  sets.midcast['Blue Magic'].Cure.Safe = set_combine(sets.SIRD, {
    ammo="Staunch Tathlum +1",                  -- __, __, __(__) [ 3/ 3, ___] ___ {11}
    head="Erilaz Galea +3",                     -- 31, 24, __(__) [__/__, 119] 111 {20}
    body=gear.Nyame_B_body,                     -- 37, 45, __(__) [ 9/ 9, 139] 136 {__}
    hands={name=gear.Rawhide_B_hands.name,
      augments=gear.Rawhide_B_hands.augments,
      priority=1},                              -- 32, 34, __(__) [__/__,  37]  75 {15}
    legs={name=gear.Carmine_A_legs.name,
      augments=gear.Carmine_A_legs.augments,
      priority=1},                              -- 16, 17, __(__) [__/__,  80] 130 {20}
    feet="Erilaz Greaves +3",                   -- 31, 21, __(__) [11/11, 157]  48 {__}
    neck="Moonlight Necklace",                  -- __, __, __(__) [__/__,  15] ___ {15}
    ear1="Magnetic Earring",                    -- __, __, __(__) [__/__, ___] ___ { 8}
    ear2="Halasz Earring",                      -- __, __, __(__) [__/__, ___] ___ { 5}
    ring1="Gelatinous Ring +1",                 -- __, 15, __(__) [ 7/-1, ___] 135 {__}
    ring2="Defending Ring",                     -- __, __, __(__) [10/10, ___] ___ {__}
    back={name="Moonlight Cape",priority=1},    -- __, __, __(__) [ 6/ 6, ___] 275 {__}
    waist="Sroda Belt",                         -- __, __, 35(__) [__/__, ___] ___ {__}
    -- SIRD merits                                                                 { 8}
    -- 147 MND, 156 VIT, 35 Cure Pot (0 self pot) [46 PDT / 38 MDT, 547 M.Eva] 910 HP {102 SIRD}
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",             -- 10,  3, __, __ < 3, __, __> [__/__, ___] ___
    head=gear.Nyame_B_head,           -- 25, __, 50,  6 < 5, __, __> [ 7/ 7, 123]  91
    body="Ashera Harness",            -- 40, 10, 45,  4 <__, __, __> [ 7/ 7,  96] 182
    hands=gear.Adhemar_A_hands,       -- 56,  7, 52,  5 <__,  4, __> [__/__,  43]  22
    legs=gear.Samnuha_legs,           -- 16,  7, 15,  6 < 3,  3, __> [__/__,  75]  41
    feet=gear.Herc_TA_feet,           -- 24, __, 23,  4 <__,  6, __> [ 2/__,  75]   9
    neck="Anu Torque",                -- __,  7, __, __ <__, __, __> [__/__, ___] ___
    ear1="Telos Earring",             -- __,  5, 10, __ < 1, __, __> [__/__, ___] ___
    ear2="Sherida Earring",           --  5,  5, __, __ < 5, __, __> [__/__, ___] ___
    ring1="Epona's Ring",             -- __, __, __, __ < 3,  3, __> [__/__, ___] ___
    ring2="Niqmaddu Ring",            -- 10, __, __, __ <__, __,  3> [__/__, ___] ___
    back=gear.RUN_TP_Cape,            -- 20, 10, 30, __ <__, __, __> [10/__, ___] ___
    waist="Kentarch Belt +1",         -- 10,  5, 14, __ < 3, __, __> [__/__, ___] ___
    -- 216 DEX, 59 STP, 269 Acc, 25 Haste <23 DA, 16 TA, 3 QA> [26 PDT/14 MDT, 412 M.Eva] 415 HP
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Yamarang",                  -- __,  3, 15, __ <__, __, __> [__/__, ___] ___
    ear2="Cessance Earring",          -- __,  3,  6, __ < 3, __, __> [__/__, ___] ___
    ring2="Chirich Ring +1",          -- __,  6, 10, __ <__, __, __> [__/__, ___] ___
    -- neck="Combatant's Torque",     -- __,  4, __, __ <__, __, __> [__/__, ___] ___; skill+15
    -- 191 DEX, 60 STP, 300 Acc, 25 Haste <18 DA, 16 TA, 0 QA> [26 PDT/14 MDT, 412 M.Eva] 415 HP
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    feet=gear.Nyame_B_feet,           -- 26, __, 53,  3 < 5, __, __> [ 7/ 7, 150]  68
    ear2="Dignitary's Earring",       -- __,  3, 10, __ <__, __, __> [__/__, ___] ___
    -- 193 DEX, 60 STP, 334 Acc, 24 Haste <20 DA, 10 TA, 0 QA> [31 PDT/21 MDT, 487 M.Eva] 474 HP
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    legs=gear.Nyame_B_legs,           -- __, __, 40,  5 < 6, __, __> [ 8/ 8, 150] 114
    ring1="Chirich Ring +1",          -- __,  6, 10, __ <__, __, __> [__/__, ___] ___
    waist="Olseni Belt",              -- __,  3, 20, __ <__, __, __> [__/__, ___] ___
    -- 167 DEX, 57 STP, 375 Acc, 23 Haste <17 DA, 4 TA, 0 QA> [39 PDT/29 MDT, 562 M.Eva] 547 HP
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = {
    ammo="Staunch Tathlum +1",        -- __, __, __, __ <__, __, __> [ 3/ 3, ___] ___
    head=gear.Nyame_B_head,           -- 25, __, 50,  6 < 5, __, __> [ 7/ 7, 123]  91
    body="Ashera Harness",            -- 40, 10, 45,  4 <__, __, __> [ 7/ 7,  96] 182
    hands=gear.Adhemar_A_hands,       -- 56,  7, 52,  5 <__,  4, __> [__/__,  43]  22
    legs=gear.Samnuha_legs,           -- 16,  7, 15,  6 < 3,  3, __> [__/__,  75]  41
    feet="Erilaz Greaves +3",         -- 36, __, 60,  4 <__, __, __> [11/11, 157]  48
    neck="Anu Torque",                -- __,  7, __, __ <__, __, __> [__/__, ___] ___
    ear1="Telos Earring",             -- __,  5, 10, __ < 1, __, __> [__/__, ___] ___
    ear2="Sherida Earring",           --  5,  5, __, __ < 5, __, __> [__/__, ___] ___
    ring1="Moonlight Ring",           -- __,  5,  8, __ <__, __, __> [ 5/ 5, ___] 110
    ring2="Moonlight Ring",           -- __,  5,  8, __ <__, __, __> [ 5/ 5, ___] 110
    back=gear.RUN_TP_Cape,            -- 20, 10, 30, __ <__, __, __> [10/__, ___] ___
    waist="Platinum Moogle Belt",     -- __, __, __, __ <__, __, __> [ 3/ 3,  15] ___; HP+10%
    -- HP from belt                                                               317
    -- 198 DEX, 61 STP, 308 Acc, 25 Haste <14 DA, 7 TA, 0 QA> [51 PDT/41 MDT, 509 M.Eva] 674/991 HP
  }
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.HeavyDef, {
    ear2="Cessance Earring",          -- __,  3,  6, __ < 3, __, __> [__/__, ___] ___
    -- neck="Combatant's Torque",     -- __,  4, __, __ <__, __, __> [__/__, ___] ___; skill+15
    -- 193 DEX, 56 STP, 314 Acc, 25 Haste <12 DA, 7 TA, 0 QA> [51 PDT/41 MDT, 509 M.Eva] 674/991 HP
  })
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {
    ear2="Dignitary's Earring",       -- __,  3, 10, __ <__, __, __> [__/__, ___] ___
    -- 193 DEX, 56 STP, 318 Acc, 25 Haste <9 DA, 7 TA, 0 QA> [51 PDT/41 MDT, 509 M.Eva] 674/991 HP
  })
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.MidAcc.HeavyDef, {
    ammo="Yamarang",                  -- __,  3, 15, __ <__, __, __> [__/__, ___] ___
    legs=gear.Nyame_B_legs,           -- __, __, 40,  5 < 6, __, __> [ 8/ 8, 150] 114
    -- 177 DEX, 52 STP, 358 Acc, 25 Haste <12 DA, 4 TA, 0 QA> [56 PDT/46 MDT, 584 M.Eva] 747/1071 HP
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.DeathResist = {
    ring1="Eihwaz Ring", --10%
    ring2="Warden's Ring", --10%
  }
  sets.SleepyHead = { head="Frenzy Sallet", }
  sets.Embolden = {
    back=gear.RUN_Adoulin_Cape
  }
  sets.Encumbrance = {
    -- Epeolatry                    --(25)/_, ___ [___] __ (__, ___) 23, __
    sub="Alber Strap",              --  2/__, ___ [___] __ (__, ___)  5, __
    ammo="Sapience Orb",            -- __/__, ___ [___] __ (__, ___)  2,  2
    head="Halitus Helm",            -- __/__,  43 [ 88]  2 (__, ___)  8, __
    body="Erilaz Surcoat +3",       -- __/__, 130 [143] 10 (__, ___) __, 13; Retain enmity; Convert dmg to MP
    hands="Kurys Gloves",           --  2/ 2,  57 [ 25]  2 (__, ___)  9, __
    legs="Erilaz Leg Guards +3",    -- 13/13, 157 [100] 10 (__, ___) 13, __
    feet="Erilaz Greaves +3",       -- 11/11, 157 [ 48]  9 (__,  35)  8, __
    neck="Warder's Charm +1",       -- __/__, ___ [___] __ (__,  20)  8, __; Absorb magic dmg
    ear1="Odnowa Earring +1",       --  3/ 5, ___ [110] __ (__, ___) __, __
    ear2="Cryptic Earring",         -- __/__, ___ [ 40] __ (__, ___)  4, __
    ring1="Moonlight Ring",         --  5/ 5, ___ [110] __ (__, ___) __, __
    ring2="Moonlight Ring",         --  5/ 5, ___ [110] __ (__, ___) __, __
    back="Moonlight Cape",          --  6/ 6, ___ [275] __ (__, ___) __, __
    waist="Platinum Moogle Belt",   --  3/ 3,  15 [___] __ (__, ___) __, __; HP+10%
    -- HP from belt                                354
    -- Runes                        -- __/__, ___ [___] __ (__, 253) __, __
    -- Bar-spell                    -- __/__, ___ [___] __ (__, 131) __, __
    -- Trait                        -- __/__, ___ [___] 22 (__, ___) __, __
    -- 50(+25)PDT / 50 MDT, 559 Meva [1049/1403 HP] 55 M.Def.Bns. (0 Status Resist, 439 Ele Resist) 80 Enmity, 15 Fast Cast
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

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

  -- Use Swipe if Lunge is on cooldown
  if spell.english == 'Lunge' then
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if abil_recasts[spell.recast_id] > 0 then
      send_command('input /jobability "Swipe" <t>')
      eventArgs.cancel = true
      return
    end
  end

  if spell.english == 'Valiance' then
    local abil_recasts = windower.ffxi.get_ability_recasts()
    -- Use Vallation if Valiance is on cooldown or not available at current master level
    if abil_recasts[spell.recast_id] > 0 then
      send_command('input /jobability "Vallation" <me>')
      cancel_spell()
      eventArgs.handled = true
      return
    -- Cancel Vallation buff before using Valiance
    elseif abil_recasts[spell.recast_id] == 0 and buffactive['Vallation'] then
      cast_delay(0.2)
      send_command('cancel Vallation') -- command requires 'cancel' add-on to work
    end
    -- Cancel Valiance buff before using Vallation
  elseif spell.english == 'Vallation' then
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if buffactive['Valiance'] and abil_recasts[spell.recast_id] == 0 then
      cast_delay(0.2)
      send_command('cancel Valiance') -- command requires 'cancel' add-on to work
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

  -- Record which rune elements are active when Rayke or Gambit is used.
  if spell.english == 'Rayke' or spell.english == 'Gambit' then
    -- Examine all active buffs
    for k,buff_id in pairs(player.buffs) do
      -- Translate buff ID into English
      local buff_name = res.buffs:get(buff_id).en;
      -- If buff is a Rune, snapshot it as it was expended
      if runes:contains(buff_name) then
        table.insert(expended_runes, buff_name)
      end
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

  if state.DefenseMode.value ~= 'None' and state[state.DefenseMode.value .. 'DefenseMode'].value == 'Encumbrance' then
    equip(sets.Encumbrance)
    if spell.english == 'Elemental Sforzo' then
      equip(sets.precast.JA['Elemental Sforzo'])
    end
  end

  -- Override with weapons to be equipped
  if state.DefenseMode.value == 'None' or state[state.DefenseMode.value .. 'DefenseMode'].value ~= 'Encumbrance' then
    equip(select_weapons())
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.english == 'Lunge' or spell.english == 'Swipe' then
    if (spell.element == world.day_element or spell.element == world.weather_element) then
      equip({waist="Hachirin-no-Obi"})
    end
  end

  if spell.english == 'Phalanx' and buffactive['Embolden'] then
    equip(sets.midcast['Phalanx'].Embolden)
  end

  if state.DefenseMode.value == 'None' then
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
      equip(sets.midcast.EnhancingDuration)
      if spellMap == 'Refresh' then
        equip(sets.midcast.Refresh)
      end
    end
  end
  
  if state.DefenseMode.value ~= 'None' and state[state.DefenseMode.value .. 'DefenseMode'].value == 'Encumbrance' then
    equip(sets.Encumbrance)
  end
  
  -- Override with weapons to be equipped
  if state.DefenseMode.value == 'None' or state[state.DefenseMode.value .. 'DefenseMode'].value ~= 'Encumbrance' then
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

  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  if spell.name == 'Rayke' then
    if spell.interrupted then
      add_to_chat(123, 'Rayke interrupted!')
      expended_runes = {}
    else
      -- Add data to tracker table indexed by target ID
      local tracker_data = {coroutine_key=math.random(),target=spell.target}
      rayke_tracker[spell.target.id] = tracker_data

      -- Print chat message
      local element_potencies = get_element_potencies()
      local el_msg = ''
      for k,v in pairs(element_potencies) do
        el_msg = el_msg..'('..v.element
        if v.count == 1 then
          el_msg = el_msg..string.char(129,171)
        elseif v.count == 2 then
          el_msg = el_msg..string.char(129,171)..string.char(129,171)
        elseif v.count == 3 then
          el_msg = el_msg..string.char(129,171)..string.char(129,171)..string.char(129,171)
        end
        el_msg = el_msg..')'
      end

      send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png') -- Requires Timers plugin
      send_command('@input '..chat_mode..' [Rayke] Resist Down '..el_msg..' '..string.char(129, 168)..' <t>;')
      display_rayke_worn:schedule(rayke_duration, tracker_data)
      expended_runes = {} -- Reset tracking of expended runes
    end
  elseif spell.name == 'Gambit' then
    if spell.interrupted then
      expended_runes = {}
      add_to_chat(123, 'Gambit interrupted!')
    else
      -- Add data to tracker table indexed by target ID
      local tracker_data = {coroutine_key=math.random(),target=spell.target}
      gambit_tracker[spell.target.id] = tracker_data

      -- Print chat message
      local element_potencies = get_element_potencies()
      local el_msg = ''
      for k,v in pairs(element_potencies) do
        el_msg = el_msg..'('..v.element
        if v.count == 1 then
          el_msg = el_msg..string.char(129,171)
        elseif v.count == 2 then
          el_msg = el_msg..string.char(129,171)..string.char(129,171)
        elseif v.count == 3 then
          el_msg = el_msg..string.char(129,171)..string.char(129,171)..string.char(129,171)
        end
        el_msg = el_msg..')'
      end

      send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png') -- Requires Timers plugin
      send_command('@input '..chat_mode..' [Gambit] M.Def Down '..el_msg..' '..string.char(129,168)..' <t>;')
      display_gambit_worn:schedule(gambit_duration, tracker_data)
      expended_runes = {} -- Reset tracking of expended runes
    end
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  -- Override with weapons to be equipped
  if state.DefenseMode.value == 'None' or state[state.DefenseMode.value .. 'DefenseMode'].value ~= 'Encumbrance' then
    equip(select_weapons())
  end

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

  if buff == 'terror' then
    if gain then
      equip(sets.defense.PDT)
    end
  end

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
  if buff == 'terror' or buff == 'doom' or buff == 'Battuta' then
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
  if state.DefenseMode.value ~= 'None' and state[state.DefenseMode.value .. 'DefenseMode'].value == 'Encumbrance' then
    return set_combine(idleSet, sets.Encumbrance)
  end

  if state.DeathResist.value == true then
    idleSet = set_combine(idleSet, sets.DeathResist)
  end
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

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.DeathResist.value == true then
    meleeSet = set_combine(meleeSet, sets.DeathResist)
  end
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

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  meleeSet = set_combine(meleeSet, select_weapons())

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.DefenseMode.value ~= 'None' and state[state.DefenseMode.value .. 'DefenseMode'].value == 'Encumbrance' then
    return set_combine(defenseSet, sets.Encumbrance)
  end

  if buffactive['Battuta'] and state.DefenseMode.value ~= 'Magical' then
    defenseSet = set_combine(defenseSet, sets.defense.Parry)
  end
  if state.DeathResist.value == true then
    defenseSet = set_combine(defenseSet, sets.DeathResist)
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

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  -- Allow weapon swaps for Encumbrance mode
  if state[state.DefenseMode.value .. 'DefenseMode'].value ~= 'Encumbrance' then
    defenseSet = set_combine(defenseSet, select_weapons())
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
  local r_msg = state.Runes.current
  local r_color = 1
  if state.Runes.current == 'Ignis' then r_color = 167
  elseif state.Runes.current == 'Gelus' then r_color = 210
  elseif state.Runes.current == 'Flabra' then r_color = 204
  elseif state.Runes.current == 'Tellus' then r_color = 050
  elseif state.Runes.current == 'Sulpor' then r_color = 215
  elseif state.Runes.current == 'Unda' then r_color = 207
  elseif state.Runes.current == 'Lux' then r_color = 001
  elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

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
  if state.DeathResist.value then
    msg = msg .. ' Death Resist: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
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

function get_element_potencies()
  local element_potencies = {}
  for k,rune in pairs(expended_runes) do
    -- Get rune's corresponding element
    local el = silibs.elements.of_rune[rune]
    -- Find element entry if already in the table
    local el_index = nil
    for k,v in pairs(element_potencies) do
      if v.element == el then
        el_index = k
      end
    end
    -- If element was not found, add new entry
    if el_index == nil then
      table.insert(element_potencies, { element=el, count=1 })
    else -- Otherwise, increase its count
      element_potencies[el_index].count = element_potencies[el_index].count + 1
    end
  end
  return element_potencies;
end

function display_rayke_worn(tracker_data, --[[optional]]force_execute)
  -- Target info is required at minimum
  if not tracker_data or not tracker_data.target then
    return
  end

  -- If force_execute, then skip all checks and execute this function
  if not force_execute then
    -- Check if data is still being tracked, if not ignore
    local lookup = rayke_tracker[tracker_data.target.id]
    if not lookup then
      return
    end

    -- Prevent displaying message if a new coroutine has been created for this target before the
    -- first goes off, such as when you reapply Rayke before the first wears off (i.e. COR resets Rayke)
    if tracker_data.coroutine_key ~= lookup.coroutine_key then
      return
    end
  end

  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  local target_name = tracker_data.target.name
  -- Ensure execution only once by checking for saved target data
  send_command('@input '..chat_mode..' [Rayke] Just wore off!')
  -- If timer still exists, clear it
  send_command('@timers d "Rayke ['..target_name..']"') -- Requires Timers plugin

  -- Clear tracker for this target after execution
  rayke_tracker[tracker_data.target.id] = nil
end

function display_gambit_worn(tracker_data, --[[optional]]force_execute)
  -- Target info is required at minimum
  if not tracker_data or not tracker_data.target then
    return
  end

  -- If force_execute, then skip all checks and execute this function
  if not force_execute then
    -- Check if data is still being tracked, if not ignore
    local lookup = gambit_tracker[tracker_data.target.id]
    if not lookup then
      return
    end

    -- Prevent displaying message if a new coroutine has been created for this target before the
    -- first goes off, such as when you reapply Gambit before the first wears off (i.e. COR resets Gambit)
    if tracker_data.coroutine_key ~= lookup.coroutine_key then
      return
    end
  end

  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  local target_name = tracker_data.target.name
  -- Ensure execution only once by checking for saved target data
  send_command('@input '..chat_mode..' [Gambit] Just wore off!')
  -- If timer still exists, clear it
  send_command('@timers d "Gambit ['..target_name..']"') -- Requires Timers plugin

  -- Clear tracker for this target after execution
  gambit_tracker[tracker_data.target.id] = nil
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

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
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

windower.raw_register_event('incoming chunk', function(id, data, modified, injected, blocked)
  -- Listen for kill message (when an enemy is defeated)
  if id == 0x029 then -- Combat messages
    local message_id = data:unpack('H',0x19)%2^15 -- Cut off the most significant bit
    if message_id == 6 then
      local defeated_mob_id = data:unpack('I',0x09)
      local rayke_data = rayke_tracker[defeated_mob_id]
      local gambit_data = gambit_tracker[defeated_mob_id]
      if rayke_data then
        -- If timer still exists, clear it
        send_command('@timers d "Rayke ['..rayke_data.target.name..']"') -- Requires Timers plugin
        -- Clear tracker for this target
        rayke_tracker[defeated_mob_id] = nil
      end
      if gambit_data then
        -- If timer still exists, clear it
        send_command('@timers d "Gambit ['..gambit_data.target.name..']"') -- Requires Timers plugin
        -- Clear tracker for this target
        gambit_tracker[defeated_mob_id] = nil
      end
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'BLU' then
    set_macro_page(1, 22)
  elseif player.sub_job == 'DRK' or player.sub_job == 'BLM' then
    set_macro_page(2, 22)
  elseif player.sub_job == 'WAR' then
    set_macro_page(3, 22)
  else
    set_macro_page(1, 22)
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
