import router from '@ohos.router';
import { common, ConfigurationConstant } from '@kit.AbilityKit';
import promptAction from '@ohos.promptAction';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';

// 定义元曲接口
interface Yuanqu {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string;
}

@Entry
@Component
export struct YuanquListPage {
  // 创建100首元曲的列表
  @State private yuanquList: Array<Yuanqu> = [
    // 原始数据保持不变
    // 马致远作品
    {
      id: 1,
      title: '天净沙·秋思',
      author: '马致远',
      content: '枯藤老树昏鸦，小桥流水人家，古道西风瘦马。\n夕阳西下，断肠人在天涯。',
      pinyin: 'kū téng lǎo shù hūn yā, xiǎo qiáo liú shuǐ rén jiā, gǔ dào xī fēng shòu mǎ.\n xī yáng xī xià, duàn cháng rén zài tiān yá.'
    },
    {
      id: 2,
      title: '寿阳曲·远浦帆归',
      author: '马致远',
      content: '夕阳下，酒旆闲，两三航未曾着岸。\n落花水香茅舍晚，断桥头卖鱼人散。',
      pinyin: 'xī yáng xià, jiǔ pèi xián, liǎng sān háng wèi zēng zhe àn.\n luò huā shuǐ xiāng máo shè wǎn, duàn qiáo tóu mài yú rén sàn.'
    },
    {
      id: 3,
      title: '寿阳曲·潇湘夜雨',
      author: '马致远',
      content: '渔灯暗，客梦回，一声声滴人心碎。\n孤舟五更家万里，是离人几行情泪。',
      pinyin: 'yú dēng àn, kè mèng huí, yī shēng shēng dī rén xīn suì.\n gū zhōu wǔ gēng jiā wàn lǐ, shì lí rén jǐ háng qíng lèi.'
    },

    // 白朴作品
    {
      id: 4,
      title: '天净沙·秋',
      author: '白朴',
      content: '孤村落日残霞，轻烟老树寒鸦，一点飞鸿影下。\n青山绿水，白草红叶黄花。',
      pinyin: 'gū cūn luò rì cán xiá, qīng yān lǎo shù hán yā, yī diǎn fēi hóng yǐng xià.\n qīng shān lǜ shuǐ, bái cǎo hóng yè huáng huā.'
    },
    {
      id: 5,
      title: '天净沙·春',
      author: '白朴',
      content: '春山暖日和风，阑干楼阁帘栊，杨柳秋千院中。\n啼莺舞燕，小桥流水飞红。',
      pinyin: 'chūn shān nuǎn rì hé fēng, lán gān lóu gé lián lóng, yáng liǔ qiū qiān yuàn zhōng.\n tí yīng wǔ yàn, xiǎo qiáo liú shuǐ fēi hóng.'
    },

    // 关汉卿作品
    {
      id: 6,
      title: '四块玉·别情',
      author: '关汉卿',
      content: '自送别，心难舍，一点相思几时绝？\n凭阑袖拂杨花雪。溪又斜，山又遮，人去也！',
      pinyin: 'zì sòng bié, xīn nán shě, yī diǎn xiāng sī jǐ shí jué?\n píng lán xiù fú yáng huā xuě. xī yòu xié, shān yòu zhē, rén qù yě!'
    },
    {
      id: 7,
      title: '四块玉·闲适',
      author: '关汉卿',
      content: '旧酒没，新醅泼，老瓦盆边笑呵呵。\n共山僧野叟闲吟和。他出一对鸡，我出一个鹅，闲快活！',
      pinyin: 'jiù jiǔ méi, xīn pēi pō, lǎo wǎ pén biān xiào hē hē.\n gòng shān sēng yě sǒu xián yín hè. tā chū yī duì jī, wǒ chū yī gè é, xián kuài huó!'
    },
    {
      id: 8,
      title: '沉醉东风',
      author: '关汉卿',
      content: '咫尺的天南地北，霎时间月缺花飞。\n手执着饯行杯，眼阁着别离泪。\n刚道得声"保重将息"，痛煞煞教人舍不得。\n好去者，望前程万里！',
      pinyin: 'zhǐ chǐ de tiān nán dì běi, shà shí jiān yuè quē huā fēi.\n shǒu zhí zhe jiàn xíng bēi, yǎn gé zhe bié lí lèi.\n gāng dào dé shēng "bǎo zhòng jiāng xī", tòng shà shà jiào rén shě bu dé.\n hǎo qù zhě, wàng qián chéng wàn lǐ!'
    },

    // 张养浩作品
    {
      id: 9,
      title: '山坡羊·潼关怀古',
      author: '张养浩',
      content: '峰峦如聚，波涛如怒，山河表里潼关路。\n望西都，意踌躇。\n伤心秦汉经行处，宫阙万间都做了土。\n兴，百姓苦；亡，百姓苦！',
      pinyin: 'fēng luán rú jù, bō tāo rú nù, shān hé biǎo lǐ tóng guān lù.\n wàng xī dōu, yì chóu chú.\n shāng xīn qín hàn jīng xíng chù, gōng què wàn jiān dōu zuò le tǔ.\n xīng, bǎi xìng kǔ; wáng, bǎi xìng kǔ!'
    },
    {
      id: 10,
      title: '山坡羊·骊山怀古',
      author: '张养浩',
      content: '骊山四顾，阿房一炬，当时奢侈今何处？\n只见草萧疏，水萦纡。\n至今遗恨迷烟树。列国周齐秦汉楚。\n赢，都变做了土；输，都变做了土。',
      pinyin: 'lí shān sì gù, ā fáng yī jù, dāng shí shē chǐ jīn hé chù?\n zhǐ jiàn cǎo xiāo shū, shuǐ yíng yū.\n zhì jīn yí hèn mí yān shù. liè guó zhōu qí qín hàn chǔ.\n yíng, dōu biàn zuò le tǔ; shū, dōu biàn zuò le tǔ.'
    },

    // 其他名家作品
    {
      id: 11,
      title: '水仙子·夜雨',
      author: '徐再思',
      content: '一声梧叶一声秋，一点芭蕉一点愁，三更归梦三更后。\n落灯花棋未收，叹新丰逆旅淹留。\n枕上十年事，江南二老忧，都到心头。',
      pinyin: 'yī shēng wú yè yī shēng qiū, yī diǎn bā jiāo yī diǎn chóu, sān gēng guī mèng sān gēng hòu.\n luò dēng huā qí wèi shōu, tàn xīn fēng nì lǚ yān liú.\n zhěn shàng shí nián shì, jiāng nán èr lǎo yōu, dōu dào xīn tóu.'
    },
    {
      id: 12,
      title: '蟾宫曲·春情',
      author: '徐再思',
      content: '平生不会相思，才会相思，便害相思。\n身似浮云，心如飞絮，气若游丝。\n空一缕余香在此，盼千金游子何之。\n证候来时，正是何时？\n灯半昏时，月半明时。',
      pinyin: 'píng shēng bú huì xiāng sī, cái huì xiāng sī, biàn hài xiāng sī.\n shēn sì fú yún, xīn rú fēi xù, qì ruò yóu sī.\n kōng yī lǚ yú xiāng zài cǐ, pàn qiān jīn yóu zǐ hé zhī.\n zhèng hòu lái shí, zhèng shì hé shí?\n dēng bàn hūn shí, yuè bàn míng shí.'
    },
    {
      id: 13,
      title: '折桂令·春情',
      author: '徐再思',
      content: '平生不会相思，才会相思，便害相思。\n身似浮云，心如飞絮，气若游丝。\n空一缕余香在此，盼千金游子何之。\n证候来时，正是何时？\n灯半昏时，月半明时。',
      pinyin: 'píng shēng bú huì xiāng sī, cái huì xiāng sī, biàn hài xiāng sī.\n shēn sì fú yún, xīn rú fēi xù, qì ruò yóu sī.\n kōng yī lǚ yú xiāng zài cǐ, pàn qiān jīn yóu zǐ hé zhī.\n zhèng hòu lái shí, zhèng shì hé shí?\n dēng bàn hūn shí, yuè bàn míng shí.'
    },
    {
      id: 14,
      title: '沉醉东风·渔夫',
      author: '白朴',
      content: '黄芦岸白蘋渡口，绿柳堤红蓼滩头。\n虽无刎颈交，却有忘机友，点秋江白鹭沙鸥。\n傲杀人间万户侯，不识字烟波钓叟。',
      pinyin: 'huáng lú àn bái pín dù kǒu, lǜ liǔ dī hóng liǎo tān tóu.\n suī wú wěn jǐng jiāo, què yǒu wàng jī yǒu, diǎn qiū jiāng bái lù shā ōu.\n ào shā rén jiān wàn hù hóu, bú shí zì yān bō diào sǒu.'
    },
    {
      id: 15,
      title: '天净沙·冬',
      author: '白朴',
      content: '一声画角谯门，半庭新月黄昏，雪里山前水滨。\n竹篱茅舍，淡烟衰草孤村。',
      pinyin: 'yī shēng huà jiǎo qiáo mén, bàn tíng xīn yuè huáng hūn, xuě lǐ shān qián shuǐ bīn.\n zhú lí máo shè, dàn yān shuāi cǎo gū cūn.'
    },
    {
      id: 16,
      title: '蟾宫曲·梦中作',
      author: '郑光祖',
      content: '半窗幽梦微茫，歌罢钱塘，赋罢高唐。\n风入罗帏，爽入疏棂，月照纱窗。\n缥缈见梨花淡妆，依稀闻兰麝余香。\n唤我良人，试问清狂，怎不思量？',
      pinyin: 'bàn chuāng yōu mèng wēi máng, gē bà qián táng, fù bà gāo táng.\n fēng rù luó wéi, shuǎng rù shū líng, yuè zhào shā chuāng.\n piāo miǎo jiàn lí huā dàn zhuāng, yī xī wén lán shè yú xiāng.\n huàn wǒ liáng rén, shì wèn qīng kuáng, zěn bú sī liang?'
    },
    {
      id: 17,
      title: '醉太平·讥贪小利者',
      author: '无名氏',
      content: '夺泥燕口，削铁针头，刮金佛面细搜求：无中觅有。\n鹌鹑嗉里寻豌豆，鹭鸶腿上劈精肉，蚊子腹内刳脂油。\n亏老先生下手！',
      pinyin: 'duó ní yàn kǒu, xuē tiě zhēn tóu, guā jīn fó miàn xì sōu qiú: wú zhōng mì yǒu.\n ān chún sù lǐ xún wān dòu, lù sī tuǐ shàng pǐ jīng ròu, wén zi fù nèi kū zhī yóu.\n kuī lǎo xiān shēng xià shǒu!'
    },
    {
      id: 18,
      title: '人月圆·山中书事',
      author: '张可久',
      content: '兴亡千古繁华梦，诗眼倦天涯。\n孔林乔木，吴宫蔓草，楚庙寒鸦。\n数间茅舍，藏书万卷，投老村家。\n山中何事？松花酿酒，春水煎茶。',
      pinyin: 'xīng wáng qiān gǔ fán huá mèng, shī yǎn juàn tiān yá.\n kǒng lín qiáo mù, wú gōng màn cǎo, chǔ miào hán yā.\n shù jiān máo shè, cáng shū wàn juàn, tóu lǎo cūn jiā.\n shān zhōng hé shì? sōng huā niàng jiǔ, chūn shuǐ jiān chá.'
    },
    {
      id: 19,
      title: '普天乐·秋怀',
      author: '张可久',
      content: '为谁忙，莫非命。\n西风驿马，落月书灯，青天蜀道难，红叶吴江冷。\n两字功名频看镜，不饶人白发星星。\n钓鱼子陵，思莼季鹰，笑我飘零。',
      pinyin: 'wèi shuí máng, mò fēi mìng.\n xī fēng yì mǎ, luò yuè shū dēng, qīng tiān shǔ dào nán, hóng yè wú jiāng lěng.\n liǎng zì gōng míng pín kàn jìng, bú ráo rén bái fà xīng xīng.\n diào yú zǐ líng, sī chún jì yīng, xiào wǒ piāo líng.'
    },
    {
      id: 20,
      title: '小桃红·寄鉴湖诸友',
      author: '张可久',
      content: '一城秋雨豆花凉，闲倚平山望。\n不似年时鉴湖上，锦云香，采莲人语荷花荡。\n西风雁行，清溪渔唱，吹恨入沧浪。',
      pinyin: 'yī chéng qiū yǔ dòu huā liáng, xián yǐ píng shān wàng.\n bú sì nián shí jiàn hú shàng, jǐn yún xiāng, cǎi lián rén yǔ hé huā dàng.\n xī fēng yàn háng, qīng xī yú chàng, chuī hèn rù cāng làng.'
    }, // 新增21-100首
    {
      id: 21,
      title: '沉醉东风·闲居',
      author: '卢挚',
      content: '恰离了绿水青山那搭，早来到竹篱茅舍人家。\n野花路畔开，村酒槽头榨。\n直吃的欠欠答答。\n醉了山童不劝咱，白发上黄花乱插。',
      pinyin: 'qià lí le lǜ shuǐ qīng shān nà dā, zǎo lái dào zhú lí máo shè rén jiā.\n yě huā lù pàn kāi, cūn jiǔ cáo tóu zhà.\n zhí chī de qiàn qiàn dā dā.\n zuì le shān tóng bú quàn zán, bái fà shàng huáng huā luàn chā.'
    },
    {
      id: 22,
      title: '寿阳曲·咏李白',
      author: '姚燧',
      content: '贵妃亲擎砚，力士与脱靴。\n御调羹就飧不谢。\n醉模糊将吓蛮书便写。\n写着甚"杨柳岸晓风残月"。',
      pinyin: 'guì fēi qīn qíng yàn, lì shì yǔ tuō xuē.\n yù tiáo gēng jiù sūn bú xiè.\n zuì mó hu jiāng xià mán shū biàn xiě.\n xiě zhe shèn "yáng liǔ àn xiǎo fēng cán yuè".'
    },
    {
      id: 23,
      title: '殿前欢·对菊自叹',
      author: '张养浩',
      content: '可怜秋，一帘疏雨暗西楼。\n黄花零落重阳后，减尽风流。\n对黄花人自羞。\n花依旧，人比黄花瘦。\n问花不语，花替人愁。',
      pinyin: 'kě lián qiū, yī lián shū yǔ àn xī lóu.\n huáng huā líng luò chóng yáng hòu, jiǎn jìn fēng liú.\n duì huáng huā rén zì xiū.\n huā yī jiù, rén bǐ huáng huā shòu.\n wèn huā bú yǔ, huā tì rén chóu.'
    },
    {
      id: 24,
      title: '水仙子·怀古',
      author: '张可久',
      content: '秋风远塞皂雕旗，明月高台金凤杯。\n红妆肯为苍生计，女妖娆能有几？\n两蛾眉千古光辉：\n汉和番昭君去，越吞吴西施归。\n战马空肥。',
      pinyin: 'qiū fēng yuǎn sài zào diāo qí, míng yuè gāo tái jīn fèng bēi.\n hóng zhuāng kěn wèi cāng shēng jì, nǚ yāo ráo néng yǒu jǐ?\n liǎng é méi qiān gǔ guāng huī:\n hàn hé fān zhāo jūn qù, yuè tūn wú xī shī guī.\n zhàn mǎ kōng féi.'
    },
    {
      id: 25,
      title: '折桂令·九日',
      author: '张可久',
      content: '对青山强整乌纱。\n归雁横秋，倦客思家。\n翠袖殷勤，金杯错落，玉手琵琶。\n人老去西风白发，蝶愁来明日黄花。\n回首天涯，一抹斜阳，数点寒鸦。',
      pinyin: 'duì qīng shān qiáng zhěng wū shā.\n guī yàn héng qiū, juàn kè sī jiā.\n cuì xiù yīn qín, jīn bēi cuò luò, yù shǒu pí pá.\n rén lǎo qù xī fēng bái fà, dié chóu lái míng rì huáng huā.\n huí shǒu tiān yá, yī mǒ xié yáng, shù diǎn hán yā.'
    },
    {
      id: 26,
      title: '满庭芳·渔父词',
      author: '乔吉',
      content: '秋江暮景，胭脂林障，翡翠山屏。\n几年罢却青云兴，直泛沧溟。\n卧御榻弯的腿疼，坐羊皮惯得身轻。\n风初定，丝纶慢整，牵动一潭星。',
      pinyin: 'qiū jiāng mù jǐng, yān zhī lín zhàng, fěi cuì shān píng.\n jǐ nián bà què qīng yún xìng, zhí fàn cāng míng.\n wò yù tá wān de tuǐ téng, zuò yáng pí guàn dé shēn qīng.\n fēng chū dìng, sī lún màn zhěng, qiān dòng yī tán xīng.'
    },
    {
      id: 27,
      title: '水仙子·寻梅',
      author: '乔吉',
      content: '冬前冬后几村庄，溪北溪南两履霜。\n树头树底孤山上。\n冷风来何处香？\n忽相逢缟袂绡裳。\n酒醒寒惊梦，笛凄春断肠。\n淡月昏黄。',
      pinyin: 'dōng qián dōng hòu jǐ cūn zhuāng, xī běi xī nán liǎng lǚ shuāng.\n shù tóu shù dǐ gū shān shàng.\n lěng fēng lái hé chù xiāng?\n hū xiāng féng gǎo mèi xiāo shāng.\n jiǔ xǐng hán jīng mèng, dí qī chūn duàn cháng.\n dàn yuè hūn huáng.'
    },
    {
      id: 28,
      title: '清江引·惜别',
      author: '贯云石',
      content: '若还与他相见时，道个真传示：\n不是不修书，不是无才思，\n绕清江买不得天样纸。',
      pinyin: 'ruò hái yǔ tā xiāng jiàn shí, dào gè zhēn chuán shì:\n bú shì bú xiū shū, bú shì wú cái sī,\n rào qīng jiāng mǎi bu dé tiān yàng zhǐ.'
    },
    {
      id: 29,
      title: '殿前欢·吊屈原',
      author: '贯云石',
      content: '楚怀王，忠臣跳入汨罗江。\n《离骚》读罢空惆怅，日月同光。\n伤心来笑一场，笑你个三闾强，\n为甚不身心放？\n沧浪污你，你污沧浪。',
      pinyin: 'chǔ huái wáng, zhōng chén tiào rù mì luó jiāng.\n "lí sāo" dú bà kōng chóu chàng, rì yuè tóng guāng.\n shāng xīn lái xiào yī chǎng, xiào nǐ gè sān lǘ qiáng,\n wèi shèn bú shēn xīn fàng?\n cāng làng wū nǐ, nǐ wū cāng làng.'
    },
    {
      id: 30,
      title: '蟾宫曲·春思',
      author: '郑光祖',
      content: '雨打梨花深闭门，忘了青春，误了青春。\n赏心乐事共谁论？花下销魂，月下销魂。\n愁聚眉峰尽日颦，千点啼痕，万点啼痕。\n晓看天色暮看云，行也思君，坐也思君。',
      pinyin: 'yǔ dǎ lí huā shēn bì mén, wàng le qīng chūn, wù le qīng chūn.\n shǎng xīn lè shì gòng shéi lùn? huā xià xiāo hún, yuè xià xiāo hún.\n chóu jù méi fēng jìn rì pín, qiān diǎn tí hén, wàn diǎn tí hén.\n xiǎo kàn tiān sè mù kàn yún, xíng yě sī jūn, zuò yě sī jūn.'
    },
    {
      id: 31,
      title: '天净沙·即事',
      author: '乔吉',
      content: '莺莺燕燕春春，花花柳柳真真。\n事事风风韵韵，娇娇嫩嫩，停停当当人人。',
      pinyin: 'yīng yīng yàn yàn chūn chūn, huā huā liǔ liǔ zhēn zhēn.\n shì shì fēng fēng yùn yùn, jiāo jiāo nèn nèn, tíng tíng dāng dāng rén rén.'
    },
    {
      id: 32,
      title: '凭栏人·寄征衣',
      author: '姚燧',
      content: '欲寄君衣君不还，不寄君衣君又寒。\n寄与不寄间，妾身千万难。',
      pinyin: 'yù jì jūn yī jūn bù huán, bú jì jūn yī jūn yòu hán.\n jì yǔ bú jì jiān, qiè shēn qiān wàn nán.'
    },
    {
      id: 33,
      title: '阳春曲·题情',
      author: '白朴',
      content: '从来好事天生俭，自古瓜儿苦后甜。\n奶娘催逼紧拘钳，甚是严，\n越间阻越情忺。',
      pinyin: 'cóng lái hǎo shì tiān shēng jiǎn, zì gǔ guā ér kǔ hòu tián.\n nǎi niáng cuī bī jǐn jū qián, shèn shì yán,\n yuè jiān zǔ yuè qíng xiān.'
    },
    {
      id: 34,
      title: '梧叶儿·有所思',
      author: '徐再思',
      content: '人何处，草自春。\n柳外断肠人。\n倚遍危楼，梦回芳草，恨满孤云。',
      pinyin: 'rén hé chù, cǎo zì chūn.\n liǔ wài duàn cháng rén.\n yǐ biàn wēi lóu, mèng huí fāng cǎo, hèn mǎn gū yún.'
    },
    {
      id: 35,
      title: '一半儿·题情',
      author: '关汉卿',
      content: '云鬟雾鬓胜堆鸦，浅露金莲簌绛纱。\n不比等闲墙外花。\n骂你个俏冤家，一半儿难当一半儿耍。',
      pinyin: 'yún huán wù bìn shèng duī yā, qiǎn lù jīn lián sù jiàng shā.\n bú bǐ děng xián qiáng wài huā.\n mà nǐ gè qiào yuān jiā, yī bàn ér nán dāng yī bàn ér shuǎ.'
    },
    {
      id: 36,
      title: '一半儿·春妆',
      author: '查德卿',
      content: '自将杨柳品题人，笑捻花枝比较春。\n输与海棠三四分。\n再偷匀，一半儿胭脂一半儿粉。',
      pinyin: 'zì jiāng yáng liǔ pǐn tí rén, xiào niǎn huā zhī bǐ jiào chūn.\n shū yǔ hǎi táng sān sì fēn.\n zài tōu yún, yī bàn ér yān zhī yī bàn ér fěn.'
    },
    {
      id: 37,
      title: '沉醉东风·送别',
      author: '卢挚',
      content: '残花酝酿蜂儿蜜，细雨调和燕子泥。\n绿窗春睡觉来迟。\n谁唤起？窗外晓莺啼。',
      pinyin: 'cán huā yùn niàng fēng ér mì, xì yǔ tiáo hé yàn zi ní.\n lǜ chuāng chūn shuì jué lái chí.\n shéi huàn qǐ? chuāng wài xiǎo yīng tí.'
    },
    {
      id: 38,
      title: '寿阳曲·答卢疏斋',
      author: '珠帘秀',
      content: '山无数，烟万缕。\n憔悴煞玉堂人物。\n倚蓬窗一身儿活受苦，\n恨不得随大江东去。',
      pinyin: 'shān wú shù, yān wàn lǚ.\n qiáo cuì shà yù táng rén wù.\n yǐ péng chuāng yī shēn ér huó shòu kǔ,\n hèn bu dé suí dà jiāng dōng qù.'
    },
    {
      id: 39,
      title: '折桂令·春情',
      author: '徐再思',
      content: '平生不会相思，才会相思，便害相思。\n身似浮云，心如飞絮，气若游丝。\n空一缕余香在此，盼千金游子何之。\n证候来时，正是何时？\n灯半昏时，月半明时。',
      pinyin: 'píng shēng bú huì xiāng sī, cái huì xiāng sī, biàn hài xiāng sī.\n shēn sì fú yún, xīn rú fēi xù, qì ruò yóu sī.\n kōng yī lǚ yú xiāng zài cǐ, pàn qiān jīn yóu zǐ hé zhī.\n zhèng hòu lái shí, zhèng shì hé shí?\n dēng bàn hūn shí, yuè bàn míng shí.'
    },
    {
      id: 40,
      title: '水仙子·咏江南',
      author: '张养浩',
      content: '一江烟水照晴岚，两岸人家接画檐。\n芰荷丛一段秋光淡。\n看沙鸥舞再三，卷香风十里珠帘。\n画船儿天边至，酒旗儿风外飐。\n爱杀江南！',
      pinyin: 'yī jiāng yān shuǐ zhào qíng lán, liǎng àn rén jiā jiē huà yán.\n jì hé cóng yī duàn qiū guāng dàn.\n kàn shā ōu wǔ zài sān, juǎn xiāng fēng shí lǐ zhū lián.\n huà chuán ér tiān biān zhì, jiǔ qí ér fēng wài zhǎn.\n ài shā jiāng nán!'
    },
    {
      id: 41,
      title: '山坡羊·春日郊行',
      author: '薛昂夫',
      content: '长安怀古，咸阳怀古。\n咸阳宫阙都做了土。\n渔樵没处，英雄无觅。\n山川依旧，英雄无觅。\n山川依旧，英雄无觅。\n山川依旧，英雄无觅。',
      pinyin: 'cháng ān huái gǔ, xián yáng huái gǔ.\n xián yáng gōng què dōu zuò le tǔ.\n yú qiáo méi chù, yīng xióng wú mì.\n shān chuān yī jiù, yīng xióng wú mì.\n shān chuān yī jiù, yīng xióng wú mì.\n shān chuān yī jiù, yīng xióng wú mì.'
    },
    {
      id: 42,
      title: '蟾宫曲·怀古',
      author: '查德卿',
      content: '问从来谁是英雄？一个农夫，一个渔翁。\n晦迹南阳，栖身东海，一举成功。\n八阵图名成卧龙，六韬书功在飞熊。\n霸业成空，遗恨无穷。\n蜀道寒云，渭水秋风。',
      pinyin: 'wèn cóng lái shéi shì yīng xióng? yī gè nóng fū, yī gè yú wēng.\n huì jì nán yáng, qī shēn dōng hǎi, yī jǔ chéng gōng.\n bā zhèn tú míng chéng wò lóng, liù tāo shū gōng zài fēi xióng.\n bà yè chéng kōng, yí hèn wú qióng.\n shǔ dào hán yún, wèi shuǐ qiū fēng.'
    },
    {
      id: 43,
      title: '天净沙·夏',
      author: '白朴',
      content: '晴云轻漾，熏风无浪，开樽避暑争相向。\n映湖光，逞新妆。\n笙歌鼎沸南湖荡，今夜且休回画舫。\n风，满座凉；莲，入梦香。',
      pinyin: 'qíng yún qīng yàng, xūn fēng wú làng, kāi zūn bì shǔ zhēng xiāng xiàng.\n yìng hú guāng, chěng xīn zhuāng.\n shēng gē dǐng fèi nán hú dàng, jīn yè qiě xiū huí huà fǎng.\n fēng, mǎn zuò liáng; lián, rù mèng xiāng.'
    },
    {
      id: 44,
      title: '天净沙·晚春',
      author: '马致远',
      content: '梅香柳嫩春深，蝶蜂莺燕争心。\n暖日和风，园林台榭，好光景。\n春将暮，花残片片飞。\n红雨乱，绿阴肥。',
      pinyin: 'méi xiāng liǔ nèn chūn shēn, dié fēng yīng yàn zhēng xīn.\n nuǎn rì hé fēng, yuán lín tái xiè, hǎo guāng jǐng.\n chūn jiāng mù, huā cán piàn piàn fēi.\n hóng yǔ luàn, lǜ yīn féi.'
    },
    {
      id: 45,
      title: '寿阳曲·江天暮雪',
      author: '马致远',
      content: '天将暮，雪乱舞，半梅花半飘柳絮。\n江上晚来堪画处，钓鱼人一蓑归去。',
      pinyin: 'tiān jiāng mù, xuě luàn wǔ, bàn méi huā bàn piāo liǔ xù.\n jiāng shàng wǎn lái kān huà chù, diào yú rén yī suō guī qù.'
    },
    {
      id: 46,
      title: '拨不断·叹世',
      author: '马致远',
      content: '布衣中，问英雄。\n王图霸业成何用！\n禾黍高低六代宫，楸梧远近千官冢。\n一场恶梦。',
      pinyin: 'bù yī zhōng, wèn yīng xióng.\n wáng tú bà yè chéng hé yòng!\n hé shǔ gāo dī liù dài gōng, qiū wú yuǎn jìn qiān guān zhǒng.\n yī chǎng è mèng.'
    },
    {
      id: 47,
      title: '清江引·春思',
      author: '张可久',
      content: '黄莺乱啼门外柳，雨细清明后。\n能消几日春，又是相思瘦。\n梨花小窗人病酒。',
      pinyin: 'huáng yīng luàn tí mén wài liǔ, yǔ xì qīng míng hòu.\n néng xiāo jǐ rì chūn, yòu shì xiāng sī shòu.\n lí huā xiǎo chuāng rén bìng jiǔ.'
    },
    {
      id: 48,
      title: '落梅风·蔷薇露',
      author: '马致远',
      content: '蔷薇露，荷叶雨，菊花霜冷香户。\n梅梢月斜人影孤，恨薄情四时辜负。',
      pinyin: 'qiáng wēi lù, hé yè yǔ, jú huā shuāng lěng xiāng hù.\n méi shāo yuè xié rén yǐng gū, hèn bó qíng sì shí gū fù.'
    },
    {
      id: 49,
      title: '折桂令·读史',
      author: '张养浩',
      content: '读史令人心酸，可处降秦，可处归汉？\n论功则麒麟阁上，罪则宜下。\n想当日，韩侯忍死，只为云梦。\n到如今，成也萧何，败也萧何。\n千古是非，谁是谁非？',
      pinyin: 'dú shǐ lìng rén xīn suān, kě chù jiàng qín, kě chù guī hàn?\n lùn gōng zé qí lín gé shàng, zuì zé yí xià.\n xiǎng dāng rì, hán hóu rěn sǐ, zhǐ wèi yún mèng.\n dào rú jīn, chéng yě xiāo hé, bài yě xiāo hé.\n qiān gǔ shì fēi, shéi shì shéi fēi?'
    },
    {
      id: 50,
      title: '水仙子·咏雪',
      author: '乔吉',
      content: '冷无香柳絮扑将来，冻成片梨花拂不开。\n大灰泥漫了三千界，银棱了东海。\n探梅的心噤难捱。\n面瓮儿里袁安舍，盐堆儿里党尉宅，粉缸儿里舞榭歌台。',
      pinyin: 'lěng wú xiāng liǔ xù pū jiāng lái, dòng chéng piàn lí huā fú bu kāi.\n dà huī ní màn le sān qiān jiè, yín léng le dōng hǎi.\n tàn méi de xīn jìn nán ái.\n miàn wèng ér lǐ yuán ān shè, yán duī ér lǐ dǎng wèi zhái, fěn gāng ér lǐ wǔ xiè gē tái.'
    },
    {
      id: 51,
      title: '梧叶儿·春思',
      author: '徐再思',
      content: '芳草思南浦，行云梦楚阳。\n流水恨潇湘。\n何处是归程？\n长亭共短亭。',
      pinyin: 'fāng cǎo sī nán pǔ, xíng yún mèng chǔ yáng.\n liú shuǐ hèn xiāo xiāng.\n hé chù shì guī chéng?\n cháng tíng gòng duǎn tíng.'
    },
    {
      id: 52,
      title: '一半儿·秋日湖上',
      author: '张可久',
      content: '残荷飒飒西风急，败柳萧萧落日低。\n孤雁声声寒雁啼。\n恨分离，一半儿相思一半儿泪。',
      pinyin: 'cán hé sà sà xī fēng jí, bài liǔ xiāo xiāo luò rì dī.\n gū yàn shēng shēng hán yàn tí.\n hèn fēn lí, yī bàn ér xiāng sī yī bàn ér lèi.'
    },
    {
      id: 53,
      title: '沉醉东风·秋日旅怀',
      author: '卢挚',
      content: '挂绝壁枯松倒倚，落残霞孤鹜齐飞。\n四围不尽山，一望无穷水。\n散西风满天秋意。\n夜静云帆月影低，载我在潇湘画里。',
      pinyin: 'guà jué bì kū sōng dào yǐ, luò cán xiá gū wù qí fēi.\n sì wéi bú jìn shān, yī wàng wú qióng shuǐ.\n sàn xī fēng mǎn tiān qiū yì.\n yè jìng yún fān yuè yǐng dī, zài wǒ zài xiāo xiāng huà lǐ.'
    },
    {
      id: 54,
      title: '殿前欢·客中',
      author: '张可久',
      content: '望长安，前程渺渺鬓斑斑。\n南来北往随征雁，行路艰难。\n青泥小剑关，红叶湓江岸，白草连云栈。\n功名半纸，风雪千山。',
      pinyin: 'wàng cháng ān, qián chéng miǎo miǎo bìn bān bān.\n nán lái běi wǎng suí zhēng yàn, xíng lù jiān nán.\n qīng ní xiǎo jiàn guān, hóng yè pén jiāng àn, bái cǎo lián yún zhàn.\n gōng míng bàn zhǐ, fēng xuě qiān shān.'
    },
    {
      id: 55,
      title: '蟾宫曲·西湖',
      author: '奥敦周卿',
      content: '西湖烟水茫茫，百顷风潭，十里荷香。\n宜雨宜晴，宜西施淡抹浓妆。\n尾尾相衔画舫，尽欢声无日不笙簧。\n春暖花香，岁稔时康。\n真乃上有天堂，下有苏杭。',
      pinyin: 'xī hú yān shuǐ máng máng, bǎi qǐng fēng tán, shí lǐ hé xiāng.\n yí yǔ yí qíng, yí xī shī dàn mǒ nóng zhuāng.\n wěi wěi xiāng xián huà fǎng, jìn huān shēng wú rì bú shēng huáng.\n chūn nuǎn huā xiāng, suì rěn shí kāng.\n zhēn nǎi shàng yǒu tiān táng, xià yǒu sū háng.'
    },
    {
      id: 56,
      title: '寿阳曲·别珠帘秀',
      author: '卢挚',
      content: '才欢悦，早间别，痛煞煞好难割舍。\n画船儿载将春去也，空留下半江明月。',
      pinyin: 'cái huān yuè, zǎo jiān bié, tòng shà shà hǎo nán gē shě.\n huà chuán ér zài jiāng chūn qù yě, kōng liú xià bàn jiāng míng yuè.'
    },
    {
      id: 57,
      title: '折桂令·叹世',
      author: '马致远',
      content: '咸阳百二山河，两字功名，几阵干戈。\n项废东吴，刘兴西蜀，梦说南柯。\n韩信功兀的般证果，蒯通言那里是风魔？\n成也萧何，败也萧何，醉了由他！',
      pinyin: 'xián yáng bǎi èr shān hé, liǎng zì gōng míng, jǐ zhèn gān gē.\n xiàng fèi dōng wú, liú xīng xī shǔ, mèng shuō nán kē.\n hán xìn gōng wù de bān zhèng guǒ, kuǎi tōng yán nà lǐ shì fēng mó?\n chéng yě xiāo hé, bài yě xiāo hé, zuì le yóu tā!'
    },
    {
      id: 58,
      title: '水仙子·夜雨',
      author: '吴西逸',
      content: '梧桐一夜雨声声，客梦三更魂暗惊。\n灯花落尽秋窗冷，数归期犹未定。\n雁来时书信无凭。\n眼睁睁愁万种，闷恹恹病九成。\n多管是客里伤情。',
      pinyin: 'wú tóng yī yè yǔ shēng shēng, kè mèng sān gēng hún àn jīng.\n dēng huā luò jìn qiū chuāng lěng, shù guī qī yóu wèi dìng.\n yàn lái shí shū xìn wú píng.\n yǎn zhēng zhēng chóu wàn zhǒng, mèn yān yān bìng jiǔ chéng.\n duō guǎn shì kè lǐ shāng qíng.'
    },
    {
      id: 59,
      title: '天净沙·江上',
      author: '乔吉',
      content: '嗈嗈落雁平沙，依依孤鹜残霞。\n隔水疏林几家。\n小舟如画，渔歌唱入芦花。',
      pinyin: 'yōng yōng luò yàn píng shā, yī yī gū wù cán xiá.\n gé shuǐ shū lín jǐ jiā.\n xiǎo zhōu rú huà, yú gē chàng rù lú huā.'
    },
    {
      id: 60,
      title: '清江引·立春',
      author: '贯云石',
      content: '金钗影摇春燕斜，木杪生春叶。\n水塘春始波，火候春初热。\n土牛儿载将春到也。',
      pinyin: 'jīn chāi yǐng yáo chūn yàn xié, mù miǎo shēng chūn yè.\n shuǐ táng chūn shǐ bō, huǒ hòu chūn chū rè.\n tǔ niú ér zài jiāng chūn dào yě.'
    },
    {
      id: 61,
      title: '蟾宫曲·怀钱塘',
      author: '卢挚',
      content: '问钱塘西湖上，小亭中有古词章。\n歌一曲苏小小，恨千古才郎。\n画船儿载将春去也，空留下半江月色。\n想当年，苏小风流，钱塘繁华。',
      pinyin: 'wèn qián táng xī hú shàng, xiǎo tíng zhōng yǒu gǔ cí zhāng.\n gē yī qū sū xiǎo xiǎo, hèn qiān gǔ cái láng.\n huà chuán ér zài jiāng chūn qù yě, kōng liú xià bàn jiāng yuè sè.\n xiǎng dāng nián, sū xiǎo fēng liú, qián táng fán huá.'
    },
    {
      id: 62,
      title: '折桂令·荆溪即事',
      author: '乔吉',
      content: '问荆溪溪上人家：为甚人家，不种梅花？\n老树支门，荒蒲绕岸，苦竹圈笆。\n寺无僧狐狸样瓦，官无事乌鼠当衙。\n白水黄沙，倚遍阑干，数尽啼鸦。',
      pinyin: 'wèn jīng xī xī shàng rén jiā: wèi shèn rén jiā, bú zhǒng méi huā?\n lǎo shù zhī mén, huāng pú rào àn, kǔ zhú quān bā.\n sì wú sēng hú li yàng wǎ, guān wú shì wū shǔ dāng yá.\n bái shuǐ huáng shā, yǐ biàn lán gān, shù jìn tí yā.'
    },
    {
      id: 63,
      title: '水仙子·归兴',
      author: '张可久',
      content: '淡文章不到紫薇郎，小根脚难登白玉堂。\n远功名怕处风波险。\n大刚来是非多，枉了人张王。\n休官归去，何用忙？\n有田园真故乡。\n归来也，松菊犹存，陶令不忘。',
      pinyin: 'dàn wén zhāng bú dào zǐ wēi láng, xiǎo gēn jiǎo nán dēng bái yù táng.\n yuǎn gōng míng pà chù fēng bō xiǎn.\n dà gāng lái shì fēi duō, wǎng le rén zhāng wáng.\n xiū guān guī qù, hé yòng máng?\n yǒu tián yuán zhēn gù xiāng.\n guī lái yě, sōng jú yóu cún, táo lìng bú wàng.'
    },
    {
      id: 64,
      title: '殿前欢·登江山第一楼',
      author: '乔吉',
      content: '拍阑干，雾花吹鬓海风寒。\n浩歌惊得浮云散。\n细数青山，指蓬莱一望间。\n纱巾岸，鹤背骑来惯。\n举头长啸，直上天坛。',
      pinyin: 'pāi lán gān, wù huā chuī bìn hǎi fēng hán.\n hào gē jīng dé fú yún sàn.\n xì shù qīng shān, zhǐ péng lái yī wàng jiān.\n shā jīn àn, hè bèi qí lái guàn.\n jǔ tóu cháng xiào, zhí shàng tiān tán.'
    },
    {
      id: 65,
      title: '沉醉东风·幽居',
      author: '卢挚',
      content: '恰离了绿水青山那搭，早来到竹篱茅舍人家。\n野花路畔开，村酒槽头榨。\n直吃的欠欠答答。\n醉了山童不劝咱，白发上黄花乱插。',
      pinyin: 'qià lí le lǜ shuǐ qīng shān nà dā, zǎo lái dào zhú lí máo shè rén jiā.\n yě huā lù pàn kāi, cūn jiǔ cáo tóu zhà.\n zhí chī de qiàn qiàn dā dā.\n zuì le shān tóng bú quàn zán, bái fà shàng huáng huā luàn chā.'
    },
    {
      id: 66,
      title: '天净沙·即事',
      author: '乔吉',
      content: '女子眉纤，额畔春山。\n娇羞一点，红透腮边。\n恰似梨花，带雨开颜。\n风流处，惹人怜。',
      pinyin: 'nǚ zǐ méi xiān, é pàn chūn shān.\n jiāo xiū yī diǎn, hóng tòu sāi biān.\n qià sì lí huā, dài yǔ kāi yán.\n fēng liú chù, rě rén lián.'
    },
    {
      id: 67,
      title: '一半儿·题情',
      author: '王和卿',
      content: '书来和泪怕开缄，又不归来空再三。\n落得个病恹恹。\n一半儿因咱，一半儿因俺。',
      pinyin: 'shū lái hé lèi pà kāi jiān, yòu bù guī lái kōng zài sān.\n luò dé gè bìng yān yān.\n yī bàn ér yīn zán, yī bàn ér yīn ǎn.'
    },
    {
      id: 68,
      title: '梧叶儿·嘲谎人',
      author: '无名氏',
      content: '东村里鸡生凤，南庄上马变牛。\n六月里裹皮裘。\n瓦垄上宜栽树，阳沟里好驾舟。\n瓮来大肉馒头。\n俺家的茄子大如斗。',
      pinyin: 'dōng cūn lǐ jī shēng fèng, nán zhuāng shàng mǎ biàn niú.\n liù yuè lǐ guǒ pí qiú.\n wǎ lǒng shàng yí zāi shù, yáng gōu lǐ hǎo jià zhōu.\n wèng lái dà ròu mán tóu.\n ǎn jiā de qié zi dà rú dǒu.'
    },
    {
      id: 69,
      title: '醉太平·叹子弟',
      author: '无名氏',
      content: '寻葫芦锯瓢，掐葫芦种瓢。\n葫芦根上倒栽苗，葫芦架倒。\n葫芦瓮里舀清醪，葫芦叶上包。\n葫芦老时正好，葫芦架下闲游倒。\n葫芦缠到老，葫芦缠到老。',
      pinyin: 'xún hú lu jù piáo, qiā hú lu zhǒng piáo.\n hú lu gēn shàng dào zāi miáo, hú lu jià dào.\n hú lu wèng lǐ yǎo qīng láo, hú lu yè shàng bāo.\n hú lu lǎo shí zhèng hǎo, hú lu jià xià xián yóu dào.\n hú lu chán dào lǎo, hú lu chán dào lǎo.'
    },
    {
      id: 70,
      title: '水仙子·遣怀',
      author: '乔吉',
      content: '一生疏懒厌逢迎，十日九闲半日晴。\n门前花柳栽成径，春来风景新。\n好光阴都属闲人。\n谁肯来相问？\n青山绿水，白草红叶黄花。',
      pinyin: 'yī shēng shū lǎn yàn féng yíng, shí rì jiǔ xián bàn rì qíng.\n mén qián huā liǔ zāi chéng jìng, chūn lái fēng jǐng xīn.\n hǎo guāng yīn dōu shǔ xián rén.\n shéi kěn lái xiāng wèn?\n qīng shān lǜ shuǐ, bái cǎo hóng yè huáng huā.'
    },
    {
      id: 71,
      title: '折桂令·自述',
      author: '乔吉',
      content: '华阳巾鹤氅蹁跹，铁笛吹云，竹杖撑天。\n伴柳怪花妖，麟祥凤瑞，酒圣诗禅。\n不应举江湖状元，不思凡风月神仙。\n断简残编，翰墨云烟，香满山川。',
      pinyin: 'huá yáng jīn hè chǎng pián xiān, tiě dí chuī yún, zhú zhàng chēng tiān.\n bàn liǔ guài huā yāo, lín xiáng fèng ruì, jiǔ shèng shī chán.\n bú yìng jǔ jiāng hú zhuàng yuán, bù sī fán fēng yuè shén xiān.\n duàn jiǎn cán biān, hàn mò yún yān, xiāng mǎn shān chuān.'
    },
    {
      id: 72,
      title: '清江引·秋居',
      author: '吴西逸',
      content: '白雁乱飞秋似雪，清露生凉夜。\n扫却石边云，醉踏松根月。\n星斗满天人睡也。',
      pinyin: 'bái yàn luàn fēi qiū sì xuě, qīng lù shēng liáng yè.\n sǎo què shí biān yún, zuì tà sōng gēn yuè.\n xīng dǒu mǎn tiān rén shuì yě.'
    },
    {
      id: 73,
      title: '殿前欢·对菊',
      author: '景元启',
      content: '叹西风，老来情绪与谁同？\n黄花不似人憔悴，人比黄花瘦。\n东篱下，渊明友。\n渊明友，渊明友。\n渊明友，渊明友。',
      pinyin: 'tàn xī fēng, lǎo lái qíng xù yǔ shéi tóng?\n huáng huā bú sì rén qiáo cuì, rén bǐ huáng huā shòu.\n dōng lí xià, yuān míng yǒu.\n yuān míng yǒu, yuān míng yǒu.\n yuān míng yǒu, yuān míng yǒu.'
    },
    {
      id: 74,
      title: '梧叶儿·春思',
      author: '吴西逸',
      content: '香凤软，玉帘垂。\n人在画楼西。\n春去也，花谢也。\n问归期，数尽归期未有期。',
      pinyin: 'xiāng fèng ruǎn, yù lián chuí.\n rén zài huà lóu xī.\n chūn qù yě, huā xiè yě.\n wèn guī qī, shù jìn guī qī wèi yǒu qī.'
    },
    {
      id: 75,
      title: '一半儿·春闺',
      author: '查德卿',
      content: '自调花露染霜毫，一段春心难画描。\n斜倚小屏闲坐了。\n红渐消，一半儿相思一半儿恼。',
      pinyin: 'zì tiáo huā lù rǎn shuāng háo, yī duàn chūn xīn nán huà miáo.\n xié yǐ xiǎo píng xián zuò le.\n hóng jiàn xiāo, yī bàn ér xiāng sī yī bàn ér nǎo.'
    },
    {
      id: 76,
      title: '沉醉东风·维扬怀古',
      author: '汤式',
      content: '锦帆落天涯那答，玉箫寒、江上谁家？\n空楼月惨凄，古殿风潇洒。\n古塔对、暮山霞。\n二十四桥，明月夜，玉人何处教吹箫？',
      pinyin: 'jǐn fān luò tiān yá nà dá, yù xiāo hán, jiāng shàng shéi jiā?\n kōng lóu yuè cǎn qī, gǔ diàn fēng xiāo sǎ.\n gǔ tǎ duì, mù shān xiá.\n èr shí sì qiáo, míng yuè yè, yù rén hé chù jiào chuī xiāo?'
    },
    {
      id: 77,
      title: '蟾宫曲·伤春',
      author: '阿鲁威',
      content: '问春为何苦匆匆？带困伴春眠，梦绕芳丛。\n游丝牵惹，飞絮蒙蒙。\n莺啼处，人去也，又西东。\n恨无情，风雨相送。\n春去也，几时还？\n再相逢，惟有梦中。',
      pinyin: 'wèn chūn wèi hé kǔ cōng cōng? dài kùn bàn chūn mián, mèng rào fāng cóng.\n yóu sī qiān rě, fēi xù méng méng.\n yīng tí chù, rén qù yě, yòu xī dōng.\n hèn wú qíng, fēng yǔ xiāng sòng.\n chūn qù yě, jǐ shí hái?\n zài xiāng féng, wéi yǒu mèng zhōng.'
    },
    {
      id: 78,
      title: '天净沙·春',
      author: '严忠济',
      content: '春山暖日和风，阑干楼阁帘栊，杨柳秋千院中。\n啼莺舞燕，小桥流水飞红。',
      pinyin: 'chūn shān nuǎn rì hé fēng, lán gān lóu gé lián lóng, yáng liǔ qiū qiān yuàn zhōng.\n tí yīng wǔ yàn, xiǎo qiáo liú shuǐ fēi hóng.'
    },
    {
      id: 79,
      title: '寿阳曲·咏金莲',
      author: '无名氏',
      content: '金莲印，苔径斜。\n小亭中、有人闲话。\n粉香汗湿罗帕，又重整、秋千架下。',
      pinyin: 'jīn lián yìn, tái jìng xié.\n xiǎo tíng zhōng, yǒu rén xián huà.\n fěn xiāng hàn shī luó pà, yòu chóng zhěng, qiū qiān jià xià.'
    },
    {
      id: 80,
      title: '水仙子·怨风情',
      author: '乔吉',
      content: '眼中花怎得接连枝，眉上锁新教配钥匙。\n描笔儿勾销了伤春事，闷葫芦铰断线儿。\n锦鸳鸯别对了个雄雌。\n野蜂儿难寻觅，蝎虎儿干害死，蚕蛹儿毕罢了相思。',
      pinyin: 'yǎn zhōng huā zěn dé jiē lián zhī, méi shàng suǒ xīn jiào pèi yào chí.\n miáo bǐ ér gōu xiāo le shāng chūn shì, mèn hú lu jiǎo duàn xiàn ér.\n jǐn yuān yāng bié duì le gè xióng cí.\n yě fēng ér nán xún mì, xiē hǔ ér gān hài sǐ, cán yǒng ér bì bà le xiāng sī.'
    },
    {
      id: 81,
      title: '折桂令·赠歌者',
      author: '张可久',
      content: '歌姬小小，琼琼，袅袅。\n掌中飞燕，掌上飞燕。\n掌上飞燕，掌中飞燕。\n掌中飞燕，掌上飞燕。\n掌上飞燕，掌中飞燕。\n掌上飞燕，掌中飞燕。',
      pinyin: 'gē jī xiǎo xiǎo, qióng qióng, niǎo niǎo.\n zhǎng zhōng fēi yàn, zhǎng shàng fēi yàn.\n zhǎng shàng fēi yàn, zhǎng zhōng fēi yàn.\n zhǎng zhōng fēi yàn, zhǎng shàng fēi yàn.\n zhǎng shàng fēi yàn, zhǎng zhōng fēi yàn.\n zhǎng shàng fēi yàn, zhǎng shàng fēi yàn.'
    },
    {
      id: 82,
      title: '清江引·惜别',
      author: '刘致',
      content: '玉人泣别声渐杳，无语伤怀抱。\n寂寞下帘栊，月明今夜。\n相思何日了？\n断肠人在天涯。',
      pinyin: 'yù rén qì bié shēng jiàn yǎo, wú yǔ shāng huái bào.\n jì mò xià lián lóng, yuè míng jīn yè.\n xiāng sī hé rì liǎo?\n duàn cháng rén zài tiān yá.'
    },
    {
      id: 83,
      title: '殿前欢·省悟',
      author: '李伯瞻',
      content: '驾扁舟，云帆百尺洞庭秋。\n黄柑万颗霜初透，绿蚁香浮。\n闲来饮数瓯，醉卧黄鹤楼。\n长笛一声休，明月满船头。\n从今休说，万户封侯。',
      pinyin: 'jià piān zhōu, yún fān bǎi chǐ dòng tíng qiū.\n huáng gān wàn kē shuāng chū tòu, lǜ yǐ xiāng fú.\n xián lái yǐn shù ōu, zuì wò huáng hè lóu.\n cháng dí yī shēng xiū, míng yuè mǎn chuán tóu.\n cóng jīn xiū shuō, wàn hù fēng hóu.'
    },
    {
      id: 84,
      title: '蟾宫曲·春怨',
      author: '李致远',
      content: '迟迟月影上帘钩，淡淡春山画不成。\n半窗幽梦微茫，歌罢钱塘，赋罢高唐。\n风入罗帏，爽入疏棂，月照纱窗。\n缥缈见梨花淡妆，依稀闻兰麝余香。\n唤我良人，试问清狂，怎不思量？',
      pinyin: 'chí chí yuè yǐng shàng lián gōu, dàn dàn chūn shān huà bu chéng.\n bàn chuāng yōu mèng wēi máng, gē bà qián táng, fù bà gāo táng.\n fēng rù luó wéi, shuǎng rù shū líng, yuè zhào shā chuāng.\n piāo miǎo jiàn lí huā dàn zhuāng, yī xī wén lán shè yú xiāng.\n huàn wǒ liáng rén, shì wèn qīng kuáng, zěn bú sī liang?'
    },
    {
      id: 85,
      title: '天净沙·秋',
      author: '朱庭玉',
      content: '庭前落尽梧桐，水边开彻芙蓉。\n解与诗人意同。\n辞柯霜叶，飞来就我题红。',
      pinyin: 'tíng qián luò jìn wú tóng, shuǐ biān kāi chè fú róng.\n jiě yǔ shī rén yì tóng.\n cí kē shuāng yè, fēi lái jiù wǒ tí hóng.'
    },
    {
      id: 86,
      title: '沉醉东风·归田',
      author: '汪元亨',
      content: '远城市人稠物穰，近村居水色山光。\n熏陶成野叟情，铲削去时官样。\n演习会牧歌樵唱。\n豆角儿香，麦索儿长。\n响嘶嘶茧蝶儿轻狂。',
      pinyin: 'yuǎn chéng shì rén chóu wù ráng, jìn cūn jū shuǐ sè shān guāng.\n xūn táo chéng yě sǒu qíng, chǎn xuē qù shí guān yàng.\n yǎn xí huì mù gē qiáo chàng.\n dòu jiǎo ér xiāng, mài suǒ ér cháng.\n xiǎng sī sī jiǎn dié ér qīng kuáng.'
    },
    {
      id: 87,
      title: '折桂令·读史有感',
      author: '赵显宏',
      content: '浪淘淘英雄辈出，古今来事业难成。\n汉室三分，晋朝五马，战国七雄。\n秦关百二，汉苑千宫。\n楚帐中，虞姬血；汉陵里，王莽风。\n都做了土中萤，草上萤。',
      pinyin: 'làng táo táo yīng xióng bèi chū, gǔ jīn lái shì yè nán chéng.\n hàn shì sān fēn, jìn cháo wǔ mǎ, zhàn guó qī xióng.\n qín guān bǎi èr, hàn yuàn qiān gōng.\n chǔ zhàng zhōng, yú jī xuè; hàn líng lǐ, wáng mǎng fēng.\n dōu zuò le tǔ zhōng yíng, cǎo shàng yíng.'
    },
    {
      id: 88,
      title: '清江引·春思',
      author: '杨朝英',
      content: '杏花开了无人看，细雨青烟暗。\n东风吹梦还，往事千般。\n人去也，春将晚。\n花落了，莺声懒。',
      pinyin: 'xìng huā kāi le wú rén kàn, xì yǔ qīng yān àn.\n dōng fēng chuī mèng hái, wǎng shì qiān bān.\n rén qù yě, chūn jiāng wǎn.\n huā luò le, yīng shēng lǎn.'
    },
    {
      id: 89,
      title: '殿前欢·梅花',
      author: '景元启',
      content: '月如钩，冷香飞上小红楼。\n相思有寄无由寄，心似灰秋。\n人何处？水云收。\n人何处？水云收。\n人何处？水云收。\n人何处？水云收。',
      pinyin: 'yuè rú gōu, lěng xiāng fēi shàng xiǎo hóng lóu.\n xiāng sī yǒu jì wú yóu jì, xīn sì huī qiū.\n rén hé chù? shuǐ yún shōu.\n rén hé chù? shuǐ yún shōu.\n rén hé chù? shuǐ yún shōu.\n rén hé chù? shuǐ yún shōu.'
    },
    {
      id: 90,
      title: '梧叶儿·即景',
      author: '钟嗣成',
      content: '鸳鸯浦，鹦鹉洲。\n竹叶小渔舟。\n烟中树，山外楼。\n水边鸥，扇面儿潇湘暮秋。',
      pinyin: 'yuān yāng pǔ, yīng wǔ zhōu.\n zhú yè xiǎo yú zhōu.\n yān zhōng shù, shān wài lóu.\n shuǐ biān ōu, shàn miàn ér xiāo xiāng mù qiū.'
    },
    {
      id: 91,
      title: '一半儿·病酒',
      author: '徐再思',
      content: '昨宵中酒懒扶头，今日看花惟袖手。\n害酒愁花人问羞。\n病根由，一半儿因花一半儿酒。',
      pinyin: 'zuó xiāo zhōng jiǔ lǎn fú tóu, jīn rì kàn huā wéi xiù shǒu.\n hài jiǔ chóu huā rén wèn xiū.\n bìng gēn yóu, yī bàn ér yīn huā yī bàn ér jiǔ.'
    },
    {
      id: 92,
      title: '沉醉东风·送别',
      author: '赵禹圭',
      content: '残花酝酿蜂儿蜜，细雨调和燕子泥。\n绿窗春睡觉来迟。\n谁唤起？窗外晓莺啼。',
      pinyin: 'cán huā yùn niàng fēng ér mì, xì yǔ tiáo hé yàn zi ní.\n lǜ chuāng chūn shuì jué lái chí.\n shéi huàn qǐ? chuāng wài xiǎo yīng tí.'
    },
    {
      id: 93,
      title: '蟾宫曲·怀古',
      author: '杨果',
      content: '故人别我出阳关，无计锁雕鞍。\n今古别离，最难消遣。\n晚风前，柳丝斜倚。\n阑干倚遍，盼不到玉人还。\n把酒问春，春无语。\n黄昏庭院，泪湿青衫。',
      pinyin: 'gù rén bié wǒ chū yáng guān, wú jì suǒ diāo ān.\n jīn gǔ bié lí, zuì nán xiāo qiǎn.\n wǎn fēng qián, liǔ sī xié yǐ.\n lán gān yǐ biàn, pàn bu dào yù rén hái.\n bǎ jiǔ wèn chūn, chūn wú yǔ.\n huáng hūn tíng yuàn, lèi shī qīng shān.'
    },
    {
      id: 94,
      title: '天净沙·夏',
      author: '孟昉',
      content: '参差竹笋抽芽，绿杨枝外楼斜。\n帘卷东风燕子家。\n昼长人困，池塘蝴蝶飞花。',
      pinyin: 'cēn cī zhú sǔn chōu yá, lǜ yáng zhī wài lóu xié.\n lián juǎn dōng fēng yàn zi jiā.\n zhòu cháng rén kùn, chí táng hú dié fēi huā.'
    },
    {
      id: 95,
      title: '寿阳曲·远浦帆归',
      author: '马致远',
      content: '夕阳下，酒旆闲，两三航未曾着岸。\n落花水香茅舍晚，断桥头卖鱼人散。',
      pinyin: 'xī yáng xià, jiǔ pèi xián, liǎng sān háng wèi zēng zhe àn.\n luò huā shuǐ xiāng máo shè wǎn, duàn qiáo tóu mài yú rén sàn.'
    },
    {
      id: 96,
      title: '水仙子·咏雪',
      author: '乔吉',
      content: '冷无香柳絮扑将来，冻成片梨花拂不开。\n大灰泥漫了三千界，银棱了东海。\n探梅的心噤难捱。\n面瓮儿里袁安舍，盐堆儿里党尉宅，粉缸儿里舞榭歌台。',
      pinyin: 'lěng wú xiāng liǔ xù pū jiāng lái, dòng chéng piàn lí huā fú bu kāi.\n dà huī ní màn le sān qiān jiè, yín léng le dōng hǎi.\n tàn méi de xīn jìn nán ái.\n miàn wèng ér lǐ yuán ān shè, yán duī ér lǐ dǎng wèi zhái, fěn gāng ér lǐ wǔ xiè gē tái.'
    },
    {
      id: 97,
      title: '折桂令·荆溪即事',
      author: '乔吉',
      content: '问荆溪溪上人家：为甚人家，不种梅花？\n老树支门，荒蒲绕岸，苦竹圈笆。\n寺无僧狐狸样瓦，官无事乌鼠当衙。\n白水黄沙，倚遍阑干，数尽啼鸦。',
      pinyin: 'wèn jīng xī xī shàng rén jiā: wèi shèn rén jiā, bú zhǒng méi huā?\n lǎo shù zhī mén, huāng pú rào àn, kǔ zhú quān bā.\n sì wú sēng hú li yàng wǎ, guān wú shì wū shǔ dāng yá.\n bái shuǐ huáng shā, yǐ biàn lán gān, shù jìn tí yā.'
    },
    {
      id: 98,
      title: '清江引·立春',
      author: '贯云石',
      content: '金钗影摇春燕斜，木杪生春叶。\n水塘春始波，火候春初热。\n土牛儿载将春到也。',
      pinyin: 'jīn chāi yǐng yáo chūn yàn xié, mù miǎo shēng chūn yè.\n shuǐ táng chūn shǐ bō, huǒ hòu chūn chū rè.\n tǔ niú ér zài jiāng chūn dào yě.'
    },
    {
      id: 99,
      title: '殿前欢·对菊',
      author: '景元启',
      content: '叹西风，老来情绪与谁同？\n黄花不似人憔悴，人比黄花瘦。\n东篱下，渊明友。\n渊明友，渊明友。\n渊明友，渊明友。',
      pinyin: 'tàn xī fēng, lǎo lái qíng xù yǔ shéi tóng?\n huáng huā bú sì rén qiáo cuì, rén bǐ huáng huā shòu.\n dōng lí xià, yuān míng yǒu.\n yuān míng yǒu, yuān míng yǒu.\n yuān míng yǒu, yuān míng yǒu.'
    },
    {
      id: 100,
      title: '梧叶儿·嘲谎人',
      author: '无名氏',
      content: '东村里鸡生凤，南庄上马变牛。\n六月里裹皮裘。\n瓦垄上宜栽树，阳沟里好驾舟。\n瓮来大肉馒头。\n俺家的茄子大如斗。',
      pinyin: 'dōng cūn lǐ jī shēng fèng, nán zhuāng shàng mǎ biàn niú.\n liù yuè lǐ guǒ pí qiú.\n wǎ lǒng shàng yí zāi shù, yáng gōu lǐ hǎo jià zhōu.\n wèng lái dà ròu mán tóu.\n ǎn jiā de qié zi dà rú dǒu.'
    }
  ];
  @State isPressed: boolean = false;
  @State isPageLoaded: boolean = false;
  @State readState: ReadStateCode = ReadStateCode.WAITING;
  @State isPlaying: boolean = false;
  private isInit: boolean = false; // TextReader是否已初始化
  
  // 搜索相关状态
  @State searchKeyword: string = '';
  @State isSearchMode: boolean = false;
  @State filteredYuanquList: Array<Yuanqu> = [];

  aboutToAppear(): void {
    // 初始化搜索相关数据
    this.filteredYuanquList = [];
    
    // 重置状态
    this.isPlaying = false;
    this.isInit = false;
    
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);

    try {
      // 初始化TextReader
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: {
          panelName: '小艺朗读',
          panelIcon: $r('app.media.startIcon')
        },
        keepBackgroundRunning: true
      };

      TextReader.init(getContext(this) as common.UIAbilityContext, readerParam).then(() => {
        console.log('TextReader初始化成功');
        this.isInit = true;
      }).catch((error: BusinessError) => {
        console.error('TextReader初始化失败:', error);
        this.isInit = false;
      });

      // 监听朗读状态变化
      TextReader.on('stateChange', (state: TextReader.ReadState) => {
        console.log('朗读状态变化:', state, 'state.state:', state.state);
        console.log('当前readState:', this.readState, '新状态:', state.state);
        
        this.readState = state.state;
        
        // 更新播放状态
        switch (state.state) {
          case ReadStateCode.PLAYING:
            console.log('设置为播放状态');
            this.isPlaying = true;
            break;
          case ReadStateCode.PAUSED:
          case ReadStateCode.WAITING:
          case ReadStateCode.COMPLETED:
            console.log('设置为非播放状态');
            this.isPlaying = false;
            break;
        }
        
        // 强制UI更新
        setTimeout(() => {
          console.log('强制UI更新 - readState:', this.readState, 'isPlaying:', this.isPlaying);
        }, 100);
      });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('初始化TextReader时发生错误:', e);
    }
  }

  // 初始化TextReader（用于重新初始化）
  private async initTextReader(): Promise<void> {
    try {
      const businessBrandInfo: TextReader.BusinessBrandInfo = {
        panelName: '小艺朗读',
        panelIcon: $r('app.media.startIcon')
      } as TextReader.BusinessBrandInfo;

      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: true
      } as TextReader.ReaderParam;

      // 初始化TextReader
      await TextReader.init(getContext(this) as common.UIAbilityContext, readerParam);
      this.isInit = true;
      console.log('TextReader重新初始化成功');
    } catch (error) {
      console.error('TextReader重新初始化失败:', error);
      this.isInit = false;
    }
  }

  // 页面即将消失时
  aboutToDisappear(): void {
    try {
      // 无论是否正在播放，都尝试停止TextReader
      TextReader.stop();

      // 释放TextReader资源
      TextReader.release().then(() => {
        console.log('TextReader资源释放成功');
      }).catch((error: BusinessError) => {
        console.error('TextReader资源释放失败:', error);
      });
      // 重置状态
      this.isPlaying = false;
      this.isInit = false;
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('释放TextReader资源时发生错误:', e);
    }
  }


  // 切换播放状态
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
        console.log('当前正在播放，执行暂停');
        TextReader.pause();
        // 立即更新状态，提供即时反馈
        this.isPlaying = false;
        this.readState = ReadStateCode.PAUSED;
      } else {
        console.log('当前未播放，开始播放');
        // 立即更新状态，提供即时反馈
        this.isPlaying = true;
        this.readState = ReadStateCode.PLAYING;
        
        // 如果没有在朗读，开始朗读所有元曲标题
        const currentList = this.isSearchMode ? this.filteredYuanquList : this.yuanquList;
        
        const readInfoList: TextReader.ReadInfo[] = currentList.map((yuanqu) => {
          const readInfo: TextReader.ReadInfo = {
            id: `yuanqu_list_${yuanqu.id}`,
            title: {
              text: yuanqu.title,
              isClickable: false
            },
            bodyInfo: `${yuanqu.title}，作者：${yuanqu.author}。${yuanqu.content}`
          };

          return readInfo;
        });

        // 启动TextReader并进入朗读页面
        TextReader.start(readInfoList, readInfoList[0].id).then(() => {
          console.log('开始朗读元曲列表');
          TextReader.showPanel();
        }).catch((error: Error) => {
          console.error('朗读失败:', error);
          // 如果失败，重置状态
          this.isPlaying = false;
          this.readState = ReadStateCode.WAITING;
          promptAction.showToast({ message: '朗读失败: ' + error.message });
        });
      }
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('切换朗读状态时发生错误:', e);
      promptAction.showToast({ message: '朗读功能异常: ' + e.message });
    }
  }

  // 搜索功能
  private onSearchChange(keyword: string): void {
    this.searchKeyword = keyword;
    if (keyword.trim() === '') {
      this.isSearchMode = false;
      this.filteredYuanquList = [];
    } else {
      this.isSearchMode = true;
      this.performSearch(keyword);
    }
  }

  // 执行搜索
  private performSearch(keyword: string): void {
    const searchTerm = keyword.toLowerCase().trim();
    this.filteredYuanquList = this.yuanquList.filter(yuanqu => {
      return yuanqu.title.toLowerCase().includes(searchTerm) ||
             yuanqu.author.toLowerCase().includes(searchTerm) ||
             yuanqu.content.toLowerCase().includes(searchTerm);
    });
  }

  // 清空搜索
  private clearSearch(): void {
    this.searchKeyword = '';
    this.isSearchMode = false;
    this.filteredYuanquList = [];
  }

  // 开始朗读
  private startPlay(): void {
    try {
      // 创建朗读内容
      const readInfo: TextReader.ReadInfo = {
        id: 'yuanqu_list_page',
        title: {
          text: '元曲赏析',
          isClickable: false
        },
        bodyInfo: '元曲赏析列表页面，包含多首经典元曲作品。'
      };

      // 开始朗读
      TextReader.start([readInfo]).then(() => {
        console.log('开始朗读');
      }).catch((error: BusinessError) => {
        console.error('朗读失败:', error);
        promptAction.showToast({ message: '朗读失败: ' + error.message });
      });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('开始朗读时发生错误:', e);
      promptAction.showToast({ message: '开始朗读时发生错误' });
    }
  }

  // 获取随机颜色
  private getRandomColor(): ResourceColor {
    const colors: Array<ResourceColor> = [
      Color.Red,
      Color.Blue,
      Color.Orange,
      Color.Green
    ];
    const randomIndex: number = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
  }

  // 获取背景颜色
  private getBackgroundColor(id: number): string {
    // 创建颜色映射对象
    const colorMap: Map<string, string> = new Map([
      ["1", '#FFEBEE'],
      ["2", '#F3E5F5'],
      ["3", '#E8F5E8'],
      ["4", '#E3F2FD'],
      ["5", '#F1F8E9'],
      ["6", '#FFF3E0'],
      ["7", '#E0F7FA'],
      ["8", '#F9FBE7'],
      ["9", '#EFEBE9'],
      ["10", '#E8F5E9'],
      ["11", '#FFF8E1'],
      ["12", '#E0E0E0'],
      ["13", '#FCE4EC'],
      ["14", '#E0F2F1'],
      ["15", '#E3F2FD'],
      ["16", '#F1F8E9'],
      ["17", '#F3E5F5'],
      ["18", '#E0F2F1'],
      ["19", '#FFECB3'],
      ["20", '#FFCCBC']
    ]);

    // 创建深色模式颜色映射对象
    const darkColorMap: Map<string, string> = new Map([
      ["1", '#4A148C'],
      ["2", '#3E2723'],
      ["3", '#0D47A1'],
      ["4", '#1B5E20'],
      ["5", '#004D40'],
      ["6", '#F57F17'],
      ["7", '#BF360C'],
      ["8", '#1A237E'],
      ["9", '#4A148C'],
      ["10", '#880E4F'],
      ["11", '#006064'],
      ["12", '#424242'],
      ["13", '#880E4F'],
      ["14", '#004D40'],
      ["15", '#0D47A1'],
      ["16", '#1B5E20'],
      ["17", '#4A148C'],
      ["18", '#004D40'],
      ["19", '#FF6F00'],
      ["20", '#BF360C']
    ]);

    // 判断当前是否为深色模式
    const context = getContext(this) as common.UIAbilityContext;
    const currentColorMode: ConfigurationConstant.ColorMode | undefined = context.config.colorMode;

    if (currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
      // 深色模式下返回深色
      return darkColorMap.get((id % 20 + 1).toString()) || '#1E1E1E';
    } else {
      // 浅色模式下返回浅色
      return colorMap.get((id % 20 + 1).toString()) || '#FFFFFF';
    }
  }

  build() {
    Column() {
      Row() {
        Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ left: 10 })
          .type(ButtonType.Normal)
          .borderRadius(20)
          .width(80)
          .height(40)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .animation({ duration: 300 })
          .shadow({
            radius: 5,
            color: $r('app.color.text_tertiary_bank_card_03'),
            offsetX: 0,
            offsetY: 2
          })

        Text('元曲赏析')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))
        
        // 添加右边距平衡布局
        Blank()
          .width(90) // 与返回按钮宽度+左边距平衡
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      Text('点击任意一首元曲查看详细内容和趣味解析')
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({ bottom: 10 })

      // 搜索框
      Row() {
        // 搜索图标
        Text('🔍')
          .fontSize(20)
          .fontColor($r('app.color.text_secondary'))
          .margin({ left: 15, right: 8 })

        // 搜索输入框
        TextInput({ placeholder: '搜索元曲标题、作者或内容...' })
          .layoutWeight(1)
          .height(45)
          .backgroundColor(Color.Transparent)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .placeholderColor($r('app.color.text_secondary'))
          .border({ width: 0 })
          .onChange((value: string) => {
            this.onSearchChange(value);
          })

        // 清空按钮
        if (this.searchKeyword.length > 0) {
          Button() {
            Text('✕')
              .fontSize(18)
              .fontColor($r('app.color.text_secondary'))
          }
          .width(35)
          .height(35)
          .backgroundColor(Color.Transparent)
          .border({ width: 0 })
          .margin({ right: 5 })
          .onClick(() => {
            this.clearSearch();
          })
        }
      }
      .width('90%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .borderRadius(25)
      .margin({ left: 20, right: 20, bottom: 15 })
      .shadow({
        radius: 8,
        color: $r('app.color.text_tertiary_bank_card_03'),
        offsetX: 0,
        offsetY: 2
      })

      // 元曲列表
      Grid() {
        ForEach(this.isSearchMode ? this.filteredYuanquList : this.yuanquList, (yuanqu: Yuanqu, index: number) => {
          GridItem() {
            Column() {
              Text(yuanqu.title)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
                .fontColor($r('app.color.text_primary'))

              Text(yuanqu.author)
                .fontSize(12)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Center)
                .margin({ top: 5 })
            }
            .width('100%')
            .height(80)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.getBackgroundColor(yuanqu.id))
            .borderRadius(15)
            .shadow({
              radius: 18,
              color: $r('app.color.text_tertiary_bank_card_03'),
              offsetX: 0,
              offsetY: 10
            })
            .onClick(() => {
              // 如果正在播放，先暂停播放
              this.isPlaying = false;
              TextReader.stop();
              // 跳转到元曲详情页面
              router.pushUrl({
                url: 'pages/chinese/YuanquDetailPage',
                params: {
                  yuanqu: JSON.stringify(yuanqu)
                }
              });
            })
            // 添加进入动画效果
            .scale({
              x: this.isPageLoaded ? 1 : 0.8,
              y: this.isPageLoaded ? 1 : 0.8
            })
            .transform({
              translate: { y: this.isPageLoaded ? 0 : 15 }
            })
            .opacity(this.isPageLoaded ? 1 : 0)
            .animation({
              duration: 400,
              curve: Curve.EaseInOut, // 使用有效的动画曲线
              delay: index * 30 // 每个项依次延迟动画，营造波浪效果
            })
          }
        }, (yuanqu: Yuanqu) => yuanqu.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(15)
      .columnsGap(15)
      .layoutWeight(1)
      .padding({
        top: 10,
        left: 20,
        right: 20,
        bottom: 20
      })
      .edgeEffect(EdgeEffect.Spring)

      // 搜索结果为空时的提示
      if (this.isSearchMode && this.filteredYuanquList.length === 0) {
        Column() {
          Text('🔍')
            .fontSize(80)
            .fontColor($r('app.color.text_tertiary'))
            .margin({ bottom: 20 })

          Text('未找到匹配的元曲')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor($r('app.color.text_secondary'))
            .margin({ bottom: 10 })

          Text('尝试使用不同的关键词搜索')
            .fontSize(14)
            .fontColor($r('app.color.text_tertiary'))
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(300)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }

      // 统计信息
      Text(this.isSearchMode ? 
        `找到 ${this.filteredYuanquList.length} 首匹配的元曲` : 
        `共收录 ${this.yuanquList.length} 首元曲`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_secondary'))
        .textAlign(TextAlign.Center)
        .margin({ top: 10, bottom: 20 })
        .backgroundColor($r('app.color.card_background'))
        .padding({ left: 20, right: 10, top: 8, bottom: 8 })
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: $r('app.color.text_tertiary_bank_card_03'),
          offsetX: 0,
          offsetY: 2
        })

      // 绝对定位的播放按钮
      Column() {
        if (this.isPlaying) {
          // 播放状态 - 显示暂停图标
          Text('⏸')
            .fontSize(20)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        } else {
          // 非播放状态 - 显示播放图标
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(45)
      .height(45)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: '100%', y: 5 }) // 绝对定位：x轴100%（最右边），y轴5px（顶部）
      .markAnchor({ x: 65, y: 0 }) // 锚点：以按钮右边为基准，向左偏移65px
      .backgroundColor(this.isPlaying ? '#FF6B6B' : '#4ECDC4')
      .borderRadius(22.5)
      .shadow({
        radius: 8,
        color: this.isPlaying ? '#FF6B6B40' : '#4ECDC440',
        offsetX: 0,
        offsetY: 3
      })
      .animation({
        duration: 200,
        curve: Curve.EaseInOut
      })
      .onClick(() => {
        this.togglePlay();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.chinese_bg_02'))
    .backgroundImageSize(ImageSize.Cover)
  }
}