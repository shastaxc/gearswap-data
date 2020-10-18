-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
lua--              [ ALT+F ]     		Cycle Toy Weapon Mode
--              [ ALT+G ]   		Cycleback Toy Weapon Mode
--              [ CTRL+F ]    		Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Weapon Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ CTRL+- ]          Yonin
--              [ CTRL+= ]          Innin
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              [ ALT+W ]           Defender
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--              [ WIN+/ ]           Utsusemi: San
--
--  Other:
--              [ ALT+D ]           Cancel Invisible/Hide & Use Key
--              [ ALT+S ]           Turn 180 degrees in place
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  state.Buff.Migawari = buffactive.migawari or false
  state.Buff.Doom = buffactive.doom or false
  state.Buff.Yonin = buffactive.Yonin or false
  state.Buff.Innin = buffactive.Innin or false
  state.Buff.Futae = buffactive.Futae or false
  state.Buff.Sange = buffactive.Sange or false

  include('Mote-TreasureHunter')

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

  lockstyleset = 20
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'DT')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
  state.PhysicalDefenseMode:options('PDT', 'Evasion')

  state.MagicBurst = M(false, 'Magic Burst')
  state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
  state.CP = M(false, "Capacity Points Mode")
  state.WeaponLock = M(false, 'Weapon Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}


  options.ninja_tool_warning_limit = 10

  -- Additional local binds
  include('Global-Binds.lua')

  send_command('lua l gearinfo')

  send_command('bind !d gs c usekey')
  send_command('bind !s gs c faceaway')
  send_command('bind @w gs c toggle WeaponLock')
  
  send_command('bind !f gs c toyweapon cycle')
  send_command('bind !g gs c toyweapon cycleback')
  send_command('bind ^f gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind ^- input /ja "Yonin" <me>')
  send_command('bind ^= input /ja "Innin" <me>')
  send_command('bind @/ input /ma "Utsusemi: San" <me>')

  send_command('bind @a gs c cycle AttackMode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numlock input /ja "Innin" <me>')
  send_command('bind !numlock input /ja "Yonin" <me>')

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  end

  -- Whether a warning has been given for low ninja tools
  state.warned = M(false)

  select_default_macro_book()
  set_lockstyle()

  state.Auto_Kite = M(false, 'Auto_Kite')
  Haste = 0
  DW_needed = 0
  DW = false
  moving = false
  update_combat_form()
  determine_haste_group()
end

function user_unload()
  send_command('unbind !d')
  send_command('unbind !s')
  send_command('unbind @w')
  
  send_command('unbind !f')
  send_command('unbind !g')
  send_command('unbind ^f')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind @/')
  send_command('unbind @a')
  send_command('unbind @c')
  send_command('unbind @t')
  send_command('unbind ^numlock')
  send_command('unbind !numlock')
  send_command('unbind ^numpad/')
  send_command('unbind !w')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad+')
  send_command('unbind !numpad+')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad2')

  send_command('unbind #`')
  send_command('unbind #1')
  send_command('unbind #2')
  send_command('unbind #3')
  send_command('unbind #4')
  send_command('unbind #5')
  send_command('unbind #6')
  send_command('unbind #7')
  send_command('unbind #8')
  send_command('unbind #9')
  send_command('unbind #0')

  send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Precast sets
  --------------------------------------

  -- Enmity set
  sets.Enmity = {
    ammo="Date Shuriken", --3
    head={ name="Naga Somen", augments={'HP+50','VIT+10','Evasion+20',}}, --0
    body="Emet Harness +1", --10
    legs="Zoar Subligar +1", --6
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}}, --8
    neck="Unmoving Collar +1", --10
    waist="Trance Belt", --4
    left_ear="Friomisi Earring", --2
	right_ear="Cryptic Earring", --4
    left_ring="Eihwaz Ring", --5
    right_ring="Supershear Ring", --5
    back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}, --10
  }

  sets.precast.JA['Provoke'] = sets.Enmity
  sets.precast.JA['Warcry'] = sets.Enmity
  
  sets.precast.JA['Mijin Gakure'] = {
    legs="Mochi. Hakama +2"
  }
  sets.precast.JA['Futae'] = {
    hands="Hattori Tekko +1"
  }
  sets.precast.JA['Sange'] = {
    body="Mochi. Chainmail +1"
  }
  sets.precast.JA['Innin'] = {
    head="Mochi. Hatsuburi +3"
  }
  sets.precast.JA['Yonin'] = {
    head="Mochi. Hatsuburi +3"
  }

  sets.precast.Waltz = {
    ammo="Yamarang",
	head="Mummu Bonnet +2",
    -- body="Passion Jacket",
    -- legs="Dashing Subligar",
    -- ring1="Asklepian Ring",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  -- Fast cast sets for spells

  sets.precast.FC = {
    ammo="Sapience Orb", --2
    head={ name="Herculean Helm", augments={'"Fast Cast"+4','CHR+1',}}, --11
    body={ name="Taeon Tabard", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. crit. hit dmg. +8%',}}, --8
	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Fast Cast"+5','MND+10','"Mag.Atk.Bns."+8',}}, --5
	neck="Orunmila's Torque", --5
    waist="Oneiros Belt", --0
    left_ear="Loquac. Earring", --2
    right_ear="Enchntr. Earring +1", --2
    left_ring="Prolix Ring", --2
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}, --10
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    -- body="Mochi. Chainmail +1", --10
    -- neck="Magoraga Beads", --10
  })

  sets.precast.RA = {
    -- head=gear.Taeon_RA_head, --10/0
    -- body=gear.Taeon_RA_body, --10/0
    -- legs=gear.Adhemar_D_legs, --10/13
  }

  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    -- ammo="Aurgelmir Orb +1",
    head="Hachiya Hatsu. +3",
    -- body=gear.Herc_WS_body,
    -- hands=gear.Adhemar_B_hands,
    legs="Mochi. Hakama +2",
    -- feet=gear.Herc_WSD_feet,
    -- neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    -- ring1="Regal Ring",
    -- ring2="Epaminondas's Ring",
    back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}},
    -- waist="Fotia Belt",
  } -- default set

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    -- ammo="Voluspa Tathlum",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    -- legs=gear.Herc_WS_legs,
    -- feet=gear.Herc_STP_feet,
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",
    head="Hachiya Hatsu. +3",
    body="Ken. Samue +1",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Rancor Collar",
    waist="Sailfi Belt +1",
    left_ear="Odr Earring",
    right_ear="Ishvara Earring",
    left_ring="Mummu Ring",
    right_ring="Petrov Ring",
    back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}},
  })

  sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {

  })

  sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}},
    waist="Sailfi Belt +1",
  })

  sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'], {
    -- ammo="Voluspa Tathlum",
    -- ear2="Telos Earring",
  })

  sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
    ammo="Date Shuriken",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet="Hiza. Sune-Ate +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear="Lugra Earring +1",
    left_ring="Tyrant's Ring",
    right_ring="Ramuh Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  })

  sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {
    -- ammo="Voluspa Tathlum",
    -- legs="Ken. Hakama +1",
  })

  sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS['Blade: Shun'], {

  })

  sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'], {

  })

  sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {
    -- ring2="Ilabrat Ring",
  })

  sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head="Hachiya Hatsu. +3",
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+19','Magic burst dmg.+5%','MND+7','"Mag.Atk.Bns."+8',}},
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Sanctity Necklace",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    waist="Eschan Stone",
  })
  
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+19','Magic burst dmg.+5%','MND+7','"Mag.Atk.Bns."+8',}},
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })

  sets.Lugra = {
    left_ear="Lugra Earring"
  }

  --------------------------------------
  -- Midcast sets
  --------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    -- ammo="Staunch Tathlum +1", --11
    -- body=gear.Taeon_Phalanx_body, --10
    -- hands="Rawhide Gloves", --15
    -- legs=gear.Taeon_Phalanx_legs, --10
    -- feet=gear.Taeon_Phalanx_feet, --10
    -- neck="Moonlight Necklace", --15
    -- ear2="Halasz Earring", --5
    -- ring1="Evanescence Ring", --5
    -- back=gear.NIN_FC_Cape, --10
    -- waist="Audumbla Sash", --10
  }

  -- Specific spells
  sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
    feet="Hattori Kyahan +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
  })

  sets.midcast.ElementalNinjutsu = {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  }

  sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {
    -- neck="Sanctity Necklace",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- ear1="Enchntr. Earring +1",
  })

  sets.midcast.EnfeeblingNinjutsu = {
    ammo="Yamarang",
    head="Hachiya Hatsu. +3",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Hachiya Kyahan +3",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Stealth Earring",
    right_ear="Hermetic Earring",
    left_ring="Mummu Ring",
    right_ring="Metamorph Ring",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
  }

  sets.midcast.EnhancingNinjutsu = {
    head="Hachiya Hatsu. +3",
    feet="Mochi. Kyahan +3",
    -- neck="Incanter's Torque",
    ear1="Stealth Earring",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- back="Astute Cape",
    -- waist="Cimmerian Sash",
  }

  sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

  sets.midcast.RA = {
    -- head="Malignance Chapeau",
    -- body="Malignance Tabard",
    -- hands="Malignance Gloves",
    -- legs="Malignance Tights",
    -- feet="Malignance Boots",
    -- neck="Iskur Gorget",
    -- ear1="Enervating Earring",
    -- ear2="Telos Earring",
    -- ring1="Dingir Ring",
    -- ring2="Hajduk Ring +1",
    -- back=gear.NIN_TP_Cape,
    -- waist="Yemaya Belt",
  }

  --------------------------------------
  -- Idle/resting/defense/etc sets
  --------------------------------------

  -- Idle sets
  sets.idle = {
    ammo="Date Shuriken",
    head="Ken. Jinpachi",
    body="Ken. Samue +1",
    hands="Ken. Tekko",
    legs="Ken. Hakama",
    feet="Ken. Sune-Ate",
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Patentia Sash",
    left_ear="Suppanomimi",
    right_ear="Eabani Earring",
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.idle.DT = set_combine(sets.idle, {
    head="Ken. Jinpachi",
    hands="Ken. Tekko",
    left_ring="Hizamaru Ring",
  })

  sets.idle.Town = set_combine(sets.idle, {
    -- ammo="Aurgelmir Orb +1",
    -- head="Ken. Jinpachi +1",
    -- body="Ken. Samue +1",
    -- hands="Ken. Tekko +1",
    -- legs="Mochi. Hakama +3",
    -- feet="Ken. Sune-Ate +1",
    -- neck="Ninja Nodowa +1",
    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Windbuffet Belt +1",
  })

  sets.idle.Town.Adoulin = {
    body="Councilor's Garb",
  }
    
  -- Defense sets
  sets.defense.PDT = sets.idle.DT
  sets.defense.MDT = sets.idle.DT

  sets.Kiting = {
    -- feet="Danzo sune-ate"
  }

  sets.DayMovement = {
    feet="Danzo sune-ate"
  }
  sets.NightMovement = {
    feet="Hachiya Kyahan +3"
  }


  --------------------------------------
  -- Engaged sets
  --------------------------------------

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- * NIN Native DW Trait: 35% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 39% from gear)
  sets.engaged = {
    ammo="Date Shuriken",
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Mochi. Hakama +2", augments={'Enhances "Mijin Gakure" effect',}}, --9
    feet="Hiza. Sune-Ate +2", --8
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Patentia Sash", --5
    left_ear="Suppanomimi", --5
    right_ear="Eabani Earring", --4
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  } -- 39%

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    -- ring2="Ilabrat Ring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 32% from gear)
  sets.engaged.LowHaste = {
    ammo="Date Shuriken",
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    feet="Hiza. Sune-Ate +2", --8
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Patentia Sash", --5
    left_ear="Suppanomimi", --5
    right_ear="Eabani Earring", --4
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  } -- 31%

  sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 21% from gear)
  sets.engaged.MidHaste = {
    ammo="Date Shuriken",
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    feet="Hiza. Sune-Ate +2", --8
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Patentia Sash", --5
    left_ear="Telos Earring", 
    right_ear="Brutal Earring",
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  } -- 22%

  sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidHaste.MidAcc, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- High Magic/Gear/JA Haste (51% DW to cap, 16% from gear)
  sets.engaged.HighHaste = {
    ammo="Date Shuriken",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    feet="Hiza. Sune-Ate +2", --8
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Patentia Sash", --5
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  } -- 12%

  sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Max Magic/Gear/JA Haste (36% DW to cap, 1% from gear)
  sets.engaged.MaxHaste = {
    ammo="Date Shuriken",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ken. Samue +1",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},
    feet={ name="Herculean Boots", augments={'Attack+18','"Triple Atk."+4','Accuracy+3',}},
    neck={ name="Ninja Nodowa", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Mummu Ring",
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  } -- 0%

  sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
    -- hands=gear.Adhemar_A_hands,
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
    -- ear1="Cessance Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.Hybrid = {
	head="Ken. Jinpachi",
    hands="Ken. Tekko",
    left_ring="Hizamaru Ring",
    -- head="Malignance Chapeau", --6/6
    -- legs="Malignance Tights", --7/7
    -- feet="Malignance Boots", --4/4
    ring2="Defending Ring", --10/10
    -- back=gear.NIN_WS1_Cape, --10/0
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

  sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)

  sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)

  sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)

  sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)

  --------------------------------------
  -- Custom buff sets
  --------------------------------------

  sets.buff.Migawari = {
    body="Hattori Ningi +1"
  }
  sets.buff.Yonin = {}
  sets.buff.Innin = {}
  sets.buff.Sange = {
    -- ammo="Hachiya Shuriken"
  }

  sets.magic_burst = {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+5%',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+19','Magic burst dmg.+5%','MND+7','"Mag.Atk.Bns."+8',}},
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Mizu. Kubikazari",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    -- ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.CP = {
	back={ name="Mecisto. Mantle", augments={'Cap. Point+43%','DEX+2','Rng. Atk.+1','DEF+6',}},
  }
  sets.TreasureHunter = {
    head="White Rarab Cap +1",
    -- hands=gear.Herc_TH_hands,
    -- waist="Chaac Belt"
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  if spell.skill == "Ninjutsu" then
    do_ninja_tool_checks(spell, spellMap, eventArgs)
  end
  if spellMap == 'Utsusemi' then
    --[[if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      cancel_spell()
      add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
      eventArgs.handled = true
      return
    else]]
	if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      send_command('cancel 66; cancel Copy Image; cancel 444; cancel Copy Image (2); cancel 445; cancel Copy Image (3); cancel 446; cancel Copy Image (4+)')
    end
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
      equip(sets.Lugra)
    end
    if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
      equip(sets.Obi)
    end
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if default_spell_map == 'ElementalNinjutsu' then
    if state.MagicBurst.value then
      equip(sets.magic_burst)
    end
    if (spell.element == world.day_element or spell.element == world.weather_element) then
      equip(sets.Obi)
    end
    if state.Buff.Futae then
      equip(sets.precast.JA['Futae'])
    end
  end
  if state.Buff.Doom then
    equip(sets.buff.Doom)
  end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  if not spell.interrupted and spell.english == "Migawari: Ichi" then
    state.Buff.Migawari = true
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
  if buff == "Migawari" and not gain then
    add_to_chat(61, "*** MIGAWARI DOWN ***")
  end

  if buff == "doom" then
    if gain then
      equip(sets.buff.Doom)
      send_command('@input /p Doomed.')
      disable('neck','ring1','waist')
    else
      if player.hpp > 0 then
        send_command('@input /p Doom Removed.')
      end
      enable('neck','ring1','waist')
      handle_equipping_gear(player.status)
    end
  end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
  if state.WeaponLock.value == true then
    disable('main','sub')
  else
    enable('main','sub')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  update_weapons()
  check_gear()
  update_combat_form()
  determine_haste_group()
  check_moving()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  th_update(cmdParams, eventArgs)
  update_weaponskill_binds()
end

function update_combat_form()
  if DW == true then
    state.CombatForm:set('DW')
  elseif DW == false then
    state.CombatForm:reset()
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode
  if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
    wsmode = 'Acc'
  end

  return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if state.Buff.Migawari then
    idleSet = set_combine(idleSet, sets.buff.Migawari)
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end
  if world.time >= (17*60) or world.time <= (7*60) then
    idleSet = set_combine(idleSet, sets.NightMovement)
  else
    idleSet = set_combine(idleSet, sets.DayMovement)
  end
  if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
    idleSet = set_combine(idleSet, sets.idle.Town.Adoulin)
  end

  return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.Buff.Migawari then
    meleeSet = set_combine(meleeSet, sets.buff.Migawari)
  end
  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end
  if state.Buff.Sange then
    meleeSet = set_combine(meleeSet, sets.buff.Sange)
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)

  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local ws_msg = state.WeaponskillMode.value

  local c_msg = state.CastingMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

  local msg = ''
  if state.TreasureMode.value == 'Tag' then
    msg = msg .. ' TH: Tag |'
  end
  if state.MagicBurst.value then
    msg = ' Burst: On |'
  end
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function check_moving()
  if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
    if state.Auto_Kite.value == false and moving then
      state.Auto_Kite:set(true)
    elseif state.Auto_Kite.value == true and moving == false then
      state.Auto_Kite:set(false)
    end
  end
end

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 1 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 1 and DW_needed <= 16 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 16 and DW_needed <= 21 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 21 and DW_needed <= 34 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 34 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation')
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
  end

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if type(tonumber(cmdParams[2])) == 'number' then
      if tonumber(cmdParams[2]) ~= DW_needed then
        DW_needed = tonumber(cmdParams[2])
        DW = true
      end
    elseif type(cmdParams[2]) == 'string' then
      if cmdParams[2] == 'false' then
        DW_needed = 0
        DW = false
      end
    end
    if type(tonumber(cmdParams[3])) == 'number' then
      if tonumber(cmdParams[3]) ~= Haste then
        Haste = tonumber(cmdParams[3])
      end
    end
    if type(cmdParams[4]) == 'string' then
      if cmdParams[4] == 'true' then
        moving = true
      elseif cmdParams[4] == 'false' then
        moving = false
      end
    end
    if not midaction() then
      job_update()
    end
  end
end
-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
  local ninja_tool_name
  local ninja_tool_min_count = 1

  -- Only checks for universal tools and shihei
  if spell.skill == "Ninjutsu" then
    if spellMap == 'Utsusemi' then
      ninja_tool_name = "Shihei"
    elseif spellMap == 'ElementalNinjutsu' then
      ninja_tool_name = "Inoshishinofuda"
    elseif spellMap == 'EnfeeblingNinjutsu' then
      ninja_tool_name = "Chonofuda"
    elseif spellMap == 'EnhancingNinjutsu' then
      ninja_tool_name = "Shikanofuda"
    else
      return
    end
  end

  local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

  -- If no tools are available, end.
  if not available_ninja_tools then
    if spell.skill == "Ninjutsu" then
      return
    end
  end

  -- Low ninja tools warning.
  if spell.skill == "Ninjutsu" and state.warned.value == false
      and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
    local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
    --local border = string.repeat("*", #msg)
    local border = ""
    for i = 1, #msg do
        border = border .. "*"
    end

    add_to_chat(104, border)
    add_to_chat(104, msg)
    add_to_chat(104, border)

    state.warned:set()
  elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
    state.warned:reset()
  end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
  if category == 2 or -- any ranged attack
    --category == 4 or -- any magic action
    (category == 3 and param == 30) or -- Aeolian Edge
    (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
    (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
    then return true
  end
end

function check_gear()
  if no_swap_gear:contains(player.equipment.left_ring) then
    disable("ring1")
  else
    enable("ring1")
  end
  if no_swap_gear:contains(player.equipment.right_ring) then
    disable("ring2")
  else
    enable("ring2")
  end
end

windower.register_event('zone change',
  function()
    if no_swap_gear:contains(player.equipment.left_ring) then
      enable("ring1")
      equip(sets.idle)
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
      enable("ring2")
      equip(sets.idle)
    end
  end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'WAR' then
    set_macro_page(1, 15)
  elseif player.sub_job == 'DNC' then
    set_macro_page(4, 15)
  else
    set_macro_page(1, 15)
  end
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
