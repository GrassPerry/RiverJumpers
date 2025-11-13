Player p1;
ArrayList<Lane> gameLanes = new ArrayList<Lane>();
boolean play;
int laneHeight = 50;
int lanesToGenerate = 15;

float scrollOffset = 0;
final float SCROLL_STEP = laneHeight;
final float MINIMUM_SPACE = 50;
final float TRUNK_WIDTH = 35;
final float MINIMUM_ITEM_SIZE = TRUNK_WIDTH + MINIMUM_SPACE;
final float FIXED_SPEED = 1.5;

void setup() {
  size(640, 600);
  p1 = new Player();
  play = false;

  for (int i = 0; i < lanesToGenerate; i++) {
    float yPos = height - (i * laneHeight) - (laneHeight / 2);

    if (i == 0) {
      gameLanes.add(new Lane(yPos, "START"));
    } else {
      String type = (i % 3 == 0) ? "SAFE" : ((i % 2 == 0) ? "ROAD" : "RIVER");
      gameLanes.add(new Lane(yPos, type));
    }
  }
}

void draw() {
  background(100, 150, 255);

  if (play == false) {
    startScreen();
  } else if (p1.lives <= 0) {
    gameOver();
  } else {
    for (int i = gameLanes.size() - 1; i >= 0; i--) {
      Lane lane = gameLanes.get(i);

      lane.y += scrollOffset;

      lane.display();
      lane.moveObstacles();

      if (lane.checkCollision(p1)) {
        p1.lives -= 1;
        scrollOffset = 0; 
        break;
      }
      if (lane.y > height + laneHeight / 2) {
        gameLanes.remove(i);
      }
    }
    scrollOffset = 0;
    p1.display();
    if (gameLanes.size() > 0 && gameLanes.get(gameLanes.size() - 1).y > -laneHeight) {
      generateNewLane();
    }
  }
}

void generateNewLane() {
  float topY = gameLanes.get(gameLanes.size() - 1).y - laneHeight;
  String type = (gameLanes.size() % 2 == 0) ? "ROAD" : "RIVER";
  gameLanes.add(new Lane(topY, type));
}

void mousePressed() {
  if (play == false) {
    play = true;
    loop();
  }
}

void keyPressed() {
  if (play == true) {
    if (keyCode == UP) {
      p1.moveLane(-1);
    }
  }
}
void startScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("Click Mouse To Start!!", 250, 400);
}

void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(33);
  text("Good Try", width / 2, 400);
  textSize(20);
  text("Score: " + (frameCount - 1), width / 2, 450); // Simple score
  noLoop();
}
