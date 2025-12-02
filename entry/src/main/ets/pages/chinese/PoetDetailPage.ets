import router from '@ohos.router';

// 定义诗人详情接口
interface PoetDetail {
  id: number;
  name: string;
  dynasty: string;
  description: string;
  imageResource: string; // 图片资源名称
  bio: string; // 详细生平
  works: WorkDetail[];
  achievements: string[]; // 主要成就
  famousLines: string[]; // 名句
}

interface WorkDetail {
  title: string;
  content: string;
  theme: string; // 主题
  creationTime: string; // 创作时间
}

// 定义路由参数接口
interface RouterParams {
  poetId: number;
}

@Entry
@Component
export struct PoetDetailPage {
  // 诗人详情数据
  @State private poet: PoetDetail = {
    id: 1,
    name: '李白',
    dynasty: '唐朝',
    description: '李白（701年－762年），字太白，号青莲居士，唐朝浪漫主义诗人，被后人誉为"诗仙"。',
    imageResource: 'libai',
    bio: '李白出生于西域碎叶城（今吉尔吉斯斯坦境内），幼时随父迁居四川江油。他自幼聪颖，博览群书，十五岁时已有诗名。青年时期游历各地，创作了大量诗歌。天宝初年，因道士吴筠推荐，被唐玄宗召至长安，供奉翰林。但因性格傲岸，不为权贵所容，仅一年多即离开长安，继续漫游生活。安史之乱后，李白曾参与永王李璘的政治活动，失败后被流放夜郎，途中遇赦。晚年漂泊于东南一带，最终病逝于安徽当涂。\n\n李白的诗歌以豪放飘逸著称，善于运用丰富的想象和夸张手法，语言清新自然，音韵和谐。他的作品题材广泛，既有描绘祖国壮丽山河的山水诗，也有反映社会现实和民间疾苦的作品，还有抒发个人情怀和理想抱负的抒情诗。代表作有《蜀道难》、《将进酒》、《静夜思》等。',
    works: [
      { 
        title: '将进酒', 
        content: '君不见黄河之水天上来，奔流到海不复回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。\n人生得意须尽欢，莫使金樽空对月。\n天生我材必有用，千金散尽还复来。\n烹羊宰牛且为乐，会须一饮三百杯。\n岑夫子，丹丘生，将进酒，杯莫停。\n与君歌一曲，请君为我倾耳听。\n钟鼓馔玉不足贵，但愿长醉不复醒。\n古来圣贤皆寂寞，惟有饮者留其名。\n陈王昔时宴平乐，斗酒十千恣欢谑。\n主人何为言少钱，径须沽取对君酌。\n五花马，千金裘，呼儿将出换美酒，\n与尔同销万古愁。', 
        theme: '抒情诗', 
        creationTime: '天宝十一年（752年）' 
      },
      { 
        title: '静夜思', 
        content: '床前明月光，疑是地上霜。\n举头望明月，低头思故乡。', 
        theme: '思乡诗', 
        creationTime: '唐玄宗开元年间' 
      },
      { 
        title: '蜀道难', 
        content: '噫吁嚱，危乎高哉！蜀道之难，难于上青天！\n蚕丛及鱼凫，开国何茫然！\n尔来四万八千岁，不与秦塞通人烟。\n西当太白有鸟道，可以横绝峨眉巅。\n地崩山摧壮士死，然后天梯石栈相钩连。\n上有六龙回日之高标，下有冲波逆折之回川。\n黄鹤之飞尚不得过，猿猱欲度愁攀援。\n青泥何盘盘，百步九折萦岩峦。\n扪参历井仰胁息，以手抚膺坐长叹。\n问君西游何时还？畏途巉岩不可攀。\n但见悲鸟号古木，雄飞雌从绕林间。\n又闻子规啼夜月，愁空山。\n蜀道之难，难于上青天，使人听此凋朱颜！\n连峰去天不盈尺，枯松倒挂倚绝壁。\n飞湍瀑流争喧豗，砯崖转石万壑雷。\n其险也如此，嗟尔远道之人胡为乎来哉！\n剑阁峥嵘而崔嵬，一夫当关，万夫莫开。\n所守或匪亲，化为狼与豺。\n朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。\n锦城虽云乐，不如早还家。\n蜀道之难，难于上青天，侧身西望长咨嗟！', 
        theme: '山水诗', 
        creationTime: '天宝初年' 
      }
    ],
    achievements: [
      '被誉为"诗仙"，是中国古代浪漫主义诗歌的代表人物',
      '创造了大量脍炙人口的诗歌作品，对后世影响深远',
      '诗歌风格豪放飘逸，想象丰富，语言清新自然',
      '在山水诗、边塞诗、抒情诗等多个领域都有杰出成就'
    ],
    famousLines: [
      '天生我材必有用，千金散尽还复来',
      '长风破浪会有时，直挂云帆济沧海',
      '抽刀断水水更流，举杯消愁愁更愁',
      '桃花潭水深千尺，不及汪伦送我情'
    ]
  };

  // 所有诗人数据
  private poets: PoetDetail[] = [
    {
      id: 1,
      name: '李白',
      dynasty: '唐朝',
      description: '李白（701年－762年），字太白，号青莲居士，唐朝浪漫主义诗人，被后人誉为"诗仙"。',
      imageResource: 'libai',
      bio: '李白出生于西域碎叶城（今吉尔吉斯斯坦境内），幼时随父迁居四川江油。他自幼聪颖，博览群书，十五岁时已有诗名。青年时期游历各地，创作了大量诗歌。天宝初年，因道士吴筠推荐，被唐玄宗召至长安，供奉翰林。但因性格傲岸，不为权贵所容，仅一年多即离开长安，继续漫游生活。安史之乱后，李白曾参与永王李璘的政治活动，失败后被流放夜郎，途中遇赦。晚年漂泊于东南一带，最终病逝于安徽当涂。\n\n李白的诗歌以豪放飘逸著称，善于运用丰富的想象和夸张手法，语言清新自然，音韵和谐。他的作品题材广泛，既有描绘祖国壮丽山河的山水诗，也有反映社会现实和民间疾苦的作品，还有抒发个人情怀和理想抱负的抒情诗。代表作有《蜀道难》、《将进酒》、《静夜思》等。',
      works: [
        { 
          title: '将进酒', 
          content: '君不见黄河之水天上来，奔流到海不复回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。\n人生得意须尽欢，莫使金樽空对月。\n天生我材必有用，千金散尽还复来。\n烹羊宰牛且为乐，会须一饮三百杯。\n岑夫子，丹丘生，将进酒，杯莫停。\n与君歌一曲，请君为我倾耳听。\n钟鼓馔玉不足贵，但愿长醉不复醒。\n古来圣贤皆寂寞，惟有饮者留其名。\n陈王昔时宴平乐，斗酒十千恣欢谑。\n主人何为言少钱，径须沽取对君酌。\n五花马，千金裘，呼儿将出换美酒，\n与尔同销万古愁。', 
          theme: '抒情诗', 
          creationTime: '天宝十一年（752年）' 
        },
        { 
          title: '静夜思', 
          content: '床前明月光，疑是地上霜。\n举头望明月，低头思故乡。', 
          theme: '思乡诗', 
          creationTime: '唐玄宗开元年间' 
        },
        { 
          title: '蜀道难', 
          content: '噫吁嚱，危乎高哉！蜀道之难，难于上青天！\n蚕丛及鱼凫，开国何茫然！\n尔来四万八千岁，不与秦塞通人烟。\n西当太白有鸟道，可以横绝峨眉巅。\n地崩山摧壮士死，然后天梯石栈相钩连。\n上有六龙回日之高标，下有冲波逆折之回川。\n黄鹤之飞尚不得过，猿猱欲度愁攀援。\n青泥何盘盘，百步九折萦岩峦。\n扪参历井仰胁息，以手抚膺坐长叹。\n问君西游何时还？畏途巉岩不可攀。\n但见悲鸟号古木，雄飞雌从绕林间。\n又闻子规啼夜月，愁空山。\n蜀道之难，难于上青天，使人听此凋朱颜！\n连峰去天不盈尺，枯松倒挂倚绝壁。\n飞湍瀑流争喧豗，砯崖转石万壑雷。\n其险也如此，嗟尔远道之人胡为乎来哉！\n剑阁峥嵘而崔嵬，一夫当关，万夫莫开。\n所守或匪亲，化为狼与豺。\n朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。\n锦城虽云乐，不如早还家。\n蜀道之难，难于上青天，侧身西望长咨嗟！', 
          theme: '山水诗', 
          creationTime: '天宝初年' 
        }
      ],
      achievements: [
        '被誉为"诗仙"，是中国古代浪漫主义诗歌的代表人物',
        '创造了大量脍炙人口的诗歌作品，对后世影响深远',
        '诗歌风格豪放飘逸，想象丰富，语言清新自然',
        '在山水诗、边塞诗、抒情诗等多个领域都有杰出成就'
      ],
      famousLines: [
        '天生我材必有用，千金散尽还复来',
        '长风破浪会有时，直挂云帆济沧海',
        '抽刀断水水更流，举杯消愁愁更愁',
        '桃花潭水深千尺，不及汪伦送我情'
      ]
    },
    {
      id: 2,
      name: '杜甫',
      dynasty: '唐朝',
      description: '杜甫（712年－770年），字子美，自号少陵野老，唐代伟大的现实主义诗人，被世人尊为"诗圣"。',
      imageResource: 'dufu',
      bio: '杜甫出生于河南巩县（今河南巩义市），出身官宦世家，祖父杜审言是武则天时期的著名诗人。杜甫自幼好学，七岁能诗，十五岁时扬名。开元二十三年（735年），杜甫赴洛阳参加进士考试，落第。此后他在齐赵一带漫游，结识了李白，两人建立了深厚的友谊。\n\n天宝六载（747年），杜甫再次赴京应试，因奸臣李林甫从中作梗，再次落第。此后他客居长安十年，过着"举进士不中第，困长安"的生活。安史之乱爆发后，杜甫颠沛流离，历尽艰辛。他曾被叛军俘获，后逃出，投奔肃宗，被授为左拾遗。后因上疏营救房琯触怒肃宗，被贬为华州司功参军。\n\n杜甫的诗歌风格沉郁顿挫，忧国忧民，真实反映了安史之乱前后社会的动荡和人民的苦难，被誉为"诗史"。他的代表作品有《春望》、《茅屋为秋风所破歌》、《登高》等。',
      works: [
        { 
          title: '春望', 
          content: '国破山河在，城春草木深。\n感时花溅泪，恨别鸟惊心。\n烽火连三月，家书抵万金。\n白头搔更短，浑欲不胜簪。', 
          theme: '忧国诗', 
          creationTime: '至德二年（757年）' 
        },
        { 
          title: '茅屋为秋风所破歌', 
          content: '八月秋高风怒号，卷我屋上三重茅。\n茅飞渡江洒江郊，高者挂罥长林梢，下者飘转沉塘坳。\n南村群童欺我老无力，忍能对面为盗贼。\n公然抱茅入竹去，唇焦口燥呼不得，归来倚杖自叹息。\n俄顷风定云墨色，秋天漠漠向昏黑。\n布衾多年冷似铁，娇儿恶卧踏里裂。\n床头屋漏无干处，雨脚如麻未断绝。\n自经丧乱少睡眠，长夜沾湿何由彻！\n安得广厦千万间，大庇天下寒士俱欢颜！\n风雨不动安如山。呜呼！何时眼前突兀见此屋，吾庐独破受冻死亦足！', 
          theme: '抒情诗', 
          creationTime: '上元二年（761年）' 
        }
      ],
      achievements: [
        '被誉为"诗圣"，是中国古代现实主义诗歌的代表人物',
        '作品被誉为"诗史"，真实反映了安史之乱前后的社会现实',
        '诗歌风格沉郁顿挫，忧国忧民，具有强烈的现实主义色彩',
        '在律诗、绝句、古体诗等多种诗体上都有杰出成就'
      ],
      famousLines: [
        '会当凌绝顶，一览众山小',
        '读书破万卷，下笔如有神',
        '朱门酒肉臭，路有冻死骨',
        '烽火连三月，家书抵万金'
      ]
    },
    {
      id: 3,
      name: '李清照',
      dynasty: '宋朝',
      description: '李清照（1084年－约1155年），号易安居士，宋代女词人，婉约词派代表，有"千古第一才女"之称。',
      imageResource: 'liqingzhao',
      bio: '李清照出生于山东济南章丘，父亲李格非是北宋著名学者，母亲王氏也出身名门。她自幼聪慧，博览群书，工于诗词，善于音律。十八岁时嫁给太学生赵明诚，两人志趣相投，共同致力于金石书画的搜集整理。\n\n靖康之变后，李清照与丈夫南渡江宁。建炎三年（1129年），赵明诚病逝，李清照孤身一人，颠沛流离于杭州、越州、金华等地。晚年的李清照境遇凄凉，但她的文学创作却达到了顶峰。\n\n李清照的词作以女性特有的细腻笔触，描写离愁别恨、闺阁情思，语言清新典雅，音韵和谐优美。她的词风以南渡为界，前期多写悠闲生活，后期则充满身世之感。代表作品有《声声慢》、《一剪梅》、《如梦令》等。',
      works: [
        { 
          title: '声声慢', 
          content: '寻寻觅觅，冷冷清清，凄凄惨惨戚戚。\n乍暖还寒时候，最难将息。\n三杯两盏淡酒，怎敌他、晚来风急？\n雁过也，正伤心，却是旧时相识。\n满地黄花堆积。憔悴损，如今有谁堪摘？\n守着窗儿，独自怎生得黑？\n梧桐更兼细雨，到黄昏、点点滴滴。\n这次第，怎一个愁字了得！', 
          theme: '抒情词', 
          creationTime: '南宋初年' 
        },
        { 
          title: '一剪梅', 
          content: '红藕香残玉簟秋。轻解罗裳，独上兰舟。\n云中谁寄锦书来，雁字回时，月满西楼。\n花自飘零水自流。一种相思，两处闲愁。\n此情无计可消除，才下眉头，却上心头。', 
          theme: '闺怨词', 
          creationTime: '北宋末年' 
        }
      ],
      achievements: [
        '被誉为"千古第一才女"，是中国古代最杰出的女词人',
        '创立了独特的"易安体"词风，对后世影响深远',
        '词作语言清新典雅，音韵和谐优美，情感真挚深沉',
        '在婉约词派中独树一帜，成为该流派的代表人物'
      ],
      famousLines: [
        '寻寻觅觅，冷冷清清，凄凄惨惨戚戚',
        '此情无计可消除，才下眉头，却上心头',
        '物是人非事事休，欲语泪先流',
        '生当作人杰，死亦为鬼雄'
      ]
    },
    {
      id: 4,
      name: '苏轼',
      dynasty: '宋朝',
      description: '苏轼（1037年－1101年），字子瞻，号东坡居士，北宋文学家、书法家、画家。',
      imageResource: 'sushi',
      bio: '苏轼出生于四川眉山，父亲苏洵、弟弟苏辙都是著名文学家，合称"三苏"。苏轼自幼聪颖，博览群书，嘉祐二年（1057年）与弟弟苏辙同榜进士，时年二十一岁。\n\n苏轼一生仕途坎坷，因反对王安石变法被贬黄州，后又因"乌台诗案"被贬惠州、儋州。但他始终保持乐观豁达的人生态度，在文学、艺术等方面都取得了卓越成就。\n\n苏轼的诗词题材广阔，风格清新豪健，善用夸张比喻，独具特色。他的散文汪洋恣肆，明白畅达，与欧阳修并称"欧苏"。在书法方面，他与黄庭坚、米芾、蔡襄并称"宋四家"。代表作品有《水调歌头》、《念奴娇·赤壁怀古》、《题西林壁》等。',
      works: [
        { 
          title: '水调歌头', 
          content: '明月几时有？把酒问青天。\n不知天上宫阙，今夕是何年。\n我欲乘风归去，又恐琼楼玉宇，高处不胜寒。\n起舞弄清影，何似在人间。\n转朱阁，低绮户，照无眠。\n不应有恨，何事长向别时圆？\n人有悲欢离合，月有阴晴圆缺，此事古难全。\n但愿人长久，千里共婵娟。', 
          theme: '抒情词', 
          creationTime: '熙宁九年（1076年）' 
        },
        { 
          title: '念奴娇·赤壁怀古', 
          content: '大江东去，浪淘尽，千古风流人物。\n故垒西边，人道是，三国周郎赤壁。\n乱石穿空，惊涛拍岸，卷起千堆雪。\n江山如画，一时多少豪杰。\n遥想公瑾当年，小乔初嫁了，雄姿英发。\n羽扇纶巾，谈笑间，樯橹灰飞烟灭。\n故国神游，多情应笑我，早生华发。\n人生如梦，一尊还酹江月。', 
          theme: '怀古词', 
          creationTime: '元丰五年（1082年）' 
        }
      ],
      achievements: [
        '开创了豪放词派，与辛弃疾并称"苏辛"',
        '诗词、散文、书法、绘画等方面都有卓越成就',
        '与父亲苏洵、弟弟苏辙并称"三苏"，是"唐宋八大家"之一',
        '作品题材广阔，风格清新豪健，善用夸张比喻'
      ],
      famousLines: [
        '但愿人长久，千里共婵娟',
        '人生如梦，一尊还酹江月',
        '不识庐山真面目，只缘身在此山中',
        '竹外桃花三两枝，春江水暖鸭先知'
      ]
    },
    {
      id: 5,
      name: '白居易',
      dynasty: '唐朝',
      description: '白居易（772年－846年），字乐天，号香山居士，唐代伟大的现实主义诗人，新乐府运动的倡导者。',
      imageResource: 'baijuyi',
      bio: '白居易出生于河南新郑，祖籍山西太原。他自幼聪颖，五六岁便学作诗，九岁通晓声韵。贞元十六年（800年），白居易考中进士，历任翰林学士、左拾遗等职。元和十年（815年），因直言进谏触怒权贵，被贬为江州司马。后历任杭州、苏州刺史，晚年官至刑部尚书。\n\n白居易是新乐府运动的倡导者，主张"文章合为时而著，歌诗合为事而作"。他的诗歌通俗易懂，深受人民喜爱，有"老妪能解"之誉。他的诗作题材广泛，内容丰富，既有反映社会现实的讽喻诗，也有描写自然景物的闲适诗，还有叙事性很强的长篇叙事诗。代表作品有《长恨歌》、《琵琶行》、《赋得古原草送别》等。',
      works: [
        { 
          title: '赋得古原草送别', 
          content: '离离原上草，一岁一枯荣。\n野火烧不尽，春风吹又生。\n远芳侵古道，晴翠接荒城。\n又送王孙去，萋萋满别情。', 
          theme: '送别诗', 
          creationTime: '贞元三年（787年）' 
        },
        { 
          title: '钱塘湖春行', 
          content: '孤山寺北贾亭西，水面初平云脚低。\n几处早莺争暖树，谁家新燕啄春泥。\n乱花渐欲迷人眼，浅草才能没马蹄。\n最爱湖东行不足，绿杨阴里白沙堤。', 
          theme: '山水诗', 
          creationTime: '长庆二年（822年）' 
        }
      ],
      achievements: [
        '新乐府运动的倡导者，主张"文章合为时而著，歌诗合为事而作"',
        '诗歌通俗易懂，有"老妪能解"之誉，深受人民喜爱',
        '创作了大量反映社会现实的讽喻诗，具有强烈的现实主义色彩',
        '长篇叙事诗《长恨歌》、《琵琶行》是中国古代叙事诗的巅峰之作'
      ],
      famousLines: [
        '野火烧不尽，春风吹又生',
        '同是天涯沦落人，相逢何必曾相识',
        '在天愿作比翼鸟，在地愿为连理枝',
        '日出江花红胜火，春来江水绿如蓝'
      ]
    },
    {
      id: 6,
      name: '王维',
      dynasty: '唐朝',
      description: '王维（701年－761年），字摩诘，号摩诘居士。唐朝著名诗人、画家，精通佛学，被称为"诗佛"。',
      imageResource: 'wangwei',
      bio: '王维出生于山西运城，出身官宦世家。开元十九年（731年），王维状元及第，历任右拾遗、监察御史、河西节度使判官等职。安史之乱时，被迫接受伪职，后因此被贬。\n\n王维精通佛学，深受禅宗影响，其诗作多描绘山水田园风光，意境深远，富有禅意。他不仅是一位杰出的诗人，还是一位著名的画家，苏轼评价他的作品"诗中有画，画中有诗"。代表作品有《山居秋暝》、《相思》、《鹿柴》等。',
      works: [
        { 
          title: '山居秋暝', 
          content: '空山新雨后，天气晚来秋。\n明月松间照，清泉石上流。\n竹喧归浣女，莲动下渔舟。\n随意春芳歇，王孙自可留。', 
          theme: '山水田园诗', 
          creationTime: '晚年隐居辋川时期' 
        },
        { 
          title: '相思', 
          content: '红豆生南国，春来发几枝。\n愿君多采撷，此物最相思。', 
          theme: '抒情诗', 
          creationTime: '天宝年间' 
        }
      ],
      achievements: [
        '被誉为"诗佛"，是唐代山水田园诗派的代表人物',
        '精通诗、书、画、音乐等，苏轼评价其"诗中有画，画中有诗"',
        '作品意境深远，富有禅意，对后世山水田园诗影响深远',
        '在山水诗、边塞诗、抒情诗等多个领域都有杰出成就'
      ],
      famousLines: [
        '明月松间照，清泉石上流',
        '大漠孤烟直，长河落日圆',
        '劝君更尽一杯酒，西出阳关无故人',
        '独在异乡为异客，每逢佳节倍思亲'
      ]
    },
    {
      id: 7,
      name: '辛弃疾',
      dynasty: '宋朝',
      description: '辛弃疾（1140年－1207年），字幼安，号稼轩，南宋豪放派词人、将领，与苏轼合称"苏辛"。',
      imageResource: 'xinqiji',
      bio: '辛弃疾出生于山东济南，少年时正值金兵占领中原。他曾亲率五十骑深入金营，生擒叛徒张安国，表现出过人的勇武。绍兴三十一年（1161年），辛弃疾南归，历任江西、湖南安抚使等职。\n\n辛弃疾一生以恢复中原为己任，但屡遭排挤，壮志难酬。他将满腔悲愤寄托于词作之中，其词风格豪放，气势磅礴，充满爱国激情。他善于用典，语言生动，想象丰富，对后世影响深远。代表作品有《破阵子·为陈同甫赋壮词以寄之》、《永遇乐·京口北固亭怀古》、《青玉案·元夕》等。',
      works: [
        { 
          title: '破阵子·为陈同甫赋壮词以寄之', 
          content: '醉里挑灯看剑，梦回吹角连营。\n八百里分麾下炙，五十弦翻塞外声。\n沙场秋点兵。\n马作的卢飞快，弓如霹雳弦惊。\n了却君王天下事，赢得生前身后名。\n可怜白发生！', 
          theme: '爱国词', 
          creationTime: '南宋中期' 
        },
        { 
          title: '青玉案·元夕', 
          content: '东风夜放花千树，更吹落，星如雨。\n宝马雕车香满路。\n凤箫声动，玉壶光转，一夜鱼龙舞。\n蛾儿雪柳黄金缕，笑语盈盈暗香去。\n众里寻他千百度，蓦然回首，那人却在，灯火阑珊处。', 
          theme: '节日词', 
          creationTime: '淳熙年间' 
        }
      ],
      achievements: [
        '豪放派词人代表，与苏轼并称"苏辛"',
        '词作充满爱国激情，表达了恢复中原的强烈愿望',
        '善于用典，语言生动，想象丰富，气势磅礴',
        '在词史上独树一帜，对后世影响深远'
      ],
      famousLines: [
        '众里寻他千百度，蓦然回首，那人却在，灯火阑珊处',
        '了却君王天下事，赢得生前身后名',
        '青山遮不住，毕竟东流去',
        '旧时茅店社林边，路转溪桥忽见'
      ]
    },
    {
      id: 8,
      name: '陆游',
      dynasty: '宋朝',
      description: '陆游（1125年－1210年），字务观，号放翁，南宋爱国诗人，是中国古代存诗最多的诗人。',
      imageResource: 'luyou',
      bio: '陆游出生于越州山阴（今浙江绍兴），自幼受到良好的家庭教育。他生逢国难，一生以恢复中原为己任。绍兴二十三年（1153年），陆游参加进士考试，因触犯秦桧而落第。\n\n陆游一生仕途坎坷，但始终保持爱国热情。他的诗作题材广泛，内容丰富，既有反映抗金斗争的爱国诗，也有描写农村生活的田园诗，还有表达个人情感的抒情诗。他一生创作诗歌9000多首，是中国古代存诗最多的诗人。代表作品有《示儿》、《钗头凤》、《游山西村》等。',
      works: [
        { 
          title: '示儿', 
          content: '死去元知万事空，但悲不见九州同。\n王师北定中原日，家祭无忘告乃翁。', 
          theme: '爱国诗', 
          creationTime: '嘉定二年（1209年）' 
        },
        { 
          title: '游山西村', 
          content: '莫笑农家腊酒浑，丰年留客足鸡豚。\n山重水复疑无路，柳暗花明又一村。\n箫鼓追随春社近，衣冠简朴古风存。\n从今若许闲乘月，拄杖无时夜叩门。', 
          theme: '田园诗', 
          creationTime: '乾道二年（1166年）' 
        }
      ],
      achievements: [
        '南宋爱国诗人，一生创作诗歌9000多首，是中国古代存诗最多的诗人',
        '诗作充满爱国激情，表达了恢复中原的强烈愿望',
        '诗风豪放奔放，语言明白流畅，富有生活气息',
        '在爱国诗、田园诗、抒情诗等多个领域都有杰出成就'
      ],
      famousLines: [
        '王师北定中原日，家祭无忘告乃翁',
        '山重水复疑无路，柳暗花明又一村',
        '纸上得来终觉浅，绝知此事要躬行',
        '夜阑卧听风吹雨，铁马冰河入梦来'
      ]
    },
    {
      id: 9,
      name: '王昌龄',
      dynasty: '唐朝',
      description: '王昌龄（698年－756年），字少伯，盛唐著名边塞诗人，被誉为"诗家夫子"、"七绝圣手"。',
      imageResource: 'wangchangling',
      bio: '王昌龄是盛唐时期著名诗人，精通音律，擅长七言绝句。他曾任江宁丞、龙标尉等职，因仕途不顺，多次遭贬。安史之乱时，他在返乡途中被刺史闾丘晓所杀。\n\n王昌龄的诗以边塞诗和宫怨诗最为著名。他的边塞诗豪放壮阔，气势雄浑，充满爱国激情；宫怨诗委婉细腻，情感真挚。他的七言绝句尤为出色，意境深远，语言精炼，被称为"七绝圣手"。代表作品有《出塞》、《芙蓉楼送辛渐》、《闺怨》等。',
      works: [
        { 
          title: '出塞', 
          content: '秦时明月汉时关，万里长征人未还。\n但使龙城飞将在，不教胡马度阴山。', 
          theme: '边塞诗', 
          creationTime: '开元年间' 
        },
        { 
          title: '芙蓉楼送辛渐', 
          content: '寒雨连江夜入吴，平明送客楚山孤。\n洛阳亲友如相问，一片冰心在玉壶。', 
          theme: '送别诗', 
          creationTime: '天宝年间' 
        }
      ],
      achievements: [
        '盛唐著名边塞诗人，被誉为"诗家夫子"、"七绝圣手"',
        '边塞诗豪放壮阔，气势雄浑，充满爱国激情',
        '七言绝句尤为出色，意境深远，语言精炼',
        '在边塞诗和宫怨诗等领域都有杰出成就'
      ],
      famousLines: [
        '秦时明月汉时关，万里长征人未还',
        '一片冰心在玉壶',
        '黄沙百战穿金甲，不破楼兰终不还',
        '洛阳亲友如相问，一片冰心在玉壶'
      ]
    },
    {
      id: 10,
      name: '孟浩然',
      dynasty: '唐朝',
      description: '孟浩然（689年－740年），本名孟浩，字浩然，襄州襄阳人，唐代著名山水田园诗人。',
      imageResource: 'menghaoran',
      bio: '孟浩然出生于襄阳（今湖北襄阳），早年隐居鹿门山，40岁时曾应进士考试，不第后仍归隐乡里。他与王维并称"王孟"，同为盛唐山水田园诗派代表。\n\n孟浩然的诗作清新自然，风格恬淡闲适，多描写山水田园风光和隐逸生活。他的诗语言质朴平易，却韵味深长，意境悠远。他不追求华丽辞藻，而注重自然天成，体现了唐代山水田园诗的典型特色。代表作品有《春晓》、《过故人庄》、《宿建德江》等。',
      works: [
        { 
          title: '春晓', 
          content: '春眠不觉晓，处处闻啼鸟。\n夜来风雨声，花落知多少。', 
          theme: '山水田园诗', 
          creationTime: '开元年间' 
        },
        { 
          title: '过故人庄', 
          content: '故人具鸡黍，邀我至田家。\n绿树村边合，青山郭外斜。\n开轩面场圃，把酒话桑麻。\n待到重阳日，还来就菊花。', 
          theme: '田园诗', 
          creationTime: '开元年间' 
        }
      ],
      achievements: [
        '唐代著名山水田园诗人，与王维并称"王孟"',
        '诗作清新自然，风格恬淡闲适，意境悠远',
        '多描写山水田园风光和隐逸生活，语言质朴平易',
        '是盛唐山水田园诗派的代表人物'
      ],
      famousLines: [
        '春眠不觉晓，处处闻啼鸟',
        '绿树村边合，青山郭外斜',
        '野旷天低树，江清月近人',
        '气蒸云梦泽，波撼岳阳城'
      ]
    },
    {
      id: 11,
      name: '杜牧',
      dynasty: '唐朝',
      description: '杜牧（803年－852年），字牧之，号樊川居士，晚唐杰出诗人、散文家，与李商隐并称"小李杜"。',
      imageResource: 'dumu',
      bio: '杜牧出生于京兆万年（今陕西西安），祖父杜佑是著名宰相。他自幼好学，博通经史，尤精于治乱兴亡之学。大和二年（828年），杜牧进士及第，历任监察御史、黄州刺史、池州刺史、睦州刺史等职。\n\n杜牧的诗作题材广泛，风格清丽俊爽，尤以咏史诗和写景诗著称。他的咏史诗多寄寓个人抱负和政治见解，写景诗则清新秀丽，意境深远。他的七言绝句尤为出色，语言凝练，意蕴深厚。代表作品有《山行》、《清明》、《泊秦淮》等。',
      works: [
        { 
          title: '山行', 
          content: '远上寒山石径斜，白云深处有人家。\n停车坐爱枫林晚，霜叶红于二月花。', 
          theme: '写景诗', 
          creationTime: '会昌年间' 
        },
        { 
          title: '清明', 
          content: '清明时节雨纷纷，路上行人欲断魂。\n借问酒家何处有？牧童遥指杏花村。', 
          theme: '节日诗', 
          creationTime: '会昌年间' 
        }
      ],
      achievements: [
        '晚唐杰出诗人，与李商隐并称"小李杜"',
        '诗作风格清丽俊爽，咏史诗和写景诗尤为著名',
        '七言绝句出色，语言凝练，意蕴深厚',
        '散文成就也很高，《阿房宫赋》是传世名篇'
      ],
      famousLines: [
        '停车坐爱枫林晚，霜叶红于二月花',
        '清明时节雨纷纷，路上行人欲断魂',
        '东风不与周郎便，铜雀春深锁二乔',
        '商女不知亡国恨，隔江犹唱后庭花'
      ]
    },
    {
      id: 12,
      name: '柳宗元',
      dynasty: '唐朝',
      description: '柳宗元（773年－819年），字子厚，世称"柳河东"，唐宋八大家之一，与韩愈并称"韩柳"。',
      imageResource: 'liuzongyuan',
      bio: '柳宗元出生于长安，祖籍河东（今山西运城）。他自幼聪颖，13岁能文。贞元九年（793年），柳宗元进士及第，历任监察御史等职。永贞元年（805年），他参与王叔文集团的政治革新，失败后被贬为永州司马，后又贬为柳州刺史。\n\n柳宗元是唐代古文运动的核心人物之一，与韩愈并称"韩柳"。他的散文说理透彻，语言简练，寓言体散文尤为出色。他的诗作风格清峻，多描写贬谪生活和山水景物，情感真挚，意境深远。代表作品有《江雪》、《渔翁》、《小石潭记》等。',
      works: [
        { 
          title: '江雪', 
          content: '千山鸟飞绝，万径人踪灭。\n孤舟蓑笠翁，独钓寒江雪。', 
          theme: '山水诗', 
          creationTime: '永贞元年（805年）后' 
        },
        { 
          title: '渔翁', 
          content: '渔翁夜傍西岩宿，晓汲清湘燃楚竹。\n烟销日出不见人，欸乃一声山水绿。\n回看天际下中流，岩上无心云相逐。', 
          theme: '山水诗', 
          creationTime: '永州时期' 
        }
      ],
      achievements: [
        '唐宋八大家之一，与韩愈并称"韩柳"',
        '唐代古文运动的核心人物，散文说理透彻，语言简练',
        '寓言体散文出色，《黔之驴》、《永某氏之鼠》是传世名篇',
        '诗作风格清峻，多描写山水景物，意境深远'
      ],
      famousLines: [
        '千山鸟飞绝，万径人踪灭',
        '孤舟蓑笠翁，独钓寒江雪',
        '烟销日出不见人，欸乃一声山水绿',
        '城上高楼接大荒，海天愁思正茫茫'
      ]
    }
  ];

  aboutToAppear(): void {
    // 获取路由参数中的诗人ID
    const routerParams = router.getParams() as RouterParams;
    if (routerParams && routerParams.poetId) {
      const poetId = routerParams.poetId;
      const foundPoet = this.poets.find(poet => poet.id === poetId);
      if (foundPoet) {
        this.poet = foundPoet;
      }
    }
  }

  build() {
    Column() {
      // 顶部标题栏，包含返回按钮
      Row() {
        // 返回按钮
        Button('返回')
          .width(60)
          .height(40)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(8)
          .margin({ left: 10 })
          .onClick(() => {
            router.back();
          })
        
        // 页面标题
        Text('诗人详情')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        // 占位元素，保持标题居中
        Button('')
          .width(60)
          .height(40)
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
      }
      .width('100%')
      .height(60)
      .backgroundColor($r('app.color.card_background'))
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // 诗人基本信息
          Row() {
            // 诗人画像
            Image($r(`app.media.${this.poet.imageResource}`))
              .width(100)
              .height(100)
              .borderRadius(50)
              .margin({ right: 20 })
            
            Column() {
              Text(this.poet.name)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
              
              Text(`${this.poet.dynasty}诗人`)
                .fontSize(16)
                .fontColor($r('app.color.text_secondary'))
                .margin({ top: 5 })
              
              Text(this.poet.description)
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .margin({ top: 5 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 20 })
          
          // 趣味填词按钮
          Button('趣味填词挑战')
            .width('80%')
            .height(50)
            .fontSize(18)
            .backgroundColor($r('app.color.card_background'))
            .fontColor($r('app.color.text_primary'))
            .borderRadius(25)
            .margin({ top: 20, bottom: 20 })
            .onClick(() => {
              // 跳转到该诗人的填词游戏页面
              router.pushUrl({ 
                url: 'pages/chinese/PoetFillQuizPage',
                params: {
                  poetId: this.poet.id
                }
              });
            })
          
          // 诗人详细介绍
          Column() {
            Text('生平简介')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .alignSelf(ItemAlign.Start)
              .margin({ top: 20, bottom: 10 })
            
            Text(this.poet.bio)
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .lineHeight(24)
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          // 主要成就
          Column() {
            Text('主要成就')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .alignSelf(ItemAlign.Start)
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.poet.achievements, (achievement: string, index: number) => {
              Row() {
                Text('•')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
                  .margin({ right: 10 })
                
                Text(achievement)
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
                  .layoutWeight(1)
              }
              .width('100%')
              .margin({ bottom: 5 })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          // 名句欣赏
          Column() {
            Text('名句欣赏')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .alignSelf(ItemAlign.Start)
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.poet.famousLines, (line: string, index: number) => {
              Text(line)
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .lineHeight(24)
                .margin({ bottom: 10 })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          // 代表作品
          Column() {
            Text('代表作品')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .alignSelf(ItemAlign.Start)
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.poet.works, (work: WorkDetail, index: number) => {
              Column() {
                Row() {
                  Text(work.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .alignSelf(ItemAlign.Start)
                    .layoutWeight(1)
                  
                  Column() {
                    Text(`主题：${work.theme}`)
                      .fontSize(12)
                      .fontColor($r('app.color.text_secondary'))
                    
                    Text(`创作时间：${work.creationTime}`)
                      .fontSize(12)
                      .fontColor($r('app.color.text_secondary'))
                  }
                  .alignItems(HorizontalAlign.End)
                }
                .width('100%')
                .margin({ bottom: 10 })
                
                Text(work.content)
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
                  .lineHeight(24)
              }
              .width('100%')
              .padding({ left: 20, right: 20, top: 15, bottom: 15 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(10)
              .margin({ bottom: 10 })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 20 })
        }
        .width('100%')
      }
      .edgeEffect(EdgeEffect.Spring)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}