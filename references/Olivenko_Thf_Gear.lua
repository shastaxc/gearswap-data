-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
  silibs.enable_premade_commands()

	-- Options: Override default values
	
    state.OffenseMode:options('Normal','FullAcc','Evasion','DT')
    state.HybridMode:options('Normal','DT','MDT','Evasion')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','FullAcc','Proc')
	state.IdleMode:options('Normal', 'PDT', 'Evasion')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Gandring','Aeneas','MagicWeapons','Evisceration')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	
	state.AmbushMode = M(false, 'Ambush Mode')

	--gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	--gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    -- Additional local binds
    --send_command('bind ^` input /ja "Flee" <me>')
    --send_command('bind !` input /ra <t>')
	--send_command('bind @` gs c cycle SkillchainMode')
	--send_command('bind @f10 gs c toggle AmbushMode')
	--send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	--send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	--send_command('bind !q gs c weapons SwordThrowing')
	--send_command('bind !backspace input /ja "Hide" <me>')
	--send_command('bind ^r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	--send_command('bind !r gs c weapons MagicWeapons')
	--send_command('bind ^\\\\ input /ja "Despoil" <t>')
	--send_command('bind !\\\\ input /ja "Mug" <t>')
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f11 gs c cycle HybridMode')
	send_command('bind f12 gs c cycle WeaponskillMode')
  
  send_command('bind !d gs c usekey')

    select_default_macro_book()
	
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
		ammo="Per. Lucky Egg", --1
		head="Volte Cap", --1
		hands="Plunderer's Armlets +3", -- 4
		feet="Skulk. Poulaines +1", -- 3
	}
		-- TH +3 Base + 9 (gear) + 3 (Gandring) = 15
	
    sets.Kiting = {feet="Skd. Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {}
	
    sets.buff['Trick Attack'] = {}

    -- Extra Melee sets.  Apply these on top of melee sets
	
    sets.Knockback = {}
	
	sets.Suppa = {}
	
	sets.DWEarrings = {}
	
	sets.DWMax = {body="Adhemar Jacket +1",waist="Reiki Yotai"}
	
	sets.Parry = {hands="Turms Mittens +1",ring1="Defending Ring"}
	
	sets.Ambush = {body="Plunderer's Vest +3"}
	
    --------------------------------------
    -- Weapon Sets
    --------------------------------------
	
	sets.weapons.Aeneas = {main="Aeneas",sub="Tauret"}
	
	sets.weapons.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	
	sets.weapons.Evisceration = {main="Tauret",sub="Aeneas"}

	sets.weapons.Gandring = {main="Gandring", sub="Tauret"}
	
    -- Actions we want to use to tag TH
	
    sets.precast.Step = sets.TreasureHunter
		
    sets.precast.JA['Violent Flourish'] = sets.precast.Step
		
	sets.precast.JA['Animated Flourish'] = sets.precast.Step
	
	sets.precast.JA.Provoke = sets.precast.Step

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
	
    sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest"} 
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
	
    sets.precast.Waltz = {
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
	}

	sets.Self_Waltz =  sets.precast.Waltz
		
    -- Don't need any special gear for Healing Waltz
	
    sets.precast.Waltz['Healing Waltz'] = {}


    --------------------------------------
    -- Fastcast sets
    --------------------------------------
	
    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'Attack+18','Weapon skill damage +3%','DEX+15','Accuracy+14',}},
		body={ name="Taeon Tabard", augments={'"Fast Cast"+4','"Regen" potency+1',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Weather. Ring",
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
	
    sets.precast.RA = {
		head="Meghanada Visor +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		feet={ name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}},
	}
	
    --------------------------------------
    -- Weaponskill Sets
    --------------------------------------

    sets.precast.WS = {
		ammo="Voluspa Tathlum",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands={ name="Plun. Armlets +3", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS.FullAcc = sets.precast.WS
	

    sets.precast.WS["Rudra's Storm"] = {
		ammo="Voluspa Tathlum",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"], {})

    sets.precast.WS["Rudra's Storm"].SA = {
		ammo="Voluspa Tathlum",
		head="Pill. Bonnet +2",
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
    sets.precast.WS["Rudra's Storm"].TA = sets.precast.WS["Rudra's Storm"].SA
	
    sets.precast.WS["Rudra's Storm"].SATA = sets.precast.WS["Rudra's Storm"].SA
	
	
	sets.precast.WS['Exenterator'] = {
		ammo="Voluspa Tathlum",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Plun. Culottes +3", augments={'Enhances "Feint" effect',}},
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS['Exenterator'], {})
	

    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})

    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"], {})
	
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"], {})
	
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"], {})
	

	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
  
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	
   
	sets.precast.WS["Savage Blade"] = {}

	sets.precast.WS["Savage Blade"].FullAcc = sets.precast.WS["Savage Blade"]
	

    sets.precast.WS.Proc = {
        body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
	}
		
    sets.precast.WS['Aeolian Edge'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','Weapon skill damage +4%','AGI+10','Mag. Acc.+14',}},
		body={ name="Herculean Vest", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +4%','"Mag.Atk.Bns."+10',}},
		hands={ name="Herculean Gloves", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','Weapon skill damage +4%','MND+5','"Mag.Atk.Bns."+15',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +4%','MND+4','Mag. Acc.+9',}},
		feet={ name="Herculean Boots", augments={'DEX+10','MND+14','Weapon skill damage +8%','Accuracy+12 Attack+12','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS["Cyclone"] = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
	-- TH for /DRK
	
	sets.midcast['Enfeebling Magic'] = sets.TreasureHunter
	
	sets.midcast.poisonga = sets.TreasureHunter

    -- Ranged gear

    sets.midcast.RA = {
		head="Meghanada Visor +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
	}

    sets.midcast.RA.Acc = sets.midcast.RA

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    sets.resting = {}

    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.idle.Town = {
		ammo="Staunch Tathlum +1",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.idle.Evasion = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
		
    sets.idle.Sphere = set_combine(sets.idle, {})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	
	sets.NightIdle = {}
	
	sets.ExtraRegen = {}

    -- Defense sets

    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

    sets.defense.MDT = sets.defense.PDT
		
	sets.defense.MEVA = sets.defense.PDT
	
	sets.defense.Evasion = {
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights",
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Gere Ring",
		right_ring="Hetairoi Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
		
    sets.engaged.FullAcc = {
		ammo="Yamarang",
		head={ name="Plun. Bonnet +3", augments={'Enhances "Aura Steal" effect',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Malignance Tights",
		feet={ name="Plun. Poulaines +3", augments={'Enhances "Assassin\'s Charge" effect',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

    sets.engaged.DT = {
		ammo="Staunch Tathlum +1", -- DT 3
		head="Nyame Helm",
		body="Malignance Tabard", -- DT 9
		hands="Malignance Gloves", -- DT 5
		legs="Malignance Tights", -- DT 7
		feet="Malignance Boots", -- DT 4
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Defending Ring", -- DT 10
		right_ring="Moonlight Ring", -- DT 5
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}, -- DT 5
	}
		-- Total: DT 48
		
	sets.engaged.Evasion = {
	    main={ name="Gandring", augments={'Path: C',}},
		sub={ name="Ternion Dagger +1", augments={'Path: A',}},
		ammo="Yamarang",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("ArkEV") then
					windower.chat.input('/ma "AAEV" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Apururu") then
					windower.chat.input('/ma "Apururu (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function extra_user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------
end

function user_job_precast(spell, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_precast function
  silibs.precast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_post_precast(spell, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_post_precast function
  silibs.post_precast_hook(spell, nil, spellMap, eventArgs)
end

function user_job_midcast(spell, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_midcast function
  silibs.midcast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_post_midcast(spell, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_post_midcast function
  silibs.post_midcast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_job_aftercast(spell, action, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_aftercast function
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
end

function extra_user_job_post_aftercast(spell, action, spellMap, eventArgs)
  -- Any non-silibs modifications should go in user_job_post_aftercast function
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

function user_job_customize_idle_set(idleSet)
  -- Any non-silibs modifications should go in user_customize_idle_set function
  return silibs.customize_idle_set(idleSet)
end

function user_job_customize_melee_set(meleeSet)
  -- Any non-silibs modifications should go in user_customize_melee_set function
  return silibs.customize_melee_set(meleeSet)
end

function user_job_customize_defense_set(defenseSet)
  -- Any non-silibs modifications should go in user_customize_defense_set function
  return silibs.customize_defense_set(defenseSet)
end

function user_self_command(cmdParams, eventArgs)
  -- Any non-silibs modifications should go in user_job_self_command function
  silibs.self_command(cmdParams, eventArgs)
end