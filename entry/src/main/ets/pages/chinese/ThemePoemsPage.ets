import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import {
  PoemData,
  SCENERY_POEMS,
  FLOWER_POEMS,
  BORDER_POEMS,
  LOVE_POEMS,
  HOMESICK_POEMS,
  PASTORAL_POEMS,
  FAREWELL_POEMS,
  LONELY_POEMS,
  AMBITION_POEMS,
  TEA_POEMS,
  OBJECT_POEMS
} from '../../data/ThemePoemsData';
import {
  SPRING_POEMS,
  SUMMER_POEMS,
  AUTUMN_POEMS,
  WINTER_POEMS,
  RAIN_POEMS,
  SNOW_POEMS,
  WIND_POEMS,
  PLUM_BLOSSOM_POEMS,
  LOTUS_POEMS,
  CHRYSANTHEMUM_POEMS,
  WILLOW_POEMS,
  MOON_POEMS,
  LANDSCAPE_POEMS,
  WATER_POEMS,
  MOUNTAIN_POEMS,
  YANGTZE_POEMS,
  YELLOW_RIVER_POEMS,
  CHILDREN_POEMS,
  BIRD_POEMS,
  HORSE_POEMS,
  PLACE_NAME_POEMS,
  FESTIVAL_POEMS,
  SPRING_FESTIVAL_POEMS,
  LANTERN_FESTIVAL_POEMS,
  COLD_FOOD_FESTIVAL_POEMS,
  QINGMING_FESTIVAL_POEMS,
  DRAGON_BOAT_FESTIVAL_POEMS,
  QIXI_FESTIVAL_POEMS,
  MID_AUTUMN_FESTIVAL_POEMS,
  DOUBLE_NINTH_FESTIVAL_POEMS,
  REMINISCENT_POEMS,
  LYRICAL_POEMS,
  PATRIOTIC_POEMS,
  BOWER_LAMENT_POEMS,
  MOURNING_POEMS,
  TEACHER_POEMS,
  FRIENDSHIP_POEMS,
  PHILOSOPHY_POEMS,
  READING_POEMS
} from '../../data/ThemePoemsData_Extended';

@Entry
@Component
export struct ThemePoemsPage {
  @State private themeName: string = '';
  @State private themeId: number = 0;
  @State private poems: PoemData[] = [];
  @State private keyword: string = '';
  @State private isPageLoaded: boolean = false;

  aboutToAppear(): void {
    // 获取路由参数
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.themeId = params['themeId'] as number || 0;
      this.themeName = params['themeName'] as string || '';
    }

    // 根据主题ID加载对应的诗词
    this.loadPoemsByTheme(this.themeId);

    setTimeout(() => {
      this.isPageLoaded = true;
    }, 100);
  }

  // 根据主题加载诗词
  private loadPoemsByTheme(themeId: number): void {
    switch (themeId) {
      case 1: // 写景
        this.poems = SCENERY_POEMS;
        break;
      case 2: // 写花
        this.poems = FLOWER_POEMS;
        break;
      case 3: // 写边塞
        this.poems = BORDER_POEMS;
        break;
      case 4: // 写爱情
        this.poems = LOVE_POEMS;
        break;
      case 5: // 写思乡
        this.poems = HOMESICK_POEMS;
        break;
      case 6: // 写田园
        this.poems = PASTORAL_POEMS;
        break;
      case 7: // 写离别
        this.poems = FAREWELL_POEMS;
        break;
      case 8: // 写孤独
        this.poems = LONELY_POEMS;
        break;
      case 9: // 写壮志
        this.poems = AMBITION_POEMS;
        break;
      case 10: // 写茶
        this.poems = TEA_POEMS;
        break;
      case 11: // 咏物
        this.poems = OBJECT_POEMS;
        break;
      case 12: // 春天
        this.poems = SPRING_POEMS;
        break;
      case 13: // 夏天
        this.poems = SUMMER_POEMS;
        break;
      case 14: // 秋天
        this.poems = AUTUMN_POEMS;
        break;
      case 15: // 冬天
        this.poems = WINTER_POEMS;
        break;
      case 16: // 写雨
        this.poems = RAIN_POEMS;
        break;
      case 17: // 写雪
        this.poems = SNOW_POEMS;
        break;
      case 18: // 写风
        this.poems = WIND_POEMS;
        break;
      case 19: // 写梅花
        this.poems = PLUM_BLOSSOM_POEMS;
        break;
      case 20: // 写荷花
        this.poems = LOTUS_POEMS;
        break;
      case 21: // 写菊花
        this.poems = CHRYSANTHEMUM_POEMS;
        break;
      case 22: // 写柳树
        this.poems = WILLOW_POEMS;
        break;
      case 23: // 月亮
        this.poems = MOON_POEMS;
        break;
      case 24: // 山水
        this.poems = LANDSCAPE_POEMS;
        break;
      case 25: // 写山
        this.poems = MOUNTAIN_POEMS;
        break;
      case 26: // 写水
        this.poems = WATER_POEMS;
        break;
      case 27: // 长江
        this.poems = YANGTZE_POEMS;
        break;
      case 28: // 黄河
        this.poems = YELLOW_RIVER_POEMS;
        break;
      case 29: // 儿童
        this.poems = CHILDREN_POEMS;
        break;
      case 30: // 写鸟
        this.poems = BIRD_POEMS;
        break;
      case 31: // 写马
        this.poems = HORSE_POEMS;
        break;
      case 32: // 地名
        this.poems = PLACE_NAME_POEMS;
        break;
      case 33: // 节日
        this.poems = FESTIVAL_POEMS;
        break;
      case 34: // 春节
        this.poems = SPRING_FESTIVAL_POEMS;
        break;
      case 35: // 元宵
        this.poems = LANTERN_FESTIVAL_POEMS;
        break;
      case 36: // 寒食
        this.poems = COLD_FOOD_FESTIVAL_POEMS;
        break;
      case 37: // 清明
        this.poems = QINGMING_FESTIVAL_POEMS;
        break;
      case 38: // 端午
        this.poems = DRAGON_BOAT_FESTIVAL_POEMS;
        break;
      case 39: // 七夕
        this.poems = QIXI_FESTIVAL_POEMS;
        break;
      case 40: // 中秋
        this.poems = MID_AUTUMN_FESTIVAL_POEMS;
        break;
      case 41: // 重阳
        this.poems = DOUBLE_NINTH_FESTIVAL_POEMS;
        break;
      case 42: // 怀古
        this.poems = REMINISCENT_POEMS;
        break;
      case 43: // 抒情
        this.poems = LYRICAL_POEMS;
        break;
      case 44: // 爱国
        this.poems = PATRIOTIC_POEMS;
        break;
      case 45: // 送别
        this.poems = FAREWELL_POEMS;
        break;
      case 46: // 闺怨
        this.poems = BOWER_LAMENT_POEMS;
        break;
      case 47: // 悼亡
        this.poems = MOURNING_POEMS;
        break;
      case 48: // 老师
        this.poems = TEACHER_POEMS;
        break;
      case 49: // 友情
        this.poems = FRIENDSHIP_POEMS;
        break;
      case 50: // 哲理
        this.poems = PHILOSOPHY_POEMS;
        break;
      case 51: // 读书
        this.poems = READING_POEMS;
        break;
      case 52: //婉约
      case 53: //豪放
      case 54: //民谣
      case 55: //母亲

      default:
        this.poems = [];
    }
  }

  // 过滤诗词
  private getFilteredPoems(): PoemData[] {
    if (!this.keyword.trim()) {
      return this.poems;
    }
    const kw = this.keyword.toLowerCase();
    return this.poems.filter((p: PoemData) =>
    p.title.toLowerCase().includes(kw) ||
    p.author.toLowerCase().includes(kw) ||
    p.content.toLowerCase().includes(kw)
    );
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Button('返回')
          .onClick(() => {
            router.back();
          })
          .margin({ left: 16 })
          .type(ButtonType.Normal)
          .borderRadius(18)
          .width(64)
          .height(32)
          .fontSize(13)
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))

        Column() {
          Text(`诗词分类·${this.themeName}`)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))

          Text(`共${this.poems.length}首经典诗词`)
            .fontSize(12)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Text(' ')
          .width(64)
      }
      .height(60)
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // 搜索框
      Row() {
        TextInput({ placeholder: '搜索诗词标题、作者或内容' })
          .layoutWeight(1)
          .height(40)
          .borderRadius(20)
          .backgroundColor($r('app.color.card_background'))
          .onChange((value: string) => {
            this.keyword = value;
          })
      }
      .padding({
        left: 16,
        right: 16,
        top: 8,
        bottom: 8
      })

      // 诗词列表
      List({ space: 12 }) {
        ForEach(this.getFilteredPoems(), (poem: PoemData, index: number) => {
          ListItem() {
            Column() {
              Text(poem.title)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))

              Text(`${poem.dynasty}·${poem.author}`)
                .fontSize(13)
                .fontColor($r('app.color.text_secondary'))
                .margin({ top: 4 })

              Text(poem.content)
                .fontSize(14)
                .fontColor($r('app.color.text_primary'))
                .margin({ top: 8 })
                .lineHeight(22)
            }
            .width('100%')
            .padding(16)
            .backgroundColor($r('app.color.card_background'))
            .borderRadius(12)
            .onClick(() => {
              promptAction.showToast({ message: `查看《${poem.title}》详情` });
            })
          }
        }, (poem: PoemData) => `${poem.id}`)
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}
