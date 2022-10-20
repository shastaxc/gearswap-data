-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
  Custom commands:

  gs c siphon
    Automatically run the process to: dismiss the current avatar; cast appropriate
    weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
    and re-summon the avatar.

    Will not cast weather you do not have access to.
    Will not re-summon the avatar if one was not out in the first place.
    Will not release the spirit if it was out before the command was issued.

  gs c pact [PactType]
    Attempts to use the indicated pact type for the current avatar.
    PactType can be one of:
      cure
      curaga
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
--]]


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
  silibs.enable_auto_lockstyle(1)
  silibs.enable_premade_commands()

  state.CP = M(false, "Capacity Points Mode")
  state.Storm = M{['description']='Storm','Aurorastorm','Sandstorm',
      'Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Voidstorm'}
  state.OffenseMode:options('None', 'Normal', 'Acc')
  state.CastingMode:options('Normal', 'NirvAM')
  state.IdleMode:options('Normal')
  
  state.Storm = M{['description']='Storm','Aurorastorm','Sandstorm',
  'Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Voidstorm'}

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
  pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
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

  -- Wards table for creating custom timers
  wards = {}
  -- Base duration for ward pacts.
  wards.durations = {
      ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
      ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120, ['Shining Ruby'] = 180, ['Frost Armor'] = 180,
      ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180, ['Glittering Ruby'] = 180, ['Hastega'] = 180,
      ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180, ['Dream Shroud'] = 180, ['Reraise II'] = 3600
  }
  -- Icons to use when creating the custom timer.
  wards.icons = {
      ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
      ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
      ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
      ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
      ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
      ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
      ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
      ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
      ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
      ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
      ['Fleet Wind']      = 'abilities/00074.png', -- 
  }
  -- Flags for code to get around the issue of slow skill updates.
  wards.flag = false
  wards.spell = ''

  latestAvatar = pet.name or nil

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @c gs c toggle CP')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind !q input /ja "Assault" <t>')
  send_command('bind !w input /ja "Retreat" <me>')
  send_command('bind !e input /ja "Release" <me>')
  send_command('bind !r input /ja "Avatar\'s Favor" <me>')

  send_command('bind !` gs c pact buffSpecial')
  send_command('bind ^numlock gs c pact bp99')
  send_command('bind ^numpad/ gs c pact bp75')
  send_command('bind ^numpad* gs c pact bp70')
  send_command('bind ^numpad- gs c pact astralflow')
  send_command('bind !z gs c pact debuff1')
  send_command('bind !x gs c pact debuff2')
  
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'SCH' then
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^\\\\ gs c scholar cost')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !\\\\ gs c scholar speed')

    send_command('bind !c gs c storm')
    send_command('bind ^pageup gs c cycleback Storm')
    send_command('bind ^pagedown gs c cycle Storm')
    send_command('bind !pagedown gs c reset Storm')
    
    send_command('bind !u input /ma "Blink" <me>')
    send_command('bind !i input /ma "Stoneskin" <me>')
    send_command('bind !p input /ma "Aquaveil" <me>')
  elseif player.sub_job == 'RDM' then
    send_command('bind !u input /ma "Blink" <me>')
    send_command('bind !i input /ma "Stoneskin" <me>')
    send_command('bind !o input /ma "Phalanx" <me>')
    send_command('bind !p input /ma "Aquaveil" <me>')
    send_command('bind !\' input /ma "Refresh" <stpc>')
  elseif player.sub_job == 'WHM' then
    send_command('bind !u input /ma "Blink" <me>')
    send_command('bind !i input /ma "Stoneskin" <me>')
    send_command('bind !p input /ma "Aquaveil" <me>')
  end
  
  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @c')
  send_command('unbind @w')
  
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')
  send_command('unbind !r')

  send_command('unbind !`')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind !z')
  send_command('unbind !x')
  
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^\\\\')
  send_command('unbind ![')
  send_command('unbind !\\\\')

  send_command('unbind !c')
  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !o')
  send_command('unbind !p')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
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
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    -- 61 Fast Cast [45 PDT/43 MDT, 428 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- waist="Shinjutsu-no-obi +1",   --  5 [__/__, ___]
    -- 81 Fast Cast [55 PDT/53 MDT, 570 M.Eva]
  }
  sets.precast.FC.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs=gear.Merl_FC_legs,           --  7 [__/__, 118]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- 64 Fast Cast [45 PDT/43 MDT, 428 M.Eva] 3 Quick Magic
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- 80 Fast Cast [55 PDT/53 MDT, 570 M.Eva]
    
    -- main="Malignance Pole",        -- __ [20/20, ___]
    -- sub="Khonsu",                  -- __ [ 6/ 6, ___]
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- head=gear.Merl_FC_head,        -- 15 [__/__,  86]
    -- body=gear.Merl_FC_body,        -- 14 [ 2/__,  91]
    -- hands="Volte Gloves",          --  6 [__/__,  96]; merlinic alt
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- feet=gear.Merl_FC_feet,        -- 12 [__/__, 118]
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- ear1="Malignance Earring",     --  4 [__/__, ___]
    -- ear2="Loquacious Earring",     --  2 [__/__, ___]
    -- ring1="Lebeche Ring",          -- __ [__/__, ___]  2
    -- ring2="Defending Ring",        -- __ [10/10, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- waist="Witful Belt",           --  3 [__/__, ___]  3
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
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    -- RDM Trait                         15
    -- 76 Fast Cast [45 PDT/43 MDT, 428 M.Eva]
    
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- waist="Shinjutsu-no-obi +1",   --  5 [__/__, ___]
    -- 81 Fast Cast [55 PDT/53 MDT, 570 M.Eva]
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
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Perimede Cape",             -- __ [__/__, ___]  4
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- RDM Trait                         15
    -- 75 Fast Cast [49 PDT/47 MDT, 538 M.Eva] 9 Quick Magic
    
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- 80 Fast Cast [50 PDT/48 MDT, 548 M.Eva] 9 Quick Magic
  }
  
  -- Fast cast sets for spells
  sets.precast.FC.NirvAM = {
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    -- 52 Fast Cast [22 PDT/20 MDT, 428 M.Eva]
    
    -- main="Nirvana",                -- __ [__/__, ___]
    -- sub="Elan Strap +1",           -- __ [__/__, ___]
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- waist="Shinjutsu-no-obi +1",   --  5 [__/__, ___]
    -- 80 Fast Cast [32 PDT/20 MDT, 570 M.Eva]
  }
  sets.precast.FC.NirvAM.QuickMagic = {
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Witful Belt",              --  3 [__/__, ___] 3
    -- 55 Fast Cast [22 PDT/20 MDT, 428 M.Eva] 3 Quick Magic

    -- main="Nirvana",                -- __ [__/__, ___]
    -- sub="Elan Strap +1",           -- __ [__/__, ___]
    -- legs="Volte Brais",            --  8 [__/__, 142]; merlinic alt
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- 78 Fast Cast [32 PDT/20 MDT, 570 M.Eva] 3 Quick Magic
  }

  sets.precast.FC.NirvAM.RDM = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs="Beckoner's Spats +2",       -- __ [11/11, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Regal Belt",               -- __ [ 3/ 3, ___]
    -- RDM Trait                         15
    -- 65 Fast Cast [40 PDT/30 MDT, 575 M.Eva]
    
    -- main="Nirvana",                -- __ [__/__, ___]
    -- sub="Elan Strap +1",           -- __ [__/__, ___]
    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- 80 Fast Cast [51 PDT/31 MDT, 585 M.Eva]
  }
  sets.precast.FC.NirvAM.QuickMagic.RDM = {
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    hands="Volte Gloves",             --  6 [__/__,  96]; merlinic alt
    legs="Beckoner's Spats +2",       -- __ [11/11, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Loquacious Earring",        --  2 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- RDM Trait                         15
    -- 66 Fast Cast [37 PDT/27 MDT, 575 M.Eva] 5 Quick Magic

    -- main="Nirvana",                -- __ [__/__, ___]
    -- sub="Elan Strap +1",           -- __ [__/__, ___]
    -- legs="Beckoner's Spats +3",    -- __ [12/12, 157]
    -- neck="Orunmila's Torque",      --  5 [__/__, ___]
    -- back=gear.SMN_FC_Cape          -- 10 [10/__, ___]
    -- 81 Fast Cast [48 PDT/28 MDT, 585 M.Eva] 5 Quick Magic
  }


  -----------------------------------------------------------------------------------------------
  ------------------------------------- Job Ability Sets ----------------------------------------
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Astral Flow'] = {
    -- head="Glyphic Horn",
  }

  -- MP Siphoned = (Summoning Skill - 50 + Base Siphon Equipment) * (1.0 + Siphon Equip Multipliers ± Weather/Day bonuses)
  -- Hachirin-no-obi has no effect; day/weather bonuses always apply.
  sets.precast.JA['Elemental Siphon'] = {
    main="Chatoyant Staff",             -- __, __, 10 [__/__, ___]
    sub="Khonsu",                       -- __, __, __ [ 6/ 6, ___]
    -- ammo="Esper stone +1",           -- 20, __, __ [__/__, ___]
    head="Beckoner's Horn +2",          -- __, 18, __ [ 9/ 9, 120]
    body="Beckoner's Doublet +2",       -- __, 19, __ [12/12, 120]
    hands="Baayami Cuffs +1",           -- __, 33, __ [__/__,  93]
    legs="Beckoner's Spats +2",         -- __, 25, __ [11/11, 147]
    feet="Beckoner's Pigaches +2",      -- 70, __, __ [__/__, 158]
    neck="Incanter's Torque",           -- __, 10, __ [__/__, ___]
    -- ear1="Lodurr Earring",           -- __, 10, __ [__/__, ___]
    ear2="Beckoner's Earring +1",       -- __, __, __ [ 4/ 4, ___]
    -- ring1="Zodiac Ring",             -- __, __,  3 [__/__, ___]
    ring2="Defending Ring",             -- __, __, __ [10/10, ___]
    back="Twilight Cape",               -- __, __,  5 [__/__, ___]
    -- waist="Ligeia Sash",             -- 10, __, __ [__/__, ___]
    -- Traits/Merits/Gifts                 60,469, __ [__/__, ___]
    -- Assume minimum day/weather          __, __, 10
    -- 160 Base Siphon, 584 Summoning Skill, 28 Siphon Multiplier [52 PDT/52 MDT, 638 M.Eva]
    -- MP Siphoned = 888 to 1061 (depending on day/weather)
    
    -- head="Beckoner's Horn +3",       -- __, 23, __ [10/10, 130]
    -- body="Beckoner's Doublet +3",    -- __, 24, __ [13/13, 130]
    -- legs="Beckoner's Spats +3",      -- __, 30, __ [12/12, 157]
    -- feet="Beckoner's Pigaches +3",   -- 80, __, __ [__/__, 168]
    -- ear2="Cath Palug Earring",       -- __,  5, __ [__/__, ___]
    -- 170 Base Siphon, 604 Summoning Skill, 28 Siphon Multiplier [51 PDT/51 MDT, 678 M.Eva]
    -- MP Siphoned = 926 to 1180 (depending on day/weather)
  }
  sets.precast.JA['Elemental Siphon'].NirvAM = {
    -- main="Nirvana",                  -- __, __, __ [__/__, ___]
    -- sub="Elan Strap +1",             -- __, __, __ [__/__, ___]
    -- ammo="Esper stone +1",           -- 20, __, __ [__/__, ___]
    head="Beckoner's Horn +2",          -- __, 18, __ [ 9/ 9, 120]
    body="Beckoner's Doublet +2",       -- __, 19, __ [12/12, 120]
    hands="Baayami Cuffs +1",           -- __, 33, __ [__/__,  93]
    legs="Beckoner's Spats +2",         -- __, 25, __ [11/11, 147]
    feet="Beckoner's Pigaches +2",      -- 70, __, __ [__/__, 158]
    neck="Incanter's Torque",           -- __, 10, __ [__/__, ___]
    -- ear1="Lodurr Earring",           -- __, 10, __ [__/__, ___]
    ear2="Beckoner's Earring +1",       -- __, __, __ [ 4/ 4, ___]
    -- ring1="Zodiac Ring",             -- __, __,  3 [__/__, ___]
    ring2="Defending Ring",             -- __, __, __ [10/10, ___]
    back="Twilight Cape",               -- __, __,  5 [__/__, ___]
    -- waist="Ligeia Sash",             -- 10, __, __ [__/__, ___]
    -- Traits/Merits/Gifts                 60,469, __ [__/__, ___]
    -- Assume minimum day/weather          __, __, 10
    -- 160 Base Siphon, 584 Summoning Skill, 18 Siphon Multiplier [46 PDT/46 MDT, 638 M.Eva]
    -- MP Siphoned = 888 to 1061 (depending on day/weather)
    
    -- head="Beckoner's Horn +3",       -- __, 23, __ [10/10, 130]
    -- body="Beckoner's Doublet +3",    -- __, 24, __ [13/13, 130]
    -- legs="Beckoner's Spats +3",      -- __, 30, __ [12/12, 157]
    -- feet="Beckoner's Pigaches +3",   -- 80, __, __ [__/__, 168]
    -- 170 Base Siphon, 599 Summoning Skill, 28 Siphon Multiplier [49 PDT/49 MDT, 678 M.Eva]
    -- MP Siphoned = 920 to 1171 (depending on day/weather)
  }

  sets.precast.JA['Mana Cede'] = {
    -- hands="Caller's Bracers +2", -- This and gifts cap out the effect; no need to reforge
  }

  -- Pact delay reduction gear: summoning skill, -BP Delay, -BP Delay II
  -- Caps: summoning skill @670, -BP Delay @15, -BP Delay II @15, -BP Delay Total @30 (including the 10s from gifts)
  sets.precast.BloodPactWard = {
    main="Malignance Pole",         -- __, __, __, __ [20/20, ___]
    sub="Vox Grip",                 --  3, __, __, __ [__/__, ___]
    ammo="Sancus Sachet +1",        -- __, __,  7, __ [__/__, ___]
    head="Beckoner's Horn +2",      -- 18, __, __, __ [ 9/ 9, 120]; Keep on for Favor bonus
    -- body="Baayami Robe",         -- 32, __, __, __ [__/__, 112]
    hands="Baayami Cuffs +1",       -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    legs="Baayami Slops +1",        -- 35,  8, __, __ [__/__, 139]
    feet="Baayami Sabots +1",       -- 29, __, __, __ [__/__, 139]
    neck="Incanter's Torque",       -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    ring2="Stikini Ring +1",        --  8, __, __, __ [__/__, ___]
    -- back=gear.SMN_Pre_BP_Cape,   --  8, __,  5, __ [__/__, ___]
    waist="Regal Belt",             -- __, __, __, __ [ 3/ 3, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- 670 Summon Skill, 15 -BP Delay, 12 -BP Delay II, 10 -BP Delay III [32 PDT/32 MDT, 603 M.Eva]
    
    -- ammo="Epitaph",              -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- 675 Summon Skill, 15 -BP Delay, 10 -BP Delay II, 10 -BP Delay III [33 PDT/33 MDT, 613 M.Eva]
    
    -- main="Malignance Pole",      -- __, __, __, __ [20/20, ___]
    -- sub="Vox Grip",              --  3, __, __, __ [__/__, ___]
    -- ammo="Epitaph",              -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- body="Beckoner's Doublet +3",-- 24, __, __, __ [13/13, 130]
    -- hands="Baayami Cuffs +1",    -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    -- legs="Baayami Slops +1",     -- 35,  8, __, __ [__/__, 139]
    -- feet="Baayami Sabots +1",    -- 29, __, __, __ [__/__, 139]
    -- neck="Incanter's Torque",    -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    -- ring2="Stikini Ring +1",     --  8, __, __, __ [__/__, ___]
    -- back=gear.SMN_FC_Cape,       -- __, __, __, __ [10/__, ___]
    -- waist="Kobo Obi",            --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- Master Levels                    3
    -- 670 Summon Skill, 15 -BP Delay, 5 -BP Delay II, 10 -BP Delay III [53 PDT/43 MDT, 631 M.Eva]
  }
  sets.precast.BloodPactRage = sets.precast.BloodPactWard

  sets.precast.BloodPactWard.NirvAM = {
    -- main="Nirvana",              -- __, __, __, __ [__/__, ___]
    -- sub="Elan Strap +1",         -- __, __, __, __ [__/__, ___]
    ammo="Epitaph",                 -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- body="Baayami Robe",         -- 32, __, __, __ [__/__, 112]
    hands="Baayami Cuffs +1",       -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    legs="Baayami Slops +1",        -- 35,  8, __, __ [__/__, 139]
    feet="Baayami Sabots +1",       -- 29, __, __, __ [__/__, 139]
    neck="Incanter's Torque",       -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    ring2="Stikini Ring +1",        --  8, __, __, __ [__/__, ___]
    -- back=gear.SMN_Pre_BP_Cape,   --  8, __,  5, __ [__/__, ___]
    waist="Regal Belt",             -- __, __, __, __ [ 3/ 3, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- 672 Summon Skill, 15 -BP Delay, 10 -BP Delay II, 10 -BP Delay III [13 PDT/13 MDT, 613 M.Eva]
    
    -- main="Nirvana",              -- __, __, __, __ [__/__, ___]
    -- sub="Elan Strap +1",         -- __, __, __, __ [__/__, ___]
    -- ammo="Epitaph",              -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- body="Baayami Robe",         -- 32, __, __, __ [__/__, 112]
    -- hands="Baayami Cuffs +1",    -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    -- legs="Baayami Slops +1",     -- 35,  8, __, __ [__/__, 139]
    -- feet="Baayami Sabots +1",    -- 29, __, __, __ [__/__, 139]
    -- neck="Incanter's Torque",    -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    -- ring2="Defending Ring",      -- __, __, __, __ [10/10, ___]
    -- back=gear.SMN_Pre_BP_Cape,   --  8, __,  5, __ [__/__, ___]
    -- waist="Kobo Obi",            --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- 672 Summon Skill, 15 -BP Delay, 10 -BP Delay II, 10 -BP Delay III [20 PDT/20 MDT, 613 M.Eva]

    -- main="Nirvana",              -- __, __, __, __ [__/__, ___]
    -- sub="Elan Strap +1",         -- __, __, __, __ [__/__, ___]
    -- ammo="Epitaph",              -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- body="Beckoner's Doublet +3",-- 24, __, __, __ [13/13, 130]
    -- hands="Baayami Cuffs +1",    -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    -- legs="Baayami Slops +1",     -- 35,  8, __, __ [__/__, 139]
    -- feet="Baayami Sabots +1",    -- 29, __, __, __ [__/__, 139]
    -- neck="Incanter's Torque",    -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    -- ring2="Stikini Ring +1",     --  8, __, __, __ [__/__, ___]
    -- back=gear.SMN_Pre_BP_Cape,   --  8, __,  5, __ [__/__, ___]
    -- waist="Kobo Obi",            --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- 672 Summon Skill, 15 -BP Delay, 10 -BP Delay II, 10 -BP Delay III [23 PDT/23 MDT, 631 M.Eva]

    -- main="Nirvana",              -- __, __, __, __ [__/__, ___]
    -- sub="Elan Strap +1",         -- __, __, __, __ [__/__, ___]
    -- ammo="Epitaph",              -- __, __,  5, __ [__/__, ___]
    -- head="Beckoner's Horn +3",   -- 23, __, __, __ [10/10, 130]; Keep on for Favor bonus
    -- body="Beckoner's Doublet +3",-- 24, __, __, __ [13/13, 130]
    -- hands="Baayami Cuffs +1",    -- 33,  7, __, __ [__/__,  93]; maybe swap for Glyphic Bracers +3
    -- legs="Baayami Slops +1",     -- 35,  8, __, __ [__/__, 139]
    -- feet="Baayami Sabots +1",    -- 29, __, __, __ [__/__, 139]
    -- neck="Incanter's Torque",    -- 10, __, __, __ [__/__, ___]
    -- ear1="Lodurr Earring",       -- 10, __, __, __ [__/__, ___]
    -- ear2="Cath Palug Earring",   --  5, __, __, __ [__/__, ___]
    -- ring1="Evoker's Ring",       -- 10, __, __, __ [__/__, ___]
    -- ring2="Defending Ring",      -- __, __, __, __ [10/10, ___]
    -- back=gear.SMN_FC_Cape,       -- __, __, __, __ [10/__, ___]
    -- waist="Kobo Obi",            --  8, __, __, __ [__/__, ___]
    -- Traits/Merits/Gifts            469, __, __, 10
    -- Master Levels                   14
    -- 670 Summon Skill, 15 -BP Delay, 5 -BP Delay II, 10 -BP Delay III [43 PDT/33 MDT, 631 M.Eva]
  }
  sets.precast.BloodPactRage.NirvAM = sets.precast.BloodPactWard.NirvAM


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
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
    ring1="Rufescent Ring",
    -- ring2="Karieyh Ring +1",
    back="Aurist's Cape +1",
    -- waist="Fotia Belt",
  }

  -- Only affected by TP Bonus, cap out DT
  sets.precast.WS['Myrkr'] = set_combine(sets.precast.WS, {
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC.NirvAM

  -- Ensure trusts get summoned at max ilvl
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureNormal = {
    main="Bunzi's Rod",         -- 30, 15, __, ___ [__/__, ___] __
    sub="Genbu's Shield",       --  5, __, __, ___ [10/__, ___] __
    head=gear.Vanya_B_head,     -- 10, 27, 18,  20 [__/ 5,  75] __
    body=gear.Vanya_B_body,     -- __, 36, 23,  20 [ 1/ 4,  80] __
    legs=gear.Vanya_B_legs,     -- __, 34, 12,  20 [__/__, 107] __
    feet=gear.Vayna_B_feet,     --  5, 19, 10,  40 [__/__, 107] __
    neck="Incanter's Torque",   -- __, __, __,  10 [__/__, ___] __
    ear1="Meili Earring",       -- __, __, __,  10 [__/__, ___] __
    ear2="Mendicant's Earring", --  5, __, __, ___ [__/__, ___] __
    ring1="Sirona's Ring",      -- __,  3,  3,  10 [__/__, ___] __
    ring2="Defending Ring",     -- __, __, __, ___ [10/10, ___] __
    -- Traits/Merits/Gifts         __,101, 89,  16
    -- Subjob                      __, __, __, 139
    -- 55 CP, 235 MND, 155 VIT, 285 Healing Skill [21 PDT/19 MDT, 369 M.Eva] 0 -Enmity
    
    -- main=gear.Gada_MND,      -- 18, 21, __,  18 [__/__, ___] __
    -- hands="Bunzi's Gloves",  -- __, 47, 26, ___ [ 8/ 8, 112]  8
    -- back=gear.SMN_Cure_Cape, -- 10, 30, __, ___ [10/__, ___] __
    -- waist="Luminary Sash",   -- __, 10, __, ___ [__/__, ___] __
    -- 53 CP, 328 MND, 181 VIT, 303 Healing Skill [39 PDT/27 MDT, 481 M.Eva] 8 -Enmity
    -- 847 HP Cure IV
  }
  sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
    waist="Hachirin-no-obi",
    -- 903 HP to 1044 Cure IV depending on weather/day
  })

  sets.midcast.Stoneskin = {
    ammo="Sancus Sachet +1",      -- __ [__/__, ___]
    head="Bunzi's Hat",           -- __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,       -- __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,     -- __ [ 7/ 7, 112]
    feet=gear.Nyame_B_feet,       -- __ [ 7/ 7, 150]
    neck="Nodens Gorget",         -- 30 [__/__, ___]
    ear1="Earthcry Earring",      -- 10 [__/__, ___]
    ring1="Gelatinous Ring +1",   -- __ [ 7/-1, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    -- 40 +Stoneskin [47 PDT/39 MDT, 524 M.Eva]

    -- ammo="Epitaph",            -- __ [__/__, ___]
    -- legs="Shedir Seraweels",   -- 35 [__/__, ___]
    -- back=gear.SMN_Cure_Cape,   -- __ [10/__,  20]
    -- waist="Siegel Sash",       -- 20 [__/__, ___]
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
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]
    head="Beckoner's Horn +2",        -- 18 [ 9/ 9, 120]
    body="Beckoner's Doublet +2",     -- 19 [12/12, 120]
    hands="Baayami Cuffs +1",         -- 33 [__/__,  93]
    legs="Beckoner's Spats +2",       -- 25 [11/11, 147]
    feet="Baayami Sabots +1",         -- 29 [__/__, 139]
    neck="Incanter's Torque",         -- 10 [__/__, ___]
    ring1="Stikini Ring +1",
    ring2="Defending Ring",           -- __ [10/10, ___]
    -- ear1="Lodurr Earring",         -- 10 [__/__, ___]
    -- ear2="Cath Palug Earring",     --  5 [__/__, ___]
    -- ring1="Evoker's Ring",         -- 10 [__/__, ___]
    -- back=gear.SMN_Skill_Cape,      -- 13 [__/__, ___]
    -- waist="Kobo Obi",              --  8 [__/__, ___]
    -- Traits/Merits/Gifts              469
    -- 664 Summon Skill [51/51, 619 M.Eva]
    
    -- ammo="Epitaph",                -- __ [__/__, ___]
    -- head="Beckoner's Horn +3",     -- 23 [10/10, 130]
    -- body="Beckoner's Doublet +3",  -- 24 [13/13, 130]
    -- 674 Summon Skill [50/50, 639 M.Eva]
  }

  -- Need Pet M.Acc, Summoning Skill to land debuffs
  sets.midcast.Pet.DebuffBloodPactWard = {
    main=gear.Espiritus_B,            -- ___, 45, 15 [__/__, ___]
    sub="Vox Grip",                   -- ___, __,  3 [__/__, ___]
    ammo="Sancus Sachet +1",          -- 119, 20, __ [__/__, ___]
    head="Beckoner's Horn +2",        -- ___, 51, 18 [ 9/ 9, 120]
    body="Beckoner's Doublet +2",     -- ___, 54, 19 [12/12, 120]
    hands="Beckoner's Bracers +2",    -- ___, 52, __ [__/__,  83]
    legs="Beckoner's Spats +2",       -- ___, 53, 25 [11/11, 147]
    feet="Beckoner's Pigaches +2",    -- ___, 50, __ [__/__, 158]
    neck="Summoner's Collar +2",      -- ___, 25, __ [ 5/ 5, ___]
    ear1="Enmerkar Earring",          -- ___, 15, __ [__/__, ___]
    ear2="Beckoner's Earring +1",     --   1, 12, __ [ 4/ 4, ___]
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
    waist="Incarnation Sash",         -- ___, 15, __ [__/__, ___]
    -- ring1="Evoker's Ring",         -- ___, __, 10 [__/__, ___]
    -- ring2="Cath Palug Ring",       -- ___, 12, __ [ 5/ 5, ___]
    -- back=gear.SMN_Magic_BP_Cape,   --   1, 20, __ [10/__,  20]
    -- 121 Pet Lv, 424 Pet M.Acc, 90 Summon Skill [56 PDT/46 MDT, 648 M.Eva]

    -- ammo="Epitaph",                -- 119, 25, __ [__/__, ___]
    -- 121 Pet Lv, 429 Pet M.Acc, 90 Summon Skill [56 PDT/46 MDT, 648 M.Eva]
    
    -- main="Nirvana",                --   2, 30, __ [__/__, ___]
    -- sub="Vox Grip",                -- ___, __,  3 [__/__, ___]
    -- ammo="Epitaph",                -- 119, 25, __ [__/__, ___]
    -- head="Beckoner's Horn +3",     -- ___, 61, 23 [10/10, 130]
    -- body="Beckoner's Doublet +3",  -- ___, 64, 24 [13/13, 130]
    -- hands="Beckoner's Bracers +3", -- ___, 62, __ [__/__,  93]
    -- legs="Beckoner's Spats +2",    -- ___, 63, 30 [12/12, 157]
    -- feet="Beckoner's Pigaches +2", -- ___, 60, __ [__/__, 168]
    -- neck="Summoner's Collar +2",   -- ___, 25, __ [ 5/ 5, ___]
    -- ear1="Enmerkar Earring",       -- ___, 15, __ [__/__, ___]
    -- ear2="Beckoner's Earring +2",  --   1, 20, __ [ 6/ 6, ___]
    -- ring1="Evoker's Ring",         -- ___, __, 10 [__/__, ___]
    -- ring2="Cath Palug Ring",       -- ___, 12, __ [ 5/ 5, ___]
    -- back=gear.SMN_Magic_BP_Cape,   --   1, 20, __ [10/__,  20]
    -- waist="Incarnation Sash",      -- ___, 15, __ [__/__, ___]
    -- 123 Pet Lv, 472 Pet M.Acc, 90 Summon Skill [61 PDT/51 MDT, 698 M.Eva]
  }

  sets.midcast.Pet.PhysicalBloodPactRage = {
    main="Gridarvor",                   -- ___, __ {___, __, __, __ / 70, 95, __, 15} [__/__, ___]
    sub="Elan Strap +1",                -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    ammo="Sancus Sachet +1",            -- 119, 15 {___, 20, __, __ / __, 20, __, __} [__/__, ___]
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Merl_Phys_BP_hands,      -- ___, 15 {___, 20, __, __ / 40, __, __, __} [__/__,  48]
    legs=gear.Apogee_D_legs,            -- ___, 21 {___, __, __, __ / __, __, 20,  4} [__/__, 118]
    feet=gear.Apogee_B_feet,            -- ___, 10 {___, __, __, __ / 35, __, __, __} [__/__, 118]
    neck="Summoner's Collar +2",        -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    ear1="Lugalbanda Earring",          -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    ear2="Beckoner's Earring +1",       --   1,  4 {___, 12, __, __ / __, 12, __, __} [ 4/ 4, ___]
    ring1="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    ring2="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    waist="Incarnation Sash",           -- ___, __ {___, 15, __, __ / __, 15, __,  4} [__/__, ___]
    -- head=gear.Helios_Phys_BP_head,   -- ___,  7 {___, __, __, __ / 30, __, __,  8} [__/__,  75]
    -- body="Convoker's Doublet +3",    -- ___, 16 {___, 45, __, __ / __, 45, __, __} [__/__, 100]
    -- back=gear.SMN_Phys_BP_Cape,      --   1,  5 {___, __, __, __ / 20, 30, __, __} [10/__, ___]
    -- 121 Pet Lv, 126 BP Dmg {Pet: 0 MAB, 152 M.Acc, 25 INT, 0 M.Dmg / 195 Att, 277 Acc, 55 STR, 31 DA} [19 PDT/9 MDT, 469 M.Eva]
    
    -- main="Nirvana",                  --   2, 40 {___, 30, __, __ / __, 30, __, __} [__/__, ___]
    -- sub="Elan Strap +1",             -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    -- ammo="Epitaph",                  -- 119, 16 {___, 25, 10, __ / __, 25, 10, __} [__/__, ___]; R20+
    -- head=gear.Helios_Phys_BP_head,   -- ___,  7 {___, __, __, __ / __, 30, __,  8} [__/__,  75]
    -- body="Convoker's Doublet +3",    -- ___, 16 {___, 45, __, __ / __, 45, __, __} [__/__, 100]
    -- hands=gear.Merl_Phys_BP_hands,   -- ___, 15 {___, 20, __, __ / 40, __, __, __} [__/__,  48]
    -- legs=gear.Apogee_D_legs,         -- ___, 21 {___, __, __, __ / __, __, 20,  4} [__/__, 118]
    -- feet=gear.Apogee_B_feet,         -- ___, 10 {___, __, __, __ / 35, __, __, __} [__/__, 118]
    -- neck="Summoner's Collar +2",     -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    -- ear1="Lugalbanda Earring",       -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- ring1="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- ring2="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- back=gear.SMN_Phys_BP_Cape,      --   1,  5 {___, __, __, __ / 20, 30, __, __} [10/__, ___]
    -- waist="Incarnation Sash",        -- ___, __ {___, 15, __, __ / __, 15, __,  4} [__/__, ___]
    -- 123 Pet Lv, 168 BP Dmg {Pet: 0 MAB, 195 M.Acc, 35 INT, 0 M.Dmg / 125 Att, 225 Acc, 55 STR, 16 DA} [21 PDT/11 MDT, 469 M.Eva]
  }

  sets.midcast.Pet.MagicalBloodPactRage = {
    main=gear.Grioavolr_Magic_BP,       -- ___,  9 {140, 54, __, __ / __, __, __, __} [__/__, ___]
    sub="Elan Strap +1",                -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    ammo="Sancus Sachet +1",            -- 119, 15 {___, 20, __, __ / __, 20, __, __} [__/__, ___]
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Merl_Mag_BP_hands,       -- ___, 15 { 39, 15,  9, __ / 20, __, __, __} [__/__,  48]
    legs=gear.Nyame_B_legs,
    feet=gear.Apogee_A_feet,            -- ___, 10 { 35, __, __, __ / __, __, __, __} [__/__, 118]
    neck="Summoner's Collar +2",        -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    ear1="Lugalbanda Earring",          -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    ear2="Beckoner's Earring +1",       --   1,  4 {___, 12, __, __ / __, 12, __, __} [ 4/ 4, ___]
    ring1="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    ring2="Varar Ring +1",              -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    waist="Regal Belt",                 -- ___, __ { 10, __, __, __ / 20, __, __, __} [ 3/ 3, ___]
    -- head="Cath Palug Crown",         -- ___, 10 { 38, 38, __, __ / __, 38, __, __} [__/__,  86]
    -- body=gear.Apogee_A_body,         -- ___,  8 { 35, __, __, __ / __, __, __, __} [__/__,  91]
    -- legs=gear.Enticer_legs,          -- ___, 12 {___, 15, __, __ / __, 15, __, __} [__/__, 107]; Pet TP Bonus
    -- back=gear.SMN_Magic_BP_Cape,     --   1,  5 {___, 20, __, 25 / __, __, __, __} [__/__, ___]
    -- 121 Pet Lv, 121 BP Dmg {Pet: 297 MAB, 214 M.Acc, 44 INT, 25 M.Dmg / 40 Att, 150 Acc, 35 STR, 0 DA} [12 PDT/12 MDT, 460 M.Eva]
    
    -- main=gear.Grioavolr_Magic_BP,    -- ___,  9 {140, 54, __, __ / __, __, __, __} [__/__, ___]
    -- sub="Elan Strap +1",             -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    -- ammo="Epitaph",                  -- 119, 16 {___, 25, 10, __ / __, 25, 10, __} [__/__, ___]; R20+
    -- head="Cath Palug Crown",         -- ___, 10 { 38, 38, __, __ / __, 38, __, __} [__/__,  86]
    -- body=gear.Apogee_A_body,         -- ___,  8 { 35, __, __, __ / __, __, __, __} [__/__,  91]
    -- hands=gear.Merl_Mag_BP_hands,    -- ___, 15 { 39, 15,  9, __ / 20, __, __, __} [__/__,  48]
    -- legs=gear.Enticer_legs,          -- ___, 12 {___, 15, __, __ / __, 15, __, __} [__/__, 107]; Pet TP Bonus
    -- feet=gear.Apogee_A_feet,         -- ___, 10 { 35, __, __, __ / __, __, __, __} [__/__, 118]
    -- neck="Summoner's Collar +2",     -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    -- ear1="Lugalbanda Earring",       -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- ring1="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- ring2="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- back=gear.SMN_Magic_BP_Cape,     --   1,  5 {___, 20, __, 25 / __, __, __, __} [__/__, ___]
    -- waist="Regal Belt",              -- ___, __ { 10, __, __, __ / 20, __, __, __} [ 3/ 3, ___]
    -- 121 Pet Lv, 123 BP Dmg {Pet: 287 MAB, 227 M.Acc, 34 INT, 25 M.Dmg / 40 Att, 153 Acc, 25 STR, 0 DA} [14 PDT/14 MDT, 460 M.Eva]
  }

  sets.midcast.Pet.HybridBloodPactRage = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
    -- main="Nirvana",                  --   2, 40 {___, 30, __, __ / __, 30, __, __} [__/__, ___]
    -- sub="Elan Strap +1",             -- ___,  5 {___, __, __, __ / __, __, __, __} [__/__, ___]
    -- ammo="Epitaph",                  -- 119, 16 {___, 25, 10, __ / __, 25, 10, __} [__/__, ___]; R20+
    -- head="Cath Palug Crown",         -- ___, 10 { 38, 38, __, __ / __, 38, __, __} [__/__,  86]
    -- body=gear.Apogee_A_body,         -- ___,  8 { 35, __, __, __ / __, __, __, __} [__/__,  91]
    -- hands=gear.Merl_Mag_BP_hands,    -- ___, 15 { 39, 15,  9, __ / 20, __, __, __} [__/__,  48]
    -- legs=gear.Enticer_legs,          -- ___, 12 {___, 15, __, __ / __, 15, __, __} [__/__, 107]; Pet TP Bonus
    feet=gear.Apogee_A_feet,            -- ___, 10 { 35, __, __, __ / __, __, __, __} [__/__, 118]
    -- neck="Summoner's Collar +2",     -- ___, 10 {___, 25, 25, __ / __, 25, 25, __} [ 5/ 5, ___]
    -- ear1="Lugalbanda Earring",       -- ___, 10 {___, 15, __, __ / __, 15, __, __} [__/__,  10]
    -- ear2="Beckoner's Earring +2",    --   1,  5 {___, 20, __, __ / __, 20, __, __} [ 6/ 6, ___]
    -- ring1="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- ring2="Varar Ring +1",           -- ___,  4 {___, __, __, __ / __, 10, __, __} [__/__, ___]
    -- back=gear.SMN_Magic_BP_Cape,     --   1,  5 {___, 20, __, 25 / __, __, __, __} [__/__, ___]
    -- waist="Regal Belt",              -- ___, __ { 10, __, __, __ / 20, __, __, __} [ 3/ 3, ___]
  })

  -- TODO: update set
  -- Spirits cast magic spells, which can be identified in standard ways.
  sets.midcast.Pet.WhiteMagic = {
    -- legs="Glyphic Spats +3" -- Shorten recast time for spirits
  }

  sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {
    -- legs="Glyphic Spats +3", -- Shorten recast time for spirits
  })


  ------------------------------------------------------------------------------------------------=
  -------------------------------------- Idle/Defense Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------=

  -- TODO: update set
  -- sets.resting = {main=gear.Staff.HMP,ammo="Seraphicaller",
  --     head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
  --     body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
  --     back="Pahtli Cape",waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}

  -- With no pet out, don't need perp cost. Focus defensive stats and Refresh
  sets.idle = {
    main="Mpaca's Staff",           -- ____ [__/__, ___] ( 2, __) {___, __, __/__}
    sub="Khonsu",                   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    ammo="Staunch Tathlum +1",      -- ____ [ 3/ 3, ___] (__, __) {___, __, __/__}; Resist Status+11
    head="Beckoner's Horn +2",      --   51 [ 9/ 9, 120] ( 3, __) {___, __, __/__}
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Loricate Torque +1",      -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}; DEF+60
    ear1="Etiolation Earring",      --   50 [__/ 3, ___] (__, __) {___, __, __/__}; Resist Silence+15
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    waist="Regal Belt",             --   88 [ 3/ 3, ___] (__, __) {___, __, __/__}
    -- body=gear.Apogee_A_body,     -- -160 [__/__,  91] ( 4, __) {___, __, __/__}
    -- hands="Asteria Mitts +1",    --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    -- back=gear.SMN_FC_Cape,       -- ____ [10/__, ___] (__, __) {  1, __, __/__}
    -- Traits/Merits/JP Gifts                                       99, __,  7/ 7
    -- 120 HP [51 PDT/44 MDT, 500 M.Eva] (19 Refresh, 3 Perp Cost) {Pet: 101 Lv, 0 Regain, 7 PDT/7 MDT}

    -- main="Mpaca's Staff",        -- ____ [__/__, ___] ( 2, __) {___, __, __/__}
    -- sub="Khonsu",                -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    -- ammo="Staunch Tathlum +1",   -- ____ [ 3/ 3, ___] (__, __) {___, __, __/__}; Resist Status+11
    -- head="Beckoner's Horn +3",   --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    -- body=gear.Apogee_A_body,     -- -160 [__/__,  91] ( 4, __) {___, __, __/__}
    -- hands="Asteria Mitts +1",    --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    -- legs="Assiduity Pants +1",   --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    -- feet="Baayami Sabots +1",    --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    -- neck="Loricate Torque +1",   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}; DEF+60
    -- ear1="Cath Palug Earring",   -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- ring1="Stikini Ring +1",     -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    -- ring2="Defending Ring",      -- ____ [10/10, ___] (__, __) {___, __, __/__}
    -- back=gear.SMN_FC_Cape,       -- ____ [10/__, ___] (__, __) {  1, __, __/__}
    -- waist="Regal Belt",          --   88 [ 3/ 3, ___] (__, __) {___, __, __/__}
    -- Traits/Merits/JP Gifts                                       99, __,  7/ 7
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
    ammo="Sancus Sachet +1",        -- ____ [__/__, ___] (__, __) {119, __, __/__}
    head="Beckoner's Horn +2",      --   51 [ 9/ 9, 120] ( 3, __) {___, __, __/__}
    body="Beckoner's Doublet +2",   --   74 [12/12, 120] (__,  7) {___, __, __/__}
    hands=gear.Nyame_B_hands,
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Caller's Pendant",        -- ____ [__/__, ___] (__, __) {___, 25, __/__}
    ear1="Enmerkar Earring",        -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    waist="Isa Belt",               -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    -- hands="Asteria Mitts +1",    --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    -- back=gear.SMN_FC_Cape,       -- ____ [10/__, ___] (__, __) {  1, __, __/__}
    -- Traits/Merits/JP Gifts                                      ___, __,  7/ 7
    -- 216 HP [51 PDT/41 MDT, 529 M.Eva] (13 Refresh, 15 Perp Cost) {Pet: 121 Lv, 25 Regain, 13 PDT/13 MDT}

    -- main="Gridarvor",            -- ____ [__/__, ___] (__,  5) {___, __, __/__}
    -- sub="Khonsu",                -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    -- ammo="Epitaph",              -- ____ [__/__, ___] (__, __) {119, __, __/__}
    -- head="Beckoner's Horn +3",   --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    -- body="Beckoner's Doublet +3",--   84 [13/13, 130] (__,  8) {___, __, __/__}
    -- hands="Asteria Mitts +1",    --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    -- legs="Assiduity Pants +1",   --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    -- feet="Baayami Sabots +1",    --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    -- neck="Caller's Pendant",     -- ____ [__/__, ___] (__, __) {___, 25, __/__}
    -- ear1="Enmerkar Earring",     -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- ring1="Stikini Ring +1",     -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    -- ring2="Defending Ring",      -- ____ [10/10, ___] (__, __) {___, __, __/__}
    -- back=gear.SMN_FC_Cape,       -- ____ [10/__, ___] (__, __) {  1, __, __/__}
    -- waist="Isa Belt",            -- ____ [__/__, ___] (__, __) {___, __,  3/ 3}
    -- Traits/Merits/JP Gifts                                      ___, __,  7/ 7
    -- 236 HP [55 PDT/45 MDT, 549 M.Eva] (15 Refresh, 16 Perp Cost) {Pet: 121 Lv, 25 Regain, 13 PDT/13 MDT}
  }

  -- Need -6 perp cost
  sets.idle.Spirit = {
    main="Gridarvor",               -- ____ [__/__, ___] (__,  5) {___, __, __/__}
    sub="Khonsu",                   -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}
    ammo="Sancus Sachet +1",        -- ____ [__/__, ___] (__, __) {119, __, __/__}
    head="Beckoner's Horn +2",      --   51 [ 9/ 9, 120] ( 3, __) {___, __, __/__}
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Assiduity Pants +1",      --   43 [__/__, 107] ( 2,  3) {___, __, __/__}
    feet="Baayami Sabots +1",       --   30 [__/__, 139] ( 3, __) {___, __, __/__}
    neck="Loricate Torque +1",      -- ____ [ 6/ 6, ___] (__, __) {___, __, __/__}; DEF+60
    ear2="Beckoner's Earring +1",   -- ____ [ 4/ 4, ___] ( 2, __) {  1, __, __/__}
    ring1="Stikini Ring +1",        -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    ring2="Defending Ring",         -- ____ [10/10, ___] (__, __) {___, __, __/__}
    waist="Regal Belt",             --   88 [ 3/ 3, ___] (__, __) {___, __, __/__}
    -- body=gear.Apogee_A_body,     -- -160 [__/__,  91] ( 4, __) {___, __, __/__}
    -- hands="Asteria Mitts +1",    --   18 [__/__,  43] ( 2, __) {___, __, __/__}
    -- ear1="Cath Palug Earring",   -- ____ [__/__, ___] ( 1, __) {___, __, __/__}
    -- back=gear.SMN_FC_Cape,       -- ____ [10/__, ___] (__, __) {  1, __, __/__}
    -- Traits/Merits/JP Gifts                                      ___, __,  7/ 7
    -- 70 HP [48 PDT/38 MDT, 500 M.Eva] (18 Refresh, 8 Perp Cost) {Pet: 121 Lv, 0 Regain, 7 PDT/7 MDT}

    -- ammo="Epitaph",              -- ____ [__/__, ___] (__, __) {119, __, __/__}
    -- head="Beckoner's Horn +3",   --   61 [10/10, 130] ( 4, __) {___, __, __/__}
    -- ear2="Beckoner's Earring +2",-- ____ [ 6/ 6, ___] ( 3, __) {  1, __, __/__}
    -- 80 HP [51 PDT/41 MDT, 510 M.Eva] (20 Refresh, 8 Perp Cost) {Pet: 121 Lv, 0 Regain, 7 PDT/7 MDT}
  }

  -- TODO: update set
  -- sets.idle.Avatar.Melee = {hands="Regimen Mittens",back="Samanisi Cape",waist="Kuku Stone",legs="Convoker's Spats"}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- TODO: update set
  sets.engaged = {
    head="Beckoner's Horn +2",
    -- body="Tali'ah Manteel +1",
    -- hands="Gazu Bracelet",
    legs="Assid. Pants +1",
    -- feet="Battlecast Gaiters",
    -- neck="Lissome Necklace",
    -- ear1="Telos Earring",
    ear2="Cessance Earring",
    -- ring1="Petrov Ring",
    -- ring2="Apate Ring",
    -- back=gear.SMN_Phys_BP_Cape,
    waist="Grunfeld Rope",
  }
  

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff.Doom = {
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
    -- neck="Nicander's Necklace",  --20
  }
  sets.CP = {
    back=gear.CP_Cape
  }
  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
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
          or (pet and pet.name and pacts.debuff2[pet.name] and pacts.debuff2[pet.name] == spell.english))
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

  -- Warn if trying to do blood pact without enough mp

	if pet.name == spell.english and pet.hpp > 50 then
		add_to_chat(122, "You already have that avatar active!")
		eventArgs.cancel = true
	elseif avatars:contains(spell.english) and pet.isvalid then
		eventArgs.cancel = true
		windower.chat.input('/pet Release <me>')
		windower.chat.input:schedule(2,'/ma "'..spell.english..'" <me>')
	end

  if state.Buff['Astral Conduit'] then
    eventArgs.useMidcastGear = true
  else
    if pet_midaction() then
      eventArgs.cancel = true
      add_to_chat(122, 'Action canceled because pet was midaction.')
    end
    if state.CastingMode.current == 'NirvAM' then
      if spell.type == 'BloodPactWard' or spell.type == 'BloodPactRage' then
        equip(sets.precast.BloodPactWard.NirvAM)
        eventArgs.handled = true
      elseif spell.english == 'Elemental Siphon' then
        equip(sets.precast.JA['Elemental Siphon'].NirvAM)
        eventArgs.handled = true
      end
    end
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
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

  if state.Buff['Astral Conduit'] and spell.type == 'BloodPactRage' then
    equip(sets.midcast[spellMap])
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
  if state.CastingMode.current == 'NirvAM' then
    equip({ main="Nirvana", sub="Elan Strap +1",})
  end

  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if state.Buff['Astral Conduit'] then
    eventArgs.handled = true
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
  if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
    wards.flag = true
    wards.spell = spell.english
    send_command('wait 4; gs c reset_ward_flag')
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

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
  if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
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
  job_update()
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
      if (world.weather_element == 'Light' and not (get_weather_intensity() < 2 and world.weather_element == 'Dark'))
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
  if not pet_midaction() then
    if pet.isvalid then
      if pet.status == 'Engaged' then
        idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
      end
    end
  
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
  if not pet_midaction() then
    if state.CP.current == 'on' then
      meleeSet = set_combine(meleeSet, sets.CP)
    end
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
  if not pet_midaction() then
    if state.CP.current == 'on' then
      defenseSet = set_combine(defenseSet, sets.CP)
    end
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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
  elseif cmdParams[1] == 'test' then
    test()
  end

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if not midaction() and not pet_midaction() then
      job_update()
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
    if get_weather_intensity() == 1 then
      -- If current weather is weak to the current day, it cancels the benefits for
      -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
      -- weather if not.
      -- If the current weather matches the current avatar's element (being used to reduce
      -- perpetuation), don't change it; just accept the penalty on Siphon.
      if world.weather_element == elements.weak_to[world.day_element] and
          (not pet.isvalid or world.weather_element ~= pet.element) then
        stormElementToUse = world.day_element
      end
    end
  end

  -- If we decided to use a storm, set that as the spirit element to cast.
  if stormElementToUse then
    siphonElement = stormElementToUse
  elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
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
    command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
    releaseWait = releaseWait - 4
  end

  if not (pet.isvalid and spirits:contains(pet.name)) then
    command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
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
    if buffactive['light arts'] then
      send_command('input /ja "Addendum: White" <me>')
    elseif buffactive['addendum: white'] then
      add_to_chat(122,'Error: Addendum: White is already active.')
    else
      send_command('input /ja "Light Arts" <me>')
    end
  elseif strategem == 'dark' then
    if buffactive['dark arts'] then
      send_command('input /ja "Addendum: Black" <me>')
    elseif buffactive['addendum: black'] then
      add_to_chat(122,'Error: Addendum: Black is already active.')
    else
      send_command('input /ja "Dark Arts" <me>')
    end
  elseif buffactive['light arts'] or buffactive['addendum: white'] then
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
  elseif buffactive['dark arts']  or buffactive['addendum: black'] then
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
  set_macro_page(2, 6)
end

function test()
  print('pet'..inspect(pet,{depth=1}))
end