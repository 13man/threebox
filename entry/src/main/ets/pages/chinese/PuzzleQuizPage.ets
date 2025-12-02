import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { TextReader, ReadStateCode } from '@kit.SpeechKit';

// 字块接口
interface CharBlock {
  char: string;
  correctIndex: number;  // 正确的位置索引
  currentIndex: number;  // 当前位置索引
  id: string;
}

// 拼图诗句接口
interface PuzzlePoem {
  id: number;
  title: string;
  author: string;
  line: string;  // 7言诗句
}

@Entry
@Component
struct PuzzleQuizPage {
  @State currentPoem: PuzzlePoem | null = null;
  @State charBlocks: CharBlock[] = [];
  @State slotBlocks: (CharBlock | null)[] = [];  // 槽位数组
  @State draggedBlock: CharBlock | null = null;
  @State isCompleted: boolean = false;
  @State score: number = 0;
  @State level: number = 1;
  @State isReading: boolean = false;
  @State wrongAttempts: number = 0; // 错误尝试次数
  
  // 诗句库（200条经典诗句）
  private poemDatabase: PuzzlePoem[] = [
    // 李白诗句
    { id: 1, title: '静夜思', author: '李白', line: '床前明月光' },
    { id: 2, title: '静夜思', author: '李白', line: '疑是地上霜' },
    { id: 3, title: '静夜思', author: '李白', line: '举头望明月' },
    { id: 4, title: '静夜思', author: '李白', line: '低头思故乡' },
    { id: 5, title: '望庐山瀑布', author: '李白', line: '日照香炉生紫烟' },
    { id: 6, title: '望庐山瀑布', author: '李白', line: '遥看瀑布挂前川' },
    { id: 7, title: '望庐山瀑布', author: '李白', line: '飞流直下三千尺' },
    { id: 8, title: '望庐山瀑布', author: '李白', line: '疑是银河落九天' },
    { id: 9, title: '早发白帝城', author: '李白', line: '朝辞白帝彩云间' },
    { id: 10, title: '早发白帝城', author: '李白', line: '千里江陵一日还' },
    { id: 11, title: '早发白帝城', author: '李白', line: '两岸猿声啼不住' },
    { id: 12, title: '早发白帝城', author: '李白', line: '轻舟已过万重山' },
    { id: 13, title: '赠汪伦', author: '李白', line: '李白乘舟将欲行' },
    { id: 14, title: '赠汪伦', author: '李白', line: '忽闻岸上踏歌声' },
    { id: 15, title: '赠汪伦', author: '李白', line: '桃花潭水深千尺' },
    { id: 16, title: '赠汪伦', author: '李白', line: '不及汪伦送我情' },
    { id: 17, title: '黄鹤楼送孟浩然', author: '李白', line: '故人西辞黄鹤楼' },
    { id: 18, title: '黄鹤楼送孟浩然', author: '李白', line: '烟花三月下扬州' },
    { id: 19, title: '黄鹤楼送孟浩然', author: '李白', line: '孤帆远影碧空尽' },
    { id: 20, title: '黄鹤楼送孟浩然', author: '李白', line: '唯见长江天际流' },
    
    // 杜甫诗句
    { id: 21, title: '春夜喜雨', author: '杜甫', line: '好雨知时节' },
    { id: 22, title: '春夜喜雨', author: '杜甫', line: '当春乃发生' },
    { id: 23, title: '春夜喜雨', author: '杜甫', line: '随风潜入夜' },
    { id: 24, title: '春夜喜雨', author: '杜甫', line: '润物细无声' },
    { id: 25, title: '绝句', author: '杜甫', line: '两个黄鹂鸣翠柳' },
    { id: 26, title: '绝句', author: '杜甫', line: '一行白鹭上青天' },
    { id: 27, title: '绝句', author: '杜甫', line: '窗含西岭千秋雪' },
    { id: 28, title: '绝句', author: '杜甫', line: '门泊东吴万里船' },
    { id: 29, title: '江畔独步寻花', author: '杜甫', line: '黄四娘家花满蹊' },
    { id: 30, title: '江畔独步寻花', author: '杜甫', line: '千朵万朵压枝低' },
    { id: 31, title: '江畔独步寻花', author: '杜甫', line: '留连戏蝶时时舞' },
    { id: 32, title: '江畔独步寻花', author: '杜甫', line: '自在娇莺恰恰啼' },
    
    // 王之涣诗句
    { id: 33, title: '登鹳雀楼', author: '王之涣', line: '白日依山尽' },
    { id: 34, title: '登鹳雀楼', author: '王之涣', line: '黄河入海流' },
    { id: 35, title: '登鹳雀楼', author: '王之涣', line: '欲穷千里目' },
    { id: 36, title: '登鹳雀楼', author: '王之涣', line: '更上一层楼' },
    { id: 37, title: '凉州词', author: '王之涣', line: '黄河远上白云间' },
    { id: 38, title: '凉州词', author: '王之涣', line: '一片孤城万仞山' },
    { id: 39, title: '凉州词', author: '王之涣', line: '羌笛何须怨杨柳' },
    { id: 40, title: '凉州词', author: '王之涣', line: '春风不度玉门关' },
    
    // 孟浩然诗句
    { id: 41, title: '春晓', author: '孟浩然', line: '春眠不觉晓' },
    { id: 42, title: '春晓', author: '孟浩然', line: '处处闻啼鸟' },
    { id: 43, title: '春晓', author: '孟浩然', line: '夜来风雨声' },
    { id: 44, title: '春晓', author: '孟浩然', line: '花落知多少' },
    { id: 45, title: '宿建德江', author: '孟浩然', line: '移舟泊烟渚' },
    { id: 46, title: '宿建德江', author: '孟浩然', line: '日暮客愁新' },
    { id: 47, title: '宿建德江', author: '孟浩然', line: '野旷天低树' },
    { id: 48, title: '宿建德江', author: '孟浩然', line: '江清月近人' },
    
    // 王维诗句
    { id: 49, title: '九月九日忆山东兄弟', author: '王维', line: '独在异乡为异客' },
    { id: 50, title: '九月九日忆山东兄弟', author: '王维', line: '每逢佳节倍思亲' },
    { id: 51, title: '九月九日忆山东兄弟', author: '王维', line: '遥知兄弟登高处' },
    { id: 52, title: '九月九日忆山东兄弟', author: '王维', line: '遍插茱萸少一人' },
    { id: 53, title: '鹿柴', author: '王维', line: '空山不见人' },
    { id: 54, title: '鹿柴', author: '王维', line: '但闻人语响' },
    { id: 55, title: '鹿柴', author: '王维', line: '返景入深林' },
    { id: 56, title: '鹿柴', author: '王维', line: '复照青苔上' },
    { id: 57, title: '竹里馆', author: '王维', line: '独坐幽篁里' },
    { id: 58, title: '竹里馆', author: '王维', line: '弹琴复长啸' },
    { id: 59, title: '竹里馆', author: '王维', line: '深林人不知' },
    { id: 60, title: '竹里馆', author: '王维', line: '明月来相照' },
    
    // 白居易诗句
    { id: 61, title: '赋得古原草送别', author: '白居易', line: '离离原上草' },
    { id: 62, title: '赋得古原草送别', author: '白居易', line: '一岁一枯荣' },
    { id: 63, title: '赋得古原草送别', author: '白居易', line: '野火烧不尽' },
    { id: 64, title: '赋得古原草送别', author: '白居易', line: '春风吹又生' },
    { id: 65, title: '忆江南', author: '白居易', line: '江南好' },
    { id: 66, title: '忆江南', author: '白居易', line: '风景旧曾谙' },
    { id: 67, title: '忆江南', author: '白居易', line: '日出江花红胜火' },
    { id: 68, title: '忆江南', author: '白居易', line: '春来江水绿如蓝' },
    { id: 69, title: '池上', author: '白居易', line: '小娃撑小艇' },
    { id: 70, title: '池上', author: '白居易', line: '偷采白莲回' },
    { id: 71, title: '池上', author: '白居易', line: '不解藏踪迹' },
    { id: 72, title: '池上', author: '白居易', line: '浮萍一道开' },
    
    // 杜牧诗句
    { id: 73, title: '清明', author: '杜牧', line: '清明时节雨纷纷' },
    { id: 74, title: '清明', author: '杜牧', line: '路上行人欲断魂' },
    { id: 75, title: '清明', author: '杜牧', line: '借问酒家何处有' },
    { id: 76, title: '清明', author: '杜牧', line: '牧童遥指杏花村' },
    { id: 77, title: '山行', author: '杜牧', line: '远上寒山石径斜' },
    { id: 78, title: '山行', author: '杜牧', line: '白云深处有人家' },
    { id: 79, title: '山行', author: '杜牧', line: '停车坐爱枫林晚' },
    { id: 80, title: '山行', author: '杜牧', line: '霜叶红于二月花' },
    
    // 贺知章诗句
    { id: 81, title: '咏柳', author: '贺知章', line: '碧玉妆成一树高' },
    { id: 82, title: '咏柳', author: '贺知章', line: '万条垂下绿丝绦' },
    { id: 83, title: '咏柳', author: '贺知章', line: '不知细叶谁裁出' },
    { id: 84, title: '咏柳', author: '贺知章', line: '二月春风似剪刀' },
    { id: 85, title: '回乡偶书', author: '贺知章', line: '少小离家老大回' },
    { id: 86, title: '回乡偶书', author: '贺知章', line: '乡音无改鬓毛衰' },
    { id: 87, title: '回乡偶书', author: '贺知章', line: '儿童相见不相识' },
    { id: 88, title: '回乡偶书', author: '贺知章', line: '笑问客从何处来' },
    
    // 骆宾王诗句
    { id: 89, title: '咏鹅', author: '骆宾王', line: '鹅鹅鹅' },
    { id: 90, title: '咏鹅', author: '骆宾王', line: '曲项向天歌' },
    { id: 91, title: '咏鹅', author: '骆宾王', line: '白毛浮绿水' },
    { id: 92, title: '咏鹅', author: '骆宾王', line: '红掌拨清波' },
    
    // 李绅诗句
    { id: 93, title: '悯农', author: '李绅', line: '锄禾日当午' },
    { id: 94, title: '悯农', author: '李绅', line: '汗滴禾下土' },
    { id: 95, title: '悯农', author: '李绅', line: '谁知盘中餐' },
    { id: 96, title: '悯农', author: '李绅', line: '粒粒皆辛苦' },
    { id: 97, title: '悯农', author: '李绅', line: '春种一粒粟' },
    { id: 98, title: '悯农', author: '李绅', line: '秋收万颗子' },
    { id: 99, title: '悯农', author: '李绅', line: '四海无闲田' },
    { id: 100, title: '悯农', author: '李绅', line: '农夫犹饿死' },
    
    // 王昌龄诗句
    { id: 101, title: '出塞', author: '王昌龄', line: '秦时明月汉时关' },
    { id: 102, title: '出塞', author: '王昌龄', line: '万里长征人未还' },
    { id: 103, title: '出塞', author: '王昌龄', line: '但使龙城飞将在' },
    { id: 104, title: '出塞', author: '王昌龄', line: '不教胡马度阴山' },
    { id: 105, title: '芙蓉楼送辛渐', author: '王昌龄', line: '寒雨连江夜入吴' },
    { id: 106, title: '芙蓉楼送辛渐', author: '王昌龄', line: '平明送客楚山孤' },
    { id: 107, title: '芙蓉楼送辛渐', author: '王昌龄', line: '洛阳亲友如相问' },
    { id: 108, title: '芙蓉楼送辛渐', author: '王昌龄', line: '一片冰心在玉壶' },
    
    // 柳宗元诗句
    { id: 109, title: '江雪', author: '柳宗元', line: '千山鸟飞绝' },
    { id: 110, title: '江雪', author: '柳宗元', line: '万径人踪灭' },
    { id: 111, title: '江雪', author: '柳宗元', line: '孤舟蓑笠翁' },
    { id: 112, title: '江雪', author: '柳宗元', line: '独钓寒江雪' },
    
    // 刘禹锡诗句
    { id: 113, title: '竹枝词', author: '刘禹锡', line: '杨柳青青江水平' },
    { id: 114, title: '竹枝词', author: '刘禹锡', line: '闻郎江上踏歌声' },
    { id: 115, title: '竹枝词', author: '刘禹锡', line: '东边日出西边雨' },
    { id: 116, title: '竹枝词', author: '刘禹锡', line: '道是无晴却有晴' },
    { id: 117, title: '浪淘沙', author: '刘禹锡', line: '九曲黄河万里沙' },
    { id: 118, title: '浪淘沙', author: '刘禹锡', line: '浪淘风簸自天涯' },
    { id: 119, title: '浪淘沙', author: '刘禹锡', line: '如今直上银河去' },
    { id: 120, title: '浪淘沙', author: '刘禹锡', line: '同到牵牛织女家' },
    
    // 张继诗句
    { id: 121, title: '枫桥夜泊', author: '张继', line: '月落乌啼霜满天' },
    { id: 122, title: '枫桥夜泊', author: '张继', line: '江枫渔火对愁眠' },
    { id: 123, title: '枫桥夜泊', author: '张继', line: '姑苏城外寒山寺' },
    { id: 124, title: '枫桥夜泊', author: '张继', line: '夜半钟声到客船' },
    
    // 高适诗句
    { id: 125, title: '别董大', author: '高适', line: '千里黄云白日曛' },
    { id: 126, title: '别董大', author: '高适', line: '北风吹雁雪纷纷' },
    { id: 127, title: '别董大', author: '高适', line: '莫愁前路无知己' },
    { id: 128, title: '别董大', author: '高适', line: '天下谁人不识君' },
    
    // 韩愈诗句
    { id: 129, title: '早春呈水部张十八员外', author: '韩愈', line: '天街小雨润如酥' },
    { id: 130, title: '早春呈水部张十八员外', author: '韩愈', line: '草色遥看近却无' },
    { id: 131, title: '早春呈水部张十八员外', author: '韩愈', line: '最是一年春好处' },
    { id: 132, title: '早春呈水部张十八员外', author: '韩愈', line: '绝胜烟柳满皇都' },
    
    // 卢纶诗句
    { id: 133, title: '塞下曲', author: '卢纶', line: '月黑雁飞高' },
    { id: 134, title: '塞下曲', author: '卢纶', line: '单于夜遁逃' },
    { id: 135, title: '塞下曲', author: '卢纶', line: '欲将轻骑逐' },
    { id: 136, title: '塞下曲', author: '卢纶', line: '大雪满弓刀' },
    { id: 137, title: '塞下曲', author: '卢纶', line: '林暗草惊风' },
    { id: 138, title: '塞下曲', author: '卢纶', line: '将军夜引弓' },
    { id: 139, title: '塞下曲', author: '卢纶', line: '平明寻白羽' },
    { id: 140, title: '塞下曲', author: '卢纶', line: '没在石棱中' },
    
    // 孟郊诗句
    { id: 141, title: '游子吟', author: '孟郊', line: '慈母手中线' },
    { id: 142, title: '游子吟', author: '孟郊', line: '游子身上衣' },
    { id: 143, title: '游子吟', author: '孟郊', line: '临行密密缝' },
    { id: 144, title: '游子吟', author: '孟郊', line: '意恐迟迟归' },
    { id: 145, title: '游子吟', author: '孟郊', line: '谁言寸草心' },
    { id: 146, title: '游子吟', author: '孟郊', line: '报得三春晖' },
    
    // 张志和诗句
    { id: 147, title: '渔歌子', author: '张志和', line: '西塞山前白鹭飞' },
    { id: 148, title: '渔歌子', author: '张志和', line: '桃花流水鳜鱼肥' },
    { id: 149, title: '渔歌子', author: '张志和', line: '青箬笠' },
    { id: 150, title: '渔歌子', author: '张志和', line: '绿蓑衣' },
    { id: 151, title: '渔歌子', author: '张志和', line: '斜风细雨不须归' },
    
    // 王勃诗句
    { id: 152, title: '送杜少府之任蜀州', author: '王勃', line: '城阙辅三秦' },
    { id: 153, title: '送杜少府之任蜀州', author: '王勃', line: '风烟望五津' },
    { id: 154, title: '送杜少府之任蜀州', author: '王勃', line: '与君离别意' },
    { id: 155, title: '送杜少府之任蜀州', author: '王勃', line: '同是宦游人' },
    { id: 156, title: '送杜少府之任蜀州', author: '王勃', line: '海内存知己' },
    { id: 157, title: '送杜少府之任蜀州', author: '王勃', line: '天涯若比邻' },
    
    // 宋之问诗句
    { id: 158, title: '渡汉江', author: '宋之问', line: '岭外音书断' },
    { id: 159, title: '渡汉江', author: '宋之问', line: '经冬复历春' },
    { id: 160, title: '渡汉江', author: '宋之问', line: '近乡情更怯' },
    { id: 161, title: '渡汉江', author: '宋之问', line: '不敢问来人' },
    
    // 崔颢诗句
    { id: 162, title: '黄鹤楼', author: '崔颢', line: '昔人已乘黄鹤去' },
    { id: 163, title: '黄鹤楼', author: '崔颢', line: '此地空余黄鹤楼' },
    { id: 164, title: '黄鹤楼', author: '崔颢', line: '黄鹤一去不复返' },
    { id: 165, title: '黄鹤楼', author: '崔颢', line: '白云千载空悠悠' },
    
    // 李商隐诗句
    { id: 166, title: '夜雨寄北', author: '李商隐', line: '君问归期未有期' },
    { id: 167, title: '夜雨寄北', author: '李商隐', line: '巴山夜雨涨秋池' },
    { id: 168, title: '夜雨寄北', author: '李商隐', line: '何当共剪西窗烛' },
    { id: 169, title: '夜雨寄北', author: '李商隐', line: '却话巴山夜雨时' },
    { id: 170, title: '登乐游原', author: '李商隐', line: '向晚意不适' },
    { id: 171, title: '登乐游原', author: '李商隐', line: '驱车登古原' },
    { id: 172, title: '登乐游原', author: '李商隐', line: '夕阳无限好' },
    { id: 173, title: '登乐游原', author: '李商隐', line: '只是近黄昏' },
    
    // 温庭筠诗句
    { id: 174, title: '商山早行', author: '温庭筠', line: '晨起动征铎' },
    { id: 175, title: '商山早行', author: '温庭筠', line: '客行悲故乡' },
    { id: 176, title: '商山早行', author: '温庭筠', line: '鸡声茅店月' },
    { id: 177, title: '商山早行', author: '温庭筠', line: '人迹板桥霜' },
    
    // 郑燮诗句
    { id: 178, title: '竹石', author: '郑燮', line: '咬定青山不放松' },
    { id: 179, title: '竹石', author: '郑燮', line: '立根原在破岩中' },
    { id: 180, title: '竹石', author: '郑燮', line: '千磨万击还坚劲' },
    { id: 181, title: '竹石', author: '郑燮', line: '任尔东西南北风' },
    
    // 袁枚诗句
    { id: 182, title: '所见', author: '袁枚', line: '牧童骑黄牛' },
    { id: 183, title: '所见', author: '袁枚', line: '歌声振林樾' },
    { id: 184, title: '所见', author: '袁枚', line: '意欲捕鸣蝉' },
    { id: 185, title: '所见', author: '袁枚', line: '忽然闭口立' },
    
    // 龚自珍诗句
    { id: 186, title: '己亥杂诗', author: '龚自珍', line: '九州生气恃风雷' },
    { id: 187, title: '己亥杂诗', author: '龚自珍', line: '万马齐喑究可哀' },
    { id: 188, title: '己亥杂诗', author: '龚自珍', line: '我劝天公重抖擞' },
    { id: 189, title: '己亥杂诗', author: '龚自珍', line: '不拘一格降人才' },
    { id: 190, title: '己亥杂诗', author: '龚自珍', line: '浩荡离愁白日斜' },
    { id: 191, title: '己亥杂诗', author: '龚自珍', line: '吟鞭东指即天涯' },
    { id: 192, title: '己亥杂诗', author: '龚自珍', line: '落红不是无情物' },
    { id: 193, title: '己亥杂诗', author: '龚自珍', line: '化作春泥更护花' },
    
    // 于谦诗句
    { id: 194, title: '石灰吟', author: '于谦', line: '千锤万凿出深山' },
    { id: 195, title: '石灰吟', author: '于谦', line: '烈火焚烧若等闲' },
    { id: 196, title: '石灰吟', author: '于谦', line: '粉骨碎身全不怕' },
    { id: 197, title: '石灰吟', author: '于谦', line: '要留清白在人间' },
    
    // 郑思肖诗句
    { id: 198, title: '画菊', author: '郑思肖', line: '花开不并百花丛' },
    { id: 199, title: '画菊', author: '郑思肖', line: '独立疏篱趣未穷' },
    { id: 200, title: '画菊', author: '郑思肖', line: '宁可枝头抱香死' }
  ];
  
  aboutToAppear(): void {
    this.initTextReader();
    this.loadNewPuzzle();
  }
  
  aboutToDisappear(): void {
    try {
      TextReader.stop();
      TextReader.release();
    } catch (error) {
      console.error('释放TextReader失败:', error);
    }
  }
  
  // 初始化TextReader
  private async initTextReader(): Promise<void> {
    try {
      const businessBrandInfo: TextReader.BusinessBrandInfo = { 
        panelName: '拼图朗读'
      };
      
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: false,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: false
      };

      await TextReader.init(getContext(this), readerParam);
      console.log('TextReader初始化成功');
    } catch (error) {
      console.error('TextReader初始化失败:', error);
    }
  }
  
  // 加载新拼图
  private loadNewPuzzle(): void {
    const randomIndex = Math.floor(Math.random() * this.poemDatabase.length);
    this.currentPoem = this.poemDatabase[randomIndex];
    this.wrongAttempts = 0; // 重置错误次数
    
    this.resetCurrentPuzzle();
  }
  
  // 重置当前拼图（不更换题目）
  private resetCurrentPuzzle(): void {
    if (!this.currentPoem) return;
    
    // 创建字块，显式声明类型
    const chars = this.currentPoem.line.split('');
    this.charBlocks = chars.map((char, index): CharBlock => {
      return {
        char: char,
        correctIndex: index,
        currentIndex: -1,
        id: `char_${index}_${Date.now()}`
      };
    });
    
    // 打乱字块顺序
    this.shuffleArray(this.charBlocks);
    
    // 初始化槽位（全空）
    this.slotBlocks = new Array(chars.length).fill(null);
    
    this.isCompleted = false;

  }
  
  // 打乱数组（Fisher-Yates洗牌算法）
  private shuffleArray(array: CharBlock[]): void {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      // 避免解构赋值，使用临时变量
      const temp = array[i];
      array[i] = array[j];
      array[j] = temp;
    }
  }
  
  // 检查是否完成
  private checkCompletion(): void {
    if (this.slotBlocks.every(block => block !== null)) {
      const isCorrect = this.slotBlocks.every((block, index) => 
        block!.correctIndex === index
      );
      
      if (isCorrect) {
        this.isCompleted = true;
        this.wrongAttempts = 0; // 重置错误次数
        this.score += 10;
        promptAction.showToast({ message: '🎉 拼对了！' });
        
        // 朗读诗句
        setTimeout(() => {
          this.readPoem();
        }, 500);
      } else {
        // 拼错了，增加错误次数
        this.wrongAttempts++;
        console.log('[PuzzleQuiz] 错误次数:', this.wrongAttempts);
        
        if (this.wrongAttempts === 1) {
          promptAction.showToast({ 
            message: '❌ 哎呀，顺序不对哦~再想想！',
            duration: 2000
          });
        } else if (this.wrongAttempts === 2) {
          promptAction.showToast({ 
            message: '❌ 还是不对呢，这次在错的话就给你看答案哈？🤔',
            duration: 2000
          });
        } else if (this.wrongAttempts >= 3) {
          // 第3次错误，给出答案提示（俏皮版）
          if (this.currentPoem) {
            const correctAnswer = this.currentPoem.line;
            promptAction.showToast({ 
              message: `💡 别灰心！答案是：「${correctAnswer}」\n看看能不能拼出来呀~ 加油！💪`,
              duration: 4000
            });
          }
        }
      }
    }
  }
  
  // 朗读诗句
  private async readPoem(): Promise<void> {
    if (!this.currentPoem) return;
    
    try {
      const readInfo: TextReader.ReadInfo = {
        id: `puzzle_${this.currentPoem.id}`,
        title: {
          text: this.currentPoem.title,
          isClickable: false
        },
        bodyInfo: this.currentPoem.line
      };
      
      await TextReader.start([readInfo]);
      this.isReading = true;
      
      // 监听朗读完成
      setTimeout(() => {
        this.isReading = false;
      }, 3000);
    } catch (error) {
      console.error('朗读失败:', error);
    }
  }
  
  build() {
    Column() {
      // 标题栏
      Row() {
        Image($r('sys.symbol.chevron_left'))
          .width(24)
          .height(24)
          .fillColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back();
          })
        
        Text('🧩 残句拼图')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Column() {
          Text(`${this.level}/${this.poemDatabase.length}`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ bottom: 2 })
          Text(`${this.score}分`)
            .fontSize(12)
            .fontColor($r('app.color.accent_positive'))
        }
        .alignItems(HorizontalAlign.End)
        .width(60)
      }
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .backgroundColor($r('app.color.card_background'))
      
      Scroll() {
        Column() {
          // 诗词信息卡片
          if (this.currentPoem) {
            Column() {
              Text(this.currentPoem.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 4 })
              
              Text(`【${this.currentPoem.author}】`)
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
            }
            .width('100%')
            .padding(16)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(12)
            .margin({ top: 16, bottom: 16 })
          }
          
          // 拼图槽位区域
          Column() {
            Text('👆 点击上方槽位放置字块，再点击可退字')
              .fontSize(14)
              .fontColor($r('app.color.text_tertiary'))
              .margin({ bottom: 12 })
            
            this.SlotArea()
          }
          .width('100%')
          .padding(20)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(16)
          .margin({ bottom: 24 })
          
          // 字块区域
          Column() {
            Text('👇 点击字块选中，然后点击上方槽位放置')
              .fontSize(14)
              .fontColor($r('app.color.text_tertiary'))
              .margin({ bottom: 12 })
            
            this.CharBlockArea()
          }
          .width('100%')
          .padding(20)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(16)
          
          // 操作按钮
          Row() {
            Button('🔄 重新开始')
              .width('48%')
              .height(50)
              .fontSize(16)
              .backgroundColor($r('app.color.card_background'))
              .fontColor($r('app.color.text_primary'))
              .borderRadius(25)
              .onClick(() => {
                this.resetCurrentPuzzle(); // 重置当前题目
              })
            
            Button('➡️ 下一题')
              .width('48%')
              .height(50)
              .fontSize(16)
              .backgroundColor($r('app.color.accent_positive'))
              .fontColor('#FFFFFF')
              .borderRadius(25)
              .enabled(this.isCompleted)
              .opacity(this.isCompleted ? 1 : 0.5)
              .onClick(() => {
                this.level++;
                this.loadNewPuzzle();
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 24, bottom: 24 })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
  
  @Builder
  SlotArea() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
      ForEach(this.slotBlocks, (block: CharBlock | null, index: number) => {
        Column() {
          if (block) {
            Text(block.char)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isCompleted ? '#4CAF50' : $r('app.color.text_primary'))
          } else {
            Text('__')
              .fontSize(28)
              .fontColor($r('app.color.text_tertiary'))
              .opacity(0.3)
          }
        }
        .width(50)
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(block ? '#E8F5E9' : $r('app.color.page_background'))
        .borderRadius(8)
        .border({ 
          width: 2, 
          color: this.isCompleted ? '#4CAF50' : $r('app.color.text_tertiary'),
          style: BorderStyle.Dashed
        })
        .margin(4)
        .onClick(() => {
          console.log('[PuzzleQuiz] 点击槽位', index, ', 当前字块:', block?.char, ', 选中的:', this.draggedBlock?.char);
          
          // 如果有选中的字块，放置到这个槽位
          if (this.draggedBlock && !this.isCompleted) {
            // 如果槽位已有字块，将其移回字块区
            if (block) {
              console.log('[PuzzleQuiz] 槽位已有字块:', block.char, '，移回字块区');
              block.currentIndex = -1;
              this.charBlocks.push(block);
            }
            
            // 从字块区移除
            const charIndex = this.charBlocks.findIndex(b => b.id === this.draggedBlock!.id);
            console.log('[PuzzleQuiz] 从字块区移除索引:', charIndex);
            if (charIndex >= 0) {
              this.charBlocks.splice(charIndex, 1);
            }
            
            // 放置到槽位
            console.log('[PuzzleQuiz] 放置字块:', this.draggedBlock.char, '到槽位', index);
            this.slotBlocks[index] = this.draggedBlock;
            this.draggedBlock.currentIndex = index;
            
            // 清空选中状态
            const placedChar = this.draggedBlock.char;
            this.draggedBlock = null;
            
            // 关键：强制刷新数组引用，触发视图更新
            this.slotBlocks = this.slotBlocks.slice();
            this.charBlocks = this.charBlocks.slice();
            
            console.log('[PuzzleQuiz] 当前槽位状态:', this.slotBlocks.map(b => b?.char || '_'));
            console.log('[PuzzleQuiz] 剩余字块:', this.charBlocks.map(b => b.char));
            
            promptAction.showToast({ message: `✅ 已放置“${placedChar}”` });
            
            // 检查是否完成
            setTimeout(() => {
              this.checkCompletion();
            }, 100);
          }
          // 如果没有选中的字块，但槽位有字，则移除
          else if (block && !this.isCompleted) {
            console.log('[PuzzleQuiz] 移除槽位字块:', block.char);
            const removedBlock = this.slotBlocks[index];
            if (removedBlock) {
              removedBlock.currentIndex = -1;
              this.charBlocks.push(removedBlock);
              this.slotBlocks[index] = null;
              
              // 关键：强制刷新数组引用
              this.slotBlocks = this.slotBlocks.slice();
              this.charBlocks = this.charBlocks.slice();
            }
          }
        })
      }, (block: CharBlock | null, index: number) => `slot_${index}_${block?.id || 'empty'}`)
    }
  }
  
  @Builder
  CharBlockArea() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
      ForEach(this.charBlocks, (block: CharBlock, index: number) => {
        Column() {
          Text(block.char)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
        }
        .width(50)
        .height(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor($r('app.color.song_lyric_card'))
        .borderRadius(8)
        .margin(4)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.2)',
          offsetX: 0,
          offsetY: 2
        })
        .draggable(false)  // 禁用原生拖拽，使用点击方式
        .onClick(() => {
          console.log('[PuzzleQuiz] 点击字块:', block.char);
          // 点击选中字块
          this.draggedBlock = block;
          promptAction.showToast({ message: `已选中“${block.char}”，点击上方槽位放置` });
        })
        .backgroundColor(
          this.draggedBlock?.id === block.id 
            ? '#FF6B35'  // 选中时高亮
            : $r('app.color.song_lyric_card')
        )
      }, (block: CharBlock) => block.id)
    }
  }
}
