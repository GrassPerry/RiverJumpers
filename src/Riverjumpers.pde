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
final float size_log = width_log + MINIMUM_SPACE;
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

void generateNewMap() {
  // animação de rolagem para cima
  for (int offset = 0; offset < height; offset += 20) {
    background(100, 150, 255);

    // mover lanes para cima
    for (Lane lane : gameLanes) {
      lane.y -= 20;
      lane.display();
    }

    p1.y -= 20;
    p1.display();

    delay(10);
  }

  // Limpa e cria novas lanes
  gameLanes.clear();

  for (int i = 0; i < lanesToGenerate; i++) {
    float yPos = height - (i * laneHeight) - (laneHeight / 2);

    if (i == 0) {
      gameLanes.add(new Lane(yPos, "START"));
    } else {
      String[] types = {"SAFE", "ROAD", "RIVER", "DOUBLE_ROAD"};
      String type = types[int(random(3))]; // aleatório
      gameLanes.add(new Lane(yPos, type));
    }
  }

  // reposiciona jogador no início
  p1.laneIndex = 0;
  p1.x = width / 2;
  p1.y = gameLanes.get(0).y;
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

  for (Lane lane : gameLanes) lane.display();

  for (int i = 0; i < p1.lives; i++) {
    drawHeart(20 + i*30, 20);
  }
  p1.display();
}

void drawHeart(float x, float y) {
  fill(255, 0, 0);
  beginShape();
  vertex(x, y+5);
  bezierVertex(x-10, y-10, x-25, y+10, x, y+20);
  bezierVertex(x+25, y+10, x+10, y-10, x, y+5);
  endShape(CLOSE);
}


void keyPressed() {
  if (!play) return;

  if (keyCode == DOWN) p1.moveLane(-1);
  if (keyCode == UP) p1.moveLane(1);
  if (keyCode == LEFT) p1.moveLeft();
  if (keyCode == RIGHT) p1.moveRight();

  if (p1.lives <= 0 && (key == 'r' || key == 'R')) {
    restartGame();
  }
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
  text("Press R do restart", width/2, height/2 + 40);
}
void restartGame() {
  p1.lives = 3;
  gameLanes.clear();
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
  play = true;
}
