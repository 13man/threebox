import router from '@ohos.router';

// 定义自我介绍接口
interface IntroduceItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct IntroducePage {
  // 常用自我介绍语句列表
  private introduceList: Array<IntroduceItem> = [
    { 
      english: 'My name is Tom.', 
      chinese: '我叫汤姆。', 
      usage: '介绍自己的姓名' 
    },
    { 
      english: 'I am ten years old.', 
      chinese: '我十岁了。', 
      usage: '介绍自己的年龄' 
    },
    { 
      english: 'I am a student.', 
      chinese: '我是个学生。', 
      usage: '介绍自己的身份' 
    },
    { 
      english: 'I am in Class 3, Grade 4.', 
      chinese: '我在四年级三班。', 
      usage: '介绍自己的班级' 
    },
    { 
      english: 'I live in Beijing.', 
      chinese: '我住在北京。', 
      usage: '介绍自己的居住地' 
    },
    { 
      english: 'I like playing football.', 
      chinese: '我喜欢踢足球。', 
      usage: '介绍自己的爱好' 
    },
    { 
      english: 'Nice to meet you!', 
      chinese: '很高兴认识你！', 
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
        
        Text('介绍自己')
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
            Text('自我介绍学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('学会自我介绍是与他人交流的第一步，让我们来看看如何用英语介绍自己。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 自我介绍语句列表
          Column() {
            Text('常用自我介绍')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.introduceList, (item: IntroduceItem, index: number) => {
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
            }, (item: IntroduceItem) => item.english)
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
                Text('• My name is...: 介绍自己的姓名\n' +
                     '• I am...years old: 介绍自己的年龄\n' +
                     '• I am a...: 介绍自己的身份\n' +
                     '• I live in...: 介绍自己的居住地\n' +
                     '• I like...: 介绍自己的爱好\n' +
                     '• Nice to meet you: 初次见面的礼貌用语')
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
              Text('场景：新学期开学，你和新同学初次见面')
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
                  
                  Text('Hi! My name is Tom. I am ten years old.')
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
                  
                  Text('Nice to meet you! I am Lucy.')
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
          
          // 趣味理解设计 - 小测验
          Column() {
            Text('趣味小测验')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('选择合适的句子完成自我介绍：')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              Text('Hello! _____')
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 15 })
              
              // 选项
              Row() {
                Button('My name is Tom.')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ right: 5 })
                  .backgroundColor('#4CAF50')
                  .fontColor('#FFFFFF')
                  .type(ButtonType.Normal)
                
                Button('I like blue.')
                  .fontSize(12)
                  .layoutWeight(1)
                  .margin({ left: 5, right: 5 })
                  .backgroundColor('#E0E0E0')
                  .fontColor($r('app.color.text_primary'))
                  .type(ButtonType.Normal)
                
                Button('How are you?')
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