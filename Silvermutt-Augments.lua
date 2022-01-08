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


----------------------------------------------------------------------
-----------------------   Oseem-Aug Weapons   ------------------------
----------------------------------------------------------------------

-- Aganoshe

-- Colada

-- Condemners

-- Digirbalag

-- Gada
gear.Gada_ENH = {} -- 6 Enh Duration, 6 FC

-- Grioavolr
gear.Grioavolr_FC = {} --7 FC
gear.Grioavolr_MB = {} --MB Dmg, MAB, M.Acc, INT

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
gear.Chironic_WSD_head = {}
gear.Chironic_WSD_hands = {}

gear.Chironic_QA_hands = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT
gear.Chironic_QA_feet = {} -- 3 QA > 10 DEX > 30 ACC > 32 ATT

gear.Chironic_Refresh_head = {} -- 2 Refresh
gear.Chironic_Refresh_hands = {} -- 2 Refresh
gear.Chironic_Refresh_feet = {} -- 2 Refresh

gear.Chironic_AE_hands = { }-- 10 WSD > 40 MAB > 15 INT > 15 DEX
gear.Chironic_AE_feet = {} -- 10 WSD > 40 MAB > 15 INT > 15 DEX


-- Herculean
gear.Herc_TA_hands = { name="Herculean Gloves", augments={'Attack+26','"Triple Atk."+3','DEX+1',}}
gear.Herc_TA_feet = { name="Herculean Boots", augments={'Accuracy+13','"Triple Atk."+4','Attack+4',}}

gear.Herc_MAB_feet = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+29','Accuracy+3','Accuracy+5 Attack+5','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}

gear.Herc_WSD_body = { name="Herculean Vest", augments={'Pet: Attack+12 Pet: Rng.Atk.+12','"Mag.Atk.Bns."+9','Weapon skill damage +10%','Accuracy+20 Attack+20',}}

gear.Herc_TH_body = { name="Herculean Vest", augments={'Pet: INT+1','AGI+6','"Treasure Hunter"+2','Accuracy+17 Attack+17',}}

gear.Herc_DEX_CritDmg_feet = { name="Herculean Boots", augments={'Accuracy+25','Crit. hit damage +3%','DEX+9',}}
-- gear.Herc_STR_CritDmg_feet = {} -- CritDmg > Str > Acc/Att > Multihit

gear.Herc_Refresh_head = { name="Herculean Helm", augments={'Weapon Skill Acc.+13','Accuracy+2','"Refresh"+1','Accuracy+19 Attack+19',}}
gear.Herc_Refresh_feet = { name="Herculean Boots", augments={'Crit.hit rate+1','STR+14','"Refresh"+2',}}

gear.Herc_DW_feet = { name="Herculean Boots", augments={'"Dual Wield"+5','Pet: Attack+15 Pet: Rng.Atk.+15','Chance of successful block +1','Accuracy+13 Attack+13','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}

gear.Herc_Phalanx_feet = { name="Herculean Boots", augments={'Pet: INT+8','"Dbl.Atk."+1','Phalanx +4','Accuracy+2 Attack+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}

-- Merlinic

gear.Merl_FC_head = { name="Merlinic Hood", augments={'Mag. Acc.+4 "Mag.Atk.Bns."+4','"Fast Cast"+5','Mag. Acc.+4',}}
gear.Merl_FC_hands = { name="Merlinic Dastanas", augments={'Mag. Acc.+24','"Fast Cast"+5','STR+5','"Mag.Atk.Bns."+9',}}
-- gear.Merl_FC_body = {}
-- gear.Merl_FC_feet = {}

-- Odyssean

-- Valorous


----------------------------------------------------------------------
-----------------------     Skirmish Gear     ------------------------
----------------------------------------------------------------------

-- Cizin

-- Gendewitha
gear.Gende_SongFC_hands = { name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','Song spellcasting time -4%',}} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
gear.Gende_SongFC_legs = { name="Gende. Spats +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -4%',}} -- 5 Song Spellcasting Time-, 3 Song Recast Delay-, 4 PDT
gear.Gende_CureFC_hands = {}  --  5 Cure Cast Time-, 4 PDT

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
gear.Taeon_SIRD_feet = { name="Taeon Boots", augments={'Mag. Evasion+20','Spell interruption rate down -10%','HP+47',}} -- Max: 20 meva, 10 sird, 50 hp

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
gear.Telchine_DA_legs = {}
gear.Telchine_ENH_body = {} -- 20 MEVA, 10 Enh Duration
gear.Telchine_STP_hands = {} -- 20 Acc, 6 STP, 10 DEX
gear.Telchine_STP_feet = {} -- 20 Acc, 6 STP, 10 DEX

-- Yorium


----------------------------------------------------------------------
-----------------------    Skirmish Weapons    -----------------------
----------------------------------------------------------------------

gear.Linos_CnsvMP = {} -- 15 M.Eva, 8 MND, 4 Conserve MP
gear.Linos_DT = {} -- 15 Magic evasion, -5% PDT, 20 HP
gear.Linos_FC = {} -- 20 HP, 15 M.Eva, 6% Fast Cast
gear.Linos_TP = {} -- 20 Acc, 3 Quad attack, 4 Store TP
gear.Linos_WS1 = {} -- 20 MAB, 8 INT, 3 WS Damage
gear.Linos_WS2 = {} -- 15 Acc/Atk, 8 CHR, 3 WS Damage
gear.Linos_WS3 = {} -- 15 Acc/Atk, 8 DEX, 3 WS Damage
gear.Linos_WS4 = {} -- 15 Acc/Atk, 3 QA, 3 DA
gear.Linos_WS5 = {} -- 15 Acc/Atk, 8 STR, 3 WS Damage


----------------------------------------------------------------------
-----------------------     Sinister Reign     -----------------------
----------------------------------------------------------------------

gear.Dampening_Tam = { name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}}
gear.Floral_Gauntlets = { name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}}
gear.Leyline_Gloves = { name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}
gear.Samnuha_body = { name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}}
gear.Samnuha_legs = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}


----------------------------------------------------------------------
-----------------------      Adoulin Capes     -----------------------
----------------------------------------------------------------------

-- gear.COR_Adoulin_Cape = {}
gear.DNC_Adoulin_Cape = { name="Toetapper Mantle", augments={'"Store TP"+1','"Dual Wield"+2','"Rev. Flourish"+28',}}
gear.GEO_Adoulin_Cape = { name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +17','Pet: Damage taken -5%',}}
gear.RUN_Adoulin_Cape = { name="Evasionist's Cape", augments={'Enmity+4','"Embolden"+15','"Dbl.Atk."+4',}}


----------------------------------------------------------------------
-----------------------    Ambuscade Capes    ------------------------
----------------------------------------------------------------------

gear.BRD_DW_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
gear.BRD_STP_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
gear.BRD_WS1_Cape = {name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.BRD_WS2_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.BRD_WS3_Cape = {} -- 30DEX, 20Acc/Atk, 10 Critical Hit Rate, -10 PDT
gear.BRD_WS4_Cape = {} -- 30AGI, 20Acc/Atk, 10 Double Attack, -10 PDT
gear.BRD_WS5_Cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

gear.COR_TP_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
gear.COR_WS1_Cape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.COR_WS2_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
-- gear.COR_WS3_Cape = {} -- AGI, Racc/ratt, agi, wsd, pdt
gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'"Snapshot"+10','"Regen"+5',}}
gear.COR_Regen_Cape = gear.COR_SNP_Cape
gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
-- gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}

gear.DNC_TP_DA_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
gear.DNC_TP_DW_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
gear.DNC_WTZ_Cape = { name="Senuna's Mantle", augments={'CHR+20','Eva.+20 /Mag. Eva.+20','CHR+10','Enmity-10','Phys. dmg. taken-10%',}}
gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.DNC_WS2_Cape = gear.DNC_TP_DA_Cape
-- gear.DNC_WS3_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
-- gear.DNC_WS4_Cape = {name="Senuna's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','"Dbl.Atk."+10',}}

-- gear.GEO_Nuke_Cape = {} -- INT, MAB
gear.GEO_Idle_Cape = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
gear.GEO_FC_Cape = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10','Pet: "Regen"+5',}}

gear.MNK_DEX_DA_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
gear.MNK_STR_DA_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
gear.MNK_STR_Crit_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
-- gear.MNK_MAB_Cape = {} -- 30 INT, 10 MAB, 20 m.acc/m.dmg

gear.SAM_STR_WSD_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

gear.RNG_DW_Cape = { name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Mag. Evasion+15',}}
gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'Eva.+20 /Mag. Eva.+20','"Snapshot"+10','"Regen"+5',}}
gear.RNG_Regen_Cape = gear.RNG_SNP_Cape
-- gear.RNG_DA_Cape = {} -- Dex, acc/att, DA, PDT
gear.RNG_WS1_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
gear.RNG_WS2_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.RNG_WS3_Cape = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Mag. Evasion+15',}}

gear.RUN_FC_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
gear.RUN_HPD_Cape = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
gear.RUN_HPP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
-- gear.RUN_HPME_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Eva.+10','Enmity+10','Mag. Eva.+15',}}
gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
gear.RUN_WS2_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

gear.THF_DW_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
gear.THF_WS1_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
-- gear.THF_WS2_Cape = {} -- STR WSD
-- gear.THF_WS3_Cape = {} -- AGI DA
-- gear.THF_WS4_Cape = {} -- DEX Crit


----------------------------------------------------------------------
-----------------------     Miscellaneous     ------------------------
----------------------------------------------------------------------

gear.Anwig_Salade = { name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Attack+3','Pet: Damage taken -10%',}}
gear.CP_Cape = { name="Mecisto. Mantle", augments={'Cap. Point+50%','STR+1','"Mag.Atk.Bns."+2','DEF+1',}}
