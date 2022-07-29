-- 
-- @author Thefoxdanger of Asura
-- RDM.lua v1.0
--
-- 
-- Intermediate RDM lua created to streamline play with as few toggles and other things to press as possible. Designed to be similar in 
-- fuction to the rest of Spicyryan's luas in the Github However, this is a job that naturally has a lot of levers to throw, so take time 
-- to get used to the keybinds below. It also has A LOT of gear fields, which is for a good reason. Make sure to read over comments, reviewing 
-- the current gear in slots to understand what goes there if you don't have my exact gearsets. Everything is very clearly labeled, and if 
-- a set seems to be a duplicate, check that it isn't a version that takes Melee_mode into account.
--
-- I plan to maintain this lua as a template, however if you get a hold of this it is YOUR responsibility to understand its use
-- and to troubleshoot issues within. I will not fix your lua if I do not know you (and probably wont if I do know you). 
-- Have fun~!
-- 	

	
--binds--
-- 4 sets you will toggle frequently
send_command("bind F9 gs c toggle TP set") -- F9 switches between melee sets
send_command("bind !F9 gs c toggle TP set reverse") -- Alt+F9 switches between melee sets in reverse

send_command("bind F10 gs c toggle Range set") -- F10 switches between range sets
send_command("bind !F10 gs c toggle Range set reverse") -- Alt+F10 switches between range sets in reverse

send_command("bind F11 gs c toggle WS set") -- F11 switches between WS sets
send_command("bind !F11 gs c toggle WS set reverse") -- Alt+F11 switches between WS sets in reverse

send_command("bind F12 gs c toggle Idle set") -- F12 switches between idle sets
send_command("bind !F12 gs c toggle Idle set reverse") -- Alt+F12 switches between idle sets in reverse

-- less frequently changed/'setup' toggles
send_command("bind ^q gs c toggle Melee Weapon set") -- CTRL+Q swap melee weapon combinations (defaults to Sacro Bulwark in offhand when mage mode)
send_command("bind ^e gs c toggle Range Weapon set") -- CTRL+E swap for Ullr use in melee/WS sets

send_command("bind !f8 gs c toggle DW set") -- Alt+F8 swap between DualWield and SingleWield for melee sets (can only be toggled if DW is available)
send_command("bind @f8 gs c toggle Melee Mode") -- WIN+F8 swap between mage and melee modes (Determines if weapons swap with casts)
send_command("bind !` gs c toggle Burst Mode") -- Alt+` switches Magic Burst sets on/off
send_command("bind @W gs c toggle Weapon Lock") -- WIN+W manually overrides and prevents swaps for main/sub/range/ammo slots
send_command("bind != gs c toggle Saboteur Mode") -- Alt+= toggles Saboteur Mode between NM and Regular mobs to determine duration potencies


--numpad controls for WS's
-- -- CTRL key for Sword WS
send_command('bind ^numpad0 @input /ws "Savage Blade" <t>')
send_command('bind ^numpad1 @input /ws "Death Blossom" <t>')
send_command('bind ^numpad2 @input /ws "Requiescat" <t>')
send_command('bind ^numpad3 @input /ws "Chant du Cygne" <t>')
send_command('bind ^numpad4 @input /ws "Sanguine Blade" <t>')
send_command('bind ^numpad5 @input /ws "Seraph Blade" <t>')
send_command('bind ^numpad6 @input /ws "Knights of Round" <t>')
send_command('bind ^numpad7 @input /ws "Flat Blade" <t>')
send_command('bind ^numpad8 @input /ws "Shining Blade" <t>')
send_command('bind ^numpad9 @input /ws "Red Lotus Blade" <t>')
-- -- Alt key for Club / Dagger / Ranged WS
send_command('bind !numpad0 @input /ws "Black Halo" <t>')
send_command('bind !numpad1 @input /ws "Seraph Strike" <t>')
send_command('bind !numpad2 @input /ws "Shining Strike" <t>')
send_command('bind !numpad3 @input /ws "True Strike" <t>')
send_command('bind !numpad4 @input /ws "Evisceration" <t>')
send_command('bind !numpad5 @input /ws "Aeolian Edge" <t>')
send_command('bind !numpad6 @input /ws "Energy Drain" <t>')
send_command('bind !numpad7 @input /ws "Flaming Arrow" <t>')
send_command('bind !numpad8 @input /ws "Empyreal Arrow" <t>')
send_command('bind !numpad9 @input /ws "Moonlight" <t>')

	
function file_unload()
	--unbinds when job unloads--
	send_command("unbind F9")
	send_command("unbind !F9")
	
	send_command("unbind F10")
	send_command("unbind !F10")

	send_command("unbind F12")
	send_command("unbind !F12")	

	send_command("unbind ^q")
	send_command("unbind ^e")
	
	send_command("unbind !f8")
	send_command("unbind @f8")
	send_command("unbind !`")
	send_command("unbind @W")
	send_command("unbind !=")
	
	send_command('unbind ^numpad0')
	send_command('unbind ^numpad1')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad8')
	send_command('unbind ^numpad9')
	
	send_command('unbind !numpad0')
	send_command('unbind !numpad1')
	send_command('unbind !numpad2')
	send_command('unbind !numpad3')
	send_command('unbind !numpad4')
	send_command('unbind !numpad5')
	send_command('unbind !numpad6')
	send_command('unbind !numpad7')
	send_command('unbind !numpad8')
	send_command('unbind !numpad9')
end


function get_sets() 
	--Calls spell mapping (don't remove)
	maps()


	-- Set Macro Book/Set Here	
	set_macros(1,1)
	---Set Lockstyle Here
	set_style(1)	
	
	
	--Gear Sets Start Here
	--Augmented Gear
	Grio = {}
	Grio.Skill = { name="Grioavolr", augments={'Enfb.mag. skill +16','STR+8','Mag. Acc.+25','"Mag.Atk.Bns."+5','Magic Damage +2',}}

	Colada = {}
	Colada.Enh = { name="Colada", augments={'Enh. Mag. eff. dur. +4','"Mag.Atk.Bns."+10','DMG:+5',}}
	
	Sucellos = {}
	Sucellos.TP = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
	
	Sucellos.Enfeeb = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10',}}
	Sucellos.Nuke = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
	Sucellos.WSD = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}} --needs Accuracy from Dyes
	Sucellos.FC = { name="Sucellos's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	Sucellos.DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Mag. Acc.+10','"Dual Wield"+10','Damage taken-5%',}}
	
	Ghostfyre = {name="Ghostfyre Cape", augments={'Enfb.mag. skill +1','Enha.mag. skill +10','Mag. Acc.+10','Enh. Mag. eff. dur. +14',}} 

	TaeonHead ={}
	TaeonHead.Phalanx = { name="Taeon Chapeau", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	
	TaeonBody = {}
	TaeonBody.Phalanx = { name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	
	TaeonHands = {}
	TaeonHands.Phalanx = { name="Taeon Gloves", augments={'"Conserve MP"+5','Phalanx +3',}}
	
	TaeonLegs = {}
	TaeonLegs.Phalanx = { name="Taeon Tights", augments={'"Conserve MP"+5','Phalanx +3',}}
	
	TaeonFeet = {}
	TaeonFeet.Phalanx = { name="Taeon Boots", augments={'"Conserve MP"+5','Phalanx +3',}}
	
	TelchineHead = {}
	TelchineHead.Enh = {name="Telchine Cap", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	
	TelchineBody = {}
	TelchineBody.Enh = { name="Telchine Chas.", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	
	TelchineHands = {}
	TelchineHands.Enh = { name="Telchine Gloves", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	
	TelchineLegs = {}
	TelchineLegs.Enh = { name="Telchine Braconi", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	
	TelchineFeet = {}
	TelchineFeet.Enh = { name="Telchine Pigaches", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	
	MerlinicHead = {}
	
	MerlinicBody = {}
	
	MerlinicHands = {}
	
	MerlinicLegs = {}

	MerlinicFeet = {}
	
	sets.Kite = { legs = "Carmine Cuisses +1"}

	--SubJob list--
	--Do not change these
	sets.SJ = {}
	sets.SJ.index = {"Other", "Ninja", "Dancer"}
	SJ_ind = 1	


	--Weapon Sets--
	sets.Weapon_melee = {} -- sets weapon combo for melee-mode
	sets.Weapon_melee.index = {"Naegling", "LightDamage", "Enspell", "Murgleis", "Maxentius", "Tauret", "lolRange", "Endagger", "None"}
	Wm_ind = 1
	sets.Weapon_melee.Naegling = {
		main = "Naegling",
		sub = "Thibron",
		ammo = "Coiste Bodhar"
	}
	sets.Weapon_melee.LightDamage = {
		main= "Maxentius",
		sub = "Daybreak",
		ammo = "Coiste Bodhar"
	}
	sets.Weapon_melee.Enspell = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub = "Gleti's Knife",
		range = "Ullr"
	}
	sets.Weapon_melee.Murgleis = {
		main ={ name="Murgleis", augments={'Path: A',}},
		sub = "Gleti's Knife",
		ammo = "Coiste Bodhar"
	}
	sets.Weapon_melee.Maxentius = {
		main="Maxentius",
		sub = "Thibron",
		ammo = "Coiste Bodhar"
	}	
	sets.Weapon_melee.Tauret = {
		--main = "Tauret",
		--sub = "Gleti's Knife",
		main = "Malevolence",
		sub = "Bunzi's Rod",
		ammo = "Coiste Bodhar"
	}
	--Next two intended for use with Ullr toggle active
	sets.Weapon_melee.lolRange = {
		-- main = "Vitiation Sword",
		-- sub = "Bunzi's Rod"
	}
	sets.Weapon_melee.Endagger = {
		main = "Trainee Knife",
		sub = "Twinned Blade"
	}

	sets.Weapon_melee.None = {
	}	

	-- sets weapon combo for ranged use
	-- for SC compatibility, Enspell MAcc, and niche Flaming Arrow shenanigans
	sets.Weapon_range = {} 
	sets.Weapon_range.index = {"none", "Ullr"} 
	Wr_ind = 1
	sets.Weapon_range.Ullr = {
		range = "Ullr",
		ammo = "Beryllium Arrow"
	}
	sets.Weapon_range.none = {}


	sets.DW_mode = {}
	sets.DW_mode.index = {"DW", "notDW"}
	DW_mode_ind = 1

	sets.DW_mode.DW = {}
	sets.DW_mode.notDW = {sub = "Sacro Bulwark"} -- 0/0/10


	--Idle Sets--
	-- mage-mode
	sets.Idle = {}
	sets.Idle.index = {"Standard", "DT", "Refresh"}
	Idle_ind = 1
	sets.Idle.Standard = {
		main="Daybreak",
	    sub="Sacro Bulwark",
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Dim. Ring (Mea)",
	    right_ring="Warp Ring",
		back = Sucellos.FC,
	} 
	sets.Idle.DT = {
		main="Daybreak",
	    sub="Sacro Bulwark",
	    ammo="Staunch Tathlum",
	    head="Bunzi's Hat",
	    body="Bunzi's Robe",
	    hands="Bunzi's Gloves",
	    legs="Bunzi's Pants",
	    feet="Bunzi's Sabots",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Ayanmo Ring",
	    right_ring="Gelatinous Ring +1",
		back ="Solemnity Cape",
	} 
	sets.Idle.Refresh = {
	    main="Daybreak",
	    sub="Sacro Bulwark",
	    ammo="Homiliary",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
		back = Sucellos.FC,
	} 
	
	-- melee-mode (DW)
	sets.Idle_melee_DW = {}
	sets.Idle_melee_DW.index = {"Standard", "DT", "Refresh"}
	Idle_melee_DW_ind = 1
	sets.Idle_melee_DW.Standard = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Dim. Ring (Mea)",
	    right_ring="Warp Ring",
		back = Sucellos.FC,
	} 
	sets.Idle_melee_DW.DT = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Vocane Ring",
	    right_ring="Defending Ring",
		back = Sucellos.FC,
	} 
	sets.Idle_melee_DW.Refresh = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
		back = Sucellos.FC,
	} 
	
	-- melee-mode (Single-Wield)
	sets.Idle_melee_SW = {}
	sets.Idle_melee_SW.index = {"Standard", "DT", "Refresh"}
	Idle_melee_SW_ind = 1
	sets.Idle_melee_SW.Standard = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Dim. Ring (Mea)",
	    right_ring="Warp Ring",
		back = Sucellos.FC,
	} 
	sets.Idle_melee_SW.DT = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Vocane Ring",
	    right_ring="Defending Ring",
		back = Sucellos.FC,
	} 
	sets.Idle_melee_SW.Refresh = {
		ammo="Staunch Tathlum",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Carmine Cuisses +1",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
		back = Sucellos.FC, 
	} 


	--TP Sets--
	sets.TP = {}
	sets.TP.index = {"Standard", "DT", "Enspells_high_damage"}
	TP_ind = 1

	sets.TP.Standard = {}
	sets.TP.Standard.index = {"Other", "Ninja", "Dancer"}
	sets.TP.Standard.Other = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Windbuffet Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.TP, 
	} 
	sets.TP.Standard.Ninja = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Windbuffet Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.DW, 
	} 
	sets.TP.Standard.Dancer = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Reiki Yotai",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.DW, 
	} 

	sets.TP.DT = {}
	sets.TP.DT.index = {"Other", "Ninja", "Dancer"}
	sets.TP.DT.Other = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Windbuffet Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.TP, 
	} 
	sets.TP.DT.Ninja = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Windbuffet Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.DW, 
	} 
	sets.TP.DT.Dancer = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Bunzi's Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Reiki Yotai",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Hetairoi Ring",	
		back = Sucellos.DW, 
	} 

	-- Enspell-Focused sets
	sets.TP.Enspells_high_damage = {}
	sets.TP.Enspells_high_damage.index = {"Other", "Ninja", "Dancer"}
	sets.TP.Enspells_high_damage.Other = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Aya. Manopolas +2",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Anu Torque",
	    waist="Eschan Stone",
	    left_ear="Sherida Earring",
	    right_ear="Crep. Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
	    back=Ghostfyre,
	} 
	sets.TP.Enspells_high_damage.Ninja = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Aya. Manopolas +2",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Eschan Stone",
	    left_ear="Sherida Earring",
	    right_ear="Crep. Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
	    back=Ghostfyre,
	} 
	sets.TP.Enspells_high_damage.Dancer = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Aya. Manopolas +2",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Eschan Stone",
	    left_ear="Sherida Earring",
	    right_ear="Crep. Earring",
	    left_ring="Stikini Ring +1",
	    right_ring="Stikini Ring +1",
	    back=Ghostfyre,
	} 
	

	sets.Ranged = {}
	sets.Ranged.index = {"Standard", "HighAccuracy"}
	Ranged_ind = 1
	
	sets.Ranged.Standard = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Sanctity Necklace",
	    waist="Reiki Yotai",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Crepuscular Ring",
		back = Sucellos.TP,
	}
	sets.Ranged.HighAccuracy = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Sanctity Necklace",
	    waist="Reiki Yotai",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Crepuscular Ring",
		back = Sucellos.TP,
	}


	--Weaponskill Sets--
	--Sword
	sets.WS = {}
	sets.WS.index = {"Attack", "AttackCapped"}
	WS_ind = 1

	sets.Knights = {}
	sets.Knights.Attack = {
		ammo="Amar Cluster",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Caro Necklace",
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	sets.Knights.AttackCapped = {
		ammo="Amar Cluster",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}

	sets.SavageBlade = {}
	sets.SavageBlade.Attack = {
		ammo="Aurgelmir Orb",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Caro Necklace",
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	sets.SavageBlade.AttackCapped = {
		ammo="Aurgelmir Orb",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Caro Necklace",
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	
	sets.DeathBlossom = {}
	sets.DeathBlossom.Attack = {
		ammo= "Regal Gem",
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Caro Necklace",
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	sets.DeathBlossom.AttackCapped = {
		ammo= "Crepuscular Pebble",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	
	sets.CDC = {}
	sets.CDC.Attack = {
		ammo="Yetshila +1",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Mache Earring +1",
	    left_ring="Ilabrat Ring",
	    right_ring="Ramuh Ring +1",
        back=Sucellos.TP,
	}
	sets.CDC.AttackCapped = {
		ammo="Yetshila +1",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Mache Earring +1",
	    left_ring="Ilabrat Ring",
	    right_ring="Ramuh Ring +1",
        back=Sucellos.TP,
	}

	sets.Requiescat = {}
	sets.Requiescat.Attack = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
	    head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
	    feet="Bunzi's Sabots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Freke Ring",
        back=Sucellos.TP,
	}
	sets.Requiescat.AttackCapped = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Freke Ring",
        back=Sucellos.TP,
	}	
	
	sets.SanguineBlade = {}
	sets.SanguineBlade.Attack = {
		ammo="Pemphredo Tathlum",
	    head="Pixie Hairpin +1",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.SanguineBlade.AttackCapped = {
		ammo="Pemphredo Tathlum",
	    head="Pixie Hairpin +1",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}

	sets.RedLotusBlade = {}
	sets.RedLotusBlade.Attack = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.RedLotusBlade.AttackCapped = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}	
	
	sets.BurningBlade = {}
	sets.BurningBlade.Attack = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.BurningBlade.AttackCapped = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}	
	
	sets.SeraphBlade = {}
	sets.SeraphBlade.Attack = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.SeraphBlade.AttackCapped = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}

	sets.ShiningBlade = {}
	sets.ShiningBlade.Attack = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.ShiningBlade.AttackCapped = {
		ammo="Pemphredo Tathlum",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Crematio Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}	

	--Dagger
	sets.Evisceration = {}
	sets.Evisceration.Attack = {
		ammo="Yetshila +1",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs={ name="Viti. Tights +3", augments={'Enspell Damage','Accuracy',}},
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Mache Earring +1",
	    left_ring="Ilabrat Ring",
	    right_ring="Ramuh Ring +1",
        back=Sucellos.TP,
	}
	sets.Evisceration.AttackCapped = {
		ammo="Yetshila +1",
	    head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Mache Earring +1",
	    left_ring="Ilabrat Ring",
	    right_ring="Ramuh Ring +1",
        back=Sucellos.TP,
	}
	
	sets.AeolianEdge = {}
	sets.AeolianEdge.Attack = {
		ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.AeolianEdge.AttackCapped = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}

	--Club
	sets.BlackHalo = {}
	sets.BlackHalo.Attack = {
		ammo="Regal Gem",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Sailfi Belt +1",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Regal Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Rufescent Ring",
		back = Sucellos.WSD, 
	}
	sets.BlackHalo.AttackCapped = {
		ammo= "Crepuscular Pebble",
	    head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Sailfi Belt +1",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Regal Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Rufescent Ring",	
		back = Sucellos.WSD, 
	}
	
	sets.TrueStrike = {}
	sets.TrueStrike.Attack = {
		ammo= "Amar Cluster",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Caro Necklace",
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}
	sets.TrueStrike.AttackCapped = {
		ammo= "Crepuscular Pebble",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Sailfi Belt +1",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}	
	
	sets.ShiningStrike = {}
	sets.ShiningStrike.Attack = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.ShiningStrike.AttackCapped = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Shiva Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}	
	
	sets.SeraphStrike = {}
	sets.SeraphStrike.Attack = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Weatherspoon Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.SeraphStrike.AttackCapped = {
		ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Crematio Earring",
        left_ring="Weatherspoon Ring +1",
        right_ring="Freke Ring",
        back=Sucellos.MAB,
	}		
	
	--Ranged
	sets.FlamingArrow = {}
	sets.FlamingArrow.Attack = {
		head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Telos Earring",
	    left_ring="Shukuyu Ring",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}
	sets.FlamingArrow.AttackCapped = {
		head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Telos Earring",
	    left_ring="Shukuyu Ring",
	    right_ring="Freke Ring",
        back=Sucellos.MAB,
	}	
	
	sets.EmpyrealArrow = {}
	sets.EmpyrealArrow.Attack = {
		head="Malignance Chapeau",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Crepuscular Ring",
        back=Sucellos.WSD,
	}
	sets.EmpyrealArrow.AttackCapped = {
		head="Nyame Helm",
	    body="Viti. Tabard +3",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Crepuscular Ring",
        back=Sucellos.WSD,
	}	

	
	--All Other
	sets.OtherWS = {}
	sets.OtherWS.Attack = {
		head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}
	sets.OtherWS.Accuracy = {
		head="Nyame Helm",
        body="Viti. Tabard +3",
        hands="Bunzi's Gloves",
        legs="Nyame Flanchard",
        feet="Bunzi's Sabots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}

	sets.RangedWS = {}
	sets.RangedWS.Attack = {
		head="Nyame Helm",
	    body="Nyame Mail",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}
	sets.RangedWS.Accuracy = {
		head="Nyame Helm",
	    body="Nyame Mail",
	    hands="Bunzi's Gloves",
	    legs="Nyame Flanchard",
	    feet="Bunzi's Sabots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Shukuyu Ring",
	    right_ring="Rufescent Ring",
		back = Sucellos.WSD,
	}


	--Job Ability Sets--
	sets.JA = {}
	sets.JA.Chainspell = {body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},}
	sets.JA.Convert = {main={ name="Murgleis", augments={'Path: A',}},}
	
	sets.Waltz ={
	-- Insert gear here as desired
	}
	
	sets.precast = {}
	-- you have +38% at job master, needing +42% in geaar to cap
	-- use the rest of your slots to minimize shifts in HP/MP between casts
	sets.precast.FastCast = {
		head="Atrophy Chapeau +1", --16
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}, --15
	    hands="Bunzi's Gloves", --
	    legs="Malignance Tights", --
	    feet="Bunzi's Sabots",
	    neck={ name="Loricate Torque +1", augments={'Path: A',}}, --
	    waist="Flume Belt +1", --
	    left_ear="Malignance Earring", --4
	    right_ear="Loquac. Earring", --2
	    left_ring="Lebeche Ring", -- 
	    right_ring="Weatherspoon Ring +1", --	
	    back = Sucellos.FC, --10
	} -- 47
	
	sets.precast.FastCast_impact = {
		head= "",
		body="Crepuscular Cloak", --
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
	    legs="Malignance Tights",
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Fast Cast"+7','CHR+3',}}, --12
	    neck={ name="Loricate Torque +1", augments={'Path: A',}}, --
	    waist="Witful Belt", --3
	    left_ear="Malignance Earring", --4
	    right_ear="Loquac. Earring", --2
	    left_ring="Kishar Ring", --4
	    right_ring="Weatherspoon Ring +1", --	 
	    back = Sucellos.FC, --10
	} -- 43
	
	--This is here if you need it for Utsusemi
	sets.precast.NinjutsuFastCast = set_combine(sets.precast.FastCast, {
		neck = "Magoraga Beads",
	})
	
	sets.midcast = {}
	-- FC here will lower recasts until cap, but its a good idea to put -DT% in midcasts
	sets.midcast.FastRecast = {
		head="Atrophy Chapeau +1", --16
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}, --15
	    hands="Bunzi's Gloves", --
	    legs="Malignance Tights", --
	    feet="Bunzi's Sabots",
	    neck={ name="Loricate Torque +1", augments={'Path: A',}}, --
	    waist="Flume Belt +1", --
	    left_ear="Malignance Earring", --4
	    right_ear="Loquac. Earring", --2
	    left_ring="Lebeche Ring", -- 
	    right_ring="Weatherspoon Ring +1", --	
	    back = Sucellos.FC, --10
	} -- 47


	--Weapon combos specific to mage-only mode
	sets.Weapon_magic = {}
	sets.Weapon_magic.Enhancing_skill_SW = {
		main = "Pukulatmuj +1",
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb"
	} -- +11 Skill | +10% Duration
	sets.Weapon_magic.Enhancing_skill_DW = {
		main = "Pukulatmuj +1",
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb"
	} -- + 21 Skill
	sets.Weapon_magic.Enhancing_duration_SW = {
		main = Colada.Enh,
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb"
	} -- +15% Duration
	sets.Weapon_magic.Enhancing_phalanx_SW = {
		main = "Sakpata's Sword",
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb"
	} -- +5 Phalanx | +10% Duration
	sets.Weapon_magic.Enhancing_phalanx_DW = {
		main = "Sakpata's Sword",
		sub = "Pukulatmuj +1",
		ammo = "Sapience Orb"
	} -- +5 Phalanx
	sets.Weapon_magic.Enhancing_regen_SW = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb"
	} -- +0% Regen | +10% Duration


	--Enhancing Magic
	--Note that any amounts noted are generalization before calculation.
	-- --For example, if the "total duration+" is noted for a set this is not the calculated duration.
	-- --Sets will be calculated for totals in the notes below based on proper weapon combos (assumes mage-mode)
	--
	--
	--Duration Formula:
	-- -- (Base Duration + (6s × RDM Group 2 Merit Point Level) + (3s × RDM Relic Hands Group 2 Merit Point Level Augment) 
	-- -- + RDM Job Points + Gear that list Seconds) × (Augments Composure Bonus) × (Duration listed on Gear + Naturalist's Roll) 
	-- -- × (Duration Augments on Gear) × (Rune Fencer Gifts) = Duration
	
	
	--Skill -> Duration+ -> CMP
	--Uncapped Skill Spells: Enspells | Gain-spells | Temper | Temper II
	sets.midcast.Enhancing_skill = {
		head="Befouled Crown", -- +16
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}, --+23 (15)
	    hands="Viti. Gloves +1", -- +24
	    legs="Atrophy Tights +1", -- +21
	    feet="Leth. Houseaux +1", -- +25 (30)
	    neck="Incanter's Torque", -- +10
	    waist="Olympus Sash", -- +5
	    left_ear="Mimir Earring", -- +10
	    right_ear="Andoaa Earring", -- +5
	    left_ring="Stikini Ring", -- +8
	    right_ring="Stikini Ring", -- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +163 skill | +60% Duration (** denotes augmented +% duration)
	
	--Skill -> Duration+ -> CMP
	--Uncapped Skill Spells (others): Enspells
	sets.midcast.Enhancing_skill_other = {
		head="Befouled Crown", -- +16
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}, --+23 (15)
	    hands="Viti. Gloves +1", -- +24
	    legs="Atrophy Tights +1", -- +21
	    feet="Leth. Houseaux +1", -- +25 (30)
	    neck="Incanter's Torque", -- +10
	    waist="Olympus Sash", -- +5
	    left_ear="Mimir Earring", -- +10
	    right_ear="Andoaa Earring", -- +5
	    left_ring="Stikini Ring", -- +8
	    right_ring="Stikini Ring", -- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +163 skill | +60% Duration (** denotes augmented +% duration) 
	
	-- Redundant set, left in for future gear considerations
	-- --Skill -> Duration+ -> CMP
	-- --Uncapped Skill Spells (others): Enspells
	-- sets.midcast.Enhancing_skill_other_composure = {
		-- head = "Lethargy Chappel +1", -- (35*)
		-- neck = "Incanter's Torque", -- +10
        -- body = "Lethargy Sayon +1", -- (35*)
		-- ear1 = "Mimir Earring", -- +10
		-- ear2 = "Andoaa Earring", -- +5
		-- hands = "Atrophy Gloves +1", -- (20)
		-- ring1 = "Stikini Ring +1", -- +5
		-- ring2 = "Stikini Ring +1", -- +5
        -- back = Ghostfyre, -- +7(20**)
		-- waist = "Olympus Sash", -- +5
		-- legs = "Leth. Fuseau +1", -- (35*)
		-- feet = "Lethargy Houseaux +1" -- +25 (30 + 35*)
	-- } -- +72 skill	| +105% Duration (* indicates set total - 4 pieces) (** denotes augmented +% duration)
	
	--Duration+ -> CMP
	--Skill-less spells: Haste / Protect / Shell / Storm
	sets.midcast.Enhancing_duration = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},-- (15)
	    hands="Atrophy Gloves +1",-- (20)
	    legs= "Telchine Braconi",-- (10**)
	    feet="Leth. Houseaux +1",-- +25 (30)
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25**)
	    waist="Embla Sash",-- (5)
	    left_ear="Mimir Earring",-- +10
	    right_ear="Andoaa Earring",-- +5
	    left_ring="Stikini Ring",-- +8
	    right_ring="Stikini Ring",-- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +64 skill	| +120% Duration (** denotes augmented +% duration)
	
	--Duration+ -> CMP
	--Skill-less spells: Haste / Protect / Shell / Storm
	sets.midcast.Enhancing_duration_other = {
		head="Leth. Chappel +1",-- (35*)
	    body="Lethargy Sayon +1",-- (35*)
	    hands="Atrophy Gloves +1",-- (20)
	    legs="Leth. Fuseau +1",-- (35*)
	    feet="Leth. Houseaux +1",-- +25 (30 + 35*)
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25**)
	    waist="Embla Sash",-- (5)
	    left_ear="Mimir Earring",-- +10
	    right_ear="Andoaa Earring",-- +5
	    left_ring="Stikini Ring",-- +8
	    right_ring="Stikini Ring",-- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +64  skill | +130% Duration (* indicates set total - 4 pieces)
	
	--Composure duration is self buff only for this spell, nothing else affects this due to being Dark Magic
	-- -- This only exists as future-proofing in the unlikely event SE changes Klimaform 
	sets.midcast.Enhancing_duration_other_klimaform = {
		--head = "Lethargy Chappel +1", -- (50*)
        --body = "Lethargy Sayon +1", -- (50*)
		--hands = "Lethargy Gantherots +1", -- (50*)
		--legs = "Lethargy Fuseau +1", -- (50*)
		--feet = "Lethargy Houseaux +1" -- (50*)
	} -- +50% Duration (* indicates set total - 5 pieces)
	
	--Phalanx+ -> 500 Skill -> Duration+ -> CMP
	--Spells: Phalanx
	sets.midcast.Enhancing_phalanx = {
		head=TaeonHead.Phalanx, -- +3
	    body=TaeonBody.Phalanx, -- +3
	    hands=TaeonHands.Phalanx, -- +3
	    legs=TaeonLegs.Phalanx, -- +3
	    feet=TaeonFeet.Phalanx, -- +3
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25**)
	    waist="Embla Sash",-- (5)
	    left_ear="Mimir Earring",-- +10
	    right_ear="Andoaa Earring",-- +5
	    left_ring="Stikini Ring",-- +8
	    right_ring="Stikini Ring",-- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +32 skill | +15 Phalanx | +45% Duration (** denotes augmented +% duration)
	
	--Hit 500 skill -> Duration+ -> CMP
	--Spells: Phalanx / Phalanx II
	sets.midcast.Enhancing_phalanx_other = {
		head="Leth. Chappel +1",-- (35*)
	    body="Lethargy Sayon +1",-- (35*)
	    hands="Atrophy Gloves +1",-- (20)
	    legs="Leth. Fuseau +1",-- (35*)
	    feet="Leth. Houseaux +1",-- +25 (30 + 35*)
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25**)
	    waist="Embla Sash",-- (5)
	    left_ear="Mimir Earring",-- +10
	    right_ear="Andoaa Earring",-- +5
	    left_ring="Stikini Ring",-- +8
	    right_ring="Stikini Ring",-- +8
	    back="Ghostfyre Cape", -- +8(15**)
	} -- +57 skill | +105% Duration (* indicates set total - 4 pieces) (** denotes augmented +% duration)
	
	--Hit 355 Skill -> Aquaveil+ -> Duration+ -> CMP
	--Spells: Aquaveil
	sets.midcast.Enhancing_aquaveil = {
		head="Amalric Coif",-- [+2]
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},-- (15)
	    hands="Regal Cuffs",-- [+2]
	    legs= "Telchine Braconi",
	    feet="Leth. Houseaux +1",-- +25 (30)
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25**)
	    waist="Emphatikos Rope",-- [+1]
	    left_ear="Mimir Earring",-- +10
	    right_ear="Andoaa Earring",-- +5
	    left_ring="Stikini Ring",-- +8
	    right_ring="Stikini Ring",-- +8
	    back=Ghostfyre, -- +8(15**)
	} -- +57 skill | +5 Aquaveil | +85% Duration (** denotes augmented +% duration)
	
	--Stoneskin+ -> Duration+ -> CMP
	--Spells: Stoneskin
	sets.midcast.Enhancing_stoneskin = {
		head="Malignance Chapeau",
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Bunzi's Gloves",
	    legs="Shedir Seraweels",
	    feet="Leth. Houseaux +1",
	    neck="Nodens Gorget",
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Earthcry Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back = Ghostfyre, 
	} 
	
	--Refresh+ -> Duration+ -> CMP
	--Spells: Refresh / Refresh II
	sets.midcast.Enhancing_refresh = {
		head="Amalric Coif",
	    body="Atrophy Tabard +3",
	    hands="Atrophy Gloves +1",
	    legs="Leth. Fuseau +1",
	    feet="Leth. Houseaux +1",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Gishdubar Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back=Ghostfyre,
    }
	
	--Refresh+ -> Duration+ -> CMP
	--Spells: Refresh / Refresh II
	sets.midcast.Enhancing_refresh_other = {
		head="Amalric Coif",
	    body="Atrophy Tabard +3",
	    hands="Atrophy Gloves +1",
	    legs="Leth. Fuseau +1",
	    feet="Leth. Houseaux +1",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back = Ghostfyre, 
	} 	

	--500 Skill -> Barspell+ -> Duration+ -> CMP
	--Spells: Barstone / Barwater / Baraero / Barfire / Barblizzard / Barthunder
	sets.midcast.Enhancing_barspell = {
		head="Atrophy Chapeau +1",
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Atrophy Gloves +1",
	    legs="Atrophy Tights +1",
	    feet="Leth. Houseaux +1",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back = Ghostfyre, 
	} 
	
	--500 Skill -> Barspell+ -> Duration+ -> CMP
	--Spells: Barstone / Barwater / Baraero / Barfire / Barblizzard / Barthunder
	--			Barstonra / Barwatera / Baraera / Barfira / Barblizzara / Barthundra
	sets.midcast.Enhancing_barspell_other = {
		head="Leth. Chappel +1",
	    body="Lethargy Sayon +1",
	    hands="Atrophy Gloves +1",
	    legs="Atrophy Tights +1",
	    feet="Leth. Houseaux +1",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back = "Ghostfyre Cape", 
	} 

	--Regen+ -> Duration+ -> CMP
	--Skill-less spells: Haste / Protect / Shell
	sets.midcast.Enhancing_regen = {
		head="Carmine Mask +1",
	    body="Telchine Chas.",
	    hands="Atrophy Gloves +1",
	    legs="Telchine Braconi",
	    feet="Leth. Houseaux +1",
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back = "Ghostfyre Cape", 
	} 	


	--Weapon combos specific to mage-only mode
	sets.Weapon_magic.Enfeebling_skill = {
		main = Grio.Skill, -- +16 
		sub = "Mephitis Grip", -- +5
		ammo = "Regal Gem" -- (10)
	} -- +21 Skill | +10% Effect
	sets.Weapon_magic.Enfeebling_accuracy = {
		main={ name="Murgleis", augments={'Path: A',}},
		sub = "Ammurapi Shield",
		range = "Ullr"
	} -- +118 MAcc
	sets.Weapon_magic.Enfeebling_dispelga = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		range = "Ullr"
	} -- +118 MAcc

	--Enfeebles
	--Note that any amounts noted are generalization before calculation.
	-- --For example, if the "total duration+" is noted for a set this is not the calculated duration.
	-- --Sets will be calculated for totals in the notes below based on proper weapon combos (assumes mage-mode)
	--
	--
	-- Potency Formula:
	-- -- floor(floor((Base Potency × Saboteur) + {dStat Modifier}) × (Enfeebling Magic Effect+ Gear))
	--
	-- Duration Formula:
	-- -- floor[((Base Duration × Saboteur) + (6s × RDM Group 2 Merit Point Level) + (3s × RDM Relic Head Group 2 Merit Point Level Augment) 
	-- -- + RDM Enfeebling Job Points + RDM Stymie Job Points + Gear that list Seconds) × (Augments Composure Bonus) × (Duration listed on Gear) 
	-- -- × (Duration Augments on Gear)] = Duration
	
	
	--Effect+ -> 625 Skill -> MND -> MAcc -> Duration+
	--Spells: Frazzle III | Poison II
	--Theoretical max of -274 MEva possible vs NMs if 625 skill can be reached along with all potency+/Saboteur+ gear
	--Current max skill possible with potency+ is 616 (potential -267 MEva)
	--Capping skill with current sets available provides a max of only 44% potency+ (potential -256 MEva)
	sets.midcast.Enfeebling_skill_frazzle3 = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- +26 (37)
	    body="Lethargy Sayon +1",-- (27){14}
	    hands="Leth. Gantherots +1",-- +19 (20)
	    legs="Psycloth Lappas",-- +18 (30)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Rumination Sash",-- +7 (3)
	    left_ear="Snotra Earring",
	    right_ear="Vor Earring",-- +10
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
	    back=Sucellos.Enfeeb, -- (30){10}	
	} -- +99 Skill (585) | +20% Duration | +41% Effect | +226 MAcc 
	--   (this set provides potential -256 MEva w/ Sab vs NMs [Bolster Languor w/ Idris is only -200])
	--   Poison II potency: 219/tick w/ Sab vs NMs
	
	--625 Skill -> Effect+ -> MND -> MAcc -> Duration+
	--Spells: Frazzle III | Poison II
	--Theoretical max of -274 MEva possible vs NMs if 625 skill can be reached along with all potency+/Saboteur+ gear
	--Current max skill possible with potency+ is 616 (potential -267 MEva)
	--Capping skill with current sets available provides a max of only 44% potency+ (potential -256 MEva)
	--This set lacks skill due to no weapon swaps on cast (meleemode)
	sets.midcast.Enfeebling_skill_frazzle3_melee = {
        head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- +26 (37)
	    body="Lethargy Sayon +1",-- (27){14}
	    hands="Leth. Gantherots +1",-- +19 (20)
	    legs="Psycloth Lappas",-- +18 (30)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Rumination Sash",-- +7 (3)
	    left_ear="Snotra Earring",
	    right_ear="Vor Earring",-- +10
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
	    back=Sucellos,Enfeeb, -- (30){10}		
	} -- +129 Skill (606) | +20% Duration | +27% Effect | +254 MAcc 
	--   (this set provides potential -198 MEva w/ Sab vs NMs [Bolster Languor w/ Idris is only -200])
	--   Poison II potency: 184/tick w/ Sab vs NMs	
	
	--MAcc -> Effect+ -> MND -> Duration+
	--Spells: Frazzle II
	sets.midcast.Enfeebling_skill_frazzle2 = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +3",-- +26 (37)
	    hands="Regal Cuffs",-- (45)[20]
	    legs="Jhakri Slops +2",-- +18 (50)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}	
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}},-- (15)[5]
	    left_ear="Malignance Earring",-- (15)
	    right_ear="Snotra Earring",-- (10)[10]
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
		back=Sucellos.Enfeeb, -- (30){10}
	} -- +91 Skill | +65% Duration | +27% Effect | +336 (+100 Spell Bonus) = +446 MAcc (Not including Sab bonus for ~+586 MAcc)
	--   (land this first, then overwrite with Frazzle III. this set provides -79 MEva w/ Sab vs NMs)
	
	--Effect+ -> 610 Skill -> MND -> MAcc -> Duration+
	--Spells: Distract III
	sets.midcast.Enfeebling_skill_distract3 = {
        head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- +26 (37)
	    body="Lethargy Sayon +1",-- (27){14}
	    hands="Leth. Gantherots +1",-- +19 (20)
	    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},-- +18 (30)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist="Rumination Sash",-- +7 (3)
	    left_ear="Snotra Earring",
	    right_ear="Vor Earring",-- +10
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
	    back=Sucellos.Enfeeb, -- (30){10}	
	} -- +94 Skill | +30% Duration | +41% Effect | +223 MAcc 
	--   (this set provides potential -264 Eva w/ Sab vs NMs [Bolster Torpor w/ Idris is only -200])
	
	--610 Skill -> Effect+ -> MND -> MAcc -> Duration+
	--Spells: Distract III
	--This set lacks skill due to no weapon swaps on cast (meleemode)
	sets.midcast.Enfeebling_skill_distract3_melee = {
        head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- +26 (37)
	    body="Lethargy Sayon +1",-- (27){14}
	    hands="Leth. Gantherots +1",-- +19 (20)
	    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},-- +18 (30)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist="Rumination Sash",-- +7 (3)
	    left_ear="Snotra Earring",
	    right_ear="Vor Earring",-- +10
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
	    back=Sucellos.Enfeeb, -- (30){10}
	} -- +129 Skill (615) | +20% Duration | +27% Effect | +254 MAcc  
	--   (this set provides potential -205 Eva w/ Sab vs NMs [Bolster Torpor w/ Idris is only -200])
	
	--Effect+ -> MND -> MAcc -> Duration+
	--Spells: Slow II | Paralyze II | Addle II
	sets.midcast.Enfeebling_MND = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- +26 (37)
	    body="Lethargy Sayon +1",-- (27){14}
	    hands="Regal Cuffs",-- (45)[20]
	    legs="Jhakri Slops +2",-- +18 (50)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}	
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}},-- (15)[5]
	    left_ear="Malignance Earring",-- (15)
	    right_ear="Snotra Earring",-- (10)[10]
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Kishar Ring", -- (5)[10]
		back=Sucellos.Enfeeb, -- (30){10}
	} -- +65 Skill | +65% Duration | +41% Effect
	
	--Effect+ -> Duration+
	--Spells: Dia III | Inundation (Due to being longest duration normal set)
	sets.midcast.Enfeebling_effect = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},-- (37)
	    body="Lethargy Sayon +1",-- (27)[10*]{14}
	    hands="Regal Cuffs",-- (45)[20]
	    legs="Leth. Fuseau +1",-- (22)[10*]
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}},-- (15)[5]
	    left_ear="Malignance Earring",
	    right_ear="Snotra Earring",-- (10)[10]
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Kishar Ring", -- (5)[10]
		back=Sucellos.Enfeeb, -- (30){10}
	} -- +75% Duration | +41% Effect
	
	--MAcc -> Duration+
	--Spells: Sleep | Sleep II | Sleepga | Bind | Break | Dispel | Dispelga
	--			Gravity | Gravity II | Blind* | Blind II* | Silence
	--			Burn | Choke | Shock | Drown | Rasp | Frost
	-- (*Technically dINT-Based, but landing is often more important than ~5-50 Acc Down lost)
	sets.midcast.Enfeebling_macc = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}}, -- +26 (37)
	    body="Atrophy Tabard +3", -- +21 (55)
	    --hands="Regal Cuffs",-- (45)[20]
	    hands="Regal Cuffs",
	    --hands={ name="Kaykaus Cuffs", augments={'MP+80','MND+12','Mag. Acc.+20',}},
	    legs="Jhakri Slops +2", -- (55)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},-- +16 (43){10}
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},-- (25)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}},-- (15)[5]
	    --right_ear="Snotra Earring",-- (10)[10]
	    --left_ear="Regal Earring",
	    right_ear="Regal Earring",
	    left_ear="Malignance Earring",
	    left_ring="Stikini Ring",-- +8 (11)
	    --right_ring="Kishar Ring", -- (5)[10]
	    right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back=Sucellos.Enfeeb, -- (30){10}
	} -- +91 Skill | +65% Duration | +27% Effect | +328 MAcc
	
	--MAcc -> CMP
	--Spells: Impact
	--Not Enfeebling Magic, but MAcc is paramount for the spell
	sets.midcast.Enfeebling_impact = {
		head="",
		body="Crepuscular Cloak", --(85)
	    hands="Regal Cuffs", -- (45)
	    legs="Jhakri Slops +2", -- (55)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}}, -- (43)
	    neck={ name="Dls. Torque +2", augments={'Path: A',}}, -- (30)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}}, -- (15)
	    left_ear="Malignance Earring", -- (10)
	    right_ear="Snotra Earring",-- (10)[10]
	    left_ring="Stikini Ring",-- +8 (11)
	    right_ring="Stikini Ring",-- +8 (11)
		back=Sucellos.Enfeeb, -- (30)
	} -- +345 MAcc
	
	--Stymie / Elemental Seal
	--Effect+ -> Lethargy Set Bonus / Duration+ -> Skill -> Mods
	--Best used with Composure bonuses for long, long enfeebs aside from just ensuring something lands.
	-- --Not optimal for potency, Frazzle III / Distract III will be excluded from this set
	-- --in the rules below to stop players from landing bad enfeebles.
	sets.midcast.Enfeebling_stymie = {
		head="Leth. Chappel +1", -- [35*]
	    body="Lethargy Sayon +1", -- [35*]{14}
	    hands="Regal Cuffs", -- [20]
	    legs="Leth. Fuseau +1", -- [35*]
	    feet="Leth. Houseaux +1", -- [35*]
	    neck={ name="Dls. Torque +2", augments={'Path: A',}}, -- (25)[25]{10}
	    waist={ name="Obstin. Sash", augments={'Path: A',}}, -- [5]
	    left_ear="Malignance Earring", -- (15)
	    right_ear="Snotra Earring", -- (10)[10]
	    left_ring="Stikini Ring", -- +8
	    right_ring="Kishar Ring", -- [10]
		back=Sucellos.Enfeeb, -- {10}
	} -- +8 Skill | +105% Duration | +31% Effect
	--   (as an example: this set puts the target(s) into a coma, providing a 6:23 sleep vs NMs, 7:09 sleep vs non-NMs)

	
	--White Magic
	--Cures
	sets.midcast.Cure = {
        main="Daybreak", --30/0
		sub="Sacro Bulwark",		
		ammo="Regal Gem",
		head="Vanya Hood", --10/0
	    body="Malignance Tabard",
	    hands="Kaykaus Cuffs", -- 11/0
	    legs="Atrophy Tights +1", --12/0
	    feet="Vanya Clogs", --10/0
	    neck="Incanter's Torque",
	    waist="Luminary Sash",
	    left_ear="Mendi. Earring", --5/0
	    right_ear="Roundel Earring", --5/0
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
		back=Sucellos.Enfeeb,
	} -- 53/0
	
	sets.midcast.Cure_melee = {
		head="Vanya Hood", --10/0
	    body="Malignance Tabard",
	    hands="Kaykaus Cuffs", -- 11/0
	    legs="Atrophy Tights +1", --12/0
	    feet="Vanya Clogs", --10/0
	    neck="Incanter's Torque",
	    waist="Luminary Sash",
	    left_ear="Mendi. Earring", --5/0
	    right_ear="Roundel Earring", --5/0
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
		back=Sucellos.Enfeeb,
	} -- 53/0
	
	--Cursna+ -> Healing Skill -> Haste -> FastCast
	sets.midcast.Cursna = {
		head="Atrophy Chapeau +1",
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
	    feet="Vanya Clogs",
	    neck="Incanter's Torque",
	    waist="Embla Sash",
	    left_ear="Malignance Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Haoma's Ring",
	    right_ring="Haoma's Ring",
		back=Sucellos.Enfeeb,
	}

	--Banish Effect+
	sets.midcast.Banish_effect = {}


	--Black Magic
	--Elemental
	sets.Weapon_magic.Elemental_mab = {
		main = "Bunzi's Rod", -- 10 (40/40)
		sub = "Ammurapi Shield", -- (38/38)
		ammo = "Pemphredo Tathlum" -- (8/4)
	} -- +10 MBB | +78 MAcc / +72 MAB
	
	sets.midcast.Elemental_mab = {
		head="Jhakri Coronal +2", -- (50/38)
	    body="Jhakri Robe +2", -- (45/45)
	    hands="Amalric Gages", -- (20/53)
	    legs="Jhakri Slops +2", -- (20/60)
	    feet="Jhakri Pigaches +2", -- (20/52)
	    neck="Deviant Necklace", -- (10/10)
	    waist="Eschan Stone", -- (7/7)
	    left_ear="Malignance Earring", -- (10/8) 
	    right_ear="Regal Earring", -- (0/7)
	    left_ring="Freke Ring", -- (0/8)
	    right_ring="Shiva Ring +1", -- (0/3)
	    back=Sucellos.Nuke, -- (20/10)
	} -- +202 MAcc / +301 MAB
	
	sets.midcast.Elemental_burst = {
		head="Ea Hat +1", --7/7 (40/33)
	    body="Ea Houppe. +1", --9/9 (42/39)
	    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --0/6 (20/53)
	    legs="Ea Slops +1", -- 8/8 (41/36)
	    feet="Ea Pigaches +1", -- 5/5 (48/32)
	    neck="Mizu. Kubikazari", --10/0 (0/8)
	    waist="Eschan Stone", -- (7/7)
	    left_ear="Malignance Earring", -- (10/8)
	    right_ear="Regal Earring", -- (0/7)
	    left_ring="Freke Ring", -- (0/8)
	    right_ring="Mujin Band", --0/5
		back=Sucellos.Nuke, -- (20/10)
	} -- 46(overcap) MBB / 40 MBBII | +228 MAcc / +241 MAB
	
	sets.midcast.Elemental_burst_melee = {
        head="Ea Hat +1", --7/7 (40/33)
	    body="Ea Houppe. +1", --9/9 (42/39)
	    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --0/6 (20/53)
	    legs="Ea Slops +1", -- 8/8 (41/36)
	    feet="Ea Pigaches +1", -- 5/5 (48/32)
	    neck="Mizu. Kubikazari", --10/0 (0/8)
	    waist="Eschan Stone", -- (7/7)
	    left_ear="Malignance Earring", -- (10/8)
	    right_ear="Regal Earring", -- (0/7)
	    left_ring="Freke Ring", -- (0/8)
	    right_ring="Mujin Band", --0/5
		back=Sucellos.Nuke, -- (20/10)
	} -- 46(overcap) MBB / 40 MBBII | +228 MAcc / +241 MAB
	
	--Dark
	sets.Weapon_magic.Dark_drain = {
		main={ name="Murgleis", augments={'Path: A',}},
		sub = "Ammurapi Shield", -- (38/38)
		ammo = "Pemphredo Tathlum" -- (8/4)
	} --  | +108 MAcc	
	
	sets.midcast.Dark_drain = {
        head="Atrophy Chapeau +1",
	    body="Atrophy Tabard +3",
	    hands={ name="Kaykaus Cuffs", augments={'MP+80','MND+12','Mag. Acc.+20',}},
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Conserve MP"+3','Mag. Acc.+13',}},
	    feet="Malignance Boots",
	    neck="Erra Pendant",
	    waist="Fucho-no-Obi",
	    left_ear="Malignance Earring",
	    right_ear="Snotra Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
        back=Sucellos.Enfeeb,
	} 
	sets.midcast.Dark_aspir = sets.midcast.Dark_drain
	
	--Macc -> Skill
	sets.midcast.Dark_stun = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}}, -- +26 (37)
	    body="Atrophy Tabard +3", -- +21 (55)
	    hands="Regal Cuffs", -- (45)[20]
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Conserve MP"+3','Mag. Acc.+13',}}, -- +18 (55)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}}, -- +16 (43){10}
	    neck="Erra Pendant", -- +10 (17)
	    waist={ name="Obstin. Sash", augments={'Path: A',}}, -- (15)[5]
	    left_ear="Regal Earring", -- (15)
	    right_ear="Snotra Earring", -- (10)[10]
	    left_ring="Stikini Ring", -- +8 (11)
	    right_ring="Stikini Ring", -- +8 (11)
        back=Sucellos.Enfeeb, -- (30){10}
	} -- +20 Skill | +344 MAcc

	--Macc -> Skill
	--Only here if you wish to customize these spells
	sets.midcast.Dark_absorb = {
        head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}}, -- +26 (37)
	    body="Atrophy Tabard +3", -- +21 (55)
	    hands="Regal Cuffs", -- (45)[20]
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Conserve MP"+3','Mag. Acc.+13',}}, -- +18 (55)
	    feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}}, -- +16 (43){10}
	    neck="Erra Pendant", -- +10 (17)
	    waist={ name="Obstin. Sash", augments={'Path: A',}}, -- (15)[5]
	    left_ear="Regal Earring", -- (15)
	    right_ear="Snotra Earring", -- (10)[10]
	    left_ring="Stikini Ring", -- +8 (11)
	    right_ring="Stikini Ring", -- +8 (11)
        back=Sucellos.Enfeeb, -- (30){10}
	} -- +20 Skill | +344 MAcc

	sets.TH = {
		head = 'White Rarab cap +1',
		waist = 'Chaac Belt',
		ammo = 'Perfect Lucky Egg',
	}

	--Other special gear--
	sets.obi = {
		waist = "Hachirin-no-Obi"
	}
	
	sets.Doom = {
		neck = "Nicander's Necklace",
		ring1 = "Defending Ring",
		waist = "Gishdubar Sash"
	} -- Actually get the gear for this set. It isnt hard and it makes Doom trivial to remove.
	
	-- Set to be enabled when you are unable to act
	-- Sleep / Terror / Stun / Petrification
	-- You can dance if you want to.
	sets.SafetyDance = {
		ammo = "Staunch Tathlum", -- 0/0/3
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Malignance Tabard", -- 10/0/0
	    hands="Bunzi's Gloves", -- 0/0/7
	    legs="Nyame Flanchard", -- 0/0/8
	    feet="Bunzi's Sabots", -- 0/0/7	
	    neck="Sanctity Necklace",
	    waist="Flume Belt +1",
	    left_ear="Genmei Earring",
	    right_ear="Etiolation Earring", -- 0/3/0
	    left_ring="Vocane Ring",
	    right_ring="Defending Ring", -- 0/0/10
		back = Sucellos.FC, -- 10/0/0	
	} 
	
	sets.Enmity = {
		ammo = "Sapience Orb", 
		head="Halitus Helm",
	    body="Emet Harness +1",
	    hands="Bunzi's Gloves",
	    legs="Zoar Subligar +1",
	    feet="Bunzi's Sabots",
	    neck={ name="Loricate Torque +1", augments={'Path: A',}},
	    waist="Trance Belt",
	    left_ear="Cryptic Earring",
	    right_ear="Trux Earring",
	    left_ring="Begrudging Ring",
	    right_ring="Supershear Ring",
		back = Sucellos.FC, 
	}
	
	sets.Swipe = {
        head="Ea Hat +1",
	    body="Ea Houppe. +1",
	    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
	    legs="Ea Slops +1",
	    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
	    neck={ name="Dls. Torque +2", augments={'Path: A',}},
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Freke Ring",
	    right_ring="Stikini Ring +1",
        back=Sucellos.Nuke, 
	} 
	
	sets.Swipe_MB = {
        head="Ea Hat +1", --7/7 (40/33)
	    body="Ea Houppe. +1", --9/9 (42/39)
	    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}, --0/6 (20/53)
	    legs="Ea Slops +1", -- 8/8 (41/36)
	    feet="Ea Pigaches +1", -- 5/5 (48/32)
	    neck="Mizu. Kubikazari", --10/0 (0/8)
	    waist="Eschan Stone", -- (7/7)
	    left_ear="Malignance Earring", -- (10/8)
	    right_ear="Regal Earring", -- (0/7)
	    left_ring="Freke Ring", -- (0/8)
	    right_ring="Mujin Band", --0/5
		back=Sucellos.Nuke, -- (20/10)
	} 

	--Precast Sets--
	--Expand on these sets as your needs require
	--Assumes no Flurry and 5/5 SS merits, +60 needed to cap
	sets.snapshot = {}
	--Assumes Flurry1 and 5/5 SS merits, +45 needed to cap
	sets.snapshotF1 = {} 
	--Assumes Flurry2 and 5/5 SS merits, +30 needed to cap
	sets.snapshotF2 = {} 

	
	--Determines SJ on load for later use, DO NOT REMOVE--
	determine_sub()	
	prep_startup()
end


------------------------------------------------------------------------------
------------------------------------------------------------------------------
--Do Not Adjust Anything Below This Point Unless You Know What You Are Doing--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
function maps()
	--Mapping--
    Effect_enfeebles = S{
		'Inundation'}
	
	Skill_enfeebles = S{
		'Dia', 'Dia II', 'Dia III', 'Diaga', 'Frazzle III', 'Distract III'}
	
	MAcc_enfeebles = S{
		'Sleep', 'Sleep II', 'Sleepga', 'Silence', 'Dispel', 'Dispelga', 'Bind', 'Break', 'Gravity', 'Gravity II',
		'Blind', 'Blind II', 'Burn', 'Choke', 'Shock', 'Drown', 'Rasp', 'Frost', 'Repose'}
		
	MND_enfeebles = S{'Slow', 'Slow II', 'Paralyze', 'Paralyze II', 'Addle', 'Addle II'}
		
	Cure_spells = S{
		'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Curaga', 'Curaga II', 'Cura',
		'Healing Breeze', 'Wild Carrot'}
	
    Skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II', 'Gain-STR', 'Gain-DEX', 
		'Gain-VIT', 'Gain-AGI', 'Gain-INT', 'Gain-MND', 'Gain-CHR'}
		
	Duration_spells = S{
		'Haste', 'Haste II', 'Klimaform', 'Flurry', 'Flurry II',
		'Aurorastorm', 'Voidstorm', 'Sandstorm', 'Rainstorm', 'Windstorm', 'Firestorm', 'Hailstorm', 'Thunderstorm',
		'Protect', 'Protect II', 'Protect III', 'Protect IV', 'Protect V', 'Protectra', 'Protectra II', 'Protectra III', 
		'Shell', 'Shell II', 'Shell III', 'Shell IV', 'Shell V', 'Shellra', 'Shellra II'}
	
	Barspells = S{
		'Barthunder', 'Barblizzard', 'Barfire', 'Baraero', 'Barwater', 'Barstone', 
		'Barthundra', 'Barblizzara', 'Barfira', 'Baraera', 'Barwatera', 'Barstonra', }
	
	Absorb_spells = S{
		'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-ACC'}
		
	Nuke_spells = S{
		'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V', 'Stonega', 'Stonega II', 
		'Water', 'Water II', 'Water III', 'Water IV', 'Water V', 'Waterga', 'Waterga II', 
		'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V', 'Aeroga', 'Aeroga II',
		'Fire', 'Fire II', 'Fire III', 'Fire IV', 'Fire V', 'Firaga', 
		'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzaga', 
		'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thundaga'}
		
	Elemental_WS = S{
		'Sanguine Blade', 'Seraph Blade', 'Shining Blade', 'Red Lotus Blade', 'Burning Blade', 
		'Seraph Strike', 'Shining Strike', 'Flaming Arrow', 'Aeolian Edge'}
		
	LethargySet = S{
		'Lethargy Chappel', 'Leth. Chappel +1', 'Lethargy Sayon', 'Lethargy Sayon +1', 'Lethargy Gantherots', 'Lethargy Gantherots +1', 
		'Lethargy Fuseau', 'Leth. Fuseau +1', 'Lethargy Houseaux', 'Leth. Houseaux +1'}	
		
	Unusable_buff = {
		spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
		ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}	

	Enmity_actions = S{'Sentinel', 'Shield Bash', 'Souleater', 'Weapon Bash', 'Vallation', 'Swordplay', 'Pflug', 'Provoke'}

	--Master Base Enfeebling Duration Table (seconds)
	duration30 = S{
		'Break', 'Bind'} --No conclusive data found on min Bind duration
	duration60 = S{
		'Sleep', 'Sleepga', 'Gravity II', 'Dia'} --No conclusive data found on min Gravity II duration
	duration90 = S{
		'Sleep II'}
	duration120 = S{
		'Paralyze', 'Paralyze II', 'Silence', 'Gravity', 'Poison', 'Poison II', 'Dia II'}
	duration180 = S{
		'Slow', 'Slow II', 'Blind', 'Blind II', 'Dia III'}
	duration300 = S{
		'Frazzle', 'Frazzle II', 'Frazzle III', 'Distract', 'Distract II', 'Distract III', 'Inundation'}
	------------------------------------------------------------------------------		
end

--Variables
--
-- Sets the default mode for weapons swaps
-- -- Melee(true): Disallows weapon swaps during casts
-- -- Mage(false): Allows weapon swaps during casts
Melee_mode = false


-- Sets the default mode for magic bursts
Burst_mode = false


-- Sets the default mode for weapon lock
Weapon_lock = false 


-- Sets default for Saboteur Mode between NM and regular mobs
Notorious_monster = false


-- Sets Merits/Job Gifts related to Enfeebling Duration for calculations later
-- -- Replace with the # of Merits you have in this cetegory (5 max)
EnfeeblingDurationMerits = 5
-- -- Replace with the # of Job Points you have in this cetegory (20 max)
EnfeeblingDurationGifts = 20
-- -- Replace with the # of Job Points you have in this cetegory (20 max)
StymieDurationGifts = 20 


--Additional related variables
Category2 = 6.00 * EnfeeblingDurationMerits
Category2Head = 3.00 * EnfeeblingDurationMerits
Composure = 1.00
Stymie = 0.00
base = 0.00
FlatGearBonus = 0.00
GearAugments = 1.00
MultiplicativeGearBonus = 1.00
DurationTotal = 0.00

-- Select default macro book on initial load or subjob change.
function set_macros(sheet,book)
    if book then
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
end

function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
end

function buff_change(n,gain,buff_table)
	local name
    name = string.lower(n)
	if name == "doom" then
		if gain then
			equip(sets.Doom)
			disable('neck','ring1','ring2','waist')
			send_command("@input /p Doomed.")
		else
			enable('neck','ring1','ring2','waist')
			determine_equip_set()
			send_command("@input /p Doom off.")
		end
	end
	--Ensures gear slots unlock if you die
	if name == "Weakness" and gain then
		enable('neck','ring1','ring2','waist')
	end
	if S{"terror", "petrification", "sleep", "stun"}:contains(name) then
        if gain then
            equip(sets.SafetyDance)
        else
			if not has_any_buff_of({"terror", "petrification", "sleep", "stun"}) then
				determine_equip_set()
			end
        end
	end
	if name == "charm" then
        if gain then
            send_command('@input /p Charmed!')
        else
            send_command('@input /p Charm off.')
        end	
	end
end

function prep_startup()
	--Streamlines Variables on load
	-- --Redundant, but I like this to be available to 'standardize'
	-- --startup from one location.
	Melee_mode = false
	Burst_mode = false
	Notorious_monster = false
	Weapon_lock = false
	DW_mode_ind = 2
	Kite_mode = true
	
	send_command('@input /echo RDM Loaded, Current Modes::: Melee_mode: OFF | Burst_mode: OFF | Saboteur Mode: Normal | Weapon Lock: OFF | DW_mode: SW')
end

function pretarget(spell)
	--Locks you in safety set when disabled
	if (spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu') then
		if has_any_buff_of({"terror", "petrification", "sleep", "stun", "silence", "mute"}) then
			cancel_spell()
		end
		if (spell.type == 'JobAbility' and has_any_buff_of({"terror", "petrification", "sleep", "stun", "amnesia"})) then
			cancel_spell()
		end
	end
end

-- Job Control Functions
function precast(spell)
	reset_enfeebling_variables()
	if spell.english == "Ranged" then
		if buffactive['Flurry II'] then
			equip(sets.snapshotF2)
		elseif buffactive['Flurry'] then
			equip(sets.snapshotF1)
		else
			equip(sets.snapshot)
		end
	elseif (spell.type == 'WhiteMagic' or spell.type == 'BlackMagic') then
		if spell.english == "Dispelga" then
			equip(set_combine(sets.Weapon_magic.Enfeebling_dispelga, sets.precast.FastCast))
		elseif spell.english == "Impact" then
			if Melee_mode == true then
				equip(sets.precast.FastCast_impact)
			else
				equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.precast.FastCast_impact))
			end
		else
			equip(sets.precast.FastCast)
		end
	elseif spell.type == 'Ninjutsu' then
		equip(sets.precast.NinjutsuFastCast)
	elseif spell.type == 'Waltz' then
		equip(sets.Waltz)
	elseif spell.type == "WeaponSkill" then
		if player.tp >= 1000 then
			--handles ranged WS's
			if spell.target.distance <= 21.5 then
				if spell.english == "Empyreal Arrow" then
					equip(sets.EmpyrealArrow[sets.WS.index[WS_ind]])
				end
				if spell.english == "Flaming Arrow" then
					equip(sets.FlamingArrow[sets.WS.index[WS_ind]])
					if world.day_element == "Fire" or world.weather_element == "Fire" then
						equip(sets.obi)
					end
				end
				--generic ranged WS
				if spell.english == "Sidewinder" or
						spell.english == "Dulling Arrow" or
						spell.english == "Piercing Arrow" then
					equip(sets.RangedWS[sets.WS.index[WS_ind]])
				end						
			else
				cancel_spell()
				send_command("@input /echo Canceled " .. spell.name .. " " .. spell.target.name .. " is Too Far")
			end
			--handles close-range WS's
			if spell.target.distance <= 5.5 then			
				if spell.english == "Knights of Round" then
					equip(sets.Knights[sets.WS.index[WS_ind]])
				end
				if spell.english == "Savage Blade" then
					equip(sets.SavageBlade[sets.WS.index[WS_ind]])
				end
				if spell.english == "Chant du Cygne" then
					equip(sets.CDC[sets.WS.index[WS_ind]])
				end
				if spell.english == "Requiescat" then
					equip(sets.Requiescat[sets.WS.index[WS_ind]])
				end
				if spell.english == "Death Blossom" then
					equip(sets.DeathBlossom[sets.WS.index[WS_ind]])
				end
				if spell.english == "Sanguine Blade" then
					equip(sets.SanguineBlade[sets.WS.index[WS_ind]])
					if world.day_element == "Dark" or world.weather_element == "Dark" then
						equip(sets.obi)
					end
				end
				if spell.english == "Seraph Blade" then
					equip(sets.SeraphBlade[sets.WS.index[WS_ind]])
					if world.day_element == "Light" or world.weather_element == "Light" then
						equip(sets.obi)
					end
				end
				if spell.english == "Shining Blade" then
					equip(sets.ShiningBlade[sets.WS.index[WS_ind]])
					if world.day_element == "Light" or world.weather_element == "Light" then
						equip(sets.obi)
					end
				end
				if spell.english == "Red Lotus Blade" then
					equip(sets.RedLotusBlade[sets.WS.index[WS_ind]])
					if world.day_element == "Fire" or world.weather_element == "Fire" then
						equip(sets.obi)
					end
				end
				if spell.english == "Burning Blade" then
					equip(sets.BurningBlade[sets.WS.index[WS_ind]])
					if world.day_element == "Fire" or world.weather_element == "Fire" then
						equip(sets.obi)
					end
				end
				if spell.english == "Black Halo" then
					equip(sets.BlackHalo[sets.WS.index[WS_ind]])
				end
				if spell.english == "Seraph Strike" then
					equip(sets.SeraphStrike[sets.WS.index[WS_ind]])
					if world.day_element == "Light" or world.weather_element == "Light" then
						equip(sets.obi)
					end
				end
				if spell.english == "Shining Strike" then
					equip(sets.SeraphStrike[sets.WS.index[WS_ind]])
					if world.day_element == "Light" or world.weather_element == "Light" then
						equip(sets.obi)
					end
				end
				if spell.english == "Evisceration" then
					equip(sets.Evisceration[sets.WS.index[WS_ind]])
				end
				if spell.english == "Aeolian Edge" then
					equip(sets.AeolianEdge)
					if world.day_element == "Wind" or world.weather_element == "Wind" then
						equip(sets.obi)
					end
				end
				if spell.english == "Evisceration" then
					equip(sets.Evisceration[sets.WS.index[WS_ind]])
				end
				if spell.english == "Fast Blade" or 
						spell.english == "Flat Blade" or 
						spell.english == "Circle Blade" or
						spell.english == "Vorpal Blade"
				then
					equip(sets.OtherWS[sets.WS.index[WS_ind]])
				elseif spell.type == "WeaponSkill" then
					equip(sets.OtherWS[sets.WS.index[WS_ind]])
				end
			else
				cancel_spell()
				send_command("@input /echo Canceled " .. spell.name .. " " .. spell.target.name .. " is Too Far")
			end
			
		end
	elseif (spell.english == "Convert" and Melee_mode == false) then
		equip(sets.JA.Convert)
	elseif spell.english == "Chainspell" then
		equip(sets.JA.Chainspell)
	elseif Enmity_actions:contains(spell.english) then  
		equip(sets.Enmity)
	elseif spell.english == "Swipe" then  
		if Burst_mode == true then
			equip(sets.Swipe_MB)
		else
			equip(sets.Swipe)
		end
	end
	
	--Hooks for JA/WS Obi swaps
	--This is redundant with the statments above, but covers a list 
	--that can be edited if user wants to remove some for any reason
	if (Elemental_WS:contains(spell.english) or spell.english == "Swipe")
		and 
		(spell.element == world.day_element or spell.element == world.weather_element)
	then
		equip(sets.Obi)
	end
end

function midcast(spell, buff, act)
	--Handles generic recasts as a fallback
	if (spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu' or spell.type == 'Trust') then
		equip(sets.midcast.FastRecast)
	end
	
	
	--Enfeebling Magic
	if (spell.english == "Frazzle III" or spell.english == "Poison II") then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_skill_frazzle3_melee)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_skill, sets.midcast.Enfeebling_skill_frazzle3))
		end
	end
	if spell.english == "Distract III" then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_skill_distract3_melee)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_skill, sets.midcast.Enfeebling_skill_distract3))
		end
	end
	if spell.english == "Frazzle II" then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_skill_frazzle2)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Enfeebling_skill_frazzle2))
		end
	end
	if MND_enfeebles:contains(spell.english) then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_MND)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Enfeebling_MND))
		end
	end
	if (Effect_enfeebles:contains(spell.english) or spell.english == "Inundation") then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_effect)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Enfeebling_effect))
		end
	end
	if spell.english == 'Impact' then
		if Melee_mode == true then
			equip(sets.midcast.Enfeebling_impact)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Enfeebling_impact))
		end
	end
	
	if MAcc_enfeebles:contains(spell.english) then
		if spell.english == "Dispelga" then
			equip(set_combine(sets.Weapon_magic.Enfeebling_dispelga, sets.midcast.Enfeebling_macc))
		elseif Melee_mode == true then
			equip(sets.midcast.Enfeebling_macc)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Enfeebling_macc))
		end
	end
	
	
	--Enhancing Magic
	if Skill_spells:contains(spell.english) 
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_skill)
		else
			if DW_mode_ind ~= 1 then
				equip(set_combine(sets.Weapon_magic.Enhancing_skill_SW, sets.midcast.Enhancing_skill))
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_skill_DW, sets.midcast.Enhancing_skill))
			end
		end
	end
	if Skill_spells:contains(spell.english) 
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'SELF')
		then
		
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_skill_other)
		else
			if DW_mode_ind ~= 1 then
				equip(set_combine(sets.Weapon_magic.Enhancing_skill_SW, sets.midcast.Enhancing_skill_other))
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_skill_DW, sets.midcast.Enhancing_skill_other))
			end
		end
	end
	
	if Duration_spells:contains(spell.english) 
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_duration)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_duration))
		end
	end
	if Duration_spells:contains(spell.english) 
		and	
			buffactive['Composure']
		and
			((buffactive['Accession'] or spell.target.type ~= 'SELF') or
			(buffactive['Manifestation'] and spell.english == "Klimaform"))
		then
			if Melee_mode == true then
				equip(sets.midcast.Enhancing_duration_other)
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_duration_other))
			end
		if spell.english == "Klimaform" then
			equip(sets.midcast.Enhancing_duration_other_klimaform)
		end
	end	

	if (spell.english == "Phalanx" or spell.english == "Phalanx II") 
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_phalanx)
		else
			if DW_mode_ind ~= 1 then
				equip(set_combine(sets.Weapon_magic.Enhancing_phalanx_SW, sets.midcast.Enhancing_phalanx))
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_phalanx_DW, sets.midcast.Enhancing_phalanx))
			end
		end
	end
	if (spell.english == "Phalanx" or spell.english == "Phalanx II")
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'SELF')
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_phalanx_other)
		else
			if DW_mode_ind ~= 1 then
				equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_phalanx_other))
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_duration_DW, sets.midcast.Enhancing_phalanx_other))
			end
		end
	end	
	
	if spell.english == "Aquaveil" 
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_aquaveil)
		else
			if DW_mode_ind ~= 1 then
				equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_aquaveil))
			else
				equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_aquaveil))
			end
		end
	end
	if spell.english == "Aquaveil"
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'SELF')
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_duration_other)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_duration_other))
		end
	end	
	
	if spell.english == "Stoneskin" 
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_stoneskin)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_stoneskin))
		end
	end
	if spell.english == "Stoneskin"
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'SELF')
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_duration_other)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_duration_other))
		end
	end
	
	if (spell.english == "Refresh" or spell.english == "Refresh II" or spell.english == "Refresh III")
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_refresh)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_refresh))
		end
	end
	if (spell.english == "Refresh" or spell.english == "Refresh II" or spell.english == "Refresh III")
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'SELF')
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_refresh_other)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_refresh_other))
		end
	end

	if Barspells:contains(spell.english)
		and 
			spell.target.type == 'SELF' or
			(spell.target.type ~= 'SELF' and buffactive['Composure'] == false)
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_barspell)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_barspell))
		end
	end
	if Barspells:contains(spell.english)
		and 
			buffactive['Composure']
		and
			(buffactive['Accession'] or spell.target.type ~= 'Self')
		then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_barspell_other)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_duration_SW, sets.midcast.Enhancing_barspell_other))
		end
	end

	if (spell.english == "Regen" or spell.english == "Regen II") then
		if Melee_mode == true then
			equip(sets.midcast.Enhancing_regen)
		else
			equip(set_combine(sets.Weapon_magic.Enhancing_regen_SW, sets.midcast.Enhancing_regen))
		end
	end


	--Cures / Cursna / Banish Effect
	if Cure_spells:contains(spell.english) then
		if Melee_mode == true then
			equip(sets.midcast.Cure_melee)
		else
			equip(sets.midcast.Cure)
		end
	end
	if spell.english == "Cursna" then
		equip(sets.midcast.Cursna)
	end
	if (spell.english == "Banish" or spell.english == "Banish II" or spell.english == "Banishga" or spell.english == "Banishga II") then
		equip(sets.midcast.Banish)
		if (spell.english == "Banish" or spell.english == "Banishga") then
			send_command('timers create "'.. spell.english .. ': ' .. spell.target.name .. '" 15 down')
		else
			send_command('timers create "'.. spell.english .. ': ' .. spell.target.name .. '" 30 down')
		end
	end
	if spell.english == "Flash" then
		equip(sets.Enmity)
	end
	

	
	--Nukes
	if Nuke_spells:contains(spell.english) then
		if Burst_mode == false then
			if Melee_mode == true then
				equip(sets.midcast.Elemental_mab)
			else
				equip(set_combine(sets.Weapon_magic.Elemental_mab, sets.midcast.Elemental_mab))
			end
		else
			if Melee_mode == true then
				equip(sets.midcast.Elemental_burst_melee)
			else
				equip(set_combine(sets.Weapon_magic.Elemental_mab, sets.midcast.Elemental_burst))
			end
		end
	end

	
	--Dark Magic
	if (spell.english == "Drain" or spell.english == "Aspir") then
		if Melee_mode == true then
			equip(sets.midcast.Dark_drain)
		else
			equip(set_combine(sets.Weapon_magic.Dark_drain, sets.midcast.Dark_drain))
		end
	end
	if spell.english == "Stun" then
		if Melee_mode == true then
			equip(sets.midcast.Dark_stun)
		else
			equip(set_combine(sets.Weapon_magic.Enfeebling_accuracy, sets.midcast.Dark_stun))
		end
	end
	if Absorb_spells:contains(spell.english) then
		if Melee_mode == true then
			equip(sets.midcast.Dark_absorb)
		else
			equip(set_combine(sets.Weapon_magic.Dark_drain, sets.midcast.Dark_absorb))
		end
	end
	
	
	--Spell Hooks for Obi
	if (Cure_spells:contains(spell.english) or 
		Nuke_spells:contains(spell.english) or 
		(spell.english == "Drain" or spell.english == "Aspir")) 
		and 
		(spell.element == world.day_element or spell.element == world.weather_element) 
	then
		equip(sets.Obi)
	end
	
	
	--Conditional Stymie / Elemental Seal override
	if (buffactive['Stymie'] or buffactive['Elemental Seal']) and (Skill_enfeebles:contains(spell.english) == false and buffactive['Composure']) then
		equip(set_combine(sets.Weapon_magic.Enfeebling_skill, sets.midcast.Enfeebling_stymie))
	end
	
	if spell.english == 'Dia' then
		equip(sets.TH)
	end
	if spell.english == 'Dia II' then
		equip(sets.TH)
	end
	if spell.english == 'Dia III' then
		equip(sets.TH)
	end
	if spell.english == 'Diaga' then
		equip(sets.TH)
	end
	
end

function world.execute(me)
	-- package goddrinksjava;

	-- /**
	 -- * The program GodDrinksJava implements an application that
	 -- * creates an empty simulated world with no meaning or purpose.
	 -- * 
	 -- * @author momocashew
	 -- * @lyrics hibiyasleep
	 -- */
	 
	-- // Switch on the power line
	-- // Remember to put on
	-- // PROTECTION
	-- public class GodDrinksJava {
		-- // Lay down your pieces
		-- // And let's begin
		-- // OBJECT CREATION
		-- public static void main(String[] args) {
			-- // Fill in my data
			-- // parameters
			-- // INITIALIZATION
			-- Thing me = new Lovable("Me", 0, true, -1, false);
			-- Thing you = new Lovable("You", 0, false, -1, false);
			
			-- // Set up our new world
			-- World world = new World(5);
			-- world.addThing(me);
			-- world.addThing(you);
			-- // And let's begin the
			-- // SIMULATION
			-- world.startSimulation();



			-- // If I'm a set of points
			-- if(me instanceof PointSet){
				-- // Then I will give you my
				-- // DIMENSION
				-- you.addAttribute(me.getDimensions().toAttribute());
			-- }

			-- // If I'm a circle
			-- if(me instanceof Circle){
				-- // Then I will give you my
				-- // CIRCUMFERENCE
				-- you.addAttribute(me.getCircumference().toAttribute());
			-- }

			-- // If I'm a sine wave
			-- if(me instanceof SineWave){
				-- // Then you can sit on all my
				-- // TANGENTS
				-- you.addAction("sit", me.getTangent(you.getXPosition()));
			-- }

			-- // If I approach infinity
			-- if(me instanceof Sequence){
				-- // Then you can be my
				-- // LIMITATIONS
				-- me.setLimit(you.toLimit());
			-- }



			-- // Switch my current
			-- // To AC, to DC
			-- me.toggleCurrent();

			-- // And then blind my vision
			-- me.canSee(false);
			-- // So dizzy, so dizzy
			-- me.addFeeling("dizzy");

			-- // Oh, we can travel
			-- world.timeTravelForTwo("AD", 617, me, you);
			-- // To A.D., to B.C.
			-- world.timeTravelForTwo("BC", 3691, me, you);

			-- // And we can unite
			-- world.unite(me, you);
			-- // So deeply, so deeply



			-- // If I can
			-- // If I can give you all the
			-- // SIMULATIONS
			-- if(me.getNumSimulationsAvailable() >=
				-- you.getNumSimulationsNeeded()){
				-- // Then I can
				-- // Then I can be your only
				-- // SATISFACTION
				-- you.setSatisfaction(me.toSatisfaction());
			-- }

			-- // If I can make you happy
			-- if(you.getFeelingIndex("happy") != -1){
				-- // I will run the
				-- // EXECUTION
				-- me.requestExecution(world);
			-- }

			-- // Though we are trapped
			-- // In this strange, strange
			-- // SIMULATION
			-- world.lockThing(me);
			-- world.lockThing(you);



			-- // If I'm an eggplant
			-- if(me instanceof Eggplant){
				-- // Then I will give you my
				-- // NUTRIENTS
				-- you.addAttribute(me.getNutrients().toAttribute());
				-- me.resetNutrients();
			-- }
			-- // If I'm a tomato
			-- if(me instanceof Tomato){
				-- // Then I will give you
				-- // ANTIOXIDANTS
				-- you.addAttribute(me.getAntioxidants().toAttribute());
				-- me.resetAntioxidants();
			-- }
			-- // If I'm a tabby cat
			-- if(me instanceof TabbyCat){
				-- // Then I will purr for your
				-- // ENJOYMENT
				-- me.purr();
			-- }

			-- // If I'm the only god
			-- if(world.getGod().equals(me)){
				-- // Then you're the proof of my
				-- // EXISTENCE
				-- me.setProof(you.toProof());
			-- }



			-- // Switch my gender
			-- // To F, to M
			-- me.toggleGender();
			-- // And then do whatever
			-- // From AM to PM
			-- world.procreate(me, you);
			-- // Oh, switch my role
			-- // To S, to M
			-- me.toggleRoleBDSM();
			-- // So we can enter
			-- // The trance, the trance 
			-- world.makeHigh(me);
			-- world.makeHigh(you);



			-- // If I can
			-- // If I can feel your
			-- // VIBRATIONS
			-- if(me.getSenseIndex("vibration") != -1){
				-- // Then I can
				-- // Then I can finally be
				-- // COMPLETION
				-- me.addFeeling("complete");
			-- }
			-- // Though you have left
			-- world.unlock(you);
			-- world.removeThing(you);
			-- // You have left
			-- me.lookFor(you, world);
			-- // You have left
			-- me.lookFor(you, world);
			-- // You have left
			-- me.lookFor(you, world);
			-- // You have left
			-- me.lookFor(you, world);
			-- // You have left me in
			-- me.lookFor(you, world);
			-- // ISOLATION

			-- // If I can
			-- // If I can erase all the pointless
			-- // FRAGMENTS
			-- if(me.getMemory().isErasable()){
				-- // Then maybe
				-- // Then maybe you won't leave me so
				-- // DISHEARTENED
				-- me.removeFeeling("disheartened");
			-- }

			-- // Challenging your god
			-- try{
				-- me.setOpinion(me.getOpinionIndex("you are here"), false);
			-- }
			-- // You have made some
			-- catch(IllegalArgumentException e){
				-- // ILLEGAL ARGUMENTS
				-- world.announce("God is always true.");
			-- }



			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EXECUTION
			-- world.runExecution();
			-- // EIN
			-- world.announce("1", "de"); // ein; German
			-- // DOS
			-- world.announce("2", "es"); // dos; Español
			-- // TROIS
			-- world.announce("3", "fr"); // trois; French
			-- // NE
			-- world.announce("4", "kr"); // 넷; Korean
			-- // FEM
			-- world.announce("5", "se"); // fem; Swedish
			-- // LIU
			-- world.announce("6", "cn"); // 六; Chinese
			-- // EXECUTION
			-- world.runExecution();



			-- // If I can
			-- // If I can give them all the
			-- // EXECUTION
			-- if(world.isExecutableBy(me)){
				-- // Then I can
				-- // Then I can be your only
				-- // EXECUTION
				-- you.setExecution(me.toExecution());
			-- }

			-- // If I can have you back
			-- if(world.getThingIndex(you) != -1){
				-- // I will run the
				-- // EXECUTION
				-- world.runExecution();
			-- }

			-- // Though we are trapped
			-- // We are trapped, ah
			-- me.escape(world);



			-- // I've studied
			-- // I've studied how to properly
			-- // LO-O-OVE
			-- me.learnTopic("love");
			-- // Question me
			-- // Question me, I can answer all
			-- // LO-O-OVE
			-- me.takeExamTopic("love");
			-- // I know the
			-- // algebraic expression of
			-- // LO-O-OVE
			-- me.getAlgebraicExpression("love");
			-- // Though you are free
			-- // I am trapped, trapped in
			-- // LO-O-OVE
			-- me.escape("love");



			-- // EXECUTION
			-- world.execute(me);

		-- }

	-- }
end

function aftercast(spell)
	if spell.skill == "Enfeebling Magic" and (spell.english ~= "Dispel" and spell.english ~= "Dispelga") then
		if not spell.interrupted then
			set_enfeebling_duration_timer(spell)
		end
	end
	determine_equip_set()
end

function status_change(new, old)
	if new ~= 'Engaged' then
		if Melee_mode == true then
			if (SJ_ind == 2 or SJ_ind == 3) then
				melee_mode_idle_DW_set()
			else
				melee_mode_idle_SW_set()
			end
		else
			if (SJ_ind == 2 or SJ_ind == 3) then
				mage_mode_idle_DW_set()
			else
				mage_mode_idle_SW_set()
			end
		end
	else
		if Melee_mode == true then
			melee_mode_engaged_set()
		else
			mage_mode_engaged_set()
		end
	end
end

function determine_sub()
	if player.sub_job == 'NIN' then 
		SJ_ind = 2 --DW25
		DW_mode_ind = 1
		send_command("@input /echo SJ is Ninja")
	elseif player.sub_job == 'DNC' then
		SJ_ind = 3 --DW15
		DW_mode_ind = 1
		send_command("@input /echo SJ is Dancer")
	else
		SJ_ind = 1 --No DW
		DW_mode_ind = 2
		send_command("unbind !f8")
		send_command("@input /echo SJ is non-DW")
	end
	determine_equip_set()
end

function determine_equip_set()
	if player.status ~= 'Engaged' then
		if (SJ_ind == 2 or SJ_ind == 3) then -- handles nin and dnc SJ swaps
			if Melee_mode == true then -- melee mode
				melee_mode_idle_DW_set()
			else -- mage mode
				mage_mode_idle_DW_set()
			end
		else -- handles other SJ swaps
			if Melee_mode == true then -- melee mode SW idle
				melee_mode_idle_SW_set()
			else -- mage mode SW idle
				mage_mode_idle_SW_set()
			end
		end
	else 
		if Melee_mode == true then -- melee mode engaged
			melee_mode_engaged_set()
		else -- mage mode engaged
			mage_mode_engaged_set()
		end
	end
end

function melee_mode_idle_DW_set()
	equip(
		set_combine(
			sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]],
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],
			sets.Idle_melee_DW[sets.Idle_melee_DW.index[Idle_melee_DW_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function melee_mode_idle_SW_set()
	equip(
		set_combine(
			sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]],
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],
			sets.Idle_melee_SW[sets.Idle_melee_SW.index[Idle_melee_SW_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function mage_mode_idle_DW_set()
	equip(
		set_combine(
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],			
			sets.Idle[sets.Idle.index[Idle_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function mage_mode_idle_SW_set()
	equip(
		set_combine(
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],
			sets.Idle[sets.Idle.index[Idle_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function melee_mode_engaged_set()
	equip(	
		set_combine(
			sets.TP[sets.TP.index[TP_ind]][sets.SJ.index[SJ_ind]],
			sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]],
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function mage_mode_engaged_set()
	equip(	
		set_combine(
			sets.TP[sets.TP.index[TP_ind]][sets.SJ.index[SJ_ind]],
			sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]],
			sets.Weapon_range[sets.Weapon_range.index[Wr_ind]],
			sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
		)
	)
end

function self_command(command)
	if command == "toggle TP set" then
		TP_ind = TP_ind + 1
		if TP_ind > #sets.TP.index then
			TP_ind = 1
		end
		send_command("@input /echo <----- TP Set changed to " .. sets.TP.index[TP_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle TP set reverse" then
		TP_ind = TP_ind - 1
		if TP_ind < 1 then
			TP_ind = #sets.TP.index
		end
		send_command("@input /echo <----- TP Set changed to " .. sets.TP.index[TP_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle Range set" then
		Ranged_ind = Ranged_ind + 1
		if Ranged_ind > #sets.Ranged.index then
			Ranged_ind = 1
		end
		send_command("@input /echo <----- Ranged Set changed to " .. sets.Ranged.index[Ranged_ind] .. " ----->")		
		if player.status ~= 'Engaged' then
			if Melee_mode == true then
				if (SJ_ind == 2 or SJ_ind == 3) then
					melee_mode_idle_DW_set()
				else
					melee_mode_idle_SW_set()
				end
			else
				if (SJ_ind == 2 or SJ_ind == 3) then
					mage_mode_idle_DW_set()
				else
					mage_mode_idle_SW_set()
				end
			end
		else
			if Melee_mode == true then
				melee_mode_engaged_set()
			else
				mage_mode_engaged_set()
				equip(sets.Weapon_range[sets.Weapon_range.index[Wr_ind]])
			end
		end
	elseif command == "toggle Range set reverse" then
		Ranged_ind = Ranged_ind - 1
		if Ranged_ind < 1 then
			Ranged_ind = #sets.Ranged.index
		end
		send_command("@input /echo <----- Ranged Set changed to " .. sets.Range.index[Range_ind] .. " ----->")
		if player.status ~= 'Engaged' then
			if Melee_mode == true then
				if (SJ_ind == 2 or SJ_ind == 3) then
					melee_mode_idle_DW_set()
				else
					melee_mode_idle_SW_set()
				end
			else
				if (SJ_ind == 2 or SJ_ind == 3) then
					mage_mode_idle_DW_set()
				else
					mage_mode_idle_SW_set()
				end
			end
		else
			if Melee_mode == true then
				melee_mode_engaged_set()
			else
				mage_mode_engaged_set()
				equip(sets.Weapon_range[sets.Weapon_range.index[Wr_ind]])
			end
		end
	elseif command == "toggle WS set" then
		WS_ind = WS_ind + 1
		if WS_ind > #sets.WS.index then
			WS_ind = 1
		end
		send_command("@input /echo <----- WS Set changed to " .. sets.WS.index[WS_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle WS set reverse" then
		WS_ind = WS_ind - 1
		if WS_ind < 1 then
			WS_ind = #sets.WS.index
		end
		send_command("@input /echo <----- WS Set changed to " .. sets.WS.index[WS_ind] .. " ----->")
		determine_equip_set()	
	elseif command == "toggle Melee Weapon set" then
		Wm_ind = Wm_ind + 1
		if Wm_ind > #sets.Weapon_melee.index then
			Wm_ind = 1
		end
		send_command("@input /echo <----- Melee weapon changed to " .. sets.Weapon_melee.index[Wm_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle Range Weapon set" then
		Wr_ind = Wr_ind + 1
		if Wr_ind > #sets.Weapon_range.index then
			Wr_ind = 1
		end
		send_command("@input /echo <----- Range weapon changed to " .. sets.Weapon_range.index[Wr_ind] .. " ----->")
		if Wr_ind == 2 then
			equip(sets.Weapon_range[sets.Weapon_range.index[Wr_ind]])
			disable(range,ammo)
			determine_equip_set()
			send_command("@input /echo Range/Ammo disabled")
		else
			enable(range,ammo)
			determine_equip_set()
			send_command("@input /echo Range/Ammo enabled")
		end
	elseif command == "toggle DW set" then
		DW_mode_ind = DW_mode_ind + 1
		
		if DW_mode_ind > #sets.DW_mode.index then
			DW_mode_ind = 1
			
		end
		if (player.sub_job == 'DNC' and DW_mode_ind == 1) then
			SJ_ind = 3
			equip(sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]])
		elseif (player.sub_job == 'NIN' and DW_mode_ind == 1) then
			SJ_ind = 2
			equip(sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]])
		else
			SJ_ind = 1
			equip(
				sets.Weapon_melee[sets.Weapon_melee.index[Wm_ind]],
				sets.DW_mode[sets.DW_mode.index[DW_mode_ind]]
			)			
		end
		send_command("@input /echo <----- DW status changed to " .. sets.DW_mode.index[DW_mode_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle Idle set" then
		Idle_ind = Idle_ind + 1
		Idle_melee_DW_ind = Idle_melee_DW_ind + 1
		Idle_melee_SW_ind = Idle_melee_SW_ind + 1		
		if Idle_ind > #sets.Idle.index then
			Idle_ind = 1
			Idle_melee_DW_ind = 1
			Idle_melee_SW_ind = 1			
		end
		send_command("@input /echo <----- Idle Set changed to " .. sets.Idle.index[Idle_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle Idle set reverse" then
		Idle_ind = Idle_ind - 1
		Idle_melee_DW_ind = Idle_melee_DW_ind - 1
		Idle_melee_SW_ind = Idle_melee_SW_ind - 1
		if Idle_ind < 1 then
			Idle_ind = #sets.Idle.index
			Idle_melee_DW_ind = #sets.Idle_melee_DW.index
			Idle_melee_SW_ind = #sets.Idle_melee_SW.index
		end
		send_command("@input /echo <----- Idle Set changed to " .. sets.Idle.index[Idle_ind] .. " ----->")
		determine_equip_set()
	elseif command == "toggle Burst Mode" then
		if Burst_mode == false then
			Burst_mode = true
			send_command("@input /echo <----- Burst Mode ON ----->")
		else
			Burst_mode = false
			send_command("@input /echo <----- Burst Mode OFF ----->")
		end
	elseif command == "toggle Melee Mode" then
		if Melee_mode == false then
			Melee_mode = true
			if (SJ_ind == 2 or SJ_ind == 3) then
				melee_mode_idle_DW_set()
			else
				melee_mode_idle_SW_set()
			end
			send_command("@input /echo <----- Melee Mode ----->")
		else
			Melee_mode = false
			if (SJ_ind == 2 or SJ_ind == 3) then
				mage_mode_idle_DW_set()
			else
				mage_mode_idle_SW_set()
			end
			send_command("@input /echo <----- Mage Mode ----->")
		end
	elseif command == "toggle Weapon Lock" then
		if Weapon_lock == false then
			Weapon_lock = true
			send_command("@input /echo <----- Weapon Lock ON ----->")
		else
			Weapon_lock = false
			send_command("@input /echo <----- Weapon Lock OFF ----->")
		end
	elseif command == "toggle Saboteur Mode" then
		if Notorious_monster == true then
			Notorious_monster = false
			send_command("@input /echo <----- Saboteur Mode: Normal ----->")
		else
			Notorious_monster = true
			send_command("@input /echo <----- Saboteur Mode: Notorious Monster ----->")
		end
	end
end


------------------------------------------------------------------------------
------------------------------------------------------------------------------

--Detects movement and equips movement speed sets
--WIN+F12 disables



------------------------------------------------------------------------------
------------------------------------------------------------------------------
	

--Duration Formula:
-- -- floor[((Base Duration × Saboteur) + (6s × RDM Group 2 Merit Point Level) + (3s × RDM Relic Head Group 2 Merit Point Level Augment) 
-- -- + RDM Enfeebling Job Points + RDM Stymie Job Points + Gear that list Seconds) × (Augments Composure Bonus) × (Duration listed on Gear)
-- -- × (Duration Augments on Gear)] = Duration
-- Base
-- Category2
-- Category2Head
-- JobGiftsAndGear (gear is only gear displaying seconds)
-- ComposureBonus
-- GearDuration
-- GearDurationAugments

function reset_enfeebling_variables()
	Category2 = 6.00 * EnfeeblingDurationMerits
	Category2Head = 3.00 * EnfeeblingDurationMerits
	Composure = 1.00
	Stymie = 0.00
	base = 0.00
	FlatGearBonus = 0.00
	GearAugments = 1.00
	MultiplicativeGearBonus = 1.00
	DurationTotal = 0.00		
end

function create_custom_timer(DurationTotal, spell)
	send_command('timers create "'.. spell.english .. ': ' .. spell.target.name .. '" ' .. DurationTotal .. ' down')
end

function set_enfeebling_duration_timer(spell, buff)
	if duration30:contains(spell.english) then
		base = 30.00
	end
	if duration60:contains(spell.english) then
		base = 60.00
	end
	if duration90:contains(spell.english) then
		base = 90.00
	end
	if duration120:contains(spell.english) then
		base = 120.00
	end
	if duration180:contains(spell.english) then
		base = 180.00
	end
	if duration300:contains(spell.english) then
		base = 300.00
	end
	if buffactive['Saboteur'] then -- need to find a way to distinguish NMs (currently uses a toggle; Default: NM)
		if Notorious_monster == false then
			if player.equipment.hands == "Lethargy Gantherots" or player.equipment.hands == "Lethargy Gantherots +1" then
				base = base * 2.12
			else
				base = base * 2.00
			end
		else
			if player.equipment.hands == "Lethargy Gantherots" or player.equipment.hands == "Lethargy Gantherots +1" then
				base = base * 1.37
			else
				base = base * 1.25
			end
		end
	end
	--5/5 bonus
	if LethargySet:contains(player.equipment.head) and
		LethargySet:contains(player.equipment.body) and
		LethargySet:contains(player.equipment.hands) and
		LethargySet:contains(player.equipment.legs) and
		LethargySet:contains(player.equipment.feet)
	then
		Composure = 1.50
	--2/5 bonus
	elseif (
		(LethargySet:contains(player.equipment.head) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		(LethargySet:contains(player.equipment.body) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		(LethargySet:contains(player.equipment.hands) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		(LethargySet:contains(player.equipment.legs) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.feet)))
		or
		(LethargySet:contains(player.equipment.feet) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs)))
		)
	then
		Composure = 1.10
	--3/5 bonus
	elseif (
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.body)) and
		(LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.hands)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.legs)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.legs) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands)))
		or
		((LethargySet:contains(player.equipment.feet) and LethargySet:contains(player.equipment.head)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs)))
		or
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.hands)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.legs)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs)))
		or
		((LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.legs)))
		) 
	then
		Composure = 1.20
	--4/5 bonus	
	elseif (
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.hands)) and
		(LethargySet:contains(player.equipment.legs) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.legs)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.legs) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.body)))
		or
		((LethargySet:contains(player.equipment.legs) and LethargySet:contains(player.equipment.feet) and LethargySet:contains(player.equipment.head)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.hands)))
		or
		((LethargySet:contains(player.equipment.feet) and LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.body)) and
		(LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.legs)))
		or
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.legs)))
		or
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.legs)) and
		(LethargySet:contains(player.equipment.body) or
		LethargySet:contains(player.equipment.feet)))
		or
		((LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.legs) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.hands)))
		or
		((LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.hands) and LethargySet:contains(player.equipment.feet)) and
		(LethargySet:contains(player.equipment.head) or
		LethargySet:contains(player.equipment.legs)))
		or
		((LethargySet:contains(player.equipment.head) and LethargySet:contains(player.equipment.body) and LethargySet:contains(player.equipment.legs)) and
		(LethargySet:contains(player.equipment.hands) or
		LethargySet:contains(player.equipment.feet)))
		)
	then
		composure = 1.35
	end
	if player.equipment.neck == "Dls. Torque" then
		GearAugments = GearAugments + 0.15
	elseif player.equipment.neck == "Dls. Torque +2" then
		GearAugments = GearAugments + 0.20
	elseif player.equipment.neck == "Dls. Torque +2" then
		GearAugments = GearAugments + 0.25
	end
	if (player.equipment.left_ear == "Snotra Earring" or player.equipment.right_ear == "Snotra Earring") then
		MultiplicativeGearBonus = MultiplicativeGearBonus + 0.10
	end
	if player.equipment.hands == "Regal Cuffs" then
		MultiplicativeGearBonus = MultiplicativeGearBonus + 0.20
	end
	if (player.equipment.left_ring == "Kishar Ring" or player.equipment.right_ring == "Kishar Ring") then
		MultiplicativeGearBonus = MultiplicativeGearBonus + 0.10
	end
	if player.equipment.waist == "Obstin. Sash" then
		MultiplicativeGearBonus = MultiplicativeGearBonus + 0.05
	end
	if buffactive['Stymie'] then
		Stymie = StymieDurationGifts
	end
	if player.equipment.head == "Vitiation Chapeau" or 
		player.equipment.head == "Vitiation Chapeau +1" or 
		player.equipment.head == "Vitiation Chapeau +2" or 
		player.equipment.head == "Vitiation Chapeau +3" 
	then
		Category2Head = 3.00 * EnfeeblingDurationMerits
	end
	
	DurationTotal = (base + Category2 + Category2Head + EnfeeblingDurationGifts + Stymie + FlatGearBonus) * Composure * MultiplicativeGearBonus * GearAugments	
	create_custom_timer(DurationTotal, spell)
end



function has_any_buff_of(buff_set)
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then 
			return true 
		end
    end
end