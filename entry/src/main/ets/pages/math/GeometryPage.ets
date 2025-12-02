import router from '@ohos.router';

interface GeometryItem {
  id: number;
  title: string;
}

@Entry
@Component
struct GeometryPage {
  private geometryItems: Array<GeometryItem> = [
    { id: 1, title: '三角形的周长' },
    { id: 2, title: '三角形的面积' },
    { id: 3, title: '勾股定理' },
    { id: 4, title: '四边形周长' },
    { id: 5, title: '四边形面积' }
  ];

  build() {
    Column() {
      Row() {
        // 返回按钮
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back()
          })
          .padding({ left: 10 })
        
        Text('几何公式')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })

      // 几何公式列表
      List({ space: 10 }) {
        ForEach(this.geometryItems, (item: GeometryItem) => {
          ListItem() {
            GeometryListItem({ item: item })
          }
        })
      }
      .layoutWeight(1)
      .margin({ top: 20, left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}

@Component
struct GeometryListItem {
  @Prop item: GeometryItem

  build() {
    Row() {
      Text(this.item.title)
        .fontSize(18)
        .fontColor($r('app.color.text_primary'))
        .layoutWeight(1)
      
      // 使用文本箭头替代图片
      Text('>')
        .fontSize(18)
        .fontColor($r('app.color.text_tertiary'))
    }
    .padding({ left: 20, right: 20, top: 15, bottom: 15 })
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(10)
    .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
    .onClick(() => {
      switch (this.item.id) {
        case 1:
          router.push({ url: 'pages/math/TrianglePerimeterPage' });
          break;
        case 2:
          router.push({ url: 'pages/math/TriangleAreaPage' });
          break;
        case 3:
          router.push({ url: 'pages/math/PythagoreanTheoremPage' });
          break;
        case 4:
          router.push({ url: 'pages/math/QuadrilateralPerimeterPage' });
          break;
        case 5:
          router.push({ url: 'pages/math/QuadrilateralAreaPage' });
          break;
      }
    })
  }
}