function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','PDT','AM','AM.SomeAcc','Naegling','SomeAcc','Acc','FullAcc','DW','DWAM','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Attackcapped','Lowattack')
    state.HybridMode:options('Normal','PDT','PDTSomeAcc','MDT','MDTSomeAcc')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Ukonvasara','GreatAxe','Shining','Blunt','Cloudsplitter','Naegling','None')



	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')


  activate_AM_mode = {
    ["Conqueror"] = S{"Aftermath: Lv.3"},
    ["Bravura"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ragnarok"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Farsha"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Ukonvasara"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
  }


   silibs.enable_cancel_outranged_ws()
	silibs.enable_weapon_rearm()
	silibs.enable_cancel_on_blocking_status()

end

function update_melee_groups()
  if player then
		classes.CustomMeleeGroups:clear()

		if data.areas.adoulin:contains(world.area) and buffactive.Ionis then
			classes.CustomMeleeGroups:append('Adoulin')
		end

		if state.Buff['Brazen Rush'] or state.Buff["Warrior's Charge"] then
			classes.CustomMeleeGroups:append('Charge')
		end

		if state.Buff['Mighty Strikes'] then
			classes.CustomMeleeGroups:append('Mighty')
		end

    for weapon,am_list in pairs(activate_AM_mode) do
      if player.equipment.main == weapon or player.equipment.ranged == weapon then
        for am_level,_ in pairs(am_list) do
          if buffactive[am_level] and not classes.CustomMeleeGroups:contains('AM') then
            classes.CustomMeleeGroups:append('AM')
          end
        end
      end
    end
	end
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets

    sets.Enmity = {ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Engraved Belt",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Cryptic Earring",
    left_ring="Petrov Ring",
    right_ring="Defending Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
	sets.Knockback = {}
	sets.passive.Twilight = {head="Twilight Helm",body="Twilight Mail"}

	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {back="Cichol's Mantle",body="Pumm. Lorica +3",feet="Agoge Calligae"}
	sets.precast.JA['Warcry'] = {head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}}}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {}
	sets.precast.JA['Mighty Strikes'] = {}
	sets.precast.JA["Warrior's Charge"] = {}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Retaliation'] = {Feet="Boii Calligae +1"}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1", feet="Boii Calligae +1"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = { ammo="Sapience Orb",
    head="Volte Salade",
    body={ name="Odyss. Chestplate", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','AGI+1','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs="Volte Hose",
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','MND+7','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
    neck="Voltsurge Torque",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Weather. Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Midcast Sets
	sets.midcast.FastRecast = { ammo="Sapience Orb",
    head="Volte Salade",
    body={ name="Odyss. Chestplate", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','AGI+1','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs="Volte Hose",
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','MND+7','Mag. Acc.+9','"Mag.Atk.Bns."+14',}},
    neck="Voltsurge Torque",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Weather. Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},}

	sets.midcast['Blank Gaze'] = sets.Enmity

	sets.midcast['Sheep Song'] = sets.Enmity

	sets.midcast['Gaist Wall'] = sets.Enmity

	sets.midcast['Jettatura'] = sets.Enmity

	sets.midcast['Flash'] = sets.Enmity

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Cure = {}

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sulev. Gauntlets +2",
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sulev. Leggings +2",
    neck={ name="Warrior's Beads +2", augments={'Path: A',}},
    waist="Olseni Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Upheaval'] =  {
   ammo="Knobkierrie",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS['Upheaval'].Attackcapped =  {
	ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}

	sets.precast.WS['Upheaval'].Lowattack =  {
	ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}


    sets.precast.WS['Upheaval'].SomeAcc = {
	 ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},}
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Upheaval'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Upheaval'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Resolution'] =  {ammo="Seeth. Bomblet +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
  back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}


  sets.precast.WS['Armor Break'] =  {ammo="Seeth. Bomblet +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
   left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
  back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}

   sets.precast.WS['Full Break'] =  {ammo="Seeth. Bomblet +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
   left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
  back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}


   sets.precast.WS['Decimation'] =  {ammo="Seeth. Bomblet +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Schere Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}



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

    sets.precast.WS["Ukko's Fury"] = {
	ammo="Crepuscular Pebble",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.WS["Ukko's Fury"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Ukko's Fury"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Ukko's Fury"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["King's Justice"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["King's Justice"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["King's Justice"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["King's Justice"].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Calamity'] =  {ammo="Knobkierrie",
    head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
    body="Pumm. Lorica +3",
    hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +5%','STR+5',}},
   legs="Sakpata's Cuisses",
    feet="Sulev. Leggings +2",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}


    sets.precast.WS['Calamity'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS["Mistral Axe"] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Stardiver'] = {ammo="Seeth. Bomblet +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
   back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}



	sets.precast.WS['Cloudsplitter'] = { ammo="Knobkierrie",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Regal Ring",
    back={ name="Cichol's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%','Damage taken-5%',}},
}

sets.precast.WS['Cataclysm'] = {  ammo="Knobkierrie",
    head="Pixie Hairpin +1",
    body={ name="Odyss. Chestplate", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','AGI+1','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    hands={ name="Odyssean Gauntlets", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon Skill Acc.+12','CHR+9','Mag. Acc.+11','"Mag.Atk.Bns."+15',}},
    legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Damage taken-2%','MND+5','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
    feet={ name="Odyssean Greaves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','CHR+9','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Beithir Ring",
    right_ring="Archon Ring",
    back={ name="Cichol's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%','Damage taken-5%',}},
}

	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Cloudsplitter']



	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Lugra Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Brutal Earring",ear2="Moonshade Earring"}

	--Specialty WS set overwrites.
	sets.AccWSMightyCharge = {}
	sets.AccWSCharge = {}
	sets.AccWSMightyCharge = {}
	sets.WSMightyCharge = {}
	sets.WSCharge = {}
	sets.WSMighty = {}

     -- Sets to return to when not performing an action.

     -- Resting sets
     sets.resting = {ammo="Staunch Tathlum +1",
    head="Volte Salade",
    body="Chozor. Coselete",
     hands={ name="Macabre Gaunt. +1", augments={'Path: A',}},
    legs="Volte Hose",
    feet="Hermes' Sandals",
    neck="Sanctity Necklace",
    waist="Engraved Belt",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Cichol's Mantle", augments={'Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
}

	-- Idle sets
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head={ name="Valorous Mask", augments={'Damage taken-1%','Accuracy+11','Attack+8',}},
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Hermes' Sandals",
    neck="Sanctity Necklace",
    waist="Engraved Belt",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
}

	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	-- Defense sets
	sets.defense.PDT = { ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},
}

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = { ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},
}

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MEVA = { ammo="Staunch Tathlum +1",
    head="Hjarrandi Helm",
    body="Tartarus Platemail",
    hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},
}

	sets.Kiting = {"Hermes' Sandals"}
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}


            -- Engaged

	sets.engaged = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.AM = {
	ammo="Yetshila +1",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet={ name="Sakpata's Leggings", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring="Petrov Ring",
    right_ring="Hetairoi Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
}

sets.engaged.Naegling = {
ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

sets.engaged.Shining = {
ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Blunt = {
ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}


sets.engaged.Cloudsplitter = sets.engaged

sets.engaged.Cloudsplitter.SomeAcc = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body="Sakpata's Plate",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Petrov Ring",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}



    sets.engaged.SomeAcc = {    ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head="Sakpata's Helm",
    body="Pumm. Lorica +3",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	sets.engaged.Acc = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body=gear.valorous_wsd_body,hands=gear.valorous_acc_hands,ring1="Flamma Ring",ring2="Niqmaddu Ring",
		back="Cichol's Mantle",waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2"}
    sets.engaged.FullAcc = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body=gear.valorous_wsd_body,hands=gear.valorous_acc_hands,ring1="Flamma Ring",ring2="Ramuh Ring +1",
		back="Cichol's Mantle",waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2"}
    sets.engaged.Fodder = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous_wsd_body,hands=gear.valorous_acc_hands,ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back="Cichol's Mantle",waist="Ioskeha Belt +1",legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2"}



	sets.engaged.PDT = {ammo="Yetshila +1",
    head={ name="Sakpata's Helm", augments={'Path: A',}},
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet={ name="Sakpata's Leggings", augments={'Path: A',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring="Hetairoi Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
}
	sets.engaged.SomeAcc.PDT = { ammo="Staunch Tathlum +1",
    head="Hjarrandi Helm",
    body="Tartarus Platemail",
    hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
    legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Dbl.Atk."+10','Mag. Evasion+15',}},
}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}




sets.engaged.Farsha = set_combine(sets.engaged,{})

sets.engaged.DW = set_combine(sets.engaged,{
right_ear="Eabani Earring",
back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})

sets.engaged.DW.PDT = set_combine(sets.engaged.PDT,{
right_ear="Eabani Earring",
back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},})







	sets.engaged.Farsha.AM = sets.engaged




--[[
    sets.engaged.Charge = {}
	sets.engaged.SomeAcc.Charge = {}
	sets.engaged.Acc.Charge = {}
	sets.engaged.FullAcc.Charge = {}
	sets.engaged.Fodder.Charge = {}

    sets.engaged.Mighty = {}
	sets.engaged.SomeAcc.Mighty = {}
	sets.engaged.Acc.Mighty = {}
	sets.engaged.FullAcc.Mighty = {}
	sets.engaged.Fodder.Mighty = {}

    sets.engaged.Charge.Mighty = {}
	sets.engaged.SomeAcc.Charge.Mighty = {}
	sets.engaged.Acc.Charge.Mighty = {}
	sets.engaged.FullAcc.Charge.Mighty = {}
	sets.engaged.Fodder.Charge.Mighty = {}

    sets.engaged.Adoulin = {}
	sets.engaged.SomeAcc.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.FullAcc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}

    sets.engaged.Adoulin.Charge = {}
	sets.engaged.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Acc.Adoulin.Charge = {}
	sets.engaged.FullAcc.Adoulin.Charge = {}
	sets.engaged.Fodder.Adoulin.Charge = {}

    sets.engaged.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Acc.Adoulin.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Fodder.Adoulin.Mighty = {}

    sets.engaged.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.Adoulin.Charge.Mighty = {}

    sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}


    sets.engaged.PDT.Charge = {}
	sets.engaged.SomeAcc.PDT.Charge = {}
	sets.engaged.Acc.PDT.Charge = {}
	sets.engaged.FullAcc.PDT.Charge = {}
	sets.engaged.Fodder.PDT.Charge = {}

    sets.engaged.PDT.Mighty = {}
	sets.engaged.SomeAcc.PDT.Mighty = {}
	sets.engaged.Acc.PDT.Mighty = {}
	sets.engaged.FullAcc.PDT.Mighty = {}
	sets.engaged.Fodder.PDT.Mighty = {}

    sets.engaged.PDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Charge.Mighty = {}

    sets.engaged.PDT.Adoulin = {}
	sets.engaged.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.FullAcc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}

    sets.engaged.PDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge = {}

    sets.engaged.PDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Mighty = {}

    sets.engaged.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.PDT.Adoulin.Charge.Mighty = {}

    sets.engaged.MDT = {}
	sets.engaged.SomeAcc.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.FullAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}

    sets.engaged.MDT.Charge = {}
	sets.engaged.SomeAcc.MDT.Charge = {}
	sets.engaged.Acc.MDT.Charge = {}
	sets.engaged.FullAcc.MDT.Charge = {}
	sets.engaged.Fodder.MDT.Charge = {}

    sets.engaged.MDT.Mighty = {}
	sets.engaged.SomeAcc.MDT.Mighty = {}
	sets.engaged.Acc.MDT.Mighty = {}
	sets.engaged.FullAcc.MDT.Mighty = {}
	sets.engaged.Fodder.MDT.Mighty = {}

    sets.engaged.MDT.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Charge.Mighty = {}

    sets.engaged.MDT.Adoulin = {}
	sets.engaged.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.FullAcc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}

    sets.engaged.MDT.Adoulin.Charge = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge = {}

    sets.engaged.MDT.Adoulin.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Mighty = {}

    sets.engaged.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Fodder.MDT.Adoulin.Charge.Mighty = {}

            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Farsha melee sets
    sets.engaged.Farsha = {}
	sets.engaged.Farsha.SomeAcc = {}
	sets.engaged.Farsha.Acc = {}
	sets.engaged.Farsha.FullAcc = {}
	sets.engaged.Farsha.Fodder = {}

    sets.engaged.Farsha.Adoulin = {}
	sets.engaged.Farsha.SomeAcc.Adoulin = {}
	sets.engaged.Farsha.Acc.Adoulin = {}
	sets.engaged.Farsha.FullAcc.Adoulin = {}
	sets.engaged.Farsha.Fodder.Adoulin = {}

    sets.engaged.Farsha.AM = {}
	sets.engaged.Farsha.SomeAcc.AM = {}
	sets.engaged.Farsha.Acc.AM = {}
	sets.engaged.Farsha.FullAcc.AM = {}
	sets.engaged.Farsha.Fodder.AM = {}

    sets.engaged.Farsha.Adoulin.AM = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.AM = {}
	sets.engaged.Farsha.Acc.Adoulin.AM = {}
	sets.engaged.Farsha.FullAcc.Adoulin.AM = {}
	sets.engaged.Farsha.Fodder.Adoulin.AM = {}

    sets.engaged.Farsha.Charge = {}
	sets.engaged.Farsha.SomeAcc.Charge = {}
	sets.engaged.Farsha.Acc.Charge = {}
	sets.engaged.Farsha.FullAcc.Charge = {}
	sets.engaged.Farsha.Fodder.Charge = {}

    sets.engaged.Farsha.Adoulin.Charge = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Farsha.Acc.Adoulin.Charge = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Charge = {}
	sets.engaged.Farsha.Fodder.Adoulin.Charge = {}

    sets.engaged.Farsha.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.Charge.AM = {}
	sets.engaged.Farsha.Acc.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.Charge.AM = {}
	sets.engaged.Farsha.Fodder.Charge.AM = {}

    sets.engaged.Farsha.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Farsha.PDT = {}
	sets.engaged.Farsha.SomeAcc.PDT = {}
	sets.engaged.Farsha.Acc.PDT = {}
	sets.engaged.Farsha.FullAcc.PDT = {}
	sets.engaged.Farsha.Fodder.PDT = {}

	sets.engaged.Farsha.PDT.Adoulin = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin = {}

	sets.engaged.Farsha.PDT.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.AM = {}
	sets.engaged.Farsha.Acc.PDT.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.AM = {}
	sets.engaged.Farsha.Fodder.PDT.AM = {}

	sets.engaged.Farsha.PDT.Adoulin.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Farsha.PDT.Charge = {}
	sets.engaged.Farsha.SomeAcc.PDT.Charge = {}
	sets.engaged.Farsha.Acc.PDT.Charge = {}
	sets.engaged.Farsha.FullAcc.PDT.Charge = {}
	sets.engaged.Farsha.Fodder.PDT.Charge = {}

	sets.engaged.Farsha.PDT.Adoulin.Charge = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Farsha.PDT.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Farsha.Acc.PDT.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Charge.AM = {}

	sets.engaged.Farsha.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Farsha.MDT = {}
	sets.engaged.Farsha.SomeAcc.MDT = {}
	sets.engaged.Farsha.Acc.MDT = {}
	sets.engaged.Farsha.FullAcc.MDT = {}
	sets.engaged.Farsha.Fodder.MDT = {}

	sets.engaged.Farsha.MDT.Adoulin = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin = {}

	sets.engaged.Farsha.MDT.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.AM = {}
	sets.engaged.Farsha.Acc.MDT.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.AM = {}
	sets.engaged.Farsha.Fodder.MDT.AM = {}

	sets.engaged.Farsha.MDT.Adoulin.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Farsha.MDT.Charge = {}
	sets.engaged.Farsha.SomeAcc.MDT.Charge = {}
	sets.engaged.Farsha.Acc.MDT.Charge = {}
	sets.engaged.Farsha.FullAcc.MDT.Charge = {}
	sets.engaged.Farsha.Fodder.MDT.Charge = {}

	sets.engaged.Farsha.MDT.Adoulin.Charge = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Farsha.MDT.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Farsha.Acc.MDT.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Charge.AM = {}

	sets.engaged.Farsha.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Charge.AM = {}

    sets.engaged.Farsha.Mighty = {}
	sets.engaged.Farsha.SomeAcc.Mighty = {}
	sets.engaged.Farsha.Acc.Mighty = {}
	sets.engaged.Farsha.FullAcc.Mighty = {}
	sets.engaged.Farsha.Fodder.Mighty = {}

    sets.engaged.Farsha.Adoulin.Mighty = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Farsha.Acc.Adoulin.Mighty = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Farsha.Fodder.Adoulin.Mighty = {}

    sets.engaged.Farsha.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.Mighty.AM = {}
	sets.engaged.Farsha.Acc.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.Mighty.AM = {}

    sets.engaged.Farsha.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.Adoulin.Mighty.AM = {}

    sets.engaged.Farsha.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.Charge.Mighty = {}

    sets.engaged.Farsha.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.Adoulin.Charge.Mighty = {}

    sets.engaged.Farsha.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.Charge.Mighty.AM = {}

    sets.engaged.Farsha.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Farsha.PDT.Mighty = {}
	sets.engaged.Farsha.SomeAcc.PDT.Mighty = {}
	sets.engaged.Farsha.Acc.PDT.Mighty = {}
	sets.engaged.Farsha.FullAcc.PDT.Mighty = {}
	sets.engaged.Farsha.Fodder.PDT.Mighty = {}

	sets.engaged.Farsha.PDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Farsha.PDT.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Farsha.Acc.PDT.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Farsha.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Farsha.PDT.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Farsha.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Farsha.PDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Farsha.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Farsha.MDT.Mighty = {}
	sets.engaged.Farsha.SomeAcc.MDT.Mighty = {}
	sets.engaged.Farsha.Acc.MDT.Mighty = {}
	sets.engaged.Farsha.FullAcc.MDT.Mighty = {}
	sets.engaged.Farsha.Fodder.MDT.Mighty = {}

	sets.engaged.Farsha.MDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Farsha.MDT.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Farsha.Acc.MDT.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Farsha.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Farsha.MDT.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Farsha.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Farsha.MDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Farsha.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Farsha.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

-- Bravura melee sets
    sets.engaged.Bravura = {}
	sets.engaged.Bravura.SomeAcc = {}
	sets.engaged.Bravura.Acc = {}
	sets.engaged.Bravura.FullAcc = {}
	sets.engaged.Bravura.Fodder = {}

    sets.engaged.Bravura.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.Adoulin = {}
	sets.engaged.Bravura.Acc.Adoulin = {}
	sets.engaged.Bravura.FullAcc.Adoulin = {}
	sets.engaged.Bravura.Fodder.Adoulin = {}

    sets.engaged.Bravura.AM = {}
	sets.engaged.Bravura.SomeAcc.AM = {}
	sets.engaged.Bravura.Acc.AM = {}
	sets.engaged.Bravura.FullAcc.AM = {}
	sets.engaged.Bravura.Fodder.AM = {}

    sets.engaged.Bravura.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.AM = {}

    sets.engaged.Bravura.Charge = {}
	sets.engaged.Bravura.SomeAcc.Charge = {}
	sets.engaged.Bravura.Acc.Charge = {}
	sets.engaged.Bravura.FullAcc.Charge = {}
	sets.engaged.Bravura.Fodder.Charge = {}

    sets.engaged.Bravura.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge = {}

    sets.engaged.Bravura.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.AM = {}
	sets.engaged.Bravura.Acc.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Charge.AM = {}

    sets.engaged.Bravura.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.PDT = {}
	sets.engaged.Bravura.SomeAcc.PDT = {}
	sets.engaged.Bravura.Acc.PDT = {}
	sets.engaged.Bravura.FullAcc.PDT = {}
	sets.engaged.Bravura.Fodder.PDT = {}

	sets.engaged.Bravura.PDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin = {}

	sets.engaged.Bravura.PDT.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.AM = {}
	sets.engaged.Bravura.Acc.PDT.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.AM = {}
	sets.engaged.Bravura.Fodder.PDT.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Bravura.PDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Charge = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Bravura.PDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Bravura.MDT = {}
	sets.engaged.Bravura.SomeAcc.MDT = {}
	sets.engaged.Bravura.Acc.MDT = {}
	sets.engaged.Bravura.FullAcc.MDT = {}
	sets.engaged.Bravura.Fodder.MDT = {}

	sets.engaged.Bravura.MDT.Adoulin = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin = {}

	sets.engaged.Bravura.MDT.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.AM = {}
	sets.engaged.Bravura.Acc.MDT.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.AM = {}
	sets.engaged.Bravura.Fodder.MDT.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Bravura.MDT.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Charge = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Bravura.MDT.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.AM = {}

    sets.engaged.Bravura.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Mighty = {}
	sets.engaged.Bravura.Acc.Mighty = {}
	sets.engaged.Bravura.FullAcc.Mighty = {}
	sets.engaged.Bravura.Fodder.Mighty = {}

    sets.engaged.Bravura.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty = {}

    sets.engaged.Bravura.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Mighty.AM = {}

    sets.engaged.Bravura.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Mighty.AM = {}

    sets.engaged.Bravura.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty = {}

    sets.engaged.Bravura.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty = {}

    sets.engaged.Bravura.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Charge.Mighty.AM = {}

    sets.engaged.Bravura.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty = {}

	sets.engaged.Bravura.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Bravura.PDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Bravura.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Bravura.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty = {}

	sets.engaged.Bravura.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Bravura.MDT.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Bravura.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Bravura.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Bravura.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

-- Ragnarok melee sets
    sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.SomeAcc = {}
	sets.engaged.Ragnarok.Acc = {}
	sets.engaged.Ragnarok.FullAcc = {}
	sets.engaged.Ragnarok.Fodder = {}

    sets.engaged.Ragnarok.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin = {}
	sets.engaged.Ragnarok.Acc.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.Adoulin = {}

    sets.engaged.Ragnarok.AM = {}
	sets.engaged.Ragnarok.SomeAcc.AM = {}
	sets.engaged.Ragnarok.Acc.AM = {}
	sets.engaged.Ragnarok.FullAcc.AM = {}
	sets.engaged.Ragnarok.Fodder.AM = {}

    sets.engaged.Ragnarok.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.AM = {}

    sets.engaged.Ragnarok.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Charge = {}
	sets.engaged.Ragnarok.Acc.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Charge = {}
	sets.engaged.Ragnarok.Fodder.Charge = {}

    sets.engaged.Ragnarok.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge = {}

    sets.engaged.Ragnarok.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.AM = {}

    sets.engaged.Ragnarok.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.PDT = {}
	sets.engaged.Ragnarok.SomeAcc.PDT = {}
	sets.engaged.Ragnarok.Acc.PDT = {}
	sets.engaged.Ragnarok.FullAcc.PDT = {}
	sets.engaged.Ragnarok.Fodder.PDT = {}

	sets.engaged.Ragnarok.PDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin = {}

	sets.engaged.Ragnarok.PDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.AM = {}

	sets.engaged.Ragnarok.PDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge = {}

	sets.engaged.Ragnarok.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.MDT = {}
	sets.engaged.Ragnarok.SomeAcc.MDT = {}
	sets.engaged.Ragnarok.Acc.MDT = {}
	sets.engaged.Ragnarok.FullAcc.MDT = {}
	sets.engaged.Ragnarok.Fodder.MDT = {}

	sets.engaged.Ragnarok.MDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin = {}

	sets.engaged.Ragnarok.MDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.AM = {}

	sets.engaged.Ragnarok.MDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge = {}

	sets.engaged.Ragnarok.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.AM = {}

    sets.engaged.Ragnarok.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty = {}
	sets.engaged.Ragnarok.Acc.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Mighty = {}

    sets.engaged.Ragnarok.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty = {}

    sets.engaged.Ragnarok.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Mighty.AM = {}

    sets.engaged.Ragnarok.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Mighty.AM = {}

    sets.engaged.Ragnarok.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty = {}

    sets.engaged.Ragnarok.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty = {}

    sets.engaged.Ragnarok.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Charge.Mighty.AM = {}

    sets.engaged.Ragnarok.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty = {}

	sets.engaged.Ragnarok.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Ragnarok.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty = {}

	sets.engaged.Ragnarok.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty = {}

	sets.engaged.Ragnarok.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Charge.Mighty.AM = {}

	sets.engaged.Ragnarok.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.Charge.Mighty.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.Charge.Mighty.AM = {}

]]--

	--Extra Special Sets

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})



	-- Weapons sets
	sets.weapons.Farsha = {main="Farsha",sub="Blurred Shield +1"}
	sets.weapons.Cloudsplitter = {main="Farsha",sub="Blurred Shield +1"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.DualWeapons = {main="Dolichenus",sub="Zantetsuken"}
	sets.weapons.AE = {main="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',},sub="Malevolence"}
	sets.weapons.Greatsword = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.GreatAxe = {main="Chango",sub="Utu Grip"}
	sets.weapons.Ukonvasara = {main="Ukonvasara",sub="Utu Grip"}
	sets.weapons.Shining = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Blunt = {main="Loxotic mace +1",sub="Blurred Shield +1"}
	sets.weapons.Staff = {main="Kaja staff",sub="Utu Grip"}

end

function user_customize_melee_set(meleeSet)
  if buffactive['Blood Rage'] then
    meleeSet = set_combine(meleeSet, {
      feet="Boii Calligae +1",
    })
  end
  return meleeSet
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
