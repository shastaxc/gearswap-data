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
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
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
    send_command('gs reorg')
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
  silibs.enable_auto_lockstyle(1)
  silibs.enable_premade_commands()
  silibs.enable_th()

  state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'MaxAcc')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'DT')
  state.IdleMode:options('Normal', 'DT')
  state.AttCapped = M(true, "Attack Capped")
  
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^f8 gs c toggle AttCapped')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
      'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
  wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Hasso" <me>')
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
  end

  -- send_command('bind !q input /ja "Jump" <t>')
  -- send_command('bind !w input /ja "High Jump" <t>')
  -- send_command('bind !e input /ja "Spirit Jump" <t>')
  -- send_command('bind !1 input /ja "Soul Jump" <t>')
  -- send_command('bind !2 input /ja "Super Jump" <t>')

  update_melee_groups()
  select_default_macro_book()
end

function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^f8')

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail +3"}
  sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +3"}
  sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}

  sets.precast.JA['Spirit Link'] = {
    head="Vishap Armet +3",
    hands="Peltast's Vambraces +1",
    feet="Pteroslaver Greaves +3",
    ear1="Pratik Earring",
  }

  sets.precast.JA['Steady Wing'] = {
    legs="Vishap Brais +3",
    feet="Pteroslaver Greaves +3",
    neck="Chanoix's Gorget",
    ear1="Lancer's Earring",
    ear2="Anastasi Earring",
    back="Updraft Mantle",
  }

  sets.precast.JA['Jump'] = {
    ammo="Aurgelmir Orb +1",
    head="Flamma Zucchetto +2",
    body="Vishap Mail +3",
    hands="Vishap Finger Gauntlets +3",
    legs="Pteroslaver Brais +3",
    feet="Ostro Greaves",
    neck="Anu Torque",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Chirich Ring +1",
    ring2="Niqmaddu Ring",
    back=gear.DRG_JMP_Cape,
    waist="Ioskeha Belt +1",
  }
  sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
  sets.precast.JA['Spirit Jump'] = sets.precast.JA['Jump']
  sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
    body="Vishap Mail +3",
    hands="Emicho Gauntlets +1",
    legs=gear.Valo_STP_legs
  })
  sets.precast.JA['Super Jump'] = {}

  sets.precast.JA['Angon'] = {
    ammo="Angon",
    hands="Pteroslaver Finger Gauntlets +3"
  }

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Sapience Orb", --2
    head="Carmine Mask +1", --14
    body="Sacro Breastplate", --10
    hands="Leyline Gloves", --8
    legs="Ayanmo Cosciales +2", --6
    feet="Carmine Greaves +1", --8
    neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    ear2="Enchanter's Earring +1", --2
    ring2="Weatherspoon Ring +1", --6(4)
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",
    head=gear.Valo_WSD_head,
    body=gear.Valo_WSD_body,
    hands="Pteroslaver Finger Gauntlets +3",
    legs="Vishap Brais +3",
    feet="Sulevia's Leggings +2",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Fotia Belt",
  }

  sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

  sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
    neck="Dragoon's Collar +1",
    ear2="Ishvara Earring",
    ring2="Epaminondas's Ring",
    waist="Sailfi Belt +1",
  })
  sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"], {})

  sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
    head="Flamma Zucchetto +2",
    body="Hjarrandi Breastplate",
    hands="Flamma Manopolas +2",
    legs="Zoar Subligar +1",
    neck="Dragoon's Collar +1",
    ear2="Brutal Earring",
    ring1="Begrudging Ring",
    back=gear.DRG_WS4_Cape,
    waist="Sailfi Belt +1",
  })
  sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {
    waist="Ioskeha Belt +1",
  })

  sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
    head="Lustratio Cap +1",
    legs="Lustratio Subligar +1",
    ear2="Mache Earring +1",
    ring2="Epaminondas's Ring",
    back=gear.DRG_WS3_Cape,
  })
  sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})

  sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS["Camlann's Torment"], {
    head="Flamma Zucchetto +2",
    body="Hjarrandi Breastplate",
    hands="Flamma Manopolas +2",
    legs="Pelt. Cuissots +1",
    neck="Dragoon's Collar +1",
    ear2="Moonshade Earring",
    ring1="Begrudging Ring",
    ring2="Epaminondas's Ring",
    back=gear.DRG_WS4_Cape,
    waist="Sailfi Belt +1",
  })
  sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
    legs="Vishap Brais +3",
    waist="Ioskeha Belt +1",
  })

  sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
    head=gear.Valo_WSD_head,
    body=gear.Valo_WSD_body,
    hands="Pteroslaver Finger Gauntlets +3",
    legs="Vishap Brais +3",
    back=gear.DRG_WS2_Cape,
    ear2="Ishvara Earring",
    ring1="Regal Ring",
  })

  sets.precast.WS['Sonic Thrust'] = sets.precast.WS["Camlann's Torment"]
  sets.precast.WS['Sonic Thrust'].Acc = sets.precast.WS["Camlann's Torment"].Acc

  sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
    head="Flamma Zucchetto +2",
    body=gear.Valo_TP_body,
    hands="Sulevia's Gauntlets +2",
    neck="Fotia Gorget",
    legs="Sulevia's Cuisses +2",
    feet="Flamma Gambieras +2",
    back=gear.DRG_WS1_Cape,
  })
  sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {
    head="Pteroslaver Armet +3",
    feet="Pteroslaver Greaves +3",
  })

  sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    body="Carm. Sc. Mail +1",
    hands="Carmine Fin. Ga. +1",
    ear1="Crematio Earring",
    ear2="Friomisi Earring",
    ring1="Shiva Ring +1",
    back="Argochampsa Mantle",
  })

  sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']

  sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    head="Flamma Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flamma Gambieras +2",
    ear1="Digni. Earring",
    ring1="Metamor. Ring +1",
    ring2="Weatherspoon Ring +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.HealingBreath = {
    head="Pteroslaver Armet +3",
    body=gear.Acro_Pet_body,
    hands=gear.Acro_Pet_hands,
    legs="Vishap Brais +3",
    feet="Pteroslaver Greaves +3",
    neck="Dragoon's Collar +1",
    ear1="Lancer's Earring",
    ear2="Anastasi Earring",
    back="Updraft Mantle",
    waist="Glassblower's Belt",
  }

  sets.midcast.ElementalBreath = {
    head="Pteroslaver Armet +3",
    body=gear.Acro_Pet_body,
    hands=gear.Acro_Pet_hands,
    neck="Lancer's Torque",
    ear1="Enmerkar Earring",
    ear2="Dragoon's Earring",
    ring1="C. Palug Ring",
    back="Updraft Mantle",
    waist="Glassblower's Belt",
  }

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.idle = {
    ammo="Staunch Tathlum +1", --3/3
    head="Hjarrandi Helm", --10/10
    body="Sacro Breastplate",
    hands="Sulevia's Gauntlets +2", --5/5
    legs="Carmine Cuisses +1",
    feet="Pteroslaver Greaves +3",
    neck="Bathy Choker +1",
    ear1="Eabani Earring",
    ear2="Sanare Earring",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2={name="Chirich Ring +1", bag="wardrobe4"},
    back="Moonlight Cape", --6/6
    waist="Flume Belt +1", --4/0
  }

  sets.idle.DT = set_combine(sets.idle, {
    ammo="Staunch Tathlum +1", --3/3
    body="Hjarrandi Breastplate", --12/12
    head="Hjarrandi Helm", --10/10
    hands="Flam. Manopolas +2",
    feet="Pteroslaver Greaves +3",
    neck="Loricate Torque +1", --6/6
    ear1="Sanare Earring",
    ear2="Anastasi Earring",
    ring1="Moonlight Ring", --5/5
    ring2="Defending Ring", --10/10
    waist="Carrier's Sash",
  })

  sets.idle.Pet = set_combine(sets.idle, {
    body="Vishap Mail +3",
    hands="Pteroslaver Finger Gauntlets +3",
    feet="Pteroslaver Greaves +3",
    neck="Dragoon's Collar +1",
    ear1="Enmerkar Earring",
    ear2="Anastasi Earring",
    waist="Isa Belt",
  })

  sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
    head="Hjarrandi Helm", --10/10
    body="Emicho Haubert +1",
    legs="Pteroslaver Brais +3",
    neck="Dragoon's Collar +1",
    ring1="Moonlight Ring", --5/5
    ring2="Defending Ring", --10/10
    back="Moonlight Cape", --6/6
  })

  sets.idle.Town = set_combine(sets.idle, {
    ammo="Aurgelmir Orb +1",
    head="Pteroslaver Armet +3",
    hands="Pteroslaver Finger Gauntlets +3",
    feet="Pteroslaver Greaves +3",
    neck="Dragoon's Collar +1",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    back=gear.DRG_TP_Cape,
    waist="Ioskeha Belt +1",
  })

  sets.idle.Weak = sets.idle.DT
  sets.Kiting = {
    legs="Carmine Cuisses +1"
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.idle.DT
  sets.defense.MDT = sets.idle.DT

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Aurgelmir Orb +1",
    head="Flamma Zucchetto +2",
    body=gear.Valo_TP_body,
    hands="Sulevia's Gauntlets +2",
    legs=gear.Valo_TP_legs,
    feet="Flamma Gambieras +2",
    neck="Anu Torque",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1={name="Chirich Ring +1", bag="wardrobe3"},
    ring2="Niqmaddu Ring",
    back=gear.DRG_TP_Cape,
    waist="Sailfi Belt +1",
  }

  sets.engaged.LowAcc = set_combine(sets.engaged, {
    neck="Combatant's Torque",
    ear2="Cessance Earring",
    waist="Ioskeha Belt +1",
  })

  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    ammo="Voluspa Tathlum",
    neck="Shulmanu Collar",
    ring1="Flamma Ring",
    ear2="Telos Earring",
  })

  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ammo="Amar Cluster",
    body="Emicho Haubert +1",
    hands="Emicho Gauntlets +1",
    legs=gear.Valo_STP_legs,
    ring1="Regal Ring",
  })

  sets.engaged.MaxAcc = set_combine(sets.engaged.HighAcc, {
    body="Vishap Mail +3",
    head="Vishap Armet +3",
    legs="Pteroslaver Brais +3",
    feet="Vishap Greaves +3",
    ear2="Mache Earring +1",
    ring1="Flamma Ring",
  })

  sets.engaged.STP = set_combine(sets.engaged, {
    hands=gear.Acro_STP_hands,
    legs=gear.Valo_STP_legs,
    ear2="Telos Earring",
    back=gear.DRG_JMP_Cape,
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.Hybrid = {
    neck="Loricate Torque +1", --6/6
    body="Vishap Mail +3",
    ring1="Moonlight Ring", --5/5
    ring2="Defending Ring", --10/10
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
  sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
  sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
  sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.CP = {
    back=gear.CP_Cape,
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
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- Wyvern Commands
  if spell.name == 'Dismiss' and pet.hpp < 100 then
    eventArgs.cancel = true
    add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
  elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
    equip(sets.precast.HealingBreath)
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs) 
  if spell.type == 'WeaponSkill' then
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
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
  if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
    equip(sets.midcast.HealingBreath)
  elseif wyv_elem_breath:contains(spell.english) then
    equip(sets.midcast.ElementalBreath)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  if buff == 'Hasso' and not gain then
    add_to_chat(167, 'Hasso just expired!')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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
  if state.Buff['Boost'] or info.boost_temp_lock then
    meleeSet = set_combine(meleeSet, sets.BoostRegain)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if state.EnmityMode.current == 'Low' then
    equip(sets.Special.LowEnmity)
  end

  -- Override sets to ensure counterstance feet are equipped if Counterstance is up
  if state.Buff['Counterstance'] then
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

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
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

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
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
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
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
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
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

function update_melee_groups()
  classes.CustomMeleeGroups:clear()
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
  set_macro_page(1, 1)
end
