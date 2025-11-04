class Enemy {
  //mv
  int x, y, diam, speed, c1;

  //con
  Enemy() {
    x= 12;
    y= 60;
    diam = int(random(10, 100));
    speed = int(random(1, 6));
    c1= color(0);
  }
  void display() {
    ellipseMode(CENTER);
    ellipse(50, 50, diam, diam);
  }
  void move() {
    y =y+speed;
  }
}

