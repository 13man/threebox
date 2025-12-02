import router from '@ohos.router';
import display from '@ohos.display';

@Entry
@Component
struct MultiplicationTablePage {
  @State isLandscape: boolean = false;

  aboutToAppear(): void {
    // 获取屏幕方向信息
    try {
      let dis = display.getDefaultDisplaySync();
      this.isLandscape = dis.rotation % 2 === 1; // 横屏检测
    } catch (err) {
      console.error('Failed to get display info: ' + err);
    }
  }

  build() {
    Column() {
      Row() {
        // 使用文本箭头替代图片
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        
        Text('九九乘法表')
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
          // 九九乘法表内容 - 按照传统三角形布局
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (i: number) => {
            Row() {
              ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (j: number) => {
                if (j <= i) {
                  Row() {
                    Text(`${j} × ${i} = ${j * i}`)
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor($r('app.color.text_primary'))
                      .textAlign(TextAlign.Center)
                      .layoutWeight(1)
                  }
                  .width(80)
                  .height(30)
                  .backgroundColor($r('app.color.card_background'))
                  .border({
                    width: 1,
                    color: $r('app.color.text_tertiary'),
                    style: BorderStyle.Solid
                  })
                }
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ bottom: 5 })
          })
        }
        .padding({ top: 20, left: 20, right: 20 })
        .width('200%') // 固定宽度确保所有内容都能显示
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Horizontal | ScrollDirection.Vertical) // 启用水平和垂直滚动
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}