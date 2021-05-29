-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Spells:
--              [ ALT+J ]           Invisible/Prism Powder
--              [ ALT+K ]           Sneak/Spectral Jig/Silent Oil
--
--  Items:
--              [ WIN+Numpad9 ]     Holy Water
--              [ WIN+Numpad7 ]     Remedy
--              [ WIN+Numpad1 ]     Echo Drops
--              [ WIN+Numpad2 ]     Eye Drops
--              [ WIN+Numpad3 ]     Antidote
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------

-- Default Spell HotKeys
if player.main_job == 'DNC' or player.sub_job == 'DNC' then
  send_command('unbind !j')
  send_command('bind !k input /ja "Spectral Jig" <me>')
elseif player.main_job == 'RDM' or player.sub_job == 'RDM'
  or player.main_job == 'SCH' or player.sub_job == 'SCH'
  or player.main_job == 'WHM' or player.sub_job == 'WHM' then
  send_command('bind !j input /ma "Invisible" <stpc>')
  send_command('bind !k input /ma "Sneak" <stpc>')
elseif player.main_job == 'NIN' or player.sub_job == 'NIN' then
  send_command('bind !j input /ma "Tonko: Ni" <me>')
  send_command('bind !k input /ma "Monomi: Ichi" <me>')
else
  send_command('bind !j input /item "Prism Powder" <me>')
  send_command('bind !k input /item "Silent Oil" <me>')
end

-- Default Item HotKeys
send_command('bind @numpad7 input /item "Remedy" <me>')
send_command('bind @numpad8 input /item "Panacea" <me>')
send_command('bind @numpad9 input /item "Holy Water" <me>')
send_command('bind @numpad5 input /item "Poison Potion" <me>')
send_command('bind @numpad1 input /item "Echo Drops" <me>')
send_command('bind @numpad2 input /item "Eye Drops" <me>')
send_command('bind @numpad3 input /item "Antidote" <me>')

send_command('bind scrolllock input //ffo me; wait 0.1; input //cureplease stop')
send_command('bind pause input //ffo stopall; wait 0.1; input //cureplease start')
send_command('bind !pause input //ffo stopall; wait 0.1; input //cureplease stop')