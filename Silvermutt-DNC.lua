-- File Status: Good. Need to update with empy+3. Acc modes for engaged sets are outdated.

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
  silibs.enable_auto_lockstyle(2)
  silibs.enable_waltz_refiner({
    base_chr= 121,
    base_vit= 122,
    bonus_chr= 186,
    bonus_vit= 111,
    waltz_potency = 50,
    waltz_self_potency = 8,
    est_non_party_target_hp = 2000,
  })
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false
  state.Buff['Feint'] = buffactive['feint'] or false

  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
  state.UseAltStep = M(false, 'Use Alt Step')
  state.SelectStepTarget = M(false, 'Select Step Target')
  state.IgnoreTargetting = M(true, 'Ignore Targetting')

  state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}

  state.CP = M(false, "Capacity Points Mode")
  state.AttCapped = M(true, "Attack Capped")

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'HeavyDef', 'Safe')
  state.IdleMode:options('Normal', 'HeavyDef')

  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.RangedWeaponSet = M{['description']='Ranged Weapon Set', 'None', 'Throwing', 'Pulling'}

  send_command('bind !a gs c test')
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')
  send_command('bind ^home gs c rangedweaponset cycle')
  send_command('bind ^end gs c rangedweaponset cycleback')
  send_command('bind !end gs c rangedweaponset reset')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')
  
  send_command('bind ^f8 gs c toggle AttCapped')

  send_command('bind ^- gs c cycleback mainstep')
  send_command('bind ^= gs c cycle mainstep')
  send_command('bind !- gs c cycleback altstep')
  send_command('bind != gs c cycle altstep')
  send_command('bind ^] gs c toggle usealtstep')
  send_command('bind ![ input /ja "Contradance" <me>')
  send_command('bind !q input /ja "Saber Dance" <me>')
  send_command('bind !` input /ja "Chocobo Jig II" <me>')
  send_command('bind ^numlock input /ja "Reverse Flourish" <me>')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numpad+ input /ja "Climactic Flourish" <me>')
  send_command('bind ^numpadenter input /ja "Building Flourish" <me>')
  send_command('bind %numpad0 gs c step t')
  send_command('bind %e input /ra <t>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if S{'PLD','WAR','MNK','BLM','DRG','SMN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Twashtar', 'TwashtarAcc', 'Terpsichore', 'H2H', 'Healing', 'Staff', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Twashtar', 'TwashtarAcc', 'Terpsichore', 'H2H', 'Healing', 'Cleaving'}
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
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')
  send_command('unbind ^home')
  send_command('unbind ^end')
  send_command('unbind !end')
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
  send_command('unbind ^f8')
  send_command('unbind %e')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}
  sets.org.job[1] = {range="Albin Bane"}

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
    feet="Maxixi Toe Shoes +3",     -- __/__ | 14(_), 40, 22 <__>
    neck="Etoile Gorget +2",        -- __/__ | 10(_), 25, __ <__>
    ear1="Genmei Earring",          --  2/__ | __(_), __,  2 <__>
    ear2="Odnowa Earring +1",       --  3/ 5 | __(_), __,  3 <__>
    ring1="Metamorph Ring +1",      -- __/__ | __(_), 16, __ <__>
    ring2="Defending Ring",         -- 10/10 | __(_), __, __ <__>
    back=gear.DNC_WTZ_Cape,         -- 10/__ | __(_), 30, __ <__>; Enmity-10
    waist="Aristo Belt",            -- __/__ | __(_),  8, __ <__>
    -- 35/25 | 53 Potency (8 Self Potency), 191 CHR, 116 VIT <-4 Delay>

    -- hands="Maculele Bangles +3", -- 11/11 | __(_), 28, 40 <__>
    -- 39/29 | 53 Potency (8 Self Potency), 195 CHR, 117 VIT <-4 Delay>
  }
  -- Waltz effects received
  sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
    body="Maxixi Casaque +3",       -- __/__ | 19(8), 33, 34 <-2>
    -- 39/29 | 53 Potency (8 Self Potency), 195 CHR, 117 VIT <-4 Delay>
  })
  sets.precast.WaltzSafe = {
    ring1="Gelatinous Ring +1",     --  7/-1 | __(_), __, 15 <__>
    waist="Flume Belt +1",          --  4/__ | __(_), __, __ <__>
    -- 50/28 | 53 Potency (8 Self Potency), 171 CHR, 147 VIT <-4 Delay>
  }

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
    feet="Maxixi Toe Shoes +3",
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
    feet="Maculele Toe Shoes +2",
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
    ring2="Stikini Ring +1",
    back=gear.DNC_TP_DW_Cape,
    waist="Eschan Stone",
    -- ring1="Stikini Ring +1",
  }

  -- Magic Accuracy
  sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Flourish1['Violent Flourish'], {
    body="Malignance Tabard",
  })

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {
    hands="Maculele Bangles +1",
    back=gear.DNC_Adoulin_Cape,
  }
  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {
    body="Maculele Casaque +2"
  }
  sets.precast.Flourish3['Climactic Flourish'] = {
    head="Maculele Tiara +2",
  }

  sets.precast.FC = {
    ammo="Impatiens",
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    neck="Orunmila's Torque", --5
    ear1="Loquac. Earring", --2
    ear2="Etiolation Earring", --1
    ring1="Weatherspoon Ring", --5
    ring2="Prolix Ring", --2
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    body="Passion Jacket", --10
    neck="Magoraga Beads", --10
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })

  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ammo="Impatiens",
    ring1="Weatherspoon Ring", --5
  })

  sets.precast.RA = {
    head=gear.Herc_Snap_head,           --  6/__
    legs=gear.Adhemar_D_legs,           -- 10/13
    feet="Meg. Jam. +2",                -- 10/__
    ring1="Crepuscular Ring",           --  3/__
    waist="Yemaya Belt",                -- __/ 5
    -- 29 Snapshot / 18 Rapid Shot

    -- body=gear.Herc_Snap_body,        --  6/__
    -- hands=gear.Herc_Snap_hands,      --  6/__
    -- back=gear.THF_Snapshot_Cape,     -- 10/__
    -- 51 Snapshot / 18 Rapid Shot
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Coiste Bodhar",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Fotia Belt",
  } -- default set
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {})
  sets.precast.WS.SA = {body="Meg. Cuirie +2"}
  -- For Crit Dmg, not crit rate; overlaid on any WS set that doesn't have its own Climacic set defined
  sets.precast.WS.Climactic = {
    ammo="Charis Feather",
    head="Maculele Tiara +2",
    body="Meghanada Cuirie +2",
  }

  -- 73-85% AGI, 1.0 FTP, ftp replicating
  -- Multihit > AGI
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    ammo="Cath Palug Stone",
    head=gear.Adhemar_B_head,
    body="Horos Casaque +3",
    hands=gear.Herc_TA_hands,
    legs="Meghanada Chausses +2",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Gere Ring",
    ring2="Regal Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Fotia Belt",
    -- head=gear.Herc_TA_head,
    -- back=gear.DNC_WS4_Cape,
  }) -- Multihit > AGI
  sets.precast.WS['Exenterator'].MaxTP = set_combine(sets.precast.WS['Exenterator'], {
  })

  -- 40% STR / 40% DEX, ftp replicating
  sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",           --  5,  5, __,  7, __
    head=gear.Lustratio_D_head,     -- 47, 45, __, __, __
    body="Gleti's Cuirass",         -- 39, 34, __, 60,  9
    hands=gear.Adhemar_B_hands,     -- 27, 56, __, 52, __
    legs="Gleti's Breeches",        -- 49, __, __, 60,  8
    feet=gear.Lustratio_D_feet,     -- 47, 48, __, __, __
    neck="Etoile Gorget +2",        -- __, 25, __, __, 10
    ear1="Sherida Earring",         --  5,  5, __, __, __
    ear2="Odr Earring",             -- __, 10, __, __, __
    ring1="Gere Ring",              -- 10, __, __, 16, __
    ring2="Regal Ring",             -- 10, 10, __, 20, __
    back=gear.DNC_WS2_Cape,         -- __, 30, __, 20, __
    waist="Fotia Belt",             -- __, __, __, __, __; +0.1 ftp
    -- Lustratio set bonus          -- __, __,  4, __, __

    -- ammo="Aurgelmir Orb +1",     --  7,  7, __, 10, __
    -- body=gear.Adhemar_B_body,    -- 38, 45, __, 55, __
    -- 240 STR, 281 DEX, 4 WSD, 233 Att, 18 PDL
  })-- 239 STR, 268 DEX, 4 WSD, 235 Att, 27 PDL
  sets.precast.WS['Pyrrhic Kleos'].MaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
  sets.precast.WS['Pyrrhic Kleos'].AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",      --  3, __, __, __,  3
    head=gear.Lustratio_D_head,     -- 47, 45, __, __, __
    body="Gleti's Cuirass",         -- 39, 34, __, 60,  9
    hands="Gleti's Gauntlets",      -- 20, 42, __, 60,  9
    legs="Gleti's Breeches",        -- 49, __, __, 60,  8
    feet=gear.Lustratio_D_feet,     -- 47, 48, __, __, __
    neck="Etoile Gorget +2",        -- __, 25, __, __, 10
    ear1="Sherida Earring",         --  5,  5, __, __, __
    ear2="Maculele Earring",        -- __, __, __, __,  9
    ring1="Gere Ring",              -- 10, __, __, 16, __
    ring2="Regal Ring",             -- 10, 10, __, 20, __
    back=gear.DNC_WS2_Cape,         -- __, 30, __, 20, __
    waist="Fotia Belt",             -- __, __, __, __, __; +0.1 ftp
    -- Lustratio set bonus          -- __, __,  4, __, __

    -- ear2="Maculele Earring +2",  -- __, __, __, __,  9
    -- 230 STR, 239 DEX, 4 WSD, 236 Att, 48 PDL
  })-- 230 STR, 249 DEX, 4 WSD, 236 Att, 39 PDL
  sets.precast.WS['Pyrrhic Kleos'].AttCappedMaxTP = set_combine(sets.precast.WS['Pyrrhic Kleos'].AttCapped, {})
  -- Required to prevent extra gear from equipping during Climactic
  -- For Crit Dmg, not crit rate; is overlaid, don't set_combine
  sets.precast.WS['Pyrrhic Kleos'].Climactic = {}

  -- 50% DEX, 1.25 FTP, can crit, ftp replicating
  sets.precast.WS['Evisceration'] = {
    ammo="Charis Feather",            -- __/__,  5, __,  5, __
    head=gear.Adhemar_B_head,         -- __/__,  6, __, 21, __
    body="Meghanada Cuirie +2",       --  8/__,  6, __, 45, __
    hands="Gleti's Gauntlets",        --  7/__, __,  6, 42,  7
    legs=gear.Lustratio_B_legs,       -- __/__, __,  3, 43, __
    feet=gear.Herc_DEX_CritDmg_feet,  --  2/__,  3, __, 33, __
    neck="Fotia Gorget",              -- fTP Bonus
    ear1="Sherida Earring",           -- __/__, __, __,  5, __
    ear2="Odr Earring",               -- __/__, __,  5, 10, __
    ring1="Ilabrat Ring",             -- __/__, __, __, 10, __
    ring2="Regal Ring",               -- __/__, __, __, 10, __
    back=gear.DNC_TP_DA_Cape,         -- 10/__,  5, __, 30, __
    waist="Fotia Belt",               -- fTP Bonus
    -- back=gear.DNC_WS3_Cape,
  } -- 27PDT/0MDT, 25 Crit Damage, 14 Crit Rate, 254 DEX, 7 PDL
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
  })
  sets.precast.WS['Evisceration'].Safe = {
    ammo="Charis Feather",            -- __/__,  5, __,  5, __
    head=gear.Adhemar_B_head,         -- __/__,  6, __, 21, __
    body="Meghanada Cuirie +2",       --  8/__,  6, __, 45, __
    hands="Gleti's Gauntlets",        --  7/__, __,  6, 42,  7
    legs=gear.Lustratio_B_legs,       -- __/__, __,  3, 43, __
    feet=gear.Herc_DEX_CritDmg_feet,  --  2/__,  3, __, 33, __
    neck="Fotia Gorget",              -- fTP Bonus
    ear1="Odnowa Earring +1",         --  3/ 5, __, __, __, __
    ear2="Odr Earring",               -- __/__, __,  5, 10, __
    ring1="Gelatinous Ring +1",       --  7/-1, __, __, __, __
    ring2="Defending Ring",           -- 10/10, __, __, __, __
    back=gear.DNC_TP_DA_Cape,         -- 10/__,  5, __, 30, __
    waist="Fotia Belt",               -- fTP Bonus
    -- back=gear.DNC_WS3_Cape,
  } -- 47PDT/14MDT, 25 Crit Damage, 14 Crit Rate, 229 DEX, 7 PDL

  -- 80% DEX
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",           --  5, __,  7, __
    head=gear.Nyame_B_head,         -- 25, 10, 60, __
    body=gear.Nyame_B_body,         -- 24, 12, 60, __
    hands="Maxixi Bangles +3",      -- 45, 10, 35, __
    legs=gear.Nyame_B_legs,         -- __, 11, 60, __
    feet=gear.Nyame_B_feet,         -- 26, 10, 60, __
    neck="Etoile Gorget +2",        -- 25, __, __, 10
    ear1="Moonshade Earring",       -- __, __, __, __; TP Bonus+250
    ear2="Odr Earring",             -- 10, __, __, __
    ring1="Ilabrat Ring",           -- 10, __, 25, __
    ring2="Epaminondas's Ring",     -- __,  5, __, __
    back=gear.DNC_WS1_Cape,         -- 30, 10, 20, __; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __
    -- 220 DEX, 63 WSD, 347 Att, 10 PDL

    -- ammo="Aurgelmir Orb +1",     --  7, __, 10, __
    -- 222 DEX, 63 WSD, 350 Att, 10 PDL
  })
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    ear1="Ishvara Earring",         -- __,  2, __, __
  })
  sets.precast.WS["Rudra's Storm"].AttCapped = set_combine(sets.precast.WS, {
    ammo="Cath Palug Stone",        -- 10, __, __, __
    head=gear.Lustratio_D_head,     -- 45, __, __, __
    body="Gleti's Cuirass",         -- 34, __, 64,  9
    hands="Maxixi Bangles +3",      -- 45, 10, 35, __
    legs=gear.Nyame_B_legs,         -- __, 11, 60, __
    feet=gear.Lustratio_D_feet,     -- 48, __, __, __
    neck="Etoile Gorget +2",        -- 25, __, __, 10
    ear1="Moonshade Earring",       -- __, __, __, __; TP Bonus+250
    ear2="Maculele Earring",        -- __, __, __,  7
    ring1="Epaminondas's Ring",     -- __,  5, __, __
    ring2="Regal Ring",             -- 10, __, 20, __
    back=gear.DNC_WS1_Cape,         -- 30, 10, 20, __; Crit dmg+5
    waist="Kentarch Belt +1",       -- 10, __, __, __
    -- Lustratio set bonus          -- __,  4, __, __
    -- 257 DEX, 40 WSD, 199 Att, 26 PDL
    
    -- ear2="Maculele Earring +2",  -- __, __, __,  9
    -- 257 DEX, 40 WSD, 199 Att, 28 PDL
  })
  sets.precast.WS["Rudra's Storm"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {
    ear1="Ishvara Earring",         -- __,  2, __, __
    -- ear1="Odr Earring",          -- 10, __, __, __
  })
  -- For Crit Dmg, not crit rate; is overlaid, don't set_combine
  sets.precast.WS["Rudra's Storm"].Climactic = {
    ammo="Charis Feather",
    head="Maculele Tiara +2",
    feet=gear.Nyame_B_feet,
    ear2="Maculele Earring",        -- __, __, __,  9
    ring1="Epaminondas's Ring",

    -- ear2="Maculele Earring +2",  -- __, __, __, __,  9
  }
  sets.precast.WS["Rudra's Storm"].Safe = {
    ring2="Defending Ring",
    waist="Flume Belt +1",
  }

  -- 40% DEX / 40% AGI; fTP 4.5-8.5
  sets.precast.WS["Shark Bite"] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS["Shark Bite"].MaxTP = sets.precast.WS["Rudra's Storm"].MaxTP
  sets.precast.WS["Shark Bite"].AttCapped = sets.precast.WS["Rudra's Storm"].AttCapped
  sets.precast.WS["Shark Bite"].AttCappedMaxTP = sets.precast.WS["Rudra's Storm"].AttCappedMaxTP
  -- For Crit Dmg, not crit rate; is overlaid, don't set_combine
  sets.precast.WS["Shark Bite"].Climactic = sets.precast.WS["Rudra's Storm"].Climactic
  sets.precast.WS["Shark Bite"].Safe = sets.precast.WS["Rudra's Storm"].Safe

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum", --4
    head=gear.Nyame_B_head, --30
    body=gear.Nyame_B_body, --30
    hands=gear.Nyame_B_hands, --30
    legs=gear.Nyame_B_legs, --30
    feet=gear.Herc_MAB_feet, --57
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Epaminondas's Ring",
    back=gear.DNC_WS1_Cape,
    waist="Eschan Stone", --7
    -- waist="Orpheus's Sash",
  }) -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring", --7
  })
  -- Required to prevent extra gear from equipping during Climactic; AE cannot crit
  -- For Crit Dmg, not crit rate; is overlaid, don't set_combine
  sets.precast.WS["Aeolian Edge"].Climactic = {}

  sets.precast.WS['Shell Crusher'] = {
    ammo="Hydrocera",           -- __,  6
    head=gear.Nyame_B_head,     -- 40, 40
    body=gear.Nyame_B_body,     -- 40, 40
    hands=gear.Nyame_B_hands,   -- 40, 40
    legs=gear.Nyame_B_legs,     -- 40, 40
    feet=gear.Nyame_B_feet,     -- 40, 40
    neck="Etoile Gorget +2",    -- 25, 25
    ear1="Dignitary's Earring", -- 10, 10
    ear2="Moonshade Earring",   -- __, __
    ring1="Chirich Ring +1",    -- 10, __
    ring2="Metamorph Ring +1",  -- __, 16
    back=gear.DNC_WS1_Cape,     -- 20, __
    waist="Olseni Belt",        -- 20, __
    -- ear2="Crepuscular Earring", -- 10, 10
    -- ring1="Etana Ring",         -- 10, 10
    -- waist="Luminary Sash",      -- __, 10
  } -- Acc, MAcc
  sets.precast.WS['Shell Crusher'].MaxTP = set_combine(sets.precast.WS['Shell Crusher'], {
    ear2="Telos Earring",
    -- ear2="Crepuscular Earring",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  sets.midcast.Utsusemi = {
    ammo="Impatiens", -- SIRD
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    legs=gear.Nyame_B_legs, -- DT
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ring1="Defending Ring", -- DT
  }

  sets.midcast.RA = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Etoile Gorget +2",
    ear1="Telos Earring",
    ear2="Enervating Earring",
    ring1="Crepuscular Ring",
    ring2="Defending Ring",
    back=gear.DNC_TP_DA_Cape,
    waist="Yemaya Belt",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Overcapped DT to account for regain gear swap
  sets.HeavyDef = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs=gear.Nyame_B_legs,     --  8/ 8, 150
    feet=gear.Nyame_B_feet,     --  7/ 7, 150
    neck="Etoile Gorget +2",    -- __/__, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.DNC_TP_DW_Cape,   -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
  } --63 PDT/55 MDT, 697 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Turms Cap +1",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
  }
  sets.latent_regen = {
    head="Turms Cap +1",
    hands="Turms Mittens +1",
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

  sets.idle = set_combine(sets.HeavyDef, {
    head="Turms Cap +1",        -- __/__, 109
    body="Gleti's Cuirass",     --  9/__, 102
    hands="Gleti's Gauntlets",  --  7/__, 75
    legs="Gleti's Breeches",    --  8/__, 112
  })

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = sets.HeavyDef

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

  -- No DW (0-1 needed from gear)
  sets.engaged = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Windbuffet Belt +1",     -- __,  2, __ <__,  2,  2> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 0 DW, 66 STP, 272 Acc <25 DA, 17 TA, 2 QA> [34 PDT/24 MDT, 485 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    legs="Meghanada Chausses +2",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Regal Ring",
    waist="Olseni Belt",
  })

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 7 DW, 68 STP, 282 Acc <25 DA, 15 TA, 0 QA> [34 PDT/24 MDT, 485 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowDW.LowAcc = set_combine(sets.engaged.LowDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
    ring1="Chirich Ring +1",
  })
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW.LowAcc, {
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    hands="Mummu Wrists +2",
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    ammo="Cath Palug Stone",
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    -- waist="Olseni Belt",
  })

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 21 DW, 63 STP, 272 Acc <14 DA, 15 TA, 0 QA> [34 PDT/24 MDT, 493 M.Eva] 38 Subtle Blow
  }
  sets.engaged.MidDW.LowAcc = set_combine(sets.engaged.MidDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
    hands="Mummu Wrists +2",
  })
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.LowAcc, {
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    legs="Horos Tights +3",
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring1="Chirich Ring +1",
    ring2="Regal Ring",
    -- waist="Olseni Belt",
  })

  -- High DW (28 needed from gear)
  sets.engaged.HighDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 28 DW, 57 STP, 232 Acc <15 DA, 15 TA, 0 QA> [38 PDT/28 MDT, 445 M.Eva] 51 Subtle Blow
  }
  sets.engaged.HighDW.LowAcc = set_combine(sets.engaged.HighDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    head="Dampening Tam",
  })
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW.LowAcc, {
    head="Maxixi Tiara +3",         --  8, __, 47 <__, __, __> [__/__,  73] __(__)
    body="Horos Casaque +3",        -- __, __, 50 <__,  4, __> [ 6/__,  84] __(__)
    legs="Horos Tights +3",
    ring1="Chirich Ring +1",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear1="Dignitary's Earring",
    ring2="Regal Ring",
    -- waist="Olseni Belt",
  })

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 47 STP, 222 Acc <9 DA, 15 TA, 0 QA> [38 PDT/28 MDT, 453 M.Eva] 46 Subtle Blow
  }
  sets.engaged.SuperDW.LowAcc = set_combine(sets.engaged.SuperDW, {
    ammo="Yamarang",                -- __,  3, 15 <__, __, __> [__/__,  15] __(__)
    ring1="Chirich Ring +1",
  })
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW.LowAcc, {
    legs="Horos Tights +3",
    waist="Kentarch Belt +1",
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    -- TODO: Re-evaluate to avoid dropping DW
    ammo="Cath Palug Stone",
    body="Maxixi Casaque +3",
    hands="Mummu Wrists +2",
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    ear2="Dignitary's Earring",
    ring2="Regal Ring",
    -- waist="Olseni Belt",
  })

  -- TODO
  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Epona's Ring",           -- __, __, __ < 3,  3, __> [__/__, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 47 STP, 222 Acc <9 DA, 15 TA, 0 QA> [38 PDT/28 MDT, 453 M.Eva] 46 Subtle Blow
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

  -- No DW (0-1 needed from gear)
  sets.engaged.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Moonlight Ring",         -- __,  5, __ <__, __, __> [ 5/ 5, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Windbuffet Belt +1",     -- __,  2, __ <__,  2,  2> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             35, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 35 DW, 79 STP, 305 Acc <19 DA, 7 TA, 2 QA> [51 PDT/41 MDT, 629 M.Eva] 38 Subtle Blow
  }
  sets.engaged.HeavyDef.LowAcc = set_combine(sets.engaged.HeavyDef, {})
  sets.engaged.HeavyDef.MidAcc = set_combine(sets.engaged.HeavyDef.LowAcc, {})
  sets.engaged.HeavyDef.HighAcc = set_combine(sets.engaged.HeavyDef.MidAcc, {})

  -- Low DW (8 needed from gear)
  sets.engaged.LowDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DA_Cape,       -- __, __, 20 <10, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 7 DW, 73 STP, 280 Acc <22 DA, 8 TA, 0 QA> [49 PDT/39 MDT, 554 M.Eva] 38 Subtle Blow
  }
  sets.engaged.LowDW.HeavyDef.LowAcc = set_combine(sets.engaged.LowDW.HeavyDef, {})
  sets.engaged.LowDW.HeavyDef.MidAcc = set_combine(sets.engaged.LowDW.HeavyDef.LowAcc, {})
  sets.engaged.LowDW.HeavyDef.HighAcc = set_combine(sets.engaged.LowDW.HeavyDef.MidAcc, {})

  -- Mid DW (21 needed from gear)
  sets.engaged.MidDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Malignance Tabard",       -- __, 11, 50 <__, __, __> [ 9/ 9, 139] __(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts          -- __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 21 DW, 68 STP, 240 Acc <11 DA, 8 TA, 0 QA> [49 PDT/39 MDT, 562 M.Eva] 38 Subtle Blow
  }
  sets.engaged.MidDW.HeavyDef.LowAcc = set_combine(sets.engaged.MidDW.HeavyDef, {})
  sets.engaged.MidDW.HeavyDef.MidAcc = set_combine(sets.engaged.MidDW.HeavyDef.LowAcc, {})
  sets.engaged.MidDW.HeavyDef.HighAcc = set_combine(sets.engaged.MidDW.HeavyDef.MidAcc,{})

  -- High DW (28 needed from gear)
  sets.engaged.HighDW.HeavyDef = {
    ammo="Staunch Tathlum +1",      -- __, __, __ <__, __, __> [ 3/ 3, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands=gear.Adhemar_A_hands,     -- __,  7, 52 <__,  4, __> [__/__,  43] __(__)
    legs=gear.Samnuha_legs,         -- __,  7, 15 < 3,  3, __> [__/__,  75] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Telos Earring",           -- __,  5, 10 < 1, __, __> [__/__, ___] __(__)
    ear2="Sherida Earring",         -- __,  5, __ < 5, __, __> [__/__, ___] __( 5)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Gere Ring",              -- __, __, __ <__,  5, __> [__/__, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 28 DW, 54 STP, 232 Acc <9 DA, 12 TA, 0 QA> [51 PDT/41 MDT, 445 M.Eva] 51 Subtle Blow
  }
  sets.engaged.HighDW.HeavyDef.LowAcc = set_combine(sets.engaged.HighDW.HeavyDef, {})
  sets.engaged.HighDW.HeavyDef.MidAcc = set_combine(sets.engaged.HighDW.HeavyDef.LowAcc, {})
  sets.engaged.HighDW.HeavyDef.HighAcc = set_combine(sets.engaged.HighDW.HeavyDef.MidAcc, {})

  -- Super DW (39 needed from gear)
  sets.engaged.SuperDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Moonlight Ring",         -- __,  5, __ <__, __, __> [ 5/ 5, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 52 STP, 220 Acc <6 DA, 8 TA, 0 QA> [53 PDT/43 MDT, 522 M.Eva] 46 Subtle Blow
  }
  sets.engaged.SuperDW.HeavyDef.LowAcc = set_combine(sets.engaged.SuperDW.HeavyDef, {})
  sets.engaged.SuperDW.HeavyDef.MidAcc = set_combine(sets.engaged.SuperDW.HeavyDef.LowAcc, {})
  sets.engaged.SuperDW.HeavyDef.HighAcc = set_combine(sets.engaged.SuperDW.HeavyDef.MidAcc,{})

  -- TODO
  -- Max DW (46 needed from gear)
  sets.engaged.MaxDW.HeavyDef = {
    ammo="Coiste Bodhar",           -- __,  3, __ < 3, __, __> [__/__, ___] __(__)
    head="Malignance Chapeau",      -- __,  8, 50 <__, __, __> [ 6/ 6, 123] __(__)
    body="Maculele Casaque +2",     -- 11, __, __ <__, __, __> [13/13,  99] 13(__)
    hands="Malignance Gloves",      -- __, 12, 50 <__, __, __> [ 5/ 5, 112] __(__)
    legs="Malignance Tights",       -- __, 10, 50 <__, __, __> [ 7/ 7, 150] __(__)
    feet="Maculele Toe Shoes +2",   -- __, 11, 50 <__, __, __> [ 9/ 9, 105] __(__); Remove Close Position merits
    neck="Etoile Gorget +2",        -- __,  7, 25 <__, __, __> [__/__, ___] __(__)
    ear1="Suppanomimi",             --  5, __, __ <__, __, __> [__/__, ___] __(__)
    ear2="Eabani Earring",          --  4, __, __ <__, __, __> [__/__,   8] __(__)
    ring1="Defending Ring",         -- __, __, __ <__, __, __> [10/10, ___] __(__)
    ring2="Moonlight Ring",         -- __,  5, __ <__, __, __> [ 5/ 5, ___] __(__)
    back=gear.DNC_TP_DW_Cape,       -- 10, __, 20 <__, __, __> [10/__, ___] __(__)
    waist="Reiki Yotai",            --  7,  4, 10 <__, __, __> [__/__, ___] __(__)
    -- Traits/Merits/Gifts             __, __, __ <__, __, __> [__/__, ___] 33(__)
    -- 37 DW, 52 STP, 220 Acc <6 DA, 8 TA, 0 QA> [53 PDT/43 MDT, 522 M.Eva] 46 Subtle Blow
  }
  sets.engaged.MaxDW.HeavyDef.LowAcc = set_combine(sets.engaged.MaxDW.HeavyDef, {})
  sets.engaged.MaxDW.HeavyDef.MidAcc = set_combine(sets.engaged.MaxDW.HeavyDef.LowAcc, {})
  sets.engaged.MaxDW.HeavyDef.HighAcc = set_combine(sets.engaged.MaxDW.HeavyDef.MidAcc,{})


  sets.engaged.Safe = sets.engaged.HeavyDef
  sets.engaged.Safe.LowAcc = sets.engaged.HeavyDef.LowAcc
  sets.engaged.Safe.MidAcc = sets.engaged.HeavyDef.MidAcc
  sets.engaged.Safe.HighAcc = sets.engaged.HeavyDef.HighAcc

  sets.engaged.LowDW.Safe = sets.engaged.LowDW.HeavyDef
  sets.engaged.LowDW.Safe.LowAcc = sets.engaged.LowDW.HeavyDef.LowAcc
  sets.engaged.LowDW.Safe.MidAcc = sets.engaged.LowDW.HeavyDef.MidAcc
  sets.engaged.LowDW.Safe.HighAcc = sets.engaged.LowDW.HeavyDef.HighAcc

  sets.engaged.MidDW.Safe = sets.engaged.MidDW.HeavyDef
  sets.engaged.MidDW.Safe.LowAcc = sets.engaged.MidDW.HeavyDef.LowAcc
  sets.engaged.MidDW.Safe.MidAcc = sets.engaged.MidDW.HeavyDef.MidAcc
  sets.engaged.MidDW.Safe.HighAcc = sets.engaged.MidDW.HeavyDef.HighAcc

  sets.engaged.HighDW.Safe = sets.engaged.HighDW.HeavyDef
  sets.engaged.HighDW.Safe.LowAcc = sets.engaged.HighDW.HeavyDef.LowAcc
  sets.engaged.HighDW.Safe.MidAcc = sets.engaged.HighDW.HeavyDef.MidAcc
  sets.engaged.HighDW.Safe.HighAcc = sets.engaged.HighDW.HeavyDef.HighAcc

  sets.engaged.SuperDW.Safe = sets.engaged.SuperDW.HeavyDef
  sets.engaged.SuperDW.Safe.LowAcc = sets.engaged.SuperDW.HeavyDef.LowAcc
  sets.engaged.SuperDW.Safe.MidAcc = sets.engaged.SuperDW.HeavyDef.MidAcc
  sets.engaged.SuperDW.Safe.HighAcc = sets.engaged.SuperDW.HeavyDef.HighAcc

  sets.engaged.MaxDW.Safe = sets.engaged.MaxDW.HeavyDef
  sets.engaged.MaxDW.Safe.LowAcc = sets.engaged.MaxDW.HeavyDef.LowAcc
  sets.engaged.MaxDW.Safe.MidAcc = sets.engaged.MaxDW.HeavyDef.MidAcc
  sets.engaged.MaxDW.Safe.HighAcc = sets.engaged.MaxDW.HeavyDef.HighAcc


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
    head="Maculele Tiara +2",
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
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = sets.TreasureHunter

  sets.WeaponSet = {}
  sets.WeaponSet['Twashtar'] = {main="Twashtar", sub={name="Centovente", priority=1}}
  sets.WeaponSet['TwashtarAcc'] = {main="Twashtar", sub={name="Taming Sari", priority=1}}
  sets.WeaponSet['Terpsichore'] = {main="Terpsichore", sub="Twashtar"}
  sets.WeaponSet['H2H'] = {main="Karambit", sub=empty}
  sets.WeaponSet['Healing'] = {main="Enchufla", sub="Blurred Knife +1"}
  sets.WeaponSet['Staff'] = {main="Gozuki Mezuki", sub="Tzacab Grip"}
  sets.WeaponSet['Cleaving'] = {main="Tauret", sub="Twashtar"}

  -- Ranged weapon sets
  sets.WeaponSet['Throwing'] = {
    ranged="Albin Bane",
    ammo=empty,
  }
  sets.WeaponSet['Pulling'] = {
    ranged="Jinx Discus",
    ammo=empty,
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

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
    local climacticSet = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Climactic) or sets.precast.WS.Climactic
    if state.Buff['Climactic Flourish'] and climacticSet then
      equip(climacticSet)
    end
    local saSet = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].SA) or sets.precast.WS.SA
    if state.Buff['Sneak Attack'] and saSet then
      equip(saSet)
    end
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
    local safeSet = sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Safe
    if (state.HybridMode.value == 'Safe' or state.DefenseMode.value ~= 'None') and safeSet then
      equip(safeSet)
    end
  end
  if spell.type=='Waltz' and spell.english:startswith('Curing') then
    if spell.target.type == 'SELF' then
      equip(sets.precast.WaltzSelf)
    end
    if (state.HybridMode.value ~= 'Normal' or state.DefenseMode.value ~= 'None') then
      equip(sets.precast.WaltzSafe)
    end
  end

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
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
  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    equip({range=player.equipment.range, ammo=player.equipment.ammo})
    silibs.equip_ammo(spell, action, spellMap, eventArgs)
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
  update_dp_type() -- Requires DistancePlus addon
  check_gear()
  update_idle_groups()
  update_combat_form()
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 1 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
  else
    if silibs.get_dual_wield_needed() > 1 and silibs.get_dual_wield_needed() <= 8 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 8 and silibs.get_dual_wield_needed() <= 21 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 21 and silibs.get_dual_wield_needed() <= 28 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 28 and silibs.get_dual_wield_needed() <= 39 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 39 then
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

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    idleSet = set_combine(idleSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    meleeSet = set_combine(meleeSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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

  -- Keep ranged weapon/ammo equipped if in an RA mode.
  if state.RangedWeaponSet.current ~= 'None' then
    defenseSet = set_combine(defenseSet, {
      range=player.equipment.range,
      ammo=player.equipment.ammo
    })
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

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

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
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-- Requires DistancePlus addon
function update_dp_type()
  local weapon = nil
  local weapon_type = nil
  local weapon_subtype = nil

  -- Handle unequipped case
  if player.equipment.ranged ~= nil and player.equipment.ranged ~= 0 and player.equipment.ranged ~= 'empty' then
    weapon = res.items:with('name', player.equipment.ranged)
    weapon_type = res.skills[weapon.skill].en
    if weapon_type == 'Throwing' then
      weapon_subtype = 'throwing'
    end
  end

  -- Update addon if weapon type changed
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

function cycle_ranged_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.RangedWeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.RangedWeaponSet:cycleback()
  else
    state.RangedWeaponSet:reset()
  end

  add_to_chat(141, 'RA Weapon Set to '..string.char(31,1)..state.RangedWeaponSet.current)
  equip(sets.WeaponSet[state.RangedWeaponSet.current])
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
      elseif cmdParams[2] == 'reset' then
        cycle_weapons('reset')
      elseif cmdParams[2] == 'current' then
        cycle_weapons('current')
      end
    elseif cmdParams[1] == 'rangedweaponset' then
      if cmdParams[2] == 'cycle' then
        cycle_ranged_weapons('forward')
      elseif cmdParams[2] == 'cycleback' then
        cycle_ranged_weapons('back')
      elseif cmdParams[2] == 'reset' then
        cycle_ranged_weapons('reset')
      elseif cmdParams[2] == 'current' then
        cycle_ranged_weapons('current')
      end
    elseif cmdParams[1] == 'test' then
      test()
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
  set_macro_page(2, 2)
end

function test()
end
