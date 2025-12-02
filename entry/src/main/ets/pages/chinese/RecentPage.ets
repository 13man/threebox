import router from '@ohos.router';
import { common } from '@kit.AbilityKit';
import promptAction from '@ohos.promptAction';
import { TextReader, ReadStateCode } from '@kit.SpeechKit';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import { GlobalContext } from '../common/GlobalContext';

// 定义唐诗接口
interface Poem {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string;
  dynasty?: string;
  category?: string;
}

@Entry
@Component
struct RecentPage {
  // 状态栏高度
  @State private statusBarHeight: number = 0;
  // 页面加载状态
  @State private isPageLoaded: boolean = false;
  // 最近浏览的诗歌列表
  @State private recentPoems: Array<Poem> = [];
  // 朗读状态
  @State private isPlaying: boolean = false;
  @State private readState: ReadStateCode = ReadStateCode.WAITING;
  @State private isInit: boolean = false;
  // 视图模式
  @State private viewMode: string = 'list'; // list, grid

  aboutToAppear(): void {
    // 获取状态栏高度
    try {
      const context = getContext(this) as common.UIAbilityContext;
      window.getLastWindow(context).then((windowClass) => {
        this.statusBarHeight = 24; // 默认状态栏高度
      }).catch((error: BusinessError) => {
        console.error('获取状态栏高度失败:', error);
        this.statusBarHeight = 24;
      });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
      console.error('获取状态栏高度失败:', e);
      this.statusBarHeight = 24;
    }
    
    // 获取最近浏览的诗歌列表
    this.loadRecentPoems();
    
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 50);
    
    // 初始化TextReader
    this.initTextReader();
  }

  aboutToDisappear(): void {
    // 页面销毁时停止朗读并释放资源
    try {
      TextReader.stop();
      TextReader.release().then(() => {
        console.log('TextReader资源释放成功');
      }).catch((error: Error) => {
        console.error('TextReader资源释放失败:', error);
      });
      this.isPlaying = false;
      this.isInit = false;
    } catch (error) {
      console.error('停止朗读失败:', error);
    }
  }

  // 加载最近浏览的诗歌列表
  private loadRecentPoems(): void {
    try {
      const params = router.getParams() as Record<string, Object>;
      const recentIds = params?.recentPoems as string;
      
      if (recentIds) {
        const ids = JSON.parse(recentIds) as number[];
        
        // 从全局上下文获取诗歌列表
        const globalContext = GlobalContext.getInstance();
        const poems = globalContext.getContext('poems') as Array<Poem> || [];
        
        // 筛选出最近浏览的诗歌，并按浏览顺序排列
        this.recentPoems = ids.map(id => poems.find(poem => poem.id === id)).filter(poem => poem !== undefined) as Poem[];
      }
    } catch (error) {
      console.error('加载最近浏览诗歌失败:', error);
      promptAction.showToast({ message: '加载最近浏览诗歌失败' });
    }
  }

  // 初始化TextReader
  private async initTextReader(): Promise<void> {
    try {
      const businessBrandInfo: TextReader.BusinessBrandInfo = { 
        panelName: '小艺朗读'
      };
      
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: businessBrandInfo,
        keepBackgroundRunning: true
      };

      await TextReader.init(getContext(this), readerParam);
      this.isInit = true;
      
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
      this.isInit = false;
    }
  }

  // 切换朗读状态
  private async togglePlay(): Promise<void> {
    try {
      if (!this.isInit) {
        promptAction.showToast({ message: '朗读功能初始化中，请稍后再试' });
        await this.initTextReader();
        
        if (!this.isInit) {
          promptAction.showToast({ message: '朗读功能初始化失败，请稍后重试' });
          return;
        }
      }
      
      if (this.isPlaying) {
        TextReader.pause();
      } else {
        const readInfoList: TextReader.ReadInfo[] = this.recentPoems.map((poem) => {
          const readInfo: TextReader.ReadInfo = {
            id: `poem_recent_${poem.id}`,
            title: {
              text: poem.title,
              isClickable: false
            },
            bodyInfo: `${poem.title}，作者：${poem.author}。${poem.content}`
          };
          
          return readInfo;
        });
        
        TextReader.start(readInfoList, readInfoList[0].id).then(() => {
          console.log('开始朗读最近浏览诗歌');
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

  // 获取背景颜色
  private getBackgroundColor(id: number): string | Resource {
    const colors = [
      '#FFF3E0', '#E3F2FD', '#F1F8E9', '#F3E5F5', '#E0F2F1',
      '#FFECB3', '#FFCCBC', '#E8EAF6', '#E1BEE7', '#FFCCDD',
      '#E0F7FA', '#F9FBE7', '#EFEBE9', '#E8F5E9', '#FFF8E1'
    ];
    return colors[id % colors.length];
  }

  // 构建诗歌卡片
  @Builder
  buildPoemCard(poem: Poem, index: number) {
    Column() {
      // 诗歌标题和作者区域
      Row() {
        Column() {
          Text(poem.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
          
          Text(poem.author)
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        
        // 浏览时间标签
        Text(`最近`)
          .fontSize(12)
          .fontColor($r('app.color.primary'))
          .padding({ top: 4, bottom: 4, left: 8, right: 8 })
          .backgroundColor($r('app.color.primary_light'))
          .borderRadius(12)
      }
      .width('100%')
      .margin({ bottom: 12 })
      
      // 诗歌内容预览
      Text(poem.content.split('\\n')[0] + '...')
        .fontSize(14)
        .fontColor($r('app.color.text_tertiary'))
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 12 })
      
      // 底部信息栏
      Row() {
        // 字数统计
        Text(`${poem.content.replace(/\\n/g, '').length}字`)
          .fontSize(12)
          .fontColor($r('app.color.text_tertiary'))
          
        Blank()
        
        // 历史图标
        Image($r('app.media.ic_history'))
          .width(16)
          .height(16)
          .fillColor($r('app.color.text_tertiary'))
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .backgroundColor(this.getBackgroundColor(poem.id))
    .borderRadius(16)
    .shadow({
      radius: 12,
      color: $r('app.color.shadow_medium'),
      offsetX: 0,
      offsetY: 4
    })
    .onClick(() => {
      // 跳转到诗歌详情页面前停止朗读
      try {
        TextReader.stop();
        this.isPlaying = false;
      } catch (error) {
        console.error('停止朗读失败:', error);
      }
      
      // 跳转到诗歌详情页面
      router.pushUrl({
        url: 'pages/chinese/PoemDetailPage',
        params: {
          poem: JSON.stringify(poem)
        }
      });
    })
    // 添加进入动画效果
    .scale({
      x: this.isPageLoaded ? 1 : 0.9,
      y: this.isPageLoaded ? 1 : 0.9
    })
    .opacity(this.isPageLoaded ? 1 : 0)
    .animation({
      duration: 500,
      curve: Curve.EaseOut,
      delay: index * 50
    })
    .transform({
      translate: { y: this.isPageLoaded ? 0 : 20 }
    })
  }

  // 构建空状态视图
  @Builder
  buildEmptyState() {
    Column() {
      Image($r('app.media.ic_favorite_outline'))
        .width(120)
        .height(120)
        .margin({ bottom: 24 })
        
      Text('暂无浏览记录')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_secondary'))
        .margin({ bottom: 8 })
        
      Text('快去浏览你感兴趣的诗歌吧')
        .fontSize(14)
        .fontColor($r('app.color.text_tertiary'))
        .textAlign(TextAlign.Center)
        .margin({ bottom: 32 })
        
      Button('去浏览')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width(140)
        .height(44)
        .backgroundColor($r('app.color.primary'))
        .fontColor(Color.White)
        .borderRadius(22)
        .onClick(() => {
          router.back();
        })
    }
    .width('100%')
    .height('60%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        // 返回按钮
        Button() {
          Image($r('app.media.ic_arrow_back'))
            .width(20)
            .height(20)
            .fillColor($r('app.color.text_primary'))
        }
        .onClick(() => {
          router.back();
        })
        .type(ButtonType.Circle)
        .width(40)
        .height(40)
        .backgroundColor($r('app.color.card_background'))
        .shadow({
          radius: 8,
          color: $r('app.color.shadow_light'),
          offsetX: 0,
          offsetY: 2
        })

        Text('最近浏览')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Blank()
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .padding({ 
        left: 16, 
        right: 16,
        top: this.statusBarHeight 
      })

      // 诗歌数量统计
      Row() {
        Text(`最近浏览了 ${this.recentPoems.length} 首诗歌`)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({ left: 16 })
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 诗歌列表
      if (this.recentPoems.length > 0) {
        Scroll() {
          Column() {
            ForEach(this.recentPoems, (poem: Poem, index: number) => {
              this.buildPoemCard(poem, index)

            }, (poem: Poem) => poem.id.toString())
          }
          .padding({ bottom: 100 }) // 为悬浮按钮留出空间
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      } else {
        // 空状态视图
        this.buildEmptyState()

      }
      
      // 悬浮播放按钮
      if (this.recentPoems.length > 0) {
        Button() {
          Image(this.isPlaying ? $r('app.media.ic_pause') : $r('app.media.ic_play'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .onClick(() => {
          this.togglePlay();
        })
        .position({ x: '85%', y: '85%' })
        .width(56)
        .height(56)
        .backgroundColor(this.isPlaying ? $r('app.color.primary') : $r('app.color.secondary'))
        .borderRadius(28)
        .shadow({
          radius: 16,
          color: this.isPlaying ? $r('app.color.primary_shadow') : $r('app.color.secondary_shadow'),
          offsetX: 0,
          offsetY: 8
        })
        .scale({
          x: this.isPlaying ? 1.1 : 1,
          y: this.isPlaying ? 1.1 : 1
        })
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background'))
  }
}