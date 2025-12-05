class Car {
  color c;
  float x;
  float y;
  float speed;
  boolean r;  

  Car(float x, float y, boolean direction) {
    c = color(random(255), random(255), random(255));
    this.x = x;
    this.y = y;
    speed = speed_car;
    r = direction;
  }

  void display() {
    fill(0);
    rect(x+2, y-3, 8, 21); 
    rect(x+25, y-3, 8, 21); 
    
    fill(c);
    rect(x, y, 35, 15, 3); 
    
    fill(200);
    rect(x+15, y, 12, 15, 3);
  }

  void move() {
    if (r) { 
      x += speed;
      if (x > width + 60)
        x = -120;
    } else { 
      x -= speed;
      if (x < -60)
        x = width + 120;
    }
  }
}
