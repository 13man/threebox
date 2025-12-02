import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 诗词题目接口
interface InkQuestion {
  id: number;
  poem: string;
  author: string;
  blankIndex: number;
  correctAnswer: string;
  options: string[];
}

// 墨滴粒子接口
interface InkParticle {
  id: number;
  x: number;
  y: number;
  velocityX: number;
  velocityY: number;
  opacity: number;
  size: number;
}

// 100道题库
const INK_QUESTIONS: InkQuestion[] = [
  { id: 1, poem: '床前明月光，疑是地上霜', author: '李白', blankIndex: 4, correctAnswer: '光', options: ['光', '广', '庆', '床'] },
  { id: 2, poem: '春眠不觉晓，处处闻啼鸟', author: '孟浩然', blankIndex: 9, correctAnswer: '啼', options: ['啼', '蹄', '谛', '缔'] },
  { id: 3, poem: '日照香炉生紫烟', author: '李白', blankIndex: 5, correctAnswer: '紫', options: ['紫', '紫', '柴', '紊'] },
  { id: 4, poem: '飞流直下三千尺', author: '李白', blankIndex: 6, correctAnswer: '千', options: ['千', '干', '于', '士'] },
  { id: 5, poem: '两岸猿声啼不住', author: '李白', blankIndex: 5, correctAnswer: '不', options: ['不', '木', '本', '未'] },
  { id: 6, poem: '轻舟已过万重山', author: '李白', blankIndex: 4, correctAnswer: '万', options: ['万', '方', '为', '力'] },
  { id: 7, poem: '孤帆远影碧空尽', author: '李白', blankIndex: 4, correctAnswer: '碧', options: ['碧', '璧', '壁', '臂'] },
  { id: 8, poem: '唯见长江天际流', author: '李白', blankIndex: 2, correctAnswer: '长', options: ['长', '长', '常', '张'] },
  { id: 9, poem: '白日依山尽，黄河入海流', author: '王之涣', blankIndex: 9, correctAnswer: '海', options: ['海', '诲', '悔', '侮'] },
  { id: 10, poem: '欲穷千里目，更上一层楼', author: '王之涣', blankIndex: 10, correctAnswer: '层', options: ['层', '屋', '居', '尺'] },
  { id: 11, poem: '举头望明月，低头思故乡', author: '李白', blankIndex: 9, correctAnswer: '故', options: ['故', '固', '古', '苦'] },
  { id: 12, poem: '春种一粒粟，秋收万颗子', author: '李绅', blankIndex: 7, correctAnswer: '万', options: ['万', '方', '力', '刀'] },
  { id: 13, poem: '谁知盘中餐，粒粒皆辛苦', author: '李绅', blankIndex: 7, correctAnswer: '辛', options: ['辛', '幸', '辞', '新'] },
  { id: 14, poem: '野火烧不尽，春风吹又生', author: '白居易', blankIndex: 9, correctAnswer: '生', options: ['生', '牛', '性', '星'] },
  { id: 15, poem: '远芳侵古道，晴翠接荒城', author: '白居易', blankIndex: 6, correctAnswer: '翠', options: ['翠', '碎', '脆', '粹'] },
  { id: 16, poem: '红豆生南国，春来发几枝', author: '王维', blankIndex: 7, correctAnswer: '几', options: ['几', '儿', '凡', '风'] },
  { id: 17, poem: '劝君更尽一杯酒', author: '王维', blankIndex: 5, correctAnswer: '一', options: ['一', '二', '三', '丁'] },
  { id: 18, poem: '西出阳关无故人', author: '王维', blankIndex: 4, correctAnswer: '无', options: ['无', '天', '元', '五'] },
  { id: 19, poem: '独在异乡为异客', author: '王维', blankIndex: 5, correctAnswer: '异', options: ['异', '导', '导', '界'] },
  { id: 20, poem: '每逢佳节倍思亲', author: '王维', blankIndex: 4, correctAnswer: '倍', options: ['倍', '培', '陪', '赔'] },
  { id: 21, poem: '桃花潭水深千尺', author: '李白', blankIndex: 4, correctAnswer: '深', options: ['深', '探', '琛', '棕'] },
  { id: 22, poem: '不及汪伦送我情', author: '李白', blankIndex: 5, correctAnswer: '我', options: ['我', '找', '戈', '成'] },
  { id: 23, poem: '朝辞白帝彩云间', author: '李白', blankIndex: 4, correctAnswer: '彩', options: ['彩', '影', '彰', '须'] },
  { id: 24, poem: '千里江陵一日还', author: '李白', blankIndex: 5, correctAnswer: '一', options: ['一', '二', '丁', '干'] },
  { id: 25, poem: '春风又绿江南岸', author: '王安石', blankIndex: 3, correctAnswer: '绿', options: ['绿', '录', '渌', '绿'] },
  { id: 26, poem: '明月何时照我还', author: '王安石', blankIndex: 5, correctAnswer: '我', options: ['我', '找', '或', '戈'] },
  { id: 27, poem: '月落乌啼霜满天', author: '张继', blankIndex: 4, correctAnswer: '霜', options: ['霜', '霸', '雪', '露'] },
  { id: 28, poem: '江枫渔火对愁眠', author: '张继', blankIndex: 4, correctAnswer: '愁', options: ['愁', '秋', '鳅', '揪'] },
  { id: 29, poem: '姑苏城外寒山寺', author: '张继', blankIndex: 4, correctAnswer: '寒', options: ['寒', '塞', '害', '宴'] },
  { id: 30, poem: '夜半钟声到客船', author: '张继', blankIndex: 5, correctAnswer: '客', options: ['客', '容', '宫', '宿'] },
  { id: 31, poem: '洛阳亲友如相问', author: '王昌龄', blankIndex: 4, correctAnswer: '如', options: ['如', '好', '妇', '知'] },
  { id: 32, poem: '一片冰心在玉壶', author: '王昌龄', blankIndex: 3, correctAnswer: '冰', options: ['冰', '水', '永', '冷'] },
  { id: 33, poem: '秦时明月汉时关', author: '王昌龄', blankIndex: 5, correctAnswer: '汉', options: ['汉', '汗', '旱', '汉'] },
  { id: 34, poem: '万里长征人未还', author: '王昌龄', blankIndex: 5, correctAnswer: '人', options: ['人', '入', '大', '天'] },
  { id: 35, poem: '黄河远上白云间', author: '王之涣', blankIndex: 4, correctAnswer: '白', options: ['白', '百', '柏', '伯'] },
  { id: 36, poem: '一片孤城万仞山', author: '王之涣', blankIndex: 4, correctAnswer: '万', options: ['万', '方', '力', '刃'] },
  { id: 37, poem: '羌笛何须怨杨柳', author: '王之涣', blankIndex: 4, correctAnswer: '怨', options: ['怨', '怒', '恕', '思'] },
  { id: 38, poem: '春风不度玉门关', author: '王之涣', blankIndex: 3, correctAnswer: '度', options: ['度', '席', '庭', '废'] },
  { id: 39, poem: '葡萄美酒夜光杯', author: '王翰', blankIndex: 4, correctAnswer: '夜', options: ['夜', '液', '夕', '多'] },
  { id: 40, poem: '欲饮琵琶马上催', author: '王翰', blankIndex: 4, correctAnswer: '马', options: ['马', '码', '妈', '蚂'] },
  { id: 41, poem: '醉卧沙场君莫笑', author: '王翰', blankIndex: 4, correctAnswer: '君', options: ['君', '群', '郡', '裙'] },
  { id: 42, poem: '古来征战几人回', author: '王翰', blankIndex: 4, correctAnswer: '几', options: ['几', '凡', '儿', '风'] },
  { id: 43, poem: '商女不知亡国恨', author: '杜牧', blankIndex: 3, correctAnswer: '知', options: ['知', '矢', '智', '和'] },
  { id: 44, poem: '隔江犹唱后庭花', author: '杜牧', blankIndex: 3, correctAnswer: '唱', options: ['唱', '晶', '吧', '喝'] },
  { id: 45, poem: '东风不与周郎便', author: '杜牧', blankIndex: 3, correctAnswer: '与', options: ['与', '写', '兴', '兵'] },
  { id: 46, poem: '铜雀春深锁二乔', author: '杜牧', blankIndex: 3, correctAnswer: '深', options: ['深', '探', '琛', '棕'] },
  { id: 47, poem: '停车坐爱枫林晚', author: '杜牧', blankIndex: 3, correctAnswer: '爱', options: ['爱', '受', '爰', '曼'] },
  { id: 48, poem: '霜叶红于二月花', author: '杜牧', blankIndex: 3, correctAnswer: '于', options: ['于', '干', '千', '子'] },
  { id: 49, poem: '清明时节雨纷纷', author: '杜牧', blankIndex: 4, correctAnswer: '纷', options: ['纷', '分', '芬', '粉'] },
  { id: 50, poem: '路上行人欲断魂', author: '杜牧', blankIndex: 4, correctAnswer: '断', options: ['断', '继', '新', '折'] },
  { id: 51, poem: '借问酒家何处有', author: '杜牧', blankIndex: 3, correctAnswer: '家', options: ['家', '冢', '宾', '宅'] },
  { id: 52, poem: '牧童遥指杏花村', author: '杜牧', blankIndex: 4, correctAnswer: '杏', options: ['杏', '呆', '束', '困'] },
  { id: 53, poem: '千山鸟飞绝', author: '柳宗元', blankIndex: 3, correctAnswer: '绝', options: ['绝', '绞', '纸', '紙'] },
  { id: 54, poem: '万径人踪灭', author: '柳宗元', blankIndex: 3, correctAnswer: '踪', options: ['踪', '综', '踪', '综'] },
  { id: 55, poem: '孤舟蓑笠翁', author: '柳宗元', blankIndex: 3, correctAnswer: '笠', options: ['笠', '苕', '芴', '笞'] },
  { id: 56, poem: '独钓寒江雪', author: '柳宗元', blankIndex: 2, correctAnswer: '钓', options: ['钓', '钩', '钧', '钮'] },
  { id: 57, poem: '天街小雨润如酥', author: '韩愈', blankIndex: 4, correctAnswer: '润', options: ['润', '闰', '酒', '间'] },
  { id: 58, poem: '草色遥看近却无', author: '韩愈', blankIndex: 5, correctAnswer: '却', options: ['却', '脚', '都', '脚'] },
  { id: 59, poem: '最是一年春好处', author: '韩愈', blankIndex: 4, correctAnswer: '春', options: ['春', '舂', '椿', '蠢'] },
  { id: 60, poem: '绝胜烟柳满皇都', author: '韩愈', blankIndex: 3, correctAnswer: '柳', options: ['柳', '抑', '卸', '御'] },
  { id: 61, poem: '黑云翻墨未遮山', author: '苏轼', blankIndex: 4, correctAnswer: '遮', options: ['遮', '蔗', '庶', '遮'] },
  { id: 62, poem: '白雨跳珠乱入船', author: '苏轼', blankIndex: 4, correctAnswer: '乱', options: ['乱', '舌', '孔', '乳'] },
  { id: 63, poem: '卷地风来忽吹散', author: '苏轼', blankIndex: 4, correctAnswer: '吹', options: ['吹', '欢', '炊', '次'] },
  { id: 64, poem: '望湖楼下水如天', author: '苏轼', blankIndex: 4, correctAnswer: '如', options: ['如', '好', '妇', '妥'] },
  { id: 65, poem: '水光潋滟晴方好', author: '苏轼', blankIndex: 5, correctAnswer: '方', options: ['方', '万', '力', '芳'] },
  { id: 66, poem: '山色空濛雨亦奇', author: '苏轼', blankIndex: 5, correctAnswer: '亦', options: ['亦', '赤', '变', '夜'] },
  { id: 67, poem: '欲把西湖比西子', author: '苏轼', blankIndex: 4, correctAnswer: '比', options: ['比', '北', '此', '批'] },
  { id: 68, poem: '淡妆浓抹总相宜', author: '苏轼', blankIndex: 4, correctAnswer: '总', options: ['总', '息', '恿', '怨'] },
  { id: 69, poem: '横看成岭侧成峰', author: '苏轼', blankIndex: 4, correctAnswer: '侧', options: ['侧', '测', '则', '刻'] },
  { id: 70, poem: '远近高低各不同', author: '苏轼', blankIndex: 4, correctAnswer: '各', options: ['各', '名', '合', '客'] },
  { id: 71, poem: '不识庐山真面目', author: '苏轼', blankIndex: 4, correctAnswer: '真', options: ['真', '直', '具', '颠'] },
  { id: 72, poem: '只缘身在此山中', author: '苏轼', blankIndex: 4, correctAnswer: '此', options: ['此', '些', '比', '紫'] },
  { id: 73, poem: '竹外桃花三两枝', author: '苏轼', blankIndex: 4, correctAnswer: '三', options: ['三', '二', '王', '川'] },
  { id: 74, poem: '春江水暖鸭先知', author: '苏轼', blankIndex: 4, correctAnswer: '暖', options: ['暖', '援', '爰', '缓'] },
  { id: 75, poem: '蒌蒿满地芦芽短', author: '苏轼', blankIndex: 4, correctAnswer: '芦', options: ['芦', '芭', '苏', '卢'] },
  { id: 76, poem: '正是河豚欲上时', author: '苏轼', blankIndex: 4, correctAnswer: '欲', options: ['欲', '谷', '浴', '俗'] },
  { id: 77, poem: '梅子金黄杏子肥', author: '范成大', blankIndex: 4, correctAnswer: '杏', options: ['杏', '呆', '束', '查'] },
  { id: 78, poem: '麦花雪白菜花稀', author: '范成大', blankIndex: 4, correctAnswer: '菜', options: ['菜', '采', '彩', '睬'] },
  { id: 79, poem: '日长篱落无人过', author: '范成大', blankIndex: 4, correctAnswer: '无', options: ['无', '天', '元', '五'] },
  { id: 80, poem: '惟有蜻蜓蛱蝶飞', author: '范成大', blankIndex: 2, correctAnswer: '有', options: ['有', '友', '右', '肴'] },
  { id: 81, poem: '儿童散学归来早', author: '高鼎', blankIndex: 4, correctAnswer: '来', options: ['来', '木', '未', '米'] },
  { id: 82, poem: '忙趁东风放纸鸢', author: '高鼎', blankIndex: 5, correctAnswer: '纸', options: ['纸', '低', '氏', '纸'] },
  { id: 83, poem: '篱落疏疏一径深', author: '杨万里', blankIndex: 4, correctAnswer: '一', options: ['一', '二', '丁', '十'] },
  { id: 84, poem: '树头花落未成阴', author: '杨万里', blankIndex: 4, correctAnswer: '未', options: ['未', '末', '朱', '来'] },
  { id: 85, poem: '儿童急走追黄蝶', author: '杨万里', blankIndex: 4, correctAnswer: '黄', options: ['黄', '皇', '横', '贯'] },
  { id: 86, poem: '飞入菜花无处寻', author: '杨万里', blankIndex: 4, correctAnswer: '无', options: ['无', '天', '元', '五'] },
  { id: 87, poem: '泉眼无声惜细流', author: '杨万里', blankIndex: 3, correctAnswer: '声', options: ['声', '生', '牛', '星'] },
  { id: 88, poem: '树阴照水爱晴柔', author: '杨万里', blankIndex: 4, correctAnswer: '晴', options: ['晴', '清', '精', '请'] },
  { id: 89, poem: '小荷才露尖尖角', author: '杨万里', blankIndex: 5, correctAnswer: '尖', options: ['尖', '尤', '小', '少'] },
  { id: 90, poem: '早有蜻蜓立上头', author: '杨万里', blankIndex: 4, correctAnswer: '立', options: ['立', '站', '位', '竖'] },
  { id: 91, poem: '应怜屐齿印苍苔', author: '叶绍翁', blankIndex: 4, correctAnswer: '印', options: ['印', '卬', '抑', '即'] },
  { id: 92, poem: '小扣柴扉久不开', author: '叶绍翁', blankIndex: 4, correctAnswer: '久', options: ['久', '之', '欠', '灭'] },
  { id: 93, poem: '春色满园关不住', author: '叶绍翁', blankIndex: 4, correctAnswer: '关', options: ['关', '天', '丙', '美'] },
  { id: 94, poem: '一枝红杏出墙来', author: '叶绍翁', blankIndex: 4, correctAnswer: '出', options: ['出', '山', '击', '凸'] },
  { id: 95, poem: '胜日寻芳泗水滨', author: '朱熹', blankIndex: 4, correctAnswer: '泗', options: ['泗', '泗', '四', '洒'] },
  { id: 96, poem: '无边光景一时新', author: '朱熹', blankIndex: 4, correctAnswer: '一', options: ['一', '二', '丁', '十'] },
  { id: 97, poem: '等闲识得东风面', author: '朱熹', blankIndex: 3, correctAnswer: '得', options: ['得', '德', '待', '街'] },
  { id: 98, poem: '万紫千红总是春', author: '朱熹', blankIndex: 4, correctAnswer: '总', options: ['总', '息', '恿', '忿'] },
  { id: 99, poem: '碧玉妆成一树高', author: '贺知章', blankIndex: 4, correctAnswer: '一', options: ['一', '二', '丁', '干'] },
  { id: 100, poem: '万条垂下绿丝绦', author: '贺知章', blankIndex: 4, correctAnswer: '绿', options: ['绿', '录', '渌', '禄'] }
];

@Entry
@Component
struct InkWipePage {
  @State currentQuestion: InkQuestion | null = null;
  @State questionIndex: number = 0;
  @State score: number = 0;
  @State inkOpacity: number = 1.0;  // 墨汁不透明度
  @State wipeProgress: number = 0;  // 擦除进度 0-100
  @State selectedAnswer: string = '';
  @State isAnswered: boolean = false;
  @State isCorrect: boolean = false;
  @State particles: InkParticle[] = [];  // 墨滴粒子数组
  @State showParticles: boolean = false;
  @State gameStarted: boolean = false;
  
  private particleTimer: number = -1;
  private nextParticleId: number = 0;

  aboutToAppear(): void {
    this.loadQuestion();
  }

  aboutToDisappear(): void {
    if (this.particleTimer !== -1) {
      clearInterval(this.particleTimer);
    }
  }

  // 加载题目
  private loadQuestion(): void {
    if (this.questionIndex < INK_QUESTIONS.length) {
      this.currentQuestion = INK_QUESTIONS[this.questionIndex];
      this.inkOpacity = 1.0;
      this.wipeProgress = 0;
      this.selectedAnswer = '';
      this.isAnswered = false;
      this.isCorrect = false;
      this.showParticles = false;
      this.particles = [];
      this.gameStarted = false;
    }
  }

  // 处理擦除手势
  private handleSwipe(offsetX: number, offsetY: number): void {
    if (this.isAnswered) return;
    
    this.gameStarted = true;
    
    // 根据擦除动作增加进度
    const swipeAmount = Math.abs(offsetX) + Math.abs(offsetY);
    const progressIncrement = swipeAmount / 2000;  // 调整灵敏度
    
    this.wipeProgress = Math.min(100, this.wipeProgress + progressIncrement);
    this.inkOpacity = Math.max(0, 1 - (this.wipeProgress / 100));
    
    // 当擦除超过40%时触发粒子特效
    if (this.wipeProgress >= 20 && !this.showParticles) {
      this.showParticles = true;
      this.triggerParticleEffect();
    }
  }

  // 触发墨滴粒子特效
  private triggerParticleEffect(): void {
    // 生成多个粒子
    for (let i = 0; i < 20; i++) {
      setTimeout(() => {
        this.createParticle();
      }, i * 50);
    }
    
    // 启动粒子动画更新
    this.particleTimer = setInterval(() => {
      this.updateParticles();
    }, 30);
  }

  // 创建单个粒子
  private createParticle(): void {
    const particle: InkParticle = {
      id: this.nextParticleId++,
      x: Math.random() * 300 + 50,  // 粒子初始x位置
      y: 100,  // 从题目区域开始
      velocityX: (Math.random() - 0.5) * 4,  // 随机水平速度
      velocityY: Math.random() * 2 + 2,  // 向下速度
      opacity: 1.0,
      size: Math.random() * 8 + 4  // 粒子大小
    };
    this.particles.push(particle);
  }

  // 更新粒子位置
  private updateParticles(): void {
    this.particles = this.particles.map((p: InkParticle): InkParticle => {
      const updatedParticle: InkParticle = {
        id: p.id,
        x: p.x + p.velocityX,
        y: p.y + p.velocityY,
        velocityX: p.velocityX,
        velocityY: p.velocityY + 0.2,  // 重力加速度
        opacity: p.opacity - 0.02,  // 逐渐消失
        size: p.size
      };
      return updatedParticle;
    }).filter((p: InkParticle) => p.opacity > 0 && p.y < 600);  // 移除消失的粒子
    
    // 所有粒子消失后停止计时器
    if (this.particles.length === 0 && this.showParticles) {
      clearInterval(this.particleTimer);
      this.particleTimer = -1;
    }
  }

  // 选择答案
  private selectAnswer(answer: string): void {
    if (this.wipeProgress < 20) {
      promptAction.showToast({ message: '💧 请先擦除墨汁，查看完整诗句！', duration: 2000 });
      return;
    }
    
    // 允许继续选择，直到选对为止
    if (this.isCorrect) return;  // 已经答对了，不再允许选择
    
    this.selectedAnswer = answer;
    this.isCorrect = (answer === this.currentQuestion!.correctAnswer);
    
    if (this.isCorrect) {
      this.isAnswered = true;
      this.score += 10;
      promptAction.showToast({ message: '✅ 回答正确！+10分', duration: 1500 });
    } else {
      // 错误时不显示答案，允许继续选择
      promptAction.showToast({ 
        message: '❌ 不对哦，再试试其他选项！', 
        duration: 1500 
      });
      // 等待一下再清空选中状态，让用户看到错误反馈
      setTimeout(() => {
        this.selectedAnswer = '';
      }, 300);
    }
  }

  // 下一题
  private nextQuestion(): void {
    this.questionIndex++;
    if (this.questionIndex < INK_QUESTIONS.length) {
      this.loadQuestion();
    } else {
      // 游戏结束
      promptAction.showDialog({
        title: '🎉 游戏结束',
        message: `恭喜完成所有题目！\n\n总分：${this.score}/${INK_QUESTIONS.length * 10}`,
        buttons: [
          { text: '返回', color: '#007DFF' },
          { text: '重新开始', color: '#FF6B00' }
        ]
      }).then((result) => {
        if (result.index === 0) {
          router.back();
        } else {
          this.questionIndex = 0;
          this.score = 0;
          this.loadQuestion();
        }
      });
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('sys.symbol.chevron_left'))
          .width(24)
          .height(24)
          .fillColor($r('app.color.text_primary'))
          .onClick(() => router.back())
        
        Text('🖌️ 墨汁遮盖')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text(`${this.questionIndex + 1}/${INK_QUESTIONS.length}`)
          .fontSize(14)
          .fontColor($r('app.color.text_tertiary'))
          .padding({ right: 4 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor($r('app.color.card_background'))

      Scroll() {
        Column({ space: 20 }) {
          // 分数显示
          Row() {
            Text(`🏆 得分：${this.score}`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.text_primary'))
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 16 })

          // 墨汁遮盖区域
          if (this.currentQuestion) {
            Stack() {
              // 诗句内容（底层）
              Column() {
                Text(this.currentQuestion.author)
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .margin({ bottom: 8 })
                
                Text() {
                  ForEach(this.currentQuestion.poem.split(''), (char: string, index: number) => {
                    if (index === this.currentQuestion!.blankIndex) {
                      Span('___')
                        .fontSize(28)
                        .fontColor('#FF6B00')
                        .fontWeight(FontWeight.Bold)
                    } else {
                      Span(char)
                        .fontSize(28)
                        .fontColor($r('app.color.text_primary'))
                    }
                  })
                }
                .lineHeight(48)
                .textAlign(TextAlign.Center)
              }
              .width('100%')
              .padding(32)

              // 墨汁层（上层）
              Column() {
                Text('擦除墨汁')
                  .fontSize(20)
                  .fontColor('#FFFFFF')
                  .fontWeight(FontWeight.Bold)
                  .opacity(this.gameStarted ? 0 : 1)
                  .animation({ duration: 300 })
                
                // 只在未达到40%且游戏已开始时显示百分比
                if (this.gameStarted && this.wipeProgress < 20) {
                  Text(`${Math.floor(this.wipeProgress)}%`)
                    .fontSize(32)
                    .fontColor('#FFFFFF')
                    .fontWeight(FontWeight.Bold)
                    .margin({ top: 8 })
                }
              }
              .width('100%')
              .height(200)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#2C2C2C')
              .opacity(this.inkOpacity)
              .gesture(
                SwipeGesture({ direction: SwipeDirection.All })
                  .onAction((event: GestureEvent) => {
                    if (event && event.offsetX !== undefined && event.offsetY !== undefined) {
                      this.handleSwipe(event.offsetX, event.offsetY);
                    }
                  })
              )
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    if (event && event.offsetX !== undefined && event.offsetY !== undefined) {
                      this.handleSwipe(event.offsetX, event.offsetY);
                    }
                  })
              )

              // 墨滴粒子特效层
              if (this.showParticles) {
                Stack() {
                  ForEach(this.particles, (particle: InkParticle) => {
                    Circle()
                      .width(particle.size)
                      .height(particle.size)
                      .fill('#2C2C2C')
                      .position({ x: particle.x, y: particle.y })
                      .opacity(particle.opacity)
                  })
                }
                .width('100%')
                .height(200)
              }
            }
            .width('100%')
            .borderRadius(16)
            .backgroundColor($r('app.color.card_background'))
            .clip(true)
          }

          // 擦除进度提示
          if (this.wipeProgress > 0 && this.wipeProgress < 20) {
            Row() {
              Text(`💧 继续擦除，还差 ${20 - Math.floor(this.wipeProgress)}% 解锁答题`)
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }

          // 选项区域
          if (this.currentQuestion && this.wipeProgress >= 20) {
            Column({ space: 12 }) {
              Text('✨ 请选择正确的字：')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.text_primary'))
                .width('100%')
                .textAlign(TextAlign.Start)
              
              Grid() {
                ForEach(this.currentQuestion.options, (option: string) => {
                  GridItem() {
                    Text(option)
                      .fontSize(32)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(
                        this.isAnswered
                          ? (option === this.currentQuestion!.correctAnswer
                            ? '#FFFFFF'
                            : (option === this.selectedAnswer ? '#FFFFFF' : $r('app.color.text_primary')))
                          : (option === this.selectedAnswer ? '#FFFFFF' : $r('app.color.text_primary'))
                      )
                      .width('100%')
                      .height(80)
                      .textAlign(TextAlign.Center)
                      .backgroundColor(
                        this.isAnswered
                          ? (option === this.currentQuestion!.correctAnswer
                            ? '#4CAF50'
                            : (option === this.selectedAnswer ? '#F44336' : $r('app.color.card_background')))
                          : (option === this.selectedAnswer ? '#007DFF' : $r('app.color.card_background'))
                      )
                      .borderRadius(12)
                      .border({
                        width: 2,
                        color: option === this.selectedAnswer ? '#007DFF' : 'transparent'
                      })
                      .onClick(() => {
                        this.selectAnswer(option);
                      })
                  }
                })
              }
              .columnsTemplate('1fr 1fr')
              .rowsTemplate('1fr 1fr')
              .columnsGap(12)
              .rowsGap(12)
              .width('100%')
              .height(180)
            }
            .width('100%')
            .padding(16)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(16)
          }

          // 下一题按钮
          if (this.isAnswered) {
            Button('下一题 →')
              .width('100%')
              .height(50)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .backgroundColor($r('app.color.accent_positive'))
              .onClick(() => {
                this.nextQuestion();
              })
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 20 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}
