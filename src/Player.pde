class Player {
  float x, y;
  int laneIndex = 0;
  float size = 28;
  int lives = 3;

  Player() {
    laneIndex = 0;
    x = width / 2;
    if (gameLanes.size() > 0) {
      y = gameLanes.get(0).y;
    } else {
      y = height - laneHeight / 2;
    }
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, size, size);
  }

  void moveLane(int dir) {
    laneIndex += dir;

    // chegou no topo (passou da última lane)
    if (laneIndex >= gameLanes.size()) {
      generateNewMap();
      return;
    }

    // não deixar passar abaixo da primeira lane
    if (laneIndex < 0) laneIndex = 0;

    y = gameLanes.get(laneIndex).y;
  }

  void moveLeft() {
    x -= 25;
    if (x < 0) x = 0;
  }

  void moveRight() {
    x += 25;
    if (x > width) x = width;
  }

  void loseLife() {
    lives--;
    respawn();
  }

  void respawn() {
    laneIndex = 0;
    x = width / 2;
    y = gameLanes.get(0).y;
  }
}
