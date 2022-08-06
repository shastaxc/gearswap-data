-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F7 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+Q ]           Temper
--              [ ALT+W ]           Flurry II
--              [ ALT+E ]           Haste II
--              [ ALT+R ]           Refresh II
--              [ ALT+Y ]           Phalanx
--              [ ALT+O ]           Regen II
--              [ ALT+P ]           Shock Spikes
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad1 ]    Sanguine Blade
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                  Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
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

    state.CP = M(false, "Capacity Points Mode")
    state.Buff.Saboteur = buffactive.Saboteur or false

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence'}
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}
    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}
		
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Emporox's Ring", "Facility Ring", "Capacity Ring", "Endorsement Ring"}

    lockstyleset = 20
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'AOE_Reraise')
	state.WeaponSet = M{['description']='Weapon Set', 'CroceaDark', 'CroceaLight', 'Almace', 'Naegling', 'Tauret', 'Idle'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}	
    state.CP = M(false, "Capacity Points Mode")
    state.RingLock = M(false, 'Ring Lock')
    state.EnspellMode = M(false, 'Enspell Melee Mode')
    state.NM = M(false, 'NM?')	

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line
    include('Global-GEO-Binds.lua') -- OK to remove this line
	include('Mote-TreasureHunter')
	
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    end

    send_command('lua l gearinfo')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')
	send_command('bind @s gs c cycle SleepMode')
    send_command('bind @e gs c cycle EnspellMode')
    send_command('bind @d gs c toggle NM')
    send_command('bind @t gs c cycle treasuremode')	
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')	
    send_command('bind !` gs c toggle MagicBurst')	

    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad9 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad4 input /ws "Requiescat" <t>')
    send_command('bind ^numpad1 input /ws "Sanguine Blade" <t>')
    send_command('bind ^numpad2 input /ws "Red Lotus Blade" <t>')
    send_command('bind ^numpad3 input /ws "Flat Blade" <t>')

    select_default_macro_book()
    lockstyleset = 20

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

-- Called when this job file is unloaded (eg: job change)
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
    send_command('unbind !q')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind @r')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
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
	
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
    send_command('lua u gearinfo')
    end
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}

    -- Fast cast sets for spells

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    Traits --30
        ammo="Sapience Orb", --2
        head="Atrophy Chapeau +2", --16
		waist="Shinjutsu-no-Obi +1",
        legs="Aya. Cosciales +2", --6
        feet="Carmine Greaves +1", --8
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Weather. Ring +1", --5
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
        back="Perimede Cape", --(4)
        })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Stikini Ring +1"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        ring1="Lebeche Ring",
		ring2= "Weatherspoon Ring +1",
        back="Perimede Cape",
        waist="Obstinate Sash",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Shukuyu Ring",
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        neck="Combatant's Torque",
        ear2="Mache Earring +1",
        ring1="Ramuh Ring +1",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb",
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Nyame Gauntlets",
        legs="Zoar Subligar +1",
        feet="Nyame Sollerets",
        ear1="Sherida Earring",
		ear2="Mache Earring +1",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
        })

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Dls. Torque +1",
        ear2="Regal Earring",
        waist="Sailfi Belt +1",
		ring2="Metamor. Ring +1",
        })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck="Combatant's Torque",
        ear2="Regal Earring",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Death Blossom'].Acc = sets.precast.WS['Savage Blade'].Acc

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Regal Gem",
        ear2="Sherida Earring",
        })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        neck="Combatant's Torque",
        ear1="Mache Earring +1",
        ring1="Rufescent Ring",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Malignance Earring",
        ring1="Freke Ring",
        ring2="Archon Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Sacro Cord",
        }
		
	sets.precast.WS['Seraph Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Epaminondas's Ring",
        ring2="Weatherspoon Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Sacro Cord",
        }	

	sets.precast.WS['Aeolian Edge'] = {
        ammo="Ghastly Tathlum +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Weatherspoon Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Sacro Cord",
        }			
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Impatiens", --10
        legs="Carmine Cuisses +1", --20
        ring1="Evanescence Ring", --5
        waist="Obstinate Sash", --10
        }

    sets.midcast.Cure = {
        main="Tamaxchi", --22/(-10)
        sub="Sors Shield", --3/(-5)
        ammo="Impatiens", --0/(-5)
        head="Kaykaus Mitra +1", --11(+2)/(-6)
        body="Kaykaus Bliaut +1", --(+3)/(-6)
        hands="Kaykaus Cuffs +1", --11(+2)/(-6)
        legs="Atrophy Tights +3", --12
        feet="Vanya Clogs", --11(+2)/(-12)
        neck="Incanter's Torque",
        ear1="Malignance Earring", --5
        ear2="Mendi. Earring", --5
        ring1="Haoma's Ring", --3/(-5)
        ring2="Menelaus's Ring",
        back="Tempered Cape +1", --(-10)
        waist="Bishop's Sash",
        }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",
        sub="Enki Strap", --0/(-4)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        hands="Buremte Gloves", -- (13)
        neck="Phalaina Locket", -- 4(4)
        ring2="Asklepian Ring", -- (3)
        waist="Gishdubar Sash", -- (10)
        })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ammo="Regal Gem",
        ring1="Metamor. Ring +1",
        ring2="Stikini Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.StatusRemoval = {
        head="Atro. Chapeau +2",
        body="Viti. Tabard +3",
        legs="Atrophy Tights +3",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Healing Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back="Tempered Cape +1",
        waist="Witful Belt",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        hands="Hieros Mittens",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        back="Oretan. Cape +1",
        })

    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head="Telchine Cap",
        body="Viti. Tabard +3",
        hands="Atrophy Gloves +3",
        legs="Telchine Braconi",
        feet="Leth. Houseaux +1",
        neck="Dls. Torque +1",
        ear1="Augment. Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back="Ghostfyre Cape",
        waist="Embla Sash",
        }

    sets.midcast.EnhancingDuration = {
        sub="Ammurapi Shield",
        head="Leth. Chappel +1",
		neck="Dls. Torque +1",
        body="Viti. Tabard +3",
        hands="Atrophy Gloves +3",
        legs="Leth. Fuseau +1",
        feet="Leth. Houseaux +1",
        back="Ghostfyre Cape",
		waist="Embla Sash",
        }

    sets.midcast.EnhancingSkill = {
        main="Pukulatmuj",
        sub="Pukulatmuj +1",
        hands="Viti. Gloves +3",
        }

    sets.midcast.GainSpell = {
        hands="Viti. Gloves +3",
        }


    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        body="Telchine Chas.",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1", -- +1
        body="Atrophy Tabard +3", -- +3
		waist="Gishdubar Sash",
        legs="Leth. Fuseau +1", -- +2
        })

    sets.midcast.RefreshSelf = {
        waist="Gishdubar Sash",
        back="Grapevine Cape"
        }

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        body=gear.Taeon_Phalanx_body, --3(10)
        hands=gear.Taeon_Phalanx_hands, --3(10)
        legs=gear.Taeon_Phalanx_legs, --3(10)
        feet=gear.Taeon_Phalanx_feet, --3(10)
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
		hands="Regal Cuffs",
        })

    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

     -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Bunzi's Rod",
		ammo="Regal Gem",
        head="Viti. Chapeau +3",
        body="Lethargy Sayon +1",
        hands="Regal Cuffs",
        legs="Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ear1="Regal Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Obstin. Sash",
		sub="Ammurapi Shield",
		}
		
    sets.midcast.MndEnfeebles.Resistant = {
        main="Bunzi's Rod",
		ammo="Regal Gem",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Regal Cuffs",
        legs="Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ear1="Regal Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Obstin. Sash",
		sub="Ammurapi Shield",
		}		

    sets.midcast.MndEnfeeblesAcc = sets.midcast.MndEnfeebles

    sets.midcast.IntEnfeebles = {
        main="Bunzi's Rod",
		range="Ullr",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Regal Cuffs",
        legs="Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        ring1="Freke Ring",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Acuity Belt +1",
		sub="Ammurapi Shield",
        }

    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {
        body="Atrophy Tabard +3",
        ring2="Metamor. Ring +1",
		ring1="Weatherspoon Ring +1",
        })

    sets.midcast.SkillEnfeebles = {
		main="Contemplator +1",
		sub="Mephitis Grip",
		range="Ullr",
        head="Viti. Chapeau +3",
        body="Lethargy Sayon +1",
        hands="Kaykaus Cuffs +1",
		legs= "Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        ear1="Vor Earring",
		ear2="Snotra Earring",
        waist="Obstinate Sash",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
		}
		
    sets.midcast.SkillEnfeebles.Resistant = {
		range="Ullr",
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Kaykaus Cuffs +1",
		legs= "Chironic Hose",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        ear1="Vor Earring",
		ear2="Snotra Earring",
        waist="Obstinate Sash",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
		}		
			
	sets.midcast.Dispelga = {
		main="Daybreak",
		sub="Ammurapi Shield",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Kaykaus Cuffs +1",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ring1="Metamor. Ring",
        ring2="Stikini Ring +1",
        ear1="Regal Earring",
        waist="Obstinate Sash",
		}

    sets.midcast.EffectEnfeebles = {
		head="Viti. Chapeau +3",
        ammo="Regal Gem",
        body="Lethargy Sayon +1",
        feet="Vitiation Boots +3",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        }

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles



    sets.midcast['Dark Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Atrophy Chapeau +2",
        body="Atrophy Tabard +3",
        hands="Kaykaus Cuffs +1",
        legs="Bunzi's Pants",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Malignance Earring",
        ring1="Metamor. Ring",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        feet="Bunzi's Sabots",
        ear1="Hirudinea Earring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
        })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {waist="Luminary Sash"})

    sets.midcast['Elemental Magic'] = {
        main="Raetic Staff +1",
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Atro. Chapeau +2",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet="Bunzi's Sabots",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Shiva Ring +1",
        ring2="Freke Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Acuity Belt +1",
        }

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        main="Mpaca's Staff",
        sub="Enki Strap",
        body="Seidr Cotehardie",
        legs="Amalric Slops +1",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        })
		
    sets.midcast['Elemental Magic'].Burst = set_combine(sets.midcast['Elemental Magic'], {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
        body="Bunzi's Robe",
		hands= "Amalric Gages +1",
        legs="Bunzi's Pants",
        feet="Bunzi's Sabots",
        neck="Mizu. Kubikazari",
		ring1="Mujin Band",
		
		
        })		

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Mpaca's Staff",
        sub="Enki Strap",
        legs="Amalric Slops +1",
        feet="Bunzi's Sabots",
        neck="Erra Pendant",
        ear1="Hermetic Earring",
        waist="Acuity Belt +1",
        })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        main="Mpaca's Staff",
        sub="Enki Strap",
		range="Ullr",
        head=empty,
        body="Twilight Cloak",
        ring1="Archon Ring",
        })

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Job-specific buff sets
    sets.buff.ComposureOther = {
        head="Leth. Chappel +1",
        body="Lethargy Sayon +1",
        hands="Leth. Gantherots +1",
        legs="Leth. Fuseau +1",
        feet="Leth. Houseaux +1",
        }

    sets.buff.Saboteur = {hands="Leth. Gantherots +1"}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Mpaca's Staff",
        sub="Oneiros Grip",
        ammo="Homiliary",
        head="Viti. Chapeau +3",
        body="Jhakri Robe +2",
        hands={ name="Chironic Gloves", augments={'Pet: VIT+12','"Conserve MP"+4','"Refresh"+2','Accuracy+11 Attack+11',}},
        legs="Lengo Pants",
        feet={ name="Merlinic Crackows", augments={'Phys. dmg. taken -2%','Enmity-2','"Refresh"+2','Accuracy+5 Attack+5',}},
        neck="Yngvi Choker",
        ear1="Etiolation Earring",
        ear2="Ethereal Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back="Moonbeam Cape",
        waist="Fucho-no-obi",
        }

    sets.idle.DT = set_combine(sets.idle, {
        main="Bolelabunga",
        sub="Genmei Shield", --10/0
        ammo="Staunch Tathlum +1", --3/3
        head="Viti. Chapeau +3",
        body="Nyame Mail", --6/6
        hands="Nyame Gauntlets", --4/3
		legs="Nyame Flanchard", -- 9
        feet="Nyame Sollerets",
        neck="Loricate Torque +1", --6/6
        ring1="Stikini Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Moonbeam Cape", --6/6
        waist="Flume Belt", --0/3
        })
		
	sets.idle.AOE_Reraise = set_combine(sets.idle.DT, {
		body="Annointed Kalasiris",
		})		

    sets.idle.Town = set_combine(sets.idle, {
		main="Excalibur",
		sub="Sacro Bulwark",
        ammo="Regal Gem",
        head="Viti. Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Viti. Gloves +3",
		legs="Atrophy Tights +3",
        feet="Vitiation Boots +3",
        neck="Dls. Torque +1",
        ear1="Regal Earring",
        ear2="Vor Earring",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}},
        waist="Obstin. Sash",
        })

    sets.idle.Weak = sets.idle.DT

    sets.resting = set_combine(sets.idle, {
        main="Contemplator +1",
        waist="Shinjutsu-no-Obi +1",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.magic_burst = {
        main="Raetic Staff +1", --5
        body="Bunzi's Robe", --10
        hands="Amalric Gages +1", --5(5)
        feet="Bunzi's Sabots", --11
        neck="Mizu. Kubikazari", --10
        ring1="Mujin Band", --(5)
        }

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Aya. Manopolas +2",
        legs="Malignance Tights",
        feet="Volte Spats",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},
        waist="Sailfi Belt +1",
		ammo="Aurgelmir Orb",
        }

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        neck="Combatant's Torque",
        waist="Kentarch Belt +1",
        ring2="Chirich Ring +1",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1",
        ear1="Cessance Earring",
        ear2="Mache Earring +1",
        ring1="Chirich Ring +1",
        waist="Grunfeld Rope",
        })

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Bunzi's Gloves",
        legs="Carmine Cuisses +1", --6
        feet="Volte Spats", --9
        neck="Anu Torque",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --10
        waist="Reiki Yotai", --7
		ammo="Aurgelmir Orb",
        } --41

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        neck="Combatant's Torque",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        head="Carmine Mask +1",
        ear1="Telos Earring",
        ear2="Mache Earring +1",
        ring1="Chirich Ring +1",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Aya. Manopolas +2",
        legs="Carmine Cuisses +1", --6
        feet="Volte Spats", --9
        neck="Anu Torque",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --10
        waist="Reiki Yotai", --7
		ammo="Aurgelmir Orb",
        }) --41

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        neck="Combatant's Torque",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        head="Carmine Mask +1",
        ear1="Cessance Earring",
        ear2="Mache Earring +1",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Aya. Manopolas +2",
        legs="Malignance Tights",
        feet="Volte Spats", --9
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --10
        waist="Reiki Yotai", --7
		ammo="Aurgelmir Orb",
        }) --41

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        legs="Carmine Cuisses +1", --6
        neck="Combatant's Torque",
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        head="Carmine Mask +1",
        ear1="Telos Earring",
        ear2="Mache Earring +1",
        ring1="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Aya. Manopolas +2",
        legs="Malignance Tights",
        feet="Volte Spats", --9
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --10
        waist="Reiki Yotai", --7
		ammo="Aurgelmir Orb",
        }) --26

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        legs="Carmine Cuisses +1", --6
        neck="Combatant's Torque",
        ring2="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        head="Carmine Mask +1",
        ear1="Cessance Earring",
        ear2="Mache Earring +1",
        ring1={name="Chirich Ring +1", bag="wardrobe1"},
        ring2={name="Chirich Ring +1", bag="wardrobe2"},
        waist="Kentarch Belt +1",
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        body="Bunzi's Robe",
        hands="Aya. Manopolas +2",
        legs="Malignance Tights",
        feet="Carmine Greaves +1",
        neck="Anu Torque",
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        ring1="Chirich Ring +1",
        ring2="Ilabrat Ring",
        back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}, --10
        waist="Sailfi Belt +1",
		ammo="Aurgelmir Orb",
        }) --10

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        neck="Combatant's Torque",
        ring2="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1", --6
        ear1="Cessance Earring",
        ear2="Mache Earring +1",
        ring1="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Malignance Chapeau",
        neck="Loricate Torque +1", --6/6
		hands="Nyame Gauntlets",
		body="Nyame Mail",
		legs="Malignance Tights",
		feet="Nyame Sollerets",
		ring1="Moonbeam Ring",
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe2"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.TreasureHunter = {head="Volte Cap", legs="Volte Hose", feet="Volte Boots", waist="Chaac Belt"}

    sets.CroceaDark = {main="Vitiation Sword", sub="Ternion Dagger +1"}
    sets.CroceaLight = {main="Vitiation Sword", sub="Daybreak"}
    sets.Almace = {main="Almace", sub="Ternion Dagger +1"}
    sets.Naegling = {main="Naegling", sub="Ternion Dagger +1"}
    sets.Tauret = {main="Tauret", sub="Ternion Dagger +1"}
    sets.Idle = {main="Daybreak", sub="Sacro Bulwark"}

    sets.engaged.Enspell = {
        hands="Aya. Manopolas +2",
        neck="Dls. Torque +1",
        waist="Sacro Cord",
        }

    sets.engaged.Enspell.Fencer = {ring1="Fencer's Ring"}	

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
              end
            end
        elseif skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Sacro Cord"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Sacro Cord"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Sleep') and not spell.interrupted then
        set_sleep_timer(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
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
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
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
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                return "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "MndEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "MndEnfeeblesEffect"
                else
                    return "MndEnfeebles"
              end
            elseif spell.type == "BlackMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "IntEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "IntEnfeeblesEffect"
                elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    return "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    return "Sleep"
                else
                    return "IntEnfeebles"
                end
            else
                return "MndEnfeebles"
            end
        end
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell)
    end
    if state.EnspellMode.value == true and player.hpp <= 75 and player.tp < 1000 then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell.Fencer)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)


    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 14 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 15 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 26 and DW_needed <= 32 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 32 and DW_needed <= 43 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 43 then
            classes.CustomMeleeGroups:append('')
        end
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    end

    gearinfo(cmdParams, eventArgs)
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

function set_sleep_timer(spell)
    local self = windower.ffxi.get_player()

    if spell.en == "Sleep II" then
        base = 90
    elseif spell.en == "Sleep" or spell.en == "Sleepga" then
        base = 60
    end

    if state.Buff.Saboteur then
        if state.NM.value then
            base = base * 1.25
        else
            base = base * 2
        end
    end

    -- Merit Points Duration Bonus
    base = base + self.merits.enfeebling_magic_duration*6

    -- Relic Head Duration Bonus
    if not ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        base = base + self.merits.enfeebling_magic_duration*3
    end

    -- Job Points Duration Bonus
    base = base + self.job_points.rdm.enfeebling_magic_duration

    --Enfeebling duration non-augmented gear total
    gear_mult = 1.40
    --Enfeebling duration augmented gear total
    aug_mult = 1.25
    --Estoquer/Lethargy Composure set bonus
    --2pc = 1.1 / 3pc = 1.2 / 4pc = 1.35 / 5pc = 1.5
    empy_mult = 1 --from sets.midcast.Sleep

    if ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        if buffactive.Stymie then
            base = base + self.job_points.rdm.stymie_effect
        end
        empy_mult = 1.35 --from sets.midcast.SleepMaxDuration
    end

    totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)

    -- Create the custom timer
    if spell.english == "Sleep II" then
        send_command('@timers c "Sleep II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then
        send_command('@timers c "Sleep ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00253.png')
    end
    add_to_chat(1, 'Base: ' ..base.. ' Merits: ' ..self.merits.enfeebling_magic_duration.. ' Job Points: ' ..self.job_points.rdm.stymie_effect.. ' Set Bonus: ' ..empy_mult)

end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
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

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
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
    set_macro_page(1, 10)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end