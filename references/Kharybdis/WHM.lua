-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+O ]           Regen IV
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts					Dark Arts
--                                          ----------                  ---------
--		        gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	
    no_swap_gear = S{"Warp Ring", "Emporox's Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Endorsement Ring"}

    lockstyleset = 9

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva', 'AOE_Reraise')

    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}
		
    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    send_command('bind ^` input /ja "Afflatus Solace" <me>')
    send_command('bind !` input /ja "Afflatus Misery" <me>')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind @c gs c toggle CP')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad5 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')
    send_command('bind ^numpad0 input /ws "Mystic Boon" <t>')

    select_default_macro_book()
    set_lockstyle()
	
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false	
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')
    send_command('unbind ![')
    send_command('unbind !;')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind !o')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind @w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')
	send_command('unbind f6')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells

    sets.precast.FC = {
    --    /SCH --3
        main="Marin Staff +1", --5
        sub="Oneiros Grip", --8
        ammo="Sapience Orb", --2
        body="Inyanga Jubbah +2", --14
        hands="Fanatic Gloves", --7
        legs="Aya. Cosciales +2", --6
        feet="Kaykaus Boots", --7
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --2
        lring="Kishar Ring", --4
        rring="Lebeche Ring", --5
        back="Alaunus's Cape", --10
        waist="Shinjutsu-no-Obi +1", --3/(3)
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })

    sets.precast.FC['Healing Magic'] = { 
	main="Marin Staff +1",
    sub="Oneiros Grip",
    ammo="Impatiens",
    head="Piety Cap +3",
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Assid. Pants +1",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Nourish. Earring",
    right_ear="Mendi. Earring",
    left_ring="Lebeche Ring",
    right_ring="Kishar Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},
}

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = sets.precast.FC['Healing Magic']
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    -- Precast sets to enhance JAs
	sets.precast.JA['Sublimation'] = {
        waist="Embla Sash",
		ring1="Weatherspoon Ring +1",
        }
		
	sets.buff.FullSublimation = {
		waist="Embla Sash",
       }

    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Floestone",
        head="Piety Cap +3",
        body="Piety Bliaut +3",
        hands="Piety Mitts +3",
        legs="Piety Pantaln. +3",
		feet="Piety Duckbills +3",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        lring="Epaminondas's Ring",
        rring="Shukuyu Ring",
        waist="Fotia Belt",
        back="Relucent Cape",
        }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        waist="Grunfeld Belt",
        })

    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
        rring="Begrudging Ring",
        })

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {})

    -- Midcast Sets

    sets.midcast.FC = {
        head="Bunzi's Hat",
        body="Inyanga Jubbah +2",
        hands="Fanatic Gloves",
        legs="Ebers Pant. +1.",
        feet="Regal Pumps +1",
        ear1="Loquacious Earring",
        ear2="Malignance Earring",
        lring="Kishar Ring",
        back="Alaunus's Cape",
        waist="Witful Belt",
        } -- Haste

    -- Cure sets

    sets.midcast.CureSolace = {
        main="Queller Rod", --15(+2)/(-15)
        sub="Sors Shield", --3/(-5)
        ammo="Impatiens", --0/(-5)
        head="Kaykaus Mitra +1", --11(+2)/(-6)
        body="Ebers Bliaud +1",
        hands="Theophany Mitts +2", --(+4)/(-7)
        legs="Ebers Pant. +1",
        feet="Vanya Clogs", --11(+2)/(-12)
        neck="Incanter's Torque",
        ear1="Glorious Earring", --7
        ear2="Mendicant's Earring", -- (+2)/(-5)
        lring="Lebeche Ring", --3/(-5)
        rring="Menelaus's Ring",
        back="Mending Cape",
        waist="Luminary Sash",
        }

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        main="Chatoyant Staff", --10
        sub="Enki Strap", --0/(-4)
        hands="Kaykaus Cuffs +1", --11/(-6)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        body="Theo. Bliaut +3", --0(+6)/(-6)
        })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        main="Chatoyant Staff", --10
        sub="Enki Strap", --0/(-4)
        hands="Kaykaus Cuffs +1", --11/(-6)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        body="Theo. Bliaut +3", --0(+6)/(-6)
        neck="Voltsurge Torque",
        lring="Menelaus's Ring",
        rring="Stikini Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.CuragaWeather = {
        main="Chatoyant Staff", --10
        sub="Oneiros Grip", --0/(-4)
        body="Theo. Bliaut +3", --0(+6)/(-6)
        hands="Kaykaus Cuffs +1", --11/(-6)
        neck="Voltsurge Torque",
        back="Twilight Cape",
        lring="Menelaus's Ring",
        rring="Stikini Ring +1",
        waist="Hachirin-no-Obi",
        }

    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
        main="Yagrush",
        sub="Genmei Shield",
        head="Ebers Cap +1",
        body="Ebers Bliaud +1",
        hands="Fanatic Gloves",
        legs="Aya. Cosciales +2",
        feet="Regal Pumps +1",
        neck="Voltsurge Torque",
        ear1="Loquacious Earring",
        ear2="Malignance Earring",
        lring="Haoma's Ring",
        rring="Haoma's Ring",
        back="Alaunus's Cape",
        waist="Witful Belt",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Yagrush",
        sub="Genmei shield",
        body="Ebers Bliaud +1",
        hands="Fanatic Gloves", --15
        legs="Th. Pantaloons +3", --21
        feet="Vanya Clogs", --5
        neck="Debilis Medallion +1", --15
        ear1="Beatific Earring",
        ear2="Healing Earring",
        lring="Menelaus's Ring", --15
        rring="Haoma's Ring", --15
        back="Alaunus's Cape", --25
        waist="Witful Belt",
        })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})
	sets.midcast.Esuna = set_combine(sets.midcast.StatusRemoval, {main="Piety Wand", sub="Genmei Shield"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Dynasty Mitts",
        legs="Piety Pantaln. +3",
        feet="Piety Duckbills +3",
        neck="Incanter's Torque",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        lring={name="Stikini Ring +1", bag="wardrobe4"},
        rring={name="Stikini Ring +1", bag="wardrobe2"},
        back="Fi Follet Cape +1",
        waist="Embla Sash",
        }

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Theo. Duckbills +3",
		waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head="Inyanga Tiara +2",
        body="Piety Bliaut +3",
        hands="Ebers Mitts +1",
        legs="Th. Pantaloons +3",
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        body="Telchine Chas.",
        hands="Ebers Mitts +1",
        legs="Th. Pantaloons +3",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        waist="Gishdubar Sash",
        back="Grapevine Cape",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		head="Umuthi Hat",
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry Earring",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
		hands="Regal Cuffs",
        sub="Ammurapi Shield",
        waist="Emphatikos Rope",
        })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +1",
        })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main="Beneficus",
        sub="Ammurapi Shield",
        head="Ebers Cap +1",
        body="Ebers Bliaud +1",
        hands="Ebers Mitts +1",
        legs="Piety Pantaln. +3",
        feet="Ebers Duckbills +1",
        })

    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Ebers Duckbills +1"
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {lring="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
    sets.midcast.ShellraV = set_combine(sets.midcast.Protect, {legs="Piety Pantaln. +3"})

    sets.midcast['Divine Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
		head="empty",
        body="Cohort Cloak +1",
        hands="Volte Gloves",
        legs="Nyame Flanchard",
        neck="Baetyl Pendant",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        lring="Shiva Ring +1",
        rring="Stikini Ring +1",
        back="Seshaw Cape",
        waist="Sacro Cord",
        }

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        head="Ipoca Beret",
        body="Nyame Mail",
		hands="Piety Mitts +3",
        legs="Nyame Flanchard",
        neck="Baetyl Pendant",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        rring="Stikini Ring +1",
        waist="Sacro Cord",
        })

    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +2",
        hands="Theophany Mitts +2",
        legs="Chironic Hose",
        feet="Inyan. Crackows +2",
        neck="Mizu. Kubikazari",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        lring="Metamor. Ring +1",
        rring="Stikini Ring +1",
        back="Alaunus's Cape",
        waist="Fucho-no-Obi",
        }

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Hydrocera",
        head="Empty",
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Chironic Hose",
        feet="Piety Duckbills +3",
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Vor Earring",
        lring="Metamor. Ring +1",
        rring="Stikini Ring +1",
        back="Alaunus's Cape",
        waist="Luminary Sash",
        }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        back="Ogapepo Cape",
        waist="Luminary Sash",
        })

    sets.midcast.Impact = {
        main="Xoanon",
        sub="Enki Strap",
        head=empty,
        body="Twilight Cloak",
        hands="Inyan. Dastanas +2",
        legs="Th. Pant. +2",
        feet="Theo. Duckbills +3",
        rring="Archon Ring",
        }
		
	sets.midcast['Dia II'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Per. Lucky Egg",
        head="Volte Cap",
        body="Theo. Bliaut +3",
        hands="Volte Gloves",
        legs="Volte Hose",
        feet="Volte Boots",
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        lring={name="Stikini Ring +1", bag="wardrobe2"},
        rring={name="Stikini Ring +1", bag="wardrobe4"},
        back="Alaunus's Cape",
        waist="Chaac Belt",
        }

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC
	
	--------------------------------------
	-- Special sets (required by rules)
	--------------------------------------

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        main="Contemplator +1",
        waist="Shinjutsu-no-Obi +1",
        }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main="Mpaca's Staff",
        sub="Oneiros Grip",
        ammo="Homiliary",
        head="Chironic Hat",
        body="Theo. Bliaut +3",
        hands={ name="Chironic Gloves", augments={'Pet: VIT+12','"Conserve MP"+4','"Refresh"+2','Accuracy+11 Attack+11',}},
        legs="Assid. Pants +1",
        feet={ name="Chironic Slippers", augments={'AGI+1','Rng.Acc.+13','"Refresh"+2','Accuracy+17 Attack+17',}},
        neck="Yngvi Earring",
        ear1="Ethereal Earring",
        ear2="Etiolation Earring",
        lring={name="Stikini Ring +1", bag="wardrobe4"},
        rring={name="Stikini Ring +1", bag="wardrobe2"},
        back="Moonbeam Cape",
        waist="Fucho-no-Obi",
        }

    sets.idle.DT = set_combine(sets.idle, {
        main="Malignance Pole",
        sub="Oneiros Grip", --10/0
        ammo="Staunch Tathlum +1", --3/3
        head="Bunzi's Hat", --3/3
        hands={ name="Chironic Gloves", augments={'Pet: VIT+12','"Conserve MP"+4','"Refresh"+2','Accuracy+11 Attack+11',}}, --4/3
        neck="Loricate Torque +1", --6/6
        ear1="Eabani Earring", --2/0
        lring={name="Stikini Ring +1", bag="wardrobe2"}, --7/(-1)
        rring="Defending Ring", --10/10
        back="Moonbeam Cape", --6/6
        waist="Flume Belt", --0/3
        })

    sets.idle.MEva = set_combine(sets.idle.DT, {
        ammo="Homiliary",
        head="Inyanga Tiara +2",
		neck="Warder's Charm +1",
		body="Inyanga Jubbah +2",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Inyanga Crackows +2",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
		rring="Defending Ring",
        lring="Shadow Ring",
        back="Moonbeam Cape",
		waist="Carrier's Sash",
        })
		
	sets.idle.AOE_Reraise = set_combine(sets.idle.DT, {
		body="Annointed Kalasiris",
		})	
		
	sets.latent_refresh = {waist="Fucho-no-obi"}


    sets.idle.Town = set_combine(sets.idle, {
        main="Maxentius",
        sub="Genmei Shield",
        head="Kaykaus Mitra +1",
		body="Councilor's Garb",
        hands="Kaykaus Cuffs +1",
        legs="Piety Pantaln. +3",
        neck="Debilis Medallion +1",
        ear1="Regal Earring",
        ear2="Glorious Earring",
        })

    sets.idle.Weak = sets.idle.DT

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Volte Boots",
        neck="Combatant's Torque",
        ear1="Telos Earring",
        ear2="Cessance Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        back="Relucent Cape",
        waist="Grunfeld Rope",
        }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back="Mending Cape"}
    sets.buff['Devotion'] = {head="Piety Cap +3"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        lring="Eshmun's Ring", --20
        rring="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spell.name == 'Shellra V' then
            equip(sets.midcast.ShellraV)
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            --send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
--      if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
--          return "CureMelee"
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Yagrush" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
    end

    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end