import router from '@ohos.router';

// 定义告别语接口
interface FarewellItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct FarewellsPage {
  // 常用告别语列表
  private farewellsList: Array<FarewellItem> = [
    { 
      english: 'Goodbye!', 
      chinese: '再见！', 
      usage: '最常用的告别语，比较正式' 
    },
    { 
      english: 'Bye!', 
      chinese: '再见！', 
      usage: '比Goodbye更随意的告别语' 
    },
    { 
      english: 'See you!', 
      chinese: '再见！', 
      usage: '表示期待再次见面' 
    },
    { 
      english: 'See you later!', 
      chinese: '待会见！', 
      usage: '表示稍后会见面' 
    },
    { 
      english: 'See you tomorrow!', 
      chinese: '明天见！', 
      usage: '表示明天会见面' 
    },
    { 
      english: 'Have a nice day!', 
      chinese: '祝你今天愉快！', 
      usage: '祝愿对方度过美好的一天' 
    },
    { 
      english: 'Take care!', 
      chinese: '保重！', 
      usage: '表达关心和照顾之意' 
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
        
        Text('英语告别语')
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
            Text('告别语学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('告别语是英语交流的重要组成部分，合适的告别语能给人留下良好的最后印象。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 告别语列表
          Column() {
            Text('常用告别语')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.farewellsList, (item: FarewellItem, index: number) => {
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
                
                // 小喇叭图标表示可以朗读发音
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
            }, (item: FarewellItem) => item.english)
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
                Text('• Goodbye/Bye: 适用于任何场合的通用告别语\n' +
                     '• See you: 表示期待再次见面\n' +
                     '• See you later/tomorrow: 表示具体的再次见面时间\n' +
                     '• Have a nice day: 表达美好的祝愿\n' +
                     '• Take care: 表达关心和照顾之意')
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
              Text('场景：放学了，你和同学要分开回家')
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
                  
                  Text('See you tomorrow!')
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
                  
                  Text('See you!')
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
          
          // 小游戏：选择合适的告别语
          Column() {
            Text('互动练习')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('选择合适的告别语填空：')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              Text('A: I have to go home now.')
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 5 })
              
              Text('B: Okay, ______')
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 15 })
              
              // 选项
              Row() {
                Button('Good morning!')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ right: 5 })
                  .backgroundColor('#E0E0E0')
                  .fontColor($r('app.color.text_primary'))
                  .type(ButtonType.Normal)
                
                Button('See you!')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ left: 5, right: 5 })
                  .backgroundColor('#4CAF50')
                  .fontColor('#FFFFFF')
                  .type(ButtonType.Normal)
                
                Button('Thank you!')
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