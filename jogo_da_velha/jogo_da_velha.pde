char[][] board;
int boardSize = 3;
int cellSize = 100;

char currentPlayer = 'X';
boolean gameOver = false;
String winner = null;

void setup() {
  // boardSize * cellSize
  size(300, 300);
  board = new char[boardSize][boardSize];
  
  for (int x = 0; x < boardSize; x++) {
    for (int y = 0; y < boardSize; y++) {
      board[x][y] = ' ';
    }
  }
}

void draw() {
  background(255);
  
  if (winner != null) {
    fill(0);
    textSize(20);
    
    String text = winner + " venceu o jogo!";
    int centerX = width / 2;
    
    text(text, centerX - textWidth(text) / 2, height / 2);
    return;
  }
  
  if (gameOver) {
     fill(0);
     textSize(20);
     
    String text = "Ninguém venceu o jogo!";
    int centerX = width / 2;
     
     text(text, centerX - textWidth(text) / 2, height / 2);
    return;
  }
  
  drawBoard();
  checkWinner();
}

void drawBoard() {
  strokeWeight(4);
  
  for (int col = 1; col < boardSize; col++) {
    // Linhas verticais
    line(col * cellSize, 0, col * cellSize, height);
    
    // Linhas horizontais
    line(0, col * cellSize, width, col * cellSize);
  }
  
  // Passa por todas as colunas para desenhar os X e os O
  for (int x = 0; x < boardSize; x++) {
    for (int y = 0; y < boardSize; y++) {
      char player = board[x][y];
      
      if (player == 'X') {
        drawX(x, y);
      } else if (player == 'O') {
        drawO(x, y);
      }
      
    }
  }
}

void drawX(int line, int column) {
  float startX = line * cellSize + cellSize / 4;
  float startY = column * cellSize + cellSize / 4;
  
  float width = cellSize / 2;
  
  line(startX, startY, startX + width, startY + width);
  line(startX + width, startY, startX, startY + width);
}

void drawO(int line, int column) {
  float x = line * cellSize + cellSize / 4;
  float y = column * cellSize + cellSize / 4;
  
  float width = cellSize / 2;
  
  ellipseMode(CORNER);
  ellipse(x, y, width, width);
}

void mouseClicked() {
  if (!gameOver) {
    int x = mouseX / cellSize;
    int y = mouseY / cellSize;
    
    if (board[x][y] == ' ') {
      board[x][y] = currentPlayer;
      
      if (currentPlayer == 'X') {
        currentPlayer = 'O';
      } else {
        currentPlayer = 'X';
      }
    }
    
  }
}

void checkWinner() {
  boolean isBoardFull = true;
  
  for (int index = 0; index < boardSize; index++) {
    // Linhas
    char rowValue = board[index][0];
    if (rowValue != ' ' && rowValue == board[index][1] && rowValue == board[index][2]) {
      winner = String.valueOf(rowValue);
      gameOver = true;
      return;
    }
    
    // Colunas
    char colValue = board[0][index];
    if (colValue != ' ' && colValue == board[1][index] && colValue == board[2][index]) {
      winner = String.valueOf(colValue);
      gameOver = true;
      return;
    }
    
    // Verifique se o tabuleiro está cheio
    for (int j = 0; j < boardSize; j++) {
      if (board[index][j] == ' ') {
        isBoardFull = false;
        break;
      }
    }
  }
  
  // Diagonal
  char topLeft = board[0][0];
  char topRight = board[0][boardSize - 1];
  if (topLeft != ' ' && topLeft == board[1][1] && topLeft == board[2][2]) {
    winner = String.valueOf(topLeft);
    gameOver = true;
    return;
  }
  if (topRight != ' ' && topRight == board[1][1] && topRight == board[2][0]) {
    winner = String.valueOf(topRight);
    gameOver = true;
    return;
  }
  
  if (isBoardFull) {
    gameOver = true;
    println("It's a draw!");
  }
}
