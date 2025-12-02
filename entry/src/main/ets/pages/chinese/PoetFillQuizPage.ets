import router from '@ohos.router';

// 定义题目接口
interface Question {
  id: number;
  title: string;
  author: string;
  poem: string;
  blanks: Blank[];
  difficulty: number; // 1-3, 1为简单, 3为困难
}

interface Blank {
  index: number;
  options: string[];
  correct: string;
}

// 定义诗人信息接口
interface PoetInfo {
  id: number;
  name: string;
  dynasty: string;
  imageResource: string;
}

// 定义路由参数接口
interface RouterParams {
  poetId: number;
}

@Entry
@Component
export struct PoetFillQuizPage {
  // 当前诗人信息
  @State private poet: PoetInfo = {
    id: 1,
    name: '李白',
    dynasty: '唐朝',
    imageResource: 'libai'
  };

  // 所有诗人数据
  private poets: PoetInfo[] = [
    {
      id: 1,
      name: '李白',
      dynasty: '唐朝',
      imageResource: 'libai'
    },
    {
      id: 2,
      name: '杜甫',
      dynasty: '唐朝',
      imageResource: 'dufu'
    },
    {
      id: 3,
      name: '李清照',
      dynasty: '宋朝',
      imageResource: 'liqingzhao'
    },
    {
      id: 4,
      name: '苏轼',
      dynasty: '宋朝',
      imageResource: 'sushi'
    },
    {
      id: 5,
      name: '王维',
      dynasty: '唐朝',
      imageResource: 'wangwei'
    },
    {
      id: 6,
      name: '白居易',
      dynasty: '唐朝',
      imageResource: 'baijuyi'
    },
    {
      id: 7,
      name: '辛弃疾',
      dynasty: '宋朝',
      imageResource: 'xinqiji'
    },
    {
      id: 8,
      name: '陆游',
      dynasty: '宋朝',
      imageResource: 'luyou'
    },
    {
      id: 9,
      name: '王昌龄',
      dynasty: '唐朝',
      imageResource: 'wangchangling'
    },
    {
      id: 10,
      name: '孟浩然',
      dynasty: '唐朝',
      imageResource: 'menghaoran'
    },
    {
      id: 11,
      name: '杜牧',
      dynasty: '唐朝',
      imageResource: 'dumu'
    },
    {
      id: 12,
      name: '柳宗元',
      dynasty: '唐朝',
      imageResource: 'liuzongyuan'
    }
  ];

  // 诗人对应的题目数据
  private poetQuestions: Map<number, Question[]> = new Map([
    [1, [ // 李白的20首著名诗作填词题
      {
        id: 1,
        title: '静夜思',
        author: '李白',
        poem: '__ __ 明月光，疑是地上霜。\n举头望明月，低头思故乡。',
        blanks: [
          {
            index: 0,
            options: ['床前', '窗前', '门前'],
            correct: '床前'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '早发白帝城',
        author: '李白',
        poem: '朝辞白帝__ __间，千里江陵一日还。\n两岸猿声啼不住，轻舟已过万重山。',
        blanks: [
          {
            index: 0,
            options: ['彩云', '白云', '红云'],
            correct: '彩云'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 3,
        title: '望庐山瀑布',
        author: '李白',
        poem: '日照香炉__ __烟，遥看瀑布挂前川。\n飞流直下三千尺，疑是银河落九天。',
        blanks: [
          {
            index: 0,
            options: ['生紫', '起紫', '冒紫'],
            correct: '生紫'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '赠汪伦',
        author: '李白',
        poem: '李白乘舟将欲行，忽闻岸上__ __声。\n桃花潭水深千尺，不及汪伦送我情。',
        blanks: [
          {
            index: 0,
            options: ['踏歌', '唱歌', '吟诗'],
            correct: '踏歌'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 5,
        title: '黄鹤楼送孟浩然之广陵',
        author: '李白',
        poem: '故人西辞黄鹤楼，烟花三月__ __扬州。\n孤帆远影碧空尽，唯见长江天际流。',
        blanks: [
          {
            index: 0,
            options: ['下', '到', '赴'],
            correct: '下'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '月下独酌',
        author: '李白',
        poem: '花间一壶酒，独酌无__ __。\n举杯邀明月，对影成三人。',
        blanks: [
          {
            index: 0,
            options: ['相亲', '相伴', '相知'],
            correct: '相亲'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '春夜洛城闻笛',
        author: '李白',
        poem: '谁家玉笛暗飞声，散入春风满__ __。\n此夜曲中闻折柳，何人不起故园情。',
        blanks: [
          {
            index: 0,
            options: ['洛城', '长安', '扬州'],
            correct: '洛城'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 8,
        title: '送友人',
        author: '李白',
        poem: '青山横北郭，白水绕东__ __。\n此地一为别，孤蓬万里征。',
        blanks: [
          {
            index: 0,
            options: ['城', '山', '水'],
            correct: '城'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '渡荆门送别',
        author: '李白',
        poem: '渡远荆门外，来从楚国__ __。\n山随平野尽，江入大荒流。',
        blanks: [
          {
            index: 0,
            options: ['游', '行', '旅'],
            correct: '游'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 10,
        title: '宣州谢脁楼饯别校书叔云',
        author: '李白',
        poem: '弃我去者，昨日之日不可__ __。\n乱我心者，今日之日多烦忧。',
        blanks: [
          {
            index: 0,
            options: ['留', '追', '忆'],
            correct: '留'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 11,
        title: '将进酒',
        author: '李白',
        poem: '君不见黄河之水天上来，奔流到海不__ __回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。',
        blanks: [
          {
            index: 0,
            options: ['复', '再', '重'],
            correct: '复'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 12,
        title: '行路难',
        author: '李白',
        poem: '金樽清酒斗十千，玉盘珍羞直万__ __。\n停杯投箸不能食，拔剑四顾心茫然。',
        blanks: [
          {
            index: 0,
            options: ['钱', '金', '两'],
            correct: '钱'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 13,
        title: '蜀道难',
        author: '李白',
        poem: '噫吁嚱，__ __乎高哉！蜀道之难，难于上青天！',
        blanks: [
          {
            index: 0,
            options: ['危', '险', '难'],
            correct: '危'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 14,
        title: '梦游天姥吟留别',
        author: '李白',
        poem: '海客谈瀛洲，烟涛微茫__ __可求。\n越人语天姥，云霞明灭或可睹。',
        blanks: [
          {
            index: 0,
            options: ['信', '真', '实'],
            correct: '信'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 15,
        title: '庐山谣寄卢侍御虚舟',
        author: '李白',
        poem: '我本楚狂人，凤歌笑孔__ __。\n手持绿玉杖，朝别黄鹤楼。',
        blanks: [
          {
            index: 0,
            options: ['丘', '子', '圣'],
            correct: '丘'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 16,
        title: '金陵酒肆留别',
        author: '李白',
        poem: '风吹柳花满店香，吴姬压酒唤客__ __。\n金陵子弟来相送，欲行不行各尽觞。',
        blanks: [
          {
            index: 0,
            options: ['尝', '品', '饮'],
            correct: '尝'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 17,
        title: '子夜秋歌',
        author: '李白',
        poem: '长安一片月，万户__ __衣。\n秋风吹不尽，总是玉关情。',
        blanks: [
          {
            index: 0,
            options: ['捣练', '洗衣', '缝衣'],
            correct: '捣练'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 18,
        title: '关山月',
        author: '李白',
        poem: '明月出天山，苍茫云海__ __。\n长风几万里，吹度玉门关。',
        blanks: [
          {
            index: 0,
            options: ['间', '中', '里'],
            correct: '间'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 19,
        title: '长相思',
        author: '李白',
        poem: '长相思，在长安。络纬秋啼金井__ __，微霜凄凄簟色寒。',
        blanks: [
          {
            index: 0,
            options: ['栏', '边', '畔'],
            correct: '栏'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 20,
        title: '独坐敬亭山',
        author: '李白',
        poem: '众鸟高飞__ __，孤云独去闲。\n相看两不厌，只有敬亭山。',
        blanks: [
          {
            index: 0,
            options: ['尽', '远', '绝'],
            correct: '尽'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 21,
        title: '夜泊牛渚怀古',
        author: '李白',
        poem: '牛渚西江夜，青天无片__ __。\n登舟望秋月，空忆谢将军。',
        blanks: [
          {
            index: 0,
            options: ['云', '雾', '霞'],
            correct: '云'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 22,
        title: '与史郎中钦听黄鹤楼上吹笛',
        author: '李白',
        poem: '一为迁客去长沙，西望长安不见__ __。黄鹤楼中吹玉笛，江城五月落梅花。',
        blanks: [
          {
            index: 0,
            options: ['家', '人', '城'],
            correct: '家'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 23,
        title: '春思',
        author: '李白',
        poem: '燕草如碧丝，秦桑低绿__ __。当君怀归日，是妾断肠时。',
        blanks: [
          {
            index: 0,
            options: ['枝', '叶', '条'],
            correct: '枝'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 24,
        title: '金陵城西楼月下吟',
        author: '李白',
        poem: '金陵夜寂凉风发，独上高楼望吴__ __。白云映水摇空城，白露垂珠滴秋月。',
        blanks: [
          {
            index: 0,
            options: ['越', '楚', '晋'],
            correct: '越'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 25,
        title: '听蜀僧濬弹琴',
        author: '李白',
        poem: '蜀僧抱绿绮，西下峨眉__ __。为我一挥手，如听万壑松。',
        blanks: [
          {
            index: 0,
            options: ['峰', '岭', '山'],
            correct: '峰'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 26,
        title: '客中作',
        author: '李白',
        poem: '兰陵美酒郁金香，玉碗盛来琥珀__ __。但使主人能醉客，不知何处是他乡。',
        blanks: [
          {
            index: 0,
            options: ['光', '色', '液'],
            correct: '光'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 27,
        title: '秋浦歌',
        author: '李白',
        poem: '白发三千丈，缘愁似个__ __。不知明镜里，何处得秋霜。',
        blanks: [
          {
            index: 0,
            options: ['长', '大', '高'],
            correct: '长'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 28,
        title: '玉阶怨',
        author: '李白',
        poem: '玉阶生白露，夜久侵罗__ __。却下水晶帘，玲珑望秋月。',
        blanks: [
          {
            index: 0,
            options: ['袜', '鞋', '裙'],
            correct: '袜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 29,
        title: '塞下曲',
        author: '李白',
        poem: '五月天山雪，无花只有寒。笛中闻折__ __，春色未曾看。',
        blanks: [
          {
            index: 0,
            options: ['柳', '梅', '桃'],
            correct: '柳'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 30,
        title: '劳劳亭',
        author: '李白',
        poem: '天下伤心处，劳劳送客__ __。春风知别苦，不遣柳条青。',
        blanks: [
          {
            index: 0,
            options: ['亭', '楼', '桥'],
            correct: '亭'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 31,
        title: '怨情',
        author: '李白',
        poem: '美人卷珠帘，深坐颦__ __。但见泪痕湿，不知心恨谁。',
        blanks: [
          {
            index: 0,
            options: ['蛾眉', '眉头', '眉尖'],
            correct: '蛾眉'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 32,
        title: '哭宣城善酿纪叟',
        author: '李白',
        poem: '纪叟黄泉里，还应酿老__ __。夜台无李白，沽酒与何人？',
        blanks: [
          {
            index: 0,
            options: ['春', '酒', '茶'],
            correct: '春'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 33,
        title: '山中问答',
        author: '李白',
        poem: '问余何意栖碧山，笑而不答心自__ __。桃花流水窅然去，别有天地非人间。',
        blanks: [
          {
            index: 0,
            options: ['闲', '乐', '静'],
            correct: '闲'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 34,
        title: '峨眉山月歌送蜀僧晏入中京',
        author: '李白',
        poem: '我在巴东三峡时，西看明月忆峨__ __。月出峨眉照沧海，与人万里长相随。',
        blanks: [
          {
            index: 0,
            options: ['眉', '山', '峰'],
            correct: '眉'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 35,
        title: '赠孟浩然',
        author: '李白',
        poem: '吾爱孟夫子，风流天下闻。红颜弃轩__ __，白首卧松云。',
        blanks: [
          {
            index: 0,
            options: ['冕', '盖', '车'],
            correct: '冕'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 36,
        title: '渡荆门送别',
        author: '李白',
        poem: '渡远荆门外，来从楚国游。山随平野尽，江入大荒__ __。',
        blanks: [
          {
            index: 0,
            options: ['流', '走', '奔'],
            correct: '流'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 37,
        title: '送友人入蜀',
        author: '李白',
        poem: '见说蚕丛路，崎岖不易__ __。山从人面起，云傍马头生。',
        blanks: [
          {
            index: 0,
            options: ['行', '走', '登'],
            correct: '行'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 38,
        title: '登金陵凤凰台',
        author: '李白',
        poem: '凤凰台上凤凰游，凤去台空江自__ __。吴宫花草埋幽径，晋代衣冠成古丘。',
        blanks: [
          {
            index: 0,
            options: ['流', '走', '淌'],
            correct: '流'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 39,
        title: '月下独酌',
        author: '李白',
        poem: '花间一壶酒，独酌无相亲。举杯邀明月，对影成__ __人。',
        blanks: [
          {
            index: 0,
            options: ['三', '双', '众'],
            correct: '三'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 40,
        title: '清平调',
        author: '李白',
        poem: '云想衣裳花想容，春风拂槛露华__ __。若非群玉山头见，会向瑶台月下逢。',
        blanks: [
          {
            index: 0,
            options: ['浓', '重', '深'],
            correct: '浓'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 41,
        title: '子夜吴歌',
        author: '李白',
        poem: '长安一片月，万户捣衣__ __。秋风吹不尽，总是玉关情。',
        blanks: [
          {
            index: 0,
            options: ['声', '响', '音'],
            correct: '声'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 42,
        title: '侠客行',
        author: '李白',
        poem: '赵客缦胡缨，吴钩霜雪__ __。银鞍照白马，飒沓如流星。',
        blanks: [
          {
            index: 0,
            options: ['明', '亮', '白'],
            correct: '明'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 43,
        title: '古风',
        author: '李白',
        poem: '大雅久不作，吾衰竟谁__ __？王风委蔓草，战国多荆榛。',
        blanks: [
          {
            index: 0,
            options: ['陈', '传', '继'],
            correct: '陈'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 44,
        title: '庐山谣寄卢侍御虚舟',
        author: '李白',
        poem: '我本楚狂人，凤歌笑孔丘。手持绿玉杖，朝别黄鹤__ __。',
        blanks: [
          {
            index: 0,
            options: ['楼', '山', '台'],
            correct: '楼'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 45,
        title: '梦游天姥吟留别',
        author: '李白',
        poem: '海客谈瀛洲，烟涛微茫信难求。越人语天姥，云霞明灭或可__ __。',
        blanks: [
          {
            index: 0,
            options: ['睹', '见', '望'],
            correct: '睹'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 46,
        title: '金陵酒肆留别',
        author: '李白',
        poem: '风吹柳花满店香，吴姬压酒唤客尝。金陵子弟来相送，欲行不行各尽__ __。',
        blanks: [
          {
            index: 0,
            options: ['觞', '杯', '酒'],
            correct: '觞'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 47,
        title: '宣城见杜鹃花',
        author: '李白',
        poem: '蜀国曾闻子规鸟，宣城还见杜鹃__ __。一叫一回肠一断，三春三月忆三巴。',
        blanks: [
          {
            index: 0,
            options: ['花', '声', '啼'],
            correct: '花'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 48,
        title: '望天门山',
        author: '李白',
        poem: '天门中断楚江开，碧水东流至此__ __。两岸青山相对出，孤帆一片日边来。',
        blanks: [
          {
            index: 0,
            options: ['回', '转', '流'],
            correct: '回'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 49,
        title: '秋登宣城谢脁北楼',
        author: '李白',
        poem: '江城如画里，山晚望晴__ __。两水夹明镜，双桥落彩虹。',
        blanks: [
          {
            index: 0,
            options: ['空', '霞', '天'],
            correct: '空'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 50,
        title: '赠汪伦',
        author: '李白',
        poem: '李白乘舟将欲行，忽闻岸上踏歌声。桃花潭水深千尺，不及汪伦送我__ __。',
        blanks: [
          {
            index: 0,
            options: ['情', '心', '意'],
            correct: '情'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 51,
        title: '早发白帝城',
        author: '李白',
        poem: '朝辞白帝彩云间，千里江陵一日__ __。两岸猿声啼不住，轻舟已过万重山。',
        blanks: [
          {
            index: 0,
            options: ['还', '回', '到'],
            correct: '还'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 52,
        title: '独坐敬亭山',
        author: '李白',
        poem: '众鸟高飞尽，孤云独去__ __。相看两不厌，只有敬亭山。',
        blanks: [
          {
            index: 0,
            options: ['闲', '散', '游'],
            correct: '闲'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 53,
        title: '黄鹤楼送孟浩然之广陵',
        author: '李白',
        poem: '故人西辞黄鹤楼，烟花三月下扬州。孤帆远影碧空尽，唯见长江天际__ __。',
        blanks: [
          {
            index: 0,
            options: ['流', '走', '奔'],
            correct: '流'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 54,
        title: '静夜思',
        author: '李白',
        poem: '床前明月光，疑是地上霜。举头望明月，低头思故__ __。',
        blanks: [
          {
            index: 0,
            options: ['乡', '人', '家'],
            correct: '乡'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 55,
        title: '望庐山瀑布',
        author: '李白',
        poem: '日照香炉生紫烟，遥看瀑布挂前__ __。飞流直下三千尺，疑是银河落九天。',
        blanks: [
          {
            index: 0,
            options: ['川', '山', '岭'],
            correct: '川'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 56,
        title: '春夜洛城闻笛',
        author: '李白',
        poem: '谁家玉笛暗飞声，散入春风满洛城。此夜曲中闻折柳，何人不起故园__ __。',
        blanks: [
          {
            index: 0,
            options: ['情', '心', '意'],
            correct: '情'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 57,
        title: '送友人',
        author: '李白',
        poem: '青山横北郭，白水绕东城。此地一为别，孤蓬万里__ __。',
        blanks: [
          {
            index: 0,
            options: ['征', '行', '游'],
            correct: '征'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 58,
        title: '将进酒',
        author: '李白',
        poem: '君不见黄河之水天上来，奔流到海不复__ __。君不见高堂明镜悲白发，朝如青丝暮成雪。',
        blanks: [
          {
            index: 0,
            options: ['回', '返', '归'],
            correct: '回'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 59,
        title: '行路难',
        author: '李白',
        poem: '金樽清酒斗十千，玉盘珍羞直万钱。停杯投箸不能食，拔剑四顾心茫__ __。',
        blanks: [
          {
            index: 0,
            options: ['然', '乱', '慌'],
            correct: '然'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 60,
        title: '蜀道难',
        author: '李白',
        poem: '噫吁嚱，危乎高哉！蜀道之难，难于上青__ __！',
        blanks: [
          {
            index: 0,
            options: ['天', '云', '峰'],
            correct: '天'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 61,
        title: '月下独酌',
        author: '李白',
        poem: '花间一壶酒，独酌无相亲。举杯邀明月，对__ __成三人。',
        blanks: [
          {
            index: 0,
            options: ['影', '酒', '月'],
            correct: '影'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 62,
        title: '宣州谢脁楼饯别校书叔云',
        author: '李白',
        poem: '弃我去者，昨日之日不可留。乱我心者，今日之日多烦__ __。',
        blanks: [
          {
            index: 0,
            options: ['忧', '愁', '恼'],
            correct: '忧'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 63,
        title: '子夜秋歌',
        author: '李白',
        poem: '长安一片月，万户捣练__ __。秋风吹不尽，总是玉关情。',
        blanks: [
          {
            index: 0,
            options: ['声', '音', '响'],
            correct: '声'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 64,
        title: '关山月',
        author: '李白',
        poem: '明月出天山，苍茫云海间。长风几万里，吹度__ __门关。',
        blanks: [
          {
            index: 0,
            options: ['玉', '嘉', '函'],
            correct: '玉'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 65,
        title: '长相思',
        author: '李白',
        poem: '长相思，在长安。络纬秋啼金井栏，微霜凄凄簟色__ __。',
        blanks: [
          {
            index: 0,
            options: ['寒', '冷', '凉'],
            correct: '寒'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 66,
        title: '金陵城西楼月下吟',
        author: '李白',
        poem: '金陵夜寂凉风发，独上高楼望吴越。白云映水摇空城，白露垂珠滴秋__ __。',
        blanks: [
          {
            index: 0,
            options: ['月', '夜', '天'],
            correct: '月'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 67,
        title: '听蜀僧濬弹琴',
        author: '李白',
        poem: '蜀僧抱绿绮，西下峨眉峰。为我一挥手，如听万__ __松。',
        blanks: [
          {
            index: 0,
            options: ['壑', '山', '谷'],
            correct: '壑'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 68,
        title: '客中作',
        author: '李白',
        poem: '兰陵美酒郁金香，玉碗盛来琥珀光。但使主人能醉客，不知何处是__ __乡。',
        blanks: [
          {
            index: 0,
            options: ['他', '故', '家'],
            correct: '他'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 69,
        title: '秋浦歌',
        author: '李白',
        poem: '白发三千丈，缘愁似个长。不知明镜里，何处得秋__ __。',
        blanks: [
          {
            index: 0,
            options: ['霜', '雪', '露'],
            correct: '霜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 70,
        title: '玉阶怨',
        author: '李白',
        poem: '玉阶生白露，夜久侵罗袜。却下水晶帘，玲珑望秋__ __。',
        blanks: [
          {
            index: 0,
            options: ['月', '夜', '天'],
            correct: '月'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 71,
        title: '塞下曲',
        author: '李白',
        poem: '五月天山雪，无花只有寒。笛中闻折柳，春色未曾__ __。',
        blanks: [
          {
            index: 0,
            options: ['看', '见', '观'],
            correct: '看'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 72,
        title: '劳劳亭',
        author: '李白',
        poem: '天下伤心处，劳劳送客亭。春风知别苦，不遣柳条__ __。',
        blanks: [
          {
            index: 0,
            options: ['青', '绿', '翠'],
            correct: '青'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 73,
        title: '怨情',
        author: '李白',
        poem: '美人卷珠帘，深坐颦蛾眉。但见泪痕湿，不知心恨__ __。',
        blanks: [
          {
            index: 0,
            options: ['谁', '何', '哪'],
            correct: '谁'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 74,
        title: '哭宣城善酿纪叟',
        author: '李白',
        poem: '纪叟黄泉里，还应酿老春。夜台无李白，沽酒与__ __人？',
        blanks: [
          {
            index: 0,
            options: ['何', '哪', '什'],
            correct: '何'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 75,
        title: '山中问答',
        author: '李白',
        poem: '问余何意栖碧山，笑而不答心自闲。桃花流水窅然去，别有天地非人__ __。',
        blanks: [
          {
            index: 0,
            options: ['间', '世', '界'],
            correct: '间'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 76,
        title: '峨眉山月歌送蜀僧晏入中京',
        author: '李白',
        poem: '我在巴东三峡时，西看明月忆峨眉。月出峨眉照沧海，与人万里长相__ __。',
        blanks: [
          {
            index: 0,
            options: ['随', '伴', '陪'],
            correct: '随'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 77,
        title: '赠孟浩然',
        author: '李白',
        poem: '吾爱孟夫子，风流天下闻。红颜弃轩冕，白首卧松__ __。',
        blanks: [
          {
            index: 0,
            options: ['云', '山', '林'],
            correct: '云'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 78,
        title: '渡荆门送别',
        author: '李白',
        poem: '渡远荆门外，来从楚国游。山随平野尽，江入大荒流。月下飞天__ __，云生结海楼。',
        blanks: [
          {
            index: 0,
            options: ['镜', '月', '光'],
            correct: '镜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 79,
        title: '送友人入蜀',
        author: '李白',
        poem: '见说蚕丛路，崎岖不易行。山从人面起，云傍马头__ __。',
        blanks: [
          {
            index: 0,
            options: ['生', '起', '升'],
            correct: '生'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 80,
        title: '登金陵凤凰台',
        author: '李白',
        poem: '凤凰台上凤凰游，凤去台空江自流。吴宫花草埋幽径，晋代衣冠成古__ __。',
        blanks: [
          {
            index: 0,
            options: ['丘', '墓', '冢'],
            correct: '丘'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 81,
        title: '清平调',
        author: '李白',
        poem: '云想衣裳花想容，春风拂槛露华浓。若非群玉山头见，会向瑶台月下__ __。',
        blanks: [
          {
            index: 0,
            options: ['逢', '遇', '见'],
            correct: '逢'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 82,
        title: '子夜吴歌',
        author: '李白',
        poem: '长安一片月，万户捣衣声。秋风吹不尽，总是玉关__ __。',
        blanks: [
          {
            index: 0,
            options: ['情', '心', '意'],
            correct: '情'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 83,
        title: '侠客行',
        author: '李白',
        poem: '赵客缦胡缨，吴钩霜雪明。银鞍照白马，飒沓如流__ __。',
        blanks: [
          {
            index: 0,
            options: ['星', '电', '光'],
            correct: '星'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 84,
        title: '古风',
        author: '李白',
        poem: '大雅久不作，吾衰竟谁陈？王风委蔓草，战国多荆__ __。',
        blanks: [
          {
            index: 0,
            options: ['榛', '棘', '莽'],
            correct: '榛'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 85,
        title: '宣城见杜鹃花',
        author: '李白',
        poem: '蜀国曾闻子规鸟，宣城还见杜鹃花。一叫一回肠一断，三春三月忆三__ __。',
        blanks: [
          {
            index: 0,
            options: ['巴', '蜀', '川'],
            correct: '巴'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 86,
        title: '望天门山',
        author: '李白',
        poem: '天门中断楚江开，碧水东流至此回。两岸青山相对出，孤帆一片日边__ __。',
        blanks: [
          {
            index: 0,
            options: ['来', '至', '到'],
            correct: '来'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 87,
        title: '秋登宣城谢脁北楼',
        author: '李白',
        poem: '江城如画里，山晚望晴空。两水夹明镜，双桥落彩__ __。',
        blanks: [
          {
            index: 0,
            options: ['虹', '霞', '云'],
            correct: '虹'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 88,
        title: '早发白帝城',
        author: '李白',
        poem: '朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不住，轻舟已过万重__ __。',
        blanks: [
          {
            index: 0,
            options: ['山', '岭', '峰'],
            correct: '山'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 89,
        title: '望庐山瀑布',
        author: '李白',
        poem: '日照香炉生紫烟，遥看瀑布挂前川。飞流直下三千尺，疑是银河落九__ __。',
        blanks: [
          {
            index: 0,
            options: ['天', '霄', '空'],
            correct: '天'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 90,
        title: '将进酒',
        author: '李白',
        poem: '君不见黄河之水天上来，奔流到海不复回。君不见高堂明镜悲白发，朝如青丝暮成__ __。',
        blanks: [
          {
            index: 0,
            options: ['雪', '霜', '灰'],
            correct: '雪'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 91,
        title: '行路难',
        author: '李白',
        poem: '金樽清酒斗十千，玉盘珍羞直万钱。停杯投箸不能食，拔剑四顾心茫然。欲渡黄河冰塞__ __，将登太行雪满山。',
        blanks: [
          {
            index: 0,
            options: ['川', '河', '水'],
            correct: '川'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 92,
        title: '蜀道难',
        author: '李白',
        poem: '噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫__ __！',
        blanks: [
          {
            index: 0,
            options: ['然', '茫', '渺'],
            correct: '然'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 93,
        title: '宣州谢脁楼饯别校书叔云',
        author: '李白',
        poem: '弃我去者，昨日之日不可留。乱我心者，今日之日多烦忧。长风万里送秋__ __，对此可以酣高楼。',
        blanks: [
          {
            index: 0,
            options: ['雁', '风', '月'],
            correct: '雁'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 94,
        title: '子夜秋歌',
        author: '李白',
        poem: '长安一片月，万户捣练声。秋风吹不尽，总是玉关情。何日平胡虏，良人罢远__ __？',
        blanks: [
          {
            index: 0,
            options: ['征', '行', '战'],
            correct: '征'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 95,
        title: '关山月',
        author: '李白',
        poem: '明月出天山，苍茫云海间。长风几万里，吹度玉门关。汉下白登道，胡窥青__ __山。',
        blanks: [
          {
            index: 0,
            options: ['海', '山', '河'],
            correct: '海'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 96,
        title: '长相思',
        author: '李白',
        poem: '长相思，在长安。络纬秋啼金井栏，微霜凄凄簟色寒。孤灯不明思欲__ __，卷帷望月空长叹。',
        blanks: [
          {
            index: 0,
            options: ['绝', '断', '绝'],
            correct: '绝'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 97,
        title: '金陵城西楼月下吟',
        author: '李白',
        poem: '金陵夜寂凉风发，独上高楼望吴越。白云映水摇空城，白露垂珠滴秋月。月下沉吟久不归，古来相接眼中__ __。',
        blanks: [
          {
            index: 0,
            options: ['稀', '少', '缺'],
            correct: '稀'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 98,
        title: '听蜀僧濬弹琴',
        author: '李白',
        poem: '蜀僧抱绿绮，西下峨眉峰。为我一挥手，如听万壑松。客心洗流水，馀响入霜__ __。',
        blanks: [
          {
            index: 0,
            options: ['钟', '钟', '钟'],
            correct: '钟'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 99,
        title: '客中作',
        author: '李白',
        poem: '兰陵美酒郁金香，玉碗盛来琥珀光。但使主人能醉客，不知何处是他__ __。',
        blanks: [
          {
            index: 0,
            options: ['乡', '家', '处'],
            correct: '乡'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 100,
        title: '秋浦歌',
        author: '李白',
        poem: '白发三千丈，缘愁似个长。不知明镜里，何处得秋霜。秋浦田舍翁，采鱼水中__ __。',
        blanks: [
          {
            index: 0,
            options: ['宿', '住', '居'],
            correct: '宿'
          } as Blank
        ],
        difficulty: 2
      } as Question
    ] as Question[]],
    [2, [ // 杜甫的20首著名诗作填词题
      {
        id: 1,
        title: '春夜喜雨',
        author: '杜甫',
        poem: '好雨知时节，当春乃__ __。\n随风潜入夜，润物细无声。',
        blanks: [
          {
            index: 0,
            options: ['发生', '出现', '降临'],
            correct: '发生'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '绝句',
        author: '杜甫',
        poem: '两个__ __鸣翠柳，一行白鹭上青天。\n窗含西岭千秋雪，门泊东吴万里船。',
        blanks: [
          {
            index: 0,
            options: ['黄鹂', '黄莺', '燕子'],
            correct: '黄鹂'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '江畔独步寻花',
        author: '杜甫',
        poem: '黄师塔前江水东，春光懒困__ __风。\n桃花一簇开无主，可爱深红爱浅红？',
        blanks: [
          {
            index: 0,
            options: ['倚', '迎', '乘'],
            correct: '倚'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '春望',
        author: '杜甫',
        poem: '国破山河在，城春草木__ __。\n感时花溅泪，恨别鸟惊心。',
        blanks: [
          {
            index: 0,
            options: ['深', '茂', '盛'],
            correct: '深'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '茅屋为秋风所破歌',
        author: '杜甫',
        poem: '八月秋高风怒号，卷我屋上三重__ __。\n茅飞渡江洒江郊，高者挂罥长林梢。',
        blanks: [
          {
            index: 0,
            options: ['茅', '瓦', '草'],
            correct: '茅'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '登高',
        author: '杜甫',
        poem: '风急天高猿啸哀，渚清沙白鸟飞__ __。\n无边落木萧萧下，不尽长江滚滚来。',
        blanks: [
          {
            index: 0,
            options: ['回', '还', '返'],
            correct: '回'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '望岳',
        author: '杜甫',
        poem: '岱宗夫如何？齐鲁青__ __了。\n造化钟神秀，阴阳割昏晓。',
        blanks: [
          {
            index: 0,
            options: ['未', '未', '未'],
            correct: '未'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 8,
        title: '月夜忆舍弟',
        author: '杜甫',
        poem: '戍鼓断人行，边秋一雁__ __。\n露从今夜白，月是故乡明。',
        blanks: [
          {
            index: 0,
            options: ['声', '鸣', '啼'],
            correct: '声'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '旅夜书怀',
        author: '杜甫',
        poem: '细雨鱼儿出，微风燕子__ __。\n江流天地外，山色有无中。',
        blanks: [
          {
            index: 0,
            options: ['斜', '飞', '舞'],
            correct: '斜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 10,
        title: '蜀相',
        author: '杜甫',
        poem: '丞相祠堂何处寻？锦官城外柏__ ____。\n映阶碧草自春色，隔叶黄鹂空好音。',
        blanks: [
          {
            index: 0,
            options: ['森森', '青青', '茂茂'],
            correct: '森森'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 11,
        title: '闻官军收河南河北',
        author: '杜甫',
        poem: '剑外忽传收蓟北，初闻涕泪满__ __。\n却看妻子愁何在，漫卷诗书喜欲狂。',
        blanks: [
          {
            index: 0,
            options: ['衣裳', '衣襟', '袍袖'],
            correct: '衣裳'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 12,
        title: '兵车行',
        author: '杜甫',
        poem: '车辚辚，马萧萧，行人弓箭各在__ __。\n爷娘妻子走相送，尘埃不见咸阳桥。',
        blanks: [
          {
            index: 0,
            options: ['腰', '身', '背'],
            correct: '腰'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 13,
        title: '丽人行',
        author: '杜甫',
        poem: '三月三日天气新，长安水边多__ __。\n态浓意远淑且真，肌理细腻骨肉匀。',
        blanks: [
          {
            index: 0,
            options: ['丽人', '美人', '佳人'],
            correct: '丽人'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 14,
        title: '哀江头',
        author: '杜甫',
        poem: '少陵野老吞声哭，__ __足不敢过春苑。\n赐浴皆长缨，与宴非短褐。',
        blanks: [
          {
            index: 0,
            options: ['潜行', '匍匐', '蹑足'],
            correct: '潜行'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 15,
        title: '自京赴奉先县咏怀五百字',
        author: '杜甫',
        poem: '杜陵有布衣，老大意转__ __。\n许身一何愚，窃比稷与契。',
        blanks: [
          {
            index: 0,
            options: ['拙', '愚', '迂'],
            correct: '拙'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 16,
        title: '北征',
        author: '杜甫',
        poem: '皇帝二载秋，闰八月__ __。\n杜子将北征，苍茫问家室。',
        blanks: [
          {
            index: 0,
            options: ['初', '始', '临'],
            correct: '初'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 17,
        title: '羌村三首',
        author: '杜甫',
        poem: '峥嵘赤云西，日脚下平__ __。\n柴门鸟雀噪，归客千里至。',
        blanks: [
          {
            index: 0,
            options: ['地', '野', '原'],
            correct: '地'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 18,
        title: '天末怀李白',
        author: '杜甫',
        poem: '凉风起天末，君子意如__ __。\n鸿雁几时到，江湖秋水多。',
        blanks: [
          {
            index: 0,
            options: ['何', '何', '何'],
            correct: '何'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 19,
        title: '佳人',
        author: '杜甫',
        poem: '绝代有佳人，幽居在空__ __。\n自云良家子，零落依草木。',
        blanks: [
          {
            index: 0,
            options: ['谷', '山', '林'],
            correct: '谷'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 20,
        title: '石壕吏',
        author: '杜甫',
        poem: '暮投石壕村，有吏夜__ __。\n老翁逾墙走，老妇出门看。',
        blanks: [
          {
            index: 0,
            options: ['捉人', '征兵', '抓丁'],
            correct: '捉人'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 21,
        title: '赠卫八处士',
        author: '杜甫',
        poem: '人生不相见，动如参与商。今夕复何夕，共此灯烛__ __。',
        blanks: [
          {
            index: 0,
            options: ['光', '辉', '明'],
            correct: '光'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 22,
        title: '房兵曹胡马',
        author: '杜甫',
        poem: '胡马大宛名，锋棱瘦骨__ __。竹批双耳峻，风入四蹄轻。',
        blanks: [
          {
            index: 0,
            options: ['成', '现', '显'],
            correct: '成'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 23,
        title: '奉赠韦左丞丈二十二韵',
        author: '杜甫',
        poem: '纨绔不饿死，儒冠多误__ __。丈人试静听，贱子请具陈。',
        blanks: [
          {
            index: 0,
            options: ['身', '人', '事'],
            correct: '身'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 24,
        title: '送孔巢父谢病归游江东兼呈李白',
        author: '杜甫',
        poem: '巢父掉头不肯住，东将入海随烟__ __。诗卷长留天地间，钓竿欲拂珊瑚枝。',
        blanks: [
          {
            index: 0,
            options: ['雾', '霞', '云'],
            correct: '雾'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 25,
        title: '饮中八仙歌',
        author: '杜甫',
        poem: '李白斗酒诗百篇，长安市上酒家__ __。天子呼来不上船，自称臣是酒中仙。',
        blanks: [
          {
            index: 0,
            options: ['眠', '醉', '卧'],
            correct: '眠'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 26,
        title: '渼陂行',
        author: '杜甫',
        poem: '岑参兄弟皆好奇，携我远来游__ __。清秋突兀陂岸高，舟人侧畔崖倾倒。',
        blanks: [
          {
            index: 0,
            options: ['渼陂', '西湖', '洞庭'],
            correct: '渼陂'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 27,
        title: '渼陂西南台',
        author: '杜甫',
        poem: '高台面苍陂，六月风__ __寒。峥嵘中天日，重复照雪岸。',
        blanks: [
          {
            index: 0,
            options: ['萧', '清', '微'],
            correct: '萧'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 28,
        title: '同元使君舂陵行',
        author: '杜甫',
        poem: '借问悬车守，何如__ __卧。呜呼巴风烈，浩荡楚云深。',
        blanks: [
          {
            index: 0,
            options: ['皂', '皂', '皂'],
            correct: '皂'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 29,
        title: '戏为六绝句',
        author: '杜甫',
        poem: '庾信文章老更成，凌云健笔意纵__ __。今人嗤点流传赋，不觉前贤畏后生。',
        blanks: [
          {
            index: 0,
            options: ['横', '肆', '狂'],
            correct: '横'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 30,
        title: '寄李十二白二十韵',
        author: '杜甫',
        poem: '昔年有狂客，号尔谪仙__ __。笔落惊风雨，诗成泣鬼神。',
        blanks: [
          {
            index: 0,
            options: ['人', '子', '才'],
            correct: '人'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 31,
        title: '兵车行',
        author: '杜甫',
        poem: '边庭流血成海水，武皇开边意未__ __。君不闻汉家山东二百州，千村万落生荆杞。',
        blanks: [
          {
            index: 0,
            options: ['已', '止', '休'],
            correct: '已'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 32,
        title: '前出塞九首・其六',
        author: '杜甫',
        poem: '挽弓当挽强，用箭当用__ __。射人先射马，擒贼先擒王。',
        blanks: [
          {
            index: 0,
            options: ['长', '大', '利'],
            correct: '长'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 33,
        title: '自京赴奉先县咏怀五百字',
        author: '杜甫',
        poem: '朱门酒肉臭，路有冻死__ __。荣枯咫尺异，惆怅难再述。',
        blanks: [
          {
            index: 0,
            options: ['骨', '人', '尸'],
            correct: '骨'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 34,
        title: '哀江头',
        author: '杜甫',
        poem: '清渭东流剑阁深，去住彼此无消__ __。人生有情泪沾臆，江水江花岂终极。',
        blanks: [
          {
            index: 0,
            options: ['息', '耗', '音'],
            correct: '息'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 35,
        title: '月夜',
        author: '杜甫',
        poem: '今夜鄜州月，闺中只独__ __。遥怜小儿女，未解忆长安。',
        blanks: [
          {
            index: 0,
            options: ['看', '望', '观'],
            correct: '看'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 36,
        title: '春宿左省',
        author: '杜甫',
        poem: '花隐掖垣暮，啾啾栖鸟__ __。星临万户动，月傍九霄多。',
        blanks: [
          {
            index: 0,
            options: ['噪', '啼', '鸣'],
            correct: '噪'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 37,
        title: '曲江二首',
        author: '杜甫',
        poem: '一片花飞减却春，风飘万点正愁__ __。且看欲尽花经眼，莫厌伤多酒入唇。',
        blanks: [
          {
            index: 0,
            options: ['人', '心', '怀'],
            correct: '人'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 38,
        title: '奉济驿重送严公四韵',
        author: '杜甫',
        poem: '远送从此别，青山空复__ __。几时杯重把，昨夜月同行。',
        blanks: [
          {
            index: 0,
            options: ['情', '心', '怀'],
            correct: '情'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 39,
        title: '别房太尉墓',
        author: '杜甫',
        poem: '他乡复行役，驻马别__ __。近泪无干土，低空有断云。',
        blanks: [
          {
            index: 0,
            options: ['孤坟', '亲人', '故人'],
            correct: '孤坟'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 40,
        title: '蜀相',
        author: '杜甫',
        poem: '三顾频烦天下计，两朝开济老臣__ __。出师未捷身先死，长使英雄泪满襟。',
        blanks: [
          {
            index: 0,
            options: ['心', '志', '情'],
            correct: '心'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 41,
        title: '客至',
        author: '杜甫',
        poem: '舍南舍北皆春水，但见群鸥日日__ __。花径不曾缘客扫，蓬门今始为君开。',
        blanks: [
          {
            index: 0,
            options: ['来', '到', '至'],
            correct: '来'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 42,
        title: '野望',
        author: '杜甫',
        poem: '西山白雪三城戍，南浦清江万里__ __。海内风尘诸弟隔，天涯涕泪一身遥。',
        blanks: [
          {
            index: 0,
            options: ['桥', '岸', '堤'],
            correct: '桥'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 43,
        title: '闻官军收河南河北',
        author: '杜甫',
        poem: '白日放歌须纵酒，青春作伴好还__ __。即从巴峡穿巫峡，便下襄阳向洛阳。',
        blanks: [
          {
            index: 0,
            options: ['乡', '家', '国'],
            correct: '乡'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 44,
        title: '登岳阳楼',
        author: '杜甫',
        poem: '昔闻洞庭水，今上岳阳__ __。吴楚东南坼，乾坤日夜浮。',
        blanks: [
          {
            index: 0,
            options: ['楼', '台', '阁'],
            correct: '楼'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 45,
        title: '登高',
        author: '杜甫',
        poem: '万里悲秋常作客，百年多病独登__ __。艰难苦恨繁霜鬓，潦倒新停浊酒杯。',
        blanks: [
          {
            index: 0,
            options: ['台', '楼', '阁'],
            correct: '台'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 46,
        title: '江汉',
        author: '杜甫',
        poem: '江汉思归客，乾坤一腐__ __。片云天共远，永夜月同孤。',
        blanks: [
          {
            index: 0,
            options: ['儒', '士', '生'],
            correct: '儒'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 47,
        title: '秋兴八首・其一',
        author: '杜甫',
        poem: '玉露凋伤枫树林，巫山巫峡气__ __。江间波浪兼天涌，塞上风云接地阴。',
        blanks: [
          {
            index: 0,
            options: ['萧森', '萧瑟', '萧条'],
            correct: '萧森'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 48,
        title: '秋兴八首・其二',
        author: '杜甫',
        poem: '夔府孤城落日斜，每依北斗望京__ __。听猿实下三声泪，奉使虚随八月槎。',
        blanks: [
          {
            index: 0,
            options: ['华', '师', '门'],
            correct: '华'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 49,
        title: '秋兴八首・其三',
        author: '杜甫',
        poem: '千家山郭静朝晖，日日江楼坐翠__ __。信宿渔人还泛泛，清秋燕子故飞飞。',
        blanks: [
          {
            index: 0,
            options: ['微', '微', '微'],
            correct: '微'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 50,
        title: '秋兴八首・其四',
        author: '杜甫',
        poem: '闻道长安似弈棋，百年世事不胜__ __。王侯第宅皆新主，文武衣冠异昔时。',
        blanks: [
          {
            index: 0,
            options: ['悲', '叹', '伤'],
            correct: '悲'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 51,
        title: '秋兴八首・其五',
        author: '杜甫',
        poem: '蓬莱宫阙对南山，承露金茎霄汉__ __。西望瑶池降王母，东来紫气满函关。',
        blanks: [
          {
            index: 0,
            options: ['间', '中', '里'],
            correct: '间'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 52,
        title: '秋兴八首・其六',
        author: '杜甫',
        poem: '瞿塘峡口曲江头，万里风烟接素__ __。花萼夹城通御气，芙蓉小苑入边愁。',
        blanks: [
          {
            index: 0,
            options: ['秋', '愁', '忧'],
            correct: '秋'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 53,
        title: '秋兴八首・其七',
        author: '杜甫',
        poem: '昆明池水汉时功，武帝旌旗在眼__ __。织女机丝虚夜月，石鲸鳞甲动秋风。',
        blanks: [
          {
            index: 0,
            options: ['中', '间', '里'],
            correct: '中'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 54,
        title: '秋兴八首・其八',
        author: '杜甫',
        poem: '昆吾御宿自逶迤，紫阁峰阴入__ __。香稻啄余鹦鹉粒，碧梧栖老凤凰枝。',
        blanks: [
          {
            index: 0,
            options: ['渼陂', '西湖', '洞庭'],
            correct: '渼陂'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 55,
        title: '咏怀古迹五首・其一',
        author: '杜甫',
        poem: '支离东北风尘际，飘泊西南天地__ __。三峡楼台淹日月，五溪衣服共云山。',
        blanks: [
          {
            index: 0,
            options: ['间', '中', '里'],
            correct: '间'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 56,
        title: '咏怀古迹五首・其二',
        author: '杜甫',
        poem: '摇落深知宋玉悲，风流儒雅亦吾__ __。怅望千秋一洒泪，萧条异代不同时。',
        blanks: [
          {
            index: 0,
            options: ['师', '友', '朋'],
            correct: '师'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 57,
        title: '咏怀古迹五首・其三',
        author: '杜甫',
        poem: '群山万壑赴荆门，生长明妃尚有__ __。一去紫台连朔漠，独留青冢向黄昏。',
        blanks: [
          {
            index: 0,
            options: ['村', '村', '村'],
            correct: '村'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 58,
        title: '咏怀古迹五首・其四',
        author: '杜甫',
        poem: '蜀主窥吴幸三峡，崩年亦在永安__ __。翠华想像空山里，玉殿虚无野寺中。',
        blanks: [
          {
            index: 0,
            options: ['宫', '殿', '台'],
            correct: '宫'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 59,
        title: '咏怀古迹五首・其五',
        author: '杜甫',
        poem: '诸葛大名垂宇宙，宗臣遗像肃清__ __。三分割据纡筹策，万古云霄一羽毛。',
        blanks: [
          {
            index: 0,
            options: ['高', '大', '雄'],
            correct: '高'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 60,
        title: '阁夜',
        author: '杜甫',
        poem: '岁暮阴阳催短景，天涯霜雪霁寒__ __。五更鼓角声悲壮，三峡星河影动摇。',
        blanks: [
          {
            index: 0,
            options: ['宵', '夜', '晨'],
            correct: '宵'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 61,
        title: '登楼',
        author: '杜甫',
        poem: '花近高楼伤客心，万方多难此登__ __。锦江春色来天地，玉垒浮云变古今。',
        blanks: [
          {
            index: 0,
            options: ['临', '览', '观'],
            correct: '临'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 62,
        title: '宿府',
        author: '杜甫',
        poem: '清秋幕府井梧寒，独宿江城蜡炬__ __。永夜角声悲自语，中天月色好谁看。',
        blanks: [
          {
            index: 0,
            options: ['残', '尽', '灭'],
            correct: '残'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 63,
        title: '登柳州城楼寄漳汀封连四州',
        author: '杜甫',
        poem: '城上高楼接大荒，海天愁思正茫茫。惊风乱飐芙蓉水，密雨斜侵薜荔__ __。',
        blanks: [
          {
            index: 0,
            options: ['墙', '壁', '山'],
            correct: '墙'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 64,
        title: '寄韩谏议注',
        author: '杜甫',
        poem: '今我不乐思岳阳，身欲奋飞病在__ __。美人娟娟隔秋水，濯足洞庭望八荒。',
        blanks: [
          {
            index: 0,
            options: ['床', '榻', '席'],
            correct: '床'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 65,
        title: '丹青引赠曹将军霸',
        author: '杜甫',
        poem: '将军魏武之子孙，于今为庶为清__ __。英雄割据虽已矣，文采风流今尚存。',
        blanks: [
          {
            index: 0,
            options: ['门', '第', '族'],
            correct: '门'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 66,
        title: '观公孙大娘弟子舞剑器行',
        author: '杜甫',
        poem: '昔有佳人公孙氏，一舞剑器动四__ __。观者如山色沮丧，天地为之久低昂。',
        blanks: [
          {
            index: 0,
            options: ['方', '处', '域'],
            correct: '方'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 67,
        title: '韦讽录事宅观曹将军画马图',
        author: '杜甫',
        poem: '国初已来画鞍马，神妙独数江都__ __。将军得名三十载，人间又见真乘黄。',
        blanks: [
          {
            index: 0,
            options: ['王', '子', '孙'],
            correct: '王'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 68,
        title: '哀王孙',
        author: '杜甫',
        poem: '长安城头头白乌，夜飞延秋门上__ __。又向人家啄大屋，屋底达官走避胡。',
        blanks: [
          {
            index: 0,
            options: ['呼', '叫', '啼'],
            correct: '呼'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 69,
        title: '新婚别',
        author: '杜甫',
        poem: '兔丝附蓬麻，引蔓故不__ __。嫁女与征夫，不如弃路旁。',
        blanks: [
          {
            index: 0,
            options: ['长', '深', '远'],
            correct: '长'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 70,
        title: '垂老别',
        author: '杜甫',
        poem: '四郊未宁静，垂老不得__ __。子孙阵亡尽，焉用身独完。',
        blanks: [
          {
            index: 0,
            options: ['安', '宁', '静'],
            correct: '安'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 71,
        title: '无家别',
        author: '杜甫',
        poem: '寂寞天宝后，园庐但蒿__ __。我里百余家，世乱各东西。',
        blanks: [
          {
            index: 0,
            options: ['藜', '草', '艾'],
            correct: '藜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 72,
        title: '潼关吏',
        author: '杜甫',
        poem: '士卒何草草，筑城潼关__ __。大城铁不如，小城万丈余。',
        blanks: [
          {
            index: 0,
            options: ['道', '路', '口'],
            correct: '道'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 73,
        title: '新安吏',
        author: '杜甫',
        poem: '客行新安道，喧呼闻点__ __。借问新安吏，县小更无丁。',
        blanks: [
          {
            index: 0,
            options: ['兵', '军', '役'],
            correct: '兵'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 74,
        title: '石壕吏',
        author: '杜甫',
        poem: '吏呼一何怒，妇啼一何__ __。听妇前致词，三男邺城戍。',
        blanks: [
          {
            index: 0,
            options: ['苦', '悲', '哀'],
            correct: '苦'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 75,
        title: '新婚别',
        author: '杜甫',
        poem: '结发为君妻，席不暖君__ __。暮婚晨告别，无乃太匆忙。',
        blanks: [
          {
            index: 0,
            options: ['床', '榻', '席'],
            correct: '床'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 76,
        title: '垂老别',
        author: '杜甫',
        poem: '老妻卧路啼，岁暮衣裳__ __。孰知是死别，且复伤其寒。',
        blanks: [
          {
            index: 0,
            options: ['单', '薄', '破'],
            correct: '单'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 77,
        title: '无家别',
        author: '杜甫',
        poem: '永痛长病母，五年委沟__ __。生我不得力，终身两酸嘶。',
        blanks: [
          {
            index: 0,
            options: ['溪', '壑', '涧'],
            correct: '溪'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 78,
        title: '佳人',
        author: '杜甫',
        poem: '绝代有佳人，幽居在空__ __。自云良家子，零落依草木。',
        blanks: [
          {
            index: 0,
            options: ['谷', '山', '林'],
            correct: '谷'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 79,
        title: '梦李白二首・其一',
        author: '杜甫',
        poem: '死别已吞声，生别常恻__ __。江南瘴疠地，逐客无消息。',
        blanks: [
          {
            index: 0,
            options: ['恻', '凄', '悲'],
            correct: '恻'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 80,
        title: '梦李白二首・其二',
        author: '杜甫',
        poem: '浮云终日行，游子久不__ __。三夜频梦君，情亲见君意。',
        blanks: [
          {
            index: 0,
            options: ['归', '还', '回'],
            correct: '归'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 81,
        title: '天末怀李白',
        author: '杜甫',
        poem: '文章憎命达，魑魅喜人__ __。应共冤魂语，投诗赠汨罗。',
        blanks: [
          {
            index: 0,
            options: ['过', '行', '游'],
            correct: '过'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 82,
        title: '不见',
        author: '杜甫',
        poem: '不见李生久，佯狂真可__ __。世人皆欲杀，吾意独怜才。',
        blanks: [
          {
            index: 0,
            options: ['哀', '叹', '悲'],
            correct: '哀'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 83,
        title: '春日忆李白',
        author: '杜甫',
        poem: '白也诗无敌，飘然思不__ __。清新庾开府，俊逸鲍参军。',
        blanks: [
          {
            index: 0,
            options: ['群', '众', '辈'],
            correct: '群'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 84,
        title: '冬日有怀李白',
        author: '杜甫',
        poem: '寂寞书斋里，终朝独尔__ __。更寻嘉树传，不忘角弓诗。',
        blanks: [
          {
            index: 0,
            options: ['思', '念', '想'],
            correct: '思'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 85,
        title: '春夜喜雨',
        author: '杜甫',
        poem: '野径云俱黑，江船火独__ __。晓看红湿处，花重锦官城。',
        blanks: [
          {
            index: 0,
            options: ['明', '亮', '照'],
            correct: '明'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 86,
        title: '江上值水如海势聊短述',
        author: '杜甫',
        poem: '为人性僻耽佳句，语不惊人死不__ __。老去诗篇浑漫兴，春来花鸟莫深愁。',
        blanks: [
          {
            index: 0,
            options: ['休', '止', '已'],
            correct: '休'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 87,
        title: '江畔独步寻花・其五',
        author: '杜甫',
        poem: '黄师塔前江水东，春光懒困倚微__ __。桃花一簇开无主，可爱深红爱浅红。',
        blanks: [
          {
            index: 0,
            options: ['风', '雨', '晴'],
            correct: '风'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 88,
        title: '江畔独步寻花・其六',
        author: '杜甫',
        poem: '黄四娘家花满蹊，千朵万朵压枝__ __。留连戏蝶时时舞，自在娇莺恰恰啼。',
        blanks: [
          {
            index: 0,
            options: ['低', '垂', '弯'],
            correct: '低'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 89,
        title: '绝句・其三',
        author: '杜甫',
        poem: '两个黄鹂鸣翠柳，一行白鹭上青__ __。窗含西岭千秋雪，门泊东吴万里船。',
        blanks: [
          {
            index: 0,
            options: ['天', '空', '霄'],
            correct: '天'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 90,
        title: '绝句・其四',
        author: '杜甫',
        poem: '迟日江山丽，春风花草__ __。泥融飞燕子，沙暖睡鸳鸯。',
        blanks: [
          {
            index: 0,
            options: ['香', '艳', '美'],
            correct: '香'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 91,
        title: '绝句漫兴九首・其一',
        author: '杜甫',
        poem: '隔户杨柳弱袅袅，恰似十五女儿__ __。谓谁朝来不作意，狂风挽断最长条。',
        blanks: [
          {
            index: 0,
            options: ['腰', '臂', '手'],
            correct: '腰'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 92,
        title: '绝句漫兴九首・其五',
        author: '杜甫',
        poem: '肠断春江欲尽头，杖藜徐步立芳__ __。颠狂柳絮随风去，轻薄桃花逐水流。',
        blanks: [
          {
            index: 0,
            options: ['洲', '渚', '岸'],
            correct: '洲'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 93,
        title: '绝句漫兴九首・其七',
        author: '杜甫',
        poem: '糁径杨花铺白毡，点溪荷叶叠青__ __。笋根雉子无人见，沙上凫雏傍母眠。',
        blanks: [
          {
            index: 0,
            options: ['钱', '币', '玉'],
            correct: '钱'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 94,
        title: '茅屋为秋风所破歌',
        author: '杜甫',
        poem: '安得广厦千万间，大庇天下寒士俱欢__ __。风雨不动安如山，呜呼何时眼前突兀见此屋。',
        blanks: [
          {
            index: 0,
            options: ['颜', '笑', '心'],
            correct: '颜'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 95,
        title: '茅屋为秋风所破歌',
        author: '杜甫',
        poem: '俄顷风定云墨色，秋天漠漠向昏__ __。布衾多年冷似铁，娇儿恶卧踏里裂。',
        blanks: [
          {
            index: 0,
            options: ['黑', '暗', '冥'],
            correct: '黑'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 96,
        title: '茅屋为秋风所破歌',
        author: '杜甫',
        poem: '床头屋漏无干处，雨脚如麻未断__ __。自经丧乱少睡眠，长夜沾湿何由彻。',
        blanks: [
          {
            index: 0,
            options: ['绝', '断', '止'],
            correct: '绝'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 97,
        title: '望岳',
        author: '杜甫',
        poem: '荡胸生曾云，决眦入归__ __。会当凌绝顶，一览众山小。',
        blanks: [
          {
            index: 0,
            options: ['鸟', '雁', '鸿'],
            correct: '鸟'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 98,
        title: '望岳',
        author: '杜甫',
        poem: '岱宗夫如何，齐鲁青未__ __。造化钟神秀，阴阳割昏晓。',
        blanks: [
          {
            index: 0,
            options: ['了', '尽', '完'],
            correct: '了'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 99,
        title: '春望',
        author: '杜甫',
        poem: '烽火连三月，家书抵万__ __。白头搔更短，浑欲不胜簪。',
        blanks: [
          {
            index: 0,
            options: ['金', '钱', '两'],
            correct: '金'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 100,
        title: '春望',
        author: '杜甫',
        poem: '国破山河在，城春草木__ __。感时花溅泪，恨别鸟惊心。',
        blanks: [
          {
            index: 0,
            options: ['深', '茂', '盛'],
            correct: '深'
          } as Blank
        ],
        difficulty: 2
      } as Question
    ] as Question[]],
    [3, [ // 李清照的10首著名词作填词题（共10首）
      {
        id: 1,
        title: '如梦令',
        author: '李清照',
        poem: '常记溪亭日暮，沉醉不知归__ __。\n兴尽晚回舟，误入藕花深处。',
        blanks: [
          {
            index: 0,
            options: ['路', '途', '道'],
            correct: '路'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '声声慢',
        author: '李清照',
        poem: '寻寻觅觅，冷冷清清，凄凄惨惨__ __。\n乍暖还寒时候，最难将息。',
        blanks: [
          {
            index: 0,
            options: ['戚戚', '切切', '泣泣'],
            correct: '戚戚'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 3,
        title: '一剪梅',
        author: '李清照',
        poem: '红藕香残玉簟秋。轻解罗裳，独上兰__ __。\n云中谁寄锦书来，雁字回时，月满西楼。',
        blanks: [
          {
            index: 0,
            options: ['舟', '船', '舸'],
            correct: '舟'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '醉花阴',
        author: '李清照',
        poem: '薄雾浓云愁永昼，瑞脑消金__ __。\n佳节又重阳，玉枕纱厨，半夜凉初透。',
        blanks: [
          {
            index: 0,
            options: ['兽', '香', '炉'],
            correct: '兽'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '武陵春',
        author: '李清照',
        poem: '风住尘香花已尽，日晚倦梳__ __。\n物是人非事事休，欲语泪先流。',
        blanks: [
          {
            index: 0,
            options: ['头', '发', '妆'],
            correct: '头'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '点绛唇',
        author: '李清照',
        poem: '蹴罢秋千，起来慵整纤纤__ __。\n露浓花瘦，薄汗轻衣透。',
        blanks: [
          {
            index: 0,
            options: ['手', '指', '腕'],
            correct: '手'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '浣溪沙',
        author: '李清照',
        poem: '淡荡春光寒食天，玉炉沉水__ __香。\n梦回山枕隐花钿。',
        blanks: [
          {
            index: 0,
            options: ['袅', '缭', '氤'],
            correct: '袅'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 8,
        title: '念奴娇',
        author: '李清照',
        poem: '萧条庭院，又斜风细雨，重门须__ __。\n宠柳娇花寒食近，种种恼人天气。',
        blanks: [
          {
            index: 0,
            options: ['闭', '锁', '关'],
            correct: '闭'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '蝶恋花',
        author: '李清照',
        poem: '泪湿罗衣脂粉满，四叠阳关，唱到千千__ __。\n人道山长山又断，萧萧微雨闻孤馆。',
        blanks: [
          {
            index: 0,
            options: ['遍', '次', '回'],
            correct: '遍'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 10,
        title: '渔家傲',
        author: '李清照',
        poem: '天接云涛连晓雾，星河欲转千帆__ __。\n仿佛梦魂归帝所，闻天语，殷勤问我归何处。',
        blanks: [
          {
            index: 0,
            options: ['舞', '飞', '举'],
            correct: '舞'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]],
    [4, [ // 苏轼的15首著名诗作填词题（共15首）
      {
        id: 1,
        title: '饮湖上初晴后雨',
        author: '苏轼',
        poem: '水光潋滟__ __方好，山色空蒙雨亦奇。\n欲把西湖比西子，淡妆浓抹总相宜。',
        blanks: [
          {
            index: 0,
            options: ['晴', '天', '日'],
            correct: '晴'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '题西林壁',
        author: '苏轼',
        poem: '横看成岭侧成峰，远近高低各不__ __。\n不识庐山真面目，只缘身在此山中。',
        blanks: [
          {
            index: 0,
            options: ['同', '一', '样'],
            correct: '同'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '惠崇春江晚景',
        author: '苏轼',
        poem: '竹外桃花三两枝，春江水暖__ __先知。\n蒌蒿满地芦芽短，正是河豚欲上时。',
        blanks: [
          {
            index: 0,
            options: ['鸭', '鱼', '鹅'],
            correct: '鸭'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 4,
        title: '赠刘景文',
        author: '苏轼',
        poem: '荷尽已无擎雨盖，菊残犹有傲霜__ __。\n一年好景君须记，最是橙黄橘绿时。',
        blanks: [
          {
            index: 0,
            options: ['枝', '叶', '茎'],
            correct: '枝'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 5,
        title: '海棠',
        author: '苏轼',
        poem: '东风袅袅泛崇光，香雾空蒙月转__ __。\n只恐夜深花睡去，故烧高烛照红妆。',
        blanks: [
          {
            index: 0,
            options: ['廊', '廊', '廊'],
            correct: '廊'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '六月二十七日望湖楼醉书',
        author: '苏轼',
        poem: '黑云翻墨未遮山，白雨跳珠乱入__ __。\n卷地风来忽吹散，望湖楼下水如天。',
        blanks: [
          {
            index: 0,
            options: ['船', '舟', '舱'],
            correct: '船'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '饮湖上初晴后雨',
        author: '苏轼',
        poem: '水光潋滟晴方好，山色空蒙__ __亦奇。\n欲把西湖比西子，淡妆浓抹总相宜。',
        blanks: [
          {
            index: 0,
            options: ['雨', '雪', '雾'],
            correct: '雨'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 8,
        title: '春宵',
        author: '苏轼',
        poem: '春宵一刻值千金，花有清香月有__ __。\n歌管楼台声细细，秋千院落夜沉沉。',
        blanks: [
          {
            index: 0,
            options: ['阴', '影', '光'],
            correct: '阴'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '和子由渑池怀旧',
        author: '苏轼',
        poem: '人生到处知何似，应似飞鸿踏雪__ __。\n泥上偶然留指爪，鸿飞那复计东西。',
        blanks: [
          {
            index: 0,
            options: ['泥', '地', '痕'],
            correct: '泥'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 10,
        title: '腊日游孤山访惠勤惠思二僧',
        author: '苏轼',
        poem: '天欲雪，云满湖，楼台明灭山有__ __。\n水清出石鱼可数，林深无人鸟相呼。',
        blanks: [
          {
            index: 0,
            options: ['无', '无', '无'],
            correct: '无'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 11,
        title: '新城道中',
        author: '苏轼',
        poem: '东风知我欲山行，吹断檐间积雨__ __。\n岭上晴云披絮帽，树头初日挂铜钲。',
        blanks: [
          {
            index: 0,
            options: ['声', '滴', '痕'],
            correct: '声'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 12,
        title: '泗州僧伽塔',
        author: '苏轼',
        poem: '耕田欲雨刈欲晴，去得顺风来者__ __。\n万事已华双鬓里，百年须醉五更头。',
        blanks: [
          {
            index: 0,
            options: ['逆', '阻', '妨'],
            correct: '逆'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 13,
        title: '雪后到乾明寺遂宿',
        author: '苏轼',
        poem: '门外山光马亦惊，阶前屐齿我先行。\n风花误入长安道，妓女都__ __学帝京。',
        blanks: [
          {
            index: 0,
            options: ['来', '去', '欲'],
            correct: '来'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 14,
        title: '除夕访子野食笋',
        author: '苏轼',
        poem: '久客厌虏馔，枵然思南__ __。\n明日又为岁，慷慨何所言。',
        blanks: [
          {
            index: 0,
            options: ['味', '风', '情'],
            correct: '味'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 15,
        title: '正月二十日与潘郭二生出郊寻春',
        author: '苏轼',
        poem: '东风未肯入东门，走马还寻去岁__ __。\n人似秋鸿来有信，事如春梦了无痕。',
        blanks: [
          {
            index: 0,
            options: ['村', '径', '痕'],
            correct: '村'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]],
    [5, [ // 王维的12首著名诗作填词题（共12首）
      {
        id: 1,
        title: '相思',
        author: '王维',
        poem: '红豆生南国，春来发几__ __。\n愿君多采撷，此物最相思。',
        blanks: [
          {
            index: 0,
            options: ['枝', '叶', '朵'],
            correct: '枝'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '山居秋暝',
        author: '王维',
        poem: '空山新雨后，天气晚来__ __。\n明月松间照，清泉石上流。',
        blanks: [
          {
            index: 0,
            options: ['秋', '凉', '寒'],
            correct: '秋'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '送元二使安西',
        author: '王维',
        poem: '渭城朝雨浥轻尘，客舍青青柳色__ __。\n劝君更尽一杯酒，西出阳关无故人。',
        blanks: [
          {
            index: 0,
            options: ['新', '嫩', '鲜'],
            correct: '新'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 4,
        title: '鹿柴',
        author: '王维',
        poem: '空山不见人，但闻人语__ __。\n返景入深林，复照青苔上。',
        blanks: [
          {
            index: 0,
            options: ['响', '声', '音'],
            correct: '响'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 5,
        title: '竹里馆',
        author: '王维',
        poem: '独坐幽篁里，弹琴复长__ __。\n深林人不知，明月来相照。',
        blanks: [
          {
            index: 0,
            options: ['啸', '吟', '歌'],
            correct: '啸'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '鸟鸣涧',
        author: '王维',
        poem: '人闲桂花落，夜静春山__ __。\n月出惊山鸟，时鸣春涧中。',
        blanks: [
          {
            index: 0,
            options: ['空', '寂', '静'],
            correct: '空'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '终南别业',
        author: '王维',
        poem: '中岁颇好道，晚家南山__ __。\n兴来每独往，胜事空自知。',
        blanks: [
          {
            index: 0,
            options: ['陲', '边', '麓'],
            correct: '陲'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '山中',
        author: '王维',
        poem: '荆溪白石出，天寒红叶__ __。\n山路元无雨，空翠湿人衣。',
        blanks: [
          {
            index: 0,
            options: ['稀', '少', '薄'],
            correct: '稀'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '终南山',
        author: '王维',
        poem: '太乙近天都，连山接海__ __。\n白云回望合，青霭入看无。',
        blanks: [
          {
            index: 0,
            options: ['隅', '边', '际'],
            correct: '隅'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 10,
        title: '辋川闲居赠裴秀才迪',
        author: '王维',
        poem: '寒山转苍翠，秋水日潺__ __。\n倚杖柴门外，临风听暮蝉。',
        blanks: [
          {
            index: 0,
            options: ['湲', '流', '淌'],
            correct: '湲'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 11,
        title: '酬张少府',
        author: '王维',
        poem: '晚年唯好静，万事不关__ __。\n自顾无长策，空知返旧林。',
        blanks: [
          {
            index: 0,
            options: ['心', '情', '怀'],
            correct: '心'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 12,
        title: '过香积寺',
        author: '王维',
        poem: '不知香积寺，数里入云__ __。\n古木无人径，深山何处钟。',
        blanks: [
          {
            index: 0,
            options: ['峰', '中', '间'],
            correct: '峰'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]],
    [6, [ // 白居易的10首著名诗作填词题
      {
        id: 1,
        title: '赋得古原草送别',
        author: '白居易',
        poem: '离离原上草，一岁一__ __。\n野火烧不尽，春风吹又生。',
        blanks: [
          {
            index: 0,
            options: ['枯荣', '枯落', '生长'],
            correct: '枯荣'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '钱塘湖春行',
        author: '白居易',
        poem: '几处早莺争__ __，谁家新燕啄春泥。\n乱花渐欲迷人眼，浅草才能没马蹄。',
        blanks: [
          {
            index: 0,
            options: ['暖树', '高枝', '新枝'],
            correct: '暖树'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 3,
        title: '大林寺桃花',
        author: '白居易',
        poem: '人间四月芳__ __，山寺桃花始盛开。\n长恨春归无觅处，不知转入此中来。',
        blanks: [
          {
            index: 0,
            options: ['菲尽', '菲落', '花尽'],
            correct: '菲尽'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '忆江南',
        author: '白居易',
        poem: '江南好，风景旧曾__ __。\n日出江花红胜火，春来江水绿如蓝。',
        blanks: [
          {
            index: 0,
            options: ['相识', '相知', '相见'],
            correct: '相识'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 5,
        title: '问刘十九',
        author: '白居易',
        poem: '绿蚁新醎酒，红泥__ __炉。\n晚来天欲雪，能饮一杯无？',
        blanks: [
          {
            index: 0,
            options: ['小火', '小泥', '小红'],
            correct: '小火'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '暗布送别',
        author: '白居易',
        poem: '同是天涯__ __人，相逢何必曾相识。',
        blanks: [
          {
            index: 0,
            options: ['沦落', '落魄', '浪迹'],
            correct: '沦落'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 7,
        title: '闻舞',
        author: '白居易',
        poem: '锁罗衫栗皮解，丹藤__ __牛发松。',
        blanks: [
          {
            index: 0,
            options: ['柳架', '花柶', '花松'],
            correct: '柳架'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '暮江吟',
        author: '白居易',
        poem: '一道残阳铺__ __，半江瑟瑟半江红。',
        blanks: [
          {
            index: 0,
            options: ['水中', '水上', '水边'],
            correct: '水中'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 9,
        title: '池上',
        author: '白居易',
        poem: '小娃擑小__ __，偏采白莲回。',
        blanks: [
          {
            index: 0,
            options: ['艇', '舟', '桥'],
            correct: '艇'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 10,
        title: '宫词',
        author: '白居易',
        poem: '泪湿罗巾梦不__ __，夜深前殿按歌声。',
        blanks: [
          {
            index: 0,
            options: ['成', '觉', '到'],
            correct: '成'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]],
    [7, [ // 辛弃疾的10首著名诗作填词题
      {
        id: 1,
        title: '破阵子·为陈同甫赋壮词以寄之',
        author: '辛弃疾',
        poem: '醉里挑灯__ __，梦回吹角连营。\n八百里分麾下炙，五十弦翻塞外声。',
        blanks: [
          {
            index: 0,
            options: ['看剑', '观剑', '抽剑'],
            correct: '看剑'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 2,
        title: '青玉案·元夕',
        author: '辛弃疾',
        poem: '众里寻他千__ __，蓦然回首，那人却在，灯火阑珊处。',
        blanks: [
          {
            index: 0,
            options: ['百度', '万度', '十度'],
            correct: '百度'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '西江月·夜行黄沙道中',
        author: '辛弃疾',
        poem: '明月别枝惊__ __，清风半夜鸣蝉。',
        blanks: [
          {
            index: 0,
            options: ['鹊', '鹤', '鹰'],
            correct: '鹊'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '丑奴儿·书博山道中壁',
        author: '辛弃疾',
        poem: '少年不识愁__ __，爱上层楼，爱上层楼，为赋新词强说愁。',
        blanks: [
          {
            index: 0,
            options: ['滋味', '味道', '情味'],
            correct: '滋味'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 5,
        title: '永遇乐·京口北固亭怀古',
        author: '辛弃疾',
        poem: '千古江山，英雄无__ __，孙仲谋处。',
        blanks: [
          {
            index: 0,
            options: ['觅处', '处所', '去处'],
            correct: '觅处'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '水龙吟·登建康赏心亭',
        author: '辛弃疾',
        poem: '楚天千里清__ __，水随天去秋无际。',
        blanks: [
          {
            index: 0,
            options: ['秋', '空', '净'],
            correct: '秋'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '鹎鸻天·代人赋',
        author: '辛弃疾',
        poem: '晚日寒鸦一片__ __，风急天高猿啸哀。',
        blanks: [
          {
            index: 0,
            options: ['愁', '愁您', '悲'],
            correct: '愁'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '诺娇娘·书东流村壁',
        author: '辛弃疾',
        poem: '青山遮不__ __，毕竟东流去。',
        blanks: [
          {
            index: 0,
            options: ['住', '住你', '了'],
            correct: '住'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 9,
        title: '永遇乐·万古登口',
        author: '辛弃疾',
        poem: '千古兴__ __，五百年后，花外高楼。',
        blanks: [
          {
            index: 0,
            options: ['亡', '亡之', '败'],
            correct: '亡'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 10,
        title: '木兰花慢·滄州送范偁',
        author: '辛弃疾',
        poem: '从今若许闲乘__ __，拄杖无时夜叩门。',
        blanks: [
          {
            index: 0,
            options: ['月', '风', '马'],
            correct: '月'
          } as Blank
        ],
        difficulty: 2
      } as Question
    ] as Question[]],
    [8, [ // 陆游的10首著名诗作填词题
      {
        id: 1,
        title: '示儿',
        author: '陆游',
        poem: '死去元知万__ __，但悲不见九州同。\n王师北定中原日，家祭无忘告乃翁。',
        blanks: [
          {
            index: 0,
            options: ['事空', '事空虚', '事休'],
            correct: '事空'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '游山西村',
        author: '陆游',
        poem: '山重水复疑无__ __，柳暗花明又一村。',
        blanks: [
          {
            index: 0,
            options: ['路', '径', '道'],
            correct: '路'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '卧春',
        author: '陆游',
        poem: '读书不觉已__ __，一寸光阴一寸金。',
        blanks: [
          {
            index: 0,
            options: ['春深', '春晚', '秋深'],
            correct: '春深'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '秋夜将晓出篮门迎凉有感',
        author: '陆游',
        poem: '三万里河东__ __，五千仍岳上摩天。',
        blanks: [
          {
            index: 0,
            options: ['入海', '入水', '流水'],
            correct: '入海'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '冒雨剧阵澄湖中破敌',
        author: '陆游',
        poem: '纸上得来终__ __，绝知此事要躬行。',
        blanks: [
          {
            index: 0,
            options: ['觉浅', '觉简', '不深'],
            correct: '觉浅'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 6,
        title: '十一月四日风雨大作',
        author: '陆游',
        poem: '僧卧听风吹__ __，铁马冰河入梦来。',
        blanks: [
          {
            index: 0,
            options: ['雨', '雪', '风'],
            correct: '雨'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 7,
        title: '关山月',
        author: '陆游',
        poem: '和戎十年归__ __，三十从军今白发。',
        blanks: [
          {
            index: 0,
            options: ['未得', '无望', '难望'],
            correct: '未得'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 8,
        title: '书愤',
        author: '陆游',
        poem: '早岁那知__ __，中原北望气如山。',
        blanks: [
          {
            index: 0,
            options: ['世事艰', '世艰', '天艰'],
            correct: '世事艰'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 9,
        title: '论诗',
        author: '陆游',
        poem: '文章本天成，妙__ __偶然得。',
        blanks: [
          {
            index: 0,
            options: ['手', '笔', '心'],
            correct: '手'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 10,
        title: '约客',
        author: '陆游',
        poem: '陷泵莫笑农家__ __，丰年留客足鸡豚。',
        blanks: [
          {
            index: 0,
            options: ['腊酒浑', '酒浑', '酒浓'],
            correct: '腊酒浑'
          } as Blank
        ],
        difficulty: 2
      } as Question
    ] as Question[]],
    [9, [ // 王昌龄的8首著名诗作填词题
      {
        id: 1,
        title: '出塞',
        author: '王昌龄',
        poem: '秦时明月__ __关，万里长征人未还。\n但使龙城飞将在，不教胡马度阴山。',
        blanks: [
          {
            index: 0,
            options: ['汉时', '唐时', '宋时'],
            correct: '汉时'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '芙蓉楼送辛渐',
        author: '王昌龄',
        poem: '洛阳亲友如相__ __，一片冰心在玉壶。',
        blanks: [
          {
            index: 0,
            options: ['问', '误', '忼'],
            correct: '问'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '闺怨',
        author: '王昌龄',
        poem: '闺中少妇不知__ __，春日凝妆上翠楼。',
        blanks: [
          {
            index: 0,
            options: ['愁', '恨', '苦'],
            correct: '愁'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '从军行',
        author: '王昌龄',
        poem: '黄沙百战穿__ __，不破楼兰终不还。',
        blanks: [
          {
            index: 0,
            options: ['金甲', '铁甲', '银甲'],
            correct: '金甲'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '采莲曲',
        author: '王昌龄',
        poem: '荷叶罗裙一色__ __，芙蓉向脸两边开。',
        blanks: [
          {
            index: 0,
            options: ['裁', '剪', '缝'],
            correct: '裁'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '送魏二',
        author: '王昌龄',
        poem: '醒时同交欢，__ __各分散。',
        blanks: [
          {
            index: 0,
            options: ['醉后', '醍后', '退后'],
            correct: '醉后'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '长信秋词',
        author: '王昌龄',
        poem: '奥家闺里秋光__ __，未解罗衫笓一个。',
        blanks: [
          {
            index: 0,
            options: ['好', '深', '凉'],
            correct: '好'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '闺中曲',
        author: '王昌龄',
        poem: '奏家鸡犬升天__ __，一人得道拔鸡犬。',
        blanks: [
          {
            index: 0,
            options: ['上', '内', '中'],
            correct: '上'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]],
    [10, [ // 孟浩然的8首著名诗作填词题
      {
        id: 1,
        title: '春晓',
        author: '孟浩然',
        poem: '春眠不__ __，处处闻啼鸟。\n夜来风雨声，花落知多少。',
        blanks: [
          {
            index: 0,
            options: ['觉晓', '觉天', '知晓'],
            correct: '觉晓'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '过故人庄',
        author: '孟浩然',
        poem: '开轩面__ __，把酒话桑麻。\n待到重阳日，还来就菊花。',
        blanks: [
          {
            index: 0,
            options: ['场圃', '田地', '田园'],
            correct: '场圃'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '宿建德江',
        author: '孟浩然',
        poem: '移舟泊烟__ __，日暮客愁新。',
        blanks: [
          {
            index: 0,
            options: ['渚', '雾', '水'],
            correct: '渚'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '望洞庭湖赠张丞相',
        author: '孟浩然',
        poem: '气蒸云梦__ __，波撼岳阳城。',
        blanks: [
          {
            index: 0,
            options: ['泽', '川', '湖'],
            correct: '泽'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '宿桌公湖',
        author: '孟浩然',
        poem: '荒林纷没夜__ __，欲寄寂寥何处边。',
        blanks: [
          {
            index: 0,
            options: ['闻鸠', '闻鸟', '听鸟'],
            correct: '闻鸠'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 6,
        title: '与诸子登岖山',
        author: '孟浩然',
        poem: '人事有__ __，往来成古今。',
        blanks: [
          {
            index: 0,
            options: ['代谢', '变易', '变迁'],
            correct: '代谢'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 7,
        title: '问舟子',
        author: '孟浩然',
        poem: '向密州__ __，水远山长的一声。',
        blanks: [
          {
            index: 0,
            options: ['哪边', '何处', '何方'],
            correct: '哪边'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 8,
        title: '寻菱溪居士不遇',
        author: '孟浩然',
        poem: '松下问__ __，言师采药去。',
        blanks: [
          {
            index: 0,
            options: ['童子', '小儿', '儿童'],
            correct: '童子'
          } as Blank
        ],
        difficulty: 1
      } as Question
    ] as Question[]],
    [11, [ // 杜牧的8首著名诗作填词题
      {
        id: 1,
        title: '山行',
        author: '杜牧',
        poem: '停车坐爱__ __，霜叶红于二月花。',
        blanks: [
          {
            index: 0,
            options: ['枫林晚', '枫林深', '枫林红'],
            correct: '枫林晚'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '清明',
        author: '杜牧',
        poem: '清明时节__ __，路上行人欲断魂。',
        blanks: [
          {
            index: 0,
            options: ['雨纷纷', '雨落落', '雨蓑蓑'],
            correct: '雨纷纷'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 3,
        title: '泊秦淮',
        author: '杜牧',
        poem: '烟笼寒__ __，夜泊秦淮近酒家。',
        blanks: [
          {
            index: 0,
            options: ['水月沙', '水月山', '水月楼'],
            correct: '水月沙'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '赤壁',
        author: '杜牧',
        poem: '东风不与__ __，铜雀春深锁二乔。',
        blanks: [
          {
            index: 0,
            options: ['周郎便', '周郎胜', '周郎意'],
            correct: '周郎便'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 5,
        title: '秋夕',
        author: '杜牧',
        poem: '银烛秋光冷__ __，轻罗小扇扑流萤。',
        blanks: [
          {
            index: 0,
            options: ['画屏', '屏风', '屏障'],
            correct: '画屏'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 6,
        title: '江南春',
        author: '杜牧',
        poem: '千里莺啼__ __，水村山郭酒旗风。',
        blanks: [
          {
            index: 0,
            options: ['绿映红', '红映绿', '绿配红'],
            correct: '绿映红'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '遣怀',
        author: '杜牧',
        poem: '落魄江湖载__ __，楚云湘雨不相关。',
        blanks: [
          {
            index: 0,
            options: ['酒行', '酒舟', '酒杯'],
            correct: '酒行'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '题害州东溪',
        author: '杜牧',
        poem: '春潮带雨晚来__ __，野渡无人舟自横。',
        blanks: [
          {
            index: 0,
            options: ['急', '深', '大'],
            correct: '急'
          } as Blank
        ],
        difficulty: 2
      } as Question
    ] as Question[]],
    [12, [ // 柳宗元的8首著名诗作填词题
      {
        id: 1,
        title: '江雪',
        author: '柳宗元',
        poem: '千山鸟__ __，万径人踪灭。\n孤舟蓑笠翁，独钓寒江雪。',
        blanks: [
          {
            index: 0,
            options: ['飞绝', '飞尽', '难飞'],
            correct: '飞绝'
          } as Blank
        ],
        difficulty: 1
      } as Question,
      {
        id: 2,
        title: '渔翁',
        author: '柳宗元',
        poem: '烟销日出不__ __，欸乃一声山水绿。',
        blanks: [
          {
            index: 0,
            options: ['见人', '闻人', '见者'],
            correct: '见人'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 3,
        title: '江雪',
        author: '柳宗元',
        poem: '晨起动__ __，开门雪满山。',
        blanks: [
          {
            index: 0,
            options: ['征铎', '铜铎', '马铎'],
            correct: '征铎'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 4,
        title: '读书',
        author: '柳宗元',
        poem: '幽沉谫不发，气__ __却自倾。',
        blanks: [
          {
            index: 0,
            options: ['优', '大', '盛'],
            correct: '优'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 5,
        title: '种柳戟江',
        author: '柳宗元',
        poem: '但令无__ __，会有道阴时。',
        blanks: [
          {
            index: 0,
            options: ['剖折', '剖损', '剥折'],
            correct: '剖折'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 6,
        title: '登柳州城楼寄漾汀连州',
        author: '柳宗元',
        poem: '城上高楼接__ __，海天愁思正茫茫。',
        blanks: [
          {
            index: 0,
            options: ['大荒', '远荒', '荒山'],
            correct: '大荒'
          } as Blank
        ],
        difficulty: 2
      } as Question,
      {
        id: 7,
        title: '酵州道中',
        author: '柳宗元',
        poem: '三年客岘一元__ __，十年弹指一年除。',
        blanks: [
          {
            index: 0,
            options: ['巳', '已', '开'],
            correct: '巳'
          } as Blank
        ],
        difficulty: 3
      } as Question,
      {
        id: 8,
        title: '雨后晓行独至愉越三亭',
        author: '柳宗元',
        poem: '宙宇是何意？__ __便自私。',
        blanks: [
          {
            index: 0,
            options: ['不杀', '不罚', '不害'],
            correct: '不杀'
          } as Blank
        ],
        difficulty: 3
      } as Question
    ] as Question[]]
  ]);

  // 当前诗人的题目
  @State private questions: Question[] = [];
  
  // 游戏状态
  @State currentQuestionIndex: number = 0;
  @State selectedAnswers: string[] = [];
  @State showResult: boolean = false;
  @State isCorrect: boolean = false;
  @State score: number = 0; // 总得分
  @State questionScores: number[] = []; // 每题得分记录
  @State showFinalScore: boolean = false; // 是否显示最终得分

  aboutToAppear(): void {
    // 获取路由参数中的诗人ID
    const routerParams = router.getParams() as RouterParams;
    if (routerParams && routerParams.poetId) {
      const poetId = routerParams.poetId;
      const foundPoet = this.poets.find(poet => poet.id === poetId);
      if (foundPoet) {
        this.poet = foundPoet;
      }
      
      // 获取该诗人的题目
      const poetQuestions = this.poetQuestions.get(poetId);
      if (poetQuestions) {
        this.questions = poetQuestions;
      }
    }
    
    // 初始化答案数组
    if (this.questions.length > 0) {
      this.selectedAnswers = new Array(this.questions[this.currentQuestionIndex].blanks.length).fill('');
    }
    
    // 初始化每题得分记录
    this.questionScores = new Array(this.questions.length).fill(0);
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
        Text('趣味填词')
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

      if (this.showFinalScore) {
        // 显示最终得分页面
        this.FinalScoreView()
      } else {
        // 显示题目页面
        this.QuizView()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.chinese_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  QuizView() {
    Column() {
      // 诗人信息
      Row() {
        // 诗人画像
        Image($r(`entry.media.${this.poet.imageResource}`))
          .width(50)
          .height(50)
          .borderRadius(25)
          .margin({ right: 10 })
        
        Column() {
          Text(this.poet.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .alignSelf(ItemAlign.Start)
          
          Text(`${this.poet.dynasty}诗人`)
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .alignSelf(ItemAlign.Start)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        
        // 当前得分
        Column() {
          Text('得分')
            .fontSize(12)
            .fontColor($r('app.color.text_secondary'))
          
          Text(`${this.score}`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
        }
        .width(60)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor($r('app.color.card_background'))
      .borderRadius(10)
      .margin({ left: 20, right: 20, top: 10 })

      // 题目进度
      Text(`第 ${this.currentQuestionIndex + 1} 题 / 共 ${this.questions.length} 题`)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({ top: 10 })

      // 题目内容
      Column() {
        Text(this.questions[this.currentQuestionIndex].title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
        
        Text(this.questions[this.currentQuestionIndex].author)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({ top: 5 })
        
        // 诗歌内容（带填空）
        this.renderPoemWithBlanks()
      }
      .width('100%')
      .padding(20)
      .layoutWeight(1)

      // 答题按钮
      if (!this.showResult) {
        Button('提交答案')
          .width('80%')
          .height(50)
          .fontSize(18)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .margin({ bottom: 80 })
          .onClick(() => {
            this.checkAnswer();
          })
      } else {
        Column() {
          Text(this.isCorrect ? '回答正确！' : '回答错误！')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCorrect ? Color.Green : Color.Red)
          
          if (!this.isCorrect) {
            Text(`正确答案：${this.questions[this.currentQuestionIndex].blanks[0].correct}`)
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10 })
          }
          
          // 显示本题得分
          Text(`本题得分: ${this.questionScores[this.currentQuestionIndex]}分`)
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Button(this.currentQuestionIndex < this.questions.length - 1 ? '下一题' : '查看总分')
            .width('80%')
            .height(50)
            .fontSize(18)
            .backgroundColor($r('app.color.card_background'))
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20, bottom: 80 })
            .onClick(() => {
              if (this.currentQuestionIndex < this.questions.length - 1) {
                this.nextQuestion();
              } else {
                // 完成所有题目，显示总分
                this.showFinalScore = true;
              }
            })
        }
      }
    }
  }

  @Builder
  FinalScoreView() {
    Column() {
      Text('游戏结束')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ top: 30, bottom: 20 })
      
      // 诗人信息
      Row() {
        // 诗人画像
        Image($r(`entry.media.${this.poet.imageResource}`))
          .width(60)
          .height(60)
          .borderRadius(30)
          .margin({ right: 15 })
        
        Column() {
          Text(this.poet.name)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .alignSelf(ItemAlign.Start)
          
          Text(`${this.poet.dynasty}诗人`)
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .alignSelf(ItemAlign.Start)
            .margin({ top: 5 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 30 })
      
      // 总得分
      Column() {
        Text('总得分')
          .fontSize(18)
          .fontColor($r('app.color.text_secondary'))
        
        Text(`${this.score}`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 10, bottom: 30 })
        
        // 得分评价
        Text(this.getScoreComment())
          .fontSize(16)
          .fontColor(this.getScoreColor())
          .margin({ bottom: 30 })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      
      // 重新开始和返回按钮
      Row() {
        Button('重新开始')
          .width('40%')
          .height(50)
          .fontSize(16)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .margin({ right: 10 })
          .onClick(() => {
            this.restartQuiz();
          })
        
        Button('返回选择')
          .width('40%')
          .height(50)
          .fontSize(16)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .margin({ left: 10 })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  renderPoemWithBlanks() {
    Column() {
      // 这里简化处理，实际应该根据blanks数组动态生成填空
      Text(this.questions[this.currentQuestionIndex].poem)
        .fontSize(16)
        .fontColor($r('app.color.text_primary'))
        .textAlign(TextAlign.Center)
        .lineHeight(30)
      
      // 选项按钮
      ForEach(this.questions[this.currentQuestionIndex].blanks[0].options, (option: string, index: number) => {
        Button(option)
          .width('80%')
          .height(40)
          .margin({ top: 10 })
          .backgroundColor(
            this.selectedAnswers[0] === option ? 
            $r('app.color.text_primary') : 
            $r('app.color.card_background')
          )
          .fontColor(
            this.selectedAnswers[0] === option ? 
            Color.White : 
            $r('app.color.text_primary')
          )
          .onClick(() => {
            this.selectedAnswers[0] = option;
          })
      })
    }
    .width('100%')
    .padding({ top: 20 })
  }

  checkAnswer() {
    const currentQuestion = this.questions[this.currentQuestionIndex];
    this.isCorrect = this.selectedAnswers[0] === currentQuestion.blanks[0].correct;
    
    // 计算本题得分（根据难度和是否正确）
    let questionScore = 0;
    if (this.isCorrect) {
      // 正确得分：简单题10分，中等题20分，困难题30分
      questionScore = currentQuestion.difficulty * 10;
    }
    
    // 更新得分记录
    this.questionScores[this.currentQuestionIndex] = questionScore;
    
    // 更新总得分
    this.score += questionScore;
    
    this.showResult = true;
  }

  nextQuestion() {
    if (this.currentQuestionIndex < this.questions.length - 1) {
      this.currentQuestionIndex++;
      this.selectedAnswers = new Array(this.questions[this.currentQuestionIndex].blanks.length).fill('');
      this.showResult = false;
    }
  }

  restartQuiz() {
    // 重置所有状态
    this.currentQuestionIndex = 0;
    this.selectedAnswers = new Array(this.questions[0].blanks.length).fill('');
    this.showResult = false;
    this.isCorrect = false;
    this.score = 0;
    this.questionScores = new Array(this.questions.length).fill(0);
    this.showFinalScore = false;
  }

  getScoreComment(): string {
    const percentage = this.questions.length > 0 ? (this.score / (this.questions.length * 30)) * 100 : 0;
    if (percentage >= 90) {
      return '太棒了！诗词大师！';
    } else if (percentage >= 70) {
      return '很不错！继续加油！';
    } else if (percentage >= 50) {
      return '还可以哦，再努力一点！';
    } else {
      return '要多读诗书哦！';
    }
  }

  getScoreColor(): ResourceColor {
    const percentage = this.questions.length > 0 ? (this.score / (this.questions.length * 30)) * 100 : 0;
    if (percentage >= 90) {
      return Color.Green;
    } else if (percentage >= 70) {
      return Color.Blue;
    } else if (percentage >= 50) {
      return Color.Orange;
    } else {
      return Color.Red;
    }
  }
}