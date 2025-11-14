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
  float[] nextX = new float[RAIA_Y_car.length];
  boolean[] raiaDirection = new boolean[RAIA_Y_car.length];

  for (int j = 0; j < RAIA_Y_car.length; j++) {
    raiaDirection[j] = (j % 2 != 0);

    // Define a posição X inicial baseada na direção
    if (raiaDirection[j]) {
      // Se move para a direita (começa na extrema esquerda, fora da tela)
      nextX[j] = random(-width * 2, -width_log);
    } else {
      // Se move para a esquerda (começa na extrema direita, fora da tela)
      nextX[j] = random(width + width_log, width * 3);
    }
  }


  for (int i = 0; i < Logs.length; i++) {
    int indiceRaia = i % RAIA_Y_log.length;
    float yRaia = RAIA_Y_log[indiceRaia];
    float xInicial = nextX[indiceRaia];
    boolean direcao = raiaDirection[indiceRaia];

    // Criação: Passa a direção e a velocidade fixa
    Logs[i] = new Tronco(xInicial, yRaia, direcao, speed);

    // Atualiza a próxima posição X para garantir espaçamento
    if (direcao) {
      // Se move para a direita, o próximo item é posicionado à esquerda do atual
      nextX[indiceRaia] -= size_log;
    } else {
      // Se move para a esquerda, o próximo item é posicionado à direita do atual
      nextX[indiceRaia] += size_log;
    }
  }


  // 1. Inicializa o estado de controle de posição e direção das faixas


  // Define a direção inicial de cada raia e a primeira posição fora da tela
  for (int j = 0; j < RAIA_Y_car.length; j++) {
    // Alterna a direção: Raia 0, 2, 4... (par) move para a esquerda (r=false).
    // Raia 1, 3, 5... (ímpar) move para a direita (r=true).
    raiaDirection[j] = (j % 2 != 0);

    if (raiaDirection[j]) {
      // Direção: Direita (r=true). Começa na extrema esquerda, fora da tela.
      nextX[j] = random(-width * 1.5, -CAR_WIDTH);
    } else {
      // Direção: Esquerda (r=false). Começa na extrema direita, fora da tela.
      nextX[j] = random(width + CAR_WIDTH, width * 2.5);
    }
  }

  // 2. Inicializa o array de carros usando a lógica de faixas
  for (int i = 0; i < cars.length; i++) {
    int indiceRaia = i % RAIA_Y_car.length;
    float yRaia = RAIA_Y_car[indiceRaia];
    float xInicial = nextX[indiceRaia];
    boolean direcaoRaia = raiaDirection[indiceRaia];

    // Criação: Passa a posição X, a posição Y da raia e a direção da raia (direcaoRaia)
    cars[i] = new Car(xInicial, yRaia, direcaoRaia);

    // Atualiza a próxima posição X para garantir espaçamento SEQUENCIAL
    if (direcaoRaia) {
      // Se move para a direita, o próximo carro é posicionado à esquerda do atual
      nextX[indiceRaia] -= SIZE_CAR_WITH_SPACE;
    } else {
      // Se move para a esquerda, o próximo carro é posicionado à direita do atual
      nextX[indiceRaia] += SIZE_CAR_WITH_SPACE;
    }
  }

  // 3. Inicializa os carros individuais (n0_name e y3ah_name) em faixas específicas se desejar,
  // mas aqui vou apenas colocá-los na primeira raia (índice 0) para o exemplo.
  n0_name = new Car (nextX[0] - SIZE_CAR_WITH_SPACE, RAIA_Y_car[0], raiaDirection[0]);
  y3ah_name = new Car (nextX[0] - 2 * SIZE_CAR_WITH_SPACE, RAIA_Y_car[0], raiaDirection[0]);
}

void draw() {
  background(100, 150, 255);

  if (play == false) {
    startScreen();
  } else if (p1.lives <= 0) {
    gameOver();
  } else {
    scrollOffset = 0;
    p1.display();
    if (gameLanes.size() > 0 && gameLanes.get(gameLanes.size() - 1).y > -laneHeight) {
      generateNewLane();
    }
  }
  background(35);

  fill(#3296C8);
  rect(0, 115, 640, 50);

  fill(#3296C8);
  rect(0, 225, 640, 50);

  fill(#3296C8);
  rect(0, 445, 640, 50);

  for (int i = 0; i < Logs.length; i++) {
    Logs[i].move();
    Logs[i].display();
  }


  // Desenho dos carros no array
  for (int i = 0; i < cars.length; i++) {
    cars[i].display();
    cars[i].move();
  }

  // Desenho dos carros individuais
  n0_name.display();
  n0_name.move();
  y3ah_name.display();
  y3ah_name.move();
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
