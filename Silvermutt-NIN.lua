-- Original: Motenten/Arislan || Modified: Silvermutt
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
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Weapon Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ CTRL+- ]          Yonin
--              [ CTRL+= ]          Innin
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              [ ALT+W ]           Defender
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--              [ WIN+/ ]           Utsusemi: San
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  lockstyleset = 1
  options.ninja_tool_warning_limit = 10

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

  state.Buff.Migawari = buffactive.migawari or false
  state.Buff.Yonin = buffactive.Yonin or false
  state.Buff.Innin = buffactive.Innin or false
  state.Buff.Futae = buffactive.Futae or false
  state.Buff.Sange = buffactive.Sange or false

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'DT')
  state.WeaponskillMode:options('Normal', 'MaxTp', 'LowAcc', 'LowAccMaxTp', 'MidAcc', 'MidAccMaxTp', 'HighAcc', 'HighAccMaxTp')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
  state.PhysicalDefenseMode:options('PDT', 'Evasion')

  state.MagicBurst = M(false, 'Magic Burst')
  state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
  state.CP = M(false, "Capacity Points Mode")
  state.WeaponLock = M(false, 'Weapon Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  state.warned = M(false) -- Whether a warning has been given for low ninja tools

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle WeaponLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind ^- input /ja "Yonin" <me>')
  send_command('bind ^= input /ja "Innin" <me>')
  send_command('bind @/ input /ma "Utsusemi: San" <me>')

  send_command('bind @a gs c cycle AttackMode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numlock input /ja "Innin" <me>')
  send_command('bind !numlock input /ja "Yonin" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  locked_style = false -- Do not modify
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
  set_lockstyle()
end

function job_file_unload()
  send_command('unbind !d')
  send_command('unbind !s')
  send_command('unbind @w')
  
  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind @/')
  send_command('unbind @a')
  send_command('unbind @c')
  send_command('unbind @t')
  send_command('unbind !w')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad+')
  send_command('unbind ^numpadenter')
  send_command('unbind ^numpad9')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad6')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad4')
  send_command('unbind ^numpad3')
  send_command('unbind ^numpad2')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind numpad0')

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
  --------------------------------------
  -- Precast sets
  --------------------------------------

  -- Enmity set
  sets.Enmity = {
    -- ammo="Sapience Orb", --2
    -- body="Emet Harness +1", --10
    -- hands="Kurys Gloves", --9
    -- feet="Mochi. Kyahan +3", --8
    -- neck="Moonlight Necklace", --15
    -- ear1="Cryptic Earring", --4
    -- ear2="Trux Earring", --5
    -- ring1="Pernicious Ring", --5
    -- ring2="Eihwaz Ring", --5
    -- waist="Kasiri Belt", --3
  }

  sets.precast.JA['Provoke'] = sets.Enmity
  sets.precast.JA['Mijin Gakure'] = {
    -- legs="Mochi. Hakama +3"
  }
  sets.precast.JA['Futae'] = {
    -- hands="Hattori Tekko +1"
  }
  sets.precast.JA['Sange'] = {
    -- body="Mochi. Chainmail +1"
  }
  sets.precast.JA['Innin'] = {
    -- head="Mochi. Hatsuburi +3"
  }
  sets.precast.JA['Yonin'] = {
    -- head="Mochi. Hatsuburi +3"
  }

  sets.precast.Waltz = {
    -- ammo="Yamarang",
    -- body="Passion Jacket",
    -- legs="Dashing Subligar",
    -- ring1="Asklepian Ring",
    -- waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  -- Fast cast sets for spells

  sets.precast.FC = {
    -- ammo="Sapience Orb", --2
    -- head=gear.Herc_MAB_head, --7
    -- body=gear.Taeon_FC_body, --8
    -- hands=gear.Leyline_Gloves, --8
    -- legs="Rawhide Trousers", --5
    -- feet=gear.Herc_MAB_feet, --2
    -- neck="Orunmila's Torque", --5
    -- ear1="Loquacious Earring", --2
    -- ear2="Enchntr. Earring +1", --2
    -- ring1="Kishar Ring", --4
    -- ring2="Weather. Ring +1", --6(4)
    -- back=gear.NIN_FC_Cape, --10
    -- waist="Sailfi Belt +1",
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    -- body="Mochi. Chainmail +1", --10
    -- neck="Magoraga Beads", --10
  })

  sets.precast.RA = {
    -- head=gear.Taeon_RA_head, --10/0
    -- body=gear.Taeon_RA_body, --10/0
    -- legs=gear.Adhemar_D_legs, --10/13
  }

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    -- ammo="Aurgelmir Orb +1",
    -- head="Hachiya Hatsu. +3",
    -- body=gear.Herc_WS_body,
    -- hands=gear.Adhemar_B_hands,
    -- legs="Mochi. Hakama +3",
    -- feet=gear.Herc_WSD_feet,
    -- neck="Fotia Gorget",
    -- ear1="Moonshade Earring",
    -- ear2="Ishvara Earring",
    -- ring1="Regal Ring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.NIN_WS2_Cape,
    -- waist="Fotia Belt",
  } -- default set

  sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
    -- ammo="Yetshila +1",
    -- body="Ken. Samue +1",
    -- hands="Mummu Wrists +2",
    -- legs="Zoar Subligar +1",
    -- feet="Mummu Gamash. +2",
    -- neck="Ninja Nodowa +1",
    -- ear2="Odr Earring",
    -- ring1="Mummu Ring",
    -- back=gear.NIN_WS2_Cape,
  })
  sets.precast.WS['Blade: Hi'].MaxTp = set_combine(sets.precast.WS['Blade: Hi'], {
  })
  sets.precast.WS['Blade: Hi'].LowAcc = set_combine(sets.precast.WS['Blade: Hi'], {
  })
  sets.precast.WS['Blade: Hi'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].LowAcc, {
  })
  sets.precast.WS['Blade: Hi'].MidAcc = set_combine(sets.precast.WS['Blade: Hi'].LowAcc, {
  })
  sets.precast.WS['Blade: Hi'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].MidAcc, {
  })
  sets.precast.WS['Blade: Hi'].HighAcc = set_combine(sets.precast.WS['Blade: Hi'].MidAcc, {
  })
  sets.precast.WS['Blade: Hi'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].HighAcc, {
  })

  sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
    -- neck="Ninja Nodowa +1",
    -- back=gear.NIN_WS2_Cape,
    -- waist="Sailfi Belt +1",
  })
  sets.precast.WS['Blade: Ten'].MaxTp = set_combine(sets.precast.WS['Blade: Ten'], {
  })
  sets.precast.WS['Blade: Ten'].LowAcc = set_combine(sets.precast.WS['Blade: Ten'], {
  })
  sets.precast.WS['Blade: Ten'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].LowAcc, {
  })
  sets.precast.WS['Blade: Ten'].MidAcc = set_combine(sets.precast.WS['Blade: Ten'].LowAcc, {
  })
  sets.precast.WS['Blade: Ten'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].MidAcc, {
  })
  sets.precast.WS['Blade: Ten'].HighAcc = set_combine(sets.precast.WS['Blade: Ten'].MidAcc, {
  })
  sets.precast.WS['Blade: Ten'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].HighAcc, {
  })

  sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
    -- ammo="C. Palug Stone",
    -- head="Ken. Jinpachi +1",
    -- body="Ken. Samue +1",
    -- hands="Ken. Tekko +1",
    -- legs="Jokushu Haidate",
    -- feet="Ken. Sune-Ate +1",
    -- ear1="Mache Earring +1",
    -- ear2="Lugra Earring +1",
    -- ring1="Gere Ring",
    -- ring2="Ilabrat Ring",
    -- back=gear.NIN_WS1_Cape,
  })
  sets.precast.WS['Blade: Shun'].MaxTp = set_combine(sets.precast.WS['Blade: Shun'], {
  })
  sets.precast.WS['Blade: Shun'].LowAcc = set_combine(sets.precast.WS['Blade: Shun'], {
  })
  sets.precast.WS['Blade: Shun'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].LowAcc, {
  })
  sets.precast.WS['Blade: Shun'].MidAcc = set_combine(sets.precast.WS['Blade: Shun'].LowAcc, {
  })
  sets.precast.WS['Blade: Shun'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].MidAcc, {
  })
  sets.precast.WS['Blade: Shun'].HighAcc = set_combine(sets.precast.WS['Blade: Shun'].MidAcc, {
  })
  sets.precast.WS['Blade: Shun'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].HighAcc, {
  })

  sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {

  })
  sets.precast.WS['Blade: Ku'].MaxTp = set_combine(sets.precast.WS['Blade: Ku'], {
  })
  sets.precast.WS['Blade: Ku'].LowAcc = set_combine(sets.precast.WS['Blade: Ku'], {
  })
  sets.precast.WS['Blade: Ku'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].LowAcc, {
  })
  sets.precast.WS['Blade: Ku'].MidAcc = set_combine(sets.precast.WS['Blade: Ku'].LowAcc, {
  })
  sets.precast.WS['Blade: Ku'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].MidAcc, {
  })
  sets.precast.WS['Blade: Ku'].HighAcc = set_combine(sets.precast.WS['Blade: Ku'].MidAcc, {
  })
  sets.precast.WS['Blade: Ku'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].HighAcc, {
  })

  sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {
    -- ring2="Ilabrat Ring",
  })
  sets.precast.WS['Blade: Kamu'].MaxTp = set_combine(sets.precast.WS['Blade: Kamu'], {
  })
  sets.precast.WS['Blade: Kamu'].LowAcc = set_combine(sets.precast.WS['Blade: Kamu'], {
  })
  sets.precast.WS['Blade: Kamu'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].LowAcc, {
  })
  sets.precast.WS['Blade: Kamu'].MidAcc = set_combine(sets.precast.WS['Blade: Kamu'].LowAcc, {
  })
  sets.precast.WS['Blade: Kamu'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].MidAcc, {
  })
  sets.precast.WS['Blade: Kamu'].HighAcc = set_combine(sets.precast.WS['Blade: Kamu'].MidAcc, {
  })
  sets.precast.WS['Blade: Kamu'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].HighAcc, {
  })

  sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS, {
    -- ammo="Seeth. Bomblet +1",
    -- head="Hachiya Hatsu. +3",
    -- body="Samnuha Coat",
    -- hands=gear.Leyline_Gloves,
    -- legs=gear.Herc_WSD_legs,
    -- feet=gear.Herc_MAB_feet,
    -- neck="Baetyl Pendant",
    -- ear1="Crematio Earring",
    -- ear2="Friomisi Earring",
    -- ring1="Dingir Ring",
    -- back=gear.NIN_MAB_Cape,
    -- waist="Eschan Stone",
  })
  sets.precast.WS['Blade: Yu'].MaxTp = set_combine(sets.precast.WS['Blade: Yu'], {
  })
  sets.precast.WS['Blade: Yu'].LowAcc = set_combine(sets.precast.WS['Blade: Yu'], {
  })
  sets.precast.WS['Blade: Yu'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].LowAcc, {
  })
  sets.precast.WS['Blade: Yu'].MidAcc = set_combine(sets.precast.WS['Blade: Yu'].LowAcc, {
  })
  sets.precast.WS['Blade: Yu'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].MidAcc, {
  })
  sets.precast.WS['Blade: Yu'].HighAcc = set_combine(sets.precast.WS['Blade: Yu'].MidAcc, {
  })
  sets.precast.WS['Blade: Yu'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].HighAcc, {
  })

  sets.Lugra = {
    -- ear2="Lugra Earring +1"
  }
  sets.Obi = {
    waist="Hachirin-no-Obi"
  }

  --------------------------------------
  -- Midcast sets
  --------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    -- ammo="Staunch Tathlum +1", --11
    -- body=gear.Taeon_Phalanx_body, --10
    -- hands="Rawhide Gloves", --15
    -- legs=gear.Taeon_Phalanx_legs, --10
    -- feet=gear.Taeon_Phalanx_feet, --10
    -- neck="Moonlight Necklace", --15
    -- ear2="Halasz Earring", --5
    -- ring1="Evanescence Ring", --5
    -- back=gear.NIN_FC_Cape, --10
    -- waist="Audumbla Sash", --10
  }

  -- Specific spells
  sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
    -- feet="Hattori Kyahan +1",
    -- back=gear.NIN_FC_Cape,
  })

  sets.midcast.ElementalNinjutsu = {
    -- ammo="Pemphredo Tathlum",
    -- head="Mochi. Hatsuburi +3",
    -- body="Samnuha Coat",
    -- hands=gear.Leyline_Gloves,
    -- legs=gear.Herc_MAB_legs,
    -- feet=gear.Herc_MAB_feet,
    -- neck="Baetyl Pendant",
    -- ear1="Crematio Earring",
    -- ear2="Friomisi Earring",
    -- ring1="Shiva Ring +1",
    -- ring2="Metamor. Ring +1",
    -- back=gear.NIN_MAB_Cape,
    -- waist="Eschan Stone",
  }

  sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {
    -- neck="Sanctity Necklace",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- ear1="Enchntr. Earring +1",
  })

  sets.midcast.EnfeeblingNinjutsu = {
    -- ammo="Yamarang",
    -- head="Hachiya Hatsu. +3",
    -- body="Mummu Jacket +2",
    -- hands="Mummu Wrists +2",
    -- legs="Mummu Kecks +2",
    -- feet="Hachiya Kyahan +3",
    -- neck="Sanctity Necklace",
    -- ear1="Enchntr. Earring +1",
    -- ear2="Digni. Earring",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- back=gear.NIN_MAB_Cape,
    -- waist="Eschan Stone",
  }

  sets.midcast.EnhancingNinjutsu = {
    -- head="Hachiya Hatsu. +3",
    -- feet="Mochi. Kyahan +3",
    -- neck="Incanter's Torque",
    -- ear1="Stealth Earring",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- back="Astute Cape",
    -- waist="Cimmerian Sash",
  }

  sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

  sets.midcast.RA = {
    -- head="Malignance Chapeau",
    -- body="Malignance Tabard",
    -- hands="Malignance Gloves",
    -- legs="Malignance Tights",
    -- feet="Malignance Boots",
    -- neck="Iskur Gorget",
    -- ear1="Enervating Earring",
    -- ear2="Telos Earring",
    -- ring1="Dingir Ring",
    -- ring2="Hajduk Ring +1",
    -- back=gear.NIN_TP_Cape,
    -- waist="Yemaya Belt",
  }

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    ring2="Karieyh Ring",
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    legs="Rawhide Trousers",
  }

  -- Idle sets
  sets.idle = {
    -- ammo="Seki Shuriken",
    -- head="Malignance Chapeau",
    -- body="Hiza. Haramaki +2",
    -- hands="Malignance Gloves",
    -- legs="Malignance Tights",
    -- feet="Malignance Boots",
    -- neck="Bathy Choker +1",
    -- ear1="Eabani Earring",
    -- ear2="Sanare Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- back=gear.NIN_FC_Cape,
    -- waist="Engraved Belt",
  }

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.DT = {
    -- head="Malignance Chapeau", --6/6
    -- body="Malignance Tabard", --9/9
    -- hands="Malignance Gloves", --5/5
    -- legs="Malignance Tights", --7/7
    -- feet="Malignance Boots", --4/4
    -- neck="Warder's Charm +1",
    -- ear1="Sanare Earring",
    -- ring1="Purity Ring", --0/4
    -- ring2="Defending Ring", --10/10
    -- back="Moonlight Cape", --6/6
  }

  sets.idle.DT = set_combine(sets.idle, sets.DT)
  sets.idle.DT.Regain = set_combine(sets.idle.Regain, sets.DT)
  sets.idle.DT.Regen = set_combine(sets.idle.Regen, sets.DT)
  sets.idle.DT.Refresh = set_combine(sets.idle.Refresh, sets.DT)
  sets.idle.DT.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.DT)
  sets.idle.DT.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.DT)
  sets.idle.DT.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.DT)
  sets.idle.DT.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.DT)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.idle.DT
  sets.defense.MDT = sets.idle.DT

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- * NIN Native DW Trait: 35% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 39% from gear)
  sets.engaged = {
    -- ammo="Seki Shuriken",
    -- head="Ryuo Somen +1", --9
    -- body=gear.Adhemar_B_body, --6
    -- hands=gear.Adhemar_B_hands,
    -- legs="Ken. Hakama +1",
    -- feet="Hiza. Sune-Ate +2", --8
    -- neck="Ninja Nodowa +1",
    -- ear1="Eabani Earring", --4
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Reiki Yotai", --7
  } -- 39%

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    -- ring2="Ilabrat Ring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 32% from gear)
  sets.engaged.LowHaste = {
    -- ammo="Seki Shuriken",
    -- head="Ryuo Somen +1", --9
    -- body=gear.Adhemar_B_body, --6
    -- hands=gear.Adhemar_B_hands,
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
    -- neck="Ninja Nodowa +1",
    -- ear1="Eabani Earring", --4
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Reiki Yotai", --7
  } -- 31%

  sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 21% from gear)
  sets.engaged.MidHaste = {
    -- ammo="Seki Shuriken",
    -- head="Ryuo Somen +1", --9
    -- body=gear.Adhemar_B_body, --6
    -- hands=gear.Adhemar_B_hands,
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
    -- neck="Ninja Nodowa +1",
    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Reiki Yotai", --7
  } -- 22%

  sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidHaste.MidAcc, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- High Magic/Gear/JA Haste (51% DW to cap, 16% from gear)
  sets.engaged.HighHaste = {
    -- ammo="Seki Shuriken",
    -- head="Ken. Jinpachi +1",
    -- body="Ken. Samue +1",
    -- hands=gear.Adhemar_B_hands,
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
    -- neck="Ninja Nodowa +1",
    -- ear1="Cessance Earring",
    -- ear2="Suppanomimi", --5
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Reiki Yotai", --7
  } -- 12%

  sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
    -- hands=gear.Adhemar_A_hands,
  })

  sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
  })

  -- Max Magic/Gear/JA Haste (36% DW to cap, 1% from gear)
  sets.engaged.MaxHaste = {
    -- ammo="Seki Shuriken",
    -- head="Ken. Jinpachi +1",
    -- body="Ken. Samue +1",
    -- hands=gear.Adhemar_B_hands,
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
    -- neck="Ninja Nodowa +1",
    -- ear1="Cessance Earring",
    -- ear2="Telos Earring",
    -- ring1="Gere Ring",
    -- ring2="Epona's Ring",
    -- back=gear.NIN_TP_Cape,
    -- waist="Windbuffet Belt +1",
  } -- 0%

  sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
    -- hands=gear.Adhemar_A_hands,
    -- waist="Kentarch Belt +1",
  })

  sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
    -- ear1="Cessance Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2="Ilabrat Ring",
  })

  sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
    -- ring1="Regal Ring",
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- waist="Olseni Belt",
  })

  sets.engaged.Hybrid = {
    -- head="Malignance Chapeau", --6/6
    -- legs="Malignance Tights", --7/7
    -- feet="Malignance Boots", --4/4
    -- ring2="Defending Ring", --10/10
    -- back=gear.NIN_WS1_Cape, --10/0
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

  sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)

  sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)

  sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)

  sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  
  sets.buff.Migawari = {
    -- body="Iga Ningi +2"
  }
  sets.buff.Yonin = {}
  sets.buff.Innin = {}
  sets.buff.Sange = {
    -- ammo="Hachiya Shuriken"
  }
  sets.buff.Doom = {
    -- neck="Nicander's Necklace", --20
    -- ring2="Eshmun's Ring", --20
    -- waist="Gishdubar Sash", --10
  }

  sets.magic_burst = {
    -- feet="Hachiya Kyahan +3",
    -- ring1="Locus Ring",
    -- ring2="Mujin Band", --(5)
  }
  sets.CP = {
    -- back="Aptitude Mantle"
  }
  sets.TreasureHunter = {
    -- head="Volte Cap",
    -- hands=gear.Herc_TH_hands,
    -- waist="Chaac Belt"
  }
  sets.Reive = {
    -- neck="Ygnas's Resolve +1"
  }

  sets.Adoulin = {
    body="Councilor's Garb",
  }
  sets.DayMovement = {
    -- feet="Danzo sune-ate"
  }
  sets.NightMovement = {
    -- feet="Hachiya Kyahan +3"
  }
  sets.Kiting = {}
  determine_kiting_set()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
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
    if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
      equip(sets.Lugra)
    end
    if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
      equip(sets.Obi)
    end
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if default_spell_map == 'ElementalNinjutsu' then
    if state.MagicBurst.value then
      equip(sets.magic_burst)
    end
    if (spell.element == world.day_element or spell.element == world.weather_element) then
      equip(sets.Obi)
    end
    if state.Buff.Futae then
      equip(sets.precast.JA['Futae'])
    end
  end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  if not spell.interrupted and spell.english == "Migawari: Ichi" then
    state.Buff.Migawari = true
  end
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

  if buff == "Doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Doom" then
    status_change(player.status)
  end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
  if state.WeaponLock.value == true then
    disable('main','sub')
  else
    enable('main','sub')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  update_weapons()
  check_gear()
  determine_kiting_set()
  update_idle_groups()
  update_combat_form()
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  th_update(cmdParams, eventArgs)
  update_weaponskill_binds()
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
  if state.OffenseMode.value == 'LowAcc' then
    if player.tp == 3000 then
      wsmode = 'LowAccMaxTp'
    else
      wsmode = 'LowAcc'
    end
  elseif state.OffenseMode.value == 'MidAcc' then
    if player.tp == 3000 then
      wsmode = 'MidAccMaxTp'
    else
      wsmode = 'MidAcc'
    end
  elseif state.OffenseMode.value == 'HighAcc' then
    if player.tp == 3000 then
      wsmode = 'HighAccMaxTp'
    else
      wsmode = 'HighAcc'
    end
  elseif player.tp == 3000 then
    wsmode = 'MaxTp'
  end

  return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if state.Buff.Migawari then
    idleSet = set_combine(idleSet, sets.buff.Migawari)
  end
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current ~= 'DT' and state.DefenseMode.value == 'None' then
    idleSet = set_combine(idleSet, sets.Kiting)
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end
  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.Buff.Migawari then
    meleeSet = set_combine(meleeSet, sets.buff.Migawari)
  end
  if state.TreasureMode.value == 'Fulltime' then
    meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end
  if state.Buff.Sange then
    meleeSet = set_combine(meleeSet, sets.buff.Sange)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end
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

  local ws_msg = state.WeaponskillMode.value

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
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
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

function determine_kiting_set()
  if classes.CustomIdleGroups:contains('Adoulin') then
    sets.Kiting = sets.Adoulin
  else
    if world.time >= (17*60) or world.time <= (7*60) then
      sets.Kiting = sets.NightMovement
    else
      sets.Kiting = sets.DayMovement
    end
  end
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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 1 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 1 and DW_needed <= 16 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 16 and DW_needed <= 21 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 21 and DW_needed <= 34 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 34 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
  elseif cmdParams[1]:lower() == 'toyweapon' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2]:lower() == 'reset' then
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
-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
  local ninja_tool_name
  local ninja_tool_min_count = 1

  -- Only checks for universal tools and shihei
  if spell.skill == "Ninjutsu" then
    if spellMap == 'Utsusemi' then
      ninja_tool_name = "Shihei"
    elseif spellMap == 'ElementalNinjutsu' then
      ninja_tool_name = "Inoshishinofuda"
    elseif spellMap == 'EnfeeblingNinjutsu' then
      ninja_tool_name = "Chonofuda"
    elseif spellMap == 'EnhancingNinjutsu' then
      ninja_tool_name = "Shikanofuda"
    else
      return
    end
  end

  local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

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

windower.raw_register_event('outgoing chunk', function(id, data, modified, injected, blocked)
  if id == 0x053 then -- Send lockstyle command to server
    local type = data:unpack("I",0x05)
    if type == 0 then -- This is lockstyle 'disable' command
      locked_style = false
    else -- Various diff ways to set lockstyle
      locked_style = true
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'WAR' then
    set_macro_page(1, 15)
  elseif player.sub_job == 'DNC' then
    set_macro_page(4, 15)
  else
    set_macro_page(1, 15)
  end
end

function set_lockstyle()
  -- Set lockstyle 2 seconds after changing job, trying immediately will error
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 2)
  -- In case lockstyle was on cooldown for first command, try again (lockstyle has 10s cd)
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 10)
end
