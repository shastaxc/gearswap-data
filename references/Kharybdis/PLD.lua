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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
	
    blue_magic_maps = {}
    
    blue_magic_maps.Enmity = S{
        'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl',
        'Sheep Song', 'Chaotic Eye'
    }
    blue_magic_maps.Cure = S{
        'Wild Carrot', 'Healing Breeze'
    }
    blue_magic_maps.Buff = S{
        'Cocoon', 'Refueling'
    }
	
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    Haste = 0
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal', 'MDT', 'PDT', 'Reraise', 'DD')
    state.WeaponskillMode:options('Normal', 'Acc', 'HP')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.CastingMode:options('Normal', 'Interrupt')
    state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind !f7 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f7')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Cab. Breeches +3",feet="Souveran Schuhs +1"}		
									 
    sets.precast.JA['Provoke'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
									 
    sets.precast.JA['Warcry'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
									 
    sets.precast.JA['Holy Circle'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Rev. Leggings +2"}		
									 
    sets.precast.JA['Shield Bash'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Cab. Gauntlets +3",left_ring="Eihwaz Ring",right_ring={name="Supershear Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
									 
    sets.precast.JA['Sentinel'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Cab. Leggings +3"}		
									 
    sets.precast.JA['Rampart'] = {ammo="Sapience Orb",head="Cab. Coronet +3",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
									 
    sets.precast.JA['Fealty'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Cab. Surcoat +3",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
	
    sets.precast.JA['Divine Emblem'] = {ammo="Sapience Orb",head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Chevalier's Sabatons +1"}		
	
    sets.precast.JA['Cover'] = {ammo="Sapience Orb",head="Rev. Coronet +1",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Eihwaz Ring",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}		
	

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Sapience Orb", head="Carmine Mask +1",neck="Warder's Charm +1",ear2="Friomis Earring",
									 body="Souv. Cuirass +1",hands="Cab. Gauntlets +3",left_ring="Stikini Ring +1",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
									 back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1", feet="Souveran Schuhs +1"}
					 
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt", feet="Volte Boots", legs="Volte Hose","Per. Lucky Egg"}
    sets.precast.Flourish1 = {waist="Chaac Belt", feet="Volte Boots", legs="Volte Hose","Per. Lucky Egg"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
    ammo="Sapience Orb",
    head="Carmine Mask +1",
    body="Sacro Breastplate",
    hands="Regal Gauntlets",
    legs="Arjuna Breeches",
    feet="Carmine Greaves +1",
    neck="Voltsurge Torque",
    waist="Creed Baudrier",
    right_ear="Etiolation Earring",
    left_ear="Tuisto Earring",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"}, 
    right_ring="Kishar Ring",
    back={ name="Rudianos's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}}
		
	sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Aurgelmir Orb",
        head="Sakpata's Helm",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Sakpata's Plate",hands="Sakpata's Gauntlets",left_ring="Epaminondas's Ring",right_ring="Regal Ring",
        back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}

    sets.precast.WS.Acc = {ammo="Aurgelmir Orb",
        head="Sakpata's Helm",neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
        body="Sakpata's Plate",hands="Sakpata's Gauntlets",left_ring="Rufescent Ring",right_ring="Regal Ring",
        back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Requiescat'].HP = set_combine(sets.precast.WS.Acc, {ammo="Sapience Orb",right_ring={name="Moonbeam Ring", bag="wardrobe3"},left_ring="Eihwaz Ring",hands="Souv. Handsch. +1",back="Moonbeam Cape",ear2="Friomis Earring",ear1="Etiolation Earring",legs="Souv. Diechlings +1",body="Souv. Cuirass +1"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {head="Blistering Sallet +1", feet="Thereoid Greaves"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Chant du Cygne'].HP = set_combine(sets.precast.WS.Acc, {})	

	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Caro Necklace",waist="Sailfi Belt +1",head="Lustratio Cap +1",body="Lustr. Harness +1"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].HP = set_combine(sets.precast.WS['Savage Blade'], {ammo="Sapience Orb",right_ring={name="Moonbeam Ring", bag="wardrobe3"},left_ring={name="Moonbeam Ring", bag="wardrobe2"},hands="Regal Gauntlets",back="Moonbeam Cape",ear1="Tuisto Earring",ear2="Odnowa Earring +1",neck="Sanctity Necklace"})	

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",body="Nayme Mail",hands="Leyline Gloves",ear1="Friomisi Earring",ear2="Crematio Earring",left_ring="Shiva Ring +1",right_ring="Archon Ring",
        back="Toro Cape",waist="Yamabuki-no-obi",legs="Founder's Hose",neck="Sanctity Necklace"})
		
    sets.precast.WS['Aoelian Edge'] = set_combine(sets.precast.WS, {ammo="Ghastly Tathlum +1",
        body="Found. Breastplate",neck="Sanctity Necklace",head="Jumalik Helm",ear1="Friomisi Earring",ear2="Moonshade Earring",hands="Leyline Gloves",left_ring="Shiva Ring +1",
        back="Toro Cape",waist="Yamabuki-no-obi",legs="Founder's Hose"})	

    sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS, {head="Nyame Helm", body="Nyame Mail", hands="Nyame Gauntlets", legs="Nyame Flanchard", feet="Nyame Sollerets", })		
    
    sets.precast.WS['Atonement'] = {
    ammo="Sapience Orb",
    head="Nyame Helm",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs="Nyame Flanchard",
    feet="Sulev. Leggings +2",
    neck="Sanctity Necklace",
    waist="Creed Baudrier",
    right_ear="Thrud Earring",
    left_ear="Tuisto Earring",
    left_ring="Epaminondas's Ring",
    right_ring={name="Moonbeam Ring", bag="wardrobe3"},
    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
    ammo="Sapience Orb",
    head="Carmine Mask +1", 
    body="Rev. Surcoat +3",
    hands="Regal Gauntlets",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet="Carmine Greaves +1",
    neck="Voltsurge Torque",
    waist="Creed Baudrier",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"},
    right_ring={name="Moonbeam Ring", bag="wardrobe3"},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%',}}}
        

    sets.midcast.Flash = {
	ammo="Sapience Orb",
	hands="Souv. Handsch. +1",
	neck={name="Unmoving Collar +1", priority=2},
    head="Carmine Mask +1",
	body="Rev. Surcoat +3",
	back={ name="Rudianos's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}},
	waist="Creed Baudrier",
	legs="Souv. Diechlings +1",
	ear1="Friomis Earring",
	ear2="Etiolation Earring",
	right_ring={name="Supershear Ring", bag="wardrobe", priority=1},
	left_ring="Apeile Ring +1",
	feet="Carmine Greaves +1"}
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
    ammo="Sapience Orb",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1},
    body="Souv. Cuirass +1", priority=1,
    hands="Souv. Handsch. +1",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=2},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=3},
    neck="Phalaina Locket",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Nourish. Earring +1",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"},
    right_ring={name="Moonbeam Ring", bag="wardrobe3", priority=4},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%',}},
	}
	
	sets.midcast.Cure.Interrupt = {
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs="Founder's Hose",
    feet="Eschite Greaves",
    neck="Unmoving Collar +1",
    waist="Audumbla Sash",
    left_ear="Odnowa Earring +1",
    right_ear="Nourish. Earring +1",
    left_ring="Defending Ring",
    right_ring={name="Gelatinous Ring +1", priority=1},
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
	}
	
	sets.midcast['Blue Magic'] = {
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Odyssean Greaves", augments={'Attack+24','"Fast Cast"+3','Accuracy+13',}},
    neck="Unmoving Collar +1",
    waist="Audumbla Sash",
    left_ear="Odnowa Earring +1",
    right_ear="Nourish. Earring +1",
    left_ring={name="Moonbeam Ring", bag="wardrobe3", priority=4},
    right_ring="Gelatinous Ring +1",
    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
	}
	
    sets.midcast['Enhancing Magic'] = {
	ammo="Sapience Orb",
	head="Carmine Mask +1",
	ear2="Andoaa Earring",
	waist="Creed Baudrier",
	ear1="Tuisto Earring",
	neck="Incanter's Torque",
	body="Shabti Cuirass +1",
	legs="Rev. Breeches +2",
	back="Weard Mantle",
	feet={name="Souveran Schuhs +1", priority=1},
	hands={name="Regal Gauntlets", priority=3},
	left_ring="Gelatinous Ring +1",
	right_ring={name="Moonbeam Ring", bag="wardrobe3", priority=2}
	}
	
    sets.midcast['Phalanx'] = {
	ammo="Sapience Orb",
	head="Carmine Mask +1",
	ear2="Andoaa Earring",
	waist="Creed Baudrier",
	ear1="Tuisto Earring",
	neck="Incanter's Torque",
	body="Shabti Cuirass +1",
	legs="Sakpata's Cuisses",
	back="Weard Mantle",
	feet={name="Souveran Schuhs +1", priority=1},
	hands={name="Souv. Handsch. +1", priority=3},
	left_ring="Gelatinous Ring +1",
	right_ring={name="Moonbeam Ring", bag="wardrobe3", priority=2}
	}	
									   
    sets.midcast['Enhancing Magic'].Interrupt = {
	ammo="Staunch Tathlum +1",
	head="Souveran Schaller +1",
	ear2="Andoaa Earring",
	waist="Olympus Sash",
	ear1="Tuisto Earring",
	neck="Incanter's Torque",
	body="Souv. Cuirass +1",
	legs="Founder's Hose",
	back="Weard Mantle",
	feet="Odyssean Greaves",
	hands={name="Regal Gauntlets", priority=3},
	left_ring={name="Moonbeam Ring", bag="wardrobe2"},
	right_ring={name="Moonbeam Ring", bag="wardrobe3", priority=2}
	}									   
    
	sets.midcast['Divine Magic'] = {
	head="Jumalik Helm",
	body="Rev. Surcoat +3",
	neck="Incanter's Torque",
	ear1="Beatific Earring",
	right_ring="Stikini Ring +1",
	left_ring="Stikini Ring +1",
	waist="Asklepian Belt",
	hands="Eschite Gauntlets",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
	}
	
	sets.midcast.Reprisal = {
	ammo="Sapience Orb",
	head="Carmine Mask +1",
	ear2="Etiolation Earring",
	waist="Sailfi Belt +1",
	ear1="Tuisto Earring",
	neck="Incanter's Torque",
	body="Shabti Cuirass +1",
	legs="Rev. Breeches +2",
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}},
	feet={name="Souveran Schuhs +1", priority=1},
	hands={name="Regal Gauntlets", priority=3},
	left_ring={name="Moonbeam Ring", bag="wardrobe2"},
	right_ring={name="Moonbeam Ring", bag="wardrobe3", priority=2}}
	
	
    sets.midcast.Protect = {left_ring="Sheltered Ring"}
    sets.midcast.Shell = {left_ring="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------


    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Bathy Choker +1",
        left_ring="Sheltered Ring",right_ring="Chirich Ring +1"}
    

    -- Idle sets
    sets.idle = {ammo="Homiliary",
        head="Souveran Schaller +1",neck="Bathy Choker +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Sacro Breastplate",hands="Regal Gauntlets",left_ring="Apeile Ring +1",right_ring="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Volte Sollerets"}
		
    sets.idle.Town = {ammo="Homiliary",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Councilor's Garb",hands="Regal Gauntlets",left_ring="Gelatinous Ring +1",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Souveran Schuhs +1"}	

	sets.idle.DD = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
    
    sets.idle.Refresh = {ammo="Homiliary",
        head="Souv. Schaller +1",neck="Bathy Choker +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body="Sacro Breastplate",hands="Regal Gauntlets",left_ring="Gelatinous Ring +1",right_ring="Apeile Ring +1",
        back="Moonbeam Cape",waist="Flume Belt",legs="Volte Brayettes",feet="Souveran Schuhs +1"}
		
	sets.idle.PDT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear2="Odnowa Earring +1",ear1="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Gelatinous Ring +1",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}	
				
    
    sets.Kiting = {legs="Carmine Cuisses +1"}



    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {head="Chev. Armet +1", feet="Rev. Leggings +2",waist="Flume Belt",ear1="ThureousEarring", back={ name="Rudianos's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Excalibur",sub="Priwen"} -- Ochain
    sets.MagicalShield = {main="Excalibur",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {ammo="Sapience Orb",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring="Gelatinous Ring +1",right_ring={name="Moonbeam Ring", bag="wardrobe3"},
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}	
    sets.defense.Reraise = {ammo="Sapience Orb",
        head="Twilight Helm",neck="Loricate Torque +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",left_ring={name="Moonbeam Ring", bag="wardrobe2"},right_ring="Defending Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Sapience Orb",
        head="Souv. Schaller +1",neck="Warder's Charm +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",right_ring="Defending Ring",left_ring="Shadow Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Odnowa Earring +1",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"},
    right_ring={name="Moonbeam Ring", bag="wardrobe3"},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.engaged.Acc = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"},
    right_ring={name="Moonbeam Ring", bag="wardrobe3"},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
	
    sets.engaged.PDT = {
	ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Sanctity Necklace",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",left_ring={name="Moonbeam Ring", bag="wardrobe2"},right_ring={name="Moonbeam Ring", bag="wardrobe3"},
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	sets.engaged.DD = {
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Regal Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}	
	
	sets.engaged.Acc.DD = {
    ammo="Aurgelmir Orb",
    head="Flam. Zucchetto +2",
    body="Sulevia's Plate. +2",
    hands="Sakpata's Gauntlets",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Chirich Ring +1",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}		
		
    sets.engaged.Acc.PDT = {
    ammo="Aurgelmir Orb",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring={name="Moonbeam Ring", bag="wardrobe2"},
    right_ring={name="Moonbeam Ring", bag="wardrobe3"},
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
		
    sets.engaged.MDT = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warder's Charm +1",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Shadow Ring",
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Chance of successful block +4',}},
	}

    sets.engaged.Acc.MDT = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Warder's Charm +1",
    waist="Creed Baudrier",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Shadow Ring",
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Chance of successful block +4',}},
	}

    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {waist="Gishdubar Sash",left_ring="Eshmun's Ring",right_ring="Purity Ring",legs="Shabti Cuisses +1"}
    sets.buff.Cover = {body="Caballarius Surcoat +3"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    update_defense_mode()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(3, 1)
    else
        set_macro_page(2, 1)
    end
end

function check_moving()
    if state.DefenseMode.value == 'None' then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end
