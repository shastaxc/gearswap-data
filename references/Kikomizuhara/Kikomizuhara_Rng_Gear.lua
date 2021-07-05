-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc','Multi','Omen')
	state.HybridMode:options('Normal','DTLite','DT')
	state.RangedMode:options('Normal','Acc','Crit','Fodder','Omen')
	state.WeaponskillMode:options('Match','Normal','Acc','Lowattack','Omen')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('None','Default','DualMagicWeapons','DualSavageWeapons')
	
	WeaponType =  {['Sparrowhawk +2'] = "Bow",
                   ['Fomalhaut'] = "Gun",
				   ['Ataktos'] = "Gun",
				   ['Gastraphetes'] = "Crossbow",
				   ['Yoichinoyumi'] = "Bow",
                   }

	DefaultAmmo = {
		['Bow']  = {['Default'] = "Eminent Arrow",
					['WS'] = "Eminent Arrow",
					['Acc'] = "Eminent Arrow",
					['Magic'] = "Eminent Arrow",
					['MagicAcc'] = "Eminent Arrow",
					['Unlimited'] = "Hauksbok Arrow",
					['MagicUnlimited'] ="Hauksbok Arrow",
					['MagicAccUnlimited'] ="Hauksbok Arrow"},
					
		['Gun']  = {['Default'] = "Chrono Bullet",
					['WS'] = "Chrono Bullet",
					['Acc'] = "Chrono Bullet",
					['Magic'] = "Orichalc. Bullet",
					['MagicAcc'] = "Orichalc. Bullet",
					['Unlimited'] = "Hauksbok Bullet",
					['MagicUnlimited'] = "Animikii Bullet",
					['MagicAccUnlimited'] ="Animikii Bullet"},
					
		['Crossbow'] = {['Default'] = "Quelling Bolt",
						['WS'] = "Quelling Bolt",
						['Acc'] = "Quelling Bolt",
						['Magic'] = "Quelling Bolt",
						['MagicAcc'] = "Quelling Bolt",
						['Unlimited'] = "Hauksbok Bolt",
						['MagicUnlimited'] = "Hauksbok Bolt",
						['MagicAccUnlimited'] ="Hauksbok Bolt"}
	}
	
	gear.tp_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	gear.snapshot_jse_back = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	


end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
	sets.precast.JA['Double Shot'] = {}


	-- Fast cast sets for spells

    sets.precast.FC = {
        head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Lebeche Ring",
        back="Moonlight Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet="Carmine Greaves +1"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head={ name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}},
    body="Amini Caban +1",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet="Meg. Jam. +2",
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Impulse Belt",
    left_ear="Genmei Earring",
    right_ear="Dedition Earring",
    left_ring="Defending Ring",
    right_ring="Ilabrat Ring",
    back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
	}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {waist="Yemaya Belt",})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {head="Orion Beret +3",waist="Yemaya Belt",legs={ name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7',}},
    feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Orion Beret +3",
    body={ name="Herculean Vest", augments={'Attack+19','Rng.Acc.+28','Weapon skill damage +6%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}
		
	sets.precast.WS['Last Stand'] = {
        head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}
		
    sets.precast.WS['Last Stand'].Acc = {
        head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

sets.precast.WS.Acc = {
        head="Orion Beret +3",
    body="Malignance Tabard",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

sets.precast.WS.Omen = {
	head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Dedition Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
    }
	
	
	
	
	
   



    sets.precast.WS['Wildfire'] = {
        body={ name="Cohort Cloak +1", augments={'Path: A',}},
 hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Wildfire'].Acc = {
        body={ name="Cohort Cloak +1", augments={'Path: A',}},
   hands={ name="Herculean Gloves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Mag.Atk.Bns."+28','"Treasure Hunter"+2','Accuracy+3 Attack+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+30','Accuracy+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
    feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+27','Pet: "Store TP"+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Weather. Ring",
    right_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Aeolian Edge'] = {
    body={ name="Cohort Cloak +1", augments={'Path: A',}},
 hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Beithir Ring",
    right_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Trueflight'] = {
	body={ name="Cohort Cloak +1", augments={'Path: A',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Weather. Ring",
    right_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

    sets.precast.WS['Trueflight'].Acc = sets.precast.WS['Trueflight']
		
		
	sets.precast.WS['Savage Blade'] = {
        ammo="Hauksbok Arrow",
    head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Savage Blade'].Lowattack = {
	 ammo="Hauksbok Arrow",
    head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Namas Arrow'] = {
     ammo="Hauksbok Arrow",
    head="Orion Beret +3",
    body="Ikenga's Vest",
    hands="Meg. Gloves +2",
    legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
     neck={ name="Scout's Gorget +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
	
	
	
	
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Friomisi Earring",}
	sets.AccMaxTP = {ear1="Ishvara Earring",ear2="Friomisi Earring",}
    sets.MagicalMaxTP = {ear1="Ishvara Earring",ear2="Friomisi Earring",}
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}
		
	-- Ranged sets

    sets.midcast.RA = {head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
    body="Ikenga's Vest",
    hands="Malignance Gloves",
    legs="Ikenga's Trousers",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Dedition Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+10 Rng.Atk.+10','Rng.Acc.+10','"Store TP"+10',}},}
	
    sets.midcast.RA.Acc = {
       head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Enervating Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+10 Rng.Atk.+10','Rng.Acc.+10','"Store TP"+10',}},}
	
	sets.midcast.RA.Crit = { head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Crit.hit rate+10',}},
	}
		
    sets.midcast.RA.Fodder = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ilabrat Ring",ring2="Rajas Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
	sets.buff.Camouflage.Acc = {}
	
	sets.buff['Double Shot'] = { 
	head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
    body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
    hands="Oshosi Gloves",
    legs="Oshosi Trousers",
    feet="Oshosi Leggings",
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Belenus's Cape", augments={'AGI+20','Crit.hit rate+10',}},
	}
	
	
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {hands="Orion Bracers +1"}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = {
        head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Sanctity Necklace",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},}
    
    -- Defense sets
    sets.defense.PDT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.defense.MEVA = {
        head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Vengeful Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Default = {main="Tauret",sub="Kraken club",range="Gastraphetes"}
	sets.weapons.Dyna = {main="Tauret",sub="Kraken Club",range="Gastraphetes"}
	sets.weapons.DualWeapons = {main="Tauret",sub="Kraken Club",range="Gastraphetes"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Kraken club",range="Sparrowhawk +2"}
	sets.weapons.Laststand = {main="Ternion Dagger +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualMalevolence = {main="Malevolence",sub="Malevolence",range="Gastraphetes"}
	sets.weapons.DualMagicWeapons = {main="Tauret",sub="Kraken Club",range="Sparrowhawk +2"}
	sets.weapons.KC = {main="Kraken Club",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.Omen = {main="mercurial kris",sub="Kraken Club",range="Gastraphetes"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {
     head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erudit. Necklace",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1", bag="wardrobe 1",
    right_ring="Chirich Ring +1", bag="wardrobe 4",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
    }
	
    sets.engaged.Acc = {
	head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
}
    sets.engaged.DTLite = {
		head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Dedition Earring",
    left_ring="Chirich Ring +1", bag="wardrobe 1",
    right_ring="Chirich Ring +1", bag="wardrobe 4",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
    }
    sets.engaged.DT = {
		head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
}
    sets.engaged.DW = { head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erudit. Necklace",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1", bag="wardrobe 1",
    right_ring="Chirich Ring +1", bag="wardrobe 4",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
		}
    sets.engaged.DW.DT = {
		head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
    }
    sets.engaged.DW.Acc = {head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Anu Torque",
    waist="Olseni Belt",
    left_ear="Digni. Earring",
    right_ear="Odr Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
}

    sets.engaged.DW.Multi = {
	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1", bag="wardrobe 1",
    right_ring="Chirich Ring +1", bag="wardrobe 4",
    back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Mag. Evasion+15',}},
}



	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end



