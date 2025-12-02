import router from '@ohos.router';

// 定义题目接口
interface Question {
  id: number;
  title: string;
  author: string;
  poem: string;
  blanks: Blank[];
}

interface Blank {
  index: number;
  options: string[];
  correct: string;
}

@Entry
@Component
export struct TangFillPage {
  // 唐诗填词题目
  @State private questions: Question[] = [
    {
      id: 1,
      title: '春晓',
      author: '孟浩然',
      poem: '__ __ 明月光，疑是地上霜。\n举头望明月，低头思故乡。',
      blanks: [
        {
          index: 0,
          options: ['床前', '窗前', '门前'],
          correct: '床前'
        }
      ]
    },
    {
      id: 2,
      title: '静夜思',
      author: '李白',
      poem: '床前明月光，疑是地上__ __。\n举头望明月，低头思故乡。',
      blanks: [
        {
          index: 0,
          options: ['霜', '雪', '露'],
          correct: '霜'
        }
      ]
    }
  ];

  @State currentQuestionIndex: number = 0;
  @State selectedAnswers: string[] = [];
  @State showResult: boolean = false;
  @State isCorrect: boolean = false;

  aboutToAppear(): void {
    // 初始化答案数组
    this.selectedAnswers = new Array(this.questions[this.currentQuestionIndex].blanks.length).fill('');
  }

  build() {
    Column() {
      Row() {
        Text('唐诗填词')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ top: 20 })
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      // 题目进度
      Text(`第 ${this.currentQuestionIndex + 1} 题 / 共 ${this.questions.length} 题`)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({ top: 10 })

      // 题目内容
      Column() {
        Text(this.questions[this.currentQuestionIndex].title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
        
        Text(this.questions[this.currentQuestionIndex].author)
          .fontSize(14)
          .fontColor($r('app.color.text_secondary'))
          .margin({ top: 5 })
        
        // 诗歌内容（带填空）
        this.renderPoemWithBlanks()
      }
      .width('100%')
      .padding(20)
      .layoutWeight(1)

      // 答题按钮
      if (!this.showResult) {
        Button('提交答案')
          .width('80%')
          .height(50)
          .fontSize(18)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .margin({ bottom: 80 })
          .onClick(() => {
            this.checkAnswer();
          })
      } else {
        Column() {
          Text(this.isCorrect ? '回答正确！' : '回答错误！')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isCorrect ? Color.Green : Color.Red)
          
          if (!this.isCorrect) {
            Text(`正确答案：${this.questions[this.currentQuestionIndex].blanks[0].correct}`)
              .fontSize(16)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10 })
          }
          
          Button(this.currentQuestionIndex < this.questions.length - 1 ? '下一题' : '完成')
            .width('80%')
            .height(50)
            .fontSize(18)
            .backgroundColor($r('app.color.card_background'))
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20, bottom: 80 })
            .onClick(() => {
              if (this.currentQuestionIndex < this.questions.length - 1) {
                this.nextQuestion();
              } else {
                // 完成所有题目
                router.back();
              }
            })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.chinese_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }

  @Builder
  renderPoemWithBlanks() {
    Column() {
      // 这里简化处理，实际应该根据blanks数组动态生成填空
      Text(this.questions[this.currentQuestionIndex].poem)
        .fontSize(16)
        .fontColor($r('app.color.text_primary'))
        .textAlign(TextAlign.Center)
        .lineHeight(30)
      
      // 选项按钮
      ForEach(this.questions[this.currentQuestionIndex].blanks[0].options, (option: string, index: number) => {
        Button(option)
          .width('80%')
          .height(40)
          .margin({ top: 10 })
          .backgroundColor(
            this.selectedAnswers[0] === option ? 
            $r('app.color.text_primary') : 
            $r('app.color.card_background')
          )
          .fontColor(
            this.selectedAnswers[0] === option ? 
            Color.White : 
            $r('app.color.text_primary')
          )
          .onClick(() => {
            this.selectedAnswers[0] = option;
          })
      })
    }
    .width('100%')
    .padding({ top: 20 })
  }

  checkAnswer() {
    const currentQuestion = this.questions[this.currentQuestionIndex];
    this.isCorrect = this.selectedAnswers[0] === currentQuestion.blanks[0].correct;
    this.showResult = true;
  }

  nextQuestion() {
    if (this.currentQuestionIndex < this.questions.length - 1) {
      this.currentQuestionIndex++;
      this.selectedAnswers = new Array(this.questions[this.currentQuestionIndex].blanks.length).fill('');
      this.showResult = false;
    }
  }
}