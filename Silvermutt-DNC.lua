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
--              [ WIN+W ]           Toggle Rearming Lock
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
  include('Mote-Include.lua') -- Executes job_setup, user_setup,
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
  silibs.enable_auto_lockstyle(2)
  silibs.enable_waltz_refiner({
    base_chr= 104,
    base_vit= 97,
    bonus_chr= 157,
    bonus_vit= 62,
    waltz_potency = 49,
    waltz_self_potency = 17,
    est_non_party_target_hp = 2000,
  })
  silibs.enable_premade_commands()
  silibs.enable_th()

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify
  retry_filtered = nil

  elemental_ws = S{'Aeolian Edge'}
  tp_bonus_weapons = {
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Centovente'] = 1000,
  }

  state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false
  state.Buff['Feint'] = buffactive['feint'] or false

  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
  state.UseAltStep = M(false, 'Use Alt Step')
  state.SelectStepTarget = M(false, 'Select Step Target')
  state.IgnoreTargetting = M(true, 'Ignore Targetting')

  state.ClosedPosition = M(false, 'Closed Position')

  state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}

  state.CP = M(false, "Capacity Points Mode")

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('LightDef', 'Normal')
  state.IdleMode:options('Normal', 'LightDef')

  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}

  send_command('bind !a gs c test')
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

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
  send_command('bind %numpad0 gs c step t')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  include('Global-Binds.lua') -- Additional local binds

  if S{'PLD','WAR','MNK','BLM','DRG','SMN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Normal', 'Acc', 'H2H', 'Fast/DI', 'Staff', 'Healing', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Normal', 'Acc', 'H2H', 'Fast/DI', 'Healing', 'Cleaving'}
  end

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
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind !-')
  send_command('unbind !=')
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
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind %numpad0')
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
    neck="Unmoving Collar +1", --10
    waist="Kasiri Belt", --3
    -- ammo="Iron Gobbet", --2
    -- hands="Horos Bangles +3", --9
    -- feet="Ahosi Leggings", --7
    -- ear2="Trux Earring", --5
    -- back="Agema Cape", --5
  }

  sets.precast.JA['Provoke'] = sets.Enmity
  sets.precast.JA['No Foot Rise'] = {
    body="Horos Casaque +3",
  }
  sets.precast.JA['Trance'] = {
    head="Horos Tiara +3"
  }

  -- Waltz Potency/CHR
  sets.precast.Waltz = {
    ammo="Staunch Tathlum +1",      --  3/ 3 | __(_), __, __ <__>
    head=gear.Anwig_Salade,         -- __/__ | __(_),  4, __ <-2>
    body="Maxixi Casaque +3",       -- __/__ | 19(8), 33, 34 <-2>
    hands=gear.Nyame_B_hands,       --  7/ 7 | __(_), 24, 39 <__>
    legs="Dashing Subligar",        -- __/__ | 10(_), 11, 16 <__>; Gives Blink
    feet="Maxixi Shoes +1",         -- __/__ | 10(_), 30, 12 <__>
    neck="Etoile Gorget +2",        -- __/__ | 10(_), 25, __ <__>
    ear1="Genmei Earring",          --  2/__ | __(_), __,  2 <__>
    ear2="Odnowa Earring +1",       --  3/ 5 | __(_), __,  3 <__>
    ring1="Metamorph Ring +1",      -- __/__ | __(_), 16, __ <__>
    ring2="Defending Ring",         -- 10/10 | __(_), __, __ <__>
    back=gear.DNC_WTZ_Cape,         -- 10/__ | __(_), 30, __ <__>; Enmity-10
    waist="Aristo Belt",            -- __/__ | __(_),  8, __ <__>
    -- ammo="Voluspa Tathlum",      -- __/__ | __(_),  5, __ <__>
    -- feet="Maxixi Toeshoes +3",   -- __/__ | 14(_), 40, 22 <__>
    -- ear1="Handler's Earring +1", -- __/__ | __(_),  5,  5 <__>
    -- 30/22 | 53 Potency (8 Self Potency), 201 CHR, 119 VIT <-4 Delay>
  } -- 35/25 | 49 Potency (8 Self Potency), 157 CHR, 62 VIT <-4 Delay>

  -- Waltz effects received
  sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
    body="Maxixi Casaque +3",       -- __/__ | 19(8), 33, 34 <-2>
    -- 30/22 | 53 Potency (8 Self Potency), 201 CHR, 119 VIT <-4 Delay>
  })

  -- Waltz delay
  sets.precast.Waltz['Healing Waltz'] = {
    head=gear.Anwig_Salade, --2
    body="Maxixi Casaque +3", --2
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
    ammo="Yamarang",              -- __/__, 15
    head="Maxixi Tiara +3",       -- __/__, 82
    body="Malignance Tabard",     --  9/ 9, 50
    hands="Maxixi Bangles +3",    -- __/__, 88
    legs="Malignance Tights",     --  7/ 7, 50
    feet="Horos Toe Shoes +3",    -- __/__, 66; Step TP -20
    neck="Etoile Gorget +2",      -- __/__, 25
    ear1="Telos Earring",         -- __/__, 10
    ear2="Odnowa Earring +1",     --  3/ 5, __
    ring1="Gelatinous Ring +1",   --  7/-1, __
    ring2="Defending Ring",       -- 10/10, __
    back=gear.DNC_TP_DW_Cape,     -- 10/__, 20
    waist="Engraved Belt",        -- __/__, 10; Elemental resist
    -- Maxixi set bonus           -- __/__, 15
  } -- 46 PDT /30 MDT, 431 Acc

  sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {
    feet="Maculele Toe Shoes +1",
  })
  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

  -- Magic Accuracy
  sets.precast.Flourish1['Violent Flourish'] = {
    ammo="Yamarang",
    head="Malignance Chapeau",
    body="Horos Casaque +3",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Etoile Gorget +2",
    ear1="Digni. Earring",
    ear2="Hermetic Earring",
    ring1="Weatherspoon Ring",
    ring2="Ayanmo Ring",
    back=gear.DNC_TP_DW_Cape,
    waist="Eschan Stone",
    -- ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
  }

  -- Magic Accuracy
  sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {
    body="Malignance Tabard",
  })

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {
    hands="Maculele Bangles",
    back=gear.DNC_Adoulin_Cape,
    -- hands="Maculele Bangles +1",
  }
  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {
    -- body="Maculele Casaque +1"
  }
  sets.precast.Flourish3['Climactic Flourish'] = {
    head="Maculele Tiara +1",
  }

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

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    neck="Magoraga Beads", --10
    ring1="Defending Ring",
  }) --51

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Fotia Belt",
  } -- default set
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {})
  sets.precast.WS.SATA = {body="Meg. Cuirie +2"}
  -- For Crit Dmg, not crit rate; overlaid on any WS set that doesn't have its own Climacic set defined
  sets.precast.WS.Climactic = {
    head="Maculele Tiara +1",
    body="Meghanada Cuirie +2",
  }

  -- 73-85% AGI, 1.0 FTP, ftp replicating
  -- Multihit > AGI
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    ammo="Charis Feather",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Herc_TA_hands,
    legs="Meghanada Chausses +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Fotia Belt",
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

  -- 40% STR / 40% DEX, ftp replicating
  sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",           --  5,  5, __, __
    head=gear.Nyame_B_head,         -- 26, 25,  8, __
    body=gear.Adhemar_B_body,       -- 38, 45, __, __
    hands=gear.Adhemar_B_hands,     -- 27, 56, __, __
    legs="Horos Tights +3",         -- 42, __, 10, __
    feet=gear.Nyame_B_feet,         -- 23, 26,  8, __
    neck="Etoile Gorget +2",        -- __, 25, __, 10
    ear1="Odr Earring",             -- __, 10, __, __
    ear2="Sherida Earring",         --  5,  5, __, __
    ring1="Gere Ring",              -- 10, __, __, __
    ring2="Regal Ring",             -- 10, 10, __, __
    back=gear.DNC_TP_DA_Cape,       -- __, 30, __, __
    waist="Fotia Belt",             -- __, __, __, __
    -- ammo="Aurgelmir Orb +1",     --  7,  7, __, __
    -- head="Gleti's Mask",         -- 33, 28, __,  6
    -- body="Gleti's Cuirass",      -- 39, 34, __,  9
    -- hands="Gleti's Gauntlets",   -- 20, 42, __,  9
    -- legs="Gleti's Greaves",      -- 49, __, __,  8
    -- feet=gear.Lustratio_D_feet,  -- 47, 48, __, __
    -- ear2="Mache Earring +1",     -- __,  8, __, __
    -- back=gear.DNC_WS2_Cape,      -- 30, __, __, __
    -- 250 STR, 207 DEX, 10 WSD, 42 PDL
  }) -- 186 STR, 237 DEX, 26 WSD, 10 PDL
  sets.precast.WS['Pyrrhic Kleos'].MaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
  })
  sets.precast.WS['Pyrrhic Kleos'].LowAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
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

  -- 50% DEX, 1.25 FTP, can crit, ftp replicating
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Charis Feather",
    head=gear.Adhemar_B_head,
    body="Meghanada Cuirie +2",
    hands="Mummu Wrists +2",
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Fotia Gorget",
    ear1="Odr Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Fotia Belt",
    -- back=gear.DNC_WS3_Cape,
  })
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ring2="Defending Ring"
  })
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {
    -- ear1="Mache Earring +1",
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

  -- 80% DEX
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",           --  5, __, __,  7, __
    head=gear.Nyame_B_head,         -- 25, 24,  8, 55, __
    body=gear.Nyame_B_body,         -- 24, 35, 10, 55, __
    hands="Maxixi Bangles +3",      -- 45, 27, 10, 35, __
    legs="Horos Tights +3",         -- __, 24, 10, 64, __
    feet=gear.Nyame_B_feet,         -- 26, 38,  8, 55, __
    neck="Etoile Gorget +2",        -- 25, 25, __, __, 10
    ear1="Ishvara Earring",         -- __, __,  2, __, __
    ear2="Moonshade Earring",       -- __, __, __, __, __; TP Bonus+250
    ring1="Ilabrat Ring",           -- 10, __, __, 25, __
    ring2="Regal Ring",             -- 10, __, __, 20, __
    back=gear.DNC_WS1_Cape,         -- 30, __, 10, 20, __; Crit dmg+5
    waist="Grunfeld Rope",          --  5, __, __, 20, __
    -- ammo="Cath Palug Stone",     -- 10, __, __, __, __
    -- ring2="Epaminondas's Ring",  -- __, __,  5, __, __
    -- waist="Kentarch Belt +1",    -- 10, __, __, __, __;Aug it first
    -- 215 DEX, 159 CHR, 68 WSD, 274 Att, 10 PDL
  })-- 205 DEX, 173 CHR, 58 WSD, 356 Att, 10 PDL
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    ear2="Odr Earring",
  })
  sets.precast.WS["Rudra's Storm"].LowAcc = set_combine(sets.precast.WS["Rudra's Storm"], {})
  sets.precast.WS["Rudra's Storm"].LowAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {
    ear2="Odr Earring",
  })
  sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS["Rudra's Storm"].LowAcc, {})
  sets.precast.WS["Rudra's Storm"].MidAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {
    ear2="Odr Earring",
  })
  sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS["Rudra's Storm"].MidAcc, {})
  sets.precast.WS["Rudra's Storm"].HighAccMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].HighAcc, {
    ear2="Odr Earring",
  })
  -- For Crit Dmg, not crit rate; overlaid on Rudra's set
  sets.precast.WS["Rudra's Storm"].Climactic = {
    head="Maculele Tiara +1",
  }

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum", --4
    head=gear.Nyame_B_head, --30
    body=gear.Nyame_B_body, --30
    hands=gear.Nyame_B_hands, --30
    legs=gear.Nyame_B_legs, --30
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Defending Ring",
    back=gear.DNC_WS1_Cape,
    waist="Eschan Stone", --7
    -- legs="Horos Tights +3", -- Use once Orpheus obtained
    -- ring2="Epaminondas's Ring",
    -- waist="Orpheus's Sash",
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
  -- Required to prevent extra gear from equipping during Climactic; AE cannot crit
  sets.precast.WS["Aeolian Edge"].Climactic = {}

  sets.precast.WS['Shell Crusher'] = {
    ammo="Hydrocera",           -- __,  6
    head=gear.Nyame_B_head,     -- 40, 40
    body=gear.Nyame_B_body,     -- 40, 40
    hands=gear.Nyame_B_hands,   -- 40, 40
    legs=gear.Nyame_B_legs,     -- 40, 40
    feet=gear.Nyame_B_feet,     -- 40, 40
    neck="Carnal Torque",       -- Needed to unlock WS
    ear1="Dignitary's Earring", -- 10, 10
    ear2="Moonshade Earring",   -- __, __
    ring1="Etana Ring",         -- 10, 10
    ring2="Metamorph Ring +1",  -- __, 16
    back=gear.DNC_WS1_Cape,     -- 20, __
    waist="Luminary Sash",      -- __, 10
    -- ear2="Crepuscular Earring", -- 10, 10
  } -- Acc, MAcc
  sets.precast.WS['Shell Crusher'].MaxTP = set_combine(sets.precast.WS['Shell Crusher'], {
    ear2="Telos Earring",
    -- ear2="Crepuscular Earring",
  })
  sets.precast.WS['Shell Crusher'].LowAcc = sets.precast.WS['Shell Crusher']
  sets.precast.WS['Shell Crusher'].LowAccMaxTP = sets.precast.WS['Shell Crusher'].MaxTP
  sets.precast.WS['Shell Crusher'].MidAcc = sets.precast.WS['Shell Crusher']
  sets.precast.WS['Shell Crusher'].MidAccMaxTP = sets.precast.WS['Shell Crusher'].MaxTP
  sets.precast.WS['Shell Crusher'].HighAcc = sets.precast.WS['Shell Crusher']
  sets.precast.WS['Shell Crusher'].HighAccMaxTP = sets.precast.WS['Shell Crusher'].MaxTP


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Impatiens", --10
    neck="Loricate Torque +1", --5
  }

  sets.midcast.Utsusemi = set_combine(sets.precast.FC.Utsusemi, sets.midcast.SpellInterrupt)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    ring2="Defending Ring",     -- 10/10, ___
    -- 10 PDT from JSE cape
  } --51 PDT/41 MDT, 689 MEVA

  sets.HeavyDef = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs=gear.Nyame_B_legs,     --  8/ 8, 150
    feet="Malignance Boots",    --  4/ 4, 150
    neck="Etoile Gorget +2",    -- __/__, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Archon Ring",        -- __/__, ___; Occ. blocks magic dmg
    back=gear.DNC_TP_DW_Cape,   -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
  } --50 PDT/42 MDT, 697 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

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
    feet="Turms Leggings +1",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }

  sets.resting = {}

  sets.idle = sets.HeavyDef

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    neck="Loricate Torque +1",  --  6/ 6, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Gelatinous Ring +1", --  7/-1, ___
    back="Moonlight Cape",      --  6/ 6, ___
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Yamarang",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Etoile Gorget +2",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Windbuffet Belt +1",
    -- hands=gear.Adhemar_A_hands,
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    head="Dampening Tam",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    legs="Meghanada Chausses +2",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Falcon Eye",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",
    ear1="Telos Earring",
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Regal Ring",
    waist="Olseni Belt",
    -- ammo="C. Palug Stone",
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
    neck="Etoile Gorget +2",
    ear1="Suppanomimi", -- 5
    ear2="Eabani Earring", -- 4
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10
    waist="Reiki Yotai", -- 7
  } --40
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    ammo="Yamarang",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Falcon Eye",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- waist="Olseni Belt",
  })

  -- Low Magic/Gear/JA Haste (60% DW to cap, 25% from gear)
  sets.engaged.DW.LowHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, -- 6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Etoile Gorget +2",
    ear1="Eabani Earring", -- 4
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10
    waist="Reiki Yotai", -- 7
  } --27
  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ammo="Yamarang",
    head="Dampening Tam",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
    -- head="Maxixi Tiara +3", --8
    -- body="Horos Casaque +3",
  })
  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Falcon Eye",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",
    ear1="Dignitary's Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- waist="Olseni Belt",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 21% from gear)
  sets.engaged.DW.MidHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Etoile Gorget +2",
    ear1="Eabani Earring", -- 4
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DW_Cape, -- 10
    waist="Reiki Yotai", -- 7
  } --21
  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ammo="Yamarang",
    head="Dampening Tam",
    hands="Mummu Wrists +2",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Horos Tights +3",
    ear1="Telos Earring",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
    -- head="Maxixi Tiara +3", --8
    -- body="Horos Casaque +3",
  })
  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    ammo="Falcon Eye",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- waist="Olseni Belt",
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 8% from gear)
  sets.engaged.DW.HighHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Etoile Gorget +2",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Reiki Yotai", -- 7
  } --7
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ammo="Yamarang",
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    hands="Mummu Wrists +2",
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
    -- body="Horos Casaque +3",
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    ammo="Falcon Eye",
    head="Maxixi Tiara +3", --8
    body="Maxixi Casaque +3",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    -- ammo="C. Palug Stone",
    -- waist="Olseni Belt",
  })

  -- Max Magic/Gear/JA Haste (0-36% DW to cap, 0-1% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Horos Toe Shoes +3",
    neck="Etoile Gorget +2",
    waist="Windbuffet Belt +1",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Epona's Ring",
    ring2="Gere Ring",
    back=gear.DNC_TP_DA_Cape,
  }
  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    ammo="Yamarang",
    head="Dampening Tam",
    ring1="Chirich Ring +1",
    -- hands=gear.Adhemar_A_hands,
  })
  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    hands="Mummu Wrists +2",
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    ammo="Falcon Eye",
    head="Maxixi Tiara +3", --8
    body="Maxixi Casaque +3",
    legs="Malignance Tights",
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    waist="Olseni Belt",
    -- ammo="C. Palug Stone",
    -- legs="Maxixi Tights +3",
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

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

  sets.buff['Saber Dance'] = {
    legs="Horos Tights +3",
  }
  sets.buff['Fan Dance'] = {
    body="Horos Bangles",
  }
  -- This is overlaid on TP set during Climactic Flourish
  sets.buff['Climactic Flourish'] = {
    head="Maculele Tiara +1",
  }
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
    ammo="Perfect Lucky Egg", --1
    body=gear.Herc_TH_body, --2
    waist="Chaac Belt", --1
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Normal'] = {main="Twashtar", sub="Centovente"}
  sets.WeaponSet['Acc'] = {main="Twashtar", sub="Taming Sari"}
  sets.WeaponSet['H2H'] = {main="Kaja Knuckles", sub=empty}
  sets.WeaponSet['Fast/DI'] = {main="Twashtar", sub="Voluspa Knife"}
  sets.WeaponSet['Staff'] = {main="Gozuki Mezuki", sub="Tzacab Grip"}
  sets.WeaponSet['Healing'] = {main="Enchufla", sub="Blurred Knife +1"}
  sets.WeaponSet['Cleaving'] = {main="Kaja Knife", sub="Levante Dagger"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function filtered_action(spell)
  if spell.english == "Shell Crusher" then
    if player.equipment.neck ~= "Carnal Torque" then
      if not retry_filtered then retry_filtered = {} end
      if not retry_filtered or (retry_filtered and retry_filtered.count and retry_filtered.count < 3) then
        print('count: '..tostring(retry_filtered and retry_filtered.count))
        equip({neck="Carnal Torque"})
        send_command('gs c update') -- Call the update command to force gear change
        retry_filtered.action = spell.name
        retry_filtered.count = (retry_filtered.count and retry_filtered.count + 1) or 1
        send_command('input /ws "Shell Crusher" <t>')
      end
    end
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  if retry_filtered and spell.name == retry_filtered.action then
    retry_filtered.action = nil
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
  if spell.type == "WeaponSkill" then
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
    if state.Buff['Climactic Flourish'] then
      -- If set isn't found for specific ws, overlay the default set
      local set = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Climactic) or sets.precast.WS.Climactic or {}
      equip(set)
    end
    if state.Buff['Sneak Attack'] or state.Buff['Trick Attack'] then
    -- If set isn't found for specific ws, overlay the default set
      local set = sets.precast.WS[spell.name].SATA or sets.precast.WS.SATA or {}
      equip(set)
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
    state.Buff['Trick Attack'] = false
    state.Buff['Feint'] = false
  end
end

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
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
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
  if buff == "Saber Dance" or buff == "Climactic Flourish" or buff == "Fan Dance" or buff == "doom" then
    status_change(player.status)
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
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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

  local buffer = 100
  local main = player.equipment.main
  local sub = player.equipment.sub
  local weapon_bonus = (tp_bonus_weapons[main] or 0) + (tp_bonus_weapons[sub] or 0)
  local buff_bonus = T{
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  if player.tp > 3000-weapon_bonus-buff_bonus-buffer then
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
    elseif DW_needed > 1 and DW_needed <= 8 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 8 and DW_needed <= 25 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 25 and DW_needed <= 39 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 39 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if not eventArgs.handled then
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
    elseif cmdParams[1] == 'toyweapon' then
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


-- Automatically use Presto for steps when it's available
function job_pretarget(spell, action, spellMap, eventArgs)
  if spell.type == 'Step' then
    local allRecasts = windower.ffxi.get_ability_recasts()
    local prestoCooldown = allRecasts[236]

    if player.main_job_level >= 77 and prestoCooldown < 1 and not buffactive.Presto then
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

function test()
end
