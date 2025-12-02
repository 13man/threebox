import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { TextReader, TextReaderIcon, ReadStateCode } from '@kit.SpeechKit';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';

// 定义元曲接口
interface Yuanqu {
  id: number;
  title: string;
  author: string;
  content: string;
  pinyin?: string;
}

// 定义参数接口
interface PageParams {
  yuanqu?: string;
}

@Entry
@Component
export struct YuanquDetailPage {
  @State yuanqu: Yuanqu = {
    id: 0,
    title: '',
    author: '',
    content: '',
    pinyin: ''
  };
  // 添加TTS相关状态
  @State isPlaying: boolean = false;

  aboutToAppear(): void {
    // 获取从上一个页面传递过来的元曲数据
    try {
      const paramsStr = JSON.stringify(router.getParams());
      if (paramsStr && paramsStr !== '{}') {
        const params: PageParams = JSON.parse(paramsStr);
        if (params.yuanqu) {
          this.yuanqu = JSON.parse(params.yuanqu);
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
        },
        keepBackgroundRunning: true
      };

      // 初始化TextReader
      TextReader.init(getContext(this) as common.UIAbilityContext, readerParam).then(() => {
        console.log('TextReader初始化成功');
      }).catch((error: BusinessError) => {
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
      const e: BusinessError = error as BusinessError;
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
      const e: BusinessError = error as BusinessError;
      console.error('切换朗读状态时发生错误:', e);
    }
  }

  // 开始朗读
  private startPlay(): void {
    try {
      // 创建朗读内容
      const readInfo: TextReader.ReadInfo = {
        id: `yuanqu_${this.yuanqu.id}`,
        title: {
          text: this.yuanqu.title,
          isClickable: false
        },
        bodyInfo: `${this.yuanqu.title}，作者：${this.yuanqu.author}。${this.yuanqu.content}`
      };

      // 开始朗读
      TextReader.start([readInfo]).then(() => {
        console.log('开始朗读');
        this.isPlaying = true;
      }).catch((error: BusinessError) => {
        console.error('朗读失败:', error);
        promptAction.showToast({ message: '朗读失败: ' + error.message });
      });
    } catch (error) {
      const e: BusinessError = error as BusinessError;
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
      const e: BusinessError = error as BusinessError;
      console.error('停止朗读时发生错误:', e);
    }
  }

  // 获取元曲的趣味解析
  private getYuanquExplanation(): string {
    const explanations: Map<string, string> = new Map([
      ['天净沙·秋思', '这是马致远的代表作，被誉为"秋思之祖"。通过枯藤、老树、昏鸦等意象，营造出萧瑟的秋日黄昏景象，表达了游子的思乡之情。全曲仅28字，却描绘出一幅完整的秋郊夕照图，情景交融，意境深远。'],
      ['天净沙·秋', '白朴的这首小令描绘了秋日黄昏的景色，通过孤村、落日、残霞等意象，展现出一幅宁静的田园画卷。与马致远的《天净沙·秋思》相比，这首曲子少了些萧瑟，多了些宁静致远的意境。'],
      ['天净沙·春', '白朴的这首小令描绘了春天的美好景象，通过暖日、和风、杨柳等意象，展现出一幅生机盎然的春日图景。全曲语言清新，节奏明快，给人以愉悦的感受。'],
      ['四块玉·别情', '关汉卿的这首小令描写了离别之情，通过"相思"、"杨花雪"等意象，表达了对远方情人的思念。语言通俗易懂，情感真挚动人。'],
      ['山坡羊·潼关怀古', '张养浩的这首散曲是元曲中的名篇，通过凭吊潼关古迹，抒发了对历史兴亡的感慨。"兴，百姓苦；亡，百姓苦"这一名句，深刻揭示了封建社会的本质，具有强烈的现实批判意义。'],
      ['水仙子·夜雨', '徐再思的这首小令描写了秋夜雨声引发的愁思，通过"梧叶"、"芭蕉"等意象，营造出凄清的氛围。全曲情景交融，语言优美，表达了游子的思乡之情。'],
      ['蟾宫曲·春情', '徐再思的这首小令描写了相思之苦，通过"浮云"、"飞絮"、"游丝"等意象，形象地表现了相思者的心理状态。语言典雅，情感细腻，是元曲中描写爱情的佳作。'],
      ['沉醉东风·渔夫', '白朴的这首小令通过描写渔夫的生活，表达了对自由自在生活的向往。全曲意境开阔，语言豪放，体现了元代文人追求精神自由的思想。'],
      ['人月圆·山中书事', '张可久的这首小令描写了隐居山中的生活，通过"松花酿酒，春水煎茶"等描写，展现了恬淡闲适的隐居生活。全曲意境清雅，语言清新，表达了对宁静生活的向往。'],
      ['普天乐·秋怀', '张可久的这首小令抒发了对功名利禄的厌倦和对自由生活的向往，通过"西风驿马，落月书灯"等意象，表现了文人生活的艰辛。全曲情感真挚，语言凝练，具有很强的感染力。'],
      ['寿阳曲·远浦帆归', '马致远的这首小令描绘了黄昏时分渔船归来的景象，通过"酒旆闲"、"两三航"等描写，营造出宁静祥和的氛围。全曲意境优美，语言简洁，给人以美的享受。'],
      ['寿阳曲·潇湘夜雨', '马致远的这首小令描写了夜晚雨声引发的愁思，通过"渔灯暗"、"客梦回"等描写，营造出凄清的氛围。全曲情景交融，语言凝练，表达了游子的思乡之情。'],
      ['四块玉·闲适', '关汉卿的这首小令表达了对闲适生活的向往，通过"旧酒"、"新醅"等描写，展现了无拘无束的生活状态。全曲语言通俗，情感真挚，体现了作者对自由生活的追求。'],
      ['沉醉东风', '关汉卿的这首小令描写了离别之情，通过"饯行杯"、"别离泪"等描写，表现了离别的痛苦。全曲语言通俗，情感真挚，是元曲中描写离情的佳作。'],
      ['山坡羊·骊山怀古', '张养浩的这首散曲通过凭吊骊山古迹，抒发了对历史兴亡的感慨。全曲语言凝练，意境深远，表达了对历史变迁的深沉思考。'],
      ['蟾宫曲·梦中作', '郑光祖的这首小令描写了梦境中的情景，通过"幽梦微茫"、"梨花淡妆"等描写，营造出朦胧的意境。全曲语言优美，意境深远，体现了作者高超的艺术技巧。'],
      ['醉太平·讥贪小利者', '这首无名氏的小令讽刺了贪图小利的行为，通过"夺泥燕口，削铁针头"等夸张的描写，揭示了贪得无厌的本质。全曲语言幽默，讽刺辛辣，具有很强的现实意义。'],
      ['小桃红·寄鉴湖诸友', '张可久的这首小令表达了对友人的思念之情，通过"秋雨豆花凉"、"采莲人语荷花荡"等描写，营造出清雅的意境。全曲语言优美，情感真挚，是元曲中友情题材的佳作。'],
      ['折桂令·春情', '徐再思的这首小令与《蟾宫曲·春情》内容相近，同样描写了相思之苦，通过"浮云"、"飞絮"等意象，表现了相思者的心理状态。'],
      ['天净沙·冬', '白朴的这首小令描绘了冬日黄昏的景色，通过"画角谯门"、"新月黄昏"等意象，营造出萧瑟的氛围。全曲语言凝练，意境深远，给人以美的享受。']
    ]);

    return explanations.get(this.yuanqu.title) || '这首元曲通过生动的意象和优美的语言，展现了作者的情感世界和艺术追求。';
  }

  build() {
    Column() {
      Row() {
        Text('< 返回')
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .onClick(() => {
            router.back();
          })
          .padding({ left: 10 })
        
        Text('元曲详情')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .shadow({ radius: 6, color: $r('app.color.text_tertiary_bank_card_03'), offsetX: 0, offsetY: 2 })

      Scroll() {
        Column() {
          // 元曲标题
          Text(this.yuanqu.title)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
          
          // 作者信息
          Text('作者：' + this.yuanqu.author)
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10 })
          
          // 原文标题
          Text('原文:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
            .textAlign(TextAlign.Start)
          
          // 元曲原文
          Text(this.yuanqu.content)
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
          
          // 拼音注释（如果有）
          if (this.yuanqu.pinyin && this.yuanqu.pinyin !== '') {
            Text('拼音:')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text_primary'))
              .margin({ top: 20 })
              .textAlign(TextAlign.Start)
            
            Text(this.yuanqu.pinyin)
              .fontSize(14)
              .fontColor($r('app.color.text_secondary'))
              .margin({ top: 10, left: 20, right: 20 })
              .textAlign(TextAlign.Start)
          }
          
          // 趣味解析标题
          Text('趣味解析:')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20 })
            .textAlign(TextAlign.Start)
          
          // 趣味解析内容
          Text(this.getYuanquExplanation())
            .fontSize(16)
            .fontColor($r('app.color.text_secondary'))
            .margin({ top: 10, left: 20, right: 20 })
            .textAlign(TextAlign.Start)
        }
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
      
      // 朗读控制按钮
      Row() {
        Button('开始朗读')
          .onClick(() => {
            this.startPlay();
          })
          .visibility(this.isPlaying ? Visibility.Hidden : Visibility.Visible)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(20)
          .height(40)
          .margin({ left: 20, right: 10 })
          .layoutWeight(1)
        
        Button('暂停朗读')
          .onClick(() => {
            TextReader.pause();
            this.isPlaying = false;
          })
          .visibility(this.isPlaying ? Visibility.Visible : Visibility.Hidden)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(20)
          .height(40)
          .margin({ left: 20, right: 10 })
          .layoutWeight(1)
        
        Button('停止朗读')
          .onClick(() => {
            this.stopPlay();
          })
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(20)
          .height(40)
          .margin({ left: 10, right: 20 })
          .layoutWeight(1)
      }
      .width('100%')
      .height(60)
      .backgroundColor($r('app.color.card_background'))
      .shadow({ radius: 6, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}