class Trunk {
  color c;
  float x;
  float y;
  final float HEIGHT = 30; // Using the English constant for height (or ALTURA)
  float speed;
  boolean moveRight;

  // Constructor is translated and uses consistent parameter names
  Trunk(float x, float y, boolean direction, float speed) {
    this.x = x;
    this.y = y;
    this.moveRight = direction; // 'direcao' translated to 'direction'
    this.c = color(98, 44, 24);
    this.speed = speed;
  }

  void display() {
    fill(c);
    // FIX: Use the global constant TRUNK_WIDTH for width
    // FIX: Use the class constant HEIGHT or the global TRUNK_HEIGHT if defined
    rect(x, y, TRUNK_WIDTH, HEIGHT, 3);
  }

  void move() {
    if (moveRight) {
      // Move to the RIGHT
      x += speed;

      // Reappears on the far left, off-screen.
      if (x > width + TRUNK_WIDTH) { // Adjusted boundary to include log width
        // FIX: Use the global constant MINIMUM_ITEM_SIZE for spacing
        x = -(MINIMUM_ITEM_SIZE * 3);
      }
    } else {
      // Move to the LEFT
      x -= speed;

      // Reappears on the far right, off-screen.
      if (x < -TRUNK_WIDTH) {
        // FIX: Use the global constant MINIMUM_ITEM_SIZE for spacing
        x = width + (MINIMUM_ITEM_SIZE * 3);
      }
    }
  }
}
