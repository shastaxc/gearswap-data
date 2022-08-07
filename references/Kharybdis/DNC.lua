-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+F ]           Toggle Closed Position (Facing) Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Primary step element cycle forward.
--              [ CTRL+= ]          Primary step element cycle backward.
--              [ ALT+- ]           Secondary step element cycle forward.
--              [ ALT+= ]           Secondary step element cycle backward.
--              [ CTRL+[ ]          Toggle step target type.
--              [ CTRL+] ]          Toggle use secondary step.
--              [ Numpad0 ]         Perform Current Step
--
--              [ CTRL+` ]          Saber Dance
--              [ ALT+` ]           Chocobo Jig II
--              [ ALT+[ ]           Contradance
--              [ CTRL+Numlock ]    Reverse Flourish
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--              [ CTRL+Numpad+ ]    Climactic Flourish
--              [ CTRL+NumpadEnter ]Building Flourish
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Exenterator
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad6 ]    Pyrrhic Kleos
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c step                       Uses the currently configured step on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c step t                     Uses the currently configured step on the target, but forces use of <t>.
--
--  gs c cycle mainstep             Cycles through the available steps to use as the primary step when using
--                                  one of the above commands.
--  gs c cycle altstep              Cycles through the available steps to use for alternating with the
--                                  configured main step.
--  gs c toggle usealtstep          Toggles whether or not to use an alternate step.
--  gs c toggle selectsteptarget    Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.


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
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')

    state.ClosedPosition = M(false, 'Closed Position')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')

    state.CP = M(false, "Capacity Points Mode")

    no_swap_gear = S{"Warp Ring", "Emporox's Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Endorsement Ring"}
			  
    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'Crit', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Atk')
    state.IdleMode:options('Normal', 'DT')

    send_command('bind ^numpad7 input /ws "Exenterator" <t>')
    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^numpad6 input /ws "Pyrrhic Kleos" <t>')
    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')
	send_command('unbind ^-')
    send_command('unbind ^=')



    select_default_macro_book()
    set_lockstyle()

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
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ![')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpadenter')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind numpad0')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')

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

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity set
    sets.Enmity = {
        ammo="Sapience Orb", --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9
        feet="Ahosi Leggings", --7
        neck="Unmoving Collar +1", --10
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        lring="Supershear Ring", --5
        rring="Eihwaz Ring", --5
        waist="Kasiri Belt", --3
        }

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}
    sets.precast.JA['Trance'] = {head="Horos Tiara +3"}

    sets.precast.Waltz = {
        ammo="Yamarang", --5
        head="Horos Tiara +3",
        body="Maxixi Casaque +3", --19(8)
        hands="Maxixi Bangles +3",
        legs="Desultor Tassets", --10
        feet="Maxixi Toeshoes +2", --14
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Handler's Earring",
        lring="Carb. Ring +1",
        rring="Carb. Ring +1",
        back="Toetapper Mantle", --10
        waist="Aristo Belt",
        } -- Waltz Potency/CHR

    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
        head="Mummu Bonnet +2", --8
        lring="Asklepian Ring", --3
        }) -- Waltz effects received

    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Samba = {head="Maxixi Tiara +2", back="Toetapper Mantle"}
    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toeshoes +2"}

    sets.precast.Step = {
        ammo="Yamarang",
        head="Maxixi Tiara +2",
        body="Maxixi Casaque +3",
        hands="Maxixi Bangles +3",
        legs="Mummu Kecks +2",
        feet="Horos T. Shoes +3",
        neck="Sanctity Necklace",
        ear1="Telos Earring",
        ear2="Digni. Earring",
        lring="Chirich Ring +1",
        rring="Patricius Ring",
        waist="Kentarch Belt +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        }

    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Macu. Toeshoes +1"})
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

    sets.precast.Flourish1['Violent Flourish'] = {
        ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Horos Casaque +3",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +1",
        neck="Sanctity Necklace",
        ear1="Digni. Earring",
        ear2="Gwati Earring",
        lring="Metamor. Ring +1",
        rring="Stikini Ring +1",
        waist="Eschan Stone",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        } -- Magic Accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
        ammo="Per. Lucky Egg",
        head="Maxixi Tiara +2",
        body="Maxixi Casaque +3",
        hands="Maxixi Bangles +3",
        legs="Maxixi Tights +2",
        feet="Horos Toeshoes +3",
        neck="Sanctity Necklace",
        ear1="Digni. Earring",
        ear2="Mache Earring +1",
        lring="Chirich Ring +1",
        rring="Regal Ring",
        back="Toeshoes Mantle",
		waist="Chaac Belt",
        } -- Accuracy

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +1",    back="Toetapper Mantle"}
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1",}

    sets.precast.FC = {
        ammo="Impatiens",
        head="Herculean Helm", --7
        body="Samnuha Coat", --8
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet="Taeon Boots", --2
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Etiolation Earring +1", --2
        rring="Weather. Ring +1", --6(4)
        }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        body="Passion Jacket",
        lring="Lebeche Ring",
        })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS['Exenterator'] ={
        ammo="Charis Feather",
        head="Mummu Bonnet +2",
		neck="Fotia Gorget",
        body="Horos Casaque +3",
		hands="Maxixi Bangles +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ear1="Sherida Earring",
        ear2="Ishvara Earring",
		lring="Epaminondas's Ring",
        rring="Regal Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        }

    sets.precast.WS['Pyrrhic Kleos'] ={
        ammo="Focal Orb",
        head="Lustratio Cap +1",
		neck="Fotia Gorget",
        body="Horos Casaque +3",
        hands="Adhemar Wristbands +1",
        legs="Samnuha Tights",
        feet="Lustratio Leggings +1",
        ear1="Ishvara Earring",
        ear2="Mache Earring +1",
		lring="Regal Ring",
        rring="Epaminondas Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        }

    sets.precast.WS['Evisceration'] ={
        ammo="Charis Feather",
        head="Blistering Sallet +1",
		neck="Fotia Gorget",
        body="Meg. Cuirie +2",
        hands="Mummu Wrists +2",
        legs="Lustr. Subligar +1",
        feet="Mummu Kecks +2",
        ear1="Mache Earring +1",
		ear2="Ishvara Earring",
        lring="Regal Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        }

    sets.precast.WS['Rudra\'s Storm'] ={
        ammo="Charis Feather",
        head="Blistering Sallet +1",
		neck="Etoile Gorget +1",
        body="Nyame Mail",
		waist="Grunfeld Rope",
        hands="Maxixi Bangles +3",
        legs="Horos Tights +3",
        feet="Lustr. Leggings +1",
        ear1="Sherida Earring",
		ear2="Moonshade Earring",
		lring="Epaminondas's Ring",
        rring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
        }
		
    sets.precast.WS['Rudra\'s Storm'].Atk ={
        ammo="Charis Feather",
        head="Gleti's Mask",
		neck="Etoile Gorget +1",
        body="Nyame Mail",
		waist="Grunfeld Rope",
        hands="Gleti's Gauntlets",
        legs="Gleti's Greaves",
        feet="Gleti's Boots",
        ear1="Sherida Earring",
		ear2="Moonshade Earring",
		lring="Epaminondas's Ring",
        rring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
        }		

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Pemphredo Tathlum",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Baetyl Pendant",
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        lring="Shiva Ring +1",
        rring="Shiva Ring +1",
        back="Sacro Mantle",
        waist="Eschan Stone",
        }
		
    sets.precast.WS['Asuran Fists'] = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','Weapon skill damage +2%','STR+10','Attack+7',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Shiukuyu Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}		
		
    sets.precast.WS['Raging Fists'] = {
		ammo="Charis Feather",
		head="Nyame Helm",
		body="Nymae Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
}			

    sets.precast.Skillchain = {
        hands="Macu. Bangles +1",
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Impatiens", --10
        lring="Evanescence Ring", --5
        }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Gleti's Mask",
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Bathy Choker +1",
        ear1="Ethereal Earring",
        ear2="Etiolation Earring",
        lring="Chirich Ring +1",
        rring="Defending Ring",
        back="Shadow Mantle",
        waist="Flume Belt",
        }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head="Nyame Helm",
		body="Ashera Harness",
        hands="Nyame Gauntlets", --7/5
        legs="Nyame Flanchard", --5/5
        feet="Nyame Sollerets",
        neck="Loricate Torque +1", --6/6
        ear1="Ethereal Earring", --2/0
        ear2="Etiolation Earring", --0/3
        lring="Shadow Ring", --7/(-1)
        rring="Defending Ring", --10/10
        back="Shadow Mantle", --6/6
        waist="Flume Belt", --4/0
        })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Councilor's Garb",
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        neck="Etoile Gorget +1",
        ear1="Telos Earring",
        ear2="Cessance Earring",
        lring="Ilabrat Ring",
        rring="Regal Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.idle.Weak = set_combine(sets.idle.DT, {
        ammo="Staunch Tathlum +1 +1", --3/3
        head="Nyame Helm",
        hands="Nyame Gauntlets", --7/5
        legs="Nyame Flanchard", --5/5
        feet="Nyame Sollerets",
        neck="Loricate Torque +1", --6/6
        ear1="Ethereal Earring", --2/0
        ear2="Etiolation Earring", --0/3
        lring="Moonbeam Ring", --7/(-1)
        rring="Defending Ring", --10/10
        back="Shadow Mantle", --6/6
        waist="Flume Belt", --4/0
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {
        feet="Tandava Crackows",
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet="Horos T. Shoes +3",
        neck="Etoile Gorget +1",
        ear1="Telos Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Epona's Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        }

    sets.engaged.Crit = set_combine(sets.engaged, {
        ammo="Charis Feather",
        head="Adhemar Bonnet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.Crit, {
        ammo="Yamarang",
		head="Horos Tiara +3",
        ear2="Mache Earring +1",
        lring="Chirich Ring +1",
        rring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        lring="Chirich Ring +1",
        waist="Kentarch Belt +1",
		ear2="Mache Earring +1",
        })

    sets.engaged.STP = set_combine(sets.engaged, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
		legs="Malignance Tights",
        })

    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Macu. Casaque +1", --11
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet="Taeon Boots", --9
        neck="Charis Necklace", --5
        ear1="Ebani Earring", --4
        ear2="Suppanomimi", --5
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        waist="Reiki Yotai", --7
        } -- 41%

    sets.engaged.DW.Crit = set_combine(sets.engaged.DW, {
        ammo="Charis Feather",
        head="Blistering Sallet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.Crit, {
        head="Maxixi Tiara +2", --8
        body="Maxixi Casaque +3",
        lring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
		legs="Malignance Tights",
        })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Maculele Casaque +1", --11
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        neck="Etoile Gorget +1", --5
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Occ. inc. resist. to stat. ailments+10',}},
        waist="Reiki Yotai", --7
        } -- 32%

    sets.engaged.DW.Crit.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        ammo="Charis Feather",
        head="Blistering Sallet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.Crit.LowHaste, {
        head="Maxixi Tiara +2", --8
        body="Maxixi Casaque +3",
        lring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        lring="Begrudging Ring",
        rring="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
        })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1", --6
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        neck="Etoile Gorget +1",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Reiki Yotai", --7
        } -- 22%

    sets.engaged.DW.Crit.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        ammo="Charis Feather",
        head="Blistering Sallet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.Crit.MidHaste, {
        head="Maxixi Tiara +2", --8
        body="Maxixi Casaque +3",
        lring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        body="Maxixi Casaque +3",
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
		legs="Malignance Tights",
        })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1", --6
        hands="Adhemar Wristbands +1",
        legs="Zoar Subligar +1",
        feet="Mummu Gamash. +2",
        neck="Etoile Gorget +1",
        ear1="Eabani Earring", --4
        ear2="Sherida Earring",
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
      } -- 10% Gear

    sets.engaged.DW.Crit.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        ammo="Charis Feather",
        head="Blistering Sallet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.Crit.HighHaste, {
        head="Horos Tiara +3",
		body="Maxixi Casaque +3",
        lring="Regal Ring",
        })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        head="Maxixi Tiara +2", --8
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        lring="Chirich Ring +1",
        rring="Chirich Ring +1",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
		legs="Malignance Tights",
        })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Malignance Tights",
        feet="Mummu Gamash. +2",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Chirich Ring +1",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        } -- 0%

    sets.engaged.DW.Crit.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ammo="Charis Feather",
        head="Blistering Sallet +1",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands +1",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        neck="Etoile Gorget +1",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        lring="Hetairoi Ring",
        rring="Mummu Ring",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        waist="Sailfi Belt +1",
        })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.Crit.MaxHaste, {
        head="Horos Tiara +3",
		body="Meg. Cuirie +2",
        ear1="Cessance Earring",
        rring="Begrudging Ring",
        })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head="Maxixi Tiara +2", --8
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','"Triple Atk."+4','DEX+10','Attack+9',}},
        ear2="Telos Earring",
        lring="Chirich Ring +1",
        rring="Regal Ring",
        waist="Kentarch Belt +1",
        })

    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
		body="Ashera Harness",
        ear2="Cessance Earring",
		ear1="Sherida Earring",
        lring="Petrov Ring",
        waist="Kentarch Belt +1",
		legs="Malignance Tights",
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head="Nyame Helm", --7/0
		body="Ashera Harness",
		hands="Nyame Gauntlets",  --7
        legs="Nyame Flanchard", -- 9
		feet="Nyame Sollerets", --7
        lring="Moonbeam ring", --5/5
        rring="Moonbeam ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Crit.DT = set_combine(sets.engaged.Crit, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Crit.DT = set_combine(sets.engaged.DW.Crit, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Crit.DT.LowHaste = set_combine(sets.engaged.DW.Crit.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Crit.DT.MidHaste = set_combine(sets.engaged.DW.Crit.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Crit.DT.HighHaste = set_combine(sets.engaged.DW.Crit.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Crit.DT.MaxHaste = set_combine(sets.engaged.DW.Crit.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
	sets.buff['Fan Dance'] = {hands="Horos Bangles +1"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1", body="Meg. Cuirie +2"}
    sets.buff['Closed Position'] = {feet="Horos T. Shoes +2"}

    sets.buff.Doom = {lring="Eshmun's Ring", rring="Eshmun's Ring", waist="Gishdubar Sash"}
    sets.CP = {back="Mecisto. Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}




    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff['Saber Dance'] = {legs="Horos Tights +3"}
    sets.buff['Fan Dance'] = {body="Horos Bangles +1"}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1", body="Meg. Cuirie +2"}
    sets.buff['Closed Position'] = {feet="Horos T. Shoes +2"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe2"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist="Gishdubar Sash", --10
        }

    sets.CP = {back="Mecisto. Mantle"}
    sets.Reive = {neck="Ygnas's Resolve +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
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

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    --if state.Buff['Climactic Flourish'] then
    --    meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    --end
    if state.ClosedPosition.value == true then
        meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
    end

    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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

    local s_msg = state.MainStep.current
    if state.UseAltStep.value == true then
        s_msg = s_msg .. '/'..state.AltStep.current
    end

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 9 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 9 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 39 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 39 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end

        send_command('@input /ja "'..doStep..'" <t>')
    end

    gearinfo(cmdParams, eventArgs)
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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        --local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 then --and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
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
    -- Default macro set/book: (set, book)
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'RUN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 2)
    else
        set_macro_page(1, 2)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end