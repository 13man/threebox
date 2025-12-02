@Entry
@Component
export struct AgreementPage {
  build() {
    Column() {
      Scroll() {
        Column() {
          Text('用户协议')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 20 })
          
          Text('欢迎您使用诗匣应用！')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('本用户协议（以下简称“协议”）是您（以下简称“用户”）与诗匣应用（以下简称“本应用”）之间的法律协议。本协议规定了您使用本应用服务的相关条款。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('一、服务内容')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('1. 本应用是一个教育类工具应用，提供古诗词学习辅助工具。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('2. 本应用提供的所有服务均为免费服务。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('3. 本应用不收集任何用户个人信息，不涉及任何用户权限申请。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('二、使用规则')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('1. 用户在使用本应用时，应遵守相关法律法规，不得利用本应用从事任何违法活动。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('2. 用户不得对本应用进行反向工程、反编译、修改等行为。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('3. 用户应合理使用本应用提供的功能，不得恶意刷取或滥用。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('三、免责声明')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('1. 本应用提供的所有内容仅供学习参考，不构成任何专业建议。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('2. 用户在使用本应用过程中产生的任何问题，本应用不承担任何责任。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('3. 本应用不对服务的及时性、安全性、准确性做出保证。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('四、协议修改')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })
          
          Text('1. 本应用有权在必要时修改本协议条款，修改后的协议将在应用内公布。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('2. 用户如不同意修改后的协议，可停止使用本应用服务。')
            .fontSize(14)
            .textAlign(TextAlign.Start)
            .margin({ bottom: 5 })
          
          Text('3. 用户继续使用本应用服务视为接受修改后的协议。')
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