import router from '@ohos.router';

// 定义表达喜欢接口
interface LikeItem {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct ExpressLikesPage {
  // 常用表达喜欢的语句列表
  private likesList: Array<LikeItem> = [
    { 
      english: 'I like apples.', 
      chinese: '我喜欢苹果。', 
      usage: '表达喜欢具体事物' 
    },
    { 
      english: 'I love playing football.', 
      chinese: '我喜欢踢足球。', 
      usage: '表达热爱某种活动' 
    },
    { 
      english: 'I enjoy reading books.', 
      chinese: '我喜欢读书。', 
      usage: '表达享受某种活动' 
    },
    { 
      english: 'My favorite color is blue.', 
      chinese: '我最喜欢的颜色是蓝色。', 
      usage: '表达最喜欢的事物' 
    },
    { 
      english: 'I am interested in music.', 
      chinese: '我对音乐感兴趣。', 
      usage: '表达对某事物的兴趣' 
    },
    { 
      english: 'I prefer summer to winter.', 
      chinese: '我更喜欢夏天而不是冬天。', 
      usage: '表达偏好' 
    },
    { 
      english: 'I am fond of animals.', 
      chinese: '我喜欢动物。', 
      usage: '表达对某类事物的喜爱' 
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
        
        Text('表达喜欢')
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
            Text('表达喜欢学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('学会表达自己的喜好有助于与他人更好地交流，让我们来看看如何用英语表达喜欢。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 表达喜欢语句列表
          Column() {
            Text('常用表达')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.likesList, (item: LikeItem, index: number) => {
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
            }, (item: LikeItem) => item.english)
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
                Text('• I like...: 表达一般性的喜欢\n' +
                     '• I love...: 表达强烈的喜爱\n' +
                     '• I enjoy...: 表达享受某种活动\n' +
                     '• My favorite...is...: 表达最喜欢的事物\n' +
                     '• I am interested in...: 表达对某事物的兴趣\n' +
                     '• I prefer...to...: 表达偏好\n' +
                     '• I am fond of...: 表达对某类事物的喜爱')
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
              Text('场景：和朋友聊天，谈论各自的爱好')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
              
              // 对话框
              Column() {
                Row() {
                  Text('朋友:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('What do you like doing in your free time?')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('你:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('I like playing basketball and reading books.')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                }
                .padding({ left: 10, right: 10, top: 8, bottom: 8 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                
                Row() {
                  Text('朋友:')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .width(40)
                  
                  Text('That sounds interesting!')
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
          
          // 趣味理解设计 - 爱好配对游戏
          Column() {
            Text('爱好配对游戏')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('将英文表达与对应的中文意思配对：')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              // 配对题目
              Row() {
                Text('1. I like swimming.')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
                  .layoutWeight(1)
                
                Text('B. 我喜欢游泳。')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
                  .layoutWeight(1)
              }
              .padding({ left: 15, right: 15, top: 8, bottom: 8 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(8)
              .margin({ bottom: 5 })
              
              Row() {
                Text('2. My favorite subject is math.')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
                  .layoutWeight(1)
                
                Text('A. 我最喜欢的科目是数学。')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
                  .layoutWeight(1)
              }
              .padding({ left: 15, right: 15, top: 8, bottom: 8 })
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(8)
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