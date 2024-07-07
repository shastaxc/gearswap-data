--[[
File Status: Good.
TODO: Cancel Boost buff if tp = 3000

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
  * Defaults to squishier/higher damage set with the assumption that MNK's higher HP will help offset the DT loss.
    If you need the extra DT you can toggle into HeavyDef mode.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
  * There is a Cait Sith PDT mode you can use during fight with the HTBF Cait Sith. Tweak the set to have the
    correct amount of HP for the fight (not divisible by 2, 3, 4, 5, or 6).
* Idle Mode: Determines which set to use when not engaged
  * Normal: Allows automatically equipping Regen, Refresh, and Regain gear as needed
  * HeavyDef: Uses defensive set and disables automatically equipping Regen, Refresh, and Regain gear
* CP Mode: Equips Capacity Points bonus cape
* Enmity Mode: Swaps gear on WS to lower enmity
  * Normal: Does not swap any -enmity gear during WS
  * Low: If you have Dirge and -Enmity merits, a simple Novia Earring will cap your -Enmity
  * Schere: Uses Schere earring during WS to actively lower enmity (only if MP > 0)
* Runes: Select a rune to use when issuing the custom rune command while subbing RUN.

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
* When Boost buff is active, sets.BoostRegain set will be locked on to provide Regain. This is the only realistic
  use of the Boost ability these days.
* When Impetus is active, and you have at least 8 consecutive hits, sets.Impetus set will be equipped
  over normal WS set.

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
  [ WIN+E ]             Cycle Enmity Mode

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
  [ ALT+` ]             Chakra
  [ ALT+Q ]             Impetus
  [ ALT+E ]             Footwork
  [ CTRL+Numpad+ ]      Boost
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
  ============ /THF ============
  [ CTRL+Numpad0 ]      Sneak Attack
  [ CTRL+Numpad. ]      Trick Attack
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
  [ CTRL+` ]            Cycle Treasure Hunter Mode

For more info and available functions, see SilverLibs documentation at:
https://github.com/shastaxc/silver-libs

Global-Binds.lua contains additional non-job-related keybinds.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  Custom Commands
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Prepend with /console to use these in in-game macros.

gs c runes              Execute rune that is selected in the Rune mode

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

gs c equipweapons       Equips weapons based on your current states that you've set.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] ChiBlast       /ja "Chi Blast" <t>
[ CTRL+2 ] Focus          /ja "Focus" <me>
[ CTRL+3 ] CStance        /ja "Counterstance" <me>
[ CTRL+4 ] HasteSam       /ja "Haste Samba" <me>
[ CTRL+6 ] Valiance       /ja "Valiance" <me>
[ CTRL+9 ] HundredF       /ja "Hundred Fists" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Stun           /ws "Shoulder Tackle" <t>
[ ALT+2 ]  Dodge          /ja "Dodge" <me>
[ ALT+3 ]  PerfCoun       /ja "Perfect Counter" <me>
[ ALT+4 ]  Erase          /ja "Healing Waltz" <stpc>
[ ALT+8 ]  Mantra         /ja "Mantra" <me>
[ ALT+9 ]  InnerStr       /ja "Inner Strength" <me>
[ ALT+0 ]  Formless       /ja "Formless Strikes" <me>

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
  silibs.enable_auto_lockstyle(2)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.Buff.Footwork = buffactive.Footwork or false
  state.Buff.Impetus = buffactive.Impetus or false

  info.impetus_hit_count = 0 -- Do not modify
  info.boost_temp_lock = false -- Do not modify

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'HeavyDef')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT', 'Cait Sith'}

  state.CP = M(false, 'Capacity Points Mode')
  state.ToyWeapons = M{['description']='Toy Weapons','None',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Verethragna', 'Piercing', 'Slashing', 'Cleaving'}
  state.EnmityMode = M{['description']='Enmity Mode', 'Normal', 'Low', 'Schere'}
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

  -- DO NOT MODIFY
  activate_AM_mode = {
    ["Verethragna"] = S{"Aftermath: Lv.3"},
  }

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  update_melee_groups()
  update_combat_form()

  select_default_macro_book()
  set_sub_keybinds()
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

  sets.Kiting = {
    feet="Hermes' Sandals",
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

  sets.Enmity = {
    ammo="Sapience Orb",  -- 0/0, 0 [0] <2>
    head="Halitus Helm", --0/0, 43 [88] <8>
    body="Emet Harness +1", --6/0, 64 [61] <10>
    hands="Kurys Gloves", --2/2, 57 [25] <9>
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Unmoving Collar +1", --_/_, __ [200] <10>
    ear1="Friomisi Earring", --0/0, 0 [0] <2>
    ear2="Cryptic Earring", --0/0, 0 [40] <4>
    ring1="Eihwaz Ring", --0/0, 0 [70] <5>
    ring2={name="Supershear Ring", priority=1}, --0/0, 0 [30] <5>
    waist={name="Kasiri Belt", priority=1}, --0/0, 0 [30] <3>
    -- feet="Ahosi Leggings", --4/0, 107 [18] <7>
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Verethragna'] = {main="Verethragna", sub=empty}
  sets.WeaponSet['Piercing'] = {main="Birdbanes", sub=empty}
  sets.WeaponSet['Slashing'] = {main="Vampiric Claws", sub=empty}
  sets.WeaponSet['Cleaving'] = {
    main="Xoanon",
    sub="Alber Strap"
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Monk's Nodowa +2",    -- __/__, ___
    ear1="Arete Del Luna +1",   -- __/__, ___; Resists
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Defending Ring",     -- 10/10, ___
    ring2="Niqmaddu Ring",      -- __/__, ___
    back=gear.MNK_DEX_DA_Cape,  -- 10/__, ___
    waist="Moonbow Belt +1",    --  6/ 6, ___
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})

  sets.HeavyDefForIdle = {
    ammo="Staunch Tathlum +1",    --  3/ 3, ___
    head=gear.Nyame_B_head,       --  7/ 7, 123`
    body=gear.Nyame_B_body,       --  9/ 9, 139
    hands=gear.Nyame_B_hands,     --  7/ 7, 112
    legs=gear.Nyame_B_legs,       --  8/ 8, 150
    feet=gear.Nyame_B_feet,       --  7/ 7, 150
    waist="Moonbow Belt +1",      --  6/ 6, ___
    -- TP Cape                    -- 10/__, ___
    --57 PDT/47 MDT

    -- head="Bhikku Crown +3",    -- 11/11,  98
    -- legs="Bhikku Hose +3",     -- 14/14, 119
    -- feet="Bhikku Gaiters +3",  -- 10/10, 119
    -- waist="Moonbow Belt +1",   --  6/ 6, ___
    -- TP Cape                    -- 10/__, ___
    --51 PDT/41 MDT
  }


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

  sets.idle.Weak = set_combine(sets.defense.PDT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {
    legs="Hesychast's Hose +3",
  }
  sets.precast.JA['Boost'] = {
    waist="Ask Sash",
  }
  sets.precast.JA['Boost'].Idle = {
    head="Gnadbhod's Helm",
    body=empty,
    hands=empty,
    legs=empty,
    feet="Mahant Sandals",
    neck="Justiciar's Torque",
    ring1="Sljor ring",
    waist="Ask Sash",
  }
  sets.precast.JA['Perfect Counter'] = {
    hands="Tantra Crown +1",      -- Increase base counter dmg by +10
    -- head="Bhikku Crown +3",    -- Increase base counter dmg by +35
  }
  sets.precast.JA['Dodge'] = {
    feet="Anchorite's Gaiters +3",
  }
  sets.precast.JA['Focus'] = {
    head="Anchorite's Crown +1",
  }
  sets.precast.JA['Counterstance'] = {
    feet="Hesychast's Gaiters +3",
  }
  sets.precast.JA['Footwork'] = {
    feet="Bhikku Gaiters +2",
    -- feet="Bhikku Gaiters +3",
  }
  sets.precast.JA['Formless Strikes'] = {
    body="Hesychast's Cyclas +2", -- +1 is acceptable
  }
  sets.precast.JA['Mantra'] = {
    feet="Hesychast's Gaiters +3", -- +1 is acceptable
  }

  sets.precast.JA['Chi Blast'] = {
    head="Hesychast's Crown +1", -- 15, Enhance Penance; +1 is acceptable
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  } -- MND

  sets.precast.JA['Chakra'] = {
    body="Anchorite's Cyclas +2", -- Enhances Chakra
    hands="Hesychast's Gloves", -- Enhances Chakra
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
    ring2="Gelatinous Ring +1",
    -- body="Anchorite's Cyclas +3", -- Enhances Chakra
    -- hands="Hesychast's Gloves +3", -- Enhances Chakra
  } -- VIT

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  })

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }

  sets.precast.Step = {
  }
  sets.precast.Flourish1 = {
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ring2="Prolix Ring", --2
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    body="Passion Jacket", --10
    neck="Magoraga Beads", --10
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
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
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatenashi Haramaki +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  } -- Base WS set
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
  })
  sets.precast.WS.Safe = set_combine(sets.precast.WS, {
  })
  sets.precast.WS.SafeMaxTP = set_combine(sets.precast.WS, {
  })

  -- Victory Smite: 80% STR, 1.5 fTP, 4 hit, can crit, ftp replicating
  -- crit dmg > TP Bonus = crit rate > multihit
  -- 1000 TP bonus = ~15% crit rate
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_STR_CritDmg_feet,
    neck="Monk's Nodowa +2", -- PDL
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Ephramad's Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Victory Smite"].MaxTP = set_combine(sets.precast.WS["Victory Smite"], {
  })
  sets.precast.WS["Victory Smite"].Safe = set_combine(sets.precast.WS["Victory Smite"], {
    feet="Mpaca's Boots",
    ear1="Odnowa Earring +1",
    ring2="Defending Ring",
  })
  sets.precast.WS["Victory Smite"].SafeMaxTP = set_combine(sets.precast.WS["Victory Smite"], {
    feet="Mpaca's Boots",
    ear1="Odnowa Earring +1",
    ring2="Defending Ring",
  })

  -- Shijin Spiral: 100% DEX, 1.5 fTP, 5 hit, ftp replicating
  -- DEX > multihit > WSD
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",             --  5, __ <__, __, __> [__/__, ___]
    head="Kendatsuba Jinpachi +1",    -- 47, __ <__,  4, __> [__/__, 101]
    body="Malignance Tabard",         -- 49, __ <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- 56, __ <__, __, __> [ 5/ 5, 112]
    legs=gear.Samnuha_legs,           -- 16, __ < 3,  3, __> [__/__,  75]
    feet="Kendatsuba Sune-Ate +1",    -- 44, __ <__,  4, __> [__/__, 139]
    neck="Monk's Nodowa +2",          -- 15, __ <__, __, __> [__/__, ___]
    ear1="Schere Earring",            -- __, __ < 6, __, __> [__/__, ___]
    ear2="Odr Earring",               -- 10, __ <__, __, __> [__/__, ___]
    ring1="Ephramad's Ring",          -- 10, __ <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",            -- 10, __ <__, __,  3> [__/__, ___]
    back=gear.MNK_DEX_DA_Cape,        -- 30, __ <10, __, __> [10/__, ___]
    waist="Moonbow Belt +1",          -- 20, __ <__,  8, __> [ 6/ 6, ___]
    -- 312 DEX, 0 WSD <19 DA, 19 TA, 3 QA> [30 PDT/20 MDT, 566 M.Eva]

    -- ammo="Aurgelmir Orb +1",       --  7, __ <__, __, __> [__/__, ___]
    -- ear2="Bhikku Earring +2",      -- 15, __ <__, __, __> [__/__, ___]
    -- 319 DEX, 0 WSD <19 DA, 19 TA, 3 QA> [30 PDT/20 MDT, 566 M.Eva]
  })
  sets.precast.WS["Shijin Spiral"].MaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {
  })
  sets.precast.WS["Shijin Spiral"].Safe = set_combine(sets.precast.WS["Shijin Spiral"], {
    feet="Mpaca's Boots",             -- 32, __ <__,  3, __> [ 6/__,  96]
    ear1="Odnowa Earring +1",         -- __, __ <__, __, __> [ 3/ 5, ___]
    ring1="Defending Ring",           -- __, __ <__, __, __> [10/10, ___]
    -- 297 DEX, 0 WSD <13 DA, 18 TA, 3 QA> [49 PDT/35 MDT, 523 M.Eva]
  })
  sets.precast.WS["Shijin Spiral"].SafeMaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {
    feet="Mpaca's Boots",             -- 32, __ <__,  3, __> [ 6/__,  96]
    ear1="Odnowa Earring +1",         -- __, __ <__, __, __> [ 3/ 5, ___]
    ring1="Defending Ring",           -- __, __ <__, __, __> [10/10, ___]
    -- 297 DEX, 0 WSD <13 DA, 18 TA, 3 QA> [49 PDT/35 MDT, 523 M.Eva]
  })
  
  -- Asuran Fists: 15% STR / 15% VIT, 1.25 fTP, 8 hit, ftp replicating
  -- WSD > STR/VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body="Bhikku Cyclas +3",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Ishvara Earring",
    ring1="Epaminondas's Ring",
    ring2="Ephramad's Ring",
    back=gear.MNK_STR_DA_Cape, -- WSD cape would be better
    waist="Fotia Belt",
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {
  })
  sets.precast.WS["Asuran Fists"].Safe = set_combine(sets.precast.WS["Asuran Fists"], {
  })
  sets.precast.WS["Asuran Fists"].SafeMaxTP = set_combine(sets.precast.WS["Asuran Fists"], {
  })

  -- Ascetic's Fury: 50% STR / 50% VIT, 1.0 fTP (2.0 w/ offhand), 1 hit (2 w/ offhand), can crit, ftp replicating
  -- Cannot crit normally - only TP bonus can increase crit rate
  -- TP Bonus > crit dmg > multihit > WSD
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_STR_CritDmg_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Sroda Ring",
    ring2="Ephramad's Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Ascetic's Fury"].MaxTP = set_combine(sets.precast.WS["Ascetic's Fury"], {
    head=gear.Adhemar_B_head,
    ear2="Schere Earring",
  })
  sets.precast.WS["Ascetic's Fury"].Safe = set_combine(sets.precast.WS["Ascetic's Fury"], {
  })
  sets.precast.WS["Ascetic's Fury"].SafeMaxTP = set_combine(sets.precast.WS["Ascetic's Fury"], {
  })

  -- Raging Fists: 30% STR / 30% DEX, 1.0-3.75 fTP, 5 hit, ftp replicating
  -- TP Bonus > WSD > Multihit (assuming always used with high TP)
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Ephramad's Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Ishvara Earring",
    -- head="Hesychast's Crown +3",
  })
  sets.precast.WS["Raging Fists"].Safe = set_combine(sets.precast.WS["Raging Fists"], {
  })
  sets.precast.WS["Raging Fists"].SafeMaxTP = set_combine(sets.precast.WS["Raging Fists"], {
  })

  -- Howling Fist: 50% VIT / 20% STR, 2.05-5.8 fTP, 2 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatenashi Haramaki +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Ephramad's Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",

    -- back=gear.MNK_VIT_DA_Cape,
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    head=gear.Adhemar_B_head,
    ear2="Schere Earring",
  })
  sets.precast.WS["Howling Fist"].Safe = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Mpaca's Boots",
    ear1="Odnowa Earring +1",
    ring2="Defending Ring",
  })
  sets.precast.WS["Howling Fist"].SafeMaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Mpaca's Boots",
    ear1="Odnowa Earring +1",
    ring2="Defending Ring",
  })

  -- Dragon Kick: 50% STR / 50% DEX, ?-5 fTP, 1 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS["Dragon Kick"].Safe = set_combine(sets.precast.WS["Howling Fist"].Safe, {
    ammo="Staunch Tathlum +1",
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS["Dragon Kick"].SafeMaxTP = set_combine(sets.precast.WS["Howling Fist"].SafeMaxTP, {
    ammo="Staunch Tathlum +1",
    feet="Anchorite's Gaiters +3",
  })

  -- Tornado Kick: 40% STR / 40% VIT, 1.68-4.575 fTP, 3 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS["Tornado Kick"].Safe = set_combine(sets.precast.WS["Howling Fist"].Safe, {
    ammo="Staunch Tathlum +1",
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS["Tornado Kick"].SafeMaxTP = set_combine(sets.precast.WS["Howling Fist"].SafeMaxTP, {
    ammo="Staunch Tathlum +1",
    feet="Anchorite's Gaiters +3",
  })

  -- Spinning Attack: 100% STR, 1.0 fTP, 1 hit (aoe-physical), ftp replicating
  -- Multihit > WSD
  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Tatenashi Haramaki +1",
    hands=gear.Adhemar_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Schere Earring",
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Spinning Attack"].MaxTP = set_combine(sets.precast.WS["Spinning Attack"], {
  })
  sets.precast.WS["Spinning Attack"].Safe = set_combine(sets.precast.WS["Spinning Attack"], {
  })
  sets.precast.WS["Spinning Attack"].SafeMaxTP = set_combine(sets.precast.WS["Spinning Attack"], {
  })

  sets.MAB = {
  }

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS['Cataclysm'] = {
    ammo="Ghastly Tathlum +1",      -- __, __, 21, __
    head="Pixie Hairpin +1",        -- 28, __, __, __
    body=gear.Nyame_B_body,         -- 30
    hands=gear.Nyame_B_hands,       -- 30
    legs=gear.Nyame_B_legs,         -- 30
    feet=gear.Herc_MAB_feet,        -- 57
    neck="Fotia Gorget",            -- __, __, __, __; FTP bonus
    ear1="Friomisi Earring",        -- 10
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring1="Shiva Ring +1",          --  3
    ring2="Archon Ring",            --  5, __, __, __
    back=gear.MNK_MAB_Cape,         -- 10
    waist="Skrymir Cord",           -- __,  5, 30, __
    -- waist="Skrymir Cord +1",     --  7
  }
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Cataclysm'], {
    ear2="Novio Earring",           -- __,  7, __, __
  })
  sets.precast.WS['Cataclysm'].Safe = set_combine(sets.precast.WS['Cataclysm'], {
  })
  sets.precast.WS['Cataclysm'].SafeMaxTP = set_combine(sets.precast.WS['Cataclysm'], {
    ear2="Novio Earring",           -- __,  7, __, __
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
    ammo="Coiste Bodhar",           --  3, __, __, __, __ < 3, __, __> [__/__, ___] (___, __) __, __, __(__)
    head="Malignance Chapeau",      --  8, 50,  3, __, __ <__, __, __> [ 6/ 6, 123] (___, __) __, __, __(__)
    body="Mpaca's Doublet",         --  8, 55, __,  7, __ <__,  4, __> [10/__,  86] (___, __) __, 10, __(__)
    hands="Malignance Gloves",      -- 12, 50,  4, __, __ <__, __, __> [ 5/ 5, 112] (___, __) __, __, __(__)
    legs="Bhikku Hose +3",          -- 10, 63, __, __, __ <__, __, __> [14/14, 119] (___, 30) __, __, __(__)
    feet="Tatenashi Sune-Ate +1",   --  8, 60, __, __, __ <__,  3, __> [__/__,  80] (___, __) __, __, __(__)
    neck="Monk's Nodowa +2",        -- __, 30, 10, __, __ <__, __, __> [__/__, ___] ( 20, 25) __, __, __(__)
    ear1="Sherida Earring",         --  5, __, __, __, __ < 5, __, __> [__/__, ___] (___, __) __, __, __( 5)
    ear2="Bhikku Earring +1",       --  4, 15, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  8, __(__)
    ring1="Gere Ring",              -- __, __, __, __, __ <__,  5, __> [__/__, ___] (___, __) __, __, __(__)
    ring2="Chirich Ring +1",        --  6, 10, __, __, __ <__, __, __> [__/__, ___] (___, __) __, __, 10(__)
    back=gear.MNK_DEX_DA_Cape,      -- __, 20, __, __, __ <10, __, __> [10/__, ___] ( 25, 10) __, __, __(__)
    waist="Moonbow Belt +1",        -- __, __, __, __, __ <__,  8, __> [ 6/ 6, ___] (___, __) __, __, __(15)
    -- Merits/Traits/Gifts             __, __, __,  5, __ <__, __, __> [__/__, ___] (___, 19)  9, 27, 35(__)
    -- 64 STP, 353 Acc, 17 PDL, 12 Crit Rate, 0 Crit Dmg <18 DA, 20 TA, 0 QA> [51 PDT/31 MDT, 520 M.Eva] (45 Kick Dmg, 84 Kick Rate) 9 Martial Arts, 45 Counter, 65 Subtle Blow

    -- Ideal:
    -- ear2="Bhikku Earring +2",    --  6, 20, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  9, __(__)
    -- 66 STP, 358 Acc, 17 PDL, 12 Crit Rate, 0 Crit Dmg <18 DA, 20 TA, 0 QA> [51 PDT/31 MDT, 520 M.Eva] (45 Kick Dmg, 84 Kick Rate) 9 Martial Arts, 46 Counter, 65 Subtle Blow
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Ginsen",
    ear1="Telos Earring",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ring1="Chirich Ring +1",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    waist="Olseni Belt",
  })


  ------------------------------------------------------------------------------------------------
  --    Aftermath Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.VerethragnaAM = {
    ammo="Crepuscular Pebble",      -- __, __,  3, __, __ <__, __, __> [ 3/ 3, ___] (___, __) __, __, __(__)
    head="Malignance Chapeau",      --  8, 50,  3, __, __ <__, __, __> [ 6/ 6, 123] (___, __) __, __, __(__)
    body="Malignance Tabard",       -- 11, 50,  6, __, __ <__, __, __> [ 9/ 9, 139] (___, __) __, __, __(__)
    hands="Malignance Gloves",      -- 12, 50,  4, __, __ <__, __, __> [ 5/ 5, 112] (___, __) __, __, __(__)
    legs="Hesychast's Hose +3",     -- __, 39, __,  8, __ <__, __, __> [__/__,  84] (___, 19) __, __, 10(__)
    feet="Anchorite's Gaiters +3",  -- __, 46, __, __, __ <__, __, __> [__/__,  84] (120, 10) __, __, __(__)
    neck="Monk's Nodowa +2",        -- __, 30, 10, __, __ <__, __, __> [__/__, ___] ( 20, 25) __, __, __(__)
    ear1="Sherida Earring",         --  5, __, __, __, __ < 5, __, __> [__/__, ___] (___, __) __, __, __( 5)
    ear2="Bhikku Earring +1",       --  4, 15, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  8, __(__)
    ring1="Gere Ring",              -- __, __, __, __, __ <__,  5, __> [__/__, ___] (___, __) __, __, __(__)
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] (___, __) __, __, __( 5)
    back=gear.MNK_DEX_DA_Cape,      -- __, 20, __, __, __ <10, __, __> [10/__, ___] ( 25, 10) __, __, __(__)
    waist="Moonbow Belt +1",        -- __, __, __, __, __ <__,  8, __> [ 6/ 6, ___] (___, __) __, __, __(15)
    -- Merits/Traits/Gifts             __, __, __,  5, __ <__, __, __> [__/__, ___] (___, 19)  9, 27, 35(__)
    -- 40 STP, 300 Acc, 26 PDL, 13 Crit Rate, 6 Crit Dmg <15 DA, 13 TA, 3 QA> [39 PDT/29 MDT, 542 M.Eva] (165 Kick Dmg, 83 Kick Rate) 9 Martial Arts, 35 Counter, 70 Subtle Blow

    -- Ideal:
    -- ear2="Bhikku Earring +2",    --  6, 20, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  9, __(__)
    -- 42 STP, 305 Acc, 26 PDL, 13 Crit Rate, 6 Crit Dmg <15 DA, 13 TA, 3 QA> [39 PDT/29 MDT, 542 M.Eva] (165 Kick Dmg, 83 Kick Rate) 9 Martial Arts, 36 Counter, 70 Subtle Blow
  }
  sets.engaged.VerethragnaAM.Impetus = set_combine(sets.engaged.VerethragnaAM, {
    body="Bhikku Cyclas +3",        -- __, 64, __, __, __ <__, __, __> [__/__, 109] (___, __)  8, __, __(__)
    legs="Bhikku Hose +3",          -- 10, 63, __, __, __ <__, __, __> [14/14, 119] (___, 30) __, __, __(__)
    -- 39 STP, 338 Acc, 20 PDL, 5 Crit Rate, 6 Crit Dmg <15 DA, 13 TA, 3 QA> [44 PDT/34 MDT, 547 M.Eva] (165 Kick Dmg, 94 Kick Rate) 17 Martial Arts, 35 Counter, 60 Subtle Blow

    -- Ideal:
    -- 41 STP, 343 Acc, 20 PDL,  5 Crit Rate, 0 Crit Dmg <15 DA, 13 TA, 3 QA> [44 PDT/34 MDT, 547 M.Eva] (165 Kick Dmg, 94 Kick Rate) 17 Martial Arts, 36 Counter, 60 Subtle Blow
  })

  sets.engaged.VerethragnaAM.HeavyDef = {
    ammo="Crepuscular Pebble",      -- __, __,  3, __, __ <__, __, __> [ 3/ 3, ___] (___, __) __, __, __(__)
    head="Malignance Chapeau",      --  8, 50,  3, __, __ <__, __, __> [ 6/ 6, 123] (___, __) __, __, __(__)
    body="Malignance Tabard",       -- 11, 50,  6, __, __ <__, __, __> [ 9/ 9, 139] (___, __) __, __, __(__)
    hands="Malignance Gloves",      -- 12, 50,  4, __, __ <__, __, __> [ 5/ 5, 112] (___, __) __, __, __(__)
    legs="Bhikku Hose +3",          -- 10, 63, __, __, __ <__, __, __> [14/14, 119] (___, 30) __, __, __(__)
    feet="Anchorite's Gaiters +3",  -- __, 46, __, __, __ <__, __, __> [__/__,  84] (120, 10) __, __, __(__)
    neck="Monk's Nodowa +2",        -- __, 30, 10, __, __ <__, __, __> [__/__, ___] ( 20, 25) __, __, __(__)
    ear1="Sherida Earring",         --  5, __, __, __, __ < 5, __, __> [__/__, ___] (___, __) __, __, __( 5)
    ear2="Bhikku Earring +1",       --  4, 15, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  8, __(__)
    ring1="Gere Ring",              -- __, __, __, __, __ <__,  5, __> [__/__, ___] (___, __) __, __, __(__)
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] (___, __) __, __, __( 5)
    back=gear.MNK_DEX_DA_Cape,      -- __, 20, __, __, __ <10, __, __> [10/__, ___] ( 25, 10) __, __, __(__)
    waist="Moonbow Belt +1",        -- __, __, __, __, __ <__,  8, __> [ 6/ 6, ___] (___, __) __, __, __(15)
    -- Merits/Traits/Gifts             __, __, __,  5, __ <__, __, __> [__/__, ___] (___, 19)  9, 27, 35(__)
    -- 50 STP, 323 Acc, 26 PDL,  5 Crit Rate, 0 Crit Dmg <15 DA, 13 TA, 3 QA> [53 PDT/43 MDT, 577 M.Eva] (165 Kick Dmg, 94 Kick Rate) 9 Martial Arts, 35 Counter, 60 Subtle Blow

    -- Ideal:
    -- ear2="Bhikku Earring +2",    --  6, 20, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  9, __(__)
    -- 52 STP, 329 Acc, 26 PDL,  5 Crit Rate, 0 Crit Dmg <15 DA, 13 TA, 3 QA> [53 PDT/43 MDT, 577 M.Eva] (165 Kick Dmg, 94 Kick Rate) 9 Martial Arts, 36 Counter, 60 Subtle Blow
  }
  sets.engaged.VerethragnaAM.HeavyDef.Impetus = set_combine(sets.engaged.VerethragnaAM.HeavyDef, {
    body="Bhikku Cyclas +3",        -- __, 64, __, __, __ <__, __, __> [__/__, 109] (___, __)  8, __, __(__)
    legs="Bhikku Hose +3",          -- 10, 63, __, __, __ <__, __, __> [14/14, 119] (___, 30) __, __, __(__)
    ring2="Defending Ring",         -- __, __, __, __, __ <__, __, __> [10/10, ___] (___, __) __, __, __(__)
    -- 39 STP, 338 Acc, 20 PDL,  5 Crit Rate, 0 Crit Dmg <15 DA, 13 TA, 0 QA> [54 PDT/44 MDT, 547 M.Eva] (165 Kick Dmg, 94 Kick Rate) 17 Martial Arts, 35 Counter, 55 Subtle Blow

    -- Ideal:
    -- 41 STP, 343 Acc, 20 PDL,  5 Crit Rate, 0 Crit Dmg <15 DA, 13 TA, 0 QA> [54 PDT/44 MDT, 547 M.Eva] (165 Kick Dmg, 94 Kick Rate) 17 Martial Arts, 36 Counter, 55 Subtle Blow
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { head="Frenzy Sallet", }
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.Impetus = {
    body="Bhikku Cyclas +3",
  }
  sets.Footwork = {
    feet="Anchorite's Gaiters +3",
  }
  sets.ImpetusAndFootwork = {
    body="Bhikku Cyclas +3",
    feet="Anchorite's Gaiters +3",
  }
  sets.Counterstance = {
    feet="Hesychast's Gaiters +3",
  }
  sets.LowEnmity = { ear2="Novia Earring", } -- Assumes -Enmity merits and Dirge
  sets.Schere = { ear2="Schere Earring", }
  sets.CaitSith = {
    ammo="Crepuscular Pebble",      -- __, __,  3, __, __ <__, __, __> [ 3/ 3, ___] (___, __) __, __, __(__)
    head="Malignance Chapeau",      --  8, 50,  3, __, __ <__, __, __> [ 6/ 6, 123] (___, __) __, __, __(__)
    body="Bhikku Cyclas +3",        -- __, 64, __, __, __ <__, __, __> [__/__, 109] (___, __)  8, __, __(__); Aug Impetus
    hands="Malignance Gloves",      -- 12, 50,  4, __, __ <__, __, __> [ 5/ 5, 112] (___, __) __, __, __(__)
    legs="Bhikku Hose +3",          -- 10, 63, __, __, __ <__, __, __> [14/14, 119] (___, 30) __, __, __(__)
    feet="Anchorite's Gaiters +3",  -- __, 46, __, __, __ <__, __, __> [__/__,  84] (120, 10) __, __, __(__)
    neck="Monk's Nodowa +2",        -- __, 30, 10, __, __ <__, __, __> [__/__, ___] ( 20, 25) __, __, __(__)
    ear1="Sherida Earring",         --  5, __, __, __, __ < 5, __, __> [__/__, ___] (___, __) __, __, __( 5)
    ear2="Bhikku Earring +1",       --  4, 15, __, __, __ <__, __, __> [__/__, ___] (___, __) __,  8, __(__)
    ring1="Defending Ring",         -- __, __, __, __, __ <__, __, __> [10/10, ___] (___, __) __, __, __(__)
    ring2="Brass Ring +1",          -- __, __, __, __, __ <__, __, __> [__/__, ___] (___, __) __, __, __(__)
    back=gear.MNK_DEX_DA_Cape,      -- __, 20, __, __, __ <10, __, __> [10/__, ___] ( 25, 10) __, __, __(__)
    waist="Moonbow Belt +1",        -- __, __, __, __, __ <__,  8, __> [ 6/ 6, ___] (___, __) __, __, __(15)
    -- Merits/Traits/Gifts             __, __, __,  5, __ <__, __, __> [__/__, ___] (___, 19)  9, 27, 35(__)
    -- 39 STP, 328 Acc, 20 PDL, 5 Crit Rate, 6 Crit Dmg <15 DA, 13 TA, 0 QA> [44 PDT/34 MDT, 537 M.Eva] (165 Kick Dmg, 94 Kick Rate) 16 Martial Arts, 35 Counter, 55 Subtle Blow
  }
  sets.BoostRegain = {
    waist="Ask Sash",
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

  -- Don't gearswap for weaponskills when Defense is on.
  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    eventArgs.handled = true
  end
  if spell.english == 'Boost' then
    if buffactive.Warcry then
      windower.add_to_chat(167, 'Stopped due to conflicting buff: Warcry.')
      eventArgs.cancel = true -- Ensures gear doesn't swap
      return -- Ends function without finishing loop
    elseif not player.in_combat and state.DefenseMode.current == 'None' then
      equip(sets.precast.JA['Boost'].Idle)
      eventArgs.handled = true
    end
  end

  if spell.english == 'Valiance' then
    local abil_recasts = windower.ffxi.get_ability_recasts()
    -- Use Vallation if Valiance is on cooldown or not available at current master level
    if abil_recasts[spell.recast_id] > 0 or player.sub_job_level < 50 then
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

  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if state.Buff.Impetus and state.DefenseMode.current == 'None' and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
      -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
      if (state.OffenseMode.current ~= 'MidAcc' and state.OffenseMode.current ~= 'HighAcc' and info.impetus_hit_count > 5)
          or (info.impetus_hit_count > 8) then
        equip(sets.Impetus)
      end
    end

    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end

    if state.EnmityMode.current == 'Low' then
      equip(sets.LowEnmity)
    elseif state.EnmityMode.current == 'Schere' and player.mp > 0 then
      equip(sets.Schere)
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

  -- Enable boost lock temporarily until buffactive can be detected
  if spell.english == 'Boost' and not spell.interrupted then
    info.boost_temp_lock = true
    coroutine.schedule(function()
        info.boost_temp_lock = false
    end, 3)
  end
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
  -- Hundred Fists and Impetus modify the custom melee groups
  if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
    classes.CustomMeleeGroups:clear()

    if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
      classes.CustomMeleeGroups:append('HF')
    end
    if (buff == "Impetus" and gain) or buffactive.impetus then
      classes.CustomMeleeGroups:append('Impetus')
    end
  end

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
  if buff == "Hundred Fists" or buff == "Impetus" or buff == "Counterstance" or buff == "Footwork" or buff == "doom" or buff == "Boost" then
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
  update_combat_form()
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

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
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
  equip(sets.WeaponSet[state.WeaponSet.current])
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

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if state.HybridMode.value == 'HeavyDef' then
    wsmode = 'Safe'
  end

  if player.tp > 2900 then
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
  if buffactive.Boost or info.boost_temp_lock then
    idleSet = set_combine(idleSet, sets.BoostRegain)
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
  if state.EnmityMode.current == 'Low' then
    equip(sets.LowEnmity)
  end

  -- Override sets to ensure counterstance feet are equipped if Counterstance is up
  if state.Buff['Counterstance'] then
    meleeSet = set_combine(meleeSet, sets.Counterstance)
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

  if state.PhysicalDefenseMode.current == 'Cait Sith' then
    defenseSet = set_combine(defenseSet, sets.CaitSith)
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

function test()
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

  if buffactive['hundred fists'] then
    classes.CustomMeleeGroups:append('HF')
  end
  if buffactive.impetus then
    classes.CustomMeleeGroups:append('Impetus')
  end
  if buffactive.footwork then
    classes.CustomMeleeGroups:append('Footwork')
  end
  if buffactive.counterstance then
    classes.CustomMeleeGroups:append('Counterstance')
  end
end

function update_combat_form()
  state.CombatForm:reset()
  
  -- Add aftermath groups
  for weapon,am_list in pairs(activate_AM_mode) do
    if player.equipment.main == weapon or player.equipment.ranged == weapon then
      for am_level,_ in pairs(am_list) do
        if buffactive[am_level] then
          state.CombatForm:set(weapon..'AM')
        end
      end
    end
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
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
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
  set_macro_page(1, 2)
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
  if state.Buff.Impetus then
    -- count melee hits by player
    if action.actor_id == player.id then
      if action.category == 1 then
        for _,target in pairs(action.targets) do
          for _,action in pairs(target.actions) do
            -- Reactions (bitset):
            -- 1 = evade
            -- 2 = parry
            -- 4 = block/guard
            -- 8 = hit
            -- 16 = JA/weaponskill?
            -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
            if (action.reaction % 4) > 0 then
              info.impetus_hit_count = 0
            else
              info.impetus_hit_count = info.impetus_hit_count + 1
            end
          end
        end
      elseif action.category == 3 then
        -- Missed weaponskill hits will reset the counter.  Can we tell?
        -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
        -- Can't tell if any hits were missed, so have to assume all hit.
        -- Increment by the minimum number of weaponskill hits: 2.
        for _,target in pairs(action.targets) do
          for _,action in pairs(target.actions) do
            -- This will only be if the entire weaponskill missed or was parried.
            if (action.reaction % 4) > 0 then
              info.impetus_hit_count = 0
            else
              info.impetus_hit_count = info.impetus_hit_count + 2
            end
          end
        end
      end
    elseif action.actor_id ~= player.id and action.category == 1 then
      -- If mob hits the player, check for counters.
      for _,target in pairs(action.targets) do
        if target.id == player.id then
          for _,action in pairs(target.actions) do
            -- Spike effect animation:
            -- 63 = counter
            -- ?? = missed counter
            if action.has_spike_effect then
              -- spike_effect_message of 592 == missed counter
              if action.spike_effect_message == 592 then
                info.impetus_hit_count = 0
              elseif action.spike_effect_animation == 63 then
                info.impetus_hit_count = info.impetus_hit_count + 1
              end
            end
          end
        end
      end
    end

  --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
  else
    info.impetus_hit_count = 0
  end

end

windower.raw_register_event('action', on_action_for_impetus)

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')
  send_command('bind ^` gs c cycle treasuremode')

  send_command('bind @c gs c toggle CP')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind @e gs c cycle EnmityMode')

  send_command('bind !` input /ja "Chakra" <me>')
  send_command('bind !q input /ja "Impetus" <me>')
  send_command('bind !e input /ja "Footwork" <me>')
  send_command('bind ^numpad+ input /ja "Boost" <me>')
end

function set_sub_keybinds()
  if player.sub_job == 'WAR' then
    send_command('bind ^numlock input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind ^numlock input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'THF' then
    send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
    send_command('bind ^numpad. input /ja "Trick Attack" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind !numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind !numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'RUN' then
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
    send_command('bind %numpad0 gs c rune')
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')
  send_command('unbind ^`')

  send_command('unbind @c')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind @e')

  send_command('unbind !`')
  send_command('unbind !q')
  send_command('unbind !e')
  send_command('unbind ^numpad+')

  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind !numpad0')
  send_command('unbind !numpad.')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind %numpad0')
end

function test()
end
