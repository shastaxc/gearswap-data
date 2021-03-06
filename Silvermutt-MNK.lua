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
--              [ WIN+W ]           Toggle Rearming Lock
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
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs org')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c weaponset current')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(5)
  silibs.enable_premade_commands()
  silibs.enable_th()

  elemental_ws = S{'Cataclysm'}

  state.Buff.Footwork = buffactive.Footwork or false
  state.Buff.Impetus = buffactive.Impetus or false

  info.impetus_hit_count = 0 -- Do not modify
  info.boost_temp_lock = false -- Do not modify
  windower.raw_register_event('action', on_action_for_impetus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef')
  state.IdleMode:options('Normal', 'LightDef')

  state.CP = M(false, "Capacity Points Mode")
  state.ToyWeapons = M{['description']='Toy Weapons','None',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Verethragna', 'Piercing', 'Slashing', 'Cleaving'}

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

  send_command('bind !q input /ja "Impetus" <me>')
  send_command('bind !` input /ja "Chakra" <me>')
  send_command('bind ^numpad+ input /ja "Boost" <me>')
  send_command('bind !e input /ja "Footwork" <me>')
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

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind !q')
  send_command('unbind !`')
  send_command('unbind !e')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad+')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  -- Enmity sets
  sets.Enmity = {
    head="Halitus Helm", --0/0, 43 [88] <8>
    body="Emet Harness +1", --6/0, 64 [61] <10>
    hands="Kurys Gloves", --2/2, 57 [25] <9>
    neck="Unmoving Collar +1", --_/_, __ [200] <10>
    ear1="Friomisi Earring", --0/0, 0 [0] <2>
    ear2="Cryptic Earring", --0/0, 0 [40] <4>
    ring1="Eihwaz Ring", --0/0, 0 [70] <5>
    ring2={name="Supershear Ring", priority=1}, --0/0, 0 [30] <5>
    waist={name="Kasiri Belt", priority=1}, --0/0, 0 [30] <3>
    -- feet="Ahosi Leggings", --4/0, 107 [18] <7>
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Weatherspoon Ring", --5
  }

  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {
    legs="Hesychast's Hose +3",
  }
  sets.precast.JA['Boost'] = {
    hands="Anchorite's Gloves +1",
    waist="Ask Sash",
  }
  sets.precast.JA['Boost'].Risky = {
    head="Gnadbhod's Helm",
    body=empty,
    hands=empty,
    legs=empty,
    feet="Mahant Sandals",
    neck="Justiciar's Torque",
    ring1="Sljor ring",
    waist="Ask Sash",
  }
  sets.precast.JA['Perfect Counter'] = {
    hands="Tantra Crown +1",
  }
  sets.precast.JA['Dodge'] = {
    feet="Anchorite's Gaiters +3",
  }
  sets.precast.JA['Focus'] = {
    head="Anchorite's Crown +1",
  }
  sets.precast.JA['Counterstance'] = {
    feet="Hesychast's Gaiters +3",
  }
  sets.precast.JA['Footwork'] = {
    feet="Bhikku Gaiters +1",
  }
  sets.precast.JA['Formless Strikes'] = {
    body="Hesychast's Cyclas +2",
  }
  sets.precast.JA['Mantra'] = {
    feet="Hesychast's Gaiters +3",
  }

  sets.precast.JA['Chi Blast'] = {
    head="Hesychast's Crown +1", -- 15, Enhance Penance
  } -- MND

  sets.precast.JA['Chakra'] = {
    body="Anchorite's Cyclas +2", -- Enhances Chakra
    hands="Hesychast's Gloves", -- Enhances Chakra
    ear2="Odnowa Earring +1",
    ring1="Gelatinous Ring +1",
    ring2="Defending Ring",
    -- body="Anchorite's Cyclas +3", -- Enhances Chakra
    -- hands="Hesychast's Gloves +3", -- Enhances Chakra
  } -- VIT

  sets.precast.JA['Provoke'] = sets.Enmity

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
  }

  sets.precast.Step = {
  }
  sets.precast.Flourish1 = {
  }

  sets.precast['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    ring1="Prolix Ring",
    ring2="Defending Ring",
  })
  sets.precast['Utsusemi: Ni'] = set_combine(sets.precast.FC, {
    ring2="Defending Ring",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    neck="Loricate Torque +1", --5
    waist="Audumbla Sash", --10
  }

  sets.midcast['Utsusemi: Ichi'] = set_combine(sets.precast['Utsusemi: Ichi'], sets.midcast.SpellInterrupt)
  sets.midcast['Utsusemi: Ni'] = set_combine(sets.precast['Utsusemi: Ni'], sets.midcast.SpellInterrupt)


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Kendatsuba Samue +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body="Tatenashi Haramaki +1",
  } -- Base WS set

  -- Victory Smite: 80% STR, 1.5 fTP, 4 hit, can crit
  -- crit dmg > TP Bonus = crit rate > multihit
  -- 1000 TP bonus = ~15% crit rate
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
    -- feet=gear.Herc_STR_CritDmg_feet,
  })
  sets.precast.WS["Victory Smite"].MaxTP = set_combine(sets.precast.WS["Victory Smite"], {
  })
  sets.precast.WS["Victory Smite"].LowAcc = set_combine(sets.precast.WS["Victory Smite"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Victory Smite"].LowAccMaxTP = set_combine(sets.precast.WS["Victory Smite"].LowAcc, {
  })
  sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS["Victory Smite"].LowAcc, {
    ammo="Falcon Eye",
  })
  sets.precast.WS["Victory Smite"].MidAccMaxTP = set_combine(sets.precast.WS["Victory Smite"].MidAcc, {
  })
  sets.precast.WS["Victory Smite"].HighAcc = set_combine(sets.precast.WS["Victory Smite"].MidAcc, {
    head="Kendatsuba Jinpachi +1",
    feet="Kendatsuba Sune-Ate +1",
  })
  sets.precast.WS["Victory Smite"].HighAccMaxTP = set_combine(sets.precast.WS["Victory Smite"].HighAcc, {
  })

  -- Shijin Spiral: 100% DEX, 1.5 fTP, 5 hit
  -- DEX > multihit > WSD
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head="Kendatsuba Jinpachi +1",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_DEX_DA_Cape,
    waist="Moonbow Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS["Shijin Spiral"].MaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {
  })
  sets.precast.WS["Shijin Spiral"].LowAcc = set_combine(sets.precast.WS["Shijin Spiral"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Shijin Spiral"].LowAccMaxTP = set_combine(sets.precast.WS["Shijin Spiral"].LowAcc, {
  })
  sets.precast.WS["Shijin Spiral"].MidAcc = set_combine(sets.precast.WS["Shijin Spiral"].LowAcc, {
    ammo="Falcon Eye",
    ear2="Telos Earring",
  })
  sets.precast.WS["Shijin Spiral"].MidAccMaxTP = set_combine(sets.precast.WS["Shijin Spiral"].MidAcc, {
  })
  sets.precast.WS["Shijin Spiral"].HighAcc = set_combine(sets.precast.WS["Shijin Spiral"].MidAcc, {
    hands=gear.Ryuo_A_hands,
    feet="Mummu Gamashes +2",
  })
  sets.precast.WS["Shijin Spiral"].HighAccMaxTP = set_combine(sets.precast.WS["Shijin Spiral"].HighAcc, {
  })

  -- Asuran Fists: 20% STR / 20% VIT, 1.25 fTP, 8 hit
  -- WSD > STR/VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Mpaca's Hose", -- Maybe replace, crit and multihit useless
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Ishvara Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,  -- WSD cape would be better
    waist="Moonbow Belt +1",
    -- head="Hesychast's Crown +3",
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {
  })
  sets.precast.WS["Asuran Fists"].LowAcc = set_combine(sets.precast.WS["Asuran Fists"], {
  })
  sets.precast.WS["Asuran Fists"].LowAccMaxTP = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
  })
  sets.precast.WS["Asuran Fists"].MidAcc = set_combine(sets.precast.WS["Asuran Fists"].LowAcc, {
    hands=gear.Ryuo_A_hands,
  })
  sets.precast.WS["Asuran Fists"].MidAccMaxTP = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
  })
  sets.precast.WS["Asuran Fists"].HighAcc = set_combine(sets.precast.WS["Asuran Fists"].MidAcc, {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
  })
  sets.precast.WS["Asuran Fists"].HighAccMaxTP = set_combine(sets.precast.WS["Asuran Fists"].HighAcc, {
  })

  -- Ascetic's Fury: 50% STR / 50% VIT, 1.0 fTP (2.0 w/ offhand), 1 hit (2 w/ offhand), can crit
  -- Cannot crit normally - only TP bonus can increase crit rate
  -- TP Bonus > crit dmg > multihit > WSD
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
    -- feet=gear.Herc_STR_CritDmg_feet,
  })
  sets.precast.WS["Ascetic's Fury"].MaxTP = set_combine(sets.precast.WS["Ascetic's Fury"], {
    head=gear.Adhemar_B_head,
    ear2="Brutal Earring",
  })
  sets.precast.WS["Ascetic's Fury"].LowAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
  })
  sets.precast.WS["Ascetic's Fury"].LowAccMaxTP = set_combine(sets.precast.WS["Ascetic's Fury"].LowAcc, {
    head=gear.Adhemar_B_head,
    ear2="Brutal Earring",
  })
  sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS["Ascetic's Fury"].LowAcc, {
  })
  sets.precast.WS["Ascetic's Fury"].MidAccMaxTP = set_combine(sets.precast.WS["Ascetic's Fury"].MidAcc, {
    head=gear.Adhemar_B_head,
    ear2="Brutal Earring",
    -- head=gear.Adhemar_A_head,
  })
  sets.precast.WS["Ascetic's Fury"].HighAcc = set_combine(sets.precast.WS["Ascetic's Fury"].MidAcc, {
  })
  sets.precast.WS["Ascetic's Fury"].HighAccMaxTP = set_combine(sets.precast.WS["Ascetic's Fury"].HighAcc, {
    head=gear.Adhemar_B_head,
    ear2="Telos Earring",
    -- head=gear.Adhemar_A_head,
  })

  -- Raging Fists: 30% STR / 30% DEX, 1.0-3.75 fTP, 5 hit
  -- TP Bonus > WSD > Multihit (assuming always used with high TP)
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body=gear.Nyame_B_body, -- R10
    -- hands="Anchorite's Gloves +3",
    -- feet=gear.Nyame_B_feet, -- R15
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Ishvara Earring",
    -- head="Hesychast's Crown +3",
  })
  sets.precast.WS["Raging Fists"].LowAcc = set_combine(sets.precast.WS["Raging Fists"], {

  })
  sets.precast.WS["Raging Fists"].LowAccMaxTP = set_combine(sets.precast.WS["Raging Fists"].LowAcc, {
    ear2="Ishvara Earring",
    -- head="Hesychast's Crown +3",
  })
  sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS["Raging Fists"].LowAcc, {

  })
  sets.precast.WS["Raging Fists"].MidAccMaxTP = set_combine(sets.precast.WS["Raging Fists"].MidAcc, {
    ear2="Ishvara Earring",
    -- head="Hesychast's Crown +3",
  })
  sets.precast.WS["Raging Fists"].HighAcc = set_combine(sets.precast.WS["Raging Fists"].MidAcc, {

  })
  sets.precast.WS["Raging Fists"].HighAccMaxTP = set_combine(sets.precast.WS["Raging Fists"].HighAcc, {
    ear2="Ishvara Earring",
    -- head="Hesychast's Crown +3",
  })

  -- Howling Fist: 50% VIT / 20% STR, 2.05-5.8 fTP, 2 hit
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Kendatsuba Samue +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body="Tatenashi Haramaki +1",
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    head=gear.Adhemar_B_head,
    ear2="Brutal Earring",
  })
  sets.precast.WS["Howling Fist"].LowAcc = set_combine(sets.precast.WS["Howling Fist"], {
  })
  sets.precast.WS["Howling Fist"].LowAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    ear2="Brutal Earring",
  })
  sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Howling Fist"].MidAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    ear2="Telos Earring",
  })
  sets.precast.WS["Howling Fist"].HighAcc = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    ammo="Falcon Eye",
  })
  sets.precast.WS["Howling Fist"].HighAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].HighAcc, {
    ear2="Telos Earring",
  })

  -- Dragon Kick: 50% STR / 50% DEX, ?-5 fTP, 1 hit
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].LowAcc = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].LowAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].LowAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].MidAcc = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].MidAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].MidAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].HighAcc = set_combine(sets.precast.WS["Howling Fist"].HighAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].HighAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].HighAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })

  -- Tornado Kick: 40% STR / 40% VIT, 1.68-4.575 fTP, 3 hit
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].LowAcc = set_combine(sets.precast.WS["Howling Fist"].LowAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].LowAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].LowAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].MidAcc = set_combine(sets.precast.WS["Howling Fist"].MidAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].MidAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].MidAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].HighAcc = set_combine(sets.precast.WS["Howling Fist"].HighAcc, {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].HighAccMaxTP = set_combine(sets.precast.WS["Howling Fist"].HighAccMaxTP, {
    feet="Anchorite's Gaiters +3",
  })

  -- Spinning Attack: 100% STR, 1.0 fTP, 1 hit (aoe-physical)
  -- Multihit > WSD
  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
    -- body="Tatenashi Haramaki +1",
  })
  sets.precast.WS["Spinning Attack"].MaxTP = set_combine(sets.precast.WS["Spinning Attack"], {
  })
  sets.precast.WS["Spinning Attack"].LowAcc = set_combine(sets.precast.WS["Spinning Attack"], {
    neck="Fotia Gorget",
  })
  sets.precast.WS["Spinning Attack"].LowAccMaxTP = set_combine(sets.precast.WS["Spinning Attack"].LowAcc, {
  })
  sets.precast.WS["Spinning Attack"].MidAcc = set_combine(sets.precast.WS["Spinning Attack"].LowAcc, {
    head="Mpaca's Cap",
  })
  sets.precast.WS["Spinning Attack"].MidAccMaxTP = set_combine(sets.precast.WS["Spinning Attack"].MidAcc, {
  })
  sets.precast.WS["Spinning Attack"].HighAcc = set_combine(sets.precast.WS["Spinning Attack"].MidAcc, {
    head="Mpaca's Cap",
    ammo="Falcon Eye",
  })
  sets.precast.WS["Spinning Attack"].HighAccMaxTP = set_combine(sets.precast.WS["Spinning Attack"].HighAcc, {
  })

  sets.MAB = {
    ammo="Pemphredo Tathlum", --4
    head=gear.Nyame_B_head, --30
    body=gear.Nyame_B_body, --30
    hands=gear.Nyame_B_hands, --30
    legs=gear.Nyame_B_legs, --30
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Novio Earring", --7
    ring1="Shiva Ring +1", --3
    back="Argochampsa Mantle", --12
    waist="Eschan Stone", --7
    -- back=gear.MNK_MAB_Cape, --10
    -- waist="Skrymir Cord +1", --7
  }

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, sets.MAB, {
    head="Pixie Hairpin +1", -- 28 MAB
    ammo="Knobkierrie", -- 6 WSD
    ring2="Archon Ring", -- 5 MAB
  }) -- STR 30% / INT 30% + MAB

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    ammo="Staunch Tathlum +1",    --  3/ 3, ___
    head="Ken. Jinpachi +1",      -- __/__, 101
    body="Malignance Tabard",     --  9/ 9, 139
    hands="Malignance Gloves",    --  5/ 5, 112
    legs="Malignance Tights",     --  7/ 7, 150
    feet="Malignance Boots",      --  4/ 4, 150
    waist="Moonbow Belt +1",      --  6/ 6, ___

    -- Ideal:
    -- ammo="Staunch Tathlum +1",    --  3/ 3, ___
    -- head="Malignance Chapeau",    --  6/ 6, 123
    -- body="Malignance Tabard",     --  9/ 9, 139
    -- hands="Malignance Gloves",    --  5/ 5, 112
    -- legs="Hesychast's Host +3",   -- __/__,  84
    -- feet="Anchorite's Gaiters +3",-- __/__,  84
    -- back=gear.MNK_DEX_DA_Cape,    -- 10/__, ___; after changing to PDT aug
    -- waist="Moonbow Belt +1",      --  6/ 6, ___
    --39 PDT/29 MDT, 542 MEVA
  } --34 PDT/34 MDT, 652 MEVA

  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head=gear.Nyame_B_head,     --  7/ 7, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Monk's Nodowa +2",    -- __/__, ___
    ear1="Sherida Earring",     -- __/__, ___
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Defending Ring",     -- 10/10, ___
    ring2="Niqmaddu Ring",      -- __/__, ___
    back=gear.MNK_DEX_DA_Cape,  -- __/__, ___
    waist="Moonbow Belt +1",    --  6/ 6, ___
    -- head="Malignance Chapeau",  --  6/ 6, 123
  } --54 PDT/56 MDT, 674 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    body="Hiza. Haramaki +2",
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

  sets.idle.Weak = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Adhemar_B_hands,
    legs="Hesychast's Hose +3",
    feet="Anchorite's Gaiters +3",
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_DEX_DA_Cape,
    waist="Moonbow Belt +1",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Ginsen",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    head="Kendatsuba Jinpachi +1",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Falcon Eye",
    feet="Anchorite's Gaiters +3",
    ring1="Chirich Ring +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, sets.LightDef)
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, sets.LightDef)
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, sets.LightDef)
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, sets.LightDef)

  -----------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.Special = {}
  sets.Special.Impetus = {
    body="Bhikku Cyclas +1",
  }
  sets.Special.Impetus.Safe = {
    body="Bhikku Cyclas +1",
    ring1="Defending Ring",
  }
  sets.Special.Counterstance = {
    feet="Hesychast's Gaiters +3",
  }
  sets.Special.Footwork = {
    feet="Anchorite's Gaiters +3",
  }
  sets.Special.Footwork.Safe = {
    feet="Anchorite's Gaiters +3",
    ring1="Defending Ring", -- Remove when have malignance head
  }
  sets.Special.ImpetusAndFootwork = {
    body="Bhikku Cyclas +1",
    feet="Anchorite's Gaiters +3",
  }
  sets.Special.ImpetusAndFootwork.Safe = {
    head=gear.Nyame_B_head, -- Remove when have malignance head
    body="Bhikku Cyclas +1",
    feet="Anchorite's Gaiters +3",
    ring1="Defending Ring",
  }
  sets.Special.ElementalObi = { waist="Hachirin-no-Obi", }
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

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
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.BoostRegain = {
    waist="Ask Sash",
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Verethragna'] = {main="Verethragna"}
  sets.WeaponSet['Piercing'] = {main="Birdbanes"}
  sets.WeaponSet['Slashing'] = {main="Vampiric Claws"}
  sets.WeaponSet['Cleaving'] = {
    main="Reikikon",
    sub="Alber Strap"
    -- main="Xoanon",
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

  -- Don't gearswap for weaponskills when Defense is on.
  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    eventArgs.handled = true
  end
  if spell.english == 'Boost' then
    if buffactive.Warcry then
      windower.add_to_chat(167, 'Stopped due to conflicting buff: Warcry.')
      eventArgs.cancel = true -- Ensures gear doesn't swap
      return -- Ends function without finishing loop
    elseif not player.in_combat and state.DefenseMode.current == 'None' then
      equip(sets.precast.JA['Boost'].Risky)
      eventArgs.handled = true
    end
  end

  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if state.Buff.Impetus and state.DefenseMode.current == 'None' and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
      -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
      if (state.OffenseMode.current ~= 'MidAcc' and state.OffenseMode.current ~= 'HighAcc' and info.impetus_hit_count > 5)
          or (info.impetus_hit_count > 8) then
        equip(sets.Special.Impetus)
      end
    elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
      equip(sets.Special.Footwork)
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

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_midcast(spell, action, spellMap, eventArgs)
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

  -- Enable boost lock temporarily until buffactive can be detected
  if spell.english == 'Boost' and not spell.interrupted then
    info.boost_temp_lock = true
    coroutine.schedule(function()
        info.boost_temp_lock = false
    end, 3)
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
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
  -- Set Footwork as combat form any time it's active and Hundred Fists is not.
  if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
    state.CombatForm:set('Footwork')
  elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
    state.CombatForm:set('Footwork')
  else
    state.CombatForm:reset()
  end

  -- Hundred Fists and Impetus modify the custom melee groups
  if buff == "Hundred Fists" or buff == "Impetus" or buff == "Counterstance" then
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

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.SleepyHead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Hundred Fists" or buff == "Impetus" or buff == "Counterstance" or buff == "Footwork" or buff == "doom" or buff == "Boost" then
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
  if buffactive.Boost or info.boost_temp_lock then
    idleSet = set_combine(idleSet, sets.BoostRegain)
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
  if buffactive.Boost or info.boost_temp_lock then
    meleeSet = set_combine(meleeSet, sets.BoostRegain)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if state.DefenseMode.value == 'None' then
    if state.HybridMode.value == "Normal" then
      if buffactive.Impetus and buffactive.Footwork then
        -- Override sets to ensure impetus and footwork gear are equipped
        meleeSet = set_combine(meleeSet, sets.Special.ImpetusAndFootwork)
      elseif buffactive.Impetus then
        -- Override sets to ensure impetus body is equipped if Impetus is up
        meleeSet = set_combine(meleeSet, sets.Special.Impetus)
      elseif buffactive.Footwork then
        -- Override sets to ensure footwork feet are equipped if Footwork is up
        meleeSet = set_combine(meleeSet, sets.Special.Footwork)
      end
    elseif state.HybridMode.value == 'LightDef' then
      if buffactive.Impetus and buffactive.Footwork then
        -- Override set to ensure Impetus and Footwork gear equipped but also increase defense
        meleeSet = set_combine(meleeSet, sets.Special.ImpetusAndFootwork.Safe)
      elseif buffactive.Impetus then
        -- Override set to ensure Impetus gear equipped but also increase defense
        meleeSet = set_combine(meleeSet, sets.Special.Impetus.Safe)
      elseif buffactive.Footwork then
        -- Override set to ensure Footwork gear equipped but also increase defense
        meleeSet = set_combine(meleeSet, sets.Special.Footwork.Safe)
      end
    end
  end

  -- Override sets to ensure counterstance feet are equipped if Counterstance is up
  if buffactive.Counterstance then
    meleeSet = set_combine(meleeSet, sets.Special.Counterstance)
  end

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
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

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
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  if cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    end
  elseif cmdParams[1] == 'test' then
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

