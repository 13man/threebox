import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';

// 定义宋词接口
interface Song {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string; // 添加拼音字段
}

// 定义句子接口
interface Sentence {
  sentence: string;
  pinyin: string;
}

// 定义字符拼音对接口
interface CharPinyinPair {
  char: string;
  pinyin: string;
}

// 定义参数接口
interface PageParams {
  song?: string;
}

@Entry
@Component
export struct SongDetailPage {
  @State song: Song = {
    id: 0,
    title: '',
    author: '',
    content: '',
    pinyin: '' // 添加拼音字段
  };
  // 添加TTS相关状态
  @State isPlaying: boolean = false;

  // 不再创建TextReader实例，而是使用静态方法

  aboutToAppear(): void {
    // 获取从上一个页面传递过来的宋词数据
    // 使用 JSON 方法安全地处理参数
    try {
      const paramsStr = JSON.stringify(router.getParams());
      if (paramsStr && paramsStr !== '{}') {
        const params: PageParams = JSON.parse(paramsStr);
        if (params.song) {
          this.song = JSON.parse(params.song);
        }
      }
    } catch (e) {
      console.log('参数解析失败:', e);
    }

    // 初始化TTS客户端
    this.initTextReader();
  }

  aboutToDisappear(): void {
    // 页面销毁时停止朗读
    if (this.isPlaying) {
      TextReader.stop();
    }
  }

  // 初始化TextReader
  private initTextReader(): void {
    try {
      // 创建朗读参数
      const readerParam: TextReader.ReaderParam = {
        isVoiceBrandVisible: true,
        businessBrandInfo: {
          panelName: '小艺朗读',
          panelIcon: $r('app.media.startIcon')
        }
      ,
        keepBackgroundRunning: true
      };

      // 初始化TextReader
      TextReader.init(getContext(this), readerParam).then(() => {
        console.log('TextReader初始化成功');
      }).catch((error: Error) => {
        console.error('TextReader初始化失败:', error);
      });

      // 监听朗读状态变化
      TextReader.on('stateChange', (state: TextReader.ReadState) => {
        console.log('朗读状态变化:', state);
        switch (state.state) {
          case ReadStateCode.PLAYING:
            this.isPlaying = true;
            break;
          case ReadStateCode.PAUSED:
          case ReadStateCode.WAITING:
          case ReadStateCode.COMPLETED:
            this.isPlaying = false;
            break;
        }
      });
    } catch (error) {
      const e: Error = error as Error;
      console.error('初始化TextReader时发生错误:', e);
    }
  }

  // 朗读/暂停朗读
  private togglePlay(): void {
    try {
      if (this.isPlaying) {
        // 暂停朗读
        TextReader.pause();
        this.isPlaying = false;
      } else {
        // 如果没有在朗读，则开始朗读
        this.startPlay();
      }
    } catch (error) {
      const e: Error = error as Error;
      console.error('切换朗读状态时发生错误:', e);
    }
  }

  // 开始朗读
  private startPlay(): void {
    try {
      // 创建朗读内容
      const readInfo: TextReader.ReadInfo = {
        id: `song_${this.song.id}`,
        title: {
          text: this.song.title,
          isClickable: false
        },
        bodyInfo: `${this.song.title}，作者：${this.song.author}。${this.song.content}`
      };

      // 开始朗读
      TextReader.start([readInfo]).then(() => {
        console.log('开始朗读');
        this.isPlaying = true;
      }).catch((error: Error) => {
        console.error('朗读失败:', error);
        promptAction.showToast({ message: '朗读失败: ' + error.message });
      });
    } catch (error) {
      const e: Error = error as Error;
      console.error('开始朗读时发生错误:', e);
      promptAction.showToast({ message: '开始朗读时发生错误' });
    }
  }

  // 停止朗读
  private stopPlay(): void {
    try {
      TextReader.stop();
      this.isPlaying = false;
    } catch (error) {
      const e: Error = error as Error;
      console.error('停止朗读时发生错误:', e);
    }
  }

  // 获取随机颜色
  private getRandomColor(): ResourceColor {
    const colors: Array<ResourceColor> = [
      Color.Red, 
      Color.Blue,
      Color.Orange
    ];
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
  }

  // 获取宋词的趣味解析
  private getSongExplanation(): string {
    const explanations: Map<string, string> = new Map([
      ['水调歌头・明月几时有', '这是苏轼在中秋节时思念弟弟苏辙而作的词，表达了对亲人的思念之情以及对人生哲理的深刻思考。词中"但愿人长久，千里共婵娟"成为千古传诵的名句，表达了对美好生活的向往。'],
      ['念奴娇・赤壁怀古', '这首词是苏轼被贬黄州时所作，通过对赤壁古战场的描写，表达了对历史英雄的缅怀以及对自己人生境遇的感慨。词中气势磅礴，是豪放词的代表作之一。'],
      ['声声慢・寻寻觅觅', '这是李清照晚年的代表作，通过描写秋日的凄凉景象，表达了词人内心的孤独与哀愁。词中连用七个叠字开头，成为中国文学史上的经典之作。'],
      ['雨霖铃・寒蝉凄切', '柳永的这首离别词描写了与恋人分别时的痛苦心情，情景交融，语言优美，是婉约词的代表作品之一。'],
      ['永遇乐・京口北固亭怀古', '辛弃疾的这首词通过对历史人物的缅怀，表达了自己壮志难酬的愤慨以及对国家命运的担忧，是豪放词中的名篇。'],
      ['虞美人・春花秋月何时了', '李煜作为亡国之君，在这首词中表达了对故国的思念以及对人生无常的感慨，情感真挚动人。'],
      ['青玉案・元夕', '辛弃疾的这首词描写了元宵节的热闹景象，最后"众里寻他千百度，蓦然回首，那人却在，灯火阑珊处"成为传世名句，寓意深刻。'],
      ['一剪梅・红藕香残玉簟秋', '李清照的这首词表达了对丈夫的深切思念，情真意切，是婉约词的代表作之一。'],
      ['苏幕遮・碧云天', '范仲淹的这首词描写了秋日景色，表达了对故乡的思念之情，情景交融，意境深远。'],
      ['渔家傲・塞下秋来风景异', '这首词描写了边塞生活，表达了戍边将士的思乡之情和报国之志，风格苍凉悲壮。'],
      ['蝶恋花・伫倚危楼风细细', '柳永的这首词表达了对恋人的思念之情，其中"衣带渐宽终不悔，为伊消得人憔悴"成为表达坚贞爱情的名句。'],
      ['浣溪沙・一曲新词酒一杯', '晏殊的这首词通过对旧景的描写，表达了对时光流逝的感慨，其中"无可奈何花落去，似曾相识燕归来"是千古名句。'],
      ['蝶恋花・槛菊愁烟兰泣露', '这首词描写了深秋的景色，表达了离别之愁，其中"昨夜西风凋碧树，独上高楼，望尽天涯路"成为经典名句。'],
      ['采桑子・轻舟短棹西湖好', '欧阳修的这首词描写了西湖的美景，风格清新自然，表达了对美好生活的热爱。'],
      ['桂枝香・金陵怀古', '王安石的这首词通过对金陵古迹的描写，表达了对历史兴衰的感慨，寓意深远。'],
      ['临江仙・梦后楼台高锁', '晏几道的这首词回忆了与恋人的美好时光，表达了对往昔的怀念和内心的感伤。'],
      ['鹊桥仙・纤云弄巧', '秦观的这首词以牛郎织女的传说为题材，表达了对爱情的赞美，其中"两情若是久长时，又岂在朝朝暮暮"成为爱情名句。'],
      ['定风波・莫听穿林打叶声', '苏轼的这首词表达了面对人生风雨的豁达态度，体现了词人乐观旷达的精神境界。'],
      ['诉衷情・当年万里觅封侯', '陆游的这首词表达了壮志未酬的悲愤以及对国家统一的渴望，情感深沉。'],
      ['满江红・写怀', '岳飞的这首词表达了对敌人的愤恨和收复失地的决心，气势磅礴，是爱国主义词作的代表。']
    ]);
    
    return explanations.get(this.song.title) || '这首词描绘了诗人内心的情感世界，通过生动的意象表达了深刻的哲理和情感，值得细细品味。';
  }

  build() {
    Column() {
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
        
        Text('宋词详情')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_primary'))

        // 添加朗读/暂停按钮
        Button(this.isPlaying ? '暂停' : '朗读')
          .onClick(() => {
            this.togglePlay();
          })
          .margin({ right: 10 })
          .type(ButtonType.Normal)
          .borderRadius(20)
          .width(80)
          .height(40)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isPlaying ? '#FF9800' : '#4CAF50')
          .fontColor(Color.White)
          .animation({ duration: 300 })
          .shadow({
            radius: 5,
            color: this.isPlaying ? '#FF9800AA' : '#4CAF50AA',
            offsetX: 0,
            offsetY: 2
          })
      }
      .height(60)
      .alignItems(VerticalAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      
      Scroll() {
        Column() {
          // 宋词标题
          Text(this.song.title)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20 })
            .fontColor($r('app.color.text_primary'))
          
          // 作者
          Text('作者：' + this.song.author)
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10 })
          
          // 分隔线
          Divider()
            .margin({ top: 20, bottom: 20 })
            .color($r('app.color.text_tertiary'))
          
          // 宋词正文（带拼音）
          Column() {
            this.renderSongWithPinyin()
          }
          .padding(20)
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(15)
          .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })
          .margin({ left: 20, right: 20 })
          
          // 趣味解析标题
          Text('趣味解析')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 30, bottom: 15 })
            .fontColor(this.getRandomColor())
          
          // 趣味解析内容
          Text(this.getSongExplanation())
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .fontStyle(FontStyle.Italic)
            .margin({ left: 20, right: 20 })
            .fontColor(this.getRandomColor())
            .fontWeight(FontWeight.Normal)

          
          // 添加爱心图标
          Text('❤')
            .fontSize(24)
            .fontColor('#FF0000')
            .textAlign(TextAlign.Center)
            .margin({ top: 10 })

          Blank()
        }
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
  
  // 使用@Builder渲染带拼音的宋词
  @Builder
  private renderSongWithPinyin() {
    ForEach(this.song.content.split('\n'), (line: string, index: number) => {
      // 每行添加横向滚动支持
      Scroll() {
        Column() {
          // 拼音行
          Row() {
            ForEach(this.getCharPinyinPairs(line, this.getPinyinLine(index)), (pair: CharPinyinPair, charIndex: number) => {
              if (/[\u4e00-\u9fa5]/.test(pair.char)) {
                Text(pair.pinyin)
                  .fontSize(10)
                  .textAlign(TextAlign.Center)
                  .fontColor($r('app.color.text_secondary'))
                  .width(22)
                  .margin({ left: 1, right: 1 })
              } else {
                Text('')
                  .fontSize(12)
                  .width(24)
                  .margin({ left: 1, right: 1 })
              }
            }, (pair: CharPinyinPair, charIndex: number) => pair.char + index.toString() + charIndex.toString())
          }
          .margin({ top: 5 })
          
          // 汉字行
          Row() {
            ForEach(this.getCharPinyinPairs(line, this.getPinyinLine(index)), (pair: CharPinyinPair, charIndex: number) => {
              Text(pair.char)
                .fontSize(16)
                .fontColor($r('app.color.text_primary'))
                .textAlign(TextAlign.Center)
                .width(22)
                .margin({ left: 1, right: 1 })
            }, (pair: CharPinyinPair, charIndex: number) => pair.char + index.toString() + charIndex.toString())
          }
          .margin({ top: 2, bottom: 10 })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
    }, (line: string) => line)
  }
  
  // 获取指定行的拼音
  private getPinyinLine(index: number): string {
    if (!this.song.pinyin) return '';
    const pinyinLines = this.song.pinyin.split('\n');
    return pinyinLines[index] || '';
  }
  
  // 获取字符和拼音的对应关系
  private getCharPinyinPairs(sentence: string, pinyinLine: string): CharPinyinPair[] {
    const result: CharPinyinPair[] = [];
    // 获取句子中的所有字符（包括汉字和标点符号）
    const chars = sentence.split('');
    
    // 处理拼音数组，去除多余空格并分割
    const pinyins = pinyinLine ? pinyinLine.trim().split(/\s+/) : [];
    
    // 用于跟踪拼音索引
    let pinyinIndex = 0;
    
    // 为每个字符分配对应的内容
    for (let i = 0; i < chars.length; i++) {
      const char = chars[i];
      // 判断是否为汉字
      if (/[\u4e00-\u9fa5]/.test(char)) {
        // 如果是汉字，则分配拼音
        result.push({
          char: char,
          pinyin: pinyins[pinyinIndex] || ''
        });
        pinyinIndex++;
      } else {
        // 如果是标点符号或其他字符，则不分配拼音
        result.push({
          char: char,
          pinyin: ''
        });
      }
    }
    
    return result;
  }

}