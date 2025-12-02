import router from '@ohos.router';

@Entry
@Component
export struct GomokuPage {
  // 棋盘大小 (19x19)
  private readonly BOARD_SIZE: number = 19;
  
  // 棋盘状态: 0=空, 1=黑子, 2=白子
  @State private board: number[][] = [];
  
  // 当前玩家 (1=黑子玩家, 2=白子玩家)
  @State private currentPlayer: number = 1;
  
  // 游戏状态
  @State private gameOver: boolean = false;
  @State private winner: number = 0; // 0=未结束, 1=黑子胜, 2=白子胜, 3=平局
  @State private gameMessage: string = '黑子先行';
  
  // 棋子颜色
  private readonly BLACK: number = 1;
  private readonly WHITE: number = 2;
  private readonly EMPTY: number = 0;

  aboutToAppear(): void {
    // 初始化棋盘
    this.initializeBoard();
  }

  initializeBoard(): void {
    // 创建19x19的空棋盘
    this.board = new Array(this.BOARD_SIZE);
    for (let i = 0; i < this.BOARD_SIZE; i++) {
      this.board[i] = new Array(this.BOARD_SIZE).fill(this.EMPTY);
    }
    
    // 重置游戏状态
    this.currentPlayer = this.BLACK;
    this.gameOver = false;
    this.winner = 0;
    this.gameMessage = '黑子先行';
  }

  // 处理棋盘点击事件
  handleCellClick(row: number, col: number): void {
    // 如果游戏已结束或该位置已有棋子，则不处理
    if (this.gameOver || this.board[row][col] !== this.EMPTY) {
      return;
    }
    
    // 下子
    this.board[row][col] = this.currentPlayer;
    
    // 检查是否获胜
    if (this.checkWin(row, col)) {
      this.gameOver = true;
      this.winner = this.currentPlayer;
      this.gameMessage = this.currentPlayer === this.BLACK ? '黑子获胜!' : '白子获胜!';
      return;
    }
    
    // 检查是否平局
    if (this.isBoardFull()) {
      this.gameOver = true;
      this.winner = 3; // 平局
      this.gameMessage = '平局!';
      return;
    }
    
    // 切换玩家
    this.currentPlayer = this.currentPlayer === this.BLACK ? this.WHITE : this.BLACK;
    this.gameMessage = this.currentPlayer === this.BLACK ? '轮到黑子' : '轮到白子';
    
    // 如果是白子(机器人)回合，执行机器人下棋
    if (this.currentPlayer === this.WHITE && !this.gameOver) {
      this.robotMove();
    }
  }

  // 机器人下棋逻辑
  robotMove(): void {
    // 简单的AI策略:
    // 1. 检查是否有获胜机会
    // 2. 检查是否需要阻止玩家获胜
    // 3. 选择中心附近的空位
    
    // 延迟一下，模拟思考时间
    setTimeout(() => {
      let moveFound = false;
      
      // 1. 检查机器人是否有获胜机会
      for (let i = 0; i < this.BOARD_SIZE; i++) {
        for (let j = 0; j < this.BOARD_SIZE; j++) {
          if (this.board[i][j] === this.EMPTY) {
            this.board[i][j] = this.WHITE;
            if (this.checkWin(i, j)) {
              // 真的可以获胜，就下这里
              this.handleCellClick(i, j);
              moveFound = true;
              break;
            }
            // 恢复
            this.board[i][j] = this.EMPTY;
          }
        }
        if (moveFound) break;
      }
      
      // 2. 如果没有获胜机会，检查是否需要阻止玩家
      if (!moveFound) {
        for (let i = 0; i < this.BOARD_SIZE; i++) {
          for (let j = 0; j < this.BOARD_SIZE; j++) {
            if (this.board[i][j] === this.EMPTY) {
              this.board[i][j] = this.BLACK;
              if (this.checkWin(i, j)) {
                // 需要阻止玩家，就下这里
                this.board[i][j] = this.EMPTY;
                this.handleCellClick(i, j);
                moveFound = true;
                break;
              }
              // 恢复
              this.board[i][j] = this.EMPTY;
            }
          }
          if (moveFound) break;
        }
      }
      
      // 3. 如果没有紧急情况，选择中心附近的空位
      if (!moveFound) {
        // 寻找离中心最近的空位
        const center = Math.floor(this.BOARD_SIZE / 2);
        let minDistance = this.BOARD_SIZE * 2;
        let targetRow = -1;
        let targetCol = -1;
        
        for (let i = 0; i < this.BOARD_SIZE; i++) {
          for (let j = 0; j < this.BOARD_SIZE; j++) {
            if (this.board[i][j] === this.EMPTY) {
              const distance = Math.abs(i - center) + Math.abs(j - center);
              if (distance < minDistance) {
                minDistance = distance;
                targetRow = i;
                targetCol = j;
              }
            }
          }
        }
        
        if (targetRow !== -1 && targetCol !== -1) {
          this.handleCellClick(targetRow, targetCol);
        }
      }
    }, 500); // 500ms延迟
  }

  // 检查是否获胜
  checkWin(row: number, col: number): boolean {
    const player = this.board[row][col];
    if (player === this.EMPTY) return false;
    
    // 检查四个方向: 水平、垂直、对角线(左上到右下)、反对角线(右上到左下)
    const directions = [
      [0, 1],   // 水平
      [1, 0],   // 垂直
      [1, 1],   // 对角线
      [1, -1]   // 反对角线
    ];
    
    for (let d = 0; d < directions.length; d++) {
      const dx = directions[d][0];
      const dy = directions[d][1];
      let count = 1; // 包括当前棋子
      
      // 正向检查
      for (let i = 1; i < 5; i++) {
        const newRow = row + i * dx;
        const newCol = col + i * dy;
        if (newRow >= 0 && newRow < this.BOARD_SIZE && 
            newCol >= 0 && newCol < this.BOARD_SIZE && 
            this.board[newRow][newCol] === player) {
          count++;
        } else {
          break;
        }
      }
      
      // 反向检查
      for (let i = 1; i < 5; i++) {
        const newRow = row - i * dx;
        const newCol = col - i * dy;
        if (newRow >= 0 && newRow < this.BOARD_SIZE && 
            newCol >= 0 && newCol < this.BOARD_SIZE && 
            this.board[newRow][newCol] === player) {
          count++;
        } else {
          break;
        }
      }
      
      // 如果连成5子，则获胜
      if (count >= 5) {
        return true;
      }
    }
    
    return false;
  }

  // 检查棋盘是否已满
  isBoardFull(): boolean {
    for (let i = 0; i < this.BOARD_SIZE; i++) {
      for (let j = 0; j < this.BOARD_SIZE; j++) {
        if (this.board[i][j] === this.EMPTY) {
          return false;
        }
      }
    }
    return true;
  }

  // 重新开始游戏
  restartGame(): void {
    this.initializeBoard();
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        // 返回按钮
        Button('返回')
          .width(60)
          .height(40)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(8)
          .margin({ left: 10 })
          .onClick(() => {
            router.back();
          })
        
        // 页面标题
        Text('五子棋游戏')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        // 占位元素
        Button('')
          .width(60)
          .height(40)
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
      }
      .width('100%')
      .height(60)
      .backgroundColor($r('app.color.card_background'))
      .alignItems(VerticalAlign.Center)
      
      // 游戏状态显示
      Row() {
        Text(this.gameMessage)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.winner === this.BLACK ? Color.Black : 
                    this.winner === this.WHITE ? Color.White : 
                    $r('app.color.text_primary'))
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        // 重新开始按钮
        Button('重新开始')
          .width(80)
          .height(40)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .backgroundColor($r('app.color.card_background'))
          .borderRadius(8)
          .margin({ right: 10 })
          .onClick(() => {
            this.restartGame();
          })
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.card_background'))
      .alignItems(VerticalAlign.Center)
      
      // 棋盘区域 - 支持水平和垂直滚动
      Scroll() {
        Scroll() {
          Column() {
            // 绘制棋盘行
            ForEach(this.board, (row: number[], rowIndex: number) => {
              Row() {
                // 绘制棋盘列
                ForEach(row, (cell: number, colIndex: number) => {
                  // 每个格子
                  Stack({ alignContent: Alignment.Center }) {
                    // 棋盘格子背景
                    Rect()
                      .width(30)
                      .height(30)
                      .fill(Color.Transparent)
                      .stroke('#8B4513')
                      .strokeWidth(1)
                    
                    // 棋子
                    if (cell !== this.EMPTY) {
                      Circle()
                        .width(26)
                        .height(26)
                        .fill(cell === this.BLACK ? Color.Black : Color.White)
                        .stroke(Color.Black)
                        .strokeWidth(1)
                    }
                  }
                  .width(30)
                  .height(30)
                  .onClick(() => {
                    this.handleCellClick(rowIndex, colIndex);
                  })
                }, (cell: number, colIndex: number) => `${rowIndex}-${colIndex}`)
              }
              .width('auto')
              .height(30)
            }, (row: number[], rowIndex: number) => `row-${rowIndex}`)
          }
          .width('auto')
          .height('auto')
          .padding(20)
          .backgroundColor('#DEB887') // 木质棋盘颜色
          .borderRadius(10)
        }
        .scrollable(ScrollDirection.Horizontal) // 启用水平滚动
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.page_background'))
      
      // 游戏说明
      Column() {
        Text('游戏规则:')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .textAlign(TextAlign.Start)
          .width('90%')
          .margin({ bottom: 5 })
        
        Text('1. 黑子先行，双方轮流下棋')
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Start)
          .width('90%')
          .margin({ bottom: 2 })
        
        Text('2. 率先在横、竖或斜方向连成五子者获胜')
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Start)
          .width('90%')
          .margin({ bottom: 2 })
        
        Text('3. 与机器人对弈，享受智力挑战')
          .fontSize(12)
          .fontColor($r('app.color.text_secondary'))
          .textAlign(TextAlign.Start)
          .width('90%')
      }
      .width('100%')
      .padding({ top: 10, bottom: 20 })
      .backgroundColor($r('app.color.card_background'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}