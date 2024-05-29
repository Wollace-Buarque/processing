ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

int lastEnemyGeneratedTime = millis();
int lastShotTime = millis();

double HEALTH = 10;
int SCORE = 0;

float myAngle = 0;

boolean ended = false;

void setup() {
  size(640, 500);
}

void draw() {
    background(#D3D3D3); 
    
    if (ended) {
      drawText("O jogo acabou!", width / 2, height / 2, true);
      drawText("Sua pontuação: " + SCORE, width / 2, (height + 40) / 2, true);
      drawText("Aperte em alguma tecla para reiniciar.", width / 2, (height + 75) / 2, true);
      return; 
    }
    
    generateEnemy();
  
   drawEnemy();
   drawBullets();
   
   drawCannon(width / 2, height - 10, myAngle);
   
   drawText("Pontuação: " + SCORE, width - 55, 16, true);
   drawText("Vida: " + HEALTH, 10, 16, false);
}

void keyboardPressed() {
 if (ended) {
    resetGame();
 }
}

void mousePressed() {
  if (ended) {
    resetGame();
    return; 
  }
  
   if (millis() < lastShotTime + 200) {
     return;
  }
  
  float angle = atan2(height - mouseY, mouseX - width / 2); // Calcula o ângulo entre o cano e o mouse
  
  if (angle > 2.45) angle = 2.45;
  if (angle < 0.51) angle = 0.51;
  
  bullets.add(new Bullet(width / 2, height - 20, angle));
  
  lastShotTime = millis();
}

void mouseMoved() {
  float mousePercentage = float(mouseX) / width; // Percentagem da posição do mouse em relação à largura da tela
    
  myAngle = map(mousePercentage, 0, 1, -PI/3, PI/3); 
}

void generateEnemy() {
    if (enemies.size() > 20) return;
  
    if (millis() > lastEnemyGeneratedTime + 650) {
      enemies.add(new Enemy());
      
      lastEnemyGeneratedTime = millis();
  }
}

void drawEnemy() {
   for (int index = 0; index < enemies.size(); index++) {
     Enemy enemy = enemies.get(index);
     enemy.update();
     
     if (enemy.exploded()) {
        enemies.remove(index); 
     
       if (HEALTH - 1 <= 0) {
         ended = true;
         break;
       }
        
        HEALTH -= 1;
     }
   }
}

void drawBullets() {
  for (int index = 0; index < bullets.size(); index++) {
     Bullet bullet = bullets.get(index);
     bullet.update();
     
     if (bullet.missed()) {
        bullets.remove(index);
        continue;
     }
     
     for (int enemyIndex = 0; enemyIndex < enemies.size(); enemyIndex++) {
       Enemy enemy = enemies.get(enemyIndex);
       
       if (bullet.collided(enemy.x, enemy.y)) {
          enemies.remove(enemyIndex);
          bullets.remove(index);
          SCORE++;
       }
     }
   }
}

void drawCannon(float x, float y, float angle) {
  // Desenhar a bazuca
  pushMatrix();
  translate(x, y);
  
  // Desenhar o corpo da bazuca
  fill(100);
  rect(-20, -10, 40, 20);

  // Desenhar o cano
  pushMatrix();
  translate(0, -10); // Posicionamento relativo ao corpo da bazuca
  rotate(angle);
  fill(150);
  rect(-5, -20, 10, 30);
  popMatrix();
  popMatrix();
}

void drawText(String message, float x, float y, boolean calculateWidth) {  
  fill(0); // Cor preta
  textSize(16); // Tamanho da fonte
  
  float messageWidth = textWidth(message);
  
  if (calculateWidth) {
    x -= messageWidth / 2; 
  }
  
  text(message, x, y); 
}

void resetGame() {
  HEALTH = 10; 
  SCORE = 0;
  
  enemies.clear();
  bullets.clear();
  
  ended = false;
}
