@Component
export struct PageHeader {
  private title: string = ''
  private showBack?: boolean = false
  private onBack?: () => void
  
  constructor(title: string, showBack?: boolean, onBack?: () => void) {
    super()
    this.title = title
    this.showBack = showBack || false
    this.onBack = onBack
  }
  
  build() {
    Row() {
      if (this.showBack) {
        Button('返回')
          .type(ButtonType.Circle)
          .width(40)
          .height(40)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .margin({ left: 10 })
          .onClick(() => {
            if (this.onBack) {
              this.onBack()
            }
          })
          .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
      }
      
      Text(this.title)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_primary'))
        .layoutWeight(1)
        .textAlign(this.showBack ? TextAlign.Center : TextAlign.Start)
        .margin({ left: this.showBack ? 0 : 20 })
    }
    .height(60)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('app.color.card_background'))
    .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 4 })
  }
}