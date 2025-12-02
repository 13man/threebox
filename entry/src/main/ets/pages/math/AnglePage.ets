import router from '@ohos.router';

// 定义角类型接口
interface AngleType {
  name: string;
  displayName: string;
}

@Entry
@Component
export struct AnglePage {
  // 当前选中的角类型
  @State selectedAngle: string = 'acute';
  
  // 角类型列表
  private angleTypes: AngleType[] = [
    { name: 'acute', displayName: '锐角' },
    { name: 'right', displayName: '直角' },
    { name: 'obtuse', displayName: '钝角' },
    { name: 'straight', displayName: '平角' },
    { name: 'reflex', displayName: '优角' },
    { name: 'full', displayName: '周角' }
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
        
        Text('认识角')
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
          // 角的展示区域
          Column() {
            this.renderAngleDisplay()
            
            // 角的名称
            Text(this.getAngleDisplayName(this.selectedAngle))
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 10 })
            
            // 角的定义
            Text(this.getAngleDefinition(this.selectedAngle))
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .textAlign(TextAlign.Center)
              .margin({ top: 10, left: 20, right: 20 })
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 20 })
          
          // 角类型选择
          Column() {
            Text('角的类型')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Grid() {
              ForEach(this.angleTypes, (angle: AngleType) => {
                GridItem() {
                  Column() {
                    // 角的图形表示
                    this.renderAngleType(angle.name)
                    
                    Text(angle.displayName)
                      .fontSize(12)
                      .fontColor($r('app.color.text_tertiary_bank_card_11'))
                      .margin({ top: 5 })
                  }
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.Center)
                  .backgroundColor(this.selectedAngle === angle.name ? Color.Blue : Color.Gray)
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedAngle = angle.name;
                  })
                }
              }, (item: AngleType) => item.name)
            }
            .columnsTemplate('1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .height(150)
            .margin({ left: 20, right: 20 })
          }
          
          // 角的特点说明
          Column() {
            Text('角的特点')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Row() {
              Column() {
                Text(this.getAngleCharacteristics(this.selectedAngle))
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 趣味解析
          Column() {
            Text('趣味解析')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Row() {
              Column() {
                Text(this.getAngleFunExplanation(this.selectedAngle))
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 角度计算
          Column() {
            Text('角度计算')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20, bottom: 10 })
            
            Row() {
              Column() {
                Text(this.getAngleCalculation(this.selectedAngle))
                  .fontSize(14)
                  .fontColor($r('app.color.text_secondary'))
                  .textAlign(TextAlign.Start)
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 鼓励性文字和爱心
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
  
  // 渲染角的展示
  @Builder
  renderAngleDisplay() {
    Stack() {
      if (this.selectedAngle === 'acute') {
        // 锐角 - 使用文本拼接方式显示
        Text("∠")
          .fontSize(100)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue)
      } else if (this.selectedAngle === 'right') {
        // 直角 - 以水平线为基线，垂直向上形成90度的角，并添加直角符号
        Path()
          .width(200)
          .height(200)
          .commands('M 50 150 L 50 50 L 150 50')
          .fill(Color.Transparent)
          .stroke(Color.Blue)
          .strokeWidth(3)
        
        // 添加直角符号（小方块）
        Path()
          .width(200)
          .height(200)
          .commands('M 50 80 L 50 50 L 80 50')
          .fill(Color.Transparent)
          .stroke(Color.Blue)
          .strokeWidth(2)
      } else if (this.selectedAngle === 'obtuse') {
        // 钝角 - 使用文本拼接方式显示
        Text("__/")
          .fontSize(120)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue)

      } else if (this.selectedAngle === 'straight') {
        // 平角 - 等于180度
        Path()
          .width(200)
          .height(200)
          .commands('M 30 100 L 170 100')
          .fill(Color.Transparent)
          .stroke(Color.Blue)
          .strokeWidth(3)
      } else if (this.selectedAngle === 'reflex') {
        // 优角 - 大于180度小于360度
        Path()
          .width(200)
          .height(200)
          .commands('M 100 100 L 100 50 A 50 50 0 1 1 150 100 Z')
          .fill(Color.Transparent)
          .stroke(Color.Blue)
          .strokeWidth(3)
      } else if (this.selectedAngle === 'full') {
        // 周角 - 等于360度
        Circle()
          .width(100)
          .height(100)
          .fill(Color.Transparent)
          .stroke(Color.Blue)
          .strokeWidth(3)
      } else {
        // 默认显示锐角
        Text("∠")
          .fontSize(100)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue)
      }
    }
    .width(200)
    .height(200)
    .align(Alignment.Center)
  }
  
  // 渲染角类型选择项
  @Builder
  renderAngleType(angleName: string) {
    Stack() {
      if (angleName === 'acute') {
        // 锐角 - 使用文本方式显示
        Text("∠")
          .fontSize(24)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
      } else if (angleName === 'right') {
        // 直角 - 以水平线为基线，垂直向上形成90度的角，并添加直角符号
        Path()
          .width(40)
          .height(40)
          .commands('M 10 30 L 10 10 L 30 10')
          .fill(Color.Transparent)
          .stroke(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
          .strokeWidth(2)
        
        // 添加直角符号（小方块）
        Path()
          .width(40)
          .height(40)
          .commands('M 10 18 L 10 10 L 18 10')
          .fill(Color.Transparent)
          .stroke(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
          .strokeWidth(1)
      } else if (angleName === 'obtuse') {
        // 钝角 - 使用文本方式显示
        Text("__/")
          .fontSize(28)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedAngle === angleName ? Color.Blue : Color.Gray)

      } else if (angleName === 'straight') {
        // 平角
        Path()
          .width(40)
          .height(40)
          .commands('M 5 20 L 35 20')
          .fill(Color.Transparent)
          .stroke(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
          .strokeWidth(2)
      } else if (angleName === 'reflex') {
        // 优角
        Path()
          .width(40)
          .height(40)
          .commands('M 20 20 L 20 10 A 10 10 0 1 1 30 20 Z')
          .fill(Color.Transparent)
          .stroke(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
          .strokeWidth(2)
      } else if (angleName === 'full') {
        // 周角
        Circle()
          .width(30)
          .height(30)
          .fill(Color.Transparent)
          .stroke(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
          .strokeWidth(2)
      } else {
        // 默认
        Text("∠")
          .fontSize(24)
          .fontFamily('serif')
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedAngle === angleName ? Color.Blue : Color.Gray)
      }
    }
    .width(50)
    .height(50)
    .align(Alignment.Center)
  }
  
  // 获取角的显示名称
  getAngleDisplayName(angle: string): string {
    const angleObj: AngleType | undefined = this.angleTypes.find((item: AngleType) => item.name === angle);
    return angleObj ? angleObj.displayName : '';
  }
  
  // 获取角的定义
  getAngleDefinition(angle: string): string {
    switch (angle) {
      case 'acute':
        return '锐角是指大于0度且小于90度的角。它看起来比较"尖锐"，是所有角中最小的一种。';
      case 'right':
        return '直角是指等于90度的角。它是我们日常生活中最常见的角，比如书本的角、桌子的角等。';
      case 'obtuse':
        return '钝角是指大于90度且小于180度的角。它看起来比较"钝"，比直角大但比平角小。';
      case 'straight':
        return '平角是指等于180度的角。它的两条边成一条直线，看起来就像一条直线。';
      case 'reflex':
        return '优角是指大于180度且小于360度的角。它比平角大，但比周角小。';
      case 'full':
        return '周角是指等于360度的角。它形成一个完整的圆，两条边完全重合。';
      default:
        return '';
    }
  }
  
  // 获取角的特点
  getAngleCharacteristics(angle: string): string {
    switch (angle) {
      case 'acute':
        return '• 角度范围：0° < 锐角 < 90°\n• 特点：看起来比较尖锐\n• 常见例子：切开的 pizza 片、山峰的形状';
      case 'right':
        return '• 角度：恰好 90°\n• 特点：形成完美的"L"形\n• 常见例子：书本的角、墙壁的角落、窗户的角';
      case 'obtuse':
        return '• 角度范围：90° < 钝角 < 180°\n• 特点：看起来比较钝\n• 常见例子：打开的扇子、张开的剪刀';
      case 'straight':
        return '• 角度：恰好 180°\n• 特点：形成一条直线\n• 常见例子：拉直的绳子、地平线';
      case 'reflex':
        return '• 角度范围：180° < 优角 < 360°\n• 特点：大于半圆但小于整圆\n• 常见例子：大于半圆的扇形、月亮的大部分形状';
      case 'full':
        return '• 角度：恰好 360°\n• 特点：形成一个完整的圆\n• 常见例子：完整的披萨、完整的圆形饼干';
      default:
        return '';
    }
  }
  
  // 获取角的趣味解析
  getAngleFunExplanation(angle: string): string {
    switch (angle) {
      case 'acute':
        return '锐角就像小猫咪的耳朵，尖尖的，总是竖起来听声音。它们也像小鸟的嘴巴，小巧精致。锐角让我们感受到精致和敏锐，就像小精灵的魔法棒一样！';
      case 'right':
        return '直角就像我们住的房子的角落，稳稳当当。它也像我们写字的纸张的角，方方正正。直角代表稳定和规整，就像士兵排队一样整齐！';
      case 'obtuse':
        return '钝角就像张开的怀抱，宽宽的，给人安全感。它也像打开的扇子，优雅大方。钝角让我们感受到包容和温暖，就像妈妈张开的臂膀！';
      case 'straight':
        return '平角就像一条笔直的大路，通向远方。它也像射出的箭，勇往直前。平角代表坚定和执着，就像运动员冲向终点线一样！';
      case 'reflex':
        return '优角就像一个大大的拥抱，包围着一切。它也像半圆形的彩虹，美丽绚烂。优角让我们感受到包容和完整，就像天空一样广阔！';
      case 'full':
        return '周角就像一个完整的圆，没有起点也没有终点。它也像地球一样，循环往复。周角代表完整和圆满，就像一家人团聚一样完美！';
      default:
        return '';
    }
  }
  
  // 获取角度计算方法
  getAngleCalculation(angle: string): string {
    switch (angle) {
      case 'acute':
        return '锐角的计算方法：\n• 锐角 = 90° - 另一个角（当两角互补时）\n• 例如：如果一个角是30°，那么它的补角是60°，这就是一个锐角\n• 在三角形中，如果已知两个角，第三个角 = 180° - 其他两个角的和';
      case 'right':
        return '直角的计算方法：\n• 直角 = 90°（固定值）\n• 在直角三角形中，另外两个角的和总是90°\n• 例如：如果一个角是30°，另一个角必然是60°';
      case 'obtuse':
        return '钝角的计算方法：\n• 钝角 = 180° - 另一个角（当两角互补时）\n• 例如：如果一个角是30°，那么它的补角是150°，这就是一个钝角\n• 在三角形中，最多只能有一个钝角';
      case 'straight':
        return '平角的计算方法：\n• 平角 = 180°（固定值）\n• 平角 = 2个直角\n• 在一条直线上，相邻的两个角之和总是180°';
      case 'reflex':
        return '优角的计算方法：\n• 优角 = 360° - 对应的锐角/直角/钝角\n• 例如：对应60°角的优角是300°\n• 在圆中，优角表示大于半圆的弧所对应的角';
      case 'full':
        return '周角的计算方法：\n• 周角 = 360°（固定值）\n• 周角 = 2个平角 = 4个直角\n• 在圆中，一周的角度总和是360°';
      default:
        return '';
    }
  }
}