import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';

// 定义宋词接口
interface Song {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string; // 添加拼音字段
}

@Entry
@Component
export struct SongsListPage {
  // 宋词列表
  @State private songs: Array<Song> = [
    {
      id: 1,
      title: '水调歌头・明月几时有',
      author: '苏轼',
      content: '明月几时有？把酒问青天。\n不知天上宫阙，今夕是何年。\n我欲乘风归去，又恐琼楼玉宇，高处不胜寒。\n起舞弄清影，何似在人间。\n转朱阁，低绮户，照无眠。\n不应有恨，何事长向别时圆？\n人有悲欢离合，月有阴晴圆缺，此事古难全。\n但愿人长久，千里共婵娟。',
      pinyin: 'míng yuè jǐ shí yǒu? bǎ jiǔ wèn qīng tiān.\n bù zhī tiān shàng gōng què, jīn xī shì hé nián. \nwǒ yù chéng fēng guī qù, yòu kǒng qióng lóu yù yǔ, gāo chù bú shèng hán.\n qǐ wǔ nòng qīng yǐng, hé sì zài rén jiān.\n zhuǎn zhū gé, dī qǐ hù, zhào wú mián. \nbù yīng yǒu hèn, hé shì cháng xiàng bié shí yuán? \nrén yǒu bēi huān lí hé, yuè yǒu yīn qíng yuán quē, cǐ shì gǔ nán quán. \ndàn yuàn rén cháng jiǔ, qiān lǐ gòng chán juān.'
    },
    {
      id: 2,
      title: '念奴娇・赤壁怀古',
      author: '苏轼',
      content: '大江东去，浪淘尽，千古风流人物。\n故垒西边，人道是，三国周郎赤壁。\n乱石穿空，惊涛拍岸，卷起千堆雪。\n江山如画，一时多少豪杰。\n遥想公瑾当年，小乔初嫁了，雄姿英发。\n羽扇纶巾，谈笑间，樯橹灰飞烟灭。\n故国神游，多情应笑我，早生华发。\n人生如梦，一尊还酹江月。',
      pinyin: 'dà jiāng dōng qù, làng táo jìn, qiān gǔ fēng liú rén wù.\n gù lěi xī biān, rén dào shì, sān guó zhōu láng chì bì.\n luàn shí chuān kōng, jīng tāo pāi àn, juǎn qǐ qiān duī xuě.\n jiāng shān rú huà, yī shí duō shǎo háo jié.\n yáo xiǎng gōng jǐn dāng nián, xiǎo qiáo chū jià liǎo, xióng zī yīng fā.\n yǔ shàn guān jīn, tán xiào jiān, qiáng lǔ huī fēi yān miè.\n gù guó shén yóu, duō qíng yīng xiào wǒ, zǎo shēng huá fà.\n rén shēng rú mèng, yī zūn hái lèi jiāng yuè.'
    },
    {
      id: 3,
      title: '声声慢・寻寻觅觅',
      author: '李清照',
      content: '寻寻觅觅，冷冷清清，凄凄惨惨戚戚。\n乍暖还寒时候，最难将息。\n三杯两盏淡酒，怎敌他、晚来风急？\n雁过也，正伤心，却是旧时相识。\n满地黄花堆积。憔悴损，如今有谁堪摘？\n守着窗儿，独自怎生得黑？\n梧桐更兼细雨，到黄昏、点点滴滴。\n这次第，怎一个愁字了得！',
      pinyin: 'xún xún mì mì, lěng lěng qīng qīng, qī qī cǎn cǎn qī qī.\n zhà nuǎn hái hán shí hòu, zuì nán jiāng xī.\n sān bēi liǎng zhǎn dàn jiǔ, zěn dí tā, wǎn lái fēng jí?\n yàn guò yě, zhèng shāng xīn, què shì jiù shí xiāng shí.\n mǎn dì huáng huā duī jī. qiáo cuì sǔn, rú jīn yǒu shuí kān zhāi?\n shǒu zhe chuāng ér, dú zì zěn shēng dé hēi?\n wú tóng gèng jiān xì yǔ, dào huáng hūn, diǎn diǎn dī dī.\n zhè cì dì, zěn yī gè chóu zì liǎo dé!'
    },
    {
      id: 4,
      title: '雨霖铃・寒蝉凄切',
      author: '柳永',
      content: '寒蝉凄切，对长亭晚，骤雨初歇。\n都门帐饮无绪，留恋处，兰舟催发。\n执手相看泪眼，竟无语凝噎。\n念去去，千里烟波，暮霭沉沉楚天阔。\n多情自古伤离别，更那堪，冷落清秋节！\n今宵酒醒何处？杨柳岸，晓风残月。\n此去经年，应是良辰好景虚设。\n便纵有千种风情，更与何人说？',
      pinyin: 'hán chán qī qiè, duì cháng tíng wǎn, zhòu yǔ chū xiē.\n dōu mén zhàng yǐn wú xù, liú liàn chù, lán zhōu cuī fā.\n zhí shǒu xiāng kàn lèi yǎn, jìng wú yǔ níng yē.\n niàn qù qù, qiān lǐ yān bō, mù ǎi chén chén chǔ tiān kuò.\n duō qíng zì gǔ shāng lí bié, gèng nǎ kān, lěng luò qīng qiū jié!\n jīn xiāo jiǔ xǐng hé chù? yáng liǔ àn, xiǎo fēng cán yuè.\n cǐ qù jīng nián, yīng shì liáng chén hǎo jǐng xū shè.\n biàn zòng yǒu qiān zhǒng fēng qíng, gèng yǔ hé rén shuō?'
    },
    {
      id: 5,
      title: '永遇乐・京口北固亭怀古',
      author: '辛弃疾',
      content: '千古江山，英雄无觅，孙仲谋处。\n舞榭歌台，风流总被，雨打风吹去。\n斜阳草树，寻常巷陌，人道寄奴曾住。\n想当年，金戈铁马，气吞万里如虎。\n元嘉草草，封狼居胥，赢得仓皇北顾。\n四十三年，望中犹记，烽火扬州路。\n可堪回首，佛狸祠下，一片神鸦社鼓！\n凭谁问：廉颇老矣，尚能饭否？',
      pinyin: 'qiān gǔ jiāng shān, yīng xióng wú mì, sūn zhòng móu chù.\n wǔ xiè gē tái, fēng liú zǒng bèi, yǔ dǎ fēng chuī qù.\n xié yáng cǎo shù, xún cháng xiàng mò, rén dào jì nú céng zhù.\n xiǎng dāng nián, jīn gē tiě mǎ, qì tūn wàn lǐ rú hǔ.\n yuán jiā cǎo cǎo, fēng láng jū xū, yíng dé cāng huáng běi gù.\n sì shí sān nián, wàng zhōng yóu jì, fēng huǒ yáng zhōu lù.\n kě kān huí shǒu, fó lí cí xià, yī piàn shén yā shè gǔ!\n píng shuí wèn: lián pō lǎo yǐ, shàng néng fàn fǒu?'
    },
    {
      id: 6,
      title: '虞美人・春花秋月何时了',
      author: '李煜',
      content: '春花秋月何时了？往事知多少。\n小楼昨夜又东风，故国不堪回首月明中。\n雕栏玉砌应犹在，只是朱颜改。\n问君能有几多愁？恰似一江春水向东流。',
      pinyin: 'chūn huā qiū yuè hé shí liǎo? wǎng shì zhī duō shǎo.\n xiǎo lóu zuó yè yòu dōng fēng, gù guó bú kān huí shǒu yuè míng zhōng.\n diāo lán yù qì yīng yóu zài, zhǐ shì zhū yán gǎi.\n wèn jūn néng yǒu jǐ duō chóu? qià sì yī jiāng chūn shuǐ xiàng dōng liú.'
    },
    {
      id: 7,
      title: '青玉案・元夕',
      author: '辛弃疾',
      content: '东风夜放花千树，更吹落、星如雨。\n宝马雕车香满路。\n凤箫声动，玉壶光转，一夜鱼龙舞。\n蛾儿雪柳黄金缕，笑语盈盈暗香去。\n众里寻他千百度，蓦然回首，那人却在，灯火阑珊处。',
      pinyin: 'dōng fēng yè fàng huā qiān shù, gèng chuī luò, xīng rú yǔ.\n bǎo mǎ diāo chē xiāng mǎn lù.\n fèng xiāo shēng dòng, yù hú guāng zhuǎn, yī yè yú lóng wǔ.\n é ér xuě liǔ huáng jīn lǚ, xiào yǔ yíng yíng àn xiāng qù.\n zhòng lǐ xún tā qiān bǎi dù, mò rán huí shǒu, nà rén què zài, dēng huǒ lán shān chù.'
    },
    {
      id: 8,
      title: '一剪梅・红藕香残玉簟秋',
      author: '李清照',
      content: '红藕香残玉簟秋。轻解罗裳，独上兰舟。\n云中谁寄锦书来？雁字回时，月满西楼。\n花自飘零水自流。一种相思，两处闲愁。\n此情无计可消除，才下眉头，却上心头。',
      pinyin: 'hóng ǒu xiāng cán yù diàn qiū. qīng jiě luó cháng, dú shàng lán zhōu.\n yún zhōng shuí jì jǐn shū lái? yàn zì huí shí, yuè mǎn xī lóu.\n huā zì piāo líng shuǐ zì liú. yī zhǒng xiāng sī, liǎng chù xián chóu.\n cǐ qíng wú jì kě xiāo chú, cái xià méi tóu, què shàng xīn tóu.'
    },
    {
      id: 9,
      title: '苏幕遮・碧云天',
      author: '范仲淹',
      content: '碧云天，黄叶地，秋色连波，波上寒烟翠。\n山映斜阳天接水，芳草无情，更在斜阳外。\n黯乡魂，追旅思。\n夜夜除非，好梦留人睡。\n明月楼高休独倚，酒入愁肠，化作相思泪。',
      pinyin: 'bì yún tiān, huáng yè dì, qiū sè lián bō, bō shàng hán yān cuì.\n shān yìng xié yáng tiān jiē shuǐ, fāng cǎo wú qíng, gèng zài xié yáng wài.\n àn xiāng hún, zhuī lǚ sī.\n yè yè chú fēi, hǎo mèng liú rén shuì.\n míng yuè lóu gāo xiū dú yǐ, jiǔ rù chóu cháng, huà zuò xiāng sī lèi.'
    },
    {
      id: 10,
      title: '渔家傲・塞下秋来风景异',
      author: '范仲淹',
      content: '塞下秋来风景异，衡阳雁去无留意。\n四面边声连角起，千嶂里，长烟落日孤城闭。\n浊酒一杯家万里，燕然未勒归无计。\n羌管悠悠霜满地，人不寐，将军白发征夫泪。',
      pinyin: 'sài xià qiū lái fēng jǐng yì, héng yáng yàn qù wú liú yì.\n sì miàn biān shēng lián jiǎo qǐ, qiān zhàng lǐ, cháng yān luò rì gū chéng bì.\n zhuó jiǔ yī bēi jiā wàn lǐ, yàn rán wèi lè guī wú jì.\n qiāng guǎn yōu yōu shuāng mǎn dì, rén bú mèi, jiāng jūn bái fà zhēng fū lèi.'
    },
    {
      id: 11,
      title: '蝶恋花・伫倚危楼风细细',
      author: '柳永',
      content: '伫倚危楼风细细，望极春愁，黯黯生天际。\n草色烟光残照里，无言谁会凭阑意。\n拟把疏狂图一醉，对酒当歌，强乐还无味。\n衣带渐宽终不悔，为伊消得人憔悴。',
      pinyin: 'zhù yǐ wēi lóu fēng xì xì, wàng jí chūn chóu, àn àn shēng tiān jì.\n cǎo sè yān guāng cán zhào lǐ, wú yán shuí huì píng lán yì.\n nǐ bǎ shū kuáng tú yī zuì, duì jiǔ dāng gē, qiǎng lè hái wú wèi.\n yī dài jiàn kuān zhōng bú huǐ, wèi yī xiāo dé rén qiáo cuì.'
    },
    {
      id: 12,
      title: '浣溪沙・一曲新词酒一杯',
      author: '晏殊',
      content: '一曲新词酒一杯，去年天气旧亭台。\n夕阳西下几时回。\n无可奈何花落去，似曾相识燕归来。\n小园香径独徘徊。',
      pinyin: 'yī qǔ xīn cí jiǔ yī bēi, qù nián tiān qì jiù tíng tái.\n xī yáng xī xià jǐ shí huí.\n wú kě nài hé huā luò qù, sì céng xiāng shí yàn guī lái.\n xiǎo yuán xiāng jìng dú pái huái.'
    },
    {
      id: 13,
      title: '蝶恋花・槛菊愁烟兰泣露',
      author: '晏殊',
      content: '槛菊愁烟兰泣露，罗幕轻寒，燕子双飞去。\n明月不谙离恨苦，斜光到晓穿朱户。\n昨夜西风凋碧树，独上高楼，望尽天涯路。\n欲寄彩笺兼尺素，山长水阔知何处。',
      pinyin: 'jiàn jú chóu yān lán qì lù, luó mù qīng hán, yàn zi shuāng fēi qù.\n míng yuè bú ān lí hèn kǔ, xié guāng dào xiǎo chuān zhū hù.\n zuó yè xī fēng diāo bì shù, dú shàng gāo lóu, wàng jìn tiān yá lù.\n yù jì cǎi jiān jiān chǐ sù, shān cháng shuǐ kuò zhī hé chù。'
    },
    {
      id: 14,
      title: '采桑子・轻舟短棹西湖好',
      author: '欧阳修',
      content: '轻舟短棹西湖好，绿水逶迤，芳草长堤，隐隐笙歌处处随。\n无风水面琉璃滑，不觉船移，微动涟漪，惊起沙禽掠岸飞。',
      pinyin: 'qīng zhōu duǎn zhào xī hú hǎo, lǜ shuǐ wēi yí, fāng cǎo cháng dī, yǐn yǐn shēng gē chù chù suí.\n wú fēng shuǐ miàn liú lí huá, bú jué chuán yí, wēi dòng lián yī, jīng qǐ shā qín lüè àn fēi.'
    },
    {
      id: 15,
      title: '桂枝香・金陵怀古',
      author: '王安石',
      content: '登临送目，正故国晚秋，天气初肃。\n千里澄江似练，翠峰如簇。\n归帆去棹残阳里，背西风，酒旗斜矗。\n彩舟云淡，星河鹭起，画图难足。\n念往昔，繁华竞逐，叹门外楼头，悲恨相续。\n千古凭高对此，谩嗟荣辱。\n六朝旧事随流水，但寒烟衰草凝绿。\n至今商女，时时犹唱，后庭遗曲。',
      pinyin: 'dēng lín sòng mù, zhèng gù guó wǎn qiū, tiān qì chū sù.\n qiān lǐ chéng jiāng sì liàn, cuì fēng rú cù.\n guī fān qù zhào cán yáng lǐ, bèi xī fēng, jiǔ qí xié chù.\n cǎi zhōu yún dàn, xīng hé lù qǐ, huà tú nán zú.\n niàn wǎng xī, fán huá jìng zhú, tàn mén wài lóu tóu, bēi hèn xiāng xù.\n qiān gǔ píng gāo duì cǐ, màn jiē róng rǔ.\n liù cháo jiù shì suí liú shuǐ, dàn hán yān shuāi cǎo níng lǜ.\n zhì jīn shāng nǚ, shí shí yóu chàng, hòu tíng yí qǔ.'
    },
    {
      id: 16,
      title: '临江仙・梦后楼台高锁',
      author: '晏殊',
      content: '梦后楼台高锁，酒醒帘幕低垂。\n去年春恨却来时。\n落花人独立，微雨燕双飞。\n记得小苹初见，两重心字罗衣。\n琵琶弦上说相思。\n当时明月在，曾照彩云归。',
      pinyin: 'mèng hòu lóu tái gāo suǒ, jiǔ xǐng lián mù dī chuí.\n qù nián chūn hèn què lái shí.\n luò huā rén dú lì, wēi yǔ yàn shuāng fēi.\n jì dé xiǎo píng chū jiàn, liǎng chóng xīn zì luó yī.\n pí pá xián shàng shuō xiāng sī.\n dāng shí míng yuè zài, céng zhào cǎi yún guī.'
    },
    {
      id: 17,
      title: '鹊桥仙・纤云弄巧',
      author: '秦观',
      content: '纤云弄巧，飞星传恨，银汉迢迢暗度。\n金风玉露一相逢，便胜却人间无数。\n柔情似水，佳期如梦，忍顾鹊桥归路。\n两情若是久长时，又岂在朝朝暮暮。',
      pinyin: 'xiān yún nòng qiǎo, fēi xīng chuán hèn, yín hàn tiáo tiáo àn dù.\n jīn fēng yù lù yī xiāng féng, biàn shèng què rén jiān wú shù.\n róu qíng sì shuǐ, jiā qī rú mèng, rěn gù què qiáo guī lù.\n liǎng qíng ruò shì jiǔ cháng shí, yòu qǐ zài zhāo zhāo mù mù.'
    },
    {
      id: 18,
      title: '定风波・莫听穿林打叶声',
      author: '苏轼',
      content: '莫听穿林打叶声，何妨吟啸且徐行。\n竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。\n料峭春风吹酒醒，微冷，山头斜照却相迎。\n回首向来萧瑟处，归去，也无风雨也无晴。',
      pinyin: 'mò tīng chuān lín dǎ yè shēng, hé fáng yín xiào qiě xú xíng.\n zhú zhàng máng xié qīng shèng mǎ, shuí pà? yī suō yān yǔ rèn píng shēng.\n liào qiào chūn fēng chuī jiǔ xǐng, wēi lěng, shān tóu xié zhào què xiāng yíng.\n huí shǒu xiàng lái xiāo sè chù, guī qù, yě wú fēng yǔ yě wú qíng.'
    },
    {
      id: 19,
      title: '诉衷情・当年万里觅封侯',
      author: '陆游',
      content: '当年万里觅封侯，匹马戍梁州。\n关河梦断何处？尘暗旧貂裘。\n胡未灭，鬓先秋，泪空流。\n此生谁料，心在天山，身老沧洲。',
      pinyin: 'dāng nián wàn lǐ mì fēng hóu, pǐ mǎ shù liáng zhōu.\n guān hé mèng duàn hé chù? chén àn jiù diāo qiú.\n hú wèi miè, bìn xiān qiū, lèi kōng liú.\n cǐ shēng shuí liào, xīn zài tiān shān, shēn lǎo cāng zhōu.'
    },
    {
      id: 20,
      title: '满江红・写怀',
      author: '岳飞',
      content: '怒发冲冠，凭栏处、潇潇雨歇。\n抬望眼，仰天长啸，壮怀激烈。\n三十功名尘与土，八千里路云和月。\n莫等闲、白了少年头，空悲切！\n靖康耻，犹未雪。\n臣子恨，何时灭！\n驾长车，踏破贺兰山缺。\n壮志饥餐胡虏肉，笑谈渴饮匈奴血。\n待从头、收拾旧山河，朝天阙！',
      pinyin: 'nù fà chōng guān, píng lán chù, xiāo xiāo yǔ xiē.\n tái wàng yǎn, yǎng tiān cháng xiào, zhuàng huái jī liè.\n sān shí gōng míng chén yǔ tǔ, bā qiān lǐ lù yún hé yuè.\n mò děng xián, bái le shào nián tóu, kōng bēi qiè!\n jìng kāng chǐ, yóu wèi xuě.\n chén zǐ hèn, hé shí miè!\n jià cháng chē, tà pò hè lán shān quē.\n zhuàng zhì jī cān hú lǔ ròu, xiào tán kě yǐn xiōng nú xuè.\n dài cóng tóu, shōu shí jiù shān hé, cháo tiān què!'
    },
    // 从第21首开始补充新数据，共110首
    {
      id: 21,
      title: '钗头凤·红酥手',
      author: '陆游',
      content: '红酥手，黄縢酒，满城春色宫墙柳。\n东风恶，欢情薄。\n一怀愁绪，几年离索。\n错、错、错。\n春如旧，人空瘦，泪痕红浥鲛绡透。\n桃花落，闲池阁。\n山盟虽在，锦书难托。\n莫、莫、莫！',
      pinyin: 'hóng sū shǒu, huáng téng jiǔ, mǎn chéng chūn sè gōng qiáng liǔ.\n dōng fēng è, huān qíng báo.\n yī huái chóu xù, jǐ nián lí suǒ.\n cuò, cuò, cuò.\n chūn rú jiù, rén kōng shòu, lèi hén hóng yì jiāo xiāo tòu.\n táo huā luò, xián chí gé.\n shān méng suī zài, jǐn shū nán tuō.\n mò, mò, mò!'
    },
    {
      id: 22,
      title: '钗头凤·世情薄',
      author: '唐琬',
      content: '世情薄，人情恶，雨送黄昏花易落。\n晓风干，泪痕残。\n欲笺心事，独语斜阑。\n难，难，难！\n人成各，今非昨，病魂常似秋千索。\n角声寒，夜阑珊。\n怕人寻问，咽泪装欢。\n瞒，瞒，瞒！',
      pinyin: 'shì qíng báo, rén qíng è, yǔ sòng huáng hūn huā yì luò.\n xiǎo fēng gān, lèi hén cán.\n yù jiān xīn shì, dú yǔ xié lán.\n nán, nán, nán!\n rén chéng gè, jīn fēi zuó, bìng hún cháng sì qiū qiān suǒ.\n jiǎo shēng hán, yè lán shān.\n pà rén xún wèn, yān lèi zhuāng huān.\n mán, mán, mán!'
    },
    {
      id: 23,
      title: '卜算子·咏梅',
      author: '陆游',
      content: '驿外断桥边，寂寞开无主。\n已是黄昏独自愁，更著风和雨。\n无意苦争春，一任群芳妒。\n零落成泥碾作尘，只有香如故。',
      pinyin: 'yì wài duàn qiáo biān, jì mò kāi wú zhǔ.\n yǐ shì huáng hūn dú zì chóu, gèng zhuó fēng hé yǔ.\n wú yì kǔ zhēng chūn, yī rèn qún fāng dù.\n líng luò chéng ní niǎn zuò chén, zhǐ yǒu xiāng rú gù.'
    },
    {
      id: 24,
      title: '破阵子·为陈同甫赋壮词以寄之',
      author: '辛弃疾',
      content: '醉里挑灯看剑，梦回吹角连营。\n八百里分麾下炙，五十弦翻塞外声。\n沙场秋点兵。\n马作的卢飞快，弓如霹雳弦惊。\n了却君王天下事，赢得生前身后名。\n可怜白发生！',
      pinyin: 'zuì lǐ tiāo dēng kàn jiàn, mèng huí chuī jiǎo lián yíng.\n bā bǎi lǐ fēn huī xià zhì, wǔ shí xián fān sāi wài shēng.\n shā chǎng qiū diǎn bīng.\n mǎ zuò dì lú fēi kuài, gōng rú pī lì xián jīng.\n liǎo què jūn wáng tiān xià shì, yíng dé shēng qián shēn hòu míng.\n kě lián bái fà shēng!'
    },
    {
      id: 25,
      title: '渔家傲·秋思',
      author: '范仲淹',
      content: '塞下秋来风景异，衡阳雁去无留意。\n四面边声连角起，千嶂里，长烟落日孤城闭。\n浊酒一杯家万里，燕然未勒归无计。\n羌管悠悠霜满地，人不寐，将军白发征夫泪。',
      pinyin: 'sài xià qiū lái fēng jǐng yì, héng yáng yàn qù wú liú yì.\n sì miàn biān shēng lián jiǎo qǐ, qiān zhàng lǐ, cháng yān luò rì gū chéng bì.\n zhuó jiǔ yī bēi jiā wàn lǐ, yàn rán wèi lè guī wú jì.\n qiāng guǎn yōu yōu shuāng mǎn dì, rén bú mèi, jiāng jūn bái fà zhēng fū lèi.'
    },
    {
      id: 26,
      title: '江城子·密州出猎',
      author: '苏轼',
      content: '老夫聊发少年狂，左牵黄，右擎苍，锦帽貂裘，千骑卷平冈。\n为报倾城随太守，亲射虎，看孙郎。\n酒酣胸胆尚开张，鬓微霜，又何妨！\n持节云中，何日遣冯唐？\n会挽雕弓如满月，西北望，射天狼。',
      pinyin: 'lǎo fū liáo fà shào nián kuáng, zuǒ qiān huáng, yòu qíng cāng, jǐn mào diāo qiú, qiān qí juǎn píng gāng.\n wèi bào qīng chéng suí tài shǒu, qīn shè hǔ, kàn sūn láng.\n jiǔ hān xiōng dǎn shàng kāi zhāng, bìn wēi shuāng, yòu hé fáng!\n chí jié yún zhōng, hé rì qiǎn féng táng?\n huì wǎn diāo gōng rú mǎn yuè, xī běi wàng, shè tiān láng.'
    },
    {
      id: 27,
      title: '摸鱼儿·雁丘词',
      author: '元好问',
      content: '问世间，情为何物，直教生死相许？\n天南地北双飞客，老翅几回寒暑。\n欢乐趣，离别苦，就中更有痴儿女。\n君应有语:渺万里层云，千山暮雪，只影向谁去？\n横汾路，寂寞当年箫鼓，荒烟依旧平楚。\n招魂楚些何嗟及，山鬼暗啼风雨。\n天也妒，未信与，莺儿燕子俱黄土。\n千秋万古，为留待骚人，狂歌痛饮，来访雁丘处。',
      pinyin: 'wèn shì jiān, qíng wéi hé wù, zhí jiào shēng sǐ xiāng xǔ?\n tiān nán dì běi shuāng fēi kè, lǎo chì jǐ huí hán shǔ.\n huān lè qù, lí bié kǔ, jiù zhōng gèng yǒu chī ér nǚ.\n jūn yīng yǒu yǔ: miǎo wàn lǐ céng yún, qiān shān mù xuě, zhǐ yǐng xiàng shuí qù?\n héng fén lù, jì mò dāng nián xiāo gǔ, huāng yān yī jiù píng chǔ.\n zhāo hún chǔ xiē hé jiē jí, shān guǐ àn tí fēng yǔ.\n tiān yě dù, wèi xìn yǔ, yīng ér yàn zi jù huáng tǔ.\n qiān qiū wàn gǔ, wèi liú dài sāo rén, kuáng gē tòng yǐn, lái fǎng yàn qiū chù.'
    },
    {
      id: 28,
      title: '相见欢·无言独上西楼',
      author: '李煜',
      content: '无言独上西楼，月如钩。\n寂寞梧桐深院锁清秋。\n剪不断，理还乱，是离愁。\n别是一般滋味在心头。',
      pinyin: 'wú yán dú shàng xī lóu, yuè rú gōu.\n jì mò wú tóng shēn yuàn suǒ qīng qiū.\n jiǎn bù duàn, lǐ hái luàn, shì lí chóu.\n bié shì yī bān zī wèi zài xīn tóu.'
    },
    {
      id: 29,
      title: '浪淘沙令·帘外雨潺潺',
      author: '李煜',
      content: '帘外雨潺潺，春意阑珊。\n罗衾不耐五更寒。\n梦里不知身是客，一晌贪欢。\n独自莫凭栏，无限江山，别时容易见时难。\n流水落花春去也，天上人间。',
      pinyin: 'lián wài yǔ chán chán, chūn yì lán shān.\n luó qīn bù nài wǔ gēng hán.\n mèng lǐ bù zhī shēn shì kè, yī shǎng tān huān.\n dú zì mò píng lán, wú xiàn jiāng shān, bié shí róng yì jiàn shí nán.\n liú shuǐ luò huā chūn qù yě, tiān shàng rén jiān.'
    },
    {
      id: 30,
      title: '浣溪沙·游蕲水清泉寺',
      author: '苏轼',
      content: '游蕲水清泉寺，寺临兰溪，溪水西流。\n山下兰芽短浸溪，松间沙路净无泥，潇潇暮雨子规啼。\n谁道人生无再少？门前流水尚能西！\n休将白发唱黄鸡。',
      pinyin: 'yóu qí shuǐ qīng quán sì, sì lín lán xī, xī shuǐ xī liú.\n shān xià lán yá duǎn jìn xī, sōng jiān shā lù jìng wú ní, xiāo xiāo mù yǔ zǐ guī tí.\n shuí dào rén shēng wú zài shǎo? mén qián liú shuǐ shàng néng xī!\n xiū jiāng bái fà chàng huáng jī.'
    },
    {
      id: 31,
      title: '卜算子·不是爱风尘',
      author: '严蕊',
      content: '不是爱风尘，似被前缘误。花落花开自有时，总赖东君主。\n去也终须去，住也如何住！若得山花插满头，莫问奴归处。',
      pinyin: 'bú shì ài fēng chén, sì bèi qián yuán wù. huā luò huā kāi zì yǒu shí, zǒng lài dōng jūn zhǔ.\n qù yě zhōng xū qù, zhù yě rú hé zhù! ruò dé shān huā chā mǎn tóu, mò wèn nú guī chù.'
    },
    {
      id: 32,
      title: '蝶恋花·庭院深深深几许',
      author: '欧阳修',
      content: '庭院深深深几许，杨柳堆烟，帘幕无重数。玉勒雕鞍游冶处，楼高不见章台路。\n雨横风狂三月暮，门掩黄昏，无计留春住。泪眼问花花不语，乱红飞过秋千去。',
      pinyin: 'tíng yuàn shēn shēn shēn jǐ xǔ, yáng liǔ duī yān, lián mù wú chóng shù. yù lè diāo ān yóu yě chù, lóu gāo bú jiàn zhāng tái lù.\n yǔ héng fēng kuáng sān yuè mù, mén yǎn huáng hūn, wú jì liú chūn zhù. lèi yǎn wèn huā huā bú yǔ, luàn hóng fēi guò qiū qiān qù.'
    },
    {
      id: 33,
      title: '苏幕遮·怀旧',
      author: '范仲淹',
      content: '碧云天，黄叶地。秋色连波，波上寒烟翠。山映斜阳天接水。芳草无情，更在斜阳外。\n黯乡魂，追旅思。夜夜除非，好梦留人睡。明月楼高休独倚。酒入愁肠，化作相思泪。',
      pinyin: 'bì yún tiān, huáng yè dì. qiū sè lián bō, bō shàng hán yān cuì. shān yìng xié yáng tiān jiē shuǐ. fāng cǎo wú qíng, gèng zài xié yáng wài.\n àn xiāng hún, zhuī lǚ sī. yè yè chú fēi, hǎo mèng liú rén shuì. míng yuè lóu gāo xiū dú yǐ. jiǔ rù chóu cháng, huà zuò xiāng sī lèi.'
    },
    {
      id: 34,
      title: '生查子·元夕',
      author: '欧阳修',
      content: '去年元夜时，花市灯如昼。月上柳梢头，人约黄昏后。\n今年元夜时，月与灯依旧。不见去年人，泪湿春衫袖。',
      pinyin: 'qù nián yuán yè shí, huā shì dēng rú zhòu. yuè shàng liǔ shāo tóu, rén yuē huáng hūn hòu.\n jīn nián yuán yè shí, yuè yǔ dēng yī jiù. bú jiàn qù nián rén, lèi shī chūn shān xiù.'
    },
    {
      id: 35,
      title: '水龙吟·登建康赏心亭',
      author: '辛弃疾',
      content: '楚天千里清秋，水随天去秋无际。遥岑远目，献愁供恨，玉簪螺髻。落日楼头，断鸿声里，江南游子。把吴钩看了，栏杆拍遍，无人会，登临意。\n休说鲈鱼堪脍，尽西风，季鹰归未？求田问舍，怕应羞见，刘郎才气。可惜流年，忧愁风雨，树犹如此！倩何人唤取，红巾翠袖，揾英雄泪！',
      pinyin: 'chǔ tiān qiān lǐ qīng qiū, shuǐ suí tiān qù qiū wú jì. yáo cén yuǎn mù, xiàn chóu gòng hèn, yù zān luó jì. luò rì lóu tóu, duàn hóng shēng lǐ, jiāng nán yóu zǐ. bǎ wú gōu kàn le, lán gǎn pāi biàn, wú rén huì, dēng lín yì.\n xiū shuō lú yú kān kuài, jìn xī fēng, jì yīng guī wèi? qiú tián wèn shě, pà yīng xiū jiàn, liú láng cái qì. kě xī liú nián, yōu chóu fēng yǔ, shù yóu rú cǐ! qiàn hé rén huàn qǔ, hóng jīn cuì xiù, wèn yīng xióng lèi!'
    },
    {
      id: 36,
      title: '鹧鸪天·桂花',
      author: '李清照',
      content: '暗淡轻黄体性柔。情疏迹远只香留。何须浅碧深红色，自是花中第一流。\n梅定妒，菊应羞。画阑开处冠中秋。骚人可煞无情思，何事当年不见收。',
      pinyin: 'àn dàn qīng huáng tǐ xìng róu. qíng shū jì yuǎn zhǐ xiāng liú. hé xū qiǎn bì shēn hóng sè, zì shì huā zhōng dì yī liú.\n méi dìng dù, jú yīng xiū. huà lán kāi chù guàn zhōng qiū. sāo rén kě shà wú qíng sī, hé shì dāng nián bú jiàn shōu.'
    },
    {
      id: 37,
      title: '玉楼春·尊前拟把归期说',
      author: '欧阳修',
      content: '尊前拟把归期说。未语春容先惨咽。人生自是有情痴，此恨不关风与月。\n离歌且莫翻新阕。一曲能教肠寸结。直须看尽洛城花，始共春风容易别。',
      pinyin: 'zūn qián nǐ bǎ guī qī shuō. wèi yǔ chūn róng xiān cǎn yè. rén shēng zì shì yǒu qíng chī, cǐ hèn bù guān fēng yǔ yuè.\n lí gē qiě mò fān xīn què. yī qǔ néng jiāo cháng cùn jié. zhí xū kàn jìn luò chéng huā, shǐ gòng chūn fēng róng yì bié.'
    },
    {
      id: 38,
      title: '点绛唇·蹴罢秋千',
      author: '李清照',
      content: '蹴罢秋千，起来慵整纤纤手。露浓花瘦，薄汗轻衣透。\n见客入来，袜刬金钗溜。和羞走，倚门回首，却把青梅嗅。',
      pinyin: 'cù bà qiū qiān, qǐ lái yōng zhěng xiān xiān shǒu. lù nóng huā shòu, báo hàn qīng yī tòu.\n jiàn kè rù lái, wà chǎn jīn chāi liū. hé xiū zǒu, yǐ mén huí shǒu, què bǎ qīng méi xiù.'
    },
    {
      id: 39,
      title: '小重山·昨夜寒蛩不住鸣',
      author: '岳飞',
      content: '昨夜寒蛩不住鸣。惊回千里梦，已三更。起来独自绕阶行。人悄悄，帘外月胧明。\n白首为功名。旧山松竹老，阻归程。欲将心事付瑶琴。知音少，弦断有谁听？',
      pinyin: 'zuó yè hán qióng bú zhù míng. jīng huí qiān lǐ mèng, yǐ sān gēng. qǐ lái dú zì rào jiē xíng. rén qiāo qiāo, lián wài yuè lóng míng.\n bái shǒu wèi gōng míng. jiù shān sōng zhú lǎo, zǔ guī chéng. yù jiāng xīn shì fù yáo qín. zhī yīn shǎo, xián duàn yǒu shuí tīng?'
    },
    {
      id: 40,
      title: '阳关曲·中秋月',
      author: '苏轼',
      content: '中秋作本名小秦王，入腔即阳关曲\n暮云收尽溢清寒。银汉无声转玉盘。此生此夜不长好，明月明年何处看。',
      pinyin: 'zhōng qiū zuò běn míng xiǎo qín wáng, rù qiāng jí yáng guān qǔ\nmù yún shōu jìn yì qīng hán. yín hàn wú shēng zhuǎn yù pán. cǐ shēng cǐ yè bú cháng hǎo, míng yuè míng nián hé chù kàn.'
    },
    {
      id: 41,
      title: '蝶恋花·泪湿阑干花著露',
      author: '毛滂',
      content: '泪湿阑干花著露。愁到眉峰碧聚。此恨平分取。更无言语。空相觑。断雨残云无意绪。寂寞朝朝暮暮。今夜山深处。断魂分付。潮回去。',
      pinyin: 'lèi shī lán gān huā zhuó lù. chóu dào méi fēng bì jù. cǐ hèn píng fēn qǔ. gèng wú yán yǔ. kōng xiāng qù. duàn yǔ cán yún wú yì xù. jì mò zhāo zhāo mù mù. jīn yè shān shēn chù. duàn hún fēn fù. cháo huí qù.'
    },
    {
      id: 42,
      title: '虞美人·寄公度',
      author: '舒亶',
      content: '芙蓉落尽天涵水。日暮沧波起。背飞双燕贴云寒。独向小楼东畔、倚阑看。浮生只合尊前老。雪满长安道。故人早晚上高台。赠我江南春色、一枝梅。',
      pinyin: 'fú róng luò jìn tiān hán shuǐ. rì mù cāng bō qǐ. bèi fēi shuāng yàn tiē yún hán. dú xiàng xiǎo lóu dōng pàn, yǐ lán kàn. fú shēng zhǐ hé zūn qián lǎo. xuě mǎn cháng ān dào. gù rén zǎo wǎn shàng gāo tái. zèng wǒ jiāng nán chūn sè, yī zhī méi.'
    },
    {
      id: 43,
      title: '菩萨蛮·书江西造口壁',
      author: '辛弃疾',
      content: '郁孤台下清江水。中间多少行人泪。西北望长安。可怜无数山。青山遮不住。毕竟东流去。江晚正愁余。山深闻鹧鸪。',
      pinyin: 'yù gū tái xià qīng jiāng shuǐ. zhōng jiān duō shǎo xíng rén lèi. xī běi wàng cháng ān. kě lián wú shù shān. qīng shān zhē bú zhù. bì jìng dōng liú qù. jiāng wǎn zhèng chóu yú. shān shēn wén zhè gū.'
    },
    {
      id: 44,
      title: '忆江南·江南好',
      author: '白居易',
      content: '江南好，风景旧曾谙。日出江花红胜火，春来江水绿如蓝。能不忆江南。',
      pinyin: 'jiāng nán hǎo, fēng jǐng jiù céng ān. rì chū jiāng huā hóng shèng huǒ, chūn lái jiāng shuǐ lǜ rú lán. néng bú yì jiāng nán.'
    },
    {
      id: 45,
      title: '鹊桥仙·纤云弄巧',
      author: '秦观',
      content: '纤云弄巧，飞星传恨，银汉迢迢暗度。金风玉露一相逢，便胜却人间无数。柔情似水，佳期如梦，忍顾鹊桥归路。两情若是久长时，又岂在朝朝暮暮。',
      pinyin: 'xiān yún nòng qiǎo, fēi xīng chuán hèn, yín hàn tiáo tiáo àn dù. jīn fēng yù lù yī xiāng féng, biàn shèng què rén jiān wú shù. róu qíng sì shuǐ, jiā qī rú mèng, rěn gù què qiáo guī lù. liǎng qíng ruò shì jiǔ cháng shí, yòu qǐ zài zhāo zhāo mù mù.'
    },
    {
      id: 46,
      title: '渔家傲·小雨纤纤风细细',
      author: '朱服',
      content: '小雨纤纤风细细。万家杨柳青烟里。恋树湿花飞不起。愁无比。和春付与东流水。九十光阴能有几。金龟解尽留无计。寄语东阳沽酒市。拚一醉。而今乐事他年泪。',
      pinyin: 'xiǎo yǔ xiān xiān fēng xì xì. wàn jiā yáng liǔ qīng yān lǐ. liàn shù shī huā fēi bú qǐ. chóu wú bǐ. hé chūn fù yǔ dōng liú shuǐ. jiǔ shí guāng yīn néng yǒu jǐ. jīn guī jiě jìn liú wú jì. jì yǔ dōng yáng gū jiǔ shì. pīn yī zuì. ér jīn lè shì tā nián lèi.'
    },
    {
      id: 47,
      title: '生查子·元夕',
      author: '欧阳修',
      content: '去年元夜时，花市灯如昼。月上柳梢头，人约黄昏后。今年元夜时，月与灯依旧。不见去年人，泪湿春衫袖。',
      pinyin: 'qù nián yuán yè shí, huā shì dēng rú zhòu. yuè shàng liǔ shāo tóu, rén yuē huáng hūn hòu. jīn nián yuán yè shí, yuè yǔ dēng yī jiù. bú jiàn qù nián rén, lèi shī chūn shān xiù.'
    },
    {
      id: 48,
      title: '千秋岁·数声鶗鴂',
      author: '张先',
      content: '数声鶗鴂。又报芳菲歇。惜春更把残红折。雨轻风色暴，梅子青时节。永丰柳，无人尽日花飞雪。莫把幺弦拨。怨极弦能说。天不老，情难绝。心似双丝网，中有千千结。夜过也，东窗未白凝残月。',
      pinyin: 'shù shēng tí jué. yòu bào fāng fēi xiē. xī chūn gèng bǎ cán hóng zhé. yǔ qīng fēng sè bào, méi zǐ qīng shí jié. yǒng fēng liǔ, wú rén jìn rì huā fēi xuě. mò bǎ yāo xián bō. yuàn jí xián néng shuō. tiān bú lǎo, qíng nán jué. xīn sì shuāng sī wǎng, zhōng yǒu qiān qiān jié. yè guò yě, dōng chuāng wèi bái níng cán yuè.'
    },
    {
      id: 49,
      title: '青门引·春思',
      author: '张先',
      content: '乍暖还轻冷。风雨晚来方定。庭轩寂寞近清明，残花中酒，又是去年病。楼头画角风吹醒。入夜重门静。那堪更被明月，隔墙送过秋千影。',
      pinyin: 'zhà nuǎn hái qīng lěng. fēng yǔ wǎn lái fāng dìng. tíng xuān jì mò jìn qīng míng, cán huā zhōng jiǔ, yòu shì qù nián bìng. lóu tóu huà jiǎo fēng chuī xǐng. rù yè chóng mén jìng. nà kān gèng bèi míng yuè, gé qiáng sòng guò qiū qiān yǐng.'
    },
    {
      id: 50,
      title: '木兰花·相离徒有相逢梦',
      author: '晏殊',
      content: '燕鸿过后莺归去。细算浮生千万绪。来时春梦不多时，去似朝云无觅处。闻琴解佩神仙侣。挽断罗衣留不住。劝君莫作独醒人，烂醉花间应有数。',
      pinyin: 'yàn hóng guò hòu yīng guī qù. xì suàn fú shēng qiān wàn xù. lái shí chūn mèng bú duō shí, qù sì zhāo yún wú mì chù. wén qín jiě pèi shén xiān lǚ. wǎn duàn luó yī liú bú zhù. quàn jūn mò zuò dú xǐng rén, làn zuì huā jiān yīng yǒu shù.'
    },
    {
      id: 51,
      title: '浣溪沙·漠漠轻寒上小楼',
      author: '秦观',
      content: '漠漠轻寒上小楼。晓阴无赖似穷秋。淡烟流水画屏幽。自在飞花轻似梦，无边丝雨细如愁。宝帘闲挂小银钩。',
      pinyin: 'mò mò qīng hán shàng xiǎo lóu. xiǎo yīn wú lài sì qióng qiū. dàn yān liú shuǐ huà píng yōu. zì zài fēi huā qīng sì mèng, wú biān sī yǔ xì rú chóu. bǎo lián xián guà xiǎo yín gōu.'
    },
    {
      id: 52,
      title: '减字木兰花·天涯旧恨',
      author: '秦观',
      content: '天涯旧恨，独自凄凉人不问。欲见回肠，断尽金炉小篆香。黛蛾长敛，任是春风吹不展。困倚危楼，过尽飞鸿字字愁。',
      pinyin: 'tiān yá jiù hèn, dú zì qī liáng rén bú wèn. yù jiàn huí cháng, duàn jìn jīn lú xiǎo zhuàn xiāng. dài é cháng liǎn, rèn shì chūn fēng chuī bú zhǎn. kùn yǐ wēi lóu, guò jìn fēi hóng zì zì chóu.'
    },
    {
      id: 53,
      title: '满庭芳·山抹微云',
      author: '秦观',
      content: '山抹微云，天粘衰草，画角声断谯门。暂停征棹，聊共引离尊。多少蓬莱旧事，空回首、烟霭纷纷。斜阳外，寒鸦万点，流水绕孤村。销魂。当此际，香囊暗解，罗带轻分。谩赢得、青楼薄幸名存。此去何时见也，襟袖上、空惹啼痕。伤情处，高城望断，灯火已黄昏。',
      pinyin: 'shān mǒ wēi yún, tiān zhān shuāi cǎo, huà jiǎo shēng duàn qiáo mén. zàn tíng zhēng zhào, liáo gòng yǐn lí zūn. duō shǎo péng lái jiù shì, kōng huí shǒu, yān ǎi fēn fēn. xié yáng wài, hán yā wàn diǎn, liú shuǐ rào gū cūn. xiāo hún. dāng cǐ jì, xiāng náng àn jiě, luó dài qīng fēn. màn yíng dé, qīng lóu bó xìng míng cún. cǐ qù hé shí jiàn yě, jīn xiù shàng, kōng rě tí hén. shāng qíng chù, gāo chéng wàng duàn, dēng huǒ yǐ huáng hūn.'
    },
    {
      id: 54,
      title: '望海潮·东南形胜',
      author: '柳永',
      content: '东南形胜，三吴都会，钱塘自古繁华。烟柳画桥，风帘翠幕，参差十万人家。云树绕堤沙。怒涛卷霜雪，天堑无涯。市列珠玑，户盈罗绮，竞豪奢。重湖叠巘清嘉。有三秋桂子，十里荷花。羌管弄晴，菱歌泛夜，嬉嬉钓叟莲娃。千骑拥高牙。乘醉听箫鼓，吟赏烟霞。异日图将好景，归去凤池夸。',
      pinyin: 'dōng nán xíng shèng, sān wú dōu huì, qián táng zì gǔ fán huá. yān liǔ huà qiáo, fēng lián cuì mù, cēn cī shí wàn rén jiā. yún shù rào dī shā. nù tāo juǎn shuāng xuě, tiān qiàn wú yá. shì liè zhū jī, hù yíng luó qǐ, jìng háo shē. chóng hú dié yǎn qīng jiā. yǒu sān qiū guì zǐ, shí lǐ hé huā. qiāng guǎn nòng qíng, líng gē fàn yè, xī xī diào sǒu lián wá. qiān qí yōng gāo yá. chéng zuì tīng xiāo gǔ, yín shǎng yān xiá. yì rì tú jiāng hǎo jǐng, guī qù fèng chí kuā.'
    },
    {
      id: 55,
      title: '八声甘州·对潇潇暮雨洒江天',
      author: '柳永',
      content: '对潇潇暮雨洒江天，一番洗清秋。渐霜风凄紧，关河冷落，残照当楼。是处红衰翠减，苒苒物华休。惟有长江水，无语东流。不忍登高临远，望故乡渺邈，归思难收。叹年来踪迹，何事苦淹留。想佳人妆楼颙望，误几回、天际识归舟。争知我，倚栏杆处，正恁凝愁。',
      pinyin: 'duì xiāo xiāo mù yǔ sǎ jiāng tiān, yī fān xǐ qīng qiū. jiàn shuāng fēng qī jǐn, guān hé lěng luò, cán zhào dāng lóu. shì chù hóng shuāi cuì jiǎn, rǎn rǎn wù huá xiū. wéi yǒu cháng jiāng shuǐ, wú yǔ dōng liú. bù rěn dēng gāo lín yuǎn, wàng gù xiāng miǎo miǎo, guī sī nán shōu. tàn nián lái zōng jì, hé shì kǔ yān liú. xiǎng jiā rén zhuāng lóu yóng wàng, wù jǐ huí, tiān jì shí guī zhōu. zhēng zhī wǒ, yǐ lán gān chù, zhèng nèn níng chóu.'
    },
    {
      id: 56,
      title: '雨霖铃·寒蝉凄切',
      author: '柳永',
      content: '寒蝉凄切，对长亭晚，骤雨初歇。都门帐饮无绪，留恋处，兰舟催发。执手相看泪眼，竟无语凝噎。念去去，千里烟波，暮霭沉沉楚天阔。多情自古伤离别，更那堪，冷落清秋节！今宵酒醒何处？杨柳岸，晓风残月。此去经年，应是良辰好景虚设。便纵有千种风情，更与何人说？',
      pinyin: 'hán chán qī qiè, duì cháng tíng wǎn, zhòu yǔ chū xiē. dōu mén zhàng yǐn wú xù, liú liàn chù, lán zhōu cuī fā. zhí shǒu xiāng kàn lèi yǎn, jìng wú yǔ níng yē. niàn qù qù, qiān lǐ yān bō, mù ǎi chén chén chǔ tiān kuò. duō qíng zì gǔ shāng lí bié, gèng nǎ kān, lěng luò qīng qiū jié! jīn xiāo jiǔ xǐng hé chù? yáng liǔ àn, xiǎo fēng cán yuè. cǐ qù jīng nián, yīng shì liáng chén hǎo jǐng xū shè. biàn zòng yǒu qiān zhǒng fēng qíng, gèng yǔ hé rén shuō?'
    },
    {
      id: 57,
      title: '蝶恋花·伫倚危楼风细细',
      author: '柳永',
      content: '伫倚危楼风细细，望极春愁，黯黯生天际。草色烟光残照里，无言谁会凭阑意。拟把疏狂图一醉，对酒当歌，强乐还无味。衣带渐宽终不悔，为伊消得人憔悴。',
      pinyin: 'zhù yǐ wēi lóu fēng xì xì, wàng jí chūn chóu, àn àn shēng tiān jì. cǎo sè yān guāng cán zhào lǐ, wú yán shuí huì píng lán yì. nǐ bǎ shū kuáng tú yī zuì, duì jiǔ dāng gē, qiǎng lè hái wú wèi. yī dài jiàn kuān zhōng bú huǐ, wèi yī xiāo dé rén qiáo cuì.'
    },
    {
      id: 58,
      title: '采莲令·月华收',
      author: '柳永',
      content: '月华收，云淡霜天曙。西征客、此时情苦。翠娥执手送临歧，轧轧开朱户。千娇面、盈盈伫立，无言有泪，断肠争忍回顾。一叶兰舟，便恁急桨凌波去。贪行色、岂知离绪。万般方寸，但饮恨，脉脉同谁语。更回首、重城不见，寒江天外，隐隐两三烟树。',
      pinyin: 'yuè huá shōu, yún dàn shuāng tiān shǔ. xī zhēng kè, cǐ shí qíng kǔ. cuì é zhí shǒu sòng lín qí, yà yà kāi zhū hù. qiān jiāo miàn, yíng yíng zhù lì, wú yán yǒu lèi, duàn cháng zhēng rěn huí gù. yī yè lán zhōu, biàn nín jí jiǎng líng bō qù. tān xíng sè, qǐ zhī lí xù. wàn bān fāng cùn, dàn yǐn hèn, mò mò tóng shuí yǔ. gèng huí shǒu, chóng chéng bú jiàn, hán jiāng tiān wài, yǐn yǐn liǎng sān yān shù.'
    },
    {
      id: 59,
      title: '玉蝴蝶·望处雨收云断',
      author: '柳永',
      content: '望处雨收云断，凭阑悄悄，目送秋光。晚景萧疏，堪动宋玉悲凉。水风轻，蘋花渐老，月露冷、梧叶飘黄。遣情伤。故人何在，烟水茫茫。难忘，文期酒会，几孤风月，屡变星霜。海阔山遥，未知何处是潇湘。念双燕、难凭远信，指暮天、空识归航。黯相望。断鸿声里，立尽斜阳。',
      pinyin: 'wàng chù yǔ shōu yún duàn, píng lán qiāo qiāo, mù sòng qiū guāng. wǎn jǐng xiāo shū, kān dòng sòng yù bēi liáng. shuǐ fēng qīng, pín huā jiàn lǎo, yuè lù lěng, wú yè piāo huáng. qiǎn qíng shāng. gù rén hé zài, yān shuǐ máng máng. nán wàng, wén qī jiǔ huì, jǐ gū fēng yuè, lǚ biàn xīng shuāng. hǎi kuò shān yáo, wèi zhī hé chù shì xiāo xiāng. niàn shuāng yàn, nán píng yuǎn xìn, zhǐ mù tiān, kōng shí guī háng. àn xiāng wàng. duàn hóng shēng lǐ, lì jìn xié yáng.'
    },
    {
      id: 60,
      title: '夜半乐·冻云黯淡天气',
      author: '柳永',
      content: '冻云黯淡天气，扁舟一叶，乘兴离江渚。渡万壑千岩，越溪深处。怒涛渐息，樵风乍起，更闻商旅相呼。片帆高举。泛画鹢、翩翩过南浦。望中酒旆闪闪，一簇烟村，数行霜树。残日下，渔人鸣榔归去。败荷零落，衰杨掩映，岸边两两三三，浣沙游女。避行客、含羞笑相语。到此因念，绣阁轻抛，浪萍难驻。叹后约丁宁竟何据。惨离怀，空恨岁晚归期阻。凝泪眼、杳杳神京路。断鸿声远长天暮。',
      pinyin: 'dòng yún àn dàn tiān qì, piān zhōu yī yè, chéng xìng lí jiāng zhǔ. dù wàn hè qiān yán, yuè xī shēn chù. nù tāo jiàn xī, qiáo fēng zhà qǐ, gèng wén shāng lǚ xiāng hū. piàn fān gāo jǔ. fàn huà yì, piān piān guò nán pǔ. wàng zhōng jiǔ pèi shǎn shǎn, yī cù yān cūn, shù háng shuāng shù. cán rì xià, yú rén míng láng guī qù. bài hé líng luò, shuāi yáng yǎn yìng, àn biān liǎng liǎng sān sān, huàn shā yóu nǚ. bì xíng kè, hán xiū xiào xiāng yǔ. dào cǐ yīn niàn, xiù gé qīng pāo, làng píng nán zhù. tàn hòu yuē dīng níng jìng hé jù. cǎn lí huái, kōng hèn suì wǎn guī qī zǔ. níng lèi yǎn, yǎo yǎo shén jīng lù. duàn hóng shēng yuǎn cháng tiān mù.'
    }, {
    id: 61,
    title: '贺新郎·别茂嘉十二弟',
    author: '辛弃疾',
    content: '绿树听鹈鴂。更那堪、鹧鸪声住，杜鹃声切。\n啼到春归无寻处，苦恨芳菲都歇。\n算未抵、人间离别。\n马上琵琶关塞黑，更长门、翠辇辞金阙。\n看燕燕，送归妾。\n将军百战身名裂。向河梁、回头万里，故人长绝。\n易水萧萧西风冷，满座衣冠似雪。\n正壮士、悲歌未彻。\n啼鸟还知如许恨，料不啼清泪长啼血。\n谁共我，醉明月？',
    pinyin: 'lǜ shù tīng tí jué. gèng nà kān, zhè gū shēng zhù, dù juān shēng qiè.\n tí dào chūn guī wú xún chù, kǔ hèn fāng fēi dōu xiē.\n suàn wèi dǐ, rén jiān lí bié.\n mǎ shàng pí pá guān sài hēi, gèng cháng mén, cuì niǎn cí jīn què.\n kàn yàn yàn, sòng guī qiè.\n jiāng jūn bǎi zhàn shēn míng liè. xiàng hé liáng, huí tóu wàn lǐ, gù rén cháng jué.\n yì shuǐ xiāo xiāo xī fēng lěng, mǎn zuò yī guān sì xuě.\n zhèng zhuàng shì, bēi gē wèi chè.\n tí niǎo hái zhī rú xǔ hèn, liào bù tí qīng lèi cháng tí xuè.\n shuí gòng wǒ, zuì míng yuè?'
  },
    {
      id: 62,
      title: '扬州慢·淮左名都',
      author: '姜夔',
      content: '淮左名都，竹西佳处，解鞍少驻初程。\n过春风十里，尽荠麦青青。\n自胡马窥江去后，废池乔木，犹厌言兵。\n渐黄昏，清角吹寒，都在空城。\n杜郎俊赏，算而今、重到须惊。\n纵豆蔻词工，青楼梦好，难赋深情。\n二十四桥仍在，波心荡、冷月无声。\n念桥边红药，年年知为谁生？',
      pinyin: 'huái zuǒ míng dū, zhú xī jiā chù, jiě ān shǎo zhù chū chéng.\n guò chūn fēng shí lǐ, jìn jì mài qīng qīng.\n zì hú mǎ kuī jiāng qù hòu, fèi chí qiáo mù, yóu yàn yán bīng.\n jiàn huáng hūn, qīng jiǎo chuī hán, dōu zài kōng chéng.\n dù láng jùn shǎng, suàn ér jīn, chóng dào xū jīng.\n zòng dòu kòu cí gōng, qīng lóu mèng hǎo, nán fù shēn qíng.\n èr shí sì qiáo réng zài, bō xīn dàng, lěng yuè wú shēng.\n niàn qiáo biān hóng yào, nián nián zhī wèi shuí shēng?'
    },
    {
      id: 63,
      title: '暗香·旧时月色',
      author: '姜夔',
      content: '旧时月色，算几番照我，梅边吹笛。\n唤起玉人，不管清寒与攀摘。\n何逊而今渐老，都忘却、春风词笔。\n但怪得、竹外疏花，香冷入瑶席。\n江国，正寂寂。\n叹寄与路遥，夜雪初积。\n翠尊易泣，红萼无言耿相忆。\n长记曾携手处，千树压、西湖寒碧。\n又片片、吹尽也，几时见得？',
      pinyin: 'jiù shí yuè sè, suàn jǐ fān zhào wǒ, méi biān chuī dí.\n huàn qǐ yù rén, bù guǎn qīng hán yǔ pān zhāi.\n hé xùn ér jīn jiàn lǎo, dōu wàng què, chūn fēng cí bǐ.\n dàn guài dé, zhú wài shū huā, xiāng lěng rù yáo xí.\n jiāng guó, zhèng jì jì.\n tàn jì yǔ lù yáo, yè xuě chū jī.\n cuì zūn yì qì, hóng è wú yán gěng xiāng yì.\n cháng jì céng xié shǒu chù, qiān shù yā, xī hú hán bì.\n yòu piàn piàn, chuī jìn yě, jǐ shí jiàn dé?'
    },
    {
      id: 64,
      title: '疏影·苔枝缀玉',
      author: '姜夔',
      content: '苔枝缀玉，有翠禽小小，枝上同宿。\n客里相逢，篱角黄昏，无言自倚修竹。\n昭君不惯胡沙远，但暗忆、江南江北。\n想佩环、月夜归来，化作此花幽独。\n犹记深宫旧事，那人正睡里，飞近蛾绿。\n莫似春风，不管盈盈，早与安排金屋。\n还教一片随波去，又却怨、玉龙哀曲。\n等恁时、重觅幽香，已入小窗横幅。',
      pinyin: 'tái zhī zhuì yù, yǒu cuì qín xiǎo xiǎo, zhī shàng tóng sù.\n kè lǐ xiāng féng, lí jiǎo huáng hūn, wú yán zì yǐ xiū zhú.\n zhāo jūn bú guàn hú shā yuǎn, dàn àn yì, jiāng nán jiāng běi.\n xiǎng pèi huán, yuè yè guī lái, huà zuò cǐ huā yōu dú.\n yóu jì shēn gōng jiù shì, nà rén zhèng shuì lǐ, fēi jìn é lǜ.\n mò sì chūn fēng, bù guǎn yíng yíng, zǎo yǔ ān pái jīn wū.\n hái jiào yī piàn suí bō qù, yòu què yuàn, yù lóng āi qū.\n děng nèn shí, chóng mì yōu xiāng, yǐ rù xiǎo chuāng héng fú.'
    },
    {
      id: 65,
      title: '长亭怨慢·渐吹尽',
      author: '姜夔',
      content: '渐吹尽，枝头香絮。\n是处人家，绿深门户。\n远浦萦回，暮帆零乱，向何许？\n阅人多矣，谁得似、长亭树。\n树若有情时，不会得、青青如此。\n日暮，望高城不见，只见乱山无数。\n韦郎去也，怎忘得、玉环分付。\n第一是、早早归来，怕红萼、无人为主。\n算空有并刀，难剪离愁千缕。',
      pinyin: 'jiàn chuī jìn, zhī tóu xiāng xù.\n shì chù rén jiā, lǜ shēn mén hù.\n yuǎn pǔ yíng huí, mù fān líng luàn, xiàng hé xǔ?\n yuè rén duō yǐ, shuí dé sì, cháng tíng shù.\n shù ruò yǒu qíng shí, bú huì dé, qīng qīng rú cǐ.\n rì mù, wàng gāo chéng bú jiàn, zhǐ jiàn luàn shān wú shù.\n wéi láng qù yě, zěn wàng dé, yù huán fēn fù.\n dì yī shì, zǎo zǎo guī lái, pà hóng è, wú rén wéi zhǔ.\n suàn kōng yǒu bìng dāo, nán jiǎn lí chóu qiān lǚ.'
    },
    {
      id: 66,
      title: '淡黄柳·空城晓角',
      author: '姜夔',
      content: '空城晓角，吹入垂杨陌。\n马上单衣寒恻恻。\n看尽鹅黄嫩绿，都是江南旧相识。\n正岑寂，明朝又寒食。\n强携酒、小桥宅。\n怕梨花落尽成秋色。\n燕燕飞来，问春何在，唯有池塘自碧。',
      pinyin: 'kōng chéng xiǎo jiǎo, chuī rù chuí yáng mò.\n mǎ shàng dān yī hán cè cè.\n kàn jìn é huáng nèn lǜ, dōu shì jiāng nán jiù xiāng shí.\n zhèng cén jì, míng cháo yòu hán shí.\n qiǎng xié jiǔ, xiǎo qiáo zhái.\n pà lí huā luò jìn chéng qiū sè.\n yàn yàn fēi lái, wèn chūn hé zài, wéi yǒu chí táng zì bì.'
    },
    {
      id: 67,
      title: '翠楼吟·月冷龙沙',
      author: '姜夔',
      content: '月冷龙沙，尘清虎落，今年汉酺初赐。\n新翻胡部曲，听毡幕、元戎歌吹。\n层楼高峙。\n看槛曲萦红，檐牙飞翠。\n人姝丽，粉香吹下，夜寒风细。\n此地，宜有词仙，拥素云黄鹤，与君游戏。\n玉梯凝望久，叹芳草、萋萋千里。\n天涯情味。\n仗酒祓清愁，花销英气。\n婆娑醉，玉箫吹断，晚风残月。',
      pinyin: 'yuè lěng lóng shā, chén qīng hǔ luò, jīn nián hàn pú chū cì.\n xīn fān hú bù qǔ, tīng zhān mù, yuán róng gē chuī.\n céng lóu gāo zhì.\n kàn kǎn qū yíng hóng, yán yá fēi cuì.\n rén shū lì, fěn xiāng chuī xià, yè hán fēng xì.\n cǐ dì, yí yǒu cí xiān, yōng sù yún huáng hè, yǔ jūn yóu xì.\n yù tī níng wàng jiǔ, tàn fāng cǎo, qī qī qiān lǐ.\n tiān yá qíng wèi.\n zhàng jiǔ fú qīng chóu, huā xiāo yīng qì.\n pó suō zuì, yù xiāo chuī duàn, wǎn fēng cán yuè.'
    },
    {
      id: 68,
      title: '解连环·怨怀无托',
      author: '周邦彦',
      content: '怨怀无托。嗟情人断绝，信音辽邈。\n纵妙手、能解连环，似风散雨收，雾轻云薄。\n燕子楼空，暗尘锁、一床弦索。\n想移根换叶，尽是旧时，手种红药。\n汀洲渐生杜若。料舟依岸曲，人在天角。\n漫记得、当日音书，把闲语闲言，待总烧却。\n水驿春回，望寄我、江南梅萼。\n拚今生、对花对酒，为伊泪落。',
      pinyin: 'yuàn huái wú tuō. jiē qíng rén duàn jué, xìn yīn liáo miǎo.\n zòng miào shǒu, néng jiě lián huán, sì fēng sàn yǔ shōu, wù qīng yún bó.\n yàn zi lóu kōng, àn chén suǒ, yī chuáng xián suǒ.\n xiǎng yí gēn huàn yè, jìn shì jiù shí, shǒu zhǒng hóng yào.\n tīng zhōu jiàn shēng dù ruò. liào zhōu yī àn qū, rén zài tiān jiǎo.\n màn jì dé, dāng rì yīn shū, bǎ xián yǔ xián yán, dài zǒng shāo què.\n shuǐ yì chūn huí, wàng jì wǒ, jiāng nán méi è.\n pīn jīn shēng, duì huā duì jiǔ, wèi yī lèi luò.'
    },
    {
      id: 69,
      title: '兰陵王·柳阴直',
      author: '周邦彦',
      content: '柳阴直，烟里丝丝弄碧。\n隋堤上、曾见几番，拂水飘绵送行色。\n登临望故国，谁识京华倦客？\n长亭路，年去岁来，应折柔条过千尺。\n闲寻旧踪迹，又酒趁哀弦，灯照离席。\n梨花榆火催寒食。\n愁一箭风快，半篙波暖，回头迢递便数驿。\n望人在天北。\n凄恻，恨堆积。\n渐别浦萦回，津堠岑寂。\n斜阳冉冉春无极。\n念月榭携手，露桥闻笛。\n沉思前事，似梦里，泪暗滴。',
      pinyin: 'liǔ yīn zhí, yān lǐ sī sī nòng bì.\n suí dī shàng, céng jiàn jǐ fān, fú shuǐ piāo mián sòng xíng sè.\n dēng lín wàng gù guó, shuí shí jīng huá juàn kè?\n cháng tíng lù, nián qù suì lái, yīng zhé róu tiáo guò qiān chǐ.\n xián xún jiù zōng jì, yòu jiǔ chèn āi xián, dēng zhào lí xí.\n lí huā yú huǒ cuī hán shí.\n chóu yī jiàn fēng kuài, bàn gāo bō nuǎn, huí tóu tiáo dì biàn shù yì.\n wàng rén zài tiān běi.\n qī cè, hèn duī jī.\n jiàn bié pǔ yíng huí, jīn hòu cén jì.\n xié yáng rǎn rǎn chūn wú jí.\n niàn yuè xiè xié shǒu, lù qiáo wén dí.\n chén sī qián shì, sì mèng lǐ, lèi àn dī.'
    },
    {
      id: 70,
      title: '瑞龙吟·章台路',
      author: '周邦彦',
      content: '章台路，还见褪粉梅梢，试花桃树。\n愔愔坊陌人家，定巢燕子，归来旧处。\n黯凝伫，因念个人痴小，乍窥门户。\n侵晨浅约宫黄，障风映袖，盈盈笑语。\n前度刘郎重到，访邻寻里，同时歌舞。\n唯有旧家秋娘，声价如故。\n吟笺赋笔，犹记燕台句。\n知谁伴、名园露饮，东城闲步。\n事与孤鸿去。\n探春尽是，伤离意绪。\n官柳低金缕。\n归骑晚、纤纤池塘飞雨。\n断肠院落，一帘风絮。',
      pinyin: 'zhāng tái lù, hái jiàn tùn fěn méi shāo, shì huā táo shù.\n yīn yīn fāng mò rén jiā, dìng cháo yàn zi, guī lái jiù chù.\n àn níng zhù, yīn niàn gè rén chī xiǎo, zhà kuī mén hù.\n qīn chén qiǎn yuē gōng huáng, zhàng fēng yìng xiù, yíng yíng xiào yǔ.\n qián dù liú láng chóng dào, fǎng lín xún lǐ, tóng shí gē wǔ.\n wéi yǒu jiù jiā qiū niáng, shēng jià rú gù.\n yín jiān fù bǐ, yóu jì yàn tái jù.\n zhī shuí bàn, míng yuán lù yǐn, dōng chéng xián bù.\n shì yǔ gū hóng qù.\n tàn chūn jìn shì, shāng lí yì xù.\n guān liǔ dī jīn lǚ.\n guī qí wǎn, xiān xiān chí táng fēi yǔ.\n duàn cháng yuàn luò, yī lián fēng xù.'
    },
    {
      id: 71,
      title: '六丑·正单衣试酒',
      author: '周邦彦',
      content: '正单衣试酒，怅客里、光阴虚掷。\n愿春暂留，春归如过翼。\n一去无迹。\n为问花何在？夜来风雨，葬楚宫倾国。\n钗钿堕处遗香泽，乱点桃蹊，轻翻柳陌。\n多情为谁追惜？但蜂媒蝶使，时叩窗槅。\n东园岑寂，渐蒙笼暗碧。\n静绕珍丛底，成叹息。\n长条故惹行客，似牵衣待话，别情无极。\n残英小、强簪巾帻。\n终不似、一朵钗头颤袅，向人欹侧。\n漂流处、莫趁潮汐。\n恐断红、尚有相思字，何由见得？',
      pinyin: 'zhèng dān yī shì jiǔ, chàng kè lǐ, guāng yīn xū zhì.\n yuàn chūn zàn liú, chūn guī rú guò yì.\n yī qù wú jì.\n wèi wèn huā hé zài? yè lái fēng yǔ, zàng chǔ gōng qīng guó.\n chāi diàn duò chù yí xiāng zé, luàn diǎn táo qī, qīng fān liǔ mò.\n duō qíng wèi shuí zhuī xī? dàn fēng méi dié shǐ, shí kòu chuāng gé.\n dōng yuán cén jì, jiàn méng lóng àn bì.\n jìng rào zhēn cóng dǐ, chéng tàn xī.\n cháng tiáo gù rě xíng kè, sì qiān yī dài huà, bié qíng wú jí.\n cán yīng xiǎo, qiǎng zān jīn zé.\n zhōng bú sì, yī duǒ chāi tóu chàn niǎo, xiàng rén yī cè.\n piāo liú chù, mò chèn cháo xī.\n kǒng duàn hóng, shàng yǒu xiāng sī zì, hé yóu jiàn dé?'
    },
    {
      id: 72,
      title: '过秦楼·水浴清蟾',
      author: '周邦彦',
      content: '水浴清蟾，月穿疏柳，寺锁玉楼人去。\n暗尘随马，碎鼓摇铃，争看凤钗双度。\n别馆闲亭，露桥深巷，多少旧愁新绪。\n怎得银笺，殷勤与说年华。\n如今何处。\n因念绣阁轻抛，浪萍难驻。\n叹后约丁宁竟何据。\n惨离怀，空恨岁晚归期阻。\n凝泪眼，杳杳神京路。\n断鸿声远长天暮。',
      pinyin: 'shuǐ yù qīng chán, yuè chuān shū liǔ, sì suǒ yù lóu rén qù.\n àn chén suí mǎ, suì gǔ yáo líng, zhēng kàn fèng chāi shuāng dù.\n bié guǎn xián tíng, lù qiáo shēn xiàng, duō shǎo jiù chóu xīn xù.\n zěn dé yín jiān, yīn qín yǔ shuō nián huá.\n rú jīn hé chù.\n yīn niàn xiù gé qīng pāo, làng píng nán zhù.\n tàn hòu yuē dīng níng jìng hé jù.\n cǎn lí huái, kōng hèn suì wǎn guī qī zǔ.\n níng lèi yǎn, yǎo yǎo shén jīng lù.\n duàn hóng shēng yuǎn cháng tiān mù.'
    },
    {
      id: 73,
      title: '花犯·粉墙低',
      author: '周邦彦',
      content: '粉墙低，梅花照眼，依然旧风味。\n露痕轻缀，疑净洗铅华，无限佳丽。\n去年胜赏曾孤倚，冰盘同宴喜。\n更可惜、雪中高树，香篝熏素被。\n今年对花最匆匆，相逢似有恨，依依憔悴。\n吟望久，青苔上、旋看飞坠。\n相将见、脆丸荐酒，人正在、空江烟浪里。\n但梦想、一枝潇洒，黄昏斜照水。',
      pinyin: 'fěn qiáng dī, méi huā zhào yǎn, yī rán jiù fēng wèi.\n lù hén qīng zhuì, yí jìng xǐ qiān huá, wú xiàn jiā lì.\n qù nián shèng shǎng céng gū yǐ, bīng pán tóng yàn xǐ.\n gèng kě xī, xuě zhōng gāo shù, xiāng gōu xūn sù bèi.\n jīn nián duì huā zuì cōng cōng, xiāng féng sì yǒu hèn, yī yī qiáo cuì.\n yín wàng jiǔ, qīng tái shàng, xuán kàn fēi zhuì.\n xiāng jiāng jiàn, cuì wán jiàn jiǔ, rén zhèng zài, kōng jiāng yān làng lǐ.\n dàn mèng xiǎng, yī zhī xiāo sǎ, huáng hūn xié zhào shuǐ.'
    },
    {
      id: 74,
      title: '大酺·对宿烟收',
      author: '周邦彦',
      content: '对宿烟收，春禽静，飞雨时鸣高屋。\n墙头青玉旆，洗铅霜、尽堕风梢奇骨。\n楚乡修竹，当年供奉，惋惜湘妃泪竹。\n千亩封君，何须斗水，移根傍石。\n空山老，岁晚犹有，岁寒心独。\n无人赏高洁，西风晚，但觉绿阴森覆。\n爱此君、秀色可餐，况宜近、窗扉几曲。\n想见来时，幽禽相和，碎玉玲珑触。\n谁信道，山中客，解佩环、结同心足。\n归来后，翠尊双饮，下了珠帘，玲珑几曲。',
      pinyin: 'duì sù yān shōu, chūn qín jìng, fēi yǔ shí míng gāo wū.\n qiáng tóu qīng yù pèi, xǐ qiān shuāng, jìn duò fēng shāo qí gǔ.\n chǔ xiāng xiū zhú, dāng nián gòng fèng, wǎn xī xiāng fēi lèi zhú.\n qiān mǔ fēng jūn, hé xū dòu shuǐ, yí gēn bàng shí.\n kōng shān lǎo, suì wǎn yóu yǒu, suì hán xīn dú.\n wú rén shǎng gāo jié, xī fēng wǎn, dàn jué lǜ yīn sēn fù.\n ài cǐ jūn, xiù sè kě cān, kuàng yí jìn, chuāng fēi jǐ qū.\n xiǎng jiàn lái shí, yōu qín xiāng hè, suì yù líng lóng chù.\n shuí xìn dào, shān zhōng kè, jiě pèi huán, jié tóng xīn zú.\n guī lái hòu, cuì zūn shuāng yǐn, xià le zhū lián, líng lóng jǐ qū.'
    },
    {
      id: 75,
      title: '解语花·上元',
      author: '周邦彦',
      content: '风消绛蜡，露浥红莲，灯市光相射。\n桂华流瓦，纤云散、耿耿素娥欲下。\n衣裳淡雅，看楚女、纤腰一把。\n箫鼓喧，人影参差，满路飘香麝。\n因念都城放夜，望千门如昼，嬉笑游冶。\n钿车罗帕，相逢处、自有暗尘随马。\n年光是也，唯只见、旧情衰谢。\n清漏移，飞盖归来，从舞休歌罢。',
      pinyin: 'fēng xiāo jiàng là, lù yì hóng lián, dēng shì guāng xiāng shè.\n guì huá liú wǎ, xiān yún sàn, gěng gěng sù é yù xià.\n yī shang dàn yǎ, kàn chǔ nǚ, xiān yāo yī bǎ.\n xiāo gǔ xuān, rén yǐng cēn cī, mǎn lù piāo xiāng shè.\n yīn niàn dū chéng fàng yè, wàng qiān mén rú zhòu, xī xiào yóu yě.\n diàn chē luó pà, xiāng féng chù, zì yǒu àn chén suí mǎ.\n nián guāng shì yě, wéi zhǐ jiàn, jiù qíng shuāi xiè.\n qīng lòu yí, fēi gài guī lái, cóng wǔ xiū gē bà.'
    },
    {
      id: 76,
      title: '拜星月慢·夜色催更',
      author: '周邦彦',
      content: '夜色催更，清尘收露，小曲幽坊月暗。\n竹槛灯窗，识秋娘庭院。\n笑相遇，似觉琼枝玉树，暖日明霞光烂。\n水盼兰情，总平生稀见。\n画图中、旧识春风面。\n谁知道、自到瑶台畔。\n眷恋雨润云温，苦惊风吹散。\n念荒寒、寄宿无人馆。\n重门闭、败壁秋虫叹。\n怎奈向、一缕相思，隔溪山不断。',
      pinyin: 'yè sè cuī gēng, qīng chén shōu lù, xiǎo qū yōu fāng yuè àn.\n zhú kǎn dēng chuāng, shí qiū niáng tíng yuàn.\n xiào xiāng yù, sì jué qióng zhī yù shù, nuǎn rì míng xiá guāng làn.\n shuǐ pàn lán qíng, zǒng píng shēng xī jiàn.\n huà tú zhōng, jiù shí chūn fēng miàn.\n shuí zhī dào, zì dào yáo tái pàn.\n juàn liàn yǔ rùn yún wēn, kǔ jīng fēng chuī sàn.\n niàn huāng hán, jì sù wú rén guǎn.\n chóng mén bì, bài bì qiū chóng tàn.\n zěn nài xiàng, yī lǚ xiāng sī, gé xī shān bú duàn.'
    },
    {
      id: 77,
      title: '关河令·秋阴时晴',
      author: '周邦彦',
      content: '秋阴时晴渐向暝，变一庭凄冷。\n伫听寒声，云深无雁影。\n更深人去寂静，但照壁、孤灯相映。\n酒已都醒，如何消夜永？',
      pinyin: 'qiū yīn shí qíng jiàn xiàng míng, biàn yī tíng qī lěng.\n zhù tīng hán shēng, yún shēn wú yàn yǐng.\n gēng shēn rén qù jì jìng, dàn zhào bì, gū dēng xiāng yìng.\n jiǔ yǐ dōu xǐng, rú hé xiāo yè yǒng?'
    },
    {
      id: 78,
      title: '绮寮怨·上马人扶残醉',
      author: '周邦彦',
      content: '上马人扶残醉，晓风吹未醒。\n映水曲、翠瓦朱檐，垂杨里、乍见津亭。\n当时曾题败壁，蛛丝罩、淡墨苔晕青。\n念去来、岁月如流，徘徊久、叹息愁思盈。\n去去倦寻路程。\n江陵旧事，何曾再问杨琼。\n旧曲凄清，敛愁黛、与谁听。\n尊前故人如在，想念我、最关情。\n何须渭城，歌声未尽处，先泪零。',
      pinyin: 'shàng mǎ rén fú cán zuì, xiǎo fēng chuī wèi xǐng.\n yìng shuǐ qū, cuì wǎ zhū yán, chuí yáng lǐ, zhà jiàn jīn tíng.\n dāng shí céng tí bài bì, zhū sī zhào, dàn mò tái yūn qīng.\n niàn qù lái, suì yuè rú liú, pái huái jiǔ, tàn xī chóu sī yíng.\n qù qù juàn xún lù chéng.\n jiāng líng jiù shì, hé céng zài wèn yáng qióng.\n jiù qǔ qī qīng, liǎn chóu dài, yǔ shuí tīng.\n zūn qián gù rén rú zài, xiǎng niàn wǒ, zuì guān qíng.\n hé xū wèi chéng, gē shēng wèi jìn chù, xiān lèi líng.'
    },
    {
      id: 79,
      title: '尉迟杯·隋堤路',
      author: '周邦彦',
      content: '隋堤路，渐日晚、密霭生烟树。\n阴阴淡月笼沙，还宿河桥深处。\n无情画舸，都不管、烟波隔前浦。\n等行人、醉拥重衾，载将离恨归去。\n因思旧事，殆救人、轻负约。\n想如今、翠拥红围，应解愁时凝伫。\n念行客，邮亭深处，问春在、花梢柳缕。\n为谁颦、双眉长皱，又恐轻抛掷。\n但凝望、楼阁层层，有佳人、凭栏无语。',
      pinyin: 'suí dī lù, jiàn rì wǎn, mì ǎi shēng yān shù.\n yīn yīn dàn yuè lóng shā, hái sù hé qiáo shēn chù.\n wú qíng huà gě, dōu bù guǎn, yān bō gé qián pǔ.\n děng xíng rén, zuì yōng chóng qīn, zài jiāng lí hèn guī qù.\n yīn sī jiù shì, dài jiù rén, qīng fù yuē.\n xiǎng rú jīn, cuì yōng hóng wéi, yīng jiě chóu shí níng zhù.\n niàn xíng kè, yóu tíng shēn chù, wèn chūn zài, huā shāo liǔ lǚ.\n wèi shuí pín, shuāng méi cháng zhòu, yòu kǒng qīng pāo zhì.\n dàn níng wàng, lóu gé céng céng, yǒu jiā rén, píng lán wú yǔ.'
    },
    {
      id: 80,
      title: '西河·佳丽地',
      author: '周邦彦',
      content: '佳丽地，南朝盛事谁记。\n山围故国绕清江，髻鬟对起。\n怒涛寂寞打孤城，风樯遥度。\n天际归舟，何时重到，叹商女、不知兴废。\n至今商女，时时犹唱，后庭遗曲。\n念往昔、繁华竞逐，叹门外楼头，悲恨相续。\n千古凭高，对此漫嗟荣辱。\n六朝旧事随流水，但寒烟衰草凝绿。\n至今商女，时时犹唱，后庭遗曲。',
      pinyin: 'jiā lì dì, nán cháo shèng shì shuí jì.\n shān wéi gù guó rào qīng jiāng, jì huán duì qǐ.\n nù tāo jì mò dǎ gū chéng, fēng qiáng yáo dù.\n tiān jì guī zhōu, hé shí chóng dào, tàn shāng nǚ, bù zhī xīng fèi.\n zhì jīn shāng nǚ, shí shí yóu chàng, hòu tíng yí qū.\n niàn wǎng xī, fán huá jìng zhú, tàn mén wài lóu tóu, bēi hèn xiāng xù.\n qiān gǔ píng gāo, duì cǐ màn jiē róng rǔ.\n liù cháo jiù shì suí liú shuǐ, dàn hán yān shuāi cǎo níng lǜ.\n zhì jīn shāng nǚ, shí shí yóu chàng, hòu tíng yí qū.'
    },
    {
      id: 81,
      title: '忆江南·江南忆',
      author: '白居易',
      content: '江南忆，最忆是杭州。\n山寺月中寻桂子，郡亭枕上看潮头。\n何日更重游？',
      pinyin: 'jiāng nán yì, zuì yì shì háng zhōu.\n shān sì yuè zhōng xún guì zǐ, jùn tíng zhěn shàng kàn cháo tóu.\n hé rì gèng chóng yóu?'
    },
    {
      id: 82,
      title: '长相思·汴水流',
      author: '白居易',
      content: '汴水流，泗水流。\n流到瓜洲古渡头，吴山点点愁。\n思悠悠，恨悠悠。\n恨到归时方始休，月明人倚楼。',
      pinyin: 'biàn shuǐ liú, sì shuǐ liú.\n liú dào guā zhōu gǔ dù tóu, wú shān diǎn diǎn chóu.\n sī yōu yōu, hèn yōu yōu.\n hèn dào guī shí fāng shǐ xiū, yuè míng rén yǐ lóu.'
    },
    {
      id: 83,
      title: '菩萨蛮·小山重叠金明灭',
      author: '温庭筠',
      content: '小山重叠金明灭，鬓云欲度香腮雪。\n懒起画蛾眉，弄妆梳洗迟。\n照花前后镜，花面交相映。\n新帖绣罗襦，双双金鹧鸪。',
      pinyin: 'xiǎo shān chóng dié jīn míng miè, bìn yún yù dù xiāng sāi xuě.\n lǎn qǐ huà é méi, nòng zhuāng shū xǐ chí.\n zhào huā qián hòu jìng, huā miàn jiāo xiāng yìng.\n xīn tiē xiù luó rú, shuāng shuāng jīn zhè gū.'
    },
    {
      id: 84,
      title: '更漏子·柳丝长',
      author: '温庭筠',
      content: '柳丝长，春雨细，花外漏声迢递。\n惊塞雁，起城乌，画屏金鹧鸪。\n香雾薄，透帘幕，惆怅谢家池阁。\n红烛背，绣帘垂，梦长君不知。',
      pinyin: 'liǔ sī cháng, chūn yǔ xì, huā wài lòu shēng tiáo dì.\n jīng sài yàn, qǐ chéng wū, huà píng jīn zhè gū.\n xiāng wù bó, tòu lián mù, chóu chàng xiè jiā chí gé.\n hóng zhú bèi, xiù lián chuí, mèng cháng jūn bù zhī.'
    },
    {
      id: 85,
      title: '梦江南·千万恨',
      author: '温庭筠',
      content: '千万恨，恨极在天涯。\n山月不知心里事，水风空落眼前花。\n摇曳碧云斜。',
      pinyin: 'qiān wàn hèn, hèn jí zài tiān yá.\n shān yuè bù zhī xīn lǐ shì, shuǐ fēng kōng luò yǎn qián huā.\n yáo yè bì yún xié.'
    },
    {
      id: 86,
      title: '望江南·梳洗罢',
      author: '温庭筠',
      content: '梳洗罢，独倚望江楼。\n过尽千帆皆不是，斜晖脉脉水悠悠。\n肠断白蘋洲。',
      pinyin: 'shū xǐ bà, dú yǐ wàng jiāng lóu.\n guò jìn qiān fān jiē bú shì, xié huī mò mò shuǐ yōu yōu.\n cháng duàn bái pín zhōu.'
    },
    {
      id: 87,
      title: '菩萨蛮·人人尽说江南好',
      author: '韦庄',
      content: '人人尽说江南好，游人只合江南老。\n春水碧于天，画船听雨眠。\n垆边人似月，皓腕凝霜雪。\n未老莫还乡，还乡须断肠。',
      pinyin: 'rén rén jìn shuō jiāng nán hǎo, yóu rén zhǐ hé jiāng nán lǎo.\n chūn shuǐ bì yú tiān, huà chuán tīng yǔ mián.\n lú biān rén sì yuè, hào wàn níng shuāng xuě.\n wèi lǎo mò huán xiāng, huán xiāng xū duàn cháng.'
    },
    {
      id: 88,
      title: '女冠子·四月十七',
      author: '韦庄',
      content: '四月十七，正是去年今日。\n别君时，忍泪佯低面，含羞半敛眉。\n不知魂已断，空有梦相随。\n除却天边月，没人知。',
      pinyin: 'sì yuè shí qī, zhèng shì qù nián jīn rì.\n bié jūn shí, rěn lèi yáng dī miàn, hán xiū bàn liǎn méi.\n bù zhī hún yǐ duàn, kōng yǒu mèng xiāng suí.\n chú què tiān biān yuè, méi rén zhī.'
    },
    {
      id: 89,
      title: '思帝乡·春日游',
      author: '韦庄',
      content: '春日游，杏花吹满头。\n陌上谁家年少，足风流。\n妾拟将身嫁与，一生休。\n纵被无情弃，不能羞。',
      pinyin: 'chūn rì yóu, xìng huā chuī mǎn tóu.\n mò shàng shuí jiā nián shào, zú fēng liú.\n qiè nǐ jiāng shēn jià yǔ, yī shēng xiū.\n zòng bèi wú qíng qì, bù néng xiū.'
    },
    {
      id: 90,
      title: '谒金门·空相忆',
      author: '韦庄',
      content: '空相忆，无计得传消息。\n天上嫦娥人不识，寄书何处觅。\n新睡觉来无力，不忍看伊书迹。\n满院落花春寂寂，断肠芳草碧。',
      pinyin: 'kōng xiāng yì, wú jì dé chuán xiāo xī.\n tiān shàng cháng é rén bù shí, jì shū hé chù mì.\n xīn shuì jué lái wú lì, bù rěn kàn yī shū jì.\n mǎn yuàn luò huā chūn jì jì, duàn cháng fāng cǎo bì.'
    },
    {
      id: 91,
      title: '清平乐·别来春半',
      author: '李煜',
      content: '别来春半，触目愁肠断。\n砌下落梅如雪乱，拂了一身还满。\n雁来音信无凭，路遥归梦难成。\n离恨恰如春草，更行更远还生。',
      pinyin: 'bié lái chūn bàn, chù mù chóu cháng duàn.\n qì xià luò méi rú xuě luàn, fú le yī shēn hái mǎn.\n yàn lái yīn xìn wú píng, lù yáo guī mèng nán chéng.\n lí hèn qià rú chūn cǎo, gèng xíng gèng yuǎn hái shēng.'
    },
    {
      id: 92,
      title: '采桑子·群芳过后西湖好',
      author: '欧阳修',
      content: '群芳过后西湖好，狼藉残红。\n飞絮濛濛，垂柳阑干尽日风。\n笙歌散尽游人去，始觉春空。\n垂下帘栊，双燕归来细雨中。',
      pinyin: 'qún fāng guò hòu xī hú hǎo, láng jì cán hóng.\n fēi xù méng méng, chuí liǔ lán gān jìn rì fēng.\n shēng gē sàn jìn yóu rén qù, shǐ jué chūn kōng.\n chuí xià lián lóng, shuāng yàn guī lái xì yǔ zhōng.'
    },
    {
      id: 93,
      title: '踏莎行·候馆梅残',
      author: '欧阳修',
      content: '候馆梅残，溪桥柳细。\n草薰风暖摇征辔。\n离愁渐远渐无穷，迢迢不断如春水。\n寸寸柔肠，盈盈粉泪。\n楼高莫近危阑倚。\n平芜尽处是春山，行人更在春山外。',
      pinyin: 'hòu guǎn méi cán, xī qiáo liǔ xì.\n cǎo xūn fēng nuǎn yáo zhēng pèi.\n lí chóu jiàn yuǎn jiàn wú qióng, tiáo tiáo bú duàn rú chūn shuǐ.\n cùn cùn róu cháng, yíng yíng fěn lèi.\n lóu gāo mò jìn wēi lán yǐ.\n píng wú jìn chù shì chūn shān, xíng rén gèng zài chūn shān wài.'
    },
    {
      id: 94,
      title: '蝶恋花·庭院深深深几许',
      author: '欧阳修',
      content: '庭院深深深几许？杨柳堆烟，帘幕无重数。\n玉勒雕鞍游冶处，楼高不见章台路。\n雨横风狂三月暮，门掩黄昏，无计留春住。\n泪眼问花花不语，乱红飞过秋千去。',
      pinyin: 'tíng yuàn shēn shēn shēn jǐ xǔ? yáng liǔ duī yān, lián mù wú chóng shù.\n yù lè diāo ān yóu yě chù, lóu gāo bú jiàn zhāng tái lù.\n yǔ héng fēng kuáng sān yuè mù, mén yǎn huáng hūn, wú jì liú chūn zhù.\n lèi yǎn wèn huā huā bù yǔ, luàn hóng fēi guò qiū qiān qù.'
    },
    {
      id: 95,
      title: '浪淘沙·把酒祝东风',
      author: '欧阳修',
      content: '把酒祝东风，且共从容。\n垂杨紫陌洛城东。\n总是当时携手处，游遍芳丛。\n聚散苦匆匆，此恨无穷。\n今年花胜去年红。\n可惜明年花更好，知与谁同？',
      pinyin: 'bǎ jiǔ zhù dōng fēng, qiě gòng cóng róng.\n chuí yáng zǐ mò luò chéng dōng.\n zǒng shì dāng shí xié shǒu chù, yóu biàn fāng cóng.\n jù sàn kǔ cōng cōng, cǐ hèn wú qióng.\n jīn nián huā shèng qù nián hóng.\n kě xī míng nián huā gèng hǎo, zhī yǔ shuí tóng?'
    },
    {
      id: 96,
      title: '青玉案·一年春事都来几',
      author: '欧阳修',
      content: '一年春事都来几，早过了、三之二。\n绿暗红嫣浑可事。\n垂杨庭院，暖风帘幕，有个人憔悴。\n买花载酒长安市，又争似、家山见桃李。\n不枉东风吹客泪。\n相思难表，梦魂无据，惟有归来是。',
      pinyin: 'yī nián chūn shì dōu lái jǐ, zǎo guò le, sān zhī èr.\n lǜ àn hóng yān hún kě shì.\n chuí yáng tíng yuàn, nuǎn fēng lián mù, yǒu gè rén qiáo cuì.\n mǎi huā zài jiǔ cháng ān shì, yòu zhēng sì, jiā shān jiàn táo lǐ.\n bù wǎng dōng fēng chuī kè lèi.\n xiāng sī nán biǎo, mèng hún wú jù, wéi yǒu guī lái shì.'
    },
    {
      id: 97,
      title: '临江仙·梦后楼台高锁',
      author: '晏几道',
      content: '梦后楼台高锁，酒醒帘幕低垂。\n去年春恨却来时。\n落花人独立，微雨燕双飞。\n记得小苹初见，两重心字罗衣。\n琵琶弦上说相思。\n当时明月在，曾照彩云归。',
      pinyin: 'mèng hòu lóu tái gāo suǒ, jiǔ xǐng lián mù dī chuí.\n qù nián chūn hèn què lái shí.\n luò huā rén dú lì, wēi yǔ yàn shuāng fēi.\n jì dé xiǎo píng chū jiàn, liǎng chóng xīn zì luó yī.\n pí pá xián shàng shuō xiāng sī.\n dāng shí míng yuè zài, céng zhào cǎi yún guī.'
    },
    {
      id: 98,
      title: '鹧鸪天·彩袖殷勤捧玉钟',
      author: '晏几道',
      content: '彩袖殷勤捧玉钟，当年拚却醉颜红。\n舞低杨柳楼心月，歌尽桃花扇底风。\n从别后，忆相逢，几回魂梦与君同。\n今宵剩把银釭照，犹恐相逢是梦中。',
      pinyin: 'cǎi xiù yīn qín pěng yù zhōng, dāng nián pàn què zuì yán hóng.\n wǔ dī yáng liǔ lóu xīn yuè, gē jìn táo huā shàn dǐ fēng.\n cóng bié hòu, yì xiāng féng, jǐ huí hún mèng yǔ jūn tóng.\n jīn xiāo shèng bǎ yín gāng zhào, yóu kǒng xiāng féng shì mèng zhōng.'
    },
    {
      id: 99,
      title: '阮郎归·天边金掌露成霜',
      author: '晏几道',
      content: '天边金掌露成霜，云随雁字长。\n绿杯红袖趁重阳，人情似故乡。\n兰佩紫，菊簪黄，殷勤理旧狂。\n欲将沉醉换悲凉，清歌莫断肠。',
      pinyin: 'tiān biān jīn zhǎng lù chéng shuāng, yún suí yàn zì cháng.\n lǜ bēi hóng xiù chèn chóng yáng, rén qíng sì gù xiāng.\n lán pèi zǐ, jú zān huáng, yīn qín lǐ jiù kuáng.\n yù jiāng chén zuì huàn bēi liáng, qīng gē mò duàn cháng.'
    },
    {
      id: 100,
      title: '思远人·红叶黄花秋意晚',
      author: '晏几道',
      content: '红叶黄花秋意晚，千里念行客。\n看飞云过尽，归鸿无信，何处寄书得。\n泪弹不尽临窗滴，就砚旋研墨。\n渐写到别来，此情深处，红笺为无色。',
      pinyin: 'hóng yè huáng huā qiū yì wǎn, qiān lǐ niàn xíng kè.\n kàn fēi yún guò jìn, guī hóng wú xìn, hé chù jì shū dé.\n lèi tán bù jìn lín chuāng dī, jiù yàn xuán yán mò.\n jiàn xiě dào bié lái, cǐ qíng shēn chù, hóng jiān wèi wú sè.'
    },
    {
      id: 101,
      title: '水调歌头·游览',
      author: '黄庭坚',
      content: '瑶草一何碧，春入武陵溪。\n溪上桃花无数，枝上有黄鹂。\n我欲穿花寻路，直入白云深处，浩气展虹霓。\n只恐花深里，红露湿人衣。\n坐玉石，倚玉枕，拂金徽。\n谪仙何处？无人伴我白螺杯。\n我为灵芝仙草，不为朱唇丹脸，长啸亦何为？\n水调歌头·游览\n瑶草一何碧，春入武陵溪。\n溪上桃花无数，枝上有黄鹂。\n我欲穿花寻路，直入白云深处，浩气展虹霓。\n只恐花深里，红露湿人衣。',
      pinyin: 'yáo cǎo yī hé bì, chūn rù wǔ líng xī.\n xī shàng táo huā wú shù, zhī shàng yǒu huáng lí.\n wǒ yù chuān huā xún lù, zhí rù bái yún shēn chù, hào qì zhǎn hóng ní.\n zhǐ kǒng huā shēn lǐ, hóng lù shī rén yī.\n zuò yù shí, yǐ yù zhěn, fú jīn huī.\n zhé xiān hé chù? wú rén bàn wǒ bái luó bēi.\n wǒ wèi líng zhī xiān cǎo, bù wèi zhū chún dān liǎn, cháng xiào yì hé wéi?'
    },
    {
      id: 102,
      title: '念奴娇·断虹霁雨',
      author: '黄庭坚',
      content: '断虹霁雨，净秋空，山染修眉新绿。\n桂影扶疏，谁便道，今夕清辉不足。\n万里青天，姮娥何处，驾此一轮玉。\n寒露零落，天涯归思，为谁凄楚。\n忆年少，京华追游，正欢娱、朝暮相续。\n别后经年，把酒凄凉，念此身、飘转如逐。\n欲寄相思，知何处，暮云平楚。\n独立小桥，满川烟树，伴人愁绪。\n归去来兮，吾归何处，此身安属。\n明朝有酒，有酒，有酒，且共君同醉。',
      pinyin: 'duàn hóng jì yǔ, jìng qiū kōng, shān rǎn xiū méi xīn lǜ.\n guì yǐng fú shū, shuí biàn dào, jīn xī qīng huī bù zú.\n wàn lǐ qīng tiān, héng é hé chù, jià cǐ yī lún yù.\n hán lù líng luò, tiān yá guī sī, wèi shuí qī chǔ.\n yì nián shào, jīng huá zhuī yóu, zhèng huān yú, zhāo mù xiāng xù.\n bié hòu jīng nián, bǎ jiǔ qī liáng, niàn cǐ shēn, piāo zhuǎn rú zhú.\n yù jì xiāng sī, zhī hé chù, mù yún píng chǔ.\n dú lì xiǎo qiáo, mǎn chuān yān shù, bàn rén chóu xù.\n guī qù lái xī, wú guī hé chù, cǐ shēn ān shǔ.\n míng cháo yǒu jiǔ, yǒu jiǔ, yǒu jiǔ, qiě gòng jūn tóng zuì.'
    },
    {
      id: 103,
      title: '踏莎行·杨柳回塘',
      author: '贺铸',
      content: '杨柳回塘，鸳鸯别浦。\n绿萍涨断莲舟路。\n断无蜂蝶慕幽香，红衣脱尽芳心苦。\n返照迎潮，行云带雨。\n依依似与骚人语。\n当年不肯嫁春风，无端却被秋风误。',
      pinyin: 'yáng liǔ huí táng, yuān yāng bié pǔ.\n lǜ píng zhǎng duàn lián zhōu lù.\n duàn wú fēng dié mù yōu xiāng, hóng yī tuō jìn fāng xīn kǔ.\n fǎn zhào yíng cháo, xíng yún dài yǔ.\n yī yī sì yǔ sāo rén yǔ.\n dāng nián bù kěn jià chūn fēng, wú duān què bèi qiū fēng wù.'
    },
    {
      id: 104,
      title: '青玉案·凌波不过横塘路',
      author: '贺铸',
      content: '凌波不过横塘路，但目送、芳尘去。\n锦瑟年华谁与度？\n月桥花院，琐窗朱户，只有春知处。\n飞云冉冉蘅皋暮，彩笔新题断肠句。\n试问闲情都几许？\n一川烟草，满城风絮，梅子黄时雨。',
      pinyin: 'líng bō bú guò héng táng lù, dàn mù sòng, fāng chén qù.\n jǐn sè nián huá shuí yǔ dù?\n yuè qiáo huā yuàn, suǒ chuāng zhū hù, zhǐ yǒu chūn zhī chù.\n fēi yún rǎn rǎn héng gāo mù, cǎi bǐ xīn tí duàn cháng jù.\n shì wèn xián qíng dōu jǐ xǔ?\n yī chuān yān cǎo, mǎn chéng fēng xù, méi zǐ huáng shí yǔ.'
    },
    {
      id: 105,
      title: '鹧鸪天·半死桐',
      author: '贺铸',
      content: '重过阊门万事非，同来何事不同归？\n梧桐半死清霜后，头白鸳鸯失伴飞。\n原上草，露初晞。\n旧栖新垅两依依。\n空床卧听南窗雨，谁复挑灯夜补衣？',
      pinyin: 'chóng guò chāng mén wàn shì fēi, tóng lái hé shì bù tóng guī?\n wú tóng bàn sǐ qīng shuāng hòu, tóu bái yuān yāng shī bàn fēi.\n yuán shàng cǎo, lù chū xī.\n jiù qī xīn lǒng liǎng yī yī.\n kōng chuáng wò tīng nán chuāng yǔ, shuí fù tiǎo dēng yè bǔ yī?'
    },
    {
      id: 106,
      title: '点绛唇·蹴罢秋千',
      author: '李清照',
      content: '蹴罢秋千，起来慵整纤纤手。\n露浓花瘦，薄汗轻衣透。\n见客入来，袜刬金钗溜。\n和羞走，倚门回首，却把青梅嗅。',
      pinyin: 'cù bà qiū qiān, qǐ lái yōng zhěng xiān xiān shǒu.\n lù nóng huā shòu, báo hàn qīng yī tòu.\n jiàn kè rù lái, wà chǎn jīn chāi liū.\n hé xiū zǒu, yǐ mén huí shǒu, què bǎ qīng méi xiù.'
    },
    {
      id: 107,
      title: '一剪梅·红藕香残玉簟秋',
      author: '李清照',
      content: '红藕香残玉簟秋。轻解罗裳，独上兰舟。\n云中谁寄锦书来？雁字回时，月满西楼。\n花自飘零水自流。一种相思，两处闲愁。\n此情无计可消除，才下眉头，却上心头。',
      pinyin: 'hóng ǒu xiāng cán yù diàn qiū. qīng jiě luó cháng, dú shàng lán zhōu.\n yún zhōng shuí jì jǐn shū lái? yàn zì huí shí, yuè mǎn xī lóu.\n huā zì piāo líng shuǐ zì liú. yī zhǒng xiāng sī, liǎng chù xián chóu.\n cǐ qíng wú jì kě xiāo chú, cái xià méi tóu, què shàng xīn tóu.'
    },
    {
      id: 108,
      title: '醉花阴·薄雾浓云愁永昼',
      author: '李清照',
      content: '薄雾浓云愁永昼，瑞脑消金兽。\n佳节又重阳，玉枕纱厨，半夜凉初透。\n东篱把酒黄昏后，有暗香盈袖。\n莫道不销魂，帘卷西风，人比黄花瘦。',
      pinyin: 'bó wù nóng yún chóu yǒng zhòu, ruì nǎo xiāo jīn shòu.\n jiā jié yòu chóng yáng, yù zhěn shā chú, bàn yè liáng chū tòu.\n dōng lí bǎ jiǔ huáng hūn hòu, yǒu àn xiāng yíng xiù.\n mò dào bù xiāo hún, lián juǎn xī fēng, rén bǐ huáng huā shòu.'
    },
    {
      id: 109,
      title: '武陵春·风住尘香花已尽',
      author: '李清照',
      content: '风住尘香花已尽，日晚倦梳头。\n物是人非事事休，欲语泪先流。\n闻说双溪春尚好，也拟泛轻舟。\n只恐双溪舴艋舟，载不动许多愁。',
      pinyin: 'fēng zhù chén xiāng huā yǐ jìn, rì wǎn juàn shū tóu.\n wù shì rén fēi shì shì xiū, yù yǔ lèi xiān liú.\n wén shuō shuāng xī chūn shàng hǎo, yě nǐ fàn qīng zhōu.\n zhǐ kǒng shuāng xī zé měng zhōu, zài bú dòng xǔ duō chóu.'
    }


  ];
  @State isPageLoaded: boolean = false; // 页面加载状态
  @State isPlaying: boolean = false;
  @State readState: ReadStateCode = ReadStateCode.WAITING; // 朗读状态
  private isInit: boolean = false; // TextReader是否已初始化
  
  // 搜索相关状态
  @State searchText: string = '';
  @State isSearchMode: boolean = false;
  @State filteredSongs: Array<Song> = [];

  aboutToAppear(): void {
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 50);

    // 初始化TextReader
    this.initTextReader();

    // 重置播放状态
    this.isPlaying = false;
    
    // 初始化搜索相关数据
    this.filteredSongs = [];
  }

  aboutToDisappear(): void {
    // 页面销毁时停止朗读并释放资源
    try {
      // 无论是否正在播放，都尝试停止TextReader
      TextReader.stop();

      // 释放TextReader资源
      TextReader.release().then(() => {
        console.log('TextReader资源释放成功');
      }).catch((error: Error) => {
        console.error('TextReader资源释放失败:', error);
      });

      // 重置状态
      this.isPlaying = false;
      this.isInit = false;
    } catch (error) {
      console.error('停止朗读失败:', error);
    }
  }

  // 搜索功能
  private onSearchChange(value: string): void {
    this.searchText = value;
    if (value.trim() === '') {
      this.isSearchMode = false;
      this.filteredSongs = [];
    } else {
      this.isSearchMode = true;
      this.performSearch();
    }
  }

  // 执行搜索
  private performSearch(): void {
    const searchTerm = this.searchText.toLowerCase().trim();
    if (searchTerm === '') {
      this.filteredSongs = [];
      return;
    }

    this.filteredSongs = this.songs.filter(song => {
      return song.title.toLowerCase().includes(searchTerm) ||
             song.author.toLowerCase().includes(searchTerm) ||
             song.content.toLowerCase().includes(searchTerm);
    });
  }

  // 清空搜索
  private clearSearch(): void {
    this.searchText = '';
    this.isSearchMode = false;
    this.filteredSongs = [];
  }

  // 初始化TextReader
  private async initTextReader(): Promise<void> {
    try {
      // 创建朗读参数
      const businessBrandInfo: TextReader.BusinessBrandInfo = {
        panelName: '小艺朗读'
      } as TextReader.BusinessBrandInfo;

      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: true
      } as TextReader.ReaderParam;

      // 初始化TextReader
      await TextReader.init(getContext(this), readerParam);
      this.isInit = true;

      // 监听朗读状态变化
      TextReader.on('stateChange', (state: TextReader.ReadState) => {
        if (state.state === ReadStateCode.PLAYING) {
          this.isPlaying = true;
        } else if (state.state === ReadStateCode.PAUSED ||
          state.state === ReadStateCode.WAITING ||
          state.state === ReadStateCode.COMPLETED) {
          this.isPlaying = false;
        }
        this.readState = state.state;
      });
    } catch (error) {
      console.error('TextReader初始化失败:', error);
      this.isInit = false; // 确保初始化失败时标志位为false
    }
  }

  // 切换朗读状态
  private async togglePlay(): Promise<void> {
    try {
      // 如果初始化未完成，等待初始化完成
      if (!this.isInit) {
        promptAction.showToast({ message: '朗读功能初始化中，请稍后再试' });

        // 尝试重新初始化
        await this.initTextReader();

        // 如果重新初始化后仍然失败，提示用户
        if (!this.isInit) {
          promptAction.showToast({ message: '朗读功能初始化失败，请稍后重试' });
          return;
        }
      }

      if (this.isPlaying) {
        TextReader.pause();
      } else {
        // 如果没有在朗读，开始朗读所有宋词标题
        const readInfoList: TextReader.ReadInfo[] = this.songs.map((song) => {
          const readInfo: TextReader.ReadInfo = {
            id: `song_list_${song.id}`,
            title: {
              text: song.title,
              isClickable: false
            },
            bodyInfo: `${song.title}，作者：${song.author}。${song.content}`
          };

          return readInfo;
        });

        // 启动TextReader并进入朗读页面
        TextReader.start(readInfoList, readInfoList[0].id).then(() => {
          console.log('开始朗读宋词列表');
          TextReader.showPanel();
        }).catch((error: Error) => {
          console.error('朗读失败:', error);
          promptAction.showToast({ message: '朗读失败: ' + error.message });
        });
      }
    } catch (error) {
      const e: Error = error as Error;
      console.error('切换朗读状态时发生错误:', e);
      promptAction.showToast({ message: '操作失败' });
    }
  }

  // 定义不同ID对应的背景颜色
  private getBackgroundColor(id: number): ResourceColor {
    // 创建颜色映射对象
    const colorMap: Map<string, string> = new Map<string, string>([
      ["1", '#FFF3E0'], // 橙色系
      ["2", '#E3F2FD'], // 蓝色系
      ["3", '#F1F8E9'], // 浅绿色系
      ["4", '#F3E5F5'], // 粉色系
      ["5", '#E0F2F1'], // 青色系
      ["6", '#FFECB3'], // 黄色系
      ["7", '#FFCCBC'], // 红色系
      ["8", '#E8EAF6'], // 蓝紫色系
      ["9", '#E1BEE7'], // 紫色系
      ["10", '#FFCCDD'], // 粉红色系
      ["11", '#E0F7FA'], // 青蓝色系
      ["12", '#F9FBE7'], // 柠檬绿系
      ["13", '#EFEBE9'], // 棕色系
      ["14", '#E8F5E9'], // 薄荷绿系
      ["15", '#FFF8E1'], // 浅黄系
      ["16", '#E0E0E0'], // 灰色系
      ["17", '#FCE4EC'], // 粉紫系
      ["18", '#E0F2F1'], // 青绿系
      ["19", '#E3F2FD'], // 淡蓝系
      ["20", '#F1F8E9']// 淡绿系
    ]);

    // 循环使用颜色
    const colorKeys = Array.from(colorMap.keys());
    const colorIndex = (id - 1) % colorKeys.length;
    const key = colorKeys[colorIndex];

    return colorMap.get(key) || $r('app.color.card_background');
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        // 返回按钮
        Button() {
          Row() {
            Text('←')
              .fontSize(20)
              .fontColor($r('app.color.primary_brand'))
            Text('返回')
              .fontSize(16)
              .fontColor($r('app.color.primary_brand'))
              .fontWeight(FontWeight.Medium)
          }
          .alignItems(VerticalAlign.Center)
        }
        .onClick(() => {
          router.back();
        })
        .type(ButtonType.Normal)
        .borderRadius(20)
        .width(90)
        .height(40)
        .backgroundColor($r('app.color.card_background'))
        .shadow({
          radius: 8,
          color: $r('app.color.primary_brand_light'),
          offsetX: 0,
          offsetY: 2
        })

        // 页面标题
        Text('宋词精选')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))
          .textShadow({
            radius: 2,
            color: $r('app.color.text_tertiary'),
            offsetX: 0,
            offsetY: 1
          })

        // 朗读按钮
        Button() {
          Row() {
            Text(this.isPlaying ? '❚❚' : '▶')
              .fontSize(16)
              .fontColor('#FFFFFF')
            Text(this.isPlaying ? '暂停' : '朗读')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Medium)
          }
          .alignItems(VerticalAlign.Center)
        }
        .onClick(() => {
          this.togglePlay();
        })
        .type(ButtonType.Normal)
        .borderRadius(20)
        .width(90)
        .height(40)
        .backgroundColor(this.isPlaying ? $r('app.color.accent_negative') : $r('app.color.primary_brand'))
        .shadow({
          radius: 8,
          color: this.isPlaying ? $r('app.color.accent_negative') : $r('app.color.primary_brand'),
          offsetX: 0,
          offsetY: 2
        })
      }
      .height(70)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 20, right: 20 })
      .backgroundColor($r('app.color.card_background'))
      .shadow({
        radius: 12,
        color: $r('app.color.text_tertiary'),
        offsetX: 0,
        offsetY: 4
      })

      // 页面副标题
      Text('婉约豪放，词韵悠长 - 探索宋代文学瑰宝')
        .fontSize(16)
        .fontColor($r('app.color.text_secondary'))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center)
        .margin({ top: 20, bottom: 20 })
        .opacity(this.isPageLoaded ? 1 : 0)
        .animation({ duration: 600, delay: 200 })

      // 搜索框
      Row() {
        // 搜索图标
        Text('🔍')
          .fontSize(18)
          .margin({ left: 15, right: 10 })
          .fontColor($r('app.color.text_secondary'))

        // 搜索输入框
        TextInput({ placeholder: '搜索宋词标题、作者或内容...' })
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .borderWidth(0)
          .layoutWeight(1)
          .placeholderColor($r('app.color.text_tertiary'))
          .onChange((value: string) => {
            this.onSearchChange(value);
          })

        // 清空按钮
        if (this.searchText.length > 0) {
          Button('✕')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .backgroundColor(Color.Transparent)
            .width(30)
            .height(30)
            .margin({ right: 10 })
            .onClick(() => {
              this.clearSearch();
            })
        }
      }
      .width('90%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .borderRadius(25)
      .margin({ bottom: 20 })
      .shadow({
        radius: 8,
        color: $r('app.color.text_tertiary_bank_card_03'),
        offsetX: 0,
        offsetY: 2
      })
      .opacity(this.isPageLoaded ? 1 : 0)
      .animation({ duration: 600, delay: 300 })

      // 搜索结果统计
      if (this.isSearchMode) {
        Text(`找到 ${this.filteredSongs.length} 首匹配的宋词`)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Center)
          .margin({ bottom: 15 })
          .opacity(this.isPageLoaded ? 1 : 0)
          .animation({ duration: 600, delay: 400 })
      }

      // 宋词卡片列表 - 现代化设计
      Scroll() {
        Column() {
          ForEach(this.isSearchMode ? this.filteredSongs : this.songs, (song: Song, index: number) => {
            // 现代化卡片设计
            Column() {
              // 卡片头部 - 渐变背景
              Row() {
                // 序号徽章
                Column() {
                  Text((index + 1).toString())
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                }
                .width(32)
                .height(32)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor($r('app.color.primary_brand'))
                .borderRadius(16)
                .shadow({
                  radius: 6,
                  color: $r('app.color.primary_brand_light'),
                  offsetX: 0,
                  offsetY: 3
                })

                // 标题和作者
                Column() {
                  Text(song.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text(`作者：${song.author}`)
                    .fontSize(14)
                    .fontColor($r('app.color.text_secondary'))
                    .fontWeight(FontWeight.Medium)
                }
                .layoutWeight(1)
                .margin({ left: 12 })
                .justifyContent(FlexAlign.Center)

                // 播放图标
                Text('→')
                  .fontSize(18)
                  .fontColor($r('app.color.text_tertiary'))
              }
              .width('100%')
              .height(80)
              .padding({ left: 20, right: 20 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(20)
              .shadow({
                radius: 15,
                color: $r('app.color.text_tertiary'),
                offsetX: 0,
                offsetY: 5
              })
              .onClick(() => {
                // 跳转到宋词详情页面前停止朗读
                try {
                  TextReader.stop();
                  this.isPlaying = false;
                } catch (error) {
                  console.error('停止朗读失败:', error);
                }

                // 跳转到宋词详情页面
                router.pushUrl({
                  url: 'pages/chinese/SongDetailPage',
                  params: {
                    song: JSON.stringify(song)
                  }
                });
              })
              .scale({
                x: this.isPageLoaded ? 1 : 0.9,
                y: this.isPageLoaded ? 1 : 0.9
              })
              .opacity(this.isPageLoaded ? 1 : 0)
              .animation({
                duration: 500,
                curve: Curve.EaseOut,
                delay: 100 + index * 80
              })
            }
            .margin({ bottom: 15, left: 20, right: 20 })
          }, (song: Song) => song.id.toString())

          // 搜索结果为空时的提示
          if (this.isSearchMode && this.filteredSongs.length === 0) {
            Column() {
              Text('🔍')
                .fontSize(48)
                .margin({ bottom: 20 })
                .opacity(0.6)

              Text('未找到匹配的宋词')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })

              Text('尝试使用不同的关键词搜索')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Center)
                .margin({ bottom: 20 })

              Button('重新搜索')
                .fontSize(14)
                .fontColor($r('app.color.primary_brand'))
                .backgroundColor(Color.Transparent)
                .border({
                  width: 1,
                  color: $r('app.color.primary_brand')
                })
                .borderRadius(20)
                .padding({ left: 20, right: 20, top: 8, bottom: 8 })
                .onClick(() => {
                  this.clearSearch();
                })
            }
            .width('100%')
            .padding({ top: 60, bottom: 60 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        }
        .padding({ top: 10, bottom: 30 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)

      // 底部统计信息
      Row() {
        Text(`共收录 ${this.songs.length} 首经典宋词`)
          .fontSize(14)
          .fontColor($r('app.color.text_tertiary'))
          .fontWeight(FontWeight.Medium)
      }
      .height(50)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.card_elevated'))
      .borderRadius({ topLeft: 20, topRight: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}