class Trunk { 
  color c;
  float x;
  float y;
  final float height = 25;
  float speed;
  boolean moveRight;
  boolean moveLeft;


  Trunk(float x, float y, boolean direcao, float velocity) {
    this.x = x;
    this.y = y;
    this.moveRight = direcao;
    this.moveLeft = direcao;
    this.c = color(98, 44, 24);
    this.speed = velocity;
  }

  void display() {
    fill(c);
    rect(x, y - 13, width_log, height, 3);
  }

  void move() {
    if (moveRight) {
      x += speed;
      if (x > width + width_log)
        x = -(size_log * 3);
    } else {
      x -= speed;
      if (x < -(width_log * 2))
        x = width + (size_log * 3);
    }
  }
}
