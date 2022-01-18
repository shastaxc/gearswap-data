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
laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}


function define_global_sets()
  --Toy weapon sets
  sets.ToyWeapon = {} --DO NOT MODIFY
  sets.ToyWeapon.None = {main=nil, sub=nil} --DO NOT MODIFY
  sets.ToyWeapon.Katana = {main="Kunai",sub="Bronze Dagger"}
  sets.ToyWeapon.GreatKatana = {main="Zanmato",sub="empty"}
  sets.ToyWeapon.Dagger = {main="Bronze Dagger",sub="Kunai"}
  sets.ToyWeapon.Sword = {main="Nihility",sub="Kunai"}
  sets.ToyWeapon.Club = {main="Kitty Rod",sub="Kunai"}
  sets.ToyWeapon.Staff = {main="Cobra Staff",sub="empty"}
  sets.ToyWeapon.Polearm = {main="Pitchfork +1",sub="empty"}
  sets.ToyWeapon.GreatSword = {main="Lament",sub="empty"}
  sets.ToyWeapon.Scythe = {main="Lost Sickle",sub="empty"}

  --Most recent weapon (used for re-arming)
  sets.MostRecent = {main="",sub=""} --DO NOT MODIFY

end

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

-- elseif current_weapon_type == 'Dagger' then
--   send_command('bind !2 input /ws "Evisceration" <t>')
--   send_command('bind !4 input /ws "Aeolian Edge" <t>')
--   send_command('bind !c input /ws "Cyclone" <t>')
--   send_command('bind !v input /ws "Energy Drain" <t>')
-- elseif current_weapon_type == 'Sword' then
--   send_command('bind !c input /ws "Red Lotus Blade" <t>')
--   send_command('bind !v input /ws "Seraph Blade" <t>')
-- elseif current_weapon_type == 'Great Sword' then
--   send_command('bind !c input /ws "Freezebite" <t>')
-- elseif current_weapon_type == 'Scythe' then
--   send_command('bind !c input /ws "Shadow of Death" <t>')
-- elseif current_weapon_type == 'Polearm' then
--   send_command('bind !c input /ws "Raiden Thrust" <t>')
-- elseif current_weapon_type == 'Katana' then
--   send_command('bind !c input /ws "Blade: Ei" <t>')
--   send_command('bind !2 input /ws "Blade: Hi" <t>')
--   send_command('bind !3 input /ws "Blade: Metsu" <t>')
--   send_command('bind !4 input /ws "Blade: Shun" <t>')
--   send_command('bind !5 input /ws "Blade: Ten" <t>')
--   send_command('bind !6 input /ws "Blade: Chi" <t>')
--   send_command('bind !7 input /ws "Blade: Retsu" <t>')
--   send_command('bind !8 input /ws "Blade: Ku" <t>')
--   send_command('bind !9 input /ws "Blade: To" <t>')
--   send_command('bind !0 input /ws "Blade: Yu" <t>')
-- elseif current_weapon_type == 'Great Katana' then
--   send_command('bind !c input /ws "Tachi: Jinpu" <t>')
--   send_command('bind !v input /ws "Tachi: Koki" <t>')
-- elseif current_weapon_type == 'Club' then
--   send_command('bind !c input /ws "Seraph Strike" <t>')
-- elseif current_weapon_type == 'Staff' then
--   send_command('bind !c input /ws "Earth Crusher" <t>')
--   send_command('bind !v input /ws "Sunburst" <t>')
-- end
