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
  include('Mote-TreasureHunter')

  lockstyleset = 5

  state.Buff.Footwork = buffactive.Footwork or false
  state.Buff.Impetus = buffactive.Impetus or false

  state.FootworkWS = M(false, 'Footwork on WS')

  info.impetus_hit_count = 0 -- Do not modify
  windower.raw_register_event('action', on_action_for_impetus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.WeaponskillMode:options('Normal', 'MaxTp', 'LowAcc', 'LowAccMaxTp', 'MidAcc', 'MidAccMaxTp', 'HighAcc', 'HighAccMaxTp')
  state.HybridMode:options('Normal', 'DT', 'SuperDef')
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

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !q input /ja "Impetus" <me>')
  send_command('bind !` input /ja "Chakra" <me>')
  send_command('bind ^numpad+ input /ja "Boost" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  locked_style = false -- Do not modify
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
  send_command('unbind @c')
  send_command('unbind !q')
  send_command('unbind !`')
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

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head=gear.Herc_WSD_head, --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Prolix Ring", --2
  }
  
  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {
    legs="Hesychast's Hose +1",
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
    feet="Hesychast's Gaiters +3",
  }
  sets.precast.JA['Footwork'] = {
    feet="Tantra Gaiters +2",
  }
  sets.precast.JA['Formless Strikes'] = {
    body="Hesychast's Cyclas",
  }
  sets.precast.JA['Mantra'] = {
    feet="Hesychast's Gaiters +3",
  }

  sets.precast.JA['Chi Blast'] = {
    ammo="Hydrocera", -- 3
    head="Hesychast's Crown", -- 9, Enhance Penance
    body="Anchorite's Cyclas +2", -- 29
    hands=gear.Leyline_Gloves, -- 30
    legs="Anchorite's Hose +1", -- 2
    feet="Hesychast's Gaiters +3", -- 22
    neck="Monk's Nodowa +2", -- 11
    ring1=gear.Dark_Ring, -- 1
    ring2="Defending Ring", -- DT
    waist="Engraved Belt", -- 7
  } -- MND

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
    ammo="Knobkierrie",
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
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  } -- Base WS set

  -- Victory Smite: 80% STR, can crit
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_CritDmg_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Rajas Ring",
    ring2="Begrudging Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body="Anchorite's Cyclas +3",
    -- legs="Hizamaru Hizayoroi +2",
    -- back=gear.MNK_WS_Cape,
    -- ear2="Moonshade Earring",
    -- ring1="Begrudging Ring",
    -- ring2="Niqmaddu Ring",
  })
  sets.precast.WS["Victory Smite"].MaxTp = set_combine(sets.precast.WS["Victory Smite"], {
  })
  sets.precast.WS["Victory Smite"].LowAcc = set_combine(sets.precast.WS["Victory Smite"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Victory Smite"].LowAccMaxTp = set_combine(sets.precast.WS["Victory Smite"].LowAcc, {
  })
  sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS["Victory Smite"].LowAcc, {
    ammo="Falcon Eye",
    -- head="Rao Kabuto +1",
  })
  sets.precast.WS["Victory Smite"].MidAccMaxTp = set_combine(sets.precast.WS["Victory Smite"].MidAcc, {
  })
  sets.precast.WS["Victory Smite"].HighAcc = set_combine(sets.precast.WS["Victory Smite"].MidAcc, {
    -- head="Ken. Jinpachi +1",
    -- legs="Ken. Hakama +1",
    -- feet="Ken. Sune-Ate +1",
  })
  sets.precast.WS["Victory Smite"].HighAccMaxTp = set_combine(sets.precast.WS["Victory Smite"].HighAcc, {
  })

  -- Shijin Spiral: 100% DEX
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    head=gear.Herc_WSD_head,
    body="Mummu Jacket +2",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_TA_feet,
    neck="Caro Necklace",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Rajas Ring",
    back=gear.MNK_DEX_DA_Cape,
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
  sets.precast.WS["Shijin Spiral"].MaxTp = set_combine(sets.precast.WS["Shijin Spiral"], {
  })
  sets.precast.WS["Shijin Spiral"].LowAcc = set_combine(sets.precast.WS["Shijin Spiral"], {
    neck="Fotia Gorget",
    head="Mummu Bonnet +2",
    -- head="Ken. Jinpachi +1",
  })
  sets.precast.WS["Shijin Spiral"].LowAccMaxTp = set_combine(sets.precast.WS["Shijin Spiral"].LowAcc, {
  })
  sets.precast.WS["Shijin Spiral"].MidAcc = set_combine(sets.precast.WS["Shijin Spiral"].LowAcc, {
    ammo="Falcon Eye",
    ear2="Telos Earring",
  })
  sets.precast.WS["Shijin Spiral"].MidAccMaxTp = set_combine(sets.precast.WS["Shijin Spiral"].MidAcc, {
  })
  sets.precast.WS["Shijin Spiral"].HighAcc = set_combine(sets.precast.WS["Shijin Spiral"].MidAcc, {
    hands=gear.Ryuo_A_hands,
    feet="Mummu Gamashes +1",
  })
  sets.precast.WS["Shijin Spiral"].HighAccMaxTp = set_combine(sets.precast.WS["Shijin Spiral"].HighAcc, {
  })

  -- Asuran Fists: 20% STR / 20% VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Caro Necklace",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Rajas Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Asuran Fists"].MaxTp = set_combine(sets.precast.WS["Asuran Fists"], {
    ear2="Odnowa Earring +1",
  })
  sets.precast.WS["Asuran Fists"].LowAcc = set_combine(sets.precast.WS["Asuran Fists"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Asuran Fists"].LowAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
    ear2="Odnowa Earring +1",
  })
  sets.precast.WS["Asuran Fists"].MidAcc = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
    hands=gear.Ryuo_A_hands,
  })
  sets.precast.WS["Asuran Fists"].MidAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
    ear2="Odnowa Earring +1",
  })
  sets.precast.WS["Asuran Fists"].HighAcc = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
  })
  sets.precast.WS["Asuran Fists"].HighAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].HighAcc, {
    ear2="Odnowa Earring +1",
  })

  -- Ascetic's Fury: 50% STR / 50% VIT, can crit
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_CritDmg_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Rajas Ring",
    ring2="Begrudging Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body="Anchorite's. Cyclas +3",
    -- legs="Ken. Hakama +1",
    -- ear2="Moonshade Earring",
    -- ring1="Begrudging Ring",
    -- ring2="Niqmaddu Ring",
    -- back=gear.MNK_WS_Cape,
  })
  sets.precast.WS["Ascetic's Fury"].MaxTp = set_combine(sets.precast.WS["Asuran Fists"], {
    ear2="Odr Earring",
  })
  sets.precast.WS["Ascetic's Fury"].LowAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
    head="Mummu Bonnet +2",
    -- feet="Ken. Sune-Ate +1",
  })
  sets.precast.WS["Ascetic's Fury"].LowAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
    ear2="Odr Earring",
  })
  sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS["Ascetic's Fury"].LowAcc, {
    ammo="Falcon Eye",
  })
  sets.precast.WS["Ascetic's Fury"].MidAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
    ear2="Odr Earring",
  })
  sets.precast.WS["Ascetic's Fury"].HighAcc = set_combine(sets.precast.WS["Ascetic's Fury"].MidAcc, {
    -- ear1="Mache Earring +1",
    -- head="Ken. Jinpachi +1",
  })
  sets.precast.WS["Ascetic's Fury"].HighAccMaxTp = set_combine(sets.precast.WS["Asuran Fists"].HighAcc, {
    ear2="Odr Earring",
  })

  -- Raging Fists: 30% STR / 30% DEX
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    hands=gear.Adhemar_B_hands,
    feet=gear.Herc_TA_feet,
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    back=gear.MNK_STR_DA_Cape,
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Raging Fists"].LowAcc = set_combine(sets.precast.WS["Raging Fists"], {

  })
  sets.precast.WS["Raging Fists"].LowAccMaxTp = set_combine(sets.precast.WS["Raging Fists"].LowAcc, {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS["Raging Fists"].LowAcc, {

  })
  sets.precast.WS["Raging Fists"].MidAccMaxTp = set_combine(sets.precast.WS["Raging Fists"].MidAcc, {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Raging Fists"].HighAcc = set_combine(sets.precast.WS["Raging Fists"].MidAcc, {

  })
  sets.precast.WS["Raging Fists"].HighAccMaxTp = set_combine(sets.precast.WS["Raging Fists"].HighAcc, {
    ear2="Brutal Earring",
  })

  -- Howling Fist: 40% STR / 40% VIT
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hizamaru Hizayoroi +1",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Epona's Ring",
    ring2="Karieyh Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- head="Herculean Helm",
    -- body="Herculean Vest",
    -- hands="Anchorite's Gloves +3",
    -- legs="Hizamaru Hizayoroi +2",
    -- feet="Herculean Boots",
    -- ear2="Moonshade Earring",
    -- ring2="Niqmaddu Ring",
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    ear2="Odnowa Earring +1",
  })
  sets.precast.WS["Howling Fist"].LowAcc = set_combine(sets.precast.WS["Howling Fist"], {
    head="Mummu Bonnet +2",
  })
  sets.precast.WS["Howling Fist"].LowAccMaxTp = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    ear2="Odnowa Earring +1",
  })
  sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Howling Fist"].MidAccMaxTp = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Howling Fist"].HighAcc = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
  })
  sets.precast.WS["Howling Fist"].HighAccMaxTp = set_combine(sets.precast.WS["Howling Fist"].HighAcc, {
    ear2="Telos Earring",
  })

  -- Dragon Kick: 50% STR / 50% DEX
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
    
  })

  -- Tornado Kick: 40% STR / 40% VIT
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
    back=gear.MNK_STR_DA_Cape,
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
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Spinning Attack"].MaxTp = set_combine(sets.precast.WS["Spinning Attack"], {
  })
  sets.precast.WS["Spinning Attack"].LowAcc = set_combine(sets.precast.WS["Spinning Attack"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Spinning Attack"].LowAccMaxTp = set_combine(sets.precast.WS["Spinning Attack"].LowAcc, {
  })
  sets.precast.WS["Spinning Attack"].MidAcc = set_combine(sets.precast.WS["Spinning Attack"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Spinning Attack"].MidAccMaxTp = set_combine(sets.precast.WS["Spinning Attack"].MidAcc, {
  })
  sets.precast.WS["Spinning Attack"].HighAcc = set_combine(sets.precast.WS["Spinning Attack"].MidAcc, {
    ammo="Falcon Eye",
  })
  sets.precast.WS["Spinning Attack"].HighAccMaxTp = set_combine(sets.precast.WS["Spinning Attack"].HighAcc, {
  })

  sets.MAB = {
    head="Highwing Helm", --20
    body=gear.Samnuha_body, --25
    hands=gear.Leyline_Gloves, --30
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
    ammo="Knobkierrie",
    ring2="Karieyh Ring",
    -- waist="Fotia Belt",
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
    neck="Bathy Choker +1",
    ear1="Infused Earring",
  }
  sets.latent_refresh = {
    legs="Rawhide Trousers",
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  sets.idle = {
    ammo="Ginsen",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_DEX_DA_Cape,
    waist="Moonbow Belt +1",
  }

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

  sets.DT = {
    ammo="Staunch Tathlum",
    neck="Twilight Necklace",
    ear2="Odnowa Earring +1",
    ring1=gear.Dark_Ring,
    ring2="Defending Ring",
    waist="Moonbow Belt +1",
  }

  sets.idle.DT = set_combine(sets.idle, sets.DT)
  sets.idle.DT.Regain = set_combine(sets.idle.Regain, sets.DT)
  sets.idle.DT.Regen = set_combine(sets.idle.Regen, sets.DT)
  sets.idle.DT.Refresh = set_combine(sets.idle.Refresh, sets.DT)
  sets.idle.DT.RefreshSub50 = set_combine(sets.idle.RefreshSub50, sets.DT)
  sets.idle.DT.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.DT)
  sets.idle.DT.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.DT)
  sets.idle.DT.Regain.RefreshSub50 = set_combine(sets.idle.Regain.RefreshSub50, sets.DT)
  sets.idle.DT.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.DT)
  sets.idle.DT.Regen.RefreshSub50 = set_combine(sets.idle.Regen.RefreshSub50, sets.DT)
  sets.idle.DT.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.DT)
  sets.idle.DT.Regain.Regen.RefreshSub50 = set_combine(sets.idle.Regain.Regen.RefreshSub50, sets.DT)

  sets.idle.Weak = sets.idle.DT

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
    legs=gear.Samnuha_legs,
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_DEX_DA_Cape,
    waist="Moonbow Belt +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Falcon Eye",
    ear2="Cessance Earring",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    head=gear.Dampening_Tam,
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    feet="Anchorite's Gaiters +2",
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

  sets.SuperDef = set_combine(sets.Hybrid, {
    head="Mummu Bonnet +2",
    hands="Volte Bracers",
    legs="Mummu Kecks +1",
    feet="Mummu gamashes +1",
    ring1=gear.Dark_Ring,
  })

  sets.defense.PDT = set_combine(sets.Hybrid, {
    hands="Volte Bracers",
    legs="Mummu Kecks +1",
    feet="Mummu gamashes +1",
    ring1=gear.Dark_Ring,
  })

  sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)

  sets.engaged.SuperDef = set_combine(sets.engaged, sets.SuperDef)
  sets.engaged.LowAcc.SuperDef = set_combine(sets.engaged.LowAcc, sets.SuperDef)
  sets.engaged.MidAcc.SuperDef = set_combine(sets.engaged.MidAcc, sets.SuperDef)
  sets.engaged.HighAcc.SuperDef = set_combine(sets.engaged.HighAcc, sets.SuperDef)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  
  -- Hundred Fists/Impetus/Counterstance melee set mods
  sets.engaged.HF = set_combine(sets.engaged)
  sets.engaged.Impetus = set_combine(sets.engaged, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.Counterstance = set_combine(sets.engaged, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HF.Impetus = set_combine(sets.engaged.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.Impetus.Counterstance = set_combine(sets.engaged.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.HF = set_combine(sets.engaged.LowAcc)
  sets.engaged.LowAcc.Impetus = set_combine(sets.engaged.LowAcc, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.Counterstance = set_combine(sets.engaged.LowAcc, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.HF.Impetus = set_combine(sets.engaged.LowAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.HF.Counterstance = set_combine(sets.engaged.LowAcc.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.Impetus.Counterstance = set_combine(sets.engaged.LowAcc.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.HF = set_combine(sets.engaged.MidAcc)
  sets.engaged.MidAcc.Impetus = set_combine(sets.engaged.MidAcc, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.Counterstance = set_combine(sets.engaged.MidAcc, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.HF.Impetus = set_combine(sets.engaged.MidAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.HF.Counterstance = set_combine(sets.engaged.MidAcc.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.Impetus.Counterstance = set_combine(sets.engaged.MidAcc.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.HF = set_combine(sets.engaged.HighAcc)
  sets.engaged.HighAcc.Impetus = set_combine(sets.engaged.HighAcc, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.Counterstance = set_combine(sets.engaged.HighAcc, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.HF.Impetus = set_combine(sets.engaged.HighAcc.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.HF.Counterstance = set_combine(sets.engaged.HighAcc.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.Impetus.Counterstance = set_combine(sets.engaged.HighAcc.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.SuperDef.HF = set_combine(sets.engaged.SuperDef)
  sets.engaged.SuperDef.Impetus = set_combine(sets.engaged.SuperDef, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.SuperDef.Counterstance = set_combine(sets.engaged.SuperDef, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.SuperDef.HF.Impetus = set_combine(sets.engaged.SuperDef.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.SuperDef.HF.Counterstance = set_combine(sets.engaged.SuperDef.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.SuperDef.Impetus.Counterstance = set_combine(sets.engaged.SuperDef.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.SuperDef = set_combine(sets.engaged.LowAcc, sets.engaged.SuperDef)
  sets.engaged.LowAcc.SuperDef.HF = set_combine(sets.engaged.LowAcc.SuperDef, {})
  sets.engaged.LowAcc.SuperDef.Impetus = set_combine(sets.engaged.LowAcc.SuperDef, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.SuperDef.Counterstance = set_combine(sets.engaged.LowAcc.SuperDef, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.SuperDef.HF.Impetus = set_combine(sets.engaged.LowAcc.SuperDef.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.LowAcc.SuperDef.HF.Counterstance = set_combine(sets.engaged.LowAcc.SuperDef.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.LowAcc.SuperDef.Impetus.Counterstance = set_combine(sets.engaged.LowAcc.SuperDef.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.SuperDef = set_combine(sets.engaged.MidAcc, sets.engaged.SuperDef)
  sets.engaged.MidAcc.SuperDef.HF = set_combine(sets.engaged.MidAcc.SuperDef, {})
  sets.engaged.MidAcc.SuperDef.Impetus = set_combine(sets.engaged.MidAcc.SuperDef, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.SuperDef.Counterstance = set_combine(sets.engaged.MidAcc.SuperDef, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.SuperDef.HF.Impetus = set_combine(sets.engaged.MidAcc.SuperDef.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.MidAcc.SuperDef.HF.Counterstance = set_combine(sets.engaged.MidAcc.SuperDef.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.MidAcc.SuperDef.Impetus.Counterstance = set_combine(sets.engaged.MidAcc.SuperDef.Impetus, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.SuperDef = set_combine(sets.engaged.HighAcc, sets.engaged.SuperDef)
  sets.engaged.HighAcc.SuperDef.HF = set_combine(sets.engaged.HighAcc.SuperDef, {})
  sets.engaged.HighAcc.SuperDef.Impetus = set_combine(sets.engaged.HighAcc.SuperDef, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.SuperDef.Counterstance = set_combine(sets.engaged.HighAcc.SuperDef, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.SuperDef.HF.Impetus = set_combine(sets.engaged.HighAcc.SuperDef.HF, {
    body="Bhikku Cyclas +1",
  })
  sets.engaged.HighAcc.SuperDef.HF.Counterstance = set_combine(sets.engaged.HighAcc.SuperDef.HF, {
    feet="Hesychast's Gaiters +3",
  })
  sets.engaged.HighAcc.SuperDef.Impetus.Counterstance = set_combine(sets.engaged.HighAcc.SuperDef.Impetus, {
    feet="Hesychast's Gaiters +3",
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
  sets.Kiting = {
    feet="Hermes' Sandals",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back="Mecistopins Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
  sets.TreasureHunter = {
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
    -- head=gear.Herc_TH_head, --2
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
  end
end

function job_aftercast(spell, action, spellMap, eventArgs)
  -- if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
  --   send_command('cancel Footwork')
  -- end
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
    if (buff == "Counterstance" and gain) or buffactive.counterstance then
      classes.CustomMeleeGroups:append('Counterstance')
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
  update_weapons()
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

  local ws_msg = state.WeaponskillMode.value

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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  update_weaponskill_binds()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current ~= 'DT' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
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
  if buffactive.counterstance then
    classes.CustomMeleeGroups:append('Counterstance')
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

