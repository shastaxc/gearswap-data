-- Original: Motenten/Arislan || Modified: Silvermutt

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
--              [ WIN+W ]           Toggle Weapon Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ CTRL+` ]          Impetus
--                                  Chakra
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
  lockstyleset = 5

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  state.Buff.Footwork = buffactive.Footwork or false
  state.Buff.Impetus = buffactive.Impetus or false

  state.FootworkWS = M(false, 'Footwork on WS')

  info.impetus_hit_count = 0 -- Do not modify
  windower.raw_register_event('action', on_action_for_impetus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.WeaponskillMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'DT', 'Counter')
  state.IdleMode:options('Normal', 'DT')

  state.WeaponLock = M(false, 'Weapon Lock')
  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle WeaponLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind @c gs c toggle CP')

  send_command('bind ^` input /ja "Impetus" <me>')
  send_command('bind !` input /ja "Chakra" <me>')
  send_command('bind ^numpad+ input /ja "Boost" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'THF' then
    send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
    send_command('bind ^numpad. input /ja "Trick Attack" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  end

  update_combat_form()
  update_melee_groups()

  select_default_macro_book()
  set_lockstyle()
end

function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
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
  send_command('unbind ^numpad+')
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

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head=gear.Herc_WSD_head, --7
    body=gear.Taeon_FC_body, --9
    hands="Leyline Gloves", --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Prolix Ring", --2
  }
  
  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {
    legs="Hesychast's Hose",
  }
  sets.precast.JA['Boost'] = {
    hands="Anchorite's Gloves +1",
  }
  sets.precast.JA['Perfect Counter'] = {
    hands="Tantra Crown +1",
  }
  sets.precast.JA['Dodge'] = {
    feet="Anchorite's Gaiters +2",
  }
  sets.precast.JA['Focus'] = {
    head="Anchorite's Crown +1",
  }
  sets.precast.JA['Counterstance'] = {
    feet="Hesychast's Gaiters +2",
  }
  sets.precast.JA['Footwork'] = {
    feet="Tantra Gaiters +2",
  }
  sets.precast.JA['Formless Strikes'] = {
    body="Hesychast's Cyclas",
  }
  sets.precast.JA['Mantra'] = {
    feet="Hesychast's Gaiters +2",
  }

  sets.precast.JA['Chi Blast'] = {
    head="Hesychast's Crown",
    hands=gear.Adhemar_B_hands,
  }

  sets.precast.JA['Chakra'] = {
    body="Anchorite's Cyclas +2",
    hands="Hesychast's Gloves",
  }

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }
      
  sets.precast.Step = {
  }
  sets.precast.Flourish1 = {
  }

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Rajas Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
  } -- Base WS set

  sets.precast.MaxTP = {
  } -- Replace any TP Bonus gear, overwrites all WS sets

  -- Victory Smite: 80% STR, can crit
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Rajas Ring",
    ring2="Begrudging Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
    -- ammo="Knobkierrie",
    -- body="Anchorite's Cyclas +3",
    -- legs="Hizamaru Hizayoroi +2",
    -- back=gear.MNK_WS_Cape,
    -- ear2="Moonshade Earring",
    -- ring1="Begrudging Ring",
    -- ring2="Niqmaddu Ring",
  })
  sets.precast.WS["Victory Smite"].LowAcc = set_combine(sets.precast.WS["Victory Smite"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS["Victory Smite"].LowAcc, {
    ear2="Telos Earring",
    -- head="Rao Kabuto +1",
  })
  sets.precast.WS["Victory Smite"].HighAcc = set_combine(sets.precast.WS["Victory Smite"].MidAcc, {
    ammo="Falcon Eye",
    -- head="Ken. Jinpachi +1",
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
  })

  -- Shijin Spiral: 100% DEX
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    head=gear.Herc_WSD_head,
    body="Mummu Jacket +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Caro Necklace",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Rajas Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
    -- head="Ken. Jinpachi +1",
    -- body="Adhemar Jacket +1",
    -- legs="Jokushu Haidate",
    -- feet="Ken. Sune-Ate +1",
    -- ear2="Mache Earring +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Regal Ring",
    -- back=gear.MNK_WS_Cape,
  })
  sets.precast.WS["Shijin Spiral"].LowAcc = set_combine(sets.precast.WS["Shijin Spiral"], {
    neck="Fotia Gorget",
    head="Mummu Bonnet +2",
    -- head="Ken. Jinpachi +1",
  })
  sets.precast.WS["Shijin Spiral"].MidAcc = set_combine(sets.precast.WS["Shijin Spiral"].LowAcc, {
    ammo="Falcon Eye",
    ear2="Telos Earring",
  })
  sets.precast.WS["Shijin Spiral"].HighAcc = set_combine(sets.precast.WS["Shijin Spiral"].MidAcc, {
    hands=gear.Ryuo_A_hands,
    feet="Mummu Gamashes +1",
  })

  -- Asuran Fists: 20% STR / 20% VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Caro Necklace",
    ear1="Sherida Earring",
    ear2="Odnowa Earring +1",
    ring1="Rajas Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Asuran Fists"].LowAcc = set_combine(sets.precast.WS["Asuran Fists"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Asuran Fists"].MidAcc = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
    ear2="Telos Earring",
    hands=gear.Ryuo_A_hands,
  })
  sets.precast.WS["Asuran Fists"].HighAcc = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
  })

  -- Ascetic's Fury: 50% STR / 50% VIT, can crit
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Odnowa Earring +1",
    ring1="Rajas Ring",
    ring2="Begrudging Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
    -- ammo="Knobkierrie",
    -- body="Anch. Cyclas +3",
    -- legs="Ken. Hakama +1",
    -- ear2="Moonshade Earring",
    -- ring1="Begrudging Ring",
    -- ring2="Niqmaddu Ring",
    -- back=gear.MNK_WS_Cape,
  })
  sets.precast.WS["Ascetic's Fury"].LowAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
    head="Mummu Bonnet +2",
    -- feet="Ken. Sune-Ate +1",
  })
  sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS["Ascetic's Fury"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Ascetic's Fury"].HighAcc = set_combine(sets.precast.WS["Ascetic's Fury"].MidAcc, {
    ammo="Falcon Eye",
    -- ear1="Mache Earring +1",
    -- head="Ken. Jinpachi +1",
  })

  -- Raging Fists: 30% STR / 30% DEX
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {

  })
  sets.precast.WS["Raging Fists"].LowAcc = set_combine(sets.precast.WS["Raging Fists"], {

  })
  sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS["Raging Fists"].LowAcc, {

  })
  sets.precast.WS["Raging Fists"].HighAcc = set_combine(sets.precast.WS["Raging Fists"].MidAcc, {

  })

  -- Howling Fist: 40% STR / 40% VIT
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Odnowa Earring +1",
    ring1="Epona's Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
    -- ammo="Knobkierrie",
    -- head="Herculean Helm",
    -- body="Herculean Vest",
    -- hands="Anchorite Gloves +3",
    -- legs="Hizamaru Hizayoroi +2",
    -- feet="Herculean Boots",
    -- ear2="Moonshade Earring",
    -- ring2="Niqmaddu Ring",
  })
  sets.precast.WS["Howling Fist"].LowAcc = set_combine(sets.precast.WS["Howling Fist"], {
    head="Mummu Bonnet +2",
  })
  sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Howling Fist"].HighAcc = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
  })

  -- Dragon Kick: 50% STR / 50% DEX
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
    
  })
  sets.precast.WS["Dragon Kick"].LowAcc = set_combine(sets.precast.WS["Dragon Kick"], {

  })
  sets.precast.WS["Dragon Kick"].MidAcc = set_combine(sets.precast.WS["Dragon Kick"].LowAcc, {

  })
  sets.precast.WS["Dragon Kick"].HighAcc = set_combine(sets.precast.WS["Dragon Kick"].MidAcc, {

  })

  -- Tornado Kick: 40% STR / 40% VIT
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
    
  })
  sets.precast.WS["Tornado Kick"].LowAcc = set_combine(sets.precast.WS["Tornado Kick"], {

  })
  sets.precast.WS["Tornado Kick"].MidAcc = set_combine(sets.precast.WS["Tornado Kick"].LowAcc, {

  })
  sets.precast.WS["Tornado Kick"].HighAcc = set_combine(sets.precast.WS["Tornado Kick"].MidAcc, {

  })

  -- Spinning Attack: 100% STR
  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
    ammo="Tantra Tathlum",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Rajas Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Spinning Attack"].LowAcc = set_combine(sets.precast.WS["Spinning Attack"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Spinning Attack"].MidAcc = set_combine(sets.precast.WS["Spinning Attack"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Spinning Attack"].HighAcc = set_combine(sets.precast.WS["Spinning Attack"].MidAcc, {
    ammo="Falcon Eye",
  })

  sets.MAB = {
    head="Highwing Helm", --20
    body=gear.Samnuha_body, --25
    hands="Leyline Gloves", --30
    legs=gear.Herc_MAB_legs, --24
    feet=gear.Herc_WSD_feet, --10
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Novio Earring", --7
    ring1="Shiva Ring +1", --3
    waist="Eschan Stone", --7
    -- feet=gear.Herc_MAB_feet,
  }

  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, sets.MAB, {
    ammo="Tantra Tathlum",
    ring2="Karieyh Ring",
    -- waist="Fotia Belt",
    -- ammo="Knobkierrie",
    -- back=gear.MNK_WS_Cape,
  }) -- STR 30% / INT 30% + MAB

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    ring2="Karieyh Ring",
  }

  sets.latent_regen = {
    neck="Lissome Necklace",
    ear1="Infused Earring",
  }

  sets.idle = {
    ammo="Ginsen",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet="Hermes' Sandals",
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
  }

  sets.DT = {
    ammo="Staunch Tathlum",
    neck="Twilight Necklace",
    ear2="Odnowa Earring +1",
    ring1=gear.Dark_Ring,
    ring2="Defending Ring",
    waist="Moonbow Belt +1",
  }

  sets.idle.DT = set_combine(sets.idle, sets.DT)

  sets.idle.Weak = sets.idle.DT

  sets.idle.Town = set_combine(sets.idle, {
    neck="Monk's Nodowa",
  })

  sets.idle.Town.Adoulin = {
    body="Councilor's Garb",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Ginsen",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha,
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_TP_Cape,
    waist="Moonbow Belt +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Falcon Eye",
    ear2="Cessance Earring",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ear1="Telos Earring",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Hybrid = {
    ammo="Staunch Tathlum",
    ear2="Odnowa Earring +1",
    ring2="Defending Ring",
    waist="Moonbow Belt +1",
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)

  sets.Counter = {
    feet="Hesychast's Gaiters +2",
  }

  sets.engaged.Counter = set_combine(sets.engaged, sets.Counter)
  sets.engaged.LowAcc.Counter = set_combine(sets.engaged.LowAcc, sets.Counter)
  sets.engaged.MidAcc.Counter = set_combine(sets.engaged.MidAcc, sets.Counter)
  sets.engaged.HighAcc.Counter = set_combine(sets.engaged.HighAcc, sets.Counter)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  
  sets.Kiting = {
    feet="Hermes' Sandals",
  }

  -- Hundred Fists/Impetus melee set mods
  sets.engaged.Impetus = set_combine(sets.engaged, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HF = set_combine(sets.engaged)
  sets.engaged.HF.Impetus = set_combine(sets.engaged.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.HF = set_combine(sets.engaged.LowAcc)
  sets.engaged.LowAcc.HF.Impetus = set_combine(sets.engaged.LowAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.HF = set_combine(sets.engaged.MidAcc)
  sets.engaged.MidAcc.HF.Impetus = set_combine(sets.engaged.MidAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.HF = set_combine(sets.engaged.HighAcc)
  sets.engaged.HighAcc.HF.Impetus = set_combine(sets.engaged.HighAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
  sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.Counter = set_combine(sets.engaged.LowAcc, sets.engaged.Counter)
  sets.engaged.LowAcc.Counter.HF = set_combine(sets.engaged.LowAcc.Counter, {})
  sets.engaged.LowAcc.Counter.HF.Impetus = set_combine(sets.engaged.LowAcc.Counter.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.Counter = set_combine(sets.engaged.MidAcc, sets.engaged.Counter)
  sets.engaged.MidAcc.Counter.HF = set_combine(sets.engaged.MidAcc.Counter, {})
  sets.engaged.MidAcc.Counter.HF.Impetus = set_combine(sets.engaged.MidAcc.Counter.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.Counter = set_combine(sets.engaged.HighAcc, sets.engaged.Counter)
  sets.engaged.HighAcc.Counter.HF = set_combine(sets.engaged.HighAcc.Counter, {})
  sets.engaged.HighAcc.Counter.HF.Impetus = set_combine(sets.engaged.HighAcc.Counter.HF, {
    body="Bhikku Cyclas +1",
  })

  -- Footwork combat form
  sets.engaged.Footwork = {
    feet="Anchorite's Gaiters +2"
  }
  sets.engaged.Footwork.Acc = set_combine(sets.engaged.Footwork, {
    
  })
      
  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.impetus_body = {
    body="Bhikku Cyclas +1"
  }
  sets.footwork_kick_feet = {
    feet="Anchorite's Gaiters +2"
  }
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.CP = {
    back="Mecistopins Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  -- Don't gearswap for weaponskills when Defense is on.
  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    eventArgs.handled = true
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' and state.DefenseMode.current == 'None' then
    if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
      -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
      if (state.OffenseMode.current ~= 'MidAcc' and state.OffenseMode.current ~= 'HighAcc' and info.impetus_hit_count > 5)
          or (info.impetus_hit_count > 8) then
        equip(sets.impetus_body)
      end
    elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
      equip(sets.footwork_kick_feet)
    end
    
    -- Replace Moonshade Earring if we're at cap TP
    if player.tp == 3000 then
      equip(sets.precast.MaxTP)
    end
  end
end

function job_aftercast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
    send_command('cancel Footwork')
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
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
  -- Set Footwork as combat form any time it's active and Hundred Fists is not.
  if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
    state.CombatForm:set('Footwork')
  elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
    state.CombatForm:set('Footwork')
  else
    state.CombatForm:reset()
  end
  
  -- Hundred Fists and Impetus modify the custom melee groups
  if buff == "Hundred Fists" or buff == "Impetus" then
    classes.CustomMeleeGroups:clear()
    
    if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
      classes.CustomMeleeGroups:append('HF')
    end
    
    if (buff == "Impetus" and gain) or buffactive.impetus then
      classes.CustomMeleeGroups:append('Impetus')
    end
  end

  -- Update gear if any of the above changed
  if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
    handle_equipping_gear(player.status)
  end

  if buff == "doom" then
    if gain then
      equip(sets.buff.Doom)
      send_command('@input /p Doomed.')
      disable('neck','ring2','waist')
    else
      if player.hpp > 0 then
        send_command('@input /p Doom Removed.')
      end
      enable('neck','ring2','waist')
      handle_equipping_gear(player.status)
    end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  update_weapons()
  check_gear()
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

  local ws_msg = state.WeaponskillMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
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
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  update_weaponskill_binds()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if player.tp < 3000 then 
    idleSet = set_combine(idleSet, sets.latent_regain)
  end
  if player.hpp < 85 then
    idleSet = set_combine(idleSet, sets.latent_regen)
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end
  if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
    idleSet = set_combine(idleSet, sets.idle.Town.Adoulin)
  end

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
  if buffactive.footwork and not buffactive['hundred fists'] then
    state.CombatForm:set('Footwork')
  else
    state.CombatForm:reset()
  end
end

function update_melee_groups()
  classes.CustomMeleeGroups:clear()
  
  if buffactive['hundred fists'] then
    classes.CustomMeleeGroups:append('HF')
  end
  
  if buffactive.impetus then
    classes.CustomMeleeGroups:append('Impetus')
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
    if not midaction() then
      job_update()
    end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  if player.sub_job == 'WAR' then
    set_macro_page(1, 1)
  elseif player.sub_job == 'DNC' then
    set_macro_page(2, 1)
  elseif player.sub_job == 'NIN' then
    set_macro_page(3, 1)
  elseif player.sub_job == 'THF' then
    set_macro_page(4, 1)
  elseif player.sub_job == 'RUN' then
    set_macro_page(5, 1)
  else
    set_macro_page(1, 1)
  end
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
  if state.Buff.Impetus then
    -- count melee hits by player
    if action.actor_id == player.id then
      if action.category == 1 then
        for _,target in pairs(action.targets) do
          for _,action in pairs(target.actions) do
            -- Reactions (bitset):
            -- 1 = evade
            -- 2 = parry
            -- 4 = block/guard
            -- 8 = hit
            -- 16 = JA/weaponskill?
            -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
            if (action.reaction % 4) > 0 then
              info.impetus_hit_count = 0
            else
              info.impetus_hit_count = info.impetus_hit_count + 1
            end
          end
        end
      elseif action.category == 3 then
        -- Missed weaponskill hits will reset the counter.  Can we tell?
        -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
        -- Can't tell if any hits were missed, so have to assume all hit.
        -- Increment by the minimum number of weaponskill hits: 2.
        for _,target in pairs(action.targets) do
          for _,action in pairs(target.actions) do
            -- This will only be if the entire weaponskill missed or was parried.
            if (action.reaction % 4) > 0 then
              info.impetus_hit_count = 0
            else
              info.impetus_hit_count = info.impetus_hit_count + 2
            end
          end
        end
      end
    elseif action.actor_id ~= player.id and action.category == 1 then
      -- If mob hits the player, check for counters.
      for _,target in pairs(action.targets) do
        if target.id == player.id then
          for _,action in pairs(target.actions) do
            -- Spike effect animation:
            -- 63 = counter
            -- ?? = missed counter
            if action.has_spike_effect then
              -- spike_effect_message of 592 == missed counter
              if action.spike_effect_message == 592 then
                info.impetus_hit_count = 0
              elseif action.spike_effect_animation == 63 then
                info.impetus_hit_count = info.impetus_hit_count + 1
              end
            end
          end
        end
      end
    end
    
  --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
  else
    info.impetus_hit_count = 0
  end
  
end

