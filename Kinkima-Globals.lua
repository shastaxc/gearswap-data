send_command('ev pos 1260 700')
send_command('gi brd 8')
send_command('gi geo 10')

include('reorganizer-lib')
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

tp_bonus_weapons = {
  ['main']={
    ['Aeneas'] = 500,
    ['Anguta'] = 500,
    ['Arasy Tabar'] = 100,
    ['Arasy Tabar +1'] = 150,
    ['Centovente'] = 1000,
    ['Chango'] = 500,
    ['Chastisers'] = 300,
    ['Dojikiri Yasutsuna'] = 500,
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Godhands'] = 500,
    ['Heishi Shorinken'] = 500,
    ['Khatvanga'] = 500,
    ['Lionheart'] = 500,
    ['Lycurgos'] = 200,
    ['Machaera +2'] = 1000,
    ['Machaera +3'] = 1000,
    ['Sequence'] = 500,
    ['Thibron'] = 1000,
    ['Tishtrya'] = 500,
    ['Tri-edge'] = 500,
    ['Trishula'] = 500,
  },
  ['sub']={
    ['Arasy Tabar'] = 100,
    ['Arasy Tabar +1'] = 150,
    ['Centovente'] = 1000,
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Machaera +2'] = 1000,
    ['Machaera +3'] = 1000,
    ['Thibron'] = 1000,
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

----------------------------------------------------------------------
-----------------------      Toy Weapons      ------------------------
----------------------------------------------------------------------

sets.ToyWeapon = {} --DO NOT MODIFY
sets.ToyWeapon.None = {main=nil, sub=nil} --DO NOT MODIFY
sets.ToyWeapon.Katana = {
  -- main="Trainee Burin",
  -- sub="Qutrub Knife"
}
sets.ToyWeapon.GreatKatana = {main="Zanmato",sub="Tzacab Grip"}
-- sets.ToyWeapon.GreatKatana = {main="Lotus Katana",sub="Tzacab Grip"}
sets.ToyWeapon.Dagger = {main="Qutrub Knife",sub="Wind Knife"}
sets.ToyWeapon.Sword = {main="Firetongue",sub={name="Qutrub Knife", priority=1}}
sets.ToyWeapon.Club = {main="Seika Uchiwa",sub="Qutrub Knife"}
sets.ToyWeapon.Staff = {main="Sophistry",sub="Tzacab Grip"}
sets.ToyWeapon.Polearm = {main="Sha Wujing's Lance",sub="Tzacab Grip"}
sets.ToyWeapon.GreatSword = {
  -- main="Lament",
  -- sub="Tzacab Grip"
}
sets.ToyWeapon.Scythe = {
  main="Lost Sickle",
  sub="Tzacab Grip"
}


function define_global_sets()
  sets.org = {}
  sets.org.global = {}
  sets.org.global[1] = {ring1="Dimensional Ring (Holla)"}
  sets.org.global[2] = {ring1="Dimensional Ring (Dem)"}
  sets.org.global[3] = {ring1="Dimensional Ring (Mea)"}
  sets.org.global[4] = {ring1="Warp Ring"}
  sets.org.global[5] = {head="Shobuhouou Kabuto"}
  sets.org.global[6] = {back="Nexus Cape"}
  include('Global-Augments.lua')
  include('Kinkima-Augments.lua')
end

windower.register_event('zone change', function()
  -- Auto load Omen add-on
  if world.zone == 'Reisenjima Henge' then
    send_command('lua l omen')
  end
end)
