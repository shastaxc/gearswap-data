--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: Cancel
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
* Attempting to dismiss your pet while it is not at full HP is blocked. If it was allowed, it would put your pet on
  cooldown the same as if it was killed so there is no apparent benefit to allowing this.
  * Using "Call Wyvern" while pet is active will instead use the "Dismiss" ability (if pet is full HP).
* Recommend only using Spirit Bond if you need to heal your pet. You can activate Spirit Bond, do Restoring Breath,
  then immediately cancel Spirit Bond (press the keybind again to cancel buff). This is to avoid you as the DRG taking
  extra damage because your pet gets hit. This can cause high damage AoEs to kill you by hitting both you and your pet
  and causing you to take more damage than the game intended one person to take.
  * Using "Spirit Bond" ability while you already have the buff for it will instead cancel the buff.

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
  [ ALT+F9 ]            Cycle Ranged Accuracy
  [ F10 ]               Toggle Emergency -PDT
  [ ALT+F10 ]           Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]               Toggle Emergency -MDT
  [ F12 ]               Report current status
  [ CTRL+F12 ]          Cycle Idle modes
  [ ALT+F12 ]           Cancel Emergency -PDT/-MDT Mode
  [ WIN+C ]             Toggle Capacity Points Mode
  [ CTRL+- ]            Cycleback Main Step
  [ CTRL+= ]            Cycle Main Step
  [ ALT+- ]             Cycleback Alt Step
  [ ALT+= ]             Cycle Alt Step
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
  [ ALT+` ]             Call Wyvern/Dismiss (if pet is out)
  [ ALT+Q ]             Spirit Link
  [ CTRL+Q ]            Steady Wing
  [ ALT+W ]             Ancient Circle
  [ ALT+E ]             Dragon Breaker
  [ ALT+Z ]             Spirit Bond/Cancel Spirit Bond (if it's active)
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
[ CTRL+1 ] Jump           /ja "Jump" <t>
[ CTRL+2 ] HighJump       /ja "High Jump" <t>
[ CTRL+3 ] SuperJum       /ja "Super Jump" <t>
[ CTRL+9 ] Eat Pet        /ja "Spirit Surge" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  SoulJump       /ja "Soul Jump" <t>
[ ALT+2 ]  SpiritJu       /ja "Spirit Jump" <t>
[ ALT+3 ]  Angon          /ja "Angon" <t>
[ ALT+4 ]  HealBrea       /ja "Restoring Breath" <me>
[ ALT+9 ]  FlyHigh        /ja "FlyHigh" <me>

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
    send_command('gs c equipweapons')
  end, 4)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(14)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef', 'Regain')
  state.AttCapped = M(true, 'Attack Capped')
  state.CP = M(false, 'Capacity Points Mode')

  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
      'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
  wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

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
      ['!`'] = 'input /ja "Call Wyvern" <me>',
      ['!q'] = 'input /ja "Spirit Link" <me>',
      ['^q'] = 'input /ja "Steady Wing" <me>',
      ['!w'] = 'input /ja "Ancient Circle" <me>',
      ['!e'] = 'input /ja "Dragon Breaker" <t>',
      ['!z'] = 'input /ja "Spirit Bond" <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['SAM'] = {
      ['^numlock'] = 'input /ja "Hasso" <me>',
      ['^numpad/'] = 'input /ja "Meditate" <me>',
      ['^numpad*'] = 'input /ja "Sekkanoki" <me>',
      ['^numpad-'] = 'input /ja "Hasso" <me>',
    },
  }

  set_main_keybinds:schedule(2)
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Shining One', 'Trishula', 'Staff', 'Aeolian'}

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

  sets.Kiting = {
    legs="Carmine Cuisses +1"
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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip",}
  sets.WeaponSet['Naegling'] = {main="Naegling", sub="Regis",}
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Ternion Dagger +1",
    -- sub="Kraken Club",
  }
  sets.WeaponSet['Aeolian'] = {main="Malevolence", sub="Regis",}
  sets.WeaponSet['Aeolian'].DW = {main="Malevolence", sub="Malevolence",}
  sets.WeaponSet['Trishula'] = {main="Trishula", sub="Utu Grip",}
  sets.WeaponSet['Staff'] = {main="Reikikon", sub="Utu Grip",}


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- Overcapped DT to account for regain gear swap
  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",    -- [ 3/ 3, ___] {__/__}; status resist
    head="Peltast's Mezail +3",   -- [__/__,  98] {__/__}; Pet absorb dmg
    body=gear.Nyame_B_body,       -- [ 9/ 9, 139] {__/__}
    hands=gear.Nyame_B_hands,     -- [ 7/ 7, 112] {__/__}
    legs=gear.Nyame_B_legs,       -- [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,       -- [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",   -- [__/__, ___] {25/25}
    ear1="Enmerkar Earring",      -- [__/__, ___] { 3/ 3}
    ear2="Odnowa Earring +1",     -- [ 3/ 5, ___] {__/__}
    ring1="Moonlight Ring",       -- [ 5/ 5, ___] {__/__}
    ring2="Defending Ring",       -- [10/10, ___] {__/__}
    back=gear.DRG_STP_Cape,       -- [10/__, ___] {__/__}
    waist="Isa Belt",             -- [__/__, ___] { 3/ 3}
    -- 62 PDT/54 MDT, 649 MEVA {31 PetPDT/31 PetMDT}

    -- ear2="Anastasi Earring",   -- [__/__, ___] { 3/__}
    -- 59 PDT/49 MDT, 649 MEVA {34 PetPDT/31 PetMDT}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head=gear.Valorous_DT_head, --  3
    body="Gleti's Cuirass",     --  3
    hands="Gleti's Gauntlets",  --  2
    legs="Gleti's Breeches",    --  3
    feet="Gleti's Boots"        --  2
  }
  sets.latent_regen = {
    head="Gleti's Mask",              --  3
    body="Sacro Breastplate",         -- 13 {__}
    neck="Bathy Choker +1",           --  3 {__}
    ear1="Infused Earring",           --  1 {__}
    ring1="Chirich Ring +1",          --  2 {__}
    ring2="Chirich Ring +1",          --  2 {__}
    -- feet="Pteroslaver Greaves +3", -- __ {10}
  } -- 24 Regen {10 Pet Regen}
  sets.latent_refresh = {
    ring1="Stikini Ring +1",      --  1
    -- body="Chozoron Coselete",  --  2
    -- ring2="Stikini Ring +1",   --  1
  }

  -- Idle set could include Pteroslaver body to ensure wyvern gets support job abilities when zoning
  -- but I don't think the bonuses are strong enough to make it worth losing the defensive stats.
  sets.idle = set_combine(sets.HeavyDef, {})

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = set_combine(sets.idle, sets.HeavyDef)
  sets.idle.HeavyDef.Regain = set_combine(sets.idle.Regain, sets.HeavyDef)
  sets.idle.HeavyDef.Regen = set_combine(sets.idle.Regen, sets.HeavyDef)
  sets.idle.HeavyDef.Refresh = set_combine(sets.idle.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.HeavyDef)
  sets.idle.HeavyDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.HeavyDef)

  sets.idle.Weak = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  -- A tic must pass with the HP+ equipment still on before the HP gains are counted for the ability.
  sets.precast.JA['Spirit Surge'] = {
    body="Pteroslaver Mail +1", -- Duration +20s; +1 is acceptable
    -- body="Pteroslaver Mail +3", -- Duration +20s; +1 is acceptable
  }
  sets.precast.JA['Call Wyvern'] = {
    body="Pteroslaver Mail +1", -- Add support job abilities to pet; +1 is acceptable
    -- body="Pteroslaver Mail +3", -- Add support job abilities to pet; +1 is acceptable
  }
  sets.precast.JA['Ancient Circle'] = {
    legs="Vishap Brais +2", -- Duration +50%, potency +2%; +1 is acceptable
    -- legs="Vishap Brais +3", -- Duration +50%, potency +2%; +1 is acceptable
  }

  sets.precast.JA['Spirit Link'] = {
    hands="Peltast's Vambraces +1", -- Augments pet debuff erasure, maybe TP transfer/HP restoration
    feet="Pteroslaver Greaves +1", -- Augments pet buff duration; +1 is acceptable
    -- hands="Peltast's Vambraces +3", -- Augments pet debuff erasure, maybe TP transfer/HP restoration
  }

  -- STP > Multihit
  sets.precast.JA['Jump'] = {
    ammo="Coiste Bodhar",                 --  3, __ < 3, __, __> [__/__, ___]
    head="Flamma Zucchetto +2",           --  6, 44 <__,  5, __> [__/__,  53]
    body="Hjarrandi Breastplate",         -- 10, 47 <__, __, __> [12/12,  69]
    hands="Gleti's Gauntlets",            --  8, 55 <__, __, __> [ 7/__,  75]
    legs="Pteroslaver Brais +3",          -- 10, 39 <__, __, __> [__/__,  95]
    feet="Flamma Gambieras +2",           --  6, 42 < 6, __, __> [__/__,  86]
    neck="Vim Torque +1",                 -- 10, 15 <__, __, __> [__/__, ___]
    ear1="Telos Earring",                 --  5, 10 < 1, __, __> [__/__, ___]
    ear2="Sherida Earring",               --  5, __ < 5, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- __, __ <__, __,  3> [__/__, ___]
    ring2="Defending Ring",               -- __, __ <__, __, __> [10/10, ___]
    back=gear.DRG_STP_Cape,               -- 10, 20 <20, __, __> [10/__, ___]
    waist="Ioskeha Belt +1",              -- __, 17 < 9, __, __> [__/__, ___]
    -- 73 STP, 289 Acc <44 DA, 5 TA, 3 QA> [39 PDT/22 MDT, 378 M.Eva]
  }
  sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {})
  sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {
    feet="Peltast's Schynbalds +2",       -- __, 50 <__, __, __> [10/10, 120]; Spirit Jump TP+80
    ring2="Chirich Ring +1",              --  6, 10 <__, __, __> [__/__, ___]

    -- feet="Peltast's Schynbalds +3",    -- __, 60 <__, __, __> [11/11, 130]; Spirit Jump TP+90
    -- 73 STP, 317 Acc <38 DA, 5 TA, 3 QA> [40 PDT/23 MDT, 422 M.Eva]
  })
  sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {})
  sets.precast.JA['Super Jump'] = {}

  sets.precast.JA['Angon'] = {
    ammo="Angon",
    hands="Pteroslaver Finger Gauntlets +4", -- Increase potency based on merits; +1 is acceptable
    ear2="Dragoon's Earring", -- Chance to not deplete Angon consumable
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    ammo="Sapience Orb",              --  2 [__/__, ___] {__/__}
    head=gear.Carmine_D_head,         -- 14 [__/__,  53] {__/__}
    body="Sacro Breastplate",         -- 10 [__/__, 129] {__/__}
    hands=gear.Leyline_Gloves,        --  8 [__/__,  62] {__/__}
    legs=gear.Nyame_B_legs,           -- __ [ 8/ 8, 150] {__/__}
    feet=gear.Carmine_D_feet,         --  8 [ 4/__,  80] {__/__}
    neck="Orunmila's Torque",         --  5 [__/__, ___] {__/__}
    ear1="Loquacious Earring",        --  2 [__/__, ___] {__/__}
    ear2="Enchanter's Earring +1",    --  2 [__/__, ___] {__/__}
    ring1="Moonlight Ring",           -- __ [ 5/ 5, ___] {__/__}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__}
    back=gear.DRG_STP_Cape,           -- __ [10/__, ___] {__/__}
    waist="Isa Belt",                 -- __ [__/__, ___] { 3/ 3}
    -- 51 FC [37 PDT/23 MDT, 474 M.Eva] {Pet: 3 PDT/3 MDT}

    -- legs="Ayanmo Cosciales +2",    --  6 [ 5/ 5,  69] {__/__}
    -- 57 FC [34 PDT/20 MDT, 393 M.Eva] {Pet: 3 PDT/3 MDT}
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 26, 71, 61, 12, __ [__/__,  98]
    body=gear.Nyame_B_body,                 -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 36, 73, 51, 12, __ [__/__,  86]
    legs=gear.Nyame_B_legs,                 -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,                 -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, __, 25, 25, __, 10 [__/__, ___]
    ear1="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]
    ear2="Moonshade Earring",               -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ring1="Epaminondas's Ring",             -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Sroda Ring",                     -- 15, __, __, __, __,  3 [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 268 STR, 157 MND, 422 Attack, 294 Accuracy, 84 WSD, 13 PDL [34 PDT/24 MDT, 623 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Ishvara Earring",                 -- __, __, __, __,  2, __ [__/__, ___]
    -- 268 STR, 157 MND, 422 Attack, 290 Accuracy, 86 WSD, 13 PDL [34 PDT/24 MDT, 623 M.Eva]
  })
  sets.precast.WS.AttCapped = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 32, 71, 61, 12, __ [__/__,  98]
    body="Peltast's Plackart +3",           -- 43, 34, 74, 64, __, 10 [__/__, 109]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 36, 73, 51, 12, __ [__/__,  86]
    legs="Gleti's Breeches",                -- 49, 20, 70, 55, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,                 -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, __, 25, 25, __, 10 [__/__, ___]
    ear1="Moonshade Earring",               -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ear2="Peltast's Earring +1",            -- __, __, __, 14, __,  8 [__/__, ___]
    ring1="Epaminondas's Ring",             -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",                -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 242 STR, 148 MND, 456 Att, 367 Acc, 56 WSD, 46 PDL [25 PDT/7 MDT, 555 M.Eva]
    
    -- ear2="Peltast's Earring +2",         -- 15, __, __, 20, __,  9 [__/__, ___]
    -- 265 STR, 122 MND, 448 Att, 362 Acc, 56 WSD, 46 PDL [25 PDT/7 MDT, 555 M.Eva]
  }
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]
  })
  
  sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {})
  sets.precast.WS["Savage Blade"].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS["Savage Blade"].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS["Savage Blade"].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 85% STR; 0.75-1.75 fTP; 4 hit physical; fTP replicating
  -- Multihit > WSD > STR
  sets.precast.WS["Stardiver"] = {
    ammo="Coiste Bodhar",               -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Pteroslaver Armet +3",        -- 37, 77, 44, __, __ <__,  4, __> [__/__,  63]
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 <10, __, __> [ 9/__, 102]
    hands=gear.Nyame_B_hands,           -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- 58, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,             -- 23, 65, 53, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Fotia Gorget",                -- __, __, 10, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",           -- __, __,  4, __, __ <__, __, __> [__/__, ___]; tp bonus +250
    ear2="Sherida Earring",             --  5, __, __, __, __ < 5, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",              -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Epona's Ring",               -- __, __, __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.DRG_WS1_Cape,             -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                 -- __, __, 10, __, __ <__, __, __> [__/__, ___]; ftp+
    -- 229 STR, 377 Att, 276 Acc, 34 WSD, 9 PDL <47 DA, 7 TA, 3 QA> [41 PDT/22 MDT, 577 M.Eva]
  }
  sets.precast.WS["Stardiver"].MaxTP = set_combine(sets.precast.WS["Stardiver"], {
    ear1="Brutal Earring",              -- __, __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS["Stardiver"].AttCapped = {
    ammo="Crepuscular Pebble",          --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Pteroslaver Armet +3",        -- 37, 77, 44, __, __ <__,  4, __> [__/__,  63]
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 <10, __, __> [ 9/__, 102]
    hands=gear.Nyame_B_hands,           -- 17, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Gleti's Breeches",            -- 49, 70, 55, __,  8 <__,  5, __> [ 8/__,  75]
    feet=gear.Nyame_B_feet,             -- 23, 65, 53, 11, __ < 5, __, __> [ 7/ 7, 150]
    neck="Dragoon's Collar +2",         -- 15, 25, 25, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",           -- __, __,  4, __, __ <__, __, __> [__/__, ___]; tp bonus +250
    ear2="Peltast's Earring +1",        -- __, __, 14, __,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",              -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",            -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    back=gear.DRG_WS1_Cape,             -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                 -- __, __, 10, __, __ <__, __, __> [__/__, ___]; ftp+
    -- 233 STR, 412 Att, 340 Acc, 22 WSD, 48 PDL <30 DA, 9 TA, 3 QA> [44 PDT/17 MDT, 502 M.Eva]

    -- ear2="Peltast's Earring +2",     -- 15, __, 20, __,  9 <__, __, __> [__/__, ___]
    -- 248 STR, 412 Att, 346 Acc, 23 WSD, 48 PDL <30 DA, 9 TA, 3 QA> [44 PDT/17 MDT, 502 M.Eva]
  }
  sets.precast.WS["Stardiver"].AttCappedMaxTP = set_combine(sets.precast.WS["Stardiver"].AttCapped, {
    ear1="Brutal Earring",              -- __, __, __, __, __ < 5, __, __> [__/__, ___]
  })

  -- 60% STR / 60% VIT; 1 hit physical; Ignores 12.5-62.5% defense based on TP
  -- WSD > STR/VIT
  sets.precast.WS["Camlann's Torment"] = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 35, 71, 61, 12, __ [__/__,  98]
    body=gear.Nyame_B_body,                 -- 45, 35, 65, 40, 13, __ [ 9/ 9, 139]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 45, 73, 51, 12, __ [__/__,  86]
    legs=gear.Nyame_B_legs,                 -- 58, 30, 65, 40, 12, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,                 -- 23, 24, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 15, 25, 25, __, 10 [__/__, ___]
    ear1="Thrud Earring",                   -- 10, 10, __, __,  3, __ [__/__, ___]
    ear2="Ishvara Earring",                 -- __, __, __, __,  2, __ [__/__, ___]
    ring1="Epaminondas's Ring",             -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",                -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 263 STR, 194 VIT, 442 Att, 310 Acc, 86 WSD, 20 PDL [34 PDT/24 MDT, 623 M.Eva]
    
    -- ear2="Peltast's Earring +2",         -- 15, 15, __, 20, __,  9 [__/__, ___]
    -- 278 STR, 209 VIT, 442 Att, 330 Acc, 86 WSD, 29 PDL [34 PDT/24 MDT, 623 M.Eva]
  }
  sets.precast.WS["Camlann's Torment"].MaxTP = set_combine(sets.precast.WS["Camlann's Torment"], {})
  sets.precast.WS["Camlann's Torment"].AttCapped = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 35, 71, 61, 12, __ [__/__,  98]
    body="Peltast's Plackart +3",           -- 43, 43, 74, 64, __, 10 [__/__, 109]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 45, 73, 51, 12, __ [__/__,  86]
    legs="Gleti's Breeches",                -- 49, 37, 70, 55, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,                 -- 23, 24, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 15, 25, 25, __, 10 [__/__, ___]
    ear1="Thrud Earring",                   -- 10, 10, __, __,  3, __ [__/__, ___]
    ear2="Peltast's Earring +1",            -- __, __, __, 14, __,  8 [__/__, ___]
    ring1="Epaminondas's Ring",             -- __, __, __, __,  5, __ [__/__, ___]
    ring2="Ephramad's Ring",                -- 10, __, 20, 20, __, 10 [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 252 STR, 209 VIT, 456 Att, 363 Acc, 59 WSD, 46 PDL [25 PDT/7 MDT, 555 M.Eva]
    
    -- ear2="Peltast's Earring +2",         -- 15, 15, __, 20, __,  9 [__/__, ___]
    -- 267 STR, 224 VIT, 456 Att, 369 Acc, 59 WSD, 47 PDL [25 PDT/7 MDT, 555 M.Eva]
  }
  sets.precast.WS["Camlann's Torment"].AttCappedMaxTP = set_combine(sets.precast.WS["Camlann's Torment"].AttCapped, {})

  -- 40% STR/40% DEX
  -- WSD > STR <> DEX
  sets.precast.WS["Sonic Thrust"] = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 32, 71, 61, 12, __ [__/__,  98]
    body=gear.Nyame_B_body,                 -- 45, 24, 65, 40, 13, __ [ 9/ 9, 139]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 43, 73, 51, 12, __ [__/__,  86]
    legs=gear.Nyame_B_legs,                 -- 58, __, 65, 40, 12, __ [ 8/ 8, 112]
    feet=gear.Nyame_B_feet,                 -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, __, 25, 25, __, 10 [__/__, ___]
    ear1="Moonshade Earring",               -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ear2="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 10, 20, 20, __, 10 [__/__, ___]
    ring2="Niqmaddu Ring",                  -- 10, 10, __, __, __, __ [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 273 STR, 145 DEX, 442 Att, 314 Acc, 79 WSD, 20 PDL [34 PDT/24 MDT, 585 M.Eva]
  }
  sets.precast.WS["Sonic Thrust"].MaxTP = set_combine(sets.precast.WS["Sonic Thrust"], {
    ear1="Ishvara Earring",                 -- __, __, __, __,  2, __ [__/__, ___]
    ear2="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]

    -- ear1="Thrud Earring",                -- 10, __, __, __,  3, __ [__/__, ___]
    -- ear2="Peltast's Earring +2",         -- 15, __, __, 20, __,  9 [__/__, ___]
  })
  sets.precast.WS["Sonic Thrust"].AttCapped = {
    ammo="Knobkierrie",                     -- __, __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 32, 71, 61, 12, __ [__/__,  98]
    body="Peltast's Plackart +3",           -- 43, 39, 74, 64, __, 10 [__/__, 109]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 43, 73, 51, 12, __ [__/__,  86]
    legs="Gleti's Breeches",                -- 49, __, 70, 55, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,                 -- 23, 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, __, 25, 25, __, 10 [__/__, ___]
    ear1="Moonshade Earring",               -- __, __, __,  4, __, __ [__/__, ___]; tp bonus +250
    ear2="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 10, 20, 20, __, 10 [__/__, ___]
    ring2="Niqmaddu Ring",                  -- 10, 10, __, __, __, __ [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, __, 15, __, __, __ [__/__, ___]
    -- 262 STR, 160 DEX, 456 Att, 353 Acc, 54 WSD, 38 PDL [25 PDT/7 MDT, 555 M.Eva]
    
    -- ear2="Peltast's Earring +2",         -- 15, __, __, 20, __,  9 [__/__, ___]
    -- 267 STR, 160 DEX, 476 Att, 353 Acc, 51 WSD, 47 PDL [25 PDT/7 MDT, 555 M.Eva]
  }
  sets.precast.WS["Sonic Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Sonic Thrust"].AttCapped, {
    ear1="Ishvara Earring",                 -- __, __, __, __,  2, __ [__/__, ___]
    ear2="Thrud Earring",                   -- 10, __, __, __,  3, __ [__/__, ___]

    -- ear1="Thrud Earring",                -- 10, __, __, __,  3, __ [__/__, ___]
    -- ear2="Peltast's Earring +2",         -- 15, __, __, 20, __,  9 [__/__, ___]
  })

  -- 100% STR, 2 hit, dmg varies with TP
  -- WSD <> STR; if used with shining one, crit rate/dmg also good
  sets.precast.WS["Impulse Drive"] = {
    ammo="Knobkierrie",                     -- __, 23, __,  6, __ (__, __) [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 71, 61, 12, __ (__, __) [__/__,  98]
    body=gear.Nyame_B_body,                 -- 45, 65, 40, 13, __ (__, __) [ 9/ 9, 139]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 73, 51, 12, __ (__, __) [__/__,  86]
    legs="Peltast's Cuissots +2",           -- 48, 63, 53, __, __ (__, 12) [12/12, 120]
    feet=gear.Nyame_B_feet,                 -- 23, 65, 53, 11, __ (__, __) [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 25, 25, __, 10 ( 4, __) [__/__, ___]
    ear1="Moonshade Earring",               -- __, __,  4, __, __ (__, __) [__/__, ___]; tp bonus +250
    ear2="Peltast's Earring +1",            -- __, __, 14, __,  8 ( 5, __) [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 (__, __) [__/__, ___]
    ring2="Sroda Ring",                     -- 15, __, __, __,  3 (__, __) [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, 20, 20, 10, __ (__, __) [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, 15, __, __, __ (__, __) [__/__, ___]
    -- 258 STR, 440 Att, 341 Acc, 64 WSD, 31 PDL (9 Crit Rate, 12 Crit Dmg) [38 PDT/28 MDT, 593 M.Eva]

    -- legs="Peltast's Cuissots +3",        -- 53, 73, 63, __, __ (__, 13) [13/13, 130]
    -- ear2="Peltast's Earring +2",         -- 15, __, 20, __,  9 ( 6, __) [__/__, ___]
    -- 278 STR, 450 Att, 357 Acc, 64 WSD, 32 PDL (10 Crit Rate, 13 Crit Dmg) [39 PDT/29 MDT, 603 M.Eva]
  }
  sets.precast.WS["Impulse Drive"].MaxTP = set_combine(sets.precast.WS["Impulse Drive"], {
    ear1="Thrud Earring",                   -- 10, __, __,  3, __ (__, __) [__/__, ___]
  })
  sets.precast.WS["Impulse Drive"].AttCapped = {
    ammo="Knobkierrie",                     -- __, 23, __,  6, __ (__, __) [__/__, ___]
    head="Peltast's Mezail +3",             -- 36, 71, 61, 12, __ (__, __) [__/__,  98]
    body="Gleti's Cuirass",                 -- 39, 70, 55, __,  9 ( 8, __) [ 9/__, 102]
    hands="Pteroslaver Finger Gauntlets +4",-- 21, 73, 51, 12, __ (__, __) [__/__,  86]
    legs="Peltast's Cuissots +2",           -- 48, 63, 53, __, __ (__, 12) [12/12, 120]
    feet=gear.Nyame_B_feet,                 -- 23, 65, 53, 11, __ (__, __) [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 25, 25, __, 10 ( 4, __) [__/__, ___]
    ear1="Moonshade Earring",               -- __, __,  4, __, __ (__, __) [__/__, ___]; tp bonus +250
    ear2="Peltast's Earring +1",            -- __, __, 14, __,  8 ( 5, __) [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 (__, __) [__/__, ___]
    ring2="Sroda Ring",                     -- 15, __, __, __,  3 (__, __) [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- 30, 20, 20, 10, __ (__, __) [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, 15, __, __, __ (__, __) [__/__, ___]
    -- 252 STR, 445 Att, 356 Acc, 51 WSD, 40 PDL (17 Crit Rate, 12 Crit Dmg) [38 PDT/19 MDT, 556 M.Eva]

    -- legs="Peltast's Cuissots +3",        -- 53, 73, 63, __, __ (__, 13) [13/13, 130]
    -- ear2="Peltast's Earring +2",         -- 15, __, 20, __,  9 ( 6, __) [__/__, ___]
    -- 272 STR, 455 Att, 372 Acc, 51 WSD, 41 PDL (18 Crit Rate, 13 Crit Dmg) [39 PDT/20 MDT, 566 M.Eva]
  }
  sets.precast.WS["Impulse Drive"].AttCappedMaxTP = set_combine(sets.precast.WS["Impulse Drive"].AttCapped, {
    ear1="Thrud Earring",                   -- 10, __, __,  3, __ (__, __) [39 PDT/20 MDT, 566 M.Eva]
  })

  -- 50% STR; 4 hit, can crit
  -- Similar to Impulse Drive but giving this set more crit because probably not using Shining One.
  sets.precast.WS["Drakesbane"] = {
    ammo="Coiste Bodhar",                   -- 10, 15, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    head="Blistering Sallet +1",            -- 41, __, 53, __, __ (10, __) < 3, __, __> [__/__,  53]
    body="Hjarrandi Breastplate",           -- 38, 53, 47, __, __ (13, __) <__, __, __> [12/12,  69]
    hands=gear.Nyame_B_hands,               -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Peltast's Cuissots +2",           -- 48, 63, 53, __, __ (__, 12) <__, __, __> [12/12, 120]
    feet=gear.Nyame_B_feet,                 -- 23, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 25, 25, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",               -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Peltast's Earring +1",            -- __, __, 14, __,  8 ( 5, __) <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                  -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.DRG_WS1_Cape,                 -- 30, 20, 20, __, __ (__, __) <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- 257 STR, 341 Att, 329 Acc, 22 WSD, 28 PDL (32 Crit Rate, 12 Crit Dmg) <31 DA, 2 TA, 3 QA> [48 PDT/38 MDT, 504 M.Eva]

    -- legs="Peltast's Cuissots +3",        -- 53, 73, 63, __, __ (__, 13) <__, __, __> [13/13, 130]
    -- ear2="Peltast's Earring +2",         -- 15, __, 20, __,  9 ( 6, __) <__, __, __> [__/__, ___]
    -- back=gear.DRG_WS3_Cape,              -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
  }
  sets.precast.WS["Drakesbane"].MaxTP = set_combine(sets.precast.WS["Drakesbane"], {
    ear1="Thrud Earring",                   -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS["Drakesbane"].AttCapped = {
    ammo="Coiste Bodhar",                   -- 10, 15, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    head="Blistering Sallet +1",            -- 41, __, 53, __, __ (10, __) < 3, __, __> [__/__,  53]
    body="Gleti's Cuirass",                 -- 39, 70, 55, __,  9 ( 8, __) <10, __, __> [ 9/__, 102]
    hands=gear.Nyame_B_hands,               -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Peltast's Cuissots +2",           -- 48, 63, 53, __, __ (__, 12) <__, __, __> [12/12, 120]
    feet=gear.Nyame_B_feet,                 -- 23, 65, 53, 11, __ (__, __) < 5, __, __> [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- 15, 25, 25, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",               -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Peltast's Earring +1",            -- __, __, 14, __,  8 ( 5, __) <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                  -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.DRG_WS1_Cape,                 -- 30, 20, 20, __, __ (__, __) <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",                 -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- 258 STR, 358 Att, 337 Acc, 22 WSD, 37 PDL (27 Crit Rate, 12 Crit Dmg) <41 DA, 2 TA, 3 QA> [45 PDT/26 MDT, 537 M.Eva]

    -- legs="Peltast's Cuissots +3",        -- 53, 73, 63, __, __ (__, 13) <__, __, __> [13/13, 130]
    -- ear2="Peltast's Earring +2",         -- 15, __, 20, __,  9 ( 6, __) <__, __, __> [__/__, ___]
    -- back=gear.DRG_WS3_Cape,              -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
  }
  sets.precast.WS["Drakesbane"].AttCappedMaxTP = set_combine(sets.precast.WS["Drakesbane"].AttCapped, {
    ear1="Thrud Earring",                   -- 10, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
  })

  -- 80% DEX
  sets.precast.WS["Geirskogul"] = {
    ammo="Knobkierrie",                     -- __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 32, 71, 61, 12, __ [__/__,  98]
    body=gear.Nyame_B_body,                 -- 24, 65, 40, 13, __ [ 9/ 9, 139]
    hands="Pteroslaver Finger Gauntlets +4",-- 43, 73, 51, 12, __ [__/__,  86]
    legs=gear.Nyame_B_legs,                 -- __, 65, 40, 12, __ [ 8/ 8, 112]
    feet=gear.Nyame_B_feet,                 -- 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- __, 25, 25, __, 10 [__/__, ___]
    ear1="Odr Earring",                     -- 10, __, __, __, __ [__/__, ___]
    ear2="Thrud Earring",                   -- __, __, __,  3, __ [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 [__/__, ___]
    ring2="Epaminondas's Ring",             -- __, __, __,  5, __ [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",                 -- __, 15, __, __, __ [__/__, ___]
    -- 145 DEX, 442 Attack, 310 Accuracy, 84 WSD, 20 PDL [34 PDT/24 MDT, 585 M.Eva]

    -- back=gear.DRG_WS4_Cape,              -- 30, 20, 20, 10, __ [10/__, ___]
    -- 185 DEX, 427 Attack, 324 Accuracy, 84 WSD, 20 PDL [34 PDT/24 MDT, 585 M.Eva]
  }
  sets.precast.WS["Geirskogul"].MaxTP = set_combine(sets.precast.WS["Geirskogul"], {})
  sets.precast.WS["Geirskogul"].AttCapped = {
    ammo="Knobkierrie",                     -- __, 23, __,  6, __ [__/__, ___]
    head="Peltast's Mezail +3",             -- 32, 71, 61, 12, __ [__/__,  98]
    body="Peltast's Plackart +3",           -- 39, 74, 64, __, 10 [__/__, 109]
    hands="Pteroslaver Finger Gauntlets +4",-- 43, 73, 51, 12, __ [__/__,  86]
    legs="Gleti's Breeches",                -- __, 70, 55, __,  8 [ 8/__, 112]
    feet=gear.Nyame_B_feet,                 -- 26, 65, 53, 11, __ [ 7/ 7, 150]
    neck="Dragoon's Collar +2",             -- __, 25, 25, __, 10 [__/__, ___]
    ear1="Odr Earring",                     -- 10, __, __, __, __ [__/__, ___]
    ear2="Peltast's Earring +1",            -- __, __, 14, __,  8 [__/__, ___]
    ring1="Ephramad's Ring",                -- 10, 20, 20, __, 10 [__/__, ___]
    ring2="Epaminondas's Ring",             -- __, __, __,  5, __ [__/__, ___]
    back=gear.DRG_WS2_Cape,                 -- __, 20, 20, 10, __ [10/__, ___]
    waist="Fotia Belt",                     -- __, __, 10, __, __ [__/__, ___]; ftp+
    -- 160 DEX, 441 Attack, 373 Accuracy, 56 WSD, 46 PDL [25 PDT/7 MDT, 555 M.Eva]

    -- ear2="Peltast's Earring +1",         -- __, __, 20, __,  9 [__/__, ___]
    -- back=gear.DRG_WS4_Cape,              -- 30, 20, 20, 10, __ [10/__, ___]
    -- 190 DEX, 441 Attack, 379 Accuracy, 56 WSD, 47 PDL [25 PDT/7 MDT, 555 M.Eva]
  }
  sets.precast.WS["Geirskogul"].AttCappedMaxTP = set_combine(sets.precast.WS["Geirskogul"].AttCapped, {})

  -- 40% INT / 40% STR. dStat = INT. Deals lightning elemental damage. Damage varies with TP. 1.0-3.0 fTP
  sets.precast.WS["Raiden Thrust"] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",        -- 11, __, __ {__, 21, __} [__/__, ___]
    head=gear.Nyame_B_head,           -- 28, 26, 11 {30, __, 40} [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 42, 45, 13 {30, __, 40} [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 28, 17, 11 {30, __, 40} [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 44, 58, 12 {30, __, 40} [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 25, 23, 11 {30, __, 40} [ 7/ 7, 150]
    neck="Sibyl Scarf",               -- 10, __, __ {10, __, __} [__/__, ___]
    ear1="Friomisi Earring",          -- __, __, __ {10, __, __} [__/__, ___]
    ear2="Novio Earring",             -- __, __, __ { 7, __, __} [__/__, ___]
    ring1="Shiva Ring +1",            --  9, __, __ { 3, __, __} [__/__, ___]
    ring2="Metamorph Ring +1",        -- 16, __, __ {__, __, 15} [__/__, ___]
    back="Argochampsa Mantle",        -- __, __, __ {12, __, __} [__/__, ___]
    waist="Skrymir Cord",             -- __, __, __ { 5, 30,  5} [__/__, ___]
    -- 213 INT, 169 STR, 58 WSD {197 MAB, 51 M.Dmg, 220 M.Acc} [38 PDT/38 MDT, 674 M.Eva]
    
    -- back=gear.DRG_MAB_Cape,        -- 30, __, __ {10, 20, 20} [10/__, ___]
    -- waist="Skrymir Cord +1",       -- __, __, __ { 7, 35,  7} [__/__, ___]
    -- 243 INT, 169 STR, 58 WSD {197 MAB, 76 M.Dmg, 242 M.Acc} [48 PDT/38 MDT, 674 M.Eva]
  })
  sets.precast.WS["Raiden Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  sets.precast.WS["Thunder Thrust"] = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  -- 30% INT/30% STR. dStat = INT. 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS["Cataclysm"] = set_combine(sets.precast.WS["Raiden Thrust"], {
    ammo="Ghastly Tathlum +1",        -- 11, __, __ {__, __, 21, __} [__/__, ___]
    head="Pixie Hairpin +1",          -- 27, __, __ {28, __, __, __} [__/__, ___]
    body=gear.Nyame_B_body,           -- 42, 45, 13 {__, 30, __, 40} [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 28, 17, 11 {__, 30, __, 40} [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 44, 58, 12 {__, 30, __, 40} [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 25, 23, 11 {__, 30, __, 40} [ 7/ 7, 150]
    neck="Sibyl Scarf",               -- 10, __, __ {__, 10, __, __} [__/__, ___]
    ear1="Friomisi Earring",          -- __, __, __ {__, 10, __, __} [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __ {__, __, __, __} [__/__, ___]; TP bonus
    ring1="Shiva Ring +1",            --  9, __, __ {__,  3, __, __} [__/__, ___]
    ring2="Archon Ring",              -- __, __, __ { 5, __, __,  5} [__/__, ___]
    back="Argochampsa Mantle",        -- __, __, __ {__, 12, __, __} [__/__, ___]
    waist="Skrymir Cord",             -- __, __, __ {__,  5, 30,  5} [__/__, ___]
    -- 196 INT, 143 STR, 47 WSD {33 Dark MAB, 160 MAB, 51 M.Dmg, 170 M.Acc} [31 PDT/31 MDT, 551 M.Eva]
    
    -- back=gear.DRG_MAB_Cape,        -- 30, __, __ {__, 10, 20, 20} [10/__, ___]
    -- waist="Skrymir Cord +1",       -- __, __, __ {__,  7, 35,  7} [__/__, ___]
    -- 226 INT, 143 STR, 160 MAB, 76 M.Dmg, 192 M.Acc, 47 WSD {33 Dark MAB, 160 MAB, 76 M.Dmg, 192 M.Acc} [41 PDT/31 MDT, 551 M.Eva]
  })
  sets.precast.WS["Cataclysm"].MaxTP = set_combine(sets.precast.WS["Cataclysm"], {
    ear2="Novio Earring",             -- __, __, __ {__,  7, __, __} [__/__, ___]
  })
  sets.precast.WS["Cataclysm"].AttCapped = set_combine(sets.precast.WS["Cataclysm"], {})
  sets.precast.WS["Cataclysm"].AttCappedMaxTP = set_combine(sets.precast.WS["Cataclysm"].AttCapped, {
    ear2="Novio Earring",             -- __, __, __ {__,  7, __, __} [__/__, ___]
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Hjarrandi Helm",          -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Vim Torque +1",           -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Tempus Fugit +1",        -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
    -- 25 Haste, 79 STP, 285 Att, 287 Acc, 19 Crit Rate <21 DA, 0 TA, 3 QA> [44 PDT/27 MDT, 378 Meva] {19 PetPDT/8 PetMDT}
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    hands="Emicho Gauntlets",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    hands="Gazu Bracelets +1",
    -- body="Vishap Mail +3",
  })

  sets.engaged.SamRoll = {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Vim Torque +1",           -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
    ear1="Odnowa Earring +1",       -- __, __, __, __, __ <__, __, __> [ 3/ 5, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 25 Haste, 68 STP, 255 Att, 313 Acc, 14 Crit Rate <33 DA, 5 TA, 0 QA> [39 PDT/15 MDT, 411 Meva] {19 PetPDT/8 PetMDT}
  }
  sets.engaged.LowAcc.SamRoll = set_combine(sets.engaged.SamRoll, {
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
  })
  sets.engaged.MidAcc.SamRoll = set_combine(sets.engaged.LowAcc.SamRoll, {
    hands="Emicho Gauntlets",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc.SamRoll = set_combine(sets.engaged.MidAcc.SamRoll, {
    hands="Gazu Bracelets +1",
    -- body="Vishap Mail +3",
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = set_combine(sets.engaged, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Hjarrandi Helm",          -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Tempus Fugit +1",        -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 63 STP, 375 Att, 308 Acc, 23 Crit Rate <20 DA, 0 TA, 3 QA> [51 PDT/34 MDT, 442 Meva] {44 PetPDT/33 PetMDT}
  })
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.LowAcc, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs=gear.Nyame_B_legs,         --  5, __, 65, 40, __ < 6, __, __> [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 47 STP, 356 Att, 345 Acc, 18 Crit Rate <39 DA, 5 TA, 0 QA> [51 PDT/25 MDT, 530 Meva] {33 PetPDT/33 PetMDT}
  })
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {})
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {})

  sets.engaged.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs=gear.Nyame_B_legs,         --  5, __, 65, 40, __ < 6, __, __> [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 47 STP, 356 Att, 345 Acc, 18 Crit Rate <39 DA, 5 TA, 0 QA> [51 PDT/25 MDT, 530 Meva] {33 PetPDT/33 PetMDT}
  })
  sets.engaged.LowAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})
  sets.engaged.MidAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})
  sets.engaged.HighAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { head="Frenzy Sallet", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.FallbackShield = {
    sub="Regis"
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Dismiss pet if attempting to call wyvern (to share keybinds)
  if spell.name == 'Call Wyvern' and pet.isvalid then
    eventArgs.cancel = true
    send_command('input /ja "Dismiss" <me>')
  -- Prevent dismissing pet if pet HP is not full
  elseif spell.name == 'Dismiss' and pet.hpp < 100 then
    eventArgs.cancel = true
    add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
  -- Cancel Spirit Bond buff if pressing Spirit Bond keybind (to share keybinds)
  elseif spell.name == 'Spirit Bond' and buffactive['Spirit Bond'] then
    eventArgs.cancel = true
    send_command('cancel spirit bond')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs) 
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end

    local safeSet = sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Safe
    if state.HybridMode.value == 'HeavyDef' and safeSet then
      equip(safeSet)
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
end

function job_post_midcast(spell, action, spellMap, eventArgs)
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

function job_pet_midcast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  if buff == 'Hasso' and not gain then
    add_to_chat(167, 'Hasso just expired!')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
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
  if state.Buff['Boost'] or info.boost_temp_lock then
    meleeSet = set_combine(meleeSet, sets.BoostRegain)
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

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
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
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
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

function update_melee_groups()
  classes.CustomMeleeGroups:clear()
  
  if buffactive["samurai roll"] then
    classes.CustomMeleeGroups:append('SamRoll')
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
  set_macro_page(1, 14)
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
