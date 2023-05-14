-- File Status: Barely started on this.

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
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
--              [ ALT+[ ]           Accession/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+Q ]           Temper
--              [ ALT+W ]           Flurry II
--              [ ALT+E ]           Equip Engaged Gear
--              [ ALT+R ]           Equip Idle Gear
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
    mote_include_version = 2 --DO NOT MOVE TO GLOBALS. MUST BE HERE.

    -- Load and initialize the include file.
    include('Mote-Include.lua') --DO NOT MOVE TO GLOBALS. MUST BE HERE.
    include('reorganizer-lib.lua')
    coroutine.schedule(function()
        send_command('gs reorg')
    end, 1)
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    silibs.enable_cancel_outranged_ws()
    silibs.enable_auto_lockstyle(1)
    silibs.enable_premade_commands()
    silibs.enable_custom_roll_text()
    silibs.enable_equip_loop()
    silibs.enable_weapon_rearm()
    silibs.enable_th()

    -- state.CP = M(false, "Capacity Points Mode")
    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence'}
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}
    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}
    auto_min_buffs = false --controls min_buff_set
    auto_max_buffs = false --controls max_buff_set

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

    --Used to pick the best enspell for the current day
    enspell_to_day_element = T{
        ['Firesday']     = {type="ma", buff_id=94  , buff_name="Enfire"},
        ['Lightsday']    = {type="ma", buff_id=94  , buff_name="Enfire"},
        ['Darksday']     = {type="ma", buff_id=94  , buff_name="Enfire"},
        ['Windsday']     = {type="ma", buff_id=96  , buff_name="Enaero"},
        ['Earthsday']    = {type="ma", buff_id=97  , buff_name="Enstone"},
        ['Watersday']    = {type="ma", buff_id=99  , buff_name="Enwater"},
        ['Lightningday'] = {type="ma", buff_id=98  , buff_name="Enthunder"},
        ['Iceday']       = {type="ma", buff_id=95  , buff_name="Enblizzard"},
    }
    
    --Passed to cast_buffs() to automatically buff when desired
    --Format: [i] = {type="ma or ja", buff_id=123, buff_name="haste"}
    min_buff_set = {
        [1] = {type="ma", buff_id=94  , buff_name="Enfire"}, --An enspell must be first entry
        [2] = {type="ja", buff_id=419 , buff_name="Composure"},
        [3] = {type="ma", buff_id=33  , buff_name="Haste II"},
        [4] = {type="ma", buff_id=432 , buff_name="Temper II"},
        [5] = {type="ma", buff_id=43  , buff_name="Refresh III"},
        -- [6] = {type="ma", buff_id=119 , buff_name="Gain-STR"},
    }

    --Format: [i] = {type="ma or ja", buff_id=123, buff_name="haste"}
    max_buff_set = {
        [1]  = {type="ma", buff_id=94  , buff_name="Enfire"}, --An enspell must be first entry
        [2]  = {type="ja", buff_id=419 , buff_name="Composure"},
        [3]  = {type="ma", buff_id=33  , buff_name="Haste II"},
        [4]  = {type="ma", buff_id=432 , buff_name="Temper II"},
        [5]  = {type="ma", buff_id=43  , buff_name="Refresh III"},
        [6]  = {type="ma", buff_id=119 , buff_name="Gain-STR"},
        [7]  = {type="ma", buff_id=104 , buff_name="Barthunder"},
        [8]  = {type="ma", buff_id=108 , buff_name="Barparalyze"},
        [9]  = {type="ma", buff_id=42  , buff_name="Regen II"},
        [10] = {type="ma", buff_id=34  , buff_name="Blaze Spikes"},
        [11] = {type="ma", buff_id=37  , buff_name="Stoneskin"},
        [12] = {type="ma", buff_id=39  , buff_name="Aquaveil"},
        [13] = {type="ma", buff_id=116 , buff_name="Phalanx II"},
    }

    -- set_lockstyle(1,"RDM") --parameter should be the lockstyle set number. Ex: Set017 would be set_lockstyle(17)
    equipRefresh = false
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    silibs.user_setup_hook()
    ----------- Non-silibs content goes below this line -----------
    --state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.OffenseMode:options('Normal', 'MidAcc','HighAcc','Enspell','NoTPEnspell')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'LowDmg', 'Seidr', 'Resistant')
    state.IdleMode:options('FastCast', 'ElementalSpam','Impact','Normal','CP', 'Gyve')
    state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}
    state.PhysicalDefenseMode:options('PDT')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
    state.EnspellMode = M(false, 'Enspell Mode')
    state.NM = M(false, 'NM?')
    -- state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    -- include('Global-Binds.lua') -- OK to remove this line
    -- include('Global-WHM-Binds.lua') -- OK to remove this line

    

    --Do not bind ^` as it's used at the char level for treasure hunter
    --send_command('bind ^` input /ja "Composure" <me>')
    send_command('bind !` gs c toggle MagicBurst')

    if player.sub_job == 'SCH' then
        send_command('bind ^- gs c scholar light')
        send_command('bind ^= gs c scholar dark')
        send_command('bind !- gs c scholar addendum')
        send_command('bind != gs c scholar addendum')
        send_command('bind ^; gs c scholar speed')
        send_command('bind ![ gs c scholar aoe')
        send_command('bind !; gs c scholar cost')
    end

    send_command('bind @s gs c cycle SleepMode')
    send_command('bind @e gs c toggle EnspellMode')
    send_command('bind @d gs c toggle NM')
    send_command('bind @w gs c WeaponLock') --Call function WeaponLock (do not call toggle)

    select_default_macro_book()

    Haste = 0
    
    update_combat_form()
    --Max Tier values: nil = unset. 0 or 1 = tier 1. 
    maxTier = nil
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
    -- send_command('bind !e input /ma "Haste" <stpc>')
    -- send_command('bind !r input /ma "Refresh" <stpc>')
    -- send_command('bind !y input /ma "Phalanx" <me>')
    send_command('unbind !e')
    send_command('unbind !r')
    send_command('unbind !y')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind @s')
    send_command('unbind @e')
    send_command('unbind @d')
    send_command('unbind @w')
    -- send_command('unbind @c')
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

    -- if sets.precast.FC == nil then
    --     sets.precast.FC= {head="nogear"} --Bug when no gear is found.
    -- end

    -- if sets.precast.midcast == nil then
    --     sets.midcast.FC= {head="nogear"} --Bug when no gear is found.
    -- end

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}

    -- Fast cast sets for spells (cap 80% FC).
    -- RDM has 38% FC at 99 full gifts
    sets.precast.FC = {
      head="Atrophy Chapeau +3", --16FC
      body="Vitiation Tabard +3", --15FC
      hands=gear.Nyame_B_hands, --7DT
      legs="Ayanmo Cosciales +2", --6FC
      feet=gear.Nyame_B_feet, --8DT
      neck={name="Unmoving Collar +1",priority=1},
      ear1="Malignance Earring", --4FC
      ear2="Odnowa Earring +1", --3DT, 2MDT
      ring1="Gelatinous Ring +1", --7PDT
      ring2="Weatherspoon Ring", --5FC
      back=gear.RDM_MND_Cape, --10PDT
    } --46FC, 33DT, 17PDT

    sets.precast.FC.QuickMagic = set_combine(sets.precast.FC,{
      ammo="Impatiens", --2%
      ring1="Lebeche Ring", --2%
      back="Perimede Cape", --4%
      waist="Witful Belt", --3%
    }) --10% cap

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
      ammo="Sapience Orb", --2
      head=empty,
      body="Twilight Cloak",
      hands="Gende. Gages +1", --7
      neck="Orunmila's Torque", --5
      ear1="Loquacious Earring", --2
      ear2="Enchntr. Earring +1", --2
      ring1="Kishar Ring", --4
      waist="Shinjutsu-no-Obi +1", --5
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {
      ring2="Stikini Ring +1",
    })
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC.Cure,{})
    sets.precast.Stun = set_combine(sets.midcast.Stun,{}) --Chainspell makes it impossible for midcast to keep up


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
      ammo="Oshasha's Treatise", --3WSD
      head=gear.Nyame_B_head,
      body=gear.Nyame_B_body,
      hands=gear.Nyame_B_hands,
      legs=gear.Nyame_B_legs,
      feet=gear.Nyame_B_feet,
      neck="Fotia Gorget",
      ear1="Ishvara Earring",
      ear2="Moonshade Earring",
      ring1="Rufescent Ring",
      ring2="Epaminondas's Ring",
      back=gear.RDM_WSD_Cape,
      waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        body="Jhakri Robe +2",
        neck="Combatant's Torque",
        ear2="Mache Earring +1",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
        neck="Fotia Gorget",
        body="Ayanmo Corazza +2",
        -- hands="Bunzi's Gloves",
        hands="Ayanmo manopolas +2", --Sub
        legs="Zoar Subligar +1",
        feet="Thereoid Greaves",
        ear2="Sherida Earring",
        ear1="Mache Earring +1",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        waist="Fotia Belt",
        back=gear.RDM_CDC_Cape,
        })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
        ammo="Voluspa Tathlum",
        head="Malignance Chapeau",
        })

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS['Chant du Cygne'],{})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].Acc,{})

    sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'],{})
    sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head = gear.Nyame_B_head,
        body=gear.Nyame_B_body,
        hands = gear.Nyame_B_hands,
        legs=gear.Nyame_B_legs,
        feet=gear.Nyame_B_feet,
        ring1 = "Epaminondas's Ring",
        ring2 = "Metamorph Ring +1",
        ear2 = "Regal Earring",
        ear1 = "Moonshade Earring",
        ammo="Oshasha's Treatise",
        neck="Duelist's Torque +2",
        waist="Sailfi Belt +1",
        back=gear.RDM_WSD_Cape,
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        ammo="Voluspa Tathlum",
        neck="Combatant's Torque",
        waist="Grunfeld Rope",
    })

    sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS['Savage Blade'],{})
    sets.precast.WS['Death Blossom'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc,{})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ear2="Sherida Earring",
        -- ring2="Shukuyu Ring",
        })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        ammo="Voluspa Tathlum",
        neck="Combatant's Torque",
        ear1="Mache Earring +1",
        })

    --Fixed ftp of 2.75. Focus on MD, WSC (stat) where 1MD==2MND==5STR
    sets.precast.WS['Sanguine Blade'] = { --50%MND/20%STR
        ammo="Ghastly Tathlum +1", --Higher MD
        head="Pixie Hairpin +1",
        body=gear.Nyame_B_body,
        hands="Jhakri Cuffs +2",
        legs=gear.Nyame_B_legs,
        feet="Lethargy Houseaux +3",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring", --7Mab and 10MND
        ring1="Epaminondas's Ring", --5WSD
        ring2="Freke Ring",
        back=gear.RDM_WSD_Cape,
        waist="Hachirin-no-obi",
    }

    sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], { --50%MND/20%STR
    })

    --Seraph blade is commonly used on single targets with Frazzle III landed.
    --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
    -- Base Magical WS Damage = floor(((152 + floor((WeaponLevel - 99) × 2.45) + WSC) × fTP) + dSTAT + MDMG Stat)
    -- Base Magical WS Damage × (MAB / MDB) × WSD × WSD Boost JT × Weather+Day Bonus × Affinity × Weapon Skill Potency Bonus
    --      × Augmented Weapon Skill Potency Bonus × Staff × Potency Multipliers × Resist × Resistance Rank Reduction × TMDA
    --Priority: ftp >> MD == 0.4*(STR+MND) > MAB > WSD > Ele Aff.
    sets.precast.WS['Seraph Blade'] = { --40% STR/40% MND
        ammo="Ghastly Tathlum +1", --21MD
        head = gear.Nyame_B_head,
        body=gear.Nyame_B_body,
        legs=gear.Nyame_B_legs,
        feet="Lethargy Houseaux +3",
        hands="Jhakri Cuffs +2",
        neck="Baetyl Pendant", --13MAB
        ear1="Friomisi Earring", --10MAB
        ear2="Moonshade earring", --fTP
        ring1="Epaminondas's Ring", --5WSD
        ring2="Freke Ring",
        back=gear.RDM_WSD_Cape,
        waist="Hachirin-no-obi", --Will be replaced by orpheus logic if applicable
    }

    sets.precast.WS['Seraph Blade'].Acc = set_combine(sets.precast.WS['Seraph Blade'], {--40% STR/40% MND
        ammo="Pemphredo Tathlum", --4MAB, 8macc
        ring1="Metamorph Ring +1", --16MND, 14macc
        ear1="Malignance Earring", --8MAB, 10Macc
        neck="Duelist's Torque +2", --30macc
    })

    sets.precast.WS['Seraph Blade'].MaxTP = set_combine(sets.precast.WS['Seraph Blade'], {--40% STR/40% MND
        ear2="Malignance Earring", --8MAB, 10Macc
    })

    --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
    --Priority: ftp >> MD == 0.4*(STR+MND) > MAB > WSD > Ele Aff.
    sets.precast.WS['Aeolian Edge'] = { --40% DEX/40% INT
        ammo ="Ghastly Tathlum +1", --MD21,INT5
        head =gear.Nyame_B_head,
        body=gear.Nyame_B_body,
        legs=gear.Nyame_B_legs,
        feet="Lethargy Houseaux +3",
        hands="Jhakri Cuffs +2",
        -- neck="Baetyl Pendant",
        neck="Sibyl Scarf", --10INT, 10MAB (testing)
        ear1="Malignance Earring",
        ear2="Moonshade earring", --fTP
        ring1="Epaminondas's Ring", --5WSD
        ring2="Freke Ring",
        back=gear.RDM_WSD_Cape,
        waist="Hachirin-no-obi", --Will be replaced by orpheus logic if applicable
    }

    sets.precast.WS['Aeolian Edge'].Acc = set_combine(sets.precast.WS['Aeolian Edge'], {
        ammo="Pemphredo Tathlum", --4MAB, 8macc
        ear2="Regal Earring", --7Mab and 10 macc
        ring1="Metamorph Ring +1", --16MND, 14macc
        neck="Duelist's Torque +2", --30macc
    })

    sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
        ear2="Regal Earring", --7Mab and 10 macc
    })

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
        -- ring1="Rufescent Ring",
        })

    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
        ammo="Voluspa Tathlum",
        neck="Combatant's Torque",
        ear2="Telos Earring",
        waist="Grunfeld Rope",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = set_combine(sets.precast.FC,{})

    --Not used often. Removing
    sets.midcast.SpellInterrupt = {
        -- sub="Sacro Bulwark", --7
        -- ammo="Impatiens", --10
        -- legs="Carmine Cuisses +1", --20
        -- ring1="Evanescence Ring", --5
        -- waist="Rumination Sash", --10
        }

    --Gearswap will ignore our custom spell mapping if we have a normal midcast.Cure set.
    --Gearswap looks for standard spell mapping sets like cure,protect,stone,etc before
    --looking at custom mapping.
    sets.midcast.CureNormal = { --Cure Pot cap +50%
        ammo="Staunch Tathlum +1",  --3DT
        --ammo="Esper Stone +1",    --0/(-5)
        --body="Kaykaus Bliaut +1", --(+4)/(-6)
        --legs="Kaykaus Tights +1", --11(+2)/(-6)
        hands="Kaykaus Cuffs +1",   --+11Pot(+2)/(-6)
        --feet="Kaykaus Boots +1",  --11(+2)/(-12)
        --ear1="Beatific Earring",
        neck="Loricate Torque +1",  --6DT
        --ear2="Meili Earring",
        back=gear.RDM_MND_Cape,     --+10Pot, 10DT, 30MND
        head="Bunzi's Hat",         --7DT
        body="Bunzi's Robe",        --+15Pot    , 10DT ,-10Enm
        legs="Atrophy tights +2",   --+11Pot,+15Skill
        feet="Vanya Clogs",         --+5Pot,+40Skill
        ear2="Odnowa Earring +1",   --3DT
        ear1="Malignance Earring",  --8MND
        waist="Flume Belt +1",      --4PDT
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Sirona's Ring",      --+10skill
        }--52%, 29DT, 21PDT, Conserve MP+6

    sets.midcast.CureSIRD = { --SIRD cure for low hp critical heal situations
        main="Daybreak",            --30Pot
        sub="Genmei Shield",        --10PDT
        ammo="Staunch Tathlum +1",  --3DT, 11SIRD
        neck="Loricate Torque +1",  --6DT
        back=gear.RDM_MND_Cape,     --+10Pot, 10PDT, 30MND
        head="Bunzi's Hat",         --7DT
        -- body="Bunzi's Robe",        --+15Pot    , 10DT ,-10Enm
        body=gear.Chironic_SIRD_body,--+13Pot   , 0DT  , 0Enm,  11SIRD
        -- body="Rosette Jaseran +1",      --0Pot     , 5DT  ,-12Enm, 20SIRD
        hands=gear.Chironic_SIRD_hands,--+0Pot  , 0DT  ,-4Enm,  30SIRD
        legs=gear.Chironic_SIRD_legs,--+8Pot    , 0DT  , 0Enm,  11SIRD
        -- legs="Atrophy tights +2",   --+11Pot,+15Skill
        feet="Vanya Clogs",         --+5Pot,+40Skill
        ear1="Halasz Earring",      --+0Pot     , 0DT  ,-3Enm,  5SIRD
        ear2="Magnetic Earring",    --+0Pot     , 0DT  , 0Enm,  8SIRD
        waist="Rumination Sash",    --0Pot      , 0DT  ,-0Enm,  10SIRD
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring",     --10DT
        }--52%, 26DT, 27PDT, Conserve MP+6, 95SIRD

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        main={name="Chatoyant Staff", priority=10},
        sub="Enki Strap",
        back="Twilight Cape",
        ring2="Defending Ring",  --10 DT covers PDT loss for hachirin
        waist="Hachirin-no-Obi", --10 less PDT
        })

    sets.midcast.CureSelf = set_combine(sets.midcast.CureNormal, {
        -- main="Sanus Ensis", -- +13 pot. +10 pot received
        -- sub="Genmei Shield"
        -- neck="Phalaina Locket", -- 4(4)
        hands="Atrophy Gloves +3",
        -- ring2="Asklepian Ring", -- (3)
        waist="Gishdubar Sash", -- (10)
        })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        -- body="Vanya Robe",
        --legs="Atrophy Tights +3",
        legs="Atrophy Tights +2",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        -- ear2="Meili Earring",
        -- ring1="Haoma's Ring",
        -- ring2="Menelaus's Ring",
        back="Aurist's Cape +1",
        -- waist="Bishop's Sash",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- hands="Hieros Mittens",
        body="Vitiation Tabard +3",
        -- neck="Debilis Medallion",
        -- ear1="Beatific Earring",
        -- ring2="Menelaus's Ring",
        ring1={name="Ephedra Ring", bag="wardrobe3"},
        ring2={name="Ephedra Ring", bag="wardrobe4"},
        -- back="Oretan. Cape +1",
        })

    sets.midcast.Blink = { --Blink used as defensive while in combat. Focus on DT, MEVA, and Duration
        ammo="Staunch tathlum +1", --3DT
        head="Bunzi's Hat", --7DT, 10 FC
        body="Vitiation Tabard +3", --15, 15FC
        legs=gear.Nyame_B_legs, --8DT
        feet="Lethargy Houseaux +3", --35
        neck="Duelist's Torque +2", --25
        ear1="Malignance Earring", --4FC
        ear2="Odnowa Earring +1", --3DT, 2MDT
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10 DT
        back=gear.RDM_ENH_Cape, --20
        hands=gear.Nyame_B_hands, --7DT
        waist="Flume Belt +1", --4PDT
    } --90% Dur, 36DT, 11PDT, 1MDT

    sets.midcast.EnhancingDuration = {
        main=gear.Colada_ENH, --4
        sub={name="Ammurapi Shield", priority = 10}, --10
        head=gear.Telchine_ENH_head, --10
        body="Vitiation Tabard +3", --15, 15FC
        legs=gear.Telchine_ENH_legs, --10
        feet="Lethargy Houseaux +3", --35
        neck="Duelist's Torque +2", --25
        ear2="Malignance Earring", --4FC
        ear1="Lethargy Earring", --7
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10 DT
        back=gear.RDM_ENH_Cape, --20
        hands="Atrophy Gloves +3", --20
        waist="Embla Sash", --10
    } --161% Dur

    sets.midcast.EnhancingSkill = set_combine(sets.midcast.EnhancingDuration, {
        main="Pukulatmuj +1",
        sub={name="Forfend +1", priority = 10},
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",
        body="Vitiation Tabard +3",
        hands="Atrophy Gloves +3",
        --legs="Atrophy Tights +3",
        legs="Atrophy Tights +2",
        feet="Lethargy Houseaux +3",
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1",bag="wardrobe3"},
        ring2={name="Stikini Ring +1",bag="wardrobe4"},
        back=gear.RDM_ENH_Cape,
        waist="Olympus Sash",
    })

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga", 
        sub={name="Ammurapi Shield", priority = 10},
        -- head=gear.Telchine_ENH_head,
        body=gear.Telchine_RGN_body,
        -- hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_RGN_legs,
        -- feet=gear.Telchine_ENH_feet,
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1", -- +2
        body="Atrophy Tabard +3", --+3
        legs="Lethargy Fuseau +2", --+3
    })

    sets.midcast.CompRefreshOther = set_combine(sets.midcast.EnhancingDuration, {     
        main=gear.Colada_ENH, --4
        sub={name="Ammurapi Shield", priority = 10}, --10
        head="Amalric Coif +1", -- +2
        body="Atrophy Tabard +3", -- +3pot
        hands="Atrophy Gloves +3", --20
        legs="Lethargy Fuseau +2",
        feet="Lethargy Houseaux +3", --35
        neck="Duelist's Torque +2", --25
        ear1="Malignance Earring", --4FC
        ear2="Lethargy Earring", --7
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10 DT
        back=gear.RDM_ENH_Cape, --20
        waist="Embla Sash", --10
    })

    sets.midcast.RefreshSelf = set_combine(sets.midcast.EnhancingDuration, {
        waist="Gishdubar Sash",
        back="Grapevine Cape",
    })

    --Stoneskin caps at a really low skill cap. At 99, you're capped with zero skill gear.
    --Stoneskin caps at 350. +Stoneskin gear has no limit. Current max is 475
    --Focus on DT, EMVA, and FC for survivability while in combat
    --If (Enhancing Magic Skill ÷ 3) + MND ≥ 130 : Stoneskin Strength = Enhancing Magic Skill + 3×MND - 190
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1", --3DT
        head="Atrophy Chapeau +3", --16FC
        body="Bunzi's Robe", --10DT
        neck="Nodens Gorget", --30, -10PDT
        hands="Stone Mufflers", --30
        waist="Siegel Sash", --20
        feet="Bunzi's Sabots", --6DT
        ear1="Earthcry Earring", --10
        ear2="Odnowa Earring +1", --3DT, 2MDT
        legs="Shedir Seraweels", --35
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10DT
        back=gear.RDM_MND_Cape, --10PDT
    }) --125 Stoneskin, 31 FC (+38 FC traits/gifts), 40DT, 17PDT (-10PDT Nodens), 1MDT

    sets.midcast.PhalanxSelf = set_combine(sets.midcast.EnhancingDuration, {
        main={name="Sakpata's Sword", priority=10}, --5
        sub="Ammurapi Shield",
        head=gear.Taeon_Phalanx_head, --3(10)
        body=gear.Taeon_Phalanx_body, --3(10)
        hands=gear.Taeon_Phalanx_hands, --3(10)
        legs=gear.Taeon_Phalanx_legs, --2(10)
        feet=gear.Taeon_Phalanx_feet, --3(10)
    }) --19 Phalanx

    --Caps at 500 Skill
    sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration,{}) --At ML27, enhancing duration set bumps above 500 skill
    sets.midcast.CompOtherPhalanx = {
        main=gear.Colada_ENH, --4
        sub={name="Ammurapi Shield", priority = 10}, --10
        head="Lethargy Chappel +2",
        body="Lethargy Sayon +2",
        hands="Atrophy Gloves +3", --20
        legs="Lethargy Fuseau +2",
        feet="Lethargy Houseaux +3", --35
        neck="Duelist's Torque +2", --25
        ear1="Malignance Earring", --4FC
        ear2="Lethargy Earring", --7
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10 DT
        back=gear.RDM_ENH_Cape, --20
        waist="Embla Sash", --10
    }

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
        head="Amalric Coif +1",
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring2="Freke Ring",
        ring1="Evanescence Ring",
        waist="Emphatikos Rope",
        legs="Shedir seraweels",
    })

    sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration,{})
    -- sets.midcast.GainSpell = {hands="Vitiation Gloves +3"}
    -- sets.midcast.SpikesSpell = {legs="Vitiation Tights +3"}
    sets.midcast.GainSpell = {hands="Vitiation gloves +2"}
    sets.midcast.SpikesSpell = {legs="Vitiation Tights"}

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        -- ring2="Sheltered Ring"
    })
    sets.midcast.Protectra = set_combine(sets.midcast.Protect,{})
    sets.midcast.Shell = set_combine(sets.midcast.Protect,{})
    sets.midcast.Shellra = set_combine(sets.midcast.Shell,{})


     -- Custom spell classes

    --Slow, Slow II, Paraylze, Addle (all tiers)
    sets.midcast.MndEnfeebles = { --Max MND but balance macc for landing
        main="Crocea Mors",  --50
        sub={name="Ammurapi Shield", priority = 10}, --38
        ammo="Regal Gem", --Pot+10
        head="Vitiation Chapeau +3",
        body="Lethargy Sayon +2",
        hands="Lethargy Gantherots +3", --52macc, 24 skill
        legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
        feet="Vitiation Boots +3",
        neck="Duelist's Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1={name="Stikini Ring +1",bag="wardrobe3"},
        ring2="Metamorph Ring +1", --16 MND vs Stikini 8 MND. 14 Macc vs 11+8skill so about 4 macc less
        waist="Obstin. Sash", --5% dur, 5skill, 15 macc
        back=gear.RDM_MND_Cape, --20macc, 30 MND
    } --411 Macc + 561 Enfeebling skill = 951, 411 total MND, max duration and effect

    sets.midcast.MndEnfeeblesDW = set_combine(sets.midcast.MndEnfeebles, {
        main={name="Daybreak", priority=10}, 
        sub="Maxentius",
    })

    --Spells that don't vary potency based on skill
    --'Silence'
    sets.midcast.MndEnfeeblesAcc = {
        
        --Option 1: Best Mythic
        -- main="Murgleis" --RDM Mythic 255+40+aftermath
        main="Crocea Mors",  --50 + 255
        sub={name="Ammurapi Shield", priority = 10}, --38
        range="Ullr",
        head="Vitiation Chapeau +3",
        body="Atrophy Tabard +3",
        hands="Lethargy Gantherots +3", --52macc, 24 skill
        -- hands="Lethargy Gantherots +3", --62 macc, 29skill, 11DT
        legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
        feet="Vitiation Boots +3",
        neck="Duelist's Torque +2", --25% dur
        ring1={name="Stikini Ring +1",bag="wardrobe3"},
        ring2={name="Stikini Ring +1",bag="wardrobe4"},
        waist="Obstin. Sash", --5% dur, 5skill, 15 macc
        back="Aurist's Cape +1",
        ear1="Snotra Earring",
        ear2="Regal Earring", --Set bonus with atrophy gear: +15 macc (total +30 macc)
    } --469 Macc (checkparam) + 91 aug/set bonus + 600 Enfeebling skill + 255 macc skill = 1404, 403 MND.

    sets.midcast.MndEnfeeblesAccDW = set_combine(sets.midcast.MndEnfeeblesAcc, {
        main={name="Crocea Mors", priority=10},  --(255)+50
        sub="Demers. Degen +1", --40 bonus magic acc
    })

    sets.midcast.MndEnfeeblesEffect = set_combine(sets.midcast.MndEnfeebles, { --Dia (all tiers) --TODO: Check gear
        ammo="Regal Gem",
        body="Lethargy Sayon +2",
        feet="Vitiation Boots +3",
        neck="Duelist's Torque +2",
        back=gear.RDM_MND_Cape, --+10 enf pot makes this better than aurist's
    })

    sets.midcast.MndEnfeeblesEffectDW = set_combine(sets.midcast.MndEnfeeblesEffect, {
        main={name="Daybreak", priority=10}, 
        sub="Maxentius",
    })

    --Distract III, Frazzle III, Inundation
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, { --Balanced INT and Macc
        ammo="Ghastly Tathlum +1",
        waist="Obstin. Sash", --5% dur, 5skill, 15 macc
        legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
        back=gear.RDM_INT_Cape,
        --ear1= --Need INT earring!
    }) --299 Macc + 552 Enfeebling skill = 851, 369 INT

    sets.midcast.IntEnfeeblesDW = set_combine(sets.midcast.IntEnfeebles, {}) 

    --'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
    --'Frazzle II',  'Gravity', 'Gravity II', 
    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.MndEnfeeblesAcc, { --Max Acc with less Int
    }) --483 Macc + 96 augments/set bonus + 574 Enfeebling skill = 1098 + 255 = 1408 , 365 INT

    sets.midcast.IntEnfeeblesAccDW = set_combine(sets.midcast.IntEnfeeblesAcc, {
        main={name="Crocea Mors", priority=10},  --255+50
        sub="Daybreak", --40 bonus magic acc
    })

    sets.midcast.IntEnfeeblesEffect = set_combine(sets.midcast.IntEnfeebles, { --Blind potency set. --Good. Verified 9/10/21
        ammo="Regal Gem",
        range=empty,
        body="Lethargy Sayon +2",
        feet="vitiation boots +3",
        neck="Duelist's Torque +2",
        back=gear.RDM_INT_Cape, --Better and aurists's because includes enfeeb magic effect +10
    }) --Check macc

    sets.midcast.IntEnfeeblesEffectDW = set_combine(sets.midcast.IntEnfeeblesEffect, {
        main={name="Crocea Mors", priority=10},  --255+50
        sub="Daybreak", --40 bonus magic acc
    })

    --Skill max is 625 is the highest needed.
    --Distract III (610), Frazzle III (625), Poison II
    sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, { 
        main="Contemplator +1", --20skill, 70macc, 228 macc skill
        sub="Enki Strap", --10macc
        ear1="Regal Earring", --15Macc with Atrophy Gear
        ammo="Regal Gem", --10% pot
        head="Vitiation Chapeau +3", --24
        body="Atrophy Tabard +3", --21
        hands="Kaykaus Cuffs +1", --16, 53macc
        legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
        feet="vitiation boots +3", --16
        -- neck="Incanter's Torque", --10
        neck="Duelist's torque +2", --10% pot
        ring1="Kishar Ring", --10% dur
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, --8
        ear2="Snotra Earring", --10% Dur
        waist="Obstin. Sash", --5% dur, 5skill, 15 macc
        back=gear.RDM_INT_Cape, --10% pot
    })--355 Macc + 146 aug macc + 30 M.Acc AF Bonus + 625 Enfeebling Skill + 228 macc skill = 1384 (Enfeeb == Macc according to wikia)

    sets.midcast.SkillEnfeeblesDW = set_combine(sets.midcast.SkillEnfeebles, {
        main={name="Crocea Mors", priority=10},  --255+50
        sub="Daybreak", --40 bonus magic acc
    })
    
    sets.midcast.SleepNormal = set_combine(sets.midcast.IntEnfeeblesAcc, {
        head="Vitiation Chapeau +3",
        neck="Duelist's Torque +2",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        back=gear.RDM_INT_Cape, --Better and aurists's because includes enfeeb magic effect +10
    })

    sets.midcast.SleepNormalDW = set_combine(sets.midcast.SleepNormal, {
        main={name="Crocea Mors", priority=10},  --255+50
        sub="Daybreak", --40 bonus magic acc
    })

    sets.midcast.SleepMaxDuration = set_combine(sets.midcast.SleepNormal, {
        head="Lethargy Chappel +2",
        body="Lethargy Sayon +2",
        hands="Regal Cuffs",
        legs="Lethargy Fuseau +2",
        feet="Lethargy Houseaux +3",
    })

    sets.midcast.SleepMaxDurationDW = set_combine(sets.midcast.SleepMaxDuration, {
        main={name="Crocea Mors", priority=10},  --255+50
        sub="Daybreak", --40 bonus magic acc
    })

    sets.midcast['Dark Magic'] = {
        -- main="Rubicundity",
        main="Crocea Mors",
        sub={name="Ammurapi Shield", priority = 10},
        ammo="Pemphredo Tathlum",
        head="Atrophy Chapeau +3",
        -- body="Carm. Sc. Mail +1",
        body="Atrophy Tabard +3", --Sub
        hands="Kaykaus Cuffs +1",
        -- legs="Ea Slops +1",
        legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
        feet="Malignance Boots", --Macc
        -- neck="Erra Pendant",
        neck="Duelist's Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        -- ear2="Mani Earring",
        ring1={name="Stikini Ring +1",bag="wardrobe3"},
        ring2="Evanescence Ring", --2 more skill but less acc than stikini
        back="Aurist's Cape +1",
        waist="Obstin. Sash", --5% dur, 5skill, 15 macc
    }

    --Not used often
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        -- feet="Merlinic Crackows",
        -- ear1="Hirudinea Earring",
        ring1="Archon Ring",
        ring2="Evanescence Ring",
        back="Perimede Cape",
        -- waist="Fucho-no-obi",
    })

    --Not often used
    --sets.midcast.Aspir = set_combine(sets.midcast.Drain,{})

    --Magic acc + Dark Elemental
    sets.midcast.Stun = { --When using chainspell, this has to be in precast.
        main={name="Crocea Mors", priority=10},  --122(255)+50
        sub={name="Ammurapi Shield", priority = 10}, --38 bonus magic acc
        range="Ullr", --40
        head="Atrophy Chapeau +3", --54+17
        body="Atrophy Tabard +3", --55
        hands="Kaykaus Cuffs +1", --33+20
        legs=gear.Chironic_MACC_legs, --20+36 macc
        feet="Malignance Boots", --50
        neck="Duelist's Torque +2", --30
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, --8+11
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, --8+11
        waist="Obstin. Sash", -- 15 macc
        ear1="Malignance Earring", --10
        ear2="Regal Earring",  --15 set bonus
        back="Aurist's Cape +1", --33
    } --496 Macc + 30 macc set bonus + 352 Drk Magic = 893 effective macc

    --sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], {legs="Vitiation Tights +3"})
    sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], {legs="Vitiation Tights"})

    sets.midcast['Elemental Magic'] = {
        main={name="Bunzi's Rod", priority=10}, 
        sub="Daybreak",
        feet="Bunzi's Sabots",
        ammo="Ghastly Tathlum +1",
        head="Lethargy Chappel +2",
        body="Lethargy Sayon +2",
        hands="Lethargy Gantherots +3",
        legs="Lethargy Fuseau +2",
        feet="Lethargy Houseaux +3",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring2="Freke Ring",
        ring1="Metamorph Ring +1",
        back="Aurist's Cape +1",
        back=gear.RDM_INT_Cape, -- MAB is much stronger
        waist="Refoccilation Stone",
    }

    sets.midcast['Elemental Magic'].LowDmg = {
        head="Malignance Chapeau",
        body="ayanmo corazza +2",
        hands="Ayanmo manopolas +2",
        legs="Malignance Tights",
        feet="Malignance Boots",
        legs=gear.Chironic_MACC_legs,
        ear2="Moonshade earring",
        ear1="Malignance earring",
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2="Defending Ring",
        neck="Loricate Torque +1",
        back="Aurist's Cape +1",
        ammo="Coiste Bodhar", --Sub
    }

    --Not used often
    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        body="Seidr Cotehardie",
        -- legs="Merlinic Shalwar",
        -- feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        waist="Acuity Belt +1",
        })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        range="Ullr",
        ammo=empty,
        -- legs="Merlinic Shalwar",
        -- feet="",
        -- neck="Sanctity Necklace",
        -- waist="Sacro Cord",
        })

    sets.midcast.Impact = set_combine(sets.midcast.MndEnfeeblesAcc, {
        head=empty,
        body="Twilight Cloak",
        ring1="Archon Ring",
        waist="Shinjutsu-no-Obi +1",
        })

    sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt,{})

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = set_combine(sets.precast.FC,{})

    -- Job-specific buff sets
    sets.buff.ComposureOther = {
        main=gear.Colada_ENH, --4
        sub={name="Ammurapi Shield", priority = 10}, --10
        head="Lethargy Chappel +2",
        body="Lethargy Sayon +2",
        hands="Atrophy Gloves +3", --20
        legs="Lethargy Fuseau +2",
        feet="Lethargy Houseaux +3", --35
        neck="Duelist's Torque +2", --25
        ear1="Malignance Earring", --4FC
        ear2="Lethargy Earring", --7
        ring1="Gelatinous Ring +1", --7PDT, -1MDT
        ring2="Defending Ring", --10 DT
        back=gear.RDM_ENH_Cape, --20
        waist="Embla Sash", --10
    }

    sets.buff.Saboteur = {hands="Lethargy Gantherots +3" }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {--DT 50%, Max Refresh
        -- main="Daybreak", --1RF 
        head="Vitiation Chapeau +3", --3RF
        -- head="Malignance Chapeau", --6
        body="Jhakri Robe +2", --4RF
        hands=gear.Nyame_B_hands, --7
        legs=gear.Nyame_B_legs, --8
        feet=gear.Nyame_B_feet, --7
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, --1RF
        ring2="Defending Ring", --10
        ear2="Odnowa Earring +1",   --3DT
        ear1="Eabani Earring", --8MEVA
        neck="Loricate torque +1", --6
        back=gear.RDM_STP_Cape, --5DT
        ammo="Homiliary", --1RF
        waist="Flume Belt +1", --3PDT
        } --43DT, 3PDT, 9 latent RF
    
    sets.idle.Refresh = set_combine(sets.idle, { --Unused currently
        -- main="Daybreak", --+1 --Too annoying and resets weapons
        head="Vitiation Chapeau +3", --+3
        hands=gear.Chironic_RF_hands, --+1
        legs=gear.Chironic_RF_legs, --+1
        feet=gear.Chironic_RF_feet, --+1
        body="Jhakri Robe +2", --+4
        waist="Fucho-no-obi",
        ammo="Homiliary", --+1
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, --+1
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, --+1
        }) --13

    sets.idle.Casting = set_combine(sets.idle, {
        main={name="Crocea Mors", priority=10}, 
        })

    sets.idle.CastingDW = set_combine(sets.idle, {
        main={name="Daybreak", priority=10}, 
        sub="Maxentius",
    })

    sets.idle.Impact = set_combine(sets.idle,{
        head=empty,
        body="Twilight Cloak",
    })

    sets.idle.Gyve = set_combine(sets.idle,{
        body="Gyve Doublet",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = { --50% cap
        head="Malignance Chapeau", --6
        body="Malignance Tabard", --9
        hands="Malignance Gloves", --5
        legs="Malignance Tights", --7
        -- ear1 - leave for DW or STP
        -- ear2 - leave for DW or STP
        feet="Malignance Boots", --4
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2="Defending Ring", --10
        neck="Loricate torque +1", --6
        back=gear.RDM_STP_Cape --5
    } --52

    sets.defense.MDT = set_combine(sets.defense.DT,{})

    sets.magic_burst = { --Cap 40
        head = gear.Nyame_B_head, --5
        body = gear.Nyame_B_body, --7
        legs = gear.Nyame_B_legs, --6
        hands = gear.Nyame_B_hands, --5
        feet = gear.Nyame_B_feet, --5

        -- head="Ea Hat +1", --7/(7)
        -- body="Ea Houppe. +1", --9/(9)
        -- hands="Amalric Gages +1", --(6)
        -- legs="Ea Slops +1", --8/(8)
        -- feet="Ea Pigaches +1", --5/(5)
        -- neck="Mizu. Kubikazari", --10
        -- ring2="Mujin Band", --(5)
    } --28

    sets.Kiting = set_combine(sets.Kiting, {
		legs="Carmine Cuisses +1"
	})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion    

    sets.engaged = { --Aim for 26% gear haste. No DW. Max STP
    --     ammo="Aurgelmir Orb +1",
        head="Malignance Chapeau", --6
        body="Malignance Tabard", --9
        hands="Malignance Gloves", --5
        legs="Malignance Tights", --7
        feet="Malignance Boots", --4
        neck="Anu Torque",
        ear1="Dedition Earring", --STP8
        ear2="Sherida Earring", --DA5, STP5
        ring1="Hetairoi Ring",
        -- ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2={name="Chirich Ring +1",bag="wardrobe4"},
        -- waist="Windbuffet Belt +1",
        waist="Flume Belt +1", --4
        back=gear.RDM_STP_Cape, --10PDT
        ammo="Coiste Bodhar",
    } --31DT, 14PDT

    sets.engaged.Enspell = set_combine(sets.engaged, {
        range="Ullr",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Ayanmo Manopolas +2",
        legs="Vitiation Tights",
        feet="Malignance Boots",
        ear1="Lyc. Earring",
        ear2="Suppanomimi", --+5% DW
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2="Hetairoi Ring",
        -- ring2={name="Chirich Ring +1",bag="wardrobe4"},
        -- waist="Orpheus's Sash",
        waist="Hachirin-no-obi",
        neck="Lissome Necklace",
        back=gear.RDM_DW_Cape, --10DW, 10PDT
        })

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        neck="Combatant's Torque",
        ear1="Telos Earring", --STP5, DA1
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        -- waist="Kentarch Belt +1",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        ammo="Voluspa Tathlum",
        head="Carmine Mask +1",
        -- body="Carm. Sc. Mail +1",
        legs="Carmine Cuisses +1",
        -- ear1="Cessance Earring",
        ear1="Mache Earring +1",
        waist="Olseni Belt",
    })

    -- Because RDM has such fast cast times, for tier 2 and lower, midcast is unable to trigger before post cast
    -- resulting in a loss of dmg for < 1s cast time spells. Work around is to stay in this gear for mid and post-cast.
    sets.engaged.ElementalSpam = set_combine(sets.midcast['Elemental Magic'],{})

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = { --Goal: 26% gear haste (cap 25) As much DW gear as possible. No haste. Low Acc set
        body="Malignance Tabard",
        waist="Reiki Yotai", --7%DW
        ring2="Ilabrat Ring",
        legs="Malignance Tights", --7DT
        -- ammo="Aurgelmir Orb +1",
        ammo="Coiste Bodhar", --Sub
        back=gear.RDM_DW_Cape, --+10% DW, 5DT
        neck="Loricate Torque +1", --6 DT
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2="Defending Ring", --10DT
        ear1="Eabani Earring", --+4% DW
        ear2="Suppanomimi", --+5% DW
        head="Malignance Chapeau", --6DT
        hands="Malignance Gloves", --4DT
        feet=gear.Taeon_DW_feet, --+4% DW +5 DW (Aug)
        ammo="Coiste Bodhar", --Sub
    }
    
    sets.engaged.DW.NoTPEnspell = set_combine(sets.engaged.Enspell, {
        range="Ullr", --Equip in macro
        ammo=empty,
        main={name="Norgish Dagger", priority=10}, 
        sub="Qutrub Knife",
        neck="Duelist's torque +2",
        body="Ayanmo corazza +2",
        head="Umuthi Hat",
        hands="Ayanmo Manopolas +2", 
        ear1="Telos Earring",
    })

    sets.engaged.DW.Enspell = set_combine(sets.engaged.Enspell,{})

    -- Because RDM has such fast cast times, for tier 2 and lower, midcast is unable to trigger before post cast
    -- resulting in a loss of dmg for < 1s cast time spells. Work around is to stay in this gear for mid and post-cast.
    sets.engaged.DW.ElementalSpam = set_combine(sets.midcast['Elemental Magic'],{})

    

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
        neck="Lissome Necklace",
        body="Ayanmo Corazza +2", --sub piece
        ear2="Sherida Earring",
        body="Malignance Tabard",
        })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        neck="Combatant's Torque",
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2={name="Chirich Ring +1",bag="wardrobe4"},
        })

    ---------------- 30% Magic Haste (31 DW w/ sub nin to cap) -----------------
    sets.engaged.MidHasteDW = {
        -- main={name="Crocea Mors", priority=10}, 
        -- sub="Demersal Degen +1", --Offhand DA 35% when under temper II
        -- sub="Tauret",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet=gear.Taeon_DW_feet, --+4% DW +5 DW (Aug)
        -- ammo="Aurgelmir Orb +1",
        ammo="Coiste Bodhar", --Sub
        waist="Reiki Yotai", --7%DW
        back=gear.RDM_DW_Cape, --+10% DW
        neck="Loricate Torque +1", --6DT
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2="Hetairoi Ring",
        ear1="Dedition Earring",
        ear2="Suppanomimi", --+5% 
        ammo="Coiste Bodhar", --Sub
        } --30DW, 48DT

    sets.engaged.MidHasteDW.MidAcc = set_combine(sets.engaged.MidHasteDW, {
        neck="Lissome Necklace",
        ear1="Sherida Earring",
        }) --42DT

    sets.engaged.MidHasteDW.HighAcc = set_combine(sets.engaged.MidHasteDW.MidAcc, {
        neck="Combatant's Torque",
        ear1="Telos Earring",
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2={name="Chirich Ring +1",bag="wardrobe4"},
        }) --42DT

    sets.engaged.MidHasteDW.NoTPEnspell = set_combine(sets.engaged.DW.NoTPEnspell, sets.engaged.MidHasteDW.HighAcc)

    sets.engaged.MidHasteDW.Enspell = set_combine(sets.engaged.Enspell,{})

    ----- 35% Magic Haste (Unsure why we have these sets. Perhaps sub dnc? Not used)--------
    sets.engaged.HighHasteDW = set_combine(sets.engaged.MidHasteDW, {})
    sets.engaged.HighHasteDW.MidAcc = set_combine(sets.engaged.MidHasteDW.MidAcc, {})
    sets.engaged.HighHasteDW.HighAcc = set_combine(sets.engaged.MidHasteDW.HighAcc, {})
    sets.engaged.HighHasteDW.NoTPEnspell = set_combine(sets.engaged.MidHasteDW.NoTPEnspell, {})
    sets.engaged.HighHasteDW.Enspell = set_combine(sets.engaged.Enspell, {})

    --------- 45% Magic Haste (11% DW to cap)----------------
    sets.engaged.MaxHasteDW = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        -- ammo="Aurgelmir Orb +1",
        ammo="Coiste Bodhar", --Sub
        back=gear.RDM_STP_Cape,
        neck="Anu Torque",
        -- ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring1="Epona's Ring",
        ring2="Hetairoi Ring",
        ear1="Dedition Earring",

        --Option 3:
        waist="Reiki Yotai", --7% DW
        ear2="Eabani Earring", --4% DW
        })

    sets.engaged.MaxHasteDW.MidAcc = set_combine(sets.engaged.MaxHasteDW, {
        neck="Lissome Necklace",
        ear1="Sherida Earring",
        })

    sets.engaged.MaxHasteDW.HighAcc = set_combine(sets.engaged.MaxHasteDW.MidAcc, {
        neck="Combatant's Torque",
        ear1="Telos Earring",
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2={name="Chirich Ring +1",bag="wardrobe4"},
        })

    sets.engaged.MaxHasteDW.NoTPEnspell = set_combine(sets.engaged.DW.NoTPEnspell, sets.engaged.MaxHasteDW.HighAcc)
    sets.engaged.MaxHasteDW.Enspell = set_combine(sets.engaged.Enspell,{})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.MidHasteDW.DT = set_combine(sets.engaged.MidHasteDW, sets.engaged.Hybrid)
    sets.engaged.MidHasteDW.MidAcc.DT = set_combine(sets.engaged.MidHasteDW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.MidHasteDW.HighAcc.DT = set_combine(sets.engaged.MidHasteDW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.HighHasteDW.DT = set_combine(sets.engaged.HighHasteDW, sets.engaged.Hybrid)
    sets.engaged.HighHasteDW.MidAcc.DT = set_combine(sets.engaged.HighHasteDW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighHasteDW.HighAcc.DT = set_combine(sets.engaged.HighHasteDW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.MaxHasteDW.DT = set_combine(sets.engaged.MaxHasteDW, sets.engaged.Hybrid)
    sets.engaged.MaxHasteDW.MidAcc.DT = set_combine(sets.engaged.MaxHasteDW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.MaxHasteDW.HighAcc.DT = set_combine(sets.engaged.MaxHasteDW.HighAcc, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Saida Ring", bag="wardrobe4"}, --15
        ring2={name="Saida Ring", bag="wardrobe4"}, --15
        -- ring1="Eshmun's Ring", --20
        -- ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.TreasureHunter = set_combine(sets.TreasureHunter,{
        legs = gear.Chironic_TH_legs, --Th+1
    })

    sets.AccAccessories = {
        ammo="Ginsen",
        neck="Lissome Necklace",
        ear1="Telos Earring",
        ring1={name="Chirich Ring +1",bag="wardrobe3"},
        ring2={name="Chirich Ring +1",bag="wardrobe4"},
    }

    --Weapon sets. Used for autows and reorg
    sets["Aeolian Edge"]= {
        main="Tauret",
        sub="Bunzi's Rod",
    }

    sets["Seraph Blade"] = {
        main="Crocea Mors",
        sub="Daybreak",
    }
    
    sets["Savage Blade"] = {
        main="Naegling",
        sub="Thibron",
    }

    sets['Asuran Fists'] = {
        main="Karambit",
    }

    sets['Black Halo'] = {
        main="Maxentius",
        sub="Thibron",
    }

    sets.enspell = {
        main="Crocea Mors",
        sub="Gleti's Knife",
    }

    sets.notpenspell = {
        main="Qutrub Knife",
        sub="Norgish Dagger",
    }

    sets.kraken = {
        sub="Kraken Club",
    }

    sets.culminus = {
        sub="Culminus",
    }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
    --print("pretarget triggered")
end

function job_precast(spell, action, spellMap, eventArgs)
    silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
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
    if spell.type == 'WeaponSkill' and player.tp == 3000 then
        -- print("TP Max. Checking for "..spell.name..".MaxTP")
        if sets.precast.WS[spell.name] and sets.precast.WS[spell.name].MaxTP then --MaxTP set throws nil if the precast.WS of the ws doesn't exist
            -- print("Found "..spell.name..'.MaxTP. Equipping..')
            equip(sets.precast.WS[spell.name].MaxTP)
        end
    end
end

-- Runs after default precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- print("post precast. Spell is:",spell.english)
    -- print("post precast. Spell action is: ",action)
    -- print("post precast. Spell Map is: ",spellMap)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.name == 'Stoneskin' then
        equip(sets.precast.FC.Stoneskin)
    end
    -- if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
    --     add_to_chat(122,'Notice: Phalanx II cancelled. Phalanx casted on self instead.')
    --     cancel_spell()
    --     send_command('@input /ma "Phalanx" <me>')
    -- end
    --Find the next tier spell down from a higher tier spell
    --Does not upgrade a lower tier spell
    if maxTier ~= nil then
        add_to_chat(123, "Notice: maxTier is current set to "..maxTier)
    end
    -- newSpell = getAvailableSpell(spell, eventArgs, maxTier)
    -- if spell.english ~= newSpell then
    --     add_to_chat(122,"Cancelling spell "..spell.english.." and casting "..newSpell.." instead.")
    --     cancel_spell()
    --     send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
    -- end
    ----------- Non-silibs content goes above this line -----------
    silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
    silibs.midcast_hook(spell, action, spellMap, eventArgs)
    ----------- Non-silibs content goes below this line -----------
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- print("Spell: "..spell.english)
    -- print("Target: "..spell.target.type)
    if spell.skill == 'Enfeebling Magic' and buffactive.Saboteur then
        equip(sets.buff.Saboteur)
    end
    if spell.skill == 'Enhancing Magic' then
        if silibs.default_quick_magic_spells['WhiteMagic']:contains(spell.english) or silibs.default_quick_magic_spells['BlackMagic']:contains(spellMap) then -- Mote libraries does not contain tier ii spells. Check spellMap for base
            -- print("No skill spell ",spell.english," is being casted. Equipping +duration gear.")
            if spellMap == 'Refresh' then
                --print("Refresh target:",spell.target.type)
                if spell.target.type == 'SELF' then
                    equip(sets.midcast.RefreshSelf)
                else
                    if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
                        equip(sets.midcast.CompRefreshOther)
                    else
                        equip(sets.midcast.Refresh)
                    end
                end
            else
                if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
                    -- print('equipping comp other')
                    equip(sets.buff.ComposureOther)
                else
                    -- print('equipping dur')
                    equip(sets.midcast.EnhancingDuration)
                end
            end
        elseif skill_spells:contains(spell.english) then
            -- print("Skill spell "..spell.english.." is being casted. Equipping skill set")
            equip(sets.midcast.EnhancingSkill)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        elseif spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.PhalanxSelf)
            else
                if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
                    equip(sets.midcast.CompOtherPhalanx)
                else
                    equip(sets.midcast.Phalanx)
                end
            end
        else
            
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then --Additionally, if we are healing ourselves, swap to received healing+ gear
        if player.hpp < 50 then
            custom_spell_map = 'CureSIRD'
        else
            custom_spell_map = 'CureSelf'
        end
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
     ----------- Non-silibs content goes above this line -----------
    silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
    silibs.aftercast_hook(spell, action, spellMap, eventArgs)
    ----------- Non-silibs content goes below this line -----------
    if spell.english:contains('Sleep') and not spell.interrupted then
        set_sleep_timer(spell)
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    ----------- Non-silibs content goes above this line -----------
    silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)    
    if buff == "sleep" then
        equip_prime_weapon(gain)
    elseif buff == "doom" then     
        equip_cursna(gain)
    end
end

-- Handle notifications of general user state change.
-- Called by mote-selfcommands
function job_state_change(stateField, newValue, oldValue)
    -- print(stateField.." is now ",newValue)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    --print("called job handle equipping gear")
end

--Arminhammer: Combat forms should be used to determine DW and Haste Tiering.
function update_combat_form()
    if silibs.is_dual_wielding() == true then
        combatForm = determine_haste_group()..'DW'
        if combatForm ~= state.CombatForm.value then
            state.CombatForm:set(combatForm)
            update_gear = true
        end
    elseif silibs.is_dual_wielding() == false then
        local currentCombatForm = state.CombatForm.value
        state.CombatForm:reset()
        if state.CombatForm.value ~= currentCombatForm then
            update_gear = true
        end
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        local custom_spell_map = default_spell_map
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                custom_spell_map = 'CureWeather'
            else
                custom_spell_map = 'CureNormal'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                custom_spell_map = "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
                if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
                    custom_spell_map = "MndEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    custom_spell_map = "MndEnfeeblesEffect"
                else
                    custom_spell_map = "MndEnfeebles" 
                    -- custom_spell_map = "MndEnfeeblesAcc"
              end
            elseif spell.type == "BlackMagic" then
                if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
                    custom_spell_map = "IntEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    custom_spell_map = "IntEnfeeblesEffect"
                elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    custom_spell_map = "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    custom_spell_map = "SleepNormal" --Can't call it sleep as gs checks for sets.midcast.Sleep before calling job_get_spell_map
                else
                    custom_spell_map ="IntEnfeebles"
                end
            else
                custom_spell_map = "MndEnfeebles"
            end
        end

        --Handle DW gear sets
        if silibs.is_dual_wielding() then
            if spell.skill == 'Enfeebling Magic' then
                custom_spell_map = custom_spell_map.."DW"
            end
        end

        return custom_spell_map
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function auto_buff()
    if auto_min_buffs then
        add_enspell(min_buff_set)
        cast_buffs(min_buff_set)
    end
    if auto_max_buffs then
        add_enspell(max_buff_set)
        cast_buffs(max_buff_set)
    end
end

--Function takes in a buff set table and appends the right enspell to it. Format of buff_set is like max_buff_set
function add_enspell(buff_set)
    local day_int = windower.ffxi.get_info()
    if not day_int then return end

    day_int = day_int["day"]
    local day = res.days[day_int].en
    local enspell = enspell_to_day_element[day]
    if day and buff_set[1].buff_name ~= enspell then
        table.remove(buff_set,1)
        table.insert(buff_set,1,enspell)
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- idleSet = set_combine(idleSet,sets.idle[state.IdleMode.value])
    --Latent Refresh handling
    -- if player.mpp < 65 and player.hpp > 60 then
    --     equipRefresh = true --Keep latent refresh gear after mpp > 75 until we reach a new mpp level
    --     --print("equipping latent refresh set")
    --     idleSet = set_combine(idleSet, sets.idle.Refresh)
    -- end
    -- if equipRefresh then --Continue the refresh gear until we reach the upper limit cap.
    --     if player.mpp > 75 then --Now we've reached this limit after we triggered refresh latent gear earlier
    --         equipRefresh = false --Disable the refresh equipment
    --         --print("reverting to " .. state.IdleMode.value .." idle set")
    --         idleSet = set_combine(idleSet, sets.idle[state.IdleMode.value]) --Revert back to original idle set
    --     else --We're still recovering from the previous refresh trigger
    --         --print("Still coming out of refresh trigger")
    --         idleSet = set_combine(idleSet, sets.idle.Refresh) --Keep this gear
    --     end
    -- end
    
    if state.IdleMode.value == 'CP' then
        idleSet = set_combine(idleSet, sets.CP)
    end

    return idleSet
end

function user_customize_idle_set(idleSet)
    -- Any non-silibs modifications should go in customize_idle_set function
    return silibs.customize_idle_set(idleSet)
end

function customize_melee_set(meleeSet)
    if state.IdleMode.value == 'CP' then
        meleeSet = set_combine(meleeSet, sets.CP)
    end
	if state.CombatForm.value == "MaxHasteDW" or state.CombatForm.value =="HighHasteDW" then
		if player.equipment.main == "Kraken Club" or player.equipment.sub == "Kraken Club" then
	  		meleeSet = set_combine(meleeSet, sets.AccAccessories)
		end
	end
    return meleeSet
end

function user_customize_melee_set(meleeSet)
    -- Any non-silibs modifications should go in customize_melee_set function
    return silibs.customize_melee_set(meleeSet)
end

function user_customize_defense_set(defenseSet)
    -- Any non-silibs modifications should go in customize_defense_set function
    return silibs.customize_defense_set(defenseSet)
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()

    local msg = ''
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
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

    local s_msg = getSpecialSet()

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Special: ' ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

--Arminhammer: Previous implementation by Arislan attempted to clear gearset table when a haste group changed
--This can happen many times in combat plus the table is immutable and will only be destroyed or cleared when disengaging and re-engaging combat
--Instead, keep table as is, use combat state to set haste tiering. This avoids the persistent memory of gear tables that requires
--disengaging and re-engaging combat to update haste tiering.
--This function should return a string based on the haste tiering.
  --Haste Tier Definitions (assumed 25% Gear Haste (cap))
  -- MaxHaste - 0-25% DW to cap, 0% from gear. Requires > 48.75% haste (43.75 from Magic, 5 from Samba).
  -- SuperHaste - 36% DW to cap, 11% from gear. Requires > 43.75 haste (Magic Haste cap)
  -- HighHaste - 43% DW to cap, 18% from gear. Requires > 42.30 haste (Haste II and Honor March)
  -- MidHaste - 56% DW to cap, 31% from gear. Requires > 30.00 haste.
  -- LowHaste - 67% DW to cap, 42% from gear. Requires > 15.00 haste.
  -- NoHaste - 74% DW to cap, 49% from gear.
  --
  -- Note: Subjob NIN gives T3 DW (25 DW) in traits
function determine_haste_group()
	classes.CustomMeleeGroups:clear()
	if silibs.is_dual_wielding() == true then
    --   local job_dw = calc_dw_traits()
	  local total_haste = calc_haste()
	--   if total_haste >= 48.75 then --RDM will almost never receive haste daze due to it's incompatability with enspell
	  if total_haste >= 43.75 then
		return 'MaxHaste'
	  elseif total_haste >= 42.30 then
		return 'HighHaste'
	  elseif total_haste >= 30 then
		return 'MidHaste'
	  elseif total_haste >= 15 then
		return 'LowHaste'
	  elseif total_haste >= 0 then
		return '' --No haste so select just DW set
	  end
	end
end

function polling_loop()
    check_gear()
    update_combat_form()
    auto_buff()
    equip_gear()
end

function job_self_command(cmdParams, eventArgs)
    silibs.self_command(cmdParams, eventArgs)
    ----------- Non-silibs content goes below this line -----------

    --print("Called self command. Param 1 is: ",cmdParams[1].lower)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'maxtier' then
        if cmdParams[2]:lower() == 'cancel' then
            maxTier = nil
            add_to_chat(122, "Canceling maximum tier capping on spells.")
        elseif tonumber(cmdParams[2]) == nil then
            add_to_chat(123, "Warning: Max spell tier entered is not a number. Ignoring tier cap.")
        else
            maxTier = tonumber(cmdParams[2])
            add_to_chat(122, "Notice: Setting Max Tier to "..maxTier)
        end
    elseif cmdParams[1]:lower() == 'setengaged' then
        if state.OffenseMode:contains(cmdParams[2]) then
            state.OffenseMode.value = cmdParams[2]
        else
            add_to_chat(123, "Warning: Invalid engaged set specified: "..cmdParams[2])
        end
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'equipidle' then
        equip(sets.idle)
    elseif cmdParams[1]:lower() == 'equipcombat' then
        equip(sets.engaged[state.OffenseMode.current])
    elseif cmdParams[1]:lower() == "autominbuffs" then
        if not cmdParams[2] then
            add_to_chat(122, "Please specify on/off state for autominbuffs command")
        else
            if cmdParams[2]:lower() == "on" then
                auto_min_buffs = true
            elseif cmdParams[2]:lower() == "off" then
                auto_min_buffs = false
            elseif cmdParams[2]:lower() == "toggle" then
                auto_min_buffs = not auto_min_buffs
            end
            add_to_chat("Auto Min Buffs: "..tostring(auto_min_buffs))
        end
    elseif cmdParams[1]:lower() == "automaxbuffs" then
        if not cmdParams[2] then
            add_to_chat(122, "Please specify on/off state for automaxbuffs command")
        else
            if cmdParams[2]:lower() == "on" then
                auto_max_buffs = true
            elseif cmdParams[2]:lower() == "off" then
                auto_max_buffs = false
            elseif cmdParams[2]:lower() == "toggle" then
                auto_max_buffs = not auto_max_buffs
            end
            add_to_chat("Auto Max Buffs: "..tostring(auto_max_buffs))
        end
    end
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
        if not buffactive['light arts'] then
            send_command('input /ja "Light Arts" <me>')
        else
            add_to_chat(122,'Notice: Light Arts is already active.')
        end
    end

    if strategem == 'dark' then
        if not buffactive['dark arts'] then
            send_command('input /ja "Dark Arts" <me>')
        else
            add_to_chat(122,'Notice: Dark Arts is already active.')
        end
    end

    if strategem == 'addendum:white' then
        if not buffactive['light arts'] then
            send_command('input /ja "Light Arts" <me>')
            coroutine.sleep(2)
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Notice: Addendum: White is already active.')
        else
            add_to_chat(123,'Error. Invalid parameter :',cmdParams[2])
        end
    end

    if strategem == 'addendum:black' then
        if not buffactive['dark arts'] then
            send_command('input /ja "Dark Arts" <me>')
            coroutine.sleep(2)
            send_command('input /ja "Addendum: Dark" <me>')
        elseif buffactive['dark arts'] then
            send_command('input /ja "Addendum: Dark" <me>')
        elseif buffactive['addendum: dark'] then
            add_to_chat(122,'Notice: Addendum: Dark is already active.')
        else
            add_to_chat(123,'Error. Invalid parameter :',cmdParams[2])
        end
    end
    
    if strategem ~= 'light' and strategem ~= 'dark' then
        if buffactive['light arts'] or buffactive['addendum: white'] then
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
        empy_mult = 1.5 --from sets.midcast.SleepMaxDuration
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end


