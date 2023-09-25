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

-- Default Item HotKeys
send_command('bind @numpad/ input /item "Steadfast Tonic" <me>') -- Negate Terror
send_command('bind @numpad* input /item "Savior\'s Tonic" <me>') -- Negate Doom
send_command('bind @numpad- input /item "Charm Buffer" <me>') -- Negate Charm
send_command('bind @numpad7 input /item "Remedy" <me>')
send_command('bind @numpad8 input /item "Panacea" <me>')
send_command('bind @numpad9 input /item "Holy Water" <me>')
send_command('bind @numpad4 input /ma "Sacrifice" <stpc>')
send_command('bind @numpad5 input /item "Elshimo Pachira Fruit" <me>')
send_command('bind @numpad1 input /ma "Paralyna" <stpc>')
send_command('bind @numpad2 input /ma "Blindna" <stpc>')
send_command('bind @numpad3 input /ma "Silena" <stpc>')

send_command('bind !Numpad/ ffo me')
send_command('bind !Numpad* ffo stopall')
send_command('bind !Numpad- ffo stopall')

send_command('bind !j gs c invisible')
send_command('bind !k gs c sneak')

send_command('bind %numpad/ console c') -- Dummy bind to disable in-game functionality
send_command('bind %numpad5 console c') -- Dummy bind to disable in-game functionality
send_command('bind %v console c') -- Dummy bind to disable in-game functionality