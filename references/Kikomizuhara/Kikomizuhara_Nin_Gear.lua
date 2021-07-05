-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','sb','SomeAcc','Acc','FullAcc','DWtwentyone','Fodder','Crit')
	state.HybridMode:options('Normal','DT','Counter')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Lowattack','Fodder','Proc')
	state.Stance:options('None','Yonin','Innin')
	state.IdleMode:options('Normal','Sphere')
	state.PhysicalDefenseMode:options('PDT','HP')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Chi','Nagi','Heishi','Tank','Heishicrit','Ageha','Evisceration')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','SuppaBrutal','DWEarrings','DWMax'}

	gear.wsd_jse_back = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.da_jse_back = {name="Andartia's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	send_command('bind ^` input /ja "Innin" <me>')
	send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	

	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06

	
  activate_AM_mode = {
    ["Nagi"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
  }
end

function update_melee_groups()
  if player then
		classes.CustomMeleeGroups:clear()
		
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
    -- Precast sets
    --------------------------------------

    sets.Enmity = {ammo="Sapience Orb",
    head="Malignance Chapeau",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs="Zoar Subligar +1",
    feet="Hattori Kyahan",
    neck="Loricate Torque +1",
    waist="Kasiri Belt",
    left_ear="Cryptic Earring",
    right_ear="Trux Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    back={ name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},
}

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {hands="Hattori Tekko +1"}
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Mummu Jacket +2",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}

    sets.precast.Flourish1 = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Hattori Hakama +1",feet="Malignance Boots"}

    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Fast Cast"+4','"Mag.Atk.Bns."+4',}},
    body={ name="Taeon Tabard", augments={'Accuracy+22','"Fast Cast"+5','Phalanx +3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+18','Weapon skill damage +5%','Attack+8',}},
    feet="Hattori Kyahan",
    neck="Voltsurge Torque",
    waist="Audumbla Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},
}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket",feet="Hattori Kyahan"})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {ammo="Staunch Tathlum +1",ring1="Prolix Ring"})

    -- Snapshot for ranged
    sets.precast.RA = {}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	 ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head="Hachiya Hatsu. +3",
    body={ name="Herculean Vest", augments={'Attack+19','Rng.Acc.+28','Weapon skill damage +6%','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Beithir Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},}
		
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {head="Dampening Tam",body="Ken. Samue",legs="Hiza. Hizayoroi +2",ear2="Telos Earring"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="C. Palug Stone",head="Ynglinga Sallet",neck="Combatant's Torque",ear2="Telos Earring",body="Ken. Samue",hands="Mummu Wrists +2",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {ammo="C. Palug Stone",head="Ynglinga Sallet",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",body="Mummu Jacket +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Malignance Boots"})
	sets.precast.WS.Proc = {ammo="Togakushi Shuriken",
        head="Ynglinga Sallet",neck="Moonbeam Nodowa",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.da_jse_back,waist="Olseni Belt",legs="Mummu Kecks +2",feet="Malignance Boots"}
		
		
		sets.precast.WS.Fodder = {ammo="Date Shuriken",
    head={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Accuracy+15',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Dedition Earring",
    left_ring="Chirich Ring +1",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {ammo="Yetshila +1",head="Adhemar Bonnet +1",ammo="Yetshila +1",head="Adhemar Bonnet +1",body="Abnoba Kaftan",hands="Ryuo Tekko",ring1="Begrudging Ring",waist="Grunfeld Rope",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Jin'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Yetshila +1",head="Mummu Bonnet +2",ammo="Yetshila +1",head="Mummu Bonnet +2",body="Abnoba Kaftan",hands="Ryuo Tekko",waist="Grunfeld Rope",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +2",body="Sayadio's Kaftan",hands="Ryuo Tekko",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Jin'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Mummu Jacket +2",hands="Ryuo Tekko",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Jin'].Fodder = set_combine(sets.precast.WS['Blade: Jin'], {head="Adhemar Bonnet +1"})

	sets.precast.WS['Blade: Hi'] = {
	ammo="C. Palug Stone",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},
	}
	
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Yetshila +1",head="Mummu Bonnet +2",ear1="Moonshade Earring",ear2="Trux Earring",body="Abnoba Kaftan",hands="Ryuo Tekko",ring1="Begrudging Ring",back=gear.wsd_jse_back,legs="Hiza. Hizayoroi +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +2",ear1="Moonshade Earring",ear2="Telos Earring",body="Sayadio's Kaftan",hands="Ryuo Tekko",legs="Hiza. Hizayoroi +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc, {hands="Ryuo Tekko",legs="Hiza. Hizayoroi +2"})
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Shun'] = {ammo="C. Palug Stone",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},}
	
	 sets.precast.WS['Blade: Shun'].Lowattack = {ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
     head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring", legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},}
	
	
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS['Blade: Shun'], {ammo="C. Palug Stone",ear1="Lugra Earring",ear2="Lugra Earring +1",legs="Jokushu Haidate",feet="Malignance Boots"})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS['Blade: Shun'], {})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Blade: Ten'] =  {
	ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head="Hachiya Hatsu. +3",
     body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Beithir Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Blade: Ten'].Lowattack =  {ammo="Seeth. Bomblet +1",
    head="Hachiya Hatsu. +3",
    body={ name="Agony Jerkin +1", augments={'Path: A',}},
    hands="Malignance Gloves",
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Herculean Boots", augments={'Pet: Mag. Acc.+4','Pet: INT+1','Weapon skill damage +8%','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},
	}
	
	
    sets.precast.WS['Blade: Ten'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="C. Palug Stone",neck="Caro Necklace",ear1="Moonshade Earring",body=gear.herculean_wsd_body,back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Hiza. Hizayoroi +2",feet=gear.herculean_wsd_feet})
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.wsd_jse_back})
    sets.precast.WS['Blade: Ten'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ten'].Fodder = set_combine(sets.precast.WS['Blade: Ten'], {})
	
	sets.precast.WS['Blade: Kamu'] = { ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head="Hachiya Hatsu. +3",
    body="Mpaca's Doublet",
    hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Trux Earring",
    left_ring="Epona's Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},
	}
	
	sets.precast.WS['Blade: Chi'] = {
	 ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Beithir Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']

sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']

    sets.precast.WS['Aeolian Edge'] = {ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Gere Ring",
    right_ring="Beithir Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},}
	
	sets.precast.WS['Tachi: Ageha'] = {ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Danzo Sune-Ate",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Lempo Earring",
    right_ear="Digni. Earring",
    left_ring="Bethir Ring",
    right_ring="Weather. Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Evisceration'] = { ammo="C. Palug Stone",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands={ name="Mochizuki Tekko +3", augments={'Enh. "Ninja Tool Expertise" effect',}},
    legs="Jokushu Haidate",
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Odr Earring",
    left_ring="Epona's Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Mag. Evasion+15',}},}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Friomisi Earring"}
	sets.AccMaxTP = {ear1="Ishvara Earring",ear2="Friomisi Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Moonshade Earring",ear2="Brutal Earring",}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Fast Cast"+4','"Mag.Atk.Bns."+4',}},
    body={ name="Taeon Tabard", augments={'Accuracy+22','"Fast Cast"+5','Phalanx +3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+18','Weapon skill damage +5%','Attack+8',}},
    feet="Hattori Kyahan",
    neck="Voltsurge Torque",
    waist="Audumbla Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+10 Attack+10','STR+10','Weapon skill damage +10%',}},
}

    sets.midcast.ElementalNinjutsu = {ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear="Digni. Earring",
    left_ring="Dingir Ring",
    right_ring="Regal Ring",
    back={ name="Andartia's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},}

	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

	sets.MagicBurst = {ring1="Mujin Band",ring2="Locus Ring"}

    sets.midcast.NinjutsuDebuff = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Mochizuki Tekko +1",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Rawhide Trousers",feet="Mochi. Kyahan +1"}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back="Andartia's Mantle",feet="Hattori Kyahan +1"})

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
		
    sets.midcast['Poisonga'] = sets.Enmity
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
	ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Danzo Sune-Ate",
    neck="Sanctity Necklace",
    waist="Engraved Belt",
    left_ear="Etiolation Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.defense.PDT = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},}
	
	sets.defense.HP = {ammo="Date Shuriken",
    head="Genmei Kabuto",
    body="Ashera Harness",
    hands="Mpaca's Gloves",
    legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet="Malignance Boots",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Engraved Belt",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Tuisto Earring",
    left_ring="Praan Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},}

	sets.defense.MEVA = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Mag. Evasion+15',}},}


    sets.Kiting = {feet="Danzo Sune-Ate"}
	sets.DuskKiting = {}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
	ammo="Date Shuriken",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",
    right_ear="Brutal Earring",
    left_ring="Epona's Ring",
    right_ring="Chirich Ring +1",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}




 sets.engaged.sb = {ammo="Date Shuriken",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

 sets.engaged.DWtwentyone = { ammo="Date Shuriken",
    head={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Accuracy+15',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet={ name="Taeon Boots", augments={'Phalanx +3',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist="Reiki Yotai",
     left_ear="Telos Earring",
    right_ear="Eabani Earring",
    left_ring="Epona's Ring",
    right_ring="Gere Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.SomeAcc = {ammo="Date Shuriken",
    head="Malignance Chapeau",
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
     legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet="Malignance Boots",
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.Acc = { ammo="Date Shuriken",
    head="Malignance Chapeau",
    body="Ashera Harness",
    hands="Malignance Gloves",
     legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet="Malignance Boots",
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
     left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.FullAcc = { ammo="Date Shuriken",
	head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist="Yemaya Belt",
    left_ear="Telos Earring",
    right_ear="Enervating Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.Fodder = {ammo="Date Shuriken",
    head={ name="Herculean Helm", augments={'"Triple Atk."+4','STR+10','Accuracy+15',}},
    body="Ashera Harness",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet={ name="Herculean Boots", augments={'Accuracy+10','"Triple Atk."+4',}},
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Brutal Earring",
    right_ear="Dedition Earring",
    left_ring="Epona's Ring",
    right_ring="Gere Ring",
   back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},}

    sets.engaged.Crit = {ammo="Date Shuriken",
    head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck={ name="Ninja Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Odr Earring",
    right_ear="Brutal Earring",
    left_ring="Mummu Ring",
    right_ring="Gere Ring",
   back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

    sets.engaged.DT = {ammo="Date Shuriken",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Loricate Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.Counter = {ammo="Date Shuriken",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands="Malignance Gloves",
    legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet="Malignance Boots",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Engraved Belt",
    left_ear="Genmei Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
   back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},}

	sets.engaged.SomeAcc.DT = {ammo="Togakushi Shuriken",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {ammo="Togakushi Shuriken",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.FullAcc.DT = {ammo="Togakushi Shuriken",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Mache Earring +1",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ramuh Ring +1",
        back=gear.da_jse_back,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Fodder.DT = {ammo="Togakushi Shuriken",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi +1",neck="Loricate Torque +1"} --body="Hattori Ningi +1"
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Futae = {}
    sets.buff.Yonin = {legs="Hattori Hakama +1"} --
    sets.buff.Innin = {} --head="Hattori Zukin +1"

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Shetal Stone"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}

	-- Weapons sets
	sets.weapons.MagicWeapons = {main="Naegling",sub="Tauret"}
	sets.weapons.Chi = {main="Heishi Shorinken",sub="Kunimitsu"}
	sets.weapons.Tank = {main="Nagi",sub="Ternion Dagger +1"}
	sets.weapons.Nagi = {main="Nagi",sub="Kunimitsu"}
	sets.weapons.Heishi = {main="Heishi Shorinken",sub="Ternion Dagger +1"}
	sets.weapons.Heishicrit = {main="Heishi Shorinken",sub="Taka"}
	sets.weapons.Ageha = {main="Kaja Tachi",sub="Utu Grip"}
	sets.weapons.Savage = {main="Naegling",sub="Uzura +2"}
	sets.weapons.Evisceration = {main="Tauret",sub="Ternion Dagger +1"}
	sets.weapons.HeishiKC = {main="Heishi Shorinken",sub="Kraken Club"}
	sets.weapons.ProcDagger = {main="Chicken Knife II",sub=empty}
	sets.weapons.ProcSword = {main="Ark Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Lament",sub=empty}
	sets.weapons.ProcScythe = {main="Ark Scythe",sub=empty}
	sets.weapons.ProcPolearm = {main="Pitchfork +1",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Hardwood Katana",sub=empty}
	sets.weapons.ProcKatana = {main="Kanaria",sub=empty}
	sets.weapons.ProcClub = {main="Dream Bell +1",sub=empty}
	sets.weapons.ProcStaff = {main="Terra's Staff",sub=empty}
	
	
end


