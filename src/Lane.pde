class Lane {
  float y;
  String type;
  ArrayList<Object> obstacles = new ArrayList<Object>(); // Can hold Enemy or Trunk objects
  boolean moveRight;

  Lane(float startY, String laneType) {
    this.y = startY;
    this.type = laneType;

    // Determine the direction for logs/cars in this lane
    moveRight = (int(random(2)) == 0);

    if (type.equals("ROAD")) {
      // Generate cars (Enemies)
      generateObstacles(5, 50, 150, true); // 5 cars, speed 5 to 15, size 50 to 150
    } else if (type.equals("RIVER")) {
      // Generate logs (Trunks)
      generateObstacles(7, FIXED_SPEED, TRUNK_WIDTH, false); // 7 logs, fixed speed, fixed width
    }

  }

  void generateObstacles(int count, float minSpeed, float maxSize, boolean isEnemy) {
    if (isEnemy) {

    } else {

      float totalSpacing = MINIMUM_ITEM_SIZE * count;

      // Determine the starting position based on movement direction
      float currentX;
      if (moveRight) {
        // Start logs off-screen left
        currentX = -totalSpacing;
      } else {
        // Start logs off-screen right
        currentX = width + totalSpacing;
      }

      // Generate the specified number of logs
      for (int i = 0; i < count; i++) {
        // Create a new Trunk object at the calculated X position and the lane's Y position
        Trunk log = new Trunk(currentX, this.y, moveRight, FIXED_SPEED);
        obstacles.add(log);

        // Update the next starting X position for the next log
        if (moveRight) {
          currentX += MINIMUM_ITEM_SIZE;
        } else {
          currentX -= MINIMUM_ITEM_SIZE;
        }
      }
    }
  }

  void display() {
    if (type.equals("ROAD")) fill(100);
    else if (type.equals("RIVER")) fill(0, 0, 150);
    else fill(0, 150, 0); // Grass/Start

    rectMode(CENTER);
    rect(width / 2, y, width, laneHeight);ßß
  }

  class Trunk {
    color c;
    float x;
    float y;
    final float HEIGHT = 30;
    float speed;
    boolean moveRight;


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
}
