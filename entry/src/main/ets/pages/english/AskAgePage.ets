import router from '@ohos.router';

// 定义年龄表达接口
interface AgeItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct AskAgePage {
  // 常用年龄表达语句列表
  private ageList: Array<AgeItem> = [
    { 
      english: 'How old are you?', 
      chinese: '你多大了？', 
      usage: '询问对方年龄' 
    },
    { 
      english: 'What is your age?', 
      chinese: '你几岁了？', 
      usage: '正式询问对方年龄' 
    },
    { 
      english: 'I am ten years old.', 
      chinese: '我十岁了。', 
      usage: '表达自己的年龄' 
    },
    { 
      english: 'I am in Grade 4.', 
      chinese: '我在四年级。', 
      usage: '表达自己的年级' 
    },
    { 
      english: 'I was born in 2014.', 
      chinese: '我出生于2014年。', 
      usage: '表达自己的出生年份' 
    },
    { 
      english: 'I will be eleven next year.', 
      chinese: '明年我就十一岁了。', 
      usage: '表达将来的年龄' 
    },
    { 
      english: 'She is older than me.', 
      chinese: '她比我大。', 
      usage: '比较年龄' 
    }
  ];

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
        
        Text('表达年龄')
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
            Text('年龄表达学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('学会如何询问和表达年龄是日常交流的重要内容，让我们来看看相关的英语表达。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 年龄表达语句列表
          Column() {
            Text('常用表达')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.ageList, (item: AgeItem, index: number) => {
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
              }
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(10)
              .margin({ left: 15, right: 15 })
              .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
            }, (item: AgeItem) => item.english)
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
                Text('• How old are you?: 询问对方年龄\n' +
                     '• What is your age?: 正式询问对方年龄\n' +
                     '• I am...years old: 表达自己的年龄\n' +
                     '• I am in Grade...: 表达自己的年级\n' +
                     '• I was born in...: 表达自己的出生年份\n' +
                     '• I will be...next year: 表达将来的年龄\n' +
                     '• ...is older/younger than...: 比较年龄')
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 趣味互动场景
          Column() {
            Text('情景对话')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Column() {
              Text('场景：在生日聚会上认识新朋友')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
              
              // 对话框
              Column() {
                Row() {
                  Text('你:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('Happy birthday! How old are you?')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('朋友:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('Thank you! I am ten years old. How old are you?')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                
                Row() {
                  Text('你:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('I am ten too!')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ top: 5 })
              }
              .padding({ left: 15, right: 15, top: 10, bottom: 10 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(10)
              .margin({ left: 20, right: 20 })
            }
            .padding({ left: 10, right: 10, top: 10, bottom: 20 })
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(15)
            .margin({ left: 15, right: 15 })
          }
          
          // 趣味理解设计 - 数字游戏
          Column() {
            Text('数字游戏')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('选择正确的英文表达：')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              Text('我八岁了。')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
              
              // 选项
              Row() {
                Button('I am eight years old.')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ right: 5 })
                  .backgroundColor('#4CAF50')
                  .fontColor('#FFFFFF')
                  .type(ButtonType.Normal)
                
                Button('I am in Grade 8.')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ left: 5, right: 5 })
                  .backgroundColor('#E0E0E0')
                  .fontColor($r('app.color.text_primary'))
                  .type(ButtonType.Normal)
                
                Button('I like number 8.')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ left: 5 })
                  .backgroundColor('#E0E0E0')
                  .fontColor($r('app.color.text_primary'))
                  .type(ButtonType.Normal)
              }
              .padding({ left: 20, right: 20 })
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