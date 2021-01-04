send_command('lua l gearinfo')

res = include('resources')
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
action_type_blocks = {
  ['Magic'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'silence', 'mute', 'Omerta'},
  ['Ranged Attack'] = {'terror', 'petrification', 'stun', 'sleep', 'charm'},
  ['Ability'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'amnesia', 'impairment'},
  ['Item'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'muddle'},
  ['Monster Move'] = {'terror', 'petrification', 'stun', 'sleep', 'charm', 'amnesia'},
}
laggy_zones = S{'Al Zahbi', 'Aht Urhgan Whitegate', 'Eastern Adoulin', 'Mhaura', 'Nashmau', 'Selbina', 'Western Adoulin'}

current_weapon_type = nil -- Do not modify
locked_neck = false -- Do not modify
locked_ear1 = false -- Do not modify
locked_ear2 = false -- Do not modify
locked_ring1 = false -- Do not modify
locked_ring2 = false -- Do not modify

function define_global_sets()

  --Most recent weapon (used for re-arming)
  sets.MostRecent = {main="",sub="",ranged="",ammo=""} --DO NOT MODIFY

  -- Augmented Weapons
  gear.Colada_ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+5','Mag. Acc.+9',}}

  gear.Gada_ENF = {name="Gada", augments={'"Conserve MP"+2','MND+14','Mag. Acc.+20','"Mag.Atk.Bns."+2','DMG:+7',}}
  gear.Gada_ENH = {name="Gada", augments={'Enh. Mag. eff. dur. +6','MND+9','Mag. Acc.+9','"Mag.Atk.Bns."+1','DMG:+4',}}

  gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
  gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

  gear.Lathi_MAB = {name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
  gear.Lathi_ENF = {name="Lathi", augments={'Mag. Acc.+20','Enfb.mag. skill +15','Dark magic skill +15',}}

  gear.Linos_CnsvMP = {} -- 15 M.Eva, 8 MND, 4 Conserve MP
  gear.Linos_DT = {} -- 15 Magic evasion, -5% PDT, 20 HP
  gear.Linos_FC = {} -- 20 HP, 15 M.Eva, 6% Fast Cast
  gear.Linos_TP = {} -- 20 Acc, 3 Quad attack, 4 Store TP
  gear.Linos_WS1 = {} -- 20 MAB, 8 INT, 3 WS Damage
  gear.Linos_WS2 = {} -- 15 Acc/Atk, 8 CHR, 3 WS Damage
  gear.Linos_WS3 = {} -- 15 Acc/Atk, 8 DEX, 3 WS Damage
  gear.Linos_WS4 = {} -- 15 Acc/Atk, 3 QA, 3 DA
  gear.Linos_WS5 = {} -- 15 Acc/Atk, 8 STR, 3 WS Damage

  gear.Grioavolr_MND = {name="Grioavolr", augments={'Enfb.mag. skill +10','MND+18','Mag. Acc.+20','"Mag.Atk.Bns."+11',}}
  gear.Grioavolr_MP = {name="Grioavolr", augments={'"Fast Cast"+5','MP+97','Mag. Acc.+28','"Mag.Atk.Bns."+29',}}
  gear.Grioavolr_MB = {name="Grioavolr", augments={'Magic burst dmg.+5%','INT+9','Mag. Acc.+27','"Mag.Atk.Bns."+27',}}

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
  gear.Herc_TA_feet = {name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','STR+9','Accuracy+15',}}

  gear.Herc_STP_head = {name="Herculean Helm", augments={'"Store TP"+4','CHR+3','Quadruple Attack +2','Accuracy+15 Attack+15','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
  gear.Herc_STP_body = {name="Herculean Vest", augments={'Accuracy+22 Attack+22','"Store TP"+4','STR+11','Accuracy+2','Attack+14',}}
  gear.Herc_STP_feet = {name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Store TP"+4','DEX+10','Accuracy+15','Attack+10',}}

  gear.Herc_RA_body = {name="Herculean Vest", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +3%','AGI+6','Rng.Acc.+15','Rng.Atk.+11',}}
  gear.Herc_RA_legs = {name="Herculean Trousers", augments={'Rng.Acc.+24 Rng.Atk.+24','Weapon skill damage +2%','STR+10','Rng.Acc.+13',}}
  gear.Herc_RA_feet = {name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +1%','AGI+4','Rng.Atk.+15',}}

  gear.Herc_MAB_head = {name="Herculean Helm", augments={'AGI+6','"Mag.Atk.Bns."+25','Weapon skill damage +2%','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
  gear.Herc_MAB_legs = {name="Herculean Trousers", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+3','AGI+10','"Mag.Atk.Bns."+15',}}
  gear.Herc_MAB_feet = {name="Herculean Boots", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+2','Accuracy+10 Attack+10','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

  gear.Herc_WS_body = {name="Herculean Vest", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','DEX+9','Attack+12',}}
  gear.Herc_WS_legs = {name="Herculean Trousers", augments={'Accuracy+25 Attack+25','Weapon skill damage +3%','DEX+13','Accuracy+6','Attack+4',}}

  gear.Herc_WSD_head = {name="Herculean Helm", augments={'Pet: VIT+7','Pet: "Regen"+3','Weapon skill damage +10%','Accuracy+2 Attack+2',}}
  gear.Herc_WSD_legs = {name="Herculean Trousers", augments={'"Repair" potency +1%','Magic dmg. taken -1%','Weapon skill damage +8%','Accuracy+11 Attack+11','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
  gear.Herc_WSD_feet = {name="Herculean Boots", augments={'Pet: "Regen"+2','AGI+14','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

  gear.Herc_DT_head = {name="Herculean Helm", augments={'AGI+2','"Rapid Shot"+2','Damage taken-5%','Accuracy+2 Attack+2',}}
  gear.Herc_DT_hands = {name="Herculean Gloves", augments={'"Cure" potency +3%','INT+9','Damage taken-5%','Accuracy+19 Attack+19','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}

  gear.Herc_Idle_head ={name="Herculean Helm", augments={'INT+5','"Mag.Atk.Bns."+19','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}

  gear.Herc_TH_head = {name="Herculean Helm", augments={'"Mag.Atk.Bns."+10','Attack+6','"Treasure Hunter"+2',}}
  gear.Herc_TH_hands = {name="Herculean Gloves", augments={'INT+4','Crit. hit damage +2%','"Treasure Hunter"+2','Accuracy+6 Attack+6','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}

  -- Merlinic
  gear.Merl_FC_body = {name="Merlinic Jubbah", augments={'STR +15, Accuracy +13, Attack +13, Mag. Acc. +16, "Mag.Atk.Bns."+16', 'Pot. of "Cure" effect rec. +1%',}}
  gear.Merl_MB_body = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','VIT+5','"Mag.Atk.Bns."+12',}}
  gear.Merl_MAB_body = { name="Merlinic Jubbah", augments={'STR +15, Accuracy +13, Attack +13, Mag. Acc. +16, "Mag.Atk.Bns."+16', 'Pot. of "Cure" effect rec. +1%',}}

  -- Taeon
  gear.Taeon_DW_feet = {name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+5','STR+7 DEX+7',}}

  gear.Taeon_FC_body = {name="Taeon Tabard", augments={'"Fast Cast"+5','HP+48',}}

  gear.Taeon_Phalanx_body = {name="Taeon Tabard", augments={'Mag. Evasion+19','Spell interruption rate down -10%','Phalanx +3',}}
  gear.Taeon_Phalanx_hands = {name="Taeon Gloves", augments={'Mag. Evasion+19','Spell interruption rate down -10%','Phalanx +3',}}
  gear.Taeon_Phalanx_legs = {name="Taeon Tights", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
  gear.Taeon_Phalanx_feet = {name="Taeon Boots", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}

  gear.Taeon_TA_head = {name="Taeon Chapeau", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+9',}}
  gear.Taeon_TA_hands = {name="Taeon Gloves", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','DEX+9',}}
  gear.Taeon_TA_legs = {name="Taeon Tights", augments={'Accuracy+19 Attack+19','"Triple Atk."+2','DEX+9',}}

  gear.Taeon_Crit_head = {name="Taeon Chapeau", augments={'Accuracy+18 Attack+18','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_body = {name="Taeon Tabard", augments={'Accuracy+19 Attack+19','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_hands = {name="Taeon Gloves", augments={'Accuracy+20 Attack+20','Crit.hit rate+3','Crit. hit damage +3%',}}
  gear.Taeon_Crit_legs = {name="Taeon Tights", augments={'Accuracy+18 Attack+18','Crit.hit rate+3','Crit. hit damage +3%',}}

  gear.Taeon_RA_head = {name="Taeon Chapeau", augments={'Rng.Acc.+19 Rng.Atk.+19','"Snapshot"+5','"Snapshot"+5',}}
  gear.Taeon_RA_body = {name="Taeon Tabard", augments={'Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+5','"Snapshot"+5',}}

  gear.Telchine_ENH_head = {name="Telchine Cap", augments={'Mag. Evasion+21','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_body = {name="Telchine Chas.", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_hands = {name="Telchine Gloves", augments={'Mag. Evasion+24','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_legs = {name="Telchine Braconi", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_ENH_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}

  gear.Telchine_Regen_head = {name="Telchine Cap", augments={'Mag. Evasion+21','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_Regen_body = {name="Telchine Chas.", augments={'Mag. Evasion+20','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_Regen_hands = {name="Telchine Gloves", augments={'Mag. Evasion+24','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_Regen_legs = {name="Telchine Braconi", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}
  gear.Telchine_Regen_feet = {name="Telchine Pigaches", augments={'Mag. Evasion+25','"Regen"+2','Enh. Mag. eff. dur. +10',}}

  gear.Telchine_STP_hands = {name="Telchine Gloves", augments={'Accuracy+20','"Store TP"+6','DEX+10',}}
  gear.Telchine_STP_feet = {name="Telchine Pigaches", augments={'Accuracy+20','"Store TP"+6','DEX+10',}}
  
  gear.Telchine_SongFC_feet = {} -- 5% FC & 25 M.Eva

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

  -- Ambuscade Capes
  gear.BLM_Death_Cape = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Fast Cast"+10',}} --*
  gear.BLM_FC_Cape = {name="Swith Cape", augments={}}
  gear.BLM_MAB_Cape = { name="Taranus's Cape", augments={'"Mag.Atk.Bns."+10','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage+1',}} --*

  gear.BRD_DW_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --**
  gear.BRD_Song_Cape = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}} --*
  gear.BRD_STP_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
  gear.BRD_WS1_Cape = {name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --**
  gear.BRD_WS2_Cape = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*
  gear.BRD_WS3_Cape = {} -- 30DEX, 20Acc/Atk, 10 Critical Hit Rate, -10 PDT
  gear.BRD_WS4_Cape = {} -- 30AGI, 20Acc/Atk, 10 Double Attack, -10 PDT
  gear.BRD_WS5_Cape = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

  gear.BLU_MAB_Cape = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}} --*
  gear.BLU_TP_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
  gear.BLU_WS1_Cape = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*
  gear.BLU_WS2_Cape = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*

  gear.COR_DW_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --**
  gear.COR_RA_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}} --*
  gear.COR_SNP_Cape = {name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10',}} --*
  gear.COR_TP_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --**
  gear.COR_WS1_Cape = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}} --*
  gear.COR_WS2_Cape = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*
  gear.COR_WS3_Cape = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}} --*
  gear.COR_WS4_Cape = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*

  gear.DNC_TP_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
  gear.DNC_WTZ_Cape = {name="Senuna's Mantle", augments={'CHR+20','Eva.+20 /Mag. Eva.+20','CHR+10','Enmity +10',}} --*
  gear.DNC_WS1_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}} --*
  gear.DNC_WS2_Cape = {name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}} --*
  gear.DNC_WS3_Cape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*

  gear.DRG_TP_Cape = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --**
  gear.DRG_JMP_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}} --*
  gear.DRG_WS1_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}} --*
  gear.DRG_WS2_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*
  gear.DRG_WS3_Cape = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}} --*
  gear.DRG_WS4_Cape = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}} --*

  gear.NIN_FC_Cape = {name="Andartia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}} --**
  gear.NIN_MAB_Cape = {name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
  gear.NIN_TP_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
  gear.NIN_WS1_Cape = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --**
  gear.NIN_WS2_Cape = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --**

  gear.RDM_DW_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --**
  gear.RDM_INT_Cape = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}} --*
  gear.RDM_MND_Cape = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity -10',}} --*
  gear.RDM_WS1_Cape = {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}} --*
  gear.RDM_WS2_Cape = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*

  gear.RNG_DW_Cape = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}
  gear.RNG_RA_Cape = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}} --*
  gear.RNG_SNP_Cape = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}}
  gear.RNG_TP_Cape = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
  gear.RNG_WS1_Cape = {name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}} --*
  gear.RNG_WS2_Cape = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}} --*

  gear.RUN_FC_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}} --**
  gear.RUN_HPD_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}} --**
  gear.RUN_HPP_Cape = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}} --**
  gear.RUN_TP_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --**
  gear.RUN_WS1_Cape = {name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --**
  gear.RUN_WS2_Cape = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --**

  gear.SCH_Cure_Cape = {name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%',}} --*
  gear.SCH_MAB_Cape = {name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}} --*
  gear.SCH_FC_Cape = {name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}} --*

  gear.THF_DW_Cape = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --**
  gear.THF_TP_Cape = {name="Toutatis's Cape", augments={'Accuracy+20 Attack+20','"Store TP"+10'}} --**
  gear.THF_WS1_Cape = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}} --*
  gear.THF_WS2_Cape = {name="Toutatis's Cape", augments={'Accuracy+20 Attack+20','Crit.hit rate+10',}} --*

  gear.WHM_Cure_Cape = {name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Mag. Evasion+15',}} --**
  gear.WHM_MND_Cape = {name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}} --**
  gear.WHM_FC_Cape = {name="Alaunus's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Mag. Evasion+15',}} --**

  -- SR Gear
  gear.Leyline_Gloves = { name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}}
  gear.Dampening_Tam = { name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}}
  gear.Samnuha_legs = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}

  -- Misc.
  gear.Dark_Ring = { name="Dark Ring", augments={'Magic dmg. taken -6%','Phys. dmg. taken -6%','Breath dmg. taken -6%',}}
end

windower.register_event('zone change',
  function()
    -- Auto load Omen add-on
    if world.zone == 'Reisenjima Henge' then
      send_command('lua l omen')
    end
  end
)

function has_item(bag_name, item_name)
  local bag = res.bags:with('en', bag_name)
  local item = res.items:with('en', item_name)
  local items_in_bag = windower.ffxi.get_items(bag['id'])
  for k,v in pairs(items_in_bag) do
    if type(v)~='number' and type(v)~='boolean' and v['id'] == item['id'] then
      return true
    end
  end
  return false
end

function update_weapons()
  --Save state of any equipped weapons
  if player.equipment.main ~= "empty" then
    if not is_encumbered('main') then
      sets.MostRecent.main = player.equipment.main
    end
    if not is_encumbered('sub') then
      sets.MostRecent.sub = player.equipment.sub
    end
  end
  if player.equipment.ranged ~= "empty" and player.equipment.ranged ~= nil then
    -- Only save if ranged is a combat item
    local rangedItem = res.items:with('name', player.equipment.ranged)
    if res.skills[rangedItem.skill].category == 'Combat' then
      if not is_encumbered('ranged') then
        sets.MostRecent.ranged = player.equipment.ranged
      end
      if not is_encumbered('ammo') then
        sets.MostRecent.ammo = player.equipment.ammo
      end
    end
  end

  --Disarm Handling--
  --Turns out that the table fills the string "empty" for empty slot. It won't return nil
  if (player.equipment.main == "empty" and sets.MostRecent.main ~= "empty")
      or (player.equipment.ranged == "empty" and sets.MostRecent.ranged ~= "empty") then
    if state.WeaponLock.value == false then
      equip(sets.MostRecent)
    end
  end
end

function update_weaponskill_binds()
  local weapon = nil
  local weapon_type = nil
  --Handle barehanded case
  if player.equipment.main == nil or player.equipment.main == 0 or player.equipment.main == 'empty' then
    weapon_type = 'Hand-to-Hand'
  else --All other types of weapons
    weapon = res.items:with('name', player.equipment.main)
    weapon_type = res.skills[weapon.skill].en
  end

  --Change keybinds if weapon type changed
  if weapon_type ~= current_weapon_type then
    current_weapon_type = weapon_type
    --Set weaponskill bindings by weapon type
    if current_weapon_type == 'Hand-to-Hand' then
      send_command('bind ^numpad7 input /ws "Victory Smite" <t>')
      send_command('bind ^numpad8 input /ws "Ascetic\'s Fury" <t>')
      send_command('bind ^numpad9 input /ws "Shijin Spiral" <t>')
      send_command('bind ^numpad4 input /ws "Asuran Fists" <t>')
      send_command('bind ^numpad5 input /ws "Shoulder Tackle" <t>')
      send_command('bind ^numpad6 input /ws "Howling Fist" <t>')
      send_command('bind ^numpad1 input /ws "Spinning Attack" <t>') --aoe
      send_command('bind ^numpad2 input /ws "Raging Fists" <t>')
    elseif current_weapon_type == 'Dagger' then
      send_command('bind ^numpad7 input /ws "Exenterator" <t>')
      send_command('bind ^numpad8 input /ws "Mandalic Stab" <t>')
      send_command('bind ^numpad9 input /ws "Shark Bite" <t>')
      send_command('bind ^numpad4 input /ws "Evisceration" <t>')
      send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
      send_command('bind ^numpad6 input /ws "Pyrrhic Kleos" <t>')
      send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>') --aoe
      send_command('bind ^numpad2 input /ws "Cyclone" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Energy Drain" <t>') --elemental
    elseif current_weapon_type == 'Sword' then
      send_command('bind ^numpad7 input /ws "Chant du Cygne" <t>')
      send_command('bind ^numpad4 input /ws "Savage Blade" <t>')
      send_command('bind ^numpad5 input /ws "Requiescat" <t>')
      send_command('bind ^numpad6 input /ws "Sanguine Blade" <t>')
      send_command('bind ^numpad1 input /ws "Circle Blade" <t>') --aoe
      send_command('bind ^numpad2 input /ws "Red Lotus Blade" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Seraph Blade" <t>') --elemental
    elseif current_weapon_type == 'Great Sword' then
      send_command('bind ^numpad7 input /ws "Resolution" <t>')
      send_command('bind ^numpad9 input /ws "Dimidiation" <t>')
      send_command('bind ^numpad8 input /ws "Ground Strike" <t>')
      send_command('bind ^numpad1 input /ws "Shockwave" <t>') --aoe, sleep
      send_command('bind ^numpad2 input /ws "Freezebite" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Herculean Slash" <t>') --elemental, paralyze
    elseif current_weapon_type == 'Axe' then
    elseif current_weapon_type == 'Great Axe' then
      send_command('bind ^numpad4 input /ws "Upheaval" <t>')
      send_command('bind ^numpad5 input /ws "Full Break" <t>')
      send_command('bind ^numpad6 input /ws "Armor Break" <t>')
      send_command('bind ^numpad1 input /ws "Fell Cleave" <t>') --aoe
    elseif current_weapon_type == 'Scythe' then
      send_command('bind ^numpad2 input /ws "Shadow of Death" <t>') --elemental
    elseif current_weapon_type == 'Polearm' then
      send_command('bind ^numpad7 input /ws "Camlann\'s Torment" <t>')
      send_command('bind ^numpad8 input /ws "Drakesbane" <t>')
      send_command('bind ^numpad4 input /ws "Stardiver" <t>')
      send_command('bind ^numpad5 input /ws "Geirskogul" <t>')
      send_command('bind ^numpad6 input /ws "Impulse Drive" <t>')
      send_command('bind ^numpad1 input /ws "Sonic Thrust" <t>')
      send_command('bind ^numpad2 input /ws "Raiden Thrust" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Leg Sweep" <t>')
    elseif current_weapon_type == 'Katana' then
      send_command('bind ^numpad7 input /ws "Blade: Kamu" <t>')
      send_command('bind ^numpad8 input /ws "Blade: Shun" <t>')
      send_command('bind ^numpad4 input /ws "Blade: Ten" <t>')
      send_command('bind ^numpad5 input /ws "Blade: Chi" <t>')
      send_command('bind ^numpad6 input /ws "Blade: Hi" <t>')
      send_command('bind ^numpad1 input /ws "Blade: Yu" <t>') --aoe
      send_command('bind ^numpad2 input /ws "Blade: Ei" <t>') --elemental
    elseif current_weapon_type == 'Great Katana' then
      send_command('bind ^numpad2 input /ws "Tachi: Jinpu" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Tachi: Koki" <t>') --elemental
    elseif current_weapon_type == 'Club' then
      send_command('bind ^numpad7 input /ws "Black Halo" <t>')
      send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
      send_command('bind ^numpad5 input /ws "Realmrazer" <t>')
      send_command('bind ^numpad1 input /ws "Flash Nova" <t>')
      send_command('bind ^numpad2 input /ws "Seraph Strike" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Mystic Boon" <t>')
    elseif current_weapon_type == 'Staff' then
      send_command('bind ^numpad1 input /ws "Cataclysm" <t>') --aoe
      send_command('bind ^numpad2 input /ws "Earth Crusher" <t>') --elemental
      send_command('bind ^numpad3 input /ws "Sunburst" <t>') --elemental
    end
  end
end
