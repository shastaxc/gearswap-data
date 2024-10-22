-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--              [ WIN+Numpad/ ]     Steadfast Tonic (Negate Terror in Escha)
--              [ WIN+Numpad* ]     Savior's Tonic (Negate Doom in Escha)
--              [ WIN+Numpad- ]     Charm Buffer (Negate Charm in Escha)
--              [ WIN+Numpad7 ]     Remedy
--              [ WIN+Numpad8 ]     Panacea
--              [ WIN+Numpad9 ]     Holy Water
--              [ WIN+Numpad4 ]     Sacrifice (spell)
--              [ WIN+Numpad5 ]     Elshima Pachira Fruit
--              [ WIN+Numpad6 ]
--              [ WIN+Numpad1 ]     Echo Drops
--              [ WIN+Numpad2 ]     Eye Drops
--              [ WIN+Numpad3 ]     Antidote
--
--              [ ALT+Numpad/ ]     Fast Follow - Follow
--              [ ALT+Numpad* ]     Fast Follow - Stop Following
--              [ ALT+Numpad- ]     Fast Follow - Stop Following
--              [ ALT+J ]           Invisible/Prism Powder
--              [ ALT+K ]           Sneak/Spectral Jig/Silent Oil

-- Additionally, loading this file will disable the in-game functionality of
-- the following keys when chat input is not open:
--              Numpad/             Toggle walk/run
--              z                   Toggle walk/run
--              Numpad5             Toggle camera mode (first-person vs third-person)
--              v                   Toggle camera mode (first-person vs third-person)


-------------------------------------------------------------------------------------------------------------------

-- Default Item HotKeys
send_command('bind @numlock input /item "Moneta\'s Tonic" <me>') -- Negate Terror
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
send_command('bind %z console c') -- Dummy bind to disable in-game functionality
