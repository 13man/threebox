import router from '@ohos.router';
import { common, ConfigurationConstant } from '@kit.AbilityKit';
import promptAction from '@ohos.promptAction';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import dataPreferences from '@ohos.data.preferences';

// 定义唐诗接口
interface Poem {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string;
  isFavorite?: boolean;
}




@Entry
@Component
export struct PoemsListPage {
  // 创建300首唐诗的列表

  @State private poems: Array<Poem> = [
  // 唐诗鉴赏列表 - 卷一：五言古诗

  // 唐诗鉴赏列表 - 卷一：五言古诗

    {
      id: 1,
      title: '将进酒',
      author: '李白',
      content: '君不见黄河之水天上来，奔流到海不复回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。\n人生得意须尽欢，莫使金樽空对月。\n天生我材必有用，千金散尽还复来。\n烹羊宰牛且为乐，会须一饮三百杯。\n岑夫子，丹丘生，将进酒，杯莫停。\n与君歌一曲，请君为我倾耳听。\n钟鼓馔玉不足贵，但愿长醉不复醒。\n古来圣贤皆寂寞，惟有饮者留其名。\n陈王昔时宴平乐，斗酒十千恣欢谑。\n主人何为言少钱，径须沽取对君酌。\n五花马，千金裘，呼儿将出换美酒，\n与尔同销万古愁。',
      pinyin: 'jūn bú jiàn huáng hé zhī shuǐ tiān shàng lái, bēn liú dào hǎi bú fù huí.\n jūn bú jiàn gāo táng míng jìng bēi bái fà, zhāo rú qīng sī mù chéng xuě.\n rén shēng dé yì xū jìn huān, mò shǐ jīn zūn kōng duì yuè.\n tiān shēng wǒ cái bì yǒu yòng, qiān jīn sàn jìn hái fù lái.\n pēng yáng zǎi niú qiě wéi lè, huì xū yī yǐn sān bǎi bēi.\n cén fū zǐ, dān qiū shēng, jiāng jìn jiǔ, bēi mò tíng.\n yǔ jūn gē yī qǔ, qǐng jūn wèi wǒ qīng ěr tīng.\n zhōng gǔ zhuàn yù bú zú guì, dàn yuàn cháng zuì bú fù xǐng.\n gǔ lái shèng xián jiē jì mò, wéi yǒu yǐn zhě liú qí míng.\n chén wáng xī shí yàn píng lè, dòu jiǔ shí qiān zì huān xuè.\n zhǔ rén hé wéi yán shǎo qián, jìng xū gū qǔ duì jūn zhuó.\n wǔ huā mǎ, qiān jīn qiú, hū ér jiāng chū huàn měi jiǔ,\n yǔ ěr tóng xiāo wàn gǔ chóu.'
    },
    {
      id: 2,
      title: '下终南山过斛斯山人宿置酒',
      author: '李白',
      content: '暮从碧山下，山月随人归。\n却顾所来径，苍苍横翠微。\n相携及田家，童稚开荆扉。\n绿竹入幽径，青萝拂行衣。\n欢言得所憩，美酒聊共挥。\n长歌吟松风，曲尽河星稀。\n我醉君复乐，陶然共忘机。',
      pinyin: 'mù cóng bì shān xià, shān yuè suí rén guī.\n què gù suǒ lái jìng, cāng cāng héng cuì wēi.\n xiāng xié jí tián jiā, tóng zhì kāi jīng fēi.\n lǜ zhú rù yōu jìng, qīng luó fú xíng yī.\n huān yán dé suǒ qì, měi jiǔ liáo gòng huī.\n cháng gē yín sōng fēng, qǔ jìn hé xīng xī.\n wǒ zuì jūn fù lè, táo rán gòng wàng jī.'
    },
    {
      id: 3,
      title: '月下独酌四首・其一',
      author: '李白',
      content: '花间一壶酒，独酌无相亲。\n举杯邀明月，对影成三人。\n月既不解饮，影徒随我身。\n暂伴月将影，行乐须及春。\n我歌月徘徊，我舞影零乱。\n醒时同交欢，醉后各分散。\n永结无情游，相期邈云汉。',
      pinyin: 'huā jiān yī hú jiǔ, dú zhuó wú xiāng qīn.\n jǔ bēi yāo míng yuè, duì yǐng chéng sān rén.\n yuè jì bù jiě yǐn, yǐng tú suí wǒ shēn.\n zàn bàn yuè jiāng yǐng, xíng lè xū jí chūn.\n wǒ gē yuè pái huái, wǒ wǔ yǐng líng luàn.\n xǐng shí tóng jiāo huān, zuì hòu gè fēn sàn.\n yǒng jié wú qíng yóu, xiāng qī miǎo yún hàn.'
    },
    {
      id: 4,
      title: '春思',
      author: '李白',
      content: '燕草如碧丝，秦桑低绿枝。\n当君怀归日，是妾断肠时。\n春风不相识，何事入罗帏？',
      pinyin: 'yàn cǎo rú bì sī, qín sāng dī lǜ zhī.\n dāng jūn huái guī rì, shì qiè duàn cháng shí.\n chūn fēng bú xiāng shí, hé shì rù luó wéi?'
    },
    {
      id: 5,
      title: '望岳',
      author: '杜甫',
      content: '岱宗夫如何？齐鲁青未了。\n造化钟神秀，阴阳割昏晓。\n荡胸生曾云，决眦入归鸟。\n会当凌绝顶，一览众山小。',
      pinyin: 'dài zōng fū rú hé? qí lǔ qīng wèi liǎo.\n zào huà zhōng shén xiù, yīn yáng gē hūn xiǎo.\n dàng xiōng shēng céng yún, jué zì rù guī niǎo.\n huì dāng líng jué dǐng, yī lǎn zhòng shān xiǎo.'
    },
    {
      id: 6,
      title: '赠卫八处士',
      author: '杜甫',
      content: '人生不相见，动如参与商。\n今夕复何夕，共此灯烛光。\n少壮能几时，鬓发各已苍。\n访旧半为鬼，惊呼热中肠。\n焉知二十载，重上君子堂。\n昔别君未婚，儿女忽成行。\n怡然敬父执，问我来何方。\n问答乃未已，驱儿罗酒浆。\n夜雨剪春韭，新炊间黄粱。\n主称会面难，一举累十觞。\n十觞亦不醉，感子故意长。\n明日隔山岳，世事两茫茫。',
      pinyin: 'rén shēng bú xiāng jiàn, dòng rú cān yǔ shāng.\n jīn xī fù hé xī, gòng cǐ dēng zhú guāng.\n shào zhuàng néng jǐ shí, bìn fà gè yǐ cāng.\n fǎng jiù bàn wéi guǐ, jīng hū rè zhōng cháng.\n yān zhī èr shí zǎi, chóng shàng jūn zǐ táng.\n xī bié jūn wèi hūn, ér nǚ hū chéng háng.\n yí rán jìng fù zhí, wèn wǒ lái hé fāng.\n wèn dá nǎi wèi yǐ, qū ér luó jiǔ jiāng.\n yè yǔ jiǎn chūn jiǔ, xīn chuī jiān huáng liáng.\n zhǔ chēng huì miàn nán, yī jǔ lěi shí shāng.\n shí shāng yì bú zuì, gǎn zǐ gù yì cháng.\n míng rì gé shān yuè, shì shì liǎng máng máng.'
    },
    {
      id: 7,
      title: '佳人',
      author: '杜甫',
      content: '绝代有佳人，幽居在空谷。\n自云良家子，零落依草木。\n关中昔丧乱，兄弟遭杀戮。\n官高何足论，不得收骨肉。\n世情恶衰歇，万事随转烛。\n夫婿轻薄儿，新人美如玉。\n合昏尚知时，鸳鸯不独宿。\n但见新人笑，那闻旧人哭？\n在山泉水清，出山泉水浊。\n侍婢卖珠回，牵萝补茅屋。\n摘花不插发，采柏动盈掬。\n天寒翠袖薄，日暮倚修竹。',
      pinyin: 'jué dài yǒu jiā rén, yōu jū zài kōng gǔ.\n zì yún liáng jiā zǐ, líng luò yī cǎo mù.\n guān zhōng xī sàng luàn, xiōng dì zāo shā lù.\n guān gāo hé zú lùn, bù dé shōu gǔ ròu.\n shì qíng è shuāi xiē, wàn shì suí zhuǎn zhú.\n fū xù qīng bó ér, xīn rén měi rú yù.\n hé hūn shàng zhī shí, yuān yāng bú dú sù.\n dàn jiàn xīn rén xiào, nà wén jiù rén kū?\n zài shān quán shuǐ qīng, chū shān quán shuǐ zhuó.\n shì bì mài zhū huí, qiān luó bǔ máo wū.\n zhāi huā bú chā fà, cǎi bǎi dòng yíng jū.\n tiān hán cuì xiù báo, rì mù yǐ xiū zhú.'
    },
    {
      id: 8,
      title: '梦李白二首・其一',
      author: '杜甫',
      content: '死别已吞声，生别常恻恻。\n江南瘴疠地，逐客无消息。\n故人入我梦，明我长相忆。\n恐非平生魂，路远不可测。\n魂来枫林青，魂返关塞黑。\n君今在罗网，何以有羽翼？\n落月满屋梁，犹疑照颜色。\n水深波浪阔，无使蛟龙得！',
      pinyin: 'sǐ bié yǐ tūn shēng, shēng bié cháng cè cè.\n jiāng nán zhàng lì dì, zhú kè wú xiāo xī.\n gù rén rù wǒ mèng, míng wǒ zhǎng xiāng yì.\n kǒng fēi píng shēng hún, lù yuǎn bú kě cè.\n hún lái fēng lín qīng, hún fǎn guān sài hēi.\n jūn jīn zài luó wǎng, hé yǐ yǒu yǔ yì?\n luò yuè mǎn wū liáng, yóu yí zhào yán sè.\n shuǐ shēn bō làng kuò, wú shǐ jiāo lóng dé!'
    },
    {
      id: 9,
      title: '梦李白二首・其二',
      author: '杜甫',
      content: '浮云终日行，游子久不至。\n三夜频梦君，情亲见君意。\n告归常局促，苦道来不易。\n江湖多风波，舟楫恐失坠。\n出门搔白首，若负平生志。\n冠盖满京华，斯人独憔悴。\n孰云网恢恢，将老身反累。\n千秋万岁名，寂寞身后事。',
      pinyin: 'fú yún zhōng rì xíng, yóu zǐ jiǔ bú zhì.\n sān yè pín mèng jūn, qíng qīn jiàn jūn yì.\n gào guī cháng jú cù, kǔ dào lái bú yì.\n jiāng hú duō fēng bō, zhōu jí kǒng shī zhuì.\n chū mén sāo bái shǒu, ruò fù píng shēng zhì.\n guān gài mǎn jīng huá, sī rén dú qiáo cuì.\n shú yún wǎng huī huī, jiāng lǎo shēn fǎn lěi.\n qiān qiū wàn suì míng, jì mò shēn hòu shì.'
    },
    {
      id: 10,
      title: '送綦毋潜落第还乡',
      author: '王维',
      content: '圣代无隐者，英灵尽来归。\n遂令东山客，不得顾采薇。\n既至金门远，孰云吾道非？\n江淮度寒食，京洛缝春衣。\n置酒长安道，同心与我违。\n行当浮桂棹，未几拂荆扉。\n远树带行客，孤城当落晖。\n吾谋适不用，勿谓知音稀。',
      pinyin: 'shèng dài wú yǐn zhě, yīng líng jìn lái guī.\n suì lìng dōng shān kè, bù dé gù cǎi wēi.\n jì zhì jīn mén yuǎn, shú yún wú dào fēi?\n jiāng huái dù hán shí, jīng luò féng chūn yī.\n zhì jiǔ cháng ān dào, tóng xīn yǔ wǒ wéi.\n xíng dāng fú guì zhào, wèi jǐ fú jīng fēi.\n yuǎn shù dài xíng kè, gū chéng dāng luò huī.\n wú móu shì bú yòng, wù wèi zhī yīn xī.'
    },

    // 卷二：五言乐府
    {
      id: 11,
      title: '塞下曲・其一',
      author: '王昌龄',
      content: '蝉鸣空桑林，八月萧关道。\n出塞入塞寒，处处黄芦草。\n从来幽并客，皆共沙尘老。\n不学游侠儿，矜夸紫骝好。',
      pinyin: 'chán míng kōng sāng lín, bā yuè xiāo guān dào.\n chū sài rù sài hán, chù chù huáng lú cǎo.\n cóng lái yōu bìng kè, jiē gòng shā chén lǎo.\n bú xué yóu xiá ér, jīn kuā zǐ liú hǎo.'
    },
    {
      id: 12,
      title: '青溪',
      author: '王维',
      content: '言入黄花川，每逐青溪水。\n随山将万转，趣途无百里。\n声喧乱石中，色静深松里。\n漾漾泛菱荇，澄澄映葭苇。\n我心素已闲，清川澹如此。\n请留盘石上，垂钓将已矣。',
      pinyin: 'yán rù huáng huā chuān, měi zhú qīng xī shuǐ.\n suí shān jiāng wàn zhuǎn, qù tú wú bǎi lǐ.\n shēng xuān luàn shí zhōng, sè jìng shēn sōng lǐ.\n yàng yàng fàn líng xìng, chéng chéng yìng jiā wěi.\n wǒ xīn sù yǐ xián, qīng chuān dàn rú cǐ.\n qǐng liú pán shí shàng, chuí diào jiāng yǐ yǐ.'
    },
    {
      id: 13,
      title: '渭川田家',
      author: '王维',
      content: '斜阳照墟落，穷巷牛羊归。\n野老念牧童，倚杖候荆扉。\n雉雊麦苗秀，蚕眠桑叶稀。\n田夫荷锄至，相见语依依。\n即此羡闲逸，怅然吟式微。',
      pinyin: 'xié yáng zhào xū luò, qióng xiàng niú yáng guī.\n yě lǎo niàn mù tóng, yǐ zhàng hòu jīng fēi.\n zhì gòu mài miáo xiù, cán mián sāng yè xī.\n tián fū hé chú zhì, xiāng jiàn yǔ yī yī.\n jí cǐ xiàn xián yì, chàng rán yín shì wēi.'
    },
    {
      id: 14,
      title: '西施咏',
      author: '王维',
      content: '艳色天下重，西施宁久微。\n朝为越溪女，暮作吴宫妃。\n贱日岂殊众，贵来方悟稀。\n邀人傅香粉，不自著罗衣。\n君宠益娇态，君怜无是非。\n当时浣纱伴，莫得同车归。\n持谢邻家子，效颦安可希。',
      pinyin: 'yàn sè tiān xià zhòng, xī shī níng jiǔ wēi.\n zhāo wéi yuè xī nǚ, mù zuò wú gōng fēi.\n jiàn rì qǐ shū zhòng, guì lái fāng wù xī.\n yāo rén fù xiāng fěn, bú zì zhuó luó yī.\n jūn chǒng yì jiāo tài, jūn lián wú shì fēi.\n dāng shí huàn shā bàn, mò dé tóng chē guī.\n chí xiè lín jiā zǐ, xiào pín ān kě xī.'
    },
    {
      id: 15,
      title: '秋登兰山寄张五',
      author: '孟浩然',
      content: '北山白云里，隐者自怡悦。\n相望试登高，心随雁飞灭。\n愁因薄暮起，兴是清秋发。\n时见归村人，沙行渡头歇。\n天边树若荠，江畔洲如月。\n何当载酒来，共醉重阳节。',
      pinyin: 'běi shān bái yún lǐ, yǐn zhě zì yí yuè.\n xiāng wàng shì dēng gāo, xīn suí yàn fēi miè.\n chóu yīn bó mù qǐ, xìng shì qīng qiū fā.\n shí jiàn guī cūn rén, shā xíng dù tóu xiē.\n tiān biān shù ruò jì, jiāng pàn zhōu rú yuè.\n hé dāng zǎi jiǔ lái, gòng zuì chóng yáng jié.'
    },
    {
      id: 16,
      title: '宿王昌龄隐居',
      author: '常建',
      content: '清溪深不测，隐处唯孤云。\n松际露微月，清光犹为君。\n茅亭宿花影，药院滋苔纹。\n余亦谢时去，西山鸾鹤群。',
      pinyin: 'qīng xī shēn bù cè, yǐn chù wéi gū yún.\n sōng jì lù wēi yuè, qīng guāng yóu wèi jūn.\n máo tíng sù huā yǐng, yào yuàn zī tái wén.\n yú yì xiè shí qù, xī shān luán hè qún.'
    },
    {
      id: 17,
      title: '闺怨',
      author: '王昌龄',
      content: '闺中少妇不知愁，春日凝妆上翠楼。\n忽见陌头杨柳色，悔教夫婿觅封侯。',
      pinyin: 'guī zhōng shào fù bú zhī chóu, chūn rì níng zhuāng shàng cuì lóu.\n hū jiàn mò tóu yáng liǔ sè, huǐ jiào fū xù mì fēng hóu.'
    },
    {
      id: 18,
      title: '凉州词二首・其一',
      author: '王翰',
      content: '葡萄美酒夜光杯，欲饮琵琶马上催。\n醉卧沙场君莫笑，古来征战几人回？'
    },
    {
      id: 19,
      title: '出塞',
      author: '王昌龄',
      content: '秦时明月汉时关，万里长征人未还。\n但使龙城飞将在，不教胡马度阴山。'
    },
    {
      id: 20,
      title: '乌衣巷',
      author: '刘禹锡',
      content: '朱雀桥边野草花，乌衣巷口夕阳斜。\n旧时王谢堂前燕，飞入寻常百姓家。'
    },
    {
      id: 21,
      title: '芙蓉楼送辛渐',
      author: '王昌龄',
      content: '寒雨连江夜入吴，平明送客楚山孤。\n洛阳亲友如相问，一片冰心在玉壶。',
      pinyin: 'hán yǔ lián jiāng yè rù wú, píng míng sòng kè chǔ shān gū.\n luò yáng qīn yǒu rú xiāng wèn, yī piàn bīng xīn zài yù hú.'
    },
    {
      id: 22,
      title: '与高适薛据登慈恩寺浮图',
      author: '岑参',
      content: '塔势如涌出，孤高耸天宫。\n登临出世界，磴道盘虚空。\n突兀压神州，峥嵘如鬼工。\n四角碍白日，七层摩苍穹。\n下窥指高鸟，俯听闻惊风。\n连山若波涛，奔凑似朝东。\n青槐夹驰道，宫馆何玲珑。\n秋色从西来，苍然满关中。\n五陵北原上，万古青蒙蒙。\n净理了可悟，胜因夙所宗。\n誓将挂冠去，觉道资无穷。',
      pinyin: 'tǎ shì rú yǒng chū, gū gāo sǒng tiān gōng.\n dēng lín chū shì jiè, dèng dào pán xū kōng.\n tū wù yā shén zhōu, zhēng róng rú guǐ gōng.\n sì jiǎo ài bái rì, qī céng mó cāng qióng.\n xià kuī zhǐ gāo niǎo, fǔ tīng wén jīng fēng.\n lián shān ruò bō tāo, bēn còu sì cháo dōng.\n qīng huái jiā chí dào, gōng guǎn hé líng lóng.\n qiū sè cóng xī lái, cāng rán mǎn guān zhōng.\n wǔ líng běi yuán shàng, wàn gǔ qīng méng méng.\n jìng lǐ liǎo kě wù, shèng yīn sù suǒ zōng.\n shì jiāng guà guàn qù, jué dào zī wú qióng.'
    },
    {
      id: 23,
      title: '贼退示官吏',
      author: '元结',
      content: '昔岁逢太平，山林二十年。\n泉源在庭户，洞壑当门前。\n井税有常期，日晏犹得眠。\n忽然遭世变，数岁亲戎旃。\n今来典斯郡，山夷又纷然。\n城小贼不屠，人贫伤可怜。\n是以陷邻境，此州独见全。\n使臣将王命，岂不如贼焉？\n今彼征敛者，迫之如火煎。\n谁能绝人命，以作时世贤！\n思欲委符节，引竿自刺船。\n将家就鱼麦，归老江湖边。',
      pinyin: 'xī suì féng tài píng, shān lín èr shí nián.\n quán yuán zài tíng hù, dòng hè dāng mén qián.\n jǐng shuì yǒu cháng qī, rì yàn yóu dé mián.\n hū rán zāo shì biàn, shù suì qīn róng zhān.\n jīn lái diǎn sī jùn, shān yí yòu fēn rán.\n chéng xiǎo zéi bú tú, rén pín shāng kě lián.\n shì yǐ xiàn lín jìng, cǐ zhōu dú jiàn quán.\n shǐ chén jiāng wáng mìng, qǐ bú rú zéi yān?\n jīn bǐ zhēng liǎn zhě, pò zhī rú huǒ jiān.\n shuí néng jué rén mìng, yǐ zuò shí shì xián!\n sī yù wěi fú jié, yǐn gān zì cì chuán.\n jiāng jiā jiù yú mài, guī lǎo jiāng hú biān.'
    },
    {
      id: 24,
      title: '郡斋雨中与诸文士燕集',
      author: '韦应物',
      content: '兵卫森画戟，宴寝凝清香。\n海上风雨至，逍遥池阁凉。\n烦疴近消散，嘉宾复满堂。\n自惭居处崇，未睹斯民康。\n理会是非遣，性达形迹忘。\n鲜肥属时禁，蔬果幸见尝。\n俯饮一杯酒，仰聆金玉章。\n神欢体自轻，意欲凌风翔。\n吴中盛文史，群彦今汪洋。\n方知大藩地，岂曰财赋强。',
      pinyin: 'bīng wèi sēn huà jǐ, yàn qǐn níng qīng xiāng.\n hǎi shàng fēng yǔ zhì, xiāo yáo chí gé liáng.\n fán kē jìn xiāo sàn, jiā bīn fù mǎn táng.\n zì cán jū chǔ chóng, wèi dǔ sī mín kāng.\n lǐ huì shì fēi qiǎn, xìng dá xíng jì wàng.\n xiān féi shǔ shí jìn, shū guǒ xìng jiàn cháng.\n fǔ yǐn yī bēi jiǔ, yǎng líng jīn yù zhāng.\n shén huān tǐ zì qīng, yì yù líng fēng xiáng.\n wú zhōng shèng wén shǐ, qún yàn jīn wāng yáng.\n fāng zhī dà fān dì, qǐ yuē cái fù qiáng.'
    },
    {
      id: 25,
      title: '初发扬子寄元大校书',
      author: '韦应物',
      content: '凄凄去亲爱，泛泛入烟雾。\n归棹洛阳人，残钟广陵树。\n今朝此为别，何处还相遇。\n世事波上舟，沿洄安得住。',
      pinyin: 'qī qī qù qīn ài, fàn fàn rù yān wù.\n guī zhào luò yáng rén, cán zhōng guǎng líng shù.\n jīn zhāo cǐ wéi bié, hé chù hái xiāng yù.\n shì shì bō shàng zhōu, yán huí ān dé zhù.'
    },
    {
      id: 26,
      title: '寄全椒山中道士',
      author: '韦应物',
      content: '今朝郡斋冷，忽念山中客。\n涧底束荆薪，归来煮白石。\n欲持一瓢酒，远慰风雨夕。\n落叶满空山，何处寻行迹。',
      pinyin: 'jīn zhāo jùn zhāi lěng, hū niàn shān zhōng kè.\n jiàn dǐ shù jīng xīn, guī lái zhǔ bái shí.\n yù chí yī piáo jiǔ, yuǎn wèi fēng yǔ xī.\n luò yè mǎn kōng shān, hé chù xún xíng jì.'
    },
    {
      id: 27,
      title: '庐山谣寄卢侍御虚舟',
      author: '李白',
      content: '我本楚狂人，凤歌笑孔丘。\n手持绿玉杖，朝别黄鹤楼。\n五岳寻仙不辞远，一生好入名山游。\n庐山秀出南斗傍，屏风九叠云锦张。\n影落明湖青黛光，金阙前开二峰长。\n银河倒挂三石梁，香炉瀑布遥相望。\n回崖沓嶂凌苍苍，翠影红霞映朝日。\n鸟飞不到吴天长，登高壮观天地间。\n大江茫茫去不还，黄云万里动风色。\n白波九道流雪山，好为庐山谣，兴因庐山发。\n闲窥石镜清我心，谢公行处苍苔没。\n早服还丹无世情，琴心三叠道初成。\n遥见仙人彩云里，手把芙蓉朝玉京。\n先期汗漫九垓上，愿接卢敖游太清。',
      pinyin: 'wǒ běn chǔ kuáng rén, fèng gē xiào kǒng qiū.\n shǒu chí lǜ yù zhàng, cháo bié huáng hè lóu.\n wǔ yuè xún xiān bú cí yuǎn, yī shēng hǎo rù míng shān yóu.\n lú shān xiù chū nán dǒu bàng, píng fēng jiǔ dié yún jǐn zhāng.\n yǐng luò míng hú qīng dài guāng, jīn quē qián kāi èr fēng cháng.\n yín hé dào guà sān shí liáng, xiāng lú pù bù yáo xiāng wàng.\n huí yá tà zhàng líng cāng cāng, cuì yǐng hóng xiá yìng zhāo rì.\n niǎo fēi bú dào wú tiān cháng, dēng gāo zhuàng guān tiān dì jiān.\n dà jiāng máng máng qù bú hái, huáng yún wàn lǐ dòng fēng sè.\n bái bō jiǔ dào liú xuě shān, hǎo wéi lú shān yáo, xìng yīn lú shān fā.\n xián kuī shí jìng qīng wǒ xīn, xiè gōng xíng chù cāng tái mò.\n zǎo fú hái dān wú shì qíng, qín xīn sān dié dào chū chéng.\n yáo jiàn xiān rén cǎi yún lǐ, shǒu bǎ fú róng cháo yù jīng.\n xiān qī hàn màn jiǔ gāi shàng, yuàn jiē lú áo yóu tài qīng.'
    },
    {
      id: 28,
      title: '梦游天姥吟留别',
      author: '李白',
      content: '海客谈瀛洲，烟涛微茫信难求。\n越人语天姥，云霞明灭或可睹。\n天姥连天向天横，势拔五岳掩赤城。\n天台四万八千丈，对此欲倒东南倾。\n我欲因之梦吴越，一夜飞度镜湖月。\n湖月照我影，送我至剡溪。\n谢公宿处今尚在，渌水荡漾清猿啼。\n脚著谢公屐，身登青云梯。\n半壁见海日，空中闻天鸡。\n千岩万转路不定，迷花倚石忽已暝。\n熊咆龙吟殷岩泉，栗深林兮惊层巅。\n云青青兮欲雨，水澹澹兮生烟。\n列缺霹雳，丘峦崩摧。\n洞天石扉，訇然中开。\n青冥浩荡不见底，日月照耀金银台。\n霓为衣兮风为马，云之君兮纷纷而来下。\n虎鼓瑟兮鸾回车，仙之人兮列如麻。\n忽魂悸以魄动，恍惊起而长嗟。\n惟觉时之枕席，失向来之烟霞。\n世间行乐亦如此，古来万事东流水。\n别君去兮何时还？且放白鹿青崖间。\n须行即骑访名山，安能摧眉折腰事权贵，\n使我不得开心颜！',
      pinyin: 'hǎi kè tán yíng zhōu, yān tāo wēi máng xìn nán qiú.\n yuè rén yǔ tiān mǔ, yún xiá míng miè huò kě dǔ.\n tiān mǔ lián tiān xiàng tiān héng, shì bá wǔ yuè yǎn chì chéng.\n tiān tāi sì wàn bā qiān zhàng, duì cǐ yù dǎo dōng nán qīng.\n wǒ yù yīn zhī mèng wú yuè, yī yè fēi dù jìng hú yuè.\n hú yuè zhào wǒ yǐng, sòng wǒ zhì shàn xī.\n xiè gōng sù chù jīn shàng zài, lù shuǐ dàng yàng qīng yuán tí.\n jiǎo zhuó xiè gōng jī, shēn dēng qīng yún tī.\n bàn bì jiàn hǎi rì, kōng zhōng wén tiān jī.\n qiān yán wàn zhuǎn lù bú dìng, mí huā yǐ shí hū yǐ míng.\n xióng páo lóng yín yǐn yán quán, lì shēn lín xī jīng céng diān.\n yún qīng qīng xī yù yǔ, shuǐ dàn dàn xī shēng yān.\n liè quē pī lì, qiū luán bēng cuī.\n dòng tiān shí fēi, hōng rán zhōng kāi.\n qīng míng hào dàng bú jiàn dǐ, rì yuè zhào yào jīn yín tái.\n ní wéi yī xī fēng wéi mǎ, yún zhī jūn xī fēn fēn ér lái xià.\n hǔ gǔ sè xī luán huí chē, xiān zhī rén xī liè rú má.\n hū hún jì yǐ pò dòng, huǎng jīng qǐ ér cháng jiē.\n wéi jué shí zhī zhěn xí, shī xiàng lái zhī yān xiá.\n shì jiān xíng lè yì rú cǐ, gǔ lái wàn shì dōng liú shuǐ.\n bié jūn qù xī hé shí hái? qiě fàng bái lù qīng yá jiān.\n xū xíng jí qí fǎng míng shān, ān néng cuī méi zhé yāo shì quán guì,\n shǐ wǒ bú dé kāi xīn yán!'
    },

    // 卷四：七言乐府
    {
      id: 29,
      title: '蜀道难',
      author: '李白',
      content: '噫吁嚱，危乎高哉！\n蜀道之难，难于上青天！\n蚕丛及鱼凫，开国何茫然！\n尔来四万八千岁，不与秦塞通人烟。\n西当太白有鸟道，可以横绝峨眉巅。\n地崩山摧壮士死，然后天梯石栈相钩连。\n上有六龙回日之高标，下有冲波逆折之回川。\n黄鹤之飞尚不得过，猿猱欲度愁攀援。\n青泥何盘盘，百步九折萦岩峦。\n扪参历井仰胁息，以手抚膺坐长叹。\n问君西游何时还？畏途巉岩不可攀。\n但见悲鸟号古木，雄飞雌从绕林间。\n又闻子规啼夜月，愁空山。\n蜀道之难，难于上青天，使人听此凋朱颜！\n连峰去天不盈尺，枯松倒挂倚绝壁。\n飞湍瀑流争喧豗，砯崖转石万壑雷。\n其险也如此，嗟尔远道之人胡为乎来哉！\n剑阁峥嵘而崔嵬，一夫当关，万夫莫开。\n所守或匪亲，化为狼与豺。\n朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。\n锦城虽云乐，不如早还家。\n蜀道之难，难于上青天，侧身西望长咨嗟！',
      pinyin: 'yī xū xī, wēi hū gāo zāi!\n shǔ dào zhī nán, nán yú shàng qīng tiān!\n cán cóng jí yú fú, kāi guó hé máng rán!\n ěr lái sì wàn bā qiān suì, bú yǔ qín sài tōng rén yān.\n xī dāng tài bái yǒu niǎo dào, kě yǐ héng jué é méi diān.\n dì bēng shān cuī zhuàng shì sǐ, rán hòu tiān tī shí zhàn xiāng gōu lián.\n shàng yǒu liù lóng huí rì zhī gāo biāo, xià yǒu chōng bō nì zhé zhī huí chuān.\n huáng hè zhī fēi shàng bú dé guò, yuán náo yù dù chóu pān yuán.\n qīng ní hé pán pán, bǎi bù jiǔ zhé yíng yán luán.\n mén shēn lì jǐng yǎng xié xī, yǐ shǒu fǔ yīng zuò cháng tàn.\n wèn jūn xī yóu hé shí hái? wèi tú chán yán bú kě pān.\n dàn jiàn bēi niǎo hào gǔ mù, xióng fēi cí cóng rào lín jiān.\n yòu wén zǐ guī tí yè yuè, chóu kōng shān.\n shǔ dào zhī nán, nán yú shàng qīng tiān, shǐ rén tīng cǐ diāo zhū yán!\n lián fēng qù tiān bú yíng chǐ, kū sōng dào guà yǐ jué bì.\n fēi tuān pù liú zhēng xuān huī, pīng yá zhuǎn shí wàn hè léi.\n qí xiǎn yě rú cǐ, jiē ěr yuǎn dào zhī rén hú wéi hū lái zāi!\n jiàn gé zhēng róng ér cuī wéi, yī fū dāng guān, wàn fū mò kāi.\n suǒ shǒu huò fěi qīn, huà wéi láng yǔ chái.\n cháo bì měng hǔ, xī bì cháng shé; mó yá shǔn xuè, shā rén rú má.\n jǐn chéng suī yún lè, bú rú zǎo huán jiā.\n shǔ dào zhī nán, nán yú shàng qīng tiān, cè shēn xī wàng cháng zī jiē!'
    },
    {
      id: 30,
      title: '感遇・其一',
      author: '张九龄',
      content: '兰叶春葳蕤，桂华秋皎洁。\n欣欣此生意，自尔为佳节。\n谁知林栖者，闻风坐相悦。\n草木有本心，何求美人折？',
      pinyin: 'lán yè chūn wēi ruí, guì huá qiū jiǎo jié.\n xīn xīn cǐ shēng yì, zì ěr wéi jiā jié.\n shuí zhī lín qī zhě, wén fēng zuò xiāng yuè.\n cǎo mù yǒu běn xīn, hé qiú měi rén zhé？'
    },
    // 卷五：五言律诗
    {
      id: 31,
      title: '望月怀远',
      author: '张九龄',
      content: '海上生明月，天涯共此时。\n情人怨遥夜，竟夕起相思。\n灭烛怜光满，披衣觉露滋。\n不堪盈手赠，还寝梦佳期。',
      pinyin: 'hǎi shàng shēng míng yuè, tiān yá gòng cǐ shí.\n qíng rén yuàn yáo yè, jìng xī qǐ xiāng sī.\n miè zhú lián guāng mǎn, pī yī jué lù zī.\n bú kān yíng shǒu zèng, hái qǐn mèng jiā qī.'
    },
    {
      id: 32,
      title: '送杜少府之任蜀州',
      author: '王勃',
      content: '城阙辅三秦，风烟望五津。\n与君离别意，同是宦游人。\n海内存知己，天涯若比邻。\n无为在歧路，儿女共沾巾。',
      pinyin: 'chéng què fǔ sān qín, fēng yān wàng wǔ jīn.\n yǔ jūn lí bié yì, tóng shì huàn yóu rén.\n hǎi nèi cún zhī jǐ, tiān yá ruò bǐ lín.\n wú wéi zài qí lù, ér nǚ gòng zhān jīn.'
    },
    {
      id: 33,
      title: '春望',
      author: '杜甫',
      content: '国破山河在，城春草木深。\n感时花溅泪，恨别鸟惊心。\n烽火连三月，家书抵万金。\n白头搔更短，浑欲不胜簪。',
      pinyin: 'guó pò shān hé zài, chéng chūn cǎo mù shēn.\n gǎn shí huā jiàn lèi, hèn bié niǎo jīng xīn.\n fēng huǒ lián sān yuè, jiā shū dǐ wàn jīn.\n bái tóu sāo gèng duǎn, hún yù bú shèng zān.'
    },
    {
      id: 34,
      title: '月夜',
      author: '杜甫',
      content: '今夜鄜州月，闺中只独看。\n遥怜小儿女，未解忆长安。\n香雾云鬟湿，清辉玉臂寒。\n何时倚虚幌，双照泪痕干。',
      pinyin: 'jīn yè fū zhōu yuè, guī zhōng zhǐ dú kàn.\n yáo lián xiǎo ér nǚ, wèi jiě yì cháng ān.\n xiāng wù yún huán shī, qīng huī yù bì hán.\n hé shí yǐ xū huǎng, shuāng zhào lèi hén gàn.'
    },

    // 卷六：七言律诗
    {
      id: 35,
      title: '黄鹤楼',
      author: '崔颢',
      content: '昔人已乘黄鹤去，此地空余黄鹤楼。\n黄鹤一去不复返，白云千载空悠悠。\n晴川历历汉阳树，芳草萋萋鹦鹉洲。\n日暮乡关何处是？烟波江上使人愁。',
      pinyin: 'xī rén yǐ chéng huáng hè qù, cǐ dì kōng yú huáng hè lóu.\n huáng hè yī qù bú fù fǎn, bái yún qiān zǎi kōng yōu yōu.\n qíng chuān lì lì hàn yáng shù, fāng cǎo qī qī yīng wǔ zhōu.\n rì mù xiāng guān hé chù shì? yān bō jiāng shàng shǐ rén chóu.'
    },
    {
      id: 36,
      title: '登金陵凤凰台',
      author: '李白',
      content: '凤凰台上凤凰游，凤去台空江自流。\n吴宫花草埋幽径，晋代衣冠成古丘。\n三山半落青天外，二水中分白鹭洲。\n总为浮云能蔽日，长安不见使人愁。',
      pinyin: 'fèng huáng tái shàng fèng huáng yóu, fèng qù tái kōng jiāng zì liú.\n wú gōng huā cǎo mái yōu jìng, jìn dài yī guān chéng gǔ qiū.\n sān shān bàn luò qīng tiān wài, èr shuǐ zhōng fēn bái lù zhōu.\n zǒng wéi fú yún néng bì rì, cháng ān bú jiàn shǐ rén chóu.'
    },
    {
      id: 37,
      title: '蜀相',
      author: '杜甫',
      content: '丞相祠堂何处寻？锦官城外柏森森。\n映阶碧草自春色，隔叶黄鹂空好音。\n三顾频烦天下计，两朝开济老臣心。\n出师未捷身先死，长使英雄泪满襟。',
      pinyin: 'chéng xiàng cí táng hé chù xún? jǐn guān chéng wài bǎi sēn sēn.\n yìng jiē bì cǎo zì chūn sè, gé yè huáng lí kōng hǎo yīn.\n sān gù pín fán tiān xià jì, liǎng cháo kāi jì lǎo chén xīn.\n chū shī wèi jié shēn xiān sǐ, cháng shǐ yīng xióng lèi mǎn jīn.'
    },
    {
      id: 38,
      title: '登高',
      author: '杜甫',
      content: '风急天高猿啸哀，渚清沙白鸟飞回。\n无边落木萧萧下，不尽长江滚滚来。\n万里悲秋常作客，百年多病独登台。\n艰难苦恨繁霜鬓，潦倒新停浊酒杯。',
      pinyin: 'fēng jí tiān gāo yuán xiào āi, zhǔ qīng shā bái niǎo fēi huí.\n wú biān luò mù xiāo xiāo xià, bú jìn cháng jiāng gǔn gǔn lái.\n wàn lǐ bēi qiū cháng zuò kè, bǎi nián duō bìng dú dēng tái.\n jiān nán kǔ hèn fán shuāng bìn, liáo dǎo xīn tíng zhuó jiǔ bēi.'
    },

    // 卷七：五言绝句
    {
      id: 39,
      title: '鹿柴',
      author: '王维',
      content: '空山不见人，但闻人语响。\n返景入深林，复照青苔上。',
      pinyin: 'kōng shān bú jiàn rén, dàn wén rén yǔ xiǎng.\n fǎn yǐng rù shēn lín, fù zhào qīng tái shàng.'
    },
    {
      id: 40,
      title: '竹里馆',
      author: '王维',
      content: '独坐幽篁里，弹琴复长啸。\n深林人不知，明月来相照。',
      pinyin: 'dú zuò yōu huáng lǐ, tán qín fù cháng xiào.\n shēn lín rén bú zhī, míng yuè lái xiāng zhào.'
    },
    {
      id: 41,
      title: '送别',
      author: '王维',
      content: '山中相送罢，日暮掩柴扉。\n春草年年绿，王孙归不归？',
      pinyin: 'shān zhōng xiāng sòng bà, rì mù yǎn chái fēi.\n chūn cǎo nián nián lǜ, wáng sūn guī bú guī？'
    },
    {
      id: 42,
      title: '相思',
      author: '王维',
      content: '红豆生南国，春来发几枝。\n愿君多采撷，此物最相思。',
      pinyin: 'hóng dòu shēng nán guó, chūn lái fā jǐ zhī.\n yuàn jūn duō cǎi xié, cǐ wù zuì xiāng sī.'
    },
    {
      id: 43,
      title: '杂诗',
      author: '王维',
      content: '君自故乡来，应知故乡事。\n来日绮窗前，寒梅著花未？',
      pinyin: 'jūn zì gù xiāng lái, yīng zhī gù xiāng shì.\n lái rì qǐ chuāng qián, hán méi zhù huā wèi？'
    },
    {
      id: 44,
      title: '静夜思',
      author: '李白',
      content: '床前明月光，疑是地上霜。\n举头望明月，低头思故乡。',
      pinyin: 'chuáng qián míng yuè guāng, yí shì dì shàng shuāng.\n jǔ tóu wàng míng yuè, dī tóu sī gù xiāng.'
    },
    {
      id: 45,
      title: '怨情',
      author: '李白',
      content: '美人卷珠帘，深坐颦蛾眉。\n但见泪痕湿，不知心恨谁。',
      pinyin: 'měi rén juǎn zhū lián, shēn zuò pín é méi.\n dàn jiàn lèi hén shī, bú zhī xīn hèn shuí.'
    },
    {
      id: 46,
      title: '登鹳雀楼',
      author: '王之涣',
      content: '白日依山尽，黄河入海流。\n欲穷千里目，更上一层楼。',
      pinyin: 'bái rì yī shān jìn, huáng hé rù hǎi liú.\n yù qióng qiān lǐ mù, gèng shàng yī céng lóu.'
    },
    {
      id: 47,
      title: '春晓',
      author: '孟浩然',
      content: '春眠不觉晓，处处闻啼鸟。\n夜来风雨声，花落知多少。',
      pinyin: 'chūn mián bú jué xiǎo, chù chù wén tí niǎo.\n yè lái fēng yǔ shēng, huā luò zhī duō shǎo.'
    },
    {
      id: 48,
      title: '宿建德江',
      author: '孟浩然',
      content: '移舟泊烟渚，日暮客愁新。\n野旷天低树，江清月近人。',
      pinyin: 'yí zhōu bó yān zhǔ, rì mù kè chóu xīn.\n yě kuàng tiān dī shù, jiāng qīng yuè jìn rén.'
    },
    {
      id: 49,
      title: '江雪',
      author: '柳宗元',
      content: '千山鸟飞绝，万径人踪灭。\n孤舟蓑笠翁，独钓寒江雪。',
      pinyin: 'qiān shān niǎo fēi jué, wàn jìng rén zōng miè.\n gū zhōu suō lì wēng, dú diào hán jiāng xuě.'
    },
    {
      id: 50,
      title: '寻隐者不遇',
      author: '贾岛',
      content: '松下问童子，言师采药去。\n只在此山中，云深不知处。',
      pinyin: 'sōng xià wèn tóng zǐ, yán shī cǎi yào qù.\n zhǐ zài cǐ shān zhōng, yún shēn bú zhī chù.'
    },
    {
      id: 51,
      title: '行宫',
      author: '元稹',
      content: '寥落古行宫，宫花寂寞红。\n白头宫女在，闲坐说玄宗。',
      pinyin: 'liáo luò gǔ xíng gōng, gōng huā jì mò hóng.\n bái tóu gōng nǚ zài, xián zuò shuō xuán zōng.'
    },


    {
      id: 52,
      title: '春词',
      author: '刘禹锡',
      content: '新妆宜面下朱楼，深锁春光一院愁。\n行到中庭数花朵，蜻蜓飞上玉搔头。',
      pinyin: 'xīn zhuāng yí miàn xià zhū lóu, shēn suǒ chūn guāng yī yuàn chóu.\n xíng dào zhōng tíng shù huā duǒ, qīng tíng fēi shàng yù sāo tóu.'
    },
    {
      id: 53,
      title: '竹枝词二首・其一',
      author: '刘禹锡',
      content: '杨柳青青江水平，闻郎江上踏歌声。\n东边日出西边雨，道是无晴却有晴。',
      pinyin: 'yáng liǔ qīng qīng jiāng shuǐ píng, wén láng jiāng shàng tà gē shēng.\n dōng biān rì chū xī biān yǔ, dào shì wú qíng què yǒu qíng.'
    },
    {
      id: 54,
      title: '泊秦淮',
      author: '杜牧',
      content: '烟笼寒水月笼沙，夜泊秦淮近酒家。\n商女不知亡国恨，隔江犹唱后庭花。',
      pinyin: 'yān lóng hán shuǐ yuè lóng shā, yè bó qín huái jìn jiǔ jiā.\n shāng nǚ bú zhī wáng guó hèn, gé jiāng yóu chàng hòu tíng huā.'
    },
    {
      id: 55,
      title: '夜雨寄北',
      author: '李商隐',
      content: '君问归期未有期，巴山夜雨涨秋池。\n何当共剪西窗烛，却话巴山夜雨时。',
      pinyin: 'jūn wèn guī qī wèi yǒu qī, bā shān yè yǔ zhǎng qiū chí.\n hé dāng gòng jiǎn xī chuāng zhú, què huà bā shān yè yǔ shí.'
    },
    {
      id: 56,
      title: '嫦娥',
      author: '李商隐',
      content: '云母屏风烛影深，长河渐落晓星沉。\n嫦娥应悔偷灵药，碧海青天夜夜心。',
      pinyin: 'yún mǔ píng fēng zhú yǐng shēn, cháng hé jiàn luò xiǎo xīng chén.\n cháng é yīng huǐ tōu líng yào, bì hǎi qīng tiān yè yè xīn.'
    },
    {
      id: 57,
      title: '贾生',
      author: '李商隐',
      content: '宣室求贤访逐臣，贾生才调更无伦。\n可怜夜半虚前席，不问苍生问鬼神。',
      pinyin: 'xuān shì qiú xián fǎng zhú chén, jiǎ shēng cái diào gèng wú lún.\n kě lián yè bàn xū qián xí, bú wèn cāng shēng wèn guǐ shén.'
    },
    {
      id: 58,
      title: '瑶瑟怨',
      author: '温庭筠',
      content: '冰簟银床梦不成，碧天如水夜云轻。\n雁声远过潇湘去，十二楼中月自明。',
      pinyin: 'bīng diàn yín chuáng mèng bú chéng, bì tiān rú shuǐ yè yún qīng.\n yàn shēng yuǎn guò xiāo xiāng qù, shí èr lóu zhōng yuè zì míng.'
    },
    {
      id: 59,
      title: '渭城曲',
      author: '王维',
      content: '渭城朝雨浥轻尘，客舍青青柳色新。\n劝君更尽一杯酒，西出阳关无故人。',
      pinyin: 'wèi chéng zhāo yǔ yì qīng chén, kè shè qīng qīng liǔ sè xīn.\n quàn jūn gèng jìn yī bēi jiǔ, xī chū yáng guān wú gù rén.'
    },
    {
      id: 60,
      title: '清平调・其一',
      author: '李白',
      content: '云想衣裳花想容，春风拂槛露华浓。\n若非群玉山头见，会向瑶台月下逢。',
      pinyin: 'yún xiǎng yī shang huā xiǎng róng, chūn fēng fú jiàn lù huá nóng.\n ruò fēi qún yù shān tóu jiàn, huì xiàng yáo tái yuè xià féng.'
    },
    {
      id: 61,
      title: '清平调・其二',
      author: '李白',
      content: '一枝红艳露凝香，云雨巫山枉断肠。\n借问汉宫谁得似，可怜飞燕倚新妆。',
      pinyin: 'yī zhī hóng yàn lù níng xiāng, yún yǔ wū shān wǎng duàn cháng.\n jiè wèn hàn gōng shuí dé sì, kě lián fēi yàn yǐ xīn zhuāng.'
    },
    {
      id: 62,
      title: '清平调・其三',
      author: '李白',
      content: '名花倾国两相欢，长得君王带笑看。\n解释春风无限恨，沉香亭北倚阑干。',
      pinyin: 'míng huā qīng guó liǎng xiāng huān, zhǎng dé jūn wáng dài xiào kàn.\n jiě shì chūn fēng wú xiàn hèn, chén xiāng tíng běi yǐ lán gān.'
    },
    {
      id: 63,
      title: '逢入京使',
      author: '岑参',
      content: '故园东望路漫漫，双袖龙钟泪不干。\n马上相逢无纸笔，凭君传语报平安。',
      pinyin: 'gù yuán dōng wàng lù màn màn, shuāng xiù lóng zhōng lèi bú gàn.\n mǎ shàng xiāng féng wú zhǐ bǐ, píng jūn chuán yǔ bào píng ān.'
    },
    {
      id: 64,
      title: '滁州西涧',
      author: '韦应物',
      content: '独怜幽草涧边生，上有黄鹂深树鸣。\n春潮带雨晚来急，野渡无人舟自横。',
      pinyin: 'dú lián yōu cǎo jiàn biān shēng, shàng yǒu huáng lí shēn shù míng.\n chūn cháo dài yǔ wǎn lái jí, yě dù wú rén zhōu zì héng.'
    },
    {
      id: 65,
      title: '夜上受降城闻笛',
      author: '李益',
      content: '回乐峰前沙似雪，受降城外月如霜。\n不知何处吹芦管，一夜征人尽望乡。',
      pinyin: 'huí lè fēng qián shā sì xuě, shòu xiáng chéng wài yuè rú shuāng.\n bú zhī hé chù chuī lú guǎn, yī yè zhēng rén jìn wàng xiāng.'
    },

    // 卷二：五言乐府
    {
      id: 66,
      title: '古意',
      author: '李颀',
      content: '男儿事长征，少小幽燕客。\n赌胜马蹄下，由来轻七尺。\n杀人莫敢前，须如猬毛磔。\n黄云陇底白云飞，未得报恩不得归。\n辽东小妇年十五，惯弹琵琶解歌舞。\n今为羌笛出塞声，使我三军泪如雨。',
      pinyin: 'nán ér shì zhǎng zhēng, shào xiǎo yōu yān kè.\n dǔ shèng mǎ tí xià, yóu lái qīng qī chǐ.\n shā rén mò gǎn qián, xū rú wèi máo zhé.\n huáng yún lǒng dǐ bái yún fēi, wèi dé bào ēn bú dé guī.\n liáo dōng xiǎo fù nián shí wǔ, guàn tán pí pá jiě gē wǔ.\n jīn wéi qiāng dí chū sài shēng, shǐ wǒ sān jūn lèi rú yǔ.'
    },
    {
      id: 67,
      title: '长干行・其二',
      author: '崔颢',
      content: '家临九江水，来去九江侧。\n同是长干人，生小不相识。',
      pinyin: 'jiā lín jiǔ jiāng shuǐ, lái qù jiǔ jiāng cè.\n tóng shì cháng gàn rén, shēng xiǎo bú xiāng shí.'
    },
    {
      id: 68,
      title: '玉阶怨',
      author: '李白',
      content: '玉阶生白露，夜久侵罗袜。\n却下水晶帘，玲珑望秋月。',
      pinyin: 'yù jiē shēng bái lù, yè jiǔ qīn luó wà.\n què xià shuǐ jīng lián, líng lóng wàng qiū yuè.'
    },
    {
      id: 69,
      title: '和张仆射塞下曲・其一',
      author: '卢纶',
      content: '鹫翎金仆姑，燕尾绣蝥弧。\n独立扬新令，千营共一呼。',
      pinyin: 'jiù líng jīn pú gū, yàn wěi xiù móu hú.\n dú lì yáng xīn lìng, qiān yíng gòng yī hū.'
    },
    {
      id: 70,
      title: '和张仆射塞下曲・其二',
      author: '卢纶',
      content: '林暗草惊风，将军夜引弓。\n平明寻白羽，没在石棱中。',
      pinyin: 'lín àn cǎo jīng fēng, jiāng jūn yè yǐn gōng.\n píng míng xún bái yǔ, mò zài shí léng zhōng.'
    },
    {
      id: 71,
      title: '塞下曲',
      author: '卢纶',
      content: '月黑雁飞高，单于夜遁逃。\n欲将轻骑逐，大雪满弓刀。',
      pinyin: 'yuè hēi yàn fēi gāo, chán yú yè dùn táo.\n yù jiāng qīng qí zhú, dà xuě mǎn gōng dāo.'
    },
    {
      id: 72,
      title: '和张仆射塞下曲・其四',
      author: '卢纶',
      content: '野幕敞琼筵，羌戎贺劳旋。\n醉和金甲舞，雷鼓动山川。',
      pinyin: 'yě mù chǎng qióng yán, qiāng róng hè láo xuán.\n zuì hé jīn jiǎ wǔ, léi gǔ dòng shān chuān.'
    },
    {
      id: 73,
      title: '江南曲',
      author: '李益',
      content: '嫁得瞿塘贾，朝朝误妾期。\n早知潮有信，嫁与弄潮儿。',
      pinyin: 'jià dé qú táng jiǎ, zhāo zhāo wù qiè qī.\n zǎo zhī cháo yǒu xìn, jià yǔ nòng cháo ér.'
    },
    {
      id: 74,
      title: '长干行',
      author: '李白',
      content: '妾发初覆额，折花门前剧。\n郎骑竹马来，绕床弄青梅。\n同居长干里，两小无嫌猜。\n十四为君妇，羞颜未尝开。\n低头向暗壁，千唤不一回。\n十五始展眉，愿同尘与灰。\n常存抱柱信，岂上望夫台。\n十六君远行，瞿塘滟滪堆。\n五月不可触，猿声天上哀。\n门前迟行迹，一一生绿苔。\n苔深不能扫，落叶秋风早。\n八月蝴蝶黄，双飞西园草。\n感此伤妾心，坐愁红颜老。\n早晚下三巴，预将书报家。\n相迎不道远，直至长风沙。',
      pinyin: 'qiè fà chū fù é, shé huā mén qián jù.\n láng qí zhú mǎ lái, rào chuáng nòng qīng méi.\n tóng jū cháng gàn lǐ, liǎng xiǎo wú xián cāi.\n shí sì wéi jūn fù, xiū yán wèi cháng kāi.\n dī tóu xiàng àn bì, qiān huàn bú yī huí.\n shí wǔ shǐ zhǎn méi, yuàn tóng chén yǔ huī.\n cháng cún bào zhù xìn, qǐ shàng wàng fū tái.\n shí liù jūn yuǎn xíng, qú táng yàn yù duī.\n wǔ yuè bú kě chù, yuán shēng tiān shàng āi.\n mén qián chí xíng jì, yī yī shēng lǜ tái.\n tái shēn bú néng sǎo, luò yè qiū fēng zǎo.\n bā yuè hú dié huáng, shuāng fēi xī yuán cǎo.\n gǎn cǐ shāng qiè xīn, zuò chóu hóng yán lǎo.\n zǎo wǎn xià sān bā, yù jiāng shū bào jiā.\n xiāng yíng bú dào yuǎn, zhí zhì cháng fēng shā.'
    },

    // 卷三：七言古诗
    {
      id: 75,
      title: '送陈章甫',
      author: '李颀',
      content: '四月南风大麦黄，枣花未落桐叶长。\n青山朝别暮还见，嘶马出门思旧乡。\n陈侯立身何坦荡，虬须虎眉仍大颡。\n腹中贮书一万卷，不肯低头在草莽。\n东门酤酒饮我曹，心轻万事如鸿毛。\n醉卧不知白日暮，有时空望孤云高。\n长河浪头连天黑，津口停舟渡不得。\n郑国游人未及家，洛阳行子空叹息。\n闻道故林相识多，罢官昨日今如何。',
      pinyin: 'sì yuè nán fēng dà mài huáng, zǎo huā wèi luò tóng yè cháng。\n qīng shān cháo bié mù hái jiàn, sī mǎ chū mén sī jiù xiāng。\n chén hòu lì shēn hé tǎn dàng, qiú xū hǔ méi réng dà sǎng。\n fù zhōng zhù shū yī wàn juàn, bù kěn dī tóu zài cǎo mǎng。\n dōng mén gū jiǔ yǐn wǒ cáo, xīn qīng wàn shì rú hóng máo。\n zuì wò bú zhī bái rì mù, yǒu shí kōng wàng gū yún gāo。\n cháng hé làng tóu lián tiān hēi, jīn kǒu tíng zhōu dù bú dé。\n zhèng guó yóu rén wèi jí jiā, luò yáng xíng zǐ kōng tàn xī。\n wén dào gù lín xiāng shí duō, bà guān zuó rì jīn rú hé。'
    },
    {
      id: 76,
      title: '琴歌',
      author: '李颀',
      content: '主人有酒欢今夕，请奏鸣琴广陵客。\n月照城头乌半飞，霜凄万树风入衣。\n铜炉华烛烛增辉，初弹渌水后楚妃。\n一声已动物皆静，四座无言星欲稀。\n清淮奉使千馀里，敢告云山从此始。',
      pinyin: 'zhǔ rén yǒu jiǔ huān jīn xī, qǐng zòu míng qín guǎng líng kè。\n yuè zhào chéng tóu wū bàn fēi, shuāng qī wàn shù fēng rù yī。\n tóng lú huá zhú zhú zēng huī, chū dàn lù shuǐ hòu chǔ fēi。\n yī shēng yǐ dòng wù jiē jìng, sì zuò wú yán xīng yù xī。\n qīng huái fèng shǐ qiān yú lǐ, gǎn gào yún shān cóng cǐ shǐ。'
    },
    {
      id: 77,
      title: '听董大弹胡笳声兼寄语弄房给事',
      author: '李颀',
      content: '蔡女昔造胡笳声，一弹一十有八拍。\n胡人落泪沾边草，汉使断肠对归客。\n古戍苍苍烽火寒，大荒沉沉飞雪白。\n先拂商弦后角羽，四郊秋叶惊摵摵。\n董夫子，通神明，深山窃听来妖精。\n言迟更速皆应手，将往复旋如有情。\n空山百鸟散还合，万里浮云阴且晴。\n嘶酸雏雁失群夜，断绝胡儿恋母声。\n川为静其波，鸟亦罢其鸣。\n乌孙部落家乡远，逻娑沙尘哀怨生。\n幽音变调忽飘洒，长风吹林雨堕瓦。\n迸泉飒飒飞木末，野鹿呦呦走堂下。\n长安城连东掖垣，凤凰池对青琐门。\n高才脱略名与利，日夕望君抱琴至。',
      pinyin: 'cài nǚ xī zào hú jiā shēng, yī dàn yī shí yǒu bā pāi。\n hú rén luò lèi zhān biān cǎo, hàn shǐ duàn cháng duì guī kè。\n gǔ shù cāng cāng fēng huǒ hán, dà huāng chén chén fēi xuě bái。\n xiān fú shāng xián hòu jiǎo yǔ, sì jiāo qiū yè jīng sè sè。\n dǒng fū zǐ, tōng shén míng, shēn shān qiè tīng lái yāo jīng。\n yán chí gèng sù jiē yìng shǒu, jiāng wǎng fù xuán rú yǒu qíng。\n kōng shān bǎi niǎo sàn hái hé, wàn lǐ fú yún yīn qiě qíng。\n sī suān chú yàn shī qún yè, duàn jué hú ér liàn mǔ shēng。\n chuān wéi jìng qí bō, niǎo yì bà qí míng。\n wū sūn bù luò jiā xiāng yuǎn, luó suō shā chén āi yuàn shēng。\n yōu yīn biàn diào hū piāo sǎ, cháng fēng chuī lín yǔ duò wǎ。\n bèng quán sà sà fēi mù mò, yě lù yōu yōu zǒu táng xià。\n cháng ān chéng lián dōng yè yuán, fèng huáng chí duì qīng suǒ mén。\n gāo cái tuō lüè míng yǔ lì, rì xī wàng jūn bào qín zhì。'
    },
    {
      id: 78,
      title: '听安万善吹觱篥歌',
      author: '李颀',
      content: '南山截竹为觱篥，此乐本自龟兹出。\n流传汉地曲转奇，凉州胡人为我吹。\n傍邻闻者多叹息，远客思乡皆泪垂。\n世人解听不解赏，长飙风中自来往。\n枯桑老柏寒飕飗，九雏鸣凤乱啾啾。\n龙吟虎啸一时发，万籁百泉相与秋。\n忽然更作渔阳掺，黄云萧条白日暗。\n变调如闻杨柳春，上林繁花照眼新。\n岁中俯见一日半，明日知谁此为主。\n古人已去今人悲，秋草无情秋山暮。\n呜呼！汉公明主亦已矣，人生在世当自为。',
      pinyin: 'nán shān jié zhú wéi bì lì, cǐ lè běn zì guī zī chū。\n liú chuán hàn dì qǔ zhuǎn qí, liáng zhōu hú rén wéi wǒ chuī。\n bàng lín wén zhě duō tàn xī, yuǎn kè sī xiāng jiē lèi chuí。\n shì rén jiě tīng bù jiě shǎng, cháng biāo fēng zhōng zì lái wǎng。\n kū sāng lǎo bǎi hán sōu liú, jiǔ chú míng fèng luàn jiū jiū。\n lóng yín hǔ xiào yī shí fā, wàn lài bǎi quán xiāng yǔ qiū。\n hū rán gèng zuò yú yáng càn, huáng yún xiāo tiáo bái rì àn。\n biàn diào rú wén yáng liǔ chūn, shàng lín fán huā zhào yǎn xīn。\n suì zhōng fǔ jiàn yī rì bàn, míng rì zhī shuí cǐ wéi zhǔ。\n gǔ rén yǐ qù jīn rén bēi, qiū cǎo wú qíng qiū shān mù。\n wū hū! hàn gōng míng zhǔ yì yǐ yǐ, rén shēng zài shì dāng zì wéi。'
    },
    {
      id: 79,
      title: '夜归鹿门山歌',
      author: '孟浩然',
      content: '山寺钟鸣昼已昏，渔梁渡头争渡喧。\n人随沙岸向江村，余亦乘舟归鹿门。\n鹿门月照开烟树，忽到庞公栖隐处。\n岩扉松径长寂寥，惟有幽人自来去。',
      pinyin: 'shān sì zhōng míng zhòu yǐ hūn, yú liáng dù tóu zhēng dù xuān。\n rén suí shā àn xiàng jiāng cūn, yú yì chéng zhōu guī lù mén。\n lù mén yuè zhào kāi yān shù, hū dào páng gōng qī yǐn chù。\n yán fēi sōng jìng cháng jì liáo, wéi yǒu yōu rén zì lái qù。'
    },
    {
      id: 80,
      title: '金陵酒肆留别',
      author: '李白',
      content: '风吹柳花满店香，吴姬压酒唤客尝。\n金陵子弟来相送，欲行不行各尽觞。\n请君试问东流水，别意与之谁短长。',
      pinyin: 'fēng chuī liǔ huā mǎn diàn xiāng, wú jī yā jiǔ huàn kè cháng。\n jīn líng zǐ dì lái xiāng sòng, yù xíng bú xíng gè jìn shāng。\n qǐng jūn shì wèn dōng liú shuǐ, bié yì yǔ zhī shuí duǎn cháng。'
    },
    {
      id: 81,
      title: '宣州谢朓楼饯别校书叔云',
      author: '李白',
      content: '弃我去者，昨日之日不可留；\n乱我心者，今日之日多烦忧。\n长风万里送秋雁，对此可以酣高楼。\n蓬莱文章建安骨，中间小谢又清发。\n俱怀逸兴壮思飞，欲上青天览明月。\n抽刀断水水更流，举杯消愁愁更愁。\n人生在世不称意，明朝散发弄扁舟。',
      pinyin: 'qì wǒ qù zhě, zuó rì zhī rì bú kě liú；\n luàn wǒ xīn zhě, jīn rì zhī rì duō fán yōu。\n cháng fēng wàn lǐ sòng qiū yàn, duì cǐ kě yǐ hān gāo lóu。\n péng lái wén zhāng jiàn ān gǔ, zhōng jiān xiǎo xiè yòu qīng fā。\n jù huái yì xìng zhuàng sī fēi, yù shàng qīng tiān lǎn míng yuè。\n chōu dāo duàn shuǐ shuǐ gèng liú, jǔ bēi xiāo chóu chóu gèng chóu。\n rén shēng zài shì bú chèn yì, míng cháo sàn fà nòng piān zhōu。'
    },
    {
      id: 82,
      title: '走马川行奉送封大夫出师西征',
      author: '岑参',
      content: '君不见走马川行雪海边，平沙莽莽黄入天。\n轮台九月风夜吼，一川碎石大如斗，随风满地石乱走。\n匈奴草黄马正肥，金山西见烟尘飞，汉家大将西出师。\n将军金甲夜不脱，半夜军行戈相拨，风头如刀面如割。\n马毛带雪汗气蒸，五花连钱旋作冰，幕中草檄砚水凝。\n虏骑闻之应胆慑，料知短兵不敢接，车师西门伫献捷。',
      pinyin: 'jūn bú jiàn zǒu mǎ chuān xíng xuě hǎi biān, píng shā mǎng mǎng huáng rù tiān。\n lún tái jiǔ yuè fēng yè hǒu, yī chuān suì shí dà rú dòu, suí fēng mǎn dì shí luàn zǒu。\n xiōng nú cǎo huáng mǎ zhèng féi, jīn shān xī jiàn yān chén fēi, hàn jiā dà jiàng xī chū shī。\n jiāng jūn jīn jiǎ yè bú tuō, bàn yè jūn xíng gē xiāng bō, fēng tóu rú dāo miàn rú gē。\n mǎ máo dài xuě hàn qì zhēng, wǔ huā lián qián xuán zuò bīng, mù zhōng cǎo xí yàn shuǐ níng。\n lǔ qí wén zhī yīng dǎn shè, liào zhī duǎn bīng bú gǎn jiē, chē shī xī mén zhù xiàn jié。'
    },
    {
      id: 83,
      title: '轮台歌奉送封大夫出师西征',
      author: '岑参',
      content: '轮台城头夜吹角，轮台城北旄头落。\n羽书昨夜过渠黎，单于已在金山西。\n戍楼西望烟尘黑，汉兵屯在轮台北。\n上将拥旄西出征，平明吹笛大军行。\n四边伐鼓雪海涌，三军大呼阴山动。\n虏塞兵气连云屯，战场白骨缠草根。\n剑河风急雪片阔，沙口石冻马蹄脱。\n亚相勤苦终成事，誓取单于灭此虏。\n古来青史谁不见，今见功名胜古人。',
      pinyin: 'lún tái chéng tóu yè chuī jiǎo, lún tái chéng běi máo tóu luò。\n yǔ shū zuó yè guò qú lí, chán yú yǐ zài jīn shān xī。\n shù lóu xī wàng yān chén hēi, hàn bīng tún zài lún tái běi。\n shàng jiàng yōng máo xī chū zhēng, píng míng chuī dí dà jūn xíng。\n sì biān fá gǔ xuě hǎi yǒng, sān jūn dà hū yīn shān dòng。\n lǔ sài bīng qì lián yún tún, zhàn chǎng bái gǔ chán cǎo gēn。\n jiàn hé fēng jí xuě piàn kuò, shā kǒu shí dòng mǎ tí tuō。\n yà xiàng qín kǔ zhōng chéng shì, shì qǔ chán yú miè cǐ lǔ。\n gǔ lái qīng shǐ shuí bú jiàn, jīn jiàn gōng míng shèng gǔ rén。'
    },
    {
      id: 84,
      title: '白雪歌送武判官归京',
      author: '岑参',
      content: '北风卷地白草折，胡天八月即飞雪。\n忽如一夜春风来，千树万树梨花开。\n散入珠帘湿罗幕，狐裘不暖锦衾薄。\n将军角弓不得控，都护铁衣冷难着。\n瀚海阑干百丈冰，愁云惨淡万里凝。\n中军置酒饮归客，胡琴琵琶与羌笛。\n纷纷暮雪下辕门，风掣红旗冻不翻。\n轮台东门送君去，去时雪满天山路。\n山回路转不见君，雪上空留马行处。',
      pinyin: 'běi fēng juǎn dì bái cǎo shé, hú tiān bā yuè jí fēi xuě。\n hū rú yī yè chūn fēng lái, qiān shù wàn shù lí huā kāi。\n sàn rù zhū lián shī luó mù, hú qiú bú nuǎn jǐn qīn báo。\n jiāng jūn jiǎo gōng bú dé kòng, dōu hù tiě yī lěng nán zhe。\n hàn hǎi lán gān bǎi zhàng bīng, chóu yún cǎn dàn wàn lǐ níng。\n zhōng jūn zhì jiǔ yǐn guī kè, hú qín pí pá yǔ qiāng dí。\n fēn fēn mù xuě xià yuán mén, fēng chè hóng qí dòng bú fān。\n lún tái dōng mén sòng jūn qù, qù shí xuě mǎn tiān shān lù。\n shān huí lù zhuǎn bú jiàn jūn, xuě shàng kōng liú mǎ xíng chù。'
    },
    {
      id: 85,
      title: '韦讽录事宅观曹将军画马图',
      author: '杜甫',
      content: '国初已来画鞍马，神妙独数江都王。\n将军得名三十载，人间又见真乘黄。\n曾貌先帝照夜白，龙池十日飞霹雳。\n内府殷红玛瑙盘，婕妤传诏才人索。\n盘赐将军拜舞归，轻纨细绮相追飞。\n贵戚权门得笔迹，始觉屏障生光辉。\n昔日太宗拳毛騧，近时郭家狮子花。\n今之新图有二马，复令识者久叹嗟。\n此皆骑战一敌万，缟素漠漠开风沙。\n其余七匹亦殊绝，迥若寒空动烟雪。\n霜蹄蹴踏长楸间，马官厮养森成列。\n可怜九马争神骏，顾视清高气深稳。\n借问苦心爱者谁，后有韦讽前支遁。\n忆昔巡幸新丰宫，翠华拂网尘蒙蒙。\n五马并驱攒八蹄，二马宛颈劵不得。\n是何意态雄且杰，骏尾萧梢朔风起。\n毛为绿缥两耳黄，眼有紫焰双瞳方。\n矫矫龙性合变化，卓立天骨森开张。\n伊昔太仆张景顺，监牧手出天开王。\n内府殷红玛瑙盘，婕妤传诏才人索。\n至尊含笑催赐金，圉人太仆皆惆怅。\n弟子韩干早入室，亦能画马穷殊相。\n干惟画肉不画骨，忍使骅骝气凋丧。\n将军画善盖有神，必逢真龙作帝王。\n斯图邂逅得再拜，摩挲谛视神飞扬。\n至尊含笑催赐金，圉人太仆皆惆怅。\n弟子韩干早入室，亦能画马穷殊相。\n干惟画肉不画骨，忍使骅骝气凋丧。\n将军画善盖有神，必逢真龙作帝王。\n斯图邂逅得再拜，摩挲谛视神飞扬。\n开元之中常引见，承恩数上南薰殿。\n凌烟功臣少颜色，将军下笔开生面。\n良相头上进贤冠，猛将腰间大羽箭。\n褒公鄂公毛发动，英姿飒爽来酣战。\n先帝天马玉花骢，画工如山貌不同。\n是日牵来赤墀下，迥立阊阖生长风。\n诏谓将军拂绢素，意匠惨澹经营中。\n斯须九重真龙出，一洗万古凡马空。',
      pinyin: 'guó chū yǐ lái huà ān mǎ, shén miào dú shù jiāng dōu wáng。\n jiāng jūn dé míng sān shí zǎi, rén jiān yòu jiàn zhēn chéng huáng。\n céng mào xiān dì zhào yè bái, lóng chí shí rì fēi pī lì。\n nèi fǔ yīn hóng mǎ nǎo pán, jié yú chuán zhào cái rén suǒ。\n pán cì jiāng jūn bài wǔ guī, qīng wán xì qǐ xiāng zhuī fēi。\n guì qī quán mén dé bǐ jì, shǐ jué píng zhàng shēng guāng huī。\n xī rì tài zōng quán máo guā, jìn shí guō jiā shī zǐ huā。\n jīn zhī xīn tú yǒu èr mǎ, fù lìng shí zhě jiǔ tàn jiē。\n cǐ jiē qí zhàn yī dí wàn, gǎo sù mò mò kāi fēng shā。\n qí yú qī pǐ yì shū jué, jiǒng ruò hán kōng dòng yān xuě。\n shuāng tí cù tà cháng qiū jiān, mǎ guān sī yǎng sēn chéng liè。\n kě lián jiǔ mǎ zhēng shén jùn, gù shì qīng gāo qì shēn wěn。\n jiè wèn kǔ xīn ài zhě shuí, hòu yǒu wéi fěng qián zhī dùn。\n yì xī xún xìng xīn fēng gōng, cuì huá fú wǎng chén méng méng。\n wǔ mǎ bìng qū zǎn bā tí, èr mǎ wǎn jǐng juàn bù dé。\n shì hé yì tài xióng qiě jié, jùn wěi xiāo shāo shuò fēng qǐ。\n máo wéi lǜ piāo liǎng ěr huáng, yǎn yǒu zǐ yàn shuāng tóng fāng。\n jiǎo jiǎo lóng xìng hé biàn huà, zhuó lì tiān gǔ sēn kāi zhāng。\n yī xī tài pú zhāng jǐng shùn, jiān mù shǒu chū tiān kāi wáng。\n nèi fǔ yīn hóng mǎ nǎo pán, jié yú chuán zhào cái rén suǒ。\n zhì zūn hán xiào cuī cì jīn, yǔ rén tài pú jiē chóu chàng。\n dì zǐ hán gàn zǎo rù shì, yì néng huà mǎ qióng shū xiàng。\n gàn wéi huà ròu bù huà gǔ, rěn shǐ huá liú qì diāo sàng。\n jiāng jūn huà shàn gài yǒu shén, bì féng zhēn lóng zuò dì wáng。\n sī tú xiè hòu dé zài bài, mó suō dì shì shén fēi yáng。\n zhì zūn hán xiào cuī cì jīn, yǔ rén tài pú jiē chóu chàng。\n dì zǐ hán gàn zǎo rù shì, yì néng huà mǎ qióng shū xiàng。\n gàn wéi huà ròu bù huà gǔ, rěn shǐ huá liú qì diāo sàng。\n jiāng jūn huà shàn gài yǒu shén, bì féng zhēn lóng zuò dì wáng。\n sī tú xiè hòu dé zài bài, mó suō dì shì shén fēi yáng。\n kāi yuán zhī zhōng cháng yǐn jiàn, chéng ēn shù shàng nán xūn diàn。\n líng yān gōng chén shǎo yán sè, jiāng jūn xià bǐ kāi shēng miàn。\n liáng xiàng tóu shàng jìn xián guàn, měng jiàng yāo jiān dà yǔ jiàn。\n bāo gōng è gōng máo fā dòng, yīng zī sà shuǎng lái hān zhàn。\n xiān dì tiān mǎ yù huā cōng, huà gōng rú shān mào bù tóng。\n shì rì qiān lái chì chí xià, jiǒng lì chāng hé shēng zhǎng fēng。\n zhào wèi jiāng jūn fú juàn sù, yì jiàng cǎn dàn jīng yíng zhōng。\n sī xū jiǔ chóng zhēn lóng chū, yī xǐ wàn gǔ fán mǎ kōng。'
    },
    {
      id: 86,
      title: '丹青引赠曹将军霸',
      author: '杜甫',
      content: '将军魏武之子孙，于今为庶为清门。\n英雄割据虽已矣，文采风流今尚存。\n学书初学卫夫人，但恨无过王右军。\n丹青不知老将至，富贵于我如浮云。\n开元之中常引见，承恩数上南薰殿。\n凌烟功臣少颜色，将军下笔开生面。\n良相头上进贤冠，猛将腰间大羽箭。\n褒公鄂公毛发动，英姿飒爽来酣战。\n先帝天马玉花骢，画工如山貌不同。\n是日牵来赤墀下，迥立阊阖生长风。\n诏谓将军拂绢素，意匠惨澹经营中。\n斯须九重真龙出，一洗万古凡马空。\n玉花却在御榻上，榻上庭前屹相向。\n至尊含笑催赐金，圉人太仆皆惆怅。\n弟子韩干早入室，亦能画马穷殊相。\n干惟画肉不画骨，忍使骅骝气凋丧。\n将军画善盖有神，必逢真龙作帝王。\n途穷反遭俗眼白，世上未有如公贫。\n但看古来盛名下，终日坎壈缠其身。',
      pinyin: 'jiāng jūn wèi wǔ zhī zǐ sūn, yú jīn wéi shù wéi qīng mén。\n yīng xióng gē jù suī yǐ yǐ, wén cǎi fēng liú jīn shàng cún。\n xué shū chū xué wèi fū rén, dàn hèn wú guò wáng yòu jūn。\n dān qīng bú zhī lǎo jiàng zhì, fù guì yú wǒ rú fú yún。\n kāi yuán zhī zhōng cháng yǐn jiàn, chéng ēn shù shàng nán xūn diàn。\n líng yān gōng chén shǎo yán sè, jiāng jūn xià bǐ kāi shēng miàn。\n liáng xiàng tóu shàng jìn xián guàn, měng jiàng yāo jiān dà yǔ jiàn。\n bāo gōng è gōng máo fā dòng, yīng zī sà shuǎng lái hān zhàn。\n xiān dì tiān mǎ yù huā cōng, huà gōng rú shān mào bù tóng。\n shì rì qiān lái chì chí xià, jiǒng lì chāng hé shēng zhǎng fēng。\n zhào wèi jiāng jūn fú juàn sù, yì jiàng cǎn dàn jīng yíng zhōng。\n sī xū jiǔ chóng zhēn lóng chū, yī xǐ wàn gǔ fán mǎ kōng。\n yù huā què zài yù tà shàng, tà shàng tíng qián yì xiāng xiàng。\n zhì zūn hán xiào cuī cì jīn, yǔ rén tài pú jiē chóu chàng。\n dì zǐ hán gàn zǎo rù shì, yì néng huà mǎ qióng shū xiàng。\n gàn wéi huà ròu bù huà gǔ, rěn shǐ huá liú qì diāo sàng。\n jiāng jūn huà shàn gài yǒu shén, bì féng zhēn lóng zuò dì wáng。\n tú qióng fǎn zāo sú yǎn bái, shì shàng wèi yǒu rú gōng pín。\n dàn kàn gǔ lái shèng míng xià, zhōng rì kǎn lǎn chán qí shēn。'
    },
    {
      id: 87,
      title: '寄韩谏议注',
      author: '杜甫',
      content: '今我不乐思岳阳，身欲奋飞病在床。\n美人娟娟隔秋水，濯足洞庭望八荒。\n鸿飞冥冥日月白，青枫叶赤天雨霜。\n玉京群帝集北斗，或骑麒麟翳凤凰。\n芙蓉旌旗烟雾落，影动倒景摇潇湘。\n星宫之君醉琼浆，羽人稀少不在旁。\n似闻昨者赤松子，恐是汉代韩张良。\n昔随刘氏定长安，帷幄未改神惨伤。\n国家成败吾岂敢，色难腥腐餐枫香。\n周南留滞古所惜，南极老人应寿昌。\n美人胡为隔秋水，焉得置之贡玉堂。',
      pinyin: 'jīn wǒ bù lè sī yuè yáng, shēn yù fèn fēi bìng zài chuáng。\n měi rén juān juān gé qiū shuǐ, zhuó zú dòng tíng wàng bā huāng。\n hóng fēi míng míng rì yuè bái, qīng fēng yè chì tiān yǔ shuāng。\n yù jīng qún dì jí běi dǒu, huò qí qí lín yì fèng huáng。\n fú róng jīng qí yān wù luò, yǐng dòng dào jǐng yáo xiāo xiāng。\n xīng gōng zhī jūn zuì qióng jiāng, yǔ rén xī shǎo bú zài páng。\n sì wén zuó zhě chì sōng zǐ, kǒng shì hàn dài hán zhāng liáng。\n xī suí liú shì dìng cháng ān, wéi wò wèi gǎi shén cǎn shāng。\n guó jiā chéng bài wú qǐ gǎn, sè nán xīng fǔ cān fēng xiāng。\n zhōu nán liú zhì gǔ suǒ xī, nán jí lǎo rén yīng shòu chāng。\n měi rén hú wéi gé qiū shuǐ, yān dé zhì zhī gòng yù táng。'
    },
    {
      id: 88,
      title: '古柏行',
      author: '杜甫',
      content: '孔明庙前有老柏，柯如青铜根如石。\n霜皮溜雨四十围，黛色参天二千尺。\n君臣已与时际会，树木犹为人爱惜。\n云来气接巫峡长，月出寒通雪山白。\n忆昨路绕锦亭东，先主武侯同閟宫。\n崔嵬枝干郊原古，窈窕丹青户牖空。\n落落盘踞虽得地，冥冥孤高多烈风。\n扶持自是神明力，正直原因造化工。\n大厦如倾要梁栋，万牛回首丘山重。\n不露文章世已惊，未辞翦伐谁能送？\n苦心岂免容蝼蚁，香叶终经宿鸾凤。\n志士幽人莫怨嗟，古来材大难为用。',
      pinyin: 'kǒng míng miào qián yǒu lǎo bǎi, kē rú qīng tóng gēn rú shí。\n shuāng pí liū yǔ sì shí wéi, dài sè cān tiān èr qiān chǐ。\n jūn chén yǐ yǔ shí jì huì, shù mù yóu wéi rén ài xī。\n yún lái qì jiē wū xiá cháng, yuè chū hán tōng xuě shān bái。\n yì zuó lù rào jǐn tíng dōng, xiān zhǔ wǔ hóu tóng bì gōng。\n cuī wéi zhī gàn jiāo yuán gǔ, yǎo tiǎo dān qīng hù yǒu kōng。\n luò luò pán jù suī dé dì, míng míng gū gāo duō liè fēng。\n fú chí zì shì shén míng lì, zhèng zhí yuán yīn zào huà gōng。\n dà shà rú qīng yào liáng dòng, wàn niú huí shǒu qiū shān zhòng。\n bú lù wén zhāng shì yǐ jīng, wèi cí jiǎn fá shuí néng sòng?\n kǔ xīn qǐ miǎn róng lóu yǐ, xiāng yè zhōng jīng xiǔ luán fèng。\n zhì shì yōu rén mò yuàn jiē, gǔ lái cái dà nán wéi yòng。'
    },
    {
      id: 89,
      title: '观公孙大娘弟子舞剑器行',
      author: '杜甫',
      content: '昔有佳人公孙氏，一舞剑器动四方。\n观者如山色沮丧，天地为之久低昂。\n㸌如羿射九日落，矫如群帝骖龙翔。\n来如雷霆收震怒，罢如江海凝清光。\n绛唇珠袖两寂寞，晚有弟子传芬芳。\n临颍美人在白帝，妙舞此曲神扬扬。\n与余问答既有以，感时抚事增惋伤。\n先帝侍女八千人，公孙剑器初第一。\n五十年间似反掌，风尘澒洞昏王室。\n梨园子弟散如烟，女乐余姿映寒日。\n金粟堆前木已拱，瞿唐石城草萧瑟。\n玳筵急管曲复终，乐极哀来月东出。\n老夫不知其所往，足茧荒山转愁疾。',
      pinyin: 'xī yǒu jiā rén gōng sūn shì, yī wǔ jiàn qì dòng sì fāng。\n guān zhě rú shān sè jǔ sàng, tiān dì wéi zhī jiǔ dī áng。\n huò rú yì shè jiǔ rì luò, jiǎo rú qún dì cān lóng xiáng。\n lái rú léi tíng shōu zhèn nù, bà rú jiāng hǎi níng qīng guāng。\n jiàng chún zhū xiù liǎng jì mò, wǎn yǒu dì zǐ chuán fēn fāng。\n lín yǐng měi rén zài bái dì, miào wǔ cǐ qǔ shén yáng yáng。\n yǔ yú wèn dá jì yǒu yǐ, gǎn shí fǔ shì zēng wǎn shāng。\n xiān dì shì nǚ bā qiān rén, gōng sūn jiàn qì chū dì yī。\n wǔ shí nián jiān sì fǎn zhǎng, fēng chén hòng dòng hūn wáng shì。\n lí yuán zǐ dì sàn rú yān, nǚ lè yú zī yìng hán rì。\n jīn sù duī qián mù yǐ gǒng, qú táng shí chéng cǎo xiāo sè。\n dài yán jí guǎn qǔ fù zhōng, lè jí āi lái yuè dōng chū。\n lǎo fū bú zhī qí suǒ wǎng, zú jiǎn huāng shān zhuǎn chóu jí。'
    },
    {
      id: 90,
      title: '石鱼湖上醉歌',
      author: '元结',
      content: '漫叟以公田酿酒，因休暇，载酒于湖上，时取一醉。\n欢醉中，据湖岸，引臂向鱼取酒，使舫载之，遍饮坐者。\n意疑倚巴丘酌于君山之上，诸子环洞庭而坐，酒舫泛泛然，触波涛而往来者，非耶？\n古之醉者，诚有是哉！\n石鱼湖，似洞庭，夏水欲满君山青。\n山为樽，水为沼，酒徒历历坐洲岛。\n长风连日作大浪，不能废人运酒舫。\n我持长瓢坐巴丘，酌饮四坐以散愁。',
      pinyin: 'màn sǒu yǐ gōng tián niàng jiǔ, yīn xiū xiá, zài jiǔ yú hú shàng, shí qǔ yī zuì。\n huān zuì zhōng, jù hú àn, yǐn bì xiàng yú qǔ jiǔ, shǐ fǎng zǎi zhī, biàn yǐn zuò zhě。\n yì yí yǐ bā qiū zhuó yú jūn shān zhī shàng, zhū zǐ huán dòng tíng ér zuò, jiǔ fǎng fàn fàn rán, chù bō tāo ér wǎng lái zhě, fēi yé?\n gǔ zhī zuì zhě, chéng yǒu shì zāi!\n shí yú hú, sì dòng tíng, xià shuǐ yù mǎn jūn shān qīng。\n shān wéi zūn, shuǐ wéi zhǎo, jiǔ tú lì lì zuò zhōu dǎo。\n cháng fēng lián rì zuò dà làng, bú néng fèi rén yùn jiǔ fǎng。\n wǒ chí cháng piáo zuò bā qiū, zhuó yǐn sì zuò yǐ sàn chóu。'
    },
    {
      id: 91,
      title: '山石',
      author: '韩愈',
      content: '山石荦确行径微，黄昏到寺蝙蝠飞。\n升堂坐阶新雨足，芭蕉叶大栀子肥。\n僧言古壁佛画好，以火来照所见稀。\n铺床拂席置羹饭，疏粝亦足饱我饥。\n夜深静卧百虫绝，清月出岭光入扉。\n天明独去无道路，出入高下穷烟霏。\n山红涧碧纷烂漫，时见松枥皆十围。\n当流赤白兼千鱼，溪荪兰芷与之齐。\n人生如此自可乐，岂必局束为人鞿？\n嗟哉吾党二三子，安得至老不更归。',
      pinyin: 'shān shí luò què xíng jìng wēi, huáng hūn dào sì biān fú fēi。\n shēng táng zuò jiē xīn yǔ zú, bā jiāo yè dà zhī zǐ féi。\n sēng yán gǔ bì fó huà hǎo, yǐ huǒ lái zhào suǒ jiàn xī。\n pū chuáng fú xí zhì gēng fàn, shū lì yì zú bǎo wǒ jī。\n yè shēn jìng wò bǎi chóng jué, qīng yuè chū lǐng guāng rù fēi。\n tiān míng dú qù wú dào lù, chū rù gāo xià qióng yān fēi。\n shān hóng jiàn bì fēn làn màn, shí jiàn sōng lì jiē shí wéi。\n dāng liú chì bái jiān qiān yú, xī sūn lán zhǐ yǔ zhī qí。\n rén shēng rú cǐ zì kě lè, qǐ bì jú shù wéi rén jī?\n jiē zāi wú dǎng èr sān zǐ, ān dé zhì lǎo bú gèng guī。'
    },
    {
      id: 92,
      title: '八月十五夜赠张功曹',
      author: '韩愈',
      content: '纤云四卷天无河，清风吹空月舒波。\n沙平水息声影绝，一杯相属君当歌。\n君歌声酸辞且苦，不能听终泪如雨。\n洞庭连天九疑高，蛟龙出没猩鼯号。\n十生九死到官所，幽居默默如藏逃。\n下床畏蛇食畏药，海气湿蛰熏腥臊。\n昨者州前捶大鼓，嗣皇继圣登夔皋。\n赦书一日行万里，罪从大辟皆除死。\n迁者追回流者还，涤瑕荡垢清朝班。\n州家申名使家抑，坎轲只得移荆蛮。\n判司卑官不堪说，未免捶楚尘埃间。\n同时辈流多上道，天路幽险难追攀。\n君歌且休听我歌，我歌今与君殊科。\n一年明月今宵多，人生由命非由他。\n有酒不饮奈明何。',
      pinyin: 'xiān yún sì juǎn tiān wú hé, qīng fēng chuī kōng yuè shū bō。\n shā píng shuǐ xī shēng yǐng jué, yī bēi xiāng zhǔ jūn dāng gē。\n jūn gē shēng suān cí qiě kǔ, bù néng tīng zhōng lèi rú yǔ。\n dòng tíng lián tiān jiǔ yí gāo, jiāo lóng chū mò xīng wú hào。\n shí shēng jiǔ sǐ dào guān suǒ, yōu jū mò mò rú cáng táo。\n xià chuáng wèi shé shí wèi yào, hǎi qì shī zhé xūn xīng sāo。\n zuó zhě zhōu qián chuí dà gǔ, sì huáng jì shèng dēng kuí gāo。\n shè shū yī rì xíng wàn lǐ, zuì cóng dà pì jiē chú sǐ。\n qiān zhě zhuī huí liú zhě hái, dí xiá dàng gòu qīng cháo bān。\n zhōu jiā shēn míng shǐ jiā yì, kǎn kě zhǐ dé yí jīng mán。\n pàn sī bēi guān bú kān shuō, wèi miǎn chuí chǔ chén āi jiān。\n tóng shí bèi liú duō shàng dào, tiān lù yōu xiǎn nán zhuī pān。\n jūn gē qiě xiū tīng wǒ gē, wǒ gē jīn yǔ jūn shū kē。\n yī nián míng yuè jīn xiāo duō, rén shēng yóu mìng fēi yóu tā。\n yǒu jiǔ bú yǐn nài míng hé。'
    },
    {
      id: 93,
      title: '谒衡岳庙遂宿岳寺题门楼',
      author: '韩愈',
      content: '五岳祭秩皆三公，四方环镇嵩当中。\n火维地荒足妖怪，天假神柄专其雄。\n喷云泄雾藏半腹，虽有绝顶谁能穷？\n我来正逢秋雨节，阴气晦昧无清风。\n潜心默祷若有应，岂非正直能感通！\n须臾静扫众峰出，仰见突兀撑青空。\n紫盖连延接天柱，石廪腾掷堆祝融。\n森然魄动下马拜，松柏一径趋灵宫。\n粉墙丹柱动光彩，鬼物图画填青红。\n升阶伛偻荐脯酒，欲以菲薄明其衷。\n庙令老人识神意，睢盱侦伺能鞠躬。\n手持杯珓导我掷，云此最吉余难同。\n窜逐蛮荒幸不死，衣食才足甘长终。\n侯王将相望久绝，神纵欲福难为功。\n夜投佛寺上高阁，星月掩映云曈昽。\n猿鸣钟动不知曙，杲杲寒日生于东。',
      pinyin: 'wǔ yuè jì zhì jiē sān gōng, sì fāng huán zhèn sōng dāng zhōng。\n huǒ wéi dì huāng zú yāo guài, tiān jiǎ shén bǐng zhuān qí xióng。\n pēn yún xiè wù cáng bàn fù, suī yǒu jué dǐng shuí néng qióng?\n wǒ lái zhèng féng qiū yǔ jié, yīn qì huì mèi wú qīng fēng。\n qián xīn mò dǎo ruò yǒu yìng, qǐ fēi zhèng zhí néng gǎn tōng!\n xū yú jìng sǎo zhòng fēng chū, yǎng jiàn tū wù chēng qīng kōng。\n zǐ gài lián yán jiē tiān zhù, shí lǐn téng zhì duī zhù róng。\n sēn rán pò dòng xià mǎ bài, sōng bǎi yī jìng qū líng gōng。\n fěn qiáng dān zhù dòng guāng cǎi, guǐ wù tú huà tián qīng hóng。\n shēng jiē yǔ lǚ jiàn fǔ jiǔ, yù yǐ fěi bó míng qí zhōng。\n miào lìng lǎo rén shí shén yì, suī xū zhēn sì néng jū gōng。\n shǒu chí bēi jiào dǎo wǒ zhì, yún cǐ zuì jí yú nán tóng。\n cuàn zhú mán huāng xìng bú sǐ, yī shí cái zú gān cháng zhōng。\n hóu wáng jiàng xiàng wàng jiǔ jué, shén zòng yù fú nán wéi gōng。\n yè tóu fó sì shàng gāo gé, xīng yuè yǎn yìng yún tóng lóng。\n yuán míng zhōng dòng bú zhī shǔ, gǎo gǎo hán rì shēng yú dōng。'
    },
    {
      id: 94,
      title: '石鼓歌',
      author: '韩愈',
      content: '张生手持石鼓文，劝我试作石鼓歌。\n少陵无人谪仙死，才薄将奈石鼓何。\n周纲凌迟四海沸，宣王愤起挥天戈。\n大开明堂受朝贺，诸侯剑佩鸣相磨。\n蒐于岐阳骋雄俊，万里禽兽皆遮罗。\n镌功勒成告万世，凿石作鼓隳嵯峨。\n从臣才艺咸第一，拣选撰刻留山阿。\n雨淋日灸野火燎，鬼物守护烦撝呵。\n公从何处得纸本，毫发尽备无差讹。\n辞严义密读难晓，字体不类隶与蝌。\n年深岂免有缺画，快剑斫断生蛟鼍。\n鸾翔凤翥众仙下，珊瑚碧树交枝柯。\n金绳铁索锁钮壮，古鼎跃水龙腾梭。\n陋儒编诗不收入，二雅褊迫无委蛇。\n孔子西行不到秦，掎摭星宿遗羲娥。\n嗟余好古生苦晚，对此涕泪双滂沱。\n忆昔初蒙博士征，其年始改称元和。\n故人从军在右辅，为我度量掘臼科。\n濯冠沐浴告祭酒，如此至宝存岂多。\n毡包席裹可立致，十鼓只载数骆驼。\n荐诸太庙比郜鼎，光价岂止百倍过。\n圣恩若许留太学，诸生讲解得切磋。\n观经鸿都尚填咽，坐见举国来奔波。\n剜苔剔藓露节角，安置妥帖平不颇。\n大厦深檐与盖覆，经历久远期无佗。\n中朝大官老于事，讵肯感激徒媕婀。\n牧童敲火牛砺角，谁复著手为摩挲。\n日销月铄就埋没，六年西顾空吟哦。\n羲之俗书趁姿媚，数纸尚可博白鹅。\n继周八代争战多，天子蒙尘不得所。\n贤侯劝农天子忧，庙堂决策由公卿。\n安能以此尚论列，愿借辩口如悬河。\n石鼓之歌止于此，呜呼吾意其蹉跎。',
      pinyin: 'zhāng shēng shǒu chí shí gǔ wén, quàn wǒ shì zuò shí gǔ gē。\n shǎo líng wú rén zhé xiān sǐ, cái báo jiāng nài shí gǔ hé。\n zhōu gāng líng chí sì hǎi fèi, xuān wáng fèn qǐ huī tiān gē。\n dà kāi míng táng shòu cháo hè, zhū hóu jiàn pèi míng xiāng mó。\n sōu yú qí yáng chěng xióng jùn, wàn lǐ qín shòu jiē zhē luó。\n juān gōng lè chéng gào wàn shì, záo shí zuò gǔ huī cuó é。\n cóng chén cái yì xián dì yī, jiǎn xuǎn zhuàn kè liú shān ā。\n yǔ lín rì jiǔ yě huǒ liáo, guǐ wù shǒu hù fán huī hē。\n gōng cóng hé chù dé zhǐ běn, háo fà jìn bèi wú chāi é。\n cí yán yì mì dú nán xiǎo, zì tǐ bú lèi lì yǔ kē。\n nián shēn qǐ miǎn yǒu quē huà, kuài jiàn zhuó duàn shēng jiāo tuó。\n luán xiáng fèng zhù zhòng xiān xià, shān hú bì shù jiāo zhī kē。\n jīn shéng tiě suǒ suǒ niǔ zhuàng, gǔ dǐng yuè shuǐ lóng téng suō。\n lòu rú biān shī bú shōu rù, èr yǎ biǎn pò wú wěi shé。\n kǒng zǐ xī xíng bú dào qín, jǐ zhí xīng xiù yí xī é。\n jiē yú hào gǔ shēng kǔ wǎn, duì cǐ tì lèi shuāng pāng tuó。\n yì xī chū méng bó shì zhēng, qí nián shǐ gǎi chēng yuán hé。\n gù rén cóng jūn zài yòu fǔ, wéi wǒ dù liàng jué jiù kē。\n zhuó guàn mù yù gào jì jiǔ, rú cǐ zhì bǎo cún qǐ duō。\n zhān bāo xí guǒ kě lì zhì, shí gǔ zhǐ zài shù luò tuó。\n jiàn zhū tài miào bǐ gào dǐng, guāng jià qǐ zhǐ bǎi bèi guò。\n shèng ēn ruò xǔ liú tài xué, zhū shēng jiǎng jiě dé qiē cuō。\n guān jīng hóng dōu shàng tián yàn, zuò jiàn jǔ guó lái bēn bō。\n wān tái tī xiǎn lù jié jiǎo, ān zhì tuǒ tiē píng bú pō。\n dà shà shēn yán yǔ gài fù, jīng lì jiǔ yuǎn qī wú tuó。\n zhōng cháo dà guān lǎo yú shì, jù kěn gǎn jī tú ān ē。\n mù tóng qiāo huǒ niú lì jiǎo, shuí fù zhuó shǒu wéi mó suō。\n rì xiāo yuè shuò jiù mái mò, liù nián xī gù kōng yín é。\n xī zhī sú shū chèn zī mèi, shù zhǐ shàng kě bó bái é。\n jì zhōu bā dài zhēng zhàn duō, tiān zǐ méng chén bú dé suǒ。\n xián hóu quàn nóng tiān zǐ yōu, miào táng jué cè yóu gōng qīng。\n ān néng yǐ cǐ shàng lùn liè, yuàn jiè biàn kǒu rú xuán hé。\n shí gǔ zhī gē zhǐ yú cǐ, wū hū wú yì qí cuō tuó。'
    },
    {
      id: 95,
      title: '渔翁',
      author: '柳宗元',
      content: '渔翁夜傍西岩宿，晓汲清湘燃楚竹。\n烟销日出不见人，欸乃一声山水绿。\n回看天际下中流，岩上无心云相逐。',
      pinyin: 'yú wēng yè bàng xī yán sù, xiǎo jí qīng xiāng rán chǔ zhú。\n yān xiāo rì chū bú jiàn rén, ǎi nǎi yī shēng shān shuǐ lǜ。\n huí kàn tiān jì xià zhōng liú, yán shàng wú xīn yún xiāng zhú。'
    },
    {
      id: 96,
      title: '长恨歌',
      author: '白居易',
      content: '汉皇重色思倾国，御宇多年求不得。\n杨家有女初长成，养在深闺人未识。\n天生丽质难自弃，一朝选在君王侧。\n回眸一笑百媚生，六宫粉黛无颜色。\n春寒赐浴华清池，温泉水滑洗凝脂。\n侍儿扶起娇无力，始是新承恩泽时。\n云鬓花颜金步摇，芙蓉帐暖度春宵。\n春宵苦短日高起，从此君王不早朝。\n承欢侍宴无闲暇，春从春游夜专夜。\n后宫佳丽三千人，三千宠爱在一身。\n金屋妆成娇侍夜，玉楼宴罢醉和春。\n姊妹弟兄皆列土，可怜光彩生门户。\n遂令天下父母心，不重生男重生女。\n骊宫高处入青云，仙乐风飘处处闻。\n缓歌慢舞凝丝竹，尽日君王看不足。\n渔阳鼙鼓动地来，惊破霓裳羽衣曲。\n九重城阙烟尘生，千乘万骑西南行。\n翠华摇摇行复止，西出都门百余里。\n六军不发无奈何，宛转蛾眉马前死。\n花钿委地无人收，翠翘金雀玉搔头。\n君王掩面救不得，回看血泪相和流。\n黄埃散漫风萧索，云栈萦纡登剑阁。\n峨嵋山下少人行，旌旗无光日色薄。\n蜀江水碧蜀山青，圣主朝朝暮暮情。\n行宫见月伤心色，夜雨闻铃肠断声。\n天旋地转回龙驭，到此踌躇不能去。\n马嵬坡下泥土中，不见玉颜空死处。\n君臣相顾尽沾衣，东望都门信马归。\n归来池苑皆依旧，太液芙蓉未央柳。\n芙蓉如面柳如眉，对此如何不泪垂？\n春风桃李花开日，秋雨梧桐叶落时。\n西宫南内多秋草，落叶满阶红不扫。\n梨园子弟白发新，椒房阿监青娥老。\n夕殿萤飞思悄然，孤灯挑尽未成眠。\n迟迟钟鼓初长夜，耿耿星河欲曙天。\n鸳鸯瓦冷霜华重，翡翠衾寒谁与共？\n悠悠生死别经年，魂魄不曾来入梦。\n临邛道士鸿都客，能以精诚致魂魄。\n为感君王辗转思，遂教方士殷勤觅。\n排空驭气奔如电，升天入地求之遍。\n上穷碧落下黄泉，两处茫茫皆不见。\n忽闻海上有仙山，山在虚无缥缈间。\n楼阁玲珑五云起，其中绰约多仙子。\n中有一人字太真，雪肤花貌参差是。\n金阙西厢叩玉扃，转教小玉报双成。\n闻道汉家天子使，九华帐里梦魂惊。\n揽衣推枕起徘徊，珠箔银屏迤逦开。\n云鬓半偏新睡觉，花冠不整下堂来。\n风吹仙袂飘飖举，犹似霓裳羽衣舞。\n玉容寂寞泪阑干，梨花一枝春带雨。\n含情凝睇谢君王，一别音容两渺茫。\n昭阳殿里恩爱绝，蓬莱宫中日月长。\n回头下望人寰处，不见长安见尘雾。\n惟将旧物表深情，钿合金钗寄将去。\n钗留一股合一扇，钗擘黄金合分钿。\n但教心似金钿坚，天上人间会相见。\n临别殷勤重寄词，词中有誓两心知。\n七月七日长生殿，夜半无人私语时。\n在天愿作比翼鸟，在地愿为连理枝。\n天长地久有时尽，此恨绵绵无绝期。',
      pinyin: 'hàn huáng zhòng sè sī qīng guó, yù yǔ duō nián qiú bù dé。\n yáng jiā yǒu nǚ chū zhǎng chéng, yǎng zài shēn guī rén wèi shí。\n tiān shēng lì zhì nán zì qì, yī zhāo xuǎn zài jūn wáng cè。\n huí móu yī xiào bǎi mèi shēng, liù gōng fěn dài wú yán sè。\n chūn hán cì yù huá qīng chí, wēn quán shuǐ huá xǐ níng zhī。\n shì ér fú qǐ jiāo wú lì, shǐ shì xīn chéng ēn zé shí。\n yún bìn huā yán jīn bù yáo, fú róng zhàng nuǎn dù chūn xiāo。\n chūn xiāo kǔ duǎn rì gāo qǐ, cóng cǐ jūn wáng bù zǎo cháo。\n chéng huān shì yàn wú xián xiá, chūn cóng chūn yóu yè zhuān yè。\n hòu gōng jiā lì sān qiān rén, sān qiān chǒng ài zài yī shēn。\n jīn wū zhuāng chéng jiāo shì yè, yù lóu yàn bà zuì hé chūn。\n zǐ mèi dì xiōng jiē liè tǔ, kě lián guāng cǎi shēng mén hù。\n suì lìng tiān xià fù mǔ xīn, bù chóng shēng nán chóng shēng nǚ。\n lí gōng gāo chù rù qīng yún, xiān lè fēng piāo chù chù wén。\n huǎn gē màn wǔ níng sī zhú, jìn rì jūn wáng kàn bù zú。\n yú yáng pí gǔ dòng dì lái, jīng pò ní cháng yǔ yī qǔ。\n jiǔ chóng chéng què yān chén shēng, qiān shèng wàn qí xī nán xíng。\n cuì huá yáo yáo xíng fù zhǐ, xī chū dōu mén bǎi yú lǐ。\n liù jūn bù fā wú nài hé, wǎn zhuǎn é méi mǎ qián sǐ。\n huā diàn wěi dì wú rén shōu, cuì qiào jīn què yù sāo tóu。\n jūn wáng yǎn miàn jiù bù dé, huí kàn xuè lèi xiāng hé liú。\n huáng āi sàn màn fēng xiāo suǒ, yún zhàn yíng yū dēng jiàn gé。\n é méi shān xià shǎo rén xíng, jīng qí wú guāng rì sè báo。\n shǔ jiāng shuǐ bì shǔ shān qīng, shèng zhǔ zhāo zhāo mù mù qíng。\n xíng gōng jiàn yuè shāng xīn sè, yè yǔ wén líng cháng duàn shēng。\n tiān xuán dì zhuǎn huí lóng yù, dào cǐ chóu chú bù néng qù。\n mǎ wéi pō xià ní tǔ zhōng, bú jiàn yù yán kōng sǐ chù。\n jūn chén xiāng gù jìn zhān yī, dōng wàng dōu mén xìn mǎ guī。\n guī lái chí yuàn jiē yī jiù, tài yè fú róng wèi yāng liǔ。\n fú róng rú miàn liǔ rú méi, duì cǐ rú hé bù lèi chuí？\n chūn fēng táo lǐ huā kāi rì, qiū yǔ wú tóng yè luò shí。\n xī gōng nán nèi duō qiū cǎo, luò yè mǎn jiē hóng bù sǎo。\n lí yuán zǐ dì bái fà xīn, jiāo fáng ā jiān qī é lǎo。\n xī diàn yíng fēi sī qiǎo rán, gū dēng tiǎo jìn wèi chéng mián。\n chí chí zhōng gǔ chū cháng yè, gěng gěng xīng hé yù shǔ tiān。\n yuān yāng wǎ lěng shuāng huá zhòng, fěi cuì qīn hán shuí yǔ gòng？\n yōu yōu shēng sǐ bié jīng nián, hún pò bù céng lái rù mèng。\n lín qióng dào shì hóng dōu kè, néng yǐ jīng chéng zhì hún pò。\n wéi gǎn jūn wáng zhǎn zhuǎn sī, suì jiào fāng shì yīn qín mì。\n pái kōng yù qì bēn rú diàn, shēng tiān rù dì qiú zhī biàn。\n shàng qióng bì luò xià huáng quán, liǎng chù máng máng jiē bú jiàn。\n hū wén hǎi shàng yǒu xiān shān, shān zài xū wú piāo miǎo jiān。\n lóu gé líng lóng wǔ yún qǐ, qí zhōng chuò yuē duō xiān zǐ。\n zhōng yǒu yī rén zì tài zhēn, xuě fū huā mào cēn cī shì。\n jīn què xī xiāng kòu yù jiōng, zhuǎn jiào xiǎo yù bào shuāng chéng。\n wén dào hàn jiā tiān zǐ shǐ, jiǔ huá zhàng lǐ mèng hún jīng。\n lǎn yī tuī zhěn qǐ pái huái, zhū bó yín píng yǐ lǐ kāi。\n yún bìn bàn piān xīn shuì jiào, huā guàn bù zhěng xià táng lái。\n fēng chuī xiān mèi piāo yáo jǔ, yóu sì ní cháng yǔ yī wǔ。\n yù róng jì mò lèi lán gān, lí huā yī zhī chūn dài yǔ。\n hán qíng níng dì xiè jūn wáng, yī bié yīn róng liǎng miǎo máng。\n zhāo yáng diàn lǐ ēn ài jué, péng lái gōng zhōng rì yuè cháng。\n huí tóu xià wàng rén huán chù, bú jiàn cháng\'ān jiàn chén wù。\n wéi jiāng jiù wù biǎo shēn qíng, diàn hé jīn chāi jì jiāng qù。\n chāi liú yī gǔ hé yī shàn, chāi bāi huáng jīn hé fēn diàn。\n dàn jiào xīn sì jīn diàn jiān, tiān shàng rén jiān huì xiāng jiàn。\n lín bié yīn qín chóng jì cí, cí zhōng yǒu shì liǎng xīn zhī。\n qī yuè qī rì cháng shēng diàn, yè bàn wú rén sī yǔ shí。\n zài tiān yuàn zuò bǐ yì niǎo, zài dì yuàn wéi lián lǐ zhī。\n tiān cháng dì jiǔ yǒu shí jìn, cǐ hèn mián mián wú jué qī。'
    },
    {
      id: 97,
      title: '琵琶行（并序）',
      author: '白居易',
      content: '元和十年，予左迁九江郡司马。明年秋，送客湓浦口，闻舟中夜弹琵琶者，听其音，铮铮然有京都声。问其人，本长安倡女，尝学琵琶于穆、曹二善才，年长色衰，委身为贾人妇。遂命酒，使快弹数曲。曲罢悯然，自叙少小时欢乐事，今漂沦憔悴，转徙于江湖间。予出官二年，恬然自安，感斯人言，是夕始觉有迁谪意。因为长句，歌以赠之，凡六百一十六言，命曰《琵琶行》。\n浔阳江头夜送客，枫叶荻花秋瑟瑟。\n主人下马客在船，举酒欲饮无管弦。\n醉不成欢惨将别，别时茫茫江浸月。\n忽闻水上琵琶声，主人忘归客不发。\n寻声暗问弹者谁？琵琶声停欲语迟。\n移船相近邀相见，添酒回灯重开宴。\n千呼万唤始出来，犹抱琵琶半遮面。\n转轴拨弦三两声，未成曲调先有情。\n弦弦掩抑声声思，似诉平生不得志。\n低眉信手续续弹，说尽心中无限事。\n轻拢慢捻抹复挑，初为《霓裳》后《六幺》。\n大弦嘈嘈如急雨，小弦切切如私语。\n嘈嘈切切错杂弹，大珠小珠落玉盘。\n间关莺语花底滑，幽咽泉流冰下难。\n冰泉冷涩弦凝绝，凝绝不通声暂歇。\n别有幽愁暗恨生，此时无声胜有声。\n银瓶乍破水浆迸，铁骑突出刀枪鸣。\n曲终收拨当心画，四弦一声如裂帛。\n东船西舫悄无言，唯见江心秋月白。\n沉吟放拨插弦中，整顿衣裳起敛容。\n自言本是京城女，家在虾蟆陵下住。\n十三学得琵琶成，名属教坊第一部。\n曲罢曾教善才服，妆成每被秋娘妒。\n五陵年少争缠头，一曲红绡不知数。\n钿头银篦击节碎，血色罗裙翻酒污。\n今年欢笑复明年，秋月春风等闲度。\n弟走从军阿姨死，暮去朝来颜色故。\n门前冷落鞍马稀，老大嫁作商人妇。\n商人重利轻别离，前月浮梁买茶去。\n去来江口守空船，绕船月明江水寒。\n夜深忽梦少年事，梦啼妆泪红阑干。\n我闻琵琶已叹息，又闻此语重唧唧。\n同是天涯沦落人，相逢何必曾相识！\n我从去年辞帝京，谪居卧病浔阳城。\n浔阳地僻无音乐，终岁不闻丝竹声。\n住近湓江地低湿，黄芦苦竹绕宅生。\n其间旦暮闻何物？杜鹃啼血猿哀鸣。\n春江花朝秋月夜，往往取酒还独倾。\n岂无山歌与村笛？呕哑嘲哳难为听。\n今夜闻君琵琶语，如听仙乐耳暂明。\n莫辞更坐弹一曲，为君翻作《琵琶行》。\n感我此言良久立，却坐促弦弦转急。\n凄凄不似向前声，满座重闻皆掩泣。\n座中泣下谁最多？江州司马青衫湿。',
      pinyin: 'yuán hé shí nián, yǔ zuǒ qiān jiǔ jiāng jùn sī mǎ。 míng nián qiū, sòng kè pén pǔ kǒu, wén zhōu zhōng yè tán pí pá zhě, tīng qí yīn, zhēng zhēng rán yǒu jīng dōu shēng。 wèn qí rén, běn cháng\'ān chàng nǚ, cháng xué pí pá yú mù、 cáo èr shàn cái, nián zhǎng sè shuāi, wěi shēn wéi gǔ rén fù。 suì mìng jiǔ, shǐ kuài tán shù qǔ。 qǔ bà mǐn rán, zì xù shào xiǎo shí huān lè shì, jīn piāo lún qiáo cuì, zhuǎn xǐ yú jiāng hú jiān。 yǔ chū guān èr nián, tián rán zì\'ān, gǎn sī rén yán, shì xī shǐ jué yǒu qiān zhé yì。 yīn wéi cháng jù, gē yǐ zèng zhī, fán liù bǎi yī shí liù yán, mìng yuē "pí pá xíng"。\n xún yáng jiāng tóu yè sòng kè, fēng yè dí huā qiū sè sè。\n zhǔ rén xià mǎ kè zài chuán, jǔ jiǔ yù yǐn wú guǎn xián。\n zuì bù chéng huān cǎn jiāng bié, bié shí máng máng jiāng jìn yuè。\n hū wén shuǐ shàng pí pá shēng, zhǔ rén wàng guī kè bù fā。\n xún shēng àn wèn tán zhě shuí？ pí pá shēng tíng yù yǔ chí。\n yí chuán xiāng jìn yāo xiāng jiàn, tiān jiǔ huí dēng chóng kāi yàn。\n qiān hū wàn huàn shǐ chū lái, yóu bào pí pá bàn zhē miàn。\n zhuǎn zhóu bō xián sān liǎng shēng, wèi chéng qǔ diào xiān yǒu qíng。\n xián xián yǎn yì shēng shēng sī, sì sù píng shēng bù dé zhì。\n dī méi xìn shǒu xù xù tán, shuō jìn xīn zhōng wú xiàn shì。\n qīng lǒng màn niǎn mǒ fù tiāo, chū wéi "ní cháng" hòu "liù yāo"。\n dà xián cáo cáo rú jí yǔ, xiǎo xián qiē qiē rú sī yǔ。\n cáo cáo qiē qiē cuò zá tán, dà zhū xiǎo zhū luò yù pán。\n jiān guān yīng yǔ huā dǐ huá, yōu yè quán liú bīng xià nán。\n bīng quán lěng sè xián níng jué, níng jué bù tōng shēng zàn xiē。\n bié yǒu yōu chóu àn hèn shēng, cǐ shí wú shēng shèng yǒu shēng。\n yín píng zhà pò shuǐ jiāng bèng, tiě qí tū chū dāo qiāng míng。\n qǔ zhōng shōu bō dāng xīn huà, sì xián yī shēng rú liè bó。\n dōng chuán xī fǎng qiāo wú yán, wéi jiàn jiāng xīn qiū yuè bái。\n chén yín fàng bō chā xián zhōng, zhěng dùn yī cháng qǐ liǎn róng。\n zì yán běn shì jīng chéng nǚ, jiā zài há má líng xià zhù。\n shí sān xué dé pí pá chéng, míng shǔ jiào fāng dì yī bù。\n qǔ bà céng jiào shàn cái fú, zhuāng chéng měi bèi qiū niáng dù。\n wǔ líng nián shào zhēng chán tóu, yī qǔ hóng xiāo bù zhī shù。\n diàn tóu yín bì jī jié suì, xuè sè luō qún fān jiǔ wū。\n jīn nián huān xiào fù míng nián, qiū yuè chūn fēng děng xián dù。\n dì zǒu cóng jūn ā yí sǐ, mù qù cháo lái yán sè gù。\n mén qián lěng luò ān mǎ xī, lǎo dà jià zuò shāng rén fù。\n shāng rén zhòng lì qī bié lí, qián yuè fú liáng mǎi chá qù。\n qù lái jiāng kǒu shǒu kōng chuán, rào chuán yuè míng jiāng shuǐ hán。\n yè shēn hū mèng shào nián shì, mèng tí zhuāng lèi hóng lán gān。\n wǒ wén pí pá yǐ tàn xī, yòu wén cǐ yǔ zhòng jī jī。\n tóng shì tiān yá lún luò rén, xiāng féng hé bì céng xiāng shí！\n wǒ cóng qù nián cí dì jīng, zhé jū wò bìng xún yáng chéng。\n xún yáng dì pì wú yīn yuè, zhōng suì bù wén sī zhú shēng。\n zhù jìn pén jiāng dì dī shī, huáng lú kǔ zhú rào zhái shēng。\n qí jiān dàn mù wén hé wù？ dù juān tí xuè yuán āi míng。\n chūn jiāng huā cháo qiū yuè yè, wǎng wǎng qǔ jiǔ hái dú qīng。\n qǐ wú shān gē yǔ cūn dí？ ǒu yā cháo zhā nán wéi tīng。\n jīn yè wén jūn pí pá yǔ, rú tīng xiān lè ěr zàn míng。\n mò cí gèng zuò tán yī qǔ, wéi jūn fān zuò "pí pá xíng"。\n gǎn wǒ cǐ yán liáng jiǔ lì, què zuò cù xián xián zhuǎn jí。\n qī qī bù sì xiàng qián shēng, mǎn zuò chóng wén jiē yǎn qì。\n zuò zhōng qì xià shuí zuì duō？ jiāng zhōu sī mǎ qīng shān shī。'
    },
    {
      id: 98,
      title: '韩碑',
      author: '李商隐',
      content: '元和天子神武姿，彼何人哉轩与羲。\n誓将上雪列圣耻，坐法宫中朝四夷。\n淮西有贼五十载，封狼生貙貙生罴。\n不据山河据平地，长戈利矛日可麾。\n帝得圣相相曰度，贼斫不死神扶持。\n腰悬相印作都统，阴风惨澹天王旗。\n愬武古通作牙爪，仪曹外郎载笔随。\n行军司马智且勇，十四万众犹虎貔。\n入蔡缚贼献太庙，功无与让恩不訾。\n帝曰汝度功第一，汝从事愈宜为辞。\n愈拜稽首蹈且舞，金石刻画臣能为。\n古者世称大手笔，此事不系于职司。\n当仁自古有不让，言讫屡颔天子颐。\n公退斋戒坐小阁，濡染大笔何淋漓。\n点窜《尧典》《舜典》字，涂改《清庙》《生民》诗。\n文成破体书在纸，清晨再拜铺丹墀。\n表曰臣愈昧死上，咏神圣功书之碑。\n碑高三丈字如斗，负以灵鳌蟠以螭。\n句奇语重喻者少，谗之天子言其私。\n长绳百尺拽碑倒，粗砂大石相磨治。\n公之斯文若元气，先时已入人肝脾。\n汤盘孔鼎有述作，今无其器存其辞。\n呜呼圣王及圣相，相与烜赫流淳熙。\n公之斯文不示后，曷与三五相攀追。\n愿书万本诵万遍，口角流沫右手胝。\n传之七十有二代，以为封禅玉检明堂基。',
      pinyin: 'yuán hé tiān zǐ shén wǔ zī, bǐ hé rén zāi xuān yǔ xī。\n shì jiāng shàng xuě liè shèng chǐ, zuò fǎ gōng zhōng cháo sì yí。\n huái xī yǒu zéi wǔ shí zǎi, fēng láng shēng chū chū shēng pí。\n bù jù shān hé jù píng dì, cháng gē lì máo rì kě huī。\n dì dé shèng xiàng xiàng yuē dù, zéi zhuó bù sǐ shén fú chí。\n yāo xuán xiàng yìn zuò dū tǒng, yīn fēng cǎn dàn tiān wáng qí。\n sù wǔ gǔ tōng zuò yá zhǎo, yí cáo wài láng zài bǐ suí。\n xíng jūn sī mǎ zhì qiě yǒng, shí sì wàn zhòng yóu hǔ pí。\n rù cài fù zéi xiàn tài miào, gōng wú yǔ ràng ēn bù zī。\n dì yuē rǔ dù gōng dì yī, rǔ cóng shì yù yí wéi cí。\n yù bài qǐ shǒu dǎo qiě wǔ, jīn shí kè huà chén néng wéi。\n gǔ zhě shì chēng dà shǒu bǐ, cǐ shì bù xì yú zhí sī。\n dāng rén zì gǔ yǒu bù ràng, yán qì lǚ hàn tiān zǐ yí。\n gōng tuì zhāi jiè zuò xiǎo gé, rú rǎn dà bǐ hé lín lí。\n diǎn cuàn "yáo diǎn" "shùn diǎn" zì, tú gǎi "qīng miào" "shēng mín" shī。\n wén chéng pò tǐ shū zài zhǐ, qīng chén zài bài pù dān chí。\n biǎo yuē chén yù mèi sǐ shàng, yǒng shén shèng gōng shū zhī bēi。\n bēi gāo sān zhàng zì rú dǒu, fù yǐ líng áo pán yǐ chī。\n jù qí yǔ zhòng yù zhě shǎo, chán zhī tiān zǐ yán qí sī。\n cháng shéng bǎi chǐ zhuāi bēi dǎo, cū shā dà shí xiāng mó zhì。\n gōng zhī sī wén ruò yuán qì, xiān shí yǐ rù rén gān pí。\n tāng pán kǒng dǐng yǒu shù zuò, jīn wú qí qì cún qí cí。\n wū hū shèng wáng jí shèng xiàng, xiāng yǔ huǐ hè liú chún xī。\n gōng zhī sī wén bù shì hòu, hé yǔ sān wǔ xiāng pān zhuī。\n yuàn shū wàn běn sòng wàn biàn, kǒu jiǎo liú mò yòu shǒu zhī。\n chuán zhī qī shí yǒu èr dài, yǐ wéi fēng shàn yù jiǎn míng táng jī。'
    },
    {
      id: 99,
      title: '燕歌行（并序）',
      author: '高适',
      content: '开元二十六年，客有从御史大夫张公出塞而还者；作《燕歌行》以示适，感征戍之事，因而和焉。\n汉家烟尘在东北，汉将辞家破残贼。\n男儿本自重横行，天子非常赐颜色。\n摐金伐鼓下榆关，旌旆逶迤碣石间。\n校尉羽书飞瀚海，单于猎火照狼山。\n山川萧条极边土，胡骑凭陵杂风雨。\n战士军前半死生，美人帐下犹歌舞！\n大漠穷秋塞草腓，孤城落日斗兵稀。\n身当恩遇常轻敌，力尽关山未解围。\n铁衣远戍辛勤久，玉箸应啼别离后。\n少妇城南欲断肠，征人蓟北空回首。\n边庭飘飖那可度，绝域苍茫更何有！\n杀气三时作阵云，寒声一夜传刁斗。\n相看白刃血纷纷，死节从来岂顾勋？\n君不见沙场征战苦，至今犹忆李将军！',
      pinyin: 'kāi yuán èr shí liù nián, kè yǒu cóng yù shǐ dà fū zhāng gōng chū sài ér hái zhě; zuò "yàn gē xíng" yǐ shì shì, gǎn zhēng shù zhī shì, yīn ér hé yān。\n hàn jiā yān chén zài dōng běi, hàn jiāng cí jiā pò cán zéi。\n nán ér běn zì zhòng héng xíng, tiān zǐ fēi cháng cì yán sè。\n chuāng jīn fá gǔ xià yú guān, jīng pèi wēi yí jié shí jiān。\n xiào wèi yǔ shū fēi hàn hǎi, chán yú liè huǒ zhào láng shān。\n shān chuān xiāo tiáo jí biān tǔ, hú qí píng líng zá fēng yǔ。\n zhàn shì jūn qián bàn sǐ shēng, měi rén zhàng xià yóu gē wǔ！\n dà mò qióng qiū sài cǎo féi, gū chéng luò rì dòu bīng xī。\n shēn dāng ēn yù cháng qīng dí, lì jìn guān shān wèi jiě wéi。\n tiě yī yuǎn shù xīn qín jiǔ, yù zhù yīng tí bié lí hòu。\n shào fù chéng nán yù duàn cháng, zhēng rén jì běi kōng huí shǒu。\n biān tíng piāo yáo nà kě dù, jué yù cāng máng gèng hé yǒu！\n shā qì sān shí zuò zhèn yún, hán shēng yī yè chuán diāo dǒu。\n xiāng kàn bái rèn xuè fēn fēn, sǐ jié cóng lái qǐ gù xūn？\n jūn bú jiàn shā chǎng zhēng zhàn kǔ, zhì jīn yóu yì lǐ jiāng jūn！'
    },

    // 卷四：七言乐府
    {
      id: 100,
      title: '古从军行',
      author: '李颀',
      content: '白日登山望烽火，黄昏饮马傍交河。\n行人刁斗风沙暗，公主琵琶幽怨多。\n野云万里无城郭，雨雪纷纷连大漠。\n胡雁哀鸣夜夜飞，胡儿眼泪双双落。\n闻道玉门犹被遮，应将性命逐轻车。\n年年战骨埋荒外，空见蒲桃入汉家。',
      pinyin: 'bái rì dēng shān wàng fēng huǒ, huáng hūn yǐn mǎ bàng jiāo hé。\n xíng rén diāo dǒu fēng shā àn, gōng zhǔ pí pá yōu yuàn duō。\n yě yún wàn lǐ wú chéng guō, yǔ xuě fēn fēn lián dà mò。\n hú yàn āi míng yè yè fēi, hú ér yǎn lèi shuāng shuāng luò。\n wén dào yù mén yóu bèi zhē, yīng jiāng xìng mìng zhú qīng chē。\n nián nián zhàn gǔ mái huāng wài, kōng jiàn pú táo rù hàn jiā。'
    },
    {
      id: 101,
      title: '关山月',
      author: '李白',
      content: '明月出天山，苍茫云海间。\n长风几万里，吹度玉门关。\n汉下白登道，胡窥青海湾。\n由来征战地，不见有人还。\n戍客望边邑，思归多苦颜。\n高楼当此夜，叹息未应闲。',
      pinyin: 'míng yuè chū tiān shān, cāng máng yún hǎi jiān。\n cháng fēng jǐ wàn lǐ, chuī dù yù mén guān。\n hàn xià bái dēng dào, hú kuī qīng hǎi wān。\n yóu lái zhēng zhàn dì, bú jiàn yǒu rén hái。\n shù kè wàng biān yì, sī guī duō kǔ yán。\n gāo lóu dāng cǐ yè, tàn xī wèi yīng xián。'
    },
    {
      id: 102,
      title: '子夜吴歌・春歌',
      author: '李白',
      content: '秦地罗敷女，采桑绿水边。\n素手青条上，红妆白日鲜。\n蚕饥妾欲去，五马莫留连。',
      pinyin: 'qín dì luó fū nǚ, cǎi sāng lǜ shuǐ biān。\n sù shǒu qīng tiáo shàng, hóng zhuāng bái rì xiān。\n cán jī qiè yù qù, wǔ mǎ mò liú lián。'
    },
    {
      id: 103,
      title: '子夜吴歌・夏歌',
      author: '李白',
      content: '镜湖三百里，菡萏发荷花。\n五月西施采，人看隘若耶。\n回舟不待月，归去越王家。',
      pinyin: 'jìng hú sān bǎi lǐ, hàn dàn fā hé huā。\n wǔ yuè xī shī cǎi, rén kàn ài ruò yē。\n huí zhōu bù dài yuè, guī qù yuè wáng jiā。'
    },
    {
      id: 104,
      title: '子夜吴歌・秋歌',
      author: '李白',
      content: '长安一片月，万户捣衣声。\n秋风吹不尽，总是玉关情。\n何日平胡虏，良人罢远征？',
      pinyin: 'cháng\'ān yī piàn yuè, wàn hù dǎo yī shēng。\n qiū fēng chuī bù jìn, zǒng shì yù guān qíng。\n hé rì píng hú lǔ, liáng rén bà yuǎn zhēng？'
    },
    {
      id: 105,
      title: '子夜吴歌・冬歌',
      author: '李白',
      content: '明朝驿使发，一夜絮征袍。\n素手抽针冷，那堪把剪刀。\n裁缝寄远道，几日到临洮？',
      pinyin: 'míng cháo yì shǐ fā, yī yè xù zhēng páo。\n sù shǒu chōu zhēn lěng, nà kān bǎ jiǎn dāo。\n cái féng jì yuǎn dào, jǐ rì dào lín táo？'
    },
    {
      id: 106,
      title: '长干行・其一',
      author: '李白',
      content: '妾发初覆额，折花门前剧。\n郎骑竹马来，绕床弄青梅。\n同居长干里，两小无嫌猜。\n十四为君妇，羞颜未尝开。\n低头向暗壁，千唤不一回。\n十五始展眉，愿同尘与灰。\n常存抱柱信，岂上望夫台。\n十六君远行，瞿塘滟滪堆。\n五月不可触，猿声天上哀。\n门前迟行迹，一一生绿苔。\n苔深不能扫，落叶秋风早。\n八月蝴蝶黄，双飞西园草。\n感此伤妾心，坐愁红颜老。\n早晚下三巴，预将书报家。\n相迎不道远，直至长风沙。',
      pinyin: 'qiè fā chū fù é, zhé huā mén qián jù。\n láng qí zhú mǎ lái, rào chuáng nòng qīng méi。\n tóng jū cháng gàn lǐ, liǎng xiǎo wú xián cāi。\n shí sì wéi jūn fù, xiū yán wèi cháng kāi。\n dī tóu xiàng àn bì, qiān huàn bù yī huí。\n shí wǔ shǐ zhǎn méi, yuàn tóng chén yǔ huī。\n cháng cún bào zhù xìn, qǐ shàng wàng fū tái。\n shí liù jūn yuǎn xíng, qú táng yàn yù duī。\n wǔ yuè bù kě chù, yuán shēng tiān shàng āi。\n mén qián chí xíng jì, yī yī shēng lǜ tái。\n tái shēn bù néng sǎo, luò yè qiū fēng zǎo。\n bā yuè hú dié huáng, shuāng fēi xī yuán cǎo。\n gǎn cǐ shāng qiè xīn, zuò chóu hóng yán lǎo。\n zǎo wǎn xià sān bā, yù jiāng shū bào jiā。\n xiāng yíng bù dào yuǎn, zhí zhì cháng fēng shā。'
    },
    {
      id: 107,
      title: '烈女操',
      author: '孟郊',
      content: '梧桐相待老，鸳鸯会双死。\n贞女贵徇夫，舍生亦如此。\n波澜誓不起，妾心古井水。',
      pinyin: 'wú tóng xiāng dài lǎo, yuān yāng huì shuāng sǐ。\n zhēn nǚ guì xùn fū, shě shēng yì rú cǐ。\n bō lán shì bù qǐ, qiè xīn gǔ jǐng shuǐ。'
    },
    {
      id: 108,
      title: '游子吟',
      author: '孟郊',
      content: '慈母手中线，游子身上衣。\n临行密密缝，意恐迟迟归。\n谁言寸草心，报得三春晖。',
      pinyin: 'cí mǔ shǒu zhōng xiàn, yóu zǐ shēn shàng yī。\n lín xíng mì mì féng, yì kǒng chí chí guī。\n shuí yán cùn cǎo xīn, bào dé sān chūn huī。'
    },
    {
      id: 109,
      title: '登幽州台歌',
      author: '陈子昂',
      content: '前不见古人，后不见来者。\n念天地之悠悠，独怆然而涕下！',
      pinyin: 'qián bú jiàn gǔ rén, hòu bú jiàn lái zhě。\n niàn tiān dì zhī yōu yōu, dú chuàng rán ér tì xià！'
    },

    // 卷三：七言古诗
    {
      id: 110,
      title: '庐山谣寄卢侍御虚舟',
      author: '李白',
      content: '我本楚狂人，凤歌笑孔丘。\n手持绿玉杖，朝别黄鹤楼。\n五岳寻仙不辞远，一生好入名山游。\n庐山秀出南斗傍，屏风九叠云锦张。\n影落明湖青黛光，金阙前开二峰长。\n银河倒挂三石梁，香炉瀑布遥相望。\n回崖沓嶂凌苍苍，翠影红霞映朝日。\n鸟飞不到吴天长，登高壮观天地间。\n大江茫茫去不还，黄云万里动风色。\n白波九道流雪山，好为庐山谣，兴因庐山发。\n闲窥石镜清我心，谢公行处苍苔没。\n早服还丹无世情，琴心三叠道初成。\n遥见仙人彩云里，手把芙蓉朝玉京。\n先期汗漫九垓上，愿接卢敖游太清。',
      pinyin: 'wǒ běn chǔ kuáng rén, fèng gē xiào kǒng qiū。\n shǒu chí lǜ yù zhàng, cháo bié huáng hè lóu。\n wǔ yuè xún xiān bù cí yuǎn, yī shēng hǎo rù míng shān yóu。\n lú shān xiù chū nán dǒu bàng, píng fēng jiǔ dié yún jǐn zhāng。\n yǐng luò míng hú qīng dài guāng, jīn què qián kāi èr fēng cháng。\n yín hé dào guà sān shí liáng, xiāng lú pù bù yáo xiāng wàng。\n huí yá tà zhàng líng cāng cāng, cuì yǐng hóng xiá yìng zhāo rì。\n niǎo fēi bú dào wú tiān cháng, dēng gāo zhuàng guān tiān dì jiān。\n dà jiāng máng máng qù bú hái, huáng yún wàn lǐ dòng fēng sè。\n bái bō jiǔ dào liú xuě shān, hǎo wéi lú shān yáo, xìng yīn lú shān fā。\n xián kuī shí jìng qīng wǒ xīn, xiè gōng xíng chù cāng tái mò。\n zǎo fú hái dān wú shì qíng, qín xīn sān dié dào chū chéng。\n yáo jiàn xiān rén cǎi yún lǐ, shǒu bǎ fú róng cháo yù jīng。\n xiān qī hàn màn jiǔ gāi shàng, yuàn jiē lú áo yóu tài qīng。'
    },
    // 卷八：七言绝句
    {
      id: 111,
      title: '九月九日忆山东兄弟',
      author: '王维',
      content: '独在异乡为异客，每逢佳节倍思亲。\n遥知兄弟登高处，遍插茱萸少一人。',
      pinyin: 'dú zài yì xiāng wéi yì kè, měi féng jiā jié bèi sī qīn.\n yáo zhī xiōng dì dēng gāo chù, biàn chā zhū yú shǎo yī rén.'
    }
  ];
  @State isPageLoaded: boolean = false; // 页面加载状态
  @State isPlaying: boolean = false;
  @State readState: ReadStateCode = ReadStateCode.WAITING; // 朗读状态
  private isInit: boolean = false; // TextReader是否已初始化
  private statusBarHeight: number = 0; // 状态栏高度
  private preferences: dataPreferences.Preferences | null = null; // 持久化存储实例

  @State private keyword: string = '';
  @State private isGridView: boolean = true;
  @State private showFavoritesOnly: boolean = false;
  @State private favoriteIds: Array<number> = [];
  @State private updateFlag: number = 0; // 用于强制触发UI更新
  @State private themeKeyword: string = ''; // 诗词分类主题关键词
  @State private themeName: string = ''; // 诗词分类主题名称

  private getFilteredPoems(): Array<Poem> {
    const kw = this.keyword.trim();
    let baseList: Array<Poem> = this.poems;

    // 首先根据诗词分类主题筛选
    if (this.themeKeyword) {
      const regex = new RegExp(this.themeKeyword);
      baseList = baseList.filter((p: Poem) => 
        regex.test(p.title) || regex.test(p.content)
      );
    }

    // 收藏筛选
    if (this.showFavoritesOnly) {
      baseList = baseList.filter((p: Poem) => p.isFavorite === true);
    }

    // 关键词搜索
    if (!kw) {
      return baseList;
    }
    const lowerKw = kw.toLowerCase();
    return baseList.filter((p: Poem) =>
      p.title.toLowerCase().includes(lowerKw) ||
      p.author.toLowerCase().includes(lowerKw) ||
      p.content.toLowerCase().includes(lowerKw)
    );
  }

  async aboutToAppear(): Promise<void> {
    // 获取路由参数
    const params = router.getParams() as Record<string, string>;
    if (params) {
      this.themeKeyword = params['themeKeyword'] as string || '';
      this.themeName = params['themeName'] as string || '';
      console.log('诗词分类主题:', this.themeName, '关键词:', this.themeKeyword);
    }

    // 初始化 Preferences 并恢复收藏状态
    try {
      const context = getContext(this) as common.UIAbilityContext;
      // 创建或获取 Preferences 实例
      this.preferences = await dataPreferences.getPreferences(context, 'poem_favorites');
      
      // 从 Preferences 读取收藏列表
      const storedIds = await this.preferences.get('favorite_ids', '[]');
      const ids: Array<number> = JSON.parse(storedIds as string) as Array<number>;
      this.favoriteIds = ids;
      
      // 更新 poems 数组中的 isFavorite 字段
      this.poems = this.poems.map((p: Poem): Poem => {
        const isFav = ids.includes(p.id);
        const updatedPoem: Poem = {
          id: p.id,
          title: p.title,
          author: p.author,
          content: p.content,
          pinyin: p.pinyin,
          isFavorite: isFav
        };
        return updatedPoem;
      });
      
      console.log('收藏数据加载成功，共', ids.length, '首收藏诗歌');
    } catch (error) {
      console.error('读取收藏失败:', error);
    }

    // 获取状态栏高度
    try {
      const context = getContext(this) as common.UIAbilityContext;
      window.getLastWindow(context).then((windowClass) => {
        // 获取系统装饰器相关属性，从中获取状态栏高度
        const windowProperties = windowClass.getWindowProperties();
        // 由于直接获取statusBarHeight属性不可用，我们使用默认值
        this.statusBarHeight = 24; // 默认状态栏高度
      }).catch((error: BusinessError) => {
        console.error('获取状态栏高度失败:', error);
        this.statusBarHeight = 24; // 默认状态栏高度
      });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('获取状态栏高度失败:', e);
      this.statusBarHeight = 24; // 默认状态栏高度
    }
    
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 50);
    
    // 初始化TextReader
    await this.initTextReader();

    // 重置播放状态
    this.isPlaying = false;
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



  // 初始化TextReader
  private async initTextReader(): Promise<void> {
    try {
      // 创建朗读参数
      const businessBrandInfo: TextReader.BusinessBrandInfo = { 
        panelName: '小艺朗读'
      };
      
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: true
      };

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
        // 如果没有在朗读，开始朗读所有诗歌标题
        const readInfoList: TextReader.ReadInfo[] = this.poems.map((poem) => {
          const readInfo: TextReader.ReadInfo = {
            id: `poem_list_${poem.id}`,
            title: {
              text: poem.title,
              isClickable: false
            },
            bodyInfo: `${poem.title}，作者：${poem.author}。${poem.content}`
          };
          
          return readInfo;
        });
        
        // 启动TextReader并进入朗读页面
        TextReader.start(readInfoList, readInfoList[0].id).then(() => {
          console.log('开始朗读诗歌列表');
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
  private getBackgroundColor(id: number): string | ResourceColor {
    // 创建浅色模式颜色映射对象
    const lightColorMap: Map<string, string> = new Map([
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
      ["20", '#F1F8E9'], // 淡绿系
      ["21", '#FFF3E0'], // 橙色系
      ["22", '#E3F2FD'], // 蓝色系
      ["23", '#F1F8E9'], // 浅绿色系
      ["24", '#F3E5F5'], // 粉色系
      ["25", '#E0F2F1'], // 青色系
      ["26", '#FFECB3'], // 黄色系
      ["27", '#FFCCBC'], // 红色系
      ["28", '#E8EAF6'], // 蓝紫色系
      ["29", '#E1BEE7'], // 紫色系
      ["30", '#FFCCDD'], // 粉红色系
      ["31", '#E0F7FA'], // 青蓝色系
      ["32", '#F9FBE7'], // 柠檬绿系
      ["33", '#EFEBE9'], // 棕色系
      ["34", '#E8F5E9'], // 薄荷绿系
      ["35", '#FFF8E1'], // 浅黄系
      ["36", '#E0E0E0'], // 灰色系
      ["37", '#FCE4EC'], // 粉紫系
      ["38", '#E0F2F1'], // 青绿系
      ["39", '#E3F2FD'], // 淡蓝系
      ["40", '#F1F8E9'], // 淡绿系
      ["41", '#FFF3E0'], // 橙色系
      ["42", '#E3F2FD'], // 蓝色系
      ["43", '#F1F8E9'], // 浅绿色系
      ["44", '#F3E5F5'], // 粉色系
      ["45", '#E0F2F1'], // 青色系
      ["46", '#FFECB3'], // 黄色系
      ["47", '#FFCCBC'], // 红色系
      ["48", '#E8EAF6'], // 蓝紫色系
      ["49", '#E1BEE7'], // 紫色系
      ["50", '#FFCCDD'], // 粉红色系
      ["51", '#E0F7FA'], // 青蓝色系
      ["52", '#F9FBE7'], // 柠檬绿系
      ["53", '#EFEBE9'], // 棕色系
      ["54", '#E8F5E9'], // 薄荷绿系
      ["55", '#FFF8E1'], // 浅黄系
      ["56", '#E0E0E0'], // 灰色系
      ["57", '#FCE4EC'], // 粉紫系
      ["58", '#E0F2F1'], // 青绿系
      ["59", '#E3F2FD'], // 淡蓝系
      ["60", '#F1F8E9'], // 淡绿系
      ["61", '#FFF3E0'], // 橙色系
      ["62", '#E3F2FD'], // 蓝色系
      ["63", '#F1F8E9'], // 浅绿色系
      ["64", '#F3E5F5'], // 粉色系
      ["65", '#E0F2F1'], // 青色系
      ["66", '#FFECB3'], // 黄色系
      ["67", '#FFCCBC'], // 红色系
      ["68", '#E8EAF6'], // 蓝紫色系
      ["69", '#E1BEE7'], // 紫色系
      ["70", '#FFCCDD'], // 粉红色系
      ["71", '#E0F7FA'], // 青蓝色系
      ["72", '#F9FBE7'], // 柠檬绿系
      ["73", '#EFEBE9'], // 棕色系
      ["74", '#E8F5E9'], // 薄荷绿系
      ["75", '#FFF8E1'], // 浅黄系
      ["76", '#E0E0E0'], // 灰色系
      ["77", '#FCE4EC'], // 粉紫系
      ["78", '#E0F2F1'], // 青绿系
      ["79", '#E3F2FD'], // 淡蓝系
      ["80", '#F1F8E9']// 淡绿系
    ]);

    // 创建深色模式颜色映射对象
    const darkColorMap: Map<string, string> = new Map([
      ["1", '#4A148C'], // 深紫色系
      ["2", '#3E2723'], // 深棕橙色系
      ["3", '#0D47A1'], // 深蓝色系
      ["4", '#1B5E20'], // 深绿色系
      ["5", '#004D40'], // 深青色系
      ["6", '#F57F17'], // 深黄色系
      ["7", '#BF360C'], // 深红色系
      ["8", '#1A237E'], // 深蓝紫色系
      ["9", '#4A148C'], // 深紫色系
      ["10", '#880E4F'], // 深粉红色系
      ["11", '#006064'], // 深青蓝色系
      ["12", '#827717'], // 深柠檬绿系
      ["13", '#3E2723'], // 深棕色系
      ["14", '#1B5E20'], // 深薄荷绿系
      ["15", '#F57F17'], // 深黄系
      ["16", '#424242'], // 深灰色系
      ["17", '#880E4F'], // 深粉紫系
      ["18", '#004D40'], // 深青绿系
      ["19", '#0D47A1'], // 深淡蓝系
      ["20", '#1B5E20'], // 深淡绿系
      ["21", '#3E2723'], // 深橙色系
      ["22", '#0D47A1'], // 深蓝色系
      ["23", '#1B5E20'], // 深浅绿色系
      ["24", '#4A148C'], // 深粉色系
      ["25", '#004D40'], // 深青色系
      ["26", '#F57F17'], // 深黄色系
      ["27", '#BF360C'], // 深红色系
      ["28", '#1A237E'], // 深蓝紫色系
      ["29", '#4A148C'], // 深紫色系
      ["30", '#880E4F'], // 深粉红色系
      ["31", '#006064'], // 深青蓝色系
      ["32", '#827717'], // 深柠檬绿系
      ["33", '#3E2723'], // 深棕色系
      ["34", '#1B5E20'], // 深薄荷绿系
      ["35", '#F57F17'], // 深浅黄系
      ["36", '#424242'], // 深灰色系
      ["37", '#880E4F'], // 深粉紫系
      ["38", '#004D40'], // 深青绿系
      ["39", '#0D47A1'], // 深淡蓝系
      ["40", '#1B5E20'], // 深淡绿系
      ["41", '#3E2723'], // 深橙色系
      ["42", '#0D47A1'], // 深蓝色系
      ["43", '#1B5E20'], // 深浅绿色系
      ["44", '#4A148C'], // 深粉色系
      ["45", '#004D40'], // 深青色系
      ["46", '#F57F17'], // 深黄色系
      ["47", '#BF360C'], // 深红色系
      ["48", '#1A237E'], // 深蓝紫色系
      ["49", '#4A148C'], // 深紫色系
      ["50", '#880E4F'], // 深粉红色系
      ["51", '#006064'], // 深青蓝色系
      ["52", '#827717'], // 深柠檬绿系
      ["53", '#3E2723'], // 深棕色系
      ["54", '#1B5E20'], // 深薄荷绿系
      ["55", '#F57F17'], // 深浅黄系
      ["56", '#424242'], // 深灰色系
      ["57", '#880E4F'], // 深粉紫系
      ["58", '#004D40'], // 深青绿系
      ["59", '#0D47A1'], // 深淡蓝系
      ["60", '#1B5E20'], // 深淡绿系
      ["61", '#3E2723'], // 深橙色系
      ["62", '#0D47A1'], // 深蓝色系
      ["63", '#1B5E20'], // 深浅绿色系
      ["64", '#4A148C'], // 深粉色系
      ["65", '#004D40'], // 深青色系
      ["66", '#F57F17'], // 深黄色系
      ["67", '#BF360C'], // 深红色系
      ["68", '#1A237E'], // 深蓝紫色系
      ["69", '#4A148C'], // 深紫色系
      ["70", '#880E4F'], // 深粉红色系
      ["71", '#006064'], // 深青蓝色系
      ["72", '#827717'], // 深柠檬绿系
      ["73", '#3E2723'], // 深棕色系
      ["74", '#1B5E20'], // 深薄荷绿系
      ["75", '#F57F17'], // 深浅黄系
      ["76", '#424242'], // 深灰色系
      ["77", '#880E4F'], // 深粉紫系
      ["78", '#004D40'], // 深青绿系
      ["79", '#0D47A1'], // 深淡蓝系
      ["80", '#1B5E20']// 深淡绿系
    ]);

    // 循环使用颜色
    const colorKeys = Array.from(lightColorMap.keys());
    const colorIndex = (id - 1) % colorKeys.length;
    const key = colorKeys[colorIndex];

    // 根据当前主题选择颜色映射
    if (this.isDarkMode()) {
      return darkColorMap.get(key) || Color.Black; // 深色模式默认黑色
    } else {
      return lightColorMap.get(key) || Color.White; // 浅色模式默认白色
    }
  }

  // 判断当前是否为深色模式
  private isDarkMode(): boolean {
    // 这里可以根据系统主题状态判断，暂时返回false作为示例
    // 实际项目中可以通过Ability或系统API获取当前主题
    const context = getContext(this) as common.UIAbilityContext;
    const currentColorMode: ConfigurationConstant.ColorMode | undefined = context.config.colorMode;
    if (currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
      return true;
    } else if (currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      return false;
    }
    return false;
  }
  // 切换收藏状态
  private async toggleFavorite(poem: Poem): Promise<void> {
    const index = this.poems.findIndex((p: Poem) => p.id === poem.id);
    if (index >= 0) {
      const current = this.poems[index];
      const isFav = !current.isFavorite;
      
      // 创建新的诗歌数组，触发状态更新
      const newPoems: Array<Poem> = this.poems.map((p: Poem): Poem => {
        if (p.id === poem.id) {
          const updatedPoem: Poem = {
            id: p.id,
            title: p.title,
            author: p.author,
            content: p.content,
            pinyin: p.pinyin,
            isFavorite: isFav
          };
          return updatedPoem;
        }
        return p;
      });
      
      // 重新赋值整个数组以触发@State响应式更新
      this.poems = newPoems;
      
      // 强制触发UI更新
      this.updateFlag++;

      // 同步收藏ID列表
      if (isFav) {
        if (!this.favoriteIds.includes(current.id)) {
          this.favoriteIds = [...this.favoriteIds, current.id];
        }
      } else {
        this.favoriteIds = this.favoriteIds.filter((id: number) => id !== current.id);
      }

      // 使用 Preferences 持久化存储收藏ID
      try {
        if (this.preferences) {
          const stored = JSON.stringify(this.favoriteIds);
          await this.preferences.put('favorite_ids', stored);
          await this.preferences.flush(); // 刷新到磁盘
          console.log('收藏数据已保存，当前收藏', this.favoriteIds.length, '首诗歌');
        }
      } catch (error) {
        console.error('保存收藏失败:', error);
      }
    }
  }

      build() {
    Column() {
      // 顶部栏：返回 + 标题
      Row() {
        Button('返回')
          .onClick(() => { router.back(); })
          .margin({ left: 16 })
          .type(ButtonType.Normal)
          .borderRadius(18)
          .width(64)
          .height(32)
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))

        Column() {
          Text('唐诗鉴赏')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.text_primary'))
            .textAlign(TextAlign.Center)

          Text('清风明月 · 诗酒年华')
            .fontSize(11)
            .fontColor($r('app.color.text_tertiary_bank_card_03'))
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        TextReaderIcon({
          readState: this.readState
        })
        .width(32)
        .height(32)
        .margin({ right: 16 })
        .onClick(() => {
          this.togglePlay();
        })
      }
      .height(72)
      .alignItems(VerticalAlign.Center)
      .padding({ top: this.statusBarHeight, right: 16 })

      Text('探索唐诗：点击诗卡查看详情与解析')
        .fontSize(13)
        .fontColor($r('app.color.text_primary_black'))
        .margin({ top: 4, bottom: 6 })

      // 搜索与视图切换（古风工具条）
      Row() {
        // 左侧：搜索框
        Row() {
          Image($r('app.media.ic_search'))
            .width(16)
            .height(16)
            .margin({ left: 10, right: 4 })

          TextInput({ placeholder: '按标题 / 作者 / 内容搜索' })
            .layoutWeight(1)
            .height(36)
            .borderRadius(18)
            .backgroundColor($r('app.color.card_background'))
            .fontColor($r('app.color.text_primary'))
            .placeholderColor($r('app.color.text_tertiary_bank_card_03'))
            .padding({ left: 4, right: 10 })
            .onChange((value: string) => { this.keyword = value.trim(); })
        }
        .layoutWeight(1)
        .height(36)
        .borderRadius(18)
        .backgroundColor($r('app.color.card_background'))
        .border({ width: 0.5, color: $r('app.color.text_tertiary_bank_card_03') })

      Row() {
        Button(this.showFavoritesOnly ? '全部' : '收藏')
          .onClick(() => { this.showFavoritesOnly = !this.showFavoritesOnly; })
          .type(ButtonType.Capsule)
          .borderRadius(16)
          .width(68)
          .height(32)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.showFavoritesOnly ? $r('app.color.accent_negative') : $r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 8 })

        Text(this.isGridView ? '宫格' : '列表')
          .fontSize(12)
          .fontColor($r('app.color.text_primary'))
          .margin({ right: 4, left: 8 })

        Toggle({
          type: ToggleType.Switch,
          isOn: this.isGridView
        })
        .size({ width: 44, height: 24 })
        .selectedColor($r('app.color.text_tertiary_bank_card_03'))
        .switchPointColor($r('app.color.card_background'))
        .onChange((value: boolean) => {
          this.isGridView = value;
        })
      }
      }
      .padding({ left: 16, right: 16 })
      .margin({ bottom: 8 })

      // 诗歌列表
      Scroll() {
        if (this.isGridView) {
          Grid() {
            ForEach(this.getFilteredPoems(), (poem: Poem, index: number) => {
              GridItem() {
                Column() {
                  Column() {
                    Text(poem.title)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor($r('app.color.text_primary'))
                      .textAlign(TextAlign.Center)

                    Text(poem.author)
                      .fontSize(12)
                      .fontColor($r('app.color.text_tertiary_bank_card_03'))
                      .textAlign(TextAlign.Center)
                      .margin({ top: 4 })

                    Text(poem.content.length > 36 ? poem.content.substring(0, 36) + '…' : poem.content)
                      .fontSize(12)
                      .fontColor($r('app.color.text_primary_black'))
                      .textAlign(TextAlign.Center)
                      .margin({ top: 6 })
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .width('100%')
                  .height(120)
                  .justifyContent(FlexAlign.Center)
                  .padding({ left: 12, right: 12 })

                  Row() {
                    Blank().layoutWeight(1)
                    Text(poem.isFavorite ? '★' : '☆')
                      .fontSize(18)
                      .fontColor(poem.isFavorite ? $r('app.color.text_tertiary_bank_card_03') : $r('app.color.text_primary'))
                      .margin({ right: 8, bottom: 6 })
                      .padding(8)
                      .onClick(() => {
                        this.toggleFavorite(poem);
                      })
                  }
                  .hitTestBehavior(HitTestMode.None)
                }
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(16)
                .shadow({
                  radius: 16,
                  color: '#0000001A',
                  offsetX: 0,
                  offsetY: 6
                })
                .onClick(() => {
                  // 点击卡片进入详情
                  try {
                    TextReader.stop();
                    this.isPlaying = false;
                  } catch (error) {
                    console.error('停止朗读失败:', error);
                  }
                  router.pushUrl({
                    url: 'pages/chinese/PoemDetailPage',
                    params: { poem: JSON.stringify(poem) }
                  });
                })
                .scale({ x: this.isPageLoaded ? 1 : 0.92, y: this.isPageLoaded ? 1 : 0.92 })
                .opacity(this.isPageLoaded ? 1 : 0)
                .animation({
                  duration: 400,
                  curve: Curve.EaseInOut,
                  delay: index * 25
                })
              }
            }, (poem: Poem) => `${poem.id}_${poem.isFavorite ? '1' : '0'}_${this.updateFlag}`)
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(20)
          .columnsGap(20)
        } else {
          List() {
            ForEach(this.getFilteredPoems(), (poem: Poem, index: number) => {
              ListItem() {
                Row() {
                  Column() {
                    Text(poem.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor($r('app.color.text_primary'))
                    Text(`${poem.author}`)
                      .fontSize(12)
                      .fontColor($r('app.color.text_tertiary_bank_card_03'))
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)

                  Text(poem.isFavorite ? '★' : '☆')
                    .fontSize(18)
                    .fontColor(poem.isFavorite ? $r('app.color.text_tertiary_bank_card_03') : $r('app.color.text_primary'))
                    .margin({ right: 12 })
                    .padding(8)
                    .onClick(() => {
                      this.toggleFavorite(poem);
                    })
                    .hitTestBehavior(HitTestMode.Block)

                  Text('查看')
                    .fontSize(12)
                    .fontColor($r('app.color.text_primary'))
                }
                .height(64)
                                .padding({ left: 16, right: 16 })
                .backgroundColor($r('app.color.card_background'))
                .margin({ bottom: 10 })
                .borderRadius(12)
                .onClick(() => {
                  // 点击整行查看详情
                  try {
                    TextReader.stop();
                    this.isPlaying = false;
                  } catch (error) {
                    console.error('停止朗读失败:', error);
                  }
                  router.pushUrl({
                    url: 'pages/chinese/PoemDetailPage',
                    params: { poem: JSON.stringify(poem) }
                  });
                })
              }
            }, (poem: Poem) => `${poem.id}_${poem.isFavorite ? '1' : '0'}_${this.updateFlag}`)
          }
          .divider({ strokeWidth: 0 })
        }
      }
      .layoutWeight(1)
      .padding({
        top: 10,
        left: 20,
        right: 20,
        bottom: 20
      })
      .edgeEffect(EdgeEffect.Spring)

      // 统计信息
      Text(`共收录 ${this.poems.length} 首唐诗`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_secondary'))
        .textAlign(TextAlign.Center)
        .margin({ top: 10, bottom: 20 })
        .backgroundColor($r('app.color.card_background'))
        .padding({ left: 20, right: 20, top: 8, bottom: 8 })
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: $r('app.color.text_tertiary_bank_card_03'),
          offsetX: 0,
          offsetY: 2
        })

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.chinese_bg'))
    .backgroundImageSize(ImageSize.Cover)
    .padding({ bottom: 12 })
}}