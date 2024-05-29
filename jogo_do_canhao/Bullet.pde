class Bullet {
  
  private float angle;
  private float speed = 2;

  float x, y;
  
  Bullet(float x, float y, float angle) {
   this.x = x;
   this.y = y;
   this.angle = angle;
  }
  
   void update() {
      updateX();
      updateY();
      draw();
   }
   
   void draw() {
      fill(1);
      ellipse(x, y, 8, 8);
   }
  
  private void updateX() {
    x += cos(angle) * speed;
  }

  private void updateY() {
    y -= sin(angle) * speed;
  }
  
  boolean missed() {
   return y < 0 || x > width || x < 0; 
  }
  
  boolean collided(float x, float y) {
    float x1 = this.x;
    float y1 = this.y;
    float r1 = 4;
    
    float x2 = x;
    float y2 = y;
    float r2 = 5; 
    
    double distance = dist(x1, y1, x2, y2);
    
    return distance <= r1 + r2;
  }
}
