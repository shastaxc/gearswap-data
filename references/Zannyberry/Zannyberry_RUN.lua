-- Original: Motenten/Arislan || Modified: Silvermutt

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ Numpad0 ]         Use current Rune
--
--              [ CTRL+` ]          Vivacious Pulse
--              [ ALT+` ]           Temper
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Last Resort
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Souleater
--
--              [ ALT+W ]           Defender (WAR sub)/Weapon Bash (DRK sub)
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--              [ ALT+U ]           Blink
--              [ ALT+I ]           Stoneskin
--              [ ALT+O ]           Phalanx
--              [ ALT+P ]           Aquaveil
--              [ ALT+; ]           Regen IV
--              [ ALT+' ]           Refresh
--              [ ALT+, ]           Blaze Spikes
--              [ ALT+. ]           Ice Spikes
--              [ ALT+/ ]           Shock Spikes
--
--              [ ALT+Q ]           Wild Carrot (BLU sub)
--              [ ALT+W ]           Cocoon (BLU sub)
--              [ ALT+E ]           Refueling (BLU sub)
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs c weaponset current')
    send_command('gs org')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.use_weapon_rearm = true
  rayke_duration = 46
  gambit_duration = 92

  runes.element_of = {['Lux']='Light', ['Tenebrae']='Dark', ['Ignis']='Fire', ['Gelus']='Ice', ['Flabra']='Wind',
      ['Tellus']='Earth', ['Sulpor']='Lightning', ['Unda']='Water'} -- Do not modify
  expended_runes={} -- Do not modify
  rayke_target=nil -- Do not modify
  gambit_target=nil -- Do not modify

  -- /BLU Spell Maps
  blue_magic_maps = {}
  blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
      'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
  blue_magic_maps.Cure = S{'Wild Carrot'}
  blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

  state.Kiting:set('On')
  state.DefenseMode:set('Physical') -- Default to PDT mode
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.CastingMode:options('Normal', 'Safe')
  state.HybridMode:options('Normal', 'LightDef')
  state.IdleMode:options('Normal', 'LightDef')
  state.Knockback = M(false, 'Knockback')
  state.DeathResist = M(false, 'Death Resist Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'Lycurgos'}
  state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
  state.CP = M(false, "Capacity Points Mode")
  state.RearmingLock = M(false, 'Rearming Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
  state.ShowSimpleRaykeGambit = M(false, 'Show Simple Rayke/Gambit Msg')

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')

  send_command('bind @w gs c toggle RearmingLock')
  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind @d gs c toggle DeathResist')

  send_command('bind numpad0 input //gs c rune')
  send_command('bind !` input /ja "Vivacious Pulse" <me>')
  send_command('bind ^` input /ma "Temper" <me>')
  send_command('bind ^- gs c cycleback Runes')
  send_command('bind ^= gs c cycle Runes')
  send_command('bind @a gs c cycle AttackMode')
  send_command('bind @c gs c toggle CP')
  send_command('bind @k gs c toggle Knockback')
  send_command('bind ^pause gs c toggle ShowSimpleRaykeGambit')

  send_command('bind !u input /ma "Blink" <me>')
  send_command('bind !i input /ma "Stoneskin" <me>')
  send_command('bind !o input /ma "Phalanx" <me>')
  send_command('bind !p input /ma "Aquaveil" <me>')

  send_command('bind !; input /ma "Regen IV" <stpc>')
  send_command('bind !\' input /ma "Refresh" <stpc>')

  send_command('bind !, input /ma "Blaze Spikes" <me>')
  send_command('bind !. input /ma "Ice Spikes" <me>')
  send_command('bind !/ input /ma "Shock Spikes" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.set_lockstyle(97)
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'BLU' then
    send_command('bind !q input /ma "Wild Carrot" <stpc>')
    send_command('bind !w input /ma "Cocoon" <me>')
    send_command('bind !e input /ma "Refueling" <me>')
  elseif player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'DRK' then
    send_command('bind !w input /ja "Weapon Bash" <t>')
    send_command('bind ^numpad/ input /ja "Last Resort" <me>')
    send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
    send_command('bind ^numpad- input /ja "Souleater" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  end

  select_default_macro_book()
end

function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')

  send_command('unbind @w')
  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind @d')

  send_command('unbind !`')
  send_command('unbind ^`')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind @a')
  send_command('unbind @c')
  send_command('unbind @k')

  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !o')
  send_command('unbind !p')

  send_command('unbind !;')
  send_command('unbind !\'')
  send_command('unbind !,')
  send_command('unbind !.')
  send_command('unbind !/')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')

  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind numpad0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.TreasureHunter = {
    feet={ name="Herculean Boots", augments={'INT+14','Pet: DEX+2','"Treasure Hunter"+2','Accuracy+13 Attack+13',}},
    hands={ name="Herculean Gloves", augments={'MND+13','CHR+6','"Treasure Hunter"+2','Accuracy+19 Attack+19','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Enmity sets
  sets.Enmity = {ammo="Sapience Orb", head="Halitus Helm", body="Emet Harness", hands="Kurys Gloves",
    legs="Erilaz Leg Guards +1", feet="Erilaz Greaves +1", neck={ name="Unmoving Collar +1", augments={'Path: A',}}, waist="Kasiri belt", left_ear="Cryptic earring", right_ear="Odnowa Earring +1",
    left_ring="Supershear Ring", right_ring="Eihwaz ring", back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
}

  sets.precast.JA = sets.Enmity;

  sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
    body="Runeist's Coat +2",
    legs="Futhark Trousers +2",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
  })
  sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
  sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {
    head="Futhark Bandeau +3"
  })
  sets.precast.JA['Liement'] = set_combine(sets.Enmity, {
    body="Futhark Coat +3",
  })

  sets.MAB = {
    ammo="Seeth. Bomblet +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Futhark Torque +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Shiva Ring +1",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
}

  sets.precast.JA['Lunge'] = set_combine(sets.Enmity, sets.MAB)
  sets.precast.JA['Lunge'].Safe = sets.Enmity

  sets.precast.JA['Swipe'] = set_combine(sets.Enmity, sets.MAB)
  sets.precast.JA['Swipe'].Safe = sets.Enmity

  sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {
    hands="Runeist Mitons"
  })
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {
    feet="Futhark Boots"
  })
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {
    body="Futhark Coat +3",
  })
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {
    hands="Futhark Mitons"
  })

  -- Divine Magic skill
  sets.precast.JA['Vivacious Pulse'] = {
    head="Erilaz Galea +1", --Aug JA [91]
    neck="Incanter's Torque", --10 [0]
    legs="Rune. Trousers +2", --19 [80]
    ring1="Stikini Ring +1", 
    ring2="Stikini Ring +1",
  } 

  -- Fast cast sets for spells
  sets.precast.FC = { ammo="Sapience Orb", head="Runeist's Bandeau +2", body={ name="Adhemar Jacket", augments={'HP+80','"Fast Cast"+7','Magic dmg. taken -3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2", feet="Carmine Greaves", neck={ name="Unmoving Collar +1", augments={'Path: A',}}, waist="Kasari belt",
    left_ear="Tuista Earring", right_ear="Odnowa Earring +1", left_ring="moonbeam Ring", right_ring="kishar ring",
    back={ name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}, }
	
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    legs="Futhark Trousers +2",
  })

  sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    --ammo="Impatiens",
    -- ear2="Mendi. Earring"
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  sets.Macc = {
    ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Futhark Torque +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Stikini Ring +1",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
}


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Meghanada Chausses +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Ilabrat Ring",
    ring2="Niqmaddu Ring",
    back=gear.RUN_WS2_Cape,
  }

  sets.precast.WS.Safe = {
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Futhark Torque +1", augments={'Path: A',}},
	left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
}

  -- 85% STR mod
  sets.precast.WS['Resolution'] = {
    ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}

  sets.precast.WS['Resolution'].Safe = set_combine(sets.precast.WS.Safe, {
    ammo="Seething Bomblet +1",
    waist="Fotia Belt",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
})
  sets.precast.WS['Resolution'].MaxTP = set_combine(sets.precast.WS['Resolution'], {
    ear2="Odnowa Earring +1",
    -- ear2="Vulcan's Pearl",
  })
  sets.precast.WS['Resolution'].LowAcc = set_combine(sets.precast.WS['Resolution'], {
  })
  sets.precast.WS['Resolution'].LowAccMaxTP = set_combine(sets.precast.WS['Resolution'].LowAcc, {
  })
  sets.precast.WS['Resolution'].MidAcc = set_combine(sets.precast.WS['Resolution'].LowAcc, {
  })
  sets.precast.WS['Resolution'].MidAccMaxTP = set_combine(sets.precast.WS['Resolution'].MidAcc, {
  })
  sets.precast.WS['Resolution'].HighAcc = set_combine(sets.precast.WS['Resolution'].MidAcc, {
  })
  sets.precast.WS['Resolution'].HighAccMaxTP = set_combine(sets.precast.WS['Resolution'].HighAcc, {
  })

  -- 80% DEX mod
  sets.precast.WS['Dimidiation'] = {
    ammo="Knobkierrie",
    head={ name="Herculean Helm", augments={'Accuracy+9','Chance of successful block +2','Weapon skill damage +8%',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands="Meg. Gloves +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

  sets.precast.WS['Dimidiation'].Safe = set_combine(sets.precast.WS.Safe, {
    ammo="Knobkierrie",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
  })
  sets.precast.WS['Dimidiation'].MaxTP = set_combine(sets.precast.WS['Dimidiation'], {
    ear2="Odr Earring",
  })
  sets.precast.WS['Dimidiation'].LowAcc = set_combine(sets.precast.WS['Dimidiation'], {
  })
  sets.precast.WS['Dimidiation'].LowAccMaxTP = set_combine(sets.precast.WS['Dimidiation'].LowAcc, {
  })
  sets.precast.WS['Dimidiation'].MidAcc = set_combine(sets.precast.WS['Dimidiation'].LowAcc, {
  })
  sets.precast.WS['Dimidiation'].MidAccMaxTP = set_combine(sets.precast.WS['Dimidiation'].MidAcc, {
  })
  sets.precast.WS['Dimidiation'].HighAcc = set_combine(sets.precast.WS['Dimidiation'].MidAcc, {
  })
  sets.precast.WS['Dimidiation'].HighAccMaxTP = set_combine(sets.precast.WS['Dimidiation'].HighAcc, {
  })

  sets.precast.WS['Herculean Slash'] = set_combine(sets.Macc, {
    ear2="Moonshade Earring",
    ring2="Niqmaddu Ring",
  })
  sets.precast.WS['Herculean Slash'].Safe = set_combine(sets.precast.WS.Safe, {
  })
  sets.precast.WS['Herculean Slash'].MaxTP = set_combine(sets.precast.WS['Herculean Slash'], {
  })
  sets.precast.WS['Herculean Slash'].LowAcc = set_combine(sets.precast.WS['Herculean Slash'], {
  })
  sets.precast.WS['Herculean Slash'].LowAccMaxTP = set_combine(sets.precast.WS['Herculean Slash'].LowAcc, {
  })
  sets.precast.WS['Herculean Slash'].MidAcc = set_combine(sets.precast.WS['Herculean Slash'].LowAcc, {
  })
  sets.precast.WS['Herculean Slash'].MidAccMaxTP = set_combine(sets.precast.WS['Herculean Slash'].MidAcc, {
  })
  sets.precast.WS['Herculean Slash'].HighAcc = set_combine(sets.precast.WS['Herculean Slash'].MidAcc, {
  })
  sets.precast.WS['Herculean Slash'].HighAccMaxTP = set_combine(sets.precast.WS['Herculean Slash'].HighAcc, {
  })

  -- Magic accuracy required for Shockwave
  sets.precast.WS['Shockwave'] = set_combine(sets.Macc, {
    ear2="Moonshade Earring",
    ring2="Niqmaddu Ring",
  })
  sets.precast.WS['Shockwave'].Safe = set_combine(sets.precast.WS.Safe, {
  })
  sets.precast.WS['Shockwave'].MaxTP = set_combine(sets.precast.WS['Shockwave'], {
  })
  sets.precast.WS['Shockwave'].LowAcc = set_combine(sets.precast.WS['Shockwave'], {
  })
  sets.precast.WS['Shockwave'].LowAccMaxTP = set_combine(sets.precast.WS['Shockwave'].LowAcc, {
  })
  sets.precast.WS['Shockwave'].MidAcc = set_combine(sets.precast.WS['Shockwave'].LowAcc, {
  })
  sets.precast.WS['Shockwave'].MidAccMaxTP = set_combine(sets.precast.WS['Shockwave'].MidAcc, {
  })
  sets.precast.WS['Shockwave'].HighAcc = set_combine(sets.precast.WS['Shockwave'].MidAcc, {
  })
  sets.precast.WS['Shockwave'].HighAccMaxTP = set_combine(sets.precast.WS['Shockwave'].HighAcc, {
  })

  sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
  })
  sets.precast.WS['Fell Cleave'].Safe = set_combine(sets.precast.WS.Safe, {
  })
  sets.precast.WS['Fell Cleave'].MaxTP = set_combine(sets.precast.WS['Fell Cleave'], {
  })
  sets.precast.WS['Fell Cleave'].LowAcc = set_combine(sets.precast.WS['Fell Cleave'], {
  })
  sets.precast.WS['Fell Cleave'].LowAccMaxTP = set_combine(sets.precast.WS['Fell Cleave'].LowAcc, {
  })
  sets.precast.WS['Fell Cleave'].MidAcc = set_combine(sets.precast.WS['Fell Cleave'].LowAcc, {
  })
  sets.precast.WS['Fell Cleave'].MidAccMaxTP = set_combine(sets.precast.WS['Fell Cleave'].MidAcc, {
  })
  sets.precast.WS['Fell Cleave'].HighAcc = set_combine(sets.precast.WS['Fell Cleave'].MidAcc, {
  })
  sets.precast.WS['Fell Cleave'].HighAccMaxTP = set_combine(sets.precast.WS['Fell Cleave'].HighAcc, {
  })

  sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Fell Cleave']
  sets.precast.WS['Steel Cyclone'].Safe = sets.precast.WS['Fell Cleave'].Safe
  sets.precast.WS['Steel Cyclone'].MaxTP = sets.precast.WS['Fell Cleave'].MaxTP
  sets.precast.WS['Steel Cyclone'].LowAcc = sets.precast.WS['Fell Cleave'].LowAcc
  sets.precast.WS['Steel Cyclone'].LowAccMaxTP = sets.precast.WS['Fell Cleave'].LowAccMaxTP
  sets.precast.WS['Steel Cyclone'].MidAcc = sets.precast.WS['Fell Cleave'].MidAcc
  sets.precast.WS['Steel Cyclone'].MidAccMaxTP = sets.precast.WS['Fell Cleave'].MidAccMaxTP
  sets.precast.WS['Steel Cyclone'].HighAcc = sets.precast.WS['Fell Cleave'].HighAcc
  sets.precast.WS['Steel Cyclone'].HighAccMaxTP = sets.precast.WS['Fell Cleave'].HighAccMaxTP

  sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
  sets.precast.WS['Upheaval'].Safe = sets.precast.WS['Resolution'].Safe
  sets.precast.WS['Upheaval'].MaxTP = sets.precast.WS['Resolution'].MaxTP
  sets.precast.WS['Upheaval'].LowAcc = sets.precast.WS['Resolution'].LowAcc
  sets.precast.WS['Upheaval'].LowAccMaxTP = sets.precast.WS['Resolution'].LowAccMaxTP
  sets.precast.WS['Upheaval'].MidAcc = sets.precast.WS['Resolution'].MidAcc
  sets.precast.WS['Upheaval'].MidAccMaxTP = sets.precast.WS['Resolution'].MidAccMaxTP
  sets.precast.WS['Upheaval'].HighAcc = sets.precast.WS['Resolution'].HighAcc
  sets.precast.WS['Upheaval'].HighAccMaxTP = sets.precast.WS['Resolution'].HighAccMaxTP

  sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Shield Break'].Safe = sets.precast.WS['Shockwave'].Safe
  sets.precast.WS['Shield Break'].MaxTP = sets.precast.WS['Shockwave'].MaxTP
  sets.precast.WS['Shield Break'].LowAcc = sets.precast.WS['Shockwave'].LowAcc
  sets.precast.WS['Shield Break'].LowAccMaxTP = sets.precast.WS['Shockwave'].LowAccMaxTP
  sets.precast.WS['Shield Break'].MidAcc = sets.precast.WS['Shockwave'].MidAcc
  sets.precast.WS['Shield Break'].MidAccMaxTP = sets.precast.WS['Shockwave'].MidAccMaxTP
  sets.precast.WS['Shield Break'].HighAcc = sets.precast.WS['Shockwave'].HighAcc
  sets.precast.WS['Shield Break'].HighAccMaxTP = sets.precast.WS['Shockwave'].HighAccMaxTP

  sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Armor Break'].Safe = sets.precast.WS['Shockwave'].Safe
  sets.precast.WS['Armor Break'].MaxTP = sets.precast.WS['Shockwave'].MaxTP
  sets.precast.WS['Armor Break'].LowAcc = sets.precast.WS['Shockwave'].LowAcc
  sets.precast.WS['Armor Break'].LowAccMaxTP = sets.precast.WS['Shockwave'].LowAccMaxTP
  sets.precast.WS['Armor Break'].MidAcc = sets.precast.WS['Shockwave'].MidAcc
  sets.precast.WS['Armor Break'].MidAccMaxTP = sets.precast.WS['Shockwave'].MidAccMaxTP
  sets.precast.WS['Armor Break'].HighAcc = sets.precast.WS['Shockwave'].HighAcc
  sets.precast.WS['Armor Break'].HighAccMaxTP = sets.precast.WS['Shockwave'].HighAccMaxTP

  sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Weapon Break'].Safe = sets.precast.WS['Shockwave'].Safe
  sets.precast.WS['Weapon Break'].MaxTP = sets.precast.WS['Shockwave'].MaxTP
  sets.precast.WS['Weapon Break'].LowAcc = sets.precast.WS['Shockwave'].LowAcc
  sets.precast.WS['Weapon Break'].LowAccMaxTP = sets.precast.WS['Shockwave'].LowAccMaxTP
  sets.precast.WS['Weapon Break'].MidAcc = sets.precast.WS['Shockwave'].MidAcc
  sets.precast.WS['Weapon Break'].MidAccMaxTP = sets.precast.WS['Shockwave'].MidAccMaxTP
  sets.precast.WS['Weapon Break'].HighAcc = sets.precast.WS['Shockwave'].HighAcc
  sets.precast.WS['Weapon Break'].HighAccMaxTP = sets.precast.WS['Shockwave'].HighAccMaxTP

  sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']
  sets.precast.WS['Full Break'].Safe = sets.precast.WS['Shockwave'].Safe
  sets.precast.WS['Full Break'].MaxTP = sets.precast.WS['Shockwave'].MaxTP
  sets.precast.WS['Full Break'].LowAcc = sets.precast.WS['Shockwave'].LowAcc
  sets.precast.WS['Full Break'].LowAccMaxTP = sets.precast.WS['Shockwave'].LowAccMaxTP
  sets.precast.WS['Full Break'].MidAcc = sets.precast.WS['Shockwave'].MidAcc
  sets.precast.WS['Full Break'].MidAccMaxTP = sets.precast.WS['Shockwave'].MidAccMaxTP
  sets.precast.WS['Full Break'].HighAcc = sets.precast.WS['Shockwave'].HighAcc
  sets.precast.WS['Full Break'].HighAccMaxTP = sets.precast.WS['Shockwave'].HighAccMaxTP


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast['Enhancing Magic'] = {
    head="Erilaz Galea +1",
    hands="Runeist Mitons +1",
    legs=gear.Carmine_D_legs,
    waist="Olympus Sash",
    neck="Incanter's Torque",
    ear1="Andoaa Earring",
    ear2="Mimir Earring",
    -- body="Manasa Chasuble",
    -- ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
    -- back="Merciful Cape",
  }

  sets.midcast.EnhancingDuration = {
    head="Erilaz Galea +1",
    hands="Regal Gauntlets",
    legs="Futhark Trousers +3",
  }

  sets.midcast['Phalanx'] = {
	ammo="Staunch Tathlum",
    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
    body={ name="Taeon Tabard", augments={'Pet: "Mag.Atk.Bns."+19','Spell interruption rate down -10%','Phalanx +3',}},
    hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
    legs={ name="Taeon Tights", augments={'Spell interruption rate down -9%','Phalanx +3',}},
    feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Kasiri Belt",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini ring +1",
    right_ring="Stikini ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10',}},
}

  -- 10% SIRD from merits
  sets.midcast['Aquaveil'] = { ammo="Staunch Tathlum", head={ name="Taeon Chapeau", augments={'Mag. Evasion+19','Spell interruption rate down -9%','HP+45',}},
    body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}}, hands={ name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}},
    legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}}, feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
    neck="Moonbeam Necklace", waist="Audumbla Sash", left_ear="Tuisto Earring", right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring", right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
}
  
  sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {
    head="Runeist's Bandeau +2",
    neck="Sacro Gorget"
  })
  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
    head="Erilaz Galea +1",
    waist="Gishdubar Sash",
  })
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Siegel Sash"
  })
  sets.midcast.Stoneskin.Safe = set_combine(sets.midcast.Stoneskin, {
    ammo="Staunch Tathlum",
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
    back={ name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}},
  })
  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
    -- ring2="Sheltered Ring"
  })
  sets.midcast.Protect.Safe = set_combine(sets.midcast['Enhancing Magic'], {
    ammo="Staunch Tathlum +1",
    waist="Audumbla Sash",
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
    -- back="Moonlight Cape",
  })
  sets.midcast.Shell = sets.midcast.Protect
  sets.midcast.Shell.Safe = sets.midcast.Protect.Safe

  sets.midcast.Flash = sets.Enmity
  sets.midcast.Foil = sets.Enmity
  sets.midcast.Stun = sets.Enmity
  sets.midcast.Utsusemi = {
    ammo="Staunch Tathlum +1", --11
    waist="Audumbla Sash", --10
  } -- 21% Spell Interrupt

  sets.midcast['Jettatura'] = set_combine(sets.Enmity, sets.TreasureHunter)
  sets.midcast['Geist Wall'] = set_combine(sets.Enmity, sets.TreasureHunter)
  sets.midcast['Sheep Song'] = sets.midcast['Aquaveil']
  sets.midcast['Soporific'] = sets.midcast['Aquaveil']

  sets.midcast['Blue Magic'] = {}
  sets.midcast['Blue Magic'].Enmity = sets.Enmity
  sets.midcast['Blue Magic'].Buffs = sets.midcast.EnhancingDuration
  sets.midcast['Blue Magic'].Cure = {
    legs="Ayanmo Cosciales +2",
    ring1="Lebeche Ring", -- 3
    waist="Gishdubar Sash", --(10)
    -- body="Vrikodara Jupon", -- 13
    -- hands="Buremte Gloves", --(13)
    -- feet="Skaoi Boots", --7
    -- neck="Phalaina Locket", -- 4(4)
    -- ear1="Roundel Earring", -- 5
    -- ear2="Mendi. Earring", -- 5
    -- back="Solemnity Cape", -- 7
  }
  sets.midcast['Blue Magic'].Cure.Safe = set_combine(sets.midcast['Blue Magic'].Cure, {
    ammo="Staunch Tathlum +1",
    waist="Audumbla Sash",
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
    -- back="Moonlight Cape",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    sub="Mensch strap +1",            
    ammo="Staunch Tathlum", 
    head="Nyame Helm",         
    body="Nyame Mail",       
    legs="Nyame Flanchard",  
    ear2="Odnowa Earring +1", 
    ring1="Defending Ring",
} 

  sets.defense.Knockback = {
    -- back="Repulse Mantle"
  }

  -- PDT cap is 50%, Protect V = 0%
  sets.defense.PDT = {
	sub="Mensch strap +1",
    ammo="Yamarang",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck={ name="Futhark Torque +1", augments={'Path: A',}},
    waist="Engraved Belt",
    left_ear="Tuisto Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},
}
  
  -- MDT cap is 50%, Shell V = 29%
  sets.defense.MDT = {
	sub="Utu Grip",
    ammo="Yamarang",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Turms Mittens",
    legs="Nyame Flanchard",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Futhark Torque +1", augments={'Path: A',}},
    waist="Engraved Belt",
    left_ear="Sanare Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
}
  sets.defense.Parry = {
    hands="Turms Mittens", --Parry: Recover HP+75
    legs="Erilaz Leg Guards +1", --Inquartata+2
    feet="Turms Leggings", --Inquartata+5
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},
    -- hands="Turms Mittens +1", --Parry: Recover HP+100
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
	sub="Utu Grip",
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+4','AGI+6','Attack+8',}},
    neck="Anu Torque",
    waist="Windbuffet Belt",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    neck="Combatant's Torque",
    waist="Kentarch belt +1",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring1="Chirich Ring",
    ring2="Chirich Ring",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Falcon Eye",
    legs="Carmine cuisses +1",
    ear1="Odr Earring",
    ear2="Dignitary's Earring",
    -- ammo="C. Palug Stone",
    -- head="Carmine Mask +1",
    -- body="Carm. Sc. Mail +1",
    -- hands="Runeist's Mitons +3",
    -- waist="Olseni Belt",
  })
  sets.engaged.Aftermath = {
    head="Ayanmo Zucchetto +2",
    neck="Anu Torque",
    ear1="Sherida Earring",
    ring1="Chirich Ring",
    waist="Kentarch Belt +1",
    -- body="Ashera Harness",
    ear2="Dedition Earring",
    ring2="Chirich Ring",
  }


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Turms Cap +1",
	ring1="Karieyh ring",
  }
  sets.latent_regen = {
    head="Turms Cap +1", --7
    body="Futhark Coat +3", --5
    hands="Regal Gauntlets", --10
    feet="Turms Leggings", --5
    neck="Bathy Choker +1", --3
    ear1="Infused Earring", --1
    ring2="Sheltered ring", --1
  }
  sets.latent_refresh = {
    ammo="Homiliary", --1
    head="Rawhide mask", --1
    body="Runeist's Coat +2", --2
    hands={ name="Herculean Gloves", augments={'Attack+1','AGI+4','"Refresh"+1','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}, --1
    feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Mag. Acc.+27','"Refresh"+2',}}, --2
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.idle = sets.defense.MDT

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

  sets.idle.Weak = sets.defense.MDT


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, sets.LightDef)
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, sets.LightDef)
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, sets.LightDef)
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, sets.LightDef)

  -- Needs updating
  sets.engaged.Aftermath.LightDef = {
    legs="Meghanada Chausses +2",
    ring2="Defending Ring",
    waist="Sailfi Belt +1",
    head="Ayanmo Zucchetto +2",
    -- head="Ayanmo Zucchetto +2",
    -- body="Ashera Harness",
    -- hands=gear.Adhemar_A_hands,
    -- legs="Meghanada Chausses +2",
    -- feet=gear.Herc_STP_feet,
    -- neck="Futhark Torque +2",
    -- ear1="Sherida Earring",
    -- ear2="Dedition Earring",
    -- ring1="Moonlight Ring",
    -- ring2="Defending Ring",
    -- back=gear.RUN_TP_Cape,
    -- waist="Sailfi Belt +1",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
	ring1="Saida ring",
    ring2="Saida ring", 
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    legs="Carmine cuisses +1",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.DeathResist = {
    ring1="Eihwaz Ring", --10%
    ring2="Warden's Ring", --10%
  }
  sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {
    back="Evasionist's Cape"
  })
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  -- Weapon Sets
  sets.WeaponSet = {}
  sets.WeaponSet["Aettir"] = {
    main="Aettir",
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

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.cancel_outranged_ws(spell, eventArgs)
  silibs.cancel_on_blocking_status(spell, eventArgs)

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

  -- Use Vallation if Valiance is on cooldown
  if spell.english == 'Valiance' then
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if abil_recasts[spell.recast_id] > 0 then
      send_command('input /jobability "Vallation" <me>')
      eventArgs.cancel = true
      return
    -- Cancel Vallation if using Valiance
    elseif spell.english == 'Valiance' and buffactive['vallation'] then
      cast_delay(0.2)
      send_command('cancel Vallation') -- command requires 'cancel' add-on to work
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
  if spell.type == "WeaponSkill" then
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
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.english == 'Lunge' or spell.english == 'Swipe' then
    if (spell.element == world.day_element or spell.element == world.weather_element) then
      equip(sets.Obi)
    end
  end
  if state.DefenseMode.value == 'None' then
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
      equip(sets.midcast.EnhancingDuration)
      if spellMap == 'Refresh' then
        equip(sets.midcast.Refresh)
      end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
      equip(sets.midcast.EnhancingDuration)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_aftercast(spell, action, spellMap, eventArgs)
  state.CastingMode:reset()

  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  if spell.name == 'Rayke' then
    if spell.interrupted then
      expended_runes = {}
    else
      -- Record Rayke target
      rayke_target = spell.target

      -- Print chat message
      local element_potencies = get_element_potencies()
      local el_msg = ''
      if not state.ShowSimpleRaykeGambit.value then
        for k,v in pairs(element_potencies) do
          el_msg = el_msg..'('..v.element
          if v.count == 1 then
            el_msg = el_msg..string.char(129,171)
          elseif v.count == 2 then
            el_msg = el_msg..string.char(129,171)..string.char(129,171)
          elseif v.count == 3 then
            el_msg = el_msg..string.char(129,171)..string.char(129,171)..string.char(129,171)
          end
          el_msg = el_msg..') '
        end
      end

      send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png') -- Requires Timers plugin
      send_command('@input '..chat_mode..' [Rayke] Resist Down '..el_msg..' '..string.char(129, 168)..'<t>;')
      coroutine.schedule(display_rayke_worn, rayke_duration)
      expended_runes = {} -- Reset tracking of expended runes
    end
  elseif spell.name == 'Gambit' then
    if spell.interrupted then
      expended_runes = {}
    else
      -- Record Rayke target
      gambit_target = spell.target

      -- Print chat message
      local element_potencies = get_element_potencies()
      local el_msg = ''
      if not state.ShowSimpleRaykeGambit.value then
        for k,v in pairs(element_potencies) do
          el_msg = el_msg..'('..v.element
          if v.count == 1 then
            el_msg = el_msg..string.char(129,171)
          elseif v.count == 2 then
            el_msg = el_msg..string.char(129,171)..string.char(129,171)
          elseif v.count == 3 then
            el_msg = el_msg..string.char(129,171)..string.char(129,171)..string.char(129,171)
          end
          el_msg = el_msg..') '
        end
      end

      send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png') -- Requires Timers plugin
      send_command('@input '..chat_mode..' [Gambit] M.Def Down '..el_msg..' '..string.char(129,168)..'<t>;')
      coroutine.schedule(display_gambit_worn, gambit_duration)
      expended_runes = {} -- Reset tracking of expended runes
    end
  end
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

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.SleepyHead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  if buff == 'Embolden' then
    if gain then
      equip(sets.Embolden)
      disable('head','legs','back')
    else
      enable('head','legs','back')
    end
  end

  if buff:startswith('Aftermath') then
    state.Buff.Aftermath = gain
    customize_melee_set()
    handle_equipping_gear(player.status)
  end

  -- Update gear for these specific buffs
  if buff == "terror" or buff == "doom" or buff == "Embolden" or buff == "Battuta" or buff:startswith("Aftermath") then
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

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if state.Knockback.value == true then
    idleSet = set_combine(idleSet, sets.defense.Knockback)
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

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
      and state.DefenseMode.value == 'None' then
    if state.HybridMode.value == "LightDef" then
      meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.LightDef)
    else
      meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end
  end
  if state.Knockback.value == true then
    meleeSet = set_combine(meleeSet, sets.defense.Knockback)
  end
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
    meleeSet = set_combine(meleeSet, sets.Special.SleepyHead)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if buffactive['Battuta'] then
    defenseSet = set_combine(defenseSet, sets.defense.Parry)
  end
  if state.Knockback.value == true then
    defenseSet = set_combine(defenseSet, sets.defense.Knockback)
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
    defenseSet = set_combine(defenseSet, sets.Special.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local r_msg = state.Runes.current
  local r_color = ''
  if state.Runes.current == 'Ignis' then r_color = 167
  elseif state.Runes.current == 'Gelus' then r_color = 210
  elseif state.Runes.current == 'Flabra' then r_color = 204
  elseif state.Runes.current == 'Tellus' then r_color = 050
  elseif state.Runes.current == 'Sulpor' then r_color = 215
  elseif state.Runes.current == 'Unda' then r_color = 207
  elseif state.Runes.current == 'Lux' then r_color = 001
  elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

  local msg = ''
  if state.Knockback.value == true then
    msg = msg .. ' Knockback Resist |'
  end
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
      ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
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
    if state.OffenseMode.value ~= 'Normal' then
      wsmode = state.OffenseMode.value
    end

    if player.tp > 2900 then
      wsmode = wsmode..'MaxTP'
    end
  end

  return wsmode
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
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

function get_element_potencies()
  local element_potencies = {}
  for k,rune in pairs(expended_runes) do
    -- Get rune's corresponding element
    local el = runes.element_of[rune]
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

function display_rayke_worn()
  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  -- Ensure execution only once by checking for saved target data
  if rayke_target ~= nil then
    send_command('@input '..chat_mode..' [Rayke] Just wore off!;')
    -- If timer still exists, clear it
    send_command('@timers d "Rayke ['..rayke_target.name..']"') -- Requires Timers plugin

    rayke_target = nil -- Reset target
  end
end

function display_gambit_worn()
  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  -- Ensure execution only once by checking for saved target data
  if gambit_target ~= nil then
    send_command('@input '..chat_mode..' [Gambit] Just wore off!;')
    -- If timer still exists, clear it
    send_command('@timers d "Gambit ['..gambit_target.name..']"') -- Requires Timers plugin

    gambit_target = nil -- Reset target
  end
end

function display_rayke_gambit_worn()
  local chat_mode = '/p'
  if windower.ffxi.get_party().party1_count == 1 then
    chat_mode = '/echo'
  end

  send_command('@input '..chat_mode..' [Rayke & Gambit] Just wore off!;')
  -- If timer still exists, clear it
  send_command('@timers d "Rayke ['..rayke_target.name..']"') -- Requires Timers plugin
  -- If timer still exists, clear it
  send_command('@timers d "Gambit ['..gambit_target.name..']"') -- Requires Timers plugin

  rayke_target = nil -- Reset target
  gambit_target = nil -- Reset target
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

function job_self_command(cmdParams, eventArgs)
  gearinfo(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
  elseif cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  elseif cmdParams[1]:lower() == 'toyweapon' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2]:lower() == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1]:lower() == 'weaponset' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2]:lower() == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1]:lower() == 'test' then
    test()
  end
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if not midaction() then
      job_update()
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

windower.raw_register_event('incoming chunk', function(id, data, modified, injected, blocked)
  -- Listen for kill message (when an enemy is defeated)
  if id == 0x029 then -- Combat messages
    local message_id = data:unpack("H",0x19)%2^15 -- Cut off the most significant bit
    if message_id == 6 then
      local defeated_mob_id = data:unpack("I",0x09)
      if (rayke_target ~= nil and defeated_mob_id == rayke_target.id) and (gambit_target ~= nil and defeated_mob_id == gambit_target.id) then
        -- Display message that Rayke and Gambit have worn off due to mob death (if applicable)
        display_rayke_gambit_worn()
      elseif rayke_target ~= nil and defeated_mob_id == rayke_target.id then
        -- Display message that Rayke has worn off (because Rayked mob was killed)
        display_rayke_worn()
      elseif gambit_target ~= nil and defeated_mob_id == gambit_target.id then
        -- Display message that Gambit has worn off (because Gambited mob was killed)
        display_gambit_worn()
      end
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'BLU' then
    set_macro_page(1, 5)
  elseif player.sub_job == 'DRK' or player.sub_job == 'BLM' then
    set_macro_page(2, 5)
  elseif player.sub_job == 'WHM' then
    set_macro_page(3, 5)
  elseif player.sub_job == 'WAR' then
    set_macro_page(4, 5)
  else
    set_macro_page(5, 5)
  end
end
