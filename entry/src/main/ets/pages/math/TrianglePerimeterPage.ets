import router from '@ohos.router';

@Entry
@Component
struct TrianglePerimeterPage {
  build() {
    Column() {
      Row() {
        // 返回按钮
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        
        Text('三角形的周长')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })

      Scroll() {
        Column() {
          // 定理标题
          Text('三角形周长定理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 定理说明
          Text('三角形的周长等于三边长度之和。这是几何学中最基本的概念之一，无论三角形是什么形状，这个定理都成立。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 公式
          Text('公式:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('C = a + b + c')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          // 符号说明
          Text('其中:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('• C: 三角形的周长')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
            Text('• a, b, c: 三角形三边的长度')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
          }
          .margin({ top: 10, left: 20, right: 20 })
          
          // 可爱解析
          Text('可爱解析:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('想象一下，你要给一个三角形小饼干围上漂亮的丝带，你需要多长的丝带呢？\n\n答案就是把三条边的长度加起来！就像数一数你走了多少步一样简单。\n\n不管这个三角形是胖胖的还是瘦瘦的，是高高的还是扁扁的，都只需要把三边加起来就可以啦！')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 图片示意（文字描述）
          Text('三角形示意图')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            // 用文本模拟三角形图形，字符准确放置在对应边上
            Text('       c')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('      /\\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('     /  \\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('    /    \\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('   /      \\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('  /        \\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' /          \\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('/____________\\')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('a            b')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
          }
          .margin({ top: 10 })
          .padding(20)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
        }
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}