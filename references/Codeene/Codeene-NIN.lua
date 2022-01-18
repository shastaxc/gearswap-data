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
--              [ ALT+F ]     		Cycle Toy Weapon Mode
--              [ ALT+G ]   		Cycleback Toy Weapon Mode
--              [ CTRL+F ]    		Reset Toy Weapon Mode
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
--  Other:
--              [ ALT+D ]           Cancel Invisible/Hide & Use Key
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
  include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

  silibs.use_weapon_rearm = true

  state.Buff.Migawari = buffactive.migawari or false
  state.Buff.Yonin = buffactive.Yonin or false
  state.Buff.Innin = buffactive.Innin or false
  state.Buff.Futae = buffactive.Futae or false
  state.Buff.Sange = buffactive.Sange or false

  include('Mote-TreasureHunter')

  -- For th_action_check():
  -- JA IDs for actions that always have TH: Provoke, Animated Flourish
  info.default_ja_ids = S{35, 204}
  -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
  info.default_u_ja_ids = S{201, 202, 203, 205, 207}

  lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

  lockstyleset = 19
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'CritRate', 'DT', 'Evasion')
  state.WeaponskillMode:options('Normal', 'MaxTp', 'LowAcc', 'LowAccMaxTp', 'MidAcc', 'MidAccMaxTp', 'HighAcc', 'HighAccMaxTp')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
  state.PhysicalDefenseMode:options('PDT', 'Evasion')

  state.MagicBurst = M(false, 'Magic Burst')
  state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
  state.CP = M(false, "Capacity Points Mode")
  state.RearmingLock = M(false, 'Rearming Lock')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Katana','GreatKatana','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}


  options.ninja_tool_warning_limit = 10

  -- Additional local binds
  include('Global-Binds.lua')

  send_command('lua l gearinfo')

  send_command('bind @w gs c toggle RearmingLock')
  
  send_command('bind !f gs c toyweapon cycle')
  send_command('bind !g gs c toyweapon cycleback')
  send_command('bind ^f gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` gs c toggle MagicBurst')
  
  --JA Keybinds
  send_command('bind @2 input /ja "Futae" <me>')
  send_command('bind !\' input /ja "Yonin" <me>; wait 1; input /ma "Gekka: Ichi" <me>')
  send_command('bind !; input /ja "Innin" <me>; wait 1; input /ma "Yain: Ichi" <me>')
  send_command('bind ^0 input /ja "Issekigan" <me>')
  
  --2hr JAs
  send_command('bind ![ input /ja "Mijin Gakure" <t>')
  send_command('bind !] input /ja "Mikage" <me>')
  
  --Magic Keybinds
  send_command('bind ^e input /ma "Migawari: Ichi" <me>')
  send_command('bind !e input /ma "Utsusemi: San" <me>')
  send_command('bind ^1 input /ma "Kurayami: Ni" <t>')
  send_command('bind ^2 input /ma "Dokumori: Ichi" <t>')
  send_command('bind ^3 input /ma "Aisha: Ichi" <t>')
  send_command('bind ^4 input /ma "Yurin: Ichi" <t>')
  send_command('bind ^5 input /ma "Kakka: Ichi" <me>')
  send_command('bind ^6 input /ma "Hojo: Ni" <t>')
  send_command('bind ^7 input /ma "Jubaku: Ichi" <t>')
  send_command('bind @3 input /ma "Katon: San" <t>')
  send_command('bind @4 input /ma "Suiton: San" <t>')
  send_command('bind @5 input /ma "Raiton: San" <t>')
  send_command('bind @6 input /ma "Doton: San" <t>')
  send_command('bind @7 input /ma "Huton: San" <t>')
  send_command('bind @8 input /ma "Hyoton: San" <t>')
  
  --Sub job JAs
  if player.sub_job == 'WAR' then
    send_command('unbind @9')
    send_command('bind !1 input /ja "Provoke" <t>; input /p Provoke > <t>')
	send_command('bind ^8 input /ja "Berserk" <me>; wait 1; input /ja "Aggressor" <me>')
	send_command('bind ^9 input /ja "Warcry" <me>')
	send_command('bind @0 input /ja "Defender" <me>')
  end
  
  if player.sub_job == 'DNC' then
    send_command('bind ^1 input /ja "Animated Flourish" <t>')
	send_command('bind ^8 input /ja "Haste Samba" <me>')
	send_command('bind ^9 input /ja "Stutter Step" <t>')
	send_command('bind @9 input /ja "Quick Step" <t>')
	send_command('bind @0 input /ja "Box Step" <t>')
  end

  send_command('bind @a gs c cycle AttackMode')
  send_command('bind @c gs c toggle CP')

  -- Whether a warning has been given for low ninja tools
  state.warned = M(false)

  select_default_macro_book()
  set_lockstyle()

  state.Auto_Kite = M(false, 'Auto_Kite')
  Haste = 0
  DW_needed = 0
  DW = false
  moving = false
  update_combat_form()
  determine_haste_group()
  
end

function user_unload()
  send_command('unbind !d')
  send_command('unbind !s')
  send_command('unbind @w')
  
  send_command('unbind !f')
  send_command('unbind !g')
  send_command('unbind ^f')
  
  send_command('unbind !e')
  send_command('unbind ^e')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @a')
  send_command('unbind @c')

  send_command('unbind !\'')
  send_command('unbind !;')
  send_command('unbind ![')
  send_command('unbind !]')
  
  send_command('unbind !1')
  send_command('unbind !2')
  send_command('unbind !3')
  send_command('unbind !4')
  send_command('unbind !5')
  send_command('unbind !6')
  send_command('unbind !7')
  send_command('unbind !8')
  send_command('unbind !9')
  send_command('unbind !0')
  
  send_command('unbind ^1')
  send_command('unbind ^2')
  send_command('unbind ^3')
  send_command('unbind ^4')
  send_command('unbind ^5')
  send_command('unbind ^6')
  send_command('unbind ^7')
  send_command('unbind ^8')
  send_command('unbind ^9')
  send_command('unbind ^0')
  
  send_command('unbind @1')
  send_command('unbind @2')
  send_command('unbind @3')
  send_command('unbind @4')
  send_command('unbind @5')
  send_command('unbind @6')
  send_command('unbind @7')
  send_command('unbind @8')
  send_command('unbind @9')
  send_command('unbind @0')
  
  send_command('unbind !q')
  send_command('unbind ^q')
  send_command('unbind @q')
  send_command('unbind !k')
  send_command('unbind !j')
  
  send_command('unbind home')
  send_command('unbind end')
  send_command('unbind !.')
  send_command('unbind !/')
  send_command('unbind !b')
  send_command('unbind !n')
  send_command('unbind !m')
  send_command('unbind !h')
  send_command('unbind !p')
  send_command('unbind !o')
  send_command('unbind !i')
  send_command('unbind !u')
   
  send_command('lua u gearinfo')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Precast sets
  --------------------------------------

  -- Enmity set
  sets.Enmity = {
    ammo="Date Shuriken", --3
    head={ name="Naga Somen", augments={'HP+50','VIT+10','Evasion+20',}}, --0
    body="Emet Harness +1", --10
	hands="Kurys Gloves", -- 9
    legs="Zoar Subligar +1", --6
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}}, --8
    neck="Unmoving Collar +1", --10
    waist="Trance Belt", --4
    left_ear="Friomisi Earring", --2
	right_ear="Cryptic Earring", --4
    left_ring="Eihwaz Ring", --5
    right_ring="Supershear Ring", --5
    back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}, --10
  }

  sets.precast.JA['Provoke'] = sets.Enmity
  sets.precast.JA['Warcry'] = sets.Enmity
  
  sets.precast.JA['Mijin Gakure'] = {
    legs="Mochi. Hakama +3"
  }
  sets.precast.JA['Futae'] = {  
    hands="Hattori Tekko +1"
  }
  sets.precast.JA['Sange'] = {
    body="Mochi. Chainmail +1"
  }
  sets.precast.JA['Innin'] = {
    head="Mochi. Hatsuburi +3"
  }
  sets.precast.JA['Yonin'] = {
    head="Mochi. Hatsuburi +3"
  }

  sets.precast.Waltz = {
    ammo="Yamarang",
	head="Mummu Bonnet +2",
    body="Passion Jacket",
	-- hands="Herculean Gloves",
    -- legs="Dashing Subligar",
	-- feet="Herculean Boots",
	left_ring="Valseur's Ring",
    right_ring="Asklepian Ring",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  -- Fast cast sets for spells

  sets.precast.FC = {
    ammo="Sapience Orb", --2
    head={ name="Herculean Helm", augments={'"Fast Cast"+4','CHR+1',}}, --11
    body={ name="Taeon Tabard", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. crit. hit dmg. +8%',}}, --8
	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}, --8
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','"Fast Cast"+5','MND+10','"Mag.Atk.Bns."+8',}}, --5
	feet={ name="Herculean Boots", augments={'"Fast Cast"+5','MND+3','Mag. Acc.+8',}}, --5
	neck="Orunmila's Torque", --5
    waist="Oneiros Belt", --0
    left_ear="Loquac. Earring", --2
    right_ear="Enchntr. Earring +1", --2
    left_ring="Prolix Ring", --2
	right_ring="Kishar Ring", --4
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}, --10
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

  sets.precast.RA = {}

  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {} -- default set
  sets.precast.WS.Safe = {}

  sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",
    head="Hachiya Hatsu. +3",
    body="Ken. Samue +1",
    hands="Mummu Wrists +2",
    legs="Mochi. Hakama +3",
    feet="Mummu Gamash. +2",
    neck="Rancor Collar",
    waist="Sailfi Belt +1",
    left_ear="Odr Earring",
    right_ear="Ishvara Earring",
    left_ring="Mummu Ring",
    right_ring="Petrov Ring",
    back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}},
  })
  sets.precast.WS['Blade: Hi'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Hi'].MaxTp = set_combine(sets.precast.WS['Blade: Hi'], {})
  sets.precast.WS['Blade: Hi'].LowAcc = set_combine(sets.precast.WS['Blade: Hi'], {})
  sets.precast.WS['Blade: Hi'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].LowAcc, {})
  sets.precast.WS['Blade: Hi'].MidAcc = set_combine(sets.precast.WS['Blade: Hi'].LowAcc, {})
  sets.precast.WS['Blade: Hi'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].MidAcc, {})
  sets.precast.WS['Blade: Hi'].HighAcc = set_combine(sets.precast.WS['Blade: Hi'].MidAcc, {})
  sets.precast.WS['Blade: Hi'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Hi'].HighAcc, {})

  sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Blade: Ten'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Ten'].MaxTp = set_combine(sets.precast.WS['Blade: Ten'], {})
  sets.precast.WS['Blade: Ten'].LowAcc = set_combine(sets.precast.WS['Blade: Ten'], {})
  sets.precast.WS['Blade: Ten'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].LowAcc, {})
  sets.precast.WS['Blade: Ten'].MidAcc = set_combine(sets.precast.WS['Blade: Ten'].LowAcc, {})
  sets.precast.WS['Blade: Ten'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].MidAcc, {})
  sets.precast.WS['Blade: Ten'].HighAcc = set_combine(sets.precast.WS['Blade: Ten'].MidAcc, {})
  sets.precast.WS['Blade: Ten'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Ten'].HighAcc, {})

  sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
    ammo="Voluspa Tathlum",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Mochi. Hakama +3",
    feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear="Lugra Earring +1",
    left_ring="Tyrant's Ring",
    right_ring="Ramuh Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  })
  sets.precast.WS['Blade: Shun'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Shun'].MaxTp = set_combine(sets.precast.WS['Blade: Shun'], {})
  sets.precast.WS['Blade: Shun'].LowAcc = set_combine(sets.precast.WS['Blade: Shun'], {})
  sets.precast.WS['Blade: Shun'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].LowAcc, {})
  sets.precast.WS['Blade: Shun'].MidAcc = set_combine(sets.precast.WS['Blade: Shun'].LowAcc, {})
  sets.precast.WS['Blade: Shun'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].MidAcc, {})
  sets.precast.WS['Blade: Shun'].HighAcc = set_combine(sets.precast.WS['Blade: Shun'].MidAcc, {})
  sets.precast.WS['Blade: Shun'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Shun'].HighAcc, {})

  sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Blade: Ku'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Ku'].MaxTp = set_combine(sets.precast.WS['Blade: Ku'], {})
  sets.precast.WS['Blade: Ku'].LowAcc = set_combine(sets.precast.WS['Blade: Ku'], {})
  sets.precast.WS['Blade: Ku'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].LowAcc, {})
  sets.precast.WS['Blade: Ku'].MidAcc = set_combine(sets.precast.WS['Blade: Ku'].LowAcc, {})
  sets.precast.WS['Blade: Ku'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].MidAcc, {})
  sets.precast.WS['Blade: Ku'].HighAcc = set_combine(sets.precast.WS['Blade: Ku'].MidAcc, {})
  sets.precast.WS['Blade: Ku'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Ku'].HighAcc, {})

  sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Blade: Kamu'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Kamu'].MaxTp = set_combine(sets.precast.WS['Blade: Kamu'], {})
  sets.precast.WS['Blade: Kamu'].LowAcc = set_combine(sets.precast.WS['Blade: Kamu'], {})
  sets.precast.WS['Blade: Kamu'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].LowAcc, {})
  sets.precast.WS['Blade: Kamu'].MidAcc = set_combine(sets.precast.WS['Blade: Kamu'].LowAcc, {})
  sets.precast.WS['Blade: Kamu'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].MidAcc, {})
  sets.precast.WS['Blade: Kamu'].HighAcc = set_combine(sets.precast.WS['Blade: Kamu'].MidAcc, {})
  sets.precast.WS['Blade: Kamu'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Kamu'].HighAcc, {})

  sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })
  sets.precast.WS['Blade: Yu'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Yu'].MaxTp = set_combine(sets.precast.WS['Blade: Yu'], {})
  sets.precast.WS['Blade: Yu'].LowAcc = set_combine(sets.precast.WS['Blade: Yu'], {})
  sets.precast.WS['Blade: Yu'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].LowAcc, {})
  sets.precast.WS['Blade: Yu'].MidAcc = set_combine(sets.precast.WS['Blade: Yu'].LowAcc, {})
  sets.precast.WS['Blade: Yu'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].MidAcc, {})
  sets.precast.WS['Blade: Yu'].HighAcc = set_combine(sets.precast.WS['Blade: Yu'].MidAcc, {})
  sets.precast.WS['Blade: Yu'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Yu'].HighAcc, {})
  
  sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })
  sets.precast.WS['Blade: Ei'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Ei'].MaxTp = set_combine(sets.precast.WS['Blade: Ei'], {})
  sets.precast.WS['Blade: Ei'].LowAcc = set_combine(sets.precast.WS['Blade: Ei'], {})
  sets.precast.WS['Blade: Ei'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Ei'].LowAcc, {})
  sets.precast.WS['Blade: Ei'].MidAcc = set_combine(sets.precast.WS['Blade: Ei'].LowAcc, {})
  sets.precast.WS['Blade: Ei'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Ei'].MidAcc, {})
  sets.precast.WS['Blade: Ei'].HighAcc = set_combine(sets.precast.WS['Blade: Ei'].MidAcc, {})
  sets.precast.WS['Blade: Ei'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Ei'].HighAcc, {})
  
  sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })
  sets.precast.WS['Blade: Chi'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: Chi'].MaxTp = set_combine(sets.precast.WS['Blade: Chi'], {})
  sets.precast.WS['Blade: Chi'].LowAcc = set_combine(sets.precast.WS['Blade: Chi'], {})
  sets.precast.WS['Blade: Chi'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: Chi'].LowAcc, {})
  sets.precast.WS['Blade: Chi'].MidAcc = set_combine(sets.precast.WS['Blade: Chi'].LowAcc, {})
  sets.precast.WS['Blade: Chi'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: Chi'].MidAcc, {})
  sets.precast.WS['Blade: Chi'].HighAcc = set_combine(sets.precast.WS['Blade: Chi'].MidAcc, {})
  sets.precast.WS['Blade: Chi'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: Chi'].HighAcc, {})
  
  sets.precast.WS['Blade: To'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })
  sets.precast.WS['Blade: To'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Blade: To'].MaxTp = set_combine(sets.precast.WS['Blade: To'], {})
  sets.precast.WS['Blade: To'].LowAcc = set_combine(sets.precast.WS['Blade: To'], {})
  sets.precast.WS['Blade: To'].LowAccMaxTp = set_combine(sets.precast.WS['Blade: To'].LowAcc, {})
  sets.precast.WS['Blade: To'].MidAcc = set_combine(sets.precast.WS['Blade: To'].LowAcc, {})
  sets.precast.WS['Blade: To'].MidAccMaxTp = set_combine(sets.precast.WS['Blade: To'].MidAcc, {})
  sets.precast.WS['Blade: To'].HighAcc = set_combine(sets.precast.WS['Blade: To'].MidAcc, {})
  sets.precast.WS['Blade: To'].HighAccMaxTp = set_combine(sets.precast.WS['Blade: To'].HighAcc, {})
  
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Date Shuriken",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear="Lugra Earring +1",
    left_ring="Tyrant's Ring",
    right_ring="Ramuh Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  })
  sets.precast.WS['Evisceration'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Evisceration'].MaxTp = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Evisceration'].LowAcc = set_combine(sets.precast.WS['Evisceration'], {})
  sets.precast.WS['Evisceration'].LowAccMaxTp = set_combine(sets.precast.WS['Evisceration'].LowAcc, {})
  sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'].LowAcc, {})
  sets.precast.WS['Evisceration'].MidAccMaxTp = set_combine(sets.precast.WS['Evisceration'].MidAcc, {})
  sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'].MidAcc, {})
  sets.precast.WS['Evisceration'].HighAccMaxTp = set_combine(sets.precast.WS['Evisceration'].HighAcc, {})  
  
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  })
  sets.precast.WS['Aeolian Edge'].Safe = set_combine(sets.precast.WS.Safe, {})
  sets.precast.WS['Aeolian Edge'].MaxTp = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].LowAcc = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].LowAccMaxTp = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {})
  sets.precast.WS['Aeolian Edge'].MidAcc = set_combine(sets.precast.WS['Aeolian Edge'].LowAcc, {})
  sets.precast.WS['Aeolian Edge'].MidAccMaxTp = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {})
  sets.precast.WS['Aeolian Edge'].HighAcc = set_combine(sets.precast.WS['Aeolian Edge'].MidAcc, {})
  sets.precast.WS['Aeolian Edge'].HighAccMaxTp = set_combine(sets.precast.WS['Aeolian Edge'].HighAcc, {})

  sets.Lugra = {
    left_ear="Lugra Earring"
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
    feet="Hattori Kyahan +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
  })

  sets.midcast.ElementalNinjutsu = {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Gyve Trousers",
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Baetyl Pendant",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring +1",
    right_ring="Metamorph Ring +1",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  }

  sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {
    -- neck="Sanctity Necklace",
    -- ring1={name="Stikini Ring +1", bag="wardrobe3"},
    -- ring2={name="Stikini Ring +1", bag="wardrobe4"},
    -- ear1="Enchntr. Earring +1",
  })

  sets.midcast.EnfeeblingNinjutsu = {
    ammo="Yamarang",
    head="Hachiya Hatsu. +3",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Hachiya Kyahan +3",
    neck="Incanter's Torque",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Hnoss Earring",
    left_ring="Mummu Ring",
    right_ring="Metamorph Ring",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
  }

  sets.midcast.EnhancingNinjutsu = {}

  sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

  sets.midcast.RA = {}

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    --ring2="Karieyh Ring",
  }
  sets.latent_regen = {
    --neck="Lissome Necklace",
    --ear1="Infused Earring",
  }
  sets.latent_refresh = {
    --legs="Rawhide Trousers",
  }

  -- Idle sets
  sets.idle = {
    ammo="Staunch Tathlum",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko +1",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
    waist="Patentia Sash",
    left_ear="Suppanomimi",
    right_ear="Eabani Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
  }

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.DT = {
    ammo="Staunch Tathlum",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko +1",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
    waist="Patentia Sash",
    left_ear="Suppanomimi",
    right_ear="Eabani Earring",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
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
    ammo="Date Shuriken", --Acc8
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9% Acc47
    body="Ken. Samue +1", --Acc81
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc94
    legs={ name="Mochi. Hakama +3", augments={'Enhances "Mijin Gakure" effect',}}, --10% Acc29
    feet="Hiza. Sune-Ate +2", --8% Acc65
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}}, --Acc22
    waist="Patentia Sash", --5% 
    left_ear="Suppanomimi", --5%
    right_ear="Eabani Earring", --4%
    left_ring="Mummu Ring", --Acc6 (+Acc6 for each extra Mummu piece)
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Acc42
  } -- 40/39% Acc394

  sets.engaged.CritRate = set_combine(sets.engaged, {
    head="Ken. Jinpachi +1",
	hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate",
	neck="Rancor Collar",
	left_ear="Brutal Earring",
	right_ear="Odr Earring",
	back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Crit.hit rate+10',}},
  })

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    legs="Mummu Kecks +2", --Acc53+6
	right_ear="Telos Earring", --Acc10
  }) --26% Acc434

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
	feet="Ken. Sune-Ate +1", --Acc81
    waist="Olseni Belt", --Acc20
    left_ear="Odr Earring", --Acc17
  }) --16% Acc487

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    sub="Shigi", --Acc35 (from Kaja Katana)
    head="Ken. Jinpachi +1", --Acc85
    right_ring="Supershear Ring", --Acc7
  }) --0% Acc567

  -- Low Magic/Gear/JA Haste (67% DW to cap, 32% from gear)
  sets.engaged.LowHaste = {
    ammo="Date Shuriken", --Acc8
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9 Acc47
    body="Ken. Samue +1", --Acc81
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc94
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --Acc26
    feet="Hiza. Sune-Ate +2", --8 Acc65
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}}, --Acc22
    waist="Patentia Sash", --5 
    left_ear="Suppanomimi", --5
    right_ear="Eabani Earring", --4
    left_ring="Mummu Ring", --Acc6 (+Acc6 for each extra Mummu piece)
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Acc42
  } -- 31% Acc391
  
  sets.engaged.CritRate.LowHaste = set_combine(sets.engaged.LowHaste, {
    head="Ken. Jinpachi +1",
	hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate",
	neck="Rancor Collar",
	left_ear="Brutal Earring",
	right_ear="Odr Earring",
	back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Crit.hit rate+10',}},
  })

  sets.engaged.LowAcc.LowHaste = set_combine(sets.engaged.LowHaste, {
    legs="Mummu Kecks +2", --Acc53+6
	right_ear="Telos Earring", --Acc10
  }) --18% Acc434

  sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    feet="Ken. Sune-Ate +1", --Acc81
    waist="Olseni Belt", --Acc20
    left_ear="Odr Earring", --Acc17
  }) --8% Acc487

  sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, {
    sub="Shigi", --Acc35 (from Kaja Katana)
    head="Ken. Jinpachi +1", --Acc85
    right_ring="Supershear Ring", --Acc7
  }) --0% Acc567

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 21% from gear)
  sets.engaged.MidHaste = {
    ammo="Date Shuriken", --Acc8
    head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9% Acc47
    body="Ken. Samue +1", --Acc81
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc94
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --Acc26
    feet="Hiza. Sune-Ate +2", --8 Acc65
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}}, --Acc22
    waist="Patentia Sash", --5
	left_ear="Brutal Earring",
    right_ear="Telos Earring", --Acc10
    left_ring="Mummu Ring", --Acc6 (+Acc6 for each extra Mummu piece)
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Acc42
  } -- 22% Acc401
  
  sets.engaged.CritRate.MidHaste = set_combine(sets.engaged.MidHaste, {
    head="Ken. Jinpachi +1",
	hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate",
	neck="Rancor Collar",
	right_ear="Odr Earring",
	back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Crit.hit rate+10',}},
  })

  sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
    legs="Mummu Kecks +2", --Acc53+6
    left_ear="Odr Earring", --Acc17
  }) --22% Acc451

  sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
    feet="Ken. Sune-Ate +1", --Acc81
    waist="Olseni Belt", --Acc20
    right_ring="Supershear Ring", --Acc7
  }) --17% Acc487

  sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.MidHaste.MidAcc, {
    sub="Shigi", --Acc35 (from Kaja Katana)
    head="Ken. Jinpachi +1", --Acc85
  }) --0% Acc567

  -- High Magic/Gear/JA Haste (51% DW to cap, 16% from gear)
  sets.engaged.HighHaste = {
    ammo="Date Shuriken", --Acc8
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc44
    body="Ken. Samue +1", --Acc81
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc94
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --Acc26
    feet="Hiza. Sune-Ate +2", --8 Acc65
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}}, --Acc22
    waist="Patentia Sash", --5
    left_ear="Brutal Earring",	
    right_ear="Telos Earring", --Acc10
    left_ring="Mummu Ring", --Acc6 (+Acc6 for each extra Mummu piece)
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Acc42
  } -- 12% Acc398
  
  sets.engaged.CritRate.HighHaste = set_combine(sets.engaged.HighHaste, {
    head="Ken. Jinpachi +1",
	hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate",
	neck="Rancor Collar",
	right_ear="Odr Earring",
	back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Crit.hit rate+10',}},
  })

  sets.engaged.LowAcc.HighHaste = set_combine(sets.engaged.HighHaste, {
    head="Ken. Jinpachi +1", --Acc85
	legs="Mummu Kecks +2", --Acc53+6
  }) --22% Acc472

  sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, {
    waist="Olseni Belt", --Acc20
    left_ear="Odr Earring", --Acc17
    right_ring="Supershear Ring", --Acc7
  }) --17% Acc516

  sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, {
    sub="Shigi", --Acc35 (from Kaja Katana)
	feet="Ken. Sune-Ate +1" --Acc81
  }) --0% Acc567

  -- Max Magic/Gear/JA Haste (36% DW to cap, 1% from gear)
  sets.engaged.MaxHaste = {
    ammo="Date Shuriken", --Acc8
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc44
    body="Ken. Samue +1", --Acc81
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, --Acc94
    legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --Acc26
    feet={ name="Herculean Boots", augments={'Accuracy+15','"Triple Atk."+4','AGI+7','Attack+9',}}, --Acc21
    neck={ name="Ninja Nodowa +2", augments={'Path: A',}}, --Acc22
    waist="Windbuffet Belt +1", --Acc2
    left_ear="Brutal Earring",	
    right_ear="Telos Earring", --Acc10
    left_ring="Mummu Ring", --Acc6 (+Acc6 for each extra Mummu piece)
    right_ring="Epona's Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}, --Acc42
  } --0% Acc368
  
  sets.engaged.CritRate.MaxHaste = set_combine(sets.engaged.MaxHaste, {
    head="Ken. Jinpachi +1",
	hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate",
	neck="Rancor Collar",
	right_ear="Odr Earring",
	back={ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Crit.hit rate+10',}},
  })	

  sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
    head="Ken. Jinpachi +1", --Acc73
	legs="Mummu Kecks +2", --Acc53
  }) --0% Acc430

  sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
    waist="Olseni Belt", --Acc20
    left_ear="Odr Earring", --Acc17
    right_ring="Supershear Ring", --Acc7
  }) --0% Acc472

  sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
    sub="Shigi", --Acc35 (from Kaja Katana)
    feet="Ken. Sune-Ate +1", --Acc81
  }) --0% Acc567

  sets.engaged.HybridDT = {
	ammo="Date Shuriken",
	head="Ken. Jinpachi +1",
    hands="Ken. Tekko +1",
	legs="Ken. Hakama +1",
	feet="Ken. Sune-Ate +1",
    left_ring="Hizamaru Ring",
  }
  
  sets.engaged.HybridEva = {
    ammo="Date Shuriken",
    head="Hiza. Somen　+2",
    body="Malignance Tabard",
    hands={ name="Shigure Tekko +1", augments={'Path: A',}},
    legs="Mummu Kecks +2",
    feet="Malignance Boots",
    neck="Bathy Choker +1",
    waist="Svelt. Gouriz +1",
    left_ear="Infused Earring",
    right_ear="Eabani Earring",
    left_ring="Hizamaru Ring",
    right_ring="Vengeful Ring",
    back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Dual Wield"+10','Evasion+15',}},
  }

  sets.engaged.Evasion = set_combine(sets.engaged, sets.engaged.HybridEva)

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.HybridDT)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.HybridDT)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.HybridDT)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.HybridDT)

  sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.HybridDT)
  sets.engaged.LowAcc.DT.LowHaste = set_combine(sets.engaged.LowAcc.LowHaste, sets.engaged.HybridDT)
  sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.HybridDT)
  sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.HybridDT)

  sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.HybridDT)
  sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.HybridDT)
  sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.HybridDT)
  sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.HybridDT)

  sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.HybridDT)
  sets.engaged.LowAcc.DT.HighHaste = set_combine(sets.engaged.LowAcc.HighHaste, sets.engaged.HybridDT)
  sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.HybridDT)
  sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.HybridDT)

  sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HybridDT)
  sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.HybridDT)
  sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.HybridDT)
  sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.HybridDT)

  --------------------------------------
  -- Custom buff sets
  --------------------------------------

  sets.buff.Migawari = {
    body="Hattori Ningi +1"
  }
  sets.buff.Yonin = {}
  sets.buff.Innin = {}
  sets.buff.Sange = {
    -- ammo="Hachiya Shuriken"
  }
  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    left_ring="Saida Ring", --15
    waist="Gishdubar Sash", --10
  }

  sets.DayMovement = {
    feet="Danzo sune-ate"
  }
  sets.NightMovement = {
    feet="Hachiya Kyahan +3"
  }
  sets.magic_burst = {
    ammo="Ghastly Tathlum +1",
    head={ name="Mochi. Hatsuburi +3", augments={'Enhances "Yonin" and "Innin" effect',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Herculean Gloves", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+5%',}},
    legs={ name="Herculean Trousers", augments={'Attack+21','Magic burst dmg.+7%','INT+5','Mag. Acc.+14',}},
    feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
    neck="Baetyl Pendant",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Static Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10','Damage taken-5%',}},
  }
  sets.CP = {
	  back={ name="Mecisto. Mantle", augments={'Cap. Point+43%','DEX+2','Rng. Atk.+1','DEF+6',}},
  }
  sets.TreasureHunter = {
    head="White Rarab Cap +1",
	body={ name="Herculean Vest", augments={'Crit. hit damage +1%','Sklchn.dmg.+2%','"Treasure Hunter"+1','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    waist="Chaac Belt"
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  sets.Kiting = {}
  determine_kiting_set()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  -- Blocks TP moves when out of range
  silibs.cancel_outranged_ws(spell, eventArgs)
  
  -- Blocks spells when unable to cast due to debuff
  silibs.cancel_on_blocking_status(spell, eventArgs)

  -- Downgrade elemental spell if higher tier is on cooldown
  refine_various_spells(spell, action, spellMap, eventArgs)
  
  -- Ninja tool status check
  if spell.skill == "Ninjutsu" then
    do_ninja_tool_checks(spell, spellMap, eventArgs)
  end
  
  -- Handle deletion of lower level shadows
  if spellMap == 'Utsusemi' then
	if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      send_command('cancel 66; cancel Copy Image; cancel 444; cancel Copy Image (2); cancel 445; cancel Copy Image (3); cancel 446; cancel Copy Image (4+)')
    end
  end
  
  if spell.english:startswith('Monomi') then
    send_command('cancel sneak')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
      equip(sets.Lugra)
    end
    if (spell.english == 'Blade: Teki' and (world.weather_element == spell.element or world.day_element == spell.element)) or
       (spell.english == 'Blade: To' and (world.weather_element == spell.element or world.day_element == spell.element)) or
       (spell.english == 'Blade: Chi' and (world.weather_element == spell.element or world.day_element == spell.element)) or
       (spell.english == 'Blade: Ei' and (world.weather_element == spell.element or world.day_element == spell.element)) or
       (spell.english == 'Blade: Yu' and (world.weather_element == spell.element or world.day_element == spell.element)) or
       (spell.english == 'Aeolian Edge' and (world.weather_element == spell.element or world.day_element == spell.element)) then
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
  if spellMap == 'ElementalNinjutsu' then
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
  determine_kiting_set()
  update_idle_groups()
  update_combat_form()
  determine_haste_group()
  check_moving()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  th_update(cmdParams, eventArgs)
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
  if state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'DT' then
    wsmode = 'Safe'
  elseif state.OffenseMode.value == 'LowAcc' then
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

  return defenseSet
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

-- Logic to handle downgrade elemental spell if higher tier is on cooldown
function refine_various_spells(spell, action, spellMap, eventArgs)
    fires = S{'Katon: Ichi','Katon: Ni','Katon: San'}
    waters = S{'Suiton: Ichi','Suiton: Ni','Suiton: San'}
    thunders = S{'Raiton: Ichi','Raiton: Ni','Raiton: San'}
	earths = S{'Doton: Ichi','Doton: Ni','Doton: San'}
	winds = S{'Huton: Ichi','Huton: Ni','Huton: San'}
	ices = S{'Hyoton: Ichi','Hyoton: Ni','Hyoton: San'}
	shadows = S{'Utsusemi: Ichi','Utsusemi: Ni','Utsusemi: San'}
 
    if not fires:contains(spell.english) and
	  not waters:contains(spell.english) and 
	  not thunders:contains(spell.english) and
	  not earths:contains(spell.english) and
	  not winds:contains(spell.english) and
	  not ices:contains(spell.english) and
	  not shadows:contains(spell.english) then
        return
    end
 
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
  
    if spell_recasts[spell.recast_id] > 0 then
        if fires:contains(spell.english) then
            if spell.english == 'Katon: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Katon: Ni' then
                newSpell = 'Katon: Ichi'
            elseif spell.english == 'Katon: San' then
                newSpell = 'Katon: Ni'
            end
        elseif waters:contains(spell.english) then
            if spell.english == 'Suiton: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Suiton: Ni' then
                newSpell = 'Suiton: Ichi'
            elseif spell.english == 'Suiton: San' then
                newSpell = 'Suiton: Ni'
            end
		elseif thunders:contains(spell.english) then
            if spell.english == 'Raiton: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Raiton: Ni' then
                newSpell = 'Raiton: Ichi'
            elseif spell.english == 'Raiton: San' then
                newSpell = 'Raiton: Ni'
            end
		elseif earths:contains(spell.english) then
            if spell.english == 'Doton: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Doton: Ni' then
                newSpell = 'Doton: Ichi'
            elseif spell.english == 'Doton: San' then
                newSpell = 'Doton: Ni'
            end
		elseif winds:contains(spell.english) then
            if spell.english == 'Huton: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Huton: Ni' then
                newSpell = 'Huton: Ichi'
            elseif spell.english == 'Huton: San' then
                newSpell = 'Huton: Ni'
            end
		elseif ices:contains(spell.english) then
            if spell.english == 'Hyoton: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Hyoton: Ni' then
                newSpell = 'Hyoton: Ichi'
            elseif spell.english == 'Hyoton: San' then
                newSpell = 'Hyoton: Ni'
            end
		elseif shadows:contains(spell.english) then
            if spell.english == 'Utsusemi: Ichi' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Utsusemi: Ni' then
                newSpell = 'Utsusemi: Ichi'
            elseif spell.english == 'Utsusemi: San' then
                newSpell = 'Utsusemi: Ni'
            end	
        end
    end
  
    if newSpell ~= spell.english then
        send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
        eventArgs.cancel = true
        return
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_kiting_set()
  if classes.CustomIdleGroups:contains('Adoulin') then
    sets.Kiting = {
      body="Councilor's Garb",
    }
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

function check_moving()
  if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
    if state.Auto_Kite.value == false and moving then
      state.Auto_Kite:set(true)
    elseif state.Auto_Kite.value == true and moving == false then
      state.Auto_Kite:set(false)
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
    if type(cmdParams[4]) == 'string' then
      if cmdParams[4] == 'true' then
        moving = true
      elseif cmdParams[4] == 'false' then
        moving = false
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'WAR' then
    set_macro_page(1, 15)
  elseif player.sub_job == 'DNC' then
    set_macro_page(5, 15)
  else
    set_macro_page(1, 15)
  end
end

function set_lockstyle()
  send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
