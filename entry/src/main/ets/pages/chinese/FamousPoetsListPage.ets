import router from '@ohos.router';

// 定义诗人基本信息接口
interface PoetInfo {
  id: number;
  name: string;
  dynasty: string;
  description: string;
  imageResource?: string; // 图片资源名称
  icon?: string; // 备用emoji图标
  masterpiece: string; // 代表作
}

@Entry
@Component
export struct FamousPoetsListPage {
  @State private isPageLoaded: boolean = false;
  
  // 著名诗人列表
  private poets: PoetInfo[] = [
    {
      id: 1,
      name: '李白',
      dynasty: '唐朝',
      description: '字太白,号青莲居士,被誉为"诗仙"',
      imageResource: 'libai',
      masterpiece: '将进酒、静夜思、蜀道难'
    },
    {
      id: 2,
      name: '杜甫',
      dynasty: '唐朝',
      description: '字子美,自号少陵野老,被尊为"诗圣"',
      imageResource: 'dufu',
      masterpiece: '春望、茅屋为秋风所破歌、登高'
    },
    {
      id: 3,
      name: '李清照',
      dynasty: '宋朝',
      description: '号易安居士,婉约词派代表,"千古第一才女"',
      imageResource: 'liqingzhao',
      masterpiece: '声声慢、一剪梅、如梦令'
    },
    {
      id: 4,
      name: '苏轼',
      dynasty: '宋朝',
      description: '字子瞻,号东坡居士,豪放派代表词人',
      imageResource: 'sushi',
      masterpiece: '水调歌头、念奴娇·赤壁怀古'
    },
    {
      id: 5,
      name: '白居易',
      dynasty: '唐朝',
      description: '字乐天,号香山居士,新乐府运动倡导者',
      imageResource: 'baijuyi',
      masterpiece: '长恨歌、琵琶行、赋得古原草送别'
    },
    {
      id: 6,
      name: '王维',
      dynasty: '唐朝',
      description: '字摩诘,唐代山水田园诗派代表',
      imageResource: 'wangwei',
      masterpiece: '相思、山居秋暝、鹿柴'
    },
    {
      id: 7,
      name: '辛弃疾',
      dynasty: '宋朝',
      description: '字幼安,号稼轩,豪放派词人代表',
      imageResource: 'xinqiji',
      masterpiece: '破阵子、永遇乐·京口北固亭怀古'
    },
    {
      id: 8,
      name: '陆游',
      dynasty: '宋朝',
      description: '字务观,号放翁,南宋爱国诗人',
      imageResource: 'luyou',
      masterpiece: '示儿、钗头凤、游山西村'
    },
    {
      id: 9,
      name: '王昌龄',
      dynasty: '唐朝',
      description: '字少伯,盛唐著名边塞诗人',
      imageResource: 'wangchangling',
      masterpiece: '出塞、芙蓉楼送辛渐'
    },
    {
      id: 10,
      name: '孟浩然',
      dynasty: '唐朝',
      description: '唐代山水田园诗派代表诗人',
      imageResource: 'menghaoran',
      masterpiece: '春晓、过故人庄、宿建德江'
    },
    {
      id: 11,
      name: '杜牧',
      dynasty: '唐朝',
      description: '字牧之,号樊川居士,晚唐杰出诗人',
      imageResource: 'dumu',
      masterpiece: '山行、清明、泊秦淮'
    },
    {
      id: 12,
      name: '柳宗元',
      dynasty: '唐朝',
      description: '字子厚,世称"柳河东",唐宋八大家之一',
      imageResource: 'liuzongyuan',
      masterpiece: '江雪、捕蛇者说、小石潭记'
    }
  ];

  aboutToAppear(): void {
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('著名诗人')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))
      }
      .height(60)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))

      // 诗人列表
      List({ space: 15 }) {
        ForEach(this.poets, (poet: PoetInfo, index: number) => {
          ListItem() {
            this.PoetCard(poet, index)
          }
        }, (poet: PoetInfo) => poet.id.toString())
      }
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder
  PoetCard(poet: PoetInfo, index: number) {
    Column() {
      Row() {
        // 诗人图片或图标
        if (poet.imageResource) {
          Image($r(`app.media.${poet.imageResource}`))
            .width(70)
            .height(70)
            .borderRadius(35)
            .objectFit(ImageFit.Cover)
            .margin({ right: 15 })
        } else if (poet.icon) {
          Text(poet.icon)
            .fontSize(48)
            .width(70)
            .height(70)
            .textAlign(TextAlign.Center)
            .margin({ right: 15 })
        }
        
        Column() {
          // 诗人姓名和朝代
          Row() {
            Text(poet.name)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
            
            Text(`【${poet.dynasty}】`)
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ left: 8 })
          }
          .width('100%')
          
          // 诗人简介
          Text(poet.description)
            .fontSize(13)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 6 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          
          // 代表作
          Text(`代表作: ${poet.masterpiece}`)
            .fontSize(12)
            .fontColor($r('app.color.text_tertiary'))
            .margin({ top: 6 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        
        // 箭头图标
        Text('>')
          .fontSize(24)
          .fontColor($r('app.color.text_tertiary'))
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(15)
    .shadow({
      radius: 10,
      color: $r('app.color.text_tertiary'),
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      // 跳转到诗人详情页
      router.pushUrl({
        url: 'pages/chinese/PoetDetailPage',
        params: {
          poetId: poet.id
        }
      });
    })
    .scale({ x: this.isPageLoaded ? 1 : 0.8, y: this.isPageLoaded ? 1 : 0.8 })
    .opacity(this.isPageLoaded ? 1 : 0)
    .animation({
      duration: 400,
      curve: Curve.EaseOut,
      delay: index * 80
    })
  }
}
