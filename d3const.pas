unit d3const;
interface
uses mem_Reader;

var
  mr : CMem_reader;

const
    offObjectMngr = $186FA3C;//$1543B9C;
    offObjectMngr_uilist = $93c;
    offUIItemProperties = $210;

    off_isVisible = 40;
    off_isEnabled = $C64;
    off_cb_value = $0CFC;
    off_text_value = $000C4C;//$000AC8;



      //item popup
  ITEM_POPUP_NAME = 8424326324760553802;//Root.TopLayer.item 2.stack.top_wrapper.stack.name [8B53294A, 74E93828]
  ITEM_POPUP_TYPE =  3281091618386546876;//Root.TopLayer.item 2.stack.frame body.stack.main.stack.wrapper.col1.type [657110BC, 2D88C771]
  ITEM_POPUP_SLOT = -6450282479763995249;//Root.TopLayer.item 2.stack.frame body.stack.main.stack.wrapper.col2.slot [7CBDC58F, A67BFE42]
//  Root.TopLayer.item 2.stack.frame body.stack.main.stack.wrapper.col1.stack.rating [8625599939499233255]
  ITEM_POPUP_RATING = 8625599939499233255; //Root.TopLayer.item 2.stack.frame body.stack.main.stack.wrapper.col1.stack.rating [D07B8FE7, 77B44971]
  ITEM_POPUP_SPEC_STATS = -217347590060135497; //Root.TopLayer.item 2.stack.frame body.stack.main.stack.special_stats [B5ADABB7, FCFBD384]
  ITEM_POPUP_STATS = 2275247841898913504; //Root.TopLayer.item 2.stack.frame body.stack.stats [805BDEE0, 1F934DDB]
  ITEM_POPUP_REQS = -1368102312172285893; //Root.TopLayer.item 2.stack.frame body.stack.wrapper.reqs [1294903B, ED038632]
  ITEM_POPUP_COST = -4321773436327437102; //Root.TopLayer.item 2.stack.frame_cost.cost [17FBDCD2, C405F9F5]
  ITEM_POPUP_DURABILITY = -6065284423672185204; //Root.TopLayer.item 2.stack.frame_cost.durability [B14F3E8C, ABD3C7F3]
  ITEM_POPUP_RATING_NAME = -1166217118883322090; //AE6BB0C => Root.TopLayer.item 2.stack.frame body.stack.main.stack.wrapper.col1.stack.rating_label [91FAE716, EFD0C3B5]


  ITEM_POPUP_SALEVALUE = -4321773436327437102; //1793885C => Root.TopLayer.item 2.stack.frame_cost.cost [-4321773436327437102]
  ITEM_POPUP_SOCKET1 = 6831232818050876769; //AE6CFFC => Root.TopLayer.item 2.stack.frame body.stack.socket 0.text [F9E9C561, 5ECD6A0D]
  ITEM_POPUP_SOCKET2 = -4157905519940435424;//AE6D85C => Root.TopLayer.item 2.stack.frame body.stack.socket 1.text [8A508220, C64C26F5]
  ITEM_POPUP_SOCKET3 = -8540101357612776801;//AE6E0BC => Root.TopLayer.item 2.stack.frame body.stack.socket 2.text [9A8C29F, 897B7710]
  ITEM_POPUP_ILVL = -8045627119143543679;//B23390C => Root.TopLayer.item 2.stack.frame body.stack.wrapper.itemLevel [40331C81, 905830C3]

  CHAR_LVL = 4685022878131781988; // Root.NormalLayer.inventory_dialog_mainPage.level.val [4685022878131781988]
  CHAR_STR = 6671999775096516877;//Root.NormalLayer.inventory_dialog_mainPage.strength.val [6671999775096516877]
  CHAR_DEX = -4372531741060143330;//Root.NormalLayer.inventory_dialog_mainPage.dexterity.val [-4372531741060143330]
  CHAR_INT = -4070855826768564529;//Root.NormalLayer.inventory_dialog_mainPage.intelligence.val [-4070855826768564529]
  CHAR_VIT = -4107877710991720954;//Root.NormalLayer.inventory_dialog_mainPage.vitality.val [-4107877710991720954]
  CHAR_ARMOR = -6525261601762777367;//Root.NormalLayer.inventory_dialog_mainPage.armor.val [-6525261601762777367]
  CHAR_DPS = -2622062949526804917;//Root.NormalLayer.inventory_dialog_mainPage.dps.val [-2622062949526804917]


  CHAR_DMG_STAT = 3138244559739087497;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_offense.stackpanel.damage_increase.val [3138244559739087497]
  CHAR_DMG_SKILL = -1685020978527009910;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_offense.stackpanel.damage_increase_skills.val [-1685020978527009910]
  CHAR_DMG_ATTACK_PERSEC = -42889536733582907;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_offense.stackpanel.attacks_per_second.val [-42889536733582907]
  CHAR_DMG_CRITHIT = -3380096549506516450;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_offense.stackpanel.crit_chance_bonus.val [-3380096549506516450]
  CHAR_DMG_CRITDMG = -3688146381508071093;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_offense.stackpanel.crit_damage_bonus.val [-3688146381508071093]

  CHAR_BLOCK_AMNT = 1249803480269529363;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.block_amount.val [1249803480269529363]
  CHAR_BLOCK = -1112167334192822977;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.block_chance.val [-1112167334192822977]
  CHAR_DODGE = -1431883400200100919;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.dodge_chance.val [-1431883400200100919]
  CHAR_DMG_REDUCE = -2226330347783038018;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.damage_reduction.val [-2226330347783038018]

  CHAR_RES_PHYS = -4975138454083160922;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.physical_resistance.val [-4975138454083160922]
  CHAR_RES_COLD = -31591190046852253;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.cold_resistance.val [-31591190046852253]
  CHAR_RES_FIRE = 3345302096047867273;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.fire_resistance.val [3345302096047867273]
  CHAR_RES_LIGHTNING = 1934112242039616827;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.lightning_resistance.val [1934112242039616827]
  CHAR_RES_POISON = 3595559460993361517;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.poison_resistance.val [3595559460993361517]
  CHAR_RES_ARCANE = 6590582217654354319;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.arcane_resistance.val [6590582217654354319]

  CHAR_CC_REDUCE = 3729124195334601985;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.cc_reduction.val [3729124195334601985]
  CHAR_MISSILE_DEF = 6444689135253746810;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.missile_defense_bonus.val [6444689135253746810]
  CHAR_MELEE_DEF = 7578783663070378046;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.melee_defense_bonus.val [7578783663070378046]
  CHAR_THORNS = 957219999691414394;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_defense.stackpanel.thorns_fixed.val [957219999691414394]


  CHAR_LIFE = -6327990121703925539;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life.val [-6327990121703925539]
  CHAR_LIFE_BONUS = -7188601676190515023;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life_from_affix.val [-7188601676190515023]
  CHAR_LIFE_PERSEC = 4896807456814297048;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life_per_second.val [4896807456814297048]
  CHAR_LIFE_STEAL = 7693804699870736805;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life_steal.val [7693804699870736805]
  CHAR_LIFE_PERKILL = 550107660180475756;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life_per_kill.val [550107660180475756]
  CHAR_LIFE_PERHIT = 3958452920361584291;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.life_per_hit.val [3958452920361584291]
  CHAR_LIFE_GLOBEBONUS = 2309192632231496503;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.health_globe_bonus.val [2309192632231496503]
  CHAR_PICKUP = 2650585178463292347;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_life.stackpanel.globe_radius_bonus.val [2650585178463292347]

  RES1_NAME = 6934917805615436904;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_resource.stackpanel.row1.name [6934917805615436904]
  RES1_VAL = 5179920230437037010;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_resource.stackpanel.row1.val [5179920230437037010]
  RES2_NAME = -219571220994234225;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_resource.stackpanel.row2.name [-219571220994234225]
  RES2_VAL = 5028288725492450987;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_resource.stackpanel.row2.val [5028288725492450987]

  CHAR_MOVESPEED = -8358895538556655070;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_adventurer.stackpanel.movement_speed.val []
  CHAR_GF = 7781485272730032187;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_adventurer.stackpanel.gold_find.val [7781485272730032187]
  CHAR_MF = 8290444824126491104;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_adventurer.stackpanel.magic_find.val [8290444824126491104]
  CHAR_BONUSXP = -8868155380023639193;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_adventurer.stackpanel.bonus_xp.val [-8868155380023639193]
  CHAR_BONUSXP_PERKILL = 8942881436326232082;//Root.NormalLayer.character_details_container.character_details.region.stackpanel.category_adventurer.stackpanel.bonus_xp_per_kill.val [8942881436326232082]

  //BUILD

  SKILL_LEFT = -8594488733706342789;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillLeftMouse.SkillName [-8594488733706342789]
  SKILL_LEFT_RUNE = 2786027519803141784;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillLeftMouse.SkillRune.SkillRuneName [2786027519803141784]
  SKILL_RIGHT = 7883611392641710568;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillRightMouse.SkillName [7883611392641710568]
  SKILL_RIGHT_RUNE = -5562963649847996257;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillRightMouse.SkillRune.SkillRuneName [-5562963649847996257]
  SKILL1 = 4407287175720712046;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction1.SkillName [4407287175720712046]
  SKILL1_RUNE = 6006331432135767585;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction1.SkillRune.SkillRuneName [6006331432135767585]
  SKILL2 = -8025998478778376465;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction2.SkillName [-8025998478778376465]
  SKILL2_RUNE = 1995560300635747636;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction2.SkillRune.SkillRuneName [1995560300635747636]
  SKILL3 = -4591930853579547096;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction3.SkillName [-4591930853579547096]
  SKILL3_RUNE = 5234400107624727647;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction3.SkillRune.SkillRuneName [5234400107624727647]
  SKILL4 = -639434427847722439;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction4.SkillName [-639434427847722439]
  SKILL4_RUNE = 8654005706796395650;//Root.NormalLayer.SkillPane_main.LayoutRoot.SkillsList.SkillAction4.SkillRune.SkillRuneName [8654005706796395650]


AH_RES0_TTL = -5458888882708096830;
AH_RES0_COL1 = 106919224760120403;
AH_RES0_COL2 = 5895577976566707876;
AH_RES0_COL3 = -4768624676833021523;
AH_RES0_COL4 = -1488905733378809722;
AH_RES0_COL5 = -4199673224242265417;

AH_RES1_TTL = 2448003708622535769;
AH_RES1_COL1 = 5113983495020744294;
AH_RES1_COL2 = 3413009632696424097;
AH_RES1_COL3 = 6472594599182794824;
AH_RES1_COL4 = 6664070658814834867;
AH_RES1_COL5 = 6160619167833716834;

AH_RES2_TTL = 9074419239025446068;
AH_RES2_COL1 = 9159343840016537113;
AH_RES2_COL2 = -3085001982935981154;
AH_RES2_COL3 = 2681213107393502799;
AH_RES2_COL4 = 6765478680846342396;
AH_RES2_COL5 = -3518392127157386587;

AH_RES3_TTL = -3681541280761911189;
AH_RES3_COL1 = -1472923393142555788;
AH_RES3_COL2 = -1335817723670863069;
AH_RES3_COL3 = -5419342804923599854;
AH_RES3_COL4 = 4249606484823893009;
AH_RES3_COL5 = -4874058247560970248;

AH_RES4_TTL = -352920372333563346;
AH_RES4_COL1 = 3134330370813648415;
AH_RES4_COL2 = -2549172395852968880;
AH_RES4_COL3 = -6582551613595901079;
AH_RES4_COL4 = -4953842885156276214;
AH_RES4_COL5 = -8381203903598538853;

AH_RES5_TTL = 6356712199422344645;
AH_RES5_COL1 = -983661912459240510;
AH_RES5_COL2 = 7584320111504651885;
AH_RES5_COL3 = 6022600491216340068;
AH_RES5_COL4 = 1466002096333756279;
AH_RES5_COL5 = -7374055488846505402;

AH_RES6_TTL = -6324432743805599024;
AH_RES6_COL1 = -7453513620940032203;
AH_RES6_COL2 = -9007540028370420022;
AH_RES6_COL3 = -7035343911882099877;
AH_RES6_COL4 = -6063934959830103536;
AH_RES6_COL5 = -2741139625725287895;

AH_RES7_TTL = 3555932187470650519;
AH_RES7_COL1 = 7642425573864726592;
AH_RES7_COL2 = 3249571795582349903;
AH_RES7_COL3 = -2516643294747134050;
AH_RES7_COL4 = -2950033438968539483;
AH_RES7_COL5 = 7333837369035189500;

AH_RES8_TTL = -910036849861227894;
AH_RES8_COL1 = -709358511154449221;
AH_RES8_COL2 = 3435705882329988396;
AH_RES8_COL3 = -4632215723703228907;
AH_RES8_COL4 = 4827436665638699790;
AH_RES8_COL5 = 3962204456133694271;

AH_RES9_TTL = 8832067514107648065;
AH_RES9_COL1 = 7660746330474920366;
AH_RES9_COL2 = -3070071234465425495;
AH_RES9_COL3 = -6392866568570241136;
AH_RES9_COL4 = -7364275520622237477;
AH_RES9_COL5 = 9110272436598993994;

AH_RES10_TTL = 1341876044561441861;
AH_RES10_COL1 = 5732833700652502850;
AH_RES10_COL2 = -4145928349093156371;
AH_RES10_COL3 = -5707647969381468188;
AH_RES10_COL4 = 8182497709445499639;
AH_RES10_COL5 = -657559875734762042;

implementation

end.
