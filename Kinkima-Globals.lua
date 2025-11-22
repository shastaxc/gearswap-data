send_command('ev pos 1260 700')

include('reorganizer-lib')
res = include('resources')
packets = include('packets')
silibs = include('SilverLibs')

has_obi = true -- Change if you do or don't have Hachirin-no-Obi
has_orpheus = true -- Change if you do or don't have Orpheus's Sash

mp_jobs = S{"WHM", "BLM", "RDM", "PLD", "DRK", "SMN", "BLU", "GEO", "RUN", "SCH"}

laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}

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

----------------------------------------------------------------------
-----------------------      Toy Weapons      ------------------------
----------------------------------------------------------------------

sets.ToyWeapon = {} --DO NOT MODIFY
sets.ToyWeapon.None = {main=nil, sub=nil} --DO NOT MODIFY
sets.ToyWeapon.Katana = {
  -- main="Trainee Burin",sub="Qutrub Knife"
}
sets.ToyWeapon.GreatKatana = {main="Zanmato",sub="Tzacab Grip"}
sets.ToyWeapon.GreatKatana = {
  -- main="Lotus Katana",sub="Tzacab Grip"
}
sets.ToyWeapon.Dagger = {main="Qutrub Knife",sub="Wind Knife"}
sets.ToyWeapon.Sword = {main="Firetongue",sub={name="Qutrub Knife", priority=1}}
sets.ToyWeapon.Club = {main="Seika Uchiwa",sub="Qutrub Knife"}
sets.ToyWeapon.Staff = {main="Sophistry",sub="Tzacab Grip"}
sets.ToyWeapon.Polearm = {main="Sha Wujing's Lance",sub="Tzacab Grip"}
sets.ToyWeapon.GreatSword = {main="Ophidian Sword",sub="Tzacab Grip"}
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
  include('Kinkima-Augments.lua')
end

windower.raw_register_event('zone change', function()
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

send_command('alias mount input /mount "Spheroid" <me>')
