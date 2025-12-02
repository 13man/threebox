import router from '@ohos.router';

// 定义问候语接口
interface GreetingItem {
  english: string;
  chinese: string;
  usage: string;
}

// 定义问题接口
interface QuestionItem {
  question: string;
  options: string[];
  answer: number;
}

@Entry
@Component
export struct GreetingsPage {
  // 常用问候语列表
  private greetingsList: Array<GreetingItem> = [
    { 
      english: 'Hello!', 
      chinese: '你好！', 
      usage: '最常用的问候语，适用于任何时间' 
    },
    { 
      english: 'Hi!', 
      chinese: '你好！', 
      usage: '比Hello更随意的问候语' 
    },
    { 
      english: 'Good morning!', 
      chinese: '早上好！', 
      usage: '上午时使用的问候语' 
    },
    { 
      english: 'Good afternoon!', 
      chinese: '下午好！', 
      usage: '下午时使用的问候语' 
    },
    { 
      english: 'Good evening!', 
      chinese: '晚上好！', 
      usage: '傍晚或晚上时使用的问候语' 
    },
    { 
      english: 'How are you?', 
      chinese: '你好吗？', 
      usage: '询问对方近况' 
    },
    { 
      english: 'How is it going?', 
      chinese: '最近怎么样？', 
      usage: '比较随意的询问近况' 
    }
  ];

  // 互动练习题目
  @State currentQuestionIndex: number = 0;
  private questions: Array<QuestionItem> = [
    {
      question: '早上遇到同学应该说什么？',
      options: ['Good afternoon!', 'Good morning!', 'Good evening!', 'Bye!'],
      answer: 1
    },
    {
      question: '下午见到老师应该说什么？',
      options: ['Good morning!', 'Hello!', 'Good afternoon!', 'Good night!'],
      answer: 2
    },
    {
      question: '哪一个是"你好"的英文？',
      options: ['Bye!', 'Hi!', 'Thank you!', 'Sorry!'],
      answer: 1
    }
  ];
  
  @State selectedOption: number = -1;
  @State showResult: boolean = false;
  @State isCorrect: boolean = false;

  build() {
    Column() {
      // 标题栏
      Row() {
           Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ left: 10 })
          .type(ButtonType.Normal)
          .borderRadius(20)
          .width(80)
          .height(40)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .animation({ duration: 300 })
          .shadow({
            radius: 5,
            color: $r('app.color.text_tertiary_bank_card_03'),
            offsetX: 0,
            offsetY: 2
          })
        
        Text('英语问候语')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      
      Scroll() {
        Column() {
          // 介绍部分
          Column() {
            Text('问候语学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('问候语是英语交流的第一步，正确的问候能给人留下良好的印象。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 问候语列表
          Column() {
            Text('常用问候语')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.greetingsList, (item: GreetingItem, index: number) => {
              Row() {
                Column() {
                  Text(item.english)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                  
                  Text(item.chinese)
                    .fontSize(14)
                    .fontColor($r('app.color.text_secondary'))
                    .margin({ top: 2 })
                  
                  Text(item.usage)
                    .fontSize(12)
                    .fontColor($r('app.color.text_tertiary'))
                    .margin({ top: 3 })
                }
                .layoutWeight(1)
                
                // 注释掉不存在的资源引用，避免编译错误
                // Image($r('app.media.speaker'))
                //   .width(24)
                //   .height(24)
                //   .margin({ right: 15 })
                //   .onClick(() => {
                //     // 模拟朗读发音
                //     console.log('Playing pronunciation for:', item.english);
                //   })
              }
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(10)
              .margin({ left: 15, right: 15 })
              .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
            }, (item: GreetingItem) => item.english)
          }
          .width('100%')
          .margin({ top: 10 })
          
          // 使用场景说明
          Column() {
            Text('使用场景')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Row() {
              Column() {
                Text('• Hello/Hi: 适用于任何时间，是最通用的问候语\n' +
                     '• Good morning: 适用于上午（通常到中午12点）\n' +
                     '• Good afternoon: 适用于下午（中午12点到傍晚6点）\n' +
                     '• Good evening: 适用于傍晚和晚上（下午6点以后）')
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 趣味互动练习
          Column() {
            Text('趣味练习')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Column() {
              // 题目
              Text(this.questions[this.currentQuestionIndex].question)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 20 })
                .textAlign(TextAlign.Center)
              
              // 选项
              ForEach(this.questions[this.currentQuestionIndex].options, (option: string, index: number) => {
                Row() {
                  Text(option)
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                
                  // 选择标记（使用文本代替图片）
                  if (this.selectedOption === index) {
                    Text('✓')
                      .fontSize(20)
                      .fontColor('#4CAF50')
                  } else {
                    Text('○')
                      .fontSize(20)
                      .fontColor($r('app.color.text_tertiary'))
                  }
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor(this.selectedOption === index ? $r('app.color.card_background') : $r('app.color.card_background'))
                .borderRadius(8)
                .margin({ left: 20, right: 20, bottom: 10 })
                .onClick(() => {
                  this.selectedOption = index;
                })
              }, (option: string) => option)
              
              // 提交按钮
              Button('提交答案')
                .onClick(() => {
                  if (this.selectedOption !== -1) {
                    this.isCorrect = (this.selectedOption === this.questions[this.currentQuestionIndex].answer);
                    this.showResult = true;
                  }
                })
                .margin({ top: 10,bottom:80 })
                .type(ButtonType.Normal)
                .enabled(this.selectedOption !== -1)
              
              // 结果显示
              if (this.showResult) {
                Column() {
                  Text(this.isCorrect ? '回答正确! 🎉' : '回答错误，再试试看!')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.isCorrect ? '#4CAF50' : '#F44336')
                    .margin({ top: 10 })
                  
                  if (!this.isCorrect) {
                    Text('正确答案: ' + this.questions[this.currentQuestionIndex].options[this.questions[this.currentQuestionIndex].answer])
                      .fontSize(14)
                      .fontColor($r('app.color.text_secondary'))
                      .margin({ top: 5 })
                  }
                  
                  // 下一题按钮
                  Button('下一题')
                    .onClick(() => {
                      this.showResult = false;
                      this.selectedOption = -1;
                      this.currentQuestionIndex = (this.currentQuestionIndex + 1) % this.questions.length;
                    })
                    .margin({ top: 10 ,bottom:80})
                    .type(ButtonType.Normal)
                }
                .padding({ top: 10, bottom: 10 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(15)
                .margin({ left: 15, right: 15 })
              }
            }
            .padding({ left: 10, right: 10, top: 10, bottom: 20 })
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(15)
            .margin({ left: 15, right: 15 })
          }
          
          // 鼓励性文字和表情
          Column() {
            Text('你已经很棒了！继续加油！😊')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4CAF50')
              .textAlign(TextAlign.Center)
              .margin({ top: 30, bottom: 20 })

          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          Blank()
        }
        .width('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}