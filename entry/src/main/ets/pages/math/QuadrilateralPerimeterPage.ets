import router from '@ohos.router';

@Entry
@Component
struct QuadrilateralPerimeterPage {
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
        
        Text('四边形周长')
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
          Text('四边形周长定理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 定理说明
          Text('四边形的周长等于四条边长度之和。无论四边形是什么形状（正方形、长方形、菱形、梯形或其他不规则四边形），这个定理都适用。')
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
          
          Text('C = a + b + c + d')
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
            Text('• C: 四边形的周长')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
            Text('• a, b, c, d: 四边形四条边的长度')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
          }
          .margin({ top: 10, left: 20, right: 20 })
          
          // 特殊四边形的周长公式
          Text('特殊四边形的周长:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('• 正方形: C = 4a (a为边长)')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 10 })
            Text('• 长方形: C = 2(a + b) (a和b分别为长和宽)')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 10 })
            Text('• 菱形: C = 4a (a为边长)')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 10 })
            Text('• 平行四边形: C = 2(a + b) (a和b为邻边长度)')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 10 })
          }
          .margin({ top: 10, left: 20, right: 20 })
          
          // 可爱解析
          Text('可爱解析:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('四边形就像一个画框或者小相框，要给它装饰一圈小花边。\n\n不管这个四边形是方方正正的正方形，还是扁扁的长方形，\n\n或者歪歪扭扭的不规则形状，我们只需要把四条边的长度加起来，\n\n就知道需要多长的花边啦！\n\n就像绕着四边形走一圈，数一数走了多少步一样简单！')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 图片示意（文字描述）
          Text('四边形示意图')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            // 用文本模拟四边形，字符准确放置在对应边上
            Text('a________b')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('|        |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('|        |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('|________|')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('d        c')
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