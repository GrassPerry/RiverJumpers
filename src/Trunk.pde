class Trunk {
  color c;
  float x;
  float y;
  final float HEIGHT = 30;
  float speed;
  boolean moveRight;

  Trunk[] Logs = new Trunk[15];
  final float[] RAIA_Y_log = {120, 145, 230, 255, 450, 475};
  final float space_logs = 80;
  final float width_log = 85;
  final float size_log = width_log + space_logs;




  Trunk(float x, float y, boolean direction, float speed) {
    this.x = x;
    this.y = y;
    this.moveRight = direction;
    this.c = color(98, 44, 24);
    this.speed = speed;
  }

  void display() {
    fill(c);

    rect(x, y, TRUNK_WIDTH, HEIGHT, 3);
  }

  void move() {
    if (moveRight) {

      x += speed;
      if (x > width + TRUNK_WIDTH) {
        x = -(MINIMUM_ITEM_SIZE * 3);
      }
    } else {
      x -= speed;

      if (x < -TRUNK_WIDTH) {
        x = width + (MINIMUM_ITEM_SIZE * 3);
      }
    }
  }
}
