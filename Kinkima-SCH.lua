--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: N/A
Recommended addons: WSBinder, Reorganizer, PartyBuffs, Shortcuts
Misc Recommendations: Disable RollTracker


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Casting Mode: Changes casting type
  * Seidr: Uses set variants containing Seidr Cotehardie to help save MP while nuking.
  * Resistant: Allows you to make high magic accuracy set variants for higher level mobs who may resist more frequently.
* Idle Mode
  * Normal: Puts you into Refresh and Regen gear when low on MP or HP
  * HeavyDef: Uses high defense gear instead of Refresh gear, also nerfs Sublimation potency
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your cure potency and damage output
* CP Mode: Equips Capacity Points bonus cape
* Magic Burst Mode: Toggle Magic Burst mode on or off. If on, when casting elemental magic, will
  use special MB set to deal more damage. You are expected to know when your spell is going to MB or not, and
  toggle this mode manually as needed. Good rule of thumb is to leave it on when in a party doing planned skillchains
  and off otherwise.
* Elemental Mode: Changes the focused element. The selected element is used for elemental magic keybinds, and
  storms (if subbing SCH).
* Helix Mode: Determines which set variant to use for casting Helix
  * Potency: Maximizes damage dealt
  * Duration: Maximizes duration of the Helix debuff
* Regen Mode: Determines which set variant to use for Regen spells
  * Potency: Maximizes Regen potency
  * Duration: Maximizes duration of the Regen buff
* Immanence Mode: Determines what set of midcast gear to use when casting an elemental nuke under Immanence
  * SIRD: Equips SIRD-capped set.
  * SubtleBlow: Equips Subtle Blow-capped set. Mainly for Bumba v25.

Weapons
* Use keybinds to cycle weapons if you need to lock into a specific weapon set to conserve TP.
  * For the most part, you'll usually want to be in the Casting weapon set which will allow weapon
    to swap according to what's in each set.
  * Khatvanga set can be used to lock the Aeonic weapon in so you don't lose TP when casting spells
    and you can use weaponskills such as Cataclysm, Myrkr, or Shattersoul.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* Casting Dispelga disregards all other weapon equip rules because Daybreak must be equipped to cast it. You
  will lose all your TP when casting Dispelga. You should have your previous weapons re-equipped afterward.

Spells:
* Certain sets have a "LightArts" or "DarkArts" variant which will be used if casting a spell aligned with that
  mode while you have that mode active.

Abilities
* Sublimation will use a variant idle set automatically to charge up Sublimation to stronger effect. This causes
  a slight reduction in Refresh in the idle set. However, if you use Sublimation as soon as it completes, the
  combination of Sublimation + Refresh gear can exceed the overall MP generation of Refresh III. Since Sublimation
  and Refresh buffs cannot both be active on a player at the same time (they cancel each other), it's best to
  only use Sublimation and ask others not to Refresh you as long as your idle sets are well-geared.

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
  [ WIN+C ]             Toggle Capacity Points Mode
  [ CTRL+PageUp ]       Cycle Elemental Mode
  [ CTRL+PageDown ]     Cycleback Elemental Mode
  [ ALT+PageDown ]      Reset to default Elemental Mode
  [ ALT+` ]             Toggle Magic Burst mode
  [ WIN+H ]             Cycle Helix mode
  [ WIN+R ]             Cycle Regen mode
  [ ALT+F8 ]            Cycle Immanence mode

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set

Spells:
  [ ALT+Q ]             Tier 3 single target nuke
  [ ALT+W ]             Highest available single target nuke
  [ ALT+Z ]             Helix
  [ ALT+C ]             Storm
  [ ALT+/ ]             Klimaform
  [ ALT+U ]             Blink
  [ ALT+I ]             Stoneskin
  [ ALT+P ]             Aquaveil
  [ ALT+; ]             Regen
  ============ /RDM ============
  [ ALT+E ]             Haste
  [ ALT+O ]             Phalanx
  [ ALT+' ]             Refresh
  ============ /WHM ============
  [ ALT+E ]             Haste

Abilities:
  [ CTRL+` ]            Immanence
  [ ALT+R ]             Sublimation
  [ CTRL+- ]            Light Arts/Addendum: White
  [ CTRL+= ]            Dark Arts/Addendum: Black
  [ CTRL+[ ]            Rapture (LA) / Ebullience (DA)
  [ CTRL+\ ]            Penury (LA) / Parsimony (DA)
  [ CTRL+] ]            Perpetuance (LA)
  [ ALT+[ ]             Accession (LA) / Manifestation (DA)
  [ ALT+\ ]             Celerity (LA) / Alacrity (DA)
  [ ALT+] ]             Altruism (DA) / Focalization (DA)
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

gs c elemental ga       Uses highest available -ga elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental ga1      Uses tier 1 -ga elemental nuke corresponding to the selected element in the ElementMode.
gs c elemental ga2      Uses tier 2 -ga elemental nuke corresponding to the selected element in the ElementMode.

gs c elemental storm    Uses SCH storm corresponding to the selected element in the ElementMode.

gs c scholar light      Activates Light Arts if not in Light Arts or Addendum: White. Activates Addendum: White if in Light Arts.
gs c scholar dark       Activates Dark Arts if not in Dark Arts or Addendum: Black. Activates Addendum: Black if in Dark Arts.
gs c scholar cost       Uses Penury if in light mode. Uses Parsimony if in dark mode.
gs c scholar speed      Uses Celerity if in light mode. Uses Alacrity if in dark mode.
gs c scholar aoe        Uses Accession if in light mode. Uses Manifestation if in dark mode.
gs c scholar power      Uses Rapture if in light mode. Uses Ebullience if in dark mode.
gs c scholar duration   Uses Perpetuance if in light mode.
gs c scholar accuracy   Uses Altruism if in light mode. Uses Focalization if in dark mode.
gs c scholar enmity     Uses Tranquility if in light mode. Uses Equanimity if in dark mode.
gs c scholar skillchain Uses Immanence if in dark mode.
gs c scholar addendum   Uses Addendum: White if in Light Arts. Uses Addendum: Black if in Dark Arts.

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Swap macro books swap based on whether you're self-skillchaining or not.

Normal macros:
__Keybind___Name______________Command_____________
[ CTRL+1 ] Cure           /ma "Cure" <stpc>
[ CTRL+2 ] Cure2          /ma "Cure II" <stpc>
[ CTRL+3 ] Cure3          /ma "Cure III" <stpc>
[ CTRL+4 ] Cure4          /ma "Cure IV" <stpc>
[ CTRL+0 ] Pro5           /ma "Protect V" <stpc>
[ ALT+1 ]  Stona          /ma "Stona" <t>
[ ALT+2 ]  Erase          /ma "Erase" <t>
[ ALT+3 ]  Cursna         /ma "Cursna" <t>
[ ALT+4 ]  Viruna         /ma "Viruna" <t>
[ ALT+5 ]  Dia            /ma "Dia II" <t>
[ ALT+6 ]  Raise          /ma "Raise III" <stpc>
[ ALT+7 ]  Reraise        /ma "Reraise" <me>
[ ALT+0 ]  Shell5         /ma "Shell V" <stpc>

Self-skillchain macros:
__Keybind___Name______________Command_____________
[ CTRL+1 ] Fusion         /p Starting {Fusion} MB: {Fire}/{Light}
                          /ja "Immanence" <me> <wait1>
                          /ma "Fire" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Thunder" <t>
                          /p Closing {Fusion} MB: {Fire}/{Light}
[ CTRL+2 ] Distorti       /p Starting {Distortion} MB: {Water}/{Ice}
                          /ja "Immanence" <me> <wait1>
                          /ma "Luminohelix" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Stone" <t>
                          /p Closing {Distortion} MB: {Water}/{Ice}
[ CTRL+3 ] Fragment       /p Starting {Fragmentation} MB: {Aero}/{Thunder}
                          /ja "Immanence" <me> <wait1>
                          /ma "Blizzard" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Water" <t>
                          /p Closing {Fragmentation} MB: {Aero}/{Thunder}
[ CTRL+4 ] Gravitat       /p Starting {Gravitation} MB: {Stone}/{Darkness}
                          /ja "Immanence" <me> <wait1>
                          /ma "Aero" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Noctohelix" <t>
                          /p Closing {Gravitation} MB: {Stone}/{Darkness}
[ CTRL+0 ] 3-s Fire       /ja "Immanence" <me> <wait1>
                          /ma "Stone" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Fire III" <t> <wait6>
                          /ja "Immanence" <me> <wait1>
                          /ma "Thunder" <t>
[ ALT+1 ]  Scission       /p Starting {Scission} MB: {Stone}
                          /ja "Immanence" <me> <wait1>
                          /ma "Fire" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Stone II" <t>
                          /p Closing {Scission} MB: {Stone}
[ ALT+2 ]  Indurati       /p Starting {Induration} MB: {Ice}
                          /ja "Immanence" <me> <wait1>
                          /ma "Water" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Blizzard II" <t>
                          /p Closing {Induration} MB: {Ice}
[ ALT+3 ]  Detonati       /p Starting {Detonation} MB: {Wind}
                          /ja "Immanence" <me> <wait1>
                          /ma "Thunder" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Aero II" <t>
                          /p Closing {Induration} MB: {Ice}
[ ALT+4 ]  Liquefac       /p Starting {Liquefaction} MB: {Fire}
                          /ja "Immanence" <me> <wait1>
                          /ma "Stone" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Fire II" <t>
                          /p Closing {Liquefaction} MB: {Fire}
[ ALT+5 ]  Reverber       /p Starting {Reverberation} MB: {Water}
                          /ja "Immanence" <me> <wait1>
                          /ma "Stone" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Water II" <t>
                          /p Closing {Reverberation} MB: {Water}
[ ALT+6 ]  Impactio       /p Starting {Impaction} MB: {Thunder}
                          /ja "Immanence" <me> <wait1>
                          /ma "Blizzard" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Thunder II" <t>
                          /p Closing {Impaction} MB: {Thunder}
[ ALT+7 ]  Compress       /p Starting {Compression} MB: {Darkness}
                          /ja "Immanence" <me> <wait1>
                          /ma "Blizzard" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Noctohelix" <t>
                          /p Closing {Compression} MB: {Darkness}
[ ALT+0 ]  Compres2       /p Starting {Compression} MB: {Darkness}
                          /ja "Immanence" <me> <wait1>
                          /ma "Stone" <t> <wait5>
                          /ja "Immanence" <me> <wait1>
                          /ma "Anemohelix" <t>
                          /p Closing {Compression} MB: {Darkness}

]]--


-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets

  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(19)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus, function ()
    return not tempDisableElementalBelt
  end)

  state.CP = M(false, 'Capacity Points Mode')

  state.OffenseMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Seidr', 'Resistant')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT', 'CaitSith'}
  state.MagicBurst = M(true, 'Magic Burst')
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Khatvanga'}
  state.ImmanenceMode = M{['description']='Immanence Mode', 'SIRD', 'SubtleBlow'}

  state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
  state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
  state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
  state.ElementalMode = M{['description'] = 'Elemental Mode', 'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'}

  state.Buff['Light Arts'] = buffactive['Light Arts'] or false
  state.Buff['Dark Arts'] = buffactive['Dark Arts'] or false
  state.Buff['Addendum: White'] = buffactive['Addendum: White'] or false
  state.Buff['Addendum: Black'] = buffactive['Addendum: Black'] or false

  degrade_array = {
    ['Aspirs'] = {'Aspir','Aspir II'}
  }

  -- Spells that don't scale with skill. Overrides Mote lib.
  classes.EnhancingDurSpells = S{'Adloquium', 'Haste', 'Haste II', 'Flurry', 'Flurry II', 'Protect', 'Protect II',
      'Protect III', 'Protect IV', 'Protect V', 'Protectra', 'Protectra II', 'Protectra III', 'Protectra IV', 'Protectra V',
      'Shell', 'Shell II', 'Shell III', 'Shell IV', 'Shell V', 'Shellra', 'Shellra II', 'Shellra III', 'Shellra IV',
      'Shellra V', 'Embrava', 'Blaze Spikes', 'Ice Spikes', 'Shock Spikes', 'Enaero', 'Enaero II', 'Enblizzard',
      'Enblizzard II', 'Enfire', 'Enfire II', 'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

  addendum_white_spells = S{'Poisona', 'Paralyna', 'Blindna', 'Cursna', 'Silena', 'Viruna', 'Stona', 'Erase',
      'Raise II', 'Raise III', 'Reraise II', 'Reraise III'}
  addendum_black_spells = S{'Stone IV', 'Stone V', 'Water IV', 'Water V', 'Aero IV', 'Aero V', 'Fire IV', 'Fire V',
      'Blizzard IV', 'Blizzard V', 'Thunder IV', 'Thunder V', 'Sleep', 'Sleep II', 'Break', 'Dispel'}

  update_active_strategems()

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['@c'] = 'gs c toggle CP',
      ['!`'] = 'gs c toggle MagcBurst',
      ['!f8'] = 'gs c cycle ImmanenceMode',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^pageup'] = 'gs c cycleback ElementalMode',
      ['^pagedown'] = 'gs c cycle ElementalMode',
      ['!pagedown'] = 'gs c reset ElementalMode',
      ['@h'] = 'gs c cycle HelixMode',
      ['@r'] = 'gs c cycle RegenMode',
      ['^`'] = 'input /ja Immanence <me>',
      ['!r'] = 'input /ja "Sublimation" <me>',
      ['^-'] = 'gs c scholar light',
      ['^='] = 'gs c scholar dark',
      ['^['] = 'gs c scholar power',
      ['^]'] = 'gs c scholar accuracy',
      ['^\\\\'] = 'gs c scholar cost',
      ['!['] = 'gs c scholar aoe',
      ['!]'] = 'gs c scholar duration',
      ['!\\\\'] = 'gs c scholar speed',
      ['!q'] = 'gs c elemental tier3',
      ['!w'] = 'gs c elemental tier',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
      ['!;'] = 'input /ma "Regen V" <stpc>',
      ['!z'] = 'gs c elemental helix',
      ['!c'] = 'gs c elemental storm',
      ['!/'] = 'input /ma "Klimaform" <me>',
    },
    ['RDM'] = {
      ['~`'] = 'input /ja "Convert" <me>',
      ['!e'] = 'input /ma "Haste" <stpc>',
      ['!o'] = 'input /ma "Phalanx" <me>',
      ['!\''] = 'input /ma "Refresh" <stpc>',
    },
    ['WHM'] = {
      ['!e'] = 'input /ma "Haste" <stpc>',
    },
  }

  set_main_keybinds:schedule(2)
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
  set_sub_keybinds:schedule(2)
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
  end

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.CP = {
    back=gear.CP_Cape
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Khatvanga'] = {
    main="Khatvanga",
    sub="Khonsu",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.HeavyDef = {
    main="Daybreak",                -- __/__,  30
    sub="Genmei Shield",            -- 10/__, ___
    ammo="Staunch Tathlum +1",      --  3/ 3, ___; Resist Status+11
    head="Arbatel Bonnet +3",       -- 10/10, 136
    body="Shamash Robe",            -- 10/__, 106; Resist Silence+90
    hands=gear.Nyame_B_hands,       --  7/ 7, 112
    legs="Arbatel Pants +3",        -- 12/12, 168
    feet="Arbatel Loafers +3",      -- __/__, 168
    neck="Loricate Torque +1",      --  6/ 6, ___; DEF+60
    ear1="Arete Del Luna +1",       -- __/__, ___; Resists
    ear2="Etiolation Earring",      -- __/ 3, ___; Resist Silence+15
    ring1="Wuji Ring",              -- __/__, ___; Resists Charm/Sleep
    ring2="Shadow Ring",            -- __/__, ___; Occ. annuls magic dmg
    back="Shadow Mantle",           -- __/__, ___; Occ. annuls physical dmg
    waist="Carrier's Sash",         -- __/__, ___; Ele Resist+15
    -- 58 PDT / 41 MDT, 720 M.Eva
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.passive_refresh = {
    main="Mpaca's Staff",           -- __/__, ___ [ 2]
    sub="Khonsu",                   --  6/ 6, ___ [__]
    ammo="Staunch Tathlum +1",      --  3/ 3, ___ [__]; Resist Status+11
    head=gear.Nyame_B_head,         --  7/ 7, 123 [__]
    body="Shamash Robe",            -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Volte Gloves",           -- __/__,  96 [ 1]
    legs="Assiduity Pants +1",      -- __/__, 107 [ 2]
    feet="Volte Gaiters",           -- __/__, 142 [ 1]
    neck="Loricate Torque +1",      --  6/ 6, ___ [__]; DEF+60
    ear1="Hearty Earring",          -- __/__, ___ [__]; Resist Status+5
    ear2="Etiolation Earring",      -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",        -- __/__, ___ [ 1]
    ring2="Defending Ring",         -- 10/10, ___ [__]
    back=gear.SCH_FC_Cape,          -- 10/__,  30 [__]
    waist="Carrier's Sash",         -- __/__, ___ [__]; Ele Resist+15
    -- 52 PDT / 35 MDT, 584 M.Eva [10 Refresh]
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",
  }
  sets.Sublimation = {
    main="Siriti",                      -- __/__, ___ [ 1, __]
    sub="Genmei Shield",                -- 10/__, ___ [__, __]
    ammo="Staunch Tathlum +1",          --  3/ 3, ___ [__, __]; Resist Status+11
    head="Academic's Mortarboard +3",   -- __/__,  95 [ 4, __]
    body="Pedagogy Gown +3",            -- __/__, 100 [ 5, __]
    hands=gear.Nyame_B_hands,           --  7/ 7, 112 [__, __]
    legs="Assiduity Pants +1",          -- __/__, 107 [__,  2]
    feet=gear.Nyame_B_feet,             --  7/ 7, 150 [__, __]
    neck="Loricate Torque +1",          --  6/ 6, ___ [__, __]; DEF+60
    ear1="Savant's Earring",            -- __/__, ___ [ 1, __]
    ear2="Etiolation Earring",          -- __/ 3, ___ [__, __]; Resist Silence+15
    ring1="Shadow Ring",                -- __/__, ___ [__, __]; Annuls magic dmg
    ring2="Defending Ring",             -- 10/10, ___ [__, __]
    back=gear.SCH_FC_Cape,              -- 10/__,  30 [__, __]
    waist="Embla Sash",                 -- __/__, ___ [ 5, __]
    -- 53 PDT / 36 MDT, 564 M.Eva [16 Sublimation, 2 Refresh]
  }
  sets.Sublimation.Refresh = {
    main="Mpaca's Staff",               -- __/__, ___ [__,  2]
    sub="Khonsu",                       --  6/ 6, ___ [__, __]
    ammo="Staunch Tathlum +1",          --  3/ 3, ___ [__, __]; Resist Status+11
    head="Academic's Mortarboard +3",   -- __/__,  95 [ 4, __]
    body="Pedagogy Gown +3",            -- __/__, 100 [ 5, __]
    hands=gear.Nyame_B_hands,           --  7/ 7, 112 [__, __]
    legs="Assiduity Pants +1",          -- __/__, 107 [__,  2]
    feet=gear.Nyame_B_feet,             --  7/ 7, 150 [__, __]
    neck="Loricate Torque +1",          --  6/ 6, ___ [__, __]; DEF+60
    ear1="Savant's Earring",            -- __/__, ___ [ 1, __]
    ear2="Etiolation Earring",          -- __/ 3, ___ [__, __]; Resist Silence+15
    ring1="Stikini Ring +1",            -- __/__, ___ [__,  1]
    ring2="Defending Ring",             -- 10/10, ___ [__, __]
    back=gear.SCH_FC_Cape,              -- 10/__,  30 [__, __]
    waist="Embla Sash",                 -- __/__, ___ [ 5, __]
    -- 49 PDT / 42 MDT, 594 M.Eva [15 Sublimation, 5 Refresh]
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Sublimation = set_combine(sets.idle, sets.Sublimation)
  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)
  sets.idle.Sublimation.Refresh = set_combine(sets.idle, sets.Sublimation.Refresh)

  -- When you need to be safe (disables move speed gear)
  sets.idle.HeavyDef = set_combine(sets.idle, {})

  sets.resting = set_combine(sets.idle, {
    main="Chatoyant Staff",
    sub="Khonsu",
    waist="Shinjutsu-no-Obi +1",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Tabula Rasa'] = {
    legs="Pedagogy Pants +3", -- Duration +30s; +1 is acceptable
  }
  sets.precast.JA['Enlightenment'] = {
    body="Pedagogy Gown +3", -- Increases magic skill based on merits; +1 is acceptable
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Incantor Stone",            --  2 [__/__, ___]
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands="Academic's Bracers +3",    --  9 [__/__,  57]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30]
    waist="Carrier's Sash",           -- __ [__/__, ___]; Ele Resist+15
    -- 86 Fast Cast [53 PDT/38 MDT, 566 MEVA]

    -- Ideal:
    -- main="Hvergelmir",             -- 50 [__/__, ___]
    -- sub="Khonsu",                  -- __ [ 6/ 6, ___]
    -- head=gear.Merl_FC_head,        -- 15 [__/__,  86]
    -- ammo="Staunch Tathlum +1",     -- __ [ 3/ 3, ___]; Resist Status+11
    -- body="Shamash Robe",           -- __ [10/__, 106]; Resist Silence+90
    -- hands=gear.Nyame_B_hands,      -- __ [ 7/ 7, 112]
    -- legs="Pinga Pants +1",         -- 13 [__/__, 147]
    -- feet=gear.Nyame_B_feet,        -- __ [ 7/ 7, 150]
    -- neck="Loricate Torque +1",     -- __ [ 6/ 6, ___]; DEF+60
    -- ear1="Hearty Earring",         -- __ [__/__, ___]; Resist Status+5
    -- ear2="Etiolation Earring",     --  1 [__/ 3, ___]; Resist Silence+15
    -- ring1="Gelatinous Ring +1",    -- __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __ [10/10, ___]
    -- back=gear.SCH_FC_Cape,         -- 10 [10/__,  30]
    -- waist="Carrier's Sash",        -- __ [__/__, ___]; Ele Resist+15
    -- 89 Fast Cast [66 PDT/41 MDT, 631 MEVA]
  }
  -- Grimoire casting bonuses multiply separately from FC, allowing
  -- breaking the normal 80% cast time reduction cap.
  -- Cast Time = Base Cast Time x (1 - FC)x(1 - magian staff cast bonus)x(1 - Grimoire reduction)
  sets.precast.FC.Grimoire = set_combine(sets.precast.FC, {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Incantor Stone",            --  2 [__/__, ___]
    head="Pedagogy Mortarboard +3",   -- __ [__/__,  95] 13
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands="Academic's Bracers +3",    --  9 [__/__,  57]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30]
    waist="Embla Sash",               --  5 [__/__, ___]
    -- 80 Fast Cast [46 PDT/39 MDT, 575 MEVA] 13 Grimoire Reduction + status resist
    
    -- If using Hvergelmir in precast.FC...
    -- head="Pedagogy Mortarboard +3",-- __ [__/__,  95] 13
    -- hands="Academic's Bracers +3", --  9 [__/__,  57]
    -- feet="Academic's Loafers +3",  -- __ [__/__, 127] 12
    -- 83 Fast Cast [52 PDT/27 MDT, 552 MEVA] 25 Grimoire Reduction + status resist
  })
  -- 10% cap on Quick Magic
  sets.precast.FC.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Khonsu",                     -- __ [ 6/ 6, ___] __
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head=gear.Merl_FC_head,           -- 15 [__/__,  86] __
    body="Pinga Tunic +1",            -- 15 [__/__, 128] __
    hands="Academic's Bracers +3",    --  9 [__/__,  57] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118] __
    neck="Orunmila's Torque",         --  5 [__/__, ___] __
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30] __
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- 86 Fast Cast [49PDT/41MDT, 566 MEVA] 7 Quick Magic
  }
  -- No point in this set until normal sets.precast.FC.QuickMagic can cap stats
  -- sets.precast.FC.QuickMagic.Grimoire = {}

  sets.precast.FC.RDM = {
    main=gear.Musa_C,                 -- 10 [__/__, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]; Resist status+11
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body="Shamash Robe",              -- __ [10/__, 106]; Resist Silence+90
    hands="Academic's Bracers +3",    --  9 [__/__,  57]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___]; DEF+60
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30]
    waist="Carrier's Sash",           -- __ [__/__, ___]; Ele Resist+15
    -- Sub RDM trait                  -- 15
    -- 89 Fast Cast [52 PDT/27 MDT, 544 MEVA]
  }
  sets.precast.FC.QuickMagic.RDM = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Khonsu",                     -- __ [ 6/ 6, ___] __
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head=gear.Merl_FC_head,           -- 15 [__/__,  86] __
    body="Pinga Tunic +1",            -- 15 [__/__, 128] __
    hands=gear.Gende_SongFC_hands,    --  7 [ 3/ 2,  37] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118] __
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __; DEF+60
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back="Perimede Cape",             -- __ [__/__, ___]  4
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- Sub RDM trait                  -- 15
    -- 80 Fast Cast [48PDT/49MDT, 516 MEVA] 11 Quick Magic

    -- hands=gear.Gende_SongFC_hands, --  7 [ 4/__,  37] __
    -- ear1="Genmei Earring",         -- __ [ 2/__, ___] __
    -- 80 Fast Cast [51PDT/47MDT, 516 MEVA] 11 Quick Magic
  }
  sets.precast.FC.RDM.Grimoire = {
    main=gear.Musa_C,                 -- 10 [__/__, ___] __
    sub="Khonsu",                     -- __ [ 6/ 6, ___] __
    ammo="Incantor Stone",            --  2 [__/__, ___] __
    head="Pedagogy Mortarboard +3",   -- __ [__/__,  95] 13
    body="Pinga Tunic +1",            -- 15 [__/__, 128] __
    hands=gear.Gende_SongFC_hands,    --  7 [ 3/ 2,  37] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet="Academic's Loafers +3",     -- __ [__/__, 127] 12
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __; DEF+60
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Etiolation Earring",        --  1 [__/ 3, ___] __; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30] __
    waist="Embla Sash",               --  5 [__/__, ___] __
    -- Sub RDM trait                  -- 15
    -- 82 Fast Cast [42 PDT/26 MDT, 564 MEVA] 25 Grimoire Speed

    -- hands=gear.Gende_SongFC_hands, --  7 [ 4/__,  37] __
    -- 80 Fast Cast [43 PDT/24 MDT, 564 MEVA] 25 Grimoire Speed
  }
  -- No point in using this set until sets.precast.FC.QuickMagic.RDM can cap stats
  -- sets.precast.FC.QuickMagic.RDM.Grimoire = {}

  sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    head="empty",
    body="Crepuscular Cloak",
  })
  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",                  -- __ [__/__, ___]
    sub="Genmei Shield",              -- __ [10/__, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands="Academic's Bracers +3",    --  9 [__/__,  57]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___]
    ear1="Arete Del Luna +1",         -- __ [__/__, ___]; Resists
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SCH_FC_Cape,            -- 10 [10/__,  30]
    waist="Embla Sash",               --  5 [__/__, ___]
    -- 80 Fast Cast [46 PDT/21 MDT, 566 MEVA]
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Oshasha's Treatise",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ear1="Moonshade Earring",
    ring1="Epaminondas's Ring",
    ring2="Rufescent Ring",
    back=gear.SCH_TP_Cape,
    -- neck="Fotia Gorget",
    -- ear2="Telos Earring",
    -- waist="Fotia Belt",
  }

  sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Pedagogy Gown +3",
    legs="Pedagogy Pants +3",
    ear1="Malignance Earring",
    ear2="Regal Earring",
    ring2="Archon Ring",
    back=gear.SCH_MAB_Cape,
    -- feet="Merlinic Crackows",
    -- waist="Sacro Cord",
  })

  -- Max MP
  sets.precast.WS['Myrkr'] = {
    ammo="Strobilus",               --  45
    head="Pixie Hairpin +1",        -- 120
    body="Academic's Gown +3",      -- 173
    legs=gear.Psycloth_D_legs,      -- 109
    ear2="Etiolation Earring",      --  50
    ring1="Mephitas's Ring +1",     -- 110
    back=gear.SCH_MP_Cape,          --  80
    waist="Shinjutsu-no-Obi +1",    --  85
    -- hands="Thrift Gloves +1 ",     --  99
    -- feet=gear.Psycloth_A_feet,     -- 124
    -- neck="Dualism Collar +1",      --  60
    -- ear1="Evans Earring",          --  50
    -- ring1="Persis ring ",          --  80
    -- ring2="Mephitas's Ring",       -- 100
    -- 1175 MP

    -- Ideal:
    -- ammo="Strobilus",              --  45
    -- head="Pixie Hairpin +1",       -- 120
    -- body="Academic's Gown +3",     -- 173
    -- hands="Kaykaus Cuffs +1",      -- 100; Amalric Path A, B good too
    -- legs="Amalric Slops +1",       -- 185; Path A, B, or D
    -- feet=gear.Psycloth_A_feet,     -- 124
    -- neck="Dualism Collar +1",      --  60
    -- ear1="Evans Earring",          --  50
    -- ear2="Etiolation Earring",     --  50
    -- ring1="Mephitas's Ring +1",    -- 110
    -- ring2="Mephitas's Ring",       -- 100
    -- back=gear.SCH_MP_Cape,         --  80
    -- waist="Shinjutsu-no-Obi +1",   --  85
    -- 1282 MP
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = set_combine(sets.precast.FC, {})

  -- Must keep this gear equipped until spell goes off
  -- TODO: Add magic accuracy
  sets.midcast.Impact = set_combine(sets.precast.FC.Impact, {})
  sets.midcast.Dispelga = set_combine(sets.precast.FC.Dispelga, {})

  -- SIRD_options          CPII, CP, Heal Skill, MND, VIT, SIRD, PDT/MDT, -Enmity
  -- main="Eremite's Wand +1",     -- __, __, ___,   2, ___, 25, __/__, __
  -- sub="Culminus",               -- __, __, ___, ___, ___, 10, __/__, __
  -- sub="Magic Strap",            -- __, __, ___, ___, ___,  5, __/__, __
  -- ammo="Staunch Tathlum +1",    -- __, __, ___, ___, ___, 11,  3/ 3, __
  -- head=gear.Kaykaus_C_head,     -- __, 11,  16,  19,  14, 12, __/ 3, __
  -- head="Agwu's Cap",            -- __, __, ___,  26,  11, 10, __/__,  5
  -- head="Chironic Hat",          -- __, __, ___,  29,  14, 11, __/ 2, __
  -- body=gear.Kaykaus_C_body,     --  4, __, ___,  33,  20, 12, __/__, __
  -- body="Rosette Jaseran +1",    -- __, __, ___,  29,  21, 25,  5/ 5, 13
  -- body="Chironic Doublet",      -- __, 13, ___,  34,  16, 11, __/__, __
  -- hands="Chironic Gloves",      -- __, __, ___,  38,  20, 31, __/__,  4
  -- hands=gear.Amalric_B_hands,   -- __, __, ___,  34,  20, 11, __/__,  6
  -- legs=gear.Kaykaus_C_legs,     -- __, 11, ___,  30,  12, 12, __/__, __
  -- legs="Chironic Hose",         -- __,  8, ___,  29,   6, 11, __/__, __
  -- feet=gear.Amalric_B_feet,     -- __, __, ___,  20,   6, 16, __/__,  6
  -- feet="Chironic Slippers",     -- __, __, ___,  24,   6, 11,  2/__,  5
  -- feet="Agwu's Pigaches",       -- __, __, ___,  26,   8, 10, __/__, __
  -- neck="Loricate Torque +1",    -- __, __, ___, ___, ___,  5,  6/ 6, __
  -- ear1="Magnetic Earring",      -- __, __, ___, ___, ___,  8, __/__, __
  -- ear1="Halasz Earring",        -- __, __, ___, ___, ___,  5, __/__,  3
  -- ring1="Freke Ring",           -- __, __, ___, ___, ___, 10, __/__, __
  -- ring1="Evanescence Ring",     -- __, __, ___, ___, ___,  5, __/__, __
  -- back=AmbuCape1,               -- __, 10, ___,  30, ___, 10, __/__, __
  -- back=AmbuCape2,               -- __, __, ___,  30, ___, 10, __/__, 10
  -- waist="Emphatikos Rope",      -- __, __, ___, ___, ___, 12, __/__, __
  -- waist="Sanctuary Obi +1",     -- __, __, ___, ___, ___, 10, __/__,  4
  -- waist="Rumination Sash",      -- __, __, ___,   4, ___, 10, __/__, __
  -- Merit points                  -- __, __, ___, ___, ___, 10, __/__,  5

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to power cap) > SIRD > -DT > Enmity (to -40)
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra SCH/RDM M30 MND = 129
  -- Mithra SCH/RDM M30 VIT = 123
  -- Mithra SCH/RDM M30 Healing Magic Skill = 486 (w/ Light Arts)
  -- For simplicity, this set assumes Light Arts is on. This set will be gimped with LA off. Use Light Arts, dummy!
  sets.midcast.CureNormal = {
    main="Malignance Pole",           -- __, __, ___, ___,  40, __, 20/20, __
    sub="Khonsu",                     -- __, __, ___, ___, ___, __,  6/ 6,  5
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body=gear.Kaykaus_C_body,         --  4, __, ___,  33,  20, 12, __/__, __
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__,  4; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Novia Earring",             -- __, __, ___, ___, ___, __, __/__,  7
    ear2="Halasz Earring",            -- __, __, ___, ___, ___,  5, __/__,  3
    ring1="Kuchekula Ring",           -- __, __, ___, ___, ___, __, __/__,  7; Use Janniston if you have it
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.SCH_CP_Cape,            -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10, __/__,  4
    -- Kaykaus bonus                      8, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 486, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 12 CPII, 49 CP, 502 Heal Skill, 298 MND, 239 VIT, 108 SIRD, 55PDT/48MDT, 41 -Enmity
    -- 710 Power
  }

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to power cap) > SIRD > -DT > Enmity (to -40)
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra SCH/RDM M30 MND = 129
  -- Mithra SCH/RDM M30 VIT = 123
  -- Mithra SCH/RDM M30 Healing Magic Skill = 486 (w/ Light Arts)
  -- For simplicity, this set assumes Light Arts is on. This set will be gimped with LA off. Use Light Arts, dummy!
  sets.midcast.CureWeather = {
    main="Chatoyant Staff",           -- __, 10, ___,   5,   5, __, __/__, __
    sub="Khonsu",                     -- __, __, ___, ___, ___, __,  6/ 6,  5
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__,  4; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Novia Earring",             -- __, __, ___, ___, ___, __, __/__,  7
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __,  7/-1, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.SCH_CP_Cape,            -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __
    -- Kaykaus set bonus              --  6, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 486, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 6 CPII, 59 CP, 502 Heal Skill, 309 MND, 233 VIT, 106 SIRD, 50PDT/37MDT, 40 -Enmity
    -- 714 Power
  }

  sets.midcast.CureNormal.LightArts = set_combine(sets.midcast.CureNormal, {})
  sets.midcast.CureWeather.LightArts = set_combine(sets.midcast.CureWeather, {})

  -- Removal rate = Base Rate * (1+(y/100))
  -- Base rate = (10+(Healing Skill / 30)); y = Cursna+ stat from gear
  -- Mithra SCH/RDM M30 Healing Magic Skill = 416
  sets.midcast.Cursna = {
    main="Gada",                  -- 18, __,  6
    sub="Culminus",
    ammo="Incantor Stone",        -- __, __,  2
    head=gear.Vanya_B_head,       -- 20, __, __
    body=gear.Vanya_B_body,       -- 20, __, __
    hands="Hieros Mittens",       -- __, 10, __
    legs=gear.Vanya_B_legs,       -- 20, __, __
    feet=gear.Vanya_B_feet,       -- 40,  5, __
    neck="Debilis Medallion",     -- __, 15, __
    ear1="Malignance Earring",    -- __, __,  4
    ear2="Meili Earring",         -- 10, __, __
    ring1="Haoma's Ring",         --  8, 15, __
    ring2="Menelaus's Ring",      -- 15, 20,-10
    back="Oretania's Cape +1",    -- __,  5, __
    waist="Embla Sash",           -- __, __,  5
    -- sub="Chanter's Shield",    -- __, __,  3
    -- Base stats                   416, __, __
    -- 567 Healing skill, 70 Cursna+, 10 FC; Cursna Rate = 49.13%

    -- Ideal:
    -- main="Hvergelmir",         -- __, __, 50
    -- sub="Clerisy Strap +1",    -- __, __,  3
    -- Base stats                   416, __, __
    -- 549 Healing skill, 70 Cursna+, 54 FC; Cursna Rate = 48.11%
  }
  -- Mithra SCH/RDM M30 Healing Magic Skill = 486 (w/ Light Arts)
  sets.midcast.Cursna.LightArts = set_combine(sets.midcast.Cursna, {
    legs="Academic's Pants +3",   -- 24, __,  9
    -- Base stats                   486, __, __
    -- 623 Healing skill, 70 Cursna+, 63 FC; Cursna Rate = 52.3%
  })

  -- Enh Magic Skill + Enh Magic Duration > Fast Cast
  sets.midcast['Enhancing Magic'] = {
    ammo="Sapience Orb",              -- __, __,  2
    main=gear.Gada_ENH,               -- 18,  6, __
    sub="Ammurapi Shield",            -- __, 10, __
    head=gear.Telchine_ENH_head,      -- __, 10,  5
    body="Pedagogy Gown +3",          -- 19, 12, __
    hands=gear.Telchine_ENH_hands,    -- __, 10, __
    legs=gear.Telchine_ENH_legs,      -- __, 10,  5
    feet=gear.Kaykaus_D_feet,         -- 21, __,  4
    neck="Incanter's Torque",         -- 10, __, __
    ear1="Mimir Earring",             -- 10, __, __
    ear2="Andoaa Earring",            --  5, __, __
    ring1="Stikini Ring +1",          --  8, __, __
    ring2="Stikini Ring +1",          --  8, __, __
    back=gear.SCH_FC_Cape,            -- __, __, 10
    waist="Embla Sash",               -- __, 10,  5

    -- main=gear.Gada_ENH,            -- 18,  6,  6
    -- ammo="Savant's Treatise",      --  4, __, __
    -- back="Fi Follet Cape +1",      --  9, __, 10
    -- 108 Enh Skill, 68 Enh Duration, 35 FC
  }

  sets.midcast.EnhancingDuration = {
    main=gear.Musa_C,               -- 20, 10
    sub="Clerisy Strap +1",         -- __,  3
    head=gear.Telchine_ENH_head,    -- 10,  5
    body="Pedagogy Gown +3",        -- 12, __
    hands=gear.Telchine_ENH_hands,  -- 10, __
    legs=gear.Telchine_ENH_legs,    -- 10,  5
    feet=gear.Telchine_ENH_feet,    -- 10,  5
    waist="Embla Sash",             -- 10,  5
    -- 82 Enh Duration, 33 FC
  }

  -- Regen not affected by Enh Magic Skill
  -- Regen % pieces apply to base value (no LA bonus), floored, then +1.
  -- floor[(Base Regen) + sum(floor(Base Regen x %Regen bonuses)+1) x Embolden)] + LA bonus + Regen Potency from Armor + Morgelai and Musa bonus.
  sets.midcast.Regen = {
    main=gear.Musa_C,                   -- 25, 20, __
    sub="Khonsu",                       -- __, __, __
    head="Arbatel Bonnet +3",           -- 11, __, __
    body=gear.Telchine_Regen_body,      --  3, __, 12
    hands=gear.Telchine_Regen_hands,    --  3, __, __
    legs=gear.Telchine_Regen_legs,      --  3, __, __
    feet=gear.Telchine_Regen_feet,      --  3, __, __
    back=gear.SCH_Adoulin_Regen_Cape,   -- 10, __, __
    waist="Embla Sash",                 -- __, 10,  5
    -- Base Potency (w/ Light Arts)        64, __, __
    -- 122 Regen Potency, 30 Enh Duration %, 17 Regen Duration
  }

  -- Can get longer duration, but potency takes a significant hit, so opted not to do that.
  sets.midcast.RegenDuration = {
    main=gear.Musa_C,                 -- 25, 20, __
    sub="Khonsu",                     -- __, __, __
    head="Arbatel Bonnet +3",         -- 11, __, __
    body=gear.Telchine_ENH_body,      -- __, 10, 12
    hands=gear.Telchine_ENH_hands,    -- __, 10, __
    legs=gear.Telchine_ENH_legs,      -- __, 10, __
    feet=gear.Telchine_ENH_feet,      -- __, 10, __
    back=gear.SCH_Adoulin_Regen_Cape, -- 10, __, __
    waist="Embla Sash",               -- __, 10,  5
    -- Base Potency (w/ Light Arts)      64, __, __
    -- 110 Regen Potency, 70 Enh Duration %, 17 Regen Duration
  }

  sets.midcast.Haste = set_combine(sets.midcast.EnhancingDuration, {})

  -- Ref Potency > Enh Duration %, Ref Duration
  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
    head="Amalric Coif +1",           --  2, __, __
    -- 2 Ref Potency, 72 Enh Duration%, 0 Ref Duration
  })

  sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {
    back="Grapevine Cape",   -- __, __, 30
    waist="Gishdubar Sash",  -- __, __, 20
    -- 2 Ref Potency, 62 Enh Duration%, 50 Ref Duration
  })

  -- Stoneskin Cap, Enh Duration
  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    neck="Nodens Gorget",    -- 30, __, __
    ear1="Earthcry Earring", -- 10, __, __
    waist="Siegel Sash",     -- 20, __, __
    -- +60 Stoneskin Cap, 72% Enh Duration
  })

  -- Aquaveil Count > Enh Duration
  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    main="Bolelabunga",
    sub="Ammurapi Shield",          -- __, 10
    head="Amalric Coif +1",         --  2, __
    hands="Regal Cuffs",            --  2, __
    waist="Emphatikos Rope",        --  1, __
    -- main="Vadose Rod",           --  1, __
    -- legs="Shedir Seraweels",     --  1, __
    -- +6 Aquaveil, 32% Enh Duration
  })

  sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {})

  sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {
    feet="Pedagogy Loafers +3",
  })

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring2="Sheltered Ring",
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shell = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell, {})

  -- M.Acc > MND > Enfeebling Duration > Enfeebling Skill
  sets.midcast.MndEnfeebles = {
    main="Contemplator +1",             -- 70, 22, __, 20; +228 M.Acc skill
    sub="Khonsu",                       -- 30, __, __, __
    ammo="Pemphredo Tathlum",           --  8, __, __, __
    head="Academic's Mortarboard +3",   -- 52, 37, __, __
    body="Academic's Gown +3",          -- 50, 39, __, __; +24 enf skill in DA
    hands="Regal Cuffs",                -- 45, 40, 20, __
    legs="Arbatel Pants +3",            -- 63, 38, __, 28; +36 M.acc in Grimoire
    feet="Academic's Loafers +3",       -- 46, 29, __, __; +20 M.Acc in Grimoire
    neck="Argute Stole +2",             -- 30, 15, __, __
    ear1="Regal Earring",               -- __, 10, __, __; Adds set bonus
    ear2="Malignance Earring",          -- 10,  8, __, __
    ring1="Kishar Ring",                --  5, __, 10, __
    ring2="Metamorph Ring +1",          -- 16, 15, __, __
    back="Aurist's Cape +1",            -- 33, 33, __, __
    waist="Obstinate Sash",             -- 15,  5,  5, 15
    -- Academic's set bonus             -- 45, __, __, __
    -- 518 M.Acc, 291 MND, 35% Enfeebling Duration, 63 Enfeebling Skill

    -- ear2="Arbatel Earring +2",       -- 20, 15, __, __
    -- 543 M.Acc, 298 MND, 35% Enfeebling Duration, 63 Enfeebling Skill
  }
  sets.midcast.MndEnfeebles.LightArts = set_combine(sets.midcast.MndEnfeebles, {
    legs="Arbatel Pants +3",            -- 63, 38, __, 28; +36 M.acc in Grimoire
    feet="Academic's Loafers +3",       -- 46, 29, __, __; +20 M.Acc in Grimoire
  })

  sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {})

  -- M.Acc > INT > Enfeebling Duration > Enfeebling Skill
  sets.midcast.IntEnfeebles = {
    main="Contemplator +1",             -- 70, 12, __, 20; +228 M.Acc skill
    sub="Khonsu",                       -- 30, __, __, __
    ammo="Pemphredo Tathlum",           --  8,  4, __, __
    head="Academic's Mortarboard +3",   -- 52, 37, __, __
    body="Academic's Gown +3",          -- 50, 44, __, __; +24 enf skill in DA
    hands="Regal Cuffs",                -- 45, 40, 20, __
    legs="Arbatel Pants +3",            -- 63, 38, __, 28; +36 M.acc in Grimoire
    feet="Academic's Loafers +3",       -- 46, 32, __, __; +20 M.Acc in Grimoire
    neck="Argute Stole +2",             -- 30, 15, __, __
    ear1="Regal Earring",               -- __, 10, __, __; Adds set bonus
    ear2="Malignance Earring",          -- 10,  8, __, __
    ring1="Kishar Ring",                --  5, __, 10, __
    ring2="Metamorph Ring +1",          -- 16, 15, __, __
    back="Aurist's Cape +1",            -- 33, 33, __, __
    waist="Obstinate Sash",             -- 15,  5,  5, 15
    -- Academic's set bonus             -- 45, __, __, __
    -- 518 M.Acc, 293 INT, 35% Enfeebling Duration, 63 Enfeebling Skill

    -- ear2="Arbatel Earring +2",       -- 20, 15, __, __
    -- 528 M.Acc, 300 INT, 35% Enfeebling Duration, 63 Enfeebling Skill
  }
  sets.midcast.IntEnfeebles.DarkArts = set_combine(sets.midcast.IntEnfeebles, {
    body="Academic's Gown +3",          -- 50, 44, __, __; +24 enf skill in DA
    legs="Arbatel Pants +3",            -- 63, 38, __, 28; +36 M.acc in Grimoire
    feet="Academic's Loafers +3",       -- 46, 29, __, __; +20 M.Acc in Grimoire
  })

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {})
  sets.midcast.ElementalEnfeeble.DarkArts = set_combine(sets.midcast.IntEnfeebles.DarkArts, {})
  sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
    main="Daybreak",
    sub="Ammurapi Shield",
    waist="Shinjutsu-no-Obi +1",
  })

  -- SCH Dark Magic = 386, with Dark Arts = 456
  -- Dark Magic Skill, INT, M.Acc
  sets.midcast['Dark Magic'] = {
    main="Rubicundity",                   -- 22, 21, 26; +215 M.Acc skill
    sub="Ammurapi Shield",                -- __, 13, 38
    ammo="Pemphredo Tathlum",             -- __,  4,  8
    head="Academic's Mortarboard +3",     -- __, 37, 52
    body="Academic's Gown +3",            -- 24, 44, 50
    hands="Academic's Bracers +3",        -- __, 29, 48
    legs="Pedagogy Pants +3",             -- 19, 47, 39
    feet="Academic's Loafers +3",         -- __, 32, 46
    neck="Erra Pendant",                  -- 10, __, 17
    ear1="Mani Earring",                  -- 10, __, __
    ear2="Regal Earring",                 -- __, 10, __; Adds set effect
    ring1="Evanescence Ring",             -- 10, __, __
    ring2="Stikini Ring +1",              --  8, __, 11
    back="Bookworm's Cape",               --  8,  4, __
    waist="Acuity Belt +1",               -- __, 23, __
    -- Academic's set bonus               -- __, __, 60
    -- Base stats                           440,127,___
    -- 551 Dark magic skill, 391 INT, 395 M.Acc
    
    -- main="Rubicundity",                -- 25, 21, 30; +215 M.Acc skill
    -- back="Bookworm's Cape",            --  8,  5, __
    -- 554 Dark magic skill, 392 INT, 399 M.Acc
  }

  -- Add Drain potency
  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
    legs="Pedagogy Pants +3",       -- 19, 47, 39, 15
    ear2="Hirudinea Earring",       -- __, __, __,  3
    ring1="Evanescence Ring",       -- 10, __, __, 10
    waist="Fucho-no-obi",           -- __, __, __,  8
    -- 554 Dark magic skill, 359 INT, 384 M.Acc, 56 Drain/Aspir potency
  })

  sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})

  -- FC > M.Acc > M.Acc Skill
  sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    ammo="Pemphredo Tathlum",             -- __,  8, ___
    head="Academic's Mortarboard +3",     --  8, 52, ___
    body="Academic's Gown +3",            -- __, 50, ___
    hands="Academic's Bracers +3",        --  9, 48, ___
    legs="Academic's Pants +3",           -- __, 49, ___
    feet="Academic's Loafers +3",         -- __, 46, ___
    neck="Argute Stole +2",               -- __, 30, ___
    ear1="Malignance Earring",            --  4, 10, ___
    ring1="Stikini Ring +1",              -- __, 11, ___; +8 all skill
    ring2="Stikini Ring +1",              -- __, 11, ___; +8 all skill
    back=gear.SCH_MAB_Cape,

    --Ideal:
    -- main="Hvergelmir",                 -- 50, __, 269
    -- sub="Khonsu",                      -- __, 30, ___
    -- head="Academic's Mortarboard +3",  --  8, 52, ___
    -- body="Academic's Gown +3",         -- __, 50, ___
    -- hands="Academic's Bracers +3",     --  9, 48, ___
    -- legs="Academic's Pants +3",        -- __, 49, ___
    -- neck="Argute Stole +2",            -- __, 30, ___
    -- ear1="Malignance Earring",         --  4, 10, ___
    -- ear2="Dignitary's Earring",        -- __, 10, ___
    -- ring1="Stikini Ring +1",           -- __, 11, ___; +8 all skill
    -- ring2="Stikini Ring +1",           -- __, 11, ___; +8 all skill
    -- back=gear.SCH_INT_MAcc_Cape,       -- 10, 30, ___
    -- waist="Acuity Belt +1",            -- __, 15, ___
    -- Academic's set bonus               -- __, 60, ___
    -- 81 FC, 460 M.Acc, 269 M.Acc Skill
  })

  sets.midcast.Stun.DarkArts = set_combine(sets.midcast.Stun, {
    ammo="Pemphredo Tathlum",           -- __, __,  8, ___
    head="Pedagogy Mortarboard +3",     -- 13, __, 37, ___; Grimoire recast-
    body="Academic's Gown +3",          -- __, __, 50, ___; +24 Dark Magic skill in DA
    hands="Academic's Bracers +3",      -- __,  9, 48, ___
    legs="Academic's Pants +3",         -- __, __, 49, ___
    feet="Academic's Loafers +3",       -- 12, __, 46, ___; Grimoire recast-, +20M.Acc in Grimoire
    neck="Argute Stole +2",             -- __, __, 30, ___
    ear1="Malignance Earring",          -- __,  4, 10, ___
    ear2="Regal Earring",               -- __, __, __, ___; adds set effect
    ring1="Stikini Ring +1",            -- __, __, 11, ___; +8 all skill
    ring2="Stikini Ring +1",            -- __, __, 11, ___; +8 all skill

    --Ideal:
    -- main="Hvergelmir",               -- __, 50, __, 269
    -- sub="Khonsu",                    -- __, __, 30, ___
    -- head="Pedagogy Mortarboard +3",  -- 13, __, 37, ___; Grimoire recast-
    -- body="Academic's Gown +3",       -- __, __, 50, ___; +24 Dark Magic skill in DA
    -- hands="Academic's Bracers +3",   -- __,  9, 48, ___
    -- legs="Academic's Pants +3",      -- __, __, 49, ___
    -- neck="Argute Stole +2",          -- __, __, 30, ___
    -- ear1="Malignance Earring",       -- __,  4, 10, ___
    -- ear2="Regal Earring",            -- __, __, __, ___; adds set effect
    -- ring1="Stikini Ring +1",         -- __, __, 11, ___; +8 all skill
    -- ring2="Stikini Ring +1",         -- __, __, 11, ___; +8 all skill
    -- back=gear.SCH_INT_MAcc_Cape,     -- __, 10, 30, ___
    -- waist="Witful Belt",             -- __,  3, __, ___
    -- Academic's set bonus             -- __, __, 60, ___
    -- 25% Grimoire Recast, 76 FC, 420 M.Acc, 269 M.Acc Skill
    -- Add 10% Grimoire Recast from Dark Arts
    -- Hits 90% recast reduction cap even without Haste spell/JA
  })
  sets.midcast.Stun.LightArts = set_combine(sets.midcast.Stun.DarkArts, {})

  -- Focus INT, Magic Accuracy, magic accuracy skill, elemental magic skill, Conserve MP
  sets.midcast.Impact = {
    main="Bunzi's Rod",               -- 15, 55, 255, ___, __
    sub="Ammurapi Shield",            -- 13, 38, ___, ___, __
    ammo="Ghastly Tathlum +1",        -- 11, __, ___, ___, __
    head="empty",
    body="Crepuscular Cloak",         -- 80, 85, ___, ___, __
    hands="Arbatel Bracers +3",       -- 36, 62, ___, ___, __
    legs="Arbatel Pants +3",          -- 53, 63, ___, ___, __; M.Acc +36
    feet="Arbatel Loafers +3",        -- 34, 60, ___,  33, __
    neck="Argute Stole +2",           -- 15, 30, ___, ___, __
    ear1="Regal Earring",             -- 10, __, ___, ___, __
    ear2="Malignance Earring",        --  8,  8, ___, ___, __
    ring1="Stikini Ring +1",          -- __, 11, ___,   8, __
    ring2="Metamorph Ring +1",        -- 16, 15, ___, ___, __
    back="Aurist's Cape +1",          -- 33, 33, ___, ___,  5
    waist="Acuity Belt +1",           -- 23, 15, ___, ___, __
    -- 347 INT, 462 M.Acc, 255 M.Acc Skill, 41 Elemental Skill, 5 Conserve MP
    
    -- ear2="Arbatel Earring +2",     -- 15, 20, ___, ___, __
    -- 354 INT, 502 M.Acc, 255 M.Acc Skill, 41 Elemental Skill, 5 Conserve MP
  }

  -- INT, MAcc, MAB, MAccSk, MDmg, MB Dmg%, MB2 Dmg%
  MB_options = {
    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __
    -- sub="Ammurapi Shield",         -- 13, 38, 38, ___, ___, __, __
    -- main=gear.Akademos_C,          -- 27, 25, 53, 228, 217, 10, __
    -- sub="Enki Strap",              -- 10, 10, __, ___, ___, __, __
    -- head="Pedagogy Mortarboard +3",-- 39, 37, 49, ___, ___, __,  4
    -- head="Agwu's Cap",             -- 33, 55, 60, ___,  35,  7, __
    -- head=gear.Nyame_B_head,        -- 28, 40, 30, ___, ___,  5, __
    -- body="Academic's Gown +3",     -- 44, 50, __, ___, ___, 10, __
    -- body="Agwu's Robe",            -- 47, 55, 60, ___,  30, 10, __
    -- body=gear.Nyame_B_body,        -- 42, 40, 30, ___, ___,  7, __
    -- body=gear.Merl_MB_body,        -- 43, 20, 20, ___, ___, 11, __
    -- hands=gear.Merl_MB_hands,      -- 26,  9, 29, ___, ___,  9, __
    -- hands=gear.Nyame_B_hands,      -- 28, 40, 30, ___, ___,  5, __
    -- hands=gear.Amalric_D_hands,    -- 24, 20, 53, ___, ___, __,  6
    -- hands="Arbatel Bracers +3",    -- 36, 62, 52, ___,  32, 15, __
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Mallquis Trews +2",      -- 57, 45, 15, ___,  55,  6, __
    -- legs=gear.Nyame_B_legs,        -- 44, 40, 30, ___, ___,  6, __
    -- legs="Agwu's Slops",           -- 54, 55, 60, ___,  20,  9, __
    -- feet="Arbatel Loafers +3",     -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    -- feet="Jhakri Pigaches +2",     -- 33, 42, 39, ___, ___,  7, __
    -- feet=gear.Nyame_B_feet,        -- 25, 40, 30, ___, ___,  5, __
    -- feet="Agwu's Pigaches",        -- 30, 55, 60, ___,  20,  6, __
    -- feet=gear.Merl_MB_feet,        -- 27,  1, 16, ___, ___,  8, __
    -- neck="Argute Stole +2",        -- 15, 30, __, ___,  25, 10, __; Helix dur +10%
    -- neck="Mizukage-No-Kubikazari", --  4, __,  8, ___, ___, 10, __
    -- ear1="Static Earring",         -- __, __, __, ___, ___,  5, __
    -- ring1="Mujin Band",            -- __, __, __, ___, ___, __,  5
    -- ring1="Jhakri Ring",           -- __,  6,  3, ___, ___,  2, __
    -- ring1="Locus Ring",            -- __, __, __, ___, ___,  5, __
    -- back="Seshaw Cape +1",         -- __, __, 12, ___, ___,  6, __
  }

  -- INT, Magic Acc, MAB
  -- More emphasis on MAB
  sets.midcast['Elemental Magic'] = {
    main="Bunzi's Rod",               -- 15, 50, 60, 255, 248, 10, __
    sub="Ammurapi Shield",            -- 13, 38, 38, ___, ___, __, __
    ammo="Pemphredo Tathlum",         --  4,  8,  4, ___, ___, __, __
    head="Pedagogy Mortarboard +3",   -- 39, 37, 49, ___, ___, __,  4
    body=gear.Merl_MAB_body,          -- 40, 39, 64, ___, ___, __, __
    hands="Arbatel Bracers +3",       -- 36, 62, 52, ___,  32, 15, __
    legs="Pedagogy Pants +3",         -- 47, 39, 51, ___, ___, __, __; Elemental skill +19
    feet="Arbatel Loafers +3",        -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    neck="Sanctity Necklace",         -- __, 10, 10, ___, ___, __, __
    ear1="Malignance Earring",        --  8, 10,  8, ___, ___, __, __
    ear2="Regal Earring",             -- 10, __,  7, ___, ___, __, __
    ring1="Freke Ring",               -- 10, __,  8, ___, ___, __, __
    ring2="Metamorph Ring +1",        -- 16, 15, __, ___, ___, __, __
    back=gear.SCH_MAB_Cape,           -- 30, 20, 10, ___,  20, __, __
    waist="Refoccilation Stone",      -- __,  4, 10, ___, ___, __, __
    -- 302 INT, 392 MAcc, 421 MAB, 255 MAccSk, 330 MDmg, 25 MB Dmg%, 9 MB2 Dmg%
    
    -- Ideal:
    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __; R30
    -- sub="Ammurapi Shield",         -- 13, 38, 38, ___, ___, __, __
    -- ammo="Pemphredo Tathlum",      --  4,  8,  4, ___, ___, __, __
    -- head="Agwu's Cap",             -- 33, 55, 60, ___,  35,  7, __
    -- body="Agwu's Robe",            -- 47, 55, 60, ___,  30, 10, __
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Agwu's Slops",           -- 54, 55, 60, ___,  20,  9, __
    -- feet="Agwu's Pigaches",        -- 30, 55, 60, ___,  20,  6, __
    -- neck="Sanctity Necklace",      -- __, 10, 10, ___, ___, __, __
    -- ear1="Malignance Earring",     --  8, 10,  8, ___, ___, __, __
    -- ear2="Arbatel Earring +2",     -- 15, 20,  9, ___,   9, __, __
    -- ring1="Freke Ring",            -- 10, __,  8, ___, ___, __, __
    -- ring2="Metamorph Ring +1",     -- 16, 15, __, ___, ___, __, __
    -- back=gear.SCH_MAB_Cape,        -- 30, 20, 10, ___,  20, __, __
    -- waist="Refoccilation Stone",   -- __,  4, 10, ___, ___, __, __
    -- 308 INT, 455 MAcc, 462 MAB, 255 MAccSk, 402 MDmg, 50 MB Dmg%, 6 MB2 Dmg%
  }
  sets.midcast['Elemental Magic'].MB = set_combine(sets.midcast['Elemental Magic'], {
    main="Bunzi's Rod",               -- 15, 50, 60, 255, 248, 10, __
    sub="Ammurapi Shield",            -- 13, 38, 38, ___, ___, __, __
    ammo="Pemphredo Tathlum",         --  4,  8,  4, ___, ___, __, __
    head="Pedagogy Mortarboard +3",   -- 39, 37, 49, ___, ___, __,  4
    body=gear.Merl_MAB_body,          -- 40, 39, 64, ___, ___, __, __
    hands="Arbatel Bracers +3",       -- 36, 62, 52, ___,  32, 15, __
    legs="Pedagogy Pants +3",         -- 47, 39, 51, ___, ___, __, __; Elemental skill +19
    feet="Arbatel Loafers +3",        -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    neck="Argute Stole +2",           -- 15, 30, __, ___,  25, 10, __
    ear1="Malignance Earring",        --  8, 10,  8, ___, ___, __, __
    ear2="Regal Earring",             -- 10, __,  7, ___, ___, __, __
    ring1="Freke Ring",               -- 10, __,  8, ___, ___, __, __
    ring2="Mujin Band",               -- __, __, __, ___, ___, __,  5
    back=gear.SCH_MAB_Cape,           -- 30, 20, 10, ___,  20, __, __
    waist="Refoccilation Stone",      -- __,  4, 10, ___, ___, __, __
    -- 301 INT, 397 MAcc, 411 MAB, 255 MAccSk, 355 MDmg, 35 MB Dmg%, 14 MB2 Dmg%

    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __; R30
    -- sub="Ammurapi Shield",         -- 13, 38, 38, ___, ___, __, __
    -- ammo="Pemphredo Tathlum",      --  4,  8,  4, ___, ___, __, __
    -- head="Pedagogy Mortarboard +3",-- 39, 37, 49, ___, ___, __,  4
    -- body="Agwu's Robe",            -- 47, 55, 60, ___,  30, 10, __
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Agwu's Slops",           -- 54, 55, 60, ___,  20,  9, __
    -- feet="Arbatel Loafers +3",     -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    -- neck="Argute Stole +2",        -- 15, 30, __, ___,  25, 10, __
    -- ear1="Malignance Earring",     --  8, 10,  8, ___, ___, __, __
    -- ear2="Arbatel Earring +2",     -- 15, 20,  9, ___,   9, __, __
    -- ring1="Freke Ring",            -- 10, __,  8, ___, ___, __, __
    -- ring2="Mujin Band",            -- __, __, __, ___, ___, __,  5
    -- back=gear.SCH_MAB_Cape,        -- 30, 20, 10, ___,  20, __, __
    -- waist="Refoccilation Stone",   -- __,  4, 10, ___, ___, __, __
    -- 317 INT, 447 MAcc, 431 MAB, 255 MAccSk, 402 MDmg, 47 MB Dmg%, 20 MB2 Dmg%
  })
  sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
    body="Seidr Cotehardie",          -- __, 13,  7, ___, ___, __, __; Convert 2% dmg to MP
    waist="Acuity Belt +1",           -- 23, 15, __, ___, ___, __, __
  })
  sets.midcast['Elemental Magic'].Seidr.MB = set_combine(sets.midcast['Elemental Magic'].MB, {
    body="Seidr Cotehardie",          -- __, 13,  7, ___, ___, __, __; Convert 2% dmg to MP
    waist="Acuity Belt +1",           -- 23, 15, __, ___, ___, __, __
    
    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __; R30
    -- sub="Ammurapi Shield",         -- 13, 38, 38, ___, ___, __, __
    -- ammo="Pemphredo Tathlum",      --  4,  8,  4, ___, ___, __, __
    -- head="Pedagogy Mortarboard +3",-- 39, 37, 49, ___, ___, __,  4
    -- body="Seidr Cotehardie",       -- __, 13,  7, ___, ___, __, __; Convert 2% dmg to MP
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Agwu's Slops",           -- 54, 55, 60, ___,  20,  9, __
    -- feet="Arbatel Loafers +3",     -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    -- neck="Argute Stole +2",        -- 15, 30, __, ___,  25, 10, __
    -- ear1="Malignance Earring",     --  8, 10,  8, ___, ___, __, __
    -- ear2="Arbatel Earring +2",     -- 15, 20,  9, ___,   9, __, __
    -- ring1="Locus Ring",            -- __, __, __, ___, ___,  5, __
    -- ring2="Mujin Band",            -- __, __, __, ___, ___, __,  5
    -- back=gear.SCH_MAB_Cape,        -- 30, 20, 10, ___,  20, __, __
    -- waist="Acuity Belt +1",        -- 23, 15, __, ___, ___, __, __
    -- 283 INT, 416 MAcc, 360 MAB, 255 MAccSk, 372 MDmg, 42 MB Dmg%, 20 MB2 Dmg%
  })
  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Ghastly Tathlum +1",        -- 11, __, __, ___,  21, __, __
    legs="Pedagogy Pants +3",         -- 47, 39, 51, ___, ___, __, __; Elemental skill +19
    feet="Arbatel Loafers +3",        -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    neck="Argute Stole +2",           -- 15, 30, __, ___,  25, 10, __
    ring1="Freke Ring",               -- 10, __,  8, ___, ___, __, __
    waist="Acuity Belt +1",           -- 23, 15, __, ___, ___, __, __
    
    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __; R30
    -- sub="Ammurapi Shield",         -- 13, 38, 38, ___, ___, __, __
    -- ammo="Ghastly Tathlum +1",     -- 11, __, __, ___,  21, __, __
    -- head="Agwu's Cap",             -- 33, 55, 60, ___,  35,  7, __
    -- body="Agwu's Robe",            -- 47, 55, 60, ___,  30, 10, __
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Pedagogy Pants +3",      -- 47, 39, 51, ___, ___, __, __; Elemental skill +19
    -- feet="Arbatel Loafers +3",     -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    -- neck="Argute Stole +2",        -- 15, 30, __, ___,  25, 10, __
    -- ear1="Malignance Earring",     --  8, 10,  8, ___, ___, __, __
    -- ear2="Arbatel Earring +2",     -- 15, 20,  9, ___,   9, __, __
    -- ring1="Freke Ring",            -- 10, __,  8, ___, ___, __, __
    -- ring2="Metamorph Ring +1",     -- 16, 15, __, ___, ___, __, __
    -- back=gear.SCH_MAB_Cape,        -- 30, 20, 10, ___,  20, __, __
    -- waist="Acuity Belt +1",        -- 23, 15, __, ___, ___, __, __
    -- 350 INT, 467 MAcc, 419 MAB, 255 MAccSk, 438 MDmg, 45 MB Dmg%, 11 MB2 Dmg%
  })

  sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'], {})
  sets.midcast.Kaustra.MB = set_combine(sets.midcast['Elemental Magic'].MB, {})
  sets.midcast.Kaustra.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})

  sets.midcast.Helix = {
    main="Bunzi's Rod",               -- 15, 50, 60, 255, 248, 10, __
    sub="Culminus",                   -- __, __, 20, ___,  75, __, __
    ammo="Ghastly Tathlum +1",        -- 11, __, __, ___,  21, __, __
    head="Pedagogy Mortarboard +3",   -- 39, 37, 49, ___, ___, __,  4
    body="Mallquis Saio +2",          -- 54, 46, 15, ___,  58, __, __
    hands="Arbatel Bracers +3",       -- 36, 62, 52, ___,  32, 15, __
    legs="Mallquis Trews +2",         -- 57, 45, 15, ___,  55,  6, __
    feet="Arbatel Loafers +3",        -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    neck="Argute Stole +2",           -- 15, 30, __, ___,  25, 10, __; Helix Dur+10%
    ear1="Malignance Earring",        --  8, 10,  8, ___, ___, __, __
    ear2="Regal Earring",             -- 10, __,  7, ___, ___, __, __
    ring1="Metamorph Ring +1",        -- 16, 15, __, ___, ___, __, __
    ring2="Mujin Band",               -- __, __, __, ___, ___, __,  5
    back=gear.SCH_MAB_Cape,           -- 30, 20, 10, ___,  20, __, __
    waist="Acuity Belt +1",           -- 23, 15, __, ___, ___, __, __
    -- 348 INT, 390 MAcc, 286 MAB, 255 MAccSk, 564 MDmg, 41 MB Dmg%, 14 MB2 Dmg%

    -- Ideal:
    -- main="Bunzi's Rod",            -- 15, 55, 65, 255, 248, 10, __; R30
    -- sub="Culminus",                -- __, __, 20, ___,  75, __, __
    -- ammo="Ghastly Tathlum +1",     -- 11, __, __, ___,  21, __, __
    -- head="Agwu's Cap",             -- 33, 55, 60, ___,  35,  7, __
    -- body="Mallquis Saio +2",       -- 54, 46, 15, ___,  58, __, __
    -- hands="Agwu's Gages",          -- 33, 55, 60, ___,  20,  8,  6
    -- legs="Mallquis Trews +2",      -- 57, 45, 15, ___,  55,  6, __
    -- feet="Arbatel Loafers +3",     -- 34, 60, 50, ___,  30, __,  5; Elemental skill +33
    -- neck="Argute Stole +2",        -- 15, 30, __, ___,  25, 10, __; Helix dur +10%
    -- ear1="Malignance Earring",     --  8, 10,  8, ___, ___, __, __
    -- ear2="Arbatel Earring +2",     -- 15, 20,  9, ___,   9, __, __
    -- ring1="Metamorph Ring +1",     -- 16, 15, __, ___, ___, __, __
    -- ring2="Mujin Band",            -- __, __, __, ___, ___, __,  5
    -- back=gear.SCH_MAB_Cape,        -- 30, 20, 10, ___,  20, __, __
    -- waist="Acuity Belt +1",        -- 23, 15, __, ___, ___, __, __
    -- Mallquis set bonus             --  8, __, __, ___, ___, __, __
    -- 352 INT, 426 MAcc, 312 MAB, 255 MAccSk, 596 MDmg, 41 MB Dmg%, 16 MB2 Dmg%
  }
  sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
    ring1="Archon Ring",
  })
  sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
    main="Daybreak",
    sub="Ammurapi Shield",
    -- body="Agwu's Robe",
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
    back=gear.SCH_TP_Cape,            -- __, 10, 30 <__, __, __> [10/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 33 Haste, 36 STP, 405 Acc <20 DA, 0 TA, 0 QA> [49 PDT/39 MDT, 524 MEVA]

    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skill+15
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 33 Haste, 42 STP, 390 Acc <21 DA, 0 TA, 0 QA> [49 PDT/39 MDT, 524 MEVA]
  }

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.CaitSith = {
    main="Bunzi's Rod",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head="Academic's Mortarboard +3",
    body="Pedagogy Gown +3",
    hands="Academic's Bracers +3",
    legs="Assiduity Pants +1",
    feet=gear.Kaykaus_D_feet,
    neck="Loricate Torque +1",
    ear1="Savant's Earring",
    ear2="Enhancing Earring",
    ring1="Metamorph Ring +1",
    ring2="Defending Ring",
    back=gear.SCH_FC_Cape,
    waist="Embla Sash",
  }

  sets.Bookworm = {
    back="Bookworm's Cape",
  }

  -- Do not modify
  sets.Immanence = {}

  -- Cap SIRD and DT, fill the rest with MAB
  sets.Immanence.SIRD = {
    main="Mpaca's Staff",             -- 18, 60, 50 [__/__, ___] __; R25
    sub="Khonsu",                     -- __, __, 30 [ 6/ 6, ___] __
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___] 11
    -- head="Agwu's Cap",             -- 33, 60, 55 [__/__, 107] 10
    body=gear.Kaykaus_C_body,         -- 30, 28, 35 [__/__,  80] 12
    hands=gear.Chironic_SIRD_hands,   -- 25, 15, 16 [__/__,  48] 31
    legs="Agwu's Slops",              -- 49, 60, 50 [ 9/ 9, 134] __; R25
    -- feet="Agwu's Pigaches",        -- 30, 58, 53 [__/__, 134]  5; R25
    neck="Loricate Torque +1",        -- __, __, __ [ 6/ 6, ___]  5
    ear1="Magnetic Earring",          -- __, __, __ [__/__, ___]  8
    ear2="Halasz Earring",            -- __, __, __ [__/__, ___]  5; Magic crit rate +14%
    ring1="Freke Ring",               -- 10,  8, __ [__/__, ___] 10
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.SCH_MAB_Cape,           -- 30, 10, 20 [10/__, ___] __
    waist="Orpheus's Sash",           -- Swap conditionally to Hachirin-no-obi
    -- Merit points                   -- __, __, __ [__/__, ___] 10
    -- 225 INT, 299 MAB, 309 M.Acc [44 PDT/34 MDT, 503 M.Eva] 107 SIRD

    -- main="Mpaca's Staff",          -- 20, 65, 55 [__/__, ___] __; R30
    -- legs="Agwu's Slops",           -- 54, 60, 55 [10/10, 134] __; R30
    -- feet="Agwu's Pigaches",        -- 30, 60, 55 [__/__, 134] 10; R30
    -- neck="Null Loop",              -- __, __, 50 [ 5/ 5, ___] __; Once you have agwu feet R30
    -- ear2="Arbatel earring +2"      -- 15,  9, 20 [__/__, ___] __
    -- 247 INT, 315 MAB, 391 M.Acc [44 PDT/34 MDT, 503 M.Eva] 102 SIRD
  }

  -- Cap SubtleBlow and DT. Minimize INT/MAB/M.Acc to maybe hit 0 dmg, which feeds 0 TP.
  -- TODO: Needs testing to see if you can hit 0 dmg on these spells. If you can't, increase the MAB/m.acc.
  sets.Immanence.SubtleBlow = {
    main="Malignance Pole",           -- __, __, __ [20/20, ___] __
    sub="",
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___] __; Resists
    -- head="Lenore's Hairpin",       -- __, __, __ [__/__, ___]  9
    -- body="Adamantite Armor",       -- 38, __, 40 [20/20, 107] __
    hands=gear.Telchine_ENH_hands,    -- 17, __, __ [__/__,  62] __
    legs="Pinga Pants +1",            -- 44, __, __ [__/__, 147] __; Alt is Assiduity Pants +1
    feet=gear.Telchine_ENH_feet,      -- 17, __, __ [__/__, 132] __
    neck="Bathy Choker +1",           -- __, __, __ [__/__, ___] 11
    ear1="Arete Del Luna +1",         -- __, __, __ [__/__, ___] __; Resists
    ear2="Digni. Earring",            -- __, __, 10 [__/__, ___]  5
    ring1="Chirich Ring +1",          -- __, __, __ [__/__, ___] 10
    ring2="Chirich Ring +1",          -- __, __, __ [__/__, ___] 10
    back=gear.SCH_FC_Cape,            -- __, __, __ [10/__,  30] __
    -- waist="Nusku's Sash",          -- __, __, __ [__/__, ___]  5; Alt is Ninurta's Sash
    -- 116 INT, 0 MAB, 50 M.Acc [53 PDT/43 MDT, 478 M.Eva] 50 Subtle Blow
  }

  sets.buff['Ebullience'] = {
    head="Arbatel Bonnet +3",
  }
  sets.buff['Rapture'] = {
    head="Arbatel Bonnet +3",
  }
  sets.buff['Perpetuance'] = {
    hands="Arbatel Bracers +3",
  }
  sets.buff['Penury'] = {
    legs="Arbatel Pants +3",
  }
  sets.buff['Parsimony'] = {
    legs="Arbatel Pants +3",
  }
  sets.buff['Celerity'] = {
    feet="Pedagogy Loafers +3",
  }
  sets.buff['Alacrity'] = {
    feet="Pedagogy Loafers +3",
  }
  sets.buff['Klimaform'] = {
    feet="Arbatel Loafers +3",
  }
  sets.buff.Doom = {
    neck="Nicander's Necklace",     --20
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Automatically use Enlightenment for spells when it's available
function filtered_action(spell, action, spellMap, eventArgs)
  if ((addendum_white_spells:contains(spell.english) and not buffactive['White Addendum'])
      or (addendum_black_spells:contains(spell.english) and not buffactive['Black Addendum']))
    and player.merits.enlightenment > 0
    and not buffactive['Enlightenment']
  then
    local allRecasts = windower.ffxi.get_ability_recasts()
    local enlightenmentCooldown = allRecasts[235]

    if enlightenmentCooldown < 1 then
      cancel_spell()
      send_command('input /ja "Enlightenment" <me>')
      send_command:schedule(1.1, 'input /ma "'..spell.english..'"'..spell.target.raw)
    else
      add_to_chat(123, 'Wrong addendum. Enlightenment is on cooldown.')
    end
  end
end

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  -- If targeting self with Caper, cancel spell
  if spell.english == 'Caper Emissarius' and spell.target.type == 'SELF' then
    add_to_chat(167, 'Cancelling Caper Emissarius due to targeting self.')
    eventArgs.cancel = true
  elseif spell.english == 'Addendum: White' and not state.Buff['Light Arts'] then
    send_command('input /ja "Light Arts" <me>')
    eventArgs.cancel = true
  elseif spell.english == 'Addendum: Dark' and not state.Buff['Dark Arts'] then
    send_command('input /ja "Dark Arts" <me>')
    eventArgs.cancel = true
  elseif spell.english:startswith('Aspir') then
    refine_various_spells(spell, action, spellMap, eventArgs)
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    equip({main="", sub=""})
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  if state.PhysicalDefenseMode.current == 'CaitSith' and state.DefenseMode.current ~= 'None' then
    equip(sets.CaitSith)
  end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.action_type == 'Magic' then
    if spellMap == 'Helix' then
      eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      if spell.english:startswith('Lumino') then
        equip(sets.midcast.LightHelix)
      elseif spell.english:startswith('Nocto') then
        equip(sets.midcast.DarkHelix)
      else
        equip(sets.midcast.Helix)
      end
      if state.HelixMode.value == 'Duration' then
        equip(sets.Bookworm)
      end
    else
      local customEquipSet = select_specific_set(sets.midcast, spell, spellMap)
      -- Add optional casting mode
      if customEquipSet[state.CastingMode.current] then
        customEquipSet = customEquipSet[state.CastingMode.current]
      end

      if spell.type == 'WhiteMagic' and (state.Buff['Light Arts'] or state.Buff['Addendum: White']) then
        if customEquipSet['Grimoire'] then
          equip(customEquipSet['Grimoire'])
          eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
        elseif customEquipSet['LightArts'] then
          equip(customEquipSet['LightArts'])
          eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
        end
      elseif spell.type == 'BlackMagic' and (state.Buff['Dark Arts'] or state.Buff['Addendum: Black']) then
        -- Add Grimoire set if exists
        if customEquipSet['Grimoire'] then
          equip(customEquipSet['Grimoire'])
          eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
        elseif customEquipSet['DarkArts'] then
          equip(customEquipSet['DarkArts'])
          eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
        end
      end

      -- Add magic burst set if exists
      if state.MagicBurst.value and (spell.english == 'Kaustra' or spell.skill == 'Elemental Magic') and customEquipSet['MB'] then
        equip(customEquipSet['MB'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      end
    end
  end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.skill == 'Enhancing Magic' then
    if classes.EnhancingDurSpells:contains(spell.english) and sets.midcast.EnhancingDuration then
      equip(sets.midcast.EnhancingDuration)
    end
    -- If self targeted refresh
    if spellMap == 'Refresh' and spell.targets.Self and sets.midcast.RefreshSelf then
      equip(sets.midcast.RefreshSelf)
    end
    if spellMap == 'Regen' and state.RegenMode.value == 'Duration' and sets.midcast.RegenDuration then
      equip(sets.midcast.RegenDuration)
    end
    if spellMap == 'Storm' and player.merits.stormsurge > 0 and sets.midcast.Stormsurge then
      equip(sets.midcast.Stormsurge)
    end
  end

  if spell.action_type == 'Magic' then
    apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
  end

  -- Always put this last in job_post_midcast
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
  end
  
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  if state.PhysicalDefenseMode.current == 'CaitSith' and state.DefenseMode.current ~= 'None' then
    equip(sets.CaitSith)
  end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  -- Remove temporary lock on elemental belt swaps
  tempDisableElementalBelt = false

  if not spell.interrupted then
    if in_battle_mode() and spell.english == 'Dispelga' then
      equip(select_weapons())
    end
    
    if spell.english == "Sleep II" then
      send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
      send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
    elseif spell.english == "Break" then
      send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
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
    equip(select_weapons())
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
  if buff == "Sublimation: Activated" then
    handle_equipping_gear(player.status)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_active_strategems()
  update_sublimation()
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
      if spell.english:startswith('Dia') then
        return 'Dia'
      elseif spell.type == 'WhiteMagic' or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
        return 'MndEnfeebles'
      else
        return 'IntEnfeebles'
      end
    end
  end
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

  return idleSet
end

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

  if in_battle_mode() then
    meleeSet = set_combine(meleeSet, select_weapons())
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

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  if in_battle_mode() then
    defenseSet = set_combine(defenseSet, select_weapons())
  end

  if state.PhysicalDefenseMode.current == 'CaitSith' then
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

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

  local c_msg = state.CastingMode.value

  local h_msg = state.HelixMode.value

  local r_msg = state.RegenMode.value

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

  add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Reset the state vars tracking strategems.
function update_active_strategems()
  state.Buff['Ebullience'] = buffactive['Ebullience'] or false
  state.Buff['Rapture'] = buffactive['Rapture'] or false
  state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
  state.Buff['Immanence'] = buffactive['Immanence'] or false
  state.Buff['Penury'] = buffactive['Penury'] or false
  state.Buff['Parsimony'] = buffactive['Parsimony'] or false
  state.Buff['Celerity'] = buffactive['Celerity'] or false
  state.Buff['Alacrity'] = buffactive['Alacrity'] or false
  state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
  state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
  if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
    equip(sets.buff['Perpetuance'])
  end
  if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
    equip(sets.buff['Rapture'])
  end
  if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
    if state.Buff.Ebullience and spell.english ~= 'Impact' then
      equip(sets.buff['Ebullience'])
    end
    if state.Buff.Immanence then
      if state.ImmanenceMode.current == 'SIRD' then
        equip(sets.Immanence.SIRD)
      -- Use SubtleBlow set if in SubtleBlow ImmanenceMode and not using tier 2 helix
      elseif state.ImmanenceMode.current == 'SubtleBlow' and not (spellMap == 'Helix' and spell.english:endswith(' II')) then
        -- Temporarily disable elemental belt swaps
        tempDisableElementalBelt = true
        equip(sets.Immanence.SubtleBlow)
      end
    end
    if state.Buff.Klimaform and spell.skill == 'Elemental Magic' and spell.element == world.weather_element then
      equip(sets.buff['Klimaform'])
    end
  end

  if state.Buff.Penury
      and spell.type == 'WhiteMagic'
      and silibs.default_quick_magic_spells['WhiteMagic']:contains(spell.english) then
    equip(sets.buff['Penury'])
  end
  if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
  if state.Buff.Celerity then equip(sets.buff['Celerity']) end
  if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
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

-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
  -- returns recast in seconds.
  local allRecasts = windower.ffxi.get_ability_recasts()
  local stratsRecast = allRecasts[231]

  local maxStrategems = (player.main_job_level + 10) / 20

  local fullRechargeTime = 4*60

  local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

  return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
  local newSpell = spell.english
  local spell_recasts = windower.ffxi.get_spell_recasts()
  local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

  local spell_index

  if spell_recasts[spell.recast_id] > 0 then
    if spell.name:startswith('Aspir') then
      spell_index = table.find(degrade_array['Aspirs'],spell.name)
      if spell_index > 1 then
        newSpell = degrade_array['Aspirs'][spell_index - 1]
        send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
        eventArgs.cancel = true
      end
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
  set_macro_page(1, 19)
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
