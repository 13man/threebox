import router from '@ohos.router';

// 定义道歉语接口
interface ApologyItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct ApologiesPage {
  // 常用道歉语列表
  private apologiesList: Array<ApologyItem> = [
    { 
      english: 'Sorry!', 
      chinese: '对不起！', 
      usage: '最常用的道歉语' 
    },
    { 
      english: 'I am sorry!', 
      chinese: '我很抱歉！', 
      usage: '比Sorry更正式的道歉语' 
    },
    { 
      english: 'Excuse me!', 
      chinese: '打扰一下！/不好意思！', 
      usage: '轻微的道歉或引起注意' 
    },
    { 
      english: 'I apologize!', 
      chinese: '我道歉！', 
      usage: '正式的道歉' 
    },
    { 
      english: 'My apologies!', 
      chinese: '我道歉！', 
      usage: '正式的道歉表达' 
    },
    { 
      english: 'I am really sorry!', 
      chinese: '我真的很抱歉！', 
      usage: '表达深深的歉意' 
    },
    { 
      english: 'Please forgive me!', 
      chinese: '请原谅我！', 
      usage: '请求对方原谅' 
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
        
        Text('英语道歉语')
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
            Text('道歉语学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('合适的道歉语能表达我们的歉意，修复关系，让交流更加和谐。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 道歉语列表
          Column() {
            Text('常用道歉语')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.apologiesList, (item: ApologyItem, index: number) => {
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
            }, (item: ApologyItem) => item.english)
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
                Text('• Sorry/I am sorry: 一般性的道歉\n' +
                     '• Excuse me: 轻微的道歉或引起注意\n' +
                     '• I apologize/My apologies: 正式的道歉\n' +
                     '• I am really sorry: 表达深深的歉意\n' +
                     '• Please forgive me: 请求对方原谅')
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
              Text('场景：不小心撞到了同学')
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
                  
                  Text('Sorry! I did not see you.')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('同学:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('That is okay.')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
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