--[[
File Status: Ok. Kinkima's BLU is better.
TODO: Need to update sets with empy+3. Engaged DT sets need updating.
Some blue magic sets need to be updated.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: HasteInfo
Recommended addons: WSBinder, Reorganizer, AzureSets
Misc Recommendations: Disable GearInfo, disable RollTracker

]]--


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets

  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('hi report')
  end, 3)
  coroutine.schedule(function()
    send_command('gs c equipweapons')
  end, 4)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(16)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.CP = M(false, 'Capacity Points Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Naegling', 'Maxentius'}
  state.RangedWeaponSet = M{['description']='Weapon Set', 'None'}
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('DT', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'Evasion', 'DT')
  state.AttCapped = M(true, 'Attack Capped')
  state.MagicBurst = M(false, 'Magic Burst')
  state.Learning = M(false, 'Learning')

  update_active_abilities()

  -- Mappings for gear sets to use for various blue magic spells.
  -- While Str isn't listed for each, it's generally assumed as being at least
  -- moderately signficant, even for spells with other mods.
  blue_magic_maps = {
    -- Physical spells with no particular (or known) stat mods
    Physical = S{'Bilgestorm'},
    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    PhysicalAcc = S{'Heavy Strike'},
    -- Physical spells with Str stat mod
    PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death','Empty Thrash',
        'Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge','Uppercut',
        'Vertical Cleave'},
    -- Physical spells with Dex stat mod
    PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad','Seedspray',
        'Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'},
    -- Physical spells with Vit stat mod
    PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam','Power Attack',
        'Quad. Continuum','Sprout Smack','Sub-zero Smash'},
    -- Physical spells with Agi stat mod
    PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'},
    -- Physical spells with Int stat mod
    PhysicalInt = S{'Mandibular Bite','Queasyshroom'},
    -- Physical spells with Mnd stat mod
    PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'},
    -- Physical spells with Chr stat mod
    PhysicalChr = S{'Bludgeon'},
    -- Physical spells with HP stat mod
    PhysicalHP = S{'Final Sting'},
    -- Magical spells with the typical Int mod
    Magical = S{'Anvil Lightning','Blazing Bound','Bomb Toss','Cursed Sphere','Droning Whirlwind',
        'Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom',
        'Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'},
    MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo','Tenebral Crush'},
    MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon','Retinal Glare'},
    -- Magical spells with a primary Mnd mod
    MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'},
    -- Magical spells with a primary Chr mod
    MagicalChr = S{'Mysterious Light'},
    -- Magical spells with a Vit stat mod (on top of Int)
    MagicalVit = S{'Thermal Pulse'},
    -- Magical spells with a Dex stat mod (on top of Int)
    MagicalDex = S{'Charged Whisker','Gates of Hades'},
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations','Auroral Drape',
        'Awful Eye', 'Blank Gaze','Blastbomb','Blistering Roar','Blood Saber','Chaotic Eye','Cimicine Discharge',
        'Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower','Enervation','Feather Tickle',
        'Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave','Infrasonics','Jettatura',
        'Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind','Sandspin',
        'Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas','Sub-zero Smash','Venom Shell',
        'Voracious Trunk','Yawn','Cruel Joke'},
    -- Breath-based spells
    Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave','Magnetite Cloud',
        'Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'},
    -- Stun spells
    StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'},
    StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'},
    -- Healing spells
    Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','Wild Carrot'},
    -- Buffs that depend on blue magic skill
    SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Pyric Bulwark','Occultation'},
    -- Other general buffs
    Buff = S{'Amplification','Cocoon','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Orcish Counterstance','Regeneration','Triumphant Roar','Winds of Promyvion','Zephyr Mantle'},
    Refresh = S{'Battery Charge'},
    -- Blue magic spells that should use conserve MP midcast set.
    ConserveMP = S{'Refueling', 'Warm-Up', 'Saline Coat', 'Reactor Cool', 'Plasma Charge', 'Animating Wail',
        'Nat. Meditation', 'Carcharian Verve', 'Erratic Flutter', 'Mighty Guard'},
  }

  -- Spells that require Unbridled Learning to cast.
  unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
      'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
      'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['!`'] = 'gs c toggle MagicBurst',
      ['^l'] = 'gs c toggle Learning',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^home'] = 'gs c rangedweaponset cycle',
      ['^end'] = 'gs c rangedweaponset cycleback',
      ['!end'] = 'gs c rangedweaponset reset',
      ['^pageup'] = 'gs c toyweapon cycle',
      ['^pagedown'] = 'gs c toyweapon cycleback',
      ['!pagedown'] = 'gs c toyweapon reset',
      ['^-'] = 'input /ja "Chain Affinity" <me>',
      ['^='] = 'input /ja "Burst Affinity" <me>',
      ['^['] = 'input /ja "Efflux" <me>',
      ['!['] = 'input /ja "Diffusion" <me>',
      ['!]'] = 'input /ja "Unbridled Learning" <me>',
      ['!q'] = 'input /ma "Occultation" <me>',
      ['!w'] = 'input /ma "Cocoon" <me>',
      ['!e'] = 'input /ma "Erratic Flutter" <me>',
      ['!\''] = 'input /ma "Battery Charge" <me>',
    },
    ['RDM'] = {
      ['~`'] = 'input /ja "Convert" <me>',
      ['!i'] = 'input /ma Stoneskin <me>',
      ['!o'] = 'input /ma Phalanx <me>',
      ['!p'] = 'input /ma Aquaveil <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
  }

  set_main_keybinds:schedule(2)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  -- Additional local binds
  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
  set_sub_keybinds:schedule(2)

  if initialized then
    send_command:schedule(1, 'gs c equipweapons')
  end
  initialized = true -- DO NOT MODIFY
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Common
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  if sets.org then
    sets.org.job = {}
  end

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    legs=gear.Carmine_D_legs,
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.CP = {
    back=gear.CP_Cape,
  }

  sets.Enmity = {
    ammo="Sapience Orb", --2
    ear1="Cryptic Earring", --4
    head="Halitus Helm", --8
    body="Emet Harness +1", --10
    hands="Kurys Gloves", --9
    feet="Ahosi Leggings", --7
    neck="Unmoving Collar +1", --10
    ear2="Trux Earring", --5
    ring2="Eihwaz Ring", --5
    waist="Kasiri Belt", --3
    -- ring1="Pernicious Ring", --5
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Genmei Shield",
  }
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Maxentius",
    -- sub="Thibron",
  }
  sets.WeaponSet['Maxentius'] = {
    main="Maxentius",
    sub="Genmei Shield",
  }
  sets.WeaponSet['Maxentius'].DW = {
    main="Maxentius",
    sub="Naegling",
    -- sub="Thibron",
  }
  sets.WeaponSet['Tizona'] = {
    -- main="Tizona",
    sub="Genmei Shield",
  }
  sets.WeaponSet['Tizona'].DW = {
    -- main="Tizona",
    -- sub="Thibron",
  }

  -- Ranged weapon sets
  sets.RangedWeaponSet = {}

  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.passive_refresh = {
    main="Bolelabunga",             -- __/__, ___ [ 1]
    sub="Genmei Shield",            -- 10/__, ___ [__]
    ammo="Staunch Tathlum +1",      --  3/ 3, ___ [__]; Resist Status+11
    head="Rawhide Mask",            -- __/__,  53 [ 1]
    body="Jhakri Robe +2",          -- __/__,  53 [ 4]
    hands=gear.Nyame_B_hands,       --  7/ 7, 112 [__]
    legs=gear.Rawhide_D_legs,       -- __/__,  69 [ 1]
    feet=gear.Nyame_B_feet,         --  7/ 7, 150 [__]
    neck="Loricate Torque +1",      --  6/ 6, ___ [__]; DEF+60
    ear1="Arete Del Luna +1",       -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",      -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",        -- __/__, ___ [ 1]
    ring2="Defending Ring",         -- 10/10, ___ [__]
    back=gear.BLU_FC_Cape,          -- 10/__, ___ [__]
    waist="Carrier's Sash",         -- __/__, ___ [__]; Ele Resist+15
    -- 53 PDT / 36 MDT, 437 M.Eva [8 Refresh]

    -- body="Shamash Robe",         -- 10/__, 106 [ 3]; Resist Silence+90
    -- legs=gear.Lengo_legs,        -- __/__, 107 [ 1]
    -- ring2="Stikini Ring +1",     -- __/__, ___ [ 1]
    -- 53 PDT / 26 MDT, 528 M.Eva [8 Refresh]
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",
  }

  sets.idle = set_combine(sets.passive_refresh, {})

  sets.idle.Evasion = { --Focus on DT cap and evasion
    -- main="Tizona",
    -- sub="Sakpata's Sword", --10
    -- ammo="Amar Cluster", --10EVA
    head="Malignance Chapeau", --7DT, 91EVA
    body="Malignance Tabard", --9DT, 102EVA
    hands="Malignance Gloves", --7DT, 80EVA
    legs="Malignance Tights", --8DT, 85EVA
    feet="Malignance Boots", --7DT, 119EVA,
    -- neck="Bathy Choker +1", --30EVA (after aug)
    -- ear1="Infused Earring", --10EVA
    ear2="Eabani Earring", --10EVA
    ring1="Vengeful Ring", --9EVA
    ring2="Gelatinous Ring +1", --7PDT
    -- back=gear.BLU_ENM_Cape, --45EVA
    -- waist="Shetal Stone", --10EVA
    -- 48 DT, 7PDT
  }

  sets.idle.DT = set_combine(sets.idle, {
    ammo="Staunch Tathlum +1", --3/3
    head="Malignance Chapeau", --6/6
    body="Malignance Tabard", --9/9
    hands="Malignance Gloves", --5/5
    legs="Malignance Tights", --7/7
    feet="Malignance Boots", --4/4
    neck="Warder's Charm +1",
    ring2="Defending Ring", --10/10
    back="Moonlight Cape", --6/6
    -- ring1="Purity Ring", --0/4
  })

  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)

  sets.idle.Weak = set_combine(sets.idle.DT, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
  sets.precast.JA['Azure Lore'] = {
    -- hands="Luhlaza Bazubands +1" -- Duration +10s; +1 is acceptable
  }
  sets.precast.JA['Chain Affinity'] = {
    -- feet="Assimilator's Charuqs +1" -- Increases damage
  }
  sets.precast.JA['Convergence'] = {
    -- head="Luhlaza Keffiyeh +3" -- Increases damage; +1 is acceptable
  }
  sets.precast.JA['Enchainment'] = {
    -- body="Luhlaza Jubbah +3" -- Increases TP bonus; +1 is acceptable
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  -- Used when casting non-blu spells and not sub RDM (rarely used)
  sets.precast.FC = {
    ammo="Sapience Orb",          --  2 [__/__, ___]
    head=gear.Carmine_D_head,     -- 14 [__/__,  53]
    hands=gear.Leyline_Gloves,    --  8 [__/__,  62]
    feet=gear.Carmine_D_feet,     --  8 [ 4/__,  80]
    neck="Loricate Torque +1",    -- __ [ 6/ 6, ___]
    ear1="Loquacious Earring",    --  2 [__/__, ___]
    ear2="Odnowa Earring +1",     -- __ [ 3/ 5, ___]
    ring1="Kishar Ring",          --  4 [__/__, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    back=gear.BLU_FC_Cape,        -- 10 [10/__, ___]
    waist="Flume Belt +1",        -- __ [ 4/__, ___]
    -- Blue Magic FC trait            5 [__/__, ___]
    -- 53 FC [37 PDT / 21 MDT, 195 M.Eva]

    -- body="Pinga Tunic +1",     -- 15 [__/__, 128]
    -- legs="Pinga Pants +1",     -- 13 [__/__, 147]
    -- 81 FC [37 PDT / 21 MDT, 470 M.Eva]
  }

  -- Used when casting blue magic spells, and not sub RDM.
  sets.precast.FC['Blue Magic'] = {
    ammo="Sapience Orb",          --  2 [__/__, ___]
    head=gear.Carmine_D_head,     -- 14 [__/__,  53]
    body=gear.Nyame_B_body,
    hands=gear.Leyline_Gloves,    --  8 [__/__,  62]
    legs=gear.Nyame_B_legs,
    feet=gear.Carmine_D_feet,     --  8 [ 4/__,  80]
    neck="Loricate Torque +1",    -- __ [ 6/ 6, ___]
    ear1="Loquacious Earring",    --  2 [__/__, ___]
    ear2="Odnowa Earring +1",     -- __ [ 3/ 5, ___]
    ring1="Kishar Ring",          --  4 [__/__, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    back=gear.BLU_FC_Cape,        -- 10 [10/__, ___]
    waist="Flume Belt +1",        -- __ [ 4/__, ___]
    -- Blue Magic FC trait            5 [__/__, ___]
    -- 53 FC [37 PDT / 21 MDT, 195 M.Eva]

    -- body="Hashishin Mintan +2",-- 15 [12/12, 126]
    -- legs="Pinga Pants +1",     -- 13 [__/__, 147]
    -- 81 FC [49 PDT / 33 MDT, 468 M.Eva]
  }

  -- Always used when sub RDM
  sets.precast.FC.RDM = {
    ammo="Sapience Orb",          --  2 [__/__, ___]
    head=gear.Carmine_D_head,     -- 14 [__/__,  53]
    body=gear.Nyame_B_body,
    hands=gear.Leyline_Gloves,    --  8 [__/__,  62]
    legs=gear.Nyame_B_legs,
    feet=gear.Carmine_D_feet,     --  8 [ 4/__,  80]
    neck="Loricate Torque +1",    -- __ [ 6/ 6, ___]
    ear1="Loquacious Earring",    --  2 [__/__, ___]
    ear2="Odnowa Earring +1",     -- __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",   -- __ [ 7/-1, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    back=gear.BLU_FC_Cape,        -- 10 [10/__, ___]
    waist="Flume Belt +1",        -- __ [ 4/__, ___]
    -- Blue Magic FC trait            5 [__/__, ___]
    -- RDM FC traits                 15
    -- 50 FC [44 PDT / 20 MDT, 192 M.Eva]

    -- legs="Pinga Pants +1",     -- 13 [__/__, 147]
    -- body="Pinga Tunic +1",     -- 15 [__/__, 128]
    -- 84 FC [51 PDT / 27 MDT, 520 M.Eva]
  }


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Ishvara Earring",
    ring1="Epaminondas's Ring",
    waist="Fotia Belt",

    -- ammo="Aurgelmir Orb +1",
    -- ring2="Beithir Ring",
    -- back=gear.BLU_WSD_Cape,
  }
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",
  })

  sets.precast.WS['Chant du Cygne'] = {
    head=gear.Adhemar_B_head,
    body="Gleti's Cuirass",
    hands=gear.Adhemar_B_hands,
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Mirage Stole +1",       -- __,  6, 20 <__, __, __> [__/__, ___]
    ear2="Odr Earring",
    ring1="Epona's Ring",
    ring2="Begrudging Ring",
    waist="Fotia Belt",
    -- ammo="Aurgelmir Orb +1",
    -- neck="Mirage Stole +2",
    -- ear1="Mache Earring +1",
    -- back=gear.BLU_Crit_Cape,
  }

  sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Chant du Cygne'], {})

  sets.precast.WS['Savage Blade'] = {
    ammo="Coiste Bodhar",         --Sub for Aurgelmir Orb +1
    head=gear.Nyame_B_head,       -- 26, 26, 65, 50, 11, __, ___
    body=gear.Nyame_B_body,       -- 45, 37, 65, 40, 13, __, ___
    hands=gear.Nyame_B_hands,     -- 17, 40, 65, 40, 11, __, ___
    legs=gear.Nyame_B_legs,       -- 58, 32, 65, 40, 12, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 65, 53, 11, __, ___
    neck="Mirage Stole +1",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ring1="Ephramad's Ring",      -- 10, __, 20, 20, __, 10, ___
    ring2="Sroda Ring",
    waist="Sailfi Belt +1",       -- Needs further augmenting
    -- STR, MND, Attack, Accuracy, WSD, PDL [PDT/MDT, M.Eva]

    -- neck="Mirage Stole +2",
    -- back=gear.BLU_WSD_Cape,
    -- STR, MND, Attack, Accuracy, WSD, PDL [PDT/MDT, M.Eva]
  }
  sets.precast.WS['Savage Blade'].AttCapped = {
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,       -- 26, 26, 65, 50, 11, __, ___
    body="Gleti's Cuirass",
    hands=gear.Nyame_B_hands,     -- 17, 40, 65, 40, 11, __, ___
    legs="Gleti's Breeches",
    feet=gear.Nyame_B_feet,       -- 23, 26, 65, 53, 11, __, ___
    neck="Mirage Stole +1",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ring1="Ephramad's Ring",      -- 10, __, 20, 20, __, 10, ___
    ring2="Sroda Ring",
    waist="Sailfi Belt +1",       -- Needs further augmenting
    -- STR, MND, Attack, Accuracy, WSD, PDL [PDT/MDT, M.Eva]

    -- neck="Mirage Stole +2",
    -- back=gear.BLU_WSD_Cape,
    -- STR, MND, Attack, Accuracy, WSD, PDL [PDT/MDT, M.Eva]
  }

  sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {})
  sets.precast.WS['Expiacion'].AttCapped = set_combine(sets.precast.WS['Savage Blade'].AttCapped, {})

  sets.precast.WS['Sanguine Blade'] = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Sibyl Scarf",
    ear1="Moonshade Earring",
    ring1="Ephramad's Ring",
    ring2="Archon Ring",
    back=gear.BLU_FC_Cape,
    -- body="Amalric Doublet +1",
    -- hands="Amalric Gages +1",
    -- legs="Luhlaza Shalwar +3",
    -- feet="Amalric Nails +1",
    -- waist="Sacro Cord",
  }

  sets.precast.WS['True Strike'] = set_combine(sets.precast.WS['Savage Blade'], {})

  sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['True Strike'], {})

  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {})

  sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS['Requiescat'], {})

  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
    head=gear.Nyame_B_head,
    ring2="Weatherspoon Ring",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = set_combine(sets.precast.FC, {})

  sets.midcast.SpellInterrupt = {
    ammo="Staunch Tathlum +1", --11
    ring1="Evanescence Ring", --5
    -- waist="Sanctuary Obi +1", --10
  }

  sets.midcast.Dia = set_combine(sets.TreasureHunter, {})
  sets.midcast.Diaga = set_combine(sets.TreasureHunter, {})
  sets.midcast.Bio = set_combine(sets.TreasureHunter, {})

  sets.midcast['Blue Magic'] = {
    ammo="Mavi Tathlum",                --  5, __ [__/__, ___]
    neck="Mirage Stole +1",             -- 15, 20 [__/__, ___]
    ear2="Odnowa Earring +1",           -- __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",         -- __, __ [ 7/-1, ___]
    ring2="Stikini Ring +1",            --  8, 11 [__/__, ___]
    waist="Flume Belt +1",              -- __, __ [ 4/__, ___]
    -- Base                               424
    -- Trait/merit/gift                    36
    -- ML  0                                0
    -- 488 Blue skill, 31 M.Acc [14 PDT/4 MDT, 0 M.Eva]

    -- head="Luhlaza Keffiyeh +3",      -- 17, 37 [__/__,  73]
    -- body="Assimilator's Jubbah +3",  -- 24, __ [__/__,  84]
    -- hands="Hashishin Bazubands +2",  -- __, 52 [ 9/ 9,  77]
    -- legs="Hashishin Tayt +2",        -- 28, 53 [11/11, 152]
    -- feet="Luhlaza Charuqs +3",       -- 12, 36 [__/__,  89]
    -- neck="Mirage Stole +2",          -- 20, 25 [__/__, ___]
    -- ear1="Njordr Earring",           -- 10, __ [__/__, ___]
    -- ring1="Stikini Ring +1",         --  8, 11 [__/__, ___]
    -- back=gear.BLU_Adoulin_Cape,      -- 15, 15 [__/__, ___]
    -- Base                               424
    -- Trait/merit/gift                    36
    -- ML  0                                0
    -- 599 Blue skill, 229 M.Acc [27 PDT/25 MDT, 475 M.Eva]

    -- hands=gear.Rawhide_D_hands,      -- 10, 35 [__/__,  37]
    -- Base                               424
    -- Trait/merit/gift                    36
    -- ML 50                               50
    -- 659 Blue skill, 212 M.Acc [18 PDT/16 MDT, 435 M.Eva]
  }

  sets.midcast['Blue Magic'].Physical = {
    ammo="Aurgelmir Orb",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Mirage Stole +1",
    ear1="Dignitary's Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Defending Ring",
    waist="Grunfeld Rope",

    -- ammo="Aurgelmir Orb +1",
    -- neck="Mirage Stole +2",
    -- back=gear.BLU_STP_Cape,
  }

  sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
    -- ammo="Voluspa Tathlum",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
    ring2="Ilabrat Ring",
    waist="Grunfeld Rope",
    -- ear2="Mache Earring +1",
    -- back=gear.BLU_Crit_Cape,
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
    ring2="Ilabrat Ring",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
    ear2="Regal Earring",
    ring2="Metamorph Ring +1",
    back=gear.BLU_MAB_Cape,

    -- ring1="Shiva Ring +1",
    -- waist="Acuity Belt +1",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
    ear2="Regal Earring",
    ring2="Stikini Ring +1",

    -- ring1="Stikini Ring +1",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
    ear1="Regal Earring",
    ear2="Enchanter's Earring +1"
  })

  sets.midcast['Blue Magic'].Magical = {
    main="Bunzi's Rod",               -- 65, 55, 15 [__/__, ___]  5
    sub="Maxentius",                  -- 21, 40, 15 [__/__, ___] __
    ammo="Pemphredo Tathlum",         --  4,  8,  4 [__/__, ___] __
    head=gear.Nyame_B_head,           -- 30, 40, 28 [ 7/ 7, 123] __
    body=gear.Nyame_B_body,           -- 30, 40, 42 [ 9/ 9, 139] __
    hands="Jhakri Cuffs +2",          -- 40, 43, 36 [__/__,  32] __
    legs=gear.Nyame_B_legs,           -- 30, 40, 44 [ 8/ 8, 150] __
    feet="Jhakri Pigaches +2",        -- 39, 42, 33 [__/__,  69] __
    neck="Loricate Torque +1",        -- __, __, __ [ 6/ 6, ___] __
    ear1="Regal Earring",             --  7, __, 10 [__/__, ___] __
    ear2="Halasz Earring",            -- __, __, __ [__/__, ___]  3; Magic crit rate +14%
    ring1="Metamorph Ring +1",        -- __, 15, 16 [__/__, ___] __
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.BLU_MAB_Cape,           -- 10, 20, 30 [10/__, ___] __
    -- 276 MAB, 343 M.Acc, 273 INT [50 PDT/40 MDT, 513 M.Eva] 8 Enmity-

    -- head="Hashishin Kavuk +2",     -- 46, 51, 29 [__/__, 115] __
    -- body=gear.Merl_MAB_body,       -- 64, 39, 40 [ 2/__,  91]  5
    -- hands="Hashishin Bazubands +2",-- 52, 52, 28 [ 9/ 9,  77]  5; Blue magic recast -15%
    -- legs="Hashishin Tayt +2",      -- 48, 53, 43 [11/11, 152] __
    -- feet="Hashishin Basmak +2",    -- 50, 50, 34 [__/__, 147]  9
    -- neck="Lasaia Pendant",         -- __,  1, __ [__/__, ___]  8
    -- waist="Sanctuary Obi +1",      -- __, __,  6 [__/__, ___]  4
    -- 367 MAB, 384 M.Acc, 270 INT [42 PDT/30 MDT, 582 M.Eva] 39 Enmity-
  }

  sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- waist="Acuity Belt +1",        -- __, 15, 23 [__/__, ___] __
    -- 348 MAB, 399 M.Acc, 287 INT [42 PDT/30 MDT, 582 M.Eva] 35 Enmity-
  })

  sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
    head="Pixie Hairpin +1",
    ring1="Archon Ring",
  })
  sets.midcast['Blue Magic'].MagicalDark.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
    ring1="Weatherspoon Ring"
  })
  sets.midcast['Blue Magic'].MagicalLight.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
  })
  sets.midcast['Blue Magic'].MagicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
    ammo="Aurgelmir Orb",
    ring2="Ilabrat Ring",
    -- ammo="Aurgelmir Orb +1",
    -- ear2="Mache Earring +1",
  })
  sets.midcast['Blue Magic'].MagicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
    ammo="Aurgelmir Orb",
    -- ammo="Aurgelmir Orb +1",
  })
  sets.midcast['Blue Magic'].MagicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
    ear1="Regal Earring",
    ear2="Enchanter's Earring +1"

    -- ammo="Voluspa Tathlum",
  })
  sets.midcast['Blue Magic'].MagicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

  sets.midcast['Blue Magic'].MagicAccuracy = {
    main="Bunzi's Rod", --55 macc
    sub="Maxentius", --40 macc
    ammo="Pemphredo Tathlum",
    head="Assimilator's Keffiyeh +3",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Assimilator's Shalwar +3",
    feet="Malignance Boots",
    neck="Mirage Stole +1",
    ear1="Dignitary's Earring",
    ear2="Regal Earring",
    ring1="Stikini Ring +1",

    -- main="Sakpata's Sword", --55 macc (R30 only)
    -- sub="Bunzi's Rod", --55 macc
    -- neck="Mirage Stole +2",
    -- ring2="Stikini Ring +1",
    -- back="Aurist's Cape +1",
    -- waist="Acuity Belt +1",

    -- main="Tizona",
    -- sub="Bunzi's Rod", --55 macc
  }

  sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- head="Luhlaza Keffiyeh +3"
  })

  sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Mirage Stole +1",
    waist="Eschan Stone",

    -- ammo="Voluspa Tathlum",
    -- neck="Mirage Stole +2",
    -- ear2="Mache Earring +1",
    -- back=gear.BLU_STP_Cape,
  })

  sets.midcast['Blue Magic'].StunMagical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

  sets.midcast['Blue Magic'].Healing = { --Focus cure potency
    main="Bunzi's Rod",               -- 30, 15, __ [__/__, ___]
    sub="empty",
    ammo="Staunch Tathlum +1",        -- __, __, 11 [ 3/ 3, ___]
    head=gear.Nyame_B_head,           -- __, 26, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- __, 37, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- __, 40, __ [ 7/ 7, 112]
    legs="Carmine Cuisses +1",        -- __, 16, 20 [__/__,  80]
    feet=gear.Nyame_B_feet,           -- __, 26, __ [ 7/ 7, 150]
    neck="Loricate Torque +1",        -- __, __,  5 [ 6/ 6, ___]
    ear1="Regal Earring",             -- __, 10, __ [__/__, ___]
    ear2="Halasz Earring",            -- __, __,  5 [__/__, ___]
    ring1="Defending Ring",           -- __, __, __ [10/10, ___]
    ring2="Stikini Ring +1",          -- __,  5, __ [__/__, ___]
    back=gear.BLU_FC_Cape,            -- __, 30, __ [10/__, ___]
    -- Merits                            __, __,  8 [__/__, ___]
    -- 30 Cure Potency, 205 MND, 49 SIRD [59 PDT / 49 MDT, 604 M.Eva]

    -- sub="Sors Shield",             --  3, __, __ [__/__, ___]
    -- body="Shamash Robe",           -- __, 40, __ [10/__, 106]
    -- hands=gear.Telchine_CP_hands,  -- 18, 33, __ [__/__,  62]
    -- ring2="Freke Ring",            -- __, __, 10 [__/__, ___]
    -- waist="Sanctuary Obi +1",      -- __, __, 10 [__/__, ___]
    -- Merits                            __, __, 10 [__/__, ___]
    -- 51 Cure Potency, 196 MND, 71 SIRD [53 PDT / 33 MDT, 521 M.Eva]
  }

  sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
    ear2="Mendicant's Earring", -- (5)
    waist="Gishdubar Sash",     -- (10)
  })

  sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
    feet=gear.Nyame_B_feet,
    neck="Unmoving Collar +1",
    ear2="Odnowa Earring +1",
    ring1="Gelatinous Ring +1",
    back="Moonlight Cape",

    -- ammo="Egoist's Tathlum",
    -- head=gear.Telchine_Cure_head,
    -- body="Pinga Tunic +1",
    -- hands=gear.Telchine_Cure_hands,
    -- legs="Pinga Pants +1",
    -- ear1="Tuisto Earring",
    -- ring2="Meridian Ring",
    -- waist="Steppe Sash",
  })

  sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'], {})
  sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {
    waist="Gishdubar Sash",

    -- head="Amalric Coif +1",
    -- back="Grapevine Cape"
  })
  sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'], {})

  sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
    ear2="Enchanter's Earring +1",
    ring2="Weatherspoon Ring",

    -- hands="Hashishin Bazubands +3",
    -- ear1="Njordr Earring",
  }) -- 1 shadow per 50 skill

  sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
    -- head="Amalric Coif +1",
    -- waist="Emphatikos Rope",
  })

  sets.midcast['Blue Magic']['ConserveMP'] = {}

  sets.midcast['Enhancing Magic'] = {
    main="Sakpata's Sword", --10DT
    ammo="Staunch Tathlum +1", --3DT
    head="Carmine Mask +1",
    legs="Carmine Cuisses +1",
    neck="Incanter's Torque",
    ear1="Mimir Earring",
    ear2="Andoaa Earring",
    ring1="Defending Ring", --10DT
    ring2="Stikini Ring +1",
    back=gear.BLU_FC_Cape, --10PDT
    waist="Olympus Sash",

    -- body=gear.Telchine_ENH_body,
    -- hands=gear.Telchine_ENH_hands,
    -- feet=gear.Telchine_ENH_feet,
  }

  sets.midcast.EnhancingDuration = {
    main="Sakpata's Sword", --10DT
    sub=gear.Colada_ENH,
    ammo="Staunch Tathlum +1", --3DT
    neck="Loricate Torque +1", --6DT
    ear1="Odnowa Earring +1", --3DT
    ear2="Andoaa Earring",
    ring1="Defending Ring", --10DT
    ring2="Stikini Ring +1",
    back=gear.BLU_FC_Cape, --10PDT
    waist="Flume Belt +1", --4PDT

    -- head=gear.Telchine_ENH_head,
    -- body=gear.Telchine_ENH_body,
    -- hands=gear.Telchine_ENH_hands,
    -- legs=gear.Telchine_ENH_legs,
    -- feet=gear.Telchine_ENH_feet,
    -- 36DT, 14PDT
  }

  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
    waist="Gishdubar Sash",

    -- head="Amalric Coif +1",
    -- back="Grapevine Cape",
  })

  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    ear2="Andoaa Earring",
    waist="Siegel Sash", --20

    -- hands="Stone Mufflers", --30
    -- legs="Shedir Seraweels", --35
    -- ear1="Earthcry Earring", --10
  })

  sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {
    main="Sakpata's Sword", --5
    body=gear.Herc_Phalanx_body,                -- 5, __, __ [__/__,  61]
    hands=gear.Herc_Phalanx_hands,              -- 5, __, __ [ 2/__,  20]
    legs=gear.Herc_Phalanx_legs,                -- 5, __, __ [ 2/__,  38]
    feet=gear.Herc_Phalanx_feet,                -- 5, __, __ [ 2/__,   9]
  })

  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    -- head="Amalric Coif +1", --2
    -- hands="Regal Cuffs", --2
    -- legs="Shedir Seraweels", --1
    -- waist="Emphatikos Rope", --1
  })

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring1="Sheltered Ring"
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shell = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shellra = set_combine(sets.midcast.Protect, {})

  sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
    -- ear2="Vor Earring",
  })

  sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Normal Engaged
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.

  sets.engaged = {
    main="Naegling",
    sub="Maxentius",
    -- sub="Thibron",
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +1",           -- __,  6, 20 <__, __, __> [__/__, ___]
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Windbuffet Belt +1",       -- __, __,  2 <__,  2,  2> [__/__, ___]
    
    -- neck="Mirage Stole +2",        -- __,  7, 25 <__, __, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,        -- __, 10, 30 <__, __, __> [10/__, ___]
    -- 0 DW, 83 STP, 307 Acc <7 DA, 5 TA, 2 QA> [51 PDT/41 MDT, 674 M.Eva]
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- 0 DW, 84 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]
  })

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.LowDW = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +1",           -- __,  6, 20 <__, __, __> [__/__, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]

    -- neck="Mirage Stole +2",        -- __,  7, 25 <__, __, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,        -- __, 10, 30 <__, __, __> [10/__, ___]
    -- 11 DW, 82 STP, 305 Acc <6 DA, 3 TA, 0 QA> [51 PDT/41 MDT, 682 M.Eva]
  }
  sets.engaged.LowDW.Acc = set_combine(sets.engaged.LowDW, {
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,         -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 10 DW, 74 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.MidDW = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +1",           -- __,  6, 20 <__, __, __> [__/__, ___]
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]

    -- neck="Mirage Stole +2",        -- __,  7, 25 <__, __, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,        -- __, 10, 30 <__, __, __> [10/__, ___]
    -- 18 DW, 68 STP, 330 Acc <7 DA, 7 TA, 0 QA> [42 PDT/32 MDT, 604 M.Eva]
  }
  sets.engaged.MidDW.Acc = set_combine(sets.engaged.MidDW, {
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- 17 DW, 75 STP, 351 Acc <7 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.HighDW = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,         -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 32 DW, 46 STP, 295 Acc <6 DA, 7 TA, 0 QA> [48 PDT/38 MDT, 612 M.Eva]
  }
  sets.engaged.HighDW.Acc = set_combine(sets.engaged.HighDW, {
    neck="Mirage Stole +1",           -- __,  6, 20 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]

    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- neck="Mirage Stole +2",        -- __,  7, 25 <__, __, __> [__/__, ___]
    -- 32 DW, 56 STP, 340 Acc <0 DA, 4 TA, 0 QA> [42 PDT/32 MDT, 612 M.Eva]
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.SuperDW = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]

    -- feet=gear.Taeon_DW_feet,       --  9, __, 32 <__, __, __> [__/__,  69]
    -- back=gear.BLU_DW_Cape,         -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 42 DW, 35 STP, 272 Acc <6 DA, 7 TA, 0 QA> [37 PDT/27 MDT, 461 M.Eva]
  }
  sets.engaged.SuperDW.Acc = set_combine(sets.engaged.SuperDW, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",           -- __,  7, 25 <__, __, __> [__/__, ___]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- 38 DW, 46 STP, 345 Acc <0 DA, 4 TA, 0 QA> [35 PDT/25 MDT, 542 M.Eva]
  })

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.MaxDW = {
    main="Naegling",
    sub="Maxentius",
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,         --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]

    -- feet=gear.Taeon_DW_feet,       --  9, __, 32 <__, __, __> [__/__,  69]
    -- back=gear.BLU_DW_Cape,         -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 47 DW, 27 STP, 282 Acc <6 DA, 7 TA, 0 QA> [37 PDT/27 MDT, 461 M.Eva]
  }
  sets.engaged.MaxDW.Acc = set_combine(sets.engaged.MaxDW, {
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +1",           -- __,  6, 20 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]

    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- neck="Mirage Stole +2",        -- __,  7, 25 <__, __, __> [__/__, ___]
    -- 38 DW, 46 STP, 345 Acc <0 DA, 4 TA, 0 QA> [35 PDT/25 MDT, 542 M.Eva]
  })


  ------------------------------------------------------------------------------------------------
  --    Hybrid Engaged
  ------------------------------------------------------------------------------------------------

  sets.engaged.DT = set_combine(sets.engaged, {})
  sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, {})

  sets.engaged.LowDW.DT = set_combine(sets.engaged.LowDW, {
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
  })
  sets.engaged.LowDW.Acc.DT = set_combine(sets.engaged.LowDW.DT, {})

  sets.engaged.MidDW.DT = set_combine(sets.engaged.MidDW, {
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
  })
  sets.engaged.MidDW.Acc.DT = set_combine(sets.engaged.MidDW.DT, {})

  sets.engaged.HighDW.DT = set_combine(sets.engaged.MidDW.DT, {})
  sets.engaged.HighDW.Acc.DT = set_combine(sets.engaged.HighDW.DT, {
    neck="Mirage Stole +1",       -- __,  6, 20 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]

    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- neck="Mirage Stole +2",    -- __,  7, 25 <__, __, __> [__/__, ___]
  })

  sets.engaged.SuperDW.DT = {
    ammo="Staunch Tathlum +1",    -- __, __, __ <__, __, __> [ 3/ 3, ___]
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,     --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,      --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Odnowa Earring +1",     -- __, __, __ <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]

    -- feet=gear.Taeon_DW_feet,   --  9, __, 32 <__, __, __> [__/__,  69]
    -- back=gear.BLU_DW_Cape,     -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 42 DW, 24 STP, 282 Acc <0 DA, 4 TA, 0 QA> [50 PDT/34 MDT, 461 M.Eva]
  }
  sets.engaged.SuperDW.Acc.DT = set_combine(sets.engaged.SuperDW.DT, {
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]

    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- 38 DW, 33 STP, 310 Acc <0 DA, 4 TA, 0 QA> [48 PDT/25 MDT, 542 M.Eva]
  })

  sets.engaged.MaxDW.DT = {
    ammo="Staunch Tathlum +1",    -- __, __, __ <__, __, __> [ 3/ 3, ___]
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body=gear.Adhemar_A_body,     --  6, __, 55 <__,  4, __> [__/__,  69]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,      --  9, __, 22 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
    
    -- feet=gear.Taeon_DW_feet,   --  9, __, 32 <__, __, __> [__/__,  69]
    -- back=gear.BLU_DW_Cape,     -- 10, __, 30 <__, __, __> [10/__, ___]
    -- 47 DW, 24 STP, 282 Acc <0 DA, 4 TA, 0 QA> [47 PDT/29 MDT, 461 M.Eva]
  }
  sets.engaged.MaxDW.Acc.DT = set_combine(sets.engaged.MaxDW.DT, {
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- 38 DW, 33 STP, 310 Acc <0 DA, 4 TA, 0 QA> [48 PDT/30 MDT, 542 M.Eva]
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.buff['Burst Affinity'] = {
    legs="Assimilator's Shalwar +3",
    -- feet="Hashishin Basmak +2",
  }
  sets.buff['Diffusion'] = {
    -- feet="Luhlaza Charuqs +3" -- +1 is acceptable
  }
  sets.buff['Efflux'] = {
    -- legs="Hashishin Tayt +2",
  }

  sets.magic_burst = {
    legs="Assimilator's Shalwar +3", --10
    feet="Jhakri Pigaches +2", --5
    ring1="Mujin Band", --(5)
    -- body="Samnuha Coat", --(8)
    -- hands="Amalric Gages +1", --(5)
    -- back="Seshaw Cape", --5
  }

  sets.Learning = {
    hands="Assimilator's Bazubands +1",
  }

  sets.FallbackShield = { sub="Genmei Shield" }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if unbridled_spells:contains(spell.english) then
    if not state.Buff['Unbridled Learning'] then
      eventArgs.cancel = true
      windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
  elseif spell.english == ('Diamondhide') or spell.english == ('Magic Barrier') then
    send_command('@wait 1;cancel stoneskin')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if state.Learning.value then
    equip(sets.Learning)
  end
  -- Always put this last in job_post_precast
  if in_battle_mode() then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
  end
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

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
  if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
    equip(sets.midcast.EnhancingDuration)
    if spellMap == 'Refresh' then
      equip(sets.midcast.Refresh)
    end
  end

  -- Add enhancement gear for JAs
  apply_ability_bonuses(spell, action, spellMap)

  if state.Learning.value then
    equip(sets.Learning)
  end

  if buffactive['doom'] then
    equip(sets.buff.Doom)
  end

  -- Always put this last in job_post_midcast
  if in_battle_mode() then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
  end
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  if not spell.interrupted then
    if spell.english == "Dream Flower" then
      send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
    elseif spell.english == "Soporific" then
      send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
    elseif spell.english == "Sheep Song" then
      send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
    elseif spell.english == "Yawn" then
      send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
    elseif spell.english == "Entomb" then
      send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
    end
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
function job_buff_change(buff,gain)
end

function job_state_change(stateField, newValue, oldValue)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  silibs.update_combat_form()
end

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if buffactive['Sublimation: Activated'] then
      classes.CustomIdleGroups:append('Sublimation')
    end
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
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
  if spell.skill == 'Blue Magic' then
    for category,spell_list in pairs(blue_magic_maps) do
      if spell_list:contains(spell.english) then
        if category == 'Healing' and spell.target.type == 'SELF' then
          return 'HealingSelf'
        else
          return category
        end
      end
    end
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'
  end

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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if player.mpp < 71 and state.DefenseMode.value == 'None' then
    idleSet = set_combine(idleSet, sets.latent_refresh)
  end

  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    -- Apply movement speed gear
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
    if state.CP.value then
      idleSet = set_combine(idleSet, sets.CP)
    end
    if state.Learning.value then
      idleSet = set_combine(idleSet, sets.Learning)
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

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.IdleMode.value == 'CP' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if state.Learning.value then
    meleeSet = set_combine(meleeSet, sets.Learning)
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

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

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


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'equipweapons' then
    equip(select_weapons())
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_weapons('set', cmdParams[3])
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'rangedweaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_ranged_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_ranged_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_ranged_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_ranged_weapons('current')
    end
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'set' and cmdParams[3] then
      cycle_toy_weapons('set', cmdParams[3])
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds:schedule(2)
    set_sub_keybinds:schedule(2)
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

function update_active_abilities()
  state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
  state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
  state.Buff['Convergence'] = buffactive['Convergence'] or false
  state.Buff['Diffusion'] = buffactive['Diffusion'] or false
  state.Buff['Efflux'] = buffactive['Efflux'] or false
  state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
  if spell.type == 'BlueMagic' then
    if state.Buff['Burst Affinity'] and (
        spellMap == 'Magical'
        or spellMap == 'MagicalLight'
        or spellMap == 'MagicalDark'
        or spellMap == 'MagicalMnd'
        or spellMap == 'MagicalChr'
        or spellMap == 'MagicalVit'
        or spellMap == 'MagicalDex'
        or spellMap == 'Breath'
      ) then
      if state.MagicBurst.value then
        equip(sets.magic_burst)
        equip(sets.buff['Burst Affinity'])
      end
    end
    if state.Buff.Efflux and (
        spellMap == 'Physical'
        or spellMap == 'PhysicalStr'
        or spellMap == 'PhysicalDex'
        or spellMap == 'PhysicalVit'
        or spellMap == 'PhysicalAgi'
        or spellMap == 'PhysicalInt'
        or spellMap == 'PhysicalChr'
        or spellMap == 'PhysicalChr'
        or spellMap == 'PhysicalHP'
      ) then
      equip(sets.buff['Efflux'])
    end
    if state.Buff.Diffusion then
      equip(sets.buff['Diffusion'])
    end
  end
end

function cycle_weapons(cycle_dir, set_name)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'set' then
    state.WeaponSet:set(set_name)
  else
    state.WeaponSet:reset()
  end
  state.ToyWeapons:reset()

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_ranged_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.RangedWeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.RangedWeaponSet:cycleback()
  elseif cycle_dir == 'set' then
    state.RangedWeaponSet:set(set_name)
  else
    state.RangedWeaponSet:reset()
  end

  add_to_chat(141, 'RA Weapon Set to '..string.char(31,1)..state.RangedWeaponSet.current)
  equip(select_weapons())
end

function cycle_toy_weapons(cycle_dir, set_name)
  if cycle_dir == 'forward' then
    state.ToyWeapons:cycle()
  elseif cycle_dir == 'back' then
    state.ToyWeapons:cycleback()
  elseif cycle_dir == 'set' then
    state.ToyWeapons:set(set_name)
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
  local weapons_to_equip = {}
  local can_dw = silibs.can_dual_wield()
  if state.ToyWeapons.current ~= 'None' then
    weapons_to_equip = set_combine(sets.ToyWeapon[state.ToyWeapons.current], {})
  else
    if can_dw and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current].DW, {})
    elseif sets.WeaponSet[state.WeaponSet.current] then
      weapons_to_equip = set_combine(sets.WeaponSet[state.WeaponSet.current], {})
    end
  end

  -- If trying to equip weapon in offhand but cannot DW, equip empty
  if not can_dw and weapons_to_equip.sub and silibs.is_weapon(weapons_to_equip.sub) then
    local sub_to_use = sets.FallbackShield and sets.FallbackShield.sub or 'empty'
    weapons_to_equip = set_combine(weapons_to_equip, {sub=sub_to_use})
  end

  -- Equip ranged weapon
  local ranged_set = sets.RangedWeaponSet[state.RangedWeaponSet.current]
  if ranged_set then
    weapons_to_equip = set_combine(weapons_to_equip, ranged_set)
  end

  return weapons_to_equip
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting' or state.ToyWeapons.current ~= 'None'
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
  set_macro_page(2, 16)
end

function set_main_keybinds()
  local main_keybinds = job_keybinds['main']
  if main_keybinds then
    for key,cmd in pairs(main_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end

  construct_unbind_command()
end

function set_sub_keybinds()
  local sub_keybinds = job_keybinds[player.sub_job]
  if sub_keybinds then
    for key,cmd in pairs(sub_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end
end

function construct_unbind_command()
  local commands = L{}
  local main_keybinds = job_keybinds['main']
  local sub_keybinds = job_keybinds[player.sub_job]
  if main_keybinds then
    for key in pairs(main_keybinds) do
      commands:append(('unbind %s'):format(key))
    end
  end
  if sub_keybinds then
    for key in pairs(sub_keybinds) do
      commands:append(('unbind %s'):format(key))
    end
  end
  unbind_command = commands:concat(';')
end

function unbind_keybinds()
  windower.send_command(unbind_command)
end

function test()
end
