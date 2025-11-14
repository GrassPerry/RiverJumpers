class Player {
  // ... (x, w, h, lives, playerColor remain the same) ...
  PImage p2;
  int x, w, h, lives;
  final int y = 500; // Player is FIXED near the bottom of the screen (e.g., y=500)
  // ... (rest of variables) ...

  Player() {
    x = width / 2;
    // y is FIXED at 500 (or height - laneHeight)
    w = 20;
    h = 20;
    lives = 3;
    p2 = loadImage("FwogOwO.png");
  }

  void moveLane(int direction) {
    if (direction == -1) {
      scrollOffset = SCROLL_STEP; // Initiates the scroll
    }
  }

  // NOTE: The intersect function must be moved to the Lane class!
  // Collision will be: Lane.checkCollision(Player p1);
  void display() {
    image(p2,x,y);
    p2.resize(50,50);
  }
}
