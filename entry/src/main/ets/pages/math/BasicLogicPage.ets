import router from '@ohos.router';

// 定义物体比较数据接口
interface ObjectComparison {
  name: string;
  count1: number;
  count2: number;
}

// 定义规律题目数据接口
interface PatternExample {
  question: string;
  answer: string;
}

@Entry
@Component
export struct BasicLogicPage {
  // 方位词示例数据
  private directions: string[] = ['前', '左', '中', '右', '后'];

  // 物体比较示例数据
  private objectComparisons: ObjectComparison[] = [
    { name: '苹果', count1: 5, count2: 3 },
    { name: '香蕉', count1: 2, count2: 7 },
    { name: '橙子', count1: 4, count2: 4 }
  ];

  // 规律题目示例数据
  private patternExamples: PatternExample[] = [
    { question: '△○△○△○__', answer: '○' },
    { question: '12312312__', answer: '3' },
    { question: '□△○□△○__', answer: '□' }
  ];

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        Text('基础逻辑')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      
      // 内容区域
      Scroll() {
        Column() {
          // 认识方位
          Column() {
            Text('认识方位')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Text('学习前、后、左、右、中等方位词')
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ bottom: 15 })
            
            // 方位展示 - 按照"中在中间，左在左边"的规律排列
            Column() {
              // 第一行：前
              Row() {
                Column() {
                  Text('前')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.card_background'))
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.text_primary'))
                .borderRadius(10)
                .layoutWeight(1)
              }
              .width('30%')
              .height(60)
              .margin({ bottom: 10 })
              .alignItems(VerticalAlign.Center)
              
              // 第二行：左、中、右
              Row() {
                Column() {
                  Text('左')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.card_background'))
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.text_primary'))
                .borderRadius(10)
                .layoutWeight(1)
                
                Column() {
                  Text('中')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.card_background'))
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.text_primary'))
                .borderRadius(10)
                .layoutWeight(1)
                .margin({ left: 10, right: 10 })
                
                Column() {
                  Text('右')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.card_background'))
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.text_primary'))
                .borderRadius(10)
                .layoutWeight(1)
              }
              .width('100%')
              .height(60)
              .margin({ bottom: 10 })
              
              // 第三行：后
              Row() {
                Column() {
                  Text('后')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.card_background'))
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor($r('app.color.text_primary'))
                .borderRadius(10)
                .layoutWeight(1)
              }
              .width('30%')
              .height(60)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .margin({ left: 20, right: 20 })
          }
          
          /*// 数物体个数并比较多少
          Column() {
            Text('数物体个数并比较多少')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 30, bottom: 10 })
            
            ForEach(this.objectComparisons, (item: ObjectComparison) => {
              Column() {
                Text(`比较${item.name}的个数`)
                  .fontSize(16)
                  .fontColor($r('app.color.text_primary'))
                  .margin({ bottom: 10 })
                
                Row() {
                  // 第一组物体
                  Column() {
                    ForEach(new Array(item.count1), () => {
                      Circle()
                        .width(20)
                        .height(20)
                        .fill($r('app.color.text_primary'))
                        .margin({ left: 2, right: 2 })
                    }, (index: number) => index.toString())
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.Center)
                  
                  // 比较符号
                  Text(item.count1 > item.count2 ? '>' : (item.count1 < item.count2 ? '<' : '='))
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                  
                  // 第二组物体
                  Column() {
                    ForEach(new Array(item.count2), () => {
                      Circle()
                        .width(20)
                        .height(20)
                        .fill($r('app.color.text_primary'))
                        .margin({ left: 2, right: 2 })
                    }, (index: number) => index.toString())
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.Center)
                }
                .width('100%')
                .margin({ bottom: 20 })
              }
            }, (item: ObjectComparison) => item.name)
          }
          .width('100%')
          .margin({ left: 20, right: 20 })*/
          
          // 找规律
          Column() {
            Text('找规律')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 30, bottom: 10 })
            
            ForEach(this.patternExamples, (item: PatternExample, index: number) => {
              Column() {
                Text(`题目${index + 1}:`)
                  .fontSize(16)
                  .fontColor($r('app.color.text_primary'))
                  .margin({ bottom: 5 })
                  .textAlign(TextAlign.Start)
                  .width('100%')
                
                Text(item.question)
                  .fontSize(18)
                  .fontColor($r('app.color.text_primary'))
                  .fontWeight(FontWeight.Bold)
                  .margin({ bottom: 10 })
                
                Text(`答案: ${item.answer}`)
                  .fontSize(16)
                  .fontColor($r('app.color.text_secondary'))
              }
              .width('100%')
              .margin({ bottom: 20 })
              .padding(15)
              .backgroundColor($r('app.color.card_background'))
              .borderRadius(10)
            }, (item: PatternExample) => item.question)
          }
          .width('100%')
          .margin({ left: 20, right: 20 })
          
          // 鼓励性文字和爱心
          Column() {
            Text('你已经掌握了基础逻辑，继续加油！😊')
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