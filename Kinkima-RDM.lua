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

  state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'Enspell')
  state.HybridMode:options('Normal', 'DT')
  state.WeaponskillMode:options('Normal')
  state.CastingMode:options('Normal', 'Seidr', 'Resistant')
  state.IdleMode:options('Normal', 'Gyve')
  state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
  state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
  state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
  state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}
  state.PhysicalDefenseMode:options('PDT')
  state.MagicBurst = M(false, 'Magic Burst')
  state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
  state.EnspellMode = M(false, 'Enspell Mode')
  state.NM = M(false, 'NM?')
  state.CP = M(false, 'Capacity Points Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Savage Blade', 'Seraph Blade', 'Black Halo', 'Enspell', 'Cleaving'}
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.Buff.Composure = buffactive.Composure or false
  state.Buff.Saboteur = buffactive.Saboteur or false
  state.Buff.Stymie = buffactive.Stymie or false

  enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
      'Frazzle II',  'Gravity', 'Gravity II', 'Silence'}
  enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
  enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}
  enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}

  enhancing_skill_spells = S{'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero',
      'Enaero II', 'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

  --Used to pick the best enspell for the current day
  enspell_to_day_element = T{
    ['Firesday']     = {type="ma", buff_id=94, buff_name="Enfire"},
    ['Lightsday']    = {type="ma", buff_id=94, buff_name="Enfire"},
    ['Darksday']     = {type="ma", buff_id=94, buff_name="Enfire"},
    ['Windsday']     = {type="ma", buff_id=96, buff_name="Enaero"},
    ['Earthsday']    = {type="ma", buff_id=97, buff_name="Enstone"},
    ['Watersday']    = {type="ma", buff_id=99, buff_name="Enwater"},
    ['Lightningday'] = {type="ma", buff_id=98, buff_name="Enthunder"},
    ['Iceday']       = {type="ma", buff_id=95, buff_name="Enblizzard"},
  }
  
  --Passed to cast_buffs() to automatically buff when desired
  --Format: [i] = {type="ma or ja", buff_id=123, buff_name="haste"}
  min_buff_set = {
    [1] = {type="ma", buff_id=94,  buff_name="Enfire"}, --An enspell must be first entry
    [2] = {type="ja", buff_id=419, buff_name="Composure"},
    [3] = {type="ma", buff_id=33,  buff_name="Haste II"},
    [4] = {type="ma", buff_id=432, buff_name="Temper II"},
    [5] = {type="ma", buff_id=43,  buff_name="Refresh III"},
    -- [6] = {type="ma", buff_id=119 , buff_name="Gain-STR"},
  }

  --Format: [i] = {type="ma or ja", buff_id=123, buff_name="haste"}
  max_buff_set = {
    [1]  = {type="ma", buff_id=94,  buff_name="Enfire"}, --An enspell must be first entry
    [2]  = {type="ja", buff_id=419, buff_name="Composure"},
    [3]  = {type="ma", buff_id=33,  buff_name="Haste II"},
    [4]  = {type="ma", buff_id=432, buff_name="Temper II"},
    [5]  = {type="ma", buff_id=43,  buff_name="Refresh III"},
    [6]  = {type="ma", buff_id=119, buff_name="Gain-STR"},
    [7]  = {type="ma", buff_id=104, buff_name="Barthunder"},
    [8]  = {type="ma", buff_id=108, buff_name="Barparalyze"},
    [9]  = {type="ma", buff_id=42,  buff_name="Regen II"},
    [10] = {type="ma", buff_id=34,  buff_name="Blaze Spikes"},
    [11] = {type="ma", buff_id=37,  buff_name="Stoneskin"},
    [12] = {type="ma", buff_id=39,  buff_name="Aquaveil"},
    [13] = {type="ma", buff_id=116, buff_name="Phalanx II"},
  }

  equipRefresh = false

  set_main_keybinds()
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  select_default_macro_book()
  update_combat_form()
  set_sub_keybinds()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Chainspell'] = {
    -- body="Vitiation Tabard +3"
  }

  -- Fast cast sets for spells (cap 80% FC).
  -- RDM has 38% FC at 2000 job points
  sets.precast.FC = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Atrophy Chapeau +2",        -- 14 [__/__,  85]
    body="Shamash Robe",              -- __ [10/__, 106]; Resist Silence+90
    hands=gear.Nyame_B_hands,         -- __ [ 7/ 7, 112]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Arete Del Luna +1",         -- __ [__/__, ___]; Resist Statuses
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.RDM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 79 FC [53 PDT/46 MDT, 603 M.Eva]
    
    -- head="Atrophy Chapeau +3",     -- 16 [__/__,  95]
    -- 81 FC [53 PDT/46 MDT, 613 M.Eva]
  }

  -- 10% cap on quick magic
  sets.precast.FC.QuickMagic = {
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands="Lethargy Gantherots +2",   -- __ [10/10,  77]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Carmine_D_feet,         --  8 [ 4/__,  80]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___]
    ear1="Odnowa Earring +1",         -- __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          --  7 [__/__, ___]
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Perimede Cape",             -- __ [__/__, ___]  4
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 81 FC [49 PDT/47 MDT, 558 M.Eva] 11 QM
    
    -- hands="Lethargy Gantherots +3",-- __ [11/11,  87]
    -- 81 FC [50 PDT/48 MDT, 568 M.Eva] 11 QM
  }

  sets.precast.FC.Impact = {
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head=empty,                       -- __ [__/__, ___]
    body="Crepuscular Cloak",         -- __ [__/__, 231]
    hands="Lethargy Gantherots +2",   -- __ [10/10,  77]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Carmine_D_feet,         --  8 [ 4/__,  80]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Lethargy Earring",          --  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.RDM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 79 FC [50 PDT/38 MDT, 538 M.Eva]
    
    -- hands="Lethargy Gantherots +3",-- __ [11/11,  87]
    -- 79 FC [51 PDT/39 MDT, 548 M.Eva]
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Oshasha's Treatise",        -- __,  5,  5,  3, __ <__, __, __> (__, __) [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 50, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 40, 65, 13, __ < 7, __, __> (__, __) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> (__, __) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 53, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    ear1="Ishvara Earring",           -- __, __, __,  2, __ <__, __, __> (__, __) [__/__, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [__/__, ___]; TP Bonus+250
    ring1="Rufescent Ring",           --  6,  7, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> (__, __) [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 20, __, 10, __ <__, __, __> (__, __) [10/__, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    -- 175 STR, 279 Acc, 330 Att, 78 WSD, 0 PDL <28 DA, 0 TA, 0 QA> (0 Crit Rate, 0 Crit Dmg) [48 PDT/38 MDT, 674 M.Eva]
  }

  -- 80% DEX. 3 hit. Can crit. Transfers fTP.
  sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
    -- ammo="Yetshila +1",            -- __, __, __, __, __ <__, __, __> ( 2,  6) [___/___, ___]
    -- head="Blistering Sallet +1",   -- 41, 53, __, __, __ < 3, __, __> (10, __) [  3/___,  53]
    body=gear.Nyame_B_body,           -- 24, 40, 65, 13, __ < 7, __, __> (__, __) [  9/  9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [  7/  7, 112]
    legs=gear.Nyame_B_legs,           -- __, 40, 65, 12, __ < 6, __, __> (__, __) [  8/  8, 150]
    -- feet="Thereoid Greaves",       -- 28, __, 25, __, __ <__, __, __> ( 4,  5) [___/___,  69]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- ear1="Mache Earring +1",       --  8, 10, __, __, __ < 2, __, __> (__, __) [___/___, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [___/___, ___]; TP Bonus+250
    -- ring1="Begrudging Ring",       -- __,  7,  7, __, __ <__, __, __> ( 5, __) [-10/-10, ___]
    ring2="Ilabrat Ring",             -- 10, __, 25, __, __ <__, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_Crit_Cape,       -- 30, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- 163 DEX, 230 Acc, 252 Att, 36 WSD, 0 PDL <28 DA, 0 TA, 0 QA> (31 Crit Rate, 11 Crit Dmg) [27 PDT/14 MDT, 523 M.Eva]
  })
  sets.precast.WS['Chant du Cygne'].MaxTP = set_combine(sets.precast.WS['Chant du Cygne'], {
    ear2="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
  })

  -- 60% STR. 4 hit. Can crit. Transfers fTP.
  sets.precast.WS['Vorpal Blade'] = {
    -- ammo="Yetshila +1",            -- __, __, __, __, __ <__, __, __> ( 2,  6) [___/___, ___]
    -- head="Blistering Sallet +1",   -- 41, 53, __, __, __ < 3, __, __> (10, __) [  3/___,  53]
    body=gear.Nyame_B_body,           -- 45, 40, 65, 13, __ < 7, __, __> (__, __) [  9/  9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [  7/  7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> (__, __) [  8/  8, 150]
    -- feet="Thereoid Greaves",       -- 13, __, 25, __, __ <__, __, __> ( 4,  5) [___/___,  69]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    ear1="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [___/___, ___]; TP Bonus+250
    -- ring1="Begrudging Ring",       -- __,  7,  7, __, __ <__, __, __> ( 5, __) [-10/-10, ___]
    ring2="Sroda Ring",               -- 15, __, __, __, __ <__, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_Crit_Cape,       -- __, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- 194 STR, 224 Acc, 227 Att, 36 WSD, 0 PDL <26 DA, 0 TA, 0 QA> (31 Crit Rate, 11 Crit Dmg) [27 PDT/14 MDT, 523 M.Eva]

    -- ear2="Lethargy Earring +2",    -- 15, __, __, __, __ < 8, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_STR_Crit_Cape,   -- 30, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
  }
  sets.precast.WS['Vorpal Blade'].MaxTP = set_combine(sets.precast.WS['Vorpal Blade'], {
    ear2="Odnowa Earring +1",         --  3, 10, __, __, __ <__, __, __> (__, __) [  3/  5, ___]
  })

  -- 50% STR/50% MND. 2 hit. Scales well with WSD, not multihit.
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ammo="Oshasha's Treatise",        -- __, __,  5,  5,  3, __ <__, __, __> (__, __) [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 26, 50, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 37, 40, 65, 13, __ < 7, __, __> (__, __) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 40, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 32, 40, 65, 12, __ < 6, __, __> (__, __) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 26, 53, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150]
    -- neck="Duelist's Torque +2",    -- __, 15, __, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ear1="Ishvara Earring",           -- __, __, __, __,  2, __ <__, __, __> (__, __) [__/__, ___]
    ear2="Moonshade Earring",         -- __, __,  4, __, __, __ <__, __, __> (__, __) [__/__, ___]; TP Bonus+250
    ring1="Rufescent Ring",           --  6,  6,  7, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __, __,  5, __ <__, __, __> (__, __) [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 30, 20, __, 10, __ <__, __, __> (__, __) [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, __, __, 15, __, __ < 5,  2, __> (__, __) [__/__, ___]
    -- 190 STR, 212 MND, 259 Acc, 345 Att, 78 WSD, 0 PDL <33 DA, 2 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]
  })
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Sherida Earring",           --  5, __, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
  })
  
  -- 70% MND/ 30% STR. 2 hit.
  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {})
  sets.precast.WS['Black Halo'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 50% MND / 30% STR. 3 hit.
  sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS['Savage Blade'],{})
  sets.precast.WS['Death Blossom'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 85% MND. 5 hit.
  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Savage Blade'],{})
  sets.precast.WS['Requiescat'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 50% MND/30% STR. Dark elemental. dStat=INT. Focus on M.Dmg, WSC (stat) where 1M.Dmg==2MND==5STR
  sets.precast.WS['Sanguine Blade'] = {
    -- ammo="Ghastly Tathlum +1",     -- __, __, 11, __, __, __, 21 [__/__, ___]
    head="Pixie Hairpin +1",          -- __, __, 27, __, __, __, __ [__/__, ___]; Dark MAB+28
    body="Lethargy Sayon +3",         -- 34, 45, 47, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 11, 45, 28, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- 25, 38, 51, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 17, 27, 25, 50,  8, 45, 20 [__/__, 147]
    neck="Sibyl Scarf",               -- __, __, 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8,  8, 10, __,  8, __ [__/__, ___]
    ear2="Regal Earring",             -- __, 10, 10, __, __,  7, __ [__/__, ___]
    ring1="Archon Ring",              -- __, __, __,  5, __, __, __ [__/__, ___]; Dark MAB+5
    ring2="Freke Ring",               -- __, __, 10, __, __,  8, __ [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- __, __, 30, 20, __, 10, 20 [10/__, ___]
    waist="Refoccilation Stone",      -- __, __, __,  4, __, 10, __ [__/__, ___]
    -- 87 STR, 173 MND, 257 INT, 260 M.Acc, 8 WSD, 229 MAB, 177 M.Dmg [43 PDT/33 MDT, 510 M.Eva]

    -- hands="Lethargy Gantherots +3",-- 16, 50, 33, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 22, 32, 30, 60, 12, 50, 30 [__/__, 157]
    -- 97 STR, 183 MND, 267 INT, 280 M.Acc, 12 WSD, 239 MAB, 197 M.Dmg [44 PDT/34 MDT, 530 M.Eva]
  }

  --Seraph blade is commonly used on single targets with Frazzle III landed.
  --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
  -- Base Magical WS Damage = floor(((152 + floor((WeaponLevel - 99) × 2.45) + WSC) × fTP) + dSTAT + MDMG Stat)
  -- Total Dmg = Base Magical WS Damage × (MAB / MDB) × WSD × WSD Boost JT × Weather+Day Bonus × Affinity × Weapon Skill Potency Bonus
  --      × Augmented Weapon Skill Potency Bonus × Staff × Potency Multipliers × Resist × Resistance Rank Reduction × TMDA
  --Priority: ftp >> MD == 0.4*(STR+MND) > MAB > WSD > Ele Aff.
  -- 40% STR/40% MND. Light elemental. No dSTAT. 
  sets.precast.WS['Seraph Blade'] = {
  -- ammo="Ghastly Tathlum +1",       -- __, __, __, __, __, 21 [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 26, 40, 11, 30, __ [ 7/ 7, 123]
    body="Lethargy Sayon +3",         -- 34, 45, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 11, 45, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- 25, 38, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 17, 27, 50,  8, 45, 20 [__/__, 147]
    neck="Baetyl Pendant",            -- __, __, __, __, 13, __ [__/__, ___]
    ear1="Regal Earring",             -- __, 10, __, __,  7, __ [__/__, ___]
    ear2="Moonshade earring",         -- __, __, __, __, __, __ [__/__, ___]; TP Bonus +250
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __, __ [__/__, ___]
    ring2="Freke Ring",               -- __, __, __, __,  8, __ [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 30, __, 10, __, __ [10/__, ___]
    waist="Skrymir Cord",             -- __, __,  5, __,  5, 30 [__/__, ___]
    -- 113 STR, 221 MND, 266 M.Acc, 34 WSD, 239 MAB, 187 M.Dmg [50 PDT/40 MDT, 633 M.Eva]
    
    -- hands="Lethargy Gantherots +3",-- 16, 50, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 22, 32, 60, 12, 50, 30 [__/__, 157]
    -- waist="Skrymir Cord +1",       -- __, __,  7, __,  7, 35 [__/__, ___]
    -- 123 STR, 231 MND, 288 M.Acc, 38 WSD, 251 MAB, 212 M.Dmg [51 PDT/41 MDT, 653 M.Eva]
  }
  sets.precast.WS['Seraph Blade'].MaxTP = set_combine(sets.precast.WS['Seraph Blade'], {
    ear2="Malignance Earring",        -- __,  8, 10, __,  8, __ [__/__, ___]
  })

  --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
  --Priority: ftp >> MD == 0.4*(DEX/INT) > MAB > WSD > Ele Aff.
  -- 40% DEX/40% INT. Wind elemental. dStat=INT.
  sets.precast.WS['Aeolian Edge'] = {
    -- ammo="Ghastly Tathlum +1",     -- __, 11, __, __, __, 21 [__/__, ___]
    head="Lethargy Chappel +2",       -- 24, 33, 51, __, 51, 21 [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- 34, 47, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 38, 28, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- __, 51, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 25, 25, 50,  8, 45, 20 [__/__, 147]
    neck="Sibyl Scarf",               -- __, 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8, 10, __,  8, __ [__/__, ___]
    ear2="Moonshade earring",         -- __, __, __, __, __, __ [__/__, ___]; TP Bonus +250
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __, __ [__/__, ___]
    ring2="Freke Ring",               -- __, 10, __, __,  8, __ [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- __, 30, 20, __, 10, 20 [10/__, ___]
    waist="Skrymir Cord",             -- __, __,  5, __,  5, 30 [__/__, ___]
    -- 121 DEX, 253 INT, 307 M.Acc, 13 WSD, 268 MAB, 228 M.Dmg [52 PDT/42 MDT, 625 M.Eva]

    -- head="Lethargy Chappel +3",    -- 29, 38, 61, __, 56, 31 [10/10, 125]
    -- hands="Lethargy Gantherots +3",-- 43, 33, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 30, 30, 60, 12, 50, 30 [__/__, 157]
    -- waist="Skrymir Cord +1",       -- __, __,  7, __,  7, 35 [__/__, ___]
    -- 136 DEX, 268 INT, 339 M.Acc, 17 WSD, 285 MAB, 263 M.Dmg [54 PDT/44 MDT, 655 M.Eva]
  }
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Regal Earring",             -- __, 10, __, __,  7, __ [__/__, ___]
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
  sets.midcast.Trust = set_combine(sets.precast.FC,{})

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to power cap) > SIRD > -DT > Enmity (to -40)
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra RDM/WHM M30 MND = 134
  -- Mithra RDM/WHM M30 VIT = 123
  -- Mithra RDM/WHM M30 Healing Magic Skill = 414
  sets.midcast.CureNormal = {
    main="Eremite's Wand +1",         -- __, __, ___,   2, ___, 25, __/__, __
    sub="Genmei Shield",              -- __, __, ___, ___, ___, __, 10/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body=gear.Kaykaus_C_body,         --  4, __, ___,  33,  20, 12, __/__, __
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +2",         -- __, 11,  15,  34,  17, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Meili Earring",             -- __, __,  10, ___, ___, __, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10, __/__,  4
    -- Kaykaus set bonus              --  6, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 10 CPII, 54 CP, 470 Heal Skill, 304 MND, 207 VIT, 116 SIRD, 42PDT/27MDT, 15 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 10 CPII, 55 CP, 472 Heal Skill, 309 MND, 212 VIT, 116 SIRD, 42PDT/27MDT, 15 -Enmity
    -- 679 Power
  }
  sets.midcast.CureNormalWeaponLock = {
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +2",         -- __, 11,  15,  34,  17, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Meili Earring",             -- __, __,  10, ___, ___, __, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10, __/__,  4
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 4 CPII, 54 CP, 470 Heal Skill, 308 MND, 218 VIT, 104 SIRD, 37PDT/32MDT, 28 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 4 CPII, 55 CP, 472 Heal Skill, 313 MND, 223 VIT, 104 SIRD, 37PDT/32MDT, 28 -Enmity
    -- 683 Power
  }
  
  sets.midcast.CureWeather = {
    main="Chatoyant Staff",           -- __, 10, ___,   5,   5, __, __/__, __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __,  5/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +2",         -- __, 11,  15,  34,  17, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Magnetic Earring",          -- __, __, ___, ___, ___,  8, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __; Weather bonus
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 4 CPII, 65 CP, 462 Heal Skill, 318 MND, 228 VIT, 102 SIRD, 42PDT/32MDT, 24 -Enmity
    -- 673 Power
  }
  sets.midcast.CureWeatherWeaponLock = {
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +2",         -- __, 11,  15,  34,  17, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Magnetic Earring",          -- __, __, ___, ___, ___,  8, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __; Weather bonus
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 0 CPII, 55 CP, 462 Heal Skill, 313 MND, 223 VIT, 102 SIRD, 37PDT/32MDT, 24 -Enmity
    -- 673 Power
  }

  sets.midcast.Cursna = {
    main="Gada",                  -- 18, __,  6
    sub="Culminus",
    ammo="Incantor Stone",        -- __, __,  2
    head=gear.Vanya_B_head,       -- 20, __, __
    body=gear.Vanya_B_body,       -- 20, __, __
    hands="Hieros Mittens",       -- __, 10, __
    legs=gear.Vanya_B_legs,       -- 20, __, __
    feet=gear.Vanya_B_feet,       -- 40,  5, __
    neck="Debilis Medallion",     -- __, 15, __
    ear1="Malignance Earring",    -- __, __,  4
    ear2="Meili Earring",         -- 10, __, __
    ring1="Haoma's Ring",         --  8, 15, __
    ring2="Menelaus's Ring",      -- 15, 20,-10
    back="Oretania's Cape +1",    -- __,  5, __
    waist="Embla Sash",           -- __, __,  5
    -- sub="Chanter's Shield",    -- __, __,  3
    -- Base stats                   416, __, __
    -- 567 Healing skill, 70 Cursna+, 10 FC; Cursna Rate = 49.13%
  }

  -- Blink used as defensive while in combat. Focus on DT, MEVA, and Duration.
  sets.midcast.Blink = {
    ammo="Staunch tathlum +1",        -- __, __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- __, 10 [ 7/ 7, 123]
    -- body="Vitiation Tabard +3",    -- 15, 15 [__/__, 100]
    hands=gear.Nyame_B_hands,         -- __, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, __ [ 8/ 8, 150]
    feet="Lethargy Houseaux +2",      -- 35, __ [__/__, 147]
    -- neck="Duelist's Torque +2",    -- 25, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  4 [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- 20, 10 [10/__, ___]
    waist="Flume Belt +1",            -- __, __ [ 4/__, ___]
    -- Traits/Gifts/Merits            -- __, 38 [__/__, ___]
    -- 95 Enh. Duration, 77 FC [PDT/MDT, 632 M.Eva]
    
    -- feet="Lethargy Houseaux +3",   -- 40, __ [__/__, 157]
    -- 100 Enh. Duration, 77 FC [PDT/MDT, 642 M.Eva]
  }

  sets.midcast.EnhancingDuration = {
    main=gear.Colada_ENH,             -- __,  4,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __, 10, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands="Atrophy Gloves +3",        -- __, 20, __ [__/__,  57]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet="Lethargy Houseaux +2",      -- 30, 35, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, 10 [10/__, ___]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, 38 [__/__, ___]
    -- 498 Enh skill, 161 Enh duration, 64 FC [33 PDT/17 MDT, 487 M.Eva]
    
    -- body="Vitiation Tabard +3",    -- 23, 15, 15 [__/__, 100]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __ [__/__, 157]
    -- 514 Enh skill, 171 Enh duration, 79 FC [33 PDT/17 MDT, 517 M.Eva]
  }

  sets.midcast.SkillEnhancing = {
    main=gear.Colada_ENH,             -- __,  4,  4 [__/__, ___]
    sub="Forfend +1",                 -- 10, __, __ [ 4/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head="Befouled Crown",            -- 16, __, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands="Atrophy Gloves +3",        -- __, 20, __ [__/__,  57]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet="Lethargy Houseaux +2",      -- 30, 35, __ [__/__, 147]
    neck="Incanter's Torque",         -- 10, __, __ [__/__, ___]
    ear1="Mimir Earring",             -- 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, 10 [10/__, ___]
    waist="Olympus Sash",             --  5, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, 38 [__/__, ___]
    -- 549 Enh skill, 99 Enh duration, 52 FC [37 PDT/17 MDT, 487 M.Eva]
    
    -- main="Pukulatmuj +1",          -- 11, __, __ [__/__, ___]
    -- body="Vitiation Tabard +3",    -- 23, 15, 15 [__/__, 100]
    -- hands="Vitiation Gloves +3",   -- 24, __, __ [__/__,  57]
    -- legs="Atrophy Tights +3",      -- 21, __, __ [__/__, 127]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __ [__/__, 157]
    -- 621 Enh skill, 75 Enh duration, 63 FC [37 PDT/17 MDT, 516 M.Eva]
  }

  -- Regen not affected by Enh Magic Skill
  -- Regen % pieces apply to base value (no LA bonus), floored, then +1.
  -- floor[(Base Regen) + sum(floor(Base Regen x %Regen bonuses)+1) x Embolden)] + LA bonus + Regen Potency from Armor + Morgelai and Musa bonus.
  -- Regen II base potency = 12 hp/tick
  sets.midcast.Regen = {
    main="Bolelabunga",               --  1, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_Regen_body,    --  3, __, 10 [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_Regen_legs,    --  3, __, __ [__/__, 107]
    feet=gear.Telchine_ENH_feet,      -- __, 10, __ [__/__, 107]
    neck="Duelist's Torque +2",       -- __, 25, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, 10 [10/__, ___]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Regen II Base Potency             12, __, __ [__/__, ___]
    -- 19 Regen Potency, 101 Enh Duration %, 25 Regen Duration [33 PDT/17 MDT, 430 M.Eva]

    -- head=gear.Telchine_Regen_head, --  3, __, __ [__/__,  75]
    -- hands=gear.Telchine_Regen_hands,-- 3, __, __ [__/__,  37]
    -- feet="Bunzi's Sabots",         -- 10, __, __ [ 6/ 6, 150]; R28
    -- 35 Regen Potency, 72 Enh Duration %, 25 Regen Duration [39 PDT/23 MDT, 449 M.Eva]
  }

  sets.midcast.RefreshOthers = {
    main=gear.Colada_ENH,             -- __,  4, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __, 10, __ [__/__,  75]
    body="Atrophy Tabard +2",         --  1, __, __ [__/__,  90]
    hands="Atrophy Gloves +3",        -- __, 20, __ [__/__,  57]
    legs="Lethargy Fuseau +2",        --  4, __, __ [__/__, 162]
    feet="Lethargy Houseaux +2",      -- __, 35, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, __ [10/__, ___]
    waist="Embla Sash",               -- __, 10, __ [__/__, ___]
    -- Refresh III potency            --  9, __, __ [__/__, ___]
    -- 14 Ref Potency, 141 Enh Duration%, 0 Ref Duration [33 PDT/17 MDT, 531 M.Eva]
    
    -- head="Amalric Coif +1",        --  2, __, __ [__/__,  86]
    -- body="Atrophy Tabard +3",      --  2, __, __ [__/__, 100]
    -- legs="Lethargy Fuseau +3",     --  4, __, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- __, 40, __ [__/__, 157]
    -- 17 Ref Potency, 136 Enh Duration%, 0 Ref Duration [33 PDT/17 MDT, 562 M.Eva]
  }
  sets.midcast.RefreshSelf = set_combine(sets.midcast.RefreshOthers, {
    waist="Gishdubar Sash",           -- __, __, 20 [__/__, ___]
    -- 17 Ref Potency, 126 Enh Duration%, 20 Ref Duration [33 PDT/17 MDT, 562 M.Eva]
  })
  -- Empy set effect adds enh duration under Composure only on non-self targets
  sets.midcast.RefreshOthersComp = set_combine(sets.midcast.RefreshOthers, {})

  -- Stoneskin caps at a really low skill cap. At 99, you're capped with zero skill gear.
  -- Stoneskin caps at 350. +Stoneskin gear has no limit. Current max is 475
  -- Focus on DT, M.Eva, and FC for survivability while in combat
  sets.midcast.Stoneskin = {
    main=gear.Colada_ENH,             -- __,  4,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- __, __, 10 [ 7/ 7, 123]
    body="Lethargy Sayon +3",         -- __, __, __ [14/14, 136]
    hands=gear.Nyame_B_hands,         -- __, __, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, __, __ [ 8/ 8, 150]
    feet="Lethargy Houseaux +2",      -- __, 35, __ [__/__, 147]
    neck="Nodens Gorget",             -- 30, __, __ [__/__, ___]
    ear1="Earthcry Earring",          -- 10, __, __ [__/__, ___]
    ear2="Lethargy Earring",          -- __,  7,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, 10 [10/__, ___]
    waist="Siegel Sash",              -- 20, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --350, __, 38 [__/__, ___]
    -- 410 Stoneskin+, 76 Enh duration, 69 FC [66 PDT/48 MDT, 668 M.Eva]
    
    -- hands="Stone Mufflers",        -- 30, __, __ [__/__, ___]
    -- legs="Shedir Seraweels",       -- 35, __, __ [__/__, ___]
    -- feet="Lethargy Houseaux +3",   -- __, 40, __ [__/__, 157]
    -- 475 Stoneskin+, 81 Enh duration, 69 FC [51 PDT/33 MDT, 416 M.Eva]
  }

  -- Skill caps at 500 Enhancing Magic skill for a total of Phalanx+35.
  sets.midcast.PhalanxSelf = {
    -- main="Sakpata's Sword",            --  5, __, __ [10/10, ___]
    sub="Ammurapi Shield",                -- __, __, 10 [__/__, ___]
    ammo="Staunch Tathlum +1",            -- __, __, __ [ 3/ 3, ___]
    head=gear.Merl_Phalanx_head,          --  5, __, __ [__/__,  86]
    body=gear.Telchine_ENH_body,          -- __, 12, 10 [__/__,  80]
    hands="Atrophy Gloves +3",            -- __, __, 20 [__/__,  57]
    legs=gear.Telchine_ENH_legs,          -- __, __, 10 [__/__, 128]
    feet=gear.Merl_Phalanx_feet,          --  4, __, __ [__/__, 118]
    neck="Incanter's Torque",             -- __, 10, __ [__/__, ___]
    ear1="Mimir Earring",                 -- __, 10, __ [__/__, ___]
    ear2="Odnowa Earring +1",             -- __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",           -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",               -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,               -- __, __, 20 [10/__, ___]
    waist="Olympus Sash",                 -- __,  5, __ [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __ [__/__, ___]
    -- Master Levels                      -- __, __, __ [__/__, ___]
    -- 48 Phalanx+, 493 Enh Skill, 70 Enh duration [43 PDT/27 MDT, 469 M.Eva]
    
    -- main="Sakpata's Sword",            --  5, __, __ [10/10, ___]
    -- sub="Ammurapi Shield",             -- __, __, 10 [__/__, ___]
    -- ammo="Staunch Tathlum +1",         -- __, __, __ [ 3/ 3, ___]
    -- head=gear.Merl_Phalanx_head,       --  5, __, __ [__/__,  86]
    -- body=gear.Merl_Phalanx_body,       --  5, __, __ [ 2/__,  91]
    -- hands=gear.Chironic_Phalanx_hands, --  5, 15, __ [__/__,  48]
    -- legs=gear.Merl_Phalanx_legs,       --  5, __, __ [__/__, 118]
    -- feet=gear.Chironic_Phalanx_feet,   --  5, __, __ [ 2/__, 118]
    -- neck="Incanter's Torque",          -- __, 10, __ [__/__, ___]
    -- ear1="Mimir Earring",              -- __, 10, __ [__/__, ___]
    -- ear2="Odnowa Earring +1",          -- __, __, __ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",        -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",            -- __, __, __ [10/10, ___]
    -- back=gear.RDM_ENH_Cape,            -- __, __, 20 [10/__, ___]
    -- waist="Olympus Sash",              -- __,  5, __ [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __ [__/__, ___]
    -- Master Levels                      -- __,  4, __ [__/__, ___]
    -- 65 Phalanx+, 500 Enh Skill, 30 Enh duration [47 PDT/27 MDT, 461 M.Eva]
    
    -- main="Sakpata's Sword",            --  5, __, __ [10/10, ___]
    -- sub="Ammurapi Shield",             -- __, __, 10 [__/__, ___]
    -- ammo="Staunch Tathlum +1",         -- __, __, __ [ 3/ 3, ___]
    -- head=gear.Merl_Phalanx_head,       --  5, __, __ [__/__,  86]
    -- body=gear.Merl_Phalanx_body,       --  5, __, __ [ 2/__,  91]
    -- hands=gear.Chironic_Phalanx_hands, --  5, 15, __ [__/__,  48]
    -- legs=gear.Merl_Phalanx_legs,       --  5, __, __ [__/__, 118]
    -- feet=gear.Chironic_Phalanx_feet,   --  5, __, __ [ 2/__, 118]
    -- neck="Duelist's Torque +2",        -- __, __, 25 [__/__, ___]
    -- ear2="Lethargy Earring +2",        -- __, __,  9 [__/__, ___]
    -- ear2="Odnowa Earring +1",          -- __, __, __ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",        -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",            -- __, __, __ [10/10, ___]
    -- back=gear.RDM_ENH_Cape,            -- __, __, 20 [10/__, ___]
    -- waist="Embla Sash",                -- __, __, 10 [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __ [__/__, ___]
    -- Master Levels                      -- __, 29, __ [__/__, ___]
    -- 65 Phalanx+, 500 Enh Skill, 74 Enh duration [47 PDT/27 MDT, 461 M.Eva]
  }
  -- Skill caps at 500 Enhancing Magic skill for a total of Phalanx+35.
  sets.midcast.PhalanxOthers = set_combine(sets.midcast.EnhancingDuration,{})
  sets.midcast.PhalanxOthersComp = {
    main=gear.Colada_ENH,             -- __,  4,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head="Lethargy Chappel +2",       -- __, __, __ [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- __, __, __ [14/14, 136]
    hands="Atrophy Gloves +3",        -- __, 20, __ [__/__,  57]
    legs="Lethargy Fuseau +2",        -- __, __, __ [__/__, 152]
    feet="Lethargy Houseaux +2",      -- 30, 35, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, 10 [10/__, ___]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, 38 [__/__, ___]
    -- Empy set bonuses                  __, 35, __ [__/__, ___]
    -- 486 Enh skill, 166 Enh duration, 64 FC [56 PDT/40 MDT, 607 M.Eva]
    
    -- main=gear.Colada_ENH,          -- __,  4,  4 [__/__, ___]
    -- sub="Ammurapi Shield",         -- __, 10, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __ [ 3/ 3, ___]
    -- head="Lethargy Chappel +3",    -- __, __, __ [10/10, 125]
    -- body="Vitiation Tabard +3",    -- 23, 15, 15 [__/__, 100]
    -- hands="Atrophy Gloves +3",     -- __, 20, __ [__/__,  57]
    -- legs="Lethargy Fuseau +3",     -- __, __, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __ [__/__, 157]
    -- neck="Duelist's Torque +2",    -- __, 25, __ [__/__, ___]
    -- ear1="Odnowa Earring +1",      -- __, __, __ [ 3/ 5, ___]
    -- ear2="Lethargy Earring",       -- __,  7,  7 [__/__, ___]
    -- ring1="Gelatinous Ring +1",    -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___]
    -- back=gear.RDM_ENH_Cape,        -- __, 20, 10 [10/__, ___]
    -- waist="Embla Sash",            -- __, 10,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, 38 [__/__, ___]
    -- Empy set bonuses                  __, 20, __ [__/__, ___]
    -- 514 Enh skill, 171 Enh duration, 79 FC [43 PDT/27 MDT, 601 M.Eva]
    
    -- main=gear.Colada_ENH,          -- __,  4,  4 [__/__, ___]
    -- sub="Ammurapi Shield",         -- __, 10, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __ [ 3/ 3, ___]
    -- head="Lethargy Chappel +3",    -- __, __, __ [10/10, 125]
    -- body="Lethargy Sayon +3",      -- __, __, __ [14/14, 136]
    -- hands="Atrophy Gloves +3",     -- __, 20, __ [__/__,  57]
    -- legs="Lethargy Fuseau +3",     -- __, __, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __ [__/__, 157]
    -- neck="Duelist's Torque +2",    -- __, 25, __ [__/__, ___]
    -- ear1="Odnowa Earring +1",      -- __, __, __ [ 3/ 5, ___]
    -- ear2="Lethargy Earring",       -- __,  7,  7 [__/__, ___]
    -- ring1="Gelatinous Ring +1",    -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___]
    -- back=gear.RDM_ENH_Cape,        -- __, 20, 10 [10/__, ___]
    -- waist="Embla Sash",            -- __, 10,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, 38 [__/__, ___]
    -- Empy set bonuses                  __, 35, __ [__/__, ___]
    -- Master levels                      9
    -- 500 Enh skill, 171 Enh duration, 64 FC [57 PDT/41 MDT, 637 M.Eva]
  }

  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    ammo="Staunch Tathlum +1",
    -- head="Amalric Coif +1",
    hands="Regal Cuffs",
    -- legs="Shedir seraweels",
    ear1="Halasz Earring",
    ring2="Freke Ring",
    ring1="Evanescence Ring",
    -- waist="Emphatikos Rope",
  })

  sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration,{})
  sets.midcast.GainSpell = {
    -- hands="Vitiation Gloves +3"
  }
  sets.midcast.SpikesSpell = {
    -- legs="Vitiation Tights +3"
  }

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring2="Sheltered Ring"
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shell = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell,{})

  --Slow, Slow II, Paraylze, Addle (all tiers)
  sets.midcast.MndEnfeebles = { --Max MND but balance macc for landing
    -- main="Crocea Mors",  --50
    sub={name="Ammurapi Shield", priority=1}, --38
    ammo="Regal Gem", --Pot+10
    -- head="Vitiation Chapeau +3",
    body="Lethargy Sayon +3",
    hands="Lethargy Gantherots +2",
    -- hands="Lethargy Gantherots +3", --52macc, 24 skill
    -- legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
    -- feet="Vitiation Boots +3",
    -- neck="Duelist's Torque +2",
    ear1="Malignance Earring",
    ear2="Snotra Earring",
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1", --16 MND vs Stikini 8 MND. 14 Macc vs 11+8skill so about 4 macc less
    back=gear.RDM_MND_Enf_Cape, --20macc, 30 MND
    waist="Obstinate Sash", --5% dur, 5skill, 15 macc
    -- Enf. Effect, Enf. Duration, Enf. Skill, M.Acc skill, M.Acc, MND
  }

  sets.midcast.MndEnfeeblesDW = set_combine(sets.midcast.MndEnfeebles, {
    main={name="Daybreak", priority=1},
    sub="Maxentius",
  })

  --Spells that don't vary potency based on skill
  --'Silence'
  sets.midcast.MndEnfeeblesAcc = {
    --Option 1: Best Mythic
    -- main="Murgleis" --RDM Mythic 255+40+aftermath
    -- main="Crocea Mors",  --50 + 255
    sub={name="Ammurapi Shield", priority=1}, --38
    -- range="Ullr",
    -- ammo=empty,
    -- head="Vitiation Chapeau +3",
    body="Atrophy Tabard +2",
    hands="Lethargy Gantherots +2",
    -- hands="Lethargy Gantherots +3", --62 macc, 29skill, 11DT
    -- legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
    -- feet="Vitiation Boots +3",
    -- neck="Duelist's Torque +2", --25% dur
    ear1="Snotra Earring",
    ear2="Regal Earring", --Set bonus with atrophy gear: +15 macc (total +30 macc)
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
    back="Aurist's Cape +1",
    waist="Obstinate Sash", --5% dur, 5skill, 15 macc
    -- AF set bonus
    -- Enf. Effect, Enf. Duration, Enf. Skill, M.Acc skill, M.Acc, MND
    
    -- body="Atrophy Tabard +3",
  } 

  sets.midcast.MndEnfeeblesAccDW = set_combine(sets.midcast.MndEnfeeblesAcc, {
    -- main={name="Crocea Mors", priority=1},  --(255)+50
    -- sub="Demersal Degen +1", --40 bonus magic acc
  })

  sets.midcast.MndEnfeeblesEffect = set_combine(sets.midcast.MndEnfeebles, { --Dia (all tiers) --TODO: Check gear
    ammo="Regal Gem",
    body="Lethargy Sayon +3",
    -- feet="Vitiation Boots +3",
    -- neck="Duelist's Torque +2",
    back=gear.RDM_MND_Enf_Cape, --+10 enf pot makes this better than aurist's
  })

  sets.midcast.MndEnfeeblesEffectDW = set_combine(sets.midcast.MndEnfeeblesEffect, {
    main={name="Daybreak", priority=1}, 
    sub="Maxentius",
  })

  --Distract III, Frazzle III, Inundation
  sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, { --Balanced INT and Macc
    -- ammo="Ghastly Tathlum +1",
    waist="Obstinate Sash", --5% dur, 5skill, 15 macc
    legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
    back=gear.RDM_INT_Enf_Cape,
    ear2="Regal Earring",
    --299 Macc + 552 Enfeebling skill = 851, 369 INT

    -- ear2="Lethargy Earring +2",
  })

  sets.midcast.IntEnfeeblesDW = set_combine(sets.midcast.IntEnfeebles, {}) 

  --'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
  --'Frazzle II',  'Gravity', 'Gravity II', 
  sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.MndEnfeeblesAcc, { --Max Acc with less Int
  }) --483 Macc + 96 augments/set bonus + 574 Enfeebling skill = 1098 + 255 = 1408 , 365 INT

  sets.midcast.IntEnfeeblesAccDW = set_combine(sets.midcast.IntEnfeeblesAcc, {
    -- main={name="Crocea Mors", priority=1},  --255+50
    sub="Daybreak", --40 bonus magic acc
  })

  sets.midcast.IntEnfeeblesEffect = set_combine(sets.midcast.IntEnfeebles, { --Blind potency set. --Good. Verified 9/10/21
    ammo="Regal Gem",
    range=empty,
    body="Lethargy Sayon +3",
    -- feet="vitiation boots +3",
    -- neck="Duelist's Torque +2",
    back=gear.RDM_INT_Enf_Cape, --Better and aurists's because includes enfeeb magic effect +10
  }) --Check macc

  sets.midcast.IntEnfeeblesEffectDW = set_combine(sets.midcast.IntEnfeeblesEffect, {
    -- main={name="Crocea Mors", priority=1},  --255+50
    sub="Daybreak", --40 bonus magic acc
  })

  --Skill max is 625 is the highest needed.
  --Distract III (610), Frazzle III (625), Poison II
  sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, { 
    main="Contemplator +1", --20skill, 70macc, 228 macc skill
    sub="Enki Strap", --10macc
    ammo="Regal Gem", --10% pot
    -- head="Vitiation Chapeau +3", --24
    body="Atrophy Tabard +2", --19
    hands=gear.Kaykaus_C_hands, --16, 53macc
    -- legs=gear.Chironic_MACC_legs, --20+36 macc, 13skill
    -- feet="Vitiation Boots +3", --16
    -- neck="Duelist's torque +2", --10% pot
    ear1="Regal Earring", --15Macc with Atrophy Gear
    ear2="Snotra Earring", --10% Dur
    ring1="Kishar Ring", --10% dur
    ring2="Stikini Ring +1", --8
    back=gear.RDM_INT_Enf_Cape, --10% pot
    waist="Obstinate Sash", --5% dur, 5skill, 15 macc
    
    -- body="Atrophy Tabard +3", --21
  })--355 Macc + 146 aug macc + 30 M.Acc AF Bonus + 625 Enfeebling Skill + 228 macc skill = 1384 (Enfeeb == Macc according to wikia)

  sets.midcast.SkillEnfeeblesDW = set_combine(sets.midcast.SkillEnfeebles, {
    -- main={name="Crocea Mors", priority=1},  --255+50
    sub="Daybreak", --40 bonus magic acc
  })
    
  sets.midcast.SleepNormal = set_combine(sets.midcast.IntEnfeeblesAcc, {
    -- head="Vitiation Chapeau +3",
    -- neck="Duelist's Torque +2",
    ear2="Snotra Earring",
    ring1="Kishar Ring",
    back=gear.RDM_INT_Enf_Cape, --Better and aurists's because includes enfeeb magic effect +10
  })

  sets.midcast.SleepNormalDW = set_combine(sets.midcast.SleepNormal, {
    -- main={name="Crocea Mors", priority=1},  --255+50
    sub="Daybreak", --40 bonus magic acc
  })

  sets.midcast.SleepMaxDuration = set_combine(sets.midcast.SleepNormal, {
    head="Lethargy Chappel +2",
    body="Lethargy Sayon +3",
    hands="Regal Cuffs",
    legs="Lethargy Fuseau +2",
    feet="Lethargy Houseaux +2",
    
    -- head="Lethargy Chappel +3",
    -- legs="Lethargy Fuseau +3",
    -- feet="Lethargy Houseaux +3",
  })

  sets.midcast.SleepMaxDurationDW = set_combine(sets.midcast.SleepMaxDuration, {
    -- main={name="Crocea Mors", priority=1},  --255+50
    sub="Daybreak", --40 bonus magic acc
  })

  sets.midcast['Dark Magic'] = {
    -- main="Rubicundity",
    sub={name="Ammurapi Shield", priority=1},
    ammo="Pemphredo Tathlum",
    head="Atrophy Chapeau +2",
    -- body="Carm. Sc. Mail +1",
    hands=gear.Kaykaus_C_hands,
    -- legs="Ea Slops +1",
    feet="Malignance Boots", --Macc
    neck="Erra Pendant",
    ear1="Malignance Earring",
    -- ear2="Mani Earring",
    ring1="Stikini Ring +1",
    ring2="Evanescence Ring", --2 more skill but less acc than stikini
    back="Aurist's Cape +1",
    waist="Obstinate Sash", --5% dur, 5skill, 15 macc

    -- head="Atrophy Chapeau +3",
  }

  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
    head="Pixie Hairpin +1",
    -- feet="Merlinic Crackows",
    -- ear1="Hirudinea Earring",
    ring1="Archon Ring",
    ring2="Evanescence Ring",
    back="Perimede Cape",
    waist="Fucho-no-obi",
  })

  sets.midcast.Aspir = set_combine(sets.midcast.Drain,{})

  --Magic acc + Dark Skill
  sets.midcast.Stun = { --When using chainspell, this has to be in precast.
    -- main={name="Crocea Mors", priority=1},  --122(255)+50
    sub={name="Ammurapi Shield", priority=1}, --38 bonus magic acc
    -- range="Ullr", --40
    -- ammo=empty,
    head="Atrophy Chapeau +2", --44
    body="Atrophy Tabard +2", --45
    hands=gear.Kaykaus_C_hands, --33+20
    -- legs=gear.Chironic_MACC_legs, --56 macc
    feet="Malignance Boots", --50
    -- neck="Duelist's Torque +2", --30
    ear1="Malignance Earring", --10
    ear2="Regal Earring",  --15 set bonus
    ring1="Stikini Ring +1", --8+11
    ring2="Stikini Ring +1", --8+11
    back="Aurist's Cape +1", --33
    waist="Obstinate Sash", -- 15 macc
    
    -- head="Atrophy Chapeau +3", --54+17
    -- body="Atrophy Tabard +3", --55
  } --496 Macc + 30 macc set bonus + 352 Drk Magic = 893 effective macc

  sets.midcast['Elemental Magic'] = {
    main={name="Bunzi's Rod", priority=1},
    sub="Daybreak",
    -- ammo="Ghastly Tathlum +1",
    head="Lethargy Chappel +2",
    body="Lethargy Sayon +3",
    hands="Lethargy Gantherots +2",
    legs="Lethargy Fuseau +2",
    feet="Lethargy Houseaux +2",
    neck="Sibyl Scarf",
    ear1="Malignance Earring",
    ear2="Regal Earring",
    ring1="Metamorph Ring +1",
    ring2="Freke Ring",
    back=gear.RDM_MAB_Cape, -- MAB is much stronger
    waist="Refoccilation Stone",
    
    -- head="Lethargy Chappel +3",
    -- hands="Agwu's Gages", -- R30
    -- legs="Lethargy Fuseau +3",
    -- feet="Lethargy Houseaux +3",
  }

  --Not used often
  sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
    body="Seidr Cotehardie",
    waist="Acuity Belt +1",
  })

  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    -- range="Ullr",
    -- ammo=empty,
    waist="Acuity Belt +1",
  })

  sets.midcast.Impact = set_combine(sets.midcast.MndEnfeeblesAcc, {
    head=empty,
    body="Crepuscular Cloak",
    ring1="Archon Ring",
    waist="Shinjutsu-no-Obi +1",
  })

  -- Job-specific buff sets
  sets.buff.ComposureOther = {
    main=gear.Colada_ENH, --4
    sub={name="Ammurapi Shield", priority=1}, --10
    head="Lethargy Chappel +2",
    body="Lethargy Sayon +3",
    hands="Atrophy Gloves +3", --20
    legs="Lethargy Fuseau +2",
    feet="Lethargy Houseaux +2", --35
    -- neck="Duelist's Torque +2", --25
    ear1="Malignance Earring", --4FC
    ear2="Lethargy Earring", --7
    ring1="Gelatinous Ring +1", --7PDT, -1MDT
    ring2="Defending Ring", --10 DT
    back=gear.RDM_ENH_Cape, --20
    waist="Embla Sash", --10
    
    -- head="Lethargy Chappel +3",
    -- legs="Lethargy Fuseau +3",
    -- feet="Lethargy Houseaux +3", --35
  }

  sets.buff.Saboteur = {
    hands="Lethargy Gantherots +2",
    -- hands="Lethargy Gantherots +3",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.HeavyDef = {
    main="Mpaca's Staff",             -- __/__, ___ [ 2]
    sub="Enki Strap",                 -- __/__,  10 [__]
    ammo="Staunch Tathlum +1",        --  3/ 3, ___ [__]; Resist Status+11
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",        --  6/ 6, ___ [__]; DEF+60
    ear1="Odnowa Earring +1",         --  3/ 5, ___ [__]
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Gelatinous Ring +1",       --  7/-1, ___
    ring2="Defending Ring",           -- 10/10, ___
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___; Ele Resist+15
    -- PDT/MDT, M.Eva [Refresh]
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})

  sets.magic_burst = { --Cap 40
    head=gear.Nyame_B_head, --5
    body=gear.Nyame_B_body, --7
    hands=gear.Nyame_B_hands, --5
    legs=gear.Nyame_B_legs, --6
    feet=gear.Nyame_B_feet, --5

    -- head="Ea Hat +1", --7/(7)
    -- body="Ea Houppe. +1", --9/(9)
    -- hands="Amalric Gages +1", --(6)
    -- legs="Ea Slops +1", --8/(8)
    -- feet="Ea Pigaches +1", --5/(5)
    -- neck="Mizu. Kubikazari", --10
    -- ring2="Mujin Band", --(5)
  } --28


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.passive_refresh = {
    main="Mpaca's Staff",             -- __/__, ___ [ 2]
    sub="Enki Strap",                 -- __/__,  10 [__]
    -- ammo="Homiliary",              -- __/__, ___ [ 1]
    head="Bunzi's Hat",               --  7/ 7, 123 [__]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Lethargy Gantherots +2",   -- 10/10,  77 [__]
    legs="Assiduity Pants +1",        -- __/__, 107 [ 2]
    feet="Volte Gaiters",             -- __/__, 142 [ 1]
    neck="Loricate Torque +1",        --  6/ 6, ___ [__]; DEF+60
    ear1="Odnowa Earring +1",         --  3/ 5, ___ [__]
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",          -- __/__, ___ [ 1]
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist+15
    -- 56 PDT / 41 MDT, 565 M.Eva [10 Refresh]
    
    -- head="Vitiation Chapeau +3",   -- __/__,  95 [ 3]
    -- hands="Lethargy Gantherots +3",-- 11/11,  87 [__]
    -- 50 PDT / 35 MDT, 547 M.Eva [13 Refresh]
    
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)

  sets.idle.Gyve = set_combine(sets.idle,{
    -- body="Gyve Doublet",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Aim for 26% gear haste. No DW. Max STP
  sets.engaged = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Ilabrat Ring",             -- __,  5, __ <__, __, __> [__/__, ___]
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___]
    -- 0 DW, 88 STP, 275 Acc <16 DA, 5 TA, 3 QA> [42 PDT/32 MDT, 674 M.Eva]
  }
  sets.engaged.MidAcc = set_combine(sets.engaged, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
  })
  sets.engaged.HighAcc = set_combine(sets.engaged, {
    -- ammo="Falcon Eye",             -- __, __, 13 <__, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
  })

  -- No Magic Haste (74% DW to cap)
  sets.engaged.DW = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Ilabrat Ring",             -- __,  5, __ <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 35 DW, 53 STP, 271 Acc <3 DA, 0 TA, 3 QA> [54 PDT/44 MDT, 601 M.Eva]
  }
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, {
    body="Malignance Tabard",
    -- neck="Lissome Necklace",
    ear2="Sherida Earring",
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    -- neck="Combatant's Torque",
    -- ear2="Telos Earring",
    -- ring1="Chirich Ring +1"
    -- ring2="Chirich Ring +1"
  })

  ---------------- 30% Magic Haste (31 DW w/ sub nin to cap) -----------------
  sets.engaged.MidHasteDW = {
    -- main={name="Crocea Mors", priority=10}, 
    -- sub="Demersal Degen +1", --Offhand DA 35% when under temper II
    -- sub="Tauret",
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- ring2="Hetairoi Ring",         -- __, __, __ <__,  2, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 31 DW, 62 STP, 271 Acc <3 DA, 2 TA, 3 QA> [44 PDT/34 MDT, 593 M.Eva]
  }
  sets.engaged.MidHasteDW.MidAcc = set_combine(sets.engaged.MidHasteDW, {
    -- neck="Lissome Necklace",       -- __,  4,  8 < 1, __, __> [__/__, ___]
    ear1="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
  })
  sets.engaged.MidHasteDW.HighAcc = set_combine(sets.engaged.MidHasteDW.MidAcc, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- ear2="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- waist="Olseni belt",
  })

  ----- 35% Magic Haste (Unsure why we have these sets. Perhaps sub dnc? Not used)--------
  sets.engaged.HighHasteDW = set_combine(sets.engaged.MidHasteDW, {})
  sets.engaged.HighHasteDW.MidAcc = set_combine(sets.engaged.MidHasteDW.MidAcc, {})
  sets.engaged.HighHasteDW.HighAcc = set_combine(sets.engaged.MidHasteDW.HighAcc, {})

  --------- 45% Magic Haste (11% DW to cap)----------------
  sets.engaged.MaxHasteDW = set_combine(sets.engaged.DW, {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    -- ring2="Hetairoi Ring",         -- __, __, __ <__,  2, __> [__/__, ___]
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 11 DW, 82 STP, 285 Acc <6 DA, 5 TA, 3 QA> [42 PDT/32 MDT, 682 M.Eva]
  })
  sets.engaged.MaxHasteDW.MidAcc = set_combine(sets.engaged.MaxHasteDW, {
    -- neck="Lissome Necklace",       -- __,  4,  8 < 1, __, __> [__/__, ___]
    ear1="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
  })
  sets.engaged.MaxHasteDW.HighAcc = set_combine(sets.engaged.MaxHasteDW.MidAcc, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
    -- ring2="Chirich Ring +1",       -- __,  6, 10 <__, __, __> [__/__, ___]
  })

  --------------- En-Spell ---------------

  -- Consider Vitiation Tights if you use enspell merits
  sets.engaged.Enspell = set_combine(sets.engaged, {
    -- main="Crocea Mors",            -- __, __, 50 <__, __, __> [__/__, ___] (50, x6, __)
    -- sub="Gleti's Knife",           -- __, __, 55 <__,  6, __> [__/__, ___] (55, __, __); R30
    -- range="Ullr",                  -- __, __, __ <__, __, __> [__/__, ___] (40, __, __)
    -- ammo=empty,                    -- __, __, __ <__, __, __> [__/__, ___] (__, __, __)
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123] (55, __, __); R30
    body="Lethargy Sayon +3",         -- __, __, 64 <__, __, __> [14/14, 136] (64, __, __)
    -- hands="Ayanmo Manopolas +2",   -- __, __, 43 <__, __, __> [ 3/ 3,  37] (43, 17, __)
    legs=gear.Nyame_B_legs,           -- __, __, 40 < 6, __, __> [ 8/ 8, 150] (40, __, __); R30
    feet=gear.Nyame_B_feet,           -- __, __, 53 < 5, __, __> [ 7/ 7, 150] (40, __, __); R30
    neck="Duelist's Torque +2",       -- __, __, __ <__, __, __> [__/__, ___] (30, __, __)
    -- ear1="Lycopodium Earring",     -- __, __, __ <__, __, __> [__/__, ___] ( 1,  2, __)
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] (__, __, __)
    -- ring1="Hetairoi Ring",         -- __, __, __ <__,  2, __> [__/__, ___] (__, __, __)
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___] (__, __, __)
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___] (__, __, __)
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___] (__, __, __)
    -- Traits/merits/gifts            -- __, __, __ <__, __, __> [__/__, ___] (90,  7, 36)
    -- 0 DW, 23 STP, 390 Acc <24 DA, 13 TA, 3 QA> [49 PDT/39 MDT, 596 M.Eva] (508 M.Acc, 26 Enspell Dmg, 36 Enh Skill)

    -- ear2="Lethargy Earring +2",    -- __, __, 20 < 8, __, __> [__/__, ___] (20, __, __)
    -- waist="Orpheus's Sash",
  })
  sets.engaged.DW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  sets.engaged.MidHasteDW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  sets.engaged.HighHasteDW.Enspell = set_combine(sets.engaged.Enspell, {})
  sets.engaged.MaxHasteDW.Enspell = set_combine(sets.engaged.Enspell, {})


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
    neck="Nicander's Necklace",     --20
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
  }

  sets.Obi = {
    waist="Hachirin-no-Obi"
  }

  sets.TreasureHunter = {
    -- legs=gear.Chironic_TH_legs, --Th+1
  }

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  --Weapon sets
  sets.WeaponSet = {}
  sets.WeaponSet['Savage Blade'] = {
    main="Naegling",
    sub="Ammurapi Shield",
  }
  sets.WeaponSet['Savage Blade'].DW = {
    main="Naegling",
    sub="Tauret",
    -- sub="Thibron",
  }
  sets.WeaponSet['Seraph Blade'] = {
    main="Naegling",
    sub="Culminus",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Seraph Blade'].DW = {
    main="Naegling",
    sub="Daybreak",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Black Halo'] = {
    main="Maxentius",
    sub="Ammurapi Shield",
  }
  sets.WeaponSet['Black Halo'].DW = {
    main="Maxentius",
    sub="Naegling",
    -- sub="Thibron",
  }
  sets.WeaponSet['Asuran Fists'] = {
    -- main="Karambit",
  }
  sets.WeaponSet['Enspell'] = {
    main="Naegling",
    sub="Ammurapi Shield",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Enspell'].DW = {
    main="Naegling",
    sub="Tauret",
    -- main="Crocea Mors",
    -- sub="Gleti's Knife",
  }
  sets.WeaponSet['Cleaving'] = {
    main="Tauret",
    sub="Culminus",
  }
  sets.WeaponSet['Cleaving'].DW = {
    main="Tauret",
    sub="Bunzi's Rod",
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
  elseif spell.english == 'Stun' and buffactive['Chainspell'] then
    equip(sets.midcast.Stun)
    eventArgs.handled = true
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- Always put this last in job_post_precast
  if in_battle_mode() then
    equip(select_weapons())
  end

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
    elseif spell.skill == 'Elemental Magic' then
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

  -- Always put this last in job_post_midcast
  if in_battle_mode() then
    equip(select_weapons())
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
    
  if in_battle_mode() then
    equip(sets.WeaponSet[state.WeaponSet.current])
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
    -- equip_prime_weapon(gain)
  elseif buff == "doom" and gain then
    equip(sets.buff.Doom)
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
  check_gear()
  update_combat_form()
  update_idle_groups()
end

--Arminhammer: Combat forms should be used to determine DW and Haste Tiering.
function update_combat_form()
end

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if (isRegening==true and player.hpp < 100) or (isRegening==false and player.hpp < 85) then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if (isRefreshing==true and player.mpp < 100) or (isRefreshing==false and player.mpp < 85) then
        classes.CustomIdleGroups:append('Refresh')
      end
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('MpSub50')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
    -- Apply time of day
    if (world.time >= (6*60) and world.time < (18*60)) then
      classes.CustomIdleGroups:append('Daytime')
      if (world.time >= (6*60) and world.time < (7*60)) then
        classes.CustomIdleGroups:append('Dawn')
      elseif (world.time >= (17*60) and world.time < (18*60)) then
        classes.CustomIdleGroups:append('Dusk')
      end
    elseif (world.time >= (18*60) or world.time < (6*60)) then
      classes.CustomIdleGroups:append('Nighttime')
    end
  end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
  if spell.action_type == 'Magic' then
    local custom_spell_map = default_spell_map
    if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
      if (world.weather_element == 'Light' and not (get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        custom_spell_map = 'CureWeather'
      else
        custom_spell_map = 'CureNormal' --Can't call it Cure as gs checks for sets.midcast.Cure before calling job_get_spell_map
      end
      
      if in_battle_mode() then
        custom_spell_map = custom_spell_map..'WeaponLock'
      end
    elseif spell.skill == 'Enfeebling Magic' then
      if enfeebling_magic_skill:contains(spell.english) then
        custom_spell_map = 'SkillEnfeebles'
      elseif spell.type == 'WhiteMagic' then
        if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
          custom_spell_map = 'MndEnfeeblesAcc'
        elseif enfeebling_magic_effect:contains(spell.english) then
          custom_spell_map = 'MndEnfeeblesEffect'
        else
          custom_spell_map = 'MndEnfeebles'
        end
      elseif spell.type == 'BlackMagic' then
        if (enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie) or state.CastingMode.value == 'Resistant' then
          custom_spell_map = 'IntEnfeeblesAcc'
        elseif enfeebling_magic_effect:contains(spell.english) then
          custom_spell_map = 'IntEnfeeblesEffect'
        elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
          custom_spell_map = 'SleepMaxDuration'
        elseif enfeebling_magic_sleep:contains(spell.english) then
          custom_spell_map = 'SleepNormal' --Can't call it sleep as gs checks for sets.midcast.Sleep before calling job_get_spell_map
        else
          custom_spell_map = 'IntEnfeebles'
        end
      else
        custom_spell_map = 'MndEnfeebles'
      end
      
      --Handle DW gear sets for enfeebling
      if silibs.is_dual_wielding() then
        if spell.skill == 'Enfeebling Magic' then
          custom_spell_map = custom_spell_map..'DW'
        end
      end
    elseif spell.skill == 'Enhancing Magic' then
      if enhancing_skill_spells:contains(spell.english) then
        custom_spell_map = 'SkillEnhancing'
      elseif spell.english:startswith('Gain') then
        custom_spell_map = 'GainSpell'
      elseif spell.english:contains('Spikes') then
        custom_spell_map = 'SpikesSpell'
      elseif spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
        if spell.target.type == 'SELF' then
          custom_spell_map = 'PhalanxSelf'
        else
          if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            custom_spell_map = 'PhalanxOthersComp'
          else
            custom_spell_map = 'PhalanxOthers'
          end
        end
      else
        if spellMap == 'Refresh' then
          if spell.target.type == 'SELF' then
            custom_spell_map = 'RefreshSelf'
          else
            if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
              custom_spell_map = 'RefreshOthersComp'
            else
              custom_spell_map = 'RefreshOthers' --Can't call it Refresh as gs checks for sets.midcast.Refresh before calling job_get_spell_map
            end
          end
        else
          if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            custom_spell_map = 'ComposureOther'
          else
            custom_spell_map = 'EnhancingDuration'
          end
        end
        custom_spell_map = 'EnhancingDuration'
      end
    end

    return custom_spell_map
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Calculate if need TP bonus
  local buffer = 100
  -- Start TP bonus at 0 and accumulate based on equipped gear
  local tp_bonus_from_weapons = 0
  for slot,gear in pairs(tp_bonus_weapons) do
    local equipped_item = player.equipment[slot]
    if equipped_item and gear[equipped_item] then
      tp_bonus_from_weapons = tp_bonus_from_weapons + gear[equipped_item]
    end
  end
  local buff_bonus = T{
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end


function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    -- Apply movement speed gear
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
    if state.CP.current == 'on' then
      idleSet = set_combine(idleSet, sets.CP)
    end
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  if in_battle_mode() then
    idleSet = set_combine(idleSet, select_weapons())
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  if in_battle_mode() then
    meleeSet = set_combine(meleeSet, select_weapons())
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  if in_battle_mode() then
    defenseSet = set_combine(defenseSet, select_weapons())
  end

  return defenseSet
end

function user_customize_idle_set(idleSet)
  -- Any non-silibs modifications should go in customize_idle_set function
  return silibs.customize_idle_set(idleSet)
end

function user_customize_melee_set(meleeSet)
  -- Any non-silibs modifications should go in customize_melee_set function
  return silibs.customize_melee_set(meleeSet)
end

function user_customize_defense_set(defenseSet)
  -- Any non-silibs modifications should go in customize_defense_set function
  return silibs.customize_defense_set(defenseSet)
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
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
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

  
function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'nuke' then
    handle_nuking(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'enspell' then
    send_command('@input /ma '..state.EnSpell.value..' <me>')
  elseif cmdParams[1] == 'barelement' then
    send_command('@input /ma '..state.BarElement.value..' <me>')
  elseif cmdParams[1] == 'barstatus' then
    send_command('@input /ma '..state.BarStatus.value..' <me>')
  elseif cmdParams[1] == 'gainspell' then
    send_command('@input /ma '..state.GainSpell.value..' <me>')
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
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
  local strategem = cmdParams[2]

  if strategem == 'light' then
    if state.Buff['Light Arts'] then
      send_command('input /ja "Addendum: White" <me>')
    elseif state.Buff['Addendum: White'] then
      add_to_chat(122,'Error: Addendum: White is already active.')
    else
      send_command('input /ja "Light Arts" <me>')
    end
  elseif strategem == 'dark' then
    if state.Buff['Dark Arts'] then
      send_command('input /ja "Addendum: Black" <me>')
    elseif state.Buff['Addendum: Black'] then
      add_to_chat(122,'Error: Addendum: Black is already active.')
    else
      send_command('input /ja "Dark Arts" <me>')
    end
  elseif state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
    if strategem == 'cost' then
      send_command('input /ja Penury <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Celerity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Accession <me>')
    elseif strategem == 'power' then
      send_command('input /ja Rapture <me>')
    elseif strategem == 'duration' then
      send_command('input /ja Perpetuance <me>')
    elseif strategem == 'accuracy' then
      send_command('input /ja Altruism <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Tranquility <me>')
    elseif strategem == 'skillchain' then
      add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: White" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
    if strategem == 'cost' then
      send_command('input /ja Parsimony <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Alacrity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Manifestation <me>')
    elseif strategem == 'power' then
      send_command('input /ja Ebullience <me>')
    elseif strategem == 'duration' then
      add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
    elseif strategem == 'accuracy' then
      send_command('input /ja Focalization <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Equanimity <me>')
    elseif strategem == 'skillchain' then
      send_command('input /ja Immanence <me>')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: Black" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  else
    add_to_chat(123,'No arts has been activated yet.')
  end
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_toy_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.ToyWeapons:cycle()
  elseif cycle_dir == 'back' then
    state.ToyWeapons:cycleback()
  else
    state.ToyWeapons:reset()
  end

  local mode_color = 001
  if state.ToyWeapons.current == 'None' then
    mode_color = 006
  end
  add_to_chat(012, 'Toy Weapon Mode: '..string.char(31,mode_color)..state.ToyWeapons.current)
  equip(select_weapons())
end

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      return sets.WeaponSet[state.WeaponSet.current].DW
    elseif sets.WeaponSet[state.WeaponSet.current] then
      return sets.WeaponSet[state.WeaponSet.current]
    end
  end
  return {}
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting' or state.ToyWeapons.current ~= 'None'
end

function set_sleep_timer(spell)
  local base

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
  base = base + player.merits.enfeebling_magic_duration*6

  -- Relic Head Duration Bonus
  if not ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
    base = base + player.merits.enfeebling_magic_duration*3
  end

  -- Job Points Duration Bonus
  base = base + player.job_points.rdm.enfeebling_magic_duration

  --Enfeebling duration non-augmented gear total
  local gear_mult = 1.40
  --Enfeebling duration augmented gear total
  local aug_mult = 1.25
  --Estoquer/Lethargy Composure set bonus
  --2pc = 1.1 / 3pc = 1.2 / 4pc = 1.35 / 5pc = 1.5
  local empy_mult = 1 --from sets.midcast.Sleep

  if ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
    if buffactive.Stymie then
      base = base + player.job_points.rdm.stymie_effect
    end
    empy_mult = 1.5 --from sets.midcast.SleepMaxDuration
  end

  local totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)

  -- Create the custom timer
  if spell.english == "Sleep II" then
    send_command('@timers c "Sleep II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00259.png')
  elseif spell.english == "Sleep" or spell.english == "Sleepga" then
    send_command('@timers c "Sleep ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00253.png')
  end
  add_to_chat(1, 'Base: ' ..base.. ' Merits: ' ..player.merits.enfeebling_magic_duration.. ' Job Points: ' ..player.job_points.rdm.stymie_effect.. ' Set Bonus: ' ..empy_mult)
end

function check_gear()
  if no_swap_necks:contains(player.equipment.neck) then
    locked_neck = true
  else
    locked_neck = false
  end
  if no_swap_earrings:contains(player.equipment.ear1) then
    locked_ear1 = true
  else
    locked_ear1 = false
  end
  if no_swap_earrings:contains(player.equipment.ear2) then
    locked_ear2 = true
  else
    locked_ear2 = false
  end
  if no_swap_rings:contains(player.equipment.ring1) then
    locked_ring1 = true
  else
    locked_ring1 = false
  end
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
end

windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  set_macro_page(1, 7)
end


function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind !e input /ma "Haste II" <stpc>')
  send_command('bind !\' input /ma "Refresh II" <stpc>')
  send_command('bind ^` input /ja "Composure" <me>')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind @s gs c cycle SleepMode')
  send_command('bind @e gs c toggle EnspellMode')
  send_command('bind @d gs c toggle NM')
end

function set_sub_keybinds()
  if player.sub_job == 'SCH' then
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^[ gs c scholar power')
    send_command('bind ^] gs c scholar accuracy')
    send_command('bind ^\\\\ gs c scholar cost')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !] gs c scholar duration')
    send_command('bind !\\\\ gs c scholar speed')
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')
  
  send_command('unbind !e')
  send_command('unbind !\'')
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @s')
  send_command('unbind @e')
  send_command('unbind @d')
  
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ^\\\\')
  send_command('unbind ![')
  send_command('unbind !]')
  send_command('unbind !\\\\')
end

function test()
end
