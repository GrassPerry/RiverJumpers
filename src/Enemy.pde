class Enemy {
  int x, y, diam, speed;
  color enemyColor;

  // Constructor
  Enemy(int laneY) {
    x = 12;
    y = laneY;
    diam = int(random(10, 100));
    speed = int(random(1, 6));
    enemyColor = color(0);
  }
  
  void display() {
    ellipseMode(CENTER);
    fill(enemyColor);
    ellipse(x, y, diam, diam);
  }
  
  void move() {
    x = x + speed;
  }
}
