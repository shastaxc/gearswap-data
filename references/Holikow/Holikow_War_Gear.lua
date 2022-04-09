function user_job_setup()
	-- Options: Override default values
    --state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    --state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('normal','single')
    --state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    --state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	--state.ResistDefenseMode:options('MEVA')
	--state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    --state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	--state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Chango','DualWeapons','Greatsword','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcClub','ProcStaff')

	-- Additional local binds
	send_command('bind ^f1 input //autows use savage blade; wait 2; input //autows toggle')
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind ^f11 gs c cycle HybridMode')
	send_command('bind ^f12 gs c useitem ring2 Warp Ring')
	
	send_command('bind ^f1 input //autows use savage blade; wait 2; input //autows toggle')
	send_command('bind ^f2 input //autows use Upheaval; wait 2; input //autows toggle')
	send_command('bind ^f3 input //autows use Fell cleave; wait 2; input //autows toggle')
	send_command('bind ^f4 input //autows use leaden salute; wait 2; input //autows toggle')
	
	select_default_macro_book()
end

autows = 'Savage Blade'
autowstp = 1750

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	
    sets.Enmity = {}
	sets.Knockback = {}
	sets.passive.Twilight = {head="Twilight Helm",body="Twilight Mail"}
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {back="Cichol's Mantle",body="Pumm. Lorica +2",feet="Agoge calligae +3"}
	sets.precast.JA['Warcry'] = {head="Agoge mask +1"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {body="Agoge lorica +3",head="Pummeler's Mask +2"}
	sets.precast.JA['Mighty Strikes'] = {hand="Agoge mufflers"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge cuisses +3"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge calligae +3"}
	sets.precast.JA['Retaliation'] = {hands="Pumm. Mufflers +2"}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {body="Boii lorica"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {
	ammo="Sapience Orb",head={ name="Sakpata's Helm", augments={'Path: A',}},
	body="Sacro Breastplate",hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+7','"Fast Cast"+4','Mag. Acc.+10',}},
	neck="Voltsurge Torque",left_ring="Kishar Ring",back="Moonlight Cape",}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = {}
	
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
                   
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
	head="Nyame Helm",
    body= "Nyame mail",
    hands= "Nyame Gauntlets", 
    legs="Nyame Flanchard", 
    feet="Nyame Sollerets",
	neck="War. beads +1",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",right_ring="Karieyh Ring +1",
	back={ name="Cichol's Mantle", augments={'STR+20','Weapon skill damage +10%',}}}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {back="Letalis Mantle",})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Savage Blade'] = { 
	ammo="Knobkierrie",head="Nyame Helm",
    body= "Nyame mail",hands= "Nyame Gauntlets", 
    legs="Nyame Flanchard",feet="Nyame Sollerets",
    neck="War. beads +1",waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",right_ring="Karieyh Ring +1",
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}
	
    sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	
    sets.precast.WS['Fell cleave'] = {  
	ammo="Knobkierrie",
    head="Nyame Helm",
    body= "Nyame mail",
    hands= "Nyame Gauntlets", 
    legs="Nyame Flanchard", 
    feet="Nyame Sollerets",
    neck="War. beads +1",waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",right_ring="Karieyh Ring +1",
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}
	
	sets.precast.WS['Aeolian Edge'] = {  
	--head={ name="Nyame Helm", augments={'Path: B',}},
	--body= { name="Nyame Mail", augments={'Path: B',}},
	ammo="Per. Lucky Egg",
	head="Wh. Rarab cap +1",
	body="Valorous mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
	Feet={ name="Nyame Sollerets", augments={'Path: B',}},
	waist="Chaac Belt", neck="Sanctity Necklace",
    left_ear="Friomisi Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",right_ring="Karieyh Ring +1",	
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}

    sets.precast.WS['Upheaval'] = {    
	head={ name="Sakpata's Helm", augments={'Path: A',}},
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
	legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
	feet={ name="Sakpata's Leggings", augments={'Path: A',}},
	neck="War. beads +1",waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	left_ear="Thrud Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Niqmaddu Ring",right_ring="Regal Ring",
	back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
    sets.precast.WS['Upheaval'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Ruinator'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Ruinator'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Ruinator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Ruinator'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Rampage'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Rampage'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Rampage'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Rampage'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Rush'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Raging Rush'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Raging Rush'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Raging Rush'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
	
	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Idle sets
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
    feet="Hermes' Sandals",
    neck="Loricate Torque +1",
    waist="Ioskeha belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}
		
	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
	
	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.latent_regen = {body="Sacro Breastplate",hands="Regal Gauntlets",legs="Volte Brayettes"}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},}
     
            -- Engaged sets
	sets.engaged = {    
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Agoge cuisses +3",
    feet="Pumm. calligae +3",
    neck="War. beads +1",
    waist="Ioskeha belt +1",
    left_ear="Schere Earring",
    right_ear="Dedition Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}
	
    sets.engaged.single = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
	head="Hjarrandi Helm",body="Hjarrandi Breast.",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Pumm. cuisses +3",feet="Pumm. calligae +3",
    neck="War. beads +1",waist="Ioskeha belt +1",
    left_ear="Schere Earring",right_ear="Dedition Earring",
    left_ring="Niqmaddu Ring",right_ring="Petrov Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}
	
	sets.engaged.TH = {
	ammo="Per. Lucky Egg",
	head="Wh. Rarab cap +1",
	body="Valorous mail",
	hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Agoge cuisses +3",
    feet="Pumm. calligae +3",
    neck="War. beads +1",
    waist="Chaac belt",
    left_ear="Schere Earring",
    right_ear="Dedition Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
	back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}

	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = {ammo="Per. Lucky Egg",head="Wh. Rarab cap +1",body="Valorous mail",waist="Chaac belt",}
	
	-- Weapons sets
	sets.weapons.Chango = {}
	sets.weapons.DualWeapons = {}
	sets.weapons.Greatsword = {}
	sets.weapons.ProcDagger = {}
	sets.weapons.ProcSword = {}
	sets.weapons.ProcGreatSword = {}
	sets.weapons.ProcScythe = {}
	sets.weapons.ProcPolearm = {}
	sets.weapons.ProcGreatKatana = {}
	sets.weapons.ProcClub = {}
	sets.weapons.ProcStaff = {}

end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'DNC' then
        set_macro_page(6, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(5, 12)
	elseif player.sub_job == 'DRG' then
        set_macro_page(4, 12)
    else
        set_macro_page(5, 12)
    end
end
function user_job_lockstyle()
	if state.Weapons.value == 'Malignance pole' then
		windower.chat.input('/lockstyleset 14')
	else
		windower.chat.input('/lockstyleset 14')
	end
end