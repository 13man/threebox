import router from '@ohos.router';

@Entry
@Component
struct ComplaintPage {
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
        
        Text('投诉举报')
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
          Text('投诉举报')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20, bottom: 20 })
          
          Text('温馨提示')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('我们按照法律法规要求，采取相应安全保护措施以保护儿童以及用户的个人信息安全。如果您对本应用内容有任何疑问或者存在任何投诉意见，您可以通过以下方式进行相关的举报投诉：')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .textAlign(TextAlign.Start)
            .margin({ bottom: 20 })
          
          Column() {
            Text('1. 联系电话：17746841770')
              .fontSize(14)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Start)
              .margin({ bottom: 10 })
            
            Text('2. 联系邮箱：1418185347@qq.com')
              .fontSize(14)
              .fontColor($r('app.color.text_primary'))
              .textAlign(TextAlign.Start)
              .margin({ bottom: 10 })
            
            Text('(周一至周五 09:30-18:00，法定节假日除外)')
              .fontSize(12)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Start)
              .margin({ top: 10 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(10)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)
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