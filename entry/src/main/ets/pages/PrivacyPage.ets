@Entry
@Component
export struct PrivacyPage {
  build() {
    Column() {
      Scroll() {
        Column() {
          Text('隐私政策（更新时间：2025年12月2日 生效时间：2025年12月2日）')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })
          
          Text('诗匣应用深知个人信息对您的重要性，我们将按照法律法规要求，保护您的个人信息及隐私安全。本隐私政策将详细说明我们在收集、使用、存储和共享您的个人信息方面的政策和措施。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('一、我们如何收集和使用您的个人信息')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('本应用不会主动收集、存储或上传任何用户的个人信息。在您使用本应用的过程中，我们不会要求您提供任何个人身份信息。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('二、我们如何存储和保护您的个人信息')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('由于本应用不收集任何用户个人信息，因此不存在个人信息的存储和泄露风险。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('三、我们如何共享、转让、公开披露您的个人信息')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('本应用不会共享、转让或公开披露您的个人信息，因为本应用不收集任何用户个人信息。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('四、我们如何使用Cookie和同类技术')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('本应用不使用Cookie和同类技术收集用户信息。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('五、我们如何保护未成年人的个人信息')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('如果有未成年人使用本应用，由于本应用不收集任何用户个人信息，因此不存在未成年人个人信息保护问题。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('六、您的个人信息权益保障')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('您有权随时停止使用本应用，由于本应用不收集任何用户个人信息，因此不存在撤回同意或注销账户的需求。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('七、隐私政策的修订')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('我们可能会适时修订本隐私政策内容。如修订内容对您的权益产生重大影响，我们会通过应用内通知等方式告知您。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('八、联系我们')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('如果您对本隐私政策有任何疑问，可以通过应用内的反馈渠道与我们联系。')
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