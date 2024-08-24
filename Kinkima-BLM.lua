--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: N/A
Recommended addons: WSBinder, Reorganizer, PartyBuffs, Debuffed, Shortcuts
Misc Recommendations: Disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Casting Mode: Changes casting type
  * Spaekona: Reduces MP use for elemental magic, reduces DPS slightly
  * Occult: Focuses on building TP when casting elemental magic, reduces DPS greatly. Mainly for building TP for
    WS spam. Doing this with a good Cataclysm set is generally best for sustained AoE damage.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
* CP Mode: Equips Capacity Points bonus cape
* Magic Burst Mode: Toggle Magic Burst mode on or off. If on, when casting elemental magic, will
  use special MB set to deal more damage. You are expected to know when your spell is going to MB or not, and
  toggle this mode manually as needed. Good rule of thumb is to leave it on when in a party doing planned skillchains
  and off otherwise.
* Elemental Mode: Changes the focused element. The selected element is used for elemental magic keybinds, and
  storms (if subbing SCH).

Weapons
* Use keybinds to cycle weapons if you need to lock into a specific weapon set to conserve TP.
  * If Casting Mode is set to Occult this will also lock you into the Myrkr weapon set.
  * For the most part, you'll usually want to be in the Casting weapon set which will allow weapon
    to swap according to what's in each set.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* Casting Dispelga disregards all other weapon equip rules because Daybreak must be equipped to cast it. You
  will lose all your TP when casting Dispelga. You should have your previous weapons re-equipped afterward.

Abilities
* Mana Wall will lock certain pieces of gear to help with damage reduction. This causes a slight DPS reduction too.

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
  [ F10 ]               Toggle Emergency -PDT
  [ ALT+F10 ]           Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]               Toggle Emergency -MDT
  [ F12 ]               Report current status
  [ CTRL+F12 ]          Cycle Idle modes
  [ ALT+F12 ]           Cancel Emergency -PDT/-MDT Mode
  [ WIN+C ]             Toggle Capacity Points Mode
  [ CTRL+PageUp ]       Cycle Elemental Mode
  [ CTRL+PageDown ]     Cycleback Elemental Mode
  [ ALT+PageDown ]      Reset to default Elemental Mode
  [ ALT+` ]             Toggle Magic Burst mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set

Spells:
  [ ALT+Q ]             Tier 3 single target nuke
  [ ALT+W ]             Highest available single target nuke
  [ ALT+Z ]             Highest available -ga nuke
  [ ALT+X ]             -ja nuke
  ============ /SCH ============
  [ ALT+C ]             Storm
  [ ALT+/ ]             Klimaform
  ============ /RDM ============
  [ ALT+E ]             Haste
  [ ALT+U ]             Blink
  [ ALT+I ]             Stoneskin
  [ ALT+O ]             Phalanx
  [ ALT+P ]             Aquaveil
  [ ALT+' ]             Refresh
  ============ /WHM ============
  [ ALT+E ]             Haste
  [ ALT+U ]             Blink
  [ ALT+I ]             Stoneskin
  [ ALT+P ]             Aquaveil

Abilities:
  [ CTRL+` ]            Mana Wall
  ============ /SCH ============
  [ ALT+R ]             Sublimation
  [ CTRL+- ]            Light Arts/Addendum: White
  [ CTRL+= ]            Dark Arts/Addendum: Black
  [ CTRL+[ ]            Rapture (LA) / Ebullience (DA)
  [ CTRL+\ ]            Penury (LA) / Parsimony (DA)
  [ ALT+[ ]             Accession (LA) / Manifestation (DA)
  [ ALT+\ ]             Celerity (LA) / Alacrity (DA)
  ============ /RDM ============
  [ Shift+` ]           Convert

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

gs c elemental tier     Uses highest available tier single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier1    Uses tier 1 single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier2    Uses tier 2 single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier3    Uses tier 3 single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier4    Uses tier 4 single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier5    Uses tier 5 single target elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental tier6    Uses tier 6 single target elemental nuke corresponding to the selected element in the ElementMode.

gs c elemental ga       Uses highest available -ga elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental ga1      Uses tier 1 -ga elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental ga2      Uses tier 2 -ga elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental ga3      Uses tier 3 -ga elemental nuke corresponding to the selected element in the ElementMode.

gs c elemental ja       Uses -ja elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental storm    Uses SCH storm corresponding to the selected element in the ElementMode.

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] Sleep          /ma "Sleep II" <t>
[ CTRL+2 ] Break          /ma "Break" <t>
[ CTRL+3 ] Burn           /ma "Burn" <t>
[ CTRL+4 ] Cure4          /ma "Cure IV" <stpc>
[ CTRL+9 ] Manafont       /ja "Manafont" <me>
[ CTRL+0 ] Manawell       /ja "Manawell" <stpc>
[ ALT+1 ]  Sleepga        /ma "Sleepga II" <t>
[ ALT+2 ]  Breakga        /ma "Breakga" <t>
[ ALT+3 ]  Stun           /ma "Stun" <t>
[ ALT+4 ]  BreakSp        /ma "Break" playername
[ ALT+8 ]  EnmityDo       /ja "Enmity Douse" <me>
[ ALT+9 ]  SubtleSo       /ja "Subtle Sorcery" <me>
[ ALT+0 ]  EleSeal        /ja "Elemental Seal" <me>

]]--

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2 --DO NOT MOVE TO GLOBALS. MUST BE HERE.

  -- Load and initialize the include file.
  include('Mote-Include.lua') --DO NOT MOVE TO GLOBALS. MUST BE HERE.
  equip({main=empty,sub=empty})
  
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(4)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_weapon_rearm()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.CastingMode:options('Normal', 'Spaekona', 'Occult')
  state.MagicBurst = M(false, 'Magic Burst')
  state.CP = M(false, 'Capacity Points Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Cleaving', 'Myrkr'}
  state.ElementalMode = M{['description'] = 'Elemental Mode', 'Fire','Ice','Wind','Earth','Lightning','Water',}

  enfeebling_stat_map = {
    ['Addle'] = 'MND', ['Addle II'] = 'MND',
    ['Bind'] = 'INT',
    ['Blind'] = 'INT', ['Blind II'] = 'INT',
    ['Break'] = 'INT', ['Breakga'] = 'INT',
    ['Dia'] = 'MND', ['Dia II'] = 'MND', ['Dia III'] = 'MND', ['Diaga'] = 'MND',
    ['Dispel'] = 'INT', ['Dispelga'] = 'INT',
    ['Distract'] = 'MND', ['Distract II'] = 'MND', ['Distract III'] = 'MND',
    ['Frazzle'] = 'MND', ['Frazzle II'] = 'MND', ['Frazzle III'] = 'MND',
    ['Gravity'] = 'INT', ['Gravity II'] = 'INT',
    ['Paralyze'] = 'MND', ['Paralyze II'] = 'MND',
    ['Poison'] = 'INT', ['Poison II'] = 'INT', ['Poisonga'] = 'INT',
    ['Sleep'] = 'INT', ['Sleep II'] = 'INT', ['Sleepga'] = 'INT', ['Sleepga II'] = 'INT',
    ['Silence'] = 'MND',
    ['Slow'] = 'MND', ['Slow II'] = 'MND',
  }
  last_midcast_set = {} -- DO NOT MODIFY
  enfeebling_dur_gear = {
    -- Base = multiplier form of the base enhancing duration stat
    -- Aug = multiplier form of the enhancing duration stat from augments
    ['Regal Cuffs'] =           {base=0.20, aug=0.00},
    ['Duelist\'s Torque'] =     {base=0.00, aug=0.15},
    ['Duelist\'s Torque +1'] =  {base=0.00, aug=0.20},
    ['Duelist\'s Torque +2'] =  {base=0.00, aug=0.25},
    ['Snotra Earring'] =        {base=0.10, aug=0.00},
    ['Kishar Ring'] =           {base=0.10, aug=0.00},
    ['Obstinate Sash'] =        {base=0.05, aug=0.00},
  }
  enf_timer_spells = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Break', 'Breakga'}

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['@c'] = 'gs c toggle CP',
      ['!`'] = 'gs c toggle MagicBurst',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c cycleback ElementalMode',
      ['^pagedown'] = 'gs c cycle ElementalMode',
      ['!pagedown'] = 'gs c reset ElementalMode',
      ['^`'] = 'input /ja "Mana Wall" <me>',
      ['!q'] = 'gs c elemental tier3',
      ['!w'] = 'gs c elemental tier',
      ['!z'] = 'gs c elemental ga',
      ['!x'] = 'gs c elemental ja',
    },
    ['SCH'] = {
      ['!r'] = 'input /ja "Sublimation" <me>',
      ['^-'] = 'gs c scholar light',
      ['^='] = 'gs c scholar dark',
      ['^['] = 'gs c scholar power',
      ['^\\\\'] = 'gs c scholar cost',
      ['!['] = 'gs c scholar aoe',
      ['!\\\\'] = 'gs c scholar speed',
      ['!c'] = 'gs c elemental storm',
      ['!/'] = 'input /ma "Klimaform" <me>',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
    },
    ['RDM'] = {
      ['~`'] = 'input /ja "Convert" <me>',
      ['!e'] = 'input /ma "Haste" <stpc>',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!o'] = 'input /ma "Phalanx" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
      ['!\''] = 'input /ma "Refresh" <stpc>',
    },
    ['WHM'] = {
      ['!e'] = 'input /ma "Haste" <stpc>',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
    },
  }

  set_main_keybinds:schedule(2)

  send_command('lua l debuffed')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'SCH' then
    state.Buff['Light Arts'] = buffactive['Light Arts'] or false
    state.Buff['Dark Arts'] = buffactive['Dark Arts'] or false
    state.Buff['Addendum: White'] = buffactive['Addendum: White'] or false
    state.Buff['Addendum: Black'] = buffactive['Addendum: Black'] or false
  end

  select_default_macro_book()
  set_sub_keybinds:schedule(2)
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  unbind_keybinds()
  send_command('lua u debuffed')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Common
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  if sets.org then
    sets.org.job = {}
  end

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.CP = {
    back=gear.CP_Cape,
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Cleaving'] = {
    main="Mpaca's Staff",
    sub="Khonsu",
  }
  sets.WeaponSet['Myrkr'] = {
    main="Khatvanga",
    sub="Khonsu",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.HeavyDef = {
    main="Mpaca's Staff",             -- __/__, ___ [ 2]
    sub="Enki Strap",                 -- __/__,  10 [__]
    range=empty,                      -- __/__, ___ [__]
    ammo="Staunch Tathlum +1",        --  3/ 3, ___ [__]; Resist Status+11
    head="Wicce Petasos +3",          -- 11/11, 136 [__]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands=gear.Nyame_B_hands,         --  7/ 7, 112 [__]
    legs=gear.Nyame_B_legs,           --  8/ 8, 150 [__]
    feet="Wicce Sabots +3",           -- 11/11, 168 [__]
    neck="Loricate Torque +1",        --  6/ 6, ___ [__]; DEF+60
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Wuji Ring",                -- __/__, ___ [__]; Resists Charm/Sleep
    ring2="Archon Ring",              -- __/__, ___ [__]; Annul severe magic dmg
    back="Shadow Mantle",             -- __/__, ___ [__]; Occ. annuls physical dmg
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist+15
    -- 56 PDT/49 MDT, 682 M.Eva [5 Refresh]

    -- ring2="Shadow Ring",           -- __/__, ___ [__]; Occ. annuls magic dmg
    -- 56 PDT/49 MDT, 682 M.Eva [5 Refresh]
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- Technically, Prime sword Caliburnus has highest refresh
  -- Used when your weapons are locked "battle mode"
  sets.passive_refresh = {
    range=empty,                      -- __/__, ___ [__]
    ammo="Staunch Tathlum +1",        --  3/ 3, ___ [__]
    head="Volte Beret",               -- __/__, 104 [ 1]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Wicce Gloves +3",          -- 13/13,  98 [__]
    legs="Assiduity Pants +1",        -- __/__, 107 [ 2]
    feet="Volte Gaiters",             -- __/__, 142 [ 1]
    neck="Sibyl Scarf",               -- __/__, ___ [ 1]
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",          -- __/__, ___ [ 1]
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.BLM_FC_Cape,            -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist
    -- 46 PDT / 29 MDT, 557 M.Eva [10 Refresh]
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",             -- __/__, ___ [ 1]
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Manafont'] = {
    body="Archmage's Coat +1", -- Duration +30s; +1 is acceptable
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells (cap 80% FC).
  sets.precast.FC = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Wicce Gloves +3",          -- __ [13/13,  98]
    legs="Agwu's Slops",              --  7 [10/10, 134]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- 79 FC [45 PDT/46 MDT, 527 M.Eva]
  }
  sets.precast.FC.QuickMagic = set_combine(sets.precast.FC, {})

  sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    head=empty,                       -- __ [__/__, ___]
    body="Crepuscular Cloak",         -- __ [__/__, 231]
  })
  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    sub={name="Ammurapi Shield", priority=1},
  })
  
  sets.precast.FC.RDM = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body="Shamash Robe",              -- __ [10/__, 106]; Resist Silence+90
    hands="Wicce Gloves +3",          -- __ [13/13,  98]
    legs="Agwu's Slops",              --  7 [10/10, 134]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- Sub RDM trait                  -- 15
    -- 80 FC [53 PDT/46 MDT, 542 MEVA]
  }
  sets.precast.FC.QuickMagic.RDM = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Wicce Gloves +3",          -- __ [13/13,  98]
    legs="Agwu's Slops",              --  7 [10/10, 134]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __; DEF+60
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- 10 [10/10, ___]
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- Sub RDM trait                  -- 15
    -- 81 FC [51 PDT/52 MDT, 527 MEVA] 7 QM
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    range=empty,                      -- __, __, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ammo="Oshasha's Treatise",        -- __,  5,  5,  3, __ <__, __, __> (__, __) [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 50, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 40, 65, 13, __ < 7, __, __> (__, __) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> (__, __) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 53, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    ear1="Ishvara Earring",           -- __, __, __,  2, __ <__, __, __> (__, __) [__/__, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [__/__, ___]; TP Bonus+250
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> (__, __) [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> (__, __) [__/__, ___]
    back=gear.BLM_MAB_Cape,           -- __, __, __, __, __ <__, __, __> (__, __) [10/__, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    -- 179 STR, 292 Acc, 350 Att, 68 WSD, 0 PDL <28 DA, 0 TA, 0 QA> (0 Crit Rate, 0 Crit Dmg) [48 PDT/38 MDT, 674 M.Eva]
  }

  -- Dark elemental WS. Lower target M.Def. Duration varies with TP. dStat = INT.
  sets.precast.WS['Vidohunir'] = set_combine(sets.precast.WS, {
    range=empty,                      -- __, __, __, __, __ [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- 11, __, __, __, 21 [__/__, ___]
    head="Wicce Petasos +3",          -- 39, 61, __, 51, 31 [11/11, 136]
    body="Wicce Coat +3",             -- 50, 64, __, 59, 34 [__/__, 141]
    hands="Wicce Gloves +3",          -- 38, 62, __, 57, 32 [13/13,  98]
    legs="Agwu's Slops",              -- 49, 55, __, 60, 20 [10/10, 134]
    feet="Wicce Sabots +3",           -- 36, 60, __, 50, 30 [11/11, 168]
    neck="Sibyl Scarf",               -- 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        --  8, 10, __,  8, __ [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __, __, __ [__/__, ___]; TP Bonus+250
    ring1="Metamorph Ring +1",        -- 16, 15, __, __, __ [__/__, ___]
    ring2="Freke Ring",               -- 10, __, __,  8, __ [__/__, ___]
    back="Aurist's Cape +1",          -- 33, 33, __, __, __ [__/__, ___]
    waist="Acuity Belt +1",           -- 23, 15, __, __, __ [__/__, ___]
    -- 333 INT, 375 M.Acc, 0 WSD, 310 MAB, 168 M.Dmg [45 PDT/45 MDT, 677 M.Eva]
  })
  sets.precast.WS['Vidohunir'].MaxTP = set_combine(sets.precast.WS['Vidohunir'], {
    ear2="Regal Earring",             -- 10, __, __,  7, __ [__/__, ___]
  })

  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Vidohunir'], {
    head="Pixie Hairpin +1",
    ring2="Archon Ring",
  })
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Cataclysm'], {
    ear2="Regal Earring",             -- 10, __, __,  7, __ [__/__, ___]
  })
  
  sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS['Vidohunir'], {})
  sets.precast.WS['Earth Crusher'].MaxTP = set_combine(sets.precast.WS['Vidohunir'], {})
  
  -- Boost max MP and TP Bonus
  sets.precast.WS['Myrkr'] = {
    ammo="Ghastly Tathlum +1",        --  35, ___ [__/__, ___]
    head="Pixie Hairpin +1",          -- 120, ___ [__/__, ___]
    body="Wicce Coat +3",             -- 132, ___ [__/__, 141]
    hands="Wicce Gloves +3",          --  50, ___ [13/13,  98]
    legs="Wicce Chausses +3",         -- 119, ___ [__/__, 168]
    feet="Wicce Sabots +3",           --  50, ___ [11/11, 168]
    neck="Orunmila's Torque",         --  30, ___ [__/__, ___]
    ear1="Etiolation Earring",        --  50, ___ [__/ 3, ___]
    ear2="Moonshade Earring",         -- ___, 250 [__/__, ___]
    -- ring1="Persis Ring",           --  80, ___ [__/ 1, ___]
    ring2="Mephitas's Ring +1",       -- 110, ___ [__/__, ___]
    back="Aurist's Cape +1",          --  45, ___ [__/__, ___]
    waist="Acuity Belt +1",           --  35, ___ [__/__, ___]
    -- 856 Max MP, 250 TP Bonus [24 PDT/28 MDT, 575 M.Eva]
  }
  sets.precast.WS['Myrkr'].MaxTP = set_combine(sets.precast.WS['Myrkr'], {
    -- ear2="Evans Earring",          --  50, ___ [__/__, ___]
  })
  
  -- Earth elemental. 40% STR/40% INT. dStat = INT. Damage varies with TP.
  sets.precast.WS['Earth Crusher'] = {
    range=empty,                      -- __, __, __, __, __, __ [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- __, 11, __, __, __, 21 [__/__, ___]
    head="Wicce Petasos +3",          -- 22, 39, 61, __, 51, 31 [11/11, 136]
    body=gear.Nyame_B_body,           -- 45, 42, 40, 13, 30, __ [ 9/ 9, 139]
    hands="Wicce Gloves +3",          -- 16, 38, 62, __, 57, 32 [13/13,  98]
    legs=gear.Nyame_B_legs,           -- 58, 44, 40, 12, 30, __ [ 8/ 8, 150]
    feet="Wicce Sabots +3",           -- 18, 36, 60, __, 50, 30 [11/11, 168]
    neck="Sibyl Scarf",               -- __, 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8, 10, __,  8, __ [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __, __, __, __ [__/__, ___]; TP Bonus
    ring1="Metamorph Ring +1",        -- __, 16, 15, __, __, __ [__/__, ___]
    ring2="Freke Ring",               -- __, 10, __, __,  8, __ [__/__, ___]
    back=gear.BLM_MAB_Cape,           -- __, 30, 20, __, 10, 20 [10/__, ___]
    waist="Refoccilation Stone",      -- __, __,  4, __, 10, __ [__/__, ___]
    -- 159 STR, 284 INT, 312 M.Acc, 25 WSD, 264 MAB, 134 M.Dmg [62 PDT/52 MDT, 691 M.Eva]
  }
  sets.precast.WS['Earth Crusher'].MaxTP = set_combine(sets.precast.WS['Earth Crusher'], {
    ear2="Regal Earring",             -- __, 10, __, __,  7, __ [__/__, ___]
  })

  -- Darkness elemental. 30% STR/30% INT. dStat = INT. Damage varies with TP.
  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Earth Crusher'], {
    head="Pixie Hairpin +1",          -- __, __, 27, __, __, __, __ [__/__, ___]; Dark MAB+28
    ring1="Archon Ring",              -- __, __, __,  5, __, __, __ [__/__, ___]; Dark MAB+5
  })
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Earth Crusher'].MaxTP, {
    head="Pixie Hairpin +1",          -- __, __, 27, __, __, __, __ [__/__, ___]; Dark MAB+28
    ring1="Archon Ring",              -- __, __, __,  5, __, __, __ [__/__, ___]; Dark MAB+5
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
  sets.midcast.Trust = set_combine(sets.precast.FC,{})

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to power cap) > SIRD > -DT > Enmity (to -40)
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra BLM/RDM M30 MND = 128
  -- Mithra BLM/RDM M30 VIT = 119
  -- Mithra BLM/RDM M30 Healing Magic Skill = 166
  sets.midcast.CureNormal = {
    main="Daybreak",            -- 30, 30, __, ___ [__/__, ___] __
    sub="Genbu's Shield",       --  5, __, __, ___ [10/__, ___] __
    ammo="Esper Stone +1",      -- __, __, __, ___ [__/__, ___]  5
    head=gear.Vanya_B_head,     -- 10, 27, 18,  20 [__/ 5,  75] __
    body=gear.Vanya_B_body,     -- __, 36, 23,  20 [ 1/ 4,  80] __
    hands=gear.Vanya_B_hands,   -- __, 33, 25,  20 [__/ 3,  37] __
    legs=gear.Vanya_B_legs,     -- __, 34, 12,  20 [__/__, 107] __
    feet=gear.Vayna_B_feet,     --  5, 19, 10,  40 [__/__, 107] __
    neck="Incanter's Torque",   -- __, __, __,  10 [__/__, ___] __
    ear1="Meili Earring",       -- __, __, __,  10 [__/__, ___] __
    ear2="Mendicant's Earring", --  5, __, __, ___ [__/__, ___] __
    ring1="Sirona's Ring",      -- __,  3,  3,  10 [__/__, ___] __
    ring2="Defending Ring",     -- __, __, __, ___ [10/10, ___] __
    back="Aurist's Cape +1",    -- __, 33, __, ___ [__/__, ___] __
    waist="Luminary Sash",      -- __, 10, __, ___ [__/__, ___] __
    -- Base Stats                  __,128,119, 155 [__/__, ___] __
    -- Traits/Merits/Gifts         __, __, __,  16
    -- 55 CP, 353 MND, 210 VIT, 321 Healing Skill [21 PDT/22 MDT, 406 M.Eva] 5 -Enmity
    -- 869 HP Cure IV
    
    -- main=gear.Gada_MND,      -- 18, 21, __,  18 [__/__, ___] __
    -- back=gear.BLM_Cure_Cape, -- 10, 30, __, ___ [10/__, ___] __
    -- 53 CP, 341 MND, 210 VIT, 339 Healing Skill [31 PDT/22 MDT, 406 M.Eva] 5 -Enmity
    -- 876 HP Cure IV
  }
  sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
    waist="Hachirin-no-obi",
    -- 963 HP to 1182 Cure IV depending on weather/day
  })

  sets.midcast['Enhancing Magic'] = {
    main=gear.Gada_ENH,               -- 18,  6, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __, 10,  5 [__/__, 100]
    body=gear.Telchine_ENH_body,      -- 12, 10,  5 [__/__, 104]
    hands="Wicce Gloves +3",          -- __, __, __ [13/13,  98]
    legs=gear.Telchine_ENH_legs,      -- __, 10,  5 [__/__, 132]
    feet=gear.Telchine_ENH_feet,      -- __, 10,  5 [__/__, 131]
    neck="Incanter's Torque",         -- 10, __, __ [__/__, ___]
    ear1="Mimir Earring",             -- 10, __, __ [__/__, ___]
    ear2="Andoaa Earring",            --  5, __, __ [__/__, ___]
    ring1="Stikini Ring +1",          --  8, __, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- __, __, 10 [10/__, ___]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- 63 Enh Skill, 66 Enh Duration, 35 FC [23 PDT/13 MDT, 565 M.Eva]

    -- main=gear.Gada_ENH,            -- 18,  6,  6 [__/__, ___]
    -- 63 Enh Skill, 66 Enh Duration, 41 FC [23 PDT/13 MDT, 565 M.Eva]
  }

  sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    head="Amalric Coif +1",           -- __, __, 11 [__/__,  86]  2
    -- 63 Enh Skill, 56 Enh Duration, 47 FC [23 PDT/13 MDT, 551 M.Eva] 2 Refresh potency
  })
  sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {
    back="Grapevine Cape",            -- __, __, __ [__/__, ___] __; Duration +30s
    waist="Gishdubar Sash",           -- __, __, __ [__/__, ___] __; Duration +20s
    -- 63 Enh Skill, 46 Enh Duration, 32 FC [13 PDT/13 MDT, 551 M.Eva] 2 Refresh potency
  })

  -- Stoneskin caps at 350 enhancing magic. At ML0 BLM is 316 so need some skill gear.
  -- +Stoneskin gear has no limit. Current max is +95 for BLM.
  -- Focus on DT, M.Eva, and FC for survivability while in combat
  sets.midcast.Stoneskin = {
    main=gear.Gada_ENH,               -- __, 18,  6, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, __, 10, __ [__/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head="Wicce Petasos +3",          -- __, __, __, __ [11/11, 136]
    body=gear.Telchine_ENH_body,      -- __, 12, 10,  5 [__/__, 104]
    hands="Wicce Gloves +3",          -- __, __, __, __ [13/13,  98]
    legs=gear.Nyame_B_legs,           -- __, __, __, __ [ 8/ 8, 150]
    feet="Wicce Sabots +3",           -- __, __, __, __ [11/11, 168]
    neck="Nodens Gorget",             -- 30, __, __, __ [__/__, ___]
    ear1="Earthcry Earring",          -- 10, __, __, __ [__/__, ___]
    ear2="Andoaa Earring",            -- __,  5, __, __ [__/__, ___]
    ring1="Archon Ring",              -- __, __, __, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- __, __, __, __ [10/__, ___]
    waist="Siegel Sash",              -- 20, __, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --350, __, __, 38 [__/__, ___]
    -- 410 Stoneskin+, 35 Enh Skill, 26 Enh Duration%, 43 FC [66 PDT/56 MDT, 656 M.Eva]
    
    -- main=gear.Gada_ENH,            -- __, 18,  6,  6 [__/__, ___]
    -- legs="Shedir Seraweels",       -- 35, __, __, __ [__/__, ___]
    -- 445 Stoneskin+, 35 Enh Skill, 26 Enh Duration%, 49 FC [58 PDT/48 MDT, 506 M.Eva]
  }

  -- Skill caps at 500 Enhancing Magic skill for a total of Phalanx+35.
  sets.midcast.Phalanx = {
    main=gear.Gada_ENH,                   -- __, 18,  6 [__/__, ___]
    sub="Ammurapi Shield",                -- __, __, 10 [__/__, ___]
    range=empty,                          -- __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",            -- __, __, __ [ 3/ 3, ___]
    head=gear.Merl_Phalanx_head,          --  5, __, __ [__/__,  86]
    body=gear.Merl_Phalanx_body,          --  3, __, __ [ 2/__,  91]
    hands="Wicce Gloves +3",              -- __, __, __ [13/13,  98]
    legs=gear.Telchine_ENH_legs,          -- __, __, 10 [__/__, 132]
    feet=gear.Merl_Phalanx_feet,          --  4, __, __ [__/__, 118]
    neck="Incanter's Torque",             -- __, 10, __ [__/__, ___]
    ear1="Mimir Earring",                 -- __, 10, __ [__/__, ___]
    ear2="Andoaa Earring",                -- __,  5, __ [__/__, ___]
    ring1="Stikini Ring +1",              -- __,  8, __ [__/__, ___]
    ring2="Defending Ring",               -- __, __, __ [10/10, ___]
    back=gear.BLM_FC_Cape,                -- __, __, __ [10/__, ___]
    waist="Olympus Sash",                 -- __,  5, __ [__/__, ___]
    -- Traits/Gifts/Merits                -- __,316, __ [__/__, ___]
    -- Master Levels                      -- __, __, __ [__/__, ___]
    -- 12 Phalanx+, 372 Enh Skill, 26 Enh duration [38 PDT/26 MDT, 525 M.Eva]
    -- 42 Phalanx total

    -- body=gear.Merl_Phalanx_body,       --  5, __, __ [ 2/__,  91]
    -- legs=gear.Merl_Phalanx_legs,       --  5, __, __ [__/__, 118]
    -- feet=gear.Merl_Phalanx_feet,       --  5, __, __ [__/__, 118]
    -- waist="Embla Sash",                -- __, __, 10 [__/__, ___]
    -- Master Levels                      -- __, 50, __ [__/__, ___]
    -- 20 Phalanx+, 417 Enh Skill, 26 Enh duration [38 PDT/26 MDT, 511 M.Eva]
    -- 52 Phalanx total
  }

  -- Caps at 500 enhancing magic skill. BLM should aim for the 355 breakpoint.
  sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    main="Eremite's Wand +1",         -- __, __, __, 25 [__/__, ___]
    sub="Genmei Shield",              -- __, __, __, __ [10/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, 11 [ 3/ 3, ___]
    head="Amalric Coif +1",           --  2, __, __, __ [__/__,  86]
    body="Rosette Jaseran +1",        -- __, __, __, 25 [ 5/ 5,  80]
    hands="Regal Cuffs",              --  2, __, __, __ [__/__,  53]
    legs=gear.Nyame_B_legs,           -- __, __, __, __ [ 8/ 8, 150]
    feet="Wicce Sabots +3",           -- __, __, __, __ [11/11, 168]
    neck="Loricate Torque +1",        -- __, __, __,  5 [ 6/ 6, ___]
    ear1="Magnetic Earring",          -- __, __, __,  8 [__/__, ___]
    ear2="Mimir Earring",             -- __, 10, __, __ [__/__, ___]
    ring1="Freke Ring",               -- __, __, __, 10 [__/__, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.BLM_FC_Cape,            -- __, __, __, __ [10/__, ___]
    waist="Emphatikos Rope",          --  1, __, __, 12 [__/__, ___]
    -- Traits/Gifts/Merits            -- __,316, __, 10 [__/__, ___]
    -- 5 Aquaveil+, 326 Enh skill, 0 Enh duration, 106 SIRD [63 PDT/43 MDT, 537 M.Eva]
    
    -- legs="Shedir Seraweels",       --  1, 15, __, __ [__/__, ___]
    -- 6 Aquaveil+, 341 Enh skill, 0 Enh duration, 106 SIRD [55 PDT/35 MDT, 537 M.Eva]
  })

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
    ring1="Sheltered Ring"
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shell = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell,{})

  sets.midcast.MNDEnfeebles = {
    main="Contemplator +1",           -- 228, 70, 12, __ (__, __, 20) [__/__, ___]
		sub="Khonsu",                     -- ___, 30, __, __ (__, __, __) [ 6/ 6, ___]
		ammo="Pemphredo Tathlum",         -- ___,  8, __, __ (__, __, __) [__/__, ___]
    head="Wicce Petasos +3",          -- ___, 61, 39, __ (__, __, __) [11/11, 136]
    body="Spaekona's Coat +3",        -- ___, 55, 39, __ (__, __, 21) [__/__, 100]
		hands="Wicce Gloves +3",          -- ___, 62, 47, __ (__, __, __) [13/13,  98]
		legs="Wicce Chausses +3",         -- ___, 63, 38, __ (__, __, __) [__/__, 168]
    feet="Wicce Sabots +3",           -- ___, 60, 32, __ (__, __, __) [11/11, 168]
    neck="Sorcerer's Stole +2",       -- ___, 30, 15, __ (__, __, __) [__/__, ___]
    ear1="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __) [__/__, ___]
		ring1="Stikini Ring +1",          -- ___, 11,  8, __ (__, __,  8) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11,  8, __ (__, __,  8) [__/__, ___]
    back="Aurist's Cape +1",          -- ___, 33, 33, __ (__, __, __) [__/__, ___]
    waist="Obstinate Sash",           -- ___, 15,  5, __ (__,  5, 15) [__/__, ___]
    -- 228 M.Acc skill, 529 M.Acc, 282 MND, 4 FC (0 Enf. Effect, 5 Enf. Duration, 72 Enf. Skill) [41 PDT/41 MDT, 670 M.Eva]
    
		-- head=empty,                    -- ___, __, __, __ (__, __, __) [__/__, ___]
		-- body="Cohort Cloak +1",        -- ___,120, 76, __ (__, __, 34) [__/__, 156]
		-- ear2="Crepuscular Earring",    -- ___, 10, __, __ (__, __, __) [__/__, ___]
    -- 228 M.Acc skill, 533 M.Acc, 282 MND, 4 FC (0 Enf. Effect, 5 Enf. Duration, 85 Enf. Skill) [30 PDT/30 MDT, 590 M.Eva]
  }

  sets.midcast.INTEnfeebles = {
    main="Contemplator +1",           -- 228, 70, 12, __ (__, __, 20) [__/__, ___]
    sub="Enki Strap",                 -- ___, 10, 10, __ (__, __, __) [__/__,  10]
    ammo="Ghastly Tathlum +1",        -- ___, __, 11, __ (__, __, __) [__/__, ___]
    head="Wicce Petasos +3",          -- ___, 61, 39, __ (__, __, __) [11/11, 136]
    body="Spaekona's Coat +3",        -- ___, 55, 39, __ (__, __, 21) [__/__, 100]
    hands="Wicce Gloves +3",          -- ___, 62, 38, __ (__, __, __) [13/13,  98]
    legs="Agwu's Slops",              -- ___, 55, 54,  7 (__, __, __) [10/10, 134]
    feet="Wicce Sabots +3",           -- ___, 60, 36, __ (__, __, __) [11/11, 168]
    neck="Sorcerer's Stole +2",       -- ___, 30, 15, __ (__, __, __) [__/__, ___]
    ear1="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __) [__/__, ___]
    ear2="Regal Earring",             -- ___, __, 10, __ (__, __, __) [__/__, ___]
    ring1="Metamorph Ring +1",        -- ___, 15, 16, __ (__, __, __) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11, __, __ (__, __,  8) [__/__, ___]
    back="Aurist's Cape +1",          -- ___, 33, 33, __ (__, __, __) [__/__, ___]
    waist="Obstinate Sash",           -- ___, 15, __, __ (__,  5, 15) [__/__, ___]
    -- 228 M.Acc skill, 487 M.Acc, 321 INT, 11 FC (0 Enf. Effect, 5 Enf. Duration, 64 Enf. Skill) [45 PDT/45 MDT, 646 M.Eva]
    
		-- head=empty,                    -- ___, __, __, __ (__, __, __) [__/__, ___]
		-- body="Cohort Cloak +1",        -- ___,120, 76, __ (__, __, 34) [__/__, 156]
    -- 228 M.Acc skill, 491 M.Acc, 319 INT, 11 FC (0 Enf. Effect, 5 Enf. Duration, 77 Enf. Skill) [34 PDT/34 MDT, 566 M.Eva]
  }

  sets.midcast.Dispelga = set_combine(sets.midcast.INTEnfeeblesAcc, {
    main="Daybreak",
    sub={name="Ammurapi Shield", priority=1},
  })

  -- For spells like Burn, Choke, etc.
  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.INTEnfeebles, {
    body="Wicce Coat +3",           -- More m.acc, dropping enfeebling skill piece
    legs="Archmage's Tonban +3",    -- Enhance elemental debuffs
    feet="Archmage's Sabots +3",    -- Enhance elemental debuffs
    waist="Acuity Belt +1",         -- More m.acc, dropping enfeebling skill piece
  })

  sets.midcast.Impact = set_combine(sets.midcast.INTEnfeebles, {
    head=empty,
    body="Twilight Cloak",
    ring2="Archon Ring",
    waist="Acuity Belt +1",         -- More m.acc, dropping enfeeblign skill piece
  })

  -- Dark magic options:
  -- M.Acc Skill, Dark skill, M.Acc, INT [PDT/MDT, M.Eva]
    -- main=gear.Rubicundity,         -- 215, 25, 30, 21 [__/__, ___]
    -- head=gear.Amalric_C_head       -- ___, 20, 36, 36 [__/__,  86]
    -- legs="Spaekona's Tonban +3",   -- ___, 21, 49, 44 [__/__, 127]
    -- feet="Wicce Sabots +3",        -- ___, 35, 60, 36 [11/11, 168]
    -- neck="Erra Pendant",           -- ___, 10, 17, __ [__/__, ___]
    -- ear2="Mani Earring",           -- ___, 10, __, __ [__/__, ___]
    -- ring1="Stikini Ring +1",       -- ___,  8, 11, __ [__/__, ___]
    -- ring1="Evanescence Ring",      -- ___, 10, __, __ [__/__, ___]

  sets.midcast['Dark Magic'] = {
    main=gear.Rubicundity,            -- 215, 22, 26, 21 [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38, 13 [__/__, ___]
    range=empty,                      -- ___, __, __, __ [__/__, ___]
    ammo="Pemphredo Tathlum",         -- ___, __,  8,  4 [__/__, ___]
    head=gear.Amalric_C_head,         -- ___, 20, 36, 36 [__/__,  86]
    body="Wicce Coat +3",             -- ___, __, 64, 50 [__/__, 141]
    hands="Wicce Gloves +3",          -- ___, __, 62, 38 [13/13,  98]
    legs="Spaekona's Tonban +3",      -- ___, 21, 49, 44 [__/__, 127]
    feet="Wicce Sabots +3",           -- ___, 35, 60, 36 [11/11, 168]
    neck="Erra Pendant",              -- ___, 10, 17, __ [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10,  8 [__/__, ___]
    ear2="Mani Earring",              -- ___, 10, __, __ [__/__, ___]
    ring1="Stikini Ring +1",          -- ___,  8, 11, __ [__/__, ___]
    ring2="Evanescence Ring",         -- ___, 10, __, __ [__/__, ___]
    back="Aurist's Cape +1",          -- ___, __, 33, 33 [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15, 23 [__/__, ___]
    -- Traits/Merits/Gifts                   469
    -- 215 M.Acc Skill, 605 Dark skill, 429 M.Acc, 306 INT [24 PDT/24 MDT, 620 M.Eva]
    
    -- main=gear.Rubicundity,         -- 215, 25, 30, 21 [__/__, ___]
    -- 215 M.Acc Skill, 608 Dark skill, 433 M.Acc, 306 INT [24 PDT/24 MDT, 620 M.Eva]
  }

  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
    main=gear.Rubicundity,            -- 215, 22, 26, 21 [__/__, ___] 20
    sub="Ammurapi Shield",            -- ___, __, 38, 13 [__/__, ___] __
    range=empty,                      -- ___, __, __, __ [__/__, ___] __
    ammo="Pemphredo Tathlum",         -- ___, __,  8,  4 [__/__, ___] __
    head="Pixie Hairpin +1",          -- ___, __, __, __ [__/__, ___] __; Extra 1.28 multiplier
    body="Wicce Coat +3",             -- ___, __, 64, 50 [__/__, 141] __
    hands="Wicce Gloves +3",          -- ___, __, 62, 38 [13/13,  98] __
    legs="Spaekona's Tonban +3",      -- ___, 21, 49, 44 [__/__, 127] 20
    feet="Wicce Sabots +3",           -- ___, 35, 60, 36 [11/11, 168] __
    neck="Erra Pendant",              -- ___, 10, 17, __ [__/__, ___]  5
    ear1="Malignance Earring",        -- ___, __, 10,  8 [__/__, ___] __
    ear2="Hirudinea Earring",         -- ___, __, __, __ [__/__, ___]  3
    ring1="Stikini Ring +1",          -- ___,  8, 11, __ [__/__, ___] __
    ring2="Evanescence Ring",         -- ___, 10, __, __ [__/__, ___] 10
    back="Aurist's Cape +1",          -- ___, __, 33, 33 [__/__, ___] __
    waist="Fucho-no-obi",             -- ___, __, __, __ [__/__, ___]  8
    -- Traits/Merits/Gifts                   469
    -- 215 M.Acc Skill, 595 Dark skill, 429 M.Acc, 306 INT [24 PDT/24 MDT, 620 M.Eva] 66 Drain/Aspir potency
    
    -- main=gear.Rubicundity,         -- 215, 25, 30, 21 [__/__, ___] 20
    -- 215 M.Acc Skill, 598 Dark skill, 433 M.Acc, 306 INT [24 PDT/24 MDT, 620 M.Eva] 66 Drain/Aspir potency
  })
  sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
  sets.midcast['Aspir III'] = set_combine(sets.midcast.Drain, {
    -- ~1016MP
  })

  sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

  -- MB options:
  -- M.Acc Skill, Elemental Skill, M.Acc (INT, MAB, M.Dmg, MB, MB2) [PDT/MDT, M.Eva]
    -- main="Bunzi's Rod",            -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    -- head="Agwu's Cap",             -- ___, __, 55 (33, 60, 35,  7, __) [__/__, 107]
    -- head=gear.Nyame_B_head,        -- ___, __, 40 (28, 30, __,  5, __) [ 7/ 7, 123]
    -- head="Ea Hat +1",              -- ___, __, 50 (43, 38, __,  7,  7) [__/__, 109]
    -- body="Agwu's Robe",            -- ___, __, 55 (47, 60, 30, 10, __) [__/__, 123]
    -- body=gear.Nyame_B_body,        -- ___, __, 40 (42, 30, __,  7, __) [ 9/ 9, 139]
    -- body="Ea Houppelande +1",      -- ___, __, 52 (48, 44, __,  9,  9) [__/__, 128]
    -- hands="Agwu's Gages",          -- ___, __, 55 (33, 60, 20,  8,  6) [__/__,  96]
    -- hands=gear.Nyame_B_hands,      -- ___, __, 40 (28, 30, __,  5, __) [ 7/ 7, 112]
    -- hands="Ea Cuffs +1",           -- ___, __, 49 (40, 35, __,  6,  6) [__/__, 101]
    -- hands=gear.Amalric_D_hands,    -- ___, 14, 20 (36, 53, __, __,  6) [__/__,  48]
    -- legs="Agwu's Slops",           -- ___, __, 55 (54, 60, 20,  9, __) [10/10, 134]
    -- legs=gear.Nyame_B_legs,        -- ___, __, 40 (44, 30, __,  6, __) [ 8/ 8, 150]
    -- legs="Ea Slops +1",            -- ___, __, 51 (48, 41, __,  8,  8) [__/__, 147]
    -- feet="Agwu's Pigaches",        -- ___, __, 55 (30, 60, 20,  6, __) [__/__, 134]
    -- feet=gear.Nyame_B_feet,        -- ___, __, 40 (25, 30, __,  5, __) [ 7/ 7, 150]
    -- feet="Ea Pigaches +1",         -- ___, __, 48 ( 5, 32, __,  5,  5) [__/__, 147]
    -- neck="Sorcerer's Stole +2",    -- ___, __, 55 (15,  7, __, 10, __) [__/__, ___]
    -- neck="Warder's Charm +1",      -- ___, __, __ (__, __, __, 10, __) [__/__, ___]
    -- neck="Mizu. Kubikazari",       -- ___, __, __ ( 4,  8, __, 10, __) [__/__, ___]
    -- ring1="Locus Ring",            -- ___, __, __ (__, __, __,  5, __) [__/__, ___]
    -- ring1="Mujin Band",            -- ___, __, __ (__, __, __, __,  5) [__/__, ___]

  sets.midcast['Elemental Magic'] = {
    main="Bunzi's Rod",               -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38 (13, 38, __, __, __) [__/__, ___]
    range=empty,                      -- ___, __, __ (__, __, __, __, __) [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- ___, __, __ (11, __, 21, __, __) [__/__, ___]
    head="Ea Hat +1",                 -- ___, __, 50 (43, 38, __,  7,  7) [__/__, 109]
		body="Wicce Coat +3",             -- ___, __, 64 (50, 59, 34, __,  5) [__/__, 141]
    hands="Wicce Gloves +3",          -- ___, __, 62 (38, 57, 32, __, __) [13/13,  98]
    legs="Wicce Chausses +3",         -- ___, __, 63 (53, 58, 33, 15, __) [__/__, 168]
    feet="Wicce Sabots +3",           -- ___, __, 60 (36, 58, 33, __, __) [11/11, 168]
		neck="Sorcerer's Stole +2",       -- ___, __, 30 (15,  7, __, 10, __) [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10 ( 8,  8, __, __, __) [__/__, ___]
    ear2="Regal Earring",             -- ___, __, __ (10, __, __, __, __) [__/__, ___]
    ring1="Freke Ring",               -- ___, __, __ (10,  8, __, __, __) [__/__, ___]
    ring2="Metamorph Ring +1",        -- ___, __, 15 (16, __, __, __, __) [__/__, ___]
		back=gear.BLM_MAB_Cape,           -- ___, __, 20 (30, 10, 20,  5, __) [10/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15 (23, __, __, __, __) [__/__, ___]
    -- 255 M.Acc Skill, 0 Elemental Skill, 482 M.Acc (371 INT, 406 MAB, 421 M.Dmg, 47 MB, 12 MB2) [34 PDT/24 MDT, 684 M.Eva]

		-- hands="Agwu's Gages",          -- ___, __, 55 (33, 60, 20,  8,  6) [__/__,  96]; R30
    -- feet="Agwu's Pigaches",        -- ___, __, 55 (30, 60, 20,  6, __) [__/__, 134]; R30
    -- 255 M.Acc Skill, 0 Elemental Skill, 470 M.Acc (360 INT, 411 MAB, 396 M.Dmg, 61 MB, 18 MB2) [10 PDT/0 MDT, 648 M.Eva]
  }
  sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
    body="Spaekona's Coat +3", -- MP return
  })
  sets.midcast['Elemental Magic'].Occult = set_combine(sets.midcast['Elemental Magic'], {
    -- main="Khatvanga",              -- 30, __, 30 (__, __,279, __, __) [__/__, ___]; TP Bonus+500
    -- sub="Khonsu",                  -- __, __, 30 (__, __, __, __, __) [ 6/ 6, ___]
    ammo="Seraphic Ampulla",          --  7, __, __ ( 3, __, __, __, __) [__/__, ___]
    head=gear.Merl_Occult_head,       -- 11, __, 15 (29, 10, __, __, __) [__/__,  86]
    hands=gear.Merl_Occult_hands,     -- 11, __, __ (26, 20, __, __, __) [__/__,  48]
    body="Spaekona's Coat +3",        -- __, __, 55 (39, __, 48, __, __) [__/__, 100]
    legs="Perdition Slops",           -- 30, __, 13 (39, 13, __, __, __) [__/__, 107]
    feet=gear.Merl_Occult_feet,       -- 11, __, __ (43, 15, __, __, __) [__/__, 118]
    neck="Loricate Torque +1",        -- __, __, __ (__, __, __, __, __) [ 6/ 6, ___]
    ear1="Dedition Earring",          -- __,  8, __ (__, __, __, __, __) [__/__, ___]
    ear2="Dignitary's Earring",       -- __,  3, 10 (__, __, __, __, __) [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, __ (__, __, __, __, __) [__/__, ___]
    ring2="Chirich Ring +1",          -- __,  6, __ (__, __, __, __, __) [__/__, ___]
    back=gear.BLM_STP_Cape,           -- __, 10, __ (30, __, __,  5, __) [10/__, ___]
    waist="Oneiros Rope",             -- 20,  2, __ (__, __, __, __, __) [__/__, ___]
    -- 120 Occult, 35 STP, 153 M.Acc (209 INT, 58 MAB, 327 M.Dmg, 5 MB, 0 MB2) [22 PDT/12 MDT, 459 M.Eva]

    -- neck="Combatant's Torque",     -- __,  4, __ (__, __, __, __, __) [__/__, ___]
    -- ear2="Crepuscular Earring",    -- __,  5, 10 (__, __, __, __, __) [__/__, ___]
    -- ring2="Crepuscular Ring",      -- __,  6, 10 (__, __, __, __, __) [__/__, ___]
    -- 120 Occult, 41 STP, 163 M.Acc (209 INT, 58 MAB, 327 M.Dmg, 5 MB, 0 MB2) [16 PDT/6 MDT, 459 M.Eva]
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    -- Assume Khonsu                  --  4, __, 30 <__, __, __> [ 6/ 6, ___]
    ammo="White Tathlum",             -- __,  2, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,           --  6, __, 50 < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,           --  3, __, 40 < 7, __, __> [ 9/ 9, 139]
    hands="Gazu Bracelets +1",        -- 15, __, 96 <__, __, __> [__/__,  43]
    legs="Jhakri Slops +2",           --  2,  9, 45 <__, __, __> [__/__,  69]
    feet=gear.Nyame_B_feet,           --  3, __, 53 < 5, __, __> [ 7/ 7, 150]
    neck="Subtlety Spectacles",       -- __, __, 15 <__, __, __> [__/__, ___]
    ear1="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.BLM_STP_Cape,           -- __, 10, 20 <__, __, __> [10/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 33 Haste, 36 STP, 395 Acc <20 DA, 0 TA, 0 QA> [49 PDT/39 MDT, 524 MEVA]

    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill+15
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 33 Haste, 42 STP, 380 Acc <21 DA, 0 TA, 0 QA> [49 PDT/39 MDT, 524 MEVA]
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace",     --20
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
  }
  -- This set will be overlaid on all idle, melee, and midcast sets while Mana Wall is active
  sets.buff.ManaWall = {
    feet="Wicce Sabots +3",   -- 25 [11/11, 168]
    back=gear.BLM_FC_Cape,    -- 10 [10/__, ___]
    -- 35 Mana Wall [21 PDT/11 MDT, 168 M.Eva]
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
  -- If missing a target, or targeting an invalid target, switch target to <me>, <stpc>, or <stnpc> as appropriate
  -- if spell.action_type == 'Magic' and (
  --   (spell.target.raw == '<t>' and not spell.target.type)
  --   or (spell.target.type == 'MONSTER' and not spell.targets.Enemy)
  --   or (spell.target.type == 'SELF' and not spell.targets.Self)
  --   or (spell.target.type == 'PLAYER' and not (spell.targets.Player or spell.targets.Ally or spell.targets.Party))
  --   or (spell.target.hpp and spell.target.hpp > 0 and spell.targets.Corpse)
  --   or (spell.target.hpp and spell.target.hpp == 0 and not spell.targets.Corpse)
  -- ) then
  --   local new_target
  --   if spell.targets.Enemy then
  --     new_target = '<stnpc>'
  --   end
  --   if spell.targets.Self then
  --     new_target = '<me>'
  --   end
  --   if spell.targets.Party or spell.targets.Corpse then
  --     new_target = '<stpc>'
  --   end
  --   -- Cancel current spell and reissue command with new target
  --   send_command('@input /ma "'..spell.english..'" '..new_target)
  --   eventArgs.cancel = true
  -- end
end

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.english == 'Addendum: White' and not state.Buff['Light Arts'] then
    send_command('input /ja "Light Arts" <me>')
    eventArgs.cancel = true
  elseif spell.english == 'Addendum: Dark' and not state.Buff['Dark Arts'] then
    send_command('input /ja "Dark Arts" <me>')
    eventArgs.cancel = true
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
  end

  if state.CastingMode.value == 'Occult' then
    equip(sets.WeaponSet['Myrkr'])
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
  
  if spell.action_type == 'Magic' then
    local customEquipSet = select_specific_set(sets.midcast, spell, spellMap)
    -- Add optional casting mode
    if customEquipSet[state.CastingMode.current] then
      customEquipSet = customEquipSet[state.CastingMode.current]
    end

    if customEquipSet then
      equip(customEquipSet)
      eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
    end

    -- Add magic burst set if exists
    if state.MagicBurst.value and spell.skill == 'Elemental Magic' and customEquipSet['MB'] then
      customEquipSet = customEquipSet['MB']
    end

    if customEquipSet then
      equip(customEquipSet)
      eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
    end
  end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.skill == 'Enhancing Magic' then
    -- If self targeted refresh
    if spellMap == 'Refresh' and spell.targets.Self and sets.midcast.RefreshSelf then
      equip(sets.midcast.RefreshSelf)
    end
  end

  if buffactive['Mana Wall'] then
    equip(sets.buff.ManaWall)
  end

  -- Always put this last in job_post_midcast
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
  end
  
  if state.CastingMode.value == 'Occult' then
    equip(sets.WeaponSet['Myrkr'])
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
  last_midcast_set = set_combine(gearswap.equip_list, {})
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if not spell.interrupted then
    if in_battle_mode() and spell.english == 'Dispelga' then
      equip(select_weapons())
    elseif spell.skill == 'Enfeebling Magic' then
      set_enfeeble_timer(spell)
    elseif spell.english == 'Light Arts' then
      state.Buff['Light Arts'] = true
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Dark Arts' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = true
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Addendum: White' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = true
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Addendum: Black' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = true
    end
  end

  if in_battle_mode() then
    equip(sets.WeaponSet[state.WeaponSet.current])
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
function job_buff_change(buff, gain)
  if buff == "doom" and gain then
    equip(sets.buff.Doom)
  end
end

-- Handle notifications of general user state change.
-- Called by mote-selfcommands
function job_state_change(stateField, newValue, oldValue)
    -- print(stateField.." is now ",newValue)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
  if spell.action_type == 'Magic' then
    if default_spell_map == 'Cure' or default_spell_map == 'Curaga' or default_spell_map == 'Cura' then
      if (world.weather_element == 'Light' and not (silibs.get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        return 'CureWeather'
      else
        return 'CureNormal'
      end
    elseif spell.skill == 'Enfeebling Magic' then
      local stat = enfeebling_stat_map[spell.english]
      return stat..'Enfeebles'
    end
  end
end

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if buffactive['Sublimation: Activated'] then
      classes.CustomIdleGroups:append('Sublimation')
    end
    if (isRegening==true and player.hpp < 100) or (isRegening==false and player.hpp < 85) then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if (isRefreshing==true and player.mpp < 100) or (isRefreshing==false and player.mpp < 80) then
        classes.CustomIdleGroups:append('Refresh')
      end
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('MpSub50')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
    -- Apply time of day
    if (world.time >= (6*60) and world.time < (18*60)) then
      classes.CustomIdleGroups:append('Daytime')
      if (world.time >= (6*60) and world.time < (7*60)) then
        classes.CustomIdleGroups:append('Dawn')
      elseif (world.time >= (17*60) and world.time < (18*60)) then
        classes.CustomIdleGroups:append('Dusk')
      end
    elseif (world.time >= (18*60) or world.time < (6*60)) then
      classes.CustomIdleGroups:append('Nighttime')
    end
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

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
    -- Apply movement speed gear
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
    if state.CP.current == 'on' then
      idleSet = set_combine(idleSet, sets.CP)
    end
  end

  if buffactive['Mana Wall'] then
    idleSet = set_combine(idleSet, sets.buff.ManaWall)
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

  if in_battle_mode() then
    idleSet = set_combine(idleSet, select_weapons())
  end

  if state.CastingMode.value == 'Occult' then
    idleSet = set_combine(idleSet, sets.WeaponSet['Myrkr'])
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  if buffactive['Mana Wall'] then
    meleeSet = set_combine(meleeSet, sets.buff.ManaWall)
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

  if in_battle_mode() then
    meleeSet = set_combine(meleeSet, select_weapons())
  end

  if state.CastingMode.value == 'Occult' then
    meleeSet = set_combine(meleeSet, sets.WeaponSet['Myrkr'])
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  if buffactive['Mana Wall'] then
    defenseSet = set_combine(defenseSet, sets.buff.ManaWall)
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

  if in_battle_mode() then
    defenseSet = set_combine(defenseSet, select_weapons())
  end

  if state.CastingMode.value == 'Occult' then
    defenseSet = set_combine(defenseSet, sets.WeaponSet['Myrkr'])
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
    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: '..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'elemental' then
    silibs.handle_elemental(cmdParams, state.ElementalMode.value)
    eventArgs.handled = true
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
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds:schedule(2)
    set_sub_keybinds:schedule(2)
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
  -- cmdParams[1] == 'scholar'
  -- cmdParams[2] == strategem to use

  if not cmdParams[2] then
    add_to_chat(123,'Error: No strategem command given.')
    return
  end
  local strategem = cmdParams[2]

  if strategem == 'light' then
    if state.Buff['Light Arts'] then
      send_command('input /ja "Addendum: White" <me>')
    elseif state.Buff['Addendum: White'] then
      add_to_chat(122,'Error: Addendum: White is already active.')
    else
      send_command('input /ja "Light Arts" <me>')
    end
  elseif strategem == 'dark' then
    if state.Buff['Dark Arts'] then
      send_command('input /ja "Addendum: Black" <me>')
    elseif state.Buff['Addendum: Black'] then
      add_to_chat(122,'Error: Addendum: Black is already active.')
    else
      send_command('input /ja "Dark Arts" <me>')
    end
  elseif state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
    if strategem == 'cost' then
      send_command('input /ja Penury <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Celerity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Accession <me>')
    elseif strategem == 'power' then
      send_command('input /ja Rapture <me>')
    elseif strategem == 'duration' then
      send_command('input /ja Perpetuance <me>')
    elseif strategem == 'accuracy' then
      send_command('input /ja Altruism <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Tranquility <me>')
    elseif strategem == 'skillchain' then
      add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: White" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
    if strategem == 'cost' then
      send_command('input /ja Parsimony <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Alacrity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Manifestation <me>')
    elseif strategem == 'power' then
      send_command('input /ja Ebullience <me>')
    elseif strategem == 'duration' then
      add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
    elseif strategem == 'accuracy' then
      send_command('input /ja Focalization <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Equanimity <me>')
    elseif strategem == 'skillchain' then
      send_command('input /ja Immanence <me>')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: Black" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  else
    add_to_chat(123,'No arts has been activated yet.')
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

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function select_weapons()
  if sets.WeaponSet[state.WeaponSet.current] then
    return sets.WeaponSet[state.WeaponSet.current]
  end
  return {}
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting'
end

function get_enfeebling_duration(spell, set)
  local base, gear_mult, aug_mult, empy_mult = spell.duration, 1, 1, 1

  -- Reduce set to names only
  for k,v in pairs(set) do
    set[k] = (type(v)=='table' and v.name) or (type(v)=='string' and v) or nil
    if set[k] == 'empty' then set[k] = nil end
  end

  -- Calculate gear multipliers
  for k,v in pairs(set) do
    local stats = enfeebling_dur_gear[v]
    if stats then
      gear_mult = gear_mult + stats.base
      aug_mult = aug_mult + stats.aug
    end
  end

  -- For debugging:
  -- add_to_chat(1, spell.english..' Set: '..inspect(set, {depth=2}))
  -- add_to_chat(1, spell.english
  --     ..' Base: ' ..base
  --     ..' Gear: '..gear_mult
  --     ..' Aug: '..aug_mult
  --     ..' Empy: '..empy_mult)

  local totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)
  return totalDuration
end

function set_enfeeble_timer(spell)
  -- Create the custom timer
  if enf_timer_spells:contains(spell.english) then
    local totalDuration = get_enfeebling_duration(spell, last_midcast_set)
    -- add_to_chat(1, spell.english..' duration: '..totalDuration)
    send_command('@timers c "'..spell.english..' ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00'..spell.id..'.png')
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
  if player.sub_job == 'SCH' then
    set_macro_page(2, 4)
  else
    set_macro_page(1, 4)
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
