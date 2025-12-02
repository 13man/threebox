@Component
export struct CommonCard {
  private title: string = ''
  private onTap?: () => void
  
  constructor(title: string, onTap?: () => void) {
    super()
    this.title = title
    this.onTap = onTap
  }
  
  build() {
    Column() {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_primary'))
    }
    .width('100%')
    .height(120)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(18)
    .shadow({ 
      radius: 12, 
      color: $r('app.color.text_tertiary'), 
      offsetX: 0, 
      offsetY: 6 
    })
    .onClick(() => {
      if (this.onTap) {
        this.onTap()
      }
    })
    .onHover((isHover: boolean) => {
      if (isHover) {
        animateTo({
          duration: 150,
          curve: Curve.Sharp
        }, () => {
          // Hover effect can be added here
        })
      }
    })
  }
}