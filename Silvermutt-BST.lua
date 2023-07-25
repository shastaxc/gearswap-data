-- File Status: WIP. Not ready for use.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: N/A
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable RollTracker

-------------------------------------------------------------------------------------------------------------------
-- Notes about this specific lua
-------------------------------------------------------------------------------------------------------------------
-- Automatic Pet Targeting will cause you to use Fight automatically on your current target if you are engaged
-- and your pet is idle. There is a keybind to toggle it if you choose.

-- If your pet is engaged and you are in Pet mode, you will be in a PetEngaged set typically. If you need movement
-- speed gear equipped in this situation, you can toggle on Kiting mode (CTRL+F10). Just remember to turn it off
-- when you're done.

-- Feel free to put weapons into various sets. They will only swap if in Pet hybrid mode. Otherwise, it will always
-- lock you into the set you currently have set according to the WeaponSet cycle.

-- Most pet Ready moves will not swap gear for the midcast if you are in Master hybrid mode unless they are
-- included in the list called master_swap_moves. Feel free to modify that list as you see fit.

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
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

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
    send_command('gs c weaponset current')
  end, 5)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(17)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('Master', 'Pet', 'Halfsies')
  state.IdleMode:options('Normal', 'DT')
  state.CP = M(false, 'Capacity Points Mode')
  state.AutomaticPetTargeting = M(true, 'Automatic Pet Targeting')
  state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}

  state.PetMode = M{['description']='Pet Mode', 'Tank', 'DD'}

  state.JugMode = M{['description']='Jug Mode', 'Generous Arthur', 'Vivacious Vickie', 'Rhyming Shizuna', 'Swooping Zhivago'}

  -- Jug pets info
  jugs = {
    -- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
    ['Funguar Familiar']        = {item='Seedbed Soil', nq_pet=''},
    ['Courier Carrie']          = {item='Fish Oil Broth', nq_pet=''},
    ['Amigo Sabotender']        = {item='Sun Water', nq_pet=''},
    ['Nursery Nazuna']          = {item='D. Herbal Broth', nq_pet=''},
    ['Crafty Clyvonne']         = {item='Cng. Brain Broth', nq_pet=''},
    ['Presto Julio']            = {item='C. Grass. Broth', nq_pet=''},
    ['Swift Sieghard']          = {item='Mlw. Bird Broth', nq_pet=''},
    ['Mailbuster Cetas']        = {item='Gob. Bug Broth', nq_pet=''},
    ['Audacious Anna']          = {item='B. Carrion Broth', nq_pet=''},
    ['Turbid Toloi']            = {item='Auroral Broth', nq_pet=''},
    ['Lucky Lulush']            = {item='L. Carrot Broth', nq_pet=''},
    ['Dipper Yuly']             = {item='Wool Grease', nq_pet=''},
    ['Flowerpot Merle']         = {item='Vermihumus', nq_pet=''},
    ['Dapper Mac']              = {item='Briny Broth', nq_pet=''},
    ['Discreet Louise']         = {item='Deepbed Soil', nq_pet=''},
    ['Fatso Fargann']           = {item='C. Plasma Broth', nq_pet=''},
    ['Faithful Falcorr']        = {item='Lucky Broth', nq_pet=''},
    ['Bugeyed Broncha']         = {item='Svg. Mole Broth', nq_pet=''},
    ['Bloodclaw Shasra']        = {item='Rzr. Brain Broth', nq_pet=''},
    ['Gorefang Hobs']           = {item='B. Carrion Broth', nq_pet=''},
    ['Gooey Gerard']            = {item='Cl. Wheat Broth', nq_pet=''},
    ['Crude Raphie']            = {item='Shadowy Broth', nq_pet=''},

    -- Complete iLvl Jug Pet Precast List
    ['Droopy Dortwin']          = {item='Swirling Broth', nq_pet=''},
    ['Sunburst Malfik']         = {item='Shimmering Broth', nq_pet=''},
    ['Warlike Patrick']         = {item='Livid Broth', nq_pet=''},
    ['Scissorleg Xerin']        = {item='Spicy Broth', nq_pet=''},
    ['Rhyming Shizuna']         = {item='Lyrical Broth', nq_pet=''},
    ['Attentive Ibuki']         = {item='Salubrious Broth', nq_pet=''},
    ['Amiable Roche']           = {item='Airy Broth', nq_pet=''},
    ['Herald Henry']            = {item='Trans. Broth', nq_pet=''},
    ['Brainy Waluis']           = {item='Crumbly Soil', nq_pet=''},
    ['Headbreaker Ken']         = {item='Blackwater Broth', nq_pet=''},
    ['Suspicious Alice']        = {item='Furious Broth', nq_pet=''},
    ['Anklebiter Jedd']         = {item='Crackling Broth', nq_pet=''},
    ['Fleet Reinhard']          = {item='Rapid Broth', nq_pet=''},
    ['Cursed Annabelle']        = {item='Creepy Broth', nq_pet=''},
    ['Surging Storm']           = {item='Insipid Broth', nq_pet=''},
    ['Redolent Candi']          = {item='Electrified Broth', nq_pet=''},
    ['Caring Kiyomaro']         = {item='Fizzy Broth', nq_pet=''},
    ['Hurler Percival']         = {item='Pale Sap', nq_pet=''},
    ['Blackbeard Randy']        = {item='Meaty Broth', nq_pet=''},
    ['Generous Arthur']         = {item='Dire Broth', nq_pet=''},
    ['Threestar Lynn']          = {item='Muddy Broth', nq_pet=''},
    ['Mosquito Familiar']       = {item='Wetlands Broth', nq_pet=''},
    ['BraveHero Glenn']         = {item='Wispy Broth', nq_pet=''},
    ['Sharpwit Hermes']         = {item='Saline Broth', nq_pet=''},
    ['Colibri Familiar']        = {item='Sugary Broth', nq_pet=''},
    ['Spider Familiar']         = {item='Sticky Webbing', nq_pet=''},
    ['Acuex Familiar']          = {item='Poisonous Broth', nq_pet=''},
    ['Weevil Familiar']         = {item='Pristine Sap', nq_pet=''},
    ['Sweet Caroline']          = {item='Aged Humus', nq_pet=''},
    ['Porter Crab Familiar']    = {item='Rancid Broth', nq_pet=''},
    ['Yellow Beetle Familiar']  = {item='Zestful Sap', nq_pet=''},
    ['Lynx Familiar']           = {item='Frizzante Broth', nq_pet=''},
    ['Hippogryph Familiar']     = {item='Turpid Broth', nq_pet=''},
    ['Slime Familiar']          = {item='Decaying Broth', nq_pet=''},

    -- HQ pets
    ['Pondering Peter']         = {item='Vis. Broth', nq_pet='Droopy Dortwin'},
    ['Aged Angus']              = {item='Ferm. Broth', nq_pet='Sunburst Malfik'},
    ['Bouncing Bertha']         = {item='Bubbly Broth', nq_pet='Scissorleg Xerin'},
    ['Swooping Zhivago']        = {item='Windy Greens', nq_pet='Attentive Ibuki'},
    ['Alluring Honey']          = {item='Bug-Ridden Broth', nq_pet='Redolent Candi'},
    ['Vivacious Vickie']        = {item='Tant. Broth', nq_pet='Caring Kiyomaro'},
    ['Choral Leera']            = {item='Glazed Broth', nq_pet='Colibri Familiar'},
    ['Gussy Hachirobe']         = {item='Slimy Webbing', nq_pet='Spider Familiar'},
    ['Submerged Iyo']           = {item='Deepwater Broth', nq_pet='Surging Storm'},
    ['Fluffy Bredo']            = {item='Venomous Broth', nq_pet='Acuex Familiar'},
    ['Left-Handed Yoko']        = {item='Heavenly Broth', nq_pet='Mosquito Familiar'},
    ['Stalwart Angelina']       = {item='T. Pristine Sap', nq_pet='Weevil Familiar'},
    ['Jovial Edwin']            = {item='Pungent Broth', nq_pet='Porter Crab Familiar'},
    ['Energized Sefina']        = {item='Gassy Sap', nq_pet='Yellow Beetle Familiar'},
    ['Vivacious Gaston']        = {item='Spumante Broth', nq_pet='Lynx Familiar'},
    ['Daring Roland']           = {item='Feculent Broth', nq_pet='Hippogryph Familiar'},
    ['Sultry Patrice']          = {item='Putrescent Broth', nq_pet='Slime Familiar'},
  }

  -- Categories: physical, matk, macc, buff
  -- Some values pulled from Windower resources on load
  ready_moves = {
    ['Foot Kick'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Whirl Claws'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Sheep Charge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Lamb Chop'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Head Butt'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Wild Oats'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Leaf Dagger'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Claw Cyclone'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Razor Fang'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Crossthrash'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Nimble Snap'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Cyclotail'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Rhino Attack'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Power Attack'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Mandibular Bite'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Big Scissors'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Grapple'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Spinning Top'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Double Claw'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Frogkick'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Blockhead'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Brain Crush'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Tail Blow'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Scythe Tail'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Ripper Fang'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Chomp Rush'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=true},
    ['Needleshot'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Recoil Dive'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Sudden Lunge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Spiral Spin'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Wing Slap'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true},
    ['Beak Lunge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Suction'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Back Heel'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Fantod'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Tortoise Stomp'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Sensilla Blades'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Tegmina Buffet'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Pentapeck'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=true},
    ['Sweeping Gouge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true},
    ['Somersault'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Tickling Tendrils'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true},
    ['Pecking Flurry'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true},
    ['Sickle Slash'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Disembowel'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Extirpating Salvo'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Mega Scissors'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Rhinowrecker'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Hoof Volley'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false},
    ['Fluid Toss'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},
    ['Fluid Spread'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false},

    ['Dust Cloud'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Cursed Sphere'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Venom'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Bubble Shower'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Drainkiss'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Silence Gas'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Dark Spore'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Fireball'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    -- ['Plague Breath'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Snow Cloud'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Charged Whisker'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Corrosive Ooze'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Aqua Breath'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Stink Bomb'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Nectarous Deluge'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Nepenthic Plunge'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Pestilent Plume'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Foul Waters'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Acid Spray'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Infected Leech'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false},
    ['Gloom Spray'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},
    ['Venom Shower'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false},

    ['Sheep Song'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Scream'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Dream Flower'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Roar'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Predatory Glare'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Gloeosuccus'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Palsy Pollen'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Soporific'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Geist Wall'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Toxic Spit'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Numbing Noise'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Spoil'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Hi-Freq Field'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Sandpit'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Sandblast'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Venom Spray'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Filamented Hold'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Queasyshroom'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Numbshroom'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Spore'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Shakeshroom'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Infrasonics'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Chaotic Eye'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Blaster'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Purulent Ooze'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Intimidate'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Noisome Powder'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Acid Mist'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Choke Breath'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Jettatura'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},
    ['Nihility Song'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Molting Plumage'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Swooping Frenzy'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false},
    ['Spider Web'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},

    ['Wild Carrot'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Bubble Curtain'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Scissor Guard'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Secretion'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Rage'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Harden Shell'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['TP Drainkiss'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false},
    ['Rhino Guard'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Zealous Snort'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Frenzied Rage'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Digest'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false},
    ['Metallic Body'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false},
    ['Water Wall'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false},
  }

  for k,v in pairs(ready_moves) do
    local ja = res.job_abilities:with('en', k)
    v.id = ja.id
    v.charges = ja.mp_cost
    v.name = k
  end

  -- List of Ready moves to allow gear swapping even when hybrid mode is set to 'Master'
  master_swap_moves = S{
    'Purulent Ooze',
  }

  sets.org.job = {}

  -- Add jugs from JugMode to org array
  for k,name in ipairs(state.JugMode) do
    if jugs[name] then
      sets.org.job[#sets.org.job+1] = {ammo=jugs[name].item}
    else
      print('Error: Cannot find jug item for pet '..name)
    end
  end

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if S{'THF','DNC','RDM','BRD','RNG','NIN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Normal', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Normal'}
  end

  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- Pet DT options [PDT/MDT, M.Eva] {Pet: PDT/MDT, Level}:
  -- head="Hike Khat +1",             -- [13/__,  75] { 5/ 5, ___}
  -- head=gear.Anwig_Salade,          -- [__/__, ___] {10/10, ___}
  -- head=gear.Taeon_Pet_DT_head,     -- [__/__,  73] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- body=gear.Taeon_Pet_DT_body,     -- [__/__,  84] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet DA+5
  -- hands=gear.Taeon_Pet_DT_hands,   -- [__/__,  57] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
  -- legs="Foire Churidars +3",       -- [__/__, 104] { 6/ 6, ___}
  -- legs="Tali'ah Seraweels +2",     -- [__/__,  69] { 5/ 5, ___}
  -- legs=gear.Taeon_Pet_DT_legs,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- feet=gear.Taeon_Pet_DT_feet,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- feet="Mpaca's Boots",            -- [ 6/__,  96] {__/__,   1}
  -- neck="Shepherd's Chain",         -- [__/__, ___] { 2/ 2, ___}
  -- ear1="Handler's Earring +1",     -- [__/__, ___] { 4/__, ___}
  -- ear1="Enmerkar Earring",         -- [__/__, ___] { 3/ 3, ___}
  -- ear1="Hypaspist Earring",        -- [-5/__, ___] { 5/__, ___}
  -- ear1="Rimeice Earring",          -- [__/__, ___] { 1/ 1, ___}
  -- ear2="Karagoz Earring +2",       -- [__/__, ___] {__/__,   1}
  -- ring1="Thurandaut Ring +1",      -- [__/__, ___] { 4/ 4, ___}; Adoulin ring
  -- back=gear.PUP_ambu_cape,         -- [__/__, ___] { 5/ 5,   1}
  -- waist="Isa Belt",                -- [__/__, ___] { 3/ 3, ___}

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Your Auto starts off with Burden, to help reduce the burden equip Overload- gear.
  sets.precast.JA['Activate'] = {
    range="Neo Animator",             -- __, __ [__/__, ___] {__/__, 119}
    head="Hike Khat +1",              -- __, __ [13/__,  75] { 5/ 5, ___}
    body="Karagoz Farsetto +2",       -- 40, __ [12/12,  99] {__/__, ___}
    hands="Foire Dastanas +3",        --  5,  5 [__/__,  46] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- __, __ [ 8/ 8, 150] {__/__, ___}
    neck="Buffoon's Collar +1",       --  5, __ [__/__, ___] {__/__, ___}
    ear1="Burana Earring",            -- __,  1 [__/__, ___] {__/__, ___}
    ear2="Karagoz Earring +1",        -- __, __ [__/__, ___] {__/__,   1}
    ring1="Gelatinous Ring +1",       -- __, __ [ 7/-1, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___}
    back=gear.PUP_Pet_Tank_Cape,      -- 10, __ [__/__,  20] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- __, __ [ 6/ 6, ___] {__/__, ___}
    -- 60 Overload-, 6 Maneuver+ [56 PDT/35 MDT, 390 M.Eva] {Pet: 10 PDT/10 MDT, 121 Lv+}
    
    -- body="Karagoz Farsetto +3",    -- 40, __ [13/13, 109] {__/__, ___}
    -- legs="Foire Churidars +3",     -- __, __ [__/__,  84] { 6/ 6, ___}
    -- ear2="Karagoz Earring +2",     -- __, __ [__/__, ___] {__/__,   1}
    -- 60 Overload-, 6 Maneuver+ [55 PDT/28 MDT, 430 M.Eva] {Pet: 16 PDT/16 MDT, 122 Lv+}
  }

  -- Pet HP+ can help increase healing, but you will only get 40% of that restored as
  -- HP, which is insignificant. It is not worth shoehorning in pet HP pieces just for
  -- that purpose, if you have to sacrifice other important stats.
	sets.precast.JA['Repair'] = {
    range="Neo Animator",             -- __, __ [__/__, ___] {__/__, 119 |  60}
    ammo="Can of Automaton Oil +3",   -- __, __ [__/__, ___] {__/__, ___ | ___}
    head="Hike Khat +1",              -- __, __ [13/__,  75] { 5/ 5, ___ | ___}
    body=gear.Taeon_Pet_DT_body,      -- __, __ [__/__,  84] { 4/ 4, ___ | ___}; Augs: +20 M.Eva, -4 Pet DT, Pet DA+5
    hands=gear.Herc_Repair_hands,     -- __,  7 [ 2/__,  43] {__/__, ___ | ___}
    legs=gear.Herc_Repair_legs,       -- __,  6 [ 2/__,  75] {__/__, ___ | ___}
    feet="Foire Babouches +3",        --  3, __ [__/__,  87] {__/__, ___ | ___}
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] {__/__, ___ | ___}
    ear1="Enmerkar Earring",          -- __, __ [__/__, ___] { 3/ 3, ___ | ___}
    ear2="Guignol Earring",           -- __, 20 [__/__, ___] {__/__, ___ | ___}
    ring1="Cath Palug Ring",          -- __, __ [ 5/ 5, ___] {__/__, ___ | ___}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___ | ___}
    back=gear.PUP_Pet_TP_Cape,        -- __, __ [__/__,  20] { 5/ 5,   1 | ___}
    waist="Isa Belt",                 -- __, __ [__/__, ___] { 3/ 3, ___ | ___}
    -- 3 Repair+, 33 Repair Potency [38 PDT/21 MDT, 384 M.Eva] {Pet: 20 PDT/20 MDT, 120 Lv | 60 HP}

    -- hands=gear.Herc_Repair_hands,  -- __,  8 [ 2/__,  43] {__/__, ___ | ___}
    -- legs=gear.Herc_Repair_legs,    -- __,  8 [ 2/__,  75] {__/__, ___ | ___}
    -- ear1="Pratik Earring",         -- __, 10 [__/__, ___] {__/__, ___ | ___}
    -- 3 Repair+, 46 Repair Potency [38 PDT/21 MDT, 384 M.Eva] {Pet: 17 PDT/17 MDT, 120 Lv | 60 HP}
  }

  sets.precast.JA['Overdrive'] = {
    body="Pitre Tobe +3",
  }

  sets.precast.JA['Role Reversal'] = {
    feet="Pitre Babouches +3",
  }

  sets.precast.JA['Tactical Switch'] = {
    feet="Karagoz Scarpe +2",
  }

  sets.precast.JA['Ventriloquy'] = {
    legs="Pitre Churidars +3",
  }

  sets.precast.ReadyRecast = {legs="Gleti's Breeches"}

  -- TODO: update
  sets.precast.Waltz = {
    body="Passion Jacket",
  }

  sets.precast.FC = {
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ring2="Prolix Ring", --2
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Passion Jacket",
    neck="Magoraga Beads",
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Master WS Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ranged="Neo Animator",            -- __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body=gear.Nyame_B_body,           -- 45, 13 < 7, __, __> [ 9/ 9, 139] {__/__, ___} 
    hands=gear.Herc_TA_hands,         -- 16, __ <__,  6, __> [ 2/__,  43] {__/__, ___}
    legs="Mpaca's Hose",              -- 49, __ <__,  4, __> [ 9/__,  96] {__/__, ___}
    feet=gear.Herc_TA_feet,           -- 16, __ <__,  6, __> [ 2/__,  75] {__/__, ___}
    neck="Fotia Gorget",              -- __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Schere Earring",            --  5, __ < 6, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Niqmaddu Ring",            -- 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __ <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 224 STR, 18 WSD <18 DA, 27 TA, 3 QA> [45 PDT/25 MDT, 422 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
    
    -- back=gear.PUP_STR_DA_Cape,     -- 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    -- 224 STR, 18 WSD <28 DA, 27 TA, 3 QA> [45 PDT/25 MDT, 422 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Brutal Earring",            -- __, __ < 5, __, __> [__/__, ___] {__/__, ___}
  })

  -- Victory Smite: 80% STR, 1.5 fTP, 4 hit, can crit, ftp replicating
  -- crit dmg > TP Bonus = crit rate > multihit
  -- 1000 TP bonus = ~15% crit rate
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __, __ <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, __,  4 < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body="Mpaca's Doublet",           -- 39, __,  7 <__,  4, __> [10/__,  86] {__/__, ___}
    hands=gear.Ryuo_A_hands,          -- 24,  5,  5 <__, __, __> [__/__,  32] {__/__, ___}
    legs="Mpaca's Hose",              -- 49, __,  6 <__,  4, __> [ 9/__,  96] {__/__, ___}
    feet=gear.Herc_STR_CritDmg_feet,  -- 16,  5, __ <__,  2, __> [ 2/__,  75] {__/__, ___}
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___}
    ear1="Odr Earring",               -- __, __,  5 <__, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Sroda Ring",               -- 15, __, __ <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __, 10 <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 226 STR, 10 Crit Dmg, 37 Crit Rate <5 DA, 21 TA, 0 QA> [50 PDT/22 MDT, 358 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
  })
  sets.precast.WS["Victory Smite"].MaxTP = set_combine(sets.precast.WS["Victory Smite"], {
    ear2="Schere Earring",            --  5, __, __ < 6, __, __> [__/__, ___] {__/__, ___}
  })

  -- 32% STR / 32% VIT - Chance of Critical varies w/ TP (Mythic WS)
  sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS['Victory Smite'], {})
  sets.precast.WS['Stringing Pummel'].MaxTP = set_combine(sets.precast.WS['Victory Smite'].MaxTP, {})

  -- Shijin Spiral: 100% DEX, 1.5 fTP, 5 hit, ftp replicating
  -- DEX > multihit > WSD
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 30, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}
    body="Malignance Tabard",         -- 49, __ <__, __, __> [ 9/ 9, 139] {__/__, ___}
    hands="Malignance Gloves",        -- 56, __ <__, __, __> [ 5/ 5, 112] {__/__, ___}
    legs=gear.Samnuha_legs,           -- 16, __ < 3,  3, __> [__/__,  75] {__/__, ___}
    feet="Mpaca's Boots",             -- 32, __ <__,  3, __> [ 6/__,  96] {__/__, ___}
    neck="Puppetmaster's Collar +1",  -- 12, __ <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Odr Earring",               -- 10, __ <__, __, __> [__/__, ___] {__/__, ___}
    ear2="Schere Earring",            -- __, __ < 6, __, __> [__/__, ___] {__/__, ___}
    ring1="Niqmaddu Ring",            -- 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- __, __ <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 235 DEX, 5 WSD <14 DA, 17 TA, 3 QA> [43 PDT/30 MDT, 491 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}

    -- neck="Puppetmaster's Collar +2"-- 15, __ <__, __, __> [__/__, ___] {__/__, ___}
    -- ear2="Karagoz Earring +2",     -- 15, __ <__, __, __> [__/__, ___] {__/__,   1}
    -- back=gear.PUP_DEX_DA_Cape,     -- 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    -- 283 DEX, 5 WSD <18 DA, 17 TA, 3 QA> [43 PDT/30 MDT, 491 M.Eva] {Pet: 5 PDT/5 MDT, 121 Lv}
  })
  sets.precast.WS["Shijin Spiral"].MaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {})
  
  -- Asuran Fists: 15% STR / 15% VIT, 1.25 fTP, 8 hit, ftp replicating
  -- WSD > STR/VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 [__/__, ___] {__/__, 119}
    head=gear.Nyame_B_head,           -- 26, 24, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 45, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 54, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 24, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ [__/__, ___] {__/__, ___}; ftp+
    ear1="Enmerkar Earring",          -- __, __, __ [__/__, ___] { 3/ 3, ___}
    ear2="Ishvara Earring",           -- __, __,  2 [__/__, ___] {__/__, ___}
    ring1="Epaminondas's Ring",       -- __, __,  5 [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __, __ [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ [ 6/ 6, ___] {__/__, ___}
    -- 229 STR, 187 VIT, 70 WSD [44 PDT/44 MDT, 674 M.Eva] {Pet: 13 PDT/13 MDT, 120 Lv}
    
    -- back=gear.PUP_STR_WSD_Cape,    -- 30, __, 10 [__/__, ___] { 5/ 5,   1}; WSD cape would be better
    -- 229 STR, 187 VIT, 80 WSD [44 PDT/44 MDT, 674 M.Eva] {Pet: 3 PDT/3 MDT, 120 Lv}
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {})

  -- Raging Fists: 30% STR / 30% DEX, 1.0-3.75 fTP, 5 hit, ftp replicating
  -- TP Bonus > WSD > Multihit (assuming always used with high TP)
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, 30, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body=gear.Nyame_B_body,           -- 45, 24, 13 < 7, __, __> [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 42, 11 < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, __, 12 < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 26, 11 < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __, __ <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 246 STR, 152 DEX, 52 WSD <33 DA, 16 TA, 3 QA> [44 PDT/37 MDT, 620 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}

    -- ear1="Moonshade Earring",      -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    -- ear2="Karagoz Earring +2",     -- 15, 15, __ <__, __, __> [__/__, ___] {__/__,   1}
    -- back=gear.PUP_STR_DA_Cape,     -- 30, __, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Ishvara Earring",           -- __, __,  2 <__, __, __> [__/__, ___] {__/__, ___}

    -- Once karagoz earring +2 acquired:
    -- ear1="Brutal Earring",         -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    -- ear2="Karagoz Earring +2",     -- 15, 15, __ <__, __, __> [__/__, ___] {__/__,   1}
  })

  -- Spinning Attack: 100% STR, 1.0 fTP, 1 hit (aoe-physical), ftp replicating
  -- Multihit > WSD
  sets.precast.WS["Spinning Attack"] = set_combine(sets.precast.WS["Raging Fists"], {})
  sets.precast.WS["Spinning Attack"].MaxTP = set_combine(sets.precast.WS["Raging Fists"].MaxTP, {})

  -- Howling Fist: 50% VIT / 20% STR, 2.05-5.8 fTP, 2 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, 26, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body=gear.Nyame_B_body,           -- 45, 45, 13 < 7, __, __> [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 54, 11 < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 30, 12 < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 24, 11 < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __, __ <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 246 STR, 189 VIT, 52 WSD <33 DA, 16 TA, 3 QA> [44 PDT/37 MDT, 620 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
    
    -- back=gear.PUP_VIT_DA_Cape,     -- __, 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    head=gear.Nyame_B_head,           -- 26, 24, 11 < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    ear2="Schere Earring",            --  5, __, __ < 6, __, __> [__/__, ___] {__/__, ___}
  })

  sets.MAB = {
  }

  -- Cataclysm: 40% DEX/40% INT, 2.0-4.5 fTP, 1 hit (aoe-magical)
  -- Stack MAB > INT > DEX > WSD
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, sets.MAB, {
    ranged="Neo Animator",            -- __, __, __,  5 [__/__, ___] {__/__, 119}
    head=gear.Nyame_B_head,           -- 25, 28, 30, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 42, 30, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 28, 30, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- __, 44, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Herc_MAB_feet,          -- 24, __, 57, __ [ 2/__,  75] {__/__, ___}
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __ [__/__, ___] {__/__, ___}
    ear2="Novio Earring",             -- __, __,  7, __ [__/__, ___] {__/__, ___}
    ring1="Shiva Ring +1",            -- __,  9,  3, __ [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5, __ [__/__, ___] {__/__, ___}
    -- 115 DEX, 161 INT, 224 MAB, 52 WSD [43 PDT/41 MDT, 599 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.PUP_MAB_Cape,        -- __, 30, 10, __ [__/__, ___] { 5/ 5,   1}
    -- waist="Skrymir Cord +1",       -- __, __,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {})

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __, __ <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 30, __,  4 < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body="Mpaca's Doublet",           -- 37, __,  7 <__,  4, __> [10/__,  86] {__/__, ___}
    hands=gear.Ryuo_A_hands,          -- 50,  5,  5 <__, __, __> [__/__,  32] {__/__, ___}
    legs="Mpaca's Hose",              -- __, __,  6 <__,  4, __> [ 9/__,  96] {__/__, ___}
    feet=gear.Herc_DEX_CritDmg_feet,  -- 24,  5, __ <__,  2, __> [ 2/__,  75] {__/__, ___}
    neck="Puppetmaster's Collar +1",  -- 12, __, __ <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Odr Earring",               -- 10, __,  5 <__, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Niqmaddu Ring",            -- 10, __, __ <__, __,  3> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_TP_Cape,            -- 30, __, __ <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 223 DEX, 10 Crit Dmg, 27 Crit Rate <5 DA, 21 TA, 3 QA> [44 PDT/16 MDT, 358 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
    
    -- neck="Puppetmaster's Collar +2"-- 15, __, __ <__, __, __> [__/__, ___] {__/__, ___}
    -- back=gear.PUP_DEX_DA_Cape,     -- 30, __, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    -- 226 DEX, 10 Crit Dmg, 27 Crit Rate <15 DA, 21 TA, 3 QA> [44 PDT/16 MDT, 358 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
  })
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear2="Schere Earring",            -- __, __, __ < 6, __, __> [__/__, ___] {__/__, ___}
    
    -- ear2="Karagoz Earring +2",     -- 15, __, __ <__, __, __> [__/__, ___] {__/__,   1}
  })

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Pet Ready Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default/fallback set
  sets.midcast.Pet = {
    --main="Agwu's Axe",
    --sub="Adapa Shield",
    ammo="Voluspa Tathlum",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bst. Collar +2",
    ear1={ name="Handler's Earring +1", augments={'Path: A',}},
    ear2="Enmerkar Earring",
    ring1="Tali'ah Ring",
    ring2="C. Palug Ring",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}},
    waist="Incarnation Sash",
  }
  sets.midcast.Pet.Halfsies = {
    --main="Agwu's Axe",
    --sub="Adapa Shield",
    ammo="Voluspa Tathlum",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bst. Collar +2",
    ear1={ name="Handler's Earring +1", augments={'Path: A',}},
    ear2="Enmerkar Earring",
    ring1="Tali'ah Ring",
    ring2="C. Palug Ring",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}},
    waist="Incarnation Sash",
  }

  sets.midcast.Pet.Physical = {
    ammo="Hesperiidae",
    head=empty,
    body=Ready_Atk_body,
    hands=Ready_Atk_hands,
    legs=Ready_Atk_legs,
    feet=Ready_Atk_feet,
    neck="Shulmanu Collar",
    ear1="Ruby Earring",
    ear2="Hija Earring",
    ring1="Thurandaut Ring +1",
    ring2="Cath Palug Ring",
    back=Ready_Atk_back,
    waist="Incarnation Sash",
  }
  sets.midcast.Pet.Physical.Halfsies = {
    ammo="Hesperiidae",
    head=empty,
    body=Ready_Atk_body,
    hands=Ready_Atk_hands,
    legs=Ready_Atk_legs,
    feet=Ready_Atk_feet,
    neck="Shulmanu Collar",
    ear1="Ruby Earring",
    ear2="Hija Earring",
    ring1="Thurandaut Ring +1",
    ring2="Cath Palug Ring",
    back=Ready_Atk_back,
    waist="Incarnation Sash",
  }

  sets.midcast.Pet.Matk = {
    ammo={ name="Hesperiidae", augments={'Path: A',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Udug Jacket",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bst. Collar +2",
    ear1="Enmerkar Earring",
    ear2={ name="Nukumi Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Pet: "Dbl. Atk."+5',}},
    ring1="Tali'ah Ring",
    ring2="C. Palug Ring",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}},
    waist="Incarnation Sash",
  }
  sets.midcast.Pet.Matk.Halfsies = {
    ammo={ name="Hesperiidae", augments={'Path: A',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Udug Jacket",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bst. Collar +2",
    ear1="Enmerkar Earring",
    ear2={ name="Nukumi Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Pet: "Dbl. Atk."+5',}},
    ring1="Tali'ah Ring",
    ring2="C. Palug Ring",
    back={ name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10',}},
    waist="Incarnation Sash",
  }

  sets.midcast.Pet.Macc = {
    ammo="Voluspa Tathlum",
    head=Ready_MAcc_head,
    body=Ready_MAcc_body,
    hands=Ready_MAcc_hands,
    legs=Ready_MAcc_legs,
    feet=Ready_MAcc_feet,
    neck="Beastmaster Collar +2",
    ear1="Kyrene's Earring",
    ear2="Enmerkar Earring",
    ring1="Tali'ah Ring",
    ring2="Cath Palug Ring",
    back=Ready_MAcc_back,
    waist="Incarnation Sash",
  }
  sets.midcast.Pet.Macc.Halfsies = {
    ammo="Voluspa Tathlum",
    head=Ready_MAcc_head,
    body=Ready_MAcc_body,
    hands=Ready_MAcc_hands,
    legs=Ready_MAcc_legs,
    feet=Ready_MAcc_feet,
    neck="Beastmaster Collar +2",
    ear1="Kyrene's Earring",
    ear2="Enmerkar Earring",
    ring1="Tali'ah Ring",
    ring2="Cath Palug Ring",
    back=Ready_MAcc_back,
    waist="Incarnation Sash",
  }

  sets.midcast.Pet.Buff = {}
  sets.midcast.Pet.Buff.Halfsies = {}

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.MultiStrike = {
    body=Ready_DA_body,
    hands=Ready_DA_hands,
    legs=Ready_DA_legs,
    feet=Ready_DA_feet,
    neck="Beastmaster Collar +2",
    ear1="Domesticator's Earring",
    ear2="Kyrene's Earring",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.Favorable = {
    head="Nukumi Cabasset +3",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.TPBonus = {
    hands="Nukumi Manoplas +3",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast['Cure'] = {
    ranged="Neo Animator",            -- __, __, __ [__/__, ___] {__/__, 119}
    head="Hike Khat +1",              -- __, __, 29 [13/__,  75] { 5/ 5, ___}
    neck="Incanter's Torque",         -- __, 10, __ [__/__, ___] {__/__, ___}
    ear1="Enmerkar Earring",          -- __, __, __ [__/__, ___] { 3/ 3, ___}
    ear2="Mendicant's Earring",       --  5, __, __ [__/__, ___] {__/__, ___}
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] {__/__, ___}
    waist="Isa Belt",                 -- __, __, __ [__/__, ___] { 3/ 3, ___}
    -- 5 Cure Potency, 10 Healing Skill, 29 MND [30 PDT/9 MDT, 75 M.Eva] {Pet: 11 PDT/11 MDT, 119 Lv}

    -- body="Vrikodara Jupon",        -- 13, __, 29 [ 3/__,  80] {__/__, ___}
    -- hands="Weatherspoon Cuffs +1", --  9, __, 33 [__/__,  37] {__/__, ___}
    -- legs="Gyve Trousers",          -- 10, __, 25 [__/ 2, 107] {__/__, ___}
    -- feet="Regal Pumps +1",         -- __, 21, 29 [__/__, 107] {__/__, ___}
    -- back=gear.PUP_Cure_Cape,       -- 10, __, 30 [__/__, ___] { 5/ 5,   1}
    -- 47 Cure Potency, 31 Healing Skill, 175 MND [33 PDT/11 MDT, 406 M.Eva] {Pet: 16 PDT/16 MDT, 120 Lv}
  }
  sets.midcast['Curaga'] = set_combine(sets.midcast['Cure'], {})

  sets.midcast['Refresh'] = {
    waist="Gishdubar Sash",

    -- back="Grapevine Cape",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- This set is used when both master and pet are idle
  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___] {__/__, ___ | __, __}
    head="Pitre Taj +3",              --  5 [__/__,  63] {__/__, ___ |  5,  5}
    body="Hizamaru Haramaki +2",      -- 12 [__/__,  69] {__/__, ___ | __, __}
    hands=gear.Taeon_Pet_DT_hands,    -- __ [__/__,  57] { 4/ 4, ___ |  3, __}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
    legs="Karagoz Pantaloni +3",      -- __ [12/12, 119] {__/__, ___ | __, __}
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150] {__/__, ___ | __, __}
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] {__/__, ___ | __, __}
    ear1="Enmerkar Earring",          -- __ [__/__, ___] { 3/ 3, ___ | __, __}
    ear2="Burana Earring",            -- __ [__/__, ___] {__/__, ___ |  2, __}
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] {__/__, ___ | __, __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __, __}
    back=gear.PUP_TP_Cape,            -- __ [__/__, ___] { 5/ 5,   1 | __, __}
    waist="Moonbow Belt +1",          -- __ [ 6/ 6, ___] {__/__, ___ | __, __}
    -- 17 Regen [48 PDT/40 MDT, 458 M.Eva] {Pet: 12 PDT/12 MDT, 120 Lv | 10 Regen, 5 Refresh}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    feet=gear.Herc_Refresh_feet,
  }

  sets.resting = {}

  sets.idle = set_combine(sets.HeavyDef, {})

  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  -- idle.PetEngaged sets is when master is idle but pet is engaged
  -- It is assumed that in this situation, master is standing out of range
  -- so no emphasis is placed on master survivability stats.
  sets.idle.PetEngaged = {}
  sets.idle.PetEngaged.Tank = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head=gear.Anwig_Salade,           -- [__/__, ___] {10/10, ___ | __, __, __/__, __/__, __, __, __}
    body="Heyoka Harness +1",         -- [__/__, 117] {__/__, ___ | __, __, 52/52, __/__,  4, __, 12}
    hands=gear.Taeon_Pet_DT_hands,    -- [__/__,  57] { 4/ 4, ___ | __, __, __/__, __/__, __,  3, __}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
    legs="Heyoka Subligar +1",        -- [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9, __, 11}
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- [11 PDT/5 MDT, 429 M.Eva] {Pet: 22 PDT /22 MDT, 122 Lv | 10 DA, 14 STP, 290 Acc/255 Racc, 40 Att/20 Ratt, 22 Haste, 13 Regen, 23 Enmity}
    
    -- ear2="Karagoz Earring +2",     -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- [11 PDT/5 MDT, 429 M.Eva] {Pet: 22 PDT /22 MDT, 122 Lv | 10 DA, 14 STP, 290 Acc/255 Racc, 40 Att/20 Ratt, 22 Haste, 13 Regen, 23 Enmity}
  }
  sets.idle.PetEngaged.DD = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Pitre Taj +3",              -- [__/__,  63] {__/__, ___ | __, __, 37/37, 57/57, __,  5, __}
    body="Pitre Tobe +3",             -- [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}; AGI+26
    legs="Karagoz Pantaloni +3",      -- [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- [33 PDT/27 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 29 STP, 389 Acc/374 Racc, 142 Att/147 Ratt, 9 Haste, 16 Regen, 0 Enmity}
    
    -- ear2="Karagoz Earring +2",     -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- [33 PDT/27 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 29 STP, 389 Acc/374 Racc, 142 Att/147 Ratt, 9 Haste, 16 Regen, 0 Enmity}
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	--------------------- When master is engaged in Master hybrid mode ---------------------
  -- Almost entirely master-focused stats
  sets.engaged = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Mpaca's Doublet",           --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Malignance Tights",         -- 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Schere Earring",            --  5, 15 < 6, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        --  4, 12 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Niqmaddu Ring",            -- __, __ <__, __,  3> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_TP_Cape,            -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __/__, __/__, __, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 48 STP, 354 Acc <14 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 483 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 274 Acc/254 Racc, 20 Att/0 Ratt, 0 Haste, 0 Regen, 0 Enmity}

    -- ear2="Karagoz Earring +2",     --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- 52 STP, 362 Acc <14 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 483 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 274 Acc/254 Racc, 20 Att/0 Ratt, 0 Haste, 0 Regen, 0 Enmity}
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    neck="Puppetmaster's Collar +1",  -- __, 25 <__, __, __> [__/__, ___] {__/__, ___}
    ring1="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___}
    
    -- head="Karagoz Cappello +3",       -- __, 61 < 5, __, __> [__/__,  98] {__/__, ___}; h2h skill+19
    -- neck="Puppetmaster's Collar +2",  -- __, 30 <__, __, __> [__/__, ___] {__/__, ___}
  })


	--------------------- When master is engaged in Pet hybrid mode ---------------------
  -- These will be similar to the idle.PetEngaged modes, but put a little more
  -- emphasis on master survivability.
  sets.engaged.PetTank = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Hike Khat +1",              -- __, __ <__, __, __> [13/__,  75] { 5/ 5, ___ | __, __, __/__, __/__, __, __, __}
    body=gear.Taeon_Pet_DT_body,      -- __, __ <__, __, __> [__/__,  84] { 4/ 4, ___ |  5, __, __/__, __/__, __, __, __}; Augs: +20 M.Eva, -4 Pet DT, Pet DA+5
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Heyoka Subligar +1",        -- __, 51 <__, __, __> [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9, __, 11}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Loricate Torque +1",        -- __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        --  4, 12 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- 15 STP, 210 Acc <0 DA, 3 TA, 0 QA> [50 PDT/31 MDT, 490 M.Eva] {Pet: 17 PDT /17 MDT, 122 Lv | 10 DA, 8 STP, 270 Acc/255 Racc, 20 Att/20 Ratt, 18 Haste, 10 Regen, 11 Enmity}
    
    -- ear2="Karagoz Earring +2",     --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- 19 STP, 218 Acc <0 DA, 3 TA, 0 QA> [50 PDT/31 MDT, 496 M.Eva] {Pet: 17 PDT /17 MDT, 122 Lv | 10 DA, 8 STP, 270 Acc/255 Racc, 20 Att/20 Ratt, 18 Haste, 10 Regen, 11 Enmity}
  }
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.PetTank, {})
  sets.engaged.PetDD = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Pitre Taj +3",              -- __, 37 <__, __, __> [__/__,  63] {__/__, ___ | __, __, 37/37, 57/57, __,  5, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        --  4, 12 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 15 STP, 299 Acc <0 DA, 11 TA, 0 QA> [49 PDT/43 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 23 STP, 359 Acc/344 Racc, 142 Att/147 Ratt, 0 Haste, 16 Regen, 0 Enmity}
    
    -- ear2="Karagoz Earring +2",     --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- 19 STP, 307 Acc <0 DA, 11 TA, 0 QA> [49 PDT/43 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 23 STP, 359 Acc/344 Racc, 142 Att/147 Ratt, 0 Haste, 16 Regen, 0 Enmity}
  }
  sets.engaged.PetDD.Acc = set_combine(sets.engaged.PetDD, {})


	--------------------- When master is engaged in Halfsies hybrid mode ---------------------
  -- About equal focus on stats for master and pet
  sets.engaged.HalfsiesTank = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Mpaca's Doublet",           --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Malignance Tights",         -- 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Sroda Earring",             -- __, __ < 7, __, __> [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}; Melee DMG+10
    ear2="Karagoz Earring +1",        --  4, 12 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Niqmaddu Ring",            -- __, __ <__, __,  3> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 33 STP, 319 Acc <15 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 493 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 304 Acc/284 Racc, 40 Att/20 Ratt, 0 Haste, 10 Regen, 0 Enmity}
    
    -- ear2="Karagoz Earring +2",     --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- 37 STP, 327 Acc <15 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 493 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 304 Acc/284 Racc, 40 Att/20 Ratt, 0 Haste, 10 Regen, 0 Enmity}
  }
  sets.engaged.HalfsiesTank.Acc = set_combine(sets.engaged.HalfsiesTank, {})
  sets.engaged.HalfsiesDD = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +1",        --  4, 12 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_TP_Cape,            -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __/__, __/__, __, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 31 STP, 347 Acc <5 DA, 14 TA, 0 QA> [51 PDT/38 MDT, 439 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 0 DA, 23 STP, 330 Acc/315 Racc, 65 Att/70 Ratt, 0 Haste, 1 Regen, 0 Enmity}

    -- ear2="Karagoz Earring +2",     --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    -- 35 STP, 355 Acc <5 DA, 14 TA, 0 QA> [51 PDT/38 MDT, 439 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 0 DA, 23 STP, 330 Acc/315 Racc, 65 Att/70 Ratt, 0 Haste, 1 Regen, 0 Enmity}
  }
  sets.engaged.HalfsiesDD.Acc = set_combine(sets.engaged.HalfsiesDD, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  sets.Kiting = {
    feet="Skadi's Jambeaux +1"
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Normal'] = {main="Pangu", sub="Izizoeksi"}
  sets.WeaponSet['Normal'].DW = {main="Pangu", sub="Izizoeksi"}
  sets.WeaponSet['Cleaving'] = {main="Tauret", sub="Malevolence"}
  sets.WeaponSet['Cleaving'].DW = {main="Tauret", sub="Malevolence"}
  -- Pet_Idle_AxeMain = "Pangu"
  -- Pet_Idle_AxeSub = "Izizoeksi"
  -- Pet_PDT_AxeMain = "Pangu"
  -- Pet_PDT_AxeSub = {name="Kumbhakarna", augments={'Pet: DEF+20','Pet: Damage taken -4%','Pet: STR+14 Pet: DEX+14 Pet: VIT+14',}}
  -- Pet_MDT_AxeMain = "Pangu"
  -- Pet_MDT_AxeSub = "Izizoeksi"
  -- Pet_TP_AxeMain = "Skullrender"
  -- Pet_TP_AxeSub = "Skullrender"
  -- Pet_Regen_AxeMain = "Buramgh +1"
  -- Pet_Regen_AxeSub = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}

  -- Ready_Atk_Axe = "Aymur"
  -- Ready_Atk_Axe2 = "Agwu's Axe"
  -- Ready_Atk_TPBonus_Axe = "Aymur"
  -- Ready_Atk_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: Attack+25 Pet: Rng.Atk.+25','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: TP Bonus+200',}}

  -- Ready_Acc_Axe = "Arktoi"
  -- Ready_Acc_Axe2 = "Agwu's Axe"

  -- Ready_MAB_Axe = {name="Digirbalag", augments={'Pet: Mag. Acc.+21','Pet: "Mag.Atk.Bns."+30','INT+2 MND+2 CHR+2',}}
  -- Ready_MAB_Axe2 = "Deacon Tabar"
  -- Ready_MAB_TPBonus_Axe = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+25','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200',}}
  -- Ready_MAB_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+22','Pet: Phys. dmg. taken -5%','Pet: TP Bonus+200',}}

  -- Ready_MAcc_Axe = {name="Kumbhakarna", augments={'Pet: Mag. Acc.+20','"Cure" potency +15%','Pet: TP Bonus+180',}}
  -- Ready_MAcc_Axe2 = "Agwu's Axe"

  -- Reward_Axe = "Farsha"
  -- Reward_Axe2 = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}
  -- Reward_back = {name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- If in Pet hybrid mode, cancel abilities if pet is using Ready move.
  if state.HybridMode.value == 'Pet' and pet_midaction() then
    eventArgs.cancel = true
    add_to_chat(122, 'Action canceled because pet was midaction.')
  end

  -- If using a Ready move, equip recast reduction gear in the precast
  if spell.type == 'Monster' and sets.precast.ReadyRecast then
    equip(sets.precast.ReadyRecast)
    eventArgs.handled = true
  end

  -- Handle equipping jugs
  if spell.english == 'Bestial Loyalty' then
    local jug_info = jugs[state.JugMode.value]
    if jug_info and silibs.has_item(jug_info.item, silibs.equippable_bags) then
      equip({ammo=jug_info.item})
      eventArgs.handled = true
    end
  elseif spell.english == 'Call Beast' then
    local jug_info = jugs[state.JugMode.value]
    -- Don't allow Call Beast to consume HQ jugs
    if jug_info then
      if jug_info.nq_item and jug_info.nq_item ~= '' then
        if silibs.has_item(jug_info.item, silibs.equippable_bags) then
          equip({ammo=jug_info.nq_item})
          eventArgs.handled = true
        end
      elseif silibs.has_item(jug_info.item, silibs.equippable_bags) then
        equip({ammo=jug_info.item})
        eventArgs.handled = true
      end
    end
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  -- Always put this last in job_post_precast
  -- Prevent swapping weapons if not in Pet mode
  if state.HybridMode.current ~= 'Pet' then
    equip({main="", sub=""})
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

	if spell.type == 'Monster' then
    equip(get_bst_pet_midcast_set(spell, spellMap))
    eventArgs.handled = true
  end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  -- Always put this last in job_post_midcast
  -- Prevent swapping weapons if not in Pet mode
  if state.HybridMode.current ~= 'Pet' then
    equip({main="", sub=""})
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

	if spell.type == 'Monster' then
		if not spell.interrupted then
		  equip(get_bst_pet_midcast_set(spell, spellMap))
      eventArgs.handled = true
	  end
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
	if spell.type == 'Monster' then
    equip(get_bst_pet_midcast_set(spell, spellMap))
    eventArgs.handled = true
  end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
  handle_equipping_gear(player.status)
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
  if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
    handle_equipping_gear(player.status, newStatus)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if buff == 'doom' then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_combat_form()
  update_idle_groups()
  auto_engage_pet()
end

function update_combat_form()
  state.CombatForm:reset()

  if state.HybridMode.value ~= 'Master' and state.PetMode.value ~= 'Normal' then
    local mode = state.HybridMode.value
    if state.PetMode.value ~= 'Normal' then
      mode = mode..state.PetMode.value
    end
    state.CombatForm:set(mode)
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if not pet_midaction() then
    -- If not in DT mode put on move speed gear
    if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
      -- Apply movement speed gear
      if classes.CustomIdleGroups:contains('Adoulin') then
        idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
      else
        idleSet = set_combine(idleSet, sets.Kiting)
      end
    end

    -- Apply pet engaged set
    if pet.isvalid and pet.status == 'Engaged' then
      if state.PetMode.value == 'Normal' then
        idleSet = set_combine(idleSet, sets.idle.PetEngaged)
      else
        idleSet = set_combine(idleSet, sets.idle.PetEngaged[state.PetMode.value])
      end
    end
  end

  if state.Kiting.value then
    idleSet = set_combine(idleSet, sets.Kiting)
  end

  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  idleSet = set_combine(idleSet, select_weapons())

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

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if not pet_midaction() then
    -- Apply pet engaged set
    if pet.isvalid and pet.status == 'Engaged' and state.HybridMode.value ~= 'Master' then
      local mode = state.HybridMode.value
      if state.PetMode.value ~= 'Normal' then
        mode = mode..state.PetMode.value
      end
      meleeSet = set_combine(meleeSet, sets.engaged[mode])
    end

    if state.CP.current == 'on' then
      meleeSet = set_combine(meleeSet, sets.CP)
    end
  end

  meleeSet = set_combine(meleeSet, select_weapons())
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
  if not pet_midaction() then
    if state.CP.current == 'on' then
      meleeSet = set_combine(meleeSet, sets.CP)
    end
  end

  defenseSet = set_combine(defenseSet, select_weapons())

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
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local m_msg = state.OffenseMode.value
  m_msg = m_msg .. '/' ..state.HybridMode.value

  local i_msg = state.IdleMode.value

  local pet_msg = state.PetMode.current

  local msg = ''
  if state.TreasureMode.value ~= 'None' then
    msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
  end
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Pet: ' ..string.char(31,001)..pet_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_pet_mode(cycle_dir)
  if cycle_dir == 'forward' then
    state.PetMode:cycle()
  elseif cycle_dir == 'back' then
    state.PetMode:cycleback()
  elseif cycle_dir == 'reset' then
    state.PetMode:reset()
  end
  
  add_to_chat(141, 'Pet Mode set to '..string.char(31,1)..state.PetMode.current)
end

function select_weapons()
  if state.HybridMode.current ~= 'Pet' then
    if silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      return sets.WeaponSet[state.WeaponSet.current].DW
    elseif sets.WeaponSet[state.WeaponSet.current] then
      return sets.WeaponSet[state.WeaponSet.current]
    end
  end

  return {}
end

function auto_engage_pet()
	if areas.Cities:contains(world.area) then
    return
  end

	local abil_recasts = windower.ffxi.get_ability_recasts()

	if state.AutomaticPetTargeting.value == true and pet.isvalid and pet.status == 'Idle' and player.status == 'Engaged'
      and player.target.type == 'MONSTER' and abil_recasts[100] < 0.1 then
    windower.chat.input('/pet "Fight" <t>')
	end
end

function pet_control(command)
  if command == 'fight' then
    windower.chat.input('/pet "Fight" <stnpc>')
  elseif command == 'heel' then
    windower.chat.input('/pet "Heel" <me>')
  end
  
  if state.AutomaticPetTargeting.value == true then
    state.AutomaticPetTargeting:set(false)
    add_to_chat(141, 'Manual pet control detected. Disabling auto targeting.')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_idle_groups()
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if isRefreshing==true and player.mpp < 100 then
        classes.CustomIdleGroups:append('Refresh')
      elseif isRefreshing==false and player.mpp < 85 then
        classes.CustomIdleGroups:append('Refresh')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
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
  elseif cmdParams[1] == 'petmode' then
    if cmdParams[2] == 'cycle' then
      cycle_pet_mode('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_pet_mode('back')
    elseif cmdParams[2] == 'current' then
      cycle_pet_mode('current')
    elseif cmdParams[2] == 'reset' then
      cycle_pet_mode('reset')
    end
  elseif cmdParams[1] == 'petcontrol' then
    if cmdParams[2] then
      pet_control(cmdParams[2])
    else
      add_to_chat(123, 'Missing 2nd parameter for this command.')
    end
  elseif cmdParams[1] == 'petactivation' then
    if pet.isvalid then
      windower.chat.input('/pet "Leave" <me>')
    else
      windower.chat.input('/ja "Bestial Loyalty" <me>')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- Get the default pet midcast gear set.
-- This is built in sets.midcast.Pet.
function get_bst_pet_midcast_set(spell, spellMap)
  local equipSet = {}
  local ready_move = ready_moves[spell.english]

  if spell.type == 'Monster' and ready_move and pet.isvalid and sets.midcast and sets.midcast.Pet then
    equipSet = sets.midcast.Pet
    
    -- Determine type of set to use
    if ready_move.set and equipSet[ready_move.set] then
      equipSet = equipSet[ready_move.set]
    end

    -- Equip offensive/defensive variants as appropriate
    -- If in Master mode...
    if state.HybridMode.current == 'Master' then
      -- Swap into Halfsies set if idle, do not swap if engaged
      if player.status ~= 'Engaged' and equipSet['Halfsies'] then
        equipSet = equipSet['Halfsies']
      end
    -- If in Halfsies mode, swap into Halfsies set always
    elseif state.HybridMode.current == 'Halfsies' and equipSet['Halfsies'] then
      equipSet = equipSet['Halfsies']
    -- If in Pet mode, swap into Pet set always
    elseif state.HybridMode.current == 'Pet' and equipSet['Pet'] then
      equipSet = equipSet['Pet']
    end

    -- Allow OffenseMode to refine whatever set was selected above.
    -- Generally this modifies accuracy of the set.
    if equipSet[state.OffenseMode.current] then
      equipSet = equipSet[state.OffenseMode.current]
    end

    -- Equip multihit set if multihit ability
    if ready_move.multihit and sets.midcast.Pet.MultiStrike then
      equipSet = set_combine(equipSet, sets.midcast.Pet.MultiStrike)
    end

    -- Check correlation mode for favorable and equip related gear.
    if state.CorrelationMode.value == 'Favorable' and sets.midcast.Pet.Favorable then
      equipSet = set_combine(equipSet, sets.midcast.Pet.Favorable)
    end

    -- Equip TP Bonus set if ability benefits from TP
    if ready_move.tp_affected and pet.tp < 1900 and sets.midcast.Pet.TPBonus then
    -- if ready_move.tp_affected and (pet.tp < 1900 or (PetJob ~= 'Warrior' and pet.tp < 2400)) then
      equipSet = set_combine(equipSet, sets.midcast.Pet.TPBonus)
    end
    
    -- Always ensure this check is last
    -- Prevent swapping weapons if not in Pet mode
    if state.HybridMode.current ~= 'Pet' then
      equipSet = set_combine(equipSet, {main="", sub=""})
    end

  end

  return equipSet
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
  set_macro_page(1, 4)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind !z gs c toggle AutomaticPetTargeting')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^pageup gs c petmode cycleback')
  send_command('bind ^pagedown gs c petmode cycle')
  send_command('bind !pagedown gs c petmode reset')
  
  send_command('bind !q gs c petcontrol fight')
  send_command('bind !w gs c petcontrol heel')
  send_command('bind !e gs c petactivation')
end

function set_sub_keybinds()
  if player.sub_job == 'WAR' then
    send_command('bind ^numlock input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  end

end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind !z')
  send_command('unbind !x')

  send_command('unbind ^`')
  send_command('unbind @c')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')
  
  send_command('unbind !`')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')
  
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

function test()
end
