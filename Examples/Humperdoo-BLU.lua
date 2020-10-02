function get_sets()

	send_command('bind f9 gs c toggle TP set')
	send_command('bind f10 gs c toggle Idle set')
	send_command('bind f11 gs c toggle CDC set')
	send_command('bind f12 gs c toggle Req set')
	send_command('bind !f12 gs c toggle Rea set')
	
	function file_unload()
      
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
	end	
		
	--Idle Sets--	
	sets.Idle = {}
	
	sets.Idle.index = {'Standard','DT'}
	Idle_ind = 1			
	
	sets.Idle.Standard = {ammo="Ginsen",
						  head="Adhemar bonnet +1",neck="Mirage Stole +1", ear1="Brutal earring", ear2="Suppanomimi",
						 body="Jhakri robe +2",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Petrov Ring",
						  back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
						  
	sets.Idle.DT = {ammo="Vanir Battery",
			    	head="Aya. zucchetto +2",neck="Twilight torque",ear1="Dominance earring",ear2="Suppanomimi",
					body="Jhakri robe +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Warden's Ring",
					back="Moonbeam cape",waist="Oneiros belt",legs="Aya. Cosciales +2",feet={ name="Herculean Boots", augments={'Accuracy+21 Attack+21','Magic dmg. taken -4%','CHR+1','Accuracy+10','Attack+15',}}}
							
							
							
							
	
	
	--TP Sets--
	sets.TP = {}

	sets.TP.index = {'Standard', 'Solo', 'Safe', 'AccuracyLite', 'AccuracyFull', 'AccuracyExtreme', 'DT', 'DTAccuracy'}
	--1=Standard, 2=Solo, 3=Marches, 4=AccuracyLite, 5=AccuracyFull, 6=DT, 7=DTAccuracy--
	TP_ind = 1
	
	sets.TP.Standard = {ammo="Ginsen",
						head="Adhemar bonnet +1",neck="Mirage Stole +1",ear1="Brutal earring",ear2="Suppanomimi",
						body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Petrov Ring",
						back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
						
	sets.TP.Solo = {ammo="Ginsen",
					head="Adhemar bonnet +1",neck="Mirage Stole +1",ear1="Brutal earring",ear2="Suppanomimi",
					body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Petrov Ring",
					back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
					
	sets.TP.Safe = {ammo="Ginsen",
					head="Adhemar bonnet +1",neck="Mirage Stole +1",ear1="Brutal earring",ear2="Suppanomimi",
					body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Petrov Ring",
					back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
					
	sets.TP.AccuracyLite = {ammo="Ginsen",
						    head="Adhemar bonnet +1",neck="Mirage Stole +1",ear1="Brutal earring",ear2="Suppanomimi",
					    	body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Petrov ring",
						    back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
	
	sets.TP.AccuracyFull = {ammo="Ginsen",
						    head="Adhemar bonnet +1",neck="Mirage stole +1",ear1="Brutal earring",ear2="Suppanomimi",
					    	body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Chirich ring",
						    back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
							
	sets.TP.AccuracyExtreme = {ammo="Ginsen",
						       head="Adhemar bonnet +1",neck="Mirage stole +1",ear1="Brutal earring",ear2="Suppanomimi",
					    	   body="Ayanmo corazzo +2",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Chirich ring",
						       back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
							
	sets.TP.DT = {ammo="Ginsen",
				  head="Adhemar bonnet +1",neck="Twilight torque",ear1="Brutal earring",ear2="Suppanomimi",
				  body="Ayanmo corazza +2",hands="Adhemar Wrist. +1",ring1="Ayanmo Ring",ring2="Epona's ring",
				  back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs="Ayanmo cosciales +2",feet={name="Herculean Boots",augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
				  
	sets.TP.DTAccuracy = {ammo="Ginsen",
					      head="Aya. zucchetto +2",neck="Mirage Stole +1",ear1="Brutal earring",ear2="Suppanomimi",
				          body="Ayanmo corazza +2",hands="Adhemar Wrist. +1",ring1="Ayanmo ring",ring2="Epona's ring",
				          back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Windbuffet belt +1",legs="Ayanmo cosciales +2",feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
	
	
	
	
	
	--Weaponskill Sets--
	sets.WS = {}
	
	sets.Requiescat = {}
	
	sets.Requiescat.index = {'Attack','Accuracy'}
	Requiescat_ind = 1
	
	sets.Requiescat.Attack = {ammo="Quartz Tathlum +1",
						      head="Jhakri coronal +2",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
						 	  body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epona's ring",ring2="Levia. ring",
						   	  back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Soil belt",legs="Jhakri slops +1",feet="Jhakri pigaches +1"}
								  
	sets.Requiescat.Accuracy = {ammo="Honed tathlum",
						        head="Jhakri coronal +2",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
							    body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Epona's ring",ring2="Levia. ring",
							    back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},waist="Soil belt",legs="Jhakri slops +1",feet="Jhakri pigaches +1"}
							 
	sets.ChantDuCygne = {}
	
	sets.ChantDuCygne.index = {'Attack','Accuracy'}
	ChantDuCygne_ind = 1
	
	sets.ChantDuCygne.Attack = {ammo="Jukukik feather",
						        head="Adhemar bonnet +1",neck="Mirage stole +1",ear1="Moonshade earring",ear2="Mache earring",
							    body="Adhemar jacket +1",hands="Adhemar wrist. +1",ring1="Epona's ring",ring2="Apate ring",
							    back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Light belt",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
							   
	sets.ChantDuCygne.Accuracy = {ammo="Jukukik feather",
						          head="Adhemar bonnet +1",neck="Mirage stole +1",ear1="Moonshade earring",ear2="Mache earring",
							      body="Adhemar jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's ring",ring2="Apate ring",
							      back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Grunfeld rope",legs={name="Herculean Trousers",augments={'Attack+4','"Triple Atk."+4','DEX+10',}},feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','"Triple Atk."+4','DEX+7','Accuracy+11','Attack+8',}}}
							   
	sets.WS.SanguineBlade = {}
	
	sets.WS.SanguineBlade = {ammo="Ghastly Tathlum +1",
						     head="Jhakri coronal +2",neck="Sanctity necklace",ear1="Hecate's earring",ear2="Friomisi earring",
							 body="Jhakri robe +2",hands="Jhakri cuffs +2",ring1="Archon ring",ring2="Acumen ring",
							 back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Jhakri slops +1",feet="Jhakri pigaches +1"}
		
	sets.WS.CircleBlade = {}		
			
	sets.WS.CircleBlade = {ammo="Cheruski needle",
						   head="Jhakri coronal +2",neck="Fotia Gorget",ear1="Flame Pearl",ear2="Moonshade earring",
						   body="Jhakri robe +2",hands="Jhakri cuffs +2",ring1="Ifrit ring",ring2="Rufescent ring",
						   back={name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Soil belt",legs="Jhakri slops +1",feet="Jhakri pigaches +1"}
						   
	sets.WS.Expiacion = {}		
			
	sets.WS.Expiacion = {ammo="Cheruski needle",
					     head={name="Herculean Helm",augments={'Attack+7','Weapon skill damage +4%','STR+6','Accuracy+8',}},neck="Mirage stole +1",ear1="Ishvara earring",ear2="Moonshade earring",
						 body="Assmim. Jubbah +2",hands="Jhakri cuffs +2",ring1="Rufescent ring",ring2="Ifrit Ring",
						 back={name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Prosilio belt +1",legs="Luhlaza Shalwar +2",feet={ name="Herculean Boots", augments={'Accuracy+20','Weapon skill damage +5%','AGI+2','Attack+4',}}}
						 
	sets.Realmrazer = {}
	
	sets.Realmrazer.index = {'Attack','Accuracy'}
	Realmrazer_ind = 1
	
	sets.Realmrazer.Attack = {ammo="Cheruski needle",
						      head="Whirlpool mask",neck="Flame gorget",ear1="Bladeborn earring",ear2="Steelflash Earring",
						 	  body="Luhlaza jubbah +1",hands="Luh. Bazubands +1",ring1="Levia. ring",ring2="Aquasoul ring",
						   	  back="Atheling mantle",waist="Fotia belt",legs="Quiahuiz trousers",feet="Luhlaza charuqs +1"}
							  
	sets.Realmrazer.Accuracy = {ammo="Honed tathlum",
						        head="Whirlpool mask",neck="Flame gorget",ear1="Bladeborn earring",ear2="Steelflash earring",
							    body="Luhlaza jubbah +1",hands="Luh. Bazubands +1",ring1="Levia. ring",ring2="Aquasoul ring",
							    back="Letalis mantle",waist="Fotia belt",legs="Quiahuiz trousers",feet="Assim. charuqs +1"}
							
	sets.WS.FlashNova = {}
	
	sets.WS.FlashNova = {ammo="Erlene's notebook",
						 head="Hagondes hat",neck="Eddy necklace",ear1="Hecate's earring",ear2="Friomisi earring",
						 body="Hagondes Coat +1",hands="Hagondes cuffs",ring1="Spiral ring",ring2="Acumen ring",
						 back="Cornflower cape",waist="Aswang sash",legs="Hagondes Pants +1",feet="Hagondes sabots"}
								
								
								
								
								
	--Blue Magic Sets--
	sets.BlueMagic = {}
	
	sets.BlueMagic.STR = {ammo="Mavi tathlum",
						 head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Flame pearl",ear2="Flame pearl",
					      body="Assim. jubbah +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Ifrit ring",
						  back={name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Prosilio belt +1",legs="Jhakri slops +1",feet="Aya. gambieras +1"}
						  
	sets.BlueMagic.STRDEX = {ammo="Cheruski needle",
						    head="Aya. Zucchetto +2",neck="Mirage Stole +1",ear1="Kuwunga earring",ear2="Flame pearl",
					        body="Assim. jubbah +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Rajas ring",
						    back={name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Prosilio belt +1",legs="Aya. cosciales +2",feet="Aya. gambieras +1"}
							
	sets.BlueMagic.STRVIT = {ammo="Mavi tathlum",
						     head="Aya. zucchetto +2",neck="Mirage Stole +1",ear1="Flame pearl",ear2="Flame pearl",
					         body="Assim. jubbah +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Petrov ring",
						     back={name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Prosilio belt +1",legs="Aya. cosciales +2",feet="Aya. gambieras +1"}
							 
	sets.BlueMagic.STRMND = {ammo="Mavi tathlum",
						     head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Flame pearl",ear2="Flame pearl",
					         body="Assim. jubbah +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Levia. ring",
						     back={name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Prosilio belt +1",legs="Jhakri slops +1",feet="Aya. gambieras +1"}
	
	sets.BlueMagic.AGI = {ammo="Mavi tathlum",
						  head="Aya. Zucchetto +1",neck="Mirage stole +1",ear1="Hermetic hearring",ear2="Suppanomimi",
					      body="Assim. Jubbah +2",hands="Aya. manopolas +1",ring1="Garuda Ring",ring2="Garuda ring",
						  back="Cornflower cape",waist="Svelt. Gouriz +1",legs="Aya. cosciales +2",feet="Aya. gambieras +1"}
						  
	sets.BlueMagic.INT = {ammo="Ghastly Tathlum +1",
						  head="Jhakri coronal +2",neck="Sanctity necklace",ear1="Hecate's earring",ear2="Friomisi earring",
						  body="Jhakri robe +2",hands="Jhakri cuffs +2",ring1="Shiva Ring",ring2="Acumen ring",
						  back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza Shalwar +2",feet="Jhakri pigaches +1"}
						  
							
	
	
	
	
	sets.BlueMagic.MABSTR = {ammo="Ghastly Tathlum +1",
						 head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					      body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Ifrit ring",ring2="Acumen ring",
						  back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}
						  
	sets.BlueMagic.MABSTRDEX = {ammo="Cheruski needle",
						    head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					        body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Rajas ring",ring2="Acumen ring",
						    back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}
	
	sets.BlueMagic.MABDEX = {ammo="Cheruski needle",
						    head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					        body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Rajas ring",ring2="Acumen ring",
						    back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}
	
	sets.BlueMagic.MABSTRVIT = {ammo="Ghastly Tathlum +1",
						     head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					         body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Ayanmo ring",ring2="Acumen ring",
						     back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}

	sets.BlueMagic.MABVIT = {ammo="Ghastly Tathlum +1",
						     head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					         body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Ayanmo ring",ring2="Acumen ring",
						     back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}		
		
	sets.BlueMagic.MABSTRMND = {ammo="Ghastly Tathlum +1",
						     head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Hecate's earring",ear2="Friomisi earring",
					         body="Assim. jubbah +2",hands="Jhakri cuffs +2",ring1="Rufescent ring",ring2="Acumen ring",
						     back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}
	
	sets.BlueMagic.MABAGI = {ammo="Ghastly Tathlum +1",
						  head="Jhakri coronal +2",neck="Sanctity necklace",ear1="Hecate's earring",ear2="Friomisi earring",
					      body="Assim. Jubbah +2",hands="Jhakri cuffs +2",ring1="Garuda Ring",ring2="Acumen ring",
						  back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}
						  					  
	sets.BlueMagic.MABMND = {ammo="Ghastly Tathlum +1",
							head="Jhakri coronal +2",neck="Sanctity necklace",ear1="Friomisi earring",ear2="Hecate's earring",
						    body="Jhakri robe +2",hands="Jhakri cuffs +2",ring1="Levia. Ring",ring2="Acumen Ring",
							back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan stone",legs="Luhlaza shalwar +2",feet="Jhakri pigaches +1"}							
							
	
	
	
	
	sets.BlueMagic.Cures = {ammo="Aqua sachet",
						    head="Weath. corona +1",neck="Nuna Gorget",ear1="Lifestorm Earring",ear2="Myrddin pearl",
						    body="Pinga Tunic",hands={name="Telchine Gloves",augments={'"Cure" potency +6%','MND+6',}},ring1="Levia. ring",ring2="Levia. ring",
						    back="Oretania's cape",waist="Pythia sash",legs="Carmine Cuisses +1",feet="Medium's Sabots"}
							
	sets.BlueMagic.SelfCures = {ammo="Aqua sachet",
								head="Weath. corona +1",neck="Nuna Gorget",ear1="Lifestorm Earring",ear2="Myrddin pearl",
								body="Pinga Tunic",hands={name="Telchine Gloves",augments={'"Cure" potency +6%','MND+6',}},ring1="Levia. ring",ring2="Kunaji ring",
								back="Oretania's cape",waist="Pythia sash",legs="Carmine Cuisses +1",feet="Medium's Sabots"}
							
	sets.BlueMagic.Stun = {ammo="Falcon Eye",
						   head="Carmine Mask +1",neck="Mirage Stole +1",ear1="Hermetic earring", ear2="Heartseeker earring",
						   body="Ayanmo corazza +2",hands="Jhakri cuffs +2",ring1="Ayanmo ring",ring2="Jhakri ring",
						   back="Cornflower Cape",waist="Eschan stone",legs="Aya. cosciales +2",feet="Aya. gambieras +1"}
						   
	sets.BlueMagic.HeavyStrike = {ammo="Honed tathlum",
						          head="Aya. Zucchetto +2",neck="Mirage stole +1",ear1="Flame pearl",ear2="Heartseeker earring",
						          body="Assim. jubbah +2",hands="Aya. manopolas +1",ring1="Pyrosoul ring",ring2="Rajas ring",
						          back="Cornflower cape",waist="Dynamic belt +1",legs="Aya. cosciales +2",feet="Assim. charuqs +1"}
								 
	sets.BlueMagic.WhiteWind = {ammo="Egoist's tathlum",
								head="Luh. Keffiyeh +1",neck="Dualism collar +1",ear1="Upsurge Earring",ear2="Odnowa earring",
								body="Pinga Tunic",hands={name="Telchine Gloves",augments={'"Cure" potency +6%','MND+6',}},ring1="Bomb queen ring",ring2="Meridian ring",
								back="Moonbeam cape",waist="Oneiros belt",legs="Pinga pants",feet="Medium's Sabots"}
									 
	sets.BlueMagic.MagicAccuracy = {ammo="Mavi Tathlum",
						            head="Jhakri coronal +2",neck="Mirage Stole +1",ear1="Psystorm earring",ear2="Lifestorm earring",
						            body="Jhakri robe +2",hands="Jhakri cuffs +2",ring1="Ayanmo ring",ring2="Jhakri ring",
						            back={name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},waist="Eschan Stone",legs="Aya. Cosciales +2",feet="Ayanmo gambieras +1"} 
									 
	sets.BlueMagic.Skill = {ammo="Mavi tathlum",
							head="Luh. Keffiyeh +1",neck="Mirage Stole +1",ear1="Loquac. earring",ear2="Moonshade Earring",
							body="Assim. jubbah +2",hands="Mv. Bazubands +1",ring1="Prolix ring",ring2="Shneddick ring", 
							back="Cornflower cape",waist="Twilight belt",legs="Hashinshin tayt",feet="Luhlaza charuqs +1"}
							
	sets.BlueMagic.SkillRecast = {ammo="Mavi tathlum",
							      head="Luh. Keffiyeh +1",neck="Mirage Stole +1",ear1="Loquac. earring",ear2="Moonshade Earring",
							      body="Assim. jubbah +2",hands="Mv. Bazubands +1",ring1="Ayanmo ring",ring2="Kishar ring",
							      back="Swith cape",waist="Twilight belt",legs="Hashinshin tayt",feet="Luhlaza charuqs +1"}
								 
    sets.BlueMagic.MDEF = {ammo="Mavi tathlum",
								head="Telchine Cap",neck="Dualism collar +1",ear1="Mujin Stud",ear2="Cassie earring",
								body="Pinga Tunic",hands="Weath. cuffs +1",ring1="Jhakri Ring",ring2="Shiva ring",
								back="Seshaw cape",waist="Gold mog. belt",legs="Pinga pants",feet="Herculean Boots"}								 
	
								  
								  
								  
						
						
	--Utility Sets--
	sets.Utility = {}
	
	sets.Utility.Stoneskin = {head="Haruspex hat",neck="Stone Gorget",ear1="Loquac. earring",ear2="Earthcry earring",
							  body="Assim. jubbah +2",hands="Stone Mufflers",ring1="Prolix ring",
							  back="Swith cape",waist="Siegel sash",legs="Haven hose",feet="Iuitl gaiters"}
							  
	sets.Utility.Phalanx = {head="Haruspex hat",neck="Colossus's torque",ear1="Loquac. earring",ear2="Augment. earring",
						    body="Assim. jubbah +2",hands="Ayao's gages",ring1="Prolix ring",
							back="Swith cape",waist="Pythia sash +1",legs="Portent pants",feet="Iuitl gaiters"}
							
	sets.Utility.Steps = {ammo="Honed tathlum",
						  head="Whirlpool mask",ear2="Heartseeker earring",
						  body="Thaumas coat",hands="Umuthi gloves",
						  back="Letalis cape",waist="Chaac belt",legs="Manibozho brais",feet="Manibozho boots"}
						  
	sets.Utility.PDT = {head="Whirlpool mask",neck="Twilight torque",ear1="Ethereal earring",
						body="Ayanmo corazza +2",hands="Aya. manopolas +1",ring1="Ayanmo Ring",ring2="Dark ring",
						back="Mollusca mantle",waist="Flume belt",legs="Aya. cosciales +2",feet="Iuitl gaiters"}
						
	sets.Utility.MDT = {head="Whirlpool mask",neck="Twilight torque",
						body="Ayanmo corazza +2",hands="Aya. manopolas +1",ring1="Ayanmo ring",ring2="Dark ring",
						back="Mollusca mantle",legs="Aya. cosciales +2",feet="Luhlaza charuqs +1"}
							
	
	
	
	
	
	--Job Ability Sets--
	
	sets.JA = {}
	
	sets.JA.ChainAffinity = {feet="Assim. charuqs +1"}
	
	sets.JA.BurstAffinity = {feet="Mavi Basmak +2",legs="Assim. Shalwar +2"}
	
	sets.JA.Efflux = {legs="Hashinshin tayt"}
	
	sets.JA.AzureLore = {hands="Luh. bazubands +1"}
	
	sets.JA.Diffusion = {feet="Luhlaza Charuqs +1"}
								
								
			
			
			
			
	--Precast Sets--
	sets.precast = {}
	
	sets.precast.FC = {}
	
	sets.precast.FC.Standard = {ammo="Sapience Orb",
								head="Carmine Mask +1",neck="Twilight Torque", ear1="Loquac. Earring", ear2="Enchntr. Earring +1",
							    body="Pinga Tunic",hands="Leyline Gloves", ring1="Prolix ring", ring2="Kishar ring",
						        back="Swith Cape",waist="Witful Belt",legs="Ayanmo Cosciales +2",feet="Carmine Greaves"}
	
	sets.precast.FC.Blue = {ammo="Sapience Orb",
							head="Carmine Mask +1",neck="Twilight Torque", ear1="Loquac. Earring", ear2="Enchntr. Earring +1",
							body="Pinga Tunic",hands="Leyline Gloves", ring1="Prolix ring", ring2="Kishar ring",
							back="Swith Cape",waist="Witful Belt",legs="Ayanmo Cosciales +2",feet="Carmine Greaves"}	
end






function precast(spell)
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC.Standard)
				
		if spell.skill == 'Blue Magic' then
		equip(sets.precast.FC.Blue)
		end
	end
	
	if spell.english == 'Azure Lore' then
		equip(sets.JA.AzureLore)
	end
	
	if spell.english == 'Requiescat' then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
	end
	
	if spell.english == 'Chant du Cygne' then
		equip(sets.ChantDuCygne[sets.ChantDuCygne.index[ChantDuCygne_ind]])
	end
	
	if spell.english == 'Circle Blade' then
		equip(sets.WS.CircleBlade)
	end
		
	if spell.english == 'Expiacion' or spell.english == 'Savage Blade' or spell.english == 'Red Lotus Blade' then
		equip(sets.WS.Expiacion)
	end
	
	if spell.english == 'Sanguine Blade' then
		equip(sets.WS.SanguineBlade)
	end
	
	if spell.english == 'Box Step' then
		equip(sets.Utility.Steps)
	end
	
	if spell.english == 'Realmrazer' then
		equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
	end
	
	if spell.english == 'Flash Nova' then
		equip(sets.WS.FlashNova)
	end
end
	
function midcast(spell,act)
	if spell.english == 'Vertical Cleave' or spell.english == 'Death Scissors' or spell.english == 'Empty Thrash' or spell.english == 'Dimensional Death' or spell.english == 'Quadrastrike' or spell.english == 'Spinal Cleave' then
		equip(sets.BlueMagic.STR)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
		
	if spell.english == 'Disseverment' or spell.english == 'Sickle Slash' or spell.english == 'Hysteric Barrage' or spell.english == 'Frenetic Rip' or spell.english == 'Seedspray' or spell.english == 'Vanity Dive' or spell.english == 'Goblin Rush' or spell.english == 'Paralyzing Triad' or spell.english == 'Thrashing Assault' or spell.english == 'Asuran Claws' then
		equip(sets.BlueMagic.STRDEX)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Quad. Continuum' or spell.english == 'Delta Thrust' or spell.english == 'Cannonball' or spell.english == 'Glutinous Dart' or spell.english == 'Tail Slap' then
		equip(sets.BlueMagic.STRVIT)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Whirl of Rage' or spell.english == 'Bloodrake' or spell.english == 'Ram Charge' then
		equip(sets.BlueMagic.STRMND)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Benthic Typhoon' or spell.english == 'Final Sting' or spell.english == 'Spiral Spin' or spell.english == 'Silent Storm' or spell.english == 'Molting Plumage' then
		equip(sets.BlueMagic.AGI)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Firespit' or spell.english == 'Corrosive Ooze' or spell.english == 'Water Bomb' or spell.english == 'Dark Orb' or spell.english == 'Thunderbolt' or spell.english == 'Droning Whirlwind' or spell.english == 'Spectral Floe' or spell.english == 'Tenebral Crush' or spell.english == 'Retinal Glare' then
		equip(sets.BlueMagic.INT)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Blazing Bound' then 
		equip(sets.BlueMagic.MDEF)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Searing Tempest' or spell.english == 'Leafstorm' then
		equip(sets.BlueMagic.MABSTR)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Gates of Hades' or spell.english == 'Blinding Fulgor' then
		equip(sets.BlueMagic.MABSTRDEX)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Anvil Lightning' or spell.english == 'Charged Whisker' then
		equip(sets.BlueMagic.MABDEX)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Subduction' or spell.english == 'Rending Deluge' then
		equip(sets.BlueMagic.MABSTRVIT)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Thermal Pulse' or spell.english == 'Embalming Earth' or spell.english == 'Entomb' or spell.english == 'Uproot' then
		equip(sets.BlueMagic.MABVIT)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Foul Waters' then
		equip(sets.BlueMagic.MABSTRMND)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Tearing Gust' or spell.english == 'Palling Salvo' or spell.english == 'Tem. Upheaval' then
		equip(sets.BlueMagic.MABAGI)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Rail Cannon' or spell.english == 'Magic Hammer' or spell.english == 'Evryone. Grudge' or spell.english == "Diffusion Ray" or spell.english == "Nectarous Deluge" or spell.english == 'Acrid Stream' or spell.english == 'Regurgitation' or spell.english == 'Scouring Spate' then
		equip(sets.BlueMagic.MABMND)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Magic Fruit' or spell.english == 'Plenilune Embrace' or spell.english == 'Wild Carrot' or spell.english == 'Pollen' or spell.english == 'Cure III' or spell.english == 'Cure IV' then
		equip(sets.BlueMagic.Cures)
			if spell.target.name == player.name and string.find(spell.english, 'Magic Fruit') or string.find(spell.english, 'Plenilune Embrace') or string.find(spell.english, 'Wild Carrot') or string.find(spell.english, 'Cure III') or string.find(spell.english, 'Cure IV') then
				equip(sets.BlueMagic.SelfCures)
			end
	end
	
	if spell.english == 'White Wind' then
		equip(sets.BlueMagic.WhiteWind)
	end
	
	if spell.english == 'Head Butt' or spell.english == 'Sudden Lunge' or spell.english == 'Blitzstrahl' then
		equip(sets.BlueMagic.Stun)
	end
	
	if spell.english == 'Heavy Strike' then
		equip(sets.BlueMagic.HeavyStrike)
	end
	
	if spell.english == 'Frightful Roar' or spell.english == 'Geist Wall' or spell.english == 'Blank Gaze' or spell.english == 'Infrasonics' or spell.english == 'Voracious Trunk' or spell.english == 'Barbed Crescent' or spell.english == 'Tourbillion' or spell.english == 'Cimicine Discharge' or spell.english == 'Sub-zero smash' or spell.english == 'Filamented Hold' or spell.english == 'Mind Blast' or spell.english == 'Sandspin' or spell.english == 'Hecatomb Wave' or spell.english == 'Cold Wave' or spell.english == 'Terror Touch' or spell.english == 'Cruel Joke' or spell.english == 'Saurian Slide' or spell.english == 'Polar Roar' or spell.english == 'Crashing Thunder' or spell.english == 'Bilgestorm' or spell.english == 'Dream Flower' or spell.english == 'Sheep Song' or spell.english == 'Yawn' or spell.english == 'Soporific' or spell.english == 'Auroral Drape' or spell.english == 'Actinic Burst' then
		equip(sets.BlueMagic.MagicAccuracy)
	end
	
	if spell.english == 'Atra. Libations' then
		equip(sets.BlueMagic.Skill)
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
	
	if spell.english == 'MP Drainkiss' or spell.english == 'Digest' or spell.english == 'Blood Saber' or spell.english == 'Blood Drain' or spell.english == 'Osmosis' or spell.english == 'Occultation' or spell.english == 'Magic Barrier' or spell.english == 'Diamondhide' or spell.english == 'Metallic Body' or spell.english == 'Retinal Glare' then
		equip(sets.BlueMagic.SkillRecast)
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
	
	if spell.english == 'Cocoon' or spell.english == 'Harden Shell' or spell.english == 'Animating Wail' or spell.english == 'Battery Charge' or spell.english == 'Nat. Meditation' or spell.english == 'Carcharian Verve' or spell.english == 'O. Counterstance' or spell.english == 'Barrier Tusk' or spell.english == 'Saline Coat' or spell.english == 'Regeneration' or spell.english == 'Erratic Flutter' or spell.english == 'Mighty Guard' then
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
end

function aftercast(spell)
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	
	if spell.action_type == 'Weaponskill' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle Req set' then
		Requiescat_ind = Requiescat_ind +1
		if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
		send_command('@input /echo <----- Requiescat Set changed to '..sets.Requiescat.index[Requiescat_ind]..' ----->')
	elseif command == 'toggle CDC set' then
		ChantDuCygne_ind = ChantDuCygne_ind +1
		if ChantDuCygne_ind > #sets.ChantDuCygne.index then ChantDuCygne_ind = 1 end
		send_command('@input /echo <----- Chant du Cygne Set changed to '..sets.ChantDuCygne.index[ChantDuCygne_ind]..' ----->')
	elseif command == 'toggle Rea set' then
		Realmrazer_ind = Realmrazer_ind +1
		if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
		send_command('@input /echo <----- Realmrazer Set changed to '..sets.Realmrazer.index[Realmrazer_ind]..' ----->')
	elseif command == 'equip TP set' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'equip Idle set' then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end