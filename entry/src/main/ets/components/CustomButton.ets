@Component
export struct CustomButton {
  @Prop text: string = ''
  @Prop type: 'primary' | 'secondary' | 'danger' = 'primary'
  onTap?: () => void
  
  build() {
    Button(this.text)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor('#FFFFFF')
      .backgroundColor(this.getBackgroundColor())
      .borderRadius(25)
      .width(120)
      .height(45)
      .onClick(() => {
        if (this.onTap) {
          this.onTap()
        }
      })
  }
  
  private getBackgroundColor(): string {
    switch (this.type) {
      case 'primary':
        return '#3F51B5' // Primary brand color
      case 'secondary':
        return '#9E9E9E' // Secondary text color
      case 'danger':
        return '#F44336' // Danger/ negative color
      default:
        return '#3F51B5'
    }
  }
}