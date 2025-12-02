import router from '@ohos.router';

// 定义诗词分类主题接口
interface FeihuaTheme {
  id: number;
  name: string;
  description: string;
  icon: string;
  keyword: string; // 用于筛选诗词的关键字
}

// 定义参数接口
interface ThemeItemParam {
  theme: FeihuaTheme;
  isPageLoaded: boolean;
  index: number;
}

@Entry
@Component
export struct FamousPoetsPage {
  // 诗词分类主题分类列表
  @State private themes: FeihuaTheme[] = [
    {
      id: 1,
      name: '写景',
      description: '山水风光，四季更迭，描绘大自然的壮美与秀丽',
      icon: '🏞️',
      keyword: '山|水|江|湖|云|雨|雪|风|日|月'
    },
    {
      id: 2,
      name: '写花',
      description: '百花齐放，芳香四溢，咏叹花卉的娇艳与芬芳',
      icon: '🌸',
      keyword: '花|梅|菊|莲|桃|梨|兰|桂|芙蓉|牡丹'
    },
    {
      id: 3,
      name: '写边塞',
      description: '铁马金戈，黄沙漫天，诉说边关将士的豪情壮志',
      icon: '⚔️',
      keyword: '塞|关|战|征|戍|胡|羌|烽火|铁衣|玉门'
    },
    {
      id: 4,
      name: '写爱情',
      description: '相思绵绵，情深意长，传递恋人间的深情厚意',
      icon: '💕',
      keyword: '爱|情|思|相思|美人|佳人|君|妾|夫|妻'
    },
    {
      id: 5,
      name: '写思乡',
      description: '举头望月，低头思乡，表达游子对故土的深深眷恋',
      icon: '🏠',
      keyword: '乡|归|家|故乡|思归|客|游子|远|离家'
    },
    {
      id: 6,
      name: '写田园',
      description: '阡陌纵横，鸡犬相闻，描绘田园生活的恬淡闲适',
      icon: '🌾',
      keyword: '田|园|农|耕|桑|麦|稻|村|野|牛羊'
    },
    {
      id: 7,
      name: '写离别',
      description: '依依惜别，黯然销魂，抒发离愁别绪的万般不舍',
      icon: '👋',
      keyword: '别|离|送|行|去|归|分|散|远行|惜别'
    },
    {
      id: 8,
      name: '写孤独',
      description: '独坐幽篁，形影相吊，倾诉内心的寂寞与孤寂',
      icon: '😔',
      keyword: '孤|独|寂|寞|冷|清|愁|空|单|幽'
    },
    {
      id: 9,
      name: '写壮志',
      description: '豪情万丈，志在千里，彰显报国壮志与凌云之气',
      icon: '🦅',
      keyword: '志|雄|壮|豪|气|功|勋|报国|凌云|万里'
    },
    {
      id: 10,
      name: '写茶',
      description: '清茗飘香，禅茶一味，品味茶文化的雅致与韵味',
      icon: '🍵',
      keyword: '茶|茗|泉|煮|品|香|清|醒|饮|壶'
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
      Row() {
        Text('诗词分类')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      // 主题分类列表
      List({ space: 15 }) {
        ForEach(this.themes, (theme: FeihuaTheme, index: number) => {
          ListItem() {
            this.ThemeListItem({ theme: theme, isPageLoaded: this.isPageLoaded, index: index });
          }
        }, (theme: FeihuaTheme) => theme.id.toString())
      }
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.math_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  ThemeListItem(param: ThemeItemParam) {
    Column() {
      Row() {
        // 主题图标
        Text(param.theme.icon)
          .fontSize(48)
          .margin({ right: 15 })
        
        Column() {
          Text(param.theme.name)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
          
          Text(param.theme.description)
            .fontSize(13)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 8 })
            .lineHeight(20)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        
        // 箭头图标
        Text('>')
          .fontSize(24)
          .fontColor($r('app.color.text_tertiary'))
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(15)
    .shadow({ 
      radius: 10, 
      color: $r('app.color.text_tertiary'), 
      offsetX: 0, 
      offsetY: 5 
    })
    .onClick(() => {
      // 跳转到主题诗词列表页,传递主题信息
      router.pushUrl({ 
        url: 'pages/chinese/ThemePoemsPage',
        params: {
          themeId: param.theme.id,
          themeName: param.theme.name
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