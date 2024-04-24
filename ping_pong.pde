int ballX, ballY;
int ballSize = 10;
int ballSpeedX = 3, ballSpeedY = 3;

int playerPaddleX, playerPaddleY;
int playerWidth = 10;
int playerHeight = 40;
int playerSpeedY = 0;

int cpuPaddleX, cpuPaddleY;
int cpuWidth = 10;
int cpuHeight = 100;
int cpuSpeedY = 0;

int scorePlayer;
int scoreCPU;

int speed = 3;
final int SCORE_LIMIT = 4;
boolean ended;

void setup() {
  size(640, 360);
  background(0);
  
  resetGame();
  
  surface.setVisible(true);
  
  textSize(32);
}

void draw() {
 background(0);
 
 drawLines();
 score();
 
 if (!ended) {
   ballMovement();
   cpuPaddle();
   playerPaddle();
 }
 
 checkWinner();
}

void drawLines() {
 int lineWidth = 10;
 int centerX = width / 2;
 int centerY = height / 2;
 
 fill(color(65));
 ellipse(centerX, centerY, 140, 140);
 
 fill(0);
 ellipse(centerX, centerY, 120, 120);
 
 fill(color(65));
 rect(centerX - (5), 0, lineWidth, height);
 
 ellipse(centerX, centerY, 30, 30);
 
 fill(color(255, 255, 255));
 
}

void ballMovement() {
 ballX += ballSpeedX;
 ballY += ballSpeedY;
 
 boolean hasScored = ballX > width || ballX < 0;
 
 if (hasScored) {
  scorePlayer += ballX > width ? 1 : 0;
  scoreCPU += ballX < 0 ? 1 : 0;
   
  ballX = width / 2;
  ballY = height / 2;
  
  ballSpeedX *= Math.random() > 0.5 ? -1 : 1;
 }
 
 if (ballY > height || ballY < 0) {
   
   if (ballY > height) ballY = height - ballSize / 2;
   else ballY = ballSize / 2; 
  
  ballSpeedY *= -1;
 }
 
  boolean hasColidedWithPlayer = (ballY + ballSize / 2 >= playerPaddleY && ballY - ballSize / 2 <= playerPaddleY + playerHeight) && (ballX + ballSize / 2 >= playerPaddleX && ballX - ballSize / 2 <= playerPaddleX + playerWidth);
 
 if (hasColidedWithPlayer) {
  ballSpeedX *= -1;
  ballX = ballSize / 2 + playerPaddleX + playerWidth;
 }
 
 boolean hasColidedWithEnemy = ((ballY + ballSize / 2 >= cpuPaddleY && ballY - ballSize / 2 <= cpuPaddleY + cpuHeight) && (ballX + ballSize / 2 >= cpuPaddleX && ballX - ballSize / 2 <= cpuPaddleX + cpuWidth));
 
 if (hasColidedWithEnemy) {
     ballSpeedX *= -1;
     ballX = cpuPaddleX - ballSize / 2;
 }
 
 noStroke();
 ellipse(ballX, ballY, ballSize, ballSize);
}

void cpuPaddle() {
 cpuPaddleY += cpuSpeedY;
 
 if (ballX > width / 2) {
   if (ballY - ballSize > cpuPaddleY + cpuHeight / 2) {
    cpuSpeedY = speed; 
   } else if (ballY + ballSize < cpuPaddleY + cpuHeight / 2) {
     cpuSpeedY = -speed;
   } else {
     cpuSpeedY = 0;
   }
 } else {
   cpuSpeedY = 0;
 }
 
 if (cpuPaddleY + cpuHeight > height) {
   cpuPaddleY = height - cpuHeight;
 }
 
 if (cpuPaddleY < 0) {
  cpuPaddleY = 0; 
 }
 
 rect(cpuPaddleX, cpuPaddleY, cpuWidth, cpuHeight);
}

void playerPaddle() {
 playerPaddleY += playerSpeedY;
 
 if (playerPaddleY + playerHeight > height) {
    playerPaddleY = height - playerHeight; 
 }
 
 if (playerPaddleY < 0) {
    playerPaddleY = 0; 
 }
 
 rect(playerPaddleX, playerPaddleY, playerWidth, playerHeight);
}

void score() {
  if (scorePlayer > scoreCPU) fill(color(0, 255, 0));
 text(scorePlayer, 160, 50);
 
 if (scoreCPU > scorePlayer) fill(color(0, 255, 0));
 else  fill(color(255, 255, 255));
 text(scoreCPU, 480, 50);
 
 fill(color(255, 255, 255));
 textSize(16);
 textAlign(LEFT, TOP);
 text("FPS: " + Math.round(frameRate), 0, 0);

 textSize(32);
}

void checkWinner() {
  if (scorePlayer > SCORE_LIMIT || scoreCPU > SCORE_LIMIT) {
    ended = true;
  }
  
  if (ended) {
    float opacityPercentage = 256 * 0.6;
    
    fill(0, opacityPercentage);
    rect(0, 0, width, height);
    
    textSize(20);
    fill(200);
    String difficultyMessage = "Dificuldade " + (speed == 3 ? "NORMAL" : speed == 4 ? "MÉDIA" : "DIFÍCIL");
    text(difficultyMessage, width - textWidth(difficultyMessage), 0);
    
    textSize(32);
    fill(color(0, 255, 0));
    String endMessage = "Parabéns, você ganhou!";
    
    if (scoreCPU > scorePlayer) {
      fill(color(255, 0, 0));
      endMessage = "Você perdeu!"; 
    }
    
    textAlign(CENTER, CENTER);
    text(endMessage, width / 2, height / 2); 
    
    textSize(20);
    fill(200);
    text("Aperte ENTER para reiniciar", width / 2, (height / 2) + 35);
    text("Aperte + para aumentar a dificuldade", width / 2, (height / 2) + 70);
    text("Aperte - para diminuir a dificuldade", width / 2, (height / 2) + 105);
    
    textSize(32);
  }
}

void resetGame() {
  ballX = width / 2;
  ballY = height / 2;
  
  playerPaddleX = 10;
  playerPaddleY = height / 2 - 50;
  
  cpuPaddleX = width - 20;
  cpuPaddleY = height / 2 - 50;
  
  scorePlayer = 0;
  scoreCPU = 0;
  ended = false;
}

void keyPressed() {
  // KEYS: 10 = ENTER | 109 = - | 107 = +
  
  if (ended) {
    boolean minusPressed = keyCode == 109;
    boolean plusPressed = keyCode == 107;
    boolean enterPressed = keyCode == 10;
    
    if (minusPressed && speed > 3) {
      ballSpeedY = ballSpeedY < 0 ? -speed : speed;
      ballSpeedX = ballSpeedX < 0 ? -speed : speed;
      speed -= 1;
      return;  
    }
    
    if (plusPressed && speed < 6) {
      ballSpeedY = ballSpeedY < 0 ? -speed : speed;
      ballSpeedX = ballSpeedX < 0 ? -speed : speed;
      speed += 1;
      return;  
    }
    
    if (enterPressed) {
      resetGame();
    }
    
    return;
  }
  
 if (key == 's' || key == 'S') {
  playerSpeedY = 5; 
 }
 
 if (key == 'w' || key == 'W') {
  playerSpeedY = -5; 
 }
}

void keyReleased() {
 if (key == 's' || key == 'S' || key == 'w' || key == 'W') {
   playerSpeedY = 0; 
 }
}
