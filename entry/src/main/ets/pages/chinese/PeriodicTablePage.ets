import router from '@ohos.router';

// 匣子元素类型定义
interface ChemicalElementType {
  atomicNumber: number;
  symbol: string;
  name: string;
  atomicMass: string;
  group: number;
  period: number;
  category: string;
}

@Entry
@Component
export struct PeriodicTablePage {
  // 元素周期表数据（前36个元素）
  private elements: ChemicalElementType[] = [
    // 第1周期
    { atomicNumber: 1, symbol: 'H', name: '氢', atomicMass: '1.008', group: 1, period: 1, category: 'nonmetal' },
    { atomicNumber: 2, symbol: 'He', name: '氦', atomicMass: '4.0026', group: 18, period: 1, category: 'nobleGas' },
    
    // 第2周期
    { atomicNumber: 3, symbol: 'Li', name: '锂', atomicMass: '6.94', group: 1, period: 2, category: 'alkaliMetal' },
    { atomicNumber: 4, symbol: 'Be', name: '铍', atomicMass: '9.0122', group: 2, period: 2, category: 'alkalineEarthMetal' },
    { atomicNumber: 5, symbol: 'B', name: '硼', atomicMass: '10.81', group: 13, period: 2, category: 'metalloid' },
    { atomicNumber: 6, symbol: 'C', name: '碳', atomicMass: '12.011', group: 14, period: 2, category: 'nonmetal' },
    { atomicNumber: 7, symbol: 'N', name: '氮', atomicMass: '14.007', group: 15, period: 2, category: 'nonmetal' },
    { atomicNumber: 8, symbol: 'O', name: '氧', atomicMass: '15.999', group: 16, period: 2, category: 'nonmetal' },
    { atomicNumber: 9, symbol: 'F', name: '氟', atomicMass: '18.998', group: 17, period: 2, category: 'halogen' },
    { atomicNumber: 10, symbol: 'Ne', name: '氖', atomicMass: '20.180', group: 18, period: 2, category: 'nobleGas' },
    
    // 第3周期
    { atomicNumber: 11, symbol: 'Na', name: '钠', atomicMass: '22.990', group: 1, period: 3, category: 'alkaliMetal' },
    { atomicNumber: 12, symbol: 'Mg', name: '镁', atomicMass: '24.305', group: 2, period: 3, category: 'alkalineEarthMetal' },
    { atomicNumber: 13, symbol: 'Al', name: '铝', atomicMass: '26.982', group: 13, period: 3, category: 'postTransitionMetal' },
    { atomicNumber: 14, symbol: 'Si', name: '硅', atomicMass: '28.085', group: 14, period: 3, category: 'metalloid' },
    { atomicNumber: 15, symbol: 'P', name: '磷', atomicMass: '30.974', group: 15, period: 3, category: 'nonmetal' },
    { atomicNumber: 16, symbol: 'S', name: '硫', atomicMass: '32.06', group: 16, period: 3, category: 'nonmetal' },
    { atomicNumber: 17, symbol: 'Cl', name: '氯', atomicMass: '35.45', group: 17, period: 3, category: 'halogen' },
    { atomicNumber: 18, symbol: 'Ar', name: '氩', atomicMass: '39.948', group: 18, period: 3, category: 'nobleGas' },
    
    // 第4周期
    { atomicNumber: 19, symbol: 'K', name: '钾', atomicMass: '39.098', group: 1, period: 4, category: 'alkaliMetal' },
    { atomicNumber: 20, symbol: 'Ca', name: '钙', atomicMass: '40.078', group: 2, period: 4, category: 'alkalineEarthMetal' },
    { atomicNumber: 21, symbol: 'Sc', name: '钪', atomicMass: '44.956', group: 3, period: 4, category: 'transitionMetal' },
    { atomicNumber: 22, symbol: 'Ti', name: '钛', atomicMass: '47.867', group: 4, period: 4, category: 'transitionMetal' },
    { atomicNumber: 23, symbol: 'V', name: '钒', atomicMass: '50.942', group: 5, period: 4, category: 'transitionMetal' },
    { atomicNumber: 24, symbol: 'Cr', name: '铬', atomicMass: '51.996', group: 6, period: 4, category: 'transitionMetal' },
    { atomicNumber: 25, symbol: 'Mn', name: '锰', atomicMass: '54.938', group: 7, period: 4, category: 'transitionMetal' },
    { atomicNumber: 26, symbol: 'Fe', name: '铁', atomicMass: '55.845', group: 8, period: 4, category: 'transitionMetal' },
    { atomicNumber: 27, symbol: 'Co', name: '钴', atomicMass: '58.933', group: 9, period: 4, category: 'transitionMetal' },
    { atomicNumber: 28, symbol: 'Ni', name: '镍', atomicMass: '58.693', group: 10, period: 4, category: 'transitionMetal' },
    { atomicNumber: 29, symbol: 'Cu', name: '铜', atomicMass: '63.546', group: 11, period: 4, category: 'transitionMetal' },
    { atomicNumber: 30, symbol: 'Zn', name: '锌', atomicMass: '65.38', group: 12, period: 4, category: 'transitionMetal' },
    { atomicNumber: 31, symbol: 'Ga', name: '镓', atomicMass: '69.723', group: 13, period: 4, category: 'postTransitionMetal' },
    { atomicNumber: 32, symbol: 'Ge', name: '锗', atomicMass: '72.630', group: 14, period: 4, category: 'metalloid' },
    { atomicNumber: 33, symbol: 'As', name: '砷', atomicMass: '74.922', group: 15, period: 4, category: 'metalloid' },
    { atomicNumber: 34, symbol: 'Se', name: '硒', atomicMass: '78.971', group: 16, period: 4, category: 'nonmetal' },
    { atomicNumber: 35, symbol: 'Br', name: '溴', atomicMass: '79.904', group: 17, period: 4, category: 'halogen' },
    { atomicNumber: 36, symbol: 'Kr', name: '氪', atomicMass: '83.798', group: 18, period: 4, category: 'nobleGas' }
  ]
  
  // 根据周期和族查找元素
  private findElement(period: number, group: number): ChemicalElementType | undefined {
    for (let i = 0; i < this.elements.length; i++) {
      const element = this.elements[i];
      if (element.period === period && element.group === group) {
        return element;
      }
    }
    return undefined;
  }

  build() {
    Column() {
      // 标题栏
      Row() {
           Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ right: 10 })
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
        
        Text('匣子周期表')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      
      // 周期表说明
      Row() {
        Text('元素周期表是匣子中最重要的工具之一，它将所有已知的匣子元素按照原子序数排列。')
          .fontSize(14)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .padding({ left: 20, right: 20 })
      }
      .height(60)
      .backgroundColor('#E3F2FD')
      .margin({ bottom: 10 })


      // 周期表主体
      Scroll() {
        Column() {
          // 创建周期表网格 (最多18列)
          ForEach(new Array(4).fill(0), (_: undefined, periodIndex: number) => {
            Row() {
              ForEach(new Array(18).fill(0), (_: undefined, groupIndex: number) => {
                // 显示元素或空白占位
                Column() {
                  // 直接使用条件渲染，避免变量声明
                  if (this.findElement(periodIndex + 1, groupIndex + 1)) {
                    // 显示元素卡片
                    Column() {
                      Text(`${this.findElement(periodIndex + 1, groupIndex + 1)?.atomicNumber}`)
                        .fontSize(10)
                        .fontColor('#666666')
                        .textAlign(TextAlign.Start)
                        .width('100%')
                        .padding({ top: 2, left: 2 })

                      Text(this.findElement(periodIndex + 1, groupIndex + 1)?.symbol ?? '')
                        .fontSize(14)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(this.getElementColor(this.findElement(periodIndex + 1, groupIndex + 1)?.category ?? ''))

                      Text(this.findElement(periodIndex + 1, groupIndex + 1)?.name ?? '')
                        .fontSize(8)
                        .fontColor('#666666')
                        .margin({ top: 2 })
                    }
                    .width('100%')
                    .height('100%')
                    .border({
                      width: 1,
                      color: this.getElementBorderColor(this.findElement(periodIndex + 1, groupIndex + 1)?.category ?? ''),
                      style: BorderStyle.Solid
                    })
                    .backgroundColor(this.getElementBackgroundColor(this.findElement(periodIndex + 1, groupIndex + 1)?.category ?? ''))
                    .padding(2)
                  } else {
                    // 空白占位
                    Column() {
                      Blank()
                    }
                    .width('100%')
                    .height('100%')
                  }
                }
                .width(40)
                .height(60)
                .margin(2)
              }, (groupIndex: number) => `group_${groupIndex}`)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }, (periodIndex: number) => `period_${periodIndex}`)
        }
        .padding({ bottom: 20 })
        .width('300%')
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Horizontal | ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      // 元素分类说明
      Column() {
        Text('元素分类')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })
        
        Row() {
          this.renderCategoryLegend('alkaliMetal', '碱金属')
          this.renderCategoryLegend('alkalineEarthMetal', '碱土金属')
          this.renderCategoryLegend('transitionMetal', '过渡金属')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        
        Row() {
          this.renderCategoryLegend('metalloid', '类金属')
          this.renderCategoryLegend('nonmetal', '非金属')
          this.renderCategoryLegend('halogen', '卤族元素')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        
        Row() {
          this.renderCategoryLegend('nobleGas', '惰性气体')
          this.renderCategoryLegend('postTransitionMetal', '后过渡金属')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .padding(10)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // 渲染分类图例
  @Builder
  private renderCategoryLegend(category: string, label: string) {
    Row() {
      Column() {
      }
      .width(15)
      .height(15)
      .backgroundColor(this.getElementBackgroundColor(category))
      .border({
        width: 1,
        color: this.getElementBorderColor(category),
        style: BorderStyle.Solid
      })
      
      Text(label)
        .fontSize(10)
        .margin({ left: 5 })
    }
  }
  
  // 获取元素文本颜色
  private getElementColor(category: string): ResourceColor {
    switch (category) {
      case 'alkaliMetal': return Color.Red;
      case 'alkalineEarthMetal': return Color.Orange;
      case 'transitionMetal': return Color.Green;
      case 'postTransitionMetal': return Color.Blue;
      // 使用相近颜色替代不存在的颜色
      case 'metalloid': return Color.Gray;
      case 'nonmetal': return Color.Pink;
      case 'halogen': return Color.Blue;
      case 'nobleGas': return Color.Grey;
      default: return Color.Black;
    }
  }
  
  // 获取元素背景颜色
  private getElementBackgroundColor(category: string): string {
    switch (category) {
      case 'alkaliMetal': return '#FFEBEE';
      case 'alkalineEarthMetal': return '#F3E5F5';
      case 'transitionMetal': return '#E8F5E8';
      case 'postTransitionMetal': return '#E3F2FD';
      case 'metalloid': return '#F1F8E9';
      case 'nonmetal': return '#FFF3E0';
      case 'halogen': return '#E0F7FA';
      case 'nobleGas': return '#F5F5F5';
      default: return '#FFFFFF';
    }
  }
  
  // 获取元素边框颜色
  private getElementBorderColor(category: string): ResourceColor {
    switch (category) {
      case 'alkaliMetal': return Color.Red;
      case 'alkalineEarthMetal': return Color.Orange;
      case 'transitionMetal': return Color.Green;
      case 'postTransitionMetal': return Color.Blue;
      // 使用相近颜色替代不存在的颜色
      case 'metalloid': return Color.Gray;
      case 'nonmetal': return Color.Pink;
      case 'halogen': return Color.Blue;
      case 'nobleGas': return Color.Grey;
      default: return Color.Black;
    }
  }
}