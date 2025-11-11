Trunk n0_name, y3ah_name;

Trunk[] Logs = new Trunk[30]; 
final float[] RAIA_Y = { 70, 120, 170, 220, 270 };

final float MINIMUM_SPACE = 50; 
final float TRUNK_WIDTH = 35; 
final float MINIMUM_ITEM_SIZE = TRUNK_WIDTH + MINIMUM_SPACE;

final float FIXED_SPEED = 1.5; // New constant for speed

void setup() {

size(640, 480);

float[] nextX = new float[RAIA_Y.length];

boolean[] raiaDirection = new boolean[RAIA_Y.length]; 

for (int j = 0; j < RAIA_Y.length; j++) {

raiaDirection[j] = (j % 2 != 0); 

// Defines the initial X position based on the direction

if (raiaDirection[j]) {

// Moves to the right (starts at the far left, off-screen)

nextX[j] = random(-width * 2, -LARGURA_TRONCO);

} else {

// Moves to the left (starts at the far right, off-screen)

nextX[j] = random(width + LARGURA_TRONCO, width * 3);

}

}

 for (int i = 0; i < Logs.length; i++) {

int indiceRaia = i % RAIA_Y.length;

float yRaia = RAIA_Y[indiceRaia];

float xInicial = nextX[indiceRaia];

boolean direcao = raiaDirection[indiceRaia];

// Creation: Passes the direction and fixed speed

Logs[i] = new Tronco(xInicial, yRaia, direcao, VELOCIDADE_FIXA);

// Updates the next X position to ensure spacing

if (direcao) {

// If it moves to the right, the next item is positioned to the left of the current one

nextX[indiceRaia] -= TAMANHO_MINIMO_ITEM;

if (nextX[indiceRaia] < -width * 2) {

nextX[indiceRaia] = random(-width * 2, -LARGURA_TRONCO);

}

} else {

/ // If it moves to the left, the next item is positioned to the right of the current one

nextX[indiceRaia] += TAMANHO_MINIMO_ITEM; 

if (nextX[indiceRaia] > width * 3) {

nextX[indiceRaia] = random(width + LARGURA_TRONCO, width * 3);

}

}

}
}
void draw() {
  background(0, 0, 100); 

  for (int i = 0; i < Logs.length; i++) {
    Logs[i].move();
    Logs[i].display();
  }
}

// ====================================================================

class Trunk { 
color c;
float x;
float y;
final float HEIGHT = 30; 
float speed;
boolean moveRight;

// --- UPDATED CONSTRUCTOR ---

// Now accepts speed as a parameter
Trunk(float x, float y, boolean direction, float speed) {

this.x = x;

this.y = y;

this.moveRight = direction;

this.c = color(98, 44, 24); 
this.speed = speed; // Uses the fixed speed passed

}
  void display() {
    fill(c);
  rect(x, y, TRUNK_WIDTH, HEIGHT, 3);

}

void move() {

if (moveRight) {

/ Move to the RIGHT
x += speed;

/ Reappears on the far left, off-screen.

if (x > width) {

/ Uses MINIMUM_ITEM_SIZE to calculate the restart point,

/ ensuring there is enough space for 3 trunks + spacing
x = -(MINIMUM_ITEM_SIZE * 3);

}

} else {

/ Move to the LEFT

x -= speed;

/ Reappears on the far right, off-screen.

if (x < -TRUNK_WIDTH) {

/ Restarts on the right side with enough space

x = width + (MINIMUM_ITEM_SIZE * 3);

}

}

}
}
