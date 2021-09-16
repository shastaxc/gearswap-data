-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2

  -- Load and initialize the include file.
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Executes on first load and main job change
function job_setup()
  include('Mote-TreasureHunter')
  --get_combat_weapon()
  update_melee_groups()

  state.CP = M(false, 'Capacity Points Mode')
  state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
  -- Options: Override default values
  state.OffenseMode:options('Normal', 'Mid', 'Acc')
  state.HybridMode:options('Normal', 'PDT')
  state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
  state.IdleMode:options('Normal', 'Sphere')
  state.RestingMode:options('Normal')
  state.PhysicalDefenseMode:options('PDT', 'Reraise')
  state.MagicalDefenseMode:options('MDT')
  state.WeaponLock = M(false, 'Weapon Lock')

  -- list of weaponskills that make better use of otomi helm in low acc situations
  wsList = S{'Tachi: Shoha'}
  gear.RAarrow = {name="Eminent Arrow"}
  LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow', 'Impulse Drive', 'Stardiver'}

  state.Buff.Sekkanoki = buffactive.sekkanoki or false
  state.Buff.Sengikori = buffactive.sengikori or false
  state.Buff['Third Eye'] = buffactive['Third Eye'] or false
  state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle WeaponLock')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  locked_style = false -- Do not modify
  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
  set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^`')
  send_command('unbind @c')

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

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark
Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo
--]]
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    Valorous = {}
    Valorous.Hands = {}
    Valorous.Hands.TP = { name="Valorous Mitts", augments={'Accuracy+26','"Store TP"+6','AGI+10',}}
    Valorous.Hands.WS = { name="Valorous Mitts", augments={'Accuracy+27','Weapon skill damage +4%','Accuracy+5 Attack+5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}


    Valorous.Feet = {}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}

    sets.TreasureHunter = {
        head="White rarab cap +1",
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }
    sets.precast.JA['Provoke'] = {
        -- ear1="Cryptic Earring",
        head="White rarab cap +1",
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
    }

    Smertrios = {}
    Smertrios.TP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Smertrios.WS = {name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto +2",
        hands="Sakonji Kote +1",
        back=Smertrios.TP
    }
    sets.precast.JA.Sekkanoki = {hands="Unkai Kote +2" }
    sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +2"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}

    sets.precast.FC = {
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        ring2="Weatherspoon Ring"
    }
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Organizer = {
        grip="Pearlsack",
        waist="Linkpearl",
    }
    sets.precast.RA = {
        head="Volte Tiara",
        hands="Buremte Gloves",
        feet="Ejekamal Boots",
        legs="Volte Tights"
    }
    sets.midcast.RA = {
        head="Volte Tiara",
        body="Kendatsuba Samue",
        legs="Kendatsuba Hakama",
        -- neck="Iqabi Necklace",
        hands="Ryuo Tekko",
        waist="Chaac Belt",
        ear2="Enervating Earring",
        ear1="Telos Earring",
        ring1="Cacoethic Ring +1",
        ring2="Hajduk Ring",
        feet="Wakido Sune-ate +2"
    }
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    --sets.Berserker       = { neck="Berserker's Torque" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.LugraMoonshade  = { ear1="Lugra Earring +1", ear2="Moonshade Earring" }
    sets.BrutalMoonshade = { ear1="Brutal Earring", ear2="Moonshade Earring" }
    --sets.LugraFlame      = { ear1="Lugra Earring +1", ear2="Flame Pearl" }
    --sets.FlameFlame      = { ear1="Flame Pearl", ear2="Flame Pearl" }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Valorous Mask",
        neck="Samurai's Nodowa +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        body="Sakonji Domaru +3",
        hands=Valorous.Hands.WS,
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=Smertrios.WS,
        waist="Sailfi Belt +1",
        legs="Wakido Haidate +3",
        feet=Valorous.Feet.WS
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        -- head="Rao Kabuto",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        feet="Flamma Gambieras +2",
    })

    sets.precast.WS['Namas Arrow'] = {
        ammo=gear.RAarrow,
        head="Valorous Mask",
        neck="Samurai's Nodowa +2",
        ear1="Thrud Earring",
        ear2="Ishvara Earring",
        body="Kendatsuba Samue",
        legs="Kendatsuba Hakama",
        hands="Ryuo Tekko",
        back=Smertrios.WS,
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        waist="Eschan Stone",
        -- legs="Hizamaru Hizayoroi +2",
        feet=Valorous.Feet.WS
    }
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
        body="Kyujutsugi",
    })
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
        ring2="Hajduk Ring"
    })

    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
        neck="Breeze Gorget",
        body="Kyujutsugi",
        ring2="Regal Ring"
    })
    sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        ring2="Longshot Ring"
    })

    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        ammo="Knobkierrie",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
    })
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
        head="Valorous Mask",
        ammo="Knobkierrie",
        --waist="Light Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        ammo="Knobkierrie",
        head="Valorous Mask",
        feet="Flamma Gambieras +2",
    })
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        feet=Valorous.Feet.WS
    })
    sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {
        head="Valorous Mask",
        hands=Valorous.Hands.WS,
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {
        feet="Flamma Gambieras +2",
    })

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        head="Stinger Helm +1",
        --head="Flamma Zucchetto +2",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        back=Smertrios.WS,
        feet="Flamma Gambieras +2",
    })
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS['Tachi: Shoha'], {
        waist="Thunder Belt",
    })
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {})

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS['Tachi: Shoha'], {
        neck="Samurai's Nodowa +2",
        waist="Soil Belt"
    })
    sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {})
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'].Mid, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
        neck="Samurai's Nodowa +2",
        waist="Soil Belt",
    })
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS['Tachi: Rana'], {
        body="Sakonji Domaru +3",
    })
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
        neck="Shadow Gorget",
        waist="Soil Belt",
    })
    -- CHR Mod
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
        feet="Flamma Gambieras +2",
        back=Smertrios.WS,
        ring2="Weatherspoon Ring",
        legs="Wakido Haidate +3",
        waist="Soil Belt",
    })

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {waist="Light Belt"})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Aqua Gorget",waist="Windbuffet Belt +1"})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Windbuffet Belt +1"})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
        head="Kendatsuba Jinpachi +1",
        body="Founder's Breastplate",
        hands="Founder's Gauntlets",
        neck="Shadow Gorget",
        waist="Soil Belt",
        feet="Founder's Greaves"
    })

    sets.midcast['Blue Magic'] = set_combine(sets.precast.WS['Tachi: Ageha'], {
        ear2="Gwati Earring", -- 3
        waist="Eschan Stone", -- 5
        ring1="Sangoma Ring", -- 10
        ring2="Weatherspoon Ring", -- 10 macc
        back="Aput Mantle",
        legs="Flamma Dirs +2"
    })
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	-- head="Otomi Helm",
        -- body="Kyujutsugi",
    	-- legs="Wakido Haidate +1",
        -- feet="Ejekamal Boots"
        waist="Sailfi Belt +1"
    }
    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        -- head="Twilight Helm",
        -- body="Twilight Mail",
        ring2="Paguroidea Ring"
    }

    sets.idle = set_combine({
        ammo="Staunch Tathlum",
        head="Valorous Mask",
        neck="Sanctity Necklace",
        ear1="Etiolation Earring",
        ear2="Genmei Earring",
   	    body="Tartarus Platemail",
        hands="Kendatsuba Tekko +1",
        ring1="Dark Ring",
        ring2="Defending Ring",
        back=Smertrios.TP,
        waist="Flume Belt",
        legs="Kendatsuba Hakama +1",
        feet="Danzo Sune-ate"
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="Rao Kabuto",
        neck="Sanctity Necklace",
        ring2="Paguroidea Ring",
        ear2="Infused Earring",
   	    body="Hizamaru Haramaki +2",
        back=Smertrios.TP,
        feet="Danzo Sune-ate"
    })

    sets.idle.Sphere = set_combine(sets.idle, { body="Makora Meikogai"  })

    sets.idle.Weak = set_combine(sets.idle.Field, {
        -- head="Twilight Helm",
    	-- body="Twilight Mail"
    })

    -- Defense sets
    sets.defense.PDT = {
        --head="Otronif Mask +1",
        neck="Agitator's Collar",
   	    body="Tartarus Platemail",
        --hands="Otronif Gloves +1",
        ring1="Dark Ring",
        ring2="Defending Ring",
    	back=Smertrios.TP,
        waist="Flume Belt",
        --legs="Otronif Brais +1",
        --feet="Otronif Boots +1"
    }

    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	head="Twilight Helm",
    	body="Twilight Mail"
    })

    sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
    	back=Smertrios.TP,
    })

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- I generally use Anahera outside of Adoulin areas, so this set aims for 47 STP + 5 from Anahera (52 total)
    -- Note, this set assumes use of Cibitshavore (hence the arrow as ammo)
    sets.engaged = {
        sub="Utu Grip",
        ammo="Ginsen",
        head="Flamma Zucchetto +2",
        --neck="Moonbeam Nodowa",
        neck="Samurai's Nodowa +2",
        ear1="Brutal Earring",
        ear2="Dedition Earring",
        body="Kasuga Domaru +1",
        hands="Wakido Kote +3",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
        back=Smertrios.TP,
        waist="Sailfi Belt +1",
        legs="Ryuo Hakama",
        --feet="Flamma Gambieras +2"
        feet="Tatenashi Sune-ate +1"
    }

    sets.engaged.Mid = set_combine(sets.engaged, {
        -- hands=Valorous.Hands.TP,
        neck="Samurai's Nodowa +2",
        body="Kendatsuba Samue +1",
        ear1="Telos Earring",
        ear2="Cessance Earring",
        legs="Kendatsuba Hakama +1",
        waist="Ioskeha Belt",
        ring1="Niqmaddu Ring",
        ring2="Flamma Ring",
        feet="Tatenashi Sune-ate +1"
        --body="Kendatsuba Samue",
        --legs="Kendatsuba Hakama",
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        head="Kendatsuba Jinpachi +1",
        neck="Samurai's Nodowa +2",
        body="Kendatsuba Samue +1",
        legs="Kendatsuba Hakama +1",
        ring2="Regal Ring",
        feet="Kendatsuba Sune-ate +1"
    })

    sets.engaged.PDT = set_combine(sets.engaged.Acc, {
        -- ammo="Staunch Tathlum",
   	    body="Tartarus Platemail",
        -- neck="Twilight Torque",
        ring2="Defending Ring",
        legs="Kendatsuba Hakama +1",
        feet="Kendatsuba Sune-ate +1"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.PDT, {
        --neck="Agitator's Collar",
   	    body="Tartarus Platemail",
        ring2="Defending Ring"
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Mid.PDT, {
        ammo="Ginsen",
   	    body="Tartarus Platemail",
        neck="Agitator's Collar",
        ring2="Defending Ring"
    })

    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })

    sets.buff.Sekkanoki = {hands="unkai kote +2"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}

    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
    --sets.seigan = {hands="Otronif Gloves +1"}
    sets.bow = {ammo=gear.RAarrow}

    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }

    sets.buff.Doom = {
      -- neck="Nicander's Necklace", --20
      -- ring2="Eshmun's Ring", --20
      waist="Gishdubar Sash", --10
    }

    sets.Reive = {
      neck="Ygnas's Resolve +1",
    }
    sets.CP = {
      back="Aptitude Mantle",
    }
    sets.Kiting = {
      feet="Danzo Sune-ate",
    }
    sets.Kiting.Adoulin = {
      body="Councilor's Garb",
    }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
  -- Don't gearswap if status forbids the action
  local forbidden_statuses = action_type_blocks[spell.action_type]
  for k,status in pairs(forbidden_statuses) do
    if buffactive[status] then
      add_to_chat(167, 'Stopped due to status.')
      eventArgs.cancel = true -- Stops the rest of the pipeline from executing
      return -- Ends execution of this function
    end
  end
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        if state.CP.value then
            equip(sets.CP)
        end
        if is_sc_element_today(spell) then
            if wsList:contains(spell.english) then
                equip(sets.WSDayBonus)
            end
        end
        -- if LugraWSList:contains(spell.english) then
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.LugraFlame)
        --         else
        --             equip(sets.LugraMoonshade)
        --         end
        --     else
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.FlameFlame)
        --         else
        --             equip(sets.BrutalMoonshade)
        --         end
        --     end
        -- end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    update_am_type(spell)
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if player.hpp < 90 then
      idleSet = set_combine(idleSet, sets.idle.Regen)
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
  if state.Buff['Seigan'] then
      if state.DefenseMode.value == 'PDT' then
        meleeSet = set_combine(meleeSet, sets.thirdeye)
      else
          meleeSet = set_combine(meleeSet, sets.seigan)
      end
  end
  if state.CP.value then
      meleeSet = set_combine(meleeSet, sets.CP)
  end
  if player.equipment.range == 'Yoichinoyumi' then
      meleeSet = set_combine(meleeSet, sets.bow)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        if player.inventory['Eminent Arrow'] then
            gear.RAarrow.name = 'Eminent Arrow'
        elseif player.inventory['Tulfaire Arrow'] then
            gear.RAarrow.name = 'Tulfaire Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
    elseif newStatus == 'Idle' then
        update_idle_groups()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  if state.Buff[buff] ~= nil then
    state.Buff[buff] = gain
      handle_equipping_gear(player.status)
  end

  if S{'madrigal'}:contains(buff:lower()) then
      if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
          equip(sets.MadrigalBonus)
      end
  end
  if S{'aftermath'}:contains(buff:lower()) then
      classes.CustomMeleeGroups:clear()

      if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
          classes.CustomMeleeGroups:clear()
      elseif player.equipment.main == 'Kogarasumaru'  then
          if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
              classes.CustomMeleeGroups:append('AM3')
          end
      elseif buff == "Aftermath" and gain or buffactive.Aftermath then
          classes.CustomMeleeGroups:append('AM')
      end
  end

  if not midaction() then
    handle_equipping_gear(player.status)
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
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
  update_melee_groups()
    --get_combat_weapon()
  update_weaponskill_binds()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_idle_groups()
  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

function seigan_thirdeye_active()
  return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
  classes.CustomMeleeGroups:clear()

  if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
      -- prevents using Amano AM while overriding it with Yoichi AM
      classes.CustomMeleeGroups:clear()
  elseif player.equipment.main == 'Kogarasumaru' then
      if buffactive['Aftermath: Lv.3'] then
          classes.CustomMeleeGroups:append('AM3')
      end
  else
      if buffactive['Aftermath'] then
          classes.CustomMeleeGroups:append('AM')
      end
  end
end

-- call this in job_post_precast()
function update_am_type(spell)
  if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
      if player.equipment.main == 'Amanomurakumo' then
          -- Yoichi AM overwrites Amano AM
          state.YoichiAM:set(true)
      end
  else
      state.YoichiAM:set(false)
  end
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

function check_gear()
  if no_swap_rings:contains(player.equipment.ring1) then
      disable("ring1")
  else
      enable("ring1")
  end
  if no_swap_rings:contains(player.equipment.ring2) then
      disable("ring2")
  else
      enable("ring2")
  end
end

windower.register_event('zone change',
    function()
        if no_swap_rings:contains(player.equipment.ring1) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_rings:contains(player.equipment.ring2) then
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
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 2)
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