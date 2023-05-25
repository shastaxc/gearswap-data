send_command('gi brd 8')
send_command('gi geo 10')

include('reorganizer-lib')
res = include('resources')
packets = include('packets')
silibs = include('SilverLibs')

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

-- Blue magic spells that should use conserve MP midcast set.
classes.BluConserveSpells = S{'Refueling', 'Warm-Up', 'Saline Coat', 'Reactor Cool', 'Plasma Charge', 'Animating Wail',
                              'Nat. Meditation', 'Carcharian Verve', 'Erratic Flutter', 'Mighty Guard'}

-- Spells that don't scale with skill. Overrides Mote lib.
classes.NoSkillSpells = S{'Adloquium', 'Haste', 'Haste II', 'Refresh', 'Refresh II', 'Refresh III', 'Regen', 'Regen II', 'Regen III',
    'Regen IV', 'Regen V', 'Protect', 'Protect II', 'Protect III', 'Protect IV', 'Protect V', 'Protectra', 'Protectra II',
    'Protectra III', 'Protectra IV', 'Protectra V', 'Shell', 'Shell II', 'Shell III', 'Shell IV', 'Shell V', 'Shellra',
    'Shellra II', 'Shellra III', 'Shellra IV', 'Shellra V', 'Raise', 'Raise II', 'Raise III', 'Arise', 'Reraise', 'Reraise II',
    'Reraise III', 'Reraise IV', 'Sneak', 'Invisible', 'Deodorize', 'Embrava', 'Aquaveil', 'Stoneskin', 'Blink', 'Auspice'}

-- Enhancing magic spells that have short duration.
classes.ShortEnhancingSpells = S{'Blaze Spikes', 'Ice Spikes', 'Shock Spikes', 'Boost-AGI', 'Boost-CHR', 'Boost-DEX', 'Boost-INT',
    'Boost-MND', 'Boost-STR', 'Boost-VIT', 'Enaero', 'Enaero II', 'Enblizzard', 'Enblizzard II', 'Enfire', 'Enfire II', 'Enstone',
    'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II', 'Firestorm', 'Firestorm II', 'Hailstorm', 'Hailstorm II',
    'Rainstorm', 'Rainstorm II', 'Sandstorm', 'Sandstorm II', 'Thunderstorm', 'Thunderstorm II', 'Voidstorm', 'Voidstorm II',
    'Windstorm', 'Windstorm II', 'Flurry', 'Flurry II', 'Haste', 'Haste II', 'Phalanx', 'Refresh', 'Refresh II', 'Refresh III', 'Regen',
    'Regen II', 'Regen III', 'Regen IV', 'Regen V', 'Reprisal', 'Temper', 'Temper II', 'Auspice'}

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
    ['Hitaki'] = 1000,
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
    ['Uzura +2'] = 1000,
    ['Uzura +3'] = 1000,
  },
  ['sub']={
    ['Arasy Tabar'] = 100,
    ['Arasy Tabar +1'] = 150,
    ['Centovente'] = 1000,
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Hitaki'] = 1000,
    ['Machaera +2'] = 1000,
    ['Machaera +3'] = 1000,
    ['Thibron'] = 1000,
    ['Uzura +2'] = 1000,
    ['Uzura +3'] = 1000,
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
sets.ToyWeapon.Katana = {main="Trainee Burin",sub="Wind Knife"}
sets.ToyWeapon.GreatKatana = {main="Mutsunokami",sub="Tzacab Grip"}
-- sets.ToyWeapon.GreatKatana = {main="Lotus Katana",sub="Tzacab Grip"}
sets.ToyWeapon.Dagger = {main="Qutrub Knife",sub="Wind Knife"}
sets.ToyWeapon.Sword = {main="Nihility",sub="Wind Knife"}
sets.ToyWeapon.Club = {main="Lady Bell",sub="Wind Knife"}
sets.ToyWeapon.Staff = {main="Levin",sub="Tzacab Grip"}
sets.ToyWeapon.Polearm = {main="Pitchfork +1",sub="Tzacab Grip"}
sets.ToyWeapon.GreatSword = {main="Lament",sub="Tzacab Grip"}
sets.ToyWeapon.Scythe = {main="Lost Sickle",sub="Tzacab Grip"}

function define_global_sets()
  sets.org = {}
  sets.org.global = {}
  sets.org.global[1] = {ring1="Dimensional Ring (Holla)"}
  sets.org.global[2] = {ring1="Dimensional Ring (Dem)"}
  sets.org.global[3] = {ring1="Dimensional Ring (Mea)"}
  sets.org.global[4] = {ring1="Warp Ring"}
  sets.org.global[5] = {head="Shobuhouou Kabuto"}
  sets.org.global[6] = {back="Nexus Cape"}
  sets.org.global[7] = {back="Orpheus's Sash"}
  sets.org.global[8] = {back="Hachirin-no-Obi"}
  include('Global-Augments.lua')
  include('Silvermutt-Augments.lua')
end

windower.register_event('zone change', function()
  -- Auto load Omen add-on
  if world.zone == 'Reisenjima Henge' then
    send_command('lua l omen')
  end
end)

function get_spell_table_by_name(spell_name)
  for k in pairs(res.spells) do
    if res.spells[k]['en'] == spell_name then
      return res.spells[k]
    end
  end
  return false
end

function actual_cost(spell)
  local cost = spell.mp_cost
  if buffactive["Manafont"] or buffactive["Manawell"] then
    return 0
  elseif spell.type=="WhiteMagic" then
    if buffactive["Penury"] then
        return cost*.5
    elseif state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
        return cost*.9
    elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
        return cost*1.1
    end
  elseif spell.type=="BlackMagic" then
    if buffactive["Parsimony"] then
        return cost*.5
    elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
        return cost*.9
    elseif state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
        return cost*1.1
    end
  end
  return cost
end

send_command('alias mount input /mount "Crawler" <me>')
