class Enemy {
  
  final color[] colors = {
        #FF5733, // Vermelho
        #33FF57, // Verde
        #3357FF, // Azul
        #FF33B8, // Rosa
        #FFD133, // Amarelo
        #3366FF, // Azul claro
        #33FFD1, // Turquesa
        #FF33E9  // Magenta
      };

  
  private int direction = random(0, 1.00) > 0.5 ? 1 : -1;
  private color enemyColor;
  float x, y;
  
  Enemy() {
   x = random(0, width);
   y = random(-1, 10);
   
   enemyColor = colors[int(random(colors.length))];
  }
  
   void update() {
      updateX();
      updateY();
      draw();
   }
   
   void draw() {
      fill(enemyColor);
      ellipse(x, y, 10, 10);
   }
  
  private void updateX() {
    if (direction == 1) {
      double incrementedX = x + 0.5;
      
        if (incrementedX > width) {
           direction = direction < 1 ? 1 : -1;
        }
      
        x += 0.5;
     } else {
      double decrementedX = x - 0.5;
      
        if (decrementedX < 0) {
           direction = direction < 1 ? 1 : -1;
        }
       
       x -= 0.5; 
     }
  }

  private void updateY() {
    y += 0.45;
  }
  
  boolean exploded() {
   return y >= height; 
  }
}
