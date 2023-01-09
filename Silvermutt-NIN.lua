-- File Status: Very rough.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: HasteInfo, DistancePlus
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable GearInfo, disable RollTracker

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Yonin
--              [ CTRL+= ]          Innin
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--              [ WIN+/ ]           Utsusemi: San
--              [ ALT+, ]           Monomi: Ichi
--              [ ALT+. ]           Tonko: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Blade: Kamu
--              [ CTRL+Numpad8 ]    Blade: Shun
--              [ CTRL+Numpad4 ]    Blade: Ten
--              [ CTRL+Numpad6 ]    Blade: Hi
--              [ CTRL+Numpad1 ]    Blade: Yu
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
  silibs.enable_auto_lockstyle(1)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('HeavyDef', 'Normal')
  state.CastingMode:options('Resistant', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  
  state.CP = M(false, 'Capacity Points Mode')
  state.AttCapped = M(true, 'Attack Capped')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Heishi', 'HeishiHitaki', 'Naegling', 'Aeolian',}
  state.MagicBurst = M(false, 'Magic Burst')

  state.Buff.Migawari = buffactive.migawari or false
  state.Buff.Doom = buffactive.doom or false
  state.Buff.Yonin = buffactive.Yonin or false
  state.Buff.Innin = buffactive.Innin or false
  state.Buff.Futae = buffactive.Futae or false
  state.Buff.Sange = buffactive.Sange or false

  options.ninja_tool_warning_limit = 10
  state.warned = M(false) -- Whether a warning has been given for low ninja tools

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
  send_command('bind !` gs c toggle MagicBurst')

  send_command('bind ^numlock input /ja "Innin" <me>')
  send_command('bind !numlock input /ja "Yonin" <me>')
  send_command('bind !q input /ma "Utsusemi: Ichi" <me>')
  send_command('bind !w input /ma "Utsusemi: Ni" <me>')
  send_command('bind !e input /ma "Utsusemi: San" <me>')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !numpad/ input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  end

  select_default_macro_book()
end

function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^f8')
  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind !`')

  send_command('unbind ^numlock')
  send_command('unbind !numlock')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')
  
  send_command('unbind !numpad/')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Enmity set
  sets.Enmity = {
    ammo="Sapience Orb", --2
    body="Emet Harness +1", --10
    hands="Kurys Gloves", --9
    feet="Mochi. Kyahan +3", --8
    neck="Moonlight Necklace", --15
    ear1="Cryptic Earring", --4
    ear2="Trux Earring", --5
    ring1="Pernicious Ring", --5
    ring2="Eihwaz Ring", --5
    waist="Kasiri Belt", --3
  }

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
  sets.precast.JA['Mijin Gakure'] = {
    legs="Mochi. Hakama +3"
  }
  sets.precast.JA['Futae'] = {
    hands="Hattori Tekko +1",
    -- hands="Hattori Tekko +3",
  }
  sets.precast.JA['Sange'] = {
    body="Mochi. Chainmail +3"
  }
  sets.precast.JA['Innin'] = {
    head="Mochi. Hatsuburi +3"
  }
  sets.precast.JA['Yonin'] = {
    head="Mochi. Hatsuburi +3"
  }

  sets.precast.Waltz = {
    ammo="Yamarang",
    body="Passion Jacket",
    legs="Dashing Subligar",
    ring1="Asklepian Ring",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Sapience Orb", --2
    head=gear.Herc_MAB_head, --7
    body=gear.Taeon_FC_body, --9
    hands="Leyline Gloves", --8
    legs="Rawhide Trousers", --5
    feet=gear.Herc_MAB_feet, --2
    neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    ear2="Enchntr. Earring +1", --2
    ring1="Kishar Ring", --4
    ring2="Weather. Ring +1", --6(4)
    back=gear.NIN_FC_Cape, --10
    waist="Sailfi Belt +1",
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Mochi. Chainmail +3", --14
  })

  sets.precast.RA = {}


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    --ammo="Oshasha's Treatise",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Ninja Nodowa +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Karieyh Ring +1",
    right_ring="Regal Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {})
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {})
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {})

  sets.HybridWS = {
    ammo="Seething Bomblet +1",
    head="Mochi. Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Eschan Stone",
  }
  sets.HybridWS.MaxTP = set_combine(sets.HybridWS, {})
  sets.HybridWS.AttCapped = set_combine(sets.HybridWS, {})
  sets.HybridWS.AttCappedMaxTP = set_combine(sets.HybridWS.AttCapped, {})

  sets.precast.WS['Blade: To'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: To'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: To'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: To'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Teki'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: Teki'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: Teki'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: Teki'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Chi'] = set_combine(sets.HybridWS, {})
  sets.precast.WS['Blade: Chi'].MaxTP = set_combine(sets.HybridWS.MaxTP, {})
  sets.precast.WS['Blade: Chi'].AttCapped = set_combine(sets.HybridWS.AttCapped, {})
  sets.precast.WS['Blade: Chi'].AttCappedMaxTP = set_combine(sets.HybridWS.AttCappedMaxTP, {})

  sets.precast.WS['Blade: Ei'] = {
    ammo="Seething Bomblet +1",
    head="Pixie Hairpin +1",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Baetyl Pendant",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Archon Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_INT_Cape,
    waist="Eschan Stone",
    
    -- neck="Sibyl Scarf",
  }
  sets.precast.WS['Blade: Ei'].MaxTP = set_combine(sets.precast.WS['Blade: Ei'], {
    ear1="Novio Earring",
  })
  sets.precast.WS['Blade: Ei'].AttCapped = set_combine(sets.precast.WS['Blade: Ei'], {})
  sets.precast.WS['Blade: Ei'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ei'].AttCapped, {
    ear1="Novio Earring",
  })

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Baetyl Pendant",
    ear1="Moonshade Earring",
    ear2="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_INT_Cape,
    waist="Eschan Stone",

    -- head="Mochi. Hatsuburi +3",
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear1="Novio Earring",
  })
  sets.precast.WS['Aeolian Edge'].AttCapped = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].AttCapped, {
    ear1="Novio Earring",
  })
  
  sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Blade: Yu'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MaxTP, {})
  sets.precast.WS['Blade: Yu'].AttCapped = set_combine(sets.precast.WS['Aeolian Edge'].AttCapped, {})
  sets.precast.WS['Blade: Yu'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].AttCappedMaxTP, {})

  sets.precast.WS['Blade: Hi'] = {
    ammo="Yetshila +1",
    head="Mpaca's Cap",
    body="Hattori Ningi +3",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Hattori Earring +2",
    ring1="Begrudging Ring",
    ring2="Regal Ring",
    back=gear.NIN_Crit_AGI_Cape,
    waist="Sailfi Belt +1",

    -- head="Blistering Sallet +1",
  }
  sets.precast.WS['Blade: Hi'].MaxTP = set_combine(sets.precast.WS['Blade: Hi'], {})
  sets.precast.WS['Blade: Hi'].AttCapped = {
    ammo="Yetshila +1",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Hattori Earring +2",
    ring1="Epaminondas's Ring",
    ring2="Sroda Ring",
    back=gear.NIN_WSD_AGI_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Hi'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Hi'].AttCapped, {})
  
  sets.precast.WS['Blade: Kamu'] = {
    ammo="Seething Bomblet +1",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Sroda Ring",
    ring2="Gere Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Kamu'].MaxTP = set_combine(sets.precast.WS['Blade: Kamu'], {})
  sets.precast.WS['Blade: Kamu'].AttCapped = {
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Nyame_B_feet,
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Sroda Ring",
    ring2="Gere Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Kamu'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Kamu'].AttCapped, {})

  sets.precast.WS['Blade: Ku'] = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands="Mochizuki Tekko +3",
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Fotia Gorget",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_DA_STR_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Blade: Ku'].MaxTP = set_combine(sets.precast.WS['Blade: Ku'], {})
  sets.precast.WS['Blade: Ku'].AttCapped = {
    ammo="Crepuscular Pebble",
    head="Blistering Sallet +1",
    body=gear.Nyame_B_body,
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Sroda Ring",
    ring2="Gere Ring",
    back=gear.NIN_DA_STR_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Blade: Ku'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ku'].AttCapped, {})

  sets.precast.WS['Blade: Metsu'] = {
    ammo="Coiste Bodhar",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_WSD_DEX_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Metsu'].MaxTP = set_combine(sets.precast.WS['Blade: Metsu'], {})
  sets.precast.WS['Blade: Metsu'].AttCapped = {
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs="Mpaca's Hose",
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
    ring1="Gere Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_DEX_Cape,
    waist="Kentarch Belt +1",
  }
  sets.precast.WS['Blade: Metsu'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Metsu'].AttCapped, {})

  sets.precast.WS['Blade: Shun'] = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body="Hattori Ningi +3",
    hands="Hattori Tekko +3",
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_DA_DEX_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Blade: Shun'].MaxTP = set_combine(sets.precast.WS['Blade: Shun'], {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })
  sets.precast.WS['Blade: Shun'].AttCapped = {
    ammo="Crepuscular Pebble",
    head="Ken. Jinpachi +1",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_DA_DEX_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Blade: Shun'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Shun'].AttCapped, {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })

  sets.precast.WS['Blade: Ten'] = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Ten'].MaxTP = set_combine(sets.precast.WS['Blade: Ten'], {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })
  sets.precast.WS['Blade: Ten'].AttCapped = {
    ammo="Crepuscular Pebble",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Sroda Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Blade: Ten'].AttCappedMaxTP = set_combine(sets.precast.WS['Blade: Ten'].AttCapped, {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })

  sets.precast.WS['Evisceration'] = {
    ammo="Yetshila +1",
    head="Blistering Sallet +1",
    body="Hattori Ningi +3",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet="Ken. Sune-Ate +1",
    neck="Fotia Gorget",
    ear1="Odr Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_Crit_DEX_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Yetshila +1",
    head="Blistering Sallet +1",
    body="Ken. Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet="Ken. Sune-Ate +1",
    neck="Ninja Nodowa +2",
    ear1="Odr Earring",
    ear2="Hattori Earring +2",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_Crit_DEX_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {})
  
  sets.precast.WS['Savage Blade'] = {
    ammo="Yetshila +1",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Lugra Earring +1",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })
  sets.precast.WS['Savage Blade'].AttCapped = {
    ammo="Crepuscular Pebble",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Hattori Kyahan +3",
    neck="Ninja Nodowa +2",
    ear1="Moonshade Earring",
    ear2="Hattori Earring +2",
    ring1="Sroda Ring",
    ring2="Epaminondas's Ring",
    back=gear.NIN_WSD_STR_Cape,
    waist="Sailfi Belt +1",
  }
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS['Savage Blade'].AttCapped, {
    ear1="Lugra Earring +1",
    ear2="Hattori Earring +2",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  sets.midcast.SpellInterrupt = {
    ammo="Staunch Tathlum +1", --11
    body=gear.Taeon_Phalanx_body, --10
    hands="Rawhide Gloves", --15
    legs=gear.Taeon_Phalanx_legs, --10
    feet=gear.Taeon_Phalanx_feet, --10
    neck="Moonlight Necklace", --15
    ear1="Halasz Earring", --5
    ear2="Magnetic Earring", --8
    ring1="Evanescence Ring", --5
    back=gear.NIN_FC_Cape, --10
    waist="Audumbla Sash", --10
  }

  -- Specific spells
  sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
    feet="Hattori Kyahan +1",
    back=gear.NIN_FC_Cape,
  })

  sets.midcast.ElementalNinjutsu = {}

  sets.midcast.ElementalNinjutsu.Ichi = {
    ammo="Ghastly Tathlum +1",
    head="Mochi. Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet="Mochi. Kyahan +3",
    neck="Sibyl Scarf",
    ear1="Crematio Earring",
    ear2="Friomisi Earring",
    ring1="Shiva Ring +1",
    ring2="Dingir Ring",
    back=gear.NIN_Nuke_Cape,
    waist="Eschan Stone",
  }
  sets.midcast.ElementalNinjutsu.Ni = set_combine(sets.midcast.ElementalNinjutsu.Ichi, {
    ring1="Metamorph Ring +1",
  })
  sets.midcast.ElementalNinjutsu.San = set_combine(sets.midcast.ElementalNinjutsu.Ni, {
    ring2="Shiva Ring +1",
  })

  sets.midcast.ElementalNinjutsu.Ichi.MB = {
    ammo="Ghastly Tathlum +1",
    head="Mochi. Hatsuburi +3",
    body=gear.Nyame_B_body,
    hands="Hattori Tekko +3",
    legs=gear.Nyame_B_legs,
    feet="Mochi. Kyahan +3",
    neck="Warder's Charm +1",
    ear1="Crematio Earring",
    ear2="Friomisi Earring",
    ring1="Dingir Ring",
    ring2="Mujin Band",
    back=gear.NIN_Nuke_Cape,
    waist="Eschan Stone",
  }
  sets.midcast.ElementalNinjutsu.Ni.MB = set_combine(sets.midcast.ElementalNinjutsu.Ichi.MB, {
    neck="Sibyl Scarf",
  })
  sets.midcast.ElementalNinjutsu.San.MB = set_combine(sets.midcast.ElementalNinjutsu.Ni.MB, {
    ring1="Metamorph Ring +1",
  })

  sets.midcast.EnfeeblingNinjutsu = {
    ammo="Yamarang",
    head="Hachiya Hatsuburi +3",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Hachiya Kyahan +2",
    neck="Sanctity Necklace",
    ear1="Enchntr. Earring +1",
    ear2="Digni. Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe3"},
    ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back=gear.NIN_MAB_Cape,
    waist="Eschan Stone",
    
    -- feet="Hachiya Kyahan +3",
  }

  sets.midcast.EnhancingNinjutsu = {
    head="Hachiya Hatsuburi +3",
    feet="Mochi. Kyahan +3",
    neck="Incanter's Torque",
    ear1="Stealth Earring",
    ring1={name="Stikini Ring +1", bag="wardrobe3"},
    ring2={name="Stikini Ring +1", bag="wardrobe4"},
    back="Astute Cape",
    waist="Cimmerian Sash",
  }

  sets.midcast.Stun = set_combine(sets.midcast.EnfeeblingNinjutsu, {})

  sets.midcast.RA = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    ear1="Enervating Earring",
    ear2="Telos Earring",
    ring1="Dingir Ring",
    ring2="Hajduk Ring +1",
    back=gear.NIN_TP_Cape,
    waist="Yemaya Belt",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",        -- [ 3/ 3, ___] ___, 11
    head=gear.Nyame_B_head,           -- [ 7/ 7, 123]  91, __
    body=gear.Nyame_B_body,           -- [ 9/ 9, 139] 102, __
    hands=gear.Nyame_B_hands,         -- [ 7/ 7, 112]  80, __
    legs=gear.Nyame_B_legs,           -- [ 8/ 8, 150]  85, __
    feet=gear.Nyame_B_feet,           -- [ 7/ 7, 150] 119, __
    neck="Warder's Charm +1",         -- [__/__, ___] ___, __; Absorb magic dmg
    ear1="Eabani Earring",            -- [__/__,   8]  15, __
    ear2="Hearty Earring",            -- [__/__, ___] ___,  5
    ring1="Shadow Ring",              -- [__/__, ___] ___, __; Annul magic dmg
    ring2="Defending Ring",           -- [10/10, ___] ___, __
    back="Shadow Mantle",             -- [__/__, ___] ___, __; Annul physical dmg
    waist="Engraved Belt",            -- [__/__, ___] ___, __; Element resist
    -- [51 PDT/51 MDT, 682 M.Eva] 492 Eva, 16 Status Resist

    -- body="Hattori Ningi +3",       -- [13/13, 129]  95, __; Migawari+16
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    body="Hizamaru Haramaki +2",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.idle = set_combine(sets.defense.PDT, {})

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

  sets.idle.Town = set_combine(sets.idle, {})

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Tatenashi Haramaki +1",     -- __,  9,  65/__ <__,  5, __> [__/__,  59]  44, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Windbuffet Belt +1",       -- __, __,   2/__ <__,  2,  2> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 0 DW, 75 STP, 314 Acc/207 R.Acc <4 DA, 14 TA, 2 QA> [37 PDT/27 MDT, 525 M.Eva] 375 Evasion, 79 Daken

    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ear2="Dignitary's Earring",       -- __,  3,  10/__ <__, __, __> [__/__, ___] ___, __
    
    -- ear1="Telos Earring",          -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ammo="Date Shuriken",             -- __, __,   5/ 5 <__, __, __> [__/__, ___]   5, __
    waist="Kentarch Belt +1",         -- __,  5,  14/__ < 3, __, __> [__/__, ___] ___, __
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ring2="Chirich Ring +1",          -- __,  6,  10/__ <__, __, __> [__/__, ___] ___, __
    waist="Olseni Belt",              -- __,  3,  20/__ <__, __, __> [__/__, ___] ___, __
  })

  -- Low DW (15 needed from gear)
  sets.engaged.LowDW = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 16 DW, 82 STP, 297 Acc/202 R.Acc <4 DA, 11 TA, 0 QA> [41 PDT/27 MDT, 525 M.Eva] 375 Evasion, 79 Daken
    
    -- feet="Tatenashi Sune-ate +1",  -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ear2="Dignitary's Earring",       -- __,  3,  10/__ <__, __, __> [__/__, ___] ___, __
    
    -- ear1="Telos Earring",          -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    ammo="Date Shuriken",             -- __, __,   5/ 5 <__, __, __> [__/__, ___]   5, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mochi. Chainmail +3",       --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    waist="Olseni Belt",              -- __,  3,  20/__ <__, __, __> [__/__, ___] ___, __
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body=gear.Adhemar_A_body,         --  6, __,  55/35 <__,  4, __> [__/__,  69]  55, __
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 22 DW, 79 STP, 295 Acc/255 R.Acc <4 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
    
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
  })

  -- High DW (25 needed from gear)
  sets.engaged.HighDW = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mochi. Chainmail +3",       --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 25 DW, 79 STP, 291 Acc/267 R.Acc <4 DA, 3 TA, 0 QA> [36 PDT/26 MDT, 533 M.Eva] 392 Evasion, 89 Daken
    
    -- feet="Tatenashi Sune-ate +1",  -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
  })

  -- Super DW (32 needed from gear)
  sets.engaged.SuperDW = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body=gear.Adhemar_A_body,         --  6, __,  55/35 <__,  4, __> [__/__,  69]  55, __
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Telos Earring",             -- __,  5,  10/10 < 1, __, __> [__/__, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 32 DW, 69 STP, 295 Acc/255 R.Acc <4 DA, 7 TA, 0 QA> [36 PDT/26 MDT, 529 M.Eva] 375 Evasion, 79 Daken
    
    -- ear1="Dedition Earring",       -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
  })

  -- Max DW (39 needed from gear)
  sets.engaged.MaxDW = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head=gear.Ryuo_C_head,            --  9, 12,  35/35 <__, __, __> [__/__,  48]  36, __
    body="Mochi. Chainmail +3",       --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands="Malignance Gloves",        -- __, 12,  50/50 <__, __, __> [ 5/ 5, 112]  80, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Eabani Earring",            --  4, __,  __/__ <__, __, __> [__/__,   8]  15, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 39 DW, 64 STP, 281 Acc/257 R.Acc <3 DA, 3 TA, 0 QA> [36 PDT/26 MDT, 541 M.Eva] 407 Evasion, 89 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.MaxDW.LowAcc = set_combine(sets.engaged.MaxDW, {
  })
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW.LowAcc, {
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_STP_Cape,           -- __, 10,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Windbuffet Belt +1",       -- __, __,   2/__ <__,  2,  2> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 0 DW, 69 STP, 304 Acc/197 R.Acc <3 DA, 13 TA, 2 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.HeavyDef.LowAcc = set_combine(sets.engaged.HeavyDef, {
  })
  sets.engaged.HeavyDef.MidAcc = set_combine(sets.engaged.HeavyDef.LowAcc, {
  })
  sets.engaged.HeavyDef.HighAcc = set_combine(sets.engaged.HeavyDef.MidAcc, {
  })

  -- Low DW (15 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 17 DW, 63 STP, 312 Acc/207 R.Acc <3 DA, 11 TA, 0 QA> [50 PDT/32 MDT, 552 M.Eva] 433 Evasion, 79 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.LowDW.HeavyDef.LowAcc = set_combine(sets.engaged.LowDW.HeavyDef, {
  })
  sets.engaged.LowDW.HeavyDef.MidAcc = set_combine(sets.engaged.LowDW.HeavyDef.LowAcc, {
  })
  sets.engaged.LowDW.HeavyDef.HighAcc = set_combine(sets.engaged.LowDW.HeavyDef.MidAcc, {
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Malignance Chapeau",        -- __,  8,  50/50 <__, __, __> [ 6/ 6, 123]  91, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Eabani Earring",            --  4, __,  __/__ <__, __, __> [__/__,   8]  15, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 21 DW, 55 STP, 322 Acc/217 R.Acc <3 DA, 11 TA, 0 QA> [50 PDT/32 MDT, 560 M.Eva] 448 Evasion, 79 Daken
  }
  sets.engaged.MidDW.HeavyDef.LowAcc = set_combine(sets.engaged.MidDW.HeavyDef, {
  })
  sets.engaged.MidDW.HeavyDef.MidAcc = set_combine(sets.engaged.MidDW.HeavyDef.LowAcc, {
  })
  sets.engaged.MidDW.HeavyDef.HighAcc = set_combine(sets.engaged.MidDW.HeavyDef.MidAcc, {
  })

  -- High DW (25 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +3",          --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    body="Mpaca's Doublet",           -- __,  8,  55/__ <__,  4, __> [10/__,  86] 102, __
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Epona's Ring",             -- __, __,  __/__ < 3,  3, __> [__/__, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 24 DW, 52 STP, 343 Acc/238 R.Acc <4 DA, 11 TA, 0 QA> [54 PDT/32 MDT, 548 M.Eva] 431 Evasion, 79 Daken
    
    -- feet="Tatenashi Sune-ate +1",  -- __,  8,  60/__ <__,  3, __> [__/__,  80]  76, __
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.HighDW.HeavyDef.LowAcc = set_combine(sets.engaged.HighDW.HeavyDef, {
  })
  sets.engaged.HighDW.HeavyDef.MidAcc = set_combine(sets.engaged.HighDW.HeavyDef.LowAcc, {
  })
  sets.engaged.HighDW.HeavyDef.HighAcc = set_combine(sets.engaged.HighDW.HeavyDef.MidAcc, {
  })

  -- Super DW (32 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +3",          --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    body="Mochi. Chainmail +3",       --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Dedition Earring",          -- __,  8,-10/-10 <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Gelatinous Ring +1",       -- __, __,  __/__ <__, __, __> [ 7/-1, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 33 DW, 47 STP, 319 Acc/265 R.Acc <0 DA, 4 TA, 0 QA> [51 PDT/35 MDT, 535 M.Eva] 401 Evasion, 89 Daken
    
    -- ear2="Hattori Earring +2",     -- __,  8,  20/__ <__, __, __> [__/__, ___] ___, __; katana/throwing +12
  }
  sets.engaged.SuperDW.HeavyDef.LowAcc = set_combine(sets.engaged.SuperDW.HeavyDef, {
  })
  sets.engaged.SuperDW.HeavyDef.MidAcc = set_combine(sets.engaged.SuperDW.HeavyDef.LowAcc, {
  })
  sets.engaged.SuperDW.HeavyDef.HighAcc = set_combine(sets.engaged.SuperDW.HeavyDef.MidAcc, {
  })

  -- Max DW (39 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    ammo="Seki Shuriken",             -- __,  2,  __/__ <__, __, __> [__/__, ___] ___, __
    head="Hattori Zukin +3",          --  7, __,  61/61 <__, __, __> [10/10, 119]  89, __
    body="Mochi. Chainmail +3",       --  9, __,  51/47 <__, __, __> [__/__,  73]  72, 10
    hands=gear.Adhemar_A_hands,       -- __,  7,  52/32 <__,  4, __> [__/__,  43]  36, __
    legs="Malignance Tights",         -- __, 10,  50/50 <__, __, __> [ 7/ 7, 150]  85, __
    feet="Malignance Boots",          -- __,  9,  50/50 <__, __, __> [ 4/ 4, 150] 119, __
    neck="Ninja Nodowa +2",           -- __,  7,  25/25 <__, __, __> [__/__, ___] ___, 25
    ear1="Odnowa Earring +1",         -- __, __,  10/__ <__, __, __> [ 3/ 5, ___] ___, __
    ear2="Suppanomimi",               --  5, __,  __/__ <__, __, __> [__/__, ___] ___, __
    ring1="Defending Ring",           -- __, __,  __/__ <__, __, __> [10/10, ___] ___, __
    ring2="Gelatinous Ring +1",       -- __, __,  __/__ <__, __, __> [ 7/-1, ___] ___, __
    back=gear.NIN_DW_Cape,            -- 10, __,  20/__ <__, __, __> [10/__, ___] ___, __
    waist="Reiki Yotai",              --  7,  4,  10/10 <__, __, __> [__/__, ___] ___, __
    -- Traits/gifts/etc                                                                54
    -- 38 DW, 39 STP, 329 Acc/275 R.Acc <0 DA, 4 TA, 0 QA> [51 PDT/35 MDT, 535 M.Eva] 401 Evasion, 89 Daken
  }
  sets.engaged.MaxDW.HeavyDef.LowAcc = set_combine(sets.engaged.MaxDW.HeavyDef, {
  })
  sets.engaged.MaxDW.HeavyDef.MidAcc = set_combine(sets.engaged.MaxDW.HeavyDef.LowAcc, {
  })
  sets.engaged.MaxDW.HeavyDef.HighAcc = set_combine(sets.engaged.MaxDW.HeavyDef.MidAcc, {
  })

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}

  sets.buff.Yonin = {}
  sets.buff.Innin = {}

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Danzo sune-ate",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.DayMovement = {
    feet="Danzo sune-ate",
  }
  sets.NightMovement = {
    feet="Hachiya Kyahan +2",
    -- feet="Hachiya Kyahan +3",
  }
  
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Heishi'] = {main="Heishi Shorinken", sub="Kunimitsu"}
  sets.WeaponSet['HeishiHitaki'] = {main="Heishi Shorinken", sub="Hitaki"}
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Kunimitsu",
    -- sub="Hitaki",
  }
  sets.WeaponSet['Enmity'] = {main=gear.Fudo_Masamune_C, sub="Kunimitsu"}
  sets.WeaponSet['Aeolian'] = {main="Tauret", sub="Malevolence"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.skill == "Ninjutsu" then
    do_ninja_tool_checks(spell, spellMap, eventArgs)
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
  if spell.type == 'WeaponSkill' then    
    -- Handle belts for elemental WS
    if elemental_ws:contains(spell.english) then
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

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'ElementalNinjutsu' then
    -- Select set based on tier of nuke and whether MB mode is on or off
    if not state.MagicBurst.value then
      if spell:endswith('Ichi') then
        equip(sets.midcast.ElementalNinjutsu.Ichi)
      elseif spell:endswith('Ni') then
        equip(sets.midcast.ElementalNinjutsu.Ni)
      else
        equip(sets.midcast.ElementalNinjutsu.San)
      end
    else
      if spell:endswith('Ichi') then
        equip(sets.midcast.ElementalNinjutsu.Ichi.MB)
      elseif spell:endswith('Ni') then
        equip(sets.midcast.ElementalNinjutsu.Ni.MB)
      else
        equip(sets.midcast.ElementalNinjutsu.San.MB)
      end
    end

    if state.Buff.Futae then
      equip(sets.precast.JA['Futae'])
    end
    
    -- Handle belts for elemental damage
    local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
    local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
    local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)
    local has_obi = true -- Change if you do or don't have Hachirin-no-Obi
    local has_orpheus = false -- Change if you do or don't have Orpheus's Sash

    -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
    if has_obi and (obi_mult >= orpheus_mult or not has_orpheus) and (obi_mult > base_day_weather_mult) then
      -- Obi is better than orpheus and better than nothing
      equip({waist='Hachirin-no-Obi'})
    elseif has_orpheus and (orpheus_mult > base_day_weather_mult) then
      -- Orpheus is better than obi and better than nothing
      equip({waist='Orpheus\'s Sash'})
    end
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


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if not spell.interrupted and spell.english == "Migawari: Ichi" then
    state.Buff.Migawari = true
  end
end

-- Called after the default aftercast handling is complete.
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
  if buff == "Migawari" and not gain then
    add_to_chat(61, "*** MIGAWARI DOWN ***")
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end
end

-- Handle notifications of general user state change.
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
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 1 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
  else
    if silibs.get_dual_wield_needed() > 1 and silibs.get_dual_wield_needed() <= 15 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 15 and silibs.get_dual_wield_needed() <= 21 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 21 and silibs.get_dual_wield_needed() <= 25 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 25 and silibs.get_dual_wield_needed() <= 32 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 32 then
      state.CombatForm:set('MaxDW')
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
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      if world.time >= (17*60) or world.time <= (7*60) then
        idleSet = set_combine(idleSet, sets.NightMovement)
      else
        idleSet = set_combine(idleSet, sets.DayMovement)
      end
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

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end
  
  return idleSet
end

-- Modify the default melee set after it was constructed.
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
function display_current_job_state(eventArgs)

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local toy_msg = state.ToyWeapons.current

    local msg = ''
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  else
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(sets.WeaponSet[state.WeaponSet.current])
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

  if cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_toy_weapons('current')
    end
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
  local ninja_tool_name

  -- Only checks for universal tools and shihei
  if spell.skill == 'Ninjutsu' then
    if spellMap == 'Utsusemi' then
      ninja_tool_name = 'Shihei'
    elseif spellMap == 'ElementalNinjutsu' then
      ninja_tool_name = "Inoshishinofuda"
    elseif spellMap == 'EnfeeblingNinjutsu' then
      ninja_tool_name = 'Chonofuda'
    elseif spellMap == 'EnhancingNinjutsu' then
      ninja_tool_name = 'Shikanofuda'
    else
      return
    end
  end

  local available_ninja_tools = player.inventory[ninja_tool_name]

  -- If no tools are available, end.
  if not available_ninja_tools then
    if spell.skill == "Ninjutsu" then
      return
    end
  end

  -- Low ninja tools warning.
  if spell.skill == "Ninjutsu" and state.warned.value == false
      and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
    local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
    --local border = string.repeat("*", #msg)
    local border = ""
    for i = 1, #msg do
      border = border .. "*"
    end

    add_to_chat(104, border)
    add_to_chat(104, msg)
    add_to_chat(104, border)

    state.warned:set()
  elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
    state.warned:reset()
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
  -- Default macro set/book
  set_macro_page(1, 11)
end

function test()
end