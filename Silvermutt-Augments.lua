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
sets.ToyWeapon.Staff = {main="Savage. Pole",sub="Tzacab Grip"}
sets.ToyWeapon.Polearm = {main="Pitchfork +1",sub="Tzacab Grip"}
sets.ToyWeapon.GreatSword = {main="Lament",sub="Tzacab Grip"}
sets.ToyWeapon.Scythe = {main="Lost Sickle",sub="Tzacab Grip"}


----------------------------------------------------------------------
-----------------------   Oseem-Aug Weapons   ------------------------
----------------------------------------------------------------------

-- Aganoshe

-- Colada

-- Condemners

-- Digirbalag

-- Gada

-- Grioavolr

-- Holliday

-- Kanaria

-- Obschine

-- Reienkyo

-- Skinflayer

-- Teller

-- Umaru

-- Zulfiqar


----------------------------------------------------------------------
-----------------------    Oseem-Aug Armor    ------------------------
----------------------------------------------------------------------

-- Chironic

-- Herculean
gear.Herc_TA_hands = { name="Herculean Gloves", augments={'Attack+26','"Triple Atk."+3','DEX+1',}}
gear.Herc_TA_feet = { name="Herculean Boots", augments={'Accuracy+13','"Triple Atk."+4','Attack+4',}}

gear.Herc_STP_feet = {} -- STP > DEX > Acc/Att > Multihit

gear.Herc_MAB_feet = { name="Herculean Boots", augments={'Mag. Acc.+1','"Mag.Atk.Bns."+23','Quadruple Attack +1','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}

gear.Herc_WSD_head = { name="Herculean Helm", augments={'Weapon skill damage +5%','"Snapshot"+2','Magic Damage +4','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}
gear.Herc_WSD_body = { name="Herculean Vest", augments={'Pet: Attack+12 Pet: Rng.Atk.+12','"Mag.Atk.Bns."+9','Weapon skill damage +10%','Accuracy+20 Attack+20',}}
gear.Herc_WSD_legs = {}
gear.Herc_WSD_feet = { name="Herculean Boots", augments={'Rng.Acc.+21','Mag. Acc.+20','Weapon skill damage +6%','Accuracy+3 Attack+3',}}

gear.Herc_TH_body = { name="Herculean Vest", augments={'Pet: INT+1','AGI+6','"Treasure Hunter"+2','Accuracy+17 Attack+17',}}

gear.Herc_DEX_CritDmg_feet = { name="Herculean Boots", augments={'Accuracy+25','Crit. hit damage +3%','DEX+9',}}

gear.Herc_Refresh_head = { name="Herculean Helm", augments={'Weapon Skill Acc.+13','Accuracy+2','"Refresh"+1','Accuracy+19 Attack+19',}}
gear.Herc_Refresh_feet = { name="Herculean Boots", augments={'Crit.hit rate+1','STR+14','"Refresh"+2',}}

-- Merlinic

-- Odyssean

-- Valorous
gear.Valorous_STR_WSD_head = {} -- 4~5%+ WSD, ~20 Acc/Att, 10~15STR
gear.Valorous_STR_WSD_hands = {} -- 4~5%+ WSD, ~20 Acc/Att, 10~15STR
gear.Valorous_STR_WSD_feet = {} -- 4~5%+ WSD, ~20 Acc/Att, 10~15STR


----------------------------------------------------------------------
-----------------------     Skirmish Gear     ------------------------
----------------------------------------------------------------------

-- Cizin

-- Gendewitha
gear.Gende_SongFC_head = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
gear.Gende_SongFC_hands = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
gear.Gende_SongFC_legs = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
gear.Gende_SongFC_feet = {} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT

-- Hagondes

-- Iuitl

-- Otronif

-- Beatific


----------------------------------------------------------------------
----------------------- Alluvion Skirmish Gear -----------------------
----------------------------------------------------------------------

-- Acro

-- Helios

-- Taeon
gear.Taeon_DW_feet = { name="Taeon Boots", augments={'Accuracy+15 Attack+15','"Dual Wield"+5',}}

gear.Taeon_FC_body = { name="Taeon Tabard", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}
gear.Taeon_FC_hands = { name="Taeon Gloves", augments={'Mag. Evasion+11','"Fast Cast"+5','Phalanx +3',}}
gear.Taeon_FC_legs = { name="Taeon Tights", augments={'Evasion+18','"Fast Cast"+5','Phalanx +3',}}
gear.Taeon_FC_feet = { name="Taeon Boots", augments={'DEF+17','"Fast Cast"+5','Phalanx +3',}}

gear.Taeon_Phalanx_body = gear.Taeon_FC_body
gear.Taeon_Phalanx_hands = gear.Taeon_FC_hands
gear.Taeon_Phalanx_legs = gear.Taeon_FC_legs
gear.Taeon_Phalanx_feet = gear.Taeon_FC_feet

gear.Taeon_RA_head = { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}

-- Telchine

-- Yorium

----------------------------------------------------------------------
-----------------------     Sinister Reign     -----------------------
----------------------------------------------------------------------

gear.Dampening_Tam = { name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}}
gear.Floral_Gauntlets = { name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}
gear.Founders_Breastplate = {}
gear.Founders_Gauntlets = {}
gear.Founders_Greaves = {}
gear.Leyline_Gloves = { name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}
gear.Samnuha_body = { name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}}
gear.Samnuha_legs = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}


----------------------------------------------------------------------
-----------------------    Ambuscade Capes    ------------------------
----------------------------------------------------------------------

gear.DNC_TP_DA_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}
gear.DNC_TP_DW_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','System: 1 ID: 640 Val: 4',}}
-- gear.DNC_WTZ_Cape = {name="Senuna's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Mag. Eva.+10','Enmity-10'}}
gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Mag. Evasion+15',}}
-- gear.DNC_WS2_Cape = {name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
gear.DNC_WS3_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
-- gear.DNC_WS4_Cape = {name="Senuna's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','"Dbl.Atk."+10',}}

gear.MNK_DEX_DA_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
gear.MNK_STR_DA_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
gear.MNK_STR_Crit_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
-- gear.MNK_MAB_Cape = {} -- 30 INT, 10 MAB, 20 m.acc/m.dmg

gear.SAM_STR_WSD_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

gear.RNG_DW_Cape = { name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Mag. Evasion+15',}}
gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Mag. Evasion+15',}}
gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'Eva.+20 /Mag. Eva.+20','"Snapshot"+10','"Regen"+5',}}
gear.RNG_Regen_Cape = { name="Belenus's Cape", augments={'Eva.+20 /Mag. Eva.+20','"Snapshot"+10','"Regen"+5',}}
gear.RNG_DA_Cape = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
gear.RNG_WS1_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
gear.RNG_WS2_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
gear.RNG_WS3_Cape = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}}

gear.RUN_FC_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
gear.RUN_HPD_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
gear.RUN_HPP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
gear.RUN_HPME_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Eva.+10','Enmity+10','Mag. Eva.+15',}}
-- gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
gear.RUN_WS2_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}


----------------------------------------------------------------------
-----------------------     Miscellaneous     ------------------------
----------------------------------------------------------------------

gear.Anwig_Salade = { name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Attack+3','Pet: Damage taken -10%',}}
gear.CP_Cape = { name="Mecisto. Mantle", augments={'Cap. Point+50%','STR+1','"Mag.Atk.Bns."+2','DEF+1',}}
