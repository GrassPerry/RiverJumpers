class Enemy {
  //mv
  int x, y, diam, speed, c1;

  //con
  Enemy(int laneY) {
    x= 12;
    y= laneY;
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
