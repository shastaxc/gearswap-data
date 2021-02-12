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
  gear.Colada_ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+5','Mag. Acc.+9',}}

  gear.Gada_ENF = {name="Gada", augments={'"Conserve MP"+2','MND+14','Mag. Acc.+20','"Mag.Atk.Bns."+2','DMG:+7',}}
  gear.Gada_ENH = {name="Gada", augments={'Enh. Mag. eff. dur. +6','MND+9','Mag. Acc.+9','"Mag.Atk.Bns."+1','DMG:+4',}}

  gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
  gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

  gear.Lathi_MAB = {name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
  gear.Lathi_ENF = {name="Lathi", augments={'Mag. Acc.+20','Enfb.mag. skill +15','Dark magic skill +15',}}

  gear.Linos_TP = {name="Linos", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+3','Quadruple Attack +3',}}
  gear.Linos_WS = {name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 CHR+6',}}

  gear.Grioavolr_MND = {name="Grioavolr", augments={'Enfb.mag. skill +10','MND+18','Mag. Acc.+20','"Mag.Atk.Bns."+11',}}
  gear.Grioavolr_MP = {name="Grioavolr", augments={'"Fast Cast"+5','MP+97','Mag. Acc.+28','"Mag.Atk.Bns."+29',}}
  gear.Grioavolr_MB = {name="Grioavolr", augments={'Magic burst dmg.+5%','INT+9','Mag. Acc.+27','"Mag.Atk.Bns."+27',}}

  gear.Linos_CnsvMP = {} -- 15 M.Eva, 8 MND, 4 Conserve MP
  gear.Linos_DT = {} -- 15 Magic evasion, -5% PDT, 20 HP
  gear.Linos_FC = {} -- 20 HP, 15 M.Eva, 6% Fast Cast
  gear.Linos_TP = {} -- 20 Acc, 3 Quad attack, 4 Store TP
  gear.Linos_WS1 = {} -- 20 MAB, 8 INT, 3 WS Damage
  gear.Linos_WS2 = {} -- 15 Acc/Atk, 8 CHR, 3 WS Damage
  gear.Linos_WS3 = {} -- 15 Acc/Atk, 8 DEX, 3 WS Damage
  gear.Linos_WS4 = {} -- 15 Acc/Atk, 3 QA, 3 DA
  gear.Linos_WS5 = {} -- 15 Acc/Atk, 8 STR, 3 WS Damage

  -- Acro
  gear.Acro_Pet_body = {name="Acro Surcoat", augments={'Pet: Mag. Acc.+25','Pet: Breath+7',}}
  gear.Acro_Pet_hands = {name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8',}}

  gear.Acro_STP_hands = {name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','STR+6 DEX+6',}}

  -- Adhemar
  gear.Adhemar_B_head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
  gear.Adhemar_D_head = {name="Adhemar Bonnet +1", augments={'HP+105','Attack+13','Phys. dmg. taken -4',}}

  gear.Adhemar_B_body = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}

  gear.Adhemar_A_hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
  gear.Adhemar_B_hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}

  gear.Adhemar_D_legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}

  gear.Adhemar_D_feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

  -- Carmine
  gear.Carmine_B_legs = { name="Carmine Cuisses +1", augments={'Accuracy+12','DEX+12','MND+20',}}
  gear.Carmine_D_legs = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}

  gear.Carmine_D_hands = { name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}

  -- Chironic
  gear.Chironic_QA_hands = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT
  gear.Chironic_QA_feet = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT

  gear.Chironic_Refresh_head = {} -- 2 Refresh
  gear.Chironic_Refresh_hands = {} -- 2 Refresh
  gear.Chironic_Refresh_feet = {} -- 2 Refresh

  gear.Chironic_AE_hands = { }-- 10 WSD > 40 MAB > 15 INT > 15 DEX
  gear.Chironic_AE_feet = {} -- 10 WSD > 40 MAB > 15 INT > 15 DEX

  -- Herculean
  gear.Herc_TA_body = {name="Herculean Vest", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','STR+9','Accuracy+10',}}
  gear.Herc_TA_hands = { name="Herculean Gloves", augments={'Attack+26','"Triple Atk."+3','DEX+1',}}
  gear.Herc_TA_feet = { name="Herculean Boots", augments={'Accuracy+13','"Triple Atk."+4','Attack+4',}}

  gear.Herc_STP_head = {name="Herculean Helm", augments={'"Store TP"+4','CHR+3','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
  gear.Herc_STP_feet = {} -- STP > DEX > Acc/Att > Multihit

  gear.Herc_RA_body = {name="Herculean Vest", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +3%','AGI+6','Rng.Acc.+15','Rng.Atk.+11',}}
  gear.Herc_RA_legs = {name="Herculean Trousers", augments={'Rng.Acc.+24 Rng.Atk.+24','Weapon skill damage +2%','STR+10','Rng.Acc.+13',}}
  gear.Herc_RA_feet = {name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +1%','AGI+4','Rng.Atk.+15',}}

  gear.Herc_MAB_head = { name="Herculean Helm", augments={'Pet: INT+11','Weapon skill damage +4%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
  gear.Herc_MAB_legs = { name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +1%','MND+1','Mag. Acc.+1','"Mag.Atk.Bns."+15',}}
  gear.Herc_MAB_feet = { name="Herculean Boots", augments={'Mag. Acc.+1','"Mag.Atk.Bns."+23','Quadruple Attack +1','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}

  gear.Herc_WSD_head = { name="Herculean Helm", augments={'Pet: INT+11','Weapon skill damage +4%','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
  gear.Herc_WSD_body = {}
  gear.Herc_WSD_legs = {}
  gear.Herc_WSD_feet = { name="Herculean Boots", augments={'Rng.Acc.+21','Mag. Acc.+20','Weapon skill damage +6%','Accuracy+3 Attack+3',}}

  gear.Herc_DT_head = {name="Herculean Helm", augments={'AGI+2','"Rapid Shot"+2','Damage taken-5%','Accuracy+2 Attack+2',}}
  gear.Herc_DT_hands = {name="Herculean Gloves", augments={'"Cure" potency +3%','INT+9','Damage taken-5%','Accuracy+19 Attack+19','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}

  gear.Herc_TH_head = {name="Herculean Helm", augments={'"Mag.Atk.Bns."+10','Attack+6','"Treasure Hunter"+2',}}
  gear.Herc_TH_body = { name="Herculean Vest", augments={'Pet: INT+1','AGI+6','"Treasure Hunter"+2','Accuracy+17 Attack+17',}}
  gear.Herc_TH_hands = {name="Herculean Gloves", augments={'INT+4','Crit. hit damage +2%','"Treasure Hunter"+2','Accuracy+6 Attack+6','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}

  gear.Herc_DEX_CritDmg_feet = { name="Herculean Boots", augments={'Accuracy+25','Crit. hit damage +3%','DEX+9',}}

  gear.Herc_Refresh_head = { name="Herculean Helm", augments={'Weapon Skill Acc.+13','Accuracy+2','"Refresh"+1','Accuracy+19 Attack+19',}}
  gear.Herc_Refresh_feet = { name="Herculean Boots", augments={'Crit.hit rate+1','STR+14','"Refresh"+2',}}

  -- Merlinic
  gear.Merl_FC_body = {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+7',}}
  gear.Merl_MB_body = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','VIT+5','"Mag.Atk.Bns."+12',}}

  -- Taeon
  gear.Taeon_DW_feet = { name="Taeon Boots", augments={'Accuracy+15 Attack+15','"Dual Wield"+5',}}

  gear.Taeon_FC_body = { name="Taeon Tabard", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_hands = { name="Taeon Gloves", augments={'Mag. Evasion+11','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_legs = { name="Taeon Tights", augments={'Evasion+18','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_FC_feet = { name="Taeon Boots", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}

  gear.Taeon_Phalanx_body = { name="Taeon Tabard", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_hands = { name="Taeon Gloves", augments={'Mag. Evasion+11','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_legs = { name="Taeon Tights", augments={'Evasion+18','"Fast Cast"+5','Phalanx +3',}}
  gear.Taeon_Phalanx_feet = { name="Taeon Boots", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}

  gear.Taeon_TA_head = {name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+9',}}
  gear.Taeon_TA_hands = {name="Taeon Gloves", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','DEX+9',}}
  gear.Taeon_TA_legs = {name="Taeon Tights", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+9',}}

  gear.Taeon_Crit_head = {name="Taeon Chapeau", augments={'Accuracy+18 Attack+18','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_body = {name="Taeon Tabard", augments={'Accuracy+19 Attack+19','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_hands = {name="Taeon Gloves", augments={'Accuracy+20 Attack+20','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_legs = {name="Taeon Tights", augments={'Accuracy+18 Attack+18','Crit.hit rate+3','Crit. hit damage +3%',}}

  gear.Taeon_RA_head = { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
  gear.Taeon_RA_body = {name="Taeon Tabard", augments={'Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+5','"Snapshot"+5',}}

  gear.Telchine_ENH_head = {name="Telchine Cap", augments={'Mag. Evasion+21','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_body = {name="Telchine Chas.", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_hands = {name="Telchine Gloves", augments={'Mag. Evasion+24','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_legs = {name="Telchine Braconi", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}

  gear.Telchine_STP_hands = {name="Telchine Gloves", augments={'Accuracy+20','"Store TP"+6','DEX+10',}}
  gear.Telchine_STP_feet = {name="Telchine Pigaches", augments={'Accuracy+20','"Store TP"+6','DEX+10',}}

  -- Valorous

  gear.Valo_STP_legs = {name="Valor. Hose", augments={'Accuracy+21 Attack+21','"Store TP"+8','Accuracy+15','Attack+11',}}

  gear.Valo_TP_body = {name="Valorous Mail", augments={'Attack+27','"Dbl.Atk."+5','DEX+9','Accuracy+15',}}
  gear.Valo_TP_legs = {name="Valor. Hose", augments={'Accuracy+20','"Dbl.Atk."+5','Attack+13',}}

  gear.Valo_WSD_head = {name="Valorous Mask", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','STR+7','Attack+3',}}
  gear.Valo_WSD_body = {name="Valorous Mail", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','STR+1','Accuracy+15','Attack+15',}}
  gear.Valo_WSD_legs = {name="Valor. Hose", augments={'Accuracy+25 Attack+25','Weapon skill damage +4%','STR+12','Attack+6',}}
  gear.Valo_WSD_feet = {name="Valorous Greaves", augments={'VIT+5','"Store TP"+4','Weapon skill damage +4%','Accuracy+19 Attack+19','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

  -- Vanya
  gear.Vanya_B_head = {} -- 7 Cure Spellcasting Time-
  gear.Vanya_B_body = {} -- 7 Cure Spellcasting Time-
  gear.Vanya_B_hands = {} -- 7 Cure Spellcasting Time-
  gear.Vanya_B_legs = {} -- 7 Cure Spellcasting Time-
  gear.Vanya_B_feet = {} -- 7 Cure Spellcasting Time-

  -- Gendewitha
  gear.Gende_SongFC_head = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_hands = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_legs = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
  gear.Gende_SongFC_feet = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT

  -- Ambuscade Capes
  gear.BLM_Death_Cape = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}}
  gear.BLM_FC_Cape = {name="Taranus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
  gear.BLM_MAB_Cape = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}

  gear.BRD_DW_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
  gear.BRD_Song_Cape = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
  gear.BRD_STP_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  gear.BRD_WS1_Cape = {name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  gear.BRD_WS2_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  gear.BRD_WS3_Cape = {} -- 30DEX, 20Acc/Atk, 10 Critical Hit Rate, -10 PDT
  gear.BRD_WS4_Cape = {} -- 30AGI, 20Acc/Atk, 10 Double Attack, -10 PDT
  gear.BRD_WS5_Cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

  gear.BLU_MAB_Cape = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
  gear.BLU_TP_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  gear.BLU_WS1_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
  gear.BLU_WS2_Cape = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

  gear.COR_DW_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
  gear.COR_RA_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
  gear.COR_SNP_Cape = {name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10',}}
  gear.COR_TP_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.COR_WS1_Cape = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
  gear.COR_WS2_Cape = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
  gear.COR_WS3_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
  gear.COR_WS4_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}

  gear.DNC_TP_DA_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}
  gear.DNC_TP_DW_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','System: 1 ID: 640 Val: 4',}}
  gear.DNC_WTZ_Cape = {name="Senuna's Mantle", augments={'CHR+20','Eva.+20 /Mag. Eva.+20','CHR+10','Enmity -10',}}
  gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Mag. Evasion+15',}}
  gear.DNC_WS2_Cape = {name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
  gear.DNC_WS3_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
  gear.DNC_WS4_Cape = {name="Senuna's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','"Dbl.Atk."+10',}}

  gear.DRG_TP_Cape = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.DRG_JMP_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}}
  gear.DRG_WS1_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
  gear.DRG_WS2_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
  gear.DRG_WS3_Cape = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
  gear.DRG_WS4_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}

  gear.MNK_DEX_DA_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
  gear.MNK_STR_DA_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
  gear.MNK_STR_Crit_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}

  gear.NIN_FC_Cape = {name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}}
  gear.NIN_MAB_Cape = {name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
  gear.NIN_TP_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  gear.NIN_WS1_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.NIN_WS2_Cape = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

  gear.RDM_DW_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
  gear.RDM_INT_Cape = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
  gear.RDM_MND_Cape = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity -10',}}
  gear.RDM_WS1_Cape = {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
  gear.RDM_WS2_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}

  gear.RNG_DW_Cape = { name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Mag. Evasion+15',}}
  gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Mag. Evasion+15',}}
  gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'"Snapshot"+10','"Regen"+5',}}
  gear.RNG_Regen_Cape = { name="Belenus's Cape", augments={'"Snapshot"+10','"Regen"+5',}}
  gear.RNG_DA_Cape = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
  gear.RNG_WS1_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
  gear.RNG_WS2_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
  gear.RNG_WS3_Cape = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

  gear.RUN_FC_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
  gear.RUN_HPD_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
  gear.RUN_HPP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
  gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  gear.RUN_WS1_Cape = {name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.RUN_WS2_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

  gear.SCH_Cure_Cape = {name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%',}}
  gear.SCH_MAB_Cape = {name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
  gear.SCH_FC_Cape = {name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}}

  gear.THF_DW_Cape = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
  gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
  gear.THF_WS1_Cape = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
  gear.THF_WS2_Cape = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}

  gear.WHM_Cure_Cape = {name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Mag. Evasion+15',}}
  gear.WHM_MND_Cape = {name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
  gear.WHM_FC_Cape = {name="Alaunus's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}}

  -- Misc.
  gear.Dark_Ring = { name="Dark Ring", augments={'Magic dmg. taken -4%','Phys. dmg. taken -5%','Breath dmg. taken -4%',}}
  gear.Anwig_Salade = { name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Attack+3','Pet: Damage taken -10%',}}
  gear.Samnuha_body = { name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}}
  gear.Samnuha_legs = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}
  gear.Lustratio_B_legs = { name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}
  gear.Ryuo_A_hands = { name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
  gear.Dampening_Tam = { name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}}
  gear.Leyline_Gloves = { name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}
  gear.CP_Cape = { name="Mecisto. Mantle", augments={'Cap. Point+50%','STR+1','"Mag.Atk.Bns."+2','DEF+1',}}
  gear.Floral_Gauntlets = { name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}

end

windower.register_event('zone change', function()
  -- Auto load Omen add-on
  if world.zone == 'Reisenjima Henge' then
    send_command('lua l omen')
  end
end)
