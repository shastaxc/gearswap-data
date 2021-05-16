-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs c equipweapons')
    send_command('gs c equiprangedweapons')
    send_command('gs org')
  end, 2)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  include('Mote-TreasureHunter')

  silibs.use_weapon_rearm = true

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef')
  state.RangedMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.IdleMode:options('Normal', 'LightDef')

  state.WeaponSet = M{['description']='Weapon Set', 'Ataktos', 'Cleaving', 'Fomalhaut_M', 'Fomalhaut_R',}

  state.CP = M(false, "Capacity Points Mode")
  state.RearmingLock = M(false, 'Rearming Lock')

  -- QuickDraw Selector
  state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot', 'Dark Shot',}
  state.UseAltqd = M(false, 'Use Secondary Shot')
  state.SelectqdTarget = M(false, 'Select Quick Draw Target')
  state.IgnoreTargetting = M(false, 'Ignore Targetting')
  state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}
  state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

  -- Whether to use Luzaf's Ring
  state.LuzafRing = M(false, "Luzaf's Ring")
  -- Whether a warning has been given for low ammo
  state.warned = M(false)
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire"}
  no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet", "Bronze Bullet"}
  no_swap_waists = S{"Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
      "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  gear.RAbullet = "Chrono Bullet"
  gear.RAccbullet = "Devastating Bullet"
  gear.WSbullet = "Chrono Bullet"
  gear.MAbullet = "Living Bullet"
  gear.QDbullet = "Hauksbok Bullet"
  options.ammo_warning_limit = 10

  marksman_weapon_subtypes = {
    ['Death Penalty'] = "gun",
    ['Armageddon'] = "gun",
    ['Fomalhaut'] = "gun",
  }

  sets.org.job = {}
  sets.org.job[1] = {ammo=gear.RAbullet}
  sets.org.job[2] = {ammo=gear.RAccbullet}
  sets.org.job[3] = {ammo=gear.WSbullet}
  sets.org.job[4] = {ammo=gear.MAbullet}
  sets.org.job[5] = {ammo=gear.QDbullet}
  sets.org.job[6] = {ammo="Chrono bullet pouch"}
  sets.org.job[7] = {ammo="Devastating Bullet Pouch"}
  sets.org.job[8] = {ammo="Living Bullet Pouch"}

  define_roll_values()

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
  send_command('bind ^insert gs c cycle WeaponSet')
  send_command('bind ^delete gs c cycleback WeaponSet')

  send_command('bind ^\\\\ gs c cycle QDMode')
  send_command('bind ^[ gs c cycleback mainqd')
  send_command('bind ^] gs c cycle mainqd')
  send_command('bind ^; gs c cycleback altqd')
  send_command('bind ^\' gs c cycle altqd')
  send_command('bind ^p c toggle selectqdtarget')
  send_command('bind ^l gs c toggle usealtqd')
  send_command('bind @` gs c toggle LuzafRing')

  send_command('bind !q input /ja "Double-up" <me>')
  send_command('bind !` input /ja "Bolter\'s Roll" <me>')
  send_command('bind ^numlock input /ja "Triple Shot" <me>')
  send_command('bind numpad0 input /ra <t>')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.set_lockstyle(8)
  Haste = 0
  DW_needed = 0
  DW = false
  current_dp_type = nil -- Do not modify
  locked_waist = false -- Do not modify

  -- Additional local binds
  include('Global-Binds.lua')

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
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

  send_command('unbind ^\\\\')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ^;')
  send_command('unbind ^\'')
  send_command('unbind ^p')
  send_command('unbind ^l')
  send_command('unbind @`')

  send_command('unbind !q')
  send_command('unbind !`')
  send_command('unbind ^numlock')
  send_command('unbind numpad0')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  sets.precast.JA['Snake Eye'] = {
    legs="Lanun Trews",
    -- legs="Lanun Trews +3",
  }
  sets.precast.JA['Wild Card'] = {
    feet="Lanun Bottes",
    -- feet="Lanun Bottes +3",
}
  sets.precast.JA['Random Deal'] = {
    body="Lanun Frac +1",
    -- body="Lanun Frac +3",
}

  sets.precast.CorsairRoll = {
    head="Lanun Tricorne",
    body="Malignance Tabard", --9/9
    feet="Malignance Boots", --4/0
    neck="Regal Necklace",
    ear1="Genmei Earring", --2/0
    ring1="Gelatinous Ring +1", --7/(-1)
    ring2="Defending Ring", --10/10
    back=gear.COR_SNP_Cape,
    -- head="Lanun Tricorne +3",
    -- hands="Chasseur's Gants +1",
    -- legs="Desultor Tassets",
    -- ear2="Etiolation Earring", --0/3
    -- waist="Flume Belt +1", --4/0
  }

  sets.precast.CorsairRoll.Duration = {
    -- main="Rostam",
    -- range="Compensator",
  }
  sets.precast.CorsairRoll.LowerDelay = {
    -- back="Gunslinger's Cape",
  }
  sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- legs="Chasseur's Culottes +1",
  })
  sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
    feet="Chasseur's Bottes",
    -- feet="Chasseur's Bottes +1",
  })
  sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
    head="Chasseur's Tricorne +1",
  })
  sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
    body="Chasseur's Frac",
    -- body="Chasseur's Frac +1",
  })
  sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {
    -- hands="Chasseur's Gants +1",
  })

  sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {
    -- ring1="Luzaf's Ring",
  })
  sets.precast.FoldDoubleBust = {
    hands="Lanun Gants",
    -- hands="Lanun Gants +3",
  }

  sets.precast.Waltz = {
    body="Passion Jacket",
    waist="Gishdubar Sash",
    -- ring1="Asklepian Ring",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Weatherspoon Ring", --5
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    neck="Magoraga Beads", --10
    ring1="Defending Ring",
  })

  -- (10% Snapshot from JP Gifts)
  sets.precast.RA = {
    ammo=gear.RAbullet,
    head="Chasseur's Tricorne +1",-- __/14
    hands="Carmine Fin. Ga. +1",  --  8/11
    legs=gear.Adhemar_D_legs,     -- 10/13
    feet="Meg. Jam. +2",          -- 10/__
    back=gear.COR_SNP_Cape,       -- 10/__
    waist="Yemaya Belt",          -- __/ 5
    -- body="Oshosi Vest +1",        -- 14/__
    -- hands="Lanun Gants +3",       -- 13/__
    -- neck="Comm. Charm +2",        --  4/__
    -- 61 Snapshot / 32 Rapid Shot
  } -- 48 Snapshot / 29 Rapid Shot

  -- 45 Snapshot to cap
  sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
    -- body="Laksamana's Frac +3", --0/20
    -- 47 Snapshot / 52 Rapid Shot
  })

  -- 30 Snapshot to cap
  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
    hands="Carmine Fin. Ga. +1",  --  8/11
    -- feet="Pursuer's Gaiters",     -- __/10
    -- 32 Snapshot / 73 Rapid Shot
  })


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo=gear.WSbullet,
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meghanada Chausses +2",
    feet="Meg. Jam. +2",
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Dingir Ring",
    waist="Fotia Belt",
    -- head="Lanun Tricorne +3",
    -- body="Laksamana's Frac +3",
    -- legs=gear.Herc_RA_legs,
    -- feet="Lanun Bottes +3",
    -- ring2="Epaminondas's Ring",
    -- back=gear.COR_WS3_Cape,
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Telos Earring",
  })
  sets.precast.WS.LowAcc = set_combine(sets.precast.WS, {
  })
  sets.precast.WS.LowAccMaxTP = set_combine(sets.precast.WS.LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS.MidAcc = set_combine(sets.precast.WS.LowAcc, {
  })
  sets.precast.WS.MidAccMaxTP = set_combine(sets.precast.WS.MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
  })
  sets.precast.WS.HighAccMaxTP = set_combine(sets.precast.WS.HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Last Stand'] = sets.precast.WS
  sets.precast.WS['Last Stand'].MaxTP = set_combine(sets.precast.WS['Last Stand'], {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].LowAcc = set_combine(sets.precast.WS['Last Stand'], {
  })
  sets.precast.WS['Last Stand'].LowAccMaxTP = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].MidAcc = set_combine(sets.precast.WS['Last Stand'].LowAcc, {
  })
  sets.precast.WS['Last Stand'].MidAccMaxTP = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'].MidAcc, {
    ammo=gear.RAccbullet,
    neck="Iskur Gorget",
    ear1="Beyla Earring",
    ear2="Telos Earring",
    ring2="Hajduk Ring +1",
    waist="K. Kachina Belt +1",
  })
  sets.precast.WS['Last Stand'].HighAccMaxTP = set_combine(sets.precast.WS['Last Stand'].HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Wildfire'] = {
    ammo=gear.MAbullet,
    head="Nyame Helm", --30
    body="Nyame Mail", --30
    hands="Carmine Fin. Ga. +1",
    legs="Nyame Flanchard", --30
    feet=gear.Herc_MAB_feet, --50
    ear1="Friomisi Earring",
    ring1="Dingir Ring",
    waist="Eschan Stone",
    -- body="Lanun Frac +3",
    -- feet="Lanun Bottes +3",
    -- neck="Comm. Charm +2",
    -- ear2="Novio Earring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.COR_WS1_Cape,
    -- waist="Skrymir Cord +1",
  }
  sets.precast.WS['Wildfire'].MaxTP = set_combine(sets.precast.WS['Wildfire'], {
  })
  sets.precast.WS['Wildfire'].LowAcc = set_combine(sets.precast.WS['Wildfire'], {
  })
  sets.precast.WS['Wildfire'].LowAccMaxTP = set_combine(sets.precast.WS['Wildfire'].LowAcc, {
  })
  sets.precast.WS['Wildfire'].MidAcc = set_combine(sets.precast.WS['Wildfire'].LowAcc, {
  })
  sets.precast.WS['Wildfire'].MidAccMaxTP = set_combine(sets.precast.WS['Wildfire'].MidAcc, {
  })
  sets.precast.WS['Wildfire'].HighAcc = set_combine(sets.precast.WS['Wildfire'].MidAcc, {
  })
  sets.precast.WS['Wildfire'].HighAccMaxTP = set_combine(sets.precast.WS['Wildfire'].HighAcc, {
  })

  sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
  sets.precast.WS['Hot Shot'].MaxTP = set_combine(sets.precast.WS['Hot Shot'], {
  })
  sets.precast.WS['Hot Shot'].LowAcc = set_combine(sets.precast.WS['Hot Shot'], {
  })
  sets.precast.WS['Hot Shot'].LowAccMaxTP = set_combine(sets.precast.WS['Hot Shot'].LowAcc, {
  })
  sets.precast.WS['Hot Shot'].MidAcc = set_combine(sets.precast.WS['Hot Shot'].LowAcc, {
  })
  sets.precast.WS['Hot Shot'].MidAccMaxTP = set_combine(sets.precast.WS['Hot Shot'].MidAcc, {
  })
  sets.precast.WS['Hot Shot'].HighAcc = set_combine(sets.precast.WS['Hot Shot'].MidAcc, {
  })
  sets.precast.WS['Hot Shot'].HighAccMaxTP = set_combine(sets.precast.WS['Hot Shot'].HighAcc, {
  })

  sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
    head="Pixie Hairpin +1",
    ear2="Moonshade Earring",
    ring1="Archon Ring",
  })
  sets.precast.WS['Leaden Salute'].MaxTP = set_combine(sets.precast.WS['Leaden Salute'], {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].LowAcc = set_combine(sets.precast.WS['Leaden Salute'], {
  })
  sets.precast.WS['Leaden Salute'].LowAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].MidAcc = set_combine(sets.precast.WS['Leaden Salute'].LowAcc, {
  })
  sets.precast.WS['Leaden Salute'].MidAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Leaden Salute'].HighAcc = set_combine(sets.precast.WS['Leaden Salute'].MidAcc, {
  })
  sets.precast.WS['Leaden Salute'].HighAccMaxTP = set_combine(sets.precast.WS['Leaden Salute'].HighAcc, {
    ear2="Novio Earring",
  })

  sets.precast.WS['Evisceration'] = {
    head=gear.Adhemar_B_head,
    hands="Mummu Wrists +2",
    feet="Mummu Gamash. +2",
    neck="Fotia Gorget",
    ear1="Odr Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    back=gear.COR_TP_Cape,
    waist="Fotia Belt",
    -- body="Abnoba Kaftan",
    -- legs="Zoar Subligar +1",
    -- ring2="Mummu Ring",
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear2="Telos Earring",
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
  })
  sets.precast.WS['Evisceration'].LowAccMaxTP = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
    ear2="Telos Earring",
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAccMaxTP = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
    head="Meghanada Visor +2",
    body=gear.Adhemar_B_body,
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    head=gear.Herc_WSD_head,
    body=gear.Herc_WSD_body,
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet=gear.Herc_WSD_feet,
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    back=gear.COR_WS2_Cape,
    waist="Sailfi Belt +1",
    -- body="Laksamana's Frac +3",
    -- legs=gear.Herc_WSD_legs,
    -- feet="Lanun Bottes +3",
    -- neck="Comm. Charm +2",
    -- ring2="Rufescent Ring",
    -- ring2="Epaminondas's Ring",
  })
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].LowAcc = set_combine(sets.precast.WS['Savage Blade'], {
  })
  sets.precast.WS['Savage Blade'].LowAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'].LowAcc, {
  })
  sets.precast.WS['Savage Blade'].MidAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
    body="Meg. Cuirie +2",
    ear2="Telos Earring",
  })
  sets.precast.WS['Savage Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Savage Blade'].HighAcc, {
    ear2="Telos Earring",
  })

  sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs="Meg. Chausses +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    ring1="Regal Ring",
    ring2="Epona's Ring",
    back=gear.COR_WS2_Cape,
    waist="Fotia Belt",
  })
  sets.precast.WS['Swift Blade'].MaxTP = set_combine(sets.precast.WS['Swift Blade'], {
  })
  sets.precast.WS['Swift Blade'].LowAcc = set_combine(sets.precast.WS['Swift Blade'], {
  })
  sets.precast.WS['Swift Blade'].LowAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].LowAcc, {
  })
  sets.precast.WS['Swift Blade'].MidAcc = set_combine(sets.precast.WS['Swift Blade'].LowAcc, {
  })
  sets.precast.WS['Swift Blade'].MidAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].MidAcc, {
  })
  sets.precast.WS['Swift Blade'].HighAcc = set_combine(sets.precast.WS['Swift Blade'].MidAcc, {
    head="Meghanada Visor +2",
    ear2="Telos Earring",
    -- hands=gear.Adhemar_A_hands,
    -- feet=gear.Herc_STP_feet,
  })
  sets.precast.WS['Swift Blade'].HighAccMaxTP = set_combine(sets.precast.WS['Swift Blade'].HighAcc, {
  })

  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
    hands="Meg. Gloves +2",
    ear1="Telos Earring",
    ear2="Moonshade Earring",
    -- ring2="Rufescent Ring",
  }) --MND
  sets.precast.WS['Requiescat'].MaxTP = set_combine(sets.precast.WS['Requiescat'], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].LowAcc = set_combine(sets.precast.WS['Requiescat'], {
  })
  sets.precast.WS['Requiescat'].LowAccMaxTP = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].MidAcc = set_combine(sets.precast.WS['Requiescat'].LowAcc, {
  })
  sets.precast.WS['Requiescat'].MidAccMaxTP = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS['Requiescat'].MidAcc, {
    head="Meghanada Visor +2",
    ear1="Cessance Earring",
    -- feet=gear.Herc_STP_feet,
  })
  sets.precast.WS['Requiescat'].HighAccMaxTP = set_combine(sets.precast.WS['Requiescat'].HighAcc, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
    ammo=gear.QDbullet,
    ear2="Moonshade Earring",
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].LowAcc = set_combine(sets.precast.WS['Aeolian Edge'], {
  })
  sets.precast.WS['Aeolian Edge'].LowAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].MidAcc = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {
  })
  sets.precast.WS['Aeolian Edge'].MidAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].HighAcc = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {
  })
  sets.precast.WS['Aeolian Edge'].HighAccMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].HighAcc, {
    ear2="Novio Earring",
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    legs="Carmine Cuisses +1", --20
    -- ring1="Evanescence Ring", --5
  }

  sets.midcast.Cure = {
    neck="Incanter's Torque",
    ring1="Lebeche Ring",
    -- ear1="Roundel Earring",
    -- ear2="Mendi. Earring",
    -- ring2="Haoma's Ring",
    -- waist="Bishop's Sash",
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  sets.midcast.CorsairShot = {
    ammo=gear.QDbullet,
    head="Nyame Helm", --30
    body="Nyame Mail", --30
    hands="Carmine Fin. Ga. +1",
    legs="Nyame Flanchard", --30
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant",
    ear1="Friomisi Earring",
    ear2="Novio Earring",
    ring1="Dingir Ring",
    waist="Eschan Stone",
    -- body="Lanun Frac +3",
    -- feet="Lanun Bottes +3",
    -- ring2={name="Fenrir Ring +1", bag="wardrobe4"},
    -- back=gear.COR_WS1_Cape,
    -- waist="Skrymir Cord +1",
  }

  -- More acc
  sets.midcast.CorsairShot['Light Shot'] = {
    ammo=gear.RAccbullet,
    head="Laksamana's Tricorne +1",
    body="Malignance Tabard",
    hands="Laksamana's Gants +1",
    legs="Malignance Tights",
    feet="Laksamana's Bottes +1",
    ear2="Digni. Earring",
    ring1="Regal Ring",
    ring2="Weatherspoon Ring",
    waist="K. Kachina Belt +1",
    -- head="Laksamana's Tricorne +3",
    -- hands="Laksamana's Gants +3",
    -- feet="Laksamana's Bottes +3",
    -- neck="Comm. Charm +2",
    -- ear1="Gwati Earring",
    -- ring2="Stikini Ring +1",
    -- back=gear.COR_WS1_Cape,
  }

  sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
  sets.midcast.CorsairShot.Enhance = {
    feet="Chasseur's Bottes"
    -- body="Mirke Wardecors",
    -- feet="Chasseur's Bottes +1"
  }

  -- Ranged gear
  sets.midcast.RA = {
    ammo=gear.RAbullet,
    head="Meghanada Visor +2",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    ear2="Telos Earring",
    ring1="Dingir Ring",
    ring2="Ilabrat Ring",
    waist="Yemaya Belt",
    -- head="Malignance Chapeau",
    -- ear1="Enervating Earring",
    -- back=gear.COR_RA_Cape,
  }

  sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    ammo=gear.RAccbullet,
    ear1="Beyla Earring",
    ring2="Hajduk Ring +1",
  })

  sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
    ring1="Regal Ring",
    waist="K. Kachina Belt +1",
    -- legs="Laksamana's Trews +3",
  })

  sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Oshosi Leggings",
    neck="Iskur Gorget",
    ear1="Telos Earring",
    ear2="Odr Earring",
    ring1="Begrudging Ring",
    waist="K. Kachina Belt +1",
    -- legs="Darraigner's Brais",
    -- feet="Osh. Leggings +1",
    -- ring2="Mummu Ring",
    -- back=gear.COR_RA_Cape,
    -- waist="Gerdr Belt +1",
  })

  sets.TripleShot = {
    body="Chasseur's Frac", --11
    legs="Oshosi Trousers", --5
    feet="Oshosi Leggings", --2
    -- head="Oshosi Mask +1", --5
    -- body="Chasseur's Frac +1", --12
    -- hands="Lanun Gants +3",
    -- legs="Osh. Trousers +1", --6
    -- feet="Osh. Leggings +1", --3
    -- back=gear.COR_RA_Cape, --5
  } --27

  sets.TripleShotCritical = {
    head="Meghanada Visor +2",
    waist="K. Kachina Belt +1",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    head="Nyame Helm",            --  7/ 7, 123
    body="Malignance Tabard",     --  9/ 9, 139
    hands="Malignance Gloves",    --  5/ 5, 112
    legs="Malignance Tights",     --  7/ 7, 150
    feet="Malignance Boots",      --  4/ 4, 150
    ring2="Defending Ring",       -- 10/10, ___
  } -- 42 PDT / 42 MDT, 674 MEVA

  sets.HeavyDef = {
    head="Nyame Helm",          --  7/ 7, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Chirich Ring +1",    -- __/__, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.COR_TP_Cape,      -- 10/__, ___
    waist="Kasiri Belt",        -- __/__, ___
    -- waist="Carrier's Sash",     -- __/__, ___
  } -- 61 PDT / 53 MDT, 697 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    head="Meghanada Visor +2",
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Meghanada Chausses +2",
    feet="Meghanada Jambeaux +2",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    back=gear.COR_Regen_Cape,
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.resting = {}

  -- Idle sets
  sets.idle = sets.HeavyDef

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.RefreshSub50 = set_combine(sets.idle, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regain.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh_sub50)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh_sub50)

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.LightDef)

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    neck="Loricate Torque +1",  --  6/ 6, ___
    ring2="Gelatinous Ring +1", --  7/-1, ___
    -- back="Moonlight Cape",      --  6/ 6, ___
  }) -- 54 PDT / 48 MDT, 697 MEVA


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Windbuffet Belt +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Combatant's Torque",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ear2="Odr Earring",
    -- head="Carmine Mask +1",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })


  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25%

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands="Floral Gauntlets", --5
    legs=gear.Carmine_D_legs, --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Reiki Yotai", --7
    -- back=gear.COR_DW_Cape, --10
  } -- 48%
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    ear2="Odr Earring",
    -- head="Carmine Mask +1",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.LowHaste = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands="Floral Gauntlets", --5
    legs="Carmine Cuisses +1", --6
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 42%
  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    head="Dampening Tam",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ear2="Odr Earring",
    -- head="Carmine Mask +1",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.MidHaste = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Taeon_DW_feet, --9
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 31%
  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    legs="Carmine Cuisses +1",
    ear2="Odr Earring",
    -- head="Carmine Mask +1",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 18% from gear)
  sets.engaged.DW.HighHaste = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Reiki Yotai", --7
  } -- 27%
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    legs="Meg. Chausses +2",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    legs="Carmine Cuisses +1",
    ear2="Odr Earring",
    -- head="Carmine Mask +1",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (36% DW to cap, 11% from gear)
  sets.engaged.DW.SuperHaste = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Suppanomimi", --5
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Windbuffet Belt +1",
  } -- 11%
  sets.engaged.DW.LowAcc.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.SuperHaste = set_combine(sets.engaged.DW.LowAcc.SuperHaste, {
    legs="Meg. Chausses +2",
    ear1="Cessance Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    -- neck="Combatant's Torque",
  })
    -- head="Carmine Mask +1",
  sets.engaged.DW.HighAcc.SuperHaste = set_combine(sets.engaged.DW.MidAcc.SuperHaste, {
    legs="Carmine Cuisses +1",
    ear2="Odr Earring",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  -- Max Magic/Gear/JA Haste (0-25% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo=gear.RAbullet,
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_TA_feet,
    neck="Iskur Gorget",
    ear1="Brutal Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Petrov Ring",
    back=gear.COR_TP_Cape,
    waist="Windbuffet Belt +1",
  }
  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    legs="Meg. Chausses +2",
    ear1="Cessance Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    -- neck="Combatant's Torque",
  })
  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {
    legs="Carmine Cuisses +1",
    ear2="Odr Earring",
    -- feet=gear.Herc_STP_feet,
    -- ear1="Mache Earring +1",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, sets.LightDef)
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, sets.LightDef)
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, sets.LightDef)
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, sets.LightDef)

  sets.engaged.DW.LightDef = set_combine(sets.engaged.DW, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef = set_combine(sets.engaged.DW.LowAcc, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef = set_combine(sets.engaged.DW.MidAcc, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef = set_combine(sets.engaged.DW.HighAcc, sets.LightDef)

  sets.engaged.DW.LightDef.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.LightDef)

  sets.engaged.DW.LightDef.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.LightDef)

  sets.engaged.DW.LightDef.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.LightDef)

  sets.engaged.DW.LightDef.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.SuperHaste = set_combine(sets.engaged.DW.LowAcc.SuperHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.SuperHaste = set_combine(sets.engaged.DW.MidAcc.SuperHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.SuperHaste = set_combine(sets.engaged.DW.HighAcc.SuperHaste, sets.LightDef)

  sets.engaged.DW.LightDef.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.LightDef)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {
    waist="Hachirin-no-Obi",
  }
  sets.CP = {
    back="Mecisto. Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1",
  }

  sets.TreasureHunter = {
    head="Volte Cap",
    hands=gear.Herc_TH_hands,
    waist="Chaac Belt",
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    legs="Carmine Cuisses +1",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.WeaponSet = {}
  sets.WeaponSet.DeathPenalty_M = {
    -- main="Rostam",
    -- sub="Tauret",
    -- ranged="Death Penalty",
  }
  sets.WeaponSet.DeathPenalty_R = {
    main="Lanun Knife",
    -- sub="Tauret",
    -- ranged="Death Penalty",
  }
  sets.WeaponSet.Armageddon_M = {
    -- main="Rostam",
    -- sub="Tauret",
    -- ranged="Armageddon",
  }
  sets.WeaponSet.Armageddon_R = {
    -- main="Fettering Blade",
    sub="Nusku Shield",
    -- ranged="Armageddon",
  }
  sets.WeaponSet.Fomalhaut_M = {
    main="Naegling",
    sub="Blurred Knife +1",
    ranged="Fomalhaut",
  }
  sets.WeaponSet.Fomalhaut_R = {
    main="Lanun Knife",
    sub="Nusku Shield",
    ranged="Fomalhaut",
  }
  sets.WeaponSet.Ataktos = {
    main="Naegling",
    sub="Blurred Knife +1",
    ranged="Fomalhaut",
    -- ranged="Ataktos",
  }
  sets.WeaponSet.Cleaving = {
    main="Kaja Knife",
    sub="Blurred Knife +1",
    ranged="Doomsday",
    -- main="Tauret",
    -- sub="Levente Dagger",
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Check that proper ammo is available if we're using ranged attacks or similar.
  if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
    do_bullet_checks(spell, spellMap, eventArgs)
  end

  -- Gear
  if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
    if player.status ~= 'Engaged' then
      equip(sets.precast.CorsairRoll.Duration)
    end
    if state.LuzafRing.value then
      equip(sets.precast.LuzafRing)
    end
  end

  if spell.english == 'Fold' and buffactive['Bust'] == 2 then
    if sets.precast.FoldDoubleBust then
      equip(sets.precast.FoldDoubleBust)
      eventArgs.handled = true
    end
  end
  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.action_type == 'Ranged Attack' then
    special_ammo_check()
    if flurry == 2 then
      equip(sets.precast.RA.Flurry2)
    elseif flurry == 1 then
      equip(sets.precast.RA.Flurry1)
    end
  elseif spell.type == 'WeaponSkill' then
    if spell.skill == 'Marksmanship' then
      special_ammo_check()
    end
    -- Equip obi if weather/day matches for WS.
    if elemental_ws:contains(spell.english) then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip(sets.Special.ElementalObi)
      -- Target distance under 1.7 yalms.
      -- elseif spell.target.distance < (1.7 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Matching day and weather.
      elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip(sets.Special.ElementalObi)
      -- Target distance under 8 yalms.
      -- elseif spell.target.distance < (8 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Match day or weather without conflict.
      elseif (spell.element == world.day_element and spell.element ~= elements.weak_to[world.weather_element]) or (spell.element == world.weather_element and spell.element ~= elements.weak_to[world.day_element]) then
        equip(sets.Special.ElementalObi)
      end
    end

    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
  if locked_waist then equip({ waist=player.equipment.waist }) end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.type == 'CorsairShot' then
    if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip(sets.Special.ElementalObi)
      -- Target distance under 1.7 yalms.
      -- elseif spell.target.distance < (1.7 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Matching day and weather.
      elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip(sets.Special.ElementalObi)
      -- Target distance under 8 yalms.
      -- elseif spell.target.distance < (8 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Match day or weather without conflict.
      elseif (spell.element == world.day_element and spell.element ~= elements.weak_to[world.weather_element]) or (spell.element == world.weather_element and spell.element ~= elements.weak_to[world.day_element]) then
        equip(sets.Special.ElementalObi)
      end
      if state.QDMode.value == 'Enhance' then
        equip(sets.midcast.CorsairShot.Enhance)
      elseif state.QDMode.value == 'TH' then
        equip(sets.midcast.CorsairShot)
        equip(sets.TreasureHunter)
      elseif state.QDMode.value == 'STP' then
        equip(sets.midcast.CorsairShot.STP)
      end
    end
  elseif spell.action_type == 'Ranged Attack' then
    if buffactive['Triple Shot'] then
      equip(sets.TripleShot)
      if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
        equip(sets.TripleShotCritical)
      end
    elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
      equip(sets.midcast.RA.Critical)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
  if locked_waist then equip({ waist=player.equipment.waist }) end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
    display_roll_info(spell)
  end
  if spell.english == "Light Shot" then
    send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
  end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
  if S{'flurry'}:contains(buff:lower()) then
    if not gain then
      flurry = nil
    end
    if not midaction() then
      handle_equipping_gear(player.status)
    end
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end
end

function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Weapon Set' then
    equip_weapons()
  end
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
  update_dp_type() -- Requires DistancePlus addon
end

function update_combat_form()
  if DW == true then
    state.CombatForm:set('DW')
  elseif DW == false then
    state.CombatForm:reset()
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''
  -- Ranged WS
  if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
    if state.RangedMode.value ~= 'Normal' then
      wsmode = state.RangedMode.value
    end
  else -- Melee WS
    if state.OffenseMode.value ~= 'Normal' then
      wsmode = state.OffenseMode.value
    end
  end

  local rweapon = sets.WeaponSet[state.WeaponSet.current].range
  if 1900 <= player.tp and player.tp < 2400 then
    if rweapon and rweapon == 'Fomalhaut' then
      wsmode = wsmode..'MaxTP'
    end
  elseif 2400 <= player.tp and player.tp < 2900 then
    if rweapon and (rweapon == 'Anarchy +2' or rweapon =='Anarchy +3' or rweapon == 'Ataktos') then
      wsmode = wsmode..'MaxTP'
    end
  elseif 2900 <= player.tp then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end
  if locked_waist then idleSet = set_combine(idleSet, { waist=player.equipment.waist }) end

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
  if locked_waist then meleeSet = set_combine(meleeSet, { waist=player.equipment.waist }) end

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
  if locked_waist then defenseSet = set_combine(defenseSet, { waist=player.equipment.waist }) end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
  if spell.type == 'CorsairShot' then
    if state.IgnoreTargetting.value == true then
      state.IgnoreTargetting:reset()
      eventArgs.handled = true
    end

    eventArgs.SelectNPCTargets = state.SelectqdTarget.value
  end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

  local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'

  local e_msg = state.Mainqd.current
  if state.UseAltqd.value == true then
    e_msg = e_msg .. '/'..state.Altqd.current
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
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_toy_weapons(cycle_dir)
  --If current state is None, save current weapons to switch back later
  if state.ToyWeapons.current == 'None' then
    sets.ToyWeapon.None.main = player.equipment.main
    sets.ToyWeapon.None.sub = player.equipment.sub
  end

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
  equip(sets.ToyWeapon[state.ToyWeapons.current])
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
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('RefreshSub50')
      elseif isRefreshing==true and player.mpp < 100 then
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

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
  function(act)
    --check if you are a target of spell
    local actionTargets = act.targets
    playerId = windower.ffxi.get_player().id
    isTarget = false
    for _, target in ipairs(actionTargets) do
      if playerId == target.id then
        isTarget = true
      end
    end
    if isTarget == true then
      if act.category == 4 then
        local param = act.param
        if param == 845 and flurry ~= 2 then
          flurry = 1
        elseif param == 846 then
          flurry = 2
        end
      end
    end
  end
)

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
  if cmdParams[1]:lower() == 'qd' then
    if cmdParams[2]:lower() == 't' then
      state.IgnoreTargetting:set()
    end

    local doqd = ''
    if state.UseAltqd.value == true then
      doqd = state[state.Currentqd.current..'qd'].current
      state.Currentqd:cycle()
    else
      doqd = state.Mainqd.current
    end

    send_command('@input /ja "'..doqd..'" <t>')
  elseif cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  elseif cmdParams[1]:lower() == 'equipweapons' then
    equip_weapons()
  elseif cmdParams[1]:lower() == 'toyweapon' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2]:lower() == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1]:lower() == 'test' then
    test()
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

function define_roll_values()
  rolls = {
    ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
    ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
    ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
    ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
    ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
    ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
    ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
    ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
    ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
    ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
    ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
    ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
    ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
    ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
    ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
    ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
    ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
    ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
    ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
    ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
    ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
    ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
    ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
    ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
    ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
    ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
    ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
    ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
    ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
    ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
    ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
  }
end

function display_roll_info(spell)
  rollinfo = rolls[spell.english]
  local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

  if rollinfo then
    add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
        ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
        '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
        ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
        '  ' ..rollsize)
  end
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
  local bullet_name
  local bullet_min_count = 1

  if spell.type == 'WeaponSkill' then
    if spell.skill == "Marksmanship" then
      if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
        -- magical weaponskills
        bullet_name = gear.MAbullet
      else
        -- physical weaponskills
        bullet_name = gear.WSbullet
      end
    else
      -- Ignore non-ranged weaponskills
      return
    end
  elseif spell.type == 'CorsairShot' then
    bullet_name = gear.QDbullet
  elseif spell.action_type == 'Ranged Attack' then
    bullet_name = gear.RAbullet
    if buffactive['Triple Shot'] then
      bullet_min_count = 3
    end
  end

  local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

  -- If no ammo is available, give appropriate warning and end.
  if not available_bullets then
    if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
      add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
      return
    elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
      add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
      return
    else
      add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
      eventArgs.cancel = true
      return
    end
  end

  -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
  if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
    add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
    eventArgs.cancel = true
    return
  end

  -- Low ammo warning.
  if spell.type ~= 'CorsairShot' and state.warned.value == false
    and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
    local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
    --local border = string.repeat("*", #msg)
    local border = ""
    for i = 1, #msg do
        border = border .. "*"
    end

    add_to_chat(104, border)
    add_to_chat(104, msg)
    add_to_chat(104, border)

    state.warned:set()
  elseif available_bullets.count > options.ammo_warning_limit and state.warned then
    state.warned:reset()
  end
end

function special_ammo_check()
  -- Stop if Animikii/Hauksbok equipped
  if no_shoot_ammo:contains(player.equipment.ammo) then
    cancel_spell()
    add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
    return
  end
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
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
  if no_swap_waists:contains(player.equipment.waist) then
    locked_waist = true
  else
    locked_waist = false
  end
end

windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
  if locked_waist then equip({ waist=empty }) end
end)

-- Requires DistancePlus addon
function update_dp_type()
  local weapon = nil
  local weapon_type = nil
  local weapon_subtype = nil

  --Handle unequipped case
  if player.equipment.ranged ~= nil and player.equipment.ranged ~= 0 and player.equipment.ranged ~= 'empty' then
    weapon = res.items:with('name', player.equipment.ranged)
    weapon_type = res.skills[weapon.skill].en
    if weapon_type == 'Archery' then
      weapon_subtype = 'bow'
    elseif weapon_type == 'Marksmanship' then
      weapon_subtype = marksman_weapon_subtypes[weapon.en]
    end
  end

  --Change keybinds if weapon type changed
  if weapon_subtype ~= current_dp_type then
    current_dp_type = weapon_subtype
    if current_dp_type ~= nil then
      coroutine.schedule(function()
        if current_dp_type ~= nil then
          send_command('dp '..current_dp_type)
        end
      end,3)
    end
  end
end

function equip_weapons()
  equip(sets.WeaponSet[state.WeaponSet.current])

  -- Equip appropriate ammo
  local ranged = sets.WeaponSet[state.WeaponSet.current].ranged
  if ranged and gear.RAbullet then
    if player.inventory[gear.RAbullet] then
      equip({ammo=gear.RAbullet})
    else
      add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
    end
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'DNC' then
    set_macro_page(2, 11)
  else
    set_macro_page(1, 11)
  end
end
