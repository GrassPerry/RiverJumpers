class Player {
  // ... (x, w, h, lives, playerColor remain the same) ...
  int x, w,h,lives,playerColor;
  final int y = 500; // Player is FIXED near the bottom of the screen (e.g., y=500)
  // ... (rest of variables) ...

  Player() {
    x = width / 2;
    // y is FIXED at 500 (or height - laneHeight)
    w = 20; 
    h = 20; 
    lives = 3;
    playerColor = color(200, 0, 0);
  }

  void moveLane(int direction) {
    // Moving UP (direction = -1) means the player successfully jumped forward
    if (direction == -1) { 
      // This is the core change: trigger the world to scroll down
      scrollOffset = SCROLL_STEP;
    }
    // Lateral movement is not typically used in Frogger/Crossy Road
    // x += (direction * speed); 
  }
  
  // NOTE: The intersect function must be moved to the Lane class!
  // Collision will be: Lane.checkCollision(Player p1);
  void display(){
    rect(x,y,w,h);
  }
}
