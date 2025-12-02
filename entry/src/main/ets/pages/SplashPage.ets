import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import dataPreferences from '@ohos.data.preferences'
import { common } from '@kit.AbilityKit'
import { CustomButton } from '../components/CustomButton'

@Entry
@Component
struct SplashPage {
  @State showPrivacyDialog: boolean = false
  @State appTitleOpacity: number = 0
  @State appNameOpacity: number = 0
  @State imageScale: number = 0.8

  aboutToAppear(): void {
    // Animate in the splash screen elements
    setTimeout(() => {
      this.appTitleOpacity = 1
      this.appNameOpacity = 1
      this.imageScale = 1
    }, 100)
    
    // Check if user has already agreed to privacy policy
    try {
      dataPreferences.getPreferences(getContext(), 'privacy_config', (err, preferences) => {
        if (err) {
          console.error('Failed to get preferences: ' + err)
          // Show dialog even if there's an error
          setTimeout(() => {
            this.showPrivacyDialog = true
          }, 1500)
          return
        }
        preferences.get('privacy_accepted', false, (err, value: Object) => {
          if (err) {
            console.error('Failed to get privacy_accepted: ' + err)
            // Show dialog even if there's an error
            setTimeout(() => {
              this.showPrivacyDialog = true
            }, 1500)
            return
          }
          if (value) {
            // Already agreed, navigate to main page
            setTimeout(() => {
              router.replace({ url: 'pages/MainPage' })
            }, 1500)
          } else {
            // Not agreed yet, show privacy policy dialog
            setTimeout(() => {
              this.showPrivacyDialog = true
            }, 1500)
          }
        })
      })
    } catch (error) {
      console.error('Error in aboutToAppear: ' + error)
      // Show dialog even if there's an error
      setTimeout(() => {
        this.showPrivacyDialog = true
      }, 1500)
    }
  }

  build() {
    Stack() {
      Column() {
        Text('诗匣')
          .fontSize(42)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_brand'))
          .margin({ bottom: 30 })
          .opacity(this.appTitleOpacity)
          .animation({
            duration: 800,
            curve: Curve.EaseInOut
          })
        
        Image($r('app.media.layered_image'))
          .width(140)
          .height(140)
          .margin({ bottom: 30 })
          .scale({ x: this.imageScale, y: this.imageScale })
          .animation({
            duration: 800,
            curve: Curve.EaseOut // 修复：使用正确的动画曲线
          })
        
        Text('欢迎使用诗匣')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .opacity(this.appNameOpacity)
          .animation({
            duration: 800,
            curve: Curve.EaseInOut,
            delay: 200
          })
        
/*        // Loading indicator
        Row() {
          ForEach([0, 1, 2], (index: number) => {
            Column()
              .width(10)
              .height(10)
              .borderRadius(5)
              .backgroundColor($r('app.color.primary_brand'))
              .margin({ left: 5, right: 5 })
              .scale({ 
                x: this.showPrivacyDialog || index !== 0 ? 1 : 1.5,
                y: this.showPrivacyDialog || index !== 0 ? 1 : 1.5
              })
              .animation({
                duration: 600,
                curve: Curve.Sharp,
                delay: index * 200,
                iterations: this.showPrivacyDialog ? 1 : -1 // Infinite when not showing dialog
              })
          }, (index: number) => `${index}`)
        }
        .margin({ top: 60 })*/
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.page_background'))
      .justifyContent(FlexAlign.Center)
      
      // Background overlay
      if (this.showPrivacyDialog) {
        Rect()
          .fill(Color.Black)
          .opacity(0.6)
          .height('100%')
          .width('100%')
          .animation({
            duration: 300,
            curve: Curve.EaseInOut
          })
      }
      
      // Privacy dialog
      if (this.showPrivacyDialog) {
        this.PrivacyDialog()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  PrivacyDialog() {
    Column() {
      Column() {
        Text('用户隐私政策说明')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
        
        Text('在您使用本应用前，请仔细阅读并同意我们的')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 20 })
        
        Row() {
          Text('《')
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
          
          Text('用户协议')
            .fontSize(16)
            .fontColor($r('app.color.primary_brand'))
            .onClick(() => {
              // Navigate to agreement page
              router.push({ url: 'pages/AgreementPage' })
            })
            .onHover((isHover: boolean) => {
              if (isHover) {
                // Add hover effect
              }
            })
          
          Text('》和《')
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
          
          Text('隐私政策')
            .fontSize(16)
            .fontColor($r('app.color.primary_brand'))
            .onClick(() => {
              // Navigate to privacy policy page
              router.push({ url: 'pages/PrivacyPage' })
            })
            .onHover((isHover: boolean) => {
              if (isHover) {
                // Add hover effect
              }
            })
          
          Text('》')
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
        }
        .margin({ top: 10 })
        
        Text('。本应用不会收集任何用户个人信息，也不需要任何敏感权限。')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 15 })
        
        // 修复：使用标准Button组件替代自定义按钮，确保文字显示和点击事件正常
        Row() {
          Button('拒绝')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#F44336')
            .borderRadius(25)
            .width(100)
            .height(45)
            .onClick(() => {
              this.showPrivacyDialog = false
              console.info('User refused privacy policy')
              setTimeout(() => {
                let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
                context.terminateSelf().catch(() => {
                });
              }, 500)
            })
          
          Blank().width(30)
          
          Button('同意')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#3F51B5')
            .borderRadius(25)
            .width(100)
            .height(45)
            .onClick(() => {
              this.handleAgree()
            })
        }
        .margin({ top: 30 })
      }
      .width('90%')
      .padding(25)
      .backgroundColor($r('app.color.card_elevated'))
      .borderRadius(20)
      .shadow({
        radius: 20,
        color: '#00000033',
        offsetX: 0,
        offsetY: 8
      })
      .scale({ x: this.showPrivacyDialog ? 1 : 0.8, y: this.showPrivacyDialog ? 1 : 0.8 })
      .animation({
        duration: 300,
        curve: Curve.Sharp
      })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
  


  handleAgree() {
    this.showPrivacyDialog = false
    console.info('User accepted privacy policy')
    try {
      dataPreferences.getPreferences(getContext(), 'privacy_config', (err, preferences) => {
        if (err) {
          console.error('Failed to get preferences: ' + err)
          return
        }
        preferences.put('privacy_accepted', true, (err) => {
          if (err) {
            console.error('Failed to save privacy_accepted: ' + err)
            return
          }
          preferences.flush((err) => {
            if (err) {
              console.error('Failed to flush preferences: ' + err)
              return
            }
            console.info('Privacy policy accepted status saved')
            router.replace({ url: 'pages/MainPage' })
          })
        })
      })
    } catch (error) {
      console.error('Error handling agreement: ' + error)
    }
  }

  acceptPrivacyPolicy() {
    console.info('User accepted privacy policy')
    dataPreferences.getPreferences(getContext(), 'privacy_config', (err, preferences) => {
      if (err) {
        console.error('Failed to get preferences: ' + err)
        return
      }
      preferences.put('privacy_accepted', true, (err) => {
        if (err) {
          console.error('Failed to save privacy_accepted: ' + err)
          return
        }
        preferences.flush((err) => {
          if (err) {
            console.error('Failed to flush preferences: ' + err)
            return
          }
          console.info('Privacy policy accepted status saved')
          router.replace({ url: 'pages/MainPage' })
        })
      })
    })
  }
}