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
  state.IdleMode:options('Normal', 'DT', 'RegainOnly')
  state.CP = M(false, 'Capacity Points Mode')
  state.AutomaticPetTargeting = M(true, 'Automatic Pet Targeting')
  state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
  state.AttCapped = M(true, 'Attack Capped')

  state.PetMode = M{['description']='Pet Mode', 'Tank', 'DD'}

  state.JugMode = M{['description']='Jug Mode', 'Generous Arthur', 'Vivacious Vickie', 'Rhyming Shizuna', 'Swooping Zhivago', 'Fatso Fargann'}

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
    ['TP Drainkiss'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false},

    ['Wild Carrot'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Bubble Curtain'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Scissor Guard'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Secretion'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Rage'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
    ['Harden Shell'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false},
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

  skill_ids_2h = S{4, 6, 7, 8, 10, 12} -- DO NOT MODIFY
  fencer_tp_bonus = {200, 300, 400, 450, 500, 550, 600, 630} -- DO NOT MODIFY

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if S{'THF','DNC','RDM','BRD','RNG','NIN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Farsha', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Farsha'}
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
  -- head=gear.Anwig_Salade,          -- [__/__, ___] {10/10, ___}
  -- head=gear.Taeon_Pet_DT_head,     -- [__/__,  73] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- body=gear.Taeon_Pet_DT_body,     -- [__/__,  84] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet DA+5
  -- body="Totemic Jackcoat +3",      -- [__/__,  84] {10/10, ___}
  -- body=gear.Emicho_D_body,         -- [__/__,  53] { 4/ 4, ___}
  -- hands=gear.Taeon_Pet_DT_hands,   -- [__/__,  57] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
  -- hands="Gleti's Gauntlets",       -- [ 7/__,  75] { 8/ 8, ___}
  -- hands="Ankusa Gloves +3",        -- [__/__,  57] { 6/__,  17}; Pet Level snapshots on summoning
  -- legs="Tali'ah Seraweels +2",     -- [__/__,  69] { 5/ 5, ___}
  -- legs=gear.Taeon_Pet_DT_legs,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- legs="Nukumi Quijotes +3",       -- [13/13, 130] { 8/ 8, ___}
  -- feet=gear.Taeon_Pet_DT_feet,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- feet="Gleti's Boots",            -- [ 5/__, 112] {__/__,   1}
  -- feet="Ankusa Gaiters +3",        -- [__/__,  89] { 5/__, ___}
  -- neck="Shepherd's Chain",         -- [__/__, ___] { 2/ 2, ___}
  -- ear1="Handler's Earring +1",     -- [__/__, ___] { 4/__, ___}
  -- ear1="Enmerkar Earring",         -- [__/__, ___] { 3/ 3, ___}
  -- ear1="Hypaspist Earring",        -- [-5/__, ___] { 5/__, ___}
  -- ear1="Rimeice Earring",          -- [__/__, ___] { 1/ 1, ___}
  -- ear2="Nukumi Earring +2",        -- [__/__, ___] {__/__,   1}
  -- ring1="Thurandaut Ring +1",      -- [__/__, ___] { 4/ 4, ___}; Adoulin ring
  -- back=gear.BST_ambu_cape,         -- [__/__, ___] { 5/ 5, ___}
  -- waist="Isa Belt",                -- [__/__, ___] { 3/ 3, ___}

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})


  sets.SpurWeapon = {
    main=gear.Skullrender_C,
  }
  sets.SpurWeaponDW = {
    main=gear.Skullrender_C,
    sub=gear.Skullrender_C,
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	sets.precast.JA['Bestial Loyalty'] = {
    hands="Ankusa Gloves +3", -- Adds 17 pet levels, snapshots
  }
	sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']

  -- Potency caps at +50%
  -- Aim for 120+ MND from gear
  sets.precast.JA.Reward = {
    ammo="Pet Food Theta",            -- __, 20, __, __ [__/__, ___] {__/__, __}
    head="Stout Bonnet",              -- __, __, __, 16 [__/__, ___] {__/__, __}
    body="Totemic Jackcoat +3",       -- 33, __, 26, __ [__/__,  84] {10/10, __}; Removes status effects
    hands="Gleti's Gauntlets",        -- 30, __, __, __ [ 7/__,  75] { 8/ 8, __}
    legs="Ankusa Trousers +3",        -- 27, __, __, 21 [__/__,  89] {__/__, __}
    feet="Ankusa Gaiters +3",         -- 22,  4, 41, __ [__/__,  89] { 5/__, __}; Enhances Beast Healer
    neck="Loricate Torque +1",        -- __, __, __, __ [ 6/ 6, ___] {__/__, __}
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___] {__/__, __}
    ear2="Genmei Earring",            -- __, __, __, __ [ 2/__, ___] {__/__, __}
    ring1="Metamorph Ring +1",        -- 16, __, __, __ [__/__, ___] {__/__, __}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, __}
    back=gear.BST_TP_Cape,            -- __, __, 30, __ [10/__, ___] {__/__, __}
    waist="Engraved Belt",            --  7, __, __, __ [__/__, ___] {__/__, __}
    -- 132 MND, 24 Reward Regen, 97 Reward Potency, 37 Reward Recast- [38 PDT/21 MDT, 337 M.Eva] {Pet: 23 PDT/18 MDT, 0 Lv}
  }
	sets.precast.JA['Killer Instinct'] = {
    head="Ankusa Helm +3",
  }
	sets.precast.JA.Familiar = {
    legs="Ankusa Trousers +3",
  }
	sets.precast.JA.Tame = {
    head="Totemic Helm +3",
  }

  -- Cap 99%?
	sets.precast.JA.Charm = {
    ammo="Staunch Tathlum +1",        -- __, __ [ 3/ 3, ___]
    head="Totemic Helm +3",           -- 34, 35 [__/__,  73]
    body="Ankusa Jackcoat +3",        -- 33, 16 [__/__,  84]
    hands="Ankusa Gloves +3",         -- 27, 13 [__/__,  57]
    legs="Ankusa Trousers +3",        -- 21, 11 [__/__,  89]
    feet="Ankusa Gaiters +3",         -- 40, 12 [__/__,  89]
    neck="Unmoving Collar +1",        --  9, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __ [ 3/ 5, ___]
    ear2="Enchanter's Earring +1",    --  5, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- 16, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __ [10/10, ___]
    back=gear.BST_TP_Cape,            -- __, __ [10/__, ___]
    waist="Aristo Belt",              --  8, __ [__/__, ___]
    -- Traits/merits/gifts                   20
    -- 193 CHR, 107 Charm [26 PDT/18 MDT, 392 M.Eva]
  }
	sets.precast.JA.Spur = {
    feet="Nukumi Ocreae +3",
    back="Artio's Mantle",
  }
	sets.precast.JA['Feral Howl'] = {
    ammo="Pemphredo Tathlum",
    head="Nukumi Cabasset +3",
    body="Ankusa Jackcoat +3",
    hands="Nukumi Manoplas +3",
    legs="Nukumi Quijotes +3",
    feet="Nukumi Ocreae +3",
    neck="Beastmaster Collar +2",
    ear1="Dignitary's Earring",
    ear2="Nukumi Earring +1",
    ring1="Metamorph Ring +1",
    ring2="Stikini Ring +1",
    back="Aurist's Cape +1",
    waist="Eschan Stone",
    
    -- ear2="Nukumi Earring +2",
  }

  sets.precast.ReadyRecast = {
    main="Charmer's Merlin",
    legs="Gleti's Breeches",
  }

  sets.precast.FC = {
    body=gear.Taeon_FC_body,          --  9
    hands=gear.Leyline_Gloves,        --  8
    legs=gear.Taeon_FC_legs,          --  5
    feet=gear.Taeon_FC_feet,          --  5
    neck="Orunmila's Torque",         --  5
    ear1="Loquac. Earring",           --  2
    ear2="Enchanter's Earring +1",    --  2
    ring2="Prolix Ring",              --  2
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    neck="Magoraga Beads",
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Master WS Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Coiste Bodhar",             -- 10, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 37, 13, __ < 7, __, __> [ 9/ 9, 139] {__/__, ___} 
    hands=gear.Nyame_B_hands,         -- 17, 40, 11, __ < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 32, 12, __ < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 26, 11, __ < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Sroda Ring",               -- 15, __, __,  3 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, __, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Sailfi Belt +1",           -- 15, __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___}
    -- 270 STR, 161 MND, 68 WSD, 13 PDL <39 DA, 2 TA, 0 QA> [58 PDT/48 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}

    -- ear1="Moonshade Earring",      -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    -- ear2="Nukumi Earring +2",      -- 15, __, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
  })
  sets.precast.WS.AttCapped = {
    ammo="Coiste Bodhar",             -- 10, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head="Gleti's Mask",              -- 33, 19, __,  6 <__, __, __> [ 6/__,  86] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, 26, __,  9 <10, __, __> [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, 30, __,  7 <__, __, __> [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, 20, __,  8 <__,  5, __> [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 33, 12, __,  5 <__, __, __> [ 5/__, 112] {__/__,   1}
    neck="Beastmaster Collar +2",     -- 15, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __, __,  8 <__, __, __> [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, __, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Sailfi Belt +1",           -- 15, __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___}
    -- 224 STR, MND, 18 WSD, PDL <18 DA, 27 TA, 3 QA> [55 PDT/25 MDT, 422 M.Eva] {Pet: 0 PDT/0 MDT, 2 Lv}

    -- feet="Nukumi Ocreae +3",       -- 31, 20, __, 10 < 6, __, __> [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
  })

  -- 50% STR / 50% MND
  -- TP Bonus > WSD > STR > MND
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Savage Blade'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 50% STR. 1 hit ws. Dmg varies with TP. 15' range.
  sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Mistral Axe'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Mistral Axe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Mistral Axe'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 73-85% STR. 4 hit physical. Acc varies with TP. fTP transfers.
  sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 13, __ < 7, __, __> [ 9/ 9, 139] {__/__, ___} 
    hands=gear.Nyame_B_hands,         -- 17, 11, __ < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 12, __ < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 11, __ < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ring1="Sroda Ring",               -- 15, __,  3 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; fTP+
    -- 265 STR, 68 WSD, 13 PDL <39 DA, 5 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}

    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  })
  sets.precast.WS['Ruinator'].MaxTP = set_combine(sets.precast.WS['Ruinator'], {})
  sets.precast.WS['Ruinator'].AttCapped = {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> [ 3/ 3, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, __,  9 <10, __, __> [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, __,  7 <__, __, __> [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 33, __,  5 <__, __, __> [ 5/__, 112] {__/__,   1}
    neck="Beastmaster Collar +2",     -- 15, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; fTP+
    -- 241 STR, 21 WSD, 60 PDL <18 DA, 5 TA, 0 QA> [59 PDT/20 MDT, 524 M.Eva] {Pet: 8 PDT/8 MDT, 2 Lv}

    -- feet="Nukumi Ocreae +3",       -- 31, __, 10 < 6, __, __> [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS['Ruinator'].AttCappedMaxTP = set_combine(sets.precast.WS['Ruinator'].AttCapped, {})

  -- 50% STR. 3 hit physical. Acc varies with TP. fTP transfers.
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Ruinator'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Ruinator'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Ruinator'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Ruinator'].AttCappedMaxTP, {})

  -- 50% STR. 5 hit ws. Can crit. fTP transfers.
  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Meghanada Cuirie +2",       -- 34, __, __ <__, __, __> (__,  6) [ 8/__,  64] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, __,  7 <__, __, __> ( 6, __) [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Sroda Ring",               -- 15, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    back=gear.BST_STR_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 241 STR, 11 WSD, 18 PDL <11 DA, 10 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [46 PDT/10 MDT, 454 M.Eva] {Pet: 8 PDT/8 MDT, 0 Lv}

    -- hands="Nukumi Manoplas +3",    -- 25, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 245 STR, 11 WSD, 20 PDL <8 DA, 10 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [50 PDT/21 MDT, 461 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  })
  sets.precast.WS['Rampage'].MaxTP = set_combine(sets.precast.WS['Rampage'], {
    ear1="Thrud Earring",             -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Rampage'].AttCapped = {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, __,  9 <10, __, __> ( 8, __) [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, __,  7 <__, __, __> ( 6, __) [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 33, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_STR_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 225 STR, 0 WSD, 50 PDL <13 DA, 5 TA, 0 QA> (45 Crit Rate, 0 Crit Dmg) [55 PDT/13 MDT, 454 M.Eva] {Pet: 8 PDT/8 MDT, 2 Lv}

    -- hands="Nukumi Manoplas +3",    -- 25, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- feet="Nukumi Ocreae +3",       -- 31, __, 10 < 6, __, __> (__, __) [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 243 STR, 0 WSD, 49 PDL <19 DA, 5 TA, 0 QA> (41 Crit Rate, 0 Crit Dmg) [54 PDT/24 MDT, 479 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  }
  sets.precast.WS['Rampage'].AttCappedMaxTP = set_combine(sets.precast.WS['Rampage'].AttCapped, {
    ear1="Thrud Earring",             -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}

    -- ear1="Lugra Earring +1",       -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    -- ear2="Thrud Earring",          -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
  })

  -- 50% DEX. 5 hit ws. Can crit. fTP transfers.
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Meghanada Cuirie +2",       -- 45, __, __ <__, __, __> (__,  6) [ 8/__,  64] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 47, __,  7 <__, __, __> ( 6, __) [ 7/__,  75] { 8/ 8, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ <__, __, __> ( 3, __) [__/__, ___] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 271 DEX, 0 WSD, 22 PDL <9 DA, 0 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [43 PDT/10 MDT, 304 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}

    -- hands="Nukumi Manoplas +3",    -- 48, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- 272 DEX, 0 WSD, 15 PDL <9 DA, 0 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [47 PDT/21 MDT, 311 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  })
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> (__, __) [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Crepuscular Pebble",        -- __, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Gleti's Cuirass",           -- 34, __,  9 <10, __, __> ( 8, __) [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 47, __,  7 <__, __, __> ( 6, __) [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- __, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 191 DEX, 0 WSD, 50 PDL <13 DA, 0 TA, 0 QA> (45 Crit Rate, 0 Crit Dmg) [55 PDT/13 MDT, 454 M.Eva] {Pet: 8 PDT/8 MDT, 2 Lv}

    -- hands="Nukumi Manoplas +3",    -- 48, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- feet="Nukumi Ocreae +3",       -- 35, __, 10 < 6, __, __> (__, __) [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- __, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 198 DEX, 0 WSD, 49 PDL <19 DA, 5 TA, 0 QA> (41 Crit Rate, 0 Crit Dmg) [54 PDT/24 MDT, 479 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear1="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
  })

  -- 80% DEX. 1 hit ws.
  sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 11, __ [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 13, __ [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 11, __ [ 7/ 7, 112] {__/__, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ [__/__, ___] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 26, 11, __ [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ [__/__, ___] {__/__, ___}
    ear2="Thrud Earring",             -- __,  3, __ [__/__, ___] {__/__, ___}
    ring1="Ephramad's Ring",          -- 10, __, 10 [__/__, ___] {__/__, ___}
    ring2="Ilabrat Ring",             -- 10, __, __ [__/__, ___] {__/__, ___}
    back=gear.BST_DEX_WSD_Cape,       -- 30, 10, __ [10/__, ___] {__/__, ___}
    waist="Kentarch Belt +1",         -- 10, __, __ [__/__, ___] {__/__, ___}
    -- 261 DEX, 59 WSD, 20 PDL [40 PDT/30 MDT, 524 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}
  })
  sets.precast.WS['Onslaught'].MaxTP = set_combine(sets.precast.WS['Onslaught'], {
  })
  sets.precast.WS['Onslaught'].AttCapped = {
    ammo="Crepuscular Pebble",        -- __, __,  3 [ 3/ 3, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 11, __ [ 7/ 7, 123] {__/__, ___}
    body="Gleti's Cuirass",           -- 34, __,  9 [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 47, __,  7 [ 7/__,  75] { 8/ 8, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ [__/__, ___] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 [ 5/__, 112] {__/__,   1}
    neck="Beastmaster Collar +2",     -- 15, __, 10 [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ [__/__, ___] {__/__, ___}
    ear2="Nukumi Earring +1",         -- __, __,  8 [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_WSD_Cape,       -- 30, 10, __ [10/__, ___] {__/__, ___}
    waist="Kentarch Belt +1",         -- 10, __, __ [__/__, ___] {__/__, ___}
    -- 259 DEX, 21 WSD, 52 PDL [52 PDT/20 MDT, 412 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}
    
    -- feet="Nukumi Ocreae +3",       -- 35, __, 10 [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- __, __,  9 [__/__, ___] {__/__,   1}
    -- 265 DEX, 21 WSD, 58 PDL [46 PDT/20 MDT, 430 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}
  }
  sets.precast.WS['Onslaught'].AttCappedMaxTP = set_combine(sets.precast.WS['Onslaught'].AttCapped, {
  })

  -- Aeolian Edge: 40% DEX/40% INT, 2.0-4.5 fTP, 1 hit (aoe-magical)
  -- Stack MAB > INT > DEX > WSD
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",         -- __,  4,  8, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 28, 30, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 42, 30, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 28, 30, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- __, 44, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 26, 25, 30, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __ [__/__, ___] {__/__, ___}
    ear2="Novio Earring",             -- __, __,  7, __ [__/__, ___] {__/__, ___}
    ring1="Shiva Ring +1",            -- __,  9,  3, __ [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5, __ [__/__, ___] {__/__, ___}
    -- 115 DEX, 165 INT, 224 MAB, 52 WSD [43 PDT/41 MDT, 599 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.BST_INT_MAB_Cape,    -- __, 30, 10, __ [10/__, ___] {__/__, ___}
    -- waist="Skrymir Cord +1",       -- __, __,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MaxTP, {})

  -- 60% CHR/30% DEX. dStat CHR. Dmg varies with TP. Light elemental.
  sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",         -- __, __,  4,  8, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 24, 25, 30, 40, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 35, 24, 30, 40, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 24, 42, 30, 40, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 24, __, 30, 40, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 38, 26, 30, 40, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Baetyl Pendant",            -- __, __, 13, __, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __, __ [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __, __, __ [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Weatherspoon Ring",        -- __, __, 10, __, __ [__/__, ___] {__/__, ___}; Light MAB+10
    ring2="Defending Ring",           -- __, __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5,  5, __ [__/__, ___] {__/__, ___}
    -- 145 CHR, 117 DEX, 211 MAB, 213 M.Acc, 58 WSD [48 PDT/48 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.BST_CHR_WSD_Cape,    -- 30, __, __, 20, 10 [__/__, ___] { 5/ 5, ___}
    -- waist="Skrymir Cord +1",       -- __, __,  7,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Primal Rend'].MaxTP = set_combine(sets.precast.WS['Primal Rend'], {
    ear2="Novio Earring",             -- __, __,  7, __, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Primal Rend'].AttCappedMaxTP = set_combine(sets.precast.WS['Primal Rend'].MaxTP, {})

  -- 40% STR/40% MND. Dmg varies with TP. Thunder elemental.
  sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {
    ring1="Sroda Ring",
    -- back=gear.BST_MND_WSD_Cape,    -- __, 30, 10, 20, __ [__/__, ___] { 5/ 5, ___}
  })
  sets.precast.WS['Cloudsplitter'].MaxTP = set_combine(sets.precast.WS['Primal Rend'].MaxTP, {
    ring1="Sroda Ring",
    -- back=gear.BST_MND_WSD_Cape,
  })
  sets.precast.WS['Cloudsplitter'].AttCappedMaxTP = set_combine(sets.precast.WS['Cloudsplitter'].MaxTP, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Pet Ready Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default/fallback set
  sets.midcast.Pet = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, 10/10, 10/__}; Pet attr+10
    head="Nukumi Cabasset +3",        -- [11/11,  98] {__/__, ___ | __, 61/61, __/__}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | __, 50/50, __/__}
    hands="Nukumi Manoplas +3",       -- [11/11,  82] {__/__, ___ | __, 62/62, __/__}; Pet TP Bonus+700
    legs="Nukumi Quijotes +3",        -- [13/13, 130] { 8/ 8, ___ | __, 63/63, __/__}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50/50, __/__}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  3, 20/__, 20/__}
    ear1="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __/__, __/__}; Pet dmg+
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __/__, __/__}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __, 10/__, __/__}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, 12/12, __/__}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, 20/20, 30/30}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, 20/20, __/__}
    -- [54 PDT/40 MDT, 534 M.Eva] {Pet: 13 PDT /13 MDT, 2 Lv | 15 DA, 378 Acc/348 Racc, 60 Att/30 Ratt}
  }
  sets.midcast.Pet.Halfsies = set_combine(sets.midcast.Pet, {})

  sets.midcast.Pet.Physical = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, 10/10, 10/__}; Pet attr+10
    head="Nukumi Cabasset +3",        -- [11/11,  98] {__/__, ___ | __, 61/61, __/__}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | __, 50/50, __/__}
    hands="Nukumi Manoplas +3",       -- [11/11,  82] {__/__, ___ | __, 62/62, __/__}; Pet TP Bonus+700
    legs="Nukumi Quijotes +3",        -- [13/13, 130] { 8/ 8, ___ | __, 63/63, __/__}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50/50, __/__}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  3, 20/__, 20/__}
    ear1="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __/__, __/__}; Pet dmg+
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __/__, __/__}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __, 10/__, __/__}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, 12/12, __/__}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, 20/20, 30/30}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, 20/20, __/__}
    -- [54 PDT/40 MDT, 534 M.Eva] {Pet: 13 PDT /13 MDT, 2 Lv | 15 DA, 378 Acc/348 Racc, 60 Att/30 Ratt}
  }
  sets.midcast.Pet.Physical.Halfsies = set_combine(sets.midcast.Pet.Physical, {})

  sets.midcast.Pet.Matk = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, 10, __, 10}; Pet attr+10
    head=gear.Valorous_Pet_Matk_head, -- [__/__,  48] {__/__, ___ | __, __, 30, 15}
    body=gear.Emicho_D_body,          -- [__/__,  53] { 4/ 4, ___ | __, __, 35, 20}
    hands="Nukumi Manoplas +3",       -- [11/11,  82] {__/__, ___ | __, 62, __, __}; Pet TP Bonus+700
    legs=gear.Valorous_Pet_Matk_legs, -- [ 2/__,  80] {__/__, ___ | __, __, 30, 15}
    feet=gear.Valorous_Pet_Matk_feet, -- [__/ 2,  80] {__/__, ___ | __, __, 30, 15}
    neck="Adad Amulet",               -- [ 4/ 4, ___] {__/__, ___ | __, 20, 10, __}
    ear1="Hija Earring",              -- [__/__, ___] {__/__, ___ |  2, __,  5, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, 15, __, __}
    ring1="Tali'ah Ring",             -- [__/__, ___] {__/__, ___ | __,  6, __, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, 12, __, __}
    back="Argochampsa Mantle",        -- [__/__, ___] {__/__, ___ | __, __, 12, __}
    waist="Incarnation Sash",         -- [__/__, ___] {__/__, ___ |  4, 15, __, __}
    -- [22 PDT/22 MDT, 343 M.Eva] {Pet: 4 PDT /4 MDT, 1 Lv | 18 DA, 140 Macc, 152 MAB, 75 INT}
    
    -- body="Udug Jacket",            -- [10/10,  86] {__/__, ___ | __, 45, 45, __}
    -- [32 PDT/32 MDT, 376 M.Eva] {Pet: 0 PDT /0 MDT, 1 Lv | 18 DA, 185 Macc, 162 MAB, 55 INT}
  }
  sets.midcast.Pet.Matk.Halfsies = {
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50, __, __}
    ring1="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __, __}
  }

  sets.midcast.Pet.Macc = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | 10, 10}; Pet attr+10
    head="Nukumi Cabasset +3",        -- [11/11,  98] {__/__, ___ | 61, __}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | 50, __}
    hands="Nukumi Manoplas +3",       -- [11/11,  82] {__/__, ___ | 62, __}; Pet TP Bonus+700
    legs="Nukumi Quijotes +3",        -- [13/13, 130] { 8/ 8, ___ | 63, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | 50, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | 15, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 | 15, __}
    ring1="Tali'ah Ring",             -- [__/__, ___] {__/__, ___ |  6, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ | 12, __}
    back=gear.BST_Pet_Macc_Cape,      -- [__/__,  20] { 5/ 5, ___ | 30, __}
    waist="Incarnation Sash",         -- [__/__, ___] {__/__, ___ | 15, __}
    -- [64 PDT/40 MDT, 544 M.Eva] {Pet: 11 PDT /11 MDT, 2 Lv | 414 Macc, 10 INT}
  }
  sets.midcast.Pet.Macc.Halfsies = set_combine(sets.midcast.Pet.Macc, {})

  sets.midcast.Pet.Buff = {}
  sets.midcast.Pet.Buff.Halfsies = {}

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.MultiStrike = {
    legs=gear.Emicho_C_legs,
    neck="Beastmaster Collar +2",
    ear2="Nukumi Earring +1",
    ring2="Cath Palug Ring",
    waist="Incarnation Sash"
    
    -- ear2="Nukumi Earring +2",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.Favorable = {
    head="Nukumi Cabasset +3",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.TPBonus = {
    main=Ready_Atk_TPBonus_Axe_1,
    sub=Ready_Atk_TPBonus_Axe_2,
    hands="Nukumi Manoplas +3",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- This set is used when both master and pet are idle
  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___] {__/__, ___ | __}
    head=gear.Nyame_B_head,           -- __ [ 7/ 7, 123] {__/__, ___ | __}
    body="Gleti's Cuirass",           -- __ [ 9/__, 102] {__/__, ___ | __}
    hands="Gleti's Gauntlets",        -- __ [ 7/__,  75] { 8/ 8, ___ | __}
    legs=gear.Nyame_B_legs,           -- __ [ 8/ 8, 150] {__/__, ___ | __}
    feet="Gleti's Boots",             -- __ [ 5/__, 112] {__/__,   1 | __}
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] {__/__, ___ | __}
    ear1="Enmerkar Earring",          -- __ [__/__, ___] { 3/ 3, ___ | __}
    ear2="Nukumi Earring +1",         -- __ [__/__, ___] {__/__,   1 | __}
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __}
    back=gear.BST_Pet_Macc_Cape,      -- __ [__/__,  20] { 5/ 5, ___ | 10}
    waist="Isa Belt",                 -- __ [__/__, ___] { 3/ 3, ___ |  1}
    -- Traits/Gifts/Merits                                 9/ 9
    -- 0 Regen [62 PDT/33 MDT, 582 M.Eva] {Pet: 28 PDT/28 MDT, 2 Lv | 11 Regen}

    -- legs="Nukumi Quijotes +3",     -- __ [13/13, 130] { 8/ 8, ___ | __}
    -- 0 Regen [67 PDT/38 MDT, 562 M.Eva] {Pet: 36 PDT/36 MDT, 2 Lv | 11 Regen}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})

  -- Reach 50 PDT/21 MDT in as few pieces as possible
  sets.EfficientDT = {
    -- head="Nukumi Cabasset +3",     -- __ [11/11,  98] {__/__, ___ | __}
    -- hands="Nukumi Manoplas +3",    -- __ [11/11, 109] {__/__, ___ | __}
    -- legs="Nukumi Quijotes +3",     -- __ [13/13, 130] { 8/ 8, ___ | __}
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __}
    -- 0 Regen [52 PDT/44 MDT, 337 M.Eva] {Pet: 8 PDT/8 MDT, 0 Lv | 0 Regen}
  }

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Valorous Mask",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
  }
  sets.latent_regen = {
    head="Gleti's Mask",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
  }
  sets.latent_refresh = {
    ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
  }

  sets.resting = {}

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.DT = set_combine(sets.HeavyDef, {})
  sets.idle.DT.Regain = set_combine(sets.HeavyDef, sets.idle.Regain, sets.EfficientDT)
  sets.idle.DT.Regen = set_combine(sets.HeavyDef, sets.idle.Regen, sets.EfficientDT)
  sets.idle.DT.Refresh = set_combine(sets.HeavyDef, sets.idle.Refresh, sets.EfficientDT)
  sets.idle.DT.Regain.Regen = set_combine(sets.HeavyDef, sets.idle.Regain.Regen, sets.EfficientDT)
  sets.idle.DT.Regain.Refresh = set_combine(sets.HeavyDef, sets.idle.Regain.Refresh, sets.EfficientDT)
  sets.idle.DT.Regen.Refresh = set_combine(sets.HeavyDef, sets.idle.Regen.Refresh, sets.EfficientDT)
  sets.idle.DT.Regain.Regen.Refresh = set_combine(sets.HeavyDef, sets.idle.Regain.Regen.Refresh, sets.EfficientDT)

  sets.idle.RegainOnly = {
    ammo="Staunch Tathlum +1",        -- __, __ [ 3/ 3, ___] {__/__, ___ | __}
    head=gear.Valorous_DT_head,       --  3, __ [ 4/ 4,  48] {__/__, ___ | __}
    body="Gleti's Cuirass",           --  3, __ [ 9/__, 102] {__/__, ___ | __}
    hands="Gleti's Gauntlets",        --  2, __ [ 7/__,  75] { 8/ 8, ___ | __}
    legs="Gleti's Breeches",          --  3, __ [ 8/__, 112] {__/__, ___ | __}
    feet="Gleti's Boots",             --  2, __ [ 5/__, 112] {__/__,   1 | __}
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] {__/__, ___ | __}
    ear1="Enmerkar Earring",          -- __, __ [__/__, ___] { 3/ 3, ___ | __}
    ear2="Nukumi Earring +1",         -- __, __ [__/__, ___] {__/__,   1 | __}
    ring1="Chirich Ring +1",          -- __,  2 [__/__, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___ | __}
    back=gear.BST_Pet_Macc_Cape,      -- __, __ [__/__,  20] { 5/ 5, ___ | 10}
    waist="Isa Belt",                 -- __, __ [__/__, ___] { 3/ 3, ___ |  1}
    -- Traits/Gifts/Merits                                     9/ 9
    -- 13 Regain, 2 Regen [48 PDT/19 MDT, 469 M.Eva] {Pet: 28 PDT/28 MDT, 2 Lv | 11 Regen}
  }

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  -- idle.PetEngaged sets is when master is idle but pet is engaged
  -- It is assumed that in this situation, master is standing out of range
  -- so no emphasis is placed on master survivability stats.
  sets.idle.PetEngaged = {} -- DO NOT MODIFY
  sets.idle.PetEngaged.Tank = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Tali'ah Turban +2",         -- [__/__,  53] {__/__, ___ | __,  7, 42/42, __/__, __, __}
    body="Ankusa Jackcoat +3",        -- [__/__,  84] {__/__, ___ |  5, __, __/__, __/__,  7, __}
    hands="Gleti's Gauntlets",        -- [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +3",        -- [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- [30 PDT/18 MDT, 474 M.Eva] {Pet: 24 PDT/24 MDT, 2 Lv | 42 DA, 21 STP, 317 Acc/302 Racc, 45 Att/30 Ratt, 26 Haste, 0 Regen}

    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [30 PDT/18 MDT, 474 M.Eva] {Pet: 24 PDT/24 MDT, 2 Lv | 45 DA, 21 STP, 317 Acc/302 Racc, 45 Att/30 Ratt, 26 Haste, 0 Regen}
  }
  sets.idle.PetEngaged.DD = {
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Tali'ah Turban +2",         -- [__/__,  53] {__/__, ___ | __,  7, 42/42, __/__, __, __}
    body="Ankusa Jackcoat +3",        -- [__/__,  84] {__/__, ___ |  5, __, __/__, __/__,  7, __}
    hands=gear.Emicho_C_hands,        -- [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Ankusa Trousers +3",        -- [__/__,  89] {__/__, ___ | __,  7, __/__, __/__,  6, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Incarnation Sash",         -- [__/__, ___] {__/__, ___ |  4, __, 15/15, __/__, __, __}
    -- [10 PDT/5 MDT, 390 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv | 50 DA, 35 STP, 219 Acc/184 Racc, 100 Att/30 Ratt, 23 Haste, 0 Regen}

    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [10 PDT/5 MDT, 390 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv | 53 DA, 35 STP, 219 Acc/204 Racc, 100 Att/30 Ratt, 23 Haste, 0 Regen}
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	--------------------- When master is engaged in Master hybrid mode ---------------------
  -- Almost entirely master-focused stats
  sets.engaged = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Ainia Collar",              -- __,  8,-10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Gere Ring",                -- __, __, __ <__,  5, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Moonlight Ring",           -- __,  5,  8 <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    -- 0 DW, 74 STP, 268 Acc <23 DA, 7 TA, 0 QA> [48 PDT/22 MDT, 600 M.Eva] {Pet: 8 PDT/8 MDT, 0 Lv | 0 DA, 0 STP, 100 Acc/100 Racc, 0 Att/0 Ratt, 0 Haste, 0 Regen}
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Moonlight Ring",           -- __,  5,  8 <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
  })


	--------------------- When master is engaged in Pet hybrid mode ---------------------
  -- These will be similar to the idle.PetEngaged modes, but put a little more
  -- emphasis on master survivability.
  sets.engaged.PetTank = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Nukumi Cabasset +3",        -- __, __, 61 <__, __, __> [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    body="Totemic Jackcoat +3",       -- __, __, 50 <__, __, __> [__/__,  84] {10/10, ___ | __, __, __/__, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +3",        -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    ring2="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Isa Belt",                 -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __, __, __/__, __/__, __,  1}
    -- 0 DW, 8 STP, 339 Acc <0 DA, 0 TA, 0 QA> [41 PDT/29 MDT, 519 M.Eva] {Pet: 37 PDT/37 MDT, 2 Lv | 37 DA, 14 STP, 316 Acc/301 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}

    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 8 STP, 344 Acc <0 DA, 0 TA, 0 QA> [41 PDT/29 MDT, 519 M.Eva] {Pet: 37 PDT/37 MDT, 2 Lv | 40 DA, 14 STP, 316 Acc/301 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}
  }
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.PetTank, {})

  sets.engaged.PetDD = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Nukumi Cabasset +3",        -- __, __, 61 <__, __, __> [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    body="Ankusa Jackcoat +3",        -- __, __, 40 <__, __, __> [__/__,  84] {__/__, ___ |  5, __, __/__, __/__,  7, __}
    hands=gear.Emicho_C_hands,        -- __,  7, 37 <__, __, __> [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Nukumi Quijotes +3",        -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    ring2="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 7 STP, 331 Acc <0 DA, 0 TA, 0 QA> [34 PDT/29 MDT, 476 M.Eva] {Pet: 16 PDT /16 MDT, 2 Lv | 46 DA, 21 STP, 306 Acc/271 Racc, 100 Att/30 Ratt, 26 Haste, 0 Regen}

    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 7 STP, 336 Acc <0 DA, 0 TA, 0 QA> [34 PDT/29 MDT, 476 M.Eva] {Pet: 16 PDT /16 MDT, 2 Lv | 49 DA, 21 STP, 306 Acc/271 Racc, 100 Att/30 Ratt, 26 Haste, 0 Regen}
  }
  sets.engaged.PetDD.Acc = set_combine(sets.engaged.PetDD, {})


  -- TODO
	--------------------- When master is engaged in Halfsies hybrid mode ---------------------
  -- About equal focus on stats for master and pet
  sets.engaged.HalfsiesTank = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +3",        -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Gere Ring",                -- __, __, __ <__,  5, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 43 STP, 338 Acc <21 DA, 8 TA, 0 QA> [49 PDT/23 MDT, 580 M.Eva] {Pet: 19 PDT/19 MDT, 0 Lv | 25 DA, 8 STP, 223 Acc/208 Racc, 0 Att/0 Ratt, 9 Haste, 0 Regen}
  }
  sets.engaged.HalfsiesTank.Acc = set_combine(sets.engaged.HalfsiesTank, {})

  sets.engaged.HalfsiesDD = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands=gear.Emicho_C_hands,        -- __,  7, 37 <__, __, __> [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Nukumi Quijotes +3",        -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    ring2="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 42 STP, 330 Acc <18 DA, 0 TA, 0 QA> [47 PDT/28 MDT, 537 M.Eva] {Pet: 11 PDT/11 MDT, 0 Lv | 34 DA, 21 STP, 215 Acc/200 Racc, 55 Att/0 Ratt, 9 Haste, 0 Regen}
  }
  sets.engaged.HalfsiesDD.Acc = set_combine(sets.engaged.HalfsiesDD, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

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
  sets.WeaponSet['Naegling'] = {main="Naegling", sub="Sacro Bulwark"}
  sets.WeaponSet['Farsha'] = {main="Farsha", sub="Sacro Bulwark"}
  sets.WeaponSet['Cleaving'] = {main="Tauret", sub="Sacro Bulwark"}
  sets.WeaponSet['Cleaving'].DW = {main="Tauret", sub=gear.Malevolence_1}
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
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  -- Handle equipping jugs
  if spell.english == 'Bestial Loyalty' then
    local jug_info = jugs[state.JugMode.value]
    if jug_info and silibs.has_item(jug_info.item, silibs.equippable_bags) then
      equip({ammo=jug_info.item})
    end
  elseif spell.english == 'Call Beast' then
    local jug_info = jugs[state.JugMode.value]
    -- Don't allow Call Beast to consume HQ jugs
    if jug_info then
      if jug_info.nq_item and jug_info.nq_item ~= '' then
        if silibs.has_item(jug_info.item, silibs.equippable_bags) then
          equip({ammo=jug_info.nq_item})
        end
      elseif silibs.has_item(jug_info.item, silibs.equippable_bags) then
        equip({ammo=jug_info.item})
      end
    end
  elseif spell.english == 'Spur' then
    if silibs.is_dual_wielding() and state.HybridMode.current == 'Pet' or player.status ~= 'Engaged' then
      equip(sets.SpurWeaponDW)
    else
      equip(sets.SpurWeaponDW)
    end
  end

  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  -- Always put this last in job_post_precast
  -- Prevent swapping weapons if not in Pet mode and engaged
  if state.HybridMode.current ~= 'Pet' and player.status == 'Engaged' then
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
  -- Prevent swapping weapons if not in Pet mode and engaged
  if state.HybridMode.current ~= 'Pet' and player.status == 'Engaged' then
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
  -- If weapons are not what's set in the WeaponSet cycle, equip them
  equip(select_weapons())

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
  elseif buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.SleepyHead)
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
  local trait_bonus = T{
    calc_fencer_tp_bonus()
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-trait_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

function calc_fencer_tp_bonus()
  local total_fencer_tp_bonus = 0
  local fencer_tier = calc_fencer_tier()
  if fencer_tier > 0 then
    -- Add Fencer TP bonus based on base trait
    total_fencer_tp_bonus = fencer_tp_bonus[fencer_tier]
    -- Add TP Bonus based on JP gifts
    local jp_spent = player.job_points.bst.jp_spent
    if jp_spent >= 2000 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 230
    elseif jp_spent >= 1125 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 160
    elseif jp_spent >= 500 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 100
    elseif jp_spent >= 150 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 50
    end
  end
  return total_fencer_tp_bonus
end

-- Calculate Fencer tier. Fencer active if not two-handed weapon, and offhand is empty or shield.
function calc_fencer_tier()
  local fencer = 0
  local main_weapon_skill = res.items:with('en', player.equipment.main).skill
  local is_using_2h = skill_ids_2h:contains(main_weapon_skill)

  if not is_using_2h then
    if player.equipment.sub == 'empty' then
      fencer = 3
    else
      local is_using_shield = res.items:with('en', player.equipment.sub).category == 'Armor'
      if is_using_shield then
        fencer = 3
      end
    end
  end
  -- Fencer caps at level 8
  return math.min(fencer, 8)
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

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.Special.SleepyHead)
  end

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

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.Special.SleepyHead)
  end

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
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if player.tp < 3000 then
      classes.CustomIdleGroups:append('Regain')
    end
    if isRegening==true and player.hpp < 100 then
      classes.CustomIdleGroups:append('Regen')
    elseif isRegening==false and player.hpp < 85 then
      classes.CustomIdleGroups:append('Regen')
    end
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
    -- Don't use with Unleash, which makes all Ready TP Bonus+3000
    if ready_move.tp_affected and pet.tp < 1900 and sets.midcast.Pet.TPBonus and not buffactive['Unleash'] then
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
  send_command('bind ^f8 gs c toggle AttCapped')

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
  send_command('unbind ^f8')

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
