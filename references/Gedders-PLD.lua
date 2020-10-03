-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Cab. Breeches +3"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets +3"}
    sets.precast.JA['Sentinel'] = {feet="Cab. Leggings +3"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet +3"}
    sets.precast.JA['Iron Will'] = {head="Cab. Coronet +3"}
    sets.precast.JA['Fealty'] = {body="Cab Surcoat +3"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {body="Cab Surcoat +3"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        
	}

    -- Fast cast sets for spells
	
	sets.precast.FC = {
		
	}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    
    sets.precast.WS = {
		
	}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Odyssean Greaves", legs="Carmine Cuisses +1"})


    --------------------------------------
    -- Cursna Set
    --------------------------------------
    
	function job_buff_change(buff,gain)
      	if buff == "doom" then
        	if gain then
            	equip(sets.buff.Doom)
            	send_command('@input /p DOOM DOOM DOOM Gotta get that DOOM DOOM DOOM.')
             	disable('neck','ring1','ring2','waist')
        	else
            	enable('neck','ring1','ring2','waist')
            	handle_equipping_gear(player.status)
        	end
    		end
	end

	sets.buff.Doom = {
      		ring1="Eshmun's Ring", --20
      		ring2="Eshmun's Ring", --20
   		 }

    --------------------------------------
    -- Midcast sets
    --------------------------------------
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	sets.midcast.Cure = {
		
	}


    -- Idle sets
    sets.idle = {
    ammo="Vanir Battery",
    head={ name="Cab. Coronet +3", augments={'Enhances "Iron Will" effect',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
	    
    	sets.engaged = {
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Kgt. Beads +2", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Genmei Earring",
    left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    right_ring="Defending Ring",
    back={ name="Rudianos's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Enmity+10','Damage taken-5%',}},
}
end
