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

-------------------------------------------------------------------------------
-- Instatiated variables for storing values and states
-------------------------------------------------------------------------------
--Most recent weapons (used for re-arming)
sets.MostRecent = {main="",sub="",ranged="",ammo=""} --DO NOT MODIFY

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- 'ws_range' expected to be the range pulled from weapon_skills.lua
-- 's' is self player object
-- 't' is target object
function is_ws_out_of_range(ws_range, s, t)
  if ws_name == nil or s == nil or t == nil then
    return true
  end

  local distance = t.distance:sqrt()
  local is_out_of_range = distance > (t.model_size + ws_range * range_mult[ws_range] + s.model_size)

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
    windower.add_to_chat(167, 'Stopping WS. Target out of range.')
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
  --Save state of any equipped weapons
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

  --Disarm Handling--
  --Turns out that the table fills the string "empty" for empty slot. It won't return nil
  if (player.equipment.main == "empty" and sets.MostRecent.main ~= "empty")
      or (player.equipment.ranged == "empty" and sets.MostRecent.ranged ~= "empty") then
    if state.WeaponLock == nil or state.WeaponLock.value == false then
      equip(sets.MostRecent)
    end
  end
end

-- Executes on every frame. This is just a way to create a perpetual loop.
windower.register_event('prerender',function()
  if USE_WEAPON_REARM then
    update_and_rearm_weapons()
  end
end)