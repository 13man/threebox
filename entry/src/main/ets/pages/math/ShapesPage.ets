import router from '@ohos.router';

// 定义图形接口
interface Shape {
  name: string;
  displayName: string;
}

@Entry
@Component
export struct ShapesPage {
  // 当前选中的图形
  @State selectedShape: string = 'circle';
  // 图形列表
  private shapesList: Shape[] = [
    { name: 'circle', displayName: '圆形' },
    { name: 'square', displayName: '正方形' },
    { name: 'rectangle', displayName: '长方形' },
    { name: 'triangle', displayName: '三角形' },
    { name: 'oval', displayName: '椭圆' },
    { name: 'star', displayName: '五角星' }
  ];

  build() {
    Column() {
      // 标题
      Row() {
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        
        Text('认识图形')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      
      // 图形选择区域
      Scroll() {
        Column() {
          // 图形展示区
          Row() {
            Column() {
              // 大图形展示区
              this.renderLargeShape()
              
              // 图形名称
              Text(this.getShapeDisplayName(this.selectedShape))
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 10 })
                .fontColor($r('app.color.text_primary'))
              
              // 图形特征描述
              Text(this.getShapeDescription(this.selectedShape))
                .fontSize(14)
                .textAlign(TextAlign.Center)
                .margin({ top: 10, left: 20, right: 20 })
                .fontColor($r('app.color.text_secondary'))
            }
            .layoutWeight(1)
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 20 })
          
          // 图形列表选择
          Column() {
            Text('选择图形')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 })
              .fontColor($r('app.color.text_primary'))
            
            Grid() {
              ForEach(this.shapesList, (shape: Shape) => {
                GridItem() {
                  Column() {
                    // 小图形展示区
                    this.renderSmallShape(shape.name)
                    
                    Text(shape.displayName)
                      .fontSize(12)
                      .margin({ top: 5 })
                      .fontColor($r('app.color.text_tertiary_bank_card_11'))
                  }
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.Center)
                  .backgroundColor(this.selectedShape === shape.name ? Color.Blue : Color.Gray)
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedShape = shape.name;
                  })
                }
              }, (item: Shape) => item.name)
            }
            .columnsTemplate('1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .height(150)
            .margin({ left: 20, right: 20 })
          }
          
          // 图形特点说明
          Column() {
            Text('图形特点')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 })
              .fontColor($r('app.color.text_primary'))
            
            Row() {
              Column() {
                Text(this.getShapeCharacteristics(this.selectedShape))
                  .fontSize(14)
                  .textAlign(TextAlign.Start)
                  .fontColor($r('app.color.text_secondary'))
              }
              .layoutWeight(1)
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
          }
          
          // 趣味活动介绍
          Column() {
            Text('趣味活动')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 })
              .fontColor($r('app.color.text_primary'))
            
            Row() {
              Column() {
                Text(this.getActivityDescription(this.selectedShape))
                  .fontSize(14)
                  .textAlign(TextAlign.Start)
                  .fontColor($r('app.color.text_secondary'))
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
  
  // 渲染大图形
  @Builder
  renderLargeShape() {
    Stack() {
      // 根据不同图形类型渲染
      if (this.selectedShape === 'circle') {
        // 圆形
        Circle()
          .width(200)
          .height(200)
          .fill(Color.Blue)
          .opacity(0.8)
      } else if (this.selectedShape === 'square') {
        // 正方形
        Rect()
          .width(200)
          .height(200)
          .fill(Color.Blue)
          .opacity(0.8)
      } else if (this.selectedShape === 'rectangle') {
        // 长方形
        Rect()
          .width(200)
          .height(120)
          .fill(Color.Blue)
          .opacity(0.8)
      } else if (this.selectedShape === 'triangle') {
        // 三角形 - 增大并居中
        Path()
          .width(200)
          .height(200)
          .commands('M 100 20 L 20 180 L 180 180 Z')
          .fill(Color.Blue)
          .opacity(0.8)
      } else if (this.selectedShape === 'oval') {
        // 椭圆
        Rect()
          .width(200)
          .height(120)
          .fill(Color.Blue)
          .borderRadius(100)
          .opacity(0.8)
      } else if (this.selectedShape === 'star') {
        // 五角星
        Path()
          .width(200)
          .height(200)
          .commands('M 100 20 L 120 80 L 185 80 L 132 115 L 155 180 L 100 140 L 45 180 L 68 115 L 15 80 L 80 80 Z')
          .fill(Color.Blue)
          .opacity(0.8)
      }
    }
  }
  
  // 渲染小图形
  @Builder
  renderSmallShape(shapeName: string) {
    if (shapeName === 'circle') {
      // 圆形
      Circle()
        .width(40)
        .height(40)
        .fill(Color.White)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    } else if (shapeName === 'square') {
      // 正方形
      Rect()
        .width(40)
        .height(40)
        .fill(Color.White)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    } else if (shapeName === 'rectangle') {
      // 长方形
      Rect()
        .width(40)
        .height(25)
        .fill(Color.White)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    } else if (shapeName === 'triangle') {
      // 三角形
      Path()
        .width(40)
        .height(40)
        .commands('M 20 5 L 5 35 L 35 35 Z')
        .fill(Color.White)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    } else if (shapeName === 'oval') {
      // 椭圆
      Rect()
        .width(40)
        .height(25)
        .fill(Color.White)
        .borderRadius(20)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    } else if (shapeName === 'star') {
      // 五角星
      Path()
        .width(40)
        .height(40)
        .commands('M 20 5 L 24 15 L 35 15 L 26 22 L 30 33 L 20 25 L 10 33 L 14 22 L 5 15 L 16 15 Z')
        .fill(Color.White)
        .stroke(this.selectedShape === shapeName ? Color.Blue : Color.Gray)
        .strokeWidth(2)
    }
  }
  
  // 获取图形显示名称
  getShapeDisplayName(shapeName: string): string {
    const shape = this.shapesList.find((item: Shape) => item.name === shapeName);
    return shape ? shape.displayName : '未知图形';
  }
  
  // 获取图形描述
  getShapeDescription(shapeName: string): string {
    switch (shapeName) {
      case 'circle':
        return '圆形是一个平面上所有到中心点距离相等的点的集合。它没有角和边。';
      case 'square':
        return '正方形是一个四边相等且四个角都是直角的四边形。';
      case 'rectangle':
        return '长方形是一个对边相等且四个角都是直角的四边形。';
      case 'triangle':
        return '三角形是一个有三条边和三个角的图形。根据边长和角度，可以分为不同的类型。';
      case 'oval':
        return '椭圆是一个看起来像被压扁的圆形的图形。它没有角和边。';
      case 'star':
        return '五角星是一个有五个尖角的星形图形。它有十条边和十个角。';
      default:
        return '这是一种有趣的图形。';
    }
  }
  
  // 获取图形特点
  getShapeCharacteristics(shapeName: string): string {
    switch (shapeName) {
      case 'circle':
        return '• 圆形有0条边和0个角\n' +
               '• 圆形的所有点到中心的距离都相等\n' +
               '• 圆形是轴对称图形，有无数条对称轴\n' +
               '• 生活中的例子：硬币、钟表、轮胎等';
      case 'square':
        return '• 正方形有4条边和4个角\n' +
               '• 正方形的四条边长度相等\n' +
               '• 正方形的四个角都是直角（90度）\n' +
               '• 正方形是轴对称图形，有4条对称轴\n' +
               '• 生活中的例子：魔方、地砖、相框等';
      case 'rectangle':
        return '• 长方形有4条边和4个角\n' +
               '• 长方形的对边长度相等\n' +
               '• 长方形的四个角都是直角（90度）\n' +
               '• 长方形是轴对称图形，有2条对称轴\n' +
               '• 生活中的例子：书本、门、窗户等';
      case 'triangle':
        return '• 三角形有3条边和3个角\n' +
               '• 三角形的内角和为180度\n' +
               '• 三角形具有稳定性\n' +
               '• 根据边长可分为：等边三角形、等腰三角形、普通三角形\n' +
               '• 根据角度可分为：锐角三角形、直角三角形、钝角三角形\n' +
               '• 生活中的例子：三明治、红领巾、屋顶等';
      case 'oval':
        return '• 椭圆有0条边和0个角\n' +
               '• 椭圆有两个焦点\n' +
               '• 椭圆是轴对称图形，有2条对称轴\n' +
               '• 生活中的例子：鸡蛋、橄榄球、椭圆形镜子等';
      case 'star':
        return '• 五角星有10条边和10个角\n' +
               '• 五角星有5个尖角和5个钝角\n' +
               '• 五角星是轴对称图形，有5条对称轴\n' +
               '• 生活中的例子：星星贴纸、国旗上的星星等';
      default:
        return '• 这是一个有趣的图形\n' +
               '• 可以观察它有多少条边和多少个角\n' +
               '• 可以寻找生活中的类似图形';
    }
  }
  
  // 获取活动描述
  getActivityDescription(shapeName: string): string {
    switch (shapeName) {
      case 'circle':
        return '1. 在家中寻找圆形的物品，如硬币、钟表、盘子等。\n' +
               '2. 用圆规画不同大小的圆，比较它们的特征。\n' +
               '3. 用彩纸剪出圆形，制作一幅圆形拼贴画。';
      case 'square':
        return '1. 寻找家中的正方形物品，如魔方、地砖、骰子等。\n' +
               '2. 用直尺和铅笔画出不同大小的正方形。\n' +
               '3. 用彩纸剪出正方形，折成千纸鹤或其他形状。';
      case 'rectangle':
        return '1. 寻找家中的长方形物品，如书本、门、窗户等。\n' +
               '2. 测量长方形物品的长和宽，计算周长和面积。\n' +
               '3. 用彩纸剪出不同大小的长方形，制作成长方形拼图。';
      case 'triangle':
        return '1. 寻找家中的三角形物品，如三明治、红领巾、屋顶等。\n' +
               '2. 用直尺和铅笔画出不同类型的三角形。\n' +
               '3. 用彩纸剪出三角形，拼成各种有趣的图案。';
      case 'oval':
        return '1. 寻找家中的椭圆形物品，如鸡蛋、橄榄球等。\n' +
               '2. 用绳子和两个图钉制作椭圆绘制工具。\n' +
               '3. 用彩纸剪出椭圆形，制作成小动物的轮廓。';
      case 'star':
        return '1. 寻找五角星形状的物品，如国旗上的星星、星星贴纸等。\n' +
               '2. 学习用折纸的方法制作五角星。\n' +
               '3. 用彩纸剪出五角星，装饰房间或制作贺卡。';
      default:
        return '1. 仔细观察这个图形的特点。\n' +
               '2. 寻找生活中的类似图形。\n' +
               '3. 用这个图形创作一幅美术作品。';
    }
  }
}