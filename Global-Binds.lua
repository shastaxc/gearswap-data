-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Spells:     
--              [ ALT+J ]           Invisible/Prism Powder
--              [ ALT+K ]           Sneak/Spectral Jig/Silent Oil
--              [ ALT+Numpad7 ]     Paralyna
--              [ ALT+Numpad8 ]     Silena
--              [ ALT+Numpad9 ]     Blindna
--              [ ALT+Numpad4 ]     Poisona
--              [ ALT+Numpad5 ]     Stona
--              [ ALT+Numpad6 ]     Viruna
--              [ ALT+Numpad1 ]     Cursna
--              [ ALT+Numpad+ ]     Erase
--              [ ALT+Numpad0 ]     Sacrifice
--              [ ALT+Numpad. ]     Esuna
--
--  Items:
--              [ WIN+Numpad/ ]     Soldier's Drink
--              [ WIN+Numpad7 ]     Remedy
--              [ WIN+Numpad8 ]     Echo Drops
--              [ WIN+Numpad9 ]     Eye Drops
--              [ WIN+Numpad4 ]     Antidote
--              [ WIN+Numpad6 ]     Remedy
--              [ WIN+Numpad1 ]     Holy Water
--              [ WIN+Numpad0 ]     Catholican +1
--              [ WIN+Numpad. ]     Catholican
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

-- Default Status Cure HotKeys
send_command('bind !numpad7 input /ma "Paralyna" <t>')
send_command('bind !numpad8 input /ma "Silena" <t>')
send_command('bind !numpad9 input /ma "Blindna" <t>')
send_command('bind !numpad4 input /ma "Poisona" <t>')
send_command('bind !numpad5 input /ma "Stona" <t>')
send_command('bind !numpad6 input /ma "Viruna" <t>')
send_command('bind !numpad1 input /ma "Cursna" <t>')
send_command('bind !numpad+ input /ma "Erase" <t>')
send_command('bind !numpad0 input /ma "Sacrifice" <t>')
send_command('bind !numpad. input /ma "Esuna" <me>')

-- Default Item HotKeys
send_command('bind @numpad7 input /item "Remedy" <me>')
send_command('bind @numpad8 input /item "Echo Drops" <me>')
send_command('bind @numpad9 input /item "Eye Drops" <me>')
send_command('bind @numpad4 input /item "Antidote" <me>')
send_command('bind @numpad6 input /item "Remedy" <me>')
send_command('bind @numpad1 input /item "Holy Water" <me>')
