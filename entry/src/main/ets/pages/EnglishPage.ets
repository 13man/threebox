import router from '@ohos.router';

// 定义英语问候语项目接口
interface EnglishItem {
  id: number;
  title: string;
  english: string;
  chinese: string;
}

// 定义EnglishGridItem参数接口
interface EnglishGridItemParam {
  item: EnglishItem;
  isPageLoaded: boolean;
  index: number;
  isPressed: boolean;
}

// 定义颜色映射类型
type ColorMap = Record<string, string>;

@Component
export struct EnglishPage {
  private englishItems: Array<EnglishItem> = [
    { id: 1, title: '问候语', english: 'Hello!', chinese: '你好！' },
    { id: 2, title: '告别语', english: 'Goodbye!', chinese: '再见！' },
    { id: 3, title: '感谢语', english: 'Thank you!', chinese: '谢谢！' },
    { id: 4, title: '道歉语', english: 'Sorry!', chinese: '对不起！' },
    { id: 5, title: '介绍自己', english: 'My name is...', chinese: '我叫...' },
    { id: 6, title: '询问姓名', english: 'What is your name?', chinese: '你叫什么名字？' },
    { id: 7, title: '表达喜欢', english: 'I like...', chinese: '我喜欢...' },
    { id: 8, title: '表达年龄', english: 'How old are you?', chinese: '你多大了？' },
    { id: 9, title: '家庭成员', english: 'family members', chinese: '家庭成员' },
    { id: 10, title: '日常问候', english: 'How are you?', chinese: '你好吗？' }
  ];

  @State isPressed: boolean = false;
  @State isPageLoaded: boolean = false;
  @State index: number = 0;

  aboutToAppear(): void {
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);
  }

  // 定义不同ID对应的背景颜色
  private getBackgroundColor(id: number): ResourceColor {
    // 创建颜色映射对象
    const colorMap: ColorMap = {};
    colorMap["1"] = '#E3F2FD';   // 问候语 - 蓝色系
    colorMap["2"] = '#E8EAF6';   // 告别语 - 蓝紫色系
    colorMap["3"] = '#E0F2F1';   // 感谢语 - 青色系
    colorMap["4"] = '#F1F8E9';   // 道歉语 - 浅绿色系
    colorMap["5"] = '#FFF3E0';   // 介绍自己 - 橙色系
    colorMap["6"] = '#FFECB3';   // 询问姓名 - 黄色系
    colorMap["7"] = '#FFCCBC';   // 表达喜欢 - 红色系
    colorMap["8"] = '#FFCCDD';   // 表达年龄 - 粉色系
    colorMap["9"] = '#E1BEE7';   // 家庭成员 - 紫色系
    colorMap["10"] = '#F3E5F5';  // 日常问候 - 粉色系
    
    return colorMap[id.toString()] || $r('app.color.card_background'); // 默认使用主题卡片背景色
  }

  // 导航到详情页的方法
  private navigateToPage(id: number) {
    switch (id) {
      case 1:
        router.push({ url: 'pages/english/GreetingsPage' });
        break;
      case 2:
        router.push({ url: 'pages/english/FarewellsPage' });
        break;
      case 3:
        router.push({ url: 'pages/english/ThanksPage' });
        break;
      case 4:
        router.push({ url: 'pages/english/ApologiesPage' });
        break;
      case 5:
        router.push({ url: 'pages/english/IntroducePage' });
        break;
      case 6:
        router.push({ url: 'pages/english/AskNamePage' });
        break;
      case 7:
        router.push({ url: 'pages/english/ExpressLikesPage' });
        break;
      case 8:
        router.push({ url: 'pages/english/AskAgePage' });
        break;
      case 9:
        router.push({ url: 'pages/english/FamilyPage' });
        break;
      case 10:
        router.push({ url: 'pages/english/DailyGreetingsPage' });
        break;
      default:
        break;
    }
  }

  build() {
    Column() {
      Row() {
        Text('英语')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      // 使用网格布局展示英语学习项目
      Grid() {
        ForEach(this.englishItems, (item: EnglishItem, index: number) => {
          GridItem() {
            this.EnglishGridItem({
              item: item,
              isPageLoaded: this.isPageLoaded,
              index: index,
              isPressed: this.isPressed
            });
          }
        }, (item: EnglishItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr') // 2列网格
      .rowsGap(20)
      .columnsGap(20)
      .layoutWeight(1)
      .padding(20)
      .edgeEffect(EdgeEffect.Spring) // 添加弹性边缘效果
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.english_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  EnglishGridItem(param: EnglishGridItemParam) {
    Column() {
      // 显示标题
      Text(param.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .textAlign(TextAlign.Center)
        .margin({ bottom: 5 })
      
      // 显示英文内容
      Text(param.item.english)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary_666'))
        .textAlign(TextAlign.Center)
        .margin({ bottom: 3 })
      
      // 显示中文内容
      Text(param.item.chinese)
        .fontSize(12)
        .fontColor($r('app.color.text_tertiary'))
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(100)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.getBackgroundColor(param.item.id))
    .borderRadius(15)
    .shadow({ 
      radius: 18, 
      color: $r('app.color.text_tertiary'), 
      offsetX: 0, 
      offsetY: 10 
    })
    .onClick(() => {
      this.isPressed = true;
      setTimeout(() => {
        this.navigateToPage(param.item.id);
      }, 150);
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    // 添加进入动画效果
    .scale({ 
      x: param.isPageLoaded ? 1 : 0.8,
      y: param.isPageLoaded ? 1 : 0.8
    })
    .opacity(param.isPageLoaded ? 1 : 0)
    // 添加点击时的缩放动画效果
    .scale({ 
      x: this.isPressed ? 0.95 : (param.isPageLoaded ? 1 : 0.8),
      y: this.isPressed ? 0.95 : (param.isPageLoaded ? 1 : 0.8)
    })
    .transform({
      translate: { y: param.isPageLoaded ? 0 : 15 }
    })
    .animation({
      duration: 400,
      curve: Curve.EaseInOut,
      delay: param.index * 80 // 每个项依次延迟动画，营造波浪效果
    })
  }
}