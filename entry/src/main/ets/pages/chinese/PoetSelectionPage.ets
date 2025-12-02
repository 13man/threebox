import router from '@ohos.router';

// 定义诗人接口
interface Poet {
  id: number;
  name: string;
  dynasty: string;
  imageResource: string; // 图片资源名称
}

// 定义参数接口
interface PoetItemParam {
  poet: Poet;
  isPageLoaded: boolean;
  index: number;
}

@Entry
@Component
export struct PoetSelectionPage {
  // 著名诗人列表
  @State private poets: Poet[] = [
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

  @State isPageLoaded: boolean = false;

  aboutToAppear(): void {
    // 页面即将出现时触发，延迟一小段时间后设置页面已加载状态
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);
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
        Text('选择诗人')
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

      // 诗人列表
      List({ space: 15 }) {
        ForEach(this.poets, (poet: Poet, index: number) => {
          ListItem() {
            this.PoetItem({ poet: poet, isPageLoaded: this.isPageLoaded, index: index });
          }
        }, (poet: Poet) => poet.id.toString())
      }
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.chinese_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  PoetItem(param: PoetItemParam) {
    Row() {
      // 诗人画像
      Image($r(`entry.media.${param.poet.imageResource}`))
        .width(60)
        .height(60)
        .borderRadius(30)
        .margin({ right: 15 })
      
      Column() {
        Text(param.poet.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .alignSelf(ItemAlign.Start)
        
        Text(`${param.poet.dynasty}诗人`)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .alignSelf(ItemAlign.Start)
          .margin({ top: 5 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      
      // 箭头图标
      Text('>')
        .fontSize(20)
        .fontColor($r('app.color.text_tertiary'))
    }
    .width('100%')
    .padding({ left: 15, right: 15, top: 15, bottom: 15 })
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(15)
    .shadow({ 
      radius: 10, 
      color: $r('app.color.text_tertiary'), 
      offsetX: 0, 
      offsetY: 5 
    })
    .onClick(() => {
      // 跳转到该诗人的填词游戏页面
      router.pushUrl({ 
        url: 'pages/chinese/PoetFillQuizPage',
        params: {
          poetId: param.poet.id
        }
      });
    })
    // 添加进入动画效果
    .scale({ 
      x: param.isPageLoaded ? 1 : 0.8,
      y: param.isPageLoaded ? 1 : 0.8
    })
    .opacity(param.isPageLoaded ? 1 : 0)
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