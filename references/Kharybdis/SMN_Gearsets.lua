-- Setup your Key Bindings here:  
    windower.send_command('bind f7 gs c toggle mb')
    windower.send_command('bind f9 gs c avatar mode')
    windower.send_command('bind f10 gs c toggle auto')
    windower.send_command('bind f12 gs c toggle melee')
     
     
-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.avatar = {}    -- leave this empty
      
    -- Your idle set when you DON'T have an avatar out
    sets.me.idle = {ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands="Asteria mitts",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Warp Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	}
      
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = {ammo="Sancus Sachet",
		head="Beckoner's Horn +1 +1",
		body="Shomonjijoe +1",
		hands="Asteria mitts",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Warp Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	}
      
    -----------------------
    -- Perpetuation Related
    -----------------------
      
    -- Avatar's Out --  
    -- This is the base for all perpetuation scenarios, as seen below
    sets.avatar.perp = {ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands="Asteria mitts",
		legs="Assiduity Pants +1",
		feet="Apogee pumps",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	}

  
    -- The following sets base off of perpetuation, so you can consider them idle sets.
    -- Set the relevant gear, bearing in mind it will overwrite the perpetuation item for that slot!
    sets.avatar["Carbuncle"] = {hands="Asteria Mitts +1"}
    sets.avatar["Cait Sith"] = {hands="Lamassu Mitts +1"}
    -- When we want our avatar to stay alive
    sets.avatar.tank = set_combine(sets.avatar.perp,{ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Assiduity Pants +1",
		feet="Apogee pumps",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	})
      
    -- When we want our avatar to shred
    sets.avatar.melee = set_combine(sets.avatar.perp,{ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Assiduity Pants +1",
		feet="Apogee pumps",
		neck="Caller's Pendant",
		waist="Klouskap Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	})
      
    -- When we want our avatar to hit
    sets.avatar.acc = set_combine(sets.avatar.perp,{ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Assiduity Pants +1",
		feet="Apogee pumps",
		neck="Caller's Pendant",
		waist="Klouskap Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	})
      
    -- When Avatar's Favori s active
    sets.avatar.favor = set_combine(sets.avatar.perp,{ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Shomonjijoe +1",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Assiduity Pants +1",
		feet="Apogee pumps",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	})
      
    ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
      
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
    sets.avatar.skill = {ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Con. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    }
      
    -------------------------
    -- Individual Blood Pacts
    -------------------------
      
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+6','Pet: MND+4','Pet: Mag. Acc.+6',}},
		legs="Enticer's pants",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Incarnation Sash",
		left_ear="Gifted Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
    sets.avatar.pacc = set_combine(sets.avatar.atk,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+6','Pet: MND+4','Pet: Mag. Acc.+6',}},
		legs="Enticer's pants",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Incarnation Sash",
		left_ear="Gifted Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
      
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+5','Pet: Mag. Acc.+2',}},
		legs="Beck. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		ring1="Varar Ring",
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Gifted Earring",
		right_ear="Gelos Earring",
		ring2="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
	})
    sets.avatar.mb = set_combine(sets.avatar.mab,{hands="Glyphic Bracers +1"})
    -- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Enticer's pants",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Klouskap Sash",
		left_ear="Gifted Earring",
		right_ear="Gelos Earring",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
      
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Con. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Incarnation Sash",
		left_ear="Gifted Earring",
		right_ear="Gelos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
      
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Con. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Klouskap Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
      
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{ammo="Sancus Sachet",
		head={ name="Apogee Crown", augments={'Pet: Attack+20','Pet: "Mag.Atk.Bns."+20','Blood Pact Dmg.+7',}},
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Con. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Klouskap Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    })
      
    -- Combat Related Sets
      
    -- Melee
    -- The melee set combines with perpetuation, because we don't want to be losing all our MP whilst we swing our Staff
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    sets.me.melee = set_combine(sets.avatar.perp,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
      
    -- Shattersoul. Weapon Skills do not work off perpetuation as it only stays equipped for a moment
    sets.me["Shattersoul"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
    sets.me["Garland of Bliss"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}
      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head={ name="Psycloth Tiara", augments={'Mag. Acc.+20','"Fast Cast"+10','INT+7',}},
		body="Shomonjijoe",
		hands={ name="Amalric Gages", augments={'INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet="Chelona Boots +1",
		neck="Caller's Pendant",
		waist="Witful Belt",
		left_ear="Evans Earring",
		right_ear="Loquac. Earring",
		left_ring="Evoker's Ring",
		right_ring="Weather. Ring",
		back="Swith Cape",
}
   
      
    -- Summoning Magic Cast time - gear
    sets.precast.summoning = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
       head={ name="Psycloth Tiara", augments={'Mag. Acc.+20','"Fast Cast"+10','INT+7',}},
		body="Shomonjijoe",
		hands={ name="Amalric Gages", augments={'INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet="Chelona Boots +1",
		neck="Caller's Pendant",
		waist="Witful Belt",
		left_ear="Evans Earring",
		right_ear="Loquac. Earring",
		left_ring="Evoker's Ring",
		right_ring="Weather. Ring",
		back="Swith Cape",
    })
      
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
		head={ name="Psycloth Tiara", augments={'Mag. Acc.+20','"Fast Cast"+10','INT+7',}},
		body="Shomonjijoe",
		hands={ name="Amalric Gages", augments={'INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet="Chelona Boots +1",
		neck="Caller's Pendant",
		waist="Witful Belt",
		left_ear="Evans Earring",
		right_ear="Loquac. Earring",
		left_ring="Evoker's Ring",
		right_ring="Weather. Ring",
		back="Swith Cape",
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
		head="",
		body="",
		hands="",
		legs="",
		feet="",
		neck="",
		waist="",
		left_ear="Mendi. Earring",
		right_ear="",
		left_ring="",
		right_ring="",
		back="",
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------
      
    -- Blood Pact Ability Delay
    sets.precast.bp = {
        main="",
        sub="",
        ranged="",
        ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Beck. Spats +1",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back="Conveyance Cape",
    }
      
    -- Mana Cede
    sets.precast["Mana Cede"] = {
        main="",
        sub="",
        ranged="",
        ammo="Sancus Sachet",
		head="Summoner's Horn",
		body="Con. Doublet +2",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Summoner's Spats",
		feet={ name="Apogee Pumps", augments={'MP+60','Summoning magic skill +15','Blood Pact Dmg.+7',}},
		neck="Caller's Pendant",
		waist="Lucidity Sash",
		left_ear="Evans Earring",
		right_ear="Smn. Earring",
		left_ring="Evoker's Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
    }
      
    -- Astral Flow  
    sets.precast["Astral Flow"] = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
      
    ----------
    -- Midcast
    ----------
      
    -- We handle the damage and etc. in Pet Midcast later
      
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    }
      
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
      
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.midcast.siphon = set_combine(sets.avatar.skill,{
        main="",
        sub="",
        ranged="",
        ammo="",
        head="",
        neck="",
        lear="",
        rear="",
        body="",
        hands="",
        lring="",
        rring="",
        back="",
        waist="",
        legs="",
        feet=""
    })
        
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
        main="",
        sub="",
        ranged="",
		ammo="Sancus Sachet",
		head="Beckoner's Horn +1",
		body="Vrikodara Jupon",
		hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+2%',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet={ name="Amalric Nails", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Conserve MP"+6',}},
		neck="Phalaina Locket",
		waist="Salire Belt",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Evoker's Ring",
		right_ring="Warp Ring",
		back="Oretan. Cape +1",
    })
      
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have an avatar out?
  
end
