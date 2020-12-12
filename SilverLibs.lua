-------------------------------------------------------------------------------
-- Includes/imports
-------------------------------------------------------------------------------
res = include('resources')


-------------------------------------------------------------------------------
-- Constants and maps
-------------------------------------------------------------------------------
range_mult = {
  [2] = 1.55,
  [3] = 1.490909,
  [4] = 1.44,
  [5] = 1.377778,
  [6] = 1.30,
  [7] = 1.15,
  [8] = 1.25,
  [9] = 1.377778,
  [10] = 1.45,
  [11] = 1.454545454545455,
  [12] = 1.666666666666667,
}

action_type_blocks = {
  ['Magic'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'silence', 'mute', 'Omerta'},
  ['Ranged Attack'] = {'terror', 'petrification', 'stun', 'sleep', 'charm'},
  ['Ability'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'amnesia', 'impairment'},
  ['Item'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'muddle'},
  ['Monster Move'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'amnesia'},
}

-- DO NOT OVERWRITE THESE. You can use your own custom keybinds by copying this table
--   to your globals file and changing the bindings there.
-- To overwrite, create table with the same format, but named user_ws_bindings.
-- Your bindings will be used instead of the default for the entire weapon type table.
--   For example, if you have a 'Hand-to-Hand' table defined, none of the default 'Hand-to-Hand'
--   keybinds will be used.
-- Bindings will be set from top to bottom within a weapon type category. Ex. In Dagger
--   category, if 'Default' table is first, those will be set. If you then have 'MNK' table
--   and you are main job MNK, those bindings will overwrite default. If you have a '/WAR'
--   table after that, then those keybinds will overwrite the previous ones if you are sub
--   job WAR.
default_ws_bindings = {
  ['Hand-to-Hand'] = {
    ['Default'] = {
      ['^numpad7'] = "Victory Smite", --empyrean
      ['^numpad8'] = "",
      ['^numpad9'] = "Final Heaven", --relic
      ['^numpad4'] = "Asuran Fists", --ambuscade
      ['^numpad5'] = "Shijin Spiral", --aeonic
      ['^numpad6'] = "Shoulder Tackle",
      ['^numpad1'] = "Spinning Attack", --aoe
      ['^numpad2'] = "Raging Fists",
      ['^numpad3'] = "Howling Fist",
    },
    ['MNK'] = {
      ['^numpad8'] = "Ascetic's Fury", --mythic
    },
    ['PUP'] = {
      ['^numpad8'] = "Stringing Pummel", --mythic
    },
  },
  ['Dagger'] = {
    ['Default'] = {
      ['^numpad7'] = "Rudra's Storm", --empyrean
      ['^numpad8'] = "",
      ['^numpad9'] = "Mercy Stroke", --relic
      ['^numpad4'] = "Evisceration", --ambuscade
      ['^numpad5'] = "Exenterator", --aeonic
      ['^numpad6'] = "Shark Bite",
      ['^numpad1'] = "Aeolian Edge", --aoe
      ['^numpad2'] = "Cyclone", --elemental
      ['^numpad3'] = "Energy Drain", --elemental
    },
    ['THF'] = {
      ['^numpad8'] = "Mandalic Stab", --mythic
    },
    ['DNC'] = {
      ['^numpad8'] = "Pyrrhic Kleos", --mythic
    },
    ['BRD'] = {
      ['^numpad8'] = "Mordant Rime", --mythic
    },
  },
  ['Sword'] = {
    ['Default'] = {
      ['^numpad7'] = "Chant du Cygne", --empyrean
      ['^numpad8'] = "",
      ['^numpad9'] = "Knights of Round", --relic
      ['^numpad4'] = "Savage Blade", --ambuscade
      ['^numpad5'] = "Requiescat", --aeonic
      ['^numpad6'] = "Sanguine Blade",
      ['^numpad1'] = "Circle Blade", --aoe
      ['^numpad2'] = "Red Lotus Blade", --elemental
      ['^numpad3'] = "Seraph Blade", --elemental
    },
    ['RDM'] = {
      ['^numpad8'] = "Death Blossom", --mythic
    },
    ['PLD'] = {
      ['^numpad8'] = "Atonement", --mythic
    },
    ['BLU'] = {
      ['^numpad8'] = "Expiacion", --mythic
    },
  },
  ['Great Sword'] = {
    ['Default'] = {
      ['^numpad7'] = "Torcleaver", --empyrean
      ['^numpad8'] = "Dimidiation", --mythic
      ['^numpad9'] = "Scourge", --relic
      ['^numpad4'] = "Ground Strike", --ambuscade
      ['^numpad5'] = "Resolution", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "Shockwave", --aoe
      ['^numpad2'] = "Freezebite", --elemental
      ['^numpad3'] = "Herculean Slash",
    },
  },
  ['Axe'] = {
    ['Default'] = {
      ['^numpad7'] = "Cloudsplitter", --empyrean
      ['^numpad8'] = "Primal Rend", --mythic
      ['^numpad9'] = "Onslaught", --relic
      ['^numpad4'] = "Decimation", --ambuscade
      ['^numpad5'] = "Ruinator", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "",
      ['^numpad3'] = "",
    },
  },
  ['Great Axe'] = {
    ['Default'] = {
      ['^numpad7'] = "Ukko's Fury", --empyrean
      ['^numpad8'] = "King's Justice", --mythic
      ['^numpad9'] = "Metatron Torment", --relic
      ['^numpad4'] = "Steel Cyclone", --ambuscade
      ['^numpad5'] = "Upheaval", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "",
      ['^numpad3'] = "",
    },
  },
  ['Scythe'] = {
    ['Default'] = {
      ['^numpad7'] = "Quietus", --empyrean
      ['^numpad8'] = "Insurgency", --mythic
      ['^numpad9'] = "Catastrophe", --relic
      ['^numpad4'] = "Spiral Hell", --ambuscade
      ['^numpad5'] = "Entropy", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "Shadow of Death", --elemental
      ['^numpad3'] = "",
    },
  },
  ['Polearm'] = {
    ['Default'] = {
      ['^numpad7'] = "Camlann's Torment", --empyrean
      ['^numpad8'] = "Drakesbane", --mythic
      ['^numpad9'] = "Geirskogul", --relic
      ['^numpad4'] = "Impulse Drive", --ambuscade
      ['^numpad5'] = "Stardiver", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "Raiden Thrust", --elemental
      ['^numpad3'] = "",
    },
  },
  ['Katana'] = {
    ['Default'] = {
      ['^numpad7'] = "Blade: Hi", --empyrean
      ['^numpad8'] = "Blade: Kamu", --mythic
      ['^numpad9'] = "Blade: Metsu", --relic
      ['^numpad4'] = "Blade: Ku", --ambuscade
      ['^numpad5'] = "Blade: Shun", --aeonic
      ['^numpad6'] = "Blade: Chi",
      ['^numpad1'] = "Blade: Yu", --aoe
      ['^numpad2'] = "Blade: Ei", --elemental
      ['^numpad3'] = "Blade: Ten",
    },
  },
  ['Great Katana'] = {
    ['Default'] = {
      ['^numpad7'] = "Tachi: Fudo", --empyrean
      ['^numpad8'] = "Tachi: Rana", --mythic
      ['^numpad9'] = "Tachi: Kaiten", --relic
      ['^numpad4'] = "Tachi: Kasha", --ambuscade
      ['^numpad5'] = "Tachi: Shoha", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "Tachi: Jinpu", --elemental
      ['^numpad3'] = "Tachi: Koki", --elemental
    },
  },
  ['Club'] = {
    ['Default'] = {
      ['^numpad7'] = "Dagan", --empyrean
      ['^numpad8'] = "",
      ['^numpad9'] = "Randgrith", --relic
      ['^numpad4'] = "Black Halo", --ambuscade
      ['^numpad5'] = "Realmrazer", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "", --aoe
      ['^numpad2'] = "Seraph Strike", --elemental
      ['^numpad3'] = "",
    },
    ['WHM'] = {
      ['^numpad8'] = "Mystic Boon", --mythic
    },
    ['GEO'] = {
      ['^numpad8'] = "Exudation", --mythic
    },
  },
  ['Staff'] = {
    ['Default'] = {
      ['^numpad7'] = "Myrkr", --empyrean
      ['^numpad8'] = "",
      ['^numpad9'] = "Gates of Tartarus", --relic
      ['^numpad4'] = "Retribution", --ambuscade
      ['^numpad5'] = "Shattersoul", --aeonic
      ['^numpad6'] = "",
      ['^numpad1'] = "Cataclysm", --aoe
      ['^numpad2'] = "Earth Crusher", --elemental
      ['^numpad3'] = "Sunburst", --elemental
    },
    ['BLM'] = {
      ['^numpad8'] = "Vidohunir", --mythic
    },
    ['SMN'] = {
      ['^numpad8'] = "Garland of Bliss", --mythic
    },
    ['SCH'] = {
      ['^numpad8'] = "Omniscience", --mythic
    },
  },
}


-------------------------------------------------------------------------------
-- Instatiated variables for storing values and states
-------------------------------------------------------------------------------
--Most recent weapons (used for re-arming)
sets.MostRecent = {main="",sub="",ranged="",ammo=""} --DO NOT MODIFY
current_weapon_type = nil --DO NOT MODIFY

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- 'ws_range' expected to be the range pulled from weapon_skills.lua
-- 's' is self player object
-- 't' is target object
function is_ws_out_of_range(ws_range, s, t)
  if ws_range == nil or s == nil or t == nil then
    print('Invalid params for is_ws_out_of_range.')
    return true
  end

  local distance = t.distance:sqrt()
  local is_out_of_range = distance > (t.model_size + ws_range * range_mult[ws_range] + s.model_size)

  if is_out_of_range then
    windower.add_to_chat(167, 'Target out of range.')
  end

  return is_out_of_range
end

-- 'spell' is the same as input parameter in job_precast function of Mote libs
-- 'eventArgs' is the same as input parameter in job_precast function of Mote libs
function cancel_outranged_ws(spell, eventArgs)
  -- Ensure spell is a weaponskill to proceed
  if spell.type ~= "WeaponSkill" then
    return
  end
  
  local player = windower.ffxi.get_mob_by_target('me')
  local target = windower.ffxi.get_mob_by_id(spell.target.id)

  if is_ws_out_of_range(spell.range, player, target) then
    cancel_spell() -- Blocks the outgoing action packet that would perform the WS
    eventArgs.cancel = true -- Ensures gear doesn't swap
  end
end

-- Don't swap gear if status forbids the action
-- 'spell' is the same as input parameter in job_precast function of Mote libs
-- 'eventArgs' is the same as input parameter in job_precast function of Mote libs
function cancel_on_blocking_status(spell, eventArgs)
  local forbidden_statuses = action_type_blocks[spell.action_type]
  for k,status in pairs(forbidden_statuses) do
    if buffactive[status] then
      add_to_chat(167, 'Stopped due to status.')
      eventArgs.cancel = true -- Ensures gear doesn't swap
      return -- Ends function without finishing loop
    end
  end
end

function has_item(bag_name, item_name)
  local bag = res.bags:with('en', bag_name)
  local item = res.items:with('en', item_name)
  local items_in_bag = windower.ffxi.get_items(bag['id'])
  for k,v in pairs(items_in_bag) do
    if type(v)~='number' and type(v)~='boolean' and v['id'] == item['id'] then
      return true
    end
  end
  return false
end

-- Saves the state of your weapons
-- Re-arms your weapons when conditions are met
-- Can be temporarily disabled by adding a toggled weapon lock state:
--    state.WeaponLock = M(false, 'Weapon Lock')
--    send_command('bind @w gs c toggle WeaponLock')
-- If 'main', 'sub', or 'ranged' are in idle, engaged, or defense sets
-- it may conflict with this functionality
function update_and_rearm_weapons()
  -- Save state of any equipped weapons
  if player.equipment.main ~= "empty" then
    if not is_encumbered('main') then
      sets.MostRecent.main = player.equipment.main
    end
    if not is_encumbered('sub') then
      sets.MostRecent.sub = player.equipment.sub
    end
  end
  if player.equipment.ranged ~= "empty" and player.equipment.ranged ~= nil then
    -- Only save if ranged is a combat item
    local rangedItem = res.items:with('name', player.equipment.ranged)
    if res.skills[rangedItem.skill].category == 'Combat' then
      if not is_encumbered('ranged') then
        sets.MostRecent.ranged = player.equipment.ranged
      end
      if not is_encumbered('ammo') then
        sets.MostRecent.ammo = player.equipment.ammo
      end
    end
  end

  -- Disarm Handling
  -- Table fills the string "empty" for empty slot. It won't return nil
  if (player.equipment.main == "empty" and sets.MostRecent.main ~= "empty")
      or (player.equipment.ranged == "empty" and sets.MostRecent.ranged ~= "empty") then
    if state.WeaponLock == nil or state.WeaponLock.value == false then
      equip(sets.MostRecent)
    end
  end
end

function update_main_weaponskill_binds(has_job_changed)
  local weapon = nil
  local weapon_type = nil
  -- Handle barehanded case
  if player.equipment.main == nil or player.equipment.main == 0 or player.equipment.main == 'empty' then
    weapon_type = 'Hand-to-Hand'
  else -- Handle equipped weapons case
    weapon = res.items:with('name', player.equipment.main)
    weapon_type = res.skills[weapon.skill].en
  end
  
  -- Do nothing if weapon type is the same as last checked and job hasn't changed
  if weapon_type == current_weapon_type and not has_job_changed then
    return
  end

  -- Update the weapon type tracker
  current_weapon_type = weapon_type

  -- Get defined bindings
  local ws_bindings = get_ws_bindings(weapon_type)
  -- Set weaponskill bindings according to mapping table
  -- TODO
end

function get_ws_bindings(weapon_type)
  -- Null check
  if default_ws_bindings == nil then
    return {}
  end

  local player = windower.ffxi.get_player()
  local weapon_specific_binding
  local final_bindings = {}

  -- If user table exists for the weapon type, use those instead of defaults
  if user_ws_binding[weapon_type] then
    weapon_specific_binding = user_ws_binding[weapon_type]
  else
    weapon_specific_binding = default_ws_binding[weapon_type]
  end

  -- Combine job-specific tables default table
  for key,job_specific_table in pairs(weapon_specific_binding) do
    local is_key_sub_job = key:sub(1, 1) == '/'
    if key:lower() == 'Default' or key:lower()=='All' or key:lower()=='Any' then
      -- Add in default/all/any job bindings
      for keybind,ws_name in pairs(job_specific_table) do
        final_bindings[keybind] = ws_name
      end
      -- Merge in job-specific bindings
    elseif (is_key_sub_job and key:sub(2,key.len):lower() == player.sub_job:lower()) or
        (not is_key_sub_job and key:lower() == player.main_job:lower()) then
      for keybind,ws_name in pairs(job_specific_table) do
        final_bindings[keybind] = ws_name
      end
    end
  end
  
  -- Purge invalid entries
  final_bindings = purge_invalid_ws_bindings(final_bindings)

  -- Set keybinds
  -- TODO
end

function purge_invalid_ws_bindings(ws_bindings)
  local index = 1
  local valid_keybinds = res.keybinds; -- TODO: Get actual map reference
  for keybind,ws_name in pairs(ws_bindings) do
    -- Remove entries that have blank key
    if keybind == '' then
      ws_bindings:remove(index)
    elseif not valid_keybinds[keybind] then-- Remove entries whose key is not on keybind list
      ws_bindings:remove(index)
    elseif ws_name == '' then -- Remove entries that have blank value
      ws_bindings:remove(index)
    elseif not res.weapon_skills:with('en', ws_name) then -- Remove entries that have value that isn't on WS list
      ws_bindings:remove(index)
    end
    index = index + 1
  end
  return ws_bindings
end


-------------------------------------------------------------------------------
-- Event hooks
-------------------------------------------------------------------------------
-- Executes on every frame. This is just a way to create a perpetual loop.
windower.register_event('prerender',function()
  if USE_WEAPON_REARM then
    update_and_rearm_weapons()
  end
  if USE_DYNAMIC_MAIN_WS_KEYBINDS then
    update_main_weaponskill_binds(false)
  end
end)

-- Hook into job/subjob change event
-- TODO
if USE_DYNAMIC_MAIN_WS_KEYBINDS then
  update_main_weaponskill_binds(true)
end