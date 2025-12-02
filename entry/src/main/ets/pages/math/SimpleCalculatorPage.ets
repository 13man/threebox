import router from '@ohos.router';

@Component
struct CalculatorButton {
  @Prop text: string = '';
  @Prop backgroundColors: ResourceColor = $r('app.color.card_background');
  @Prop fontSize: number = 24;
  onBtnClick: (() => void) | undefined;

  build() {
    Button(this.text)
      .width('80vp')
      .height('80vp')
      .fontSize(this.fontSize)
      .fontColor($r('app.color.text_primary'))
      .backgroundColor(this.backgroundColors)
      .borderRadius('40vp')
      .margin(5)
      .onClick(() => {
        if (this.onBtnClick) {
          this.onBtnClick();
        }
      })
  }
};

@Entry
@Component
struct SimpleCalculatorPage {
  @State displayText: string = '0';
  private firstOperand: number = 0;
  private operator: string = '';
  private waitForOperand: boolean = false;

  private inputDigit(digit: string): void {
    console.log('inputDigit called with digit:', digit, ', current displayText:', this.displayText, ', waitForOperand:', this.waitForOperand);
    if (this.waitForOperand) {
      this.displayText = digit;
      this.waitForOperand = false;
    } else {
      // 如果显示屏以运算符结尾，则添加数字
      if (['+', '-', '×', '÷'].some(op => this.displayText.trim().endsWith(op))) {
        this.displayText += ' ' + digit;
      } else {
        this.displayText = this.displayText === '0' ? digit : this.displayText + digit;
      }
    }
    console.log('inputDigit finished: displayText=', this.displayText, ', waitForOperand=', this.waitForOperand);
  }

  private inputOperator(nextOperator: string): void {
    console.log('inputOperator called with operator:', nextOperator, ', current displayText:', this.displayText, ', firstOperand:', this.firstOperand, ', operator:', this.operator);
    
    // 保存当前的数字
    const inputValue = parseFloat(this.displayText);
    
    if (this.firstOperand === 0) {
      this.firstOperand = inputValue;
    } else if (this.operator) {
      const result = this.performCalculation();
      this.firstOperand = result;
      this.displayText = String(result);
    }
    
    // 显示运算符在显示屏上
    this.displayText += ' ' + nextOperator + ' ';
    
    this.waitForOperand = true;
    this.operator = nextOperator;
    console.log('inputOperator finished: firstOperand=', this.firstOperand, ', displayText=', this.displayText, ', operator=', this.operator, ', waitForOperand=', this.waitForOperand);
  }

  private performCalculation(): number {
    console.log('performCalculation called: firstOperand=', this.firstOperand, ', displayText=', this.displayText, ', operator=', this.operator);
    // 从显示屏文本中提取第二个操作数
    const parts = this.displayText.split(' ');
    const secondOperandStr = parts[parts.length - 1];
    const secondOperand = secondOperandStr ? parseFloat(secondOperandStr) : 0;
    
    let result = 0;
    switch (this.operator) {
      case '+':
        result = this.firstOperand + secondOperand;
        break;
      case '-':
        result = this.firstOperand - secondOperand;
        break;
      case '×':
        result = this.firstOperand * secondOperand;
        break;
      case '÷':
        result = secondOperand !== 0 ? this.firstOperand / secondOperand : 0;
        break;
      default:
        result = secondOperand;
    }
    console.log('performCalculation result:', result);
    return result;
  }

  private handleEquals(): void {
    console.log('handleEquals called: operator=', this.operator, ', displayText=', this.displayText, ', firstOperand=', this.firstOperand);
    if (this.operator) {
      const result = this.performCalculation();
      this.displayText = String(result);
      this.firstOperand = 0; // 重置第一个操作数
      this.operator = '';
      this.waitForOperand = false; // 重置等待操作数标志
    }
    console.log('handleEquals finished: displayText=', this.displayText, ', firstOperand=', this.firstOperand, ', operator=', this.operator, ', waitForOperand=', this.waitForOperand);
  }

  private clearAll(): void {
    console.log('clearAll called');
    this.displayText = '0';
    this.firstOperand = 0;
    this.operator = '';
    this.waitForOperand = false;
    console.log('clearAll finished: displayText=', this.displayText, ', firstOperand=', this.firstOperand, ', operator=', this.operator, ', waitForOperand=', this.waitForOperand);
  }

  build() {
    Column({ space: 10 }) {
      // 标题
      Text('加减乘除简易好玩计算器')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
        .margin({ top: 20 })

      // 显示屏
      Row() {
        Text(this.displayText)
          .fontSize(36)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.End)
          .margin({ left: 20, right: 20 })
      }
      .width('90%')
      .height('80vp')
      .backgroundColor($r('app.color.card_background'))
      .borderRadius('10vp')
      .shadow({ radius: 5, color: $r('app.color.text_tertiary'), offsetX: 0, offsetY: 2 })

      // 计算器按钮区
      Column({ space: 10 }) {
        // 第一行
        Row({ space: 10 }) {
          CalculatorButton({
            text: 'C',
            backgroundColors: '#ff9999',
            onBtnClick: () => {
              this.clearAll();
            }
          })
          CalculatorButton({
            text: '÷',
            backgroundColors: '#ffcc99',
            onBtnClick: () => {
              this.inputOperator('÷');
            }
          })
          CalculatorButton({
            text: '×',
            backgroundColors: '#ffcc99',
            onBtnClick: () => {
              this.inputOperator('×');
            }
          })
          CalculatorButton({
            text: '←',
            backgroundColors: '#ff9999',
            onBtnClick: () => {
              console.log('Backspace clicked, current displayText:', this.displayText);
              if (this.displayText.length > 1) {
                // 检查是否以 " 运算符 "结尾
                const trimmed = this.displayText.trim();
                if (trimmed.endsWith('+') || trimmed.endsWith('-') || trimmed.endsWith('×') || trimmed.endsWith('÷')) {
                  // 如果以运算符结尾，删除整个运算符和空格
                  this.displayText = this.displayText.slice(0, this.displayText.trim().lastIndexOf(' '));
                } else {
                  // 否则只删除最后一个字符
                  this.displayText = this.displayText.slice(0, -1);
                }
              } else {
                this.displayText = '0';
              }
              console.log('Backspace finished, displayText:', this.displayText);
            }
          })
        }

        // 第二行
        Row({ space: 10 }) {
          CalculatorButton({
            text: '7',
            onBtnClick: () => {
              this.inputDigit('7');
            }
          })
          CalculatorButton({
            text: '8',
            onBtnClick: () => {
              this.inputDigit('8');
            }
          })
          CalculatorButton({
            text: '9',
            onBtnClick: () => {
              this.inputDigit('9');
            }
          })
          CalculatorButton({
            text: '-',
            backgroundColors: '#ffcc99',
            onBtnClick: () => {
              this.inputOperator('-');
            }
          })
        }

        // 第三行
        Row({ space: 10 }) {
          CalculatorButton({
            text: '4',
            onBtnClick: () => {
              this.inputDigit('4');
            }
          })
          CalculatorButton({
            text: '5',
            onBtnClick: () => {
              this.inputDigit('5');
            }
          })
          CalculatorButton({
            text: '6',
            onBtnClick: () => {
              this.inputDigit('6');
            }
          })
          CalculatorButton({
            text: '+',
            backgroundColors: '#ffcc99',
            onBtnClick: () => {
              this.inputOperator('+');
            }
          })
        }

        // 第四行
        Row({ space: 10 }) {
          CalculatorButton({
            text: '1',
            onBtnClick: () => {
              this.inputDigit('1');
            }
          })
          CalculatorButton({
            text: '2',
            onBtnClick: () => {
              this.inputDigit('2');
            }
          })
          CalculatorButton({
            text: '3',
            onBtnClick: () => {
              this.inputDigit('3');
            }
          })
          CalculatorButton({
            text: '=',
            backgroundColors: '#99ccff',
            fontSize: 32,
            onBtnClick: () => {
              this.handleEquals();
            }
          })
        }

        // 第五行
        Row({ space: 10 }) {
          CalculatorButton({
            text: '0',
            onBtnClick: () => {
              this.inputDigit('0');
            }
          })
          CalculatorButton({
            text: '.',
            onBtnClick: () => {
              if (this.displayText.indexOf('.') === -1) {
                this.displayText += '.';
              }
            }
          })
        }
      }
      .margin({ top: 20 })

      // 返回按钮
      Row() {
        Button('返回')
          .width('80%')
          .height('50vp')
          .backgroundColor($r('app.color.card_background'))
          .fontColor($r('app.color.text_primary'))
          .borderRadius('25vp')
          .margin({ top: 20, bottom: 20 })
          .onClick(() => {
            try {
              router.back();
            } catch (e) {
              console.error('Navigation failed:', e);
            }
          })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
};