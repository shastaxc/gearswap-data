-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------


function user_setup()
    state.OffenseMode:options('LowAccTP', 'MEva', 'HighAccTP', 'Counter')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('DT', 'Resist')
    state.IdleMode:options('DT', 'idleMovement')

	--select_default_macro_book(1, 4)

end
function job_setup()
    ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','1000 Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort'}
end


function init_gear_sets()

	sets.enmity = {}
		
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	--Example:
	--sets.precast.JA['Provoke'] = sets.enmity
	
	sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves +1"}
	sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']


	-- Fast cast sets for spells
	sets.precast.FC = {}

	--sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck=''})
	
	--sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = {ammo="Aurgelmir Orb",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Karieyh Ring +1",
    right_ring="Regal Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','CHR+2','Rng.Atk.+1','DEF+2',}},}

	--Specific weaponskill declaration
	sets.precast.WS[''] = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
		
	sets.midcast.Cure = {}

sets.midcast.Pet.WS = {main="Agwu's Axe",
    sub="Adapa Shield",
    ammo="Voluspa Tathlum",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bst. Collar +2",
    waist="Incarnation Sash",
    left_ear={ name="Handler's Earring +1", augments={'Path: A',}},
    right_ear="Enmerkar Earring",
    left_ring="Tali'ah Ring",
    right_ring="C. Palug Ring",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}}}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.idle = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear={ name="Handler's Earring +1", augments={'Path: A',}},
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}}}
			
	--sets.idleMovement = {}

	--sets.idle.DT = {}

	--sets.Kiting = {}


	--------------------------------------
	-- Engaged sets
	--------------------------------------
	--These can be renamed at the top

	sets.engaged.LowAccTP = {ammo="Aurgelmir Orb",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Lissome Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring",
    right_ring="Chirich Ring +1",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','CHR+2','Rng.Atk.+1','DEF+2',}},}

	sets.engaged.MEva = {}
	
	sets.engaged.Counter = {  }

	sets.engaged.HighAccTP = {}
		
	sets.engaged.CC = {} -- Don't do anything to this

	sets.engaged.HP = {} -- Don't do anything to this

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.


function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 4) send_command('@input /lockstyleset 37')
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 4) send_command('@input /lockstyleset 37')
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 4) send_command('@input /lockstyleset 37')
	else
		set_macro_page(1, 4)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end	
end


function job_buff_change(buff, gain)
	end


function job_post_precast(spell, action, spellMap, eventArgs)
    if buffactive['Impetus'] and spell.english == 'Victory Smite' then 
		equip(sets.VS)
	end
end


function job_buff_change(buff, gain)
    if buff == 'Impetus' then
        if gain then
            equip(sets.impetus)
            disable('body')
        else
            enable('body')
        end
    end
	
    if buff == 'Boost' then
        if gain then
            equip(sets.Sash)
            disable('waist')
        else
            enable('waist')
        end
    end
end 
	
--Cancel weaponskill if out of range
function job_precast(spell, action, spellMap, eventArgs)    
if spell.type == 'WeaponSkill' and player.target.distance > (3.4 + player.target.model_size) then 
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        eventArgs.cancel = true        
        return
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    if ready_moves_to_check:contains(spell.english) and pet.status == 'Engaged' then
        equip(sets.midcast.Pet.WS)
    end
end

-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
 
if spell.type == "Monster" and not spell.interrupted then
    if ready_moves_to_check:contains(spell.english) and pet.status == 'Engaged' then
 equip(sets.midcast.Pet.WS)
 end
 eventArgs.handled = true
 end
 
 
end