--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: Shortcuts
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable RollTracker


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Casting Mode: Changes casting type
  * NirvAM: Turn this mode on to lock your weapon to Nirvana and maintain your Aftermath buff.
* Offense Mode: Changes melee accuracy level
  * Acc: Uses set variants with higher accuracy for engaged sets.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your cure potency and damage output
* CP Mode: Equips Capacity Points bonus cape
* Storm: Cycle that sets the storm to use with your custom command `//gs c storm`

Weapons
* No logic is included for SMN to use melee sets.

Abilities
* Blood Pact keybinds are set up by category and the exact ability used will depend on which avatar you have summoned.
* Attempting to use a Blood Pact when you have no pet summoned will automatically summon your previous pet instead.
  You'll have to re-issue the Blood Pact command after it is alive again to have it perform the ability.
* If you attempt to use a Blood Pact that requires an enemy for a target but you are targeting no one or a friendly,
  then it will automatically cast the ability on your last Blood Pact target instead.
* Sets for Blood Pacts are divided by type: physical rage, magical rage, hybrid rage, buff, debuff.
* After issuing a Blood Pact command, your gear will remain locked until the ability finishes. This is because there
  is sometimes a delay between issuing the command and the command going off, maybe pet has to move into range or
  some other reason. In this interim you need to be wearing the Blood Pact midcast set.
  * Any spells you cast during this time will be canceled because otherwise they would be casted in this Blood Pact
    set that you're locked into so the potency of your spell would be terrible. To avoid wasting your time and resources
    you will simply not be allowed to cast spells until the pet is finished with its action.
  * To avoid issues such as dropped packets or your pet getting interrupted (slept, stunned, killed, etc) there is a
    3 second timeout. After 3 seconds, you will no longer be locked into the pet midcast set. This lock releases sooner
    in the normal case where the pet finished the ability and you didn't lose packets.
* While Astral Conduit is active, you will be locked into pet midcast sets, with the assumption that you're going to
  be spamming it. Also skips the precast set since there is no Blood Pact cooldown under Astral Conduit.

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
* I have made a conscious choice to prioritize a little more defensive stats for survivability in some sets instead
  of solely highest potency.


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
  ============ /SCH ============
  [ CTRL+PageUp ]       Cycle Storm
  [ CTRL+PageDown]      Cycleback Storm
  [ ALT+PageDown ]      Reset Storm cycle

Spells:
  ============ /SCH ============
  [ ALT+C ]             Storm
  [ ALT+/ ]             Klimaform
  [ ALT+U ]             Blink
  [ ALT+I ]             Stoneskin
  [ ALT+P ]             Aquaveil
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
  [ ALT+Q ]             Assault
  [ ALT+w ]             Retreat
  [ ALT+` ]             Release
  [ ALT+R ]             Avatar's Favor
  [ CTRL+Numlock ]      Blood Pact: Lv 99
  [ ALT+Numlock ]       Blood Pact: Astral Flow
  [ CTRL+Numpad/ ]      Blood Pact: Lv 75-80 Merit
  [ CTRL+Numpad* ]      Blood Pact: Lv 70
  [ CTRL+Numpad- ]      Blood Pact: Extra
  [ ALT+Z ]             Blood Pact: Debuff 1
  [ ALT+X ]             Blood Pact: Debuff 2
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

gs c storm              Uses storm that is selected in the Storm state cycle.

gs c siphon             Automatically run the process to: dismiss the current avatar; cast appropriate
                        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
                        and re-summon the avatar.
                        Will not cast weather you do not have access to.
                        Will not re-summon the avatar if one was not out in the first place.
                        Will not release the spirit if it was out before the command was issued.

gs c pact [PactType]    Attempts to use the indicated pact type for the current avatar.
                        PactType can be one of:
                          cure
                          curaga
                          bpextra
                          buffOffense
                          buffDefense
                          buffSpecial
                          buffSpecial2
                          debuff1
                          debuff2
                          sleep
                          nuke2
                          nuke4
                          bp70
                          bp75 (merits and lvl 75-80 pacts)
                          bp99
                          astralflow

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] BuffSP1        /console gs c pact buffSpecial
[ CTRL+2 ] BuffSP2        /console gs c pact buffSpecial2
[ CTRL+3 ] ManaCede       /ja "Mana Cede" <me>
[ CTRL+4 ] Cure4          /ma "Cure IV" <stpc>
[ CTRL+7 ] nuke2          /console gs c pact nuke2
[ CTRL+8 ] nuke4          /console gs c pact nuke4
[ CTRL+9 ] AstFlow        /ja "Astral Flow" <me>
[ CTRL+0 ] Sleep          /console gs c pact sleep
[ ALT+1 ]  BuffDef        /console gs c pact buffDefense
[ ALT+2 ]  BuffOff        /console gs c pact buffOffense
[ ALT+3 ]  CurePact       /console gs c pact cure
[ ALT+4 ]  CuragaPa       /console gs c pact curaga
[ ALT+5 ]  Dia2           /ma "Dia II" <t>
[ ALT+6 ]  Raise          /ma "Raise" <stpc>
[ ALT+7 ]  Reraise        /ma "Reraise" <me>
[ ALT+8 ]  Apogee         /ja "Apogee" <me>
[ ALT+9 ]  AstCondu       /ja "Astral Conduit" <me>
[ ALT+0 ]  Siphon         /console gs c siphon

]]--


-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  equip({main=empty,sub=empty})
  
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(15)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.CP = M(false, 'Capacity Points Mode')
  state.Storm = M{['description']='Storm','Aurorastorm','Sandstorm',
      'Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Voidstorm'}
  state.OffenseMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'NirvAM')
  state.IdleMode:options('Normal')

  state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
  state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

  spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
  avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}

  magicalRagePacts = S{
      'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
      'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
      'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
      'Thunderspark','Burning Strike','Meteorite','Nether Blast', 'Flaming Crush',
      'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
      'Holy Mist','Lunar Bay','Night Terror','Level ? Holy'}

  hybridRagePacts = S{'Flaming Crush'}

  pacts = {}
  pacts.cure = {['Carbuncle']='Healing Ruby'}
  pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
  pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
      ['Fenrir']='Ecliptic Growl'}
  pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
      ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
  pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
      ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
  pacts.buffspecial2 = {['Carbuncle']='Pacifying Ruby',['Leviathan']='Soothing Current',['Shiva']='Crystal Blessing'}
  pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
      ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
  pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
  pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
  pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
      ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
  pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
      ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
  pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
      ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
      ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
  pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
      ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
      ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
  pacts.bp99 = {['Ifrit']='Conflag Strike',['Titan']='Crag Throw',['Ramuh']='Volt Strike', ['Siren']='Hysteric Assault'}
  pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
      ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
      ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}
  pacts.bpextra = {['Ramuh']='Thunderspark'}

  -- Wards table for creating custom timers
  wards = {}
  -- Base duration for ward pacts.
  wards.durations = {
      ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
      ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120, ['Shining Ruby'] = 180, ['Frost Armor'] = 180,
      ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180, ['Glittering Ruby'] = 180, ['Hastega II'] = 180,
      ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180, ['Dream Shroud'] = 180, ['Reraise II'] = 3600
  }
  -- Icons to use when creating the custom timer.
  wards.icons = {
      ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
      ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
      ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
      ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
      ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
      ['Hastega II']      = 'spells/00358.png', -- 00358 for Hastega
      ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
      ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
      ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
      ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
      ['Fleet Wind']      = 'abilities/00074.png', -- 
  }
  -- Flags for code to get around the issue of slow skill updates.
  wards.flag = false
  wards.spell = ''

  latestAvatar = pet.name or nil -- DO NOT MODIFY
  last_pet_midcast_set = {} -- DO NOT MODIFY
  last_pet_midaction_time = 0 -- DO NOT MODIFY

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['@c'] = 'gs c toggle CP',
      ['!`'] = 'input /ja "Release" <me>',
      ['!q'] = 'input /ja "Assault" <t>',
      ['!w'] = 'input /ja "Retreat" <me>',
      ['!a'] = 'input /ja "Avatar\'s Favor" <me>',
      ['!z'] = 'gs c pact debuff1',
      ['!x'] = 'gs c pact debuff2',
      ['^numlock'] = 'gs c pact bp99',
      ['!numlock'] = 'gs c pact astralflow',
      ['^numpad/'] = 'gs c pact bp75',
      ['^numpad*'] = 'gs c pact bp70',
      ['^numpad-'] = 'gs c pact bpextra',
    },
    ['SCH'] = {
      ['^pageup'] = 'gs c cycleback Storm',
      ['^pagedown'] = 'gs c cycle Storm',
      ['!pagedown'] = 'gs c reset Storm',
      ['!r'] = 'input /ja "Sublimation" <me>',
      ['^-'] = 'gs c scholar light',
      ['^='] = 'gs c scholar dark',
      ['^['] = 'gs c scholar power',
      ['^\\\\'] = 'gs c scholar cost',
      ['!['] = 'gs c scholar aoe',
      ['!\\\\'] = 'gs c scholar speed',
      ['!c'] = 'gs c storm',
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
      ['!e'] = 'input /ma "Haste" <tpc>',
      ['!u'] = 'input /ma "Blink" <me>',
      ['!i'] = 'input /ma "Stoneskin" <me>',
      ['!p'] = 'input /ma "Aquaveil" <me>',
    },
  }

  set_main_keybinds:schedule(2)
end

-- Executes on first load, main job change, **and sub job change**
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


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- With no pet out, don't need perp cost. Focus defensive stats and Refresh
  sets.idle = {
    main="Mpaca's Staff",           -- ____ [__/__, ___] ( 2, __) {___, __, __/__}
    sub="Khonsu",                   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    ammo="Staunch Tathlum +1",      -- ____ [ 3/ 3, ___] (__, __) {___, __, __/__}; Resist Status+11
    head="Beckoner's Horn +3",      --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    body=gear.Apogee_A_body,        -- -160 [__/__,  91] ( 4, __) {___, __, __/__}
    hands="Asteria Mitts +1",       --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Loricate Torque +1",      -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}; DEF+60
    ear1="Cath Palug Earring",      -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    back=gear.SMN_Phys_BP_Cape,     -- ____ [10/__, ___] (__, __) {  1, __, __/__}; Pet Haste+10
    waist="Regal Belt",             --   88 [ 3/ 3, ___] (__, __) {___, __, __/__}
    -- Traits/Merits/JP Gifts                                       99, __,  7/ 7
    -- 80 HP [52 PDT/42 MDT, 510 M.Eva] (21 Refresh, 3 Perp Cost) {Pet: 101 Lv, 0 Regain, 7 PDT/7 MDT}

    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- 80 HP [54 PDT/44 MDT, 510 M.Eva] (22 Refresh, 3 Perp Cost) {Pet: 101 Lv, Regain, 7 PDT/7 MDT}
  }

  -- perp costs:
  -- spirits: 7
  -- carby: 11 (5 with mitts)
  -- fenrir: 13
  -- others: 15
  -- avatar's favor: -4/tick

  -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
  -- Aim for -14 perp, and refresh in other slots.

  -- Need -14 perp cost
  sets.idle.Avatar = {
    main="Gridarvor",               -- ____ [__/__, ___] (__,  5) {___, __, __/__}
    sub="Khonsu",                   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    ammo="Epitaph",                 -- ____ [__/__, ___] (__, __) {119, __, __/__}
    head="Beckoner's Horn +3",      --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    body="Beckoner's Doublet +2",   --   74 [12/12, 120] (__,  7) {___, __, __/__}
    hands="Asteria Mitts +1",       --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Caller's Pendant",        -- ____ [__/__, ___] (__, __) {___, 25, __/__}
    ear1="Enmerkar Earring",        -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    back=gear.SMN_Phys_BP_Cape,     -- ____ [10/__, ___] (__, __) {  1, __, __/__}; Pet Haste+10
    waist="Isa Belt",               -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    -- Traits/Merits/JP Gifts                                      ___, __,  7/ 7
    -- 226 HP [52 PDT/42 MDT, 539 M.Eva] (14 Refresh, 15 Perp Cost) {Pet: 121 Lv, 25 Regain, 13 PDT/13 MDT}

    -- body="Beckoner's Doublet +3",--   84 [13/13, 130] (__,  8) {___, __, __/__}
    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- 236 HP [55 PDT/45 MDT, 549 M.Eva] (15 Refresh, 16 Perp Cost) {Pet: 121 Lv, 25 Regain, 13 PDT/13 MDT}
  }
  -- Used when avatar is engaged with an enemy
  sets.idle.Avatar.Melee = set_combine(sets.idle.Avatar, {
    waist="Klouskap Sash +1", -- Pet Haste+9
  })

  -- Need -6 perp cost
  sets.idle.Spirit = {
    main="Gridarvor",               -- ____ [__/__, ___] (__,  5) {___, __, __/__}
    sub="Khonsu",                   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    ammo="Epitaph",                 -- ____ [__/__, ___] (__, __) {119, __, __/__}
    head="Beckoner's Horn +3",      --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    body=gear.Apogee_A_body,        -- -160 [__/__,  91] ( 4, __) {___, __, __/__}
    hands="Asteria Mitts +1",       --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Loricate Torque +1",      -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}; DEF+60
    ear1="Cath Palug Earring",      -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    back=gear.SMN_Phys_BP_Cape,     -- ____ [10/__, ___] (__, __) {  1, __, __/__}; Pet Haste+10
    waist="Regal Belt",             --   88 [ 3/ 3, ___] (__, __) {___, __, __/__}
    -- Traits/Merits/JP Gifts                                      ___, __,  7/ 7
    -- 80 HP [49 PDT/39 MDT, 510 M.Eva] (19 Refresh, 8 Perp Cost) {Pet: 121 Lv, 0 Regain, 7 PDT/7 MDT}

    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- 80 HP [51 PDT/41 MDT, 510 M.Eva] (20 Refresh, 8 Perp Cost) {Pet: 121 Lv, 0 Regain, 7 PDT/7 MDT}
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Astral Flow'] = {
    head="Glyphic Horn", -- Duration +30s; +1 is acceptable
  }

  -- MP Siphoned = (Summoning Skill - 50 + Base Siphon Equipment) * (1.0 + Weather/Day bonuses)
  -- Hachirin-no-obi has no effect; day/weather bonuses always apply.
  -- Day/weather muliplier caps at 1.4.
  sets.precast.JA['Elemental Siphon'] = {
    main="Chatoyant Staff",             -- __, __, 10 [__/__, ___]
    sub="Khonsu",                       -- __, __, __ [ 6/ 6, ___]
    ammo="Esper Stone +1",              -- 20, __, __ [__/__, ___]
    head="Beckoner's Horn +3",          -- __, 23, __ [10/10, 130]
    body="Beckoner's Doublet +2",       -- __, 19, __ [12/12, 120]
    hands="Baayami Cuffs +1",           -- __, 33, __ [__/__,  93]
    legs="Beckoner's Spats +2",         -- __, 25, __ [11/11, 147]
    feet="Beckoner's Pigaches +2",      -- 70, __, __ [__/__, 158]
    neck="Incanter's Torque",           -- __, 10, __ [__/__, ___]
    ear1="Lodurr Earring",              -- __, 10, __ [__/__, ___]
    ear2="Cath Palug Earring",          -- __,  5, __ [__/__, ___]
    ring1="Stikini Ring +1",            -- __,  8, __ [__/__, ___]
    ring2="Defending Ring",             -- __, __, __ [10/10, ___]
    back="Twilight Cape",               -- __, __,  5 [__/__, ___]
    waist="Ligeia Sash",                -- 10, __, __ [__/__, ___]
    -- Traits/Merits/Gifts                 60,469, __ [__/__, ___]
    -- Assume minimum day/weather          __, __, 10
    -- 160 Base Siphon, 602 Summoning Skill, 25 Siphon Multiplier [49 PDT/49 MDT, 648 M.Eva]
    -- MP Siphoned = 883 to 989 (depending on day/weather)
    
    -- body="Beckoner's Doublet +3",    -- __, 24, __ [13/13, 130]
    -- legs="Beckoner's Spats +3",      -- __, 30, __ [12/12, 157]
    -- feet="Beckoner's Pigaches +3",   -- 80, __, __ [__/__, 168]
    -- 170 Base Siphon, 612 Summoning Skill, 25 Siphon Multiplier [51 PDT/51 MDT, 678 M.Eva]
    -- MP Siphoned = 915 to 1024 (depending on day/weather)
  }
  sets.precast.JA['Elemental Siphon'].NirvAM = {
    main="Nirvana",                     -- __, __, __ [__/__, ___]
    sub="Elan Strap +1",                -- __, __, __ [__/__, ___]
    ammo="Esper Stone +1",              -- 20, __, __ [__/__, ___]
    head="Beckoner's Horn +3",          -- __, 23, __ [10/10, 130]
    body="Beckoner's Doublet +2",       -- __, 19, __ [12/12, 120]
    hands="Baayami Cuffs +1",           -- __, 33, __ [__/__,  93]
    legs="Beckoner's Spats +2",         -- __, 25, __ [11/11, 147]
    feet="Beckoner's Pigaches +2",      -- 70, __, __ [__/__, 158]
    neck="Incanter's Torque",           -- __, 10, __ [__/__, ___]
    ear1="Lodurr Earring",              -- __, 10, __ [__/__, ___]
    ear2="Beckoner's Earring +1",       -- __, __, __ [ 4/ 4, ___]
    ring1="Stikini Ring +1",            -- __,  8, __ [__/__, ___]
    ring2="Defending Ring",             -- __, __, __ [10/10, ___]
    back="Twilight Cape",               -- __, __,  5 [__/__, ___]
    waist="Ligeia Sash",                -- 10, __, __ [__/__, ___]
    -- Traits/Merits/Gifts                 60,469, __ [__/__, ___]
    -- Assume minimum day/weather          __, __, 10
    -- 160 Base Siphon, 597 Summoning Skill, 15 Weather Multiplier [47 PDT/47 MDT, 648 M.Eva]
    -- MP Siphoned = 807 to 982 (depending on day/weather)
    
    -- body="Beckoner's Doublet +3",    -- __, 24, __ [13/13, 130]
    -- legs="Beckoner's Spats +3",      -- __, 30, __ [12/12, 157]
    -- feet="Beckoner's Pigaches +3",   -- 80, __, __ [__/__, 168]
    -- 170 Base Siphon, 607 Summoning Skill, 15 Weather Multiplier [49 PDT/49 MDT, 678 M.Eva]
    -- MP Siphoned = 836 to 1017 (depending on day/weather)
  }

  sets.precast.JA['Mana Cede'] = {
    -- hands="Caller's Bracers +2", -- Base hands + JP gifts cap out this effect; no need to upgrade
  }

  -- Pact delay reduction gear: summoning skill, -BP Delay, -BP Delay II
  -- Caps: summoning skill @670, -BP Delay @15, -BP Delay II @15, -BP Delay Total @30 (including the 10s from gifts)
  sets.precast.BloodPactWard = {
    main="Malignance Pole",         -- __, __, __, __ [20/20, ___]
    sub="Vox Grip",                 --  3, __, __, __ [__/__, ___]
    ammo="Epitaph",                 -- __, __,  5, __ [__/__, ___]
    head="Beckoner's Horn +3",      -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    body="Beckoner's Doublet +2",   -- 19, __, __, __ [12/12, 120]
    hands="Baayami Cuffs +1",       -- 33,  7, __, __ [__/__,  93]
    legs="Baayami Slops +1",        -- 35,  8, __, __ [__/__, 139]
    feet="Baayami Sabots +1",       -- 29, __, __, __ [__/__, 139]
    neck="Incanter's Torque",       -- 10, __, __, __ [__/__, ___]
    ear1="Lodurr Earring",          -- 10, __, __, __ [__/__, ___]
    ear2="Cath Palug Earring",      --  5, __, __, __ [__/__, ___]
    ring1="Evoker's Ring",          -- 10, __, __, __ [__/__, ___]
    ring2="Stikini Ring +1",        --  8, __, __, __ [__/__, ___]
    back=gear.SMN_Skill_Cape,       --  8, __,  2, __ [__/__, ___]
    waist="Kobo Obi",               --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- Master Levels                    2
    -- 672 Summon Skill, 15 -BP Delay, 7 -BP Delay II, 10 -BP Delay III [42 PDT/42 MDT, 621 M.Eva]
    
    -- body="Beckoner's Doublet +3",-- 24, __, __, __ [13/13, 130]
    -- back=gear.SMN_FC_Cape,       -- __, __, __, __ [10/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- Master Levels                    3
    -- 670 Summon Skill, 15 -BP Delay, 5 -BP Delay II, 10 -BP Delay III [53 PDT/43 MDT, 631 M.Eva]
  }
  sets.precast.BloodPactRage = set_combine(sets.precast.BloodPactWard, {})

  sets.precast.BloodPactWard.NirvAM = {
    main="Nirvana",                 -- __, __, __, __ [__/__, ___]
    sub="Elan Strap +1",            -- __, __, __, __ [__/__, ___]
    ammo="Epitaph",                 -- __, __,  5, __ [__/__, ___]
    head="Beckoner's Horn +3",      -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    body="Beckoner's Doublet +2",   -- 19, __, __, __ [12/12, 120]
    hands="Baayami Cuffs +1",       -- 33,  7, __, __ [__/__,  93]
    legs="Baayami Slops +1",        -- 35,  8, __, __ [__/__, 139]
    feet="Baayami Sabots +1",       -- 29, __, __, __ [__/__, 139]
    neck="Incanter's Torque",       -- 10, __, __, __ [__/__, ___]
    ear1="Lodurr Earring",          -- 10, __, __, __ [__/__, ___]
    ear2="Cath Palug Earring",      --  5, __, __, __ [__/__, ___]
    ring1="Evoker's Ring",          -- 10, __, __, __ [__/__, ___]
    ring2="Stikini Ring +1",        --  8, __, __, __ [__/__, ___]
    back=gear.SMN_Skill_Cape,       --  8, __,  2, __ [__/__, ___]
    waist="Kobo Obi",               --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- 667 Summon Skill, 15 -BP Delay, 7 -BP Delay II, 10 -BP Delay III [22 PDT/22 MDT, 621 M.Eva]

    -- body="Beckoner's Doublet +3",-- 24, __, __, __ [13/13, 130]
    -- 672 Summon Skill, 15 -BP Delay, 7 -BP Delay II, 10 -BP Delay III [23 PDT/23 MDT, 631 M.Eva]

    -- ring2="Defending Ring",      -- __, __, __, __ [10/10, ___]
    -- back=gear.SMN_FC_Cape,       -- __, __, __, __ [10/__, ___]
    -- Master Levels                   14
    -- 670 Summon Skill, 15 -BP Delay, 5 -BP Delay II, 10 -BP Delay III [43 PDT/33 MDT, 631 M.Eva]
  }
  sets.precast.BloodPactRage.NirvAM = set_combine(sets.precast.BloodPactWard.NirvAM, {})


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Shinjutsu-no-obi +1",      --  5 [__/__, ___]
    -- 81 Fast Cast [55 PDT/43 MDT, 428 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- 81 Fast Cast [55 PDT/53 MDT, 570 M.Eva]
  }
  sets.precast.FC.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- 78 Fast Cast [48 PDT/36 MDT, 509 M.Eva] 7 Quick Magic
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- 79 Fast Cast [48 PDT/36 MDT, 533 M.Eva] 7 Quick Magic
  }
  
  sets.precast.FC.RDM = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet="Beckoner's Pigaches +2",    -- __ [__/__, 158]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Shinjutsu-no-obi +1",      --  5 [__/__, ___]
    -- RDM Trait                         15
    -- 84 Fast Cast [55 PDT/43 MDT, 586 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- feet="Beckoner's Pigaches +3", -- __ [__/__, 168]
    -- 85 Fast Cast [55 PDT/43 MDT, 620 M.Eva]
  }
  sets.precast.FC.QuickMagic.RDM = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head=gear.Merl_FC_head,           -- 15 [__/__,  86]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs="Beckoner's Spats +2",       -- __ [11/11, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Perimede Cape",             -- __ [__/__, ___]  4
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- RDM Trait                         15
    -- 80 Fast Cast [49 PDT/47 MDT, 538 M.Eva] 9 Quick Magic
    
    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- 80 Fast Cast [50 PDT/48 MDT, 548 M.Eva] 9 Quick Magic
  }
  
  -- Fast cast sets for spells
  sets.precast.FC.NirvAM = {
    main="Nirvana",                   -- __ [__/__, ___]
    sub="Elan Strap +1",              -- __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Shinjutsu-no-obi +1",      --  5 [__/__, ___]
    -- 79 Fast Cast [32 PDT/20 MDT, 546 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- 80 Fast Cast [32 PDT/20 MDT, 570 M.Eva]
  }
  sets.precast.FC.NirvAM.QuickMagic = {
    main="Nirvana",                   -- __ [__/__, ___]
    sub="Elan Strap +1",              -- __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Witful Belt",              --  3 [__/__, ___] 3
    -- 77 Fast Cast [32 PDT/20 MDT, 546 M.Eva] 3 Quick Magic

    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- 78 Fast Cast [32 PDT/20 MDT, 570 M.Eva] 3 Quick Magic
  }

  sets.precast.FC.NirvAM.RDM = {
    main="Nirvana",                   -- __ [__/__, ___]
    sub="Elan Strap +1",              -- __ [__/__, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs="Beckoner's Spats +2",       -- __ [11/11, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Regal Belt",               -- __ [ 3/ 3, ___]
    -- RDM Trait                         15
    -- 80 Fast Cast [50 PDT/30 MDT, 575 M.Eva]
    
    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- 80 Fast Cast [51 PDT/31 MDT, 585 M.Eva]
  }
  sets.precast.FC.NirvAM.QuickMagic.RDM = {
    main="Nirvana",                   -- __ [__/__, ___]
    sub="Elan Strap +1",              -- __ [__/__, ___]
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs="Beckoner's Spats +2",       -- __ [11/11, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- RDM Trait                         15
    -- 81 Fast Cast [47 PDT/27 MDT, 575 M.Eva] 5 Quick Magic

    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- 81 Fast Cast [48 PDT/28 MDT, 585 M.Eva] 5 Quick Magic
  }

  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",                  -- __ [__/__, ___]
    sub="Genmei Shield",              -- __ [10/__, ___]    
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_FC_Cape,            -- 10 [10/__, ___]
    waist="Shinjutsu-no-obi +1",      --  5 [__/__, ___]
    -- 75 Fast Cast [49 PDT/19 MDT, 546 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- 76 Fast Cast [49 PDT/19 MDT, 570 M.Eva]
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    -- neck="Fotia Gorget",
    -- ear1="Telos Earring",
    ear2="Moonshade Earring",
    ring1="Ephramad's Ring",
    ring2="Epaminondas's Ring",
    back="Aurist's Cape +1",
    -- waist="Fotia Belt",
  }

  -- Only affected by TP Bonus, cap out DT
  sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
  })

  sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Baetyl Pendant",
    ear1="Malignance Earring",
    ear2="Novio Earring",
    ring1="Epaminondas's Ring",
    ring2="Metamorph Ring +1",
    back="Aurist's Cape +1",
    waist="Refoccilation Stone",

    -- neck="Fotia Gorget",
    -- waist="Fotia Belt",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC.NirvAM, {})

  -- Ensure trusts get summoned at max ilvl
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  sets.midcast.Dispelga = set_combine(sets.precast.FC.Dispelga, {})

  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureNormal = {
    main="Daybreak",            -- 30, 30, __, ___ [__/__, ___] __
    sub="Genbu's Shield",       --  5, __, __, ___ [10/__, ___] __
    ammo="Esper Stone +1",      -- __, __, __, ___ [__/__, ___]  5
    head=gear.Vanya_B_head,     -- 10, 27, 18,  20 [__/ 5,  75] __
    body=gear.Vanya_B_body,     -- __, 36, 23,  20 [ 1/ 4,  80] __
    hands="Bunzi's Gloves",     -- __, 52, 26, ___ [ 8/ 8, 112]  8
    legs=gear.Vanya_B_legs,     -- __, 34, 12,  20 [__/__, 107] __
    feet=gear.Vayna_B_feet,     --  5, 19, 10,  40 [__/__, 107] __
    neck="Incanter's Torque",   -- __, __, __,  10 [__/__, ___] __
    ear1="Meili Earring",       -- __, __, __,  10 [__/__, ___] __
    ear2="Mendicant's Earring", --  5, __, __, ___ [__/__, ___] __
    ring1="Sirona's Ring",      -- __,  3,  3,  10 [__/__, ___] __
    ring2="Defending Ring",     -- __, __, __, ___ [10/10, ___] __
    back="Aurist's Cape +1",    -- __, 33, __, ___ [__/__, ___] __
    waist="Luminary Sash",      -- __, 10, __, ___ [__/__, ___] __
    -- Traits/Merits/Gifts         __,101, 89,  16
    -- Subjob                      __, __, __, 139
    -- 55 CP, 345 MND, 181 VIT, 285 Healing Skill [29 PDT/27 MDT, 481 M.Eva] 13 -Enmity
    
    -- main=gear.Gada_MND,      -- 18, 21, __,  18 [__/__, ___] __
    -- back=gear.SMN_Cure_Cape, -- 10, 30, __, ___ [10/__, ___] __
    -- 53 CP, 348 MND, 181 VIT, 303 Healing Skill [39 PDT/27 MDT, 481 M.Eva] 5 -Enmity
    -- 853 HP Cure IV
  }
  sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
    waist="Hachirin-no-obi",
    -- 938 HP to 1151 Cure IV depending on weather/day
  })

  sets.midcast.Stoneskin = {
    ammo="Epitaph",               -- __ [__/__, ___]
    head="Bunzi's Hat",           -- __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,       -- __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,     -- __ [ 7/ 7, 112]
    feet=gear.Nyame_B_feet,       -- __ [ 7/ 7, 150]
    neck="Nodens Gorget",         -- 30 [__/__, ___]
    ear1="Earthcry Earring",      -- 10 [__/__, ___]
    ring1="Gelatinous Ring +1",   -- __ [ 7/-1, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    waist="Siegel Sash",          -- 20 [__/__, ___]
    -- 60 +Stoneskin [47 PDT/39 MDT, 524 M.Eva]

    -- legs="Shedir Seraweels",   -- 35 [__/__, ___]
    -- back=gear.SMN_Cure_Cape,   -- __ [10/__,  20]
    -- 95 +Stoneskin [50 PDT/39 MDT, 544 M.Eva]
  }

  -- TODO: update set
  sets.midcast['Dark Magic'] = {
    -- main="Lehbrailg +2",
    -- sub="Wizzan Grip",
    -- head="Nahtirah Hat",
    -- body="Vanir Cotehardie",
    -- hands="Yaoyotl Gloves",
    -- legs="Bokwus Slops",
    -- feet="Bokwus Boots",
    -- neck="Aesir Torque",
    -- ear1="Lifestorm Earring",
    -- ear2="Psystorm Earring",
    -- ring1="Excelsis Ring",
    -- ring2="Sangoma Ring",
    waist="Fucho-no-Obi",
  }

  sets.midcast.Pet.BloodPactWard = {
    main=gear.Espiritus_B,            -- 15 [__/__, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Epitaph",                   -- __ [__/__, ___]
    head="Beckoner's Horn +3",        -- 23 [10/10, 130]
    body="Beckoner's Doublet +2",     -- 19 [12/12, 120]
    hands="Baayami Cuffs +1",         -- 33 [__/__,  93]
    legs="Beckoner's Spats +2",       -- 25 [11/11, 147]
    feet="Baayami Sabots +1",         -- 29 [__/__, 139]
    neck="Incanter's Torque",         -- 10 [__/__, ___]
    ear1="Lodurr Earring",            -- 10 [__/__, ___]
    ear2="Cath Palug Earring",        --  5 [__/__, ___]
    ring1="Evoker's Ring",            -- 10 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.SMN_Skill_Cape,         -- 13 [__/__, ___]
    waist="Kobo Obi",                 --  8 [__/__, ___]
    -- Traits/Merits/Gifts              469
    -- 669 Summon Skill [49 PDT/49 MDT, 629 M.Eva]
    
    -- body="Beckoner's Doublet +3",  -- 24 [13/13, 130]
    -- legs="Beckoner's Spats +3",    -- 30 [12/12, 157]
    -- 679 Summon Skill [51 PDT/51 MDT, 649 M.Eva]
  }

  -- Need Pet M.Acc, Summoning Skill to land debuffs
  sets.midcast.Pet.DebuffBloodPactWard = {
    main="Nirvana",                   --   2, 30, __ [__/__, ___]
    sub="Vox Grip",                   -- ___, __,  3 [__/__, ___]
    ammo="Epitaph",                   -- 119, 25, __ [__/__, ___]
    head="Beckoner's Horn +3",        -- ___, 61, 23 [10/10, 130]
    body="Beckoner's Doublet +2",     -- ___, 54, 19 [12/12, 120]
    hands="Beckoner's Bracers +2",    -- ___, 52, __ [__/__,  83]
    legs="Beckoner's Spats +2",       -- ___, 53, 25 [11/11, 147]
    feet="Bunzi's Sabots",            --   1, 50, __ [ 6/ 6, 150]; Pet attr+10
    neck="Summoner's Collar +2",      -- ___, 25, __ [ 5/ 5, ___]
    ear1="Enmerkar Earring",          -- ___, 15, __ [__/__, ___]
    ear2="Beckoner's Earring +1",     --   1, 12, __ [ 4/ 4, ___]
    ring1="Evoker's Ring",            -- ___, __, 10 [__/__, ___]
    ring2="Cath Palug Ring",          -- ___, 12, __ [ 5/ 5, ___]
    back=gear.SMN_Magic_BP_Cape,      --   1, 20, __ [10/__,  20]
    waist="Incarnation Sash",         -- ___, 15, __ [__/__, ___]
    -- 124 Pet Lv, 424 Pet M.Acc, 80 Summon Skill [63 PDT/53 MDT, 650 M.Eva]
    
    -- body="Beckoner's Doublet +3",  -- ___, 64, 24 [13/13, 130]
    -- hands="Beckoner's Bracers +3", -- ___, 62, __ [__/__,  93]
    -- legs="Beckoner's Spats +3",    -- ___, 63, 30 [12/12, 157]
    -- ear2="Beckoner's Earring +2",  --   1, 20, __ [ 6/ 6, ___]
    -- 124 Pet Lv, 462 Pet M.Acc, 90 Summon Skill [67 PDT/57 MDT, 680 M.Eva]
  }

  -- TODO: Maybe add more HP
  sets.midcast.Pet.PhysicalBloodPactRage = {
    main="Nirvana",                     --   2, 40 {___, 30, __, __ / __, 30, __, __} [__/__, ___]
    sub="Elan Strap +1",                -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    ammo="Epitaph",                     -- 119, 16 {___, 30, 15, __ / __, 30, 15, __} [__/__, ___]; R20+ before using
    head=gear.Helios_Phys_BP_head,      -- ___,  7 {___, __, __, __ / __, 30, __,  8} [__/__,  75]
    body="Beckoner's Doublet +2",       -- ___, 12 {___, 54, __, __ / __, 54, __, __} [12/12, 120]
    hands=gear.Merl_Phys_BP_hands,      -- ___, 15 {___, 20, __, __ / 40, __, __, __} [__/__,  48]
    legs=gear.Apogee_D_legs,            -- ___, 21 {___, __, __, __ / __, __, 20,  4} [__/__, 118]
    feet=gear.Apogee_B_feet,            -- ___, 10 {___, __, __, __ / 35, __, __, __} [__/__, 118]
    neck="Summoner's Collar +2",        -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    ear1="Lugalbanda Earring",          -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    ear2="Beckoner's Earring +1",       --   1,  4 {___, 12, __, __ / __, 12, __, __} [ 4/ 4, ___]
    ring1="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    ring2="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    back=gear.SMN_Phys_BP_Cape,         --   1,  5 {___, __, __, __ / 20, 30, __, __} [10/__, ___]
    waist="Incarnation Sash",           -- ___, __ {___, 15, __, __ / __, 15, __,  4} [__/__, ___]
    -- 123 Pet Lv, 163 BP Dmg {Pet: 0 MAB, 201 M.Acc, 40 INT, 0 M.Dmg / 95 Att, 261 Acc, 60 STR, 16 DA} [31 PDT/21 MDT, 489 M.Eva]
    
    -- body="Beckoner's Doublet +3",    -- ___, 13 {___, 64, __, __ / __, 64, __, __} [13/13, 130]
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- 123 Pet Lv, 165 BP Dmg {Pet: 0 MAB, 219 M.Acc, 40 INT, 0 M.Dmg / 95 Att, 279 Acc, 60 STR, 16 DA} [34 PDT/24 MDT, 499 M.Eva]
  }

  sets.midcast.Pet.MagicalBloodPactRage = {
    main=gear.Grioavolr_Magic_BP,       -- ___,  9 {140, 54, __, __ / __, __, __, __} [__/__, ___]
    sub="Elan Strap +1",                -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    ammo="Epitaph",                     -- 119, 16 {___, 30, 15, __ / __, 30, 15, __} [__/__, ___]; R20+ before using
    head="Cath Palug Crown",            -- ___, 10 { 38, 38, __, __ / __, 38, __, __} [__/__,  86]
    body="Beckoner's Doublet +2",       -- ___, 12 {___, 54, __, __ / __, 54, __, __} [12/12, 120]
    hands=gear.Merl_Mag_BP_hands,       -- ___, 15 { 39, 15,  9, __ / 20, __, __, __} [__/__,  48]
    legs=gear.Enticer_legs,             -- ___, 12 {___, 12, __, __ / __, __, __, __} [__/__, 107]; Pet TP Bonus
    feet=gear.Apogee_A_feet,            -- ___, 10 { 35, __, __, __ / __, __, __, __} [__/__, 118]
    neck="Summoner's Collar +2",        -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    ear1="Lugalbanda Earring",          -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    ear2="Beckoner's Earring +1",       --   1,  4 {___, 12, __, __ / __, 12, __, __} [ 4/ 4, ___]
    ring1="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    ring2="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    back=gear.SMN_Magic_BP_Cape,        --   1,  5 {___, 20, __, 25 / __, __, __, __} [10/__, ___]
    waist="Regal Belt",                 -- ___, __ { 10, __, __, __ / 20, __, __, __} [ 3/ 3, ___]
    -- 121 Pet Lv, 126 BP Dmg {Pet: 262 MAB, 271 M.Acc, 49 INT, 25 M.Dmg / 40 Att, 194 Acc, 40 STR, 0 DA} [34 PDT/24 MDT, 489 M.Eva]

    -- body="Beckoner's Doublet +3",    -- ___, 13 {___, 64, __, __ / __, 64, __, __} [13/13, 130]
    -- legs=gear.Enticer_legs,          -- ___, 12 {___, 15, __, __ / __, 15, __, __} [__/__, 107]; Pet TP Bonus
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- 121 Pet Lv, 128 BP Dmg {Pet: 262 MAB, 296 M.Acc, 49 INT, 25 M.Dmg / 40 Att, 227 Acc, 40 STR, 0 DA} [37 PDT/27 MDT, 499 M.Eva]
  }

  sets.midcast.Pet.HybridBloodPactRage = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
    main="Nirvana",                     --   2, 40 {___, 30, __, __ / __, 30, __, __} [__/__, ___]
    sub="Elan Strap +1",                -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    ammo="Epitaph",                     -- 119, 16 {___, 30, 15, __ / __, 30, 15, __} [__/__, ___]; R20+ before using
    head="Cath Palug Crown",            -- ___, 10 { 38, 38, __, __ / __, 38, __, __} [__/__,  86]
    body="Beckoner's Doublet +2",       -- ___, 12 {___, 54, __, __ / __, 54, __, __} [12/12, 120]
    hands=gear.Merl_Mag_BP_hands,       -- ___, 15 { 39, 15,  9, __ / 20, __, __, __} [__/__,  48]
    legs=gear.Enticer_legs,             -- ___, 12 {___, 12, __, __ / __, __, __, __} [__/__, 107]; Pet TP Bonus
    feet=gear.Apogee_A_feet,            -- ___, 10 { 35, __, __, __ / __, __, __, __} [__/__, 118]
    neck="Summoner's Collar +2",        -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    ear1="Lugalbanda Earring",          -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    ear2="Beckoner's Earring +1",       --   1,  4 {___, 12, __, __ / __, 12, __, __} [ 4/ 4, ___]
    ring1="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    ring2="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    back=gear.SMN_Magic_BP_Cape,        --   1,  5 {___, 20, __, 25 / __, __, __, __} [10/__, ___]
    waist="Regal Belt",                 -- ___, __ { 10, __, __, __ / 20, __, __, __} [ 3/ 3, ___]
    -- 123 Pet Lv, 157 BP Dmg {Pet: 122 MAB, 251 M.Acc, 49 INT, 25 M.Dmg / 40 Att, 224 Acc, 40 STR, 0 DA} [34 PDT/24 MDT, 489 M.Eva]
    
    -- body="Beckoner's Doublet +3",    -- ___, 13 {___, 64, __, __ / __, 64, __, __} [13/13, 130]
    -- legs=gear.Enticer_legs,          -- ___, 12 {___, 15, __, __ / __, 15, __, __} [__/__, 107]; Pet TP Bonus
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- 123 Pet Lv, 159 BP Dmg {Pet: 122 MAB, 272 M.Acc, 49 INT, 25 M.Dmg / 40 Att, 257 Acc, 40 STR, 0 DA} [37 PDT/27 MDT, 499 M.Eva]
  })

  -- TODO: update set
  -- Spirits cast magic spells, which can be identified in standard ways.
  sets.midcast.Pet.WhiteMagic = {
    -- legs="Glyphic Spats +3" -- Shorten recast time for spirits
  }

  sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
    -- legs="Glyphic Spats +3", -- Shorten recast time for spirits
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  -- TODO: update set
  sets.engaged = {
    head="Beckoner's Horn +3",
    body="Beckoner's Doublet +2",
    hands="Gazu Bracelets +1",
    legs="Beckoner's Spats +2",
    feet="Beckoner's Pigaches +2",
    neck="Loricate Torque +1",
    ear1="Dedition Earring",
    ear2="Cessance Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back="Aurist's Cape +1",
    waist="Klouskap Sash +1",

    -- ear2="Telos Earring",
  }
  sets.engaged.Acc = {
    ear1="Dignitary's Earring",
    ear2="Cessance Earring",

    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace",     --20
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
  -- If targeting self for rage blood pact, change its target to <bt> (battle target)
  if (spell.type == 'BloodPactRage'
          or (pet and pet.name and pacts.sleep[pet.name] and pacts.sleep[pet.name] == spell.english)
          or (pet and pet.name and pacts.nuke2[pet.name] and pacts.nuke2[pet.name] == spell.english)
          or (pet and pet.name and pacts.nuke4[pet.name] and pacts.nuke4[pet.name] == spell.english)
          or (pet and pet.name and pacts.astralflow[pet.name] and pacts.astralflow[pet.name] == spell.english)
          or (pet and pet.name and pacts.debuff1[pet.name] and pacts.debuff1[pet.name] == spell.english)
          or (pet and pet.name and pacts.debuff2[pet.name] and pacts.debuff2[pet.name] == spell.english)
          or (pet and pet.name and pacts.bpextra[pet.name] and pacts.bpextra[pet.name] == spell.english))
      and (spell.target.type == 'SELF' or spell.target.type == nil) and spell.target.raw ~= '<bt>' then
    eventArgs.cancel = true -- Prevent sending command to game that was targeting self
    send_command('@input /ja "'..spell.english..'" <bt>') -- Re-issue command to target <bt>
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
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
  
  -- Handle summoning avatar that is already active
  if pet.name == spell.english and pet.hpp > 50 then
    add_to_chat(122, "You already have that avatar active!")
    eventArgs.cancel = true
  elseif avatars:contains(spell.english) and pet.isvalid then
    eventArgs.cancel = true
    windower.chat.input('/pet Release <me>')
    windower.chat.input:schedule(2,'/ma "'..spell.english..'" <me>')
  end

  -- Skip precast set if astral conduit is active
  if state.Buff['Astral Conduit'] and (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
    equip(get_smn_pet_midcast_set(spell, spellMap))
    eventArgs.handled = true
  else
    if pending_pet_ability() then
      eventArgs.cancel = true
      add_to_chat(122, 'Action canceled because pet was midaction.')
    end
    if state.CastingMode.current == 'NirvAM' then -- Normal casting mode is handled automatically
      if spell.type == 'BloodPactWard' or spell.type == 'BloodPactRage' then
        equip(sets.precast[spell.type].NirvAM)
        eventArgs.handled = true
      elseif spell.english == 'Elemental Siphon' then
        equip(sets.precast.JA['Elemental Siphon'].NirvAM)
        eventArgs.handled = true
      end
    end
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if state.CastingMode.current == 'NirvAM' then
    equip({ main="Nirvana", sub="Elan Strap +1",})
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

  if state.Buff['Astral Conduit'] and (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
    eventArgs.handled = true
  end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if state.CastingMode.current == 'NirvAM' then
    equip({ main="Nirvana", sub="Elan Strap +1",})
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

  if not spell.interrupted then
    if spell.english == 'Light Arts' then
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
    elseif spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard' then
      equip(get_smn_pet_midcast_set(spell, spellMap))
      last_pet_midcast_set = set_combine(gearswap.equip_list, {})
      last_pet_midaction_time = os.clock()
      eventArgs.handled = true
    end
  end

  if state.CastingMode.current == 'NirvAM' then
    equip({ main="Nirvana", sub="Elan Strap +1",})
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-- Note: the "spell" object is different in the pet action hooks
function job_pet_midcast(spell, action, spellMap, eventArgs)
  equip(get_smn_pet_midcast_set(spell, spellMap))
  eventArgs.handled = true
  
	if spell.interrupted then
    last_pet_midaction_time = 0
  end
end

-- Runs when pet completes an action.
-- Note: the "spell" object is different in the pet action hooks
function job_pet_aftercast(spell, action, spellMap, eventArgs)
  last_pet_midaction_time = 0

	if not spell.interrupted then
    if spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
      wards.flag = true
      wards.spell = spell.english
      send_command('wait 4; gs c reset_ward_flag')
    end
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_active_strategems()
  update_sublimation()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
  if state.Buff[buff] ~= nil then
    handle_equipping_gear(player.status)
  elseif storms:contains(buff) then
    handle_equipping_gear(player.status)
  end
end

-- Get the default pet midcast gear set.
-- This is built in sets.midcast.Pet.
function get_smn_pet_midcast_set(spell, spellMap)
  local equipSet = {}
  if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard')
      and pet.isvalid and sets.midcast and sets.midcast.Pet then
    equipSet = sets.midcast.Pet

    if equipSet[spell.english] then
      equipSet = equipSet[spell.english]
    else
      -- Determine type of set to use
      equipSet = select_specific_set(equipSet, spell, spellMap)
    end

    -- Allow CastingMode to refine whatever set was selected above.
    -- Generally this modifies accuracy of the set.
    if equipSet[state.CastingMode.current] then
      equipSet = equipSet[state.CastingMode.current]
    end
  end

  return equipSet
end

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
  if pet.isvalid and not midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
    handle_equipping_gear(player.status, newStatus)
  end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
  if gain and avatars:contains(petparam.name) then
    latestAvatar = petparam.name
  end
  handle_equipping_gear(player.status)
end

function update_idle_groups()
  classes.CustomIdleGroups:clear()
  if pet.isvalid then
    if avatars:contains(pet.name) then
      classes.CustomIdleGroups:append('Avatar')
    elseif spirits:contains(pet.name) then
      classes.CustomIdleGroups:append('Spirit')
    end
  end
  
  if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
    classes.CustomIdleGroups:append('Adoulin')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
  if spell.type == 'BloodPactRage' then
    if magicalRagePacts:contains(spell.english) then
      return 'MagicalBloodPactRage'
    elseif hybridRagePacts:contains(spell.english) then
      return 'HybridBloodPactRage'
    else
      return 'PhysicalBloodPactRage'
    end
  elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
    return 'DebuffBloodPactWard'
  end

  if spell.action_type == 'Magic' then
    if default_spell_map == 'Cure' then
      if (world.weather_element == 'Light' and not (silibs.get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        return 'CureWeather'
      else
        return 'CureNormal'
      end
    end
  end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if not pending_pet_ability() then
    if state.Buff['Astral Conduit'] then
      if pet.isvalid then
        idleSet = set_combine(idleSet, last_pet_midcast_set)
      end
    else
      if pet.isvalid and pet.status == 'Engaged' then
        idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
      else
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
      end
    end
  end

  if state.CastingMode.value == 'NirvAM' then
    idleSet = set_combine(idleSet, { main="Nirvana", sub="Elan Strap +1",})
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

function customize_melee_set(meleeSet)
  if not pending_pet_ability() then
    if state.Buff['Astral Conduit'] then
      if pet.isvalid then
        meleeSet = set_combine(meleeSet, last_pet_midcast_set)
      end
    else
      if pet.isvalid and pet.status == 'Engaged' then
        meleeSet = set_combine(meleeSet, sets.idle.Avatar.Melee)
      else
        -- If not in DT mode
        if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
          if state.CP.current == 'on' then
            meleeSet = set_combine(meleeSet, sets.CP)
          end
        end
      end
    end
  end

  if state.CastingMode.value == 'NirvAM' then
    meleeSet = set_combine(meleeSet, { main="Nirvana", sub="Elan Strap +1",})
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

  return meleeSet
end

function customize_defense_set(defenseSet)
  if not pending_pet_ability() then
    if pet.isvalid and pet.status == 'Engaged' then
      defenseSet = set_combine(defenseSet, sets.idle.Avatar.Melee)
    else
      -- If not in DT mode
      if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
        if state.CP.current == 'on' then
          defenseSet = set_combine(defenseSet, sets.CP)
        end
      end
    end
  end

  if state.CastingMode.value == 'NirvAM' then
    defenseSet = set_combine(defenseSet, { main="Nirvana", sub="Elan Strap +1",})
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
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
  local c_msg = state.CastingMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)
    )

  eventArgs.handled = true
end

function pending_pet_ability()
  return (os.clock() - last_pet_midaction_time) < 3
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  if cmdParams[1]:lower() == 'siphon' then
    handle_siphoning()
    eventArgs.handled = true
  elseif cmdParams[1]:lower() == 'pact' then
    handle_pacts(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'reset_ward_flag' then
    wards.flag = false
    wards.spell = ''
    eventArgs.handled = true
  elseif cmdParams[1] == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'storm' then
    send_command('@input /ma "'..state.Storm.current..'" <stpc>')
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds:schedule(2)
    set_sub_keybinds:schedule(2)
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
  if areas.Cities:contains(world.area) then
    add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
    return
  end

  local siphonElement
  local stormElementToUse
  local releasedAvatar
  local dontRelease

  -- If we already have a spirit out, just use that.
  if pet.isvalid and spirits:contains(pet.name) then
    siphonElement = pet.element
    dontRelease = true
    -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
    if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
      stormElementToUse = pet.element
    end
  -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
  -- If current (single) weather is opposed by the current day, we want to change the weather to match
  -- the current day, if possible.
  elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
    -- We can override single-intensity weather; leave double weather alone, since even if
    -- it's partially countered by the day, it's not worth changing.
    if silibs.get_weather_intensity() == 1 then
      -- If current weather is weak to the current day, it cancels the benefits for
      -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
      -- weather if not.
      -- If the current weather matches the current avatar's element (being used to reduce
      -- perpetuation), don't change it; just accept the penalty on Siphon.
      if world.weather_element == silibs.elements.weak_to[world.day_element] and
          (not pet.isvalid or world.weather_element ~= pet.element) then
        stormElementToUse = world.day_element
      end
    end
  end

  -- If we decided to use a storm, set that as the spirit element to cast.
  if stormElementToUse then
    siphonElement = stormElementToUse
  elseif world.weather_element ~= 'None' and (silibs.get_weather_intensity() == 2 or world.weather_element ~= silibs.elements.weak_to[world.day_element]) then
    siphonElement = world.weather_element
  else
    siphonElement = world.day_element
  end

  local command = ''
  local releaseWait = 0

  if pet.isvalid and avatars:contains(pet.name) then
    command = command..'input /pet "Release" <me>;wait 1.1;'
    releasedAvatar = pet.name
    releaseWait = 10
  end

  if stormElementToUse then
    command = command..'input /ma "'..silibs.elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
    releaseWait = releaseWait - 4
  end

  if not (pet.isvalid and spirits:contains(pet.name)) then
    command = command..'input /ma "'..silibs.elements.spirit_of[siphonElement]..'" <me>;wait 4;'
    releaseWait = releaseWait - 4
  end

  command = command..'input /ja "Elemental Siphon" <me>;'
  releaseWait = releaseWait - 1
  releaseWait = releaseWait + 0.1

  if not dontRelease then
    if releaseWait > 0 then
      command = command..'wait '..tostring(releaseWait)..';'
    else
      command = command..'wait 1.1;'
    end

    command = command..'input /pet "Release" <me>;'
  end

  if releasedAvatar then
    command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
  end

  send_command(command)
end

-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
  if areas.Cities:contains(world.area) then
    add_to_chat(122, 'You cannot use pacts in town.')
    return
  end

  if spirits:contains(pet.name) then
    add_to_chat(122,'Cannot use pacts with spirits.')
    return
  end

  if not cmdParams[2] then
    add_to_chat(123,'No pact type given.')
    return
  end

  local pact = cmdParams[2]:lower()

  if not pacts[pact] then
    add_to_chat(123,'Unknown pact type: '..tostring(pact))
    return
  end

  if pet.name then
    if pacts[pact][pet.name] then
      if pact == 'astralflow' and not buffactive['astral flow'] then
        add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
        return
      end

      -- Leave out target; let Shortcuts auto-determine it.
      send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
      add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
  elseif latestAvatar then
    -- Pet is currently dead, so summon a new one
    send_command('@input /ma "'..latestAvatar..'" <me>')
  else
    add_to_chat(122,'No current pet, and cannot determine latest avatar.')
  end
end

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
  -- Create custom timers for ward pacts.
  if wards.durations[spell_name] then
    local ward_duration = wards.durations[spell_name]
    if ward_duration < 181 then
      local skill = player.skills.summoning_magic
      if skill > 300 then
        skill = skill - 300
        if skill > 200 then
          skill = 200
        end
        ward_duration = ward_duration + skill
      end
    end

    local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'

    if wards.icons[spell_name] then
      timer_cmd = timer_cmd..' '..wards.icons[spell_name]
    end

    send_command(timer_cmd)
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

-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk', function (id)
  if id == 0x62 then
    if wards.flag then
      create_pact_timer(wards.spell)
      wards.flag = false
      wards.spell = ''
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
  -- Default macro set/book
  set_macro_page(1, 15)
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
