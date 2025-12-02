import router from '@ohos.router';

@Entry
@Component
export struct RulerPage {
  // 尺子总长度（厘米）
  private rulerLength: number = 100;
  
  build() {
    Column() {
      // 标题栏
      Row() {
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        
        Text('尺子测量')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      
      // 内容区域
      Scroll() {
        Column() {
          // 尺子介绍
          Column() {
            Text('认识尺子')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('尺子是用来测量物体长度的工具。在尺子上，每一小格代表1厘米，每一大格代表10厘米。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Center)
              .margin({ left: 20, right: 20 })
          }
          
          // 尺子可视化展示
          Column() {
            Text('厘米尺子')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            // 尺子主体
            Stack() {
              // 尺子背景
              Row()
                .width('100%')
                .height(80)
                .backgroundColor('#FFF59D')
                .borderRadius(10)
                .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
              
              // 尺子刻度
              Row() {
                // 100个1cm的小刻度
                ForEach(
                  new Array(this.rulerLength).fill(0).map((_: undefined, index: number) => index),
                  (index: number) => {
                    Column() {
                      if (index % 10 === 0) {
                        // 10cm的大刻度
                        Rect()
                          .width(2)
                          .height(40)
                          .fill($r('app.color.text_primary_000'))
                        
                        // 大刻度数字标记
                        Text(`${index}`)
                          .fontSize(12)
                          .fontColor($r('app.color.text_primary_000'))
                          .margin({ top: 5 })
                      } else if (index % 5 === 0) {
                        // 5cm的中等刻度
                        Rect()
                          .width(1)
                          .height(30)
                          .fill($r('app.color.text_primary_000'))
                      } else {
                        // 1cm的小刻度
                        Rect()
                          .width(1)
                          .height(20)
                          .fill($r('app.color.text_primary_000'))
                      }
                    }
                    .width('1%')
                    .alignItems(HorizontalAlign.Center)
                  },
                  (index: number) => index.toString()
                )
              }
              .width('100%')
              .height(80)
              .padding({ left: 10, right: 10 })
            }
            .width('100%')
            .margin({ left: 20, right: 20 })
          }
          .margin({ top: 20 })
          
          // 使用方法
          Column() {
            Text('使用方法')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 30, bottom: 10 })
            
            Column() {
              Text('1. 将尺子的0刻度线对齐物体的一端')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('2. 读取物体另一端对应的刻度值')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('3. 读数时视线要与刻度线垂直')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('4. 记录测量结果，单位是厘米(cm)')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
            }
            .width('100%')
            .padding(15)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .margin({ left: 20, right: 20 })
          }
          
          // 测量练习
          Column() {
            Text('测量练习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 30, bottom: 10 })
            
            Text('试着用这把尺子测量一下家里常见的物品：')
              .fontSize(14)
              .fontColor($r('app.color.text_tertiary'))
              .margin({ bottom: 15 })
            
            Column() {
              Text('• 数学课本的长度')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('• 铅笔的长度')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('• 手机的长度')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
                .margin({ bottom: 5 })
              
              Text('• 水杯的高度')
                .fontSize(14)
                .fontColor($r('app.color.text_secondary'))
                .textAlign(TextAlign.Start)
            }
            .width('100%')
            .padding(15)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(10)
            .margin({ left: 20, right: 20 })
          }
          
          // 小知识
          Column() {
            Text('小知识')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 30, bottom: 10 })
            
            Text('厘米是我们常用的长度单位，1厘米大约是一个手指甲的宽度。100厘米等于1米。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Center)
              .margin({ left: 20, right: 20 })
          }
          
          // 鼓励性文字和爱心
          Column() {
            Text('你已经很棒了！继续加油！😊')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4CAF50')
              .textAlign(TextAlign.Center)
              .margin({ top: 30, bottom: 20 })

          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          Blank()
        }
        .width('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}