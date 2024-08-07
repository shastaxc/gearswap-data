--[[
File Status: Good.

Author: Silvermutt
Required external libraries: SilverLibs
Required addons: N/A
Recommended addons: WSBinder, Reorganizer
Misc Recommendations: Disable RollTracker

∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  General Use Tips
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes
* Offense Mode: Changes melee accuracy level
* Hybrid Mode: Changes gear sets based on whether you want pet or master focused stats
  * Master: Uses "Halfsies" set variants if idle on pet ready moves; does not swap to pet stats when engaged. Mostly focused
    on boosting master's stats.
  * Halfsies: A relatively even split between master and pet stats.
  * PetDT: Focused on pet stats + master defense (in case you need to be in close range).
  * Pet: Focused solely on pet stats.
* Defense Mode: Equips super high emergency damage reduction set, greatly reduces your DPS output
* Idle Mode: Determines which set to use when not engaged
  * Normal: Allows automatically equipping Regen, Refresh, and Regain gear as needed
  * DT: Ensures enough defensive gear is equipped to keep you safe in case you need to be in close range even if Hybrid
    Mode is set to Pet.
  * Regain: Equips maximum Regain gear. This set is not balanced with other stats and may overwrite movement speed
    gear. This is intended for short term use only when needed.
* CP Mode: Equips Capacity Points bonus cape
* AttCapped: When on, if you have AttCapped set variants for your weaponskills, it will use that. This mode is
  intended to be used when you think you are attack capped vs your enemy such as when you have a lot of Attack buffs
  from BRD, COR, GEO, etc.
* Jug Mode: Feel free to adjust cycle with any pets you wish to summon. This only affects the Bestial Loyalty keybind.
  This will automate swapping into the correct Jug in your ammo slot. The ready moves are tied to the pet that is detected
  as alive, not what your JugMode is set to.
* PetMode: Determines if pet gear should be focused on offensive or defensive stats for "idle" and "engaged" sets.
* CorrelationMode: If set to "Favorable" and ready move is physical, Empyrean helm will be used for the Ready set.
* AutomaticPetTargeting: If turned on, when master is engaged on an enemy and pet is idle, it will issue the "Fight"
  command to your pet automatically. There is a keybind to toggle that behavior if you choose.

Weapons
* Use keybinds to cycle weapons.
* If you want different weapon sets, edit the sets.WeaponSet sets.
  * Additional weapon sets can be created but you need to also add them to the state.WeaponSet cycle.
* Feel free to put weapons into sets, but they will only swap if in Pet or PetDT hybrid mode and master is not
  engaged. Otherwise, you will be locked into whatever weapons are set in your state.WeaponSet cycle.
* The "DW" variants of sets will be used automatically if the Dual Wield trait is available.
  * If idle or in pet mode and you use an ability but cannot dual wield, your offhand will use sets.FallbackShield.

Abilities
* Ready moves will not swap gear for the midcast if you are in Master hybrid mode unless they are included in the
  list called always_swap_moves. Feel free to modify that list as you see fit.
* A UI displaying current pet's Ready moves is enabled by default. It displays the following info:
    Index|    Ability Type    Range Type    [Charges]    Name    (Description)
    Example: Dust Cloud, a magical conal attack
    1| M ▼ [1] Dust Cloud (Blind)
  * Magical attacks are also color coded by element so "Dust Cloud (Blind)" would be a yellow/brown color.
  * There are some configuration options available for the UI in the job_setup() function. Please adjust as you
    see fit.
  * The "Index" number correlates to the custom commands available in this lua for issuing Ready commands to your
    pet. See "Custom Commands" below for more details.
* While Unleash is active, you will be locked into pet midcast sets, with the assumption that you're going to
  be spamming it.

Other
* If you are not using my reorganizer addon, remove all the sets.org sets (including in character global file).
* I generally plan out best-in-slot (BiS) pieces for each set even before I acquire the pieces. These BiS pieces are
  left commented out in the set, while placeholders that I do have in the meantime are uncommented for that slot.
* I like to list out the important stats for each piece of item in most of my sets, and then have a total at
  the bottom of the set. If you ever change any pieces of gear, you should recalculate the stats for the new piece
  and then recalculate for the set total, or just remove those stat comments entirely to avoid confusion. However,
  if you choose to ignore them, it doesn't not actually affect anything.
* Equipping certain gear such as warp rings or ammo belts will automatically lock that slot until you manually
  unequip it or change zones.
* Set named sets.SleepyHead will be equipped if you are asleep. This should have a piece of gear in it that
  will deal damage to you to wake you up.
* If your pet is engaged and you are in Pet mode, you will be in a PetEngaged set typically. If you need movement
  speed gear equipped in this situation, you can toggle on Kiting mode (CTRL+F10). Just remember to turn it off
  when you're done.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                      Keybinds
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Modes:
  [ F9 ]                Cycle Melee Accuracy
  [ CTRL+F9 ]           Cycle Melee Defense
  [ ALT+F9 ]            Cycle Ranged Accuracy
  [ F10 ]               Toggle Emergency -PDT
  [ ALT+F10 ]           Toggle Kiting (on = move speed gear always equipped)
  [ F11 ]               Toggle Emergency -MDT
  [ F12 ]               Report current status
  [ CTRL+F12 ]          Cycle Idle modes
  [ ALT+F12 ]           Cancel Emergency -PDT/-MDT Mode
  [ WIN+C ]             Toggle Capacity Points Mode
  [ CTRL+F8 ]           Toggle Attack Capped mode
  [ CTRL+Home ]         Cycle Jug mode
  [ CTRL+End ]          Cycleback Jug mode
  [ ALT+End ]           Reset Jug mode
  [ CTRL+PageUp ]       Cycleback Pet mode
  [ CTRL+PageDown ]     Cycle Pet mode
  [ ALT+PageDown ]      Reset Pet mode
  [ ALT+Z ]             Toggle Automatic Pet Targeting mode
  [ ALT+X ]             Toggle Correlation mode
  [ CTRL+U ]            Toggle UI

Weapons:
  [ CTRL+Insert ]       Cycle Weapon Sets
  [ CTRL+Delete ]       Cycleback Weapon Sets
  [ ALT+Delete ]        Reset to default Weapon Set

Spells:
  ============ /NIN ============
  [ ALT+Numpad0 ]       Utsusemi: Ichi
  [ ALT+Numpad. ]       Utsusemi: Ni

Abilities:
  [ ALT+E ]             Reward
  [ ALT+Q ]             Fight
  [ ALT+W ]             Heel
  [ ALT+` ]             Bestial Loyalty (if no pet) / Leave (if pet)
  ============ /WAR ============
  [ CTRL+Numlock ]      Defender
  [ CTRL+Numpad/ ]      Berserk
  [ CTRL+Numpad* ]      Warcry
  [ CTRL+Numpad- ]      Aggressor

SilverLibs keybinds:
  [ ALT+D ]             Interact
  [ ALT+S ]             Turn 180 degrees in place
  [ WIN+W ]             Toggle Rearming Lock
                          (off = re-equip previous weapons if you go barehanded)
                          (on = prevent weapon auto-equipping)
  [ CTRL+` ]            Cycle Treasure Hunter Mode

For more info and available functions, see SilverLibs documentation at:
https://github.com/shastaxc/silver-libs

Global-Binds.lua contains additional non-job-related keybinds.


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                                  Custom Commands
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
Prepend with /console to use these in in-game macros.

Note: Not all pets have 7 ready moves, but for those that do, there is a command for it
gs c ready 1            Uses Ready move index 1
gs c ready 2            Uses Ready move index 2
gs c ready 3            Uses Ready move index 3
gs c ready 4            Uses Ready move index 4
gs c ready 5            Uses Ready move index 5
gs c ready 6            Uses Ready move index 6
gs c ready 7            Uses Ready move index 7

gs c bind               Sets keybinds again. Sometimes they don't all get set when swapping jobs. Calling this manually fixes it.

(More commands available through SilverLibs)


∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
                                            Recommended In-game Macros
∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
__Keybind___Name______________Command_____________
[ CTRL+1 ] Ready1         /console gs c ready 1
[ CTRL+2 ] Ready2         /console gs c ready 2
[ CTRL+3 ] Ready3         /console gs c ready 3
[ CTRL+4 ] Ready4         /console gs c ready 4
[ CTRL+5 ] Tame           /ja "Tame" <t>
[ CTRL+6 ] Charm          /ja "Charm" <t>
[ CTRL+7 ] FeralHow       /ja "Feral Howl" <t>
[ CTRL+9 ] Familiar       /ja "Familiar" <me>
[ CTRL+0 ] Provoke        /ja "Provoke" <stnpc>
[ ALT+1 ]  Ready5         /console gs c ready 5
[ ALT+2 ]  Ready6         /console gs c ready 6
[ ALT+3 ]  Ready7         /console gs c ready 7
[ ALT+4 ]  Spur           /ja "Spur" <me>
[ ALT+5 ]  CallBeas       /ja "Call Beast" <me>
[ ALT+7 ]  Snarl          /ja "Snarl" <me>
[ ALT+8 ]  KillerIn       /ja "Killer Instinct" <me>
[ ALT+9 ]  Unleash        /ja "Unleash" <me>
[ ALT+0 ]  RunWild        /ja "Run Wild" <me>

]]--


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  equip({main=empty,sub=empty})
  
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c weaponset current')
  end, 5)
  
  texts = require('texts') -- Used for pet UI
end

-- Executes on first load and main job change
function job_setup()
  -- UPDATE THESE SETTINGS FOR UI
  state.ShowUI = M(true, 'Show UI')
  ui_x_position = 145
  ui_y_position = 625
  ui_font = 'Cascadia Mono' -- Can use any font on your OS
  ui_show_ability_description = true

  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(9)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('Master', 'Halfsies', 'PetDT', 'Pet')
  state.IdleMode:options('Normal', 'DT', 'RegainOnly')
  state.CP = M(false, 'Capacity Points Mode')
  state.AutomaticPetTargeting = M(true, 'Automatic Pet Targeting')
  state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
  state.AttCapped = M(true, 'Attack Capped')
  state.PetMode = M{['description']='Pet Mode', 'Tank', 'DD'}
  state.JugMode = M{['description']='Jug Mode', 'GenerousArthur', 'VivaciousVickie', 'RhymingShizuna', 'SwoopingZhivago', 'FatsoFargann'}

  -- Jug pets info
  jugs = {
    -- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
    ['FunguarFamiliar']   = {item='Seedbed Soil', nq_pet='', type='Plantoid', family='Funguar',},
    ['CourierCarrie']     = {item='Fish Oil Broth', nq_pet='', type='Aquan', family='Crab',},
    ['AmigoSabotender']   = {item='Sun Water', nq_pet='', type='Plantoid', family='Sabotender',},
    ['NurseryNazuna']     = {item='D. Herbal Broth', nq_pet='', type='Beast', family='Sheep',},
    ['CraftyClyvonne']    = {item='Cng. Brain Broth', nq_pet='', type='Beast', family='Coeurl',},
    ['PrestoJulio']       = {item='C. Grass. Broth', nq_pet='', type='Plantoid', family='Flytrap',},
    ['SwiftSieghard']     = {item='Mlw. Bird Broth', nq_pet='', type='Lizard', family='Raptor',},
    ['MailbusterCetas']   = {item='Gob. Bug Broth', nq_pet='', type='Vermin', family='Fly',},
    ['AudaciousAnna']     = {item='B. Carrion Broth', nq_pet='', type='Lizard', family='Hill Lizard',},
    ['TurbidToloi']       = {item='Auroral Broth', nq_pet='', type='Aquan', family='Pugil',},
    ['LuckyLulush']       = {item='L. Carrot Broth', nq_pet='', type='Beast', family='Rabbit',},
    ['DipperYuly']        = {item='Wool Grease', nq_pet='', type='Vermin', family='Ladybug',},
    ['FlowerpotMerle']    = {item='Vermihumus', nq_pet='', type='Plantoid', family='Mandragora',},
    ['DapperMac']         = {item='Briny Broth', nq_pet='', type='Bird', family='Apkallu',},
    ['DiscreetLouise']    = {item='Deepbed Soil', nq_pet='', type='Plantoid', family='Funguar',},
    ['FatsoFargann']      = {item='C. Plasma Broth', nq_pet='', type='Amorph', family='Leech',},
    ['FaithfulFalcorr']   = {item='Lucky Broth', nq_pet='', type='Bird', family='Hippogryph',},
    ['BugeyedBroncha']    = {item='Svg. Mole Broth', nq_pet='', type='Lizard', family='Eft',},
    ['BloodclawShasra']   = {item='Rzr. Brain Broth', nq_pet='', type='Beast', family='Coeurl',},
    ['GorefangHobs']      = {item='B. Carrion Broth', nq_pet='', type='Beast', family='Tiger',},
    ['GooeyGerard']       = {item='Cl. Wheat Broth', nq_pet='', type='Amorph', family='Slug',},
    ['CrudeRaphie']       = {item='Shadowy Broth', nq_pet='', type='Lizard', family='Adamantoise',},

    -- Complete iLvl Jug Pet Precast List
    ['DroopyDortwin']     = {item='Swirling Broth', nq_pet='', type='Beast', family='Rabbit',},
    ['SunburstMalfik']    = {item='Shimmering Broth', nq_pet='', type='Aquan', family='Crab',},
    ['WarlikePatrick']    = {item='Livid Broth', nq_pet='', type='Lizard', family='Hill Lizard',},
    ['ScissorlegXerin']   = {item='Spicy Broth', nq_pet='', type='Vermin', family='Chapuli',},
    ['RhymingShizuna']    = {item='Lyrical Broth', nq_pet='', type='Beast', family='Sheep',},
    ['AttentiveIbuki']    = {item='Salubrious Broth', nq_pet='', type='Bird', family='Tulfaire',},
    ['AmiableRoche']      = {item='Airy Broth', nq_pet='', type='Aquan', family='Pugil',},
    ['HeraldHenry']       = {item='Trans. Broth', nq_pet='', type='Aquan', family='Crab',},
    ['BrainyWaluis']      = {item='Crumbly Soil', nq_pet='', type='Plantoid', family='Funguar',},
    ['HeadbreakerKen']    = {item='Blackwater Broth', nq_pet='', type='Vermin', family='Fly',},
    ['SuspiciousAlice']   = {item='Furious Broth', nq_pet='', type='Lizard', family='Eft',},
    ['AnklebiterJedd']    = {item='Crackling Broth', nq_pet='', type='Vermin', family='Diremite',},
    ['FleetReinhard']     = {item='Rapid Broth', nq_pet='', type='Lizard', family='Raptor',},
    ['CursedAnnabelle']   = {item='Creepy Broth', nq_pet='', type='Vermin', family='Antlion',},
    ['SurgingStorm']      = {item='Insipid Broth', nq_pet='', type='Bird', family='Apkallu',},
    ['RedolentCandi']     = {item='Electrified Broth', nq_pet='', type='Plantoid', family='Snapweed',},
    ['CaringKiyomaro']    = {item='Fizzy Broth', nq_pet='', type='Beast', family='Raaz',},
    ['HurlerPercival']    = {item='Pale Sap', nq_pet='', type='Vermin', family='Beetle',},
    ['BlackbeardRandy']   = {item='Meaty Broth', nq_pet='', type='Beast', family='Tiger',},
    ['GenerousArthur']    = {item='Dire Broth', nq_pet='', type='Amorph', family='Slug',},
    ['ThreestarLynn']     = {item='Muddy Broth', nq_pet='', type='Vermin', family='Ladybug',},
    ['MosquitoFamiliar']  = {item='Wetlands Broth', nq_pet='', type='Vermin', family='Mosquito',},
    ['BraveHeroGlenn']    = {item='Wispy Broth', nq_pet='', type='Aquan', family='Frog',},
    ['SharpwitHermes']    = {item='Saline Broth', nq_pet='', type='Plantoid', family='Mandragora',},
    ['ColibriFamiliar']   = {item='Sugary Broth', nq_pet='', type='Bird', family='Colibri',},
    ['SpiderFamiliar']    = {item='Sticky Webbing', nq_pet='', type='Vermin', family='Spider',},
    ['AcuexFamiliar']     = {item='Poisonous Broth', nq_pet='', type='Amorph', family='Acuex',},
    ['WeevilFamiliar']    = {item='Pristine Sap', nq_pet='', type='Vermin', family='Lucani',},
    ['SweetCaroline']     = {item='Aged Humus', nq_pet='', type='Plantoid', family='Mandragora',},
    ['P.CrabFamiliar']    = {item='Rancid Broth', nq_pet='', type='Aquan', family='Crab',},
    ['Y.BeetleFamiliar']  = {item='Zestful Sap', nq_pet='', type='Vermin', family='Yellow Beetle',},
    ['LynxFamiliar']      = {item='Frizzante Broth', nq_pet='', type='Beast', family='Coeurl',},
    ['Hip.Familiar']      = {item='Turpid Broth', nq_pet='', type='Bird', family='Hippogryph',},
    ['SlimeFamiliar']     = {item='Decaying Broth', nq_pet='', type='Amorph', family='Slime',},

    -- HQ pets
    ['PonderingPeter']    = {item='Vis. Broth', nq_pet='Droopy Dortwin', type='Beast', family='Rabbit',},
    ['AgedAngus']         = {item='Ferm. Broth', nq_pet='Sunburst Malfik', type='Aquan', family='Crab',},
    ['BouncingBertha']    = {item='Bubbly Broth', nq_pet='Scissorleg Xerin', type='Vermin', family='Chapuli',},
    ['SwoopingZhivago']   = {item='Windy Greens', nq_pet='Attentive Ibuki', type='Bird', family='Tulfaire',},
    ['AlluringHoney']     = {item='Bug-Ridden Broth', nq_pet='Redolent Candi', type='Plantoid', family='Snapweed',},
    ['VivaciousVickie']   = {item='Tant. Broth', nq_pet='Caring Kiyomaro', type='Beast', family='Raaz',},
    ['ChoralLeera']       = {item='Glazed Broth', nq_pet='Colibri Familiar', type='Bird', family='Colibri',},
    ['GussyHachirobe']    = {item='Slimy Webbing', nq_pet='Spider Familiar', type='Vermin', family='Spider',},
    ['SubmergedIyo']      = {item='Deepwater Broth', nq_pet='Surging Storm', type='Bird', family='Apkallu',},
    ['FluffyBredo']       = {item='Venomous Broth', nq_pet='Acuex Familiar', type='Amorph', family='Acuex',},
    ['Left-HandedYoko']   = {item='Heavenly Broth', nq_pet='Mosquito Familiar', type='Vermin', family='Mosquito',},
    ['StalwartAngelina']  = {item='T. Pristine Sap', nq_pet='Weevil Familiar', type='Vermin', family='Lucani',},
    ['JovialEdwin']       = {item='Pungent Broth', nq_pet='Porter Crab Familiar', type='Aquan', family='Crab',},
    ['EnergizedSefina']   = {item='Gassy Sap', nq_pet='Yellow Beetle Familiar', type='Vermin', family='Yellow Beetle',},
    ['VivaciousGaston']   = {item='Spumante Broth', nq_pet='Lynx Familiar', type='Beast', family='Coeurl',},
    ['DaringRoland']      = {item='Feculent Broth', nq_pet='Hippogryph Familiar', type='Bird', family='Hippogryph',},
    ['SultryPatrice']     = {item='Putrescent Broth', nq_pet='Slime Familiar', type='Amorph', family='Slime',},
  }

  family_ready_move_lists = {
    ['Funguar'] = {[1]='Frogkick',[2]='Spore',[3]='Queasyshroom',[4]='Numbshroom',[5]='Shakeshroom',[6]='Silence Gas',[7]='Dark Spore'},
    ['Crab'] = {[1]='Metallic Body',[2]='Scissor Guard',[3]='Bubble Curtain',[4]='Mega Scissors',[5]='Venom Shower'},
    ['Sabotender'] = {[1]='Needleshot',[2]='??? Needles'},
    ['Sheep'] = {[1]='Sheep Song',[2]='Rage',[3]='Sheep Charge',[4]='Lamb Chop'},
    ['Coeurl'] = {[1]='Chaotic Eye',[2]='Blaster',[3]='Charged Whisker',[4]='Frenzied Rage'},
    ['Flytrap'] = {[1]='Soporific',[2]='Gloeosuccus',[3]='Palsy Pollen'},
    ['Raptor'] = {[1]='Scythe Tail',[2]='Ripper Fang',[3]='Chomp Rush'},
    ['Fly'] = {[1]='Cursed Sphere',[2]='Venom',[3]='Somersault'},
    ['Hill Lizard'] = {[1]='Tail Blow',[2]='Fireball',[3]='Blockhead',[4]='Brain Crush',[5]='Infrasonics',[6]='Secretion'},
    ['Pugil'] = {[1]='Water Wall',[2]='Intimidate',[3]='Recoil Dive'},
    ['Rabbit'] = {[1]='Wild Carrot',[2]='Dust Cloud',[3]='Whirl Claws',[4]='Foot Kick'},
    ['Ladybug'] = {[1]='Sudden Lunge',[2]='Spiral Spin',[3]='Noisome Powder'},
    ['Mandragora'] = {[1]='Head Butt',[2]='Dream Flower',[3]='Wild Oats',[4]='Leaf Dagger',[5]='Scream'},
    ['Apkallu'] = {[1]='Wing Slap',[2]='Beak Lunge'},
    ['Leech'] = {[1]='TP Drainkiss',[2]='Acid Mist',[3]='Drainkiss',[4]='Suction'},
    ['Hippogryph'] = {[1]='Nihility Song',[2]='Jettatura',[3]='Choke Breath',[4]='Back Heel',[5]='Hoof Volley',[6]='Fantod'},
    ['Eft'] = {[1]='Geist Wall',[2]='Numbing Noise',[3]='Cyclotail',[4]='Nimble Snap',[5]='Toxic Spit'},
    ['Tiger'] = {[1]='Claw Cyclone',[2]='Crossthrash',[3]='Predatory Glare',[4]='Roar',[5]='Razor Fang'},
    ['Slug'] = {[1]='Purulent Ooze',[2]='Corrosive Ooze'},
    ['Adamantoise'] = {[1]='Harden Shell',[2]='Tortoise Stomp',[3]='Aqua Breath'},
    ['Chapuli'] = {[1]='Tegmina Buffet',[2]='Sensilla Blades'},
    ['Tulfaire'] = {[1]='Swooping Frenzy',[2]='Molting Plumage',[3]='Pentapeck'},
    ['Diremite'] = {[1]='Filamented Hold',[2]='Spinning Top',[3]='Double Claw',[4]='Grapple'},
    ['Antlion'] = {[1]='Mandibular Bite',[2]='Sandpit',[3]='Sandblast',[4]='Venom Spray'},
    ['Snapweed'] = {[1]='Tickling Tendrils',[2]='Stink Bomb',[3]='Nectarous Deluge',[4]='Nepenthic Plunge'},
    ['Raaz'] = {[1]='Zealous Snort',[2]='Sweeping Gouge'},
    ['Beetle'] = {[1]='Power Attack',[2]='Rhino Attack',[3]='Hi-Freq Field',[4]='Rhino Guard',[5]='Spoil'},
    ['Mosquito'] = {[1]='Infected Leech',[2]='Gloom Spray'},
    ['Frog'] = {},
    ['Colibri'] = {[1]='Pecking Flurry'},
    ['Spider'] = {[1]='Sickle Slash',[2]='Acid Spray',[3]='Spider Web'},
    ['Acuex'] = {[1]='Pestilent Plume',[2]='Foul Waters'},
    ['Lucani'] = {[1]='Extirpating Salvo',[2]='Disembowel'},
    ['Yellow Beetle'] = {[1]='Rhinowrecker',[2]='Power Attack',[3]='Rhino Attack',[4]='Hi-Freq Field',[5]='Rhino Guard',[6]='Spoil'},
    ['Slime'] = {[1]='Fluid Spread',[2]='Fluid Toss',[3]='Digest'},
  }

  -- Categories: physical, matk, macc, buff
  -- Some values pulled from Windower resources on load
  ready_moves = {
    ['Foot Kick'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Whirl Claws'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='',},
    ['Sheep Charge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='',},
    ['Lamb Chop'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Head Butt'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Wild Oats'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='-VIT',},
    ['Leaf Dagger'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Claw Cyclone'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='',},
    ['Razor Fang'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Crossthrash'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Dispel',},
    ['Nimble Snap'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Cyclotail'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='',},
    ['Rhino Attack'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Power Attack'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='',},
    ['Mandibular Bite'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Mega Scissors'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='',},
    ['Grapple'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='',},
    ['Spinning Top'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='',},
    ['Double Claw'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Frogkick'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Ignore Def',},
    ['Blockhead'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Brain Crush'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Silence',},
    ['Tail Blow'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Stun',},
    ['Scythe Tail'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Stun',},
    ['Ripper Fang'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Chomp Rush'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=true, range_type='Single', effect='Slow',},
    ['Needleshot'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Recoil Dive'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='',},
    ['Sudden Lunge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Stun',},
    ['Spiral Spin'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='-Acc',},
    ['Wing Slap'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true, range_type='Single', effect='Stun',},
    ['Beak Lunge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Suction'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Stun',},
    ['Back Heel'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Tortoise Stomp'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='-Def',},
    ['Sensilla Blades'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='',},
    ['Tegmina Buffet'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Choke (-VIT)',},
    ['Pentapeck'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=true, range_type='Conal', effect='Amnesia',},
    ['Sweeping Gouge'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true, range_type='Conal', effect='-Def',},
    ['Somersault'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Tickling Tendrils'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true, range_type='Single', effect='Stun',},
    ['Pecking Flurry'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=true, range_type='Single', effect='',},
    ['Sickle Slash'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='',},
    ['Disembowel'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='-Acc',},
    ['Extirpating Salvo'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Stun',},
    ['Rhinowrecker'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='-Def',},
    ['Hoof Volley'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='',},
    ['Fluid Toss'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='',},
    ['Fluid Spread'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='',},
    ['Queasyshroom'] = {id=0, name='', set='Physical', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Poison',},
    ['??? Needles'] = {id=0, name='', set='Physical', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='',},

    ['Dust Cloud'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Blind', element='Earth',},
    ['Cursed Sphere'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='', element='Darkness',},
    ['Venom'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Poison', element='Water',},
    ['Venom Shower'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='-STR', element='Water',},
    ['Drainkiss'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Absorb HP', element='Darkness'},
    ['Silence Gas'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Silence', element='Darkness'},
    ['Dark Spore'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Blind', element='Darkness'},
    ['Fireball'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='', element='Fire',},
    ['Charged Whisker'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='', element='Thunder',},
    ['Corrosive Ooze'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='-Atk & -Def', element='Water',},
    ['Aqua Breath'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='', element='Water',},
    ['Stink Bomb'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='Blind & Paralyze', element='Earth',},
    ['Nectarous Deluge'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='Poison', element='Water',},
    ['Nepenthic Plunge'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Drown (-STR) & Weight', element='Water',},
    ['Pestilent Plume'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Plague & Blind & -MDB', element='Darkness',},
    ['Foul Waters'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Drown (-STR) & Weight', element='Water',},
    ['Acid Spray'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Poison', element='Water',},
    ['Infected Leech'] = {id=0, name='', set='Matk', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Absorb HP & Plague', element='Darkness',},
    ['Gloom Spray'] = {id=0, name='', set='Matk', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Dispel', element='Darkness',},

    ['Sheep Song'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Sleep',},
    ['Scream'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='-MND',},
    ['Dream Flower'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Sleep',},
    ['Roar'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Paralyze',},
    ['Predatory Glare'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Stun',},
    ['Gloeosuccus'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Slow',},
    ['Palsy Pollen'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Paralyze',},
    ['Soporific'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Sleep',},
    ['Geist Wall'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Dispel',},
    ['Toxic Spit'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Poison',},
    ['Numbing Noise'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Stun',},
    ['Spoil'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='-STR',},
    ['Hi-Freq Field'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='-Eva',},
    ['Sandpit'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Bind',},
    ['Sandblast'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Blind',},
    ['Venom Spray'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='Poison',},
    ['Filamented Hold'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Slow',},
    ['Numbshroom'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Paralyze',},
    ['Spore'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Paralyze',},
    ['Shakeshroom'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Single', effect='Disease',},
    ['Infrasonics'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='-Eva',},
    ['Chaotic Eye'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Silence',},
    ['Blaster'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Paralyze',},
    ['Purulent Ooze'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='-Max HP & Bio',},
    ['Intimidate'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Slow',},
    ['Noisome Powder'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='-Atk',},
    ['Acid Mist'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='-Atk',},
    ['Choke Breath'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Paralyze & Silence',},
    ['Jettatura'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='Conal', effect='Terror',},
    ['Nihility Song'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='Dispel',},
    ['Molting Plumage'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='Dispel',},
    ['Swooping Frenzy'] = {id=0, name='', set='Macc', charges=0, tp_affected=false, multihit=false, range_type='Conal', effect='-Def & -MDB',},
    ['Spider Web'] = {id=0, name='', set='Macc', charges=0, tp_affected=true, multihit=false, range_type='AoE', effect='Slow',},

    ['TP Drainkiss'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Absorb TP',}, -- Putting in Buff set because it never misses, doesn't need m.acc
    ['Wild Carrot'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='Cure',},
    ['Bubble Curtain'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='MDT',},
    ['Scissor Guard'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='+Def',},
    ['Secretion'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='+Eva',},
    ['Rage'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='+Atk & -Def',},
    ['Harden Shell'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='+Def',},
    ['Rhino Guard'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='Self', effect='+Eva',},
    ['Zealous Snort'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Self', effect='Haste, MDB, Counter, Guard',},
    ['Frenzied Rage'] = {id=0, name='', set='Buff', charges=0, tp_affected=false, multihit=false, range_type='AoE', effect='+Atk',},
    ['Digest'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Single', effect='Absorb HP',},
    ['Metallic Body'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Self', effect='Stoneskin',},
    ['Water Wall'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Self', effect='+Def',},
    ['Fantod'] = {id=0, name='', set='Buff', charges=0, tp_affected=true, multihit=false, range_type='Self', effect='+Atk next',},
  }

  -- Populate a few fields of pet info from resource files
  for k,v in pairs(ready_moves) do
    local ja = res.job_abilities:with('en', k)
    v.id = ja.id
    v.charges = ja.mp_cost
    v.name = k
  end

  -- Validate that all pet ready moves have info defined
  for family,move_list in pairs(family_ready_move_lists) do
    for index,ready_move_name in ipairs(move_list) do
      if not ready_moves[ready_move_name] then
        print('Error: Missing "'..ready_move_name..'" from "ready_moves" list.')
      end
    end
  end

  -- List of Ready moves to allow gear swapping even when hybrid mode is set to 'Master'
  always_swap_moves = S{
    'Purulent Ooze',
    'TP Drainkiss',
  }

  sets.org.job = {}

  -- Add jugs from JugMode to org array
  for k,name in ipairs(state.JugMode) do
    if jugs[name] then
      sets.org.job[#sets.org.job+1] = {ammo=jugs[name].item}
    else
      print('Error: Cannot find jug item for pet '..name)
    end
  end

  ----------------- DO NOT MODIFY BELOW -----------------
  skill_ids_2h = S{4, 6, 7, 8, 10, 12}
  fencer_tp_bonus = {200, 300, 400, 450, 500, 550, 600, 630}
  current_pet = nil
  last_pet_midcast_set = {}
  last_pet_midaction_time = 0 -- DO NOT MODIFY
  fight_max_range = 16 -- Player and target model sizes are added later
  ----------------- DO NOT MODIFY ABOVE -----------------
  
  element_colors = {
    ['Fire']      = '\\cs(244,  58,  18)',
    ['Ice']       = '\\cs(136, 238, 244)',
    ['Wind']      = '\\cs( 41, 224,   8)',
    ['Earth']     = '\\cs(246, 205,  51)',
    ['Thunder']   = '\\cs(199,  81, 254)',
    ['Water']     = '\\cs( 94, 149, 235)',
    ['Light']     = '\\cs(238, 238, 191)',
    ['Darkness']  = '\\cs(151, 139, 184)',
  }
  default_txt_color = '\\cs(255, 255, 255)'
  range_symbol = {
    ['Self'] = '↑',
    ['Single'] = '•',
    ['Conal'] = '▼',
    ['AoE'] = '◯',
  }
  ready_move_set_symbol = {
    ['Physical'] = 'P',
    ['Matk'] = 'M',
    ['Macc'] = ' ',
    ['Buff'] = ' ',
  }
  ready_charge_cost_symbol = {
    [1] = '1',
    [2] = '2',
    [3] = '3',
  }

  -- Does not include Ready moves
  abilities_require_pet = S{'Familiar', 'Reward', 'Fight', 'Heel', 'Leave', 'Stay', 'Snarl', 'Spur', 'Run Wild'}

  -- All jugs IDs
  jug_full_list = {}
  for k,item in pairs(res.items) do
    if item.id > 17860 and item.type == 4 and item.stack == 12 and item.flags.Equippable and item.flags.Flag02 and item.jobs[9] then
      jug_full_list[item.en]=true
    end
  end

  create_ui()
  on_pet_change(pet and pet.name)

  job_keybinds = {
    ['main'] = {
      ['!s'] = 'gs c faceaway',
      ['!d'] = 'gs c interact',
      ['@w'] = 'gs c toggle RearmingLock',
      ['^`'] = 'gs c cycle treasuremode',
      ['@c'] = 'gs c toggle CP',
      ['^f8'] = 'gs c toggle AttCapped',
      ['!z'] = 'gs c toggle AutomaticPetTargeting',
      ['^u'] = 'gs c toggle ShowUI',
      ['^insert'] = 'gs c weaponset cycle',
      ['^delete'] = 'gs c weaponset cycleback',
      ['!delete'] = 'gs c weaponset reset',
      ['^home'] = 'gs c cycle JugMode',
      ['^end'] = 'gs c cycleback JugMode',
      ['!end'] = 'gs c reset JugMode',
      ['^pageup'] = 'gs c petmode cycleback',
      ['^pagedown'] = 'gs c petmode cycle',
      ['!pagedown'] = 'gs c petmode reset',
      ['!x'] = 'gs c cycle CorrelationMode',
      ['!`'] = 'gs c petactivation',
      ['!q'] = 'gs c petcontrol fight',
      ['!w'] = 'gs c petcontrol heel',
      ['!e'] = 'input /ja "Reward" <me>',
    },
    ['WAR'] = {
      ['^numlock'] = 'input /ja "Defender" <me>',
      ['^numpad/'] = 'input /ja "Berserk" <me>',
      ['^numpad*'] = 'input /ja "Warcry" <me>',
      ['^numpad-'] = 'input /ja "Aggressor" <me>',
    },
    ['NIN'] = {
      ['!numpad0'] = 'input /ma "Utsusemi: Ichi" <me>',
      ['!numpad.'] = 'input /ma "Utsusemi: Ni" <me>',
    },
  }

  set_main_keybinds:schedule(2)
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if S{'THF','DNC','RDM','BRD','RNG','NIN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Axe', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Axe'}
  end

  select_default_macro_book()
  set_sub_keybinds:schedule(2)
end

function job_file_unload()
  unbind_keybinds()
end

-- Pet DT options [PDT/MDT, M.Eva] {Pet: PDT/MDT, Level}:
-- head=gear.Anwig_Salade,          -- [__/__, ___] {10/10, ___}
-- head=gear.Taeon_Pet_DT_head,     -- [__/__,  73] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
-- body=gear.Taeon_Pet_DT_body,     -- [__/__,  84] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet DA+5
-- body="Totemic Jackcoat +3",      -- [__/__,  84] {10/10, ___}
-- body=gear.Emicho_D_body,         -- [__/__,  53] { 4/ 4, ___}
-- hands=gear.Taeon_Pet_DT_hands,   -- [__/__,  57] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
-- hands="Gleti's Gauntlets",       -- [ 7/__,  75] { 8/ 8, ___}
-- hands="Ankusa Gloves +3",        -- [__/__,  57] { 6/__,  17}; Pet Level snapshots on summoning
-- legs="Tali'ah Seraweels +2",     -- [__/__,  69] { 5/ 5, ___}
-- legs=gear.Taeon_Pet_DT_legs,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
-- legs="Nukumi Quijotes +3",       -- [13/13, 130] { 8/ 8, ___}
-- feet=gear.Taeon_Pet_DT_feet,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
-- feet="Gleti's Boots",            -- [ 5/__, 112] {__/__,   1}
-- feet="Ankusa Gaiters +3",        -- [__/__,  89] { 5/__, ___}
-- neck="Shepherd's Chain",         -- [__/__, ___] { 2/ 2, ___}
-- ear1="Handler's Earring +1",     -- [__/__, ___] { 4/__, ___}
-- ear1="Enmerkar Earring",         -- [__/__, ___] { 3/ 3, ___}
-- ear1="Hypaspist Earring",        -- [-5/__, ___] { 5/__, ___}
-- ear1="Rimeice Earring",          -- [__/__, ___] { 1/ 1, ___}
-- ear2="Nukumi Earring +2",        -- [__/__, ___] {__/__,   1}
-- ring1="Thurandaut Ring +1",      -- [__/__, ___] { 4/ 4, ___}; Adoulin ring
-- back=gear.BST_ambu_cape,         -- [__/__, ___] { 5/ 5, ___}
-- waist="Isa Belt",                -- [__/__, ___] { 3/ 3, ___}

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Common
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  if sets.org then
    sets.org.job = {}
  end

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  sets.Kiting = {
    feet="Skadi's Jambeaux +1"
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.CP = {
    back=gear.CP_Cape,
  }

  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Weapon Sets
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet['Naegling'] = {main="Naegling", sub="Sacro Bulwark"}
  sets.WeaponSet['Naegling'].DW = {main="Naegling", sub="Ikenga's Axe"}
  sets.WeaponSet['Farsha'] = {main="Farsha", sub="Sacro Bulwark"}
  sets.WeaponSet['Farsha'].DW = {main="Farsha", sub="Ikenga's Axe"}
  sets.WeaponSet['Piercing'] = {main="Tauret", sub="Sacro Bulwark"}
  sets.WeaponSet['Piercing'].DW = {main="Tauret", sub="Ikenga's Axe"}
  sets.WeaponSet['Cleaving'] = {main=gear.Malevolence_1, sub="Sacro Bulwark"}
  sets.WeaponSet['Cleaving'].DW = {main=gear.Malevolence_1, sub=gear.Malevolence_2}
  sets.WeaponSet['Axe'] = {main="Dolichenus", sub="Sacro Bulwark"}
  sets.WeaponSet['Axe'].DW = {main="Dolichenus", sub="Ikenga's Axe"}


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Defense
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  -- This set is used when both master and pet are idle
  sets.HeavyDef = {
    main=gear.Pet_DT_Axe,             -- __ [__/__, ___] { 4/ 4, ___ | __}
    sub=gear.Regen_Axe,               -- __ [__/__, ___] {__/__, ___ |  3}
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___] {__/__, ___ | __}
    head=gear.Nyame_B_head,           -- __ [ 7/ 7, 123] {__/__, ___ | __}
    body="Gleti's Cuirass",           -- __ [ 9/__, 102] {__/__, ___ | __}
    hands="Gleti's Gauntlets",        -- __ [ 7/__,  75] { 8/ 8, ___ | __}
    legs="Nukumi Quijotes +2",        -- __ [12/12, 120] { 6/ 6, ___ | __}
    feet="Gleti's Boots",             -- __ [ 5/__, 112] {__/__,   1 | __}
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] {__/__, ___ | __}
    ear1="Enmerkar Earring",          -- __ [__/__, ___] { 3/ 3, ___ | __}
    ear2="Nukumi Earring +1",         -- __ [__/__, ___] {__/__,   1 | __}
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __}
    back=gear.BST_Pet_Macc_Cape,      -- __ [__/__,  20] { 5/ 5, ___ | 10}
    waist="Isa Belt",                 -- __ [__/__, ___] { 3/ 3, ___ |  1}
    -- Traits/Gifts/Merits                                 9/ 9
    -- 0 Regen [66 PDT/37 MDT, 532 M.Eva] {Pet: 38 PDT/38 MDT, 2 Lv | 14 Regen}

    -- legs="Nukumi Quijotes +3",     -- __ [13/13, 130] { 8/ 8, ___ | __}
    -- 0 Regen [67 PDT/38 MDT, 562 M.Eva] {Pet: 40 PDT/40 MDT, 2 Lv | 14 Regen}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})

  -- Reach 50 PDT/21 MDT in as few pieces as possible
  sets.EfficientDT = {
    head="Nukumi Cabasset +2",        -- __ [10/10,  88] {__/__, ___ | __}
    hands="Nukumi Manoplas +2",       -- __ [10/10,  72] {__/__, ___ | __}
    legs="Nukumi Quijotes +2",        -- __ [12/12, 120] { 6/ 6, ___ | __}
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __}
    -- 0 Regen [48 PDT/48 MDT, 280 M.Eva] {Pet: 6 PDT/6 MDT, 0 Lv | 0 Regen}

    -- head="Nukumi Cabasset +3",     -- __ [11/11,  98] {__/__, ___ | __}
    -- hands="Nukumi Manoplas +3",    -- __ [11/11,  82] {__/__, ___ | __}
    -- legs="Nukumi Quijotes +3",     -- __ [13/13, 130] { 8/ 8, ___ | __}
    -- 0 Regen [51 PDT/51 MDT, 310 M.Eva] {Pet: 8 PDT/8 MDT, 0 Lv | 0 Regen}
  }


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Idle
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.latent_regain = {
    head="Valorous Mask",       -- 3
    body="Gleti's Cuirass",     -- 3
    hands="Gleti's Gauntlets",  -- 2
    legs="Gleti's Breeches",    -- 3
    feet="Gleti's Boots",       -- 2
  }
  sets.latent_regen = {
    head="Gleti's Mask",        -- 3
    neck="Bathy Choker +1",     -- 3
    ear1="Infused Earring",     -- 1
    ring1="Chirich Ring +1",    -- 2
    ring2="Chirich Ring +1",    -- 2
  }
  sets.latent_refresh = {
    ring1="Stikini Ring +1",    -- 1
    -- ring2="Stikini Ring +1", -- 1
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Regain = set_combine(sets.HeavyDef, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.HeavyDef, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.HeavyDef, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.HeavyDef, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.HeavyDef, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.HeavyDef, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.HeavyDef, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.DT = set_combine(sets.HeavyDef, {})
  sets.idle.DT.Regain = set_combine(sets.idle.Regain, sets.EfficientDT)
  sets.idle.DT.Regen = set_combine(sets.idle.Regen, sets.EfficientDT)
  sets.idle.DT.Refresh = set_combine(sets.idle.Refresh, sets.EfficientDT)
  sets.idle.DT.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.EfficientDT)
  sets.idle.DT.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.EfficientDT)
  sets.idle.DT.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.EfficientDT)
  sets.idle.DT.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.EfficientDT)

  sets.idle.RegainOnly = {
    ammo="Staunch Tathlum +1",        -- __, __ [ 3/ 3, ___] {__/__, ___ | __}
    head=gear.Valorous_DT_head,       --  3, __ [ 4/ 4,  48] {__/__, ___ | __}
    body="Gleti's Cuirass",           --  3, __ [ 9/__, 102] {__/__, ___ | __}
    hands="Gleti's Gauntlets",        --  2, __ [ 7/__,  75] { 8/ 8, ___ | __}
    legs="Gleti's Breeches",          --  3, __ [ 8/__, 112] {__/__, ___ | __}
    feet="Gleti's Boots",             --  2, __ [ 5/__, 112] {__/__,   1 | __}
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] {__/__, ___ | __}
    ear1="Enmerkar Earring",          -- __, __ [__/__, ___] { 3/ 3, ___ | __}
    ear2="Nukumi Earring +1",         -- __, __ [__/__, ___] {__/__,   1 | __}
    ring1="Chirich Ring +1",          -- __,  2 [__/__, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___ | __}
    back=gear.BST_Pet_Macc_Cape,      -- __, __ [__/__,  20] { 5/ 5, ___ | 10}
    waist="Isa Belt",                 -- __, __ [__/__, ___] { 3/ 3, ___ |  1}
    -- Traits/Gifts/Merits
    -- 13 Regain, 2 Regen [52 PDT/23 MDT, 469 M.Eva] {Pet: 19 PDT/19 MDT, 2 Lv | 11 Regen}
  }

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  -- idle.PetEngaged sets is when master is idle but pet is engaged
  sets.idle.PetEngaged = {} -- DO NOT MODIFY

  -- More squishy for master
  sets.idle.PetEngaged.PetTank = {
    main=gear.Skullrender_C,          -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__,  8, __}
    sub=gear.Pet_DT_Axe,              -- [__/__, ___] { 4/ 4, ___ | __, __, __/__, __/__, __, __}
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Tali'ah Turban +2",         -- [__/__,  53] {__/__, ___ | __,  7, 42/42, __/__, __, __}
    body="Totemic Jackcoat +3",       -- [__/__,  84] {10/10, ___ | __, __, __/__, __/__, __, __}
    hands="Gleti's Gauntlets",        -- [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +2",        -- [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- [29 PDT/17 MDT, 464 M.Eva] {Pet: 36 PDT/36 MDT, 2 Lv | 42 DA, 21 STP, 327 Acc/292 Racc, 65 Att/30 Ratt, 27 Haste, 0 Regen}

    -- legs="Nukumi Quijotes +3",     -- [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [30 PDT/18 MDT, 474 M.Eva] {Pet: 38 PDT/38 MDT, 2 Lv | 45 DA, 21 STP, 337 Acc/302 Racc, 65 Att/30 Ratt, 27 Haste, 0 Regen}
  }
  -- More squishy for master
  sets.idle.PetEngaged.PetDD = {
    main=gear.Skullrender_C,          -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__,  8, __}
    sub="Agwu's Axe",                 -- [__/__, ___] {__/__, ___ | __, __, 50/__, __/__, __, __}; Pet dmg+
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Tali'ah Turban +2",         -- [__/__,  53] {__/__, ___ | __,  7, 42/42, __/__, __, __}
    body="Ankusa Jackcoat +3",        -- [__/__,  84] {__/__, ___ |  5, __, __/__, __/__,  7, __}
    hands=gear.Emicho_C_hands,        -- [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Ankusa Trousers +3",        -- [__/__,  89] {__/__, ___ | __,  7, __/__, __/__,  6, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Incarnation Sash",         -- [__/__, ___] {__/__, ___ |  4, __, 15/15, __/__, __, __}
    -- [10 PDT/5 MDT, 390 M.Eva] {Pet: 8 PDT/8 MDT, 2 Lv | 55 DA, 35 STP, 289 Acc/184 Racc, 120 Att/30 Ratt, 31 Haste, 0 Regen}

    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [10 PDT/5 MDT, 390 M.Eva] {Pet: 8 PDT/8 MDT, 2 Lv | 58 DA, 35 STP, 289 Acc/184 Racc, 120 Att/30 Ratt, 31 Haste, 0 Regen}
  }

  -- Cap master DT
  sets.idle.PetEngaged.PetDTTank = {
    main=gear.Skullrender_C,          -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__,  8, __}
    sub=gear.Pet_DT_Axe,              -- [__/__, ___] { 4/ 4, ___ | __, __, __/__, __/__, __, __}
    ammo="Staunch Tathlum +1",        -- [ 3/ 3, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Nukumi Cabasset +2",        -- [10/10,  88] {__/__, ___ | __, __, 51/51, __/__, __, __}
    body="Totemic Jackcoat +3",       -- [__/__,  84] {10/10, ___ | __, __, __/__, __/__, __, __}
    hands="Gleti's Gauntlets",        -- [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +2",        -- [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- [47 PDT/35 MDT, 464 M.Eva] {Pet: 36 PDT/36 MDT, 2 Lv | 37 DA, 14 STP, 314 Acc/279 Racc, 50 Att/30 Ratt, 27 Haste, 0 Regen}

    -- head="Nukumi Cabasset +3",     -- [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    -- legs="Nukumi Quijotes +3",     -- [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [49 PDT/37 MDT, 519 M.Eva] {Pet: 38 PDT/38 MDT, 2 Lv | 40 DA, 14 STP, 334 Acc/299 Racc, 50 Att/30 Ratt, 27 Haste, 0 Regen}
  }
  -- Cap master DT
  sets.idle.PetEngaged.PetDTDD = {
    main=gear.Skullrender_C,          -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__,  8, __}
    sub="Agwu's Axe",                 -- [__/__, ___] {__/__, ___ | __, __, 50/__, __/__, __, __}; Pet dmg+
    ammo="Staunch Tathlum +1",        -- [ 3/ 3, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Nukumi Cabasset +2",        -- [10/10,  88] {__/__, ___ | __, __, 51/51, __/__, __, __}
    body=gear.Nyame_B_body,           -- [ 9/ 9, 139] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands=gear.Emicho_C_hands,        -- [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Ankusa Trousers +3",        -- [__/__,  89] {__/__, ___ | __,  7, __/__, __/__,  6, __}
    feet=gear.Nyame_B_feet,           -- [ 7/ 7, 150] {__/__, ___ | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Flume Belt +1",            -- [ 4/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    -- [48 PDT/44 MDT, 518 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv | 46 DA, 22 STP, 313 Acc/208 Racc, 105 Att/30 Ratt, 24 Haste, 0 Regen}

    -- head="Nukumi Cabasset +3",     -- [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- [49 PDT/45 MDT, 528 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv | 46 DA, 22 STP, 323 Acc/218 Racc, 105 Att/30 Ratt, 24 Haste, 0 Regen}
  }

  sets.idle.PetEngaged.MasterTank = set_combine(sets.idle.PetEngaged.PetDTTank, {})
  sets.idle.PetEngaged.MasterDD = set_combine(sets.idle.PetEngaged.PetDTDD, {})

  sets.idle.PetEngaged.HalfsiesTank = set_combine(sets.idle.PetEngaged.PetDTTank, {})
  sets.idle.PetEngaged.HalfsiesDD = set_combine(sets.idle.PetEngaged.PetDTDD, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Precast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  -----------------------------------------------------------------------------------------------
  --     Job Abilities
  -----------------------------------------------------------------------------------------------

	sets.precast.JA['Bestial Loyalty'] = {
    hands="Ankusa Gloves +1", -- Adds 17 pet levels, snapshots; +1 is acceptable
    -- hands="Ankusa Gloves +3", -- Adds 17 pet levels, snapshots; +1 is acceptable
  }
	sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']

  -- Potency caps at +50% from gear
  -- Aim for 120+ MND from gear
  sets.precast.JA.Reward = {
    main=gear.Reward_Axe,             -- 17, __, __, __ [__/__, ___] {__/__, __}
    sub="Naegling",                   -- 15, __, __, __ [__/__, ___] {__/__, __}
    ammo="Pet Food Theta",            -- __, 20, __, __ [__/__, ___] {__/__, __}
    head="Stout Bonnet",              -- __, __, __, 16 [__/__, ___] {__/__, __}
    body="Totemic Jackcoat +3",       -- 33, __, 26, __ [__/__,  84] {10/10, __}; Removes status effects
    hands="Gleti's Gauntlets",        -- 30, __, __, __ [ 7/__,  75] { 8/ 8, __}
    legs="Ankusa Trousers +3",        -- 27, __, __, 21 [__/__,  89] {__/__, __}
    feet="Ankusa Gaiters +3",         -- 22,  4, 41, __ [__/__,  89] { 5/__, __}; Enhances Beast Healer
    neck="Loricate Torque +1",        -- __, __, __, __ [ 6/ 6, ___] {__/__, __}
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___] {__/__, __}
    ear2="Genmei Earring",            -- __, __, __, __ [ 2/__, ___] {__/__, __}
    ring1="Metamorph Ring +1",        -- 16, __, __, __ [__/__, ___] {__/__, __}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, __}
    back=gear.BST_TP_Cape,            -- __, __, 30, __ [10/__, ___] {__/__, __}
    waist="Engraved Belt",            --  7, __, __, __ [__/__, ___] {__/__, __}
    -- 167 MND, 24 Reward Regen, 97 Reward Potency, 37 Reward Recast- [38 PDT/21 MDT, 337 M.Eva] {Pet: 23 PDT/18 MDT, 0 Lv}

    -- main="Farsha",                 -- 50, __, __, __ [__/__, ___] {__/__, __}
    -- sub=gear.Reward_Axe,           -- 17, __, __, __ [__/__, ___] {__/__, __}
    -- back=gear.BST_MND_WSD_Cape,    -- 30, __, 30, __ [10/__, ___] {__/__, __}
    -- 229 MND, 24 Reward Regen, 97 Reward Potency, 37 Reward Recast- [38 PDT/21 MDT, 337 M.Eva] {Pet: 23 PDT/18 MDT, 0 Lv}
  }
	sets.precast.JA['Killer Instinct'] = {
    head="Ankusa Helm +1", -- Increase duration based on merits; +1 is acceptable
    -- head="Ankusa Helm +3", -- Increase duration based on merits; +1 is acceptable
  }
	sets.precast.JA.Familiar = {
    legs="Ankusa Trousers +3", -- Increase duration, pet haste +10%; +1 is acceptable
  }
	sets.precast.JA.Tame = {
    head="Totemic Helm +3", -- Increase success rate
  }

  -- Charm+ gear cap for accuracy at 99%?
  -- Charm+ gear might increase Charm duration with no cap.
	sets.precast.JA.Charm = {
    ammo="Staunch Tathlum +1",        -- __, __ [ 3/ 3, ___]
    head="Totemic Helm +3",           -- 34, 35 [__/__,  73]
    body="Ankusa Jackcoat +3",        -- 33, 16 [__/__,  84]
    hands="Ankusa Gloves +1",         -- 17,  9 [__/__,  37]
    legs="Ankusa Trousers +3",        -- 21, 11 [__/__,  89]
    feet="Ankusa Gaiters +3",         -- 40, 12 [__/__,  89]
    neck="Unmoving Collar +1",        --  9, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __ [ 3/ 5, ___]
    ear2="Enchanter's Earring +1",    --  5, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- 16, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __ [10/10, ___]
    back=gear.BST_TP_Cape,            -- __, __ [10/__, ___]
    waist="Aristo Belt",              --  8, __ [__/__, ___]
    -- Traits/merits/gifts                   20
    -- 185 CHR, 87 Charm [26 PDT/18 MDT, 372 M.Eva]
    
    -- main="Habilitator +1",         -- 28, __ [ 3/__, ___]
    -- sub=gear.Digirbalag_CHR,       -- 25, __ [__/__, ___]
    -- hands="Ankusa Gloves +3",      -- 27, 13 [__/__,  57]
    -- back=gear.BST_CHR_WSD_Cape,    -- 30, __ [10/__, ___]
    -- 276 CHR, 107 Charm [29 PDT/18 MDT, 392 M.Eva]
  }
	sets.precast.JA.Spur = {
    main=gear.Skullrender_C,
    sub=gear.Skullrender_C,
    feet="Nukumi Ocreae +2", -- Increase pet STP
    back="Artio's Mantle",

    -- feet="Nukumi Ocreae +3", -- Increase pet STP
  }
	sets.precast.JA['Feral Howl'] = {
    main="Agwu's Axe",                -- 55 [__/__, ___]
    sub="Ikenga's Axe",               -- 55 [__/__, ___]
    ammo="Pemphredo Tathlum",         --  8 [__/__, ___]
    head="Nukumi Cabasset +2",        -- 51 [10/10,  88]
    body="Ankusa Jackcoat +3",        -- 40 [__/__,  84]; Feral Howl Duration+
    hands="Nukumi Manoplas +2",       -- 52 [10/10,  72]
    legs="Nukumi Quijotes +2",        -- 53 [12/12, 120]
    feet="Nukumi Ocreae +2",          -- 50 [__/__, 120]
    neck="Beastmaster Collar +2",     -- 25 [__/__, ___]
    ear1="Dignitary's Earring",       -- 10 [__/__, ___]
    ear2="Nukumi Earring +1",         -- 15 [__/__, ___]
    ring1="Metamorph Ring +1",        -- 15 [__/__, ___]
    ring2="Stikini Ring +1",          -- 11 [__/__, ___]
    back="Sacro Mantle",              -- 20 [__/__, ___]
    waist="Eschan Stone",             --  7 [__/__, ___]
    -- 467 M.Acc [32 PDT/32 MDT, 484 M.Eva]
    
    -- head="Nukumi Cabasset +3",     -- 61 [11/11,  98]
    -- hands="Nukumi Manoplas +3",    -- 62 [11/11,  82]
    -- legs="Nukumi Quijotes +3",     -- 63 [13/13, 130]
    -- feet="Nukumi Ocreae +3",       -- 60 [__/__, 130]
    -- ear2="Nukumi Earring +2",      -- 20 [__/__, ___]
    -- 512 M.Acc [35 PDT/35 MDT, 524 M.Eva]
  }

  -- With merits and JP gifts, this caps out ready recast reduction at -20s
  sets.precast.ReadyRecast = {
    legs="Gleti's Breeches", -- R0 is acceptable
  }


  ------------------------------------------------------------------------------------------------
  --     Fast Cast
  ------------------------------------------------------------------------------------------------

  sets.precast.FC = {
    body=gear.Taeon_FC_body,          --  9
    hands=gear.Leyline_Gloves,        --  8
    legs=gear.Taeon_FC_legs,          --  5
    feet=gear.Taeon_FC_feet,          --  5
    neck="Orunmila's Torque",         --  5
    ear1="Loquac. Earring",           --  2
    ear2="Enchanter's Earring +1",    --  2
    ring2="Prolix Ring",              --  2
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    neck="Magoraga Beads",
    ear2="Odnowa Earring +1",
    ring1="Defending Ring",
  })


  ------------------------------------------------------------------------------------------------
  --    Weapon Skills
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Coiste Bodhar",             -- 10, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 37, 13, __ < 7, __, __> [ 9/ 9, 139] {__/__, ___} 
    hands=gear.Nyame_B_hands,         -- 17, 40, 11, __ < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 32, 12, __ < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 26, 11, __ < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Sroda Ring",               -- 15, __, __,  3 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, __, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Sailfi Belt +1",           -- 15, __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___}
    -- 270 STR, 161 MND, 68 WSD, 13 PDL <39 DA, 2 TA, 0 QA> [58 PDT/48 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}

    -- ear1="Moonshade Earring",      -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    -- ear2="Nukumi Earring +2",      -- 15, __, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
  })
  sets.precast.WS.AttCapped = {
    ammo="Coiste Bodhar",             -- 10, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head="Gleti's Mask",              -- 33, 19, __,  6 <__, __, __> [ 6/__,  86] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, 26, __,  9 <10, __, __> [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, 30, __,  7 <__, __, __> [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, 20, __,  8 <__,  5, __> [ 8/__, 112] {__/__, ___}
    feet="Nukumi Ocreae +2",          -- 26, 15, __,  7 < 5, __, __> [__/__, 120] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Moonshade Earring",         -- __, __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __, __,  8 <__, __, __> [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, __, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Sailfi Belt +1",           -- 15, __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___}
    -- 247 STR, 110 MND, 10 WSD, 65 PDL <23 DA, 7 TA, 0 QA> [50 PDT/10 MDT, 495 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}

    -- feet="Nukumi Ocreae +3",       -- 31, 20, __, 10 < 6, __, __> [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Lugra Earring +1",          -- 16, __, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
  })

  -- 50% STR / 50% MND
  -- TP Bonus > WSD > STR > MND
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Savage Blade'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 50% STR. 1 hit ws. Dmg varies with TP. 15' range.
  sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {})
  sets.precast.WS['Mistral Axe'].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS['Mistral Axe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS['Mistral Axe'].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 73-85% STR. 4 hit physical. Acc varies with TP. fTP transfers.
  sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 13, __ < 7, __, __> [ 9/ 9, 139] {__/__, ___} 
    hands=gear.Nyame_B_hands,         -- 17, 11, __ < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 12, __ < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 11, __ < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ring1="Sroda Ring",               -- 15, __,  3 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; fTP+
    -- 265 STR, 68 WSD, 13 PDL <39 DA, 5 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}

    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  })
  sets.precast.WS['Ruinator'].MaxTP = set_combine(sets.precast.WS['Ruinator'], {})
  sets.precast.WS['Ruinator'].AttCapped = {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> [ 3/ 3, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 26, 11, __ < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, __,  9 <10, __, __> [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 20, __,  7 <__, __, __> [ 7/__,  75] { 8/ 8, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> [ 8/__, 112] {__/__, ___}
    feet="Nukumi Ocreae +2",          -- 26, __,  7 < 5, __, __> [__/__, 120] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ < 3, __, __> [__/__, ___] {__/__, ___}
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.BST_STR_WSD_Cape,       -- 30, 10, __ <__, __, __> [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; fTP+
    -- 234 STR, 21 WSD, 62 PDL <23 DA, 5 TA, 0 QA> [54 PDT/20 MDT, 532 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}

    -- feet="Nukumi Ocreae +3",       -- 31, __, 10 < 6, __, __> [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> [__/__, ___] {__/__,   1}
  }
  sets.precast.WS['Ruinator'].AttCappedMaxTP = set_combine(sets.precast.WS['Ruinator'].AttCapped, {})

  -- 50% STR. 3 hit physical. Acc varies with TP. fTP transfers.
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Ruinator'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Ruinator'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Ruinator'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Ruinator'].AttCappedMaxTP, {})

  -- 50% STR. 5 hit ws. Can crit. fTP transfers.
  sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Meghanada Cuirie +2",       -- 34, __, __ <__, __, __> (__,  6) [ 8/__,  64] {__/__, ___}
    hands="Nukumi Manoplas +2",       -- 20, __, __ <__, __, __> ( 5, __) [10/10,  72] {__/__, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Sroda Ring",               -- 15, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    back=gear.BST_STR_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 241 STR, 11 WSD, 11 PDL <11 DA, 10 TA, 0 QA> (32 Crit Rate, 6 Crit Dmg) [49 PDT/20 MDT, 451 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}

    -- hands="Nukumi Manoplas +3",    -- 25, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 245 STR, 11 WSD, 20 PDL <8 DA, 10 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [50 PDT/21 MDT, 461 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  })
  sets.precast.WS['Rampage'].MaxTP = set_combine(sets.precast.WS['Rampage'], {
    ear1="Thrud Earring",             -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Rampage'].AttCapped = {
    ammo="Crepuscular Pebble",        --  3, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Gleti's Cuirass",           -- 39, __,  9 <10, __, __> ( 8, __) [ 9/__, 102] {__/__, ___}
    hands="Nukumi Manoplas +2",       -- 20, __, __ <__, __, __> ( 5, __) [10/10,  72] {__/__, ___}
    legs="Gleti's Breeches",          -- 49, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_STR_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 221 STR, 0 WSD, 43 PDL <13 DA, 5 TA, 0 QA> (44 Crit Rate, 0 Crit Dmg) [58 PDT/23 MDT, 451 M.Eva] {Pet: 0 PDT/0 MDT, 2 Lv}

    -- hands="Nukumi Manoplas +3",    -- 25, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- feet="Nukumi Ocreae +3",       -- 31, __, 10 < 6, __, __> (__, __) [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- 15, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 243 STR, 0 WSD, 49 PDL <19 DA, 5 TA, 0 QA> (41 Crit Rate, 0 Crit Dmg) [54 PDT/24 MDT, 479 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  }
  sets.precast.WS['Rampage'].AttCappedMaxTP = set_combine(sets.precast.WS['Rampage'].AttCapped, {
    ear1="Thrud Earring",             -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}

    -- ear1="Lugra Earring +1",       -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    -- ear2="Thrud Earring",          -- 10,  3, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}
  })

  -- 50% DEX. 5 hit ws. Can crit. fTP transfers.
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Meghanada Cuirie +2",       -- 45, __, __ <__, __, __> (__,  6) [ 8/__,  64] {__/__, ___}
    hands="Nukumi Manoplas +2",       -- 43, __, __ <__, __, __> ( 5, __) [10/10,  72] {__/__, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ <__, __, __> ( 3, __) [__/__, ___] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 267 DEX, 0 WSD, 15 PDL <9 DA, 0 TA, 0 QA> (32 Crit Rate, 6 Crit Dmg) [46 PDT/20 MDT, 301 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}

    -- hands="Nukumi Manoplas +3",    -- 48, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- 272 DEX, 0 WSD, 15 PDL <9 DA, 0 TA, 0 QA> (33 Crit Rate, 6 Crit Dmg) [47 PDT/21 MDT, 311 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  })
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> (__, __) [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Crepuscular Pebble",        -- __, __,  3 <__, __, __> (__, __) [ 3/ 3, ___] {__/__, ___}
    head="Blistering Sallet +1",      -- 41, __, __ < 3, __, __> (10, __) [ 3/__,  53] {__/__, ___}
    body="Gleti's Cuirass",           -- 34, __,  9 <10, __, __> ( 8, __) [ 9/__, 102] {__/__, ___}
    hands="Nukumi Manoplas +2",       -- 43, __, __ <__, __, __> ( 5, __) [10/10,  72] {__/__, ___}
    legs="Gleti's Breeches",          -- __, __,  8 <__,  5, __> ( 7, __) [ 8/__, 112] {__/__, ___}
    feet="Gleti's Boots",             -- 29, __,  5 <__, __, __> ( 4, __) [ 5/__, 112] {__/__,   1}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    ear1="Moonshade Earring",         -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; TP Bonus+250
    ear2="Nukumi Earring +1",         -- __, __,  8 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 <__, __, __> (__, __) [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> (__, __) [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_Crit_Cape,      -- 30, __, __ <__, __, __> (10, __) [10/__, ___] {__/__, ___}
    waist="Fotia Belt",               -- __, __, __ <__, __, __> (__, __) [__/__, ___] {__/__, ___}; fTP+
    -- 187 DEX, 0 WSD, 43 PDL <13 DA, 5 TA, 0 QA> (44 Crit Rate, 0 Crit Dmg) [58 PDT/23 MDT, 451 M.Eva] {Pet: 0 PDT/0 MDT, 2 Lv}

    -- hands="Nukumi Manoplas +3",    -- 48, __, __ <__, __, __> ( 6, __) [11/11,  82] {__/__, ___}
    -- feet="Nukumi Ocreae +3",       -- 35, __, 10 < 6, __, __> (__, __) [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- __, __,  9 <__, __, __> (__, __) [__/__, ___] {__/__,   1}
    -- 198 DEX, 0 WSD, 49 PDL <19 DA, 5 TA, 0 QA> (41 Crit Rate, 0 Crit Dmg) [54 PDT/24 MDT, 479 M.Eva] {Pet: 0 PDT/0 MDT, 1 Lv}
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear1="Lugra Earring +1",          -- 16, __, __ < 3, __, __> (__, __) [__/__, ___] {__/__, ___}
  })

  -- 80% DEX. 1 hit ws.
  sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {
    ammo="Coiste Bodhar",             -- 10, __, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 11, __ [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 13, __ [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 11, __ [ 7/ 7, 112] {__/__, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ [__/__, ___] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 26, 11, __ [ 7/ 7, 150] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ [__/__, ___] {__/__, ___}
    ear2="Thrud Earring",             -- __,  3, __ [__/__, ___] {__/__, ___}
    ring1="Ephramad's Ring",          -- 10, __, 10 [__/__, ___] {__/__, ___}
    ring2="Ilabrat Ring",             -- 10, __, __ [__/__, ___] {__/__, ___}
    back=gear.BST_DEX_WSD_Cape,       -- 30, 10, __ [10/__, ___] {__/__, ___}
    waist="Kentarch Belt +1",         -- 10, __, __ [__/__, ___] {__/__, ___}
    -- 261 DEX, 59 WSD, 20 PDL [40 PDT/30 MDT, 524 M.Eva] {Pet: 0 PDT/0 MDT, 0 Lv}
  })
  sets.precast.WS['Onslaught'].MaxTP = set_combine(sets.precast.WS['Onslaught'], {
  })
  sets.precast.WS['Onslaught'].AttCapped = {
    ammo="Crepuscular Pebble",        -- __, __,  3 [ 3/ 3, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 11, __ [ 7/ 7, 123] {__/__, ___}
    body="Gleti's Cuirass",           -- 34, __,  9 [ 9/__, 102] {__/__, ___}
    hands="Gleti's Gauntlets",        -- 47, __,  7 [ 7/__,  75] { 8/ 8, ___}
    legs=gear.Lustratio_B_legs,       -- 43, __, __ [__/__, ___] {__/__, ___}
    feet="Nukumi Ocreae +2",          -- 30, __,  7 [__/__, 120] {__/__, ___}
    neck="Beastmaster Collar +2",     -- 15, __, 10 [__/__, ___] {__/__, ___}
    ear1="Lugra Earring +1",          -- 16, __, __ [__/__, ___] {__/__, ___}
    ear2="Nukumi Earring +1",         -- __, __,  8 [__/__, ___] {__/__,   1}
    ring1="Ephramad's Ring",          -- 10, __, 10 [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] {__/__, ___}
    back=gear.BST_DEX_WSD_Cape,       -- 30, 10, __ [10/__, ___] {__/__, ___}
    waist="Kentarch Belt +1",         -- 10, __, __ [__/__, ___] {__/__, ___}
    -- 260 DEX, 21 WSD, 54 PDL [46 PDT/20 MDT, 420 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}
    
    -- feet="Nukumi Ocreae +3",       -- 35, __, 10 [__/__, 130] {__/__, ___}
    -- ear2="Nukumi Earring +2",      -- __, __,  9 [__/__, ___] {__/__,   1}
    -- 265 DEX, 21 WSD, 58 PDL [46 PDT/20 MDT, 430 M.Eva] {Pet: 8 PDT/8 MDT, 1 Lv}
  }
  sets.precast.WS['Onslaught'].AttCappedMaxTP = set_combine(sets.precast.WS['Onslaught'].AttCapped, {
  })

  -- Aeolian Edge: 40% DEX/40% INT, 2.0-4.5 fTP, 1 hit (aoe-magical)
  -- Stack MAB > INT > DEX > WSD
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    ammo="Ghastly Tathlum +1",        -- __, 11, __, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 25, 28, 30, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 42, 30, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 28, 30, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- __, 44, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 26, 25, 30, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __ [__/__, ___] {__/__, ___}
    ear2="Novio Earring",             -- __, __,  7, __ [__/__, ___] {__/__, ___}
    ring1="Shiva Ring +1",            -- __,  9,  3, __ [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5, __ [__/__, ___] {__/__, ___}
    -- 115 DEX, 172 INT, 216 MAB, 52 WSD [43 PDT/41 MDT, 599 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.BST_INT_MAB_Cape,    -- __, 30, 10, __ [10/__, ___] {__/__, ___}
    -- waist="Skrymir Cord +1",       -- __, __,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {})
  sets.precast.WS['Aeolian Edge'].AttCappedMaxTP = set_combine(sets.precast.WS['Aeolian Edge'].MaxTP, {})

  -- 60% CHR/30% DEX. dStat CHR. Dmg varies with TP. Light elemental.
  sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",         -- __, __,  4,  8, __ [__/__, ___] {__/__, ___}
    head=gear.Nyame_B_head,           -- 24, 25, 30, 40, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 35, 24, 30, 40, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 24, 42, 30, 40, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 24, __, 30, 40, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 38, 26, 30, 40, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Baetyl Pendant",            -- __, __, 13, __, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __, __ [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __, __, __ [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Weatherspoon Ring",        -- __, __, 10, __, __ [__/__, ___] {__/__, ___}; Light MAB+10
    ring2="Defending Ring",           -- __, __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5,  5, __ [__/__, ___] {__/__, ___}
    -- 145 CHR, 117 DEX, 211 MAB, 213 M.Acc, 58 WSD [48 PDT/48 MDT, 674 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.BST_CHR_WSD_Cape,    -- 30, __, __, 20, 10 [__/__, ___] { 5/ 5, ___}
    -- waist="Skrymir Cord +1",       -- __, __,  7,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Primal Rend'].MaxTP = set_combine(sets.precast.WS['Primal Rend'], {
    ear2="Novio Earring",             -- __, __,  7, __, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Primal Rend'].AttCappedMaxTP = set_combine(sets.precast.WS['Primal Rend'].MaxTP, {})

  -- 40% STR/40% MND. Dmg varies with TP. Thunder elemental.
  sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {
    ring1="Sroda Ring",
    -- back=gear.BST_MND_WSD_Cape,    -- __, 30, 10, 20, __ [__/__, ___] { 5/ 5, ___}
  })
  sets.precast.WS['Cloudsplitter'].MaxTP = set_combine(sets.precast.WS['Primal Rend'].MaxTP, {
    ring1="Sroda Ring",
    -- back=gear.BST_MND_WSD_Cape,
  })
  sets.precast.WS['Cloudsplitter'].AttCappedMaxTP = set_combine(sets.precast.WS['Cloudsplitter'].MaxTP, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Midcast
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    Spells
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC


  ------------------------------------------------------------------------------------------------
  --    Pet "Ready"
  ------------------------------------------------------------------------------------------------

  -- Default/fallback set
  sets.midcast.Pet = {
    main=gear.Ready_Phys_TPBonus_Axe, -- [__/__, ___] {__/__, ___ |  4, __/__, 20/__}; Pet TP Bonus
    sub="Agwu's Axe",                 -- [__/__, ___] {__/__, ___ | __, 50/50, __/__}; Pet dmg+
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, 10/10, 10/__}; Pet attr+10
    head="Nukumi Cabasset +2",        -- [10/10,  88] {__/__, ___ | __, 51/51, __/__}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | __, 50/50, __/__}
    hands="Nukumi Manoplas +2",       -- [10/10,  72] {__/__, ___ | __, 52/52, __/__}; Pet TP Bonus
    legs="Nukumi Quijotes +2",        -- [12/12, 120] { 6/ 6, ___ | __, 53/53, __/__}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50/50, __/__}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  3, 20/__, 20/__}
    ear1="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __/__, __/__}; Pet dmg+
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __/__, __/__}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __, 10/__, __/__}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, 12/12, __/__}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, 20/20, 30/30}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, 20/20, __/__}
    -- [51 PDT/37 MDT, 504 M.Eva] {Pet: 11 PDT/11 MDT, 2 Lv | 15 DA, 398 Acc/368 Racc, 80 Att/30 Ratt}
    
    -- main="Aymur",                  -- [__/__, ___] {__/__, ___ | __, __/__, 80/__}; Pet TP Bonus+1000
    -- head="Nukumi Cabasset +3",     -- [11/11,  98] {__/__, ___ | __, 61/61, __/__}
    -- hands="Nukumi Manoplas +3",    -- [11/11,  82] {__/__, ___ | __, 62/62, __/__}; Pet TP Bonus+700
    -- legs="Nukumi Quijotes +3",     -- [13/13, 130] { 8/ 8, ___ | __, 63/63, __/__}
    -- [54 PDT/40 MDT, 534 M.Eva] {Pet: 13 PDT/13 MDT, 2 Lv | 15 DA, 428 Acc/398 Racc, 140 Att/30 Ratt}
  }
  sets.midcast.Pet.Halfsies = set_combine(sets.midcast.Pet, {})

  sets.midcast.Pet.Physical = {
    main=gear.Ready_Phys_TPBonus_Axe, -- [__/__, ___] {__/__, ___ |  4, __/__, 20/__}; Pet TP Bonus
    sub="Agwu's Axe",                 -- [__/__, ___] {__/__, ___ | __, 50/50, __/__}; Pet dmg+
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | __, 10/10, 10/__}; Pet attr+10
    head="Nukumi Cabasset +2",        -- [10/10,  88] {__/__, ___ | __, 51/51, __/__}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | __, 50/50, __/__}
    hands="Nukumi Manoplas +2",       -- [10/10,  72] {__/__, ___ | __, 52/52, __/__}; Pet TP Bonus
    legs="Nukumi Quijotes +2",        -- [12/12, 120] { 6/ 6, ___ | __, 53/53, __/__}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50/50, __/__}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  3, 20/__, 20/__}
    ear1="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __/__, __/__}; Pet dmg+
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 |  7, __/__, __/__}
    ring1="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __, 10/__, __/__}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, 12/12, __/__}
    back=gear.BST_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5, ___ | __, 20/20, 30/30}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, 20/20, __/__}
    -- [51 PDT/37 MDT, 504 M.Eva] {Pet: 11 PDT/11 MDT, 2 Lv | 19 DA, 398 Acc/368 Racc, 80 Att/30 Ratt}
    
    -- main="Aymur",                  -- [__/__, ___] {__/__, ___ | __, __/__, 80/__}; Pet TP Bonus+1000
    -- head="Nukumi Cabasset +3",     -- [11/11,  98] {__/__, ___ | __, 61/61, __/__}
    -- hands="Nukumi Manoplas +3",    -- [11/11,  82] {__/__, ___ | __, 62/62, __/__}; Pet TP Bonus+700
    -- legs="Nukumi Quijotes +3",     -- [13/13, 130] { 8/ 8, ___ | __, 63/63, __/__}
    -- [54 PDT/40 MDT, 534 M.Eva] {Pet: 13 PDT/13 MDT, 2 Lv | 15 DA, 428 Acc/398 Racc, 140 Att/30 Ratt}
  }
  sets.midcast.Pet.Physical.Halfsies = set_combine(sets.midcast.Pet.Physical, {})

  sets.midcast.Pet.Matk = {
    main=gear.Ready_MAB_Axe,            -- [__/__, ___] { 4/ 4, ___ | __, __, 25, __}; Pet TP Bonus+200
    sub="Agwu's Axe",                   -- [__/__, ___] {__/__, ___ | __, 50, __, 20}
    ammo="Hesperiidae",                 -- [__/__, ___] {__/__, ___ | __, 10, __, 10}; Pet attr+10
    head=gear.Nyame_B_head,             -- [ 7/ 7, 123] {__/__, ___ | __, 50, __, __}
    body="Udug Jacket",                 -- [10/10,  86] {__/__, ___ | __, 45, 45, __}
    hands="Nukumi Manoplas +2",         -- [10/10,  72] {__/__, ___ | __, 52, __, __}; Pet TP Bonus+
    legs=gear.Nyame_B_legs,             -- [ 8/ 8, 150] {__/__, ___ | __, 50, __, __}
    feet=gear.Nyame_B_feet,             -- [ 7/ 7, 150] {__/__, ___ | __, 50, __, __}
    neck="Adad Amulet",                 -- [ 4/ 4, ___] {__/__, ___ | __, 20, 10, __}
    ear1="Enmerkar Earring",            -- [__/__, ___] { 3/ 3, ___ | __, 15, __, __}
    ear2="Nukumi Earring +1",           -- [__/__, ___] {__/__,   1 |  7, 15, __, __}
    ring1="Tali'ah Ring",               -- [__/__, ___] {__/__, ___ | __,  6, __, __}
    ring2="Cath Palug Ring",            -- [ 5/ 5, ___] {__/__, ___ |  5, 12, __, __}
    back="Argochampsa Mantle",          -- [__/__, ___] {__/__, ___ | __, __, 12, __}
    waist="Incarnation Sash",           -- [__/__, ___] {__/__, ___ |  4, 15, __, __}
    -- [51 PDT/51 MDT, 581 M.Eva] {Pet: 7 PDT/7 MDT, 1 Lv | 16 DA, 390 Macc, 92 MAB, 30 INT}
    
    -- head=gear.Valorous_Pet_Matk_head,-- [__/__,  48] {__/__, ___ | __, __, 30, 15}
    -- hands="Nukumi Manoplas +3",      -- [11/11,  82] {__/__, ___ | __, 62, __, __}; Pet TP Bonus+700
    -- legs=gear.Valorous_Pet_Matk_legs,-- [ 2/__,  80] {__/__, ___ | __, __, 30, 15}
    -- feet=gear.Valorous_Pet_Matk_feet,-- [__/ 2,  80] {__/__, ___ | __, __, 30, 15}
    -- ear1="Hija Earring",             -- [__/__, ___] {__/__, ___ |  2, __,  5, __}
    -- [32 PDT/32 MDT, 376 M.Eva] {Pet: 4 PDT/4 MDT, 1 Lv | 18 DA, 235 Macc, 187 MAB, 75 INT}
  }
  sets.midcast.Pet.Matk.Halfsies = {
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | __, 50, __, __}
    ring1="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __, __}
  }

  sets.midcast.Pet.Macc = {
    main="Agwu's Axe",                 -- [__/__, ___] {__/__, ___ | 50, 20}
    sub=gear.Ready_MAcc_Axe,         -- [__/__, ___] { 4/ 4, ___ | 25, __}; Pet TP Bonus+200
    ammo="Hesperiidae",               -- [__/__, ___] {__/__, ___ | 10, 10}
    head="Nukumi Cabasset +2",        -- [10/10,  88] {__/__, ___ | 51, __}
    body="Gleti's Cuirass",           -- [ 9/__, 102] {__/__, ___ | 50, __}
    hands="Nukumi Manoplas +2",       -- [10/10,  72] {__/__, ___ | 52, __}; Pet TP Bonus
    legs="Nukumi Quijotes +2",        -- [12/12, 120] { 6/ 6, ___ | 53, __}
    feet="Gleti's Boots",             -- [ 5/__, 112] {__/__,   1 | 50, __}
    neck="Beastmaster Collar +2",     -- [__/__, ___] {__/__, ___ | 25, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | 15, __}
    ear2="Nukumi Earring +1",         -- [__/__, ___] {__/__,   1 | 15, __}
    ring1="Tali'ah Ring",             -- [__/__, ___] {__/__, ___ |  6, __}
    ring2="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ | 12, __}
    back=gear.BST_Pet_Macc_Cape,      -- [__/__,  20] { 5/ 5, ___ | 30, __}
    waist="Incarnation Sash",         -- [__/__, ___] {__/__, ___ | 15, __}
    -- [51 PDT/37 MDT, 514 M.Eva] {Pet: 18 PDT/18 MDT, 2 Lv | 459 Macc, 30 INT}
    
    -- head="Nukumi Cabasset +3",     -- [11/11,  98] {__/__, ___ | 61, __}
    -- hands="Nukumi Manoplas +3",    -- [11/11,  82] {__/__, ___ | 62, __}; Pet TP Bonus+700
    -- legs="Nukumi Quijotes +3",     -- [13/13, 130] { 8/ 8, ___ | 63, __}
    -- [64 PDT/40 MDT, 544 M.Eva] {Pet: 15 PDT/15 MDT, 2 Lv | 489 Macc, 30 INT}
  }
  sets.midcast.Pet.Macc.Halfsies = set_combine(sets.midcast.Pet.Macc, {})

  sets.midcast.Pet.Buff = {}
  sets.midcast.Pet.Buff.Halfsies = {}

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.MultiStrike = {
    main=gear.Skullrender_C,
    sub=gear.Skullrender_C,
    legs=gear.Emicho_C_legs,
    neck="Beastmaster Collar +2",
    ear2="Nukumi Earring +1",
    ring2="Cath Palug Ring",
    waist="Incarnation Sash",
    
    -- ear2="Nukumi Earring +2",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.Favorable = {
    head="Nukumi Cabasset +2",
    -- head="Nukumi Cabasset +3",
  }

  -- This set is overlaid on top of the other pet midcast sets as appropriate
  sets.midcast.Pet.TPBonus = {
    hands="Nukumi Manoplas +2",
    -- hands="Nukumi Manoplas +3",
  }
  sets.midcast.Pet.TPBonus.Physical = set_combine(sets.midcast.Pet.TPBonus, {
    main=gear.Ready_MAB_TPBonus_Axe,
    sub=gear.Ready_Phys_TPBonus_Axe,

    -- main="Aymur",
  })
  sets.midcast.Pet.TPBonus.Matk = set_combine(sets.midcast.Pet.TPBonus, {
    main=gear.Ready_Macc_TPBonus_Axe,
    sub=gear.Ready_MAB_TPBonus_Axe,

    -- main="Aymur",
  })
  sets.midcast.Pet.TPBonus.Macc = set_combine(sets.midcast.Pet.TPBonus, {
    main=gear.Ready_MAB_TPBonus_Axe,
    sub=gear.Ready_Macc_TPBonus_Axe,

    -- main="Aymur",
  })
  sets.midcast.Pet.TPBonus.Buff = set_combine(sets.midcast.Pet.TPBonus, {
    main=gear.Ready_Macc_TPBonus_Axe,
    sub=gear.Pet_DT_TPBonus_Axe,

    -- main="Aymur",
  })


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Engaged
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  ------------------------------------------------------------------------------------------------
  --    When master is engaged in Master hybrid mode
  ------------------------------------------------------------------------------------------------

  -- Almost entirely master-focused stats
  sets.engaged = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Ainia Collar",              -- __,  8,-10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Gere Ring",                -- __, __, __ <__,  5, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Moonlight Ring",           -- __,  5,  8 <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    -- 0 DW, 74 STP, 268 Acc <23 DA, 7 TA, 0 QA> [48 PDT/22 MDT, 600 M.Eva] {Pet: 8 PDT/8 MDT, 0 Lv | 0 DA, 0 STP, 100 Acc/100 Racc, 0 Att/0 Ratt, 0 Haste, 0 Regen}
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ear1="Telos Earring",             -- __,  5, 10 < 1, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Moonlight Ring",           -- __,  5,  8 <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
  })


  ------------------------------------------------------------------------------------------------
  --    When master is engaged in Pet hybrid mode
  ------------------------------------------------------------------------------------------------

  sets.engaged.PetTank = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Nukumi Cabasset +2",        -- __, __, 51 <__, __, __> [10/10,  88] {__/__, ___ | __, __, 51/51, __/__, __, __}
    body="Totemic Jackcoat +3",       -- __, __, 50 <__, __, __> [__/__,  84] {10/10, ___ | __, __, __/__, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Isa Belt",                 -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __, __, __/__, __/__, __,  1}
    -- 0 DW, 8 STP, 319 Acc <0 DA, 0 TA, 0 QA> [39 PDT/27 MDT, 499 M.Eva] {Pet: 35 PDT/35 MDT, 2 Lv | 37 DA, 14 STP, 296 Acc/281 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}

    -- head="Nukumi Cabasset +3",     -- __, __, 61 <__, __, __> [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 8 STP, 344 Acc <0 DA, 0 TA, 0 QA> [41 PDT/29 MDT, 519 M.Eva] {Pet: 37 PDT/37 MDT, 2 Lv | 40 DA, 14 STP, 316 Acc/301 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}
  }
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.PetTank, {})

  sets.engaged.PetDD = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Nukumi Cabasset +2",        -- __, __, 51 <__, __, __> [10/10,  88] {__/__, ___ | __, __, 51/51, __/__, __, __}
    body="Ankusa Jackcoat +3",        -- __, __, 40 <__, __, __> [__/__,  84] {__/__, ___ |  5, __, __/__, __/__,  7, __}
    hands=gear.Emicho_C_hands,        -- __,  7, 37 <__, __, __> [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 7 STP, 311 Acc <0 DA, 0 TA, 0 QA> [32 PDT/27 MDT, 456 M.Eva] {Pet: 14 PDT/14 MDT, 2 Lv | 46 DA, 21 STP, 286 Acc/251 Racc, 100 Att/30 Ratt, 26 Haste, 0 Regen}

    -- head="Nukumi Cabasset +3",     -- __, __, 61 <__, __, __> [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 7 STP, 336 Acc <0 DA, 0 TA, 0 QA> [34 PDT/29 MDT, 476 M.Eva] {Pet: 16 PDT/16 MDT, 2 Lv | 49 DA, 21 STP, 306 Acc/271 Racc, 100 Att/30 Ratt, 26 Haste, 0 Regen}
  }
  sets.engaged.PetDD.Acc = set_combine(sets.engaged.PetDD, {})


  ------------------------------------------------------------------------------------------------
  --    When master is engaged in PetDT hybrid mode
  ------------------------------------------------------------------------------------------------

  sets.engaged.PetDTTank = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head="Nukumi Cabasset +2",        -- __, __, 51 <__, __, __> [10/10,  88] {__/__, ___ | __, __, 51/51, __/__, __, __}
    body="Totemic Jackcoat +3",       -- __, __, 50 <__, __, __> [__/__,  84] {10/10, ___ | __, __, __/__, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Isa Belt",                 -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __, __, __/__, __/__, __,  1}
    -- 0 DW, 8 STP, 309 Acc <0 DA, 0 TA, 0 QA> [49 PDT/37 MDT, 499 M.Eva] {Pet: 35 PDT/35 MDT, 2 Lv | 37 DA, 8 STP, 289 Acc/271 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}

    -- head="Nukumi Cabasset +3",     -- __, __, 61 <__, __, __> [11/11,  98] {__/__, ___ | __, __, 61/61, __/__, __, __}
    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 8 STP, 334 Acc <0 DA, 0 TA, 0 QA> [51 PDT/39 MDT, 519 M.Eva] {Pet: 37 PDT/37 MDT, 2 Lv | 40 DA, 8 STP, 306 Acc/291 Racc, 45 Att/30 Ratt, 10 Haste, 1 Regen}
  }
  sets.engaged.PetDTTank.Acc = set_combine(sets.engaged.PetDTTank, {})

  sets.engaged.PetDTDD = {
    ammo="Hesperiidae",               -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10, 15/__, __, __}
    head=gear.Nyame_B_head,           -- __, __, 50 < 5, __, __> [ 7/ 7, 123] {__/__, ___ | __, __, 50/50, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands=gear.Emicho_C_hands,        -- __,  7, 37 <__, __, __> [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Gleti's Boots",             -- __, __, 50 <__, __, __> [ 5/__, 112] {__/__,   1 | __, __, 50/50, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Nukumi Earring +1",         -- __, __, 15 <__, __, __> [__/__, ___] {__/__,   1 |  7, __, __/__, __/__, __, __}
    ring1="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_Pet_TP_Cape,        -- __, __, __ <__, __, __> [__/__,  20] { 5/ 5, ___ | __, __, 20/20, 30/30, 10, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 7 STP, 315 Acc <15 DA, 0 TA, 0 QA> [48 PDT/34 MDT, 509 M.Eva] {Pet: 14 PDT/14 MDT, 2 Lv | 41 DA, 15 STP, 325 Acc/290 Racc, 100 Att/30 Ratt, 19 Haste, 0 Regen}

    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- ear2="Nukumi Earring +2",      -- __, __, 20 <__, __, __> [__/__, ___] {__/__,   1 | 10, __, __/__, __/__, __, __}
    -- 0 DW, 7 STP, 330 Acc <15 DA, 0 TA, 0 QA> [49 PDT/35 MDT, 519 M.Eva] {Pet: 16 PDT/16 MDT, 2 Lv | 44 DA, 15 STP, 335 Acc/300 Racc, 100 Att/30 Ratt, 19 Haste, 0 Regen}

  }
  sets.engaged.PetDTDD.Acc = set_combine(sets.engaged.PetDTDD, {})


  ------------------------------------------------------------------------------------------------
  --    When master is engaged in Halfsies hybrid mode
  ------------------------------------------------------------------------------------------------

  -- About equal focus on stats for master and pet
  sets.engaged.HalfsiesTank = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands="Gleti's Gauntlets",        -- __,  8, 55 <__, __, __> [ 7/__,  75] { 8/ 8, ___ | __, __, 50/50, __/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Gere Ring",                -- __, __, __ <__,  5, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 43 STP, 328 Acc <21 DA, 8 TA, 0 QA> [48 PDT/22 MDT, 570 M.Eva] {Pet: 17 PDT/17 MDT, 0 Lv | 25 DA, 8 STP, 213 Acc/198 Racc, 0 Att/0 Ratt, 9 Haste, 0 Regen}
    
    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- 0 DW, 43 STP, 338 Acc <21 DA, 8 TA, 0 QA> [49 PDT/23 MDT, 580 M.Eva] {Pet: 19 PDT/19 MDT, 0 Lv | 25 DA, 8 STP, 223 Acc/208 Racc, 0 Att/0 Ratt, 9 Haste, 0 Regen}
  }
  sets.engaged.HalfsiesTank.Acc = set_combine(sets.engaged.HalfsiesTank, {})

  sets.engaged.HalfsiesDD = {
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    head="Malignance Chapeau",        -- __,  8, 50 <__, __, __> [ 6/ 6, 123] {__/__, ___ | __, __, __/__, __/__, __, __}
    body="Gleti's Cuirass",           -- __, __, 55 <10, __, __> [ 9/__, 102] {__/__, ___ | __, __, 50/50, __/__, __, __}
    hands=gear.Emicho_C_hands,        -- __,  7, 37 <__, __, __> [__/__,  32] {__/__, ___ |  4,  7, 20/__, 55/__, __, __}
    legs="Nukumi Quijotes +2",        -- __, __, 53 <__, __, __> [12/12, 120] { 6/ 6, ___ | __, __, 53/53, __/__, __, __}
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150] {__/__, ___ | __, __, __/__, __/__, __, __}
    neck="Beastmaster Collar +2",     -- __, __, 25 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, 25/25, __/__, __, __}
    ear1="Enmerkar Earring",          -- __, __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __}
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    ring1="Varar Ring +1",            -- __, __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __}
    ring2="Cath Palug Ring",          -- __, __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __}
    back=gear.BST_TP_Cape,            -- __, 10, 20 <__, __, __> [10/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __}
    waist="Klouskap Sash +1",         -- __, __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __}
    -- 0 DW, 42 STP, 320 Acc <18 DA, 0 TA, 0 QA> [46 PDT/27 MDT, 527 M.Eva] {Pet: 9 PDT/9 MDT, 0 Lv | 34 DA, 21 STP, 205 Acc/170 Racc, 55 Att/0 Ratt, 9 Haste, 0 Regen}
    
    -- legs="Nukumi Quijotes +3",     -- __, __, 63 <__, __, __> [13/13, 130] { 8/ 8, ___ | __, __, 63/63, __/__, __, __}
    -- 0 DW, 42 STP, 330 Acc <18 DA, 0 TA, 0 QA> [47 PDT/28 MDT, 537 M.Eva] {Pet: 11 PDT/11 MDT, 0 Lv | 34 DA, 21 STP, 215 Acc/200 Racc, 55 Att/0 Ratt, 9 Haste, 0 Regen}
  }
  sets.engaged.HalfsiesDD.Acc = set_combine(sets.engaged.HalfsiesDD, {})


  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  --     Unique/Special/Misc
  -- ∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎

  sets.SleepyHead = { head="Frenzy Sallet", }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  -- Shield to use as a fallback option swap sets when not dual wielding
  sets.FallbackShield = {sub="Sacro Bulwark"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- If in Pet hybrid mode, cancel abilities if pet is using Ready move.
  if (state.HybridMode.value == 'Pet' or state.HybridMode.value == 'PetDT') and pending_pet_ability() then
    eventArgs.cancel = true
    add_to_chat(122, 'Action canceled because pet was midaction.')
  end

  -- If using a Ready move, 
  if spell.type == 'Monster' then
    if buffactive['Unleash'] then -- If Unleash is active don't swap gear
      equip(get_bst_pet_midcast_set(spell, spellMap))
      eventArgs.handled = true
    elseif sets.precast.ReadyRecast then -- Equip recast reduction gear in the precast
      equip(sets.precast.ReadyRecast)
      eventArgs.handled = true
    end
  end

  if not pet.isvalid and (spell.type == 'Monster' or abilities_require_pet:contains(spell.english)) then
    add_to_chat(123, 'No valid pet detected!')
    eventArgs.cancel = true
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  -- Handle equipping jugs
  if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
    -- Only change ammo if another jug not already equipped
    if not jug_full_list[player.equipment.ammo] then
      local jug_info = jugs[state.JugMode.value]
      if jug_info and silibs.has_item(jug_info.item, silibs.equippable_bags) then
        equip({ammo=jug_info.item})
      end
    end
  end

  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  -- Always put this last in job_post_precast
  -- Prevent swapping weapons if not in Pet mode or engaged
  if (state.HybridMode.current ~= 'Pet' and state.HybridMode.current ~= 'PetDT') or player.status == 'Engaged' then
    equip({main="", sub=""})
  elseif not silibs.can_dual_wield() then
    equip(sets.FallbackShield)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  if spell.type == 'Monster' and buffactive['Unleash'] then
    eventArgs.handled = true
  end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  -- Always put this last in job_post_midcast
  -- Prevent swapping weapons if not in Pet mode and engaged
  if (state.HybridMode.current ~= 'Pet' and state.HybridMode.current ~= 'PetDT') or player.status == 'Engaged' then
    equip({main="", sub=""})
  elseif not silibs.can_dual_wield() then
    equip(sets.FallbackShield)
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

	if spell.type == 'Monster' and not spell.interrupted then
    equip(get_bst_pet_midcast_set(spell, spellMap))
    last_pet_midcast_set = set_combine(gearswap.equip_list, {})
    last_pet_midaction_time = os.clock()
    if (state.HybridMode.value ~= 'Master' and not always_swap_moves:contains(spell.english))
        or buffactive['Unleash'] then
      eventArgs.handled = true
    end
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  -- If weapons are not what's set in the WeaponSet cycle, equip them
	if spell.type ~= 'Monster' or spell.interrupted then
    equip(select_weapons())
  end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-- Note: the "spell" object is different in the pet action hooks
function job_pet_midcast(spell, action, spellMap, eventArgs)
  equip(get_bst_pet_midcast_set(spell, spellMap))
  eventArgs.handled = true
	if spell.interrupted then
    last_pet_midaction_time = 0
  end
end

-- Note: the "spell" object is different in the pet action hooks
function job_pet_aftercast(spell, action, spellMap, eventArgs)
  last_pet_midaction_time = 0
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
  handle_equipping_gear(player.status)
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
  if pet.isvalid and not silibs.midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
    handle_equipping_gear(player.status, newStatus)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if buff == 'doom' then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  elseif buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.SleepyHead)
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_combat_form()
  update_idle_groups()
end

function update_combat_form()
  state.CombatForm:reset()
end

function job_status_change(new,old)
  if new == 'Engaged' then
    auto_engage_pet()
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'
  end

  -- Calculate if need TP bonus
  local buffer = 100
  -- Start TP bonus at 0 and accumulate based on equipped gear
  local tp_bonus_from_weapons = 0
  for slot,gear in pairs(tp_bonus_weapons) do
    local equipped_item = player.equipment[slot]
    if equipped_item and gear[equipped_item] then
      tp_bonus_from_weapons = tp_bonus_from_weapons + gear[equipped_item]
    end
  end
  local buff_bonus = T{
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  local trait_bonus = T{
    calc_fencer_tp_bonus()
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-trait_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

function calc_fencer_tp_bonus()
  local total_fencer_tp_bonus = 0
  local fencer_tier = calc_fencer_tier()
  if fencer_tier > 0 then
    -- Add Fencer TP bonus based on base trait
    total_fencer_tp_bonus = fencer_tp_bonus[fencer_tier]
    -- Add TP Bonus based on JP gifts
    local jp_spent = player.job_points.bst.jp_spent
    if jp_spent >= 2000 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 230
    elseif jp_spent >= 1125 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 160
    elseif jp_spent >= 500 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 100
    elseif jp_spent >= 150 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 50
    end
  end
  return total_fencer_tp_bonus
end

-- Calculate Fencer tier. Fencer active if not two-handed weapon, and offhand is empty or shield.
function calc_fencer_tier()
  local fencer = 0
  local main_weapon_skill = res.items:with('en', player.equipment.main).skill
  local is_using_2h = skill_ids_2h:contains(main_weapon_skill)

  if not is_using_2h then
    if player.equipment.sub == 'empty' then
      fencer = 3
    else
      local is_using_shield = res.items:with('en', player.equipment.sub).category == 'Armor'
      if is_using_shield then
        fencer = 3
      end
    end
  end
  -- Fencer caps at level 8
  return math.min(fencer, 8)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if not pending_pet_ability() then
    if buffactive['Unleash'] then
      if pet.isvalid then
        idleSet = set_combine(idleSet, last_pet_midcast_set)
      end
    else
      -- If not in DT mode put on move speed gear
      if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
        -- Apply movement speed gear
        if classes.CustomIdleGroups:contains('Adoulin') then
          idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
        else
          idleSet = set_combine(idleSet, sets.Kiting)
        end

        -- Apply pet engaged set
        if pet.isvalid and pet.status == 'Engaged' then
          local mode = state.HybridMode.value
          if state.PetMode.value ~= 'Normal' then
            mode = mode..state.PetMode.value
          end
          if sets.idle.PetEngaged[mode] then
            idleSet = set_combine(idleSet, sets.idle.PetEngaged[mode])
          else
            idleSet = set_combine(idleSet, sets.idle.PetEngaged)
          end
        end
      end
    end
  end

  if state.Kiting.value then
    idleSet = set_combine(idleSet, sets.Kiting)
  end

  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  idleSet = set_combine(idleSet, select_weapons())

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if not ((state.HybridMode.value == 'Pet' or state.HybridMode.value == 'PetDT') and pending_pet_ability()) then
    if buffactive['Unleash'] then
      if pet.isvalid then
        meleeSet = set_combine(meleeSet, last_pet_midcast_set)
      end
    else
      -- Apply pet engaged set
      if pet.isvalid and pet.status == 'Engaged' and state.HybridMode.value ~= 'Master' then
        local mode = state.HybridMode.value
        if state.PetMode.value ~= 'Normal' then
          mode = mode..state.PetMode.value
        end
        meleeSet = set_combine(meleeSet, sets.engaged[mode])
      end

      if state.CP.current == 'on' then
        meleeSet = set_combine(meleeSet, sets.CP)
      end
    end
  end

  meleeSet = set_combine(meleeSet, select_weapons())
  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  defenseSet = set_combine(defenseSet, select_weapons())

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function user_customize_idle_set(idleSet)
  -- Any non-silibs modifications should go in customize_idle_set function
  return silibs.customize_idle_set(idleSet)
end

function user_customize_melee_set(meleeSet)
  -- Any non-silibs modifications should go in customize_melee_set function
  return silibs.customize_melee_set(meleeSet)
end

function user_customize_defense_set(defenseSet)
  -- Any non-silibs modifications should go in customize_defense_set function
  return silibs.customize_defense_set(defenseSet)
end

-- Handle notifications of general user state change.
-- Called by mote-selfcommands
function job_state_change(stateField, newValue, oldValue)
  if stateField == 'Show UI' then
    update_ui_visibility()
  end
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local m_msg = state.OffenseMode.value
  m_msg = m_msg .. '/' ..state.HybridMode.value

  local i_msg = state.IdleMode.value

  local pet_msg = state.PetMode.current

  local msg = ''
  if state.TreasureMode.value ~= 'None' then
    msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
  end
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Pet: ' ..string.char(31,001)..pet_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_pet_mode(cycle_dir)
  if cycle_dir == 'forward' then
    state.PetMode:cycle()
  elseif cycle_dir == 'back' then
    state.PetMode:cycleback()
  elseif cycle_dir == 'reset' then
    state.PetMode:reset()
  end
  
  add_to_chat(141, 'Pet Mode set to '..string.char(31,1)..state.PetMode.current)
end

function select_weapons()
  if (state.HybridMode.current ~= 'Pet' and state.HybridMode.current ~= 'PetDT') then
    if silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      return sets.WeaponSet[state.WeaponSet.current].DW
    elseif sets.WeaponSet[state.WeaponSet.current] then
      return sets.WeaponSet[state.WeaponSet.current]
    end
  end

  return {}
end

function use_ready_move(index)
  if current_pet and index then
    local pet_info = jugs[current_pet]
    if pet_info then
      local move_list = family_ready_move_lists[pet_info.family]
      if move_list and move_list[index] then
        send_command('input /ja "'..move_list[index]..'" <me>')
      end
    end
  end
end

function auto_engage_pet()
	if state.AutomaticPetTargeting.value ~= true or not pet.isvalid or areas.Cities:contains(world.area) or silibs.midaction() then
    return
  end

  -- If player is fighting and pet is not, order it to attack
	if pet.status == 'Idle'
      and player.status == 'Engaged'
      and player.target.type == 'MONSTER'
      and player.target.hpp > 0 then
    -- Check for status that would prevent action
    for _,status in pairs(silibs.action_type_blockers['Ability']) do
      if buffactive[status] then
        return
      end
    end
    -- Check range
    if player.target.distance < (player.model_size + player.target.model_size + fight_max_range) then
      local abil_recasts = windower.ffxi.get_ability_recasts()
      if abil_recasts[100] < 0.1 then
        windower.chat.input('/pet "Fight" <t>')
      end
    end
	end
end

function pet_control(command)
  if command == 'fight' then
    windower.chat.input('/pet "Fight" <stnpc>')
  elseif command == 'heel' then
    windower.chat.input('/pet "Heel" <me>')
  end
  
  if state.AutomaticPetTargeting.value == true then
    state.AutomaticPetTargeting:set(false)
    add_to_chat(141, 'Manual pet control detected. Disabling auto targeting.')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if player.tp < 3000 then
      classes.CustomIdleGroups:append('Regain')
    end
    if isRegening==true and player.hpp < 100 then
      classes.CustomIdleGroups:append('Regen')
    elseif isRegening==false and player.hpp < 85 then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if isRefreshing==true and player.mpp < 100 then
        classes.CustomIdleGroups:append('Refresh')
      elseif isRefreshing==false and player.mpp < 85 then
        classes.CustomIdleGroups:append('Refresh')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

function pending_pet_ability()
  return (os.clock() - last_pet_midaction_time) < 1.5
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'petmode' then
    if cmdParams[2] == 'cycle' then
      cycle_pet_mode('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_pet_mode('back')
    elseif cmdParams[2] == 'current' then
      cycle_pet_mode('current')
    elseif cmdParams[2] == 'reset' then
      cycle_pet_mode('reset')
    end
  elseif cmdParams[1] == 'petcontrol' then
    if cmdParams[2] then
      pet_control(cmdParams[2])
    else
      add_to_chat(123, 'Missing 2nd parameter for this command.')
    end
  elseif cmdParams[1] == 'petactivation' then
    if pet.isvalid then
      windower.chat.input('/pet "Leave" <me>')
    else
      windower.chat.input('/ja "Bestial Loyalty" <me>')
    end
  elseif cmdParams[1] == 'ready' then
    if cmdParams[2] then
      use_ready_move(tonumber(cmdParams[2]))
    else
      add_to_chat(123, 'Missing 2nd parameter for this command.')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds:schedule(2)
    set_sub_keybinds:schedule(2)
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- Get the default pet midcast gear set.
-- This is built in sets.midcast.Pet.
function get_bst_pet_midcast_set(spell, spellMap)
  local equipSet = {}
  local ready_move = ready_moves[spell.english]

  if ready_move and pet.isvalid and sets.midcast and sets.midcast.Pet then
    equipSet = sets.midcast.Pet
    
    -- Determine type of set to use
    if ready_move.set and equipSet[ready_move.set] then
      equipSet = equipSet[ready_move.set]
    end

    -- Equip offensive/defensive variants as appropriate
    -- If in Master mode...
    if state.HybridMode.current == 'Master' then
      -- Swap into Halfsies set if idle, do not swap if engaged
      -- Override if Unleash is active
      if player.status ~= 'Engaged' or buffactive['Unleash'] then
        if equipSet['Halfsies'] then
          equipSet = equipSet['Halfsies']
        end
      elseif not always_swap_moves:contains(spell.english) then
        return {} -- Do not swap if Master mode, engaged, and spell is not on always_swap_moves list
      end
    -- If in Halfsies mode, swap into Halfsies set always
    elseif state.HybridMode.current == 'Halfsies' and equipSet['Halfsies'] then
      equipSet = equipSet['Halfsies']
    -- If in Pet mode, swap into Pet set always
    elseif state.HybridMode.current == 'Pet' and equipSet['Pet'] then
      equipSet = equipSet['Pet']
    elseif state.HybridMode.current == 'PetDT' and equipSet['PetDT'] then
      equipSet = equipSet['PetDT']
    end

    -- Allow OffenseMode to refine whatever set was selected above.
    -- Generally this modifies accuracy of the set.
    if equipSet[state.OffenseMode.current] then
      equipSet = equipSet[state.OffenseMode.current]
    end

    -- Equip multihit set if multihit ability
    if ready_move.multihit and sets.midcast.Pet.MultiStrike then
      equipSet = set_combine(equipSet, sets.midcast.Pet.MultiStrike)
    end

    -- Check correlation mode for favorable and equip related gear.
    if state.CorrelationMode.value == 'Favorable' and ready_move.set == 'Physical' and sets.midcast.Pet.Favorable then
      equipSet = set_combine(equipSet, sets.midcast.Pet.Favorable)
    end

    -- Equip TP Bonus set if ability benefits from TP
    -- Don't use with Unleash, which makes all Ready TP Bonus+3000
    if ready_move.tp_affected and pet.tp < 1900 and sets.midcast.Pet.TPBonus and not buffactive['Unleash'] then
      if sets.midcast.Pet.TPBonus[ready_move.set] then
        equipSet = set_combine(equipSet, sets.midcast.Pet.TPBonus[ready_move.set])
      else
        equipSet = set_combine(equipSet, sets.midcast.Pet.TPBonus)
      end
    end
    
    -- Always ensure this check is last
    -- Prevent swapping weapons if not in Pet mode
    if (state.HybridMode.current ~= 'Pet' and state.HybridMode.current ~= 'PetDT') or player.status == 'Engaged' then
      equipSet = set_combine(equipSet, {main="", sub=""})
    elseif not silibs.can_dual_wield() then
      equipSet = set_combine(equipSet, sets.FallbackShield)
    end
  end

  return equipSet
end

function create_ui()
  local ui_settings = {
    text={
      size=10,
      font=ui_font,
      alpha=255,
      red=255,
      green=255,
      blue=255,
    },
    pos={
      x=ui_x_position,
      y=ui_y_position,
    },
    bg={
      visible=true,
      alpha=200,
      red=0,
      green=0,
      blue=0,
    },
    padding=2,
  }
  
  ui = texts.new('${value}', ui_settings)
  ui:hide()
end

function on_pet_change(petname)
  if current_pet ~= petname then
    current_pet = petname
    last_pet_midaction_time = 0 -- Reset gearswap lockout if pet died or new pet summoned
    update_ui_text()
    update_ui_visibility()
  end
end

function update_ui_text()
  if ui then
    -- Update UI text
    local lines = T{}
    if current_pet then
      -- Display ready move info
      local pet_info = jugs[current_pet]
      if pet_info then
        local ready_move_list = family_ready_move_lists[pet_info.family]
        if ready_move_list then
          for index,ready_move_name in ipairs(ready_move_list) do
            -- Index    color code by element    set type    range type symbol    name    description
            local str = ''
            if index > 1 then
              str = default_txt_color
            end
            str = str..index..'|'
            local ready_move_info = ready_moves[ready_move_name]

            -- Display ability type
            str = str..' '..ready_move_set_symbol[ready_move_info.set]

            -- Range type symbol
            str = str..' '..range_symbol[ready_move_info.range_type]

            -- Charge count
            str = str..' ['..ready_charge_cost_symbol[ready_moves[ready_move_name].charges]..']'

            -- Element color
            if ready_move_info.element then
              str = str..element_colors[ready_move_info.element]
            else
              str = str..default_txt_color
            end
            
            -- Name of ability
            str = str..' '..ready_move_name

            -- Description of ability
            if ui_show_ability_description and ready_move_info.effect and ready_move_info.effect ~= '' then
              str = str..' ('..ready_move_info.effect..')'
            end
            lines:append(str)
          end
        end
      end
    end
    local str = lines:concat('\n')
    ui:text(str)
  end
end

function update_ui_visibility()
  if ui then
    -- Update UI visibility
    if not ui:visible() and (state.ShowUI.value and current_pet and not hide_ui_due_to_status and not is_zoning) then
      ui:show()
    elseif ui:visible() and (not state.ShowUI.value or not current_pet or hide_ui_due_to_status or is_zoning) then
      ui:hide()
    end
  end
end

function check_gear()
  if no_swap_necks:contains(player.equipment.neck) then
    locked_neck = true
  else
    locked_neck = false
  end
  if no_swap_earrings:contains(player.equipment.ear1) then
    locked_ear1 = true
  else
    locked_ear1 = false
  end
  if no_swap_earrings:contains(player.equipment.ear2) then
    locked_ear2 = true
  else
    locked_ear2 = false
  end
  if no_swap_rings:contains(player.equipment.ring1) then
    locked_ring1 = true
  else
    locked_ring1 = false
  end
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
end

-- Triggers after zoning
windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
  
  is_zoning = false
  update_ui_visibility()
end)

-- Triggers on player status change. This only triggers for the following statuses:
-- 0: idle
-- 1: engaged
-- 2: dead
-- 3: engaged while dead
-- 4: in menu, cutscene, some forms of zoning
windower.raw_register_event('status change', function(new_status_id, old_status_id)
  -- Hide UI under certain conditions
  if new_status_id == 2 or new_status_id == 3 or new_status_id == 4 then
    hide_ui_due_to_status = true
    update_ui_visibility()
  elseif old_status_id == 2 or old_status_id == 3 or old_status_id == 4 then
    hide_ui_due_to_status = false
    update_ui_visibility()
  end
end)

windower.raw_register_event('outgoing chunk', function(id, data, modified, injected, blocked)
  if id == 0x00D then -- Last packet sent when leaving zone
    is_zoning = true
    on_pet_change(nil) -- Reset pet being tracked. It'll correct itself after zoning.
  end
end)

windower.raw_register_event('incoming chunk', function(id, data, modified, injected, blocked)
  if id == 0x067 or id == 0x068 then -- Pet Info & Pet Status
    local packet = packets.parse('incoming', data)
    local type = packet['Message Type']
    local pethpp = packet['Current HP%']
    if type == 4 then
      if pethpp == 0 then -- Pet died
        on_pet_change(nil)
      else
        on_pet_change(packet['Pet Name'])
      end
    end
  end
end)

timer1 = os.clock()
windower.raw_register_event('prerender',function()
  local now = os.clock()
  if windower.ffxi.get_info().logged_in and windower.ffxi.get_player() then
    -- Execute every second
    if now - timer1 > 1 then
      timer1 = now
      auto_engage_pet()
    end
  end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(1, 9)
end

function set_main_keybinds()
  local main_keybinds = job_keybinds['main']
  if main_keybinds then
    for key,cmd in pairs(main_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end

  construct_unbind_command()
end

function set_sub_keybinds()
  local sub_keybinds = job_keybinds[player.sub_job]
  if sub_keybinds then
    for key,cmd in pairs(sub_keybinds) do
      send_command(('bind %s %s'):format(key, cmd))
    end
  end
end

function construct_unbind_command()
  local commands = L{}
  local main_keybinds = job_keybinds['main']
  local sub_keybinds = job_keybinds[player.sub_job]
  if main_keybinds then
    for key in pairs(main_keybinds) do
        commands:append(('unbind %s'):format(key))
    end
  end
  if sub_keybinds then
    for key in pairs(sub_keybinds) do
        commands:append(('unbind %s'):format(key))
    end
  end
  unbind_command = commands:concat(';')
end

function unbind_keybinds()
  windower.send_command(unbind_command)
end

function test()
end
