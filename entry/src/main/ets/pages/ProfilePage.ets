import router from '@ohos.router'

@Component
export struct ProfilePage {
  @State currentPage: string = ''
  @State appVersion: string = 'v1.0.4'

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('个人中心')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor($r('app.color.card_background'))
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 4 })
      
      // 功能列表区域
      Column() {
        // 常用功能标题
        Text('常用功能')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .width('90%')
          .textAlign(TextAlign.Start)
          .margin({ top: 30, bottom: 15 })
        
        // 功能项
        this.ProfileItem('用户协议', 'pages/AgreementPage')
        this.ProfileItem('隐私政策', 'pages/PrivacyPage')
        this.ProfileItem('关于我们', 'pages/AboutPage')
        this.ProfileItem('投诉举报', 'pages/ComplaintPage')
        
        // 应用信息区域
        Column() {
          Row() {
            Text('软件版本')
              .fontSize(16)
              .fontColor($r('app.color.text_primary'))
              .layoutWeight(1)
              .textAlign(TextAlign.Start)
            
            Text(this.appVersion)
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
          }
          .width('90%')
          .padding({ left: 15, right: 15, top: 15, bottom: 15 })
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(12)
          .margin({ top: 20 })
        }
        .width('100%')
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder
  ProfileItem(title: string, pageUrl: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor($r('app.color.text_primary'))
        .layoutWeight(1)
        .textAlign(TextAlign.Start)
      
      // 右侧箭头图标
      Text('>')
        .fontSize(16)
        .fontColor($r('app.color.text_tertiary'))
    }
    .width('90%')
    .height(55)
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(12)
    .padding({ left: 15, right: 15 })
    .margin({ top: 12 })
    .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
    .onClick(() => {
      router.push({ url: pageUrl })
    })
    .onHover((isHover: boolean) => {
      if (isHover) {
        animateTo({
          duration: 150,
          curve: Curve.Sharp
        }, () => {
          // Add hover effect
        })
      }
    })
  }
}