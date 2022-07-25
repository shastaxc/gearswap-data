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
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Chain Affinity
--              [ CTRL+= ]          Burst Affinity
--              [ CTRL+[ ]          Efflux
--              [ ALT+[ ]           Diffusion
--              [ ALT+] ]           Unbridled Learning
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ CTRL+` ]          Blank Gaze
--              [ ALT+Q ]            Nature's Meditation/Fantod
--              [ ALT+W ]           Cocoon/Reactor Cool
--              [ ALT+E ]           Erratic Flutter
--              [ ALT+R ]           Battery Charge/Refresh
--              [ ALT+T ]           Occultation
--              [ ALT+Y ]           Barrier Tusk/Phalanx
--              [ ALT+U ]           Diamondhide/Stoneskin
--              [ ALT+P ]           Mighty Guard/Carcharian Verve
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad5 ]    Expiacion
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


--------------------------------------------------------------------------------------------------------------------
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
    send_command('gs c weaponset current')
    send_command('aset set main')
  end, 2)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(5)
  silibs.enable_premade_commands()
  silibs.enable_th()

  state.CP = M(false, "Capacity Points Mode")
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Naegling', 'Maxentius'}
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('DT', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'Evasion', 'DT')
  state.AttCapped = M(true, 'Attack Capped')
  state.MagicBurst = M(false, 'Magic Burst')
  state.Learning = M(false, 'Learning')

  state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
  state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
  state.Buff.Convergence = buffactive.Convergence or false
  state.Buff.Diffusion = buffactive.Diffusion or false
  state.Buff.Efflux = buffactive.Efflux or false
  state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


  blue_magic_maps = {}

  -- Mappings for gear sets to use for various blue magic spells.
  -- While Str isn't listed for each, it's generally assumed as being at least
  -- moderately signficant, even for spells with other mods.

  -- Physical spells with no particular (or known) stat mods
  blue_magic_maps.Physical = S{'Bilgestorm'}

  -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
  blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

  -- Physical spells with Str stat mod
  blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
      'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
      'Uppercut','Vertical Cleave'}

  -- Physical spells with Dex stat mod
  blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
      'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
      'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

  -- Physical spells with Vit stat mod
  blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
      'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

  -- Physical spells with Agi stat mod
  blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
      'Pinecone Bomb','Spiral Spin','Wild Oats'}

  -- Physical spells with Int stat mod
  blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

  -- Physical spells with Mnd stat mod
  blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

  -- Physical spells with Chr stat mod
  blue_magic_maps.PhysicalChr = S{'Bludgeon'}

  -- Physical spells with HP stat mod
  blue_magic_maps.PhysicalHP = S{'Final Sting'}

  -- Magical spells with the typical Int mod
  blue_magic_maps.Magical = S{'Anvil Lightning','Blazing Bound','Bomb Toss','Cursed Sphere',
      'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
      'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
      'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

  blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
      'Tenebral Crush'}

  blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
      'Retinal Glare'}

  -- Magical spells with a primary Mnd mod
  blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

  -- Magical spells with a primary Chr mod
  blue_magic_maps.MagicalChr = S{'Mysterious Light'}

  -- Magical spells with a Vit stat mod (on top of Int)
  blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

  -- Magical spells with a Dex stat mod (on top of Int)
  blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

  -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
  -- Add Int for damage where available, though.
  blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
      'Auroral Drape','Awful Eye', 'Blank Gaze','Blastbomb','Blistering Roar','Blood Saber','Chaotic Eye',
      'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
      'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
      'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
      'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
      'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn','Cruel Joke'}

  -- Breath-based spells
  blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
      'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

  -- Stun spells
  blue_magic_maps.StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
  blue_magic_maps.StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

  -- Healing spells
  blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
      'Wild Carrot'}

  -- Buffs that depend on blue magic skill
  blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
      'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

  -- Other general buffs
  blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
      'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
      'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
      'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

  blue_magic_maps.Refresh = S{'Battery Charge'}

  -- Spells that require Unbridled Learning to cast.
  unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
      'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
      'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind ^l gs c toggle Learning')
  send_command('bind ^- input /ja "Chain Affinity" <me>')
  send_command('bind ^= input /ja "Burst Affinity" <me>')
  send_command('bind ^[ input /ja "Efflux" <me>')
  send_command('bind ![ input /ja "Diffusion" <me>')
  send_command('bind !] input /ja "Unbridled Learning" <me>')
  send_command('bind !q input /ma "Occultation" <me>')
  send_command('bind !e input /ma "Erratic Flutter" <me>')
  send_command('bind !\' input /ma "Battery Charge" <me>')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

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

  if player.sub_job == "RDM" then
    send_command('bind !o input /ma Phalanx <me>')
    send_command('bind !i input /ma Stoneskin <me>')
  elseif player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  end

  select_default_macro_book()

  Haste = 0
  DW_needed = 0
  DW = false
  update_combat_form()
  determine_haste_group()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @c')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^f8')
  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^l')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^[')
  send_command('unbind ![')
  send_command('unbind !]')
  send_command('unbind !q')
  send_command('unbind !e')

  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind !e')
  send_command('unbind !o')
  send_command('unbind !i')
  send_command('unbind !\'')

  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs

  -- Enmity set
  sets.Enmity = {
    ammo="Sapience Orb", --2
    ear1="Cryptic Earring", --4
    -- head="Halitus Helm", --8
    -- body="Emet Harness +1", --10
    -- hands="Kurys Gloves", --9
    -- feet="Ahosi Leggings", --7
    -- neck="Unmoving Collar +1", --10
    -- ear2="Trux Earring", --5
    -- ring1="Pernicious Ring", --5
    -- ring2="Eihwaz Ring", --5
    -- waist="Kasiri Belt", --3
  }

  sets.precast.JA['Provoke'] = sets.Enmity

  sets.buff['Burst Affinity'] = {
    legs="Assimilator's Shalwar +2",
    -- legs="Assimilator's Shalwar +3",
    -- feet="Hashishin Basmak +1"
  }
  sets.buff['Diffusion'] = {
    -- feet="Luhlaza Charuqs +3"
  }
  sets.buff['Efflux'] = {
    -- legs="Hashishin Tayt +1"
  }

  sets.precast.JA['Azure Lore'] = {
    -- hands="Luhlaza Bazubands +1"
  }
  sets.precast.JA['Chain Affinity'] = {
    -- feet="Assimilator's Charuqs +1"
  }
  sets.precast.JA['Convergence'] = {
    -- head="Luhlaza Keffiyeh +3"
  }
  sets.precast.JA['Enchainment'] = {
    -- body="Luhlaza Jubbah +3"
  }

  sets.precast.FC = {
    ammo="Sapience Orb",          --  2 [__/__, ___]
    head=gear.Carmine_D_head,     -- 14 [__/__,  53]
    hands=gear.Leyline_Gloves,    --  5 [__/__,  62]
    legs="Pinga Pants +1",        -- 13 [__/__, 147]
    feet=gear.Carmine_D_feet,     --  8 [ 4/__,  80]
    neck="Loricate Torque +1",    -- __ [ 6/ 6, ___]
    ear1="Loquacious Earring",    --  2 [__/__, ___]
    ear2="Odnowa Earring +1",     -- __ [ 3/ 5, ___]
    ring1="Kishar Ring",          --  4 [__/__, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    back=gear.BLU_FC_Cape,        -- 10 [10/__, ___]
    -- body="Pinga Tunic +1",     -- 15 [__/__, 128]
    -- hands=gear.Leyline_Gloves, --  7 [__/__,  62]
    -- waist="Flume Belt +1",     -- __ [ 4/__, ___]
    -- Blue Magic FC trait            5 [__/__, ___]
    -- 80 FC [37 PDT / 21 MDT, 470 M.Eva]
  }

  sets.precast.FC.RDM = {
    ammo="Sapience Orb",          --  2 [__/__, ___]
    head=gear.Carmine_D_head,     -- 14 [__/__,  53]
    hands=gear.Nyame_B_hands,     -- __ [ 7/ 7, 112]
    legs="Pinga Pants +1",        -- 13 [__/__, 147]
    feet=gear.Carmine_D_feet,     --  8 [ 4/__,  80]
    neck="Loricate Torque +1",    -- __ [ 6/ 6, ___]
    ear1="Loquacious Earring",    --  2 [__/__, ___]
    ear2="Odnowa Earring +1",     -- __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",   -- __ [ 7/-1, ___]
    ring2="Defending Ring",       -- __ [10/10, ___]
    back=gear.BLU_FC_Cape,        -- 10 [10/__, ___]
    -- body="Pinga Tunic +1",     -- 15 [__/__, 128]
    -- waist="Flume Belt +1",     -- __ [ 4/__, ___]
    -- Blue Magic FC trait            5 [__/__, ___]
    -- RDM FC traits                 15
    -- 84 FC [51 PDT / 27 MDT, 520 M.Eva]
  }

  -- 10% cap on Quick Magic
  sets.QuickMagic = {}
  sets.QuickMagic.RDM = {}


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ear1="Moonshade Earring",
    -- ammo="Aurgelmir Orb +1",
    -- neck="Fotia Gorget",
    -- ear2="Ishvara Earring",
    -- ring1="Epaminondas's Ring",
    -- ring2="Beithir Ring",
    -- back=gear.BLU_WSD_Cape,
    -- waist="Fotia Belt",
  }
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    -- ammo="Crepuscular Pebble",
  })

  sets.precast.WS['Chant du Cygne'] = {
    neck="Mirage Stole +2",
    -- ammo="Aurgelmir Orb +1",
    -- head=gear.Adhemar_B_head,
    -- body="Gleti's Cuirass",
    -- hands=gear.Adhemar_B_hands,
    -- legs="Gleti's Breeches",
    -- feet="Gleti's Boots",
    -- ear1="Mache Earring +1",
    -- ear2="Odr Earring",
    -- ring1="Epona's Ring",
    -- ring2="Begrudging Ring",
    -- back=gear.BLU_Crit_Cape,
    -- waist="Fotia Belt",
  }

  sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

  sets.precast.WS['Savage Blade'] = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Mirage Stole +2",
    ear2="Moonshade Earring",
    -- ammo="Coiste Bodhar", --Sub for Aurgelmir Orb +1
    -- ear1="Ishvara Earring",
    -- ring1="Epaminondas's Ring",
    -- ring2="Sroda Ring",
    -- back=gear.BLU_WSD_Cape,
    -- waist="Sailfi Belt +1",
  }
  sets.precast.WS['Savage Blade'].AttCapped = {
    head=gear.Nyame_B_head,
    hands=gear.Nyame_B_hands,
    feet=gear.Nyame_B_feet,
    neck="Mirage Stole +2",
    ear2="Moonshade Earring",
    -- ammo="Crepuscular Pebble",
    -- body="Gleti's Cuirass",
    -- legs="Gleti's Breeches",
    -- ear1="Ishvara Earring",
    -- ring1="Epaminondas's Ring",
    -- ring2="Sroda Ring",
    -- back=gear.BLU_WSD_Cape,
    -- waist="Sailfi Belt +1",
  }

  sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']
  sets.precast.WS['Expiacion'].AttCapped = sets.precast.WS['Savage Blade'].AttCapped

  sets.precast.WS['Sanguine Blade'] = {
    ammo="Pemphredo Tathlum",
    ear1="Moonshade Earring",
    ear2="Regal Earring",
    back=gear.BLU_FC_Cape,
    -- head="Pixie Hairpin +1",
    -- body="Amalric Doublet +1",
    -- hands="Amalric Gages +1",
    -- legs="Luhlaza Shalwar +3",
    -- feet="Amalric Nails +1",
    -- neck="Baetyl Pendant",
    -- ring1="Epaminondas's Ring",
    -- ring2="Archon Ring",
    -- waist="Sacro Cord",
  }

  sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
  
  sets.precast.WS['Judgment'] = sets.precast.WS['True Strike']
  

  sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']

  sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']

  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
    head=gear.Nyame_B_head,
    -- ring2="Weather. Ring",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC
  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Staunch Tathlum", --10
    ring1="Evanescence Ring", --5
    waist="Sanctuary Obi +1", --10
    -- ammo="Staunch Tathlum +1", --11
  }

  sets.midcast['Blue Magic'] = {
    neck="Mirage Stole +2",             -- 20, 25 [__/__, ___]
    ear1="Njordr Earring",              -- 10, __ [__/__, ___]
    ear2="Odnowa Earring +1",           -- __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",         -- __, __ [ 7/-1, ___]
    ring2="Stikini Ring +1",            --  8, 11 [__/__, ___]
    -- ammo="Mavi Tathlum",             --  5, __ [__/__, ___]
    -- head="Luhlaza Keffiyeh +3",      -- 17, 37 [__/__,  73]
    -- body="Assimilator's Jubbah +3",  -- 24, __ [__/__,  84]
    -- hands=gear.Rawhide_D_hands,      -- 10, 35 [__/__,  37]
    -- legs="Hashishin Tayt +1",        -- 23, __ [__/__, 112]
    -- feet="Luhlaza Charuqs +3",       -- 12, 36 [__/__,  89]
    -- ring1="Stikini Ring +1",         --  8, 11 [__/__, ___]
    -- back=gear.BLU_Adoulin_Cape,      -- 15, 15 [__/__, ___]
    -- waist="Flume Belt +1",           -- __, __ [ 4/__, ___]
  } -- 152 Blue skill, 170 M.Acc [14 PDT/4 MDT, 395 M.Eva]

  sets.midcast['Blue Magic'].Physical = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Mirage Stole +2",
    ear1="Dignitary's Earring",
    ring2="Defending Ring",
    waist="Grunfeld Rope",
    -- ammo="Aurgelmir Orb +1",
    -- ear2="Telos Earring",
    -- ring1="Epona's Ring",
    -- back=gear.BLU_STP_Cape,
  }

  sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
    -- ammo="Voluspa Tathlum",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
    ring2="Ilabrat Ring",
    waist="Grunfeld Rope",
    -- ear2="Mache Earring +1",
    -- back=gear.BLU_Crit_Cape,
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
    ring2="Ilabrat Ring",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
    ear2="Regal Earring",
    ring2="Metamorph Ring +1",
    waist="Acuity Belt +1",
    -- ring1="Shiva Ring +1",
    -- back=gear.BLU_MAB_Cape,
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
    ear2="Regal Earring",
    ring2="Stikini Ring +1",
    -- ring1="Stikini Ring +1",
  })

  -- TODO: Update
  sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring", ear2="Enchanter's Earring +1"})

  sets.midcast['Blue Magic'].Magical = {
    main="Bunzi's Rod",           -- 60, 50, 15 [__/__, ___]
    sub=empty,
    ammo="Pemphredo Tathlum",     --  4,  8,  4 [__/__, ___]
    head=gear.Nyame_B_head,       -- 30, 40, 28 [ 7/ 7, 123]
    body="Shamash Robe",          -- 45, 45, 40 [10/__, 106]
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,       -- 30, 40, 44 [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",    -- __, __, __ [ 6/ 6, ___]
    ear1="Regal Earring",         --  7, __, 10 [__/__, ___]
    ear2="Friomisi Earring",      -- 10, __, __ [__/__, ___]
    ring1="Metamorph Ring +1",    -- __, 15, 16 [__/__, ___]
    ring2="Defending Ring",       -- __, __, __ [10/10, ___]
    -- sub="Maxentius",           -- 21, 40, 15 [__/__, ___]
    -- hands="Jhakri Cuffs +2",   -- 40, 43, 36 [__/__,  32]
    -- feet="Jhakri Pigaches +2", -- 39, 42, 33 [__/__,  69]
    -- back=gear.BLU_MAB_Cape,    -- 10, 20, 30 [10/__, ___]
    -- waist="Eschan Stone",      --  7,  7, __ [__/__, ___]

    -- Ideal:
    -- main="Bunzi's Rod",        -- 60, 50, 15 [__/__, ___]
    -- sub="Maxentius",           -- 21, 40, 15 [__/__, ___]
    -- ammo="Pemphredo Tathlum",  --  4,  8,  4 [__/__, ___]
    -- head=gear.Nyame_B_head,    -- 30, 40, 28 [ 7/ 7, 123]
    -- body="Shamash Robe",       -- 45, 45, 40 [10/__, 106]
    -- hands=gear.Amalric_D_hands,-- 53, 20, 36 [__/__,  48]
    -- legs=gear.Nyame_B_legs,    -- 30, 40, 44 [ 8/ 8, 150]
    -- feet=gear.Amalric_D_feet,  -- 52, 20, 21 [__/__, 118]
    -- neck="Loricate Torque +1", -- __, __, __ [ 6/ 6, ___]
    -- ear1="Regal Earring",      --  7, __, 10 [__/__, ___]
    -- ear2="Friomisi Earring",   -- 10, __, __ [__/__, ___]
    -- ring1="Metamorph Ring +1", -- __, 15, 16 [__/__, ___]
    -- ring2="Defending Ring",    -- __, __, __ [10/10, ___]
    -- back=gear.BLU_MAB_Cape,    -- 10, 20, 30 [10/__, ___]
    -- waist="Eschan Stone",      --  7,  7, __ [__/__, ___]
    -- Amalric set bonus             20, __, __ [__/__, ___]
    -- 349 MAB, 305 M.Acc, 259 INT [51 PDT/31 MDT, 545 M.Eva]
  }

  sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
    main="Bunzi's Rod",                 -- 60, 50, 15 [__/__, ___]
    sub=empty,
    ammo="Pemphredo Tathlum",           --  4,  8,  4 [__/__, ___]
    head="Assimilator's Keffiyeh +3",   -- 28, 56, 33 [__/__,  73]
    body="Shamash Robe",                -- 45, 45, 40 [10/__, 106]
    hands=gear.Nyame_B_hands,           -- 30, 40, 28 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,             -- 30, 40, 44 [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,             -- 30, 40, 25 [ 7/ 7, 150]
    ear1="Regal Earring",               --  7, __, 10 [__/__, ___]
    ear2="Friomisi Earring",            -- 10, __, __ [__/__, ___]
    ring1="Metamorph Ring +1",          -- __, 15, 16 [__/__, ___]
    ring2="Defending Ring",             -- __, __, __ [10/10, ___]
    waist="Acuity Belt +1",             -- __, 15, 23 [__/__, ___]
    -- sub="Maxentius",                 -- 21, 40, 15 [__/__, ___]
    -- neck="Baetyl Pendant",           -- 13, __, __ [__/__, ___]
    -- back=gear.BLU_MAB_Cape,          -- 10, 20, 30 [10/__, ___]
    -- AF set bonus                        __, 15, __ [__/__, ___]
    -- 288 MAB, 384 M.Acc, 283 INT [52 PDT/32 MDT, 591 M.Eva]
  })-- 244 MAB, 309 M.Acc, 238 INT [42 PDT/32 MDT, 591 M.Eva]

  sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- head="Pixie Hairpin +1",
    -- ring1="Archon Ring",
  })

  sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- ring1="Weather. Ring"
  })

  sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
  })

  sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
    ring2="Ilabrat Ring",
    -- ammo="Aurgelmir Orb +1",
    -- ear2="Mache Earring +1",
  })

  sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- ammo="Aurgelmir Orb +1",
  })

  sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
    ear1="Regal Earring",
    -- ammo="Voluspa Tathlum",
    -- ear2="Enchanter's Earring +1"
  })

  sets.midcast['Blue Magic'].MagicAccuracy = {
    main="Bunzi's Rod", --40 macc
    sub=gear.Nibiru_Club_B,
    ammo="Pemphredo Tathlum",
    head="Assimilator's Keffiyeh +3",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Assimilator's Shalwar +2",
    feet="Malignance Boots",
    neck="Mirage Stole +2",
    ear1="Dignitary's Earring",
    ear2="Regal Earring",
    ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
    back="Aurist's Cape +1",
    waist="Acuity Belt +1",
    -- main="Sakpata's Sword", --Needs R25 for +10 macc
    -- main="Tizona",
    -- sub="Bunzi's Rod", --40 macc
    -- sub="Maxentius", --40 macc
    -- legs="Assimilator's Shalwar +3",
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
    neck="Mirage Stole +2",
    -- ammo="Voluspa Tathlum",
    -- ear2="Mache Earring +1",
    -- back=gear.BLU_STP_Cape,
    -- waist="Eschan Stone",
  })

  sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

  sets.midcast['Blue Magic'].Healing = { --Focus cure potency
    main="Bunzi's Rod",               -- 30, 15, __ [__/__, ___]
    sub=empty,
    ammo="Staunch Tathlum",           -- __, __, 10 [ 3/ 3, ___]
    head=gear.Nyame_B_head,           -- __, 26, __ [ 7/ 7, 123]
    body="Shamash Robe",              -- __, 40, __ [10/__, 106]
    hands=gear.Telchine_ENH_hands,    -- 17, 33, __ [__/__,  61]
    legs=gear.Nyame_B_legs,           -- __, 32, __ [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- __, 26, __ [ 7/ 7, 150]
    neck="Loricate Torque +1",        -- __, __,  5 [ 6/ 6, ___]
    ear1="Regal Earring",             -- __, 10, __ [__/__, ___]
    ear2="Halasz Earring",            -- __, __,  5 [__/__, ___]
    ring1="Defending Ring",           -- __, __, __ [10/10, ___]
    ring2="Stikini Ring +1",          -- __,  5, __ [__/__, ___]
    back=gear.BLU_FC_Cape,            -- __, 30, __ [10/__, ___]
    waist="Sanctuary Obi +1",         -- __, __, 10 [__/__, ___]
    -- Merits                            __, __, 10 [__/__, ___]

    -- sub="Sors Shield",             --  3, __, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, 11 [ 3/ 3, ___]
    -- hands=gear.Telchine_ENH_hands, -- 18, 33, __ [__/__,  62]
    -- legs="Carmine Cuisses +1",     -- __, 16, 20 [__/__,  80]
    -- ring2="Freke Ring",            -- __, __, 10 [__/__, ___]
    -- 51 Cure Potency, 196 MND, 71 SIRD [53 PDT / 33 MDT, 521 M.Eva]
  } -- 47 Cure Potency, 217 MND, 40 SIRD [61 PDT / 41 MDT, 590 M.Eva]

  sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
    ear2="Mendicant's Earring", -- (5)
    -- waist="Gishdubar Sash",     -- (10)
  })

  sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
    legs="Pinga Pants +1",
    feet=gear.Nyame_B_feet,
    ear2="Odnowa Earring +1",
    ring1="Gelatinous Ring +1",
    -- ammo="Egoist's Tathlum",
    -- head=gear.Telchine_Cure_head,
    -- body="Pinga Tunic +1",
    -- hands=gear.Telchine_Cure_hands,
    -- neck="Unmoving Collar +1",
    -- ear1="Tuisto Earring",
    -- ring2="Meridian Ring",
    -- back="Moonlight Cape",
    -- waist="Steppe Sash",
  })

  sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
  sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {
    waist="Gishdubar Sash",
    -- head="Amalric Coif +1",
    -- back="Grapevine Cape"
  })
  sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

  sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
    -- hands="Hashishin Bazu. +1",
    -- neck="Incanter's torque",
    -- ear1="Njordr Earring",
    -- ear2="Enchanter's Earring +1",
    -- ring2="Weatherspoon Ring",
  }) -- 1 shadow per 50 skill

  sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
    -- head="Amalric Coif +1",
    -- waist="Emphatikos Rope",
  })

  sets.midcast['Enhancing Magic'] = {
    ammo="Staunch Tathlum",
    head="Carmine Mask +1",
    body=gear.Telchine_ENH_body,
    hands=gear.Telchine_ENH_hands,
    feet=gear.Telchine_ENH_feet,
    ear1="Mimir Earring",
    ring1="Defending Ring", --10DT
    ring2="Stikini Ring +1",
    back=gear.BLU_FC_Cape, --10PDT
    -- main="Sakpata's Sword", --10DT
    -- ammo="Staunch Tathlum +1", --3DT
    -- legs="Carmine Cuisses +1",
    -- neck="Incanter's Torque",
    -- ear2="Andoaa Earring",
    -- waist="Olympus Sash",
  }

  sets.midcast.EnhancingDuration = {
    sub=gear.Colada_ENH,
    ammo="Staunch Tathlum",
    head=gear.Telchine_ENH_head,
    body=gear.Telchine_ENH_body,
    hands=gear.Telchine_ENH_hands,
    legs=gear.Telchine_ENH_legs,
    feet=gear.Telchine_ENH_feet,
    neck="Loricate Torque +1", --6DT
    ear1="Odnowa Earring +1", --3DT
    ring1="Defending Ring", --10DT
    ring2="Stikini Ring +1",
    back=gear.BLU_FC_Cape, --10PDT
    -- main="Sakpata's Sword", --10DT
    -- ammo="Staunch Tathlum +1", --3DT
    -- ear2="Andoaa Earring",
    -- waist="Flume Belt +1", --4PDT
  } --36DT, 14PDT

  sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
    waist="Gishdubar Sash",
    back="Grapevine Cape",
    -- head="Amalric Coif +1",
  })

  sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
    ear1="Earthcry Earring", --10
    -- hands="Stone Mufflers", --30
    -- waist="Siegel Sash", --20
    -- ear2="Andoaa Earring",
    -- legs="Shedir Seraweels", --35
  })

  sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {
    -- main="Sakpata's Sword", --5
    -- body=gear.Taeon_Phalanx_body, --3(10)
    -- hands=gear.Taeon_Phalanx_hands, --3(10)
    -- legs=gear.Taeon_Phalanx_legs, --3(10)
    -- feet=gear.Taeon_Phalanx_feet, --3(10)
  })

  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    hands="Regal Cuffs", --2
    -- head="Amalric Coif +1", --2
    -- legs="Shedir Seraweels", --1
    -- waist="Emphatikos Rope", --1
  })

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring1="Sheltered Ring"
  })
  sets.midcast.Protectra = sets.midcast.Protect
  sets.midcast.Shell = sets.midcast.Protect
  sets.midcast.Shellra = sets.midcast.Protect

  sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
    ear2="Vor Earring",
  })

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.passive_refresh = {
    main="Bolelabunga",             -- __/__, ___ [ 1]
    sub="Genmei Shield",            -- 10/__, ___ [__]
    ammo="Staunch Tathlum",         --  2/ 2, ___ [__]
    head=gear.Nyame_B_head,         --  7/ 7, 123 [__]
    body="Shamash Robe",            -- 10/__, 106 [ 3]; Resist Silence+90
    hands=gear.Nyame_B_hands,       --  7/ 7, 112 [__]
    legs=gear.Nyame_B_legs,         --  8/ 8, 150 [__]
    feet=gear.Nyame_B_feet,         --  7/ 7, 150 [__]
    neck="Loricate Torque +1",      --  6/ 6, ___ [__]; DEF+60
    ear1="Hearty Earring",          -- __/__, ___ [__]; Resist Status+5
    ear2="Etiolation Earring",      -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",        -- __/__, ___ [ 1]
    ring2="Defending Ring",         -- 10/10, ___ [__]
    back=gear.BLU_FC_Cape,          -- 10/__, ___ [__]
    waist="Carrier's Sash",         -- __/__, ___ [__]; Ele Resist+15
    -- ammo="Staunch Tathlum +1",   --  3/ 3, ___ [__]; Resist Status+11
    -- head="Rawhide Mask",         -- __/__,  53 [ 1]
    -- legs=gear.Rawhide_D_legs,    -- __/__,  69 [ 1]
    -- legs=gear.Lengo_legs,        -- __/__, 107 [ 1]
    -- ring2="Stikini Ring +1",     -- __/__, ___ [ 1]
    -- 53 PDT / 26 MDT, 528 M.Eva [8 Refresh]
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",
  }

  -- Resting sets
  sets.resting = {}

  sets.idle = sets.passive_refresh

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
    -- ring1="Vengeful Ring", --9EVA
    ring2="Gelatinous Ring +1", --7PDT
    -- back=gear.BLU_ENM_Cape, --45EVA
    -- waist="Shetal Stone", --10EVA
  } --48 DT, 7PDT

  sets.idle.DT = set_combine(sets.idle, {
    ammo="Staunch Tathlum", --2/2
    head="Malignance Chapeau", --6/6
    body="Malignance Tabard", --9/9
    hands="Malignance Gloves", --5/5
    legs="Malignance Tights", --7/7
    feet="Malignance Boots", --4/4
    ring2="Defending Ring", --10/10
    -- ammo="Staunch Tathlum +1", --3/3
    -- neck="Warder's Charm +1",
    -- ring1="Purity Ring", --0/4
    -- back="Moonlight Cape", --6/6
  })

  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)

  sets.idle.Weak = sets.idle.DT


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",     -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",     -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- main="Naegling",
    -- sub=empty,
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- ear1="Telos Earring",         -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ear2="Dedition Earring",      -- __,  8,-10 <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,       -- __, 10, 30 <__, __, __> [10/__, ___]
    -- waist="Windbuffet Belt +1",   -- __, __,  2 <__,  2,  2> [__/__, ___]
  } -- 0 DW, 83 STP, 307 Acc <7 DA, 5 TA, 2 QA> [51 PDT/41 MDT, 674 M.Eva]
  sets.engaged.Acc = set_combine(sets.engaged, {
    waist="Olseni Belt",          -- __,  3, 20 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ear2="Cessance Earring",   -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
  }) -- 0 DW, 84 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]


  -- Base Dual-Wield Values:
  -- * DW6: +37%
  -- * DW5: +35%
  -- * DW4: +30%
  -- * DW3: +25% (NIN Subjob)
  -- * DW2: +15% (DNC Subjob)
  -- * DW1: +10%
  -- I assume I'll always have DW3.

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW = {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- main="Naegling",
    -- sub=empty,
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    -- feet=gear.Taeon_DW_feet,      --  9, __,  7 <__, __, __> [__/__,  89]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,        -- 10, __, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  } -- 47 DW, 27 STP, 237 Acc <6 DA, 7 TA, 0 QA> [37 PDT/27 MDT, 481 M.Eva]
  sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
  }) -- 38 DW, 46 STP, 325 Acc <0 DA, 4 TA, 0 QA> [35 PDT/25 MDT, 542 M.Eva]

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    -- feet=gear.Taeon_DW_feet,      --  9, __,  7 <__, __, __> [__/__,  89]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- ear2="Dedition Earring",      -- __,  8,-10 <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,        -- 10, __, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 42 DW, 35 STP, 227 Acc <6 DA, 7 TA, 0 QA> [37 PDT/27 MDT, 481 M.Eva]
  sets.engaged.DW.Acc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    feet="Malignance Boots",   -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",    -- __,  7, 25 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ear2="Suppanomimi",        --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
  }) -- 38 DW, 46 STP, 325 Acc <0 DA, 4 TA, 0 QA> [35 PDT/25 MDT, 542 M.Eva]

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.LowHaste, {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",     -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,        -- 10, __, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 32 DW, 46 STP, 275 Acc <6 DA, 7 TA, 0 QA> [48 PDT/38 MDT, 612 M.Eva]
  sets.engaged.DW.Acc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
  }) -- 32 DW, 56 STP, 320 Acc <0 DA, 4 TA, 0 QA> [42 PDT/32 MDT, 612 M.Eva]

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW.MidHaste, {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",     -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- ear1="Telos Earring",         -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,       -- __, 10, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 18 DW, 68 STP, 310 Acc <7 DA, 7 TA, 0 QA> [42 PDT/32 MDT, 604 M.Eva]
  sets.engaged.DW.Acc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    body="Malignance Tabard",     -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ear2="Cessance Earring",   -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
  }) -- 17 DW, 75 STP, 351 Acc <7 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

  -- Super Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.DW.SuperHaste = set_combine(sets.engaged.DW.HighHaste, {
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    body="Malignance Tabard",     -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",     -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Coiste Bodhar",         -- __,  3, __ < 3, __, __> [__/__, ___]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- ear2="Dedition Earring",      -- __,  8,-10 <__, __, __> [__/__, ___]
    -- ring1="Epona's Ring",         -- __, __, __ < 3,  3, __> [__/__, ___]
    -- back=gear.BLU_STP_Cape,       -- __, 10, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 11 DW, 82 STP, 305 Acc <6 DA, 3 TA, 0 QA> [51 PDT/41 MDT, 682 M.Eva]
  sets.engaged.DW.SuperHaste.Acc = set_combine(sets.engaged.DW.SuperHaste, {
    waist="Olseni Belt",          -- __,  3, 20 <__, __, __> [__/__, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ear1="Telos Earring",      -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- ear2="Cessance Earring",   -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- ring1="Chirich Ring +1",   -- __,  6, 10 <__, __, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,     -- 10, __, 30 <__, __, __> [10/__, ___]
  }) -- 10 DW, 74 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

  -- Max Magic/Gear/JA Haste (0-25% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = set_combine(sets.engaged, {
    -- main="Naegling",
    -- sub="Thibron",
  }) -- 0 DW, 83 STP, 307 Acc <7 DA, 5 TA, 2 QA> [51 PDT/41 MDT, 674 M.Eva]
  sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.Acc, {
    -- main="Naegling",
    -- sub="Thibron",
  }) -- 0 DW, 84 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.DT = sets.engaged
  -- 0 DW, 83 STP, 307 Acc <7 DA, 5 TA, 2 QA> [51 PDT/41 MDT, 674 M.Eva]
  sets.engaged.Acc.DT = sets.engaged.Acc
  -- 0 DW, 84 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

  sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
    ammo="Staunch Tathlum",       -- __, __, __ <__, __, __> [ 2/ 2, ___]
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Staunch Tathlum +1",    -- __, __, __ <__, __, __> [ 3/ 3, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    -- feet=gear.Taeon_DW_feet,      --  9, __,  7 <__, __, __> [__/__,  89]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- ear2="Suppanomimi",           --  5, __, __ <__, __, __> [__/__, ___]
    -- back=gear.BLU_DW_Cape,        -- 10, __, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 47 DW, 24 STP, 237 Acc <0 DA, 4 TA, 0 QA> [47 PDT/29 MDT, 481 M.Eva]
  sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.DT, {
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
  }) -- 38 DW, 33 STP, 290 Acc <0 DA, 4 TA, 0 QA> [48 PDT/30 MDT, 542 M.Eva]

  sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ammo="Staunch Tathlum",       -- __, __, __ <__, __, __> [ 2/ 2, ___]
    head="Malignance Chapeau",    -- __,  8, 50 <__, __, __> [ 6/ 6, 123]
    hands="Malignance Gloves",    -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    neck="Loricate Torque +1",    -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear2="Odnowa Earring +1",     -- __, __, __ <__, __, __> [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
    ring2="Defending Ring",       -- __, __, __ <__, __, __> [10/10, ___]
    -- ammo="Staunch Tathlum +1",    -- __, __, __ <__, __, __> [ 3/ 3, ___]
    -- body=gear.Adhemar_B_body,     --  6, __, 35 <__,  4, __> [__/__,  69]
    -- legs=gear.Carmine_D_legs,     --  6, __, 55 <__, __, __> [__/__,  80]
    -- feet=gear.Taeon_DW_feet,      --  9, __,  7 <__, __, __> [__/__,  89]
    -- ear1="Eabani Earring",        --  4, __, __ <__, __, __> [__/__,   8]
    -- back=gear.BLU_DW_Cape,        -- 10, __, 30 <__, __, __> [10/__, ___]
    -- waist="Reiki Yotai",          --  7,  4, 10 <__, __, __> [__/__, ___]
  }) -- 42 DW, 24 STP, 237 Acc <0 DA, 4 TA, 0 QA> [50 PDT/34 MDT, 481 M.Eva]
  sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.DT.LowHaste, {
    feet="Malignance Boots",      -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
    -- ear2="Suppanomimi",        --  5, __, __ <__, __, __> [__/__, ___]
  }) -- 38 DW, 33 STP, 290 Acc <0 DA, 4 TA, 0 QA> [48 PDT/25 MDT, 542 M.Eva]

  sets.engaged.DW.DT.MidHaste = sets.engaged.DW.MidHaste
  sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.DT.MidHaste, {
    neck="Mirage Stole +2",       -- __,  7, 25 <__, __, __> [__/__, ___]
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
    -- ammo="Voluspa Tathlum",    -- __, __, 10 <__, __, __> [__/__, ___]
  }) -- 32 DW, 50 STP, 310 Acc <0 DA, 4 TA, 0 QA> [49 PDT/31 MDT, 612 M.Eva]

  sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ring1="Gelatinous Ring +1",   -- __, __, __ <__, __, __> [ 7/-1, ___]
  }) -- 18 DW, 68 STP, 310 Acc <4 DA, 4 TA, 0 QA> [49 PDT/31 MDT, 604 M.Eva]
  sets.engaged.DW.Acc.DT.HighHaste = sets.engaged.DW.Acc.HighHaste
  -- 17 DW, 75 STP, 351 Acc <7 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

  sets.engaged.DW.DT.SuperHaste = sets.engaged.DW.SuperHaste
  -- 11 DW, 82 STP, 305 Acc <6 DA, 3 TA, 0 QA> [51 PDT/41 MDT, 682 M.Eva]
  sets.engaged.DW.Acc.DT.SuperHaste = sets.engaged.DW.Acc.SuperHaste
  -- 10 DW, 74 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]

  sets.engaged.DW.DT.MaxHaste = sets.engaged.DW.MaxHaste
  -- 0 DW, 83 STP, 307 Acc <7 DA, 5 TA, 2 QA> [51 PDT/41 MDT, 674 M.Eva]
  sets.engaged.DW.Acc.DT.MaxHaste = sets.engaged.DW.Acc.MaxHaste
  -- 0 DW, 84 STP, 361 Acc <4 DA, 0 TA, 0 QA> [51 PDT/41 MDT, 674 M.Eva]


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.magic_burst = set_combine(sets.midcast['Blue Magic'].Magical, {
    -- body="Samnuha Coat", --(8)
    -- hands="Amalric Gages +1", --(5)
    -- legs="Assimilator's Shalwar +3", --10
    -- feet="Jhakri Pigaches +2", --5
    -- ring1="Mujin Band", --(5)
    -- back="Seshaw Cape", --5
  })

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.Learning = {
    hands="Assimilator's Bazubands +1",
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.TreasureHunter = {
    ammo="Perfect Lucky Egg",
    waist="Chaac Belt",
    -- feet=gear.Herc_TH_feet,
  }
  sets.TreasureHunter.RA = sets.TreasureHunter
  sets.midcast.Dia = sets.TreasureHunter
  sets.midcast.Diaga = sets.TreasureHunter
  sets.midcast.Bio = sets.TreasureHunter

  sets.WeaponSet = {}
  sets.WeaponSet['Naegling'] = {
    -- main="Naegling",
    sub="Genmei Shield",
  }
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Thibron",
  }
  sets.WeaponSet['Maxentius'] = {
    -- main="Maxentius",
    sub={name="Genmei Shield", priority=1},
  }
  sets.WeaponSet['Maxentius'].DW = {
    -- main="Maxentius",
    sub="Thibron",
  }
  sets.WeaponSet['Tizona'] = {
    -- main="Tizona",
    sub="Genmei Shield",
  }
  sets.WeaponSet['Tizona'].DW = {
    -- main="Tizona",
    sub="Thibron",
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  -- Use special FC set if subbing RDM
  if player.sub_job == 'RDM' and spell.type == 'Magic' then
    equipSet = select_specific_set(sets.precast.FC, spell, spellMap)
    -- Add optional casting mode
    if equipSet[state.CastingMode.current] then
      equipSet = equipSet[state.CastingMode.current]
    end
    if equipSet['RDM'] then
      equip(equipSet['RDM'])
      eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
    end
  end

  if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
    eventArgs.cancel = true
    windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
  end
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
  -- Handle belts for elemental WS
  if spell.type == 'WeaponSkill' and elemental_ws:contains(spell.english) then
    local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
    local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
    local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)
    local has_obi = true -- Change if you do or don't have Hachirin-no-Obi
    local has_orpheus = false -- Change if you do or don't have Orpheus's Sash

    -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
    if has_obi and (obi_mult >= orpheus_mult or not has_orpheus) and (obi_mult > base_day_weather_mult) then
      -- Obi is better than orpheus and better than nothing
      equip({waist="Hachirin-no-Obi"})
    elseif has_orpheus and (orpheus_mult > base_day_weather_mult) then
      -- Orpheus is better than obi and better than nothing
      equip({waist="Orpheus's Sash"})
    end
  end

  -- Always put this last in job_post_precast
  if in_battle_mode() then
    equip(select_weapons())
  end

  if state.Learning.value then
    equip(sets.Learning)
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
  -- Add enhancement gear for Chain Affinity, etc.
  if spell.skill == 'Blue Magic' then
    for buff,active in pairs(state.Buff) do
      if active and sets.buff[buff] then
        equip(sets.buff[buff])
      end
    end
    if spellMap == 'Healing' and spell.target.type == 'SELF' then
      equip(sets.midcast['Blue Magic'].HealingSelf)
    end
  end

  -- Handle belts for elemental damage
  if (spell.skill == 'Blue Magic' and spellMap == 'Magical') or spell.skill == 'Elemental Magic' then
    local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
    local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
    local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)
    local has_obi = true -- Change if you do or don't have Hachirin-no-Obi
    local has_orpheus = false -- Change if you do or don't have Orpheus's Sash

    -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
    if has_obi and (obi_mult >= orpheus_mult or not has_orpheus) and (obi_mult > base_day_weather_mult) then
      -- Obi is better than orpheus and better than nothing
      equip({waist="Hachirin-no-Obi"})
    elseif has_orpheus and (orpheus_mult > base_day_weather_mult) then
      -- Orpheus is better than obi and better than nothing
      equip({waist="Orpheus's Sash"})
    end
  end

  if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
    equip(sets.midcast.EnhancingDuration)
    if spellMap == 'Refresh' then
      equip(sets.midcast.Refresh)
    end
  end

  -- Always put this last in job_post_midcast
  if in_battle_mode() then
    equip(select_weapons())
  end
  
  if state.Learning.value then
    equip(sets.Learning)
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
  update_combat_form()
  determine_haste_group()
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
        return category
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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 0 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 0 and DW_needed <= 11 then
      classes.CustomMeleeGroups:append('SuperHaste')
    elseif DW_needed > 11 and DW_needed <= 18 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 18 and DW_needed <= 31 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 31 and DW_needed <= 42 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 42 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  if cmdParams[1] == 'weaponset' then
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
    if not midaction() then
      job_update()
    end
  end
end

function update_active_abilities()
  state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
  state.Buff['Efflux'] = buffactive['Efflux'] or false
  state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
  if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
    if state.MagicBurst.value then
      equip(sets.magic_burst)
    end
    equip(sets.buff['Burst Affinity'])
  end
  if state.Buff.Efflux and spellMap == 'Physical' then
    equip(sets.buff['Efflux'])
  end
  if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
    equip(sets.buff['Diffusion'])
  end

  if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
  if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
  if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
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

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if has_dual_wield_trait() and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      return sets.WeaponSet[state.WeaponSet.current].DW
    elseif sets.WeaponSet[state.WeaponSet.current] then
      return sets.WeaponSet[state.WeaponSet.current]
    end
  end
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting' or state.ToyWeapons.current ~= 'None'
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'WAR' then
      set_macro_page(1, 5)
  elseif player.sub_job == 'RDM' then
      set_macro_page(2, 5)
  end

  set_macro_page(1,5)
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

function has_dual_wield_trait()
  local abilities = windower.ffxi.get_abilities()
  local traits = S(abilities.job_traits)
  if traits:contains(18) then
    return true
  end
  return false
end