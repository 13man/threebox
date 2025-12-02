import router from '@ohos.router';

interface GameMode {
  id: number;
  title: string;
  icon: string;
  description: string;
  difficulty: string;
  color: ResourceColor;
  route: string;
}

@Entry
@Component
export struct FunFillPage {
  @State isPageLoaded: boolean = false;
  @State selectedMode: number = -1;  // 选中的游戏模式

  // 游戏模式列表
  private gameModes: GameMode[] = [
    {
      id: 1,
      title: '🎯 诗人填词',
      icon: '🖋️',
      description: '选择喜爱的诗人，挑戨20首著名诗作',
      difficulty: '经典模式',
      color: $r('app.color.tang_poem_card'),
      route: 'pages/chinese/PoetSelectionPage'
    },
    {
      id: 2,
      title: '🎲 摇一摇出题',
      icon: '🎀',
      description: '手机摇一摇，随机抽取锦鲤诗题',
      difficulty: '惊喜盲盒',
      color: $r('app.color.accent_positive'),
      route: 'pages/chinese/ShakeQuizPage'
    },
    {
      id: 3,
      title: '🧩 残句拼图',
      icon: '🔤',
      description: '拖拽汉字拼图，还原完整诗句',
      difficulty: '趣味闯关',
      color: $r('app.color.song_lyric_card'),
      route: 'pages/chinese/PuzzleQuizPage'
    },
    {
      id: 4,
      title: '🖌️ 墨汁遮盖',
      icon: '💧',
      description: '擦除墨汁揭示诗句，解压又益智',
      difficulty: '解压模式',
      color: '#2C2C2C',
      route: 'pages/chinese/InkWipePage'
    }
  ];

  aboutToAppear(): void {
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('趣味闯关')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      Scroll() {
        Column() {
          // 介绍区域
          Column() {
            Text('🎮 三大游戏模式')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ bottom: 8 })
            
            Text('选择你喜欢的游戏方式，开启诗词之旅')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .padding({ top: 20, bottom: 20 })
          .opacity(this.isPageLoaded ? 1 : 0)
          .animation({ duration: 400, delay: 100 })

          // 游戏模式卡片
          ForEach(this.gameModes, (mode: GameMode, index: number) => {
            this.GameModeCard(mode, index)
          })

          // 底部提示
          Text('💡 每种模式都有独特的乐趣，快来试试吧！')
            .fontSize(12)
            .fontColor($r('app.color.primary_brand'))
            .fontStyle(FontStyle.Italic)
            .margin({ top: 30, bottom: 20 })
            .opacity(this.isPageLoaded ? 0.8 : 0)
            .animation({ duration: 400, delay: 800 })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.english_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  GameModeCard(mode: GameMode, index: number) {
    Column() {
      // 卡片头部 - 图标和标题
      Row() {
        Text(mode.icon)
          .fontSize(32)
          .margin({ right: 12 })
        
        Column() {
          Text(mode.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .alignSelf(ItemAlign.Start)
          
          Text(mode.difficulty)
            .fontSize(12)
            .fontColor($r('app.color.text_tertiary'))
            .margin({ top: 4 })
            .alignSelf(ItemAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 描述
      Text(mode.description)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(22)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 开始按钮
      Button('开始挑战')
        .width('100%')
        .height(44)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(mode.color)
        .fontColor('#FFFFFF')
        .borderRadius(22)
        .margin({ top: 16 })
        .onClick(() => {
          this.selectedMode = mode.id;
          animateTo({ duration: 200 }, () => {
            router.push({ url: mode.route });
          });
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(16)
    .margin({ top: index === 0 ? 0 : 16 })
    .shadow({
      radius: 12,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 4
    })
    .scale({ 
      x: this.selectedMode === mode.id ? 0.98 : 1,
      y: this.selectedMode === mode.id ? 0.98 : 1
    })
    .opacity(this.isPageLoaded ? 1 : 0)
    .translate({ y: this.isPageLoaded ? 0 : 30 })
    .animation({
      duration: 500,
      delay: 200 + index * 100,
      curve: Curve.EaseOut
    })
  }
}