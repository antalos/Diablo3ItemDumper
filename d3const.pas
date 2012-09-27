unit d3const;
interface
uses mem_Reader;

var
  mr : CMem_reader;

const
    offObjectMngr = $1543B9C;
    offObjectMngr_uilist = $924;
    offUIItemProperties = $210;

    off_isVisible = 40;
    off_isEnabled = $C64;
    off_cb_value = $0CFC;
    off_text_value = $000AC8;



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


implementation

end.
