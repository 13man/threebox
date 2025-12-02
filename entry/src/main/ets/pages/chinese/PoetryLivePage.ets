import router from '@ohos.router';
import { common } from '@kit.AbilityKit';
import promptAction from '@ohos.promptAction';
import { TextReader, ReadStateCode } from '@kit.SpeechKit';

// 诗词数据接口
interface LivePoem {
  id: number;
  title: string;
  author: string;
  content: string;
  type: 'tang' | 'song' | 'yuan'; // 类型：唐诗/宋词/元曲
  scene: string; // 场景描述：春江花月夜、雪山寒梅等
}

// 粒子接口
interface Particle {
  x: number;
  y: number;
  vx: number;
  vy: number;
  size: number;
  alpha: number;
  color: string;
  life: number;
  type?: string;  // 粒子类型: 'petal'花瓣, 'tide'潮水, 'light'流光
}

// 花瓣粒子接口
interface Petal {
  x: number;
  y: number;
  vx: number;
  vy: number;
  rotation: number;  // 旋转角度
  rotationSpeed: number;  // 旋转速度
  size: number;
  alpha: number;
  color: string;
  isFalling: boolean;  // 是否正在下落
}

// 孔明灯接口 (水调歌头)
interface Lantern {
  x: number;
  y: number;
  vy: number;  // 上升速度
  size: number;
  alpha: number;
  color: string;
  isExploding: boolean;  // 是否正在爆炸
  explodeProgress: number;  // 爆炸进度 (0-1)
}

// 位置坐标接口 (用于孔明灯拼字)
interface Position {
  x: number;
  y: number;
}

// 诗句样式接口
interface LineStyle {
  fontSize: number;
  fontColor: string | Resource;
  fontWeight: FontWeight;
  opacity: number;
}

@Entry
@Component
export struct PoetryLivePage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  
  @State private currentPoemIndex: number = 0;
  @State private isPlaying: boolean = false;
  @Prop @Watch('onVisibilityChange') isVisible: boolean = true;  // 用于监控tab可见性
 @State private moonX: number = 0.7; // 月亮X位置 (0-1)
  @State private moonY: number = 0.3; // 月亮Y位置 (0-1)
  @State private waveOffset: number = 0;
  @State private particleOpacity: number = 1.0;
  @State private moonScale: number = 1.0; // 月亮缩放 (静夜思交互)
  @State private libaiAlpha: number = 0; // 李白剪影透明度 (静夜思交互)
  @State private moonBrightness: number = 0.5; // 月光亮度 (呼吸效果)
  @State private highlightFrost: boolean = false; // 是否高亮"疑是地上霜"
  
  // 春江花月夜状态
  @State private moonAngle: number = 0; // 月亮旋转角度 (双指旋转)
  @State private tideHeight: number = 0; // 潮水高度 (0-1)
  @State private moonPhase: number = 0; // 月相 (0=新月, 0.5=满月, 1=月食)
  @State private lightPathAlpha: number = 0; // 光路透明度
  @State private boatAlpha: number = 0; // 扁舟透明度
  @State private mapVisible: boolean = false; // 是否显示地图
  
  // 水调歌头状态 (中秋夜)
  @State private moonRiseProgress: number = 0; // 月亮升起进度 (0-1)
  @State private palaceAlpha: number = 0; // 月宫透明度
  @State private changEAlpha: number = 0; // 嫦娥透明度
  @State private suShiAlpha: number = 0; // 苏轼透明度
  @State private cupAlpha: number = 0; // 酒杯透明度
  @State private shadowCount: number = 1; // 人影数量 (1或3)
  @State private shadowRotation: number = 0; // 人影旋转角度
  @State private timeCountdown: number = -1; // 时间隧道倒计时 (-1表示不显示)
  @State private lanternBurst: boolean = false; // 孔明灯爆炸
  @State private moonPhaseValue: number = 1.0; // 月相值 (0=新月, 1=满月)
  
  // 天净沙·秋思状态 (黄昏古道)
  @State private scrollOffset: number = 0; // 卷轴滚动偏移
  @State private crowsFlying: boolean = false; // 乌鸦是否飞起
  @State private crowEyeOpen: boolean = false; // 乌鸦睁眼
  @State private waterRipple: number = 0; // 水面波纹程度
  @State private horseStop: boolean = false; // 瘦马停下
  @State private tianyaText: boolean = false; // 天涯文字显示
  @State private sunsetProgress: number = 0; // 夕阳下沉进度 (0-1)
  @State private vignetteAlpha: number = 0; // 暗角透明度
  @State private duanchangText: boolean = false; // 断肠人在天涯残影
  
  private particles: Particle[] = [];
  private petals: Petal[] = [];  // 花瓣粒子数组
  private lanterns: Lantern[] = [];  // 孔明灯数组 (水调歌头)
  private animationId: number = -1;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private isInit: boolean = false;
  private breathePhase: number = 0; // 呼吸动画相位
  private gooseX: number = -100; // 孤雁X位置
  private gooseY: number = 0; // 孤雁Y位置
  private showGoose: boolean = false; // 是否显示孤雁
  private touchStartY: number = 0; // 触摸起始位置Y
  private touchStartX: number = 0; // 触摸起始位置X
  private tidePhase: number = 0;  // 潮汐相位 (0-2π)
  private longPressTimer: number = -1;  // 长按计时器
  private timeAcceleration: number = 1.0;  // 时间加速倍率
  private seaWavePhase: number = 0;  // 海面波纹相位 (水调歌头)
  
  // 定时器和间隔器管理
  private effectTimers: number[] = [];  // 存储所有setTimeout返回值
  private effectIntervals: number[] = [];  // 存储所有setInterval返回值
  
  // 诗词Live数据
  private livePoems: LivePoem[] = [
    {
      id: 1,
      title: '天净沙·秋思',
      author: '马致远',
      content: '枯藤老树昏鸦，\n小桥流水人家，\n古道西风瘦马。\n夕阳西下，\n断肠人在天涯。',
      type: 'yuan',
      scene: 'autumn_dusk'
    },
    {
      id: 2,
      title: '春江花月夜',
      author: '张若虚',
      content: '春江潮水连海平，海上明月共潮生。\n滟滟随波千万里，何处春江无月明。\n江流宛转绕芳甸，月照花林皆似霰。\n空里流霜不觉飞，汀上白沙看不见。',
      type: 'tang',
      scene: 'river_moon'
    },
    {
      id: 3,
      title: '静夜思',
      author: '李白',
      content: '床前明月光，疑是地上霜。\n举头望明月，低头思故乡。',
      type: 'tang',
      scene: 'night_moon'
    },
    {
      id: 4,
      title: '江雪',
      author: '柳宗元',
      content: '千山鸟飞绝，万径人踪灭。\n孤舟蓑笠翁，独钓寒江雪。',
      type: 'tang',
      scene: 'snow_river'
    },
    {
      id: 5,
      title: '水调歌头·明月几时有',
      author: '苏轼',
      content: '明月几时有？把酒问青天。\n不知天上宫阙，今夕是何年。\n我欲乘风归去，又恐琼楼玉宇，高处不胜寒。\n起舞弄清影，何似在人间。\n\n转朱阁，低绮户，照无眠。\n不应有恨，何事长向别时圆？\n人有悲欢离合，月有阴晴圆缺，此事古难全。\n但愿人长久，千里共婵娟。',
      type: 'song',
      scene: 'moon_palace'
    }
  ];

  async aboutToAppear(): Promise<void> {
    console.log('🛡️ Poetry Live Page: aboutToAppear');
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params && params['poemIndex'] !== undefined) {
      this.currentPoemIndex = params['poemIndex'] as number;
    }
  }

  aboutToDisappear(): void {
    // 清理所有定时器
    this.clearAllTimers();
    console.log('🛡️ Poetry Live Page: aboutToDisappear');
    // 停止动画
    if (this.animationId !== -1) {
      // HarmonyOS不支持cancelAnimationFrame,使用标志位控制
      this.animationId = -1;
    }
    
    // 清理长按计时器
    if (this.longPressTimer !== -1) {
      clearTimeout(this.longPressTimer);
      this.longPressTimer = -1;
    }
    
    // 释放TextReader
    this.cleanupTextReader();
    
    // 清空粒子数组
    this.particles = [];
    this.petals = [];
    this.lanterns = [];
    
    console.log('🛡️ Poetry Live Page: 资源已清理');
  }
  

  
  // Tab可见性变化监听器
  onVisibilityChange(): void {
    if (!this.isVisible) {
      // Tab隐藏时暂停播放
      if (this.isPlaying) {
        try {
          TextReader.stop();
          // 释放TextReader资源
          TextReader.release().then(() => {
            console.log('TextReader资源释放成功');
          }).catch((error: Error) => {
            console.error('TextReader资源释放失败:', error);
          });
          this.isPlaying = false;
          this.isInit=false;
          console.log('🚫 Poetry Live Tab: 隐藏，暂停播放');
        } catch (error) {
          console.error('Poetry 暂停TextReader失败:', error);
        }
      }else {
        console.log('🚫 Poetry isVisible true');
      }
    } else {
      // Tab显示时重新初始化（如果需要）
      if (!this.isInit) {
        this.initTextReader();
        console.log('✅ Poetry Live Tab: 显示，重新初始化TextReader');
      }else {
        console.log('✅Poetry isInit true');
      }
    }
  }
  
  // 清理所有定时器和间隔器
  private clearAllTimers(): void {
    // 清理所有setTimeout
    this.effectTimers.forEach((timerId: number) => {
      clearTimeout(timerId);
    });
    this.effectTimers = [];
    
    // 清理所有setInterval
    this.effectIntervals.forEach((intervalId: number) => {
      clearInterval(intervalId);
    });
    this.effectIntervals = [];
  }
  
  // 清理TextReader资源
  private cleanupTextReader(): void {
    try {
      if (this.isInit) {
        console.error('Poetry cleanupTextReader:');
        TextReader.stop();
        TextReader.off('stateChange');  // 取消事件监听
        TextReader.release();
        this.isInit = false;
        this.isPlaying = false;
      }
    } catch (error) {
      console.error('Poetry 释放TextReader失败:', error);
    }
  }
  
  // 安全的setTimeout包装器
  private safeSetTimeout(callback: () => void, delay: number): void {
    const timerId = setTimeout(callback, delay);
    this.effectTimers.push(timerId);
  }
  
  // 安全的setInterval包装器
  private safeSetInterval(callback: () => void, delay: number): void {
    const intervalId = setInterval(callback, delay);
    this.effectIntervals.push(intervalId);
  }

  // 初始化TextReader
  private async initTextReader(): Promise<void> {
    try {
      const businessBrandInfo: TextReader.BusinessBrandInfo = { 
        panelName: '诗词Live朗诵'
      };
      
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: true
      };

      await TextReader.init(getContext(this), readerParam);
      this.isInit = true;
      
      // 监听朗读状态
      TextReader.on('stateChange', (state: TextReader.ReadState) => {
        if (state.state === ReadStateCode.PLAYING) {
          this.isPlaying = true;
        } else if (state.state === ReadStateCode.COMPLETED || 
                   state.state === ReadStateCode.WAITING) {
          this.isPlaying = false;
        }
      });
    } catch (error) {
      console.error('Poetry TextReader初始化失败:', error);
      this.isInit = false;
    }
  }

  // 开始朗诵
  private async startRecitation(): Promise<void> {
    if (!this.isInit) {
      promptAction.showToast({ message: '朗诵功能初始化中...' });
      return;
    }
    
    // 清理之前的所有特效定时器
    this.clearAllTimers();
    
    const poem = this.livePoems[this.currentPoemIndex];
    
    try {
      TextReader.stop();
      
      // 春江花月夜 - 启动特效序列
      if (poem.scene === 'river_moon') {
        this.triggerRiverMoonEffects();
      }
      
      // 静夜思 - 启动特效序列
      if (poem.scene === 'night_moon') {
        this.triggerNightMoonEffects();
      }
      
      // 水调歌头 - 启动特效序列
      if (poem.scene === 'moon_palace') {
        this.triggerMoonPalaceEffects();
        // 初始化孔明灯
        this.initLanterns();
      }
      
      // 天净沙·秋思 - 启动特效序列
      if (poem.scene === 'autumn_dusk') {
        this.triggerAutumnDuskEffects();
      }
      
      // 创建朗读信息 - 使用正确的ReadInfo格式
      const readInfo: TextReader.ReadInfo = {
        id: `poetry_live_${poem.id}`,
        title: {
          text: poem.title,
          isClickable: false
        },
        bodyInfo: `${poem.title},作者:${poem.author}。${poem.content}`
      };
      
      // 开始朗读
      TextReader.start([readInfo]).then(() => {
        console.log('开始朗诵');
        this.isPlaying = true;
      }).catch((error: Error) => {
        console.error('朗诵失败:', error);
        promptAction.showToast({ message: '朗诵失败' });
      });
    } catch (error) {
      console.error('朗诵失败:', error);
      promptAction.showToast({ message: '朗诵失败' });
    }
  }

  // 春江花月夜特效序列
  private triggerRiverMoonEffects(): void {
    // "春江潮水连海平" - 潮水涌起
    this.safeSetTimeout(() => {
      this.tideHeight = 0.8;
    }, 2000);
    
    // "海上明月共潮生" - 月亮上升
    this.safeSetTimeout(() => {
      this.moonY = 0.2;
    }, 4000);
    
    // "滚溭随波千万里" - 光路出现
    this.safeSetTimeout(() => {
      this.lightPathAlpha = 0.8;
    }, 6000);
  }

  // 静夜思特效序列
  private triggerNightMoonEffects(): void {
    // "床前明月光" - 月光粒子第一次爆发
    this.safeSetTimeout(() => {
      this.particleOpacity = 1.8; // 增强粒子亮度
      this.moonBrightness = 0.9; // 月光增强
      console.log('✨ 床前明月光 - 月光爆发');
    }, 1500);
    
    // "疑是地上霜" - 地面霜花高亮
    this.safeSetTimeout(() => {
      this.highlightFrost = true;
      this.particleOpacity = 1.5;
      console.log('❄️ 疑是地上霜 - 霜高亮');
    }, 3500);
    
    // "举头望明月" - 月亮放大 1.2 倍，镜头上移
    this.safeSetTimeout(() => {
      this.moonScale = 1.3; // 月亮放大
      this.moonY = 0.2; // 镜头明显上移
      this.highlightFrost = false; // 取消霜高亮
      console.log('🔼 举头望明月 - 月亮放大+上移');
    }, 5500);
    
    // "低头思故乡" - 李白剪影明显出现
    this.safeSetTimeout(() => {
      this.libaiAlpha = 1.0; // 李白完全显示
      this.moonScale = 1.0; // 月亮恢复
      this.moonY = 0.3; // 月亮位置恢复
      console.log('🚶 低头思故乡 - 李白出现 (Alpha=1.0)');
    }, 7500);
    
    // 10秒后重置，循环效果
    this.safeSetTimeout(() => {
      this.particleOpacity = 1.0;
      this.moonBrightness = 0.5;
      this.libaiAlpha = 0;
      this.moonScale = 1.0;
      console.log('🔄 重置状态，准备下一轮循环');
    }, 10000);
  }

  // 水调歌头特效序列 (中秋夜)
  private triggerMoonPalaceEffects(): void {
    // 开场: 月亮从海面跃出
    this.moonRiseProgress = 0;
    this.moonY = 1.0; // 从海平面开始
    
    this.safeSetTimeout(() => {
      // 月亮上升动画 (2秒内从海面升到天空)
      this.safeSetInterval(() => {
        this.moonRiseProgress += 0.02;
        this.moonY = 1.0 - this.moonRiseProgress * 0.7; // 从1.0升到0.3
        if (this.moonRiseProgress >= 1.0) {
          this.moonY = 0.3;
          this.palaceAlpha = 0.3; // 月宫显现
          // 月宫出现后，嫦娥也出现
          this.changEAlpha = 0.6;
        }
      }, 30);
    }, 500);
    
    // 嫦娥飞行动画 (从月宫飞过)
    this.safeSetTimeout(() => {
      // 嫦娥渐隐
      this.safeSetInterval(() => {
        this.changEAlpha -= 0.05;
        if (this.changEAlpha <= 0) {
          this.changEAlpha = 0;
        }
      }, 100);
      console.log('👰 嫦娥仙子飞过月宫');
    }, 4000);
    
    // "明月几时有" - 时间隧道，倒计时3 2 1
    this.safeSetTimeout(() => {
      this.timeCountdown = 3;
      this.safeSetInterval(() => {
        this.timeCountdown--;
        if (this.timeCountdown <= 0) {
          this.timeCountdown = -1; // 隐藏倒计时
        }
      }, 1000);
      console.log('🕒 明月几时有 - 时间隧道 3-2-1');
    }, 3000);
    
    // "把酒问青天" - 苏轼举杯，酒杯出现
    this.safeSetTimeout(() => {
      this.suShiAlpha = 0.9; // 苏轼出现
      this.cupAlpha = 1.0; // 酒杯出现
      console.log('🍷 把酒问青天 - 苏轼举杯');
    }, 7000);
    
    // "起舞弄清影" - 人影分裂成03个，360°旋转
    this.safeSetTimeout(() => {
      this.shadowCount = 3; // 分裂成3个重影
      // 旋转动画
      this.safeSetInterval(() => {
        this.shadowRotation += 10; // 每次10度
        if (this.shadowRotation >= 360) {
          this.shadowRotation = 0;
          this.shadowCount = 1; // 恢复为1个
        }
      }, 30);
      console.log('💃 起舞弄清影 - 人影分裂+旋转');
    }, 15000);
    
    // "但愿人长久" - 所有孔明灯同时升空，拼成"长久"二字
    this.safeSetTimeout(() => {
      this.lanternBurst = true;
      
      // 孔明灯分成两组，分别拼成"长"和"久"
      const centerX: number = this.canvasWidth * 0.5;
      const centerY: number = this.canvasHeight * 0.35;
      const spacing: number = 100; // 两个字的间距
      
      // "长"字的位置 (左侧)
      const changPositions: Position[] = [
        {x: centerX - spacing - 20, y: centerY - 30} as Position,
        {x: centerX - spacing, y: centerY - 20} as Position,
        {x: centerX - spacing + 20, y: centerY - 10} as Position,
        {x: centerX - spacing - 10, y: centerY + 10} as Position,
        {x: centerX - spacing + 10, y: centerY + 30} as Position
      ];
      
      // "久"字的位置 (右侧)
      const jiuPositions: Position[] = [
        {x: centerX   - 15, y: centerY - 25} as Position,
        {x: centerX , y: centerY - 10} as Position,
        {x: centerX  + 15, y: centerY} as Position,
        {x: centerX  - 10, y: centerY + 15} as Position,
        {x: centerX  + 10, y: centerY + 30} as Position
      ];
      
      // 将孔明灯移动到指定位置
      this.lanterns.forEach((lantern: Lantern, index: number) => {
        if (index < 5) {
          // 前5个拼"长"
          lantern.x = changPositions[index].x;
          lantern.y = changPositions[index].y;
        } else if (index < 10) {
          // 后5个拼"久"
          lantern.x = jiuPositions[index - 5].x;
          lantern.y = jiuPositions[index - 5].y;
        }
        lantern.vy = 0; // 停止移动
        lantern.isExploding = true;
        lantern.alpha = 1.0;
      });
      
      console.log('🎆 但愿人长久 - 孔明灯拼成"长久"二字');
      
      // 2秒后重置
      this.safeSetTimeout(() => {
        this.lanternBurst = false;
      }, 2000);
    }, 30000); // 调整为30秒,对应朗读到"但愿人长久"(最后一句)
    
    // 30秒后重置所有状态，准备循环
    this.safeSetTimeout(() => {
      this.moonRiseProgress = 0;
      this.palaceAlpha = 0;
      this.changEAlpha = 0;
      this.suShiAlpha = 0;
      this.cupAlpha = 0;
      this.shadowCount = 1;
      this.shadowRotation = 0;
      this.timeCountdown = -1;
      this.lanternBurst = false;
      this.moonY = 0.3;
      console.log('🔄 水调歌头重置，准备下一轮');
    }, 34000);
  }
  
  // 天净沙·秋思特效序列 (黄昏古道)
  private triggerAutumnDuskEffects(): void {
    // 卷轴自动滚动
    this.safeSetInterval(() => {
      this.scrollOffset += 0.5;
      if (this.scrollOffset > this.canvasWidth) {
        this.scrollOffset = 0;
      }
    }, 30);
    
    // 0:00 "枯藤老树昏鸦" - 乌鸦睁眼并飞起
    this.safeSetTimeout(() => {
      this.crowEyeOpen = true;
      this.safeSetTimeout(() => {
        this.crowsFlying = true;
        console.log('🦅 枯藤老树昏鸦 - 乌鸦睁眼飞起');
      }, 500);
    }, 1000);
    
    // 0:08 "小桥流水人家" - 水面波纹
    this.safeSetTimeout(() => {
      this.waterRipple = 1.0;
      console.log('🌊 小桥流水人家 - 水面波纹');
    }, 8000);
    
    // 0:16 "古道西风瘦马" - 瘦马停下，马尾扫出"天涯"
    this.safeSetTimeout(() => {
      this.horseStop = true;
      this.safeSetTimeout(() => {
        this.tianyaText = true;
        console.log('🐎 古道西风瘦马 - 马尾扫出天涯');
        // 3秒后文字消散
        this.safeSetTimeout(() => {
          this.tianyaText = false;
        }, 3000);
      }, 1000);
    }, 10000);
    
    // 0:24 "夕阳西下" - 太阳加速落山，暗角+心跳
    this.safeSetTimeout(() => {
      // 夕阳下沉动画
      this.safeSetInterval(() => {
        this.sunsetProgress += 0.05;
        this.vignetteAlpha = this.sunsetProgress * 0.6;
        if (this.sunsetProgress >= 1.0) {
          // 显示断肠人在天涯
          this.duanchangText = true;
        }
      }, 100);
      console.log('🌅 夕阳西下 - 加速落山+暗角');
    }, 13000);
    
    // 30秒后重置
    this.safeSetTimeout(() => {
      this.scrollOffset = 0;
      this.crowsFlying = false;
      this.crowEyeOpen = false;
      this.waterRipple = 0;
      this.horseStop = false;
      this.tianyaText = false;
      this.sunsetProgress = 0;
      this.vignetteAlpha = 0;
      this.duanchangText = false;
      console.log('🔄 天净沙·秋思重置，准备下一轮');
    }, 15000);
  }

  // 暂停/继续朗诵
  private togglePlay(): void {
    if (this.isPlaying) {
      TextReader.pause();
      this.isPlaying = false;
    } else {
      this.startRecitation();
    }
  }

  // 初始化粒子
  private initParticles(): void {
    if (this.canvasWidth === 0 || this.canvasHeight === 0) {
      console.log('Cannot init particles: canvas size is 0');
      return;
    }
    
    const poem = this.livePoems[this.currentPoemIndex];
    this.particles = [];
    
    // 根据场景调整粒子数量
    let particleCount = 60;
    if (poem.scene === 'river_moon') {
      particleCount = 80; // 春江花月夜 - 更多花瓣
    } else if (poem.scene === 'night_moon') {
      particleCount = 30; // 静夜思 - 宁静少量
    } else if (poem.scene === 'snow_river') {
      particleCount = 100; // 江雪 - 大雪纷飞
    } else if (poem.scene === 'moon_palace') {
      particleCount = 50; // 水调歌头 - 星尘闪烁
    } else if (poem.scene === 'autumn_dusk') {
      particleCount = 70; // 秋思 - 落叶纷飞
    }
    
    for (let i = 0; i < particleCount; i++) {
      this.particles.push(this.createParticle());
    }
    
    console.log('Particles initialized:', this.particles.length, 'for scene:', poem.scene);
  }

  // 创建粒子
  private createParticle(): Particle {
    const poem = this.livePoems[this.currentPoemIndex];
    let color = '#FFD700'; // 默认金色
    let size = Math.random() * 4 + 2;
    let vx = (Math.random() - 0.5) * 2;
    let vy = Math.random() * 2 + 1;
    
    if (poem.scene === 'river_moon') {
      // 春江花月夜 - 金色花瓣,横向飘动
      color = Math.random() > 0.7 ? '#FFD700' : '#FFC0CB'; // 金色/粉色花瓣
      size = Math.random() * 5 + 3;
      vx = (Math.random() - 0.5) * 3; // 更多横向运动
      vy = Math.random() * 1.5 + 0.5; // 缓慢下落
    } else if (poem.scene === 'night_moon') {
      // 静夜思 - 银白月光,从下往上上升 (霜粒子)
      color = 'rgba(255, 255, 255, 0.8)'; // 银白色
      size = Math.random() * 3 + 1;
      vx = (Math.random() - 0.5) * 0.5; // 几乎不横向移动
      vy = -(Math.random() * 0.8 + 0.3); // 从下往上上升 (负值)
    } else if (poem.scene === 'snow_river') {
      // 江雪 - 白色雪花,飘洒下落
      color = '#FFFFFF';
      size = Math.random() * 6 + 3;
      vx = (Math.random() - 0.5) * 1.5; // 雪花飘洒
      vy = Math.random() * 2 + 1;
    } else if (poem.scene === 'moon_palace') {
      // 水调歌头 - 仙气星尘,微光闪烁
      color = Math.random() > 0.5 ? '#E0E0FF' : '#FFFACD'; // 淡紫/淡黄
      size = Math.random() * 2 + 1; // 微小的星尘
      vx = (Math.random() - 0.5) * 1;
      vy = Math.random() * 1 + 0.5; // 漂浮感
    } else if (poem.scene === 'autumn_dusk') {
      // 秋思 - 红色枫叶,金黄落叶
      color = Math.random() > 0.5 ? '#FF6B6B' : '#FFD700';
      size = Math.random() * 5 + 2;
      vx = (Math.random() - 0.5) * 3; // 西风吹拂
      vy = Math.random() * 2 + 1.5; // 较快下落
    }
    
    return {
      x: Math.random() * this.canvasWidth,
      y: Math.random() * this.canvasHeight,
      vx: vx,
      vy: vy,
      size: size,
      alpha: Math.random() * 0.5 + 0.5,
      color: color,
      life: 1.0
    };
  }

  // 更新粒子
  private updateParticles(): void {
    const poem = this.livePoems[this.currentPoemIndex];
    
    this.particles.forEach((p: Particle, index: number) => {
      // 更新位置
      p.x += p.vx;
      p.y += p.vy;
      
      // 边界检测
      if (poem.scene === 'night_moon') {
        // 静夜思 - 粒子上升，从底部重生
        if (p.y < -10 || p.x < 0 || p.x > this.canvasWidth) {
          this.particles[index] = this.createParticle();
          this.particles[index].y = this.canvasHeight + 10; // 从底部出现
        }
      } else {
        // 其他场景 - 粒子下降，从顶部重生
        if (p.y > this.canvasHeight || p.x < 0 || p.x > this.canvasWidth) {
          this.particles[index] = this.createParticle();
          this.particles[index].y = -10; // 从顶部出现
        }
      }
      
      // 生命周期
      p.life -= 0.001;
      if (p.life <= 0) {
        this.particles[index] = this.createParticle();
        if (poem.scene === 'night_moon') {
          this.particles[index].y = this.canvasHeight + 10;
        }
      }
    });
  }

  // 更新孔明灯 (水调歌头)
  private updateLanterns(): void {
    this.lanterns.forEach((lantern, index) => {
      // 爆炸动画
      if (lantern.isExploding) {
        lantern.explodeProgress += 0.02;
        if (lantern.explodeProgress >= 1.0) {
          lantern.isExploding = false;
          lantern.explodeProgress = 0;
          // 重置位置
          lantern.y = this.canvasHeight + 100;
          lantern.x = Math.random() * this.canvasWidth;
          lantern.vy = -(Math.random() * 0.5 + 0.3);
        }
      } else if (!this.lanternBurst) {
        // 只有在非爆炸状态时才正常移动
        // 更新位置
        lantern.y += lantern.vy;
        
        // 微飘动
        lantern.x += Math.sin(lantern.y * 0.01) * 0.5;
        
        // 超出屏幕重置
        if (lantern.y < -50) {
          lantern.y = this.canvasHeight + Math.random() * 50;
          lantern.x = Math.random() * this.canvasWidth;
        }
      }
    });
  }
  
  // 添加孔明灯 (水调歌头 - 点击交互)
  private addLantern(x: number, y: number): void {
    this.lanterns.push({
      x: x,
      y: y,
      vy: -(Math.random() * 0.8 + 0.5), // 上升速度
      size: 15 + Math.random() * 10,
      alpha: 0.9,
      color: `rgba(255, ${180 + Math.random() * 50}, ${80 + Math.random() * 50}, 0.8)`,
      isExploding: false,
      explodeProgress: 0
    });
  }
  
  // 初始化孔明灯 (水调歌头)
  private initLanterns(): void {
    this.lanterns = [];
    // 创建 10 个初始孔明灯
    for (let i = 0; i < 10; i++) {
      this.lanterns.push({
        x: Math.random() * this.canvasWidth,
        y: this.canvasHeight * (0.6 + Math.random() * 0.4), // 在下半部分
        vy: -(Math.random() * 0.5 + 0.3), // 缓慢上升
        size: 15 + Math.random() * 10,
        alpha: 0.8 + Math.random() * 0.2,
        color: `rgba(255, ${180 + Math.random() * 50}, ${80 + Math.random() * 50}, 0.8)`,
        isExploding: false,
        explodeProgress: 0
      });
    }
    console.log('🏮 初始化 10 个孔明灯');
  }

  // 绘制场景
  private drawScene(): void {
    if (!this.context) {
      console.log('Context not ready');
      return;
    }
    
    if (this.canvasWidth === 0 || this.canvasHeight === 0) {
      console.log('Canvas size is 0');
      return;
    }
    
    const ctx = this.context;
    const poem = this.livePoems[this.currentPoemIndex];
    
    try {
      // 清空画布
      ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
      
      // 绘制背景
      this.drawBackground(ctx, poem.scene);
      
      // 绘制月亮
      if (poem.scene.includes('moon')) {
        this.drawMoon(ctx);
        // 春江花月夜 - 绘制月光路径
        if (poem.scene === 'river_moon' && this.lightPathAlpha > 0) {
          this.drawMoonlightPath(ctx);
        }
      }
      
      // 绘制水波
      if (poem.scene.includes('river')) {
        this.drawWaves(ctx);
      }
      
      // 绘制粒子
      this.drawParticles(ctx);
      
      // 更新波浪偏移
      this.waveOffset += 0.02;
    } catch (error) {
      console.error('Draw scene error:', error);
    }
  }

  // 绘制背景
  private drawBackground(ctx: CanvasRenderingContext2D, scene: string): void {
    const gradient = ctx.createLinearGradient(0, 0, 0, this.canvasHeight);
    
    if (scene === 'river_moon') {
      // 春江花月夜 - 春江潮水连海平,海上明月共潮生
      // 深蓝夜空渐变到青色江水
      gradient.addColorStop(0, '#0a1128'); // 深夜蓝
      gradient.addColorStop(0.4, '#1e3a5f'); // 夜空蓝
      gradient.addColorStop(0.7, '#2c5f7f'); // 江水蓝
      gradient.addColorStop(1, '#3d7fa6'); // 浅江蓝
    } else if (scene === 'night_moon') {
      // 静夜思 - 床前明月光,疑是地上霜
      // 黑夜房间,窗棂透进月光
      gradient.addColorStop(0, '#0a0a0f'); // 深黑夜
      gradient.addColorStop(0.5, '#1a1a2e'); // 深紫夜
      gradient.addColorStop(1, '#16213e'); // 底部稍亮
    } else if (scene === 'snow_river') {
      // 江雪 - 千山鸟飞绝,万径人踪灭,孤舟蓑笠翁,独钓寒江雪
      // 寒冷的雪景,灰白色调
      gradient.addColorStop(0, '#4a5568'); // 灰色天空
      gradient.addColorStop(0.5, '#718096'); // 雪云
      gradient.addColorStop(1, '#cbd5e0'); // 雪白江面
    } else if (scene === 'moon_palace') {
      // 水调歌头 - 明月几时有,把酒问青天
      // 清澈的夜空,仙境般的月宫
      gradient.addColorStop(0, '#1e1e3f'); // 深紫夜
      gradient.addColorStop(0.3, '#2d3561'); // 紫蓝夜空
      gradient.addColorStop(0.7, '#3e4a7a'); // 天空蓝紫
      gradient.addColorStop(1, '#4a5f8f'); // 浅蓝
    } else if (scene === 'autumn_dusk') {
      // 天净沙·秋思 - 枯藤老树昏鸦,小桥流水人家,古道西风瘦马,夕阳西下
      // 秋日黄昏,暖橙到深蓝
      gradient.addColorStop(0, '#ff6b6b'); // 夕阳红
      gradient.addColorStop(0.3, '#ffa500'); // 橙黄
      gradient.addColorStop(0.6, '#ff8c42'); // 暖橙
      gradient.addColorStop(1, '#3d5a80'); // 暮色蓝灰
    } else {
      // 默认天空
      gradient.addColorStop(0, '#1e3a8a');
      gradient.addColorStop(1, '#3b82f6');
    }
    
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, this.canvasWidth, this.canvasHeight);
    
    // 根据场景添加特殊效果
    if (scene === 'river_moon') {
      // 春江花月夜 - 添加江面波光
      this.drawRiverShimmer(ctx);
      // 绘制远山视差层
      this.drawMountainLayers(ctx);
      // 绘制潮水效果
      if (this.tideHeight > 0) {
        this.drawTideWater(ctx);
      }
    } else if (scene === 'night_moon') {
      // 静夜思 - 绘制房间、窗户、李白剪影
      this.drawNightRoom(ctx);
    } else if (scene === 'moon_palace') {
      // 水调歌头 - 绘制中秋夜场景
      this.drawMoonPalace(ctx);
    } else if (scene === 'snow_river') {
      // 江雪 - 添加雪山剪影
      this.drawSnowMountains(ctx);
    } else if (scene === 'autumn_dusk') {
      // 秋思 - 添加枯树剪影
      this.drawAutumnTrees(ctx);
    }
  }

  // 绘制月亮
  private drawMoon(ctx: CanvasRenderingContext2D): void {
    const x = this.moonX * this.canvasWidth;
    const y = this.moonY * this.canvasHeight;
    const baseRadius = 50;
    const radius = baseRadius * this.moonScale;  // 应用缩放比例
    
    // 月亮光晕
    const haloGradient = ctx.createRadialGradient(x, y, radius * 0.5, x, y, radius * 2);
    haloGradient.addColorStop(0, 'rgba(255, 255, 200, 0.3)');
    haloGradient.addColorStop(0.5, 'rgba(255, 255, 200, 0.1)');
    haloGradient.addColorStop(1, 'rgba(255, 255, 200, 0)');
    
    ctx.fillStyle = haloGradient;
    ctx.beginPath();
    ctx.arc(x, y, radius * 2, 0, Math.PI * 2);
    ctx.fill();
    
    // 月亮本体
    const moonGradient = ctx.createRadialGradient(x - radius * 0.3, y - radius * 0.3, 0, x, y, radius);
    moonGradient.addColorStop(0, '#fffacd');
    moonGradient.addColorStop(1, '#f0e68c');
    
    ctx.fillStyle = moonGradient;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, Math.PI * 2);
    ctx.fill();
  }

  // 绘制水波
  private drawWaves(ctx: CanvasRenderingContext2D): void {
    const poem = this.livePoems[this.currentPoemIndex];
    const waveHeight = 30;
    const waveCount = 3;
    const baseY = this.canvasHeight * 0.75;
    
    for (let i = 0; i < waveCount; i++) {
      ctx.beginPath();
      ctx.moveTo(0, baseY + i * 20);
      
      for (let x = 0; x <= this.canvasWidth; x += 10) {
        const y = baseY + i * 20 + Math.sin((x + this.waveOffset * 100) * 0.02) * waveHeight;
        ctx.lineTo(x, y);
      }
      
      ctx.lineTo(this.canvasWidth, this.canvasHeight);
      ctx.lineTo(0, this.canvasHeight);
      ctx.closePath();
      
      const alpha = 0.3 - i * 0.1;
      // 根据场景调整水波颜色
      if (poem.scene === 'river_moon') {
        ctx.fillStyle = `rgba(61, 127, 166, ${alpha})`; // 青蓝江水
      } else {
        ctx.fillStyle = `rgba(100, 149, 237, ${alpha})`; // 默认蓝色
      }
      ctx.fill();
    }
  }
  
  // 绘制江面波光 (春江花月夜)
  private drawRiverShimmer(ctx: CanvasRenderingContext2D): void {
    const baseY = this.canvasHeight * 0.75;
    const shimmerCount = 5;
    
    for (let i = 0; i < shimmerCount; i++) {
      const x = (i / shimmerCount) * this.canvasWidth + (this.waveOffset * 50) % this.canvasWidth;
      const y = baseY + Math.sin(this.waveOffset * 2 + i) * 10;
      
      const gradient = ctx.createRadialGradient(x, y, 0, x, y, 30);
      gradient.addColorStop(0, 'rgba(255, 255, 200, 0.3)');
      gradient.addColorStop(1, 'rgba(255, 255, 200, 0)');
      
      ctx.fillStyle = gradient;
      ctx.beginPath();
      ctx.arc(x, y, 30, 0, Math.PI * 2);
      ctx.fill();
    }
  }
  
  // 绘制月光路径 (春江花月夜 - 滚溭随波千万里)
  private drawMoonlightPath(ctx: CanvasRenderingContext2D): void {
    const moonX = this.moonX * this.canvasWidth;
    const moonY = this.moonY * this.canvasHeight;
    const pathY = this.canvasHeight * 0.75; // 江面高度
    
    ctx.save();
    ctx.globalAlpha = this.lightPathAlpha;
    
    // 绘制从月亮到江面的光路
    const gradient = ctx.createLinearGradient(moonX, moonY, moonX, pathY);
    gradient.addColorStop(0, 'rgba(255, 255, 200, 0)');
    gradient.addColorStop(0.5, 'rgba(255, 255, 200, 0.3)');
    gradient.addColorStop(1, 'rgba(255, 255, 200, 0.5)');
    
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.moveTo(moonX - 30, moonY);
    ctx.lineTo(moonX + 30, moonY);
    ctx.lineTo(moonX + 50, pathY);
    ctx.lineTo(moonX - 50, pathY);
    ctx.closePath();
    ctx.fill();
    
    // 绘制江面上的波光点
    for (let i = 0; i < 20; i++) {
      const x = moonX - 40 + Math.random() * 80;
      const y = pathY + Math.random() * 50;
      const size = Math.random() * 3 + 1;
      
      ctx.fillStyle = `rgba(255, 255, 200, ${Math.random() * 0.5})`;
      ctx.beginPath();
      ctx.arc(x, y, size, 0, Math.PI * 2);
      ctx.fill();
    }
    
    ctx.restore();
  }
  
  // 绘制静夜思房间场景 (全新设计)
  private drawNightRoom(ctx: CanvasRenderingContext2D): void {
    // 1. 绘制地面 (床前的地板)
    const floorY = this.canvasHeight * 0.7;
    const floorGradient = ctx.createLinearGradient(0, floorY, 0, this.canvasHeight);
    floorGradient.addColorStop(0, 'rgba(30, 30, 40, 0.8)'); // 房间地板
    floorGradient.addColorStop(1, 'rgba(20, 20, 30, 0.9)'); // 更暗的地面
    ctx.fillStyle = floorGradient;
    ctx.fillRect(0, floorY, this.canvasWidth, this.canvasHeight - floorY);
    
    // 2. 绘制地面霜花效果 (疑是地上霜) - 优化版
    if (this.highlightFrost || this.moonBrightness > 0.6) {
      const frostAlpha = this.highlightFrost ? 0.6 : this.moonBrightness * 0.3;
      
      // 绘制更精致的霜花结晶
      for (let i = 0; i < 15; i++) {
        const x = (i / 15) * this.canvasWidth * 0.8 + this.canvasWidth * 0.1;
        const y = floorY + 30 + (i % 3) * 25 + Math.sin(this.waveOffset + i) * 10;
        
        // 霜花中心点（更亮）
        const centerGradient = ctx.createRadialGradient(x, y, 0, x, y, 8);
        centerGradient.addColorStop(0, `rgba(240, 250, 255, ${frostAlpha * 1.2})`);
        centerGradient.addColorStop(0.6, `rgba(220, 235, 250, ${frostAlpha * 0.6})`);
        centerGradient.addColorStop(1, 'rgba(200, 220, 240, 0)');
        ctx.fillStyle = centerGradient;
        ctx.beginPath();
        ctx.arc(x, y, 8, 0, Math.PI * 2);
        ctx.fill();
        
        // 绘制霜花的六边形结晶纹理
        ctx.save();
        ctx.translate(x, y);
        ctx.strokeStyle = `rgba(255, 255, 255, ${frostAlpha * 0.7})`;
        ctx.lineWidth = 0.8;
        
        // 绘制6条放射状冰晶线
        for (let angle = 0; angle < 360; angle += 60) {
          const rad = (angle * Math.PI) / 180;
          const length = 12 + Math.random() * 6;
          ctx.beginPath();
          ctx.moveTo(0, 0);
          ctx.lineTo(Math.cos(rad) * length, Math.sin(rad) * length);
          ctx.stroke();
          
          // 在每条线的末端添加小分支
          const branchAngle1 = rad + Math.PI / 6;
          const branchAngle2 = rad - Math.PI / 6;
          const branchLen = 4;
          
          ctx.beginPath();
          ctx.moveTo(Math.cos(rad) * length, Math.sin(rad) * length);
          ctx.lineTo(
            Math.cos(rad) * length + Math.cos(branchAngle1) * branchLen,
            Math.sin(rad) * length + Math.sin(branchAngle1) * branchLen
          );
          ctx.stroke();
          
          ctx.beginPath();
          ctx.moveTo(Math.cos(rad) * length, Math.sin(rad) * length);
          ctx.lineTo(
            Math.cos(rad) * length + Math.cos(branchAngle2) * branchLen,
            Math.sin(rad) * length + Math.sin(branchAngle2) * branchLen
          );
          ctx.stroke();
        }
        
        ctx.restore();
      }
      
      // 添加细小的霜花粉尘效果
      for (let i = 0; i < 30; i++) {
        const px = Math.random() * this.canvasWidth;
        const py = floorY + 20 + Math.random() * 100;
        const size = 1 + Math.random() * 2;
        
        ctx.fillStyle = `rgba(240, 250, 255, ${frostAlpha * 0.4 * Math.random()})`;
        ctx.beginPath();
        ctx.arc(px, py, size, 0, Math.PI * 2);
        ctx.fill();
      }
    }
    
    // 3. 绘制窗户 (左下方)
    const windowX = this.canvasWidth * 0.05;  // 左侧留小留白
    const windowY = this.canvasHeight * 0.45;  // 中下部位置
    const windowW = this.canvasWidth * 0.3;
    const windowH = this.canvasHeight * 0.35;
    
    // 窗外夜空 (深蓝色)
    ctx.fillStyle = 'rgba(10, 20, 40, 0.6)';
    ctx.fillRect(windowX, windowY, windowW, windowH);
    
    // 窗外月光 (根据moonBrightness)
    const moonlightAlpha = this.moonBrightness * 0.5;
    const moonlightGradient = ctx.createRadialGradient(
      windowX + windowW * 0.6, windowY + windowH * 0.3, 0,
      windowX + windowW * 0.6, windowY + windowH * 0.3, windowW * 0.8
    );
    moonlightGradient.addColorStop(0, `rgba(255, 255, 220, ${moonlightAlpha})`);
    moonlightGradient.addColorStop(0.5, `rgba(200, 200, 150, ${moonlightAlpha * 0.5})`);
    moonlightGradient.addColorStop(1, 'rgba(200, 200, 150, 0)');
    ctx.fillStyle = moonlightGradient;
    ctx.fillRect(windowX, windowY, windowW, windowH);
    
    // 窗框 (木制窗框)
    ctx.strokeStyle = 'rgba(60, 50, 40, 0.9)';
    ctx.lineWidth = 6;
    ctx.strokeRect(windowX, windowY, windowW, windowH);
    
    // 窗棂 (十字分割)
    ctx.lineWidth = 3;
    // 竖线
    ctx.beginPath();
    ctx.moveTo(windowX + windowW / 2, windowY);
    ctx.lineTo(windowX + windowW / 2, windowY + windowH);
    ctx.stroke();
    // 横线
    ctx.beginPath();
    ctx.moveTo(windowX, windowY + windowH / 2);
    ctx.lineTo(windowX + windowW, windowY + windowH / 2);
    ctx.stroke();
    
    // 4. 窗外远山剪影
    ctx.fillStyle = 'rgba(20, 30, 50, 0.5)';
    ctx.beginPath();
    ctx.moveTo(windowX, windowY + windowH * 0.5);
    ctx.lineTo(windowX + windowW * 0.3, windowY + windowH * 0.4);
    ctx.lineTo(windowX + windowW * 0.5, windowY + windowH * 0.45);
    ctx.lineTo(windowX + windowW * 0.7, windowY + windowH * 0.38);
    ctx.lineTo(windowX + windowW, windowY + windowH * 0.5);
    ctx.lineTo(windowX + windowW, windowY + windowH);
    ctx.lineTo(windowX, windowY + windowH);
    ctx.closePath();
    ctx.fill();
    
    // 5. 绘制李白剪影 (站在窗前)
    if (this.libaiAlpha > 0) {
      this.drawLibaiSilhouette(ctx);
    }
    
    // 6. 绘制孤雁 (窗外飞过)
    if (this.showGoose) {
      // 调整孤雁位置到窗户区域
      const gooseInWindow = this.gooseX > windowX && this.gooseX < windowX + windowW &&
                           this.gooseY > windowY && this.gooseY < windowY + windowH;
      if (gooseInWindow) {
        this.drawGoose(ctx);
      }
    }
    
    // 7. 月光投射到地面的光束
    if (this.moonBrightness > 0.4) {
      const lightBeam = ctx.createLinearGradient(
        windowX + windowW * 0.5, windowY + windowH,
        windowX - windowW * 0.3, floorY + 50
      );
      lightBeam.addColorStop(0, `rgba(255, 255, 220, ${this.moonBrightness * 0.15})`);
      lightBeam.addColorStop(1, 'rgba(255, 255, 220, 0)');
      ctx.fillStyle = lightBeam;
      ctx.beginPath();
      ctx.moveTo(windowX + windowW * 0.3, windowY + windowH);
      ctx.lineTo(windowX + windowW * 0.7, windowY + windowH);
      ctx.lineTo(windowX, floorY + 80);
      ctx.lineTo(windowX - windowW * 0.5, floorY + 80);
      ctx.closePath();
      ctx.fill();
    }
  }
  
  // 绘制窗棂
  private drawWindow(ctx: CanvasRenderingContext2D): void {
    const windowX = this.canvasWidth * 0.7;
    const windowY = this.canvasHeight * 0.15;
    const windowW = this.canvasWidth * 0.25;
    const windowH = this.canvasHeight * 0.3;
    
    // 窗框
    ctx.strokeStyle = 'rgba(40, 40, 50, 0.8)';
    ctx.lineWidth = 4;
    ctx.strokeRect(windowX, windowY, windowW, windowH);
    
    // 窗棂 (十字分割)
    ctx.lineWidth = 2;
    // 竖线
    ctx.beginPath();
    ctx.moveTo(windowX + windowW / 2, windowY);
    ctx.lineTo(windowX + windowW / 2, windowY + windowH);
    ctx.stroke();
    // 横线
    ctx.beginPath();
    ctx.moveTo(windowX, windowY + windowH / 2);
    ctx.lineTo(windowX + windowW, windowY + windowH / 2);
    ctx.stroke();
    
    // 窗外月光 (呼吸效果)
    const moonlightAlpha = this.moonBrightness * 0.3;
    ctx.fillStyle = `rgba(200, 200, 150, ${moonlightAlpha})`;
    ctx.fillRect(windowX, windowY, windowW, windowH);
  }
  
  // 绘制李白剪影 (增强版 - 更明显)
  private drawLibaiSilhouette(ctx: CanvasRenderingContext2D): void {
    const centerX = this.canvasWidth * 0.5; // 调整位置，站在窗户右侧
    const bottomY = this.canvasHeight * 0.8; // 调整高度
    
    ctx.save();
    ctx.globalAlpha = this.libaiAlpha;
    ctx.fillStyle = 'rgba(10, 10, 20, 0.95)'; // 更深的黑色
    
    // 头部 - 更大
    ctx.beginPath();
    ctx.arc(centerX, bottomY - 90, 20, 0, Math.PI * 2); // 半径从15增加到20
    ctx.fill();
    
    // 头巾 (古代文人形象)
    ctx.beginPath();
    ctx.moveTo(centerX - 22, bottomY - 90);
    ctx.lineTo(centerX - 18, bottomY - 100);
    ctx.lineTo(centerX + 18, bottomY - 100);
    ctx.lineTo(centerX + 22, bottomY - 90);
    ctx.closePath();
    ctx.fill();
    
    // 身体 - 更宽
    ctx.beginPath();
    ctx.moveTo(centerX - 30, bottomY - 70); // 从-20增加到-30
    ctx.lineTo(centerX - 35, bottomY);
    ctx.lineTo(centerX + 35, bottomY);
    ctx.lineTo(centerX + 30, bottomY - 70);
    ctx.closePath();
    ctx.fill();
    
    // 左臂 (低头思故乡的姿态)
    ctx.beginPath();
    ctx.moveTo(centerX - 30, bottomY - 65);
    ctx.lineTo(centerX - 50, bottomY - 50);
    ctx.lineTo(centerX - 45, bottomY - 30);
    ctx.closePath();
    ctx.fill();
    
    // 右臂 (抱臂姿态)
    ctx.beginPath();
    ctx.moveTo(centerX + 30, bottomY - 65);
    ctx.lineTo(centerX + 45, bottomY - 55);
    ctx.lineTo(centerX + 40, bottomY - 35);
    ctx.closePath();
    ctx.fill();
    
    // 添加轮廓发光效果
    ctx.strokeStyle = `rgba(200, 200, 150, ${this.libaiAlpha * 0.3})`;
    ctx.lineWidth = 2;
    ctx.stroke();
    
    ctx.restore();
  }
  
  // 绘制孤雁
  private drawGoose(ctx: CanvasRenderingContext2D): void {
    ctx.save();
    ctx.globalAlpha = 0.6;
    ctx.strokeStyle = 'rgba(100, 100, 120, 0.8)';
    ctx.lineWidth = 2;
    
    // V字形的雁形
    ctx.beginPath();
    ctx.moveTo(this.gooseX - 8, this.gooseY - 5);
    ctx.lineTo(this.gooseX, this.gooseY);
    ctx.lineTo(this.gooseX + 8, this.gooseY - 5);
    ctx.stroke();
    
    ctx.restore();
  }
  
  // 绘制远山视差层 (春江花月夜)
  private drawMountainLayers(ctx: CanvasRenderingContext2D): void {
    // 远山层 - 颜色更暗、更靠上
    ctx.fillStyle = 'rgba(20, 40, 70, 0.6)';
    ctx.beginPath();
    ctx.moveTo(0, this.canvasHeight * 0.35);
    ctx.lineTo(this.canvasWidth * 0.25, this.canvasHeight * 0.3);
    ctx.lineTo(this.canvasWidth * 0.5, this.canvasHeight * 0.33);
    ctx.lineTo(this.canvasWidth * 0.75, this.canvasHeight * 0.28);
    ctx.lineTo(this.canvasWidth, this.canvasHeight * 0.32);
    ctx.lineTo(this.canvasWidth, this.canvasHeight);
    ctx.lineTo(0, this.canvasHeight);
    ctx.closePath();
    ctx.fill();

    // 中山层 - 颜色略亮
    ctx.fillStyle = 'rgba(30, 60, 100, 0.5)';
    ctx.beginPath();
    ctx.moveTo(0, this.canvasHeight * 0.45);
    ctx.lineTo(this.canvasWidth * 0.2, this.canvasHeight * 0.4);
    ctx.lineTo(this.canvasWidth * 0.45, this.canvasHeight * 0.43);
    ctx.lineTo(this.canvasWidth * 0.7, this.canvasHeight * 0.38);
    ctx.lineTo(this.canvasWidth, this.canvasHeight * 0.42);
    ctx.lineTo(this.canvasWidth, this.canvasHeight);
    ctx.lineTo(0, this.canvasHeight);
    ctx.closePath();
    ctx.fill();

    // 近山层 - 颜色最亮
    ctx.fillStyle = 'rgba(40, 80, 130, 0.4)';
    ctx.beginPath();
    ctx.moveTo(0, this.canvasHeight * 0.55);
    ctx.lineTo(this.canvasWidth * 0.18, this.canvasHeight * 0.5);
    ctx.lineTo(this.canvasWidth * 0.4, this.canvasHeight * 0.53);
    ctx.lineTo(this.canvasWidth * 0.65, this.canvasHeight * 0.49);
    ctx.lineTo(this.canvasWidth, this.canvasHeight * 0.52);
    ctx.lineTo(this.canvasWidth, this.canvasHeight);
    ctx.lineTo(0, this.canvasHeight);
    ctx.closePath();
    ctx.fill();
  }

  // 绘制潮水 (潮汐引力 + 朗诵音量模拟)
  private drawTideWater(ctx: CanvasRenderingContext2D): void {
    const baseY = this.canvasHeight * 0.75;
    const tide = baseY - this.tideHeight * 60; // 潮水高度改变
    ctx.fillStyle = 'rgba(61, 127, 166, 0.4)';
    ctx.beginPath();
    ctx.moveTo(0, tide);
    for (let x = 0; x <= this.canvasWidth; x += 8) {
      const y = tide + Math.sin((x + this.waveOffset * 120) * 0.02) * 8;
      ctx.lineTo(x, y);
    }
    ctx.lineTo(this.canvasWidth, this.canvasHeight);
    ctx.lineTo(0, this.canvasHeight);
    ctx.closePath();
    ctx.fill();
  }

  // 绘制雪山剪影 (江雪)
  private drawSnowMountains(ctx: CanvasRenderingContext2D): void {
    ctx.fillStyle = 'rgba(255, 255, 255, 0.1)';
    
    // 远山
    ctx.beginPath();
    ctx.moveTo(0, this.canvasHeight * 0.6);
    ctx.lineTo(this.canvasWidth * 0.3, this.canvasHeight * 0.4);
    ctx.lineTo(this.canvasWidth * 0.5, this.canvasHeight * 0.5);
    ctx.lineTo(this.canvasWidth * 0.7, this.canvasHeight * 0.35);
    ctx.lineTo(this.canvasWidth, this.canvasHeight * 0.55);
    ctx.lineTo(this.canvasWidth, this.canvasHeight);
    ctx.lineTo(0, this.canvasHeight);
    ctx.closePath();
    ctx.fill();
    
    // 小船 - 孤舟蓑笠翁
    const boatX = this.canvasWidth * 0.7;
    const boatY = this.canvasHeight * 0.8;
    ctx.fillStyle = 'rgba(80, 80, 80, 0.6)';
    ctx.beginPath();
    ctx.moveTo(boatX - 15, boatY);
    ctx.lineTo(boatX + 15, boatY);
    ctx.lineTo(boatX + 10, boatY + 5);
    ctx.lineTo(boatX - 10, boatY + 5);
    ctx.closePath();
    ctx.fill();
  }

  // 绘制秋天枯树 (秋思)
  private drawAutumnTrees(ctx: CanvasRenderingContext2D): void {
    // 调用完整的秋思场景
    this.drawAutumnDuskScene(ctx);
  }
  
  // 绘制天净沙·秋思完整场景 (黄昏古道)
  private drawAutumnDuskScene(ctx: CanvasRenderingContext2D): void {
    ctx.save();
    
    // 1. 绘制卷轴背景 (横向滚动)
    ctx.translate(-this.scrollOffset, 0);
    
    // 2. 绘制夕阳
    const sunX: number = this.canvasWidth * 0.8 + this.scrollOffset;
    const sunY: number = this.canvasHeight * (0.2 + this.sunsetProgress * 0.3); // 下沉
    const sunRadius: number = 40;
    
    const sunGradient = ctx.createRadialGradient(sunX, sunY, 0, sunX, sunY, sunRadius);
    sunGradient.addColorStop(0, 'rgba(255, 150, 50, 0.9)');
    sunGradient.addColorStop(0.7, 'rgba(255, 100, 30, 0.6)');
    sunGradient.addColorStop(1, 'rgba(255, 80, 20, 0)');
    ctx.fillStyle = sunGradient;
    ctx.beginPath();
    ctx.arc(sunX, sunY, sunRadius, 0, Math.PI * 2);
    ctx.fill();
    
    // 3. 绘制枯藤老树
    const treeX: number = this.canvasWidth * 0.2 + this.scrollOffset;
    this.drawDeadTree(ctx, treeX, this.canvasHeight * 0.7, 60);
    
    // 4. 绘制昏鸦
    if (this.crowEyeOpen || this.crowsFlying) {
      this.drawCrows(ctx, treeX + 20, this.canvasHeight * 0.5);
    }
    
    // 5. 绘制小桥流水
    const bridgeX: number = this.canvasWidth * 0.5 + this.scrollOffset;
    this.drawBridgeAndWater(ctx, bridgeX, this.canvasHeight * 0.75);
    
    // 6. 绘制古道西风瘦马
    const horseX: number = this.canvasWidth * 0.7 + this.scrollOffset;
    this.drawHorse(ctx, horseX, this.canvasHeight * 0.65);
    
    ctx.restore();
    
    // 7. 绘制暗角 (不受卷轴影响)
    if (this.vignetteAlpha > 0) {
      this.drawVignette(ctx);
    }
    
    // 8. 绘制文字特效
    if (this.tianyaText) {
      this.drawTianyaText(ctx);
    }
    
    if (this.duanchangText) {
      this.drawDuanchangText(ctx);
    }
  }
  
  // 绘制枯树
  private drawDeadTree(ctx: CanvasRenderingContext2D, x: number, y: number, height: number): void {
    ctx.strokeStyle = 'rgba(60, 40, 30, 0.8)';
    ctx.lineWidth = 4;
    
    // 树干
    ctx.beginPath();
    ctx.moveTo(x, y);
    ctx.lineTo(x, y - height);
    ctx.stroke();
    
    // 枯藤缠绕
    ctx.strokeStyle = 'rgba(80, 60, 40, 0.6)';
    ctx.lineWidth = 2;
    for (let i = 0; i < 3; i++) {
      ctx.beginPath();
      ctx.moveTo(x - 5, y - i * 20);
      ctx.bezierCurveTo(
        x + 10, y - i * 20 - 10,
        x - 10, y - i * 20 - 20,
        x + 5, y - i * 20 - 30
      );
      ctx.stroke();
    }
    
    // 枝权
    const branchCount: number = 4;
    ctx.strokeStyle = 'rgba(60, 40, 30, 0.7)';
    ctx.lineWidth = 3;
    for (let i = 0; i < branchCount; i++) {
      const branchY: number = y - height * (0.4 + i * 0.2);
      const branchLength: number = height * (0.4 - i * 0.08);
      
      ctx.beginPath();
      ctx.moveTo(x, branchY);
      ctx.lineTo(x - branchLength, branchY - branchLength * 0.3);
      ctx.stroke();
      
      ctx.beginPath();
      ctx.moveTo(x, branchY);
      ctx.lineTo(x + branchLength * 0.7, branchY - branchLength * 0.4);
      ctx.stroke();
    }
  }
  
  // 绘制乌鸦
  private drawCrows(ctx: CanvasRenderingContext2D, x: number, y: number): void {
    const crowCount: number = 3;
    
    for (let i = 0; i < crowCount; i++) {
      const crowX: number = x + i * 25;
      const crowY: number = y + Math.sin(Date.now() * 0.003 + i) * 5;
      
      ctx.fillStyle = 'rgba(20, 20, 20, 0.9)';
      
      if (this.crowsFlying) {
        // 飞行状态
        const flyOffset: number = (Date.now() * 0.1 + i * 100) % this.canvasWidth;
        const finalX: number = crowX + flyOffset;
        const finalY: number = crowY - flyOffset * 0.3;
        
        // 简化的飞鸟形状
        ctx.beginPath();
        ctx.moveTo(finalX - 8, finalY);
        ctx.lineTo(finalX - 3, finalY - 3);
        ctx.lineTo(finalX, finalY);
        ctx.lineTo(finalX + 3, finalY - 3);
        ctx.lineTo(finalX + 8, finalY);
        ctx.stroke();
      } else {
        // 停止状态
        ctx.beginPath();
        ctx.arc(crowX, crowY, 4, 0, Math.PI * 2);
        ctx.fill();
        
        // 睡眼 (红点)
        if (this.crowEyeOpen) {
          ctx.fillStyle = 'rgba(255, 0, 0, 0.9)';
          ctx.beginPath();
          ctx.arc(crowX + 2, crowY, 1.5, 0, Math.PI * 2);
          ctx.fill();
        }
      }
    }
  }
  
  // 绘制小桥和流水
  private drawBridgeAndWater(ctx: CanvasRenderingContext2D, x: number, y: number): void {
    // 小桥
    ctx.strokeStyle = 'rgba(100, 80, 60, 0.7)';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(x, y, 40, Math.PI, 0);
    ctx.stroke();
    
    // 流水区域
    const waterY: number = y + 10;
    const waterWidth: number = 120;
    const waterHeight: number = 30;
    
    // 绘制水面渐变
    const waterGradient = ctx.createLinearGradient(x - waterWidth/2, waterY, x - waterWidth/2, waterY + waterHeight);
    waterGradient.addColorStop(0, 'rgba(100, 150, 180, 0.4)');
    waterGradient.addColorStop(1, 'rgba(80, 130, 160, 0.5)');
    ctx.fillStyle = waterGradient;
    ctx.fillRect(x - waterWidth/2, waterY, waterWidth, waterHeight);
    
    // 水波纹效果 (横向波浪线)
    if (this.waterRipple > 0) {
      ctx.save();
      
      // 绘制多层波纹线
      for (let i = 0; i < 5; i++) {
        const waveY: number = waterY + 5 + i * 6;
        const amplitude: number = 2 + i * 0.5; // 波浪振幅
        const frequency: number = 0.1; // 波浪频率
        const phase: number = this.waveOffset * 2 + i * 0.5; // 相位偏移
        const alpha: number = (0.5 - i * 0.08) * this.waterRipple;
        
        ctx.strokeStyle = `rgba(150, 200, 220, ${alpha})`;
        ctx.lineWidth = 1.5;
        ctx.beginPath();
        
        // 绘制波浪曲线
        for (let wx = x - waterWidth/2; wx <= x + waterWidth/2; wx += 2) {
          const wy = waveY + Math.sin((wx - x) * frequency + phase) * amplitude;
          if (wx === x - waterWidth/2) {
            ctx.moveTo(wx, wy);
          } else {
            ctx.lineTo(wx, wy);
          }
        }
        ctx.stroke();
      }
      
      // 添加一些波光点
      for (let i = 0; i < 8; i++) {
        const dotX: number = x - waterWidth/2 + Math.random() * waterWidth;
        const dotY: number = waterY + Math.random() * waterHeight;
        const dotSize: number = 1 + Math.random() * 2;
        const dotAlpha: number = Math.random() * 0.4 * this.waterRipple;
        
        ctx.fillStyle = `rgba(200, 230, 250, ${dotAlpha})`;
        ctx.beginPath();
        ctx.arc(dotX, dotY, dotSize, 0, Math.PI * 2);
        ctx.fill();
      }
      
      ctx.restore();
    }
  }
  
  // 绘制瘦马
  private drawHorse(ctx: CanvasRenderingContext2D, x: number, y: number): void {
    ctx.fillStyle = 'rgba(80, 60, 40, 0.8)';
    
    // 马身
    ctx.fillRect(x - 20, y - 15, 40, 20);
    
    // 马头
    ctx.beginPath();
    ctx.arc(x + 20, y - 20, 8, 0, Math.PI * 2);
    ctx.fill();
    
    // 马腿
    ctx.fillRect(x - 15, y + 5, 4, 15);
    ctx.fillRect(x - 5, y + 5, 4, 15);
    ctx.fillRect(x + 5, y + 5, 4, 15);
    ctx.fillRect(x + 15, y + 5, 4, 15);
    
    // 马尾 (如果停下则扫出天涯)
    if (this.horseStop) {
      ctx.strokeStyle = 'rgba(100, 80, 60, 0.6)';
      ctx.lineWidth = 2;
      ctx.beginPath();
      ctx.moveTo(x - 20, y - 5);
      ctx.quadraticCurveTo(x - 40, y - 10, x - 50, y + 5);
      ctx.stroke();
    }
  }
  
  // 绘制暗角
  private drawVignette(ctx: CanvasRenderingContext2D): void {
    const gradient = ctx.createRadialGradient(
      this.canvasWidth / 2, this.canvasHeight / 2, this.canvasHeight * 0.3,
      this.canvasWidth / 2, this.canvasHeight / 2, this.canvasHeight * 0.8
    );
    gradient.addColorStop(0, 'rgba(0, 0, 0, 0)');
    gradient.addColorStop(1, `rgba(0, 0, 0, ${this.vignetteAlpha})`);
    
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, this.canvasWidth, this.canvasHeight);
  }
  
  // 绘制"天涯"文字
  private drawTianyaText(ctx: CanvasRenderingContext2D): void {
    ctx.save();
    ctx.font = 'bold 50px serif';
    ctx.fillStyle = `rgba(150, 120, 80, ${1.0 - (Date.now() % 3000) / 3000})`; // 渐隐效果
    ctx.textAlign = 'center';
    ctx.fillText('天涯', this.canvasWidth * 0.75, this.canvasHeight * 0.5);
    ctx.restore();
  }
  
  // 绘制"断肠人在天涯"残影
  private drawDuanchangText(ctx: CanvasRenderingContext2D): void {
    ctx.save();
    ctx.font = 'bold 40px serif';
    ctx.fillStyle = 'rgba(200, 150, 100, 0.5)';
    ctx.textAlign = 'center';
    ctx.shadowColor = 'rgba(255, 100, 50, 0.6)';
    ctx.shadowBlur = 15;
    ctx.fillText('断肠人在天涯', this.canvasWidth * 0.5, this.canvasHeight * 0.4);
    ctx.restore();
  }

  // 绘制水貃歌头场景 (中秋夜)
  private drawMoonPalace(ctx: CanvasRenderingContext2D): void {
    // 1. 绘制海面 (下半部分)
    const seaY = this.canvasHeight * 0.65;
    const seaGradient = ctx.createLinearGradient(0, seaY, 0, this.canvasHeight);
    seaGradient.addColorStop(0, 'rgba(20, 40, 80, 0.6)'); // 深蓝海面
    seaGradient.addColorStop(1, 'rgba(10, 20, 50, 0.8)'); // 更深的海水
    ctx.fillStyle = seaGradient;
    ctx.fillRect(0, seaY, this.canvasWidth, this.canvasHeight - seaY);
    
    // 2. 绘制海面波纹 (扩散圆)
    this.seaWavePhase += 0.01;
    for (let i = 0; i < 5; i++) {
      const x = this.canvasWidth * (0.2 + i * 0.15);
      const y = seaY + 20 + Math.sin(this.seaWavePhase + i) * 10;
      const size = 30 + Math.sin(this.seaWavePhase * 2 + i) * 15;
      ctx.strokeStyle = `rgba(100, 150, 200, 0.2)`;
      ctx.lineWidth = 2;
      ctx.beginPath();
      ctx.arc(x, y, size, 0, Math.PI * 2);
      ctx.stroke();
    }
    
    // 3. 绘制月宫虚影 (半透明)
    if (this.palaceAlpha > 0) {
      const moonX = this.moonX * this.canvasWidth;
      const moonY = this.moonY * this.canvasHeight;
      ctx.save();
      ctx.globalAlpha = this.palaceAlpha;
      ctx.strokeStyle = 'rgba(200, 200, 220, 0.6)';
      ctx.lineWidth = 2;
      
      // 绘制简单的宫殿轮廓
      const palaceW = 80;
      const palaceH = 50;
      ctx.strokeRect(moonX - palaceW/2, moonY - 30, palaceW, palaceH);
      // 屋顶
      ctx.beginPath();
      ctx.moveTo(moonX - palaceW/2 - 10, moonY - 30);
      ctx.lineTo(moonX, moonY - 50);
      ctx.lineTo(moonX + palaceW/2 + 10, moonY - 30);
      ctx.stroke();
      
      ctx.restore();
    }
    
    // 4. 绘制嫦娥剪影 (掉过)
    if (this.changEAlpha > 0) {
      ctx.save();
      ctx.globalAlpha = this.changEAlpha;
      ctx.fillStyle = 'rgba(255, 255, 255, 0.6)';
      const eX = this.canvasWidth * 0.6;
      const eY = this.canvasHeight * 0.3;
      // 简单的人形剪影
      ctx.beginPath();
      ctx.arc(eX, eY, 8, 0, Math.PI * 2);
      ctx.fill();
      ctx.fillRect(eX - 10, eY + 8, 20, 30);
      ctx.restore();
    }
    
    // 5. 绘制苏轼举杯
    if (this.suShiAlpha > 0) {
      const sX = this.canvasWidth * 0.2;
      const sY = this.canvasHeight * 0.5;
      
      ctx.save();
      ctx.globalAlpha = this.suShiAlpha;
      ctx.fillStyle = 'rgba(50, 50, 70, 0.9)';
      
      // 头部
      ctx.beginPath();
      ctx.arc(sX, sY, 15, 0, Math.PI * 2);
      ctx.fill();
      
      // 身体
      ctx.fillRect(sX - 20, sY + 15, 40, 60);
      
      // 举起的手臂 (拿杯)
      ctx.beginPath();
      ctx.moveTo(sX + 20, sY + 20);
      ctx.lineTo(sX + 40, sY - 10);
      ctx.lineWidth = 8;
      ctx.strokeStyle = 'rgba(50, 50, 70, 0.9)';
      ctx.stroke();
      
      ctx.restore();
      
      // 绘制酒杯
      if (this.cupAlpha > 0) {
        ctx.save();
        ctx.globalAlpha = this.cupAlpha;
        ctx.fillStyle = 'rgba(180, 150, 100, 0.8)'; // 金色杯子
        ctx.fillRect(sX + 35, sY - 15, 12, 18);
        // 杯中酒水 (反射星空)
        ctx.fillStyle = 'rgba(100, 100, 150, 0.6)';
        ctx.fillRect(sX + 37, sY - 13, 8, 10);
        ctx.restore();
      }
    }
    
    // 6. 绘制多重影 (起舞弄清影)
    if (this.shadowCount === 3) {
      const centerX = this.canvasWidth * 0.5;
      const centerY = this.canvasHeight * 0.5;
      
      for (let i = 0; i < 3; i++) {
        const angle = (this.shadowRotation + i * 120) * Math.PI / 180;
        const offsetX = Math.cos(angle) * 50;
        const offsetY = Math.sin(angle) * 30;
        
        ctx.save();
        ctx.globalAlpha = 0.4;
        ctx.fillStyle = 'rgba(100, 100, 150, 0.5)';
        const x = centerX + offsetX;
        const y = centerY + offsetY;
        
        // 简化的人形
        ctx.beginPath();
        ctx.arc(x, y, 12, 0, Math.PI * 2);
        ctx.fill();
        ctx.fillRect(x - 15, y + 12, 30, 40);
        ctx.restore();
      }
    }
    
    // 7. 绘制时间隧道倒计时
    if (this.timeCountdown > 0) {
      const moonX = this.moonX * this.canvasWidth;
      const moonY = this.moonY * this.canvasHeight;
      
      ctx.save();
      ctx.font = 'bold 60px sans-serif';
      ctx.fillStyle = 'rgba(255, 100, 100, 0.8)';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(this.timeCountdown.toString(), moonX, moonY);
      ctx.restore();
    }
    
    // 8. 绘制孔明灯
    this.drawLanterns(ctx);
    
    // 9. 绘制烟花文字 (但愿人长久)
    if (this.lanternBurst) {
      const centerX: number = this.canvasWidth * 0.5;
      const centerY: number = this.canvasHeight * 0.3 - 20; // 往上移20像素
      const spacing: number = 80;
      
      ctx.save();
      ctx.font = 'bold 80px serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      
      // 红色发光效果
      ctx.shadowColor = 'rgba(255, 0, 0, 0.8)';
      ctx.shadowBlur = 20;
      ctx.fillStyle = 'rgba(255, 50, 50, 1.0)'; // 红色
      
      // 绘制"长"字
      ctx.fillText('长', centerX - spacing, centerY);
      // 绘制"久"字
      ctx.fillText('久', centerX + spacing, centerY);
      
      ctx.restore();
    }
  }
  
  // 绘制孔明灯
  private drawLanterns(ctx: CanvasRenderingContext2D): void {
    this.lanterns.forEach(lantern => {
      ctx.save();
      ctx.globalAlpha = lantern.alpha;
      
      // 灯笼本体
      const gradient = ctx.createRadialGradient(
        lantern.x, lantern.y, 0,
        lantern.x, lantern.y, lantern.size
      );
      gradient.addColorStop(0, lantern.color);
      gradient.addColorStop(1, 'rgba(255, 200, 100, 0)');
      
      ctx.fillStyle = gradient;
      ctx.beginPath();
      ctx.arc(lantern.x, lantern.y, lantern.size, 0, Math.PI * 2);
      ctx.fill();
      
      // 爆炸效果
      if (lantern.isExploding) {
        ctx.strokeStyle = `rgba(255, 150, 50, ${1 - lantern.explodeProgress})`;
        ctx.lineWidth = 3;
        ctx.beginPath();
        ctx.arc(lantern.x, lantern.y, lantern.size * (1 + lantern.explodeProgress * 2), 0, Math.PI * 2);
        ctx.stroke();
      }
      
      ctx.restore();
    });
  }

  // 绘制粒子
  private drawParticles(ctx: CanvasRenderingContext2D): void {
    this.particles.forEach((p: Particle) => {
      ctx.save();
      ctx.globalAlpha = p.alpha * p.life * this.particleOpacity;
      ctx.fillStyle = p.color;
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
      ctx.fill();
      ctx.restore();
    });
  }

  // 动画循环
  private startAnimation(): void {
    const animate = (): void => {
      if (this.animationId === -1) {
        return; // 已停止动画
      }
      
      // 更新粒子
      this.updateParticles();
      
      // 静夜思特殊动画
      const poem = this.livePoems[this.currentPoemIndex];
      if (poem.scene === 'night_moon') {
        // 呼吸效果 (30% - 70% - 30%)
        this.breathePhase += 0.02;
        this.moonBrightness = 0.3 + Math.sin(this.breathePhase) * 0.2 + 0.2;
        
        // 孤雁飞行 (偶尔出现)
        if (!this.showGoose && Math.random() < 0.001) {
          this.showGoose = true;
          this.gooseX = -50;
          this.gooseY = this.canvasHeight * (0.2 + Math.random() * 0.2);
        }
        
        if (this.showGoose) {
          this.gooseX += 3;
          this.gooseY += Math.sin(this.gooseX * 0.05) * 0.5;
          if (this.gooseX > this.canvasWidth + 50) {
            this.showGoose = false;
          }
        }
      } else if (poem.scene === 'river_moon') {
        // 春江花月夜特殊动画
        // 潮汐引力动画 (20秒周期)
        this.tidePhase += 0.005 * this.timeAcceleration; // 可加速
        if (this.tidePhase > Math.PI * 2) {
          this.tidePhase = 0;
        }
        // 潮水高度: 0 -> 1 -> 0 (正弦波)
        this.tideHeight = (Math.sin(this.tidePhase) + 1) * 0.5;
      } else if (poem.scene === 'moon_palace') {
        // 水调歌头 - 更新孔明灯
        this.updateLanterns();
      }
      
      // 绘制场景
      this.drawScene();
      
      // 使用setTimeout模拟r requestAnimationFrame (HarmonyOS)
      setTimeout(() => {
        animate();
      }, 16); // 约60fps
    };
    this.animationId = 1; // 设置为非-1表示动画运行中
    animate();
  }

  // 触摸手势处理
  private onTouchMove(event: TouchEvent): void {
    const poem = this.livePoems[this.currentPoemIndex];
    
    console.log('Touch event type:', event.type, 'scene:', poem.scene);
    
    if (event.touches.length > 0 && this.canvasWidth > 0) {
      const touch = event.touches[0];
      
      // 静夜思 - 不处理触摸，由朗诵打点控制
      if (poem.scene === 'night_moon') {
        console.log('night_moon - no manual interaction, controlled by recitation');
      } else if (poem.scene === 'river_moon') {
        // 春江花月夜 - 不处理触摸，月亮由动画控制
        console.log('river_moon - no manual interaction');
      } else if (poem.scene === 'moon_palace') {
        // 水调歌头 - 点击添加孔明灯
        if (event.type === TouchType.Down) {
          this.addLantern(touch.x, touch.y);
          console.log('🏮 添加孔明灯 at:', touch.x, touch.y);
        }
      } else {
        // 其他场景 - 普通拖动月亮
        if (event.type === TouchType.Move || event.type === TouchType.Down) {
          this.moonX = touch.x / this.canvasWidth;
          this.moonY = touch.y / this.canvasHeight;
          
          // 限制范围
          this.moonX = Math.max(0.1, Math.min(0.9, this.moonX));
          this.moonY = Math.max(0.1, Math.min(0.6, this.moonY));
        }
      }
    }
  }

  // 切换诗词
  private switchPoem(delta: number): void {
    const newIndex = this.currentPoemIndex + delta;
    if (newIndex >= 0 && newIndex < this.livePoems.length) {
      this.currentPoemIndex = newIndex;
      this.isPlaying = false;
      
      // 重置静夜思状态
      this.moonScale = 1.0;
      this.libaiAlpha = 0;
      this.highlightFrost = false;
      this.moonBrightness = 0.5;
      
      // 重置春江花月夜状态
      this.moonAngle = 0;
      this.tideHeight = 0;
      this.moonPhase = 0;
      this.lightPathAlpha = 0;
      this.boatAlpha = 0;
      this.mapVisible = false;
      this.tidePhase = 0;
      this.timeAcceleration = 1.0;
      
      // 重置月亮位置
      this.moonX = 0.7;
      this.moonY = 0.3;
      
      // 重新初始化粒子
      this.initParticles();
      
      // 停止当前朗诵
      if (this.isInit) {
        TextReader.stop();
      }
    }
  }
  
  // 获取诗句样式 (用于build方法)
  private getLineStyle(line: string): LineStyle {
    const isNightMoon = this.livePoems[this.currentPoemIndex].scene === 'night_moon';
    const isFrostLine = line.includes('疑是地上霜');
    const shouldHighlight = isNightMoon && this.highlightFrost && isFrostLine;
    const shouldDim = isNightMoon && this.highlightFrost && !isFrostLine;
    
    const result: LineStyle = {
      fontSize: shouldHighlight ? 22 : 18,
      fontColor: shouldHighlight ? '#FFD700' : $r('app.color.text_primary'),
      fontWeight: shouldHighlight ? FontWeight.Bold : FontWeight.Normal,
      opacity: shouldDim ? 0.2 : 1.0
    };
    
    return result;
  }

  build() {
    Scroll() {
      Column() {
        // Canvas画布层 - 固定高度
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .backgroundColor('#1a1a2e')
            .onReady(() => {
              console.log('Canvas onReady called');
              // 直接使用context的宽高
              this.canvasWidth = this.context.width;
              this.canvasHeight = this.context.height;
              
              console.log('Canvas size:', this.canvasWidth, 'x', this.canvasHeight);
              
              // 如果尺寸为0，使用默认值
              if (this.canvasWidth === 0 || this.canvasHeight === 0) {
                // 获取屏幕尺寸作为默认值
                this.canvasWidth = 360; // 默认宽度
                this.canvasHeight = 500; // 默认高度
                console.log('Using default size:', this.canvasWidth, 'x', this.canvasHeight);
              }
              
              // 初始化粒子
              this.initParticles();
              
              // 立即绘制一次
              this.drawScene();
              
              // 开始动画循环
              this.startAnimation();
            })
            .onTouch((event: TouchEvent) => {
              this.onTouchMove(event);
            })
        }
        .width('100%')
        .height(500)  // 固定高度500px
        
        // 诗词内容显示
        Column() {
        // 顶部返回和标题
        Row() {
          Image($r('sys.symbol.chevron_left'))
            .width(24)
            .height(24)
            .fillColor($r('app.color.text_primary'))
            .onClick(() => {
              router.back();
            })
          
          Text('诗词')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          
          Text('   ')
            .width(24)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 8 })
        
        Blank()
        
        // 诗词内容区域
        Column() {
          // 诗词标题和作者
          Text(this.livePoems[this.currentPoemIndex].title)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ bottom: 8 })
          
          Text(`【${this.livePoems[this.currentPoemIndex].type === 'tang' ? '唐' : 
                 this.livePoems[this.currentPoemIndex].type === 'song' ? '宋' : '元'}】${this.livePoems[this.currentPoemIndex].author}`)
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ bottom: 20 })
          
          // 诗词内容
          Column() {
            ForEach(this.livePoems[this.currentPoemIndex].content.split('\n'), 
              (line: string, lineIndex: number) => {
                Text(line)
                  .fontSize(this.getLineStyle(line).fontSize)
                  .fontColor(this.getLineStyle(line).fontColor)
                  .fontWeight(this.getLineStyle(line).fontWeight)
                  .margin({ bottom: 12 })
                  .textAlign(TextAlign.Center)
                  .opacity(this.getLineStyle(line).opacity)
                  .animation({
                    duration: 300,
                    curve: Curve.EaseInOut
                  })
              })
          }
          .width('100%')
          
          // 控制按钮区域
          Row() {
            // 上一首
            Button('上一首')
              .fontSize(14)
              .fontColor($r('app.color.text_primary'))
              .backgroundColor($r('app.color.card_background'))
              .width(80)
              .height(50)
              .borderRadius(25)
              .enabled(this.currentPoemIndex > 0)
              .opacity(this.currentPoemIndex > 0 ? 1 : 0.3)
              .onClick(() => {
                this.switchPoem(-1);
              })
            
            Blank()
              .width(20)
            
            // 播放/暂停
            Button(this.isPlaying ? '暂停' : '播放')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .backgroundColor($r('app.color.accent_positive'))
              .width(100)
              .height(60)
              .borderRadius(30)
              .onClick(() => {
                this.togglePlay();
              })
            
            Blank()
              .width(20)
            
            // 下一首
            Button('下一首')
              .fontSize(14)
              .fontColor($r('app.color.text_primary'))
              .backgroundColor($r('app.color.card_background'))
              .width(80)
              .height(50)
              .borderRadius(25)
              .enabled(this.currentPoemIndex < this.livePoems.length - 1)
              .opacity(this.currentPoemIndex < this.livePoems.length - 1 ? 1 : 0.3)
              .onClick(() => {
                this.switchPoem(1);
              })
          }
          .justifyContent(FlexAlign.Center)
          .padding({ top: 24 })
          
          // 提示文字
          Text(this.livePoems[this.currentPoemIndex].scene === 'night_moon' ? 
            '🌙 静夜思：点击播放观看朗诵动画  | 月光爆发、李白出现' :
            this.livePoems[this.currentPoemIndex].scene === 'river_moon' ?
            '🌊 春江花月夜：点击播放启动动画 | 潮汐引力、月光路径' :
            '👆 点击播放启动朗诵观看粒子画卷')
            .fontSize(12)
            .fontColor($r('app.color.text_tertiary'))
            .fontStyle(FontStyle.Italic)
            .margin({ top: 16 })
            .opacity(0.8)
        }
        .width('100%')
        .padding(24)
        .backgroundColor($r('app.color.page_background'))
        .borderRadius({ topLeft: 24, topRight: 24 })
      }
      .width('100%')
    }
    .width('100%')
  }
  .scrollable(ScrollDirection.Vertical)
  .scrollBar(BarState.Auto)
  .edgeEffect(EdgeEffect.Spring)
  .width('100%')
  .height('100%')
  .backgroundColor($r('app.color.page_background'))
}
}
