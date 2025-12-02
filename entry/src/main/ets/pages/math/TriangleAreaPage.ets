import router from '@ohos.router';

@Entry
@Component
struct TriangleAreaPage {
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
        
        Text('三角形的面积')
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
          Text('三角形面积定理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 定理说明
          Text('三角形的面积等于底边长度乘以对应高的长度再除以2。这是计算三角形面积最常用的方法。')
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
          
          Text('S = (1/2) × 底 × 高')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('或')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10 })
          
          Text('S = (1/2) × a × h')
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
            Text('• S: 三角形的面积')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
            Text('• 底(或a): 三角形的底边长度')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
            Text('• 高(或h): 对应底边的垂直高度')
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
          
          Text('想象一下，你要给一个三角形小花园铺草皮，需要买多少草皮呢？\n\n我们可以先把它想象成一个长方形，然后从对角线切开变成两个三角形。\n\n所以三角形的面积就是长方形面积的一半，也就是底乘以高再除以2！\n\n就像分享蛋糕一样，把长方形蛋糕沿对角线切开，每人分到一半~')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 图片示意（文字描述）
          Text('三角形面积示意图')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            // 用文本模拟三角形图形和高，字符准确放置在对应边上
            Text('      /|')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('     / |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('    /  |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('     /   | h')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('  /    |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' /_____|')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('   a')
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