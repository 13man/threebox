import router from '@ohos.router';

@Entry
@Component
struct YuanJiaoFenPage {
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
        
        Text('元角分')
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
          Text('元角分的定义')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 专业定义
          Text('专业定义:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Text('元、角、分是中国货币人民币的单位，它们之间的进率是10，属于十进制货币单位。\n\n1元 = 10角\n1角 = 10分\n1元 = 100分')
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
          
          Text('想象一下，你有一个大钱包！\n\n一个大大的"元"就像一个大个子哥哥，他很厉害，可以换成10个中等大小的"角"弟弟。\n\n每个"角"弟弟也不小，他们每人又可以换成10个小小的"分"宝宝。\n\n所以一个"元"哥哥等于10个"角"弟弟，等于100个"分"宝宝！\n\n就像一个大家庭，大哥哥能换很多小宝宝一样，"元"能换很多"分"！')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 转换方法
          Text('转换方法:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('元转角:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
            
            Text('1元 = 10角\n2元 = 20角\n5元 = 50角\n10元 = 100角')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5 })
              .fontFamily('monospace')
            
            Text('角转分:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 15 })
            
            Text('1角 = 10分\n3角 = 30分\n7角 = 70分\n10角 = 100分')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5 })
              .fontFamily('monospace')
            
            Text('元转分:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 15 })
            
            Text('1元 = 100分\n2元 = 200分\n5元 = 500分\n10元 = 1000分')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5 })
              .fontFamily('monospace')
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          // 学习方法
          Text('学习方法:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('1. 记住口诀:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Start)
            
            Text('• 1元等于10角\n• 1角等于10分\n• 1元等于100分')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('2. 实际操作:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
              .textAlign(TextAlign.Start)
            
            Text('• 可以拿真实的人民币纸币或硬币观察\n• 和爸爸妈妈一起去超市时注意价格标签\n• 玩购物游戏，练习找零')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('3. 多做练习:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
              .textAlign(TextAlign.Start)
            
            Text('• 多做一些元角分的换算题目\n• 用计算器验证自己的答案\n• 和同学一起比赛谁算得又快又准')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
          
          // 鼓励词汇
          Text('你已经掌握了元角分的匣子，继续加油学习更多的数学匣子吧！😊')
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
  }
}