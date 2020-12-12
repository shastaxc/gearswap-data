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
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+F ]           Toggle Closed Position (Facing) Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Weapon Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ CTRL+- ]          Primary step element cycle forward.
--              [ CTRL+= ]          Primary step element cycle backward.
--              [ ALT+- ]           Secondary step element cycle forward.
--              [ ALT+= ]           Secondary step element cycle backward.
--              [ CTRL+[ ]          Toggle step target type.
--              [ CTRL+] ]          Toggle use secondary step.
--              [ Numpad0 ]         Perform Current Step
--
--              [ CTRL+` ]          Saber Dance
--              [ ALT+` ]           Chocobo Jig II
--              [ ALT+[ ]           Contradance
--              [ CTRL+Numlock ]    Reverse Flourish
--              [ CTRL+Numpad/ ]    Berserk/Meditate
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki
--              [ CTRL+Numpad- ]    Aggressor/Third Eye
--              [ CTRL+Numpad+ ]    Climactic Flourish
--              [ CTRL+NumpadEnter ]Building Flourish
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ CTRL+Numpad0 ]    Utsusemi: Ichi
--              [ CTRL+Numpad. ]    Utsusemi: Ni
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c step                       Uses the currently configured step on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c step t                     Uses the currently configured step on the target, but forces use of <t>.
--
--  gs c cycle mainstep             Cycles through the available steps to use as the primary step when using
--                                  one of the above commands.
--  gs c cycle altstep              Cycles through the available steps to use for alternating with the
--                                  configured main step.
--  gs c toggle usealtstep          Toggles whether or not to use an alternate step.
--  gs c toggle selectsteptarget    Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')

  lockstyleset = 2
  USE_WEAPON_REARM = true

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false

  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
  state.UseAltStep = M(false, 'Use Alt Step')
  state.SelectStepTarget = M(false, 'Select Step Target')
  state.IgnoreTargetting = M(true, 'Ignore Targetting')

  state.ClosedPosition = M(false, 'Closed Position')

  state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
--  state.SkillchainPending = M(false, 'Skillchain Pending')

  state.CP = M(false, "Capacity Points Mode")

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'LightDef')
  state.IdleMode:options('Normal', 'LightDef')

  state.WeaponLock = M(false, 'Weapon Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle WeaponLock')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^- gs c cycleback mainstep')
  send_command('bind ^= gs c cycle mainstep')
  send_command('bind !- gs c cycleback altstep')
  send_command('bind != gs c cycle altstep')
  send_command('bind ^] gs c toggle usealtstep')
  send_command('bind ![ input /ja "Contradance" <me>')
  send_command('bind !q input /ja "Saber Dance" <me>')
  send_command('bind !` input /ja "Chocobo Jig II" <me>')
  send_command('bind @f gs c toggle ClosedPosition')
  send_command('bind ^numlock input /ja "Reverse Flourish" <me>')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numpad+ input /ja "Climactic Flourish" <me>')
  send_command('bind ^numpadenter input /ja "Building Flourish" <me>')
  send_command('bind numpad0 gs c step t')
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
  determine_haste_group()

  select_default_macro_book()
  set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind !-')
  send_command('unbind !=')
  send_command('unbind ^]')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ![')
  send_command('unbind !q')
  send_command('unbind !`')
  send_command('unbind ^,')
  send_command('unbind @f')
  send_command('unbind ^`')
  send_command('unbind @c')
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

  -- Enmity set
  sets.Enmity = {
    head="Halitus Helm", --8
    body="Emet Harness +1", --10
    hands="Horos Bangles", --6
    ear1="Cryptic Earring", --4
    ring1="Eihwaz Ring", --5
    ring2="Supershear Ring", --5
    waist="Kasiri Belt", --3
    -- ammo="Iron Gobbet", --2
    -- hands="Horos Bangles +3", --9
    -- feet="Ahosi Leggings", --7
    -- neck="Unmoving Collar +1", --10
    -- ear2="Trux Earring", --5
    -- back="Agema Cape", --5
  }

  sets.precast.JA['Provoke'] = sets.Enmity
  sets.precast.JA['No Foot Rise'] = {
    body="Horos Casaque +3",
  }
  sets.precast.JA['Trance'] = {
    head="Horos Tiara"
  }

  -- Waltz Potency/CHR
  sets.precast.Waltz = {
    ammo="Light Sachet",            -- __(_),  2 <__>
    head=gear.Anwig_Salade,         -- __(_),  4 <-2>
    body="Maxixi Casaque +2",       -- 17(7), 28 <-1>
    legs="Horos Tights +3",         -- __(_), 24 <__>
    feet="Charis Shoes +2",         -- __(_),  8 <__>
    waist="Aristo Belt",            -- __(_),  8 <__>
    ring1=gear.Dark_Ring,           -- __(_),  1 <__>
    feet="Maxixi Shoes +1",         -- 10(_), 30 <__>
    back="Toetapper Mantle",        --  5(_), __ <__>
    -- Ideal:
    -- ammo="Voluspa Tathlum",      -- __(_),  5 <__>
    -- head=gear.Anwig_Salade,      -- __(_),  4 <-2>
    -- body="Maxixi Casaque +3",    -- 19(8), 33 <-2>
    -- hands="Raetic Bangles +1",   -- __(_), 38 <__>
    -- legs="Dashing Subligar",     -- 10(_), 11 <__>; Gives Blink
    -- feet="Maxixi Toeshoes +3",   -- 14(_), 40 <__>
    -- neck="Etoile gorget +2",     -- 10(_), 25 <__>
    -- ear1="Enchntr. Earring +1",  -- __(_),  5 <__>
    -- ear2="Handler's Earring +1", -- __(_),  5 <__>
    -- ring1="Carb. Ring +1",       -- __(_),  9 <__>
    -- ring2="Carb. Ring +1",       -- __(_),  9 <__>
    -- back=gear.DNC_WTZ_Cape,      -- __(_), 30 <__>; Enmity-10
    -- waist="Aristo Belt",         -- __(_),  8 <__>
    -- 53 Potency (8 Self Potency), 217 CHR <-4 Delay>
  } -- 32 Potency (7 Self Potency), 105 CHR <-3 Delay>

  -- Waltz effects received
  sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
    head="Mummu Bonnet +2",         -- __(9), 17 <__>
    body="Maxixi Casaque +2",       -- 17(7), 28 <-1>
    -- body="Maxixi Casaque +3",    -- 19(8), 33 <-2>
    -- ring1="Asklepian Ring",      -- __(3), __ <__>
  })

  -- Waltz delay
  sets.precast.Waltz['Healing Waltz'] = {
    head=gear.Anwig_Salade, --2
    body="Maxixi Casaque +2", --1
    -- body="Maxixi Casaque +3", --2
  }
  sets.precast.Samba = {
    head="Maxixi Tiara +3",
    back=gear.DNC_TP_DW_Cape,
  }
  sets.precast.Jig = {
    legs="Horos Tights +3",
    feet="Maxixi Shoes +1",
    -- feet="Maxixi Shoes +3",
  }

  -- Acc
  sets.precast.Step = {
    ammo="Charis Feather",
    head="Maxixi Tiara +3",
    body="Maxixi Casaque +2",
    hands="Mummu Wrists +2",
    legs="Meghanada Chausses +2",
    feet="Horos Toe Shoes +3",
    neck="Love Torque",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    back=gear.DNC_TP_DW_Cape,

    -- Goal:
    -- ammo="Yamarang",
    -- head="Maxixi Tiara +3",
    -- body="Maxixi Casaque +3",
    -- hands="Maxixi Bangles +3",
    -- legs="Maxixi Tights +3",
    -- feet="Horos Toe Shoes +3",
    -- neck="Etoile Gorget +2",
    -- ear1="Mache Earring +1",
    -- ear2="Mache Earring +1",
    -- ring1="Regal Ring",
    -- ring2="Chirich Ring +1",
    -- waist="Olseni Belt",
    -- back=gear.DNC_TP_DW_Cape,
  }

  sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {
    feet="Charis Shoes +2",
    -- feet="Maculele Toe Shoes +1",
  })
  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

  -- Magic Accuracy
  sets.precast.Flourish1['Violent Flourish'] = {
    ammo="Charis Feather",
    head="Mummu Bonnet +2",
    body="Horos Casaque +3",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Love Torque",
    ear1="Digni. Earring",
    ring1="Weatherspoon Ring",
    ring2="Ayanmo Ring",
    waist="Eschan Stone",
    back=gear.DNC_TP_DW_Cape,
    -- ammo="Yamarang",
    -- head="Malignance Chapeau",
    -- neck="Etoile Gorget +2",
    -- ear2="Hermetic Earring",
    -- ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
  }

  -- Magic Accuracy
  sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {
    body="Malignance Tabard",
  })

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {
    hands="Charis Bangles +2",
    back="Toetapper Mantle",
    -- hands="Maculele Bangles +1",
  }
  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {
    body="Maculele Casaque +1"
  }
  sets.precast.Flourish3['Climactic Flourish'] = {
    head="Maculele Tiara",
    -- head="Maculele Tiara +1",
  }

  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head=gear.Herc_WSD_head, --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Weatherspoon Ring", --5
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    -- body="Passion Jacket",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Horos Tights +3",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.DNC_TP_DA_Cape,
  } -- default set

  -- For Crit Dmg, not crit rate
  sets.precast.WS.SneakAttack = {
    ammo="Charis Feather",
    head="Maculele Tiara",
    body="Meghanada Cuirie +2",
    -- head="Maculele Tiara +1",
  }

  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    ammo="Charis Feather",
    head=gear.Herc_WSD_head,
    body="Horos Casaque +3",
    hands=gear.Herc_TA_hands,
    legs="Meghanada Chausses +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    -- ammo="C. Palug Stone",
    -- head=gear.Herc_TA_head,
    -- back=gear.DNC_WS4_Cape,
  }) -- Multihit > AGI
  sets.precast.WS['Exenterator'].MaxTP = set_combine(sets.precast.WS['Exenterator'], {
  })
  sets.precast.WS['Exenterator'].LowAcc = set_combine(sets.precast.WS['Exenterator'], {
  })
  sets.precast.WS['Exenterator'].LowAccMaxTP = set_combine(sets.precast.WS['Exenterator'].LowAcc, {
  })
  sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS['Exenterator'].LowAcc, {
  })
  sets.precast.WS['Exenterator'].MidAccMaxTP = set_combine(sets.precast.WS['Exenterator'].MidAcc, {
  })
  sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS['Exenterator'].MidAcc, {
  })
  sets.precast.WS['Exenterator'].HighAccMaxTP = set_combine(sets.precast.WS['Exenterator'].HighAcc, {
  })

  sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head=gear.Herc_WSD_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs="Horos Tights +3",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Gere Ring",
    ring2="Epona's Ring",
    back=gear.DNC_TP_DA_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- head=gear.Lustratio_A_head,
    -- back=gear.DNC_WS2_Cape,
  }) -- 40% STR / 40% DEX
  sets.precast.WS['Pyrrhic Kleos'].MaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
  })
  sets.precast.WS['Pyrrhic Kleos'].LowAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Pyrrhic Kleos'].LowAccMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].LowAcc, {
  })
  sets.precast.WS['Pyrrhic Kleos'].MidAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'].LowAcc, {
  })
  sets.precast.WS['Pyrrhic Kleos'].MidAccMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].MidAcc, {
  })
  sets.precast.WS['Pyrrhic Kleos'].HighAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'].MidAcc, {
  })
  sets.precast.WS['Pyrrhic Kleos'].HighAccMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].HighAcc, {
  })

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Charis Feather",
    head=gear.Adhemar_B_head,
    body="Meghanada Cuirie +2",
    hands="Mummu Wrists +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Fotia Belt",
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    -- feet=gear.Herc_DEX_CritDmg_feet,
    -- back=gear.DNC_WS3_Cape,
  }) -- 50% DEX
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ring2="Defending Ring"
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
    -- ear2="Mache Earring +1",
  })
  sets.precast.WS['Evisceration'].LowAccMaxTP = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {
  })
  sets.precast.WS['Evisceration'].MidAccMaxTP = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {
  })
  sets.precast.WS['Evisceration'].HighAccMaxTP = set_combine(sets.precast.WS['Evisceration'].HighAcc, {
  })

  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head=gear.Herc_WSD_head,
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    legs="Horos Tights +3",
    feet=gear.Herc_WSD_feet,
    neck="Fotia Gorget",
    waist="Grunfeld Rope",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    -- ammo="Aurgelmir Orb +1",
    -- head=gear.Herc_WSD_head,
    -- body=gear.Herc_WSD_body,
    -- hands="Maxixi Bangles +3",
    -- neck="Etoile Gorget +2",
    -- back=gear.DNC_WS1_Cape,
  }) -- 80% DEX
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS["Rudra's Storm"].LowAcc = set_combine(sets.precast.WS["Rudra's Storm"], {
  })
  sets.precast.WS["Rudra's Storm"].LowAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {
  })
  sets.precast.WS["Rudra's Storm"].MidAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {
    -- ear2="Ishvara Earring",
  })
  sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {
  })
  sets.precast.WS["Rudra's Storm"].HighAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].HighAcc, {
    -- ear2="Ishvara Earring",
  })

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum", --4
    head="Highwing Helm", --20
    body=gear.Samnuha_body, --25
    hands=gear.Leyline_Gloves, --30
    legs=gear.Herc_MAB_legs, --33
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Ilabrat Ring",
    back="Argochampsa Mantle", --12
    waist="Eschan Stone", --7
    -- head=gear.Herc_MAB_head,
    -- body=gear.Herc_MAB_body,
    -- hands=gear.Herc_MAB_hands,
    -- legs="Horos Tights +3", -- Use once more MAB gear obtained
    -- ring2="Epaminondas's Ring",
    -- waist="Orpheus's Sash",
    -- back=gear.DNC_WS1_Cape,
  }) -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring", --7
  })
  sets.precast.WS['Aeolian Edge'].LowAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].LowAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP
  sets.precast.WS['Aeolian Edge'].MidAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].MidAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP
  sets.precast.WS['Aeolian Edge'].HighAcc = sets.precast.WS['Aeolian Edge']
  sets.precast.WS['Aeolian Edge'].HighAccMaxTP = sets.precast.WS['Aeolian Edge'].MaxTP

  sets.precast.Skillchain = {
    hands="Charis Bangles +2",
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Impatiens", --10
    ring1="Evanescence Ring", --5
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Turms Cap +1",
  }
  sets.latent_regen = {
    head="Turms Cap +1",
    body="Meghanada Cuirie +2",
    hands="Turms Mittens",
    legs="Meghanada Chausses +2",
    feet="Turms Leggings",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    legs="Rawhide Trousers",
  }

  sets.resting = {}

  sets.idle = {
    ammo="Charis Feather",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Ilabrat Ring",
    back=gear.DNC_TP_DA_Cape,
  }

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.LightDef = {
    ammo="Staunch Tathlum", --2/2, 0
    head="Turms Cap +1", --0/0, 109
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
  } --27 PDT/27 MDT, 647 MEVA

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)

  sets.HeavyDef = {
    ammo="Staunch Tathlum", --2/2, 109
    head="Turms Cap +1", --0/0, 109
    body="Malignance Tabard", --9/9, 139
    hands="Malignance Gloves", --5/5, 112
    legs="Malignance Tights", --7/7, 150
    feet="Malignance Boots", --4/4, 150
    neck="Twilight Torque", --5/5, 0
    ear1="Eabani Earring", --0/0, 8
    ear2="Odnowa Earring +1", --3/5, 0
    ring1=gear.Dark_Ring, --5/4, 0
    ring2="Defending Ring", --10/10, 0
  } --46 PDT/47 MDT, 764 MEVA

  sets.idle.Weak = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DA_Cape,
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
    -- neck="Etoile Gorget +2",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    head="Dampening Tam",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    legs="Meghanada Chausses +2",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Falcon Eye",
    legs="Malignance Tights",
    ear1="Telos Earring",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- body="Maxixi Casaque +3",
    -- waist="Olseni Belt",
  })

  -- * DNC Native DW Trait: 30% DW
  -- * DNC Job Points DW Gift: 5% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 39% from gear)
  sets.engaged.DW = {
    ammo="Aurgelmir Orb",
    head="Maxixi Tiara +3", -- 8
    body=gear.Adhemar_B_body, -- 6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Charis Necklace", -- 3
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5
    ear2="Eabani Earring", -- 4
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10
    -- neck="Etoile Gorget +2",
    -- waist="Reiki Yotai", -- 7
  } --36
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    head="Dampening Tam",
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- head="Maxixi Tiara +3", --8
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- body="Maxixi Casaque +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 32% from gear)
  sets.engaged.DW.LowHaste = {
    ammo="Aurgelmir Orb",
    head="Maxixi Tiara +3", -- 8
    body=gear.Adhemar_B_body, -- 6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Charis Necklace", -- 3
    waist="Windbuffet Belt +1",
    ear1="Suppanomimi", -- 5
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10
    -- neck="Etoile Gorget +2",
    -- waist="Reiki Yotai", -- 7
  } --30
  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    head="Dampening Tam",
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- head="Maxixi Tiara +3", --8
    -- body="Horos Casaque +3",
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- body="Maxixi Casaque +3",
    -- feet=gear.Herc_STP_feet,
    -- waist="Olseni Belt",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 21% from gear)
  sets.engaged.DW.MidHaste = {
    ammo="Aurgelmir Orb",
    head="Maxixi Tiara +3", -- 8%
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Eabani Earring", -- 4%
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10%
    -- head=gear.Adhemar_B_head, -- Use with Reiki Yotai
    -- neck="Etoile Gorget +2",
    -- waist="Reiki Yotai", -- 7
  } --22
  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ear2="Telos Earring",
    head="Dampening Tam",
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- head="Maxixi Tiara +3", --8
    -- body="Horos Casaque +3",
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- body="Maxixi Casaque +3",
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (51% DW to cap, 16% from gear)
  sets.engaged.DW.HighHaste = {
    ammo="Aurgelmir Orb",
    head="Maxixi Tiara +3", -- 8%
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10%
    -- head=gear.Adhemar_B_head, -- Use with Reiki Yotai
    -- neck="Etoile Gorget +2",
    -- waist="Reiki Yotai", -- 7
  } --18
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ear1="Telos Earring",
    head="Dampening Tam",
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- body="Horos Casaque +3",
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- head="Maxixi Tiara +3", --8
    -- body="Maxixi Casaque +3",
    -- waist="Olseni Belt",
  })

  -- Max Magic/Gear/JA Haste (36% DW to cap, 1% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Anu Torque",
    waist="Windbuffet Belt +1",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DA_Cape,
    -- neck="Etoile Gorget +2",
  }
  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    ear1="Telos Earring",
    head="Dampening Tam",
    -- ammo="Yamarang",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    -- ammo="Voluspa Tathlum",
    -- waist="Kentarch Belt +1",
  })
  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    ammo="Falcon Eye",
    body="Maxixi Casaque +2",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Regal Ring",
    ring2="Chirich Ring +1",
    -- ammo="C. Palug Stone",
    -- head="Maxixi Tiara +3", --8
    -- body="Maxixi Casaque +3",
    -- legs="Maxixi Tights +3",
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

  sets.engaged.DW.LightDef.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.LightDef)
  sets.engaged.DW.LowAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.MidAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.LightDef)
  sets.engaged.DW.HighAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.LightDef)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff['Saber Dance'] = {
    legs="Horos Tights +3",
  }
  sets.buff['Fan Dance'] = {
    body="Horos Bangles",
  }
  sets.buff['Climactic Flourish'] = {
    ammo="Charis Feather",
    head="Maculele Tiara",
    body="Meghanada Cuirie +2",
    -- head="Maculele Tiara +1",
    -- ring2="Epaminondas's Ring",
  }
  sets.buff['Climactic Flourish'].WS = set_combine(sets.buff['Climactic Flourish'], {
    -- ear1="Ishvara Earring",
    -- ear2="Moonshade Earring",
  })
  sets.buff['Climactic Flourish'].WSMaxTP = set_combine(sets.buff['Climactic Flourish'], {
    -- ear1="Ishvara Earring",
    -- ear2="Sherida Earring",
  })
  sets.buff['Closed Position'] = {
    feet="Horos Toe Shoes +3",
  }
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Skd. Jambeaux +1"
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
    -- head=gear.Herc_TH_head, --2
  }

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  cancel_outranged_ws(spell, eventArgs)
  cancel_on_blocking_status(spell, eventArgs)

  --auto_presto(spell)
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

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == "WeaponSkill" then
    if state.Buff['Sneak Attack'] == true then
      equip(sets.precast.WS.SneakAttack)
    end
    if state.Buff['Climactic Flourish'] then
      if player.tp <= 2900 then
        equip(sets.buff['Climactic Flourish'].WS)
      else
        equip(sets.buff['Climactic Flourish'].WSMaxTP)
      end
    end
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end
  if spell.type=='Waltz' and spell.english:startswith('Curing') and spell.target.type == 'SELF' then
    equip(sets.precast.WaltzSelf)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Saber Dance" or buff == "Climactic Flourish" or buff == "Fan Dance" or buff == "doom" then
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
  check_gear()
  update_idle_groups()
  update_combat_form()
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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
  local wsmode = ''

  if state.OffenseMode.value ~= 'Normal' then
    wsmode = state.OffenseMode.value
  end

  if player.tp > 2900 then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

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

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if state.Buff['Climactic Flourish'] then
    meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
  end
  if state.ClosedPosition.value == true then
    meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
  end
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

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
  if spell.type == 'Step' then
    if state.IgnoreTargetting.value == true then
      state.IgnoreTargetting:reset()
      eventArgs.handled = true
    end

    eventArgs.SelectNPCTargets = state.SelectStepTarget.value
  end
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

  local s_msg = state.MainStep.current
  if state.UseAltStep.value == true then
    s_msg = s_msg .. '/'..state.AltStep.current
  end

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
      ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
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
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 1 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 1 and DW_needed <= 9 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 9 and DW_needed <= 21 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 21 and DW_needed <= 39 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 39 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  if cmdParams[1] == 'step' then
    if cmdParams[2] == 't' then
      state.IgnoreTargetting:set()
    end

    local doStep = ''
    if state.UseAltStep.value == true then
      doStep = state[state.CurrentStep.current..'Step'].current
      state.CurrentStep:cycle()
    else
      doStep = state.MainStep.current
    end

    send_command('@input /ja "'..doStep..'" <t>')
  elseif cmdParams[1]:lower() == 'usekey' then
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
  end

  -- gearinfo(cmdParams, eventArgs)
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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
  if spell.type == 'Step' then
    local allRecasts = windower.ffxi.get_ability_recasts()
    local prestoCooldown = allRecasts[236]
    local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

    if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
      cast_delay(1.1)
      send_command('input /ja "Presto" <me>')
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
    set_macro_page(1, 2)
  elseif player.sub_job == 'THF' then
    set_macro_page(2, 2)
  elseif player.sub_job == 'NIN' then
    set_macro_page(3, 2)
  elseif player.sub_job == 'RUN' then
    set_macro_page(4, 2)
  elseif player.sub_job == 'SAM' then
    set_macro_page(5, 2)
  else
    set_macro_page(1, 2)
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
