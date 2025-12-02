import { ChinesePage } from './ChinesePage'
import { FamousPoetsListPage } from './chinese/FamousPoetsListPage'
import { FunFillPage } from './chinese/FunFillPage'
import HandwritingPage from './chinese/HandwritingPage'
import { PoetryLivePage } from './chinese/PoetryLivePage'
import { ProfilePage } from './ProfilePage'

@Entry
@Component
struct MainPage {
  @State selectedIndex: number = 0
  @State poetryLiveVisible: boolean = false  // Track Poetry Live tab visibility

  @Builder
  TabBuilder(text: string, index: number, icon: string) {
    Column() {
      Text(icon)
        .fontSize(13)
        .fontColor(this.selectedIndex === index ? $r('app.color.primary_brand') : $r('app.color.text_tertiary'))
      
      Text(text)
        .fontSize(this.selectedIndex === index ? 15 : 13)
        .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.selectedIndex === index ? $r('app.color.primary_brand') : $r('app.color.text_secondary'))
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 6, bottom: 6 })
  }

  build() {
    Column() {
      Tabs({}) {
        TabContent() {
          ChinesePage()
        }
        .tabBar(this.TabBuilder('匣', 0, '📜'))

        TabContent() {
          FamousPoetsListPage()
        }
        .tabBar(this.TabBuilder('著名诗人', 1, '🖋️'))

        TabContent() {
          FunFillPage()
        }
        .tabBar(this.TabBuilder('趣填', 2, '📝'))

        TabContent() {
          PoetryLivePage({ isVisible: this.poetryLiveVisible })
        }
        .tabBar(this.TabBuilder('动态画卷', 3, '🎬'))

      /*  TabContent() {
          HandwritingPage()
        }
        .tabBar(this.TabBuilder('趣味笔画', 4, '✍️'))
*/
        TabContent() {
          ProfilePage()
        }
        .tabBar(this.TabBuilder('我的', 4, '👤'))
      }
      .barPosition(BarPosition.End) // Move tabs to bottom
      .barHeight(60)
      .onChange((index: number) => {
        // 为Tab切换添加动画效果
        animateTo({
          duration: 200,
          curve: Curve.Sharp
        }, () => {
          this.selectedIndex = index
          // 更新Poetry Live tab的可见性
          this.poetryLiveVisible = (index === 3);
        });
      })
      // 为整个Tabs组件添加淡入淡出动画
      .animation({
        duration: 200,
        curve: Curve.Sharp
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}