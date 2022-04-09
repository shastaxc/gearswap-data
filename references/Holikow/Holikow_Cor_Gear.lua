-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    --state.OffenseMode:options('Normal','Acc')
	--state.RangedMode:options('Normal', 'Acc')
    --state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
    --state.CastingMode:options('Normal', 'Resistant')
    --state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal','SB')
	--state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default')
	--state.CompensatorMode:options('Always','300','1000','Never')

    --gear.RAbullet = "Chrono Bullet"
    --gear.WSbullet = "Chrono Bullet"
    --gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
    --gear.QDbullet = "Animikii Bullet"
    --options.ammo_warning_limit = 15
 
	gear.tp_ranger_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	--send_command('bind ^` gs c cycle ElementalMode')
	--send_command('bind !` gs c elemental quickdraw')
	
	--send_command('bind ^backspace input /ja "Double-up" <me>')
	--send_command('bind @backspace input /ja "Snake Eye" <me>')
	--send_command('bind !backspace input /ja "Fold" <me>')
	--send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^f1 input //gs c autows Savage Blade')
	send_command('bind ^f2 input //gs c autows Leaden Salute')
	send_command('bind ^f3 input //gs c autows Aeolian Edge')
	send_command('bind ^f4 input //gs c autows wildfire')
	send_command('bind ^f5 gs c toggle AutoWSMode')
	send_command('bind !f5 gs c toggle RngHelper')
	send_command('bind ^f6 input //cor')
	send_command('bind !f7 input //gs enable head')
	send_command('bind !f8 input //gs disable head;wait 1;input /equip head "Wh. Rarab cap +1"')
	send_command('bind !` input /ma "Utsusemi: Ni" <me>;/ma "Utsusemi: Ichi" <me>')
	send_command('bind ^f10 gs c toggle IdleMode')
	send_command('bind ^f11 gs c cycle HybridMode')
	send_command('bind ^f12 gs c useitem ring2 Warp Ring')

	--send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	--send_command('bind ^q gs c weapons DualAeolian;gs c update')
	--send_command('bind @q gs c weapons DualKustawi;gs c update')
	--send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
	--send_command('bind @pause roller roll')

    select_default_macro_book()
end

include('organizer-lib')

organizer_items = {
   -- echos="",
  --  shihei="Shihei",
	--bullet="Living bullet",
}

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +2"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}

    sets.precast.CorsairRoll = {    
    head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands="Chasseur's Gants +1",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    neck="Regal Necklace",
    left_ring="Luzaf's Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    --sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"}) 
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.CorsairShot = {    
	head="Nyame Helm",
    body="Lanun Frac +3",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs="Nyame flanchard",
    feet="Chasseur Bottes +1",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's earring",
    left_ring="Stikini ring",
    right_ring="Stikini ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}
		
	sets.precast.CorsairShot.Damage = {
	head="Nyame Helm",
    body="Lanun Frac +3",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs="Nyame flanchard",
    feet="Lanun bottes +2",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's earring",
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}
	
    sets.precast.CorsairShot.Proc = {}

    sets.precast.CorsairShot['Light Shot'] = {
	head="Malignance chapeau",
    body="Malignance tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Gwati earring",right_ear="Crepuscular Earring",
    left_ring="Stikini Ring +1", right_ring="Stikini Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}
	
	sets.precast.CorsairShot['Earth Shot'] = {
	range="Death Penalty", ammo="Living Bullet",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Chasseur's bottes +1",
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",right_ear="Crepuscular Earring",
    left_ring="Stikini Ring +1", right_ring="Stikini Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet="Chass. Bottes +1"})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
	head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},ear1="Etiolation Earring",ear2="Odnowa Earring +1",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},ring1="Kishar Ring",
	neck="Voltsurge Torque",ring2="Defending Ring",back="Moonlight Cape",waist="Flume Belt"}

    sets.precast.FC.Utsusemi = {    
	head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body="Passion Jacket", neck="Magoraga Beads",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, ring1="Kishar Ring",
	neck="Voltsurge Torque",ring2="Defending Ring",back="Moonlight Cape",waist="Flume Belt"}
	
	sets.precast.FC.Cure = {}

    sets.precast.RA = {
	ammo="Chrono Bullet",
	head="Chass. Tricorne +1",
    body="Laksa. Frac +2",
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7',}},
    feet="Meg. Jam. +2",
	neck="Comm. Charm +1", 
	waist={ name="Tellen Belt", augments={'Path: A',}},
	ring1="Dingir ring", ring2="Crepuscular ring", ear1="Telos earring", ear2="enervating earring", 
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}
		
	sets.precast.RA.Flurry = {}
	sets.precast.RA.Flurry2 = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
}
		
    sets.precast.WS.Acc = {
     }		
		
    sets.precast.WS.Proc = {
        }
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = {}

	sets.precast.WS['Savage Blade'] = {	
    head={ name="Nyame Helm", augments={'Path: B',}},
	body= { name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Comm. charm +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
	
    sets.precast.WS['Last Stand'] = {
	ammo="Chrono Bullet",
	head={ name="Nyame Helm", augments={'Path: B',}},
    body="Laksa. Frac +2",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Last Stand'].Acc = {}
		
    sets.precast.WS['Detonator'] = {}
    sets.precast.WS['Detonator'].Acc = {}
    sets.precast.WS['Slug Shot'] = {}
    sets.precast.WS['Slug Shot'].Acc = {}
    sets.precast.WS['Numbing Shot'] = {}
    sets.precast.WS['Numbing Shot'].Acc = {}
    sets.precast.WS['Sniper Shot'] = {}
    sets.precast.WS['Sniper Shot'].Acc = {}
    sets.precast.WS['Split Shot'] = {}
    sets.precast.WS['Split Shot'].Acc = {}
	
    sets.precast.WS['Leaden Salute'] = {
	ammo="Living bullet",
    head="Pixie Hairpin +1",
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan stone",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Aeolian Edge'] = {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",right_ring="Karieyh Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Wildfire'] = {
	ammo="Living bullet",
	head={ name="Nyame Helm", augments={'Path: B',}},
	body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",
    right_ring="Karieyh Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Wildfire'].Acc = {}
		
    sets.precast.WS['Evisceration'] = {}
	
  
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells

	sets.midcast.Cure = {waist="Anrin Obi"}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {
	head="Malignance chapeau",
    body="Malignance tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
	waist={ name="Tellen Belt", augments={'Path: A',}},
	neck="Iskur gorget", ring1="Dingir ring", ring2="Crepuscular ring", ear1="Telos earring", ear2="enervating earring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},	}

    sets.midcast.RA.Acc = {
	head="Malignance chapeau",
    body="Malignance tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
	waist={ name="Tellen Belt", augments={'Path: A',}},
	neck="Iskur gorget", ring1="Dingir ring", ring2="Ilabrat ring", ear1="Telos earring", ear2="enervating earring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},	}
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
	left_ring="Karieyh Ring +1",
    right_ring="Defending Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
		
    sets.idle.PDT = {
	head="Nyame Helm",
    body="Nyame Mail",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Gelatinous Ring +1",
    right_ring="Vocane Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
		
    sets.idle.Refresh = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = {}
	sets.DWMax = {}

	-- Weapons sets
	sets.weapons.Default = {}
	sets.weapons.DualWeapons = {main="Naegling",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Blurred Knife +1",range="Ataktos"}
	sets.weapons.DualLeadenRanged = {main="Rostam",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualLeadenMelee = {main="Naegling",sub="Atoyac",range="Fomalhaut"}
	sets.weapons.DualAeolian = {main="Rostam",sub="Tauret",range="Ataktos"}
	sets.weapons.DualLeadenMeleeAcc = {main="Naegling",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.weapons.DualRanged = {main="Rostam",sub="Kustawi +1",range="Fomalhaut"}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
	head="Malignance chapeau",body="Malignance tabard",
    hands="Malignance Gloves",legs="Malignance Tights",
    feet="Malignance Boots", neck="Iskur gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",right_ear="Cessance Earring",
    left_ring="Epona's Ring",right_ring="hetairoi Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
    
    sets.engaged.Acc = {}
		
    sets.engaged.DT = {}
    
    sets.engaged.Acc.DT = {}

    sets.engaged.DW = {
	head="Malignance chapeau",body="Malignance tabard",
    hands="Malignance Gloves",legs="Malignance Tights",
    feet="Malignance Boots",neck="Iskur gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",right_ear="Cessance Earring",
    left_ring="Epona's Ring",right_ring="hetairoi Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
    
    sets.engaged.SB = {
	head="Malignance chapeau",body="Malignance tabard",
    hands="Malignance Gloves",legs="Malignance Tights",
    feet="Malignance Boots", neck="Iskur gorget",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",right_ear="Cessance Earring",
    ring1="Chirich ring +1",ring2="Chirich ring +1",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}},}
		

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 2)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 2)
    elseif player.sub_job == 'DRG' then
        set_macro_page(2, 2)
    else
        set_macro_page(1, 2)
    end
end

function user_job_lockstyle()
	if state.Weapons.value == 'Malignance pole' then
		windower.chat.input('/lockstyleset 1')
	else
		windower.chat.input('/lockstyleset 1')
	end
end