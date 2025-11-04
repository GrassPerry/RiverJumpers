Player p1;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean play;


void setup() {
  size(500, 500);
  p1 = new Player();
  play = false;
}

void draw() {
  background(255);
  if (play == false) {
    startScreen();
  } else if (p1.lives<= 0) {
    gameOver();
  } else {
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.display();
      enemy.move();

      if (p1.intersect(enemy)) {
        enemies.remove(i);
        p1.lives -= 1;

        break;
      }

      if (enemy.x > width + 50 || enemy.x < -50) {
        enemies.remove(i);
      }
    }
    if (frameCount %60 ==0) {
      int lane = int(random (3, 7));
      enemies.add(new Enemy());
    }
    p1.display();
    if (mousePressed) {
      if (play == true) {
        if (key == CODED) {
          if (keyCode == UP) {
            p1.moveUp(1);
          } else if (keyCode == DOWN) {
            p1.moveUp(-1);
          }
        }
      }
    }
  }
}
void startScreen() {
  background(0);
  textAlign(CENTER);
  textSize(40);
  text("Click Mouse To Start!!", 250, 400);
}

void gameOver() {
  background(0);
  textAlign(CENTER);
  textSize(33);
  text("Good Try", width/2, 400);
  noLoop();
}

