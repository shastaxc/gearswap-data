-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  silibs.use_weapon_rearm = true

  state.CP = M(false, "Capacity Points Mode")

  state.OffenseMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Seidr', 'Resistant')
  state.IdleMode:options('Normal', 'HeavyDef', 'Vagary')
  state.RearmingLock = M(false, 'Rearming Lock')
  state.MagicBurst = M(false, 'Magic Burst')
  state.StormSurge = M(false, 'Stormsurge')

  info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
  "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
  state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
  state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
  state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}

  degrade_array = {
    ['Aspirs'] = {'Aspir','Aspir II'}
  }

  update_active_strategems()

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^` input /ja Immanence <me>')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind ^- gs c scholar light')
  send_command('bind ^= gs c scholar dark')
  send_command('bind ^[ gs c scholar power')
  send_command('bind ^] gs c scholar accuracy')
  send_command('bind ^; gs c scholar speed')
  send_command('bind ![ gs c scholar aoe')
  send_command('bind !] gs c scholar duration')
  send_command('bind !; gs c scholar cost')
  send_command('bind !w input /ma "Aspir II" <t>')
  send_command('bind @h gs c cycle HelixMode')
  send_command('bind @r gs c cycle RegenMode')
  send_command('bind @s gs c toggle StormSurge')

  send_command('bind !u input /ma "Blink" <me>')
  send_command('bind !i input /ma "Stoneskin" <me>')
  send_command('bind !p input /ma "Aquaveil" <me>')
  send_command('bind !; input /ma "Regen V" <stpc>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.set_lockstyle(1)
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'RDM' then
    send_command('bind !o input /ma "Phalanx" <stpc>')
    send_command('bind !\' input /ma "Refresh" <stpc>')
  end

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')
  send_command('unbind @c')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ^;')
  send_command('unbind ![')
  send_command('unbind !]')
  send_command('unbind !;')
  send_command('unbind !w')
  send_command('unbind @h')
  send_command('unbind @r')
  send_command('unbind @s')

  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !p')
  send_command('unbind !;')

  send_command('unbind !o')
  send_command('unbind !\'')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Tabula Rasa'] = {
    -- legs="Peda. Pants +3",
  }
  sets.precast.JA['Enlightenment'] = {
    body="Peda. Gown",
    -- body="Peda. Gown +3",
  }
  -- Maximize HP+ (MP-to-HP conversion doesn't work)
  sets.precast.JA['Sublimation'] = {
    main="Siriti", --1
    sub="Genmei Shield", --10/0
    body="Peda. Gown", --2
    ear1="Savant's Earring", --1
    waist="Embla Sash", --5
    -- head="Acad. Mortar. +3", --4
    -- body="Peda. Gown +3", --5
  }

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Incantor Stone", --2
    head=gear.Psycloth_D_head, --10
    body=gear.Merl_FC_body, --14
    legs=gear.Psycloth_D_legs, --7
    feet=gear.Merl_FC_feet, --11
    back="Swith Cape +1", --4
    waist="Embla Sash", --5
    -- neck="Voltsurge Torque", --4
    -- ear2="Loquacious Earring", --2

    -- Great:
    -- main=gear.Grioavolr_FC, --11
    -- sub="Clerisy Strap +1", --3
    -- ammo="Incantor Stone", --2
    -- head="Amalric Coif +1", --11
    -- body="Pinga Tunic +1", --15
    -- hands="Acad. Bracers +3", --9
    -- legs="Pinga Pants +1", --13
    -- feet=gear.Merl_FC_feet, --12
    -- neck="Orunmila's Torque", --5
    -- ear1="Malignance Earring", --4
    -- ear2="Enchntr. Earring +1", --2
    -- ring1="Kishar Ring", --4
    -- ring2="Prolix Ring", --2
    -- back=gear.SCH_FC_Cape, --10
    -- waist="Embla Sash", --5

    -- Ideal:
    -- main="Hvergelmir", --50
    -- sub="Khonsu",
    -- body="Pinga Tunic +1", --15
    -- back=gear.SCH_FC_Cape, --10
    -- waist="Embla Sash", --5
  }

  -- Grimoire casting bonuses multiply separately from FC, allowing
  -- breaking the normal 80% cast time reduction cap.
  -- Cast Time = Base Cast Time x (1 - FC)x(1 - magian staff cast bonus)x(1 - Grimoire reduction)
  sets.precast.FC.Grimoire = set_combine(sets.precast.FC, {
    -- head="Peda. M.Board +3",
    -- feet="Acad. Loafers +3",
  })
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    -- waist="Siegel Sash",
  })
  sets.precast.FC['Enhancing Magic'].Grimoire = set_combine(sets.precast.FC.Grimoire, {
    -- waist="Siegel Sash", --8
  })
  sets.precast.FC['Elemental Magic'] = sets.precast.FC
  sets.precast.FC['Elemental Magic'].Grimoire = sets.precast.FC.Grimoire

  sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    ear2="Mendicant's Earring", --5
  })
  sets.precast.FC.Cure.Grimoire = set_combine(sets.precast.FC.Grimoire, {
    ear2="Mendicant's Earring", --5
  })
  sets.precast.FC.Curaga = sets.precast.FC.Cure
  sets.precast.FC.Curaga.Grimoire = sets.precast.FC.CureGrimoire
  sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    -- head=empty,
    -- body="Twilight Cloak",
  })
  -- Without head & body, cannot use Grimoire gear and hit 80% FC
  -- until Hvergelmir set is acquired
  sets.precast.FC.Impact.Grimoire = sets.precast.FC.Impact
  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",

    -- If using Hvergelmir in precast.FC...
    -- ammo="Incantor Stone", --2
    -- head="Amalric Coif +1", --11
    -- body="Pinga Tunic +1", --15
    -- hands="Acad. Bracers +3", --9
    -- legs="Pinga Pants +1", --13
    -- feet=gear.Merl_FC_feet, --12
    -- neck="Orunmila's Torque", --5
    -- ear1="Malignance Earring", --4
    -- ear2="Enchntr. Earring +1", --2
    -- ring1="Kishar Ring", --4
    -- ring2="Prolix Ring", --2
    -- back=gear.SCH_FC_Cape, --10
    -- waist="Embla Sash", --5
  })
  sets.precast.FC.Dispelga.Grimoire = set_combine(sets.precast.FC.Grimoire, {
    -- main="Daybreak",
    -- sub="Chanter's Shield", --3
    -- head="Amalric Coif +1", --11

    -- If using Hvergelmir in precast.FC...
    -- ammo="Incantor Stone", --2
    -- head="Amalric Coif +1", --11
    -- body="Pinga Tunic +1", --15
    -- hands="Acad. Bracers +3", --9
    -- legs="Pinga Pants +1", --13
    -- neck="Orunmila's Torque", --5
    -- ear1="Malignance Earring", --4
    -- ear2="Enchntr. Earring +1", --2
    -- ring1="Kishar Ring", --4
    -- ring2="Prolix Ring", --2
    -- back=gear.SCH_FC_Cape, --10
    -- waist="Embla Sash", --5
  })


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    -- ammo="Floestone",
    -- head="Jhakri Coronal +2",
    -- body="Jhakri Robe +2",
    -- hands="Jhakri Cuffs +2",
    -- legs=gear.Telchine_ENH_legs,
    -- feet="Jhakri Pigaches +2",
    -- neck="Fotia Gorget",
    -- ear1="Moonshade Earring",
    -- ear2="Telos Earring",
    -- ring1="Epaminondas's Ring",
    -- ring2="Rufescent Ring",
    -- back="Relucent Cape",
    -- waist="Fotia Belt",
  }

  sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {
    body="Peda. Gown",
    -- ammo="Pemphredo Tathlum",
    -- head="Pixie Hairpin +1",
    -- body="Peda. Gown +3",
    -- legs="Peda. Pants +3",
    -- feet="Merlinic Crackows",
    -- ear1="Malignance Earring",
    -- ear2="Regal Earring",
    -- ring2="Archon Ring",
    -- back=gear.SCH_MAB_Cape,
    -- waist="Sacro Cord",
  })

  -- Max MP
  sets.precast.WS['Myrkr'] = {
    ammo="Strobilus",              --  45
    legs=gear.Psycloth_D_legs,     -- 109
    -- head="Pixie Hairpin +1",       -- 120
    -- body="Academic's Gown +3",     -- 173
    -- hands="Thrift Gloves +1 ",     --  99
    -- feet=gear.Psycloth_A_feet,     -- 124
    -- neck="Dualism Collar +1",      --  60
    -- ear1="Evans Earring",          --  50
    -- ear2="Etiolation Earring",     --  50
    -- ring1="Persis ring ",          --  80
    -- ring2="Mephitas's Ring",       -- 100
    -- back="Tantalic Cape ",         --  50
    -- waist="Shinjutsu-no-Obi +1",   --  85
    -- 1145 MP

    -- Ideal:
    -- ammo="Strobilus",              --  45
    -- head="Pixie Hairpin +1",       -- 120
    -- body="Academic's Gown +3",     -- 173
    -- hands="Kaykaus Cuffs +1",      -- 100
    -- legs="Amalric Slops +1",       -- 185; Path A, B, or D
    -- feet=gear.Psycloth_A_feet,     -- 124
    -- neck="Dualism Collar +1",      --  60
    -- ear1="Evans Earring",          --  50
    -- ear2="Etiolation Earring",     --  50
    -- ring1="Mephitas's Ring +1",    -- 110
    -- ring2="Mephitas's Ring",       -- 100
    -- back="Tantalic Cape ",         --  50
    -- back=gear.SCH_MP_Cape,         --  80
    -- waist="Shinjutsu-no-Obi +1",   --  85
    -- 1332 MP
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC
  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to cap) > FC > -Enmity
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra SCH Lv99 MND = 95
  -- Mithra SCH Lv99 VIT = 91
  -- Mithra SCH Lv99 Healing Magic Skill = 386
  sets.midcast.Cure = {
    main="Arka IV",            -- __, 24, __, __, __, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- main="Daybreak",           -- __, 30, __, 30, __, __, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- body=gear.Vanya_B_body,    -- __, __, 20, 36, 23, __, __
    -- hands=gear.Vanya_B_hands,  -- __, __, 20, 33, 25, __, __
    -- legs=gear.Vanya_B_legs,    -- __, __, 20, 34, 12, __, __
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- 0 CPII, 50 CP, 130 Heal Skill, 220 MND, 91 VIT, 32 FC, 0 -Enmity
    -- 718 Power

    -- Ideal
    -- main=gear.Gada_Cure,       -- __, 18, 18, 16, __,  6, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_A_body,  --  4, __, __, 45, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __, __
    -- legs=gear.Kaykaus_A_legs,  -- __, 11, __, 42, 12,  7, __
    -- feet=gear.Kaykaus_A_feet,  -- __, 11, __, 31, 10, __,  6
    -- neck="Incanter's Torque",  -- __, __, 10, __, __, __, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Meili Earring",      -- __, __, 10, __, __, __, __
    -- ring1="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    -- ring2="Stikini Ring +1",   -- __, __,  8,  8, __, __, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 51 CP, 91 Heal Skill, 260 MND, 94 VIT, 37 FC, 6 -Enmity
    -- 700 Power
  }

  sets.midcast.CureWeather = {
    main="Chatoyant Staff",    -- __, 10, __,  5,  5, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- main="Daybreak",           -- __, 30, __, 30, __, __, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- body=gear.Vanya_B_body,    -- __, __, 20, 36, 23, __, __
    -- hands=gear.Vanya_B_hands,  -- __, __, 20, 33, 25, __, __
    -- legs=gear.Vanya_B_legs,    -- __, __, 20, 34, 12, __, __
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- 0 CPII, 50 CP, 130 Heal Skill, 220 MND, 91 VIT, 32 FC, 0 -Enmity
    -- 718 Power

    -- Ideal
    -- main="Chatoyant Staff",    -- __, 10, __,  5,  5, __, __
    -- sub="Enki Strap",          -- __, __, __, 10, __, __, __
    -- ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_A_body,  --  4, __, __, 45, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __, __
    -- legs=gear.Kaykaus_A_legs,  -- __, 11, __, 42, 12,  7, __
    -- feet=gear.Kaykaus_A_feet,  -- __, 11, __, 31, 10, __,  6
    -- neck="Incanter's Torque",  -- __, __, 10, __, __, __, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Meili Earring",      -- __, __, 10, __, __, __, __
    -- ring1="Stikini Ring +1",   -- __, __,  8,  8, __, __, __
    -- ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    -- back=gear.SCH_Cure_Cape,   -- __, 10, __, 30, __, __, __
    -- waist="Hachirin-no-Obi",   -- __, __, __, __, __, __, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 53 CP, 73 Heal Skill, 259 MND, 99 VIT, 13 FC, 6 -Enmity
    -- Plus minimum of 20% weather bonus
    -- 683 Power
  }

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to cap) > FC > -Enmity
  -- No power cap; Power = 3×MND + VIT + 3×floor(Healing Magic Skill÷5)
  -- Mithra SCH Lv99 MND = 95
  -- Mithra SCH Lv99 VIT = 91
  -- Mithra SCH Lv99 Healing Magic Skill = 386
  sets.midcast.Curaga = {
    main="Arka IV",            -- __, 24, __, __, __, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- main="Daybreak",           -- __, 30, __, 30, __, __, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- body=gear.Vanya_B_body,    -- __, __, 20, 36, 23, __, __
    -- hands=gear.Vanya_B_hands,  -- __, __, 20, 33, 25, __, __
    -- legs=gear.Vanya_B_legs,    -- __, __, 20, 34, 12, __, __
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- 0 CPII, 50 CP, 130 Heal Skill, 220 MND, 91 VIT, 32 FC, 0 -Enmity
    -- 1436 Power

    -- Ideal:
    -- main=gear.Gada_Cure,       -- __, 18, 18, 16, __,  6, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_A_body,  --  4, __, __, 45, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __, __
    -- legs=gear.Kaykaus_A_legs,  -- __, 11, __, 42, 12,  7, __
    -- feet=gear.Kaykaus_A_feet,  -- __, 11, __, 31, 10, __,  6
    -- neck="Nuna Gorget +1",     -- __, __, __,  9, __, __, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Lifestorm Earring",  -- __, __, __,  4, __, __,  1
    -- ring1="Metamorph Ring +1", -- __, __, __, 16, __, __, __
    -- ring2="Stikini Ring +1",   -- __, __,  8,  8, __, __, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- waist="Luminary Sash",     -- __, __, __, 10, __, __, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 51 CP, 61 Heal Skill, 296 MND, 91 VIT, 32 FC, 7 -Enmity
    -- 1622 Power
  }

  sets.midcast.CuragaWeather = {
    main="Chatoyant Staff",    -- __, 10, __,  5,  5, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- sub="Enki Strap",          -- __, __, __, 10, __, __, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- body=gear.Vanya_B_body,    -- __, __, 20, 36, 23, __, __
    -- hands=gear.Vanya_B_hands,  -- __, __, 20, 33, 25, __, __
    -- legs=gear.Vanya_B_legs,    -- __, __, 20, 34, 12, __, __
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- waist="Hachirin-no-Obi",   -- __, __, __, __, __, __, __
    -- 0 CPII, 50 CP, 130 Heal Skill, 220 MND, 91 VIT, 32 FC, 0 -Enmity
    -- 1436 Power

    -- main="Chatoyant Staff",    -- __, 10, __,  5,  5, __, __
    -- sub="Enki Strap",          -- __, __, __, 10, __, __, __
    -- ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_A_body,  --  4, __, __, 45, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __, __
    -- legs=gear.Kaykaus_A_legs,  -- __, 11, __, 42, 12,  7, __
    -- feet=gear.Kaykaus_A_feet,  -- __, 11, __, 31, 10, __,  6
    -- neck="Nuna Gorget +1",     -- __, __, __,  9, __, __, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Lifestorm Earring",  -- __, __, __,  4, __, __,  1
    -- ring1="Metamorph Ring +1", -- __, __, __, 16, __, __, __
    -- ring2="Stikini Ring +1",   -- __, __,  8,  8, __, __, __
    -- back=gear.SCH_Cure_Cape,   -- __, 10, __, 30, __, __, __
    -- waist="Hachirin-no-Obi",   -- __, __, __, __, __, __, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 53 CP, 43 Heal Skill, 285 MND, 96 VIT, 13 FC, 7 -Enmity
    -- 1582 Power
  }

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to cap) > FC
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra SCH Lv99 MND = 95
  -- Mithra SCH Lv99 VIT = 91
  -- Mithra SCH Lv99 Healing Magic Skill = 456 (w/ Light Arts)
  sets.midcast.Cure.LightArts = {
    main="Arka IV",            -- __, 24, __, __, __, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    body="Shango Robe",        -- __, __, __, 29, 21,  8, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    legs=gear.Psycloth_D_legs, -- __, __, __, 30, 12,  7, __
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- main="Daybreak",           -- __, 30, __, 30, __, __, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- hands="Acad. Bracers +1"   -- __, __, __, 33, 25,  5,  4
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- 0 CPII, 50 CP, 70 Heal Skill, 209 MND, 89 VIT, 52 FC, 4 -Enmity
    -- 723 Power

    -- Ideal
    -- main="Hvergelmir",         -- __, __, __, __, __, 50, __
    -- sub="Khonsu",              -- __, __, __, __, __, __,  5
    -- ammo="Esper Stone +1",     -- __, __, __, __, __, __,  5
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_D_body,  --  4,  6, __, 33, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __,  7
    -- legs=gear.Kaykaus_D_legs,  -- __, 11, __, 30, 12,  7,  6
    -- feet=gear.Kaykaus_D_feet,  -- __, 17, __, 19, 10, __,  6
    -- neck="Incanter's Torque",  -- __, __, 10, __, __, __, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Mendicant's Earring",-- __,  5, 10, __, __, __, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- ring2="Kuchekula Ring",    -- __, __, __, __, __, __,  7
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 50 CP, 55 Heal Skill, 197 MND, 91 VIT, 80 FC, 36 -Enmity
    -- 702 Power
  }

  sets.midcast.CureWeather.LightArts = {
    main="Arka IV",            -- __, 24, __, __, __, __, __
    ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    body="Shango Robe",        -- __, __, __, 29, 21,  8, __
    hands="Serpentes Cuffs",   -- __, __, __, __, __, __, __; Set: 5% CP
    legs=gear.Psycloth_D_legs, -- __, __, __, 30, 12,  7, __
    feet="Serpentes Sabots",   -- __, __, __, __, __, __, __; Set: 5% CP
    ear2="Mendicant's Earring",-- __,  5, __, __, __, __, __
    ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    waist="Embla Sash",        -- __, __, __, __, __,  5, __
    -- main="Daybreak",           -- __, 30, __, 30, __, __, __
    -- sub="Chanter's Shield",    -- __, __, __, __, __,  3, __
    -- head=gear.Vanya_B_head,    -- __, 10, 20, 27, 18, __, __
    -- hands="Acad. Bracers +1"   -- __, __, __, 33, 25,  5,  4
    -- feet=gear.Vanya_B_feet,    -- __,  5, 40, 19, 10, __, __
    -- neck="Voltsurge Torque",   -- __, __, __, __, __,  4, __
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- 0 CPII, 50 CP, 70 Heal Skill, 209 MND, 89 VIT, 52 FC, 4 -Enmity
    -- 723 Power

    -- Ideal:
    -- main="Chatoyant Staff",    -- __, 10, __,  5,  5, __, __
    -- sub="Clerisy Strap +1",    -- __, __, __, __, __,  3, __
    -- ammo="Incantor Stone",     -- __, __, __, __, __,  2, __
    -- head=gear.Kaykaus_D_head,  -- __, 11, 16, 31, 14, __, __
    -- body=gear.Kaykaus_D_body,  --  4,  6, __, 33, 20, __, __
    -- hands="Peda. Bracers +3",  --  3, __, 19, 46, 35, __,  7
    -- legs=gear.Kaykaus_D_legs,  -- __, 11, __, 30, 12,  7,  6
    -- feet=gear.Kaykaus_D_feet,  -- __, 17, __, 19, 10, __,  6
    -- neck="Orunmila's Torque",  -- __, __, __, __, __,  5,  3
    -- ear1="Malignance Earring", -- __, __, __,  8, __,  4, __
    -- ear2="Meili Earring",      -- __, __, 10, __, __, __, __
    -- ring1="Kishar Ring",       -- __, __, __, __, __,  4, __
    -- ring2="Sirona's Ring",     -- __, __, 10,  3,  3, __, __
    -- back=gear.SCH_FC_Cape,     -- __, __, __, 30, __, 10, __
    -- waist="Hachirin-no-Obi",   -- __, __, __, __, __, __, __
    -- Kaykaus set bonus          --  8, __, __, __, __, __, __
    -- 15 CPII, 55 CP, 55 Heal Skill, 205 MND, 99 VIT, 35 FC, 22 -Enmity
    -- Plus minimum of 20% weather bonus
    -- 708 Power
  }

  -- Removal rate = Base Rate * (1+(x/100)) * (1+(y/100))
  -- x = healing skill from gear; y = cursna+ stat from gear
  -- Base rate is determined by base healing magic skill (26% @500)
  sets.midcast.Cursna = {
    ammo="Incantor Stone",     -- __, __,  2
    -- main="Gada",               -- 18, __,  6
    -- sub="Chanter's Shield",    -- __, __,  3
    -- head=gear.Vanya_B_head,    -- 20, __, __
    -- body=gear.Vanya_B_body,    -- 20, __, __
    -- hands=gear.Vanya_B_hands,  -- 20, __, __
    -- legs=gear.Vanya_B_legs,    -- 20, __, __
    -- feet=gear.Vanya_B_feet,    -- 40,  5, __
    -- neck="Debilis Medallion",  -- __, 15, __
    -- ear1="Beatific Earring",   --  4, __, __
    -- ear2="Meili Earring",      -- 10, __, __
    -- ring1="Haoma's Ring",      --  8, 15, __
    -- ring2="Menelaus's Ring",   -- 15, 20,-10
    -- back="Oretania's Cape +1", -- __,  5, __
    -- waist="Bishop's Sash",     --  5, __, __
    -- 180 Healing skill, 60 Cursna+, 1 FC
    -- Rate @386 (assuming 20% base) = 89.6%
  }

  sets.midcast.Cursna.LightArts = set_combine(sets.midcast.Cursna, {
    -- legs="Academic's Pants +3",    -- 24, __,  9
    -- 184 Healing skill, 60 Cursna+, 10 FC
    -- Rate @456 (assuming 23% base) = 104.5%
  })

  -- Enh Magic Skill + Enh Magic Duration > Fast Cast
  sets.midcast['Enhancing Magic'] = {
    body="Peda. Gown",             -- 12, __, __
    waist="Embla Sash",            -- __, 10,  5
    -- main=gear.Gada_ENH,            -- 18,  6,  6
    -- sub="Ammurapi Shield",         -- __, 10, __
    -- ammo="Savant's Treatise",      --  4, __, __
    -- head=gear.Telchine_ENH_head,   -- __, 10, __
    -- body="Peda. Gown +3",          -- 19, 12, __
    -- hands=gear.Telchine_ENH_hands, -- __, 10, __
    -- legs=gear.Telchine_ENH_legs,   -- __, 10, __
    -- feet=gear.Kaykaus_D_feet,      -- 21, __,  4
    -- neck="Incanter's Torque",      -- 10, __, __
    -- ear1="Mimir Earring",          -- 10, __, __
    -- ear2="Andoaa Earring",         --  5, __, __
    -- ring1="Stikini Ring +1",       --  8, __, __
    -- ring2="Stikini Ring +1",       --  8, __, __
    -- back="Fi Follet Cape +1",      --  9, __, 10
    -- 112 Enh Skill, 68 Enh Duration, 25 FC
  }

  sets.midcast.EnhancingDuration = {
    waist="Embla Sash",            -- 10,  5
    -- main=gear.Musa_C,              -- 20, 10
    -- sub="Clerisy Strap +1",        -- __,  3
    -- head=gear.Telchine_ENH_head,   -- 10, __
    -- body="Peda. Gown +3",          -- 12, __
    -- hands=gear.Telchine_ENH_hands, -- 10, __
    -- legs=gear.Telchine_ENH_legs,   -- 10, __
    -- feet=gear.Telchine_ENH_feet,   -- 10, __
    -- 82 Enh Duration, 18 FC
  }

  -- Regen not affected by Enh Magic Skill
  sets.midcast.Regen = {
    main="Bolelabunga",            -- __, 10, __, __
    sub="Genmei Shield",           -- __, __, __, __
    waist="Embla Sash",            -- __, __, 10,  5
    -- main=gear.Musa_C,              -- 25, __, 20, __
    -- sub="Khonsu",                  -- __, __, __, __
    -- head="Arbatel Bonnet +1",      --  7, __, __, __
    -- body=gear.Telchine_ENH_body,   -- __, __, 10, 12
    -- hands=gear.Telchine_ENH_hands, -- __, __, 10, __
    -- legs=gear.Telchine_ENH_legs,   -- __, __, 10, __
    -- feet=gear.Telchine_ENH_feet,   -- __, __, 10, __
    -- back="Bookworm's Cape",        -- 10, __, __, __
    -- 42 Regen Potency, 0 Regen Potency %, 70 Enh Duration %, 17 Regen Duration
    -- Regen V (no LA) = 82 hp/tic
    -- Regen V (w/ LA) = 106 hp/tic
  }-- 0 Regen Potency, 10 Regen Potency %, 10 Enh Duration %, 5 Regen Duration

  sets.midcast.RegenDuration = set_combine(sets.midcast.Regen, {
    -- head=gear.Telchine_ENH_head,   -- __, __, 10, __
    -- back=gear.SCH_FC_Cape,         -- __, __, __, 15
    -- 0 Regen Potency, 0 Regen Potency %, 80 Enh Duration %, 45 Regen Duration
  })-- 0 Regen Potency, 0 Regen Potency %, 10 Enh Duration %, 5 Regen Duration

  sets.midcast.Haste = sets.midcast.EnhancingDuration

  -- Ref Potency > Enh Duration %, Ref Duration
  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
    -- head="Amalric Coif +1",  --  2, __, __
    -- 2 Ref Potency, 72 Enh Duration%, 0 Ref Duration
  })

  sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {
    -- waist="Gishdubar Sash",  -- __, __, 20
    -- back="Grapevine Cape",   -- __, __, 30
    -- 2 Ref Potency, 62 Enh Duration%, 50 Ref Duration
  })

  -- Stoneskin Cap, Enh Duration
  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    -- neck="Nodens Gorget",    -- 30, __, __
    -- waist="Siegel Sash",     -- 20, __, __
    -- ear1="Earthcry Earring", -- 10, __, __
    -- +60 Stoneskin Cap, 72% Enh Duration
  })

  -- Aquaveil Count > Enh Duration
  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    -- main="Vadose Rod",           --  1, __
    -- sub="Ammurapi Shield",       -- __, 10
    -- head="Amalric Coif +1",      --  2, __
    -- hands="Regal Cuffs",         --  2, 20
    -- legs="Shedir seraweels",     --  1, __
    -- waist="Emphatikos Rope",     --  1, __
    -- +6 Aquaveil, 52% Enh Duration
  })

  sets.midcast.Storm = sets.midcast.EnhancingDuration

  sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {
    feet="Peda. Loafers",
    -- feet="Peda. Loafers +3",
  })

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring2="Sheltered Ring",
  })
  sets.midcast.Protectra = sets.midcast.Protect
  sets.midcast.Shell = sets.midcast.Protect
  sets.midcast.Shellra = sets.midcast.Shell

  -- M.Acc > MND > Enfeebling Duration > Enfeebling Skill
  sets.midcast.MndEnfeebles = {
    body="Shango Robe",             -- 23, 29, __, 15
    neck="Sanctity Necklace",       -- 10, __, __, __
    -- main=gear.Gada_MND_MAcc,     -- 35, 16, __, 16; +215 M.Acc skill
    -- sub="Ammurapi Shield",       -- 38, 13, __, __
    -- ammo="Pemphredo Tathlum",    --  8, __, __, __
    -- head="Acad. Mortar. +3",     -- 52, 37, __, __
    -- body="Acad. Gown +3",        -- 50, 39, __, __; +24 enf skill in DA
    -- hands="Regal Cuffs",         -- 45, 40, 20, __
    -- legs="Acad. Pants +3",       -- 49, 39, __, __; +24 enf skill in LA
    -- feet="Acad. Loafers +3",     -- 46, 29, __, __; +20 M.Acc in Grimoire
    -- neck="Argute Stole +2",      -- 30, 15, __, __
    -- ear1="Malignance Earring",   -- 10,  8, __, __
    -- ear2="Regal Earring",        -- __, 10, __, __; Adds set bonus
    -- ring1="Kishar Ring",         --  5, __, 10, __
    -- ring2="Metamor. Ring +1",    -- 16, 15, __, __
    -- back=gear.SCH_MND_MAcc_Cape, -- 30, 20, __, __
    -- waist="Luminary Sash",       -- 10, 10, __, __
    -- Acad. set bonus              -- 60, __, __, __
    -- 504 M.Acc, 291 MND, 30% Enfeebling Duration, 40 Enfeebling Skill

    -- Ideal:
    -- main="Maxentius",            -- 40, 15, __, __; +250 M.Acc skill
    -- 489 M.Acc, 290 MND, 30% Enfeebling Duration, 24 Enfeebling Skill
  }

  -- M.Acc > INT > Enfeebling Duration > Enfeebling Skill
  sets.midcast.IntEnfeebles = {
    body="Shango Robe",             -- 23, 29, __, 15
    neck="Sanctity Necklace",       -- 10, __, __, __
    -- main=gear.Gada_INT_MAcc,     -- 35, 16, __, 16; +215 M.Acc skill
    -- sub="Ammurapi Shield",       -- 38, 13, __, __
    -- ammo="Pemphredo Tathlum",    --  8,  4, __, __
    -- head="Acad. Mortar. +3",     -- 52, 37, __, __
    -- body="Acad. Gown +3",        -- 50, 44, __, __; +24 enf skill in DA
    -- hands="Regal Cuffs",         -- 45, 40, 20, __
    -- legs="Acad. Pants +3",       -- 49, 39, __, __; +24 enf skill in LA
    -- feet="Acad. Loafers +3",     -- 46, 32, __, __; +20 M.Acc in Grimoire
    -- neck="Argute Stole +2",      -- 30, 15, __, __
    -- ear1="Malignance Earring",   -- 10,  8, __, __
    -- ear2="Regal Earring",        -- __, 10, __, __; Adds set bonus
    -- ring1="Kishar Ring",         --  5, __, 10, __
    -- ring2="Metamor. Ring +1",    -- 16, 15, __, __
    -- back=gear.SCH_INT_MAcc_Cape, -- 30, 20, __, __
    -- waist="Acuity Belt +1",      -- 15, 23, __, __
    -- Acad. set bonus              -- 60, __, __, __
    -- 509 M.Acc, 316 INT, 30% Enfeebling Duration, 40 Enfeebling Skill
    -- +147 M.Acc from skill

    -- Ideal:
    -- main="Maxentius",            -- 40, 15, __, __; +250 M.Acc skill
    -- 514 M.Acc, 315 INT, 30% Enfeebling Duration, 24 Enfeebling Skill
    -- +149 M.Acc from skill
  }

  sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
  sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",
    -- waist="Shinjutsu-no-Obi +1",
  })

  -- SCH Dark Magic = 386, with Dark Arts = 456
  -- Dark Magic Skill, INT, M.Acc
  sets.midcast['Dark Magic'] = {
    body="Shango Robe",
    -- main="Rubicundity",        -- 25, 21, 20; +215 M.Acc skill
    -- sub="Ammurapi Shield",     -- __, 13, 38
    -- ammo="Pemphredo Tathlum",  -- __,  4,  8
    -- head="Acad. Mortar. +3",   -- __, 37, 52
    -- body="Acad. Gown +3",      -- 24, 44, 50
    -- hands="Acad. Bracers +3",  -- __, 29, 48
    -- legs="Peda. Pants +3",     -- 19, 47, 39
    -- feet="Acad. Loafers +3",   -- __, 32, 46
    -- neck="Erra Pendant",       -- 10, __, 17
    -- ear1="Regal Earring",      -- __, 10, __; Adds set effect
    -- ear2="Mani Earring",       -- 10, __, __
    -- ring1="Evanescence Ring",  -- 10, __, __
    -- ring2="Stikini Ring +1",   --  8, __, 11
    -- back="Bookworm's Cape",    --  8,  5, __
    -- waist="Acuity Belt +1",    -- __, 23, __
    -- Acad. set bonus            -- __, __, 60
    -- 114 Dark magic skill, 265 INT, 389 M.Acc
  }

  -- Add Drain potency
  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
    waist="Fucho-no-obi",         --  8
    -- main="Rubicundity",        -- 20
    -- sub="Ammurapi Shield",     -- __
    -- legs="Peda. Pants +3",     -- 15
    -- ear2="Hirudinea Earring",  --  3
    -- ring1="Evanescence Ring",  -- 10
    -- 104 Dark magic skill, 242 INT, 389 M.Acc
  })

  sets.midcast.Aspir = sets.midcast.Drain

  -- FC > M.Acc > M.Acc Skill
  sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    -- back=gear.SCH_MAB_Cape,

    --Ideal:
    -- main="Hvergelmir",           -- 50, __, 269
    -- sub="Khonsu",                -- __, 30, ___
    -- ammo="Pemphredo Tathlum",    -- __,  8, ___
    -- head="Acad. Mortar. +3",     --  8, 52, ___
    -- body="Acad. Gown +3",        -- __, 50, ___
    -- hands="Acad. Bracers +3",    --  9, 48, ___
    -- legs="Acad. Pants +3",       -- __, 49, ___
    -- feet="Acad. Loafers +3",     -- __, 46, ___
    -- neck="Argute Stole +2",      -- __, 30, ___
    -- ear1="Malignance Earring",   --  4, 10, ___
    -- ear2="Dignitary's Earring",  -- __, 10, ___
    -- ring1="Stikini Ring +1",     -- __, 11, ___; +8 all skill
    -- ring2="Stikini Ring +2",     -- __, 11, ___; +8 all skill
    -- back=gear.SCH_INT_MAcc_Cape, -- 10, 30, ___
    -- waist="Acuity Belt +1",      -- __, 15, ___
    -- Acad. set bonus              -- __, 60, ___
    -- 81 FC, 460 M.Acc, 269 M.Acc Skill
  })

  sets.midcast.Stun.DarkArts = set_combine(sets.midcast.Stun, {
    --Ideal:
    -- main="Hvergelmir",           -- __, 50, __, 269
    -- sub="Khonsu",                -- __, __, 30, ___
    -- ammo="Pemphredo Tathlum",    -- __, __,  8, ___
    -- head="Peda. M.Board +3",     -- 13, __, 37, ___; Grimoire recast-
    -- body="Acad. Gown +3",        -- __, __, 50, ___; +24 Dark Magic skill in DA
    -- hands="Acad. Bracers +3",    -- __,  9, 48, ___
    -- legs="Acad. Pants +3",       -- __, __, 49, ___
    -- feet="Acad. Loafers +3",     -- 12, __, 46, ___; Grimoire recast-, +20M.Acc in Grimoire
    -- neck="Argute Stole +2",      -- __, __, 30, ___
    -- ear1="Malignance Earring",   -- __,  4, 10, ___
    -- ear2="Regal Earring",        -- __, __, __, ___; adds set effect
    -- ring1="Stikini Ring +1",     -- __, __, 11, ___; +8 all skill
    -- ring2="Stikini Ring +2",     -- __, __, 11, ___; +8 all skill
    -- back=gear.SCH_INT_MAcc_Cape, -- __, 10, 30, ___
    -- waist="Witful Belt",         -- __,  3, __, ___
    -- Acad. set bonus              -- __, __, 60, ___
    -- 25% Grimoire Recast, 76 FC, 420 M.Acc, 269 M.Acc Skill
    -- Add 10% Grimoire Recast from Dark Arts
    -- Hits 90% recast reduction cap even without Haste spell/JA
  })
  sets.midcast.Stun.LightArts = sets.midcast.Stun.DarkArts

  -- INT, Magic Acc, MAB
  -- More emphasis on INT
  sets.midcast.Kaustra = {
    main=gear.Akademos_A,         -- 32, __, 58
    neck="Sanctity Necklace",     -- __, 10, 10
    -- sub="Enki Strap",          -- 10, 10, __
    -- ammo="Pemphredo Tathlum",  --  4,  8,  4
    -- head="Peda. M.Board +3",   -- 39, 52, 49
    -- body=gear.Merl_MB_body,    -- 50, 60, 60
    -- hands=gear.Amalric_D_hands,-- 36, 20, 53
    -- legs="Mallquis Trews +2",  -- 57, 45, 15
    -- feet=gear.Merl_MB_feet,    -- 34, 40, 55
    -- neck="Argute Stole +2",    -- 15, 30, __
    -- ear1="Malignance Earring", --  8, 10,  8
    -- ear2="Regal Earring",      -- 10, __,  7
    -- ring1="Freke Ring",        -- 10, __,  8
    -- ring2="Metamor. Ring +1",  -- 16, 15, __
    -- back=gear.SCH_MAB_Cape,    -- 30, 20, 10
    -- waist="Acuity Belt +1",    -- 23, 15, __
    -- 374 INT, 315 Magic Acc, 327 MAB
  }

  -- INT, Magic Acc, MAB
  -- More emphasis on MAB
  sets.midcast['Elemental Magic'] = {
    main=gear.Akademos_A,           -- 32, __, 58
    neck="Sanctity Necklace",       -- __, 10, 10
    -- sub="Enki Strap",            -- 10, 10, __
    -- ammo="Pemphredo Tathlum",    --  4,  8,  4
    -- head="Peda. M.Board +3",     -- 39, 52, 49
    -- body=gear.Amalric_A_body,    -- 38, 53, 53
    -- hands=gear.Amalric_D_hands,  -- 36, 20, 53
    -- legs=gear.Amalric_A_legs,    -- 40, 20, 60
    -- feet=gear.Amalric_D_feet,    -- 21, 20, 52
    -- neck="Baetyl Pendant",       -- __, __, 13
    -- ear1="Malignance Earring",   --  8, 10,  8
    -- ear2="Regal Earring",        -- 10, __,  7
    -- ring1="Freke Ring",          -- 10, __,  8
    -- ring2="Metamor. Ring +1",    -- 16, 15, __
    -- back=gear.SCH_MAB_Cape,      -- 30, 20, 10
    -- waist="Refoccilation Stone", -- __,  4, 10
    -- Amalric set bonus            -- __, __, 40
    -- 294 INT, 232 Magic Acc, 425 MAB
  }

  sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
    -- head="Merlinic Hood",
    -- body="Seidr Cotehardie",
    -- legs="Peda. Pants +3",
    -- feet="Merlinic Crackows",
    -- neck="Erra Pendant",
    -- waist="Acuity Belt +1",
  })

  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    -- head="Merlinic Hood",
    -- legs="Peda. Pants +3",
    -- neck="Erra Pendant",
    -- waist="Sacro Cord",
  })

  sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
    main=gear.Akademos_A,
    -- sub="Khonsu",
    -- head=empty,
    -- body="Twilight Cloak",
    -- ring2="Archon Ring",
    -- waist="Shinjutsu-no-Obi +1",
  })

  sets.midcast.Helix = {
    main=gear.Akademos_A,
    -- sub="Enki Strap",
    -- ammo="Ghastly Tathlum +1",
    -- neck="Argute Stole +2",
    -- waist="Sacro Cord",
  }

  sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
    -- head="Pixie Hairpin +1",
    -- ring2="Archon Ring",
  })

  sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",
  })

  -- This is applied on top of other sets when appropriate
  sets.magic_burst = {
    main=gear.Akademos_A, --10
    feet=gear.Merl_MB_feet, --8
    ring1="Locus Ring", --5
    -- Ideal:
    -- main=gear.Akademos_A, --10
    -- head="Peda. M.Board +3", --(4)
    -- body=gear.Merl_MB_body, --10
    -- hands="Amalric Gages +1", --(6)
    -- feet="Merlinic Crackows", --10
    -- neck="Argute Stole +2", --10
    -- ring2="Mujin Band", --(5)
  }

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Passive sets are applied to idle in function `customize_idle_sets`
  sets.passive_regen = {
    main="Bolelabunga", --1
    back="Kumbira Cape", --1
    neck="Sanctity Necklace", --2
    -- main="Malignance Pole", --0
    -- sub="Mensch Strap +1", --3
    -- body="Pluviale", --1
    -- feet="Coalrake Sabots", --1
    -- neck="Bathy Choker +1", --1
    -- ear1="Infused Earring", --1
    -- ring1="Chirich Ring +1", --2
    -- ring2="Paguroidea Ring", --2
    -- back=gear.SCH_Regen_Cape, --5
  }
  sets.passive_regen.daytime = {
    hands="Serpentes Cuffs", --1
    -- ear2="Dawn Earring", --1
    -- waist="Lycopodium Sash", --3
  }
  sets.passive_regen.nighttime = {
    feet="Serpentes Sabots", --1
  }
  sets.passive_refresh = {
    main="Bolelabunga",
    legs="Assiduity Pants +1",
    -- main="Contemplator +1", --2
    -- sub="Oneiros Grip", --1; when mp<70%
    -- head="Befouled Crown", --1
    -- body="Jhakri Robe +2", --4
    -- hands="Volte Gloves", --1
    -- feet="Volte Gaiters", --1
    -- ring1="Stikini Ring +1", --1
    -- ring2="Stikini Ring +1", --1
  }
  sets.passive_refresh.daytime = {
    feet="Serpentes Sabots",
  }
  sets.passive_refresh.nighttime = {
    hands="Serpentes Cuffs",
  }
  sets.passive_refresh.sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.HeavyDef = {
    main="Bolelabunga",
    sub="Genmei Shield", --10/0
    head="Wayfarer Circlet",
    body="Shango Robe",
    hands="Wayfarer Cuffs",
    legs="Assiduity Pants +1",
    feet="Savant's Loafers +2",
    neck="Twilight Torque",
    ear1="Hecate's Earring",
    ear2="Savant's Earring",
    back="Cheviot Cape",
    -- main="Malignance Pole",      -- 20, 20, ___
    -- sub="Khonsu",                --  6,  6, ___
    -- ammo="Staunch Tathlum +1",   --  3,  3, ___; Resist Status+11
    -- head="Pinga Crown +1",       -- __, __, 109
    -- body="Pinga Tunic +1",       -- __, __, 128
    -- hands="Pinga Mittens +1",    -- __, __, 101
    -- legs="Pinga Pants +1",       -- __, __, 147
    -- feet="Pinga Pumps +1",       -- __, __, 147
    -- neck="Loricate Torque +1",   --  6,  6, ___; DEF+60
    -- ear1="Hearty Earring",       -- __, __, ___; Resist Status+5
    -- ear2="Etiolation Earring",   -- __,  3, ___; Resist Silence+15
    -- ring1="Gelatinous Ring +1",  --  7, -1, ___
    -- ring2="Defending Ring",      -- 10, 10, ___
    -- back="Archon Cape",          -- __, __, ___
    -- waist="Carrier's Sash",      -- __, __, ___; Ele Resist+15

    -- Ideal:
    -- main="Malignance Pole",      -- 20, 20, ___
    -- sub="Khonsu",                --  6,  6, ___
    -- ammo="Staunch Tathlum +1",   --  3,  3, ___; Resist Status+11
    -- head="Volte Cap",            -- __, __, 102; Resist Status+10
    -- body="Pinga Tunic +1",       -- __, __, 128
    -- hands="Volte Bracers",       -- __, __, 102; Resist Status+10
    -- legs="Pinga Pants +1",       -- __, __, 147
    -- feet="Pinga Pumps +1",       -- __, __, 147
    -- neck="Loricate Torque +1",   --  6,  6, ___; DEF+60
    -- ear1="Hearty Earring",       -- __, __, ___; Resist Status+5
    -- ear2="Etiolation Earring",   -- __,  3, ___; Resist Silence+15
    -- ring1="Gelatinous Ring +1",  --  7, -1, ___
    -- ring2="Defending Ring",      -- 10, 10, ___
    -- back="Archon Cape",          -- __, __, ___
    -- waist="Carrier's Sash",      -- __, __, ___; Ele Resist+15
    -- 52 PDT / 47 MDT, 626 M.Eva
  }

  sets.idle = sets.HeavyDef
  sets.idle.HeavyDef = set_combine(sets.idle, sets.HeavyDef)
  sets.idle.Weak = sets.HeavyDef

  sets.idle.Vagary = sets.midcast['Elemental Magic']

  sets.resting = set_combine(sets.idle, {
    main="Chatoyant Staff",
    -- waist="Shinjutsu-no-Obi +1",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    feet="Peda. Loafers",
    -- head="Peda. M.Board +3",
    -- body="Jhakri Robe +2",
    -- hands="Raetic Bangles +1",
    -- legs="Peda. Pants +3",
    -- feet="Peda. Loafers +3",
    -- neck="Combatant's Torque",
    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
    -- ring1="Hetairoi Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- back="Relucent Cape",
    -- waist="Windbuffet Belt +1",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff['Ebullience'] = {
    -- head="Arbatel Bonnet +1",
  }
  sets.buff['Rapture'] = {
    -- head="Arbatel Bonnet +1",
  }
  sets.buff['Perpetuance'] = {
    -- hands="Arbatel Bracers +1",
  }
  sets.buff['Immanence'] = {
    -- hands="Arbatel Bracers +1",
    -- back="Lugh's Cape",
  }
  sets.buff['Penury'] = {
    -- legs="Arbatel Pants +1",
  }
  sets.buff['Parsimony'] = {
    -- legs="Arbatel Pants +1",
  }
  sets.buff['Celerity'] = {
    feet="Peda. Loafers",
    -- feet="Peda. Loafers +3",
  }
  sets.buff['Alacrity'] = {
    feet="Peda. Loafers",
    -- feet="Peda. Loafers +3",
  }
  sets.buff['Klimaform'] = {
    -- feet="Arbatel Loafers +1",
  }

  sets.buff.FullSublimation = sets.precast.JA['Sublimation']

  sets.buff.Doom = {
    -- neck="Nicander's Necklace", --20
    -- ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
    -- ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
    -- waist="Gishdubar Sash", --10
  }

  sets.LightArts = {
    -- legs="Acad. Pants +3",
    -- feet="Acad. Loafers +3",
  }
  sets.DarkArts = {
    -- body="Acad. Gown +3",
    -- feet="Acad. Loafers +3",
  }

  sets.Obi = {
    -- waist="Hachirin-no-Obi",
  }
  sets.Bookworm = {
    -- back="Bookworm's Cape",
  }
  sets.CP = {
    -- back="Mecisto. Mantle",
  }

  sets.Kiting = {
    feet="Herald's Gaiters",
  }
  sets.Kiting.Adoulin = {
    -- body="Councilor's Garb",
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.cancel_outranged_ws(spell, eventArgs)

  if spell.name:startswith('Aspir') then
    refine_various_spells(spell, action, spellMap, eventArgs)
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- If magic and grimoire is active, use Grimoire sub-set
  local crumbs = mote_vars.set_breadcrumbs
  if spell.action_type == 'Magic' then
    if (buffactive["Light Arts"] or buffactive["Addendum: White"]) or (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
      if (#crumbs == 3) then
        equip(sets[crumbs[2]][crumbs[3]].Grimoire)
      end
      if (#crumbs == 4) then
        equip(sets[crumbs[2]][crumbs[3]][crumbs[4]].Grimoire)
      end
      if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact.Grimoire)
      end
    else
      if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
      end
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.skill == 'Elemental Magic' then
    if spellMap == "Helix" then
      equip(sets.midcast['Elemental Magic'])
      if spell.english:startswith('Lumino') then
        equip(sets.midcast.LightHelix)
      elseif spell.english:startswith('Nocto') then
        equip(sets.midcast.DarkHelix)
      else
        equip(sets.midcast.Helix)
      end
      if state.HelixMode.value == 'Duration' then
        equip(sets.Bookworm)
      end
    end
    if buffactive['Klimaform'] and spell.element == world.weather_element then
      equip(sets.buff['Klimaform'])
    end
  end
  if spell.action_type == 'Magic' then
    apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
  end
  if spell.skill == 'Enfeebling Magic' then
    if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
      equip(sets.LightArts)
    elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
      equip(sets.DarkArts)
    end
  end
  if spell.english == "Kaustra" and state.MagicBurst.value then
    equip(sets.magic_burst)
  end
  if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
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
      equip(sets.Obi)
      -- equip({waist="Orpheus's Sash"})
    -- Matching day and weather.
    elseif spell.element == world.day_element and spell.element == world.weather_element then
      equip(sets.Obi)
    -- Target distance under 8 yalms.
    elseif spell.target.distance < (8 + spell.target.model_size) then
      equip(sets.Obi)
      -- equip({waist="Orpheus's Sash"})
      -- Match day or weather without conflict.
      elseif (spell.element == world.day_element and spell.element ~= elements.weak_to[world.weather_element]) or (spell.element == world.weather_element and spell.element ~= elements.weak_to[world.day_element]) then
      equip(sets.Obi)
    end
  end
  if spell.skill == 'Enhancing Magic' then
    if classes.NoSkillSpells:contains(spell.english) then
      equip(sets.midcast.EnhancingDuration)
      if spellMap == 'Refresh' then
        if spell.targets.Self then
          -- If self targeted
          equip(sets.midcast.RefreshSelf)
        else
          -- If not self targeted
          equip(sets.midcast.Refresh)
        end
      end
    end
    if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
      equip(sets.midcast.RegenDuration)
    end
    if state.Buff.Perpetuance then
      equip(sets.buff['Perpetuance'])
    end
    if spellMap == "Storm" and state.StormSurge.value then
      equip (sets.midcast.Stormsurge)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_aftercast(spell, action, spellMap, eventArgs)
  if not spell.interrupted then
    if spell.english == "Sleep II" then
      send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
      send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
    elseif spell.english == "Break" then
      send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
    end
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
  if buff == "Sublimation: Activated" then
    handle_equipping_gear(player.status)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_active_strategems()
  update_sublimation()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
  if spell.action_type == 'Magic' then
    if default_spell_map == 'Cure' then
      if (world.weather_element == 'Light' or world.day_element == 'Light') then
        return 'CureWeather'
      end
    elseif default_spell_map == 'Curaga' then
      if (world.weather_element == 'Light' or world.day_element == 'Light') then
        return 'CuragaWeather'
      end
    elseif spell.skill == 'Enfeebling Magic' then
      if spell.type == 'WhiteMagic' then
        return 'MndEnfeebles'
      else
        return 'IntEnfeebles'
      end
    end
  end
end

function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' then
    -- Apply regen gear
    if classes.CustomIdleGroups:contains('Regen') then
      idleSet = set_combine(idleSet, sets.passive_regen)
      if classes.CustomIdleGroups:contains('Daytime') then
        idleSet = set_combine(idleSet, sets.passive_regen.daytime)
      elseif classes.CustomIdleGroups:contains('Nighttime') then
        idleSet = set_combine(idleSet, sets.passive_regen.nighttime)
      end
    end
    -- Apply refresh gear
    if classes.CustomIdleGroups:contains('Refresh') then
      idleSet = set_combine(idleSet, sets.passive_refresh)
      if classes.CustomIdleGroups:contains('MpSub50') then
        idleSet = set_combine(idleSet, sets.passive_refresh.sub50)
      end
      if classes.CustomIdleGroups:contains('Daytime') then
        idleSet = set_combine(idleSet, sets.passive_refresh.daytime)
      elseif classes.CustomIdleGroups:contains('Nighttime') then
        idleSet = set_combine(idleSet, sets.passive_refresh.nighttime)
      end
    end
    -- Apply movement speed gear
    if classes.CustomIdleGroups:contains('Adoulin') then
      -- idleSet = set_combine(idleSet, sets.Kiting.Adoulin) -- Uncomment line when gear obtained
      idleSet = set_combine(idleSet, sets.Kiting)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
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

  return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

  local c_msg = state.CastingMode.value

  local h_msg = state.HelixMode.value

  local r_msg = state.RegenMode.value

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

  add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
  gearinfo(cmdParams, eventArgs)

  if cmdParams[1]:lower() == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1]:lower() == 'nuke' then
    handle_nuking(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Reset the state vars tracking strategems.
function update_active_strategems()
  state.Buff['Ebullience'] = buffactive['Ebullience'] or false
  state.Buff['Rapture'] = buffactive['Rapture'] or false
  state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
  state.Buff['Immanence'] = buffactive['Immanence'] or false
  state.Buff['Penury'] = buffactive['Penury'] or false
  state.Buff['Parsimony'] = buffactive['Parsimony'] or false
  state.Buff['Celerity'] = buffactive['Celerity'] or false
  state.Buff['Alacrity'] = buffactive['Alacrity'] or false
  state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
  state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
  if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
    equip(sets.buff['Perpetuance'])
  end
  if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
    equip(sets.buff['Rapture'])
  end
  if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
    if state.Buff.Ebullience and spell.english ~= 'Impact' then
      equip(sets.buff['Ebullience'])
    end
    if state.Buff.Immanence then
      equip(sets.buff['Immanence'])
    end
    if state.Buff.Klimaform and spell.element == world.weather_element then
      equip(sets.buff['Klimaform'])
    end
  end

  if state.Buff.Penury then equip(sets.buff['Penury']) end
  if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
  if state.Buff.Celerity then equip(sets.buff['Celerity']) end
  if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
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
  elseif buffactive['dark arts']  or buffactive['addendum: black'] then
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

-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
  -- returns recast in seconds.
  local allRecasts = windower.ffxi.get_ability_recasts()
  local stratsRecast = allRecasts[231]

  local maxStrategems = (player.main_job_level + 10) / 20

  local fullRechargeTime = 4*60

  local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

  return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
  local newSpell = spell.english
  local spell_recasts = windower.ffxi.get_spell_recasts()
  local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

  local spell_index

  if spell_recasts[spell.recast_id] > 0 then
    if spell.name:startswith('Aspir') then
      spell_index = table.find(degrade_array['Aspirs'],spell.name)
      if spell_index > 1 then
        newSpell = degrade_array['Aspirs'][spell_index - 1]
        send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
        eventArgs.cancel = true
      end
    end
  end
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
  -- Default macro set/book: (set, book)
  if player.sub_job == 'WHM' then
    set_macro_page(2, 1)
  elseif player.sub_job == 'BLM' then
    set_macro_page(1, 1)
  else
    set_macro_page(1, 1)
  end
end
