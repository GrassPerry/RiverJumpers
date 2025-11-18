// =====================================
// RIVER JUMPERS — MAIN FILE
// =====================================


Player p1;
ArrayList<Lane> gameLanes = new ArrayList<Lane>();


boolean play = false;
int laneHeight = 50;
int lanesToGenerate = 12;


final float width_log = 55;
final float MINIMUM_SPACE = 50;
final float size_log = widtah_log + MINIMUM_SPACE;
final float speed_car = 3;  


void setup() {
  size(640, 600);
  p1 = new Player();

  for (int i = 0; i < lanesToGenerate; i++) {
    float yPos = height - (i * laneHeight) - (laneHeight / 2);
    if (i == 0) {
      gameLanes.add(new Lane(yPos, "START"));
    } else {
      String type = (i % 3 == 0) ? "SAFE" : ((i % 2 == 0) ? "ROAD" : "RIVER");
      gameLanes.add(new Lane(yPos, type));
    }
  }
  p1 = new Player();

  play = false;
}

    
 



void draw() {
  background(100, 150, 255);

  if (!play) {
    startScreen();
    return;
  }

  if (p1.lives <= 0) {
    gameOver();
    return;
  }

  for (Lane lane : gameLanes) lane.update();

  for (Lane lane : gameLanes) lane.display();

  p1.display();
}


void keyPressed() {
  if (!play) return;

  if (keyCode == UP) p1.moveLane(-1);
  if (keyCode == DOWN) p1.moveLane(1);
  if (keyCode == LEFT) p1.moveLeft();
  if (keyCode == RIGHT) p1.moveRight();
}


void mousePressed() {
  play = true;
}


void startScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("Click to start!", width/2, height/2);
}


void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("GAME OVER", width/2, height/2);
  textSize(20);
  text("Click to restart", width/2, height/2 + 40);

  noLoop();
}
