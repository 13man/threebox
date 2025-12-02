import router from '@ohos.router';

// 定义数学项目接口
interface MathItem {
  id: number;
  title: string;
}

// 定义MathGridItem参数接口
interface MathGridItemParam {
  item: MathItem;
  isPageLoaded: boolean;
  index: number;
  isPressed: boolean;
}

// 定义颜色映射类型
type ColorMap = Record<string, string>;

@Component
export struct MathPage {
  private mathItems: Array<MathItem> = [
    { id: 1, title: '九九乘法表' },
    { id: 11, title: '九九乘法表趣味练习版本' },
    { id: 6, title: '加减乘除简易好玩计算器' },
    { id: 2, title: '几何公式' },
    { id: 3, title: '奇数与偶数' },
    { id: 4, title: '元角分' },
    { id: 5, title: '认识钟表' },
    { id: 7, title: '认识图形' },
    { id: 8, title: '认识角' },
    { id: 9, title: '基础逻辑' },
    { id: 10, title: '尺子测量' },
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
    colorMap["1"] = '#FFF3E0';   // 九九乘法表 - 橙色系
    colorMap["11"] = '#FFECB3';  // 九九乘法表趣味练习版本 - 黄色系
    colorMap["6"] = '#FFCCBC';   // 加减乘除简易好玩计算器 - 红色系
    colorMap["2"] = '#E8F5E9';   // 几何公式 - 绿色系
    colorMap["3"] = '#F1F8E9';   // 奇数与偶数 - 浅绿色系
    colorMap["4"] = '#E0F7FA';   // 元角分 - 蓝色系
    colorMap["5"] = '#E0F2F1';   // 认识钟表 - 青色系
    colorMap["7"] = '#E8EAF6';   // 认识图形 - 蓝紫色系
    colorMap["8"] = '#EDE7F6';   // 认识角 - 紫色系
    colorMap["9"] = '#F3E5F5';   // 基础逻辑 - 粉色系
    colorMap["10"] = '#FFF0F5';  // 尺子测量 - 粉红色系
    
    return colorMap[id.toString()] || $r('app.color.card_background'); // 默认使用主题卡片背景色
  }

  // 导航到详情页的方法
  private navigateToPage(id: number) {
    switch (id) {
      case 1:
        // 跳转到九九乘法表页面
        router.push({ url: 'pages/math/MultiplicationTablePage' })
        break;
      case 2:
        // 跳转到几何公式页面
        router.push({ url: 'pages/math/GeometryPage' })
        break;
      case 3:
        // 跳转到奇数和偶数页面
        router.push({ url: 'pages/math/OddEvenPage' })
        break;
      case 4:
        // 跳转到元角分页面
        router.push({ url: 'pages/math/YuanJiaoFenPage' })
        break;
      case 5:
        // 跳转到认识钟表页面
        router.push({ url: 'pages/math/ClockPage' })
        break;
      case 6:
        // 跳转到简易计算器页面
        router.push({ url: 'pages/math/SimpleCalculatorPage' })
        break;
      case 7:
        // 跳转到认识图形页面
        router.push({ url: 'pages/math/ShapesPage' })
        break;
      case 8:
        // 跳转到认识角页面
        router.push({ url: 'pages/math/AnglePage' })
        break;
      case 9:
        // 跳转到基础逻辑页面
        router.push({ url: 'pages/math/BasicLogicPage' })
        break;
      case 10:
        // 跳转到尺子测量页面
        router.push({ url: 'pages/math/RulerPage' })
        break;
      case 11:
        // 跳转到好玩的九九乘法表页面
        router.push({ url: 'pages/math/FunMultiplicationTablePage' })
        break;
      default:
        // 其他情况暂不处理
        break;
    }
  }

  build() {
    Column() {
      Row() {
        Text('数学')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      // 使用网格布局展示数学学习项目
      Grid() {
        ForEach(this.mathItems, (item: MathItem, index: number) => {
          GridItem() {
            this.MathGridItem({
              item: item,
              isPageLoaded: this.isPageLoaded,
              index: index,
              isPressed: this.isPressed
            });
          }
        }, (item: MathItem) => item.id.toString())
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
    .backgroundImage($r('app.media.math_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  MathGridItem(param: MathGridItemParam) {
    Column() {
      // 显示标题
      Text(param.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
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

@Component
struct MathListItem {
  @Prop item: MathItem
  @Prop isPageLoaded: boolean
  @Prop index: number
  @State isPressed: boolean = false

  // 定义不同ID对应的背景颜色
  private getBackgroundColor(id: number): ResourceColor {
    // 创建颜色映射对象
    const colorMap: ColorMap = {};
    colorMap["1"] = '#FFF3E0';   // 九九乘法表 - 橙色系
    colorMap["11"] = '#FFECB3';  // 九九乘法表趣味练习版本 - 黄色系
    colorMap["6"] = '#FFCCBC';   // 加减乘除简易好玩计算器 - 红色系
    colorMap["2"] = '#E8F5E9';   // 几何公式 - 绿色系
    colorMap["3"] = '#F1F8E9';   // 奇数与偶数 - 浅绿色系
    colorMap["4"] = '#E0F7FA';   // 元角分 - 蓝色系
    colorMap["5"] = '#E0F2F1';   // 认识钟表 - 青色系
    colorMap["7"] = '#E8EAF6';   // 认识图形 - 蓝紫色系
    colorMap["8"] = '#EDE7F6';   // 认识角 - 紫色系
    colorMap["9"] = '#F3E5F5';   // 基础逻辑 - 粉色系
    colorMap["10"] = '#FFF0F5';  // 尺子测量 - 粉红色系
    
    return colorMap[id.toString()] || $r('app.color.card_background'); // 默认使用主题卡片背景色
  }

  build() {
    Row() {
      Text(this.item.title)
        .fontSize(18)
        .layoutWeight(1)
        .fontWeight(FontWeight.Bold)
        .fontColor(/*(this.item.id === 11 || this.item.id === 6) ?*/ $r('app.color.text_tertiary_math')  /*: $r('app.color.text_primary')*/) // 橘黄色为#FFA500
      
      // 使用文本箭头替代图片
      Text('>')
        .fontSize(18)
        .fontColor($r('app.color.text_tertiary'))
    }
    .padding({ left: 20, right: 20, top: 15, bottom: 15 })
    .backgroundColor(this.getBackgroundColor(this.item.id))
    .borderRadius(15)
    .shadow({ radius: 18, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 10 })
    .onClick(() => {
      this.isPressed = true;
      setTimeout(() => {
        this.navigateToPage(this.item.id);
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
      x: this.isPageLoaded ? 1 : 0.8,
      y: this.isPageLoaded ? 1 : 0.8
    })
    .opacity(this.isPageLoaded ? 1 : 0)
    // 添加点击时的缩放动画效果
    .scale({ 
      x: this.isPressed ? 0.95 : (this.isPageLoaded ? 1 : 0.8),
      y: this.isPressed ? 0.95 : (this.isPageLoaded ? 1 : 0.8)
    }).transform({
      translate: { y: this.isPageLoaded ? 0 : 15 }
    })
    .animation({
      duration: 400,
      curve: Curve.EaseInOut,
      delay: this.index * 80 // 每个项依次延迟动画，营造波浪效果
    })
  }

  // 将方法改为public以便其他组件可以调用
  public navigateToPage(id: number) {
    switch (id) {
      case 1:
        // 跳转到九九乘法表页面
        router.push({ url: 'pages/math/MultiplicationTablePage' })
        break;
      case 2:
        // 跳转到几何公式页面
        router.push({ url: 'pages/math/GeometryPage' })
        break;
      case 3:
        // 跳转到奇数和偶数页面
        router.push({ url: 'pages/math/OddEvenPage' })
        break;
      case 4:
        // 跳转到元角分页面
        router.push({ url: 'pages/math/YuanJiaoFenPage' })
        break;
      case 5:
        // 跳转到认识钟表页面
        router.push({ url: 'pages/math/ClockPage' })
        break;
      case 6:
        // 跳转到简易计算器页面
        router.push({ url: 'pages/math/SimpleCalculatorPage' })
        break;
      case 7:
        // 跳转到认识图形页面
        router.push({ url: 'pages/math/ShapesPage' })
        break;
      case 8:
        // 跳转到认识角页面
        router.push({ url: 'pages/math/AnglePage' })
        break;
      case 9:
        // 跳转到基础逻辑页面
        router.push({ url: 'pages/math/BasicLogicPage' })
        break;
      case 10:
        // 跳转到尺子测量页面
        router.push({ url: 'pages/math/RulerPage' })
        break;
      case 11:
        // 跳转到好玩的九九乘法表页面
        router.push({ url: 'pages/math/FunMultiplicationTablePage' })
        break;
      default:
        // 其他情况暂不处理
        break;
    }
  }
}

@Component
struct MathGridItem {
  @Prop item: MathItem
  @Prop isPageLoaded: boolean
  @Prop index: number
  @State isPressed: boolean = false

  // 定义不同ID对应的背景颜色
  private getBackgroundColor(id: number): ResourceColor {
    // 创建颜色映射对象
    const colorMap: ColorMap = {};
    colorMap["1"] = '#FFF3E0';   // 九九乘法表 - 橙色系
    colorMap["11"] = '#FFECB3';  // 九九乘法表趣味练习版本 - 黄色系
    colorMap["6"] = '#FFCCBC';   // 加减乘除简易好玩计算器 - 红色系
    colorMap["2"] = '#E8F5E9';   // 几何公式 - 绿色系
    colorMap["3"] = '#F1F8E9';   // 奇数与偶数 - 浅绿色系
    colorMap["4"] = '#E0F7FA';   // 元角分 - 蓝色系
    colorMap["5"] = '#E0F2F1';   // 认识钟表 - 青色系
    colorMap["7"] = '#E8EAF6';   // 认识图形 - 蓝紫色系
    colorMap["8"] = '#EDE7F6';   // 认识角 - 紫色系
    colorMap["9"] = '#F3E5F5';   // 基础逻辑 - 粉色系
    colorMap["10"] = '#FFF0F5';  // 尺子测量 - 粉红色系
    
    return colorMap[id.toString()] || $r('app.color.card_background'); // 默认使用主题卡片背景色
  }

  build() {
    Column() {
      Text(this.item.title)
        .fontSize(16)
        .fontColor(/*(this.item.id === 11 || this.item.id === 6) ? */ $r('app.color.text_tertiary_math') /*: $r('app.color.text_primary')*/) // 橘黄色为#FFA500
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.getBackgroundColor(this.item.id))
    .borderRadius(15)
    .shadow({ radius: 8, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 4 })
    .onClick(() => {
      this.isPressed = true;
      setTimeout(() => {
        this.navigateToPage(this.item.id);
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
      x: this.isPageLoaded ? 1 : 0.8,
      y: this.isPageLoaded ? 1 : 0.8
    })
    .opacity(this.isPageLoaded ? 1 : 0)
    // 添加点击时的缩放动画效果
    .scale({ 
      x: this.isPressed ? 0.95 : (this.isPageLoaded ? 1 : 0.8),
      y: this.isPressed ? 0.95 : (this.isPageLoaded ? 1 : 0.8)
    })
    .animation({
      duration: 400,
      curve: Curve.EaseInOut,
      delay: this.index * 80 // 每个项依次延迟动画，营造波浪效果
    })
  }

  // 将方法改为public以便其他组件可以调用
  private navigateToPage(id: number) {
    switch (id) {
      case 1:
        // 跳转到九九乘法表页面
        router.push({ url: 'pages/math/MultiplicationTablePage' })
        break;
      case 2:
        // 跳转到几何公式页面
        router.push({ url: 'pages/math/GeometryPage' })
        break;
      case 3:
        // 跳转到奇数和偶数页面
        router.push({ url: 'pages/math/OddEvenPage' })
        break;
      case 4:
        // 跳转到元角分页面
        router.push({ url: 'pages/math/YuanJiaoFenPage' })
        break;
      case 5:
        // 跳转到认识钟表页面
        router.push({ url: 'pages/math/ClockPage' })
        break;
      case 6:
        // 跳转到简易计算器页面
        router.push({ url: 'pages/math/SimpleCalculatorPage' })
        break;
      case 7:
        // 跳转到认识图形页面
        router.push({ url: 'pages/math/ShapesPage' })
        break;
      case 8:
        // 跳转到认识角页面
        router.push({ url: 'pages/math/AnglePage' })
        break;
      case 9:
        // 跳转到基础逻辑页面
        router.push({ url: 'pages/math/BasicLogicPage' })
        break;
      case 10:
        // 跳转到尺子测量页面
        router.push({ url: 'pages/math/RulerPage' })
        break;
      case 11:
        // 跳转到好玩的九九乘法表页面
        router.push({ url: 'pages/math/FunMultiplicationTablePage' })
        break;
      default:
        // 其他情况暂不处理
        break;
    }
  }
}