import router from '@ohos.router';

interface ChineseItem {
  id: number;
  title: string;
  icon: string;
  description: string;
  color: ResourceColor;
  bgGradient: [ResourceColor, number][];
  count: number;
}

// 定义诗词分类主题接口
interface FeihuaTheme {
  id: number;
  name: string;
  description: string;
  icon: string;
  keyword: string;
}

// 定义分组主题接口
interface GroupedTheme {
  category: string;
  themes: FeihuaTheme[];
}

@Component
export struct ChinesePage {
  @State selectedItem: number = 1; // 默认选中唐诗鉴赏
  @State isPageLoaded: boolean = false;
  @State isNavigating: boolean = false; // 防止多次点击跳转的状态
  @State gridColumns: string = '1fr 1fr'; // 默认网格列数
  @State searchKeyword: string = ''; // 搜索关键词
  @State isSearching: boolean = false; // 是否正在搜索
  @State stickyHeaderVisible: boolean = false; // 吸顶区域是否可见
  @State showTopHeader: boolean = true; // 顶部标题区域是否可见
  
  // 定义语文学习项目列表
  private chineseItems: Array<ChineseItem> = [
    { 
      id: 1, 
      title: '唐诗鉴赏', 
      icon: '📖', 
      description: '千古绝唱,诗韵悠扬',
      color: $r('app.color.tang_poem_card'),
      bgGradient: [[$r('app.color.tang_poem_card'), 1.0], [$r('app.color.tang_poem_card_light'), 1.0]],
      count: 110
    },
    { 
      id: 2, 
      title: '宋词精选',
      icon: '🎵', 
      description: '婉约豪放,词韵悠长',
      color: $r('app.color.song_lyric_card'),
      bgGradient: [[$r('app.color.song_lyric_card'), 1.0], [$r('app.color.song_lyric_card_light'), 1.0]],
      count: 100
    },
    { 
      id: 3, 
      title: '元曲赏析', 
      icon: '🎪', 
      description: '曲韵悠扬,意境深远',
      color: $r('app.color.yuan_opera_card'),
      bgGradient: [[$r('app.color.yuan_opera_card'), 1.0], [$r('app.color.yuan_opera_card_light'), 1.0]],
      count: 100
    }
  ];
  
  // 诗词分类主题分类列表
  private themes: FeihuaTheme[] = [
    { id: 1, name: '写景', description: '山水风光', icon: '🏞️', keyword: '山|水|江|湖' },
    { id: 2, name: '写花', description: '百花齐放', icon: '🌸', keyword: '花|梅|菊|莲' },
    { id: 3, name: '写边塞', description: '铁马金戈', icon: '⚔️', keyword: '塞|关|战|征' },
    { id: 4, name: '写爱情', description: '相思绵绵', icon: '💕', keyword: '爱|情|思|相思' },
    { id: 5, name: '写思乡', description: '举头望月', icon: '🏠', keyword: '乡|归|家|故乡' },
    { id: 6, name: '写田园', description: '阡陌纵横', icon: '🌾', keyword: '田|园|农|耕' },
    { id: 7, name: '写离别', description: '依依惜别', icon: '👋', keyword: '别|离|送|行' },
    { id: 8, name: '写孤独', description: '独坐幽篁', icon: '😔', keyword: '孤|独|寂|寞' },
    { id: 9, name: '写壮志', description: '豪情万丈', icon: '🦅', keyword: '志|雄|壮|豪' },
    { id: 10, name: '写茶', description: '清茗飘香', icon: '🍵', keyword: '茶|茗|泉|煮' },
    { id: 11, name: '咏物', description: '咏物抒怀', icon: '📿', keyword: '物|器|宝|玉' },
    { id: 12, name: '春天', description: '春意盎然', icon: '🌱', keyword: '春|绿|暖|生' },
    { id: 13, name: '夏天', description: '夏日炎炎', icon: '☀️', keyword: '夏|热|荷|蝉' },
    { id: 14, name: '秋天', description: '秋高气爽', icon: '🍂', keyword: '秋|黄|霜|落' },
    { id: 15, name: '冬天', description: '寒冬腊月', icon: '❄️', keyword: '冬|雪|寒|冰' },
    { id: 16, name: '写雨', description: '烟雨蒙蒙', icon: '🌧️', keyword: '雨|湿|润|滴' },
    { id: 17, name: '写雪', description: '雪花飘飘', icon: '⛄', keyword: '雪|白|冷|冻' },
    { id: 18, name: '写风', description: '清风徐来', icon: '🌬️', keyword: '风|吹|拂|飘' },
    { id: 19, name: '写梅花', description: '傲雪寒梅', icon: '🌺', keyword: '梅|香|寒|傲' },
    { id: 20, name: '写荷花', description: '荷塘月色', icon: '🪷', keyword: '荷|莲|池|塘' },
    { id: 21, name: '写菊花', description: '金秋菊韵', icon: '🌻', keyword: '菊|黄|秋|香' },
    { id: 22, name: '写柳树', description: '杨柳依依', icon: '🌿', keyword: '柳|绿|垂|条' },
    { id: 23, name: '月亮', description: '明月清辉', icon: '🌕', keyword: '月|明|辉|圆' },
    { id: 24, name: '山水', description: '山清水秀', icon: '⛰️', keyword: '山|水|峰|溪' },
    { id: 25, name: '写山', description: '巍峨高山', icon: '🏔️', keyword: '山|峰|岭|岳' },
    { id: 26, name: '写水', description: '江河湖海', icon: '💧', keyword: '水|江|河|湖' },
    { id: 27, name: '长江', description: '长江浩荡', icon: '🌊', keyword: '江|长|流|浪' },
    { id: 28, name: '黄河', description: '黄河奔腾', icon: '🏞️', keyword: '河|黄|浪|涛' },
    { id: 29, name: '儿童', description: '童真童趣', icon: '👶', keyword: '童|儿|小|幼' },
    { id: 30, name: '写鸟', description: '飞鸟翱翔', icon: '🐦', keyword: '鸟|雁|鹤|燕' },
    { id: 31, name: '写马', description: '骏马奔腾', icon: '🐎', keyword: '马|骑|驰|奔' },
    { id: 32, name: '地名', description: '名胜古迹', icon: '🗺️', keyword: '地|城|关|州' },
    { id: 33, name: '节日', description: '传统佳节', icon: '🎊', keyword: '节|日|庆|欢' },
    { id: 34, name: '春节', description: '新春佳节', icon: '🧧', keyword: '春|岁|年|新' },
    { id: 35, name: '元宵', description: '元宵佳节', icon: '🏮', keyword: '灯|元|宵|圆' },
    { id: 36, name: '寒食', description: '寒食清明', icon: '🕯️', keyword: '寒|食|火|烟' },
    { id: 37, name: '清明', description: '清明时节', icon: '🌧️', keyword: '清|明|雨|祭' },
    { id: 38, name: '端午', description: '端午龙舟', icon: '🐲', keyword: '端|午|粽|舟' },
    { id: 39, name: '七夕', description: '七夕鹊桥', icon: '💫', keyword: '七|夕|星|桥' },
    { id: 40, name: '中秋', description: '中秋月圆', icon: '🥮', keyword: '中|秋|月|圆' },
    { id: 41, name: '重阳', description: '重阳登高', icon: '🏔️', keyword: '重|阳|菊|登' },
    { id: 42, name: '怀古', description: '怀古幽思', icon: '🏛️', keyword: '古|昔|史|迹' },
    { id: 43, name: '抒情', description: '抒情言志', icon: '💭', keyword: '情|志|意|怀' },
    { id: 44, name: '爱国', description: '报国情怀', icon: '🇨🇳', keyword: '国|忠|报|志' },
    { id: 45, name: '送别', description: '依依惜别', icon: '🤝', keyword: '送|别|离|去' },
    { id: 46, name: '闺怨', description: '闺阁幽怨', icon: '🌸', keyword: '闺|怨|思|愁' },
    { id: 47, name: '悼亡', description: '悼念亡者', icon: '🕊️', keyword: '悼|亡|逝|忆' },
    { id: 48, name: '老师', description: '师恩难忘', icon: '📚', keyword: '师|教|学|道' },
    { id: 49, name: '友情', description: '知己良朋', icon: '🤝', keyword: '友|朋|知|交' },
    { id: 50, name: '哲理', description: '人生哲理', icon: '☯️', keyword: '理|道|悟|思' },
    { id: 51, name: '读书', description: '勤学苦读', icon: '📖', keyword: '书|读|学|文' },
  /*  { id: 52, name: '婉约', description: '婉约柔美', icon: '🎭', keyword: '婉|柔|细|美' },
    { id: 53, name: '豪放', description: '豪放不羁', icon: '🎺', keyword: '豪|放|壮|阔' },
    { id: 54, name: '民谣', description: '民间歌谣', icon: '🎵', keyword: '谣|歌|民|曲' },
    { id: 55, name: '母亲', description: '慈母情深', icon: '👩', keyword: '母|慈|恩|养' }
  */];

  // 按类别分组的主题数据
  private groupedThemes: GroupedTheme[] = [
    {
      category: '情感表达',
      themes: this.themes.slice(0, 10)
    },
    {
      category: '自然景物',
      themes: this.themes.slice(10, 25)
    },
    {
      category: '时节节日',
      themes: this.themes.slice(25, 40)
    },
    {
      category: '人物关系',
      themes: this.themes.slice(40, 51)
    }
  ];

  aboutToAppear(): void {
    // 页面加载动画
    setTimeout(() => {
      this.isPageLoaded = true;
    }, 300);
  }

  // 根据ID跳转到对应页面
  navigateToPage(id: number) {
    // 如果正在跳转中，则忽略后续点击
    if (this.isNavigating) {
      return;
    }
    
    // 先更新选中状态，显示放大效果
    this.selectedItem = id;
    this.isNavigating = true; // 设置正在跳转状态
    
    // 延迟一段时间后跳转，确保放大动画完全播放完毕后再跳转
    setTimeout(() => {
      switch (id) {
        case 1:
          router.push({ url: 'pages/chinese/PoemsListPage' });
          break;
        case 2:
          router.push({ url: 'pages/chinese/SongsListPage' });
          break;
        case 3:
          router.push({ url: 'pages/chinese/YuanquListPage' });
          break;
        default:
          console.log('未知的页面ID:', id);
      }
      // 在跳转命令执行后立即重置状态
      this.isNavigating = false;
    }, 1000);
  }

  // 获取过滤后的主题数据
  getFilteredThemes(): GroupedTheme[] {
    // 如果没有搜索关键词，返回所有主题
    if (!this.isSearching || this.searchKeyword.trim().length === 0) {
      return this.groupedThemes;
    }
    
    // 创建新的过滤结果数组
    const filteredGroups: GroupedTheme[] = [];
    
    // 遍历所有分组
    for (let i = 0; i < this.groupedThemes.length; i++) {
      const group = this.groupedThemes[i];
      // 过滤当前分组中的主题
      const filteredThemes = group.themes.filter(theme => {
        // 检查主题名称、描述或关键字是否包含搜索关键词（不区分大小写）
        return (
          theme.name.toLowerCase().includes(this.searchKeyword.toLowerCase()) ||
          theme.description.toLowerCase().includes(this.searchKeyword.toLowerCase()) ||
          theme.keyword.toLowerCase().includes(this.searchKeyword.toLowerCase())
        );
      });
      
      // 如果过滤后还有主题，则添加到结果中
      if (filteredThemes.length > 0) {
        filteredGroups.push({
          category: group.category,
          themes: filteredThemes
        });
      }
    }
    
    return filteredGroups;
  }

  build() {
    Scroll() {
      Column() {
        // 顶部标题区域
        Column() {
          Text('诗匣')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.accent_positive'))
            .textShadow({ radius: 2, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })
            .margin({ bottom: 6 })
            .scale({ x: this.isPageLoaded ? 1 : 0.8, y: this.isPageLoaded ? 1 : 0.8 })
            .opacity(this.isPageLoaded ? 1 : 0)
            .animation({ duration: 600, curve: Curve.EaseOut })

          Text('开启古典文学之旅')
            .fontSize(14)
            .fontColor($r('app.color.text_secondary'))
            .fontWeight(FontWeight.Medium)
            .opacity(this.isPageLoaded ? 1 : 0)
            .animation({ duration: 600, curve: Curve.EaseOut, delay: 100 })
        }
        .margin({ top: 30, bottom: 20 })
        .alignItems(HorizontalAlign.Center)

        // 诗匣容器 - 支持滑动
        Column() {
          Scroll() {
            Row() {
              ForEach(this.chineseItems, (item: ChineseItem, index: number) => {
                this.MagicBox(item, index)
              })
            }
            .justifyContent(FlexAlign.Start)
            .width('auto')
            .padding({ left: 30, right: 30 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .height(120)
          .margin({ bottom: 10 })

          // 诗匣指示器
          Row() {
            ForEach(this.chineseItems, (item: ChineseItem, index: number) => {
              Circle({ width: 6, height: 6 })
                .fill(item.id === this.selectedItem ? item.color : $r('app.color.text_tertiary'))
                .margin({ right: 5 })
                .scale({ x: item.id === this.selectedItem ? 1.2 : 1, y: item.id === this.selectedItem ? 1.2 : 1 })
                .animation({ duration: 300, curve: Curve.EaseInOut })
            })
          }
          .margin({ bottom: 20 })
        }

        // 吸顶区域 - 诗词分类标题和搜索框
        Column() {
          // 分隔线和著名诗人标题
          Column() {
            Row()
              .width('80%')
              .height(1)
              .backgroundColor($r('app.color.text_tertiary'))
              .opacity(0.3)
              .margin({ bottom: 10 })
            
            Row() {
              Text('🌸')
                .fontSize(20)
                .margin({ right: 8 })
              
              Text('诗词分类')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.text_primary'))
              
              Text('🌸')
                .fontSize(20)
                .margin({ left: 8 })
            }
            .margin({ bottom: 10 })
          }
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 5 })

          // 搜索框
          Row() {
            TextInput({ 
              placeholder: '搜索诗词分类...', 
              text: this.searchKeyword 
            })
            .onChange((value: string) => {
              this.searchKeyword = value;
              this.isSearching = value.length > 0;
            })
            .placeholderColor($r('app.color.text_secondary'))
            .width('80%')
            .height(40)
            .borderRadius(20)
            .backgroundColor($r('app.color.card_background'))
            .padding({ left: 15, right: 15 })
            .margin({ bottom: 10 })
            
            // 清除按钮
            if (this.isSearching) {
              Button('清除')
                .width(60)
                .height(40)
                .fontSize(14)
                .borderRadius(20)
                .backgroundColor($r('app.color.card_background'))  // 使用已有的颜色资源
                .fontColor($r('app.color.text_primary'))
                .onClick(() => {
                  this.searchKeyword = '';
                  this.isSearching = false;
                })
                .margin({ left: 10 })
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .height(130)
        .id('stickyHeader')
        .backgroundColor($r('app.color.page_background'))
        .constraintSize({ minHeight: 130 })

        // 诗词分类展示区域
        Column() {
          // 改进的诗词分类展示 - 网格布局分组展示
          Column() {
            // 过滤后的主题数据
            ForEach(this.getFilteredThemes(), (group: GroupedTheme, groupIndex: number) => {
              Column() {
                // 分组标题
                Row() {
                  Text(group.category)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text_primary'))
                    .layoutWeight(1)
                }
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })

                // 分组内容 - 网格布局
                Grid() {
                  ForEach(group.themes, (theme: FeihuaTheme, index: number) => {
                    GridItem() {
                      this.ThemeCard(theme, index)
                    }
                  }, (theme: FeihuaTheme) => theme.id.toString())
                }
                .columnsTemplate(this.gridColumns) // 使用状态变量控制列数
                .rowsGap(10)
                .columnsGap(10)
                .padding({ left: 20, right: 20 })
                // 响应式布局 - 根据屏幕宽度调整列数
                .onAreaChange((oldArea, newArea) => {
                  // 将Length类型转换为number类型
                  const widthStr: string = newArea.width.toString();
                  const width: number = parseInt(widthStr, 10) || 0;
                  
                  if (width > 700) {
                    // 大屏幕显示4列
                    this.gridColumns = '1fr 1fr 1fr 1fr';
                  } else if (width > 500) {
                    // 中等屏幕显示3列
                    this.gridColumns = '1fr 1fr 1fr';
                  } else {
                    // 小屏幕显示2列
                    this.gridColumns = '1fr 1fr';
                  }
                })
              }
            })
          }
          .padding({ bottom: 20 })
        }
      }
      .width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder
  MagicBox(item: ChineseItem, index: number) {
    Column() {
      // 匣子图标
      Text(item.icon)
        .fontSize(item.id === this.selectedItem ? 32 : 30)
        .margin({ top: item.id === this.selectedItem ? 6 : 4, bottom: item.id === this.selectedItem ? 4 : 2 })
        .scale({ x: item.id === this.selectedItem ? 1.1 : 1, y: item.id === this.selectedItem ? 1.1 : 1 })
        .animation({ duration: 300, curve: Curve.EaseInOut })
      
      // 匣子标题
      Text(item.title)
        .fontSize(item.id === this.selectedItem ? 12: 11)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: item.id === this.selectedItem ? 2 : 1 })
        .scale({ x: item.id === this.selectedItem ? 1.05 : 1, y: item.id === this.selectedItem ? 1.05 : 1 })
        .animation({ duration: 300, curve: Curve.EaseInOut })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      // 匣子描述
      Text(item.description)
        .fontSize(10)
        .fontColor($r('app.color.text_primary'))
        .opacity(0.9)
        .margin({ bottom: item.id === this.selectedItem ? 4 : 2 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)
      
      // 收藏数量
      Text(`${item.count}+`)
        .fontSize(9)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_primary'))
        .opacity(0.8)
    }
    .width(item.id === this.selectedItem ? 140 : 125)
    .height(item.id === this.selectedItem ? 100 : 90)
    .borderRadius(18)
    .padding({ top: 10, bottom: 10, left: 12, right: 12 })  // 增加垂直内边距使内容更居中
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: item.bgGradient
    })
    .shadow({
      radius: item.id === this.selectedItem ? 18 : 10,
      color: item.id === this.selectedItem ? $r('app.color.text_tertiary') : $r('app.color.text_secondary'),
      offsetX: 0,
      offsetY: item.id === this.selectedItem ? 7 : 4
    })
    .scale({ x: item.id === this.selectedItem ? 1.05 : 1, y: item.id === this.selectedItem ? 1.05 : 1 })
    .onClick(() => {
      animateTo({
        duration: 100,
        curve: Curve.EaseInOut
      }, () => {
        // 点击时的缩放效果
      })
      
      this.navigateToPage(item.id);
    })
    .margin({ left: index === 0 ? 0 : 12, right: index === 2 ? 0 : 12 })
    .translate({
      y: this.isPageLoaded ? 0 : 30,
      x: this.isPageLoaded ? 0 : (index === 0 ? -50 : (index === 2 ? 50 : 0))
    })
    .opacity(this.isPageLoaded ? 1 : 0)
    .animation({
      duration: 600,
      curve: Curve.EaseOut,
      delay: 200 + index * 100
    })
    .justifyContent(FlexAlign.Center)  // 整体内容居中
  }

  @Builder
  ThemeCard(theme: FeihuaTheme, index: number) {
    Column() {
      // 主题图标
      Text(theme.icon)
        .fontSize(32)
        .margin({ bottom: 10 })
      
      // 主题名称
      Text(theme.name)
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ bottom: 5 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      // 主题描述
      Text(theme.description)
        .fontSize(11)
        .fontColor($r('app.color.text_secondary'))
        .opacity(0.8)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(110)
    .backgroundColor($r('app.color.card_background'))
    .borderRadius(10)
    .padding({ top: 10, bottom: 10, left: 10, right: 10 })
    .justifyContent(FlexAlign.Center)
    .shadow({
      radius: 5,
      color: $r('app.color.text_tertiary'),
      offsetX: 0,
      offsetY: 1
    })
    .onClick(() => {
      // 跳转到主题诗词列表页
      router.pushUrl({
        url: 'pages/chinese/ThemePoemsPage',
        params: {
          themeId: theme.id,
          themeName: theme.name
        }
      });
    })
    .scale({ x: this.isPageLoaded ? 1 : 0.8, y: this.isPageLoaded ? 1 : 0.8 })
    .opacity(this.isPageLoaded ? 1 : 0)
    .animation({
      duration: 400,
      curve: Curve.EaseOut,
      delay: 400 + index * 60
    })
  }
}