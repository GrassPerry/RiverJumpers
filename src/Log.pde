// Arthur Leite | 18 Sept 2025 | Making Cars

// ===================================
// NOVAS CONSTANTES GLOBAIS PARA RAIAS
// ===================================
Car[] cars = new Car[25];
final float[] RAIA_Y_car = {55, 80, 175, 200 , 400, 500}; // Posições Y das faixas
final float CAR_WIDTH = 35;
final float SPACE_CARS = 45;
final float SIZE_CAR_WITH_SPACE = CAR_WIDTH + SPACE_CARS;
final float speed_car = 3;
final float space_between_groups_cars = 200;

Car n0_name, y3ah_name;
// Mantendo 100 carros, que serão distribuídos pelas 8 raias

Tronco[] Logs = new Tronco[15];
final float[] RAIA_Y_log = {120, 145, 230, 255 , 450, 475};
final float space_logs = 80;
final float width_log = 85;
final float size_log = width_log + space_logs;
final float speed = 5;

void setup() {
  size(640, 600);



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

-------------------------------------

class Car {
  // Member Variable
  color c;
  float x;
  float y;
  float speed;
  boolean r; // Direção: true = direita, false = esquerda

  // ===================================
  // CONSTRUTOR MODIFICADO PARA RECEBER DIREÇÃO
  // ===================================
  Car(float x, float y, boolean direction) {
    c = color(12, random(255), random(255));
    this.x = x;
    this.y = y;
    speed = speed_car;
    this.r = direction; // Define a direção do carro com base na raia
  }

  // Member Methods
  void display() {
    // A lógica 'if (r == true)' e 'else' na função display era idêntica,
    // simplificando o código para apenas uma vez:
    fill(0);
    rect(x+2, y-3, 8, 21); // Roda 1
    rect(x+25, y-3, 8, 21); // Roda 2
    fill(c);
    rect(x, y, 35, 15, 3); // Corpo
    fill(200);
    rect(x+15, y, 12, 15, 3); // Janela
  }


  // ===================================
  // MÉTODO MOVE COM LÓGICA DE REAPARECIMENTO APLICADA
  // ===================================
  void move () {
    if (r == true) { // Move para a direita
      x = x + speed;
      if (x > width + CAR_WIDTH + 10) { // Saiu da tela (largura do carro + margem)
        x = -CAR_WIDTH; // Volta para o lado esquerdo
        y = y; // Mantém-se na mesma raia
      }
    } else { // Move para a esquerda
      x = x - speed;
      if (x < -CAR_WIDTH - 10) { // Saiu da tela
        x = width; // Volta para o lado direito
        y = y; // Mantém-se na mesma raia
      }
    }
  }
}


--------------------------------

class Tronco { 
  color c;
  float x;
  float y;
  final float ALTURA = 15; 
  float speed;
  boolean moveRight;

  // --- CONSTRUTOR ATUALIZADO ---
  // Agora aceita a velocidade como parâmetro
  Tronco(float x, float y, boolean direcao, float velocidade) {
    this.x = x;
    this.y = y;
    this.moveRight = direcao;
    this.c = color(98, 44, 24); 
    this.speed = velocidade; // Usa a velocidade fixa passada
  }

  void display() {
    fill(c);
    rect(x, y, width_log, ALTURA, 3);
  }

  void move() {
    if (moveRight) {
      // Movimento para a DIREITA
      x += speed;
      // Reaparece na extrema esquerda, fora da tela.
      if (x > width) {
        // Usa o TAMANHO_MINIMO_ITEM para calcular o ponto de reinício, 
        // garantindo que haja espaço suficiente para 3 troncos + espaçamento
        x = -(size_log * 3); 
      }
    } else {
      // Movimento para a ESQUERDA
      x -= speed;
      // Reaparece na extrema direita, fora da tela.
      if (x < -width_log) {
        // Reinicia no lado direito com espaço suficiente
        x = width + (size_log * 3); 
      }
    }
  }
}
