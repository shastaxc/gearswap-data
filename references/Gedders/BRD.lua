function get_sets()
 
    sets.idle = {}                  -- Leave this empty
    sets.melee = {}		    -- Leave this empty
    sets.ws = {}	            -- Leave this empty
    sets.ja = {}		    -- Leave this empty
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
    sets.precast = {}		    -- leave this empty	
  
    sets.precast.FC = {
    main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
    sub="Genmei Shield",
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    
    sets.midcast.cure = {
    main="Iridal Staff",
    range="Gjallarhorn",
    head="Xux Hat",
    body="Inyanga Jubbah +1",
    hands="Weath. Cuffs +1",
    legs="Aya. Cosciales +2",
    feet="Fili Cothurnes +1",
    neck="Aoidos' Matinee",
    waist="Aoidos' Belt",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
    sets.midcast.BardSong = {    main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +2",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
}
	

--    sets.midcast.Ballad = {main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
--    sub="Genmei Shield",
--    range="Gjallarhorn",
--    head="Fili Calot",
--    body="Inyanga Jubbah +2",
--    hands="Inyan. Dastanas +1",
--    legs="Aya. Cosciales +2",
--    feet="Inyan. Crackows +1",
--    neck="Moonbow Whistle",
--    waist="Flume Belt +1",
--    left_ear="Regal Earring",
--    right_ear="Genmei Earring",
--    left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
--    right_ring="Defending Ring",
--    back="Nexus Cape",
--}
	
	sets.midcast.Scherzo = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +",
    feet="Fili Cothurnes +1",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	
	sets.midcast.Etude = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Mousai Turban",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Threnody = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Mousai Manteel",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Carol = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Mousai Gages",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Minne = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Mousai Seraweels",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Mambo = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Mousai Crackows",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Dirge= {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Sirvente = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Lullaby = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Brioso Roundlet",
    body="Fili Hongreline +1",
    hands="Brioso Cuffs",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	
	sets.midcast.Debuff = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}},
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Brioso Roundlet",
    body="Brioso Just.",
    hands="Brioso Cuffs",
    legs="Brioso Cannions",
    feet="Brioso Slippers",
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Static Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
	

    sets.midcast.Dummy ={
    main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
    sub="Genmei Shield",
    range="Daurdabla",
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
    neck="Mnbw. Whistle +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }
end
 
function precast(spell)
    equip(sets.precast.FC)
end
 
function midcast(spell)
	if spell.name:match('Cure') or spell.name:match('Cura') then
	equip(sets.midcast.cure)
	end
    if spell.type == "BardSong" then
	equip (sets.midcast.BardSong)
    end 
    if spell.name:match('Ballad') then
  equip (sets.midcast.Ballad) 
    end
	if spell.name:match('Scherzo') then
  equip (sets.midcast.Scherzo) 
    end
	if spell.name:match('Paeon') then
  equip (sets.midcast.Paeon) 
    end
	if spell.name:match('Etude') then
  equip (sets.midcast.Etude) 
    end
	if spell.name:match('Threnody') then
  equip (sets.midcast.Threnody) 
    end
	if spell.name:match('Carol') then
  equip (sets.midcast.Carol) 
    end
	if spell.name:match('Minne') then
  equip (sets.midcast.Minne) 
    end
	if spell.name:match('Mambo') then
  equip (sets.midcast.Mambo) 
    end
	if spell.name:match('Dirge') then
  equip (sets.midcast.Dirge) 
    end
	if spell.name:match('Sirvente') then
  equip (sets.midcast.Sirvente) 
    end	
    if spell.name:match('Lullaby') then
  equip (sets.midcast.Lullaby) 
    end   
    if spell.name:match('Nocturne') then
  equip (sets.midcast.Debuff) 
    end  
    if spell.name:match('Virelai') then
  equip (sets.midcast.Debuff) 
    end  
    if spell.name:match('Finale') then
  equip (sets.midcast.Debuff) 
    end  
    if spell.name:match('Elegy') then
  equip (sets.midcast.Debuff) 
    end  
    if spell.name:match('Requiem') then
  equip (sets.midcast.Debuff) 
    end   
    if spell.name:match('Goblin Gavotte') then
  equip (sets.midcast.Dummy) 
    end  
    
   
end
 
function aftercast(spell)
     idle()
end
 
function idle()
    equip(sets.idle.normal)
end
 
function status_change(new,old)
 
end