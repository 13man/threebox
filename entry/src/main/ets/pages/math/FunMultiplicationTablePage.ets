import router from '@ohos.router';

@Entry
@Component
struct FunMultiplicationTablePage {
  // 存储用户输入的答案
  @State userAnswers: Array<Array<string>> = Array(10).fill(null).map(() => Array(10).fill(''))
  // 存储答案是否正确的状态
  @State answerStatus: Array<Array<boolean>> = Array(10).fill(null).map(() => Array(10).fill(false))
  // 是否已经检查过答案
  @State isChecked: boolean = false

  // 获取数字对应的颜色
  getNumberColor(num: number): string {
    const colors = [
      '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFBE0B', '#FB5607', 
      '#8338EC', '#3A86FF', '#06D6A0', '#118AB2', '#073B4C'
    ];
    return colors[num % 10];
  }

  // 检查用户答案是否正确
  checkAnswer(row: number, col: number): boolean {
    if (!this.isChecked) return false
    return this.answerStatus[row][col]
  }

  // 更新用户答案
  updateUserAnswer(row: number, col: number, value: string) {
    this.userAnswers[row][col] = value
  }

  // 检查所有答案
  checkAllAnswers() {
    this.isChecked = true
    for (let i = 1; i <= 9; i++) {
      for (let j = 1; j <= 9; j++) {
        const correctAnswer = i * j
        const userAnswer = parseInt(this.userAnswers[i][j]) || 0
        this.answerStatus[i][j] = (userAnswer === correctAnswer)
      }
    }
  }

  // 重置所有答案
  resetAllAnswers() {
    this.isChecked = false
    for (let i = 1; i <= 9; i++) {
      for (let j = 1; j <= 9; j++) {
        this.userAnswers[i][j] = ''
        this.answerStatus[i][j] = false
      }
    }
  }

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
          .padding({ left: 10 })
        
        Text('九九乘法表好玩版本')
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
          Text('填空九九乘法表')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20 })

          Text('在空格中填入正确的答案，填对了显示绿色，填错了显示红色')
            .fontSize(16)
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Center)

          // 九九乘法表填空内容 - 显示完整的9x9表格
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (i: number) => {
            Row() {
              ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (j: number) => {
                Row() {
                  Text(`${j} × ${i} = `)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.getNumberColor(j)) // 为第一个数字添加颜色
                  
                  TextInput({ 
                    text: this.userAnswers[i][j]
                  })
                  .onChange((value: string) => {
                    this.updateUserAnswer(i, j, value)
                  })
                  .type(InputType.Number)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .width(60) // 调整输入框宽度
                  .height(40)
                  .textAlign(TextAlign.Center)
                  .border({
                    width: 2,
                    color: this.isChecked ? 
                      (this.checkAnswer(i, j) ? '#00FF00' : '#FF0000') : 
                      '#CCCCCC',
                    style: BorderStyle.Solid
                  })
                  
                  // 在答案正确时显示有趣的表情
                  if (this.isChecked && this.checkAnswer(i, j)) {
                    Text(' ✓')
                      .fontSize(16)
                      .fontColor('#00FF00')
                      .fontWeight(FontWeight.Bold)
                      .layoutWeight(1) // 让符号占用剩余空间
                      .textAlign(TextAlign.Center) // 居中对齐
                  } else if (this.isChecked && !this.checkAnswer(i, j)) {
                    Text(' ✗')
                      .fontSize(16)
                      .fontColor('#FF0000')
                      .fontWeight(FontWeight.Bold)
                      .layoutWeight(1) // 让符号占用剩余空间
                      .textAlign(TextAlign.Center) // 居中对齐
                  }
                }
                .width(140) // 调整容器宽度
                .height(50)
                .border({
                  width: 1,
                  color: '#CCCCCC',
                  style: BorderStyle.Solid
                })
                .justifyContent(FlexAlign.Center)
                .animation({
                  duration: 300,
                  tempo: 1.0,
                  delay: 0,
                  iterations: 1,
                  playMode: PlayMode.Normal
                }) // 添加动画效果
                .padding(5) // 调整内边距
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .margin({ bottom: 5 })
          })

          // 操作按钮
          Row() {
            Button('检查答案')
              .onClick(() => {
                this.checkAllAnswers()
              })
              .margin({ right: 10 })
              .backgroundColor('#4CAF50')
              .fontColor('#FFFFFF')
              .fontSize(16)

            Button('重置')
              .onClick(() => {
                this.resetAllAnswers()
              })
              .margin({ left: 10 })
              .backgroundColor('#F44336')
              .fontColor('#FFFFFF')
              .fontSize(16)
          }
          .margin({ top: 20 })
        }
        .padding({ top: 20, left: 20, right: 20, bottom: 20 })
        .width('350%') // 调整宽度以支持水平滚动
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