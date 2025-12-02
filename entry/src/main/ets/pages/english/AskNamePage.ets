import router from '@ohos.router';

// 定义询问姓名接口
interface AskNameItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct AskNamePage {
  // 常用询问姓名语句列表
  private askNameList: Array<AskNameItem> = [
    { 
      english: 'What is your name?', 
      chinese: '你叫什么名字？', 
      usage: '询问对方姓名的常用语' 
    },
    { 
      english: 'May I have your name?', 
      chinese: '可以告诉我你的名字吗？', 
      usage: '礼貌询问对方姓名' 
    },
    { 
      english: 'What should I call you?', 
      chinese: '我应该叫你什么？', 
      usage: '询问对方希望被如何称呼' 
    },
    { 
      english: 'Could you tell me your name?', 
      chinese: '你能告诉我你的名字吗？', 
      usage: '客气地询问对方姓名' 
    },
    { 
      english: 'My name is Tom. And you?', 
      chinese: '我叫汤姆，你呢？', 
      usage: '先介绍自己再询问对方姓名' 
    },
    { 
      english: 'Nice to meet you, Tom!', 
      chinese: '很高兴认识你，汤姆！', 
      usage: '得知对方姓名后的礼貌回应' 
    },
    { 
      english: 'Pleased to meet you!', 
      chinese: '很高兴见到你！', 
      usage: '初次见面的礼貌用语' 
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
        
        Text('询问姓名')
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
            Text('询问姓名学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('学会如何礼貌地询问他人姓名是建立友谊的第一步，让我们来看看相关的表达。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 询问姓名语句列表
          Column() {
            Text('常用询问语')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.askNameList, (item: AskNameItem, index: number) => {
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
            }, (item: AskNameItem) => item.english)
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
                Text('• What is your name?: 直接询问对方姓名\n' +
                     '• May I have your name?: 礼貌询问对方姓名\n' +
                     '• What should I call you?: 询问对方希望被如何称呼\n' +
                     '• Could you tell me your name?: 客气地询问对方姓名\n' +
                     '• ...And you?: 先介绍自己再询问对方\n' +
                     '• Nice to meet you...: 得知对方姓名后的礼貌回应')
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
              Text('场景：在夏令营中认识新朋友')
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
                  
                  Text('Hi! My name is Tom. What is your name?')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('新朋友:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(50)
                  
                  Text('Hello, Tom! My name is Lucy. Nice to meet you!')
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
            .backgroundColor($r('app.color.page_background'))
            .borderRadius(15)
            .margin({ left: 15, right: 15 })
          }
          
          // 趣味理解设计 - 角色扮演
          Column() {
            Text('角色扮演')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('如果你是下面对话中的小明，你会如何回应？')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              Row() {
                Text('小红:')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.text_primary'))
                  .width(40)
                
                Text('Hi! I am Xiaohong. What is your name?')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
              }
              .padding({ left: 10, right: 10, top: 8, bottom: 8 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(8)
              .margin({ bottom: 10 })
              
              Text('你的回答：')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
              
              // 回答选项
              Column() {
                Row() {
                  Text('A. My name is Xiaoming. Nice to meet you!')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('B. I am fine, thank you.')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('C. How are you?')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
              }
            }
            .padding({ left: 10, right: 10, top: 10, bottom: 20 })
            .backgroundColor($r('app.color.page_background'))
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