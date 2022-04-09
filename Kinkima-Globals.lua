send_command('ev pos 1260 720')

res = include('resources')
inspect = include('inspect')
packets = include('packets')
silibs = include('SilverLibs')
-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

no_swap_necks = S{"Reraise Gorget", "Chocobo Pullus Torque", "Federation Stables Scarf",
    "Kingdom Stables Collar", "Republic Stables Medal", "Chocobo Whistle", "Wing Gorget", "Stoneskin Torque",
    "Airmid's Gorget", "Portafurnace"}
no_swap_earrings = S{"Raising Earring", "Signal Pearl", "Tactics Pearl", "Federation Earring", "Kingdom Earring",
    "Republic Earring", "Reraise Earring", "Mhaura Earring", "Selbina Earring", "Duchy Earring", "Kazham Earring",
    "Rabao Earring", "Empire Earring", "Norg Earring", "Safehold Earring", "Nashmau Earring", "Kocco's Earring",
    "Mamool Ja Earring"}
no_swap_rings = S{"Duck Ring", "Homing Ring", "Invisible Ring", "Reraise Ring", "Return Ring",
    "Sneak Ring", "Warp Ring", "Albatross Ring", "Pelican Ring", "Penguin Ring", "Ecphoria Ring", "Olduum Ring",
    "Tavnazian Ring", "Teleport Ring: Altep", "Teleport Ring: Dem", "Teleport Ring: Holla", "Recall Ring: Jugner",
    "Teleport Ring: Mea", "Recall Ring: Meriphataud", "Recall Ring: Pashhow", "Teleport Ring: Vahzl", "Teleport Ring: Yhoat",
    "Ceizak Ring",  "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)", "Emporox's Ring",
    "Hennetiel Ring", "Kamihr Ring", "Marjami Ring", "Morimar Ring", "Yahse Ring", "Yorcia Ring",
    "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Dem Ring", "Empress Band",
    "Emperor Band", "Anniversary Ring", "Caliber Ring", "Chariot Band", "Ducal Guard's Ring", "Decennial Ring",
    "Duodecennial Ring", "Kupofried's Ring", "Novennial Ring", "Undecennial Ring", "Allied Ring", "Resolution Ring",
    "Endorsement Ring", "Expertise Ring", "Vocation Ring"}

mp_jobs = S{"WHM", "BLM", "RDM", "PLD", "DRK", "SMN", "BLU", "GEO", "RUN", "SCH"}

laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}

elemental_ws = S{'Aeolian Edge', 'Sanguine Blade', 'Cloudsplitter', 'Seraph Blade', 'Blade: Teki', 'Blade: To', 'Blade: Chi',
    'Tachi: Jinpu', 'Tachi: Koki', 'Cataclysm', 'Wildfire', 'Trueflight', 'Leaden Salute', 'Primal Rend', 'Cyclone',
    'Burning Blade', 'Red Lotus Blade', 'Shining Blade', 'Frostbite', 'Freezebite', 'Dark Harvest', 'Shadow of Death',
    'Infernal Scythe', 'Thunder Thrust', 'Raiden Thrust', 'Blade: Ei', 'Blade: Yu', 'Tachi: Goten', 'Tachi: Kagero',
    'Shining Strike', 'Seraph Strike', 'Flash Nova', 'Rock Crusher', 'Earth Crusher', 'Starburst', 'Sunburst', 'Vidohunir',
    'Garland of Bliss', 'Omniscience', 'Flaming Arrow', 'Hot Shot'}

-- Spells that don't scale with skill. Overrides Mote lib.
classes.NoSkillSpells = S{'Haste', 'Haste II', 'Refresh', 'Refresh II', 'Refresh III', 'Regen', 'Regen II', 'Regen III',
    'Regen IV', 'Regen V', 'Protect', 'Protect II', 'Protect III', 'Protect IV', 'Protect V', 'Protectra', 'Protectra II',
    'Protectra III', 'Protectra IV', 'Protectra V', 'Shell', 'Shell II', 'Shell III', 'Shell IV', 'Shell V', 'Shellra',
    'Shellra II', 'Shellra III', 'Shellra IV', 'Shellra V', 'Raise', 'Raise II', 'Raise III', 'Arise', 'Reraise', 'Reraise II',
    'Reraise III', 'Reraise IV', 'Sneak', 'Invisible', 'Deodorize', 'Embrava', 'Silence', 'Aquaveil', 'Stoneskin', 'Blink'}

tp_bonus_weapons = {
  ['main']={
    ['Aeneas'] = 500,
    ['Anguta'] = 500,
    ['Centovente'] = 1000,
    ['Chango'] = 500,
    ['Dojikiri Yasutsuna'] = 500,
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Godhands'] = 500,
    ['Heishi Shorinken'] = 500,
    ['Khatvanga'] = 500,
    ['Lionheart'] = 500,
    ['Sequence'] = 500,
    ['Tishtrya'] = 500,
    ['Tri-edge'] = 500,
    ['Trishula'] = 500,
  },
  ['sub']={
    ['Centovente'] = 1000,
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
  },
  ['range']={
    ['Accipiter'] = 1000,
    ['Anarchy +2'] = 1000,
    ['Anarchy +3'] = 1000,
    ['Ataktos'] = 1000,
    ['Fail-Not'] = 500,
    ['Fomalhaut'] = 500,
    ['Sparrowhawk +2'] = 1000,
    ['Sparrowhawk +3'] = 1000,
  }
}

locked_neck = false -- Do not modify
locked_ear1 = false -- Do not modify
locked_ear2 = false -- Do not modify
locked_ring1 = false -- Do not modify
locked_ring2 = false -- Do not modify

function define_global_sets()
  include('Global-Augments.lua')
  include('Kinkima-Augments.lua')
end

windower.register_event('zone change', function()
  -- Auto load Omen add-on
  if world.zone == 'Reisenjima Henge' then
    send_command('lua l omen')
  end
end)
