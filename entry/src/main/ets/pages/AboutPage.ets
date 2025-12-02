import router from '@ohos.router';

@Entry
@Component
export struct AboutPage {
  build() {
    Column() {
      Scroll() {
        Column() {
          Text('关于我们')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })
          
          Text('应用名称：诗匣')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('应用简介')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('诗匣是一款面向爱好古诗词等多功能学习工具应用具，帮助用户更轻松地学习和掌握相关匣子。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('功能特色')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('1. 匣子：提供著名诗人详细介绍，包括李白、杜甫、李清照等，用户可以了解诗人生平、代表作品和主要成就')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('2. 趣味填词：为每位著名诗人提供专属的填词挑战游戏，包含20+首经典诗词，用户可以通过互动游戏加深对古典诗词的理解')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          Text('3. 摇一摇出题：把“做题”变成“抽盲盒”，解决“默认题顺序枯燥”问题')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          Text('4. 残局拼图：看起来是“拼图”，其实是“填词”变种，小朋友也能玩')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          Text('5. 墨汁遮盖：把“填字”做成“刮刮”，视觉反馈爽')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          Text('6. 动态画卷：诗词不是静态，是“活的”，诗是动画，我是导演，每一首诗生成一个动态画卷（鸿蒙专属粒子动画）')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          Text('联系我们')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('如有任何问题或建议，欢迎通过以下方式联系我们：')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('邮箱：1418185347@qq.com')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          // 添加投诉举报条目
          Text('投诉举报')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10, top: 10 })
          
          Text('如果您对本应用内容有任何疑问或者存在任何投诉意见，您可以点击这里进行投诉举报')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .fontColor('#007DFF')
            .onClick(() => {
              router.push({ url: 'pages/ComplaintPage' })
            })
            .margin({ bottom: 10 })

          Text('版本信息')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('当前版本：v1.0.4')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 20 })
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('90%')
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')

  }
}