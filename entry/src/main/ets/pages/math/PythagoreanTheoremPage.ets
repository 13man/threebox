import router from '@ohos.router';

@Entry
@Component
struct PythagoreanTheoremPage {
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
        
        Text('勾股定理')
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
          Text('勾股定理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 定理说明
          Text('在直角三角形中，两条直角边的平方和等于斜边的平方。这是古希腊数学家毕达哥拉斯发现的重要定理，也被称为毕达哥拉斯定理。')
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
          
          Text('a² + b² = c²')
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
            Text('• a, b: 直角三角形的两条直角边')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 5 })
            Text('• c: 直角三角形的斜边（最长边）')
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
          
          Text('勾股定理就像是直角三角形的魔法咒语！\n\n想象一个直角三角形小房子，两条短边是墙，最长的边是屋顶。\n\n这个神奇的定理告诉我们：左边墙的平方加上右边墙的平方，刚好等于屋顶的平方！\n\n这就像一个数学小精灵在说："两边平方加一加，斜边平方就出来！"\n\n无论这个直角三角形是胖是瘦，这个魔法都有效哦！')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 图片示意（文字描述）
          Text('勾股定理示意图')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            // 用文本模拟直角三角形，字符准确放置在对应边上
            Text('   c  /|')
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
            Text('   /   |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('    /    | b')
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
          
          // 实际应用
          Text('实际应用:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('勾股定理在生活中有很多应用，比如：\n\n• 测量不可直接到达的距离\n• 建筑工程中的直角验证\n• 导航和地图制作\n• 计算屏幕对角线长度')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
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