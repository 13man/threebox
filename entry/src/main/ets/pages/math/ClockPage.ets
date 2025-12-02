import router from '@ohos.router';

@Entry
@Component
struct ClockPage {
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
        
        Text('认识钟表')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })

      Scroll() {
        Column() {
          // 定理标题
          Text('认识钟表')
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
          
          Text('钟表是用来测量和显示时间的仪器。钟表上有三种指针：\n\n• 时针：最短最粗的指针，走一圈代表12小时\n• 分针：比时针长一些的指针，走一圈代表60分钟\n• 秒针：最细最长的指针，走一圈代表60秒\n\n时间单位之间的关系：\n1小时 = 60分钟\n1分钟 = 60秒\n1小时 = 3600秒')
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
          
          Text('钟表就像是一个时间的游乐场！\n\n时针是一个胖胖的懒惰小矮人，他走得很慢很慢，走一圈需要12个小时，相当于你从早上起床到晚上睡觉的时间。\n\n分针是一个中等身材的普通小矮人，他走的速度是时针的12倍，走一圈需要1个小时。\n\n秒针是一个高高瘦瘦的跑步冠军，他跑得超级快，走一圈只需要1分钟，他每跑一步就是1秒钟！\n\n他们三兄弟一起工作，告诉我们现在是什么时间。')
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 时分秒详解
          Text('时分秒详解:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('时针:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
            
            Text('• 时针走得最慢\n• 一大格代表1小时\n• 钟面上有12个大格，所以走一圈是12小时\n• 一天有24小时，所以时针一天要走两圈')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('分针:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 15 })
            
            Text('• 分针走得不快不慢\n• 一小格代表1分钟\n• 一大格代表5分钟\n• 钟面上有60个小格，所以走一圈是60分钟，也就是1小时')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('秒针:')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 15 })
            
            Text('• 秒针走得最快\n• 一小格代表1秒钟\n• 一大格代表5秒钟\n• 钟面上有60个小格，所以走一圈是60秒，也就是1分钟')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })
          
          // 读取时间方法
          Text('读取时间方法:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('1. 先看时针:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Start)
            
            Text('• 看时针指向几（或刚走过几）\n• 确定是几点或接近几点')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('2. 再看分针:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
              .textAlign(TextAlign.Start)
            
            Text('• 看分针指向几\n• 用指向的数字乘以5，得到分钟数\n• 如果分针指向12，就是整点')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('3. 举例说明:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
              .textAlign(TextAlign.Start)
            
            Text('• 时针指向3，分针指向12：3点整\n• 时针指向6，分针指向6：6点30分\n• 时针在9和10之间，分针指向3：9点15分')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })
          
          // 学习方法
          Text('学习方法:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          Column() {
            Text('1. 观察实物:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Start)
            
            Text('• 仔细观察家里的钟表\n• 注意三种指针的长短粗细\n• 观察指针的走动')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
            
            Text('2. 实践操作:')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
              .textAlign(TextAlign.Start)
            
            Text('• 拿一个有时针分针的时钟模型自己拨动\n• 让家长说时间，自己拨出来\n• 自己说时间，让家长检查')
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
            
            Text('• 做一些看钟表读时间的练习题\n• 和同学比赛谁认时间更快更准确\n• 每天固定时间观察钟表，培养时间观念')
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 5, left: 10 })
              .textAlign(TextAlign.Start)
          }
          .margin({ top: 10, left: 20, right: 20 })
          .padding(15)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })
          
          // 鼓励词汇
          Text('你已经掌握了认识钟表的匣子，继续加油学习更多的数学匣子吧！❤️')
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