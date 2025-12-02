import router from '@ohos.router';

@Entry
@Component
struct OddEvenPage {
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
        
        Text('奇数和偶数')
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
          Text('奇数和偶数的定义')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 专业数学定义
          Text('专业数学定义:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('整数中，能够被2整除的数叫做偶数，不能被2整除的数叫做奇数。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          Text('0是偶数，正奇数和负奇数统称为奇数，正偶数和负偶数统称为偶数。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 可爱解析
          Text('可爱解析:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('奇数就像是一个有点孤单的数字，它总是不能被2整除，总是会留下一个小伙伴没人陪伴。\n\n偶数则是一个很公平的数字，它总是能被2整除，所有的小伙伴都能找到自己的伙伴，成双成对。\n\n想象一下，如果你有一堆糖果，如果是偶数颗，你就可以和你的好朋友平分，每人得到一样多的糖果；但如果是奇数颗，就会有一颗糖果剩下，需要决定给谁。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 示例说明
          Text('示例说明:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('偶数示例:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
            
            Text('2, 4, 6, 8, 10, 12, 14, 16, 18, 20...')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5 })
              .fontFamily('monospace')
            
            Text('这些数字都能被2整除，没有余数')
              .fontSize(14)
              .fontColor($r('app.color.text_tertiary'))
              .margin({ top: 5 })
            
            Text('奇数示例:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 15 })
            
            Text('1, 3, 5, 7, 9, 11, 13, 15, 17, 19...')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5 })
              .fontFamily('monospace')
            
            Text('这些数字除以2都会有余数1')
              .fontSize(14)
              .fontColor($r('app.color.text_tertiary'))
              .margin({ top: 5 })
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          // 判断方法
          Text('判断方法:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('看个位数：只要看一个整数的个位数就能判断它是奇数还是偶数。\n\n个位数是0, 2, 4, 6, 8的数是偶数。\n\n个位数是1, 3, 5, 7, 9的数是奇数。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 鼓励词汇
          Text('你已经掌握了奇数和偶数的匣子，继续加油学习更多的数学匣子吧！😊')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
            .margin({ top: 30, bottom: 20, left: 20, right: 20 })
            .textAlign(TextAlign.Center)
        }
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }}