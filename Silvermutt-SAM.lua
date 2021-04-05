-- Author: Silvermutt

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
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
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
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs c weaponset current')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  silibs.use_weapon_rearm = true

  elemental_ws = S{'Tachi: Goten', 'Tachi: Kagero', 'Tachi: Jinpu', 'Tachi: Koki'}

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef', 'MEVA')
  state.IdleMode:options('Normal', 'HeavyDef')

  state.RearmingLock = M(false, 'Rearming Lock')
  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None','GreatKatana','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Masa', 'Doji', 'Shining One'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.set_lockstyle(7)
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  end

  update_combat_form()
  update_melee_groups()

  select_default_macro_book()
end

function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  -- Enmity sets
  sets.Enmity = {
    -- ammo="Sapience Orb",
    -- head="Loess Barbuta +1",
    -- body="Emet Harness +1",
    -- hands="Kurys Gloves",
    -- legs=gear.Valorous_Enmity_legs,
    -- feet=gear.Valorous_Enmity_feet,
    -- neck="Unmoving Collar +1",
    -- ear1="Cryptic Earring",
    -- ear2="Trux Earring",
    -- ring1="Supershear Ring",
    -- ring2="Eihwaz Ring",
    -- back=gear.SAM_Enmity_Cape,
    -- waist="Trance Belt",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
  }

  -- Precast sets to enhance JAs on use
  sets.precast.JA['Meikyo Shisui'] = {
    -- feet="Sakonji Sune-ate +3",
  }

  sets.precast.JA['Warding Circle'] = {
    -- head="Wakido Kabuto +3",
  }

  sets.precast.JA['Third Eye'] = {
    -- legs="Sakonji Haidate +3",
  }

  sets.precast.JA['Hasso'] = {
    -- hands="Wakido Kote +3",
  }

  sets.precast.JA['Meditate'] = {
    -- head="Wakido Kabuto +3",
    -- hands="Sakonji Kote +3",
    -- back="Smertrios's Mantle",
  }

  sets.precast.JA['Seigan'] = {
    -- head="Kasuga Kabuto +1",
  }

  sets.precast.JA['Sekkanoki'] = {
    -- hands="Kasuga Kote +1",
  }

  sets.precast.JA['Shikikoyo'] = {
    -- legs="Sakonji Haidate +3",
  }

  sets.precast.JA['Blade Bash'] = {
    -- hands="Sakonji Kote +3",
  }

  sets.precast.JA['Sengikori'] = {
    -- feet="Kasuga Sune-ate +1",
  }

  sets.precast.JA['Provoke'] = sets.Enmity

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }
  sets.precast.Step = {
  }
  sets.precast.Flourish1 = {
  }

  sets.precast.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    ring1="Prolix Ring",
    ring2="Defending Ring",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  sets.midcast.Utsusemi = sets.precast.Utsusemi


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",
    head="Mpaca's cap",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    waist="Fotia Belt",
    -- body="Sakonji Domaru +3",
    -- hands=gear.Valorous_STR_WSD_hands,
    -- legs="Wakido Haidate +3",
    -- feet=gear.Valorous_STR_WSD_feet,
    -- neck="Samurai's Nodowa +2",
    -- ear1="Thrud Earring",
    -- ring2="Epaminondas's Ring",
    -- back=gear.SAM_STR_WSD_Cape,
  } -- Base WS set

  -- Tachi: Fudo - 80% STR
  sets.precast.WS["Tachi: Fudo"] = sets.precast.WS
  sets.precast.WS["Tachi: Fudo"].MaxTP = set_combine(sets.precast.WS["Tachi: Fudo"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Tachi: Fudo"].LowAcc = set_combine(sets.precast.WS["Tachi: Fudo"], {
    ring1="Regal Ring",
    -- head=gear.Rao_A_head,
    -- hands="Wakido Kote +3",
  })
  sets.precast.WS["achi: Fudo"].LowAccMaxTP = set_combine(sets.precast.WS["Tachi: Fudo"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Tachi: Fudo"].MidAcc = set_combine(sets.precast.WS["Tachi: Fudo"].LowAcc, {
    neck="Fotia Gorget",
    -- feet="Sak. Sune-Ate +3",
  })
  sets.precast.WS["Tachi: Fudo"].MidAccMaxTP = set_combine(sets.precast.WS["Tachi: Fudo"].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Tachi: Fudo"].HighAcc = set_combine(sets.precast.WS["Tachi: Fudo"].MidAcc, {
    ear1="Telos Earring",
    -- head="Sakonji Kabuto +3"
  })
  sets.precast.WS["Tachi: Fudo"].HighAccMaxTP = set_combine(sets.precast.WS["Tachi: Fudo"].HighAcc, {
    ear2="Telos Earring",
    -- ear1="Thrud Earring",
  })

  -- Tachi: Kaiten - 80% STR
  sets.precast.WS["Tachi: Kaiten"] = sets.precast.WS["Tachi: Fudo"]
  sets.precast.WS["Tachi: Kaiten"].MaxTP = sets.precast.WS["Tachi: Fudo"].MaxTP
  sets.precast.WS["Tachi: Kaiten"].LowAcc = sets.precast.WS["Tachi: Fudo"].LowAcc
  sets.precast.WS["Tachi: Kaiten"].LowAccMaxTP = sets.precast.WS["Tachi: Fudo"].LowAccMaxTP
  sets.precast.WS["Tachi: Kaiten"].MidAcc = sets.precast.WS["Tachi: Fudo"].MidAcc
  sets.precast.WS["Tachi: Kaiten"].MidAccMaxTP = sets.precast.WS["Tachi: Fudo"].MidAccMaxTP
  sets.precast.WS["Tachi: Kaiten"].HighAcc = sets.precast.WS["Tachi: Fudo"].HighAcc
  sets.precast.WS["Tachi: Kaiten"].HighAccMaxTP = sets.precast.WS["Tachi: Fudo"].HighAccMaxTP

  -- Tachi: Gekko - 75% STR
  sets.precast.WS["Tachi: Gekko"] = sets.precast.WS["Tachi: Fudo"]
  sets.precast.WS["Tachi: Gekko"].MaxTP = sets.precast.WS["Tachi: Fudo"].MaxTP
  sets.precast.WS["Tachi: Gekko"].LowAcc = sets.precast.WS["Tachi: Fudo"].LowAcc
  sets.precast.WS["Tachi: Gekko"].LowAccMaxTP = sets.precast.WS["Tachi: Fudo"].LowAccMaxTP
  sets.precast.WS["Tachi: Gekko"].MidAcc = sets.precast.WS["Tachi: Fudo"].MidAcc
  sets.precast.WS["Tachi: Gekko"].MidAccMaxTP = sets.precast.WS["Tachi: Fudo"].MidAccMaxTP
  sets.precast.WS["Tachi: Gekko"].HighAcc = sets.precast.WS["Tachi: Fudo"].HighAcc
  sets.precast.WS["Tachi: Gekko"].HighAccMaxTP = sets.precast.WS["Tachi: Fudo"].HighAccMaxTP

  -- Tachi: Yukikaze - 75% STR
  sets.precast.WS["Tachi: Yukikaze"] = sets.precast.WS["Tachi: Fudo"]
  sets.precast.WS["Tachi: Yukikaze"].MaxTP = sets.precast.WS["Tachi: Fudo"].MaxTP
  sets.precast.WS["Tachi: Yukikaze"].LowAcc = sets.precast.WS["Tachi: Fudo"].LowAcc
  sets.precast.WS["Tachi: Yukikaze"].LowAccMaxTP = sets.precast.WS["Tachi: Fudo"].LowAccMaxTP
  sets.precast.WS["Tachi: Yukikaze"].MidAcc = sets.precast.WS["Tachi: Fudo"].MidAcc
  sets.precast.WS["Tachi: Yukikaze"].MidAccMaxTP = sets.precast.WS["Tachi: Fudo"].MidAccMaxTP
  sets.precast.WS["Tachi: Yukikaze"].HighAcc = sets.precast.WS["Tachi: Fudo"].HighAcc
  sets.precast.WS["Tachi: Yukikaze"].HighAccMaxTP = sets.precast.WS["Tachi: Fudo"].HighAccMaxTP

  -- Tachi: Rana - 50% STR
  sets.precast.WS["Tachi: Rana"] = sets.precast.WS["Tachi: Fudo"]
  sets.precast.WS["Tachi: Rana"].MaxTP = sets.precast.WS["Tachi: Fudo"].MaxTP
  sets.precast.WS["Tachi: Rana"].LowAcc = sets.precast.WS["Tachi: Fudo"].LowAcc
  sets.precast.WS["Tachi: Rana"].LowAccMaxTP = sets.precast.WS["Tachi: Fudo"].LowAccMaxTP
  sets.precast.WS["Tachi: Rana"].MidAcc = sets.precast.WS["Tachi: Fudo"].MidAcc
  sets.precast.WS["Tachi: Rana"].MidAccMaxTP = sets.precast.WS["Tachi: Fudo"].MidAccMaxTP
  sets.precast.WS["Tachi: Rana"].HighAcc = sets.precast.WS["Tachi: Fudo"].HighAcc
  sets.precast.WS["Tachi: Rana"].HighAccMaxTP = sets.precast.WS["Tachi: Fudo"].HighAccMaxTP

  -- Tachi: Kasha - 75% STR
  sets.precast.WS["Tachi: Kasha"] = sets.precast.WS["Tachi: Fudo"]
  sets.precast.WS["Tachi: Kasha"].MaxTP = sets.precast.WS["Tachi: Fudo"].MaxTP
  sets.precast.WS["Tachi: Kasha"].LowAcc = sets.precast.WS["Tachi: Fudo"].LowAcc
  sets.precast.WS["Tachi: Kasha"].LowAccMaxTP = sets.precast.WS["Tachi: Fudo"].LowAccMaxTP
  sets.precast.WS["Tachi: Kasha"].MidAcc = sets.precast.WS["Tachi: Fudo"].MidAcc
  sets.precast.WS["Tachi: Kasha"].MidAccMaxTP = sets.precast.WS["Tachi: Fudo"].MidAccMaxTP
  sets.precast.WS["Tachi: Kasha"].HighAcc = sets.precast.WS["Tachi: Fudo"].HighAcc
  sets.precast.WS["Tachi: Kasha"].HighAccMaxTP = sets.precast.WS["Tachi: Fudo"].HighAccMaxTP

  -- Tachi: Jinpu - 30% STR
  sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    neck="Fotia Gorget",
    ear1="Friomisi Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    waist="Fotia Belt",
    -- head=gear.Valorous_STR_WSD_head,
    -- body=gear.Founders_Breastplate,
    -- hands=gear.Founders_Gauntlets,
    -- legs="Wakido Haidate +3",
    -- feet=gear.Founders_Greaves,
    -- back=gear.SAM_STR_WSD_Cape,
  })
  sets.precast.WS["Tachi: Jinpu"].MaxTP = set_combine(sets.precast.WS["Tachi: Jinpu"], {
    ear2="Novio Earring",
  })
  sets.precast.WS["Tachi: Jinpu"].LowAcc = set_combine(sets.precast.WS["Tachi: Jinpu"], {
  })
  sets.precast.WS["Tachi: Jinpu"].LowAccMaxTP = set_combine(sets.precast.WS["Tachi: Jinpu"].LowAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS["Tachi: Jinpu"].MidAcc = set_combine(sets.precast.WS["Tachi: Jinpu"].LowAcc, {
  })
  sets.precast.WS["Tachi: Jinpu"].MidAccMaxTP = set_combine(sets.precast.WS["Tachi: Jinpu"].MidAcc, {
    ear2="Novio Earring",
  })
  sets.precast.WS["Tachi: Jinpu"].HighAcc = set_combine(sets.precast.WS["Tachi: Jinpu"].MidAcc, {
  })
  sets.precast.WS["Tachi: Jinpu"].HighAccMaxTP = set_combine(sets.precast.WS["Tachi: Jinpu"].HighAcc, {
    ear2="Novio Earring",
  })

  -- Tachi: Shoha - 85% STR; Benefits more from multihit
  sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    neck="Samurai's Nodowa +2",
    ear2="Moonshade Earring",
    ring1="Niqmaddu Ring",
    waist="Fotia Belt",
    -- body="Sakonji Domaru +3",
    -- hands="Flam. Manopolas +2",
    -- legs="Wakido Haidate +3",
    -- feet="Flamma Gambieras +2",
    -- ear1="Thrud Earring",
    -- ring2="Flamma Ring",
    -- back=gear.SAM_STR_WSD_Cape,
  })
  sets.precast.WS["Tachi: Shoha"].MaxTP = set_combine(sets.precast.WS["Tachi: Shoha"], {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Tachi: Shoha"].LowAcc = set_combine(sets.precast.WS["Tachi: Shoha"], {
    ring1="Regal Ring",
  })
  sets.precast.WS["Tachi: Shoha"].LowAccMaxTP = set_combine(sets.precast.WS["Tachi: Shoha"].LowAcc, {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Tachi: Shoha"].MidAcc = set_combine(sets.precast.WS["Tachi: Shoha"].LowAcc, {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Tachi: Shoha"].MidAccMaxTP = set_combine(sets.precast.WS["Tachi: Shoha"].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Tachi: Shoha"].HighAcc = set_combine(sets.precast.WS["Tachi: Shoha"].MidAcc, {
    ear1="Telos Earring",
  })
  sets.precast.WS["Tachi: Shoha"].HighAccMaxTP = set_combine(sets.precast.WS["Tachi: Shoha"].HighAcc, {
    ear2="Telos Earring",
    -- ear1="Thrud Earring",
  })

  -- Tachi: Ageha - 60% CHR / 40% STR; More important to stack magic acc
  -- to ensure the defense down effect lands
  sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    head="Mpaca's Cap",
    ear1="Dignitary's Earring",
    ear2="Moonshade Earring",
    waist="Eschan Stone",
    -- body="Flamme Korazin +2",
    -- hands="Flamma Manopolas +2",
    -- legs="Flamma Dirs +2",
    -- feet="Flamma Gambieras +2",
    -- neck="Sanctity Necklace",
    -- ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
  })
  sets.precast.WS["Tachi: Ageha"].MaxTP = set_combine(sets.precast.WS["Tachi: Ageha"], {
    -- ear2="Gwati Earring",
  })
  sets.precast.WS["Tachi: Ageha"].LowAcc = set_combine(sets.precast.WS["Tachi: Ageha"], {
  })
  sets.precast.WS["Tachi: Ageha"].LowAccMaxTP = set_combine(sets.precast.WS["Tachi: Ageha"].LowAcc, {
    -- ear2="Gwati Earring",
  })
  sets.precast.WS["Tachi: Ageha"].MidAcc = set_combine(sets.precast.WS["Tachi: Ageha"].LowAcc, {
  })
  sets.precast.WS["Tachi: Ageha"].MidAccMaxTP = set_combine(sets.precast.WS["Tachi: Ageha"].MidAcc, {
    -- ear2="Gwati Earring",
  })
  sets.precast.WS["Tachi: Ageha"].HighAcc = set_combine(sets.precast.WS["Tachi: Ageha"].MidAcc, {
  })
  sets.precast.WS["Tachi: Ageha"].HighAccMaxTP = set_combine(sets.precast.WS["Tachi: Ageha"].HighAcc, {
    -- ear2="Gwati Earring",
  })

  -- Polearm sets use a crit build since you should be using Shining One
  -- Impulse Drive - 100% STR
  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb +1",
    legs="Ken. Hakama +1",
    neck="Samurai's Nodowa +2",
    ear1="Brutal Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    waist="Fotia Belt",
    -- head="Flam. Zucchetto +2",
    -- body="Dagon Breast.",
    -- hands=gear.Ryuo_A_hands,
    -- feet="Flam. Gambieras +2",
    -- back=gear.SAM_STR_WSD_Cape,
  })
  sets.precast.WS["Impulse Drive"].MaxTP = set_combine(sets.precast.WS["Impulse Drive"], {
  })
  sets.precast.WS["Impulse Drive"].LowAcc = set_combine(sets.precast.WS["Impulse Drive"], {
  })
  sets.precast.WS["Impulse Drive"].LowAccMaxTP = set_combine(sets.precast.WS["Impulse Drive"].LowAcc, {
  })
  sets.precast.WS["Impulse Drive"].MidAcc = set_combine(sets.precast.WS["Impulse Drive"].LowAcc, {
  })
  sets.precast.WS["Impulse Drive"].MidAccMaxTP = set_combine(sets.precast.WS["Impulse Drive"].MidAcc, {
  })
  sets.precast.WS["Impulse Drive"].HighAcc = set_combine(sets.precast.WS["Impulse Drive"].MidAcc, {
  })
  sets.precast.WS["Impulse Drive"].HighAccMaxTP = set_combine(sets.precast.WS["Impulse Drive"].HighAcc, {
  })

  -- Stardiver - 85% STR
  sets.precast.WS["Stardiver"] = sets.precast.WS["Impulse Drive"]
  sets.precast.WS["Stardiver"].MaxTP = sets.precast.WS["Impulse Drive"].MaxTP
  sets.precast.WS["Stardiver"].LowAcc = sets.precast.WS["Impulse Drive"].LowAcc
  sets.precast.WS["Stardiver"].LowAccMaxTP = sets.precast.WS["Impulse Drive"].LowAccMaxTP
  sets.precast.WS["Stardiver"].MidAcc = sets.precast.WS["Impulse Drive"].MidAcc
  sets.precast.WS["Stardiver"].MidAccMaxTP = sets.precast.WS["Impulse Drive"].MidAccMaxTP
  sets.precast.WS["Stardiver"].HighAcc = sets.precast.WS["Impulse Drive"].HighAcc
  sets.precast.WS["Stardiver"].HighAccMaxTP = sets.precast.WS["Impulse Drive"].HighAccMaxTP

  -- Sonic Thrust - 40% STR / 40% DEX
  sets.precast.WS["Sonic Thrust"] = sets.precast.WS["Impulse Drive"]
  sets.precast.WS["Sonic Thrust"].MaxTP = sets.precast.WS["Impulse Drive"].MaxTP
  sets.precast.WS["Sonic Thrust"].LowAcc = sets.precast.WS["Impulse Drive"].LowAcc
  sets.precast.WS["Sonic Thrust"].LowAccMaxTP = sets.precast.WS["Impulse Drive"].LowAccMaxTP
  sets.precast.WS["Sonic Thrust"].MidAcc = sets.precast.WS["Impulse Drive"].MidAcc
  sets.precast.WS["Sonic Thrust"].MidAccMaxTP = sets.precast.WS["Impulse Drive"].MidAccMaxTP
  sets.precast.WS["Sonic Thrust"].HighAcc = sets.precast.WS["Impulse Drive"].HighAcc
  sets.precast.WS["Sonic Thrust"].HighAccMaxTP = sets.precast.WS["Impulse Drive"].HighAccMaxTP

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Ken. Jinpachi +1",    -- __/__, 101
    legs="Ken. Hakama +1",      -- __/__, 139
    feet="Ken. Sune-Ate +1",    -- __/__, 139
    ring1="Gelatinous Ring +1", --  7/-1, ___
    ring2="Defending Ring",     -- 10/10, ___
    -- body="Wakido Domaru +3",    --  8/ 8,  73
    -- back=gear.SAM_TP_Cape,      -- 10/__, ___
  } --38 PDT/20 MDT, 452 MEVA

  sets.MEVA = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Ken. Jinpachi +1",    -- __/__, 101
    body="Ken. Samue +1",       -- __/__, 117
    hands="Wakido Kote +3",     -- __/__,  46
    legs="Ken. Hakama +1",      -- __/__, 139
    feet="Ken. Sune-Ate +1",    -- __/__, 139
  } --13 PDT/3 MDT, 542 MEVA

  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Ken. Jinpachi +1",    -- __/__, 101
    legs="Ken. Hakama +1",      -- __/__, 139
    feet="Ken. Sune-Ate +1",    -- __/__, 139
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Odnowa Earring +1",   --  3/ 5, ___
    ear2="Genmei Earring",      --  2/__, ___
    ring1="Gelatinous Ring +1", --  7/-1, ___
    ring2="Defending Ring",     -- 10/10, ___
    -- body="Wakido Domaru +3",    --  8/ 8,  73
    -- hands="Wakido Kote +3",     -- __/__,  46
    -- back=gear.SAM_TP_Cape,      -- 10/__, ___
    -- waist="Ioskeha Belt +1",    -- __/__, ___
  } --49 PDT/31 MDT, 542 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    -- head="Valorous Mask",
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    -- body="Hiza. Haramaki +2",
    -- hands="Rao Kote +1",
    -- legs="Rao Haidate +1",
    -- feet="Rao Sune-Ate +1",
    -- ring2="Chirich Ring +1",
  }
  sets.latent_refresh = {
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
  })

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

  sets.idle.HeavyDef = sets.HeavyDef

  sets.idle.Weak = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    legs="Mpaca's Hose",
    neck="Samurai's Nodowa +2",
    ear1="Telos Earring",
    ring2="Niqmaddu Ring",
    -- ammo="Aurgelmir Orb +1",
    -- head="Flam. Zucchetto +2",
    -- body="Kasuga Domaru +1",
    -- hands="Wakido Kote +3",
    -- feet="Mpaca's Boots",
    -- ear2="Dedition Earring",
    -- ring1="Flamma Ring",
    -- back=gear.SAM_TP_Cape,
    -- waist="Ioskeha Belt +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    body="Ken. Samue +1",
    legs="Ken. Hakama +1",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear1="Cessance Earring",
    ear2="Brutal Earring",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ear1="Cessance Earring",
    ear2="Telos Earring",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, sets.LightDef)
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, sets.LightDef)
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, sets.LightDef)
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, sets.LightDef)

  sets.engaged.MEVA = set_combine(sets.engaged, sets.MEVA)
  sets.engaged.LowAcc.MEVA = set_combine(sets.engaged.LowAcc, sets.MEVA)
  sets.engaged.MidAcc.MEVA = set_combine(sets.engaged.MidAcc, sets.MEVA)
  sets.engaged.HighAcc.MEVA = set_combine(sets.engaged.HighAcc, sets.MEVA)

  -----------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.Kiting = {
    feet="Danzo Sune-Ate",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
  sets.TreasureHunter = {
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Masa'] = {main="Masamune", sub="Utu Grip"}
  sets.WeaponSet['Doji'] = {main="Dojikiri Tasutsuna", sub="Utu Grip"}
  sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.cancel_outranged_ws(spell, eventArgs)
  silibs.cancel_on_blocking_status(spell, eventArgs)

  -- Don't gearswap for weaponskills when Defense is on.
  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    eventArgs.handled = true
  end

  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    -- Equip obi if weather/day matches for WS.
    if elemental_ws:contains(spell.english) then
      -- Matching double weather (w/o day conflict).
      if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 1.7 yalms.
      -- elseif spell.target.distance < (1.7 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Matching day and weather.
      elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip({waist="Hachirin-no-Obi"})
      -- Target distance under 8 yalms.
      -- elseif spell.target.distance < (8 + spell.target.model_size) then
        -- equip({waist="Orpheus's Sash"})
      -- Match day or weather without conflict.
      elseif (spell.element == world.day_element and spell.element ~= elements.weak_to[world.weather_element]) or (spell.element == world.weather_element and spell.element ~= elements.weak_to[world.day_element]) then
        equip({waist="Hachirin-no-Obi"})
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
end

function job_midcast(spell, action, spellMap, eventArgs)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_aftercast(spell, action, spellMap, eventArgs)
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
  state.CombatForm:reset()
  classes.CustomMeleeGroups:clear()

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "doom" then
    status_change(player.status)
  end

  if buff == "Aftermath: Lv.3" then
    if gain then
        send_command('timers create "Aftermath Tier III" 180 down')
        send_command('input /echo Tier III Aftermath!!!')
    else
        send_command('timers delete "Aftermath Tier III";gs c -cd AM3 Lost!!!')
        send_command('input /echo Tier III Aftermath OFF!!!')
    end
  end
  if buff == "Aftermath: Lv.2" then
      if gain then
          send_command('timers create "Aftermath Tier II" 120 down')
          send_command('input /echo Tier II Aftermath!!')
      else
          send_command('timers delete "Aftermath Tier II";gs c -cd AM3 Lost!!!')
      end
  end
  if buff == "Aftermath: Lv.1" then
      if gain then
          send_command('timers create "Aftermath Tier I" 60 down')
          send_command('input /echo Tier I Aftermath!')
      else
          send_command('timers delete "Aftermath Tier I";gs c -cd AM3 Lost!!!')
      end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_combat_form()
  update_melee_groups()
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

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

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
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

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if state.OffenseMode.value ~= 'Normal' then
    wsmode = state.OffenseMode.value
  end

  if player.tp > 2900 then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in defensive mode put on move speed gear
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

function test()

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

function update_combat_form()
  state.CombatForm:reset()
end

function update_melee_groups()
  classes.CustomMeleeGroups:clear()
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
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
  elseif cmdParams[1]:lower() == 'weaponset' then
    if cmdParams[2]:lower() == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2]:lower() == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2]:lower() == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1]:lower() == 'test' then
    test()
  end

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if not midaction() then
      job_update()
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
  if player.sub_job == 'DRG' then
    set_macro_page(1, 10)
  elseif player.sub_job == 'WAR' then
    set_macro_page(2, 10)
  elseif player.sub_job == 'NIN' then
  else
    set_macro_page(1, 10)
  end
end
