import router from '@ohos.router';

// 定义家庭成员接口
interface FamilyMember {
  english: string;
  chinese: string;
  usage: string;
}

@Entry
@Component
export struct FamilyPage {
  // 家庭成员列表
  private familyList: Array<FamilyMember> = [
    { 
      english: 'father/dad', 
      chinese: '父亲/爸爸', 
      usage: '对父亲的称呼' 
    },
    { 
      english: 'mother/mom', 
      chinese: '母亲/妈妈', 
      usage: '对母亲的称呼' 
    },
    { 
      english: 'parents', 
      chinese: '父母', 
      usage: '对父母的统称' 
    },
    { 
      english: 'brother', 
      chinese: '兄弟', 
      usage: '对兄弟的称呼' 
    },
    { 
      english: 'sister', 
      chinese: '姐妹', 
      usage: '对姐妹的称呼' 
    },
    { 
      english: 'grandfather/grandpa', 
      chinese: '祖父/爷爷', 
      usage: '对祖父的称呼' 
    },
    { 
      english: 'grandmother/grandma', 
      chinese: '祖母/奶奶', 
      usage: '对祖母的称呼' 
    },
    { 
      english: 'grandparents', 
      chinese: '祖父母', 
      usage: '对祖父母的统称' 
    }
  ];

  // 家庭成员相关句子
  private familySentenceList: Array<FamilyMember> = [
    { 
      english: 'This is my family.', 
      chinese: '这是我的家庭。', 
      usage: '介绍自己的家庭' 
    },
    { 
      english: 'I have a happy family.', 
      chinese: '我有一个幸福的家庭。', 
      usage: '表达对家庭的感受' 
    },
    { 
      english: 'We live together.', 
      chinese: '我们住在一起。', 
      usage: '描述家庭生活' 
    },
    { 
      english: 'I love my family.', 
      chinese: '我爱我的家庭。', 
      usage: '表达对家庭的爱' 
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
        
        Text('家庭成员')
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
            Text('家庭成员学习')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
            
            Text('了解如何用英语介绍自己的家庭成员，是英语交流中的重要内容。')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Center)
          }
          
          // 家庭成员列表
          Column() {
            Text('家庭成员称呼')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.familyList, (item: FamilyMember, index: number) => {
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
            }, (item: FamilyMember) => item.english)
          }
          .width('100%')
          .margin({ top: 10 })
          
          // 家庭成员相关句子
          Column() {
            Text('常用句子')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            ForEach(this.familySentenceList, (item: FamilyMember, index: number) => {
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
            }, (item: FamilyMember) => item.english)
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
                Text('• father/dad, mother/mom: 对父母的称呼\n' +
                     '• parents: 父母的统称\n' +
                     '• brother, sister: 对兄弟姐妹的称呼\n' +
                     '• grandfather/grandpa, grandmother/grandma: 对祖父母的称呼\n' +
                     '• grandparents: 祖父母的统称\n' +
                     '• This is my family: 介绍自己的家庭\n' +
                     '• I have a happy family: 表达对家庭的感受')
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
              Text('场景：向新朋友介绍自己的家庭')
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
                  
                  Text('This is a photo of my family.')
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
                  
                  Text('Who is he?')
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
                  
                  Text('He is my father. This is my mother.')
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
          
          // 趣味理解设计 - 家庭树
          Column() {
            Text('家庭树')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('根据英文选择正确的中文意思：')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 10 })
            
            Column() {
              Text('My parents are teachers.')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
                .margin({ bottom: 10 })
              
              // 选项
              Column() {
                Row() {
                  Text('A. 我的父母是教师。')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor('#4CAF50')
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('B. 我的祖父母是教师。')
                    .fontSize(14)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })
                .backgroundColor($r('app.color.card_background'))
                .borderRadius(8)
                .margin({ bottom: 5 })
                
                Row() {
                  Text('C. 我的兄弟是教师。')
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