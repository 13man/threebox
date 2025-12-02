import router from '@ohos.router';

@Entry
@Component
struct QuadrilateralAreaPage {
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
        
        Text('四边形面积')
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
          Text('四边形面积定理')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 定理说明
          Text('不同类型的四边形有不同的面积计算方法。这里介绍几种常见四边形的面积计算公式。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 正方形面积
          Text('1. 正方形面积:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('公式:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Text('S = a²')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('说明: a为正方形边长')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 5 })
          
          // 长方形面积
          Text('2. 长方形面积:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('公式:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Text('S = 长 × 宽')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('说明: 长和宽分别为长方形的两个不同边长')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 5 })
          
          // 平行四边形面积
          Text('3. 平行四边形面积:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('公式:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Text('S = 底 × 高')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('说明: 底为平行四边形的一边，高为该边到对边的垂直距离')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 5 })
          
          // 梯形面积
          Text('4. 梯形面积:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('公式:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Text('S = (上底 + 下底) × 高 ÷ 2')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('说明: 上底和下底为梯形的两个平行边，高为两平行边间的垂直距离')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 5 })
          
          // 通用四边形面积（海伦公式变形）
          Text('5. 任意四边形面积:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('公式（布雷契奈德公式）:')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
          
          Text('S = √[(p-a)(p-b)(p-c)(p-d) - abcd·cos²((A+C)/2)]')
            .fontSize(18)
            .fontFamily('monospace')
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10 })
            .padding(10)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          Text('说明: a,b,c,d为四边长，p为半周长，A,C为对角')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 5 })
          
          // 可爱解析
          Text('可爱解析:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('四边形面积就像要铺地板砖一样，需要知道需要多少块砖。\n\n不同的四边形有不同的铺法：\n\n• 正方形就像整整齐齐的棋盘，边长乘边长就搞定\n\n• 长方形就像普通的地板砖，长乘宽就OK\n\n• 平行四边形就像歪着放的长方形，用底乘高来计算\n\n• 梯形就像梯子的横截面，用两个平行边的平均值乘高\n\n每种形状都有自己的小秘密，找到正确的公式就能轻松算出面积啦！')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 图片示意（文字描述）
          Text('几种常见四边形示意图')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('正方形:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
            Text('  _______')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' |       |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('   |       | a')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' |_______|')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('    a')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            
            Text('长方形:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
            Text('  _________')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' |         |')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' |         | b')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text(' |_________|')
              .fontSize(16)
              .fontFamily('monospace')
              .fontColor($r('app.color.text_primary'))
            Text('     a')
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