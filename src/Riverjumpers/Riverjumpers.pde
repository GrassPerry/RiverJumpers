import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// =====================================
// RIVER JUMPERS — MAIN FILE
// =====================================

import ddf.minim.*;

boolean isGameOver = false;
AudioPlayer music;
AudioPlayer gameOverMusic;

Player p1;
ArrayList<Lane> gameLanes = new ArrayList<Lane>();

PImage GS, GO;

boolean play = false;
int laneHeight = 50;
int lanesToGenerate = 12;

int score = 0;
long startTime;
int survivalSeconds = 0;


final float width_log = 55;
final float MINIMUM_SPACE = 50;
final float size_log = width_log + MINIMUM_SPACE;
final float speed_car = 3;

Minim minim;

void setup() {
  size(640, 600);

  startTime = millis();
  textAlign(CENTER, CENTER);
  textSize(32);

  minim = new Minim(this);

  music = minim.loadFile("theme.wav");
  gameOverMusic = minim.loadFile("death.wav");

  music.loop();


  GS = loadImage("GameStart.png");
  GO = loadImage("GameOver.png");
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
  for (int offset = 0; offset < height; offset += 20) {
    background(100, 150, 255);

    for (Lane lane : gameLanes) {
      lane.y -= 20;
      lane.display();
    }

    p1.y -= 20;
    p1.display();

    delay(0);
  }

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

  p1.laneIndex = 0;
  p1.x = width / 2;
  p1.y = gameLanes.get(0).y;
}


void draw() {
  background(100, 150, 255);

long currentTime = millis();
  long elapsedTime = currentTime - startTime;
  survivalSeconds = (int)(elapsedTime / 1000);
  score = survivalSeconds * 5;

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
  
  if (isGameOver) {
      restartGame();
      isGameOver = false;

  }

  if (keyCode == DOWN) {
    p1.moveLane(-1);
    p1.currentFrog = p1.frogD;
  }
  if (keyCode == UP) {
    p1.moveLane(1);
    p1.currentFrog = p1.frog;
  }
  if (keyCode == LEFT) {
    p1.moveLeft();
    p1.currentFrog = p1.frogL;
  }
  if (keyCode == RIGHT) {
    p1.moveRight();
    p1.currentFrog = p1.frogR;
    }
  }


void mousePressed() {
  play = true;
}

//Arthur Leite
void startScreen() {
  background(GS);
  fill(255);
  textAlign(CENTER);
  textSize(40);
}

//Grace Perry
void gameOver() {
  if (music.isPlaying()) music.pause();
  if (!gameOverMusic.isPlaying()) gameOverMusic.play();
    isGameOver = true;
    
  background(GO);
  fill(29,118,16);
  text("Survival Time: " + survivalSeconds + " seconds", width / 2, 150 );
  text("Score: " + score, width / 2, 200);

  noLoop();
}

void restartGame() {
  isGameOver = false;
  play = false;
  p1.lives = 3;
  gameOverMusic.pause();
  gameOverMusic.rewind();
  music.loop();
  generateNewMap();
  p1.x = width / 2;
  p1.laneIndex = 0;
  p1.y = gameLanes.get(0).y;
  loop();
}
