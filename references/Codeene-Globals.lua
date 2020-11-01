res = include('resources')
-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
"Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Dem Ring", "Empress Band",
"Emperor Band", "Emporox's Ring"}

mp_jobs = S{"WHM", "BLM", "RDM", "PLD", "DRK", "SMN", "BLU", "GEO", "RUN", "SCH"}

spell_type_blocks = {
  ['WhiteMagic'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['BlackMagic'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['SummonerPact'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['Ninjutsu'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['BardSong'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['BlueMagic'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['Geomancy'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['Trust'] = {'terror', 'petrification', 'stun', 'sleep', 'silence', 'mute'},
  ['WeaponSkill'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['JobAbility'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['PetCommand'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Samba'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Waltz'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Jig'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Step'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Samba'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Flourish1'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Flourish2'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Effusion'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Rune'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Ward'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['CorsairRoll'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['BloodPactRage'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['BloodPactWard'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Scholar'] = {'terror', 'petrification', 'stun', 'sleep', 'amnesia'},
  ['Item'] = {'terror', 'petrification', 'stun', 'sleep'},
}

current_weapon_type = nil

function define_global_sets()
  --Toy weapon sets
  sets.ToyWeapon = {} --DO NOT MODIFY
  sets.ToyWeapon.None = {main=nil, sub=nil} --DO NOT MODIFY
  sets.ToyWeapon.Katana = {main="Kunai",sub="Bronze Dagger"}
  sets.ToyWeapon.GreatKatana = {main="Zanmato",sub="empty"}
  sets.ToyWeapon.Dagger = {main="Bronze Dagger",sub="Kunai"}
  sets.ToyWeapon.Sword = {main="Nihility",sub="Bronze Dagger"}
  sets.ToyWeapon.Club = {main="Kitty Rod",sub="Bronze Dagger"}
  sets.ToyWeapon.Staff = {main="Cobra Staff",sub="empty"}
  sets.ToyWeapon.Polearm = {main="Pitchfork +1",sub="empty"}
  sets.ToyWeapon.GreatSword = {main="Lament",sub="empty"}
  sets.ToyWeapon.Scythe = {main="Lost Sickle",sub="empty"}

  --Most recent weapon (used for re-arming)
  sets.MostRecent = {main="",sub=""} --DO NOT MODIFY

end



laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}

windower.register_event('zone change',
  function()
    -- Caps FPS to 30 via Config addon in certain problem zones
    --[[if laggy_zones:contains(world.zone) then
      send_command('config FrameRateDivisor 2')
    else
      send_command('config FrameRateDivisor 1')
    end]]--

    -- Auto load Omen add-on
    if world.zone == 'Reisenjima Henge' then
      send_command('lua l omen')
    end
  end
)

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

function update_weapons()
  --Save state of any equipped weapons
  if player.equipment.main ~= "empty" then
    sets.MostRecent.main = player.equipment.main
    sets.MostRecent.sub = player.equipment.sub
  end

  --Disarm Handling--
  --Turns out that the table fills the string "empty" for empty slot. It won't return nil
  if player.equipment.main == "empty" then
    if state.WeaponLock.value == false then
      equip(sets.MostRecent)
    end
  end
end

function update_weaponskill_binds()
  local weapon = nil
  local weapon_type = nil
  --Handle barehanded case
  if player.equipment.main == nil or player.equipment.main == 0 or player.equipment.main == 'empty' then
    weapon_type = 'Hand-to-Hand'
  else --All other types of weapons
    weapon = res.items:with('name', player.equipment.main)
    weapon_type = res.skills[weapon.skill].en
  end

  --Change keybinds if weapon type changed
  if weapon_type ~= current_weapon_type then
    current_weapon_type = weapon_type
    --Set weaponskill bindings by weapon type
    if current_weapon_type == 'Hand-to-Hand' then
    elseif current_weapon_type == 'Dagger' then
      send_command('bind !c input /ws "Cyclone" <t>')
      send_command('bind !v input /ws "Energy Drain" <t>')
    elseif current_weapon_type == 'Sword' then
      send_command('bind !c input /ws "Red Lotus Blade" <t>')
      send_command('bind !v input /ws "Seraph Blade" <t>')
    elseif current_weapon_type == 'Great Sword' then
      send_command('bind !c input /ws "Freezebite" <t>')
    elseif current_weapon_type == 'Scythe' then
      send_command('bind !c input /ws "Shadow of Death" <t>')
    elseif current_weapon_type == 'Polearm' then
      send_command('bind !c input /ws "Raiden Thrust" <t>')
    elseif current_weapon_type == 'Katana' then
      send_command('bind !c input /ws "Blade: Ei" <t>')
    elseif current_weapon_type == 'Great Katana' then
      send_command('bind !c input /ws "Tachi: Jinpu" <t>')
      send_command('bind !v input /ws "Tachi: Koki" <t>')
    elseif current_weapon_type == 'Club' then
      send_command('bind !c input /ws "Seraph Strike" <t>')
    elseif current_weapon_type == 'Staff' then
      send_command('bind !c input /ws "Earth Crusher" <t>')
      send_command('bind !v input /ws "Sunburst" <t>')
    end
  end
end

-- Runs before job_precast
function user_precast(spell, action, spellMap, eventArgs)
  -- Don't gearswap if status forbids the action
  local forbidden_statuses = spell_type_blocks[spell.type]
  for k,status in pairs(forbidden_statuses) do
    if buffactive[status] then
      add_to_chat(167, 'Stopped due to status.')
      eventArgs.cancel = true
      return
    end
  end
end