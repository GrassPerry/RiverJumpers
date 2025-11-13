class Enemy {
  int x, y, diam, speed;
  color enemyColor;

  // Constructor
  Enemy() {
    // Start off-screen right and move left (only one direction for simplicity)
    x = width + 50; 
    diam = int(random(20, 70)); // Adjusted size range
    speed = int(random(3, 8)); // Adjusted speed range
    enemyColor = color(0);
  }

  void display() {
    ellipseMode(CENTER);
    fill(enemyColor);
    ellipse(x, y, diam, diam);
  }

  void move() {
    // Move to the left
    x = x - speed; 
  }
}
