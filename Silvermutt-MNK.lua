-- Original: Motenten / Modified: Arislan

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
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)

    lockstyleset = 5

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
  state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.WeaponskillMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'DT', 'Counter')
  state.IdleMode:options('Normal', 'DT')

  state.CP = M(false, "Capacity Points Mode")

  -- Additional local binds
  include('Global-Binds.lua') -- OK to remove this line

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

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

  send_command('bind ^numpad7 input /ws "Victory Smite" <t>')
  send_command('bind ^numpad8 input /ws "Ascetic\'s Fury" <t>')
  send_command('bind ^numpad4 input /ws "Asuran Fists" <t>')
  send_command('bind ^numpad1 input /ws "Spinning Attack" <t>')
  send_command('bind ^numpad2 input /ws "Shoulder Tackle" <t>')

  send_command('bind numpad0 input /ja "Boost" <t>')

  update_combat_form()
  update_melee_groups()

  select_default_macro_book()
  set_lockstyle()
end

function user_unload()
  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad7')
  send_command('unbind ^numpad8')
  send_command('unbind ^numpad5')
  send_command('unbind ^numpad1')
  send_command('unbind ^numpad2')
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
    -- ammo="Sapience Orb", --2
    -- head=gear.Herc_MAB_head, --7
    body=gear.Taeon_FC_body, --9
    hands="Leyline Gloves", --8
    legs="Rawhide Trousers", --5
    -- feet=gear.Herc_MAB_feet, --2
    -- neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    -- ear2="Enchntr. Earring +1", --2
    -- ring1="Weather. Ring +1", --6(4)
    -- ring2="Kishar Ring", --4
    }
  
  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {
    legs="Hesychast's Hose",
  }
  sets.precast.JA['Boost'] = {
    hands="Anchorite's Gloves",
  }
  sets.precast.JA['Dodge'] = {
    -- feet="Anchorite's Gaiters +1",
  }
  sets.precast.JA['Focus'] = {
    -- head="Anchorite's Crown +1",
  }
  sets.precast.JA['Counterstance'] = {
    -- feet="Hesychast's Gaiters +1",
  }
  sets.precast.JA['Footwork'] = {
    -- feet="Tantra Gaiters +2",
  }
  sets.precast.JA['Formless Strikes'] = {
    body="Hesychast's Cyclas",
  }
  sets.precast.JA['Mantra'] = {
    -- feet="Hesychast's Gaiters +1",
  }

  sets.precast.JA['Chi Blast'] = {
    head="Melee Crown +1",
    hands="Adhemar wristbands +1",
    -- head="Melee Crown +2",
    -- body="Otronif Harness +1",
    -- hands="Adhemar wristbands +1",
    -- back="Tuilha Cape",
    -- legs="Hesychast's Hose +1",
    -- feet="Anchorite's Gaiters +1",
  }

  sets.precast.JA['Chakra'] = {
    -- ammo="Iron Gobbet",
    -- head="Kendatsuba jinpachi +1",
    -- body="Anchorite's Cyclas +1",
    -- hands="Hesychast's Gloves +1",
    -- ring1="Spiral Ring",
    -- back="Iximulew Cape",
    -- waist="Caudata Belt",
    -- legs="Kendatsuba hakama +1",
    -- feet="Thurandaut Boots +1",
  }

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    -- ammo="Sonia's Plectrum",
    -- head="Kendatsuba jinpachi +1",
    -- body="Otronif Harness +1",
    -- hands="Hesychast's Gloves +1",
    -- ring1="Spiral Ring",
    -- back="Iximulew Cape",
    -- waist="Caudata Belt",
    -- legs="Kendatsuba hakama +1",
    -- feet="Otronif Boots +1",
  }
      
  sets.precast.Step = {
    -- waist="Chaac Belt",
  }
  sets.precast.Flourish1 = {
    -- waist="Chaac Belt",
  }

  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    -- ammo="Knobkierrie",
    -- head=gear.Adhemar_B_head,
    -- body=gear.Herc_WS_body,
    -- hands=gear.Adhemar_B_hands,
    -- legs="Samnuha Tights",
    -- feet=gear.Herc_TA_feet,
    -- neck="Fotia Gorget",
    -- ear1="Moonshade Earring",
    -- ear2="Ishvara Earring",
    -- ring1="Gere Ring",
    -- ring2="Epaminondas's Ring",
    -- back="Relucent Cape",
    -- waist="Fotia Belt",
    } -- default set
  sets.precast.WSAcc = {
    -- ammo="Honed Tathlum",
    -- body="Manibozho Jerkin",
    -- back="Letalis Mantle",
    -- feet="Qaaxo Leggings",
  }
  sets.precast.MaxTP = {
    -- ear1="Bladeborn Earring",
    -- ear2="Steelflash Earring",
  }
  sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)

  -- Specific weaponskill sets.
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    -- legs="Manibozho Brais",
    -- feet="Daihanshi Habaki",
  })
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    -- ear1="Bladeborn Earring",
    -- ear2="Moonshade Earring",
    -- ring2="Spiral Ring",
    -- back="Buquwik Cape",
  })
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    -- ammo="Tantra Tathlum",
    -- ring1="Spiral Ring",
    -- back="Buquwik Cape",
    -- feet="Qaaxo Leggings",
  })
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    -- neck="Rancor Collar",
    -- back="Buquwik Cape",
    -- feet="Qaaxo Leggings",
  })
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    -- ear1="Bladeborn Earring",
    -- ear2="Steelflash Earring",
    -- legs="Manibozho Brais",
    -- feet="Daihanshi Habaki",
  })
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
    -- feet="Daihanshi Habaki",
  })
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
    -- ammo="Tantra Tathlum",
    -- ring1="Spiral Ring",
  })
  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
    -- head="Kendatsuba jinpachi +1",
    -- ear1="Bladeborn Earring",
    -- ear2="Steelflash Earring",
  })

  sets.precast.WS["Raging Fists"].LowAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
  sets.precast.WS["Howling Fist"].LowAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
  sets.precast.WS["Asuran Fists"].LowAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
  sets.precast.WS["Ascetic's Fury"].LowAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
  sets.precast.WS["Victory Smite"].LowAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
  sets.precast.WS["Shijin Spiral"].LowAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
  sets.precast.WS["Dragon Kick"].LowAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
  sets.precast.WS["Tornado Kick"].LowAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

  sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
  sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
  sets.precast.WS["Asuran Fists"].MidAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
  sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
  sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
  sets.precast.WS["Shijin Spiral"].MidAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
  sets.precast.WS["Dragon Kick"].MidAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
  sets.precast.WS["Tornado Kick"].MidAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

  sets.precast.WS["Raging Fists"].HighAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
  sets.precast.WS["Howling Fist"].HighAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
  sets.precast.WS["Asuran Fists"].HighAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
  sets.precast.WS["Ascetic's Fury"].HighAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
  sets.precast.WS["Victory Smite"].HighAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
  sets.precast.WS["Shijin Spiral"].HighAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
  sets.precast.WS["Dragon Kick"].HighAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
  sets.precast.WS["Tornado Kick"].HighAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

  sets.precast.WS['Cataclysm'] = {
    -- head="Wayfarer Circlet",
    -- neck="Stoicheion Medal",
    -- ear1="Friomisi Earring",
    -- ear2="Hecate's Earring",
    -- body="Wayfarer Robe",
    -- hands="Otronif Gloves",
    -- ring1="Acumen Ring",
    -- ring2="Demon's Ring",
    -- back="Toro Cape",
    -- waist="Thunder Belt",
    -- legs="Nahtirah Trousers",
    -- feet="Qaaxo Leggings",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.idle = {
    ammo="Ginsen",
    head=gear.Adhemar_B_head,
    body="Bhikku Cyclas",
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet="Hermes' Sandals",
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_TP_Cape,
    waist="Black Belt",
    -- ammo="Seki Shuriken",
    -- head="Volte Cap",
    -- body="Hiza. Haramaki +2",
    -- hands=gear.Herc_DT_hands,
    -- legs="Samnuha Tights",
    -- feet="Herald's Gaiters",
    -- neck="Bathy Choker +1",
    -- ear1="Eabani Earring",
    -- ear2="Sanare Earring",
    -- ring1={name="Chirich Ring +1", bag="wardrobe3"},
    -- ring2={name="Chirich Ring +1", bag="wardrobe4"},
    -- back="Moonlight Cape",
    -- waist="Flume Belt +1",
  }

  sets.idle.DT = set_combine(sets.idle, {
    ring1="Defending Ring",
  })

  sets.idle.Weak = sets.idle.DT

  sets.idle.Town = sets.idle

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
    body="Bhikku Cyclas",
    hands=gear.Adhemar_B_hands,
    legs="Samnuha Tights",
    feet=gear.Herc_Temp_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.MNK_TP_Cape,
    waist="Black Belt",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Falcon Eye",
    ear2="Cessance Earring",
    -- ammo="Hasty Pinion +1",
    -- head="Ademar bonnet",
    -- neck="Lissome necklace",
    -- ear1="Mache earring +1",
    -- ear2="Cessance earring",
    -- body="Kendatsuba samue +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Epona's Ring",
    -- back="Segomo's Mantle",
    -- waist="Moonbow belt +1",
    -- legs="Kendatsuba hakama +1",
    -- feet="Kendatsuba sune-ate +1",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    -- ammo="Hasty Pinion +1",
    -- head="Ademar bonnet",
    -- neck="Lissome necklace",
    -- ear1="Mache earring +1",
    -- ear2="Cessance earring",
    -- body="Kendatsuba samue +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Epona's Ring",
    -- back="Segomo's Mantle",
    -- waist="Moonbow belt +1",
    -- legs="Kendatsuba hakama +1",
    -- feet="Kendatsuba sune-ate +1",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- ammo="Hasty Pinion +1",
    -- head="Ademar bonnet",
    -- neck="Lissome necklace",
    -- ear1="Mache earring +1",
    -- ear2="Cessance earring",
    -- body="Kendatsuba samue +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Epona's Ring",
    -- back="Segomo's Mantle",
    -- waist="Moonbow belt +1",
    -- legs="Kendatsuba hakama +1",
    -- feet="Kendatsuba sune-ate +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.DT = {
    -- ammo="Thew Bomblet",
    -- head="Uk'uxkaj Cap",
    -- neck="Lissome necklace",
    -- ear1="Bladeborn Earring",
    -- ear2="Cessance earring",
    -- body="Otronif Harness +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Patricius Ring",
    -- ring2="Epona's Ring",
    -- back="Iximulew Cape",
    -- waist="Windbuffet Belt",
    -- legs="Hesychast's Hose +1",
    -- feet="Otronif Boots +1",
  }

  sets.engaged.Counter = {
    -- feet="Melee Gaiters +2",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------
  
  sets.Kiting = {
    feet="Hermes' Sandals",
  }

  -- Hundred Fists/Impetus melee set mods
  sets.engaged.Impetus = set_combine(sets.engaged, {
    body="Bhikku Cyclas",
  })
  sets.engaged.HF = set_combine(sets.engaged)
  sets.engaged.HF.Impetus = set_combine(sets.engaged.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.LowAcc.HF = set_combine(sets.engaged.LowAcc)
  sets.engaged.LowAcc.HF.Impetus = set_combine(sets.engaged.LowAcc.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.MidAcc.HF = set_combine(sets.engaged.MidAcc)
  sets.engaged.MidAcc.HF.Impetus = set_combine(sets.engaged.MidAcc.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.HighAcc.HF = set_combine(sets.engaged.HighAcc)
  sets.engaged.HighAcc.HF.Impetus = set_combine(sets.engaged.HighAcc.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
  sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.LowAcc.Counter = set_combine(sets.engaged.LowAcc, sets.engaged.Counter)
  sets.engaged.LowAcc.Counter.HF = set_combine(sets.engaged.LowAcc.Counter, {})
  sets.engaged.LowAcc.Counter.HF.Impetus = set_combine(sets.engaged.LowAcc.Counter.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.MidAcc.Counter = set_combine(sets.engaged.MidAcc, sets.engaged.Counter)
  sets.engaged.MidAcc.Counter.HF = set_combine(sets.engaged.MidAcc.Counter, {})
  sets.engaged.MidAcc.Counter.HF.Impetus = set_combine(sets.engaged.MidAcc.Counter.HF, {
    body="Bhikku Cyclas",
  })
  sets.engaged.HighAcc.Counter = set_combine(sets.engaged.HighAcc, sets.engaged.Counter)
  sets.engaged.HighAcc.Counter.HF = set_combine(sets.engaged.HighAcc.Counter, {})
  sets.engaged.HighAcc.Counter.HF.Impetus = set_combine(sets.engaged.HighAcc.Counter.HF, {
    body="Bhikku Cyclas",
  })

  -- Footwork combat form
  sets.engaged.Footwork = {
    -- ammo="Thew Bomblet",
    -- head="Kendatsuba jinpachi +1",
    -- neck="Monk's nodowa +1",
    -- ear1="Mache earring +1",
    -- ear2="Cessance earring",
    -- body="Kendatsuba samue +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Epona's Ring",
    -- back="Segomo's Mantle",
    -- waist="Moonbow belt +1",
    -- legs="Hesychast's Hose +1",
    -- feet="Anchorite's Gaiters +1",
  }
  sets.engaged.Footwork.Acc = {
    -- ammo="Honed Tathlum",
    -- head="Whirlpool Mask",
    -- neck="Monk's nodowa +1",
    -- ear1="Mache earring +1",
    -- ear2="Cessance earring",
    -- body="Kendatsuba samue +1",
    -- hands="Adhemar wristbands +1",
    -- ring1="Niqmaddu Ring",
    -- ring2="Epona's Ring",
    -- back="Segomo's Mantle",
    -- waist="Moonbow belt +1",
    -- legs="Hesychast's Hose +1",
    -- feet="Anchorite's Gaiters +1",
  }
      
  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.impetus_body = {
    -- body="Bhikku Cyclas"
  }
  sets.footwork_kick_feet = {
    -- feet="Anchorite's Gaiters +1"
  }
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring1="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.CP = {
    back="Aptitude Mantle",
  }
  sets.TreasureHunter = {
    -- head="Volte Cap",
    -- waist="Chaac Belt",
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
      disable('neck', 'ring1','waist')
    else
      if player.hpp > 0 then
        send_command('@input /p Doom Removed.')
      end
      enable('neck', 'ring1','waist')
      handle_equipping_gear(player.status)
    end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
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
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
  update_combat_form()
  update_melee_groups()
  handle_equipping_gear(player.status)
  th_update(cmdParams, eventArgs)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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
  if state.TreasureMode.value == 'Fulltime' then
      meleeSet = set_combine(meleeSet, sets.TreasureHunter)
  end

  return meleeSet
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

