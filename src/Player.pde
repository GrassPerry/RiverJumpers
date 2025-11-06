class Player {
  // Member Variables
  int x, y, w, h, lives, speed;
  int currentLane;
  color playerColor;
  
  // Constructor (Starts player at the bottom lane)
  Player() {
    currentLane = 2; // Start at index 2 (Bottom Lane)
    x = 250;
    y = laneY[currentLane];
    w = 12; // Made a little wider
    h = 24; // Made a little taller
    lives = 3;
    speed = 5;
    playerColor = color(200, 0, 0);
  }
  

  void display() {
    rectMode(CENTER);
    fill(playerColor);
    rect(x, y, w, h);
  }
  
  void moveLane(int direction) {

    if (direction == -1 && currentLane > 0) {
      currentLane--; 
    } 
    else if (direction == 1 && currentLane < 2) {
      currentLane++;
    }

    y = laneY[currentLane];
  }
  
  boolean intersect(Enemy e) {
 
    float d = dist(x, y, e.x, e.y);

    if (d < e.diam / 2) {
      return true;
    } else {
      return false;
    }
  }
}
