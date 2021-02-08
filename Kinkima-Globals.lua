send_command('lua l gearinfo')

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

locked_neck = false -- Do not modify
locked_ear1 = false -- Do not modify
locked_ear2 = false -- Do not modify
locked_ring1 = false -- Do not modify
locked_ring2 = false -- Do not modify

function define_global_sets()
  --Toy weapon sets
  sets.ToyWeapon = {} --DO NOT MODIFY
  sets.ToyWeapon.None = {main=nil, sub=nil} --DO NOT MODIFY
  sets.ToyWeapon.Katana = {main="Trainee Burin",sub="Qutrub Knife"}
  sets.ToyWeapon.GreatKatana = {main="Lotus Katana",sub="Tzacab Grip"}
  sets.ToyWeapon.Dagger = {main="Qutrub Knife",sub="Wind Knife"}
  sets.ToyWeapon.Sword = {main="Nihility",sub="Qutrub Knife"}
  sets.ToyWeapon.Club = {main="Lady Bell",sub="Qutrub Knife"}
  sets.ToyWeapon.Staff = {main="Savage. Pole",sub="Tzacab Grip"}
  sets.ToyWeapon.Polearm = {main="Pitchfork +1",sub="Tzacab Grip"}
  sets.ToyWeapon.GreatSword = {main="Lament",sub="Tzacab Grip"}
  sets.ToyWeapon.Scythe = {main="Lost Sickle",sub="Tzacab Grip"}

  -- Augmented Weapons
  gear.Gada_Cure = {} -- 10 MND, 6 FC
  gear.Gada_ENH = {} -- 6 Enh Duration, 6 FC

  gear.Grioavolr_MND = {} -- MND, Enfeeb skill, M.Acc
  gear.Grioavolr_MP = {} -- 100 MP
  gear.Grioavolr_MB = {} --MB Dmg, MAB, M.Acc, INT

  gear.Musa_C = {} --Regen potency +25, Cure potency +25%, Fast Cast +10%

  -- Acro

  -- Adhemar

  -- Carmine

  -- Chironic
  gear.Chironic_QA_hands = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT
  gear.Chironic_QA_feet = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT

  gear.Chironic_Refresh_head = {} -- 2 Refresh
  gear.Chironic_Refresh_hands = {} -- 2 Refresh
  gear.Chironic_Refresh_feet = {} -- 2 Refresh

  gear.Chironic_AE_hands = { }-- 10 WSD > 40 MAB > 15 INT > 15 DEX
  gear.Chironic_AE_feet = {} -- 10 WSD > 40 MAB > 15 INT > 15 DEX

  -- Herculean

  -- Merlinic
  gear.Merl_FC_body = {} --7 FC
  gear.Merl_MB_body = {} --MB Dmg, MAB, M.Acc, INT

  -- Taeon
  gear.Taeon_FC_body = { name="Taeon Tabard", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_hands = { name="Taeon Gloves", augments={'Mag. Evasion+11','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_legs = { name="Taeon Tights", augments={'Evasion+18','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_feet = { name="Taeon Boots", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}

  gear.Taeon_Phalanx_body = { name="Taeon Tabard", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_hands = { name="Taeon Gloves", augments={'Mag. Evasion+11','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_legs = { name="Taeon Tights", augments={'Evasion+18','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_feet = { name="Taeon Boots", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}

  gear.Telchine_ENH_head = {name="Telchine Cap", augments={'Mag. Evasion+21','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_body = {name="Telchine Chas.", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_hands = {name="Telchine Gloves", augments={'Mag. Evasion+24','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_legs = {name="Telchine Braconi", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}

  -- Valorous

  -- Vanya
  gear.Vanya_B_head = {} -- 20 healing magic skill, 7 Cure Spellcasting Time-
  gear.Vanya_B_body = {} -- 20 healing magic skill, 7 Cure Spellcasting Time-
  gear.Vanya_B_hands = {} -- 20 healing magic skill, 7 Cure Spellcasting Time-
  gear.Vanya_B_legs = {} -- 20 healing magic skill, 7 Cure Spellcasting Time-
  gear.Vanya_B_feet = {} -- 20 healing magic skill, 7 Cure Spellcasting Time-

  -- Gendewitha
  gear.Gende_SongFC_head = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_hands = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_legs = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_feet = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT

  -- Kaykaus
  gear.Kaykaus_A_body = {}
  gear.Kaykaus_A_legs = {}
  gear.Kaykaus_A_feet = {}

  gear.Kaykaus_D_head = {}
  gear.Kaykaus_D_body = {}
  gear.Kaykaus_D_legs = {}
  gear.Kaykaus_D_feet = {}

  -- Psycloth
  gear.Psycloth_D_head = { name="Psycloth Tiara", augments={'Mag. Acc.+20','"Fast Cast"+10','INT+7',}}
  gear.Psycloth_D_legs = { name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}
  gear.Psycloth_A_feet = {}

  -- Ambuscade Capes
  gear.SCH_Cure_Cape = {} --MND, Cure Potency
  gear.SCH_MAB_Cape = {} --INT, MAB
  gear.SCH_FC_Cape = {} --MND, FC

  -- Misc.
  gear.CP_Cape = {}

end

windower.register_event('zone change', function()
  -- Auto load Omen add-on
  if world.zone == 'Reisenjima Henge' then
    send_command('lua l omen')
  end
end)
