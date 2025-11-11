Tronco n0_name, y3ah_name;
Tronco[] Logs = new Tronco[30]; 
final float[] RAIA_Y = { 70, 120, 170, 220, 270 };
final float ESPACO_MINIMO = 50; 
final float LARGURA_TRONCO = 35; 
final float TAMANHO_MINIMO_ITEM = LARGURA_TRONCO + ESPACO_MINIMO;
final float VELOCIDADE_FIXA = 1.5; // Nova constante para velocidade

void setup() {
  size(640, 480);

  float[] nextX = new float[RAIA_Y.length];
  boolean[] raiaDirection = new boolean[RAIA_Y.length]; 

  for (int j = 0; j < RAIA_Y.length; j++) {
    raiaDirection[j] = (j % 2 != 0); 
    
    // Define a posição X inicial baseada na direção
    if (raiaDirection[j]) {
      // Se move para a direita (começa na extrema esquerda, fora da tela)
      nextX[j] = random(-width * 2, -LARGURA_TRONCO);
    } else {
      // Se move para a esquerda (começa na extrema direita, fora da tela)
      nextX[j] = random(width + LARGURA_TRONCO, width * 3);
    }
  }

  for (int i = 0; i < Logs.length; i++) {
    int indiceRaia = i % RAIA_Y.length;
    float yRaia = RAIA_Y[indiceRaia];
    float xInicial = nextX[indiceRaia];
    boolean direcao = raiaDirection[indiceRaia];
    
    // Criação: Passa a direção e a velocidade fixa
    Logs[i] = new Tronco(xInicial, yRaia, direcao, VELOCIDADE_FIXA);
    
    // Atualiza a próxima posição X para garantir espaçamento
    if (direcao) {
        // Se move para a direita, o próximo item é posicionado à esquerda do atual
        nextX[indiceRaia] -= TAMANHO_MINIMO_ITEM; 
        if (nextX[indiceRaia] < -width * 2) {
            nextX[indiceRaia] = random(-width * 2, -LARGURA_TRONCO);
        }
    } else {
        // Se move para a esquerda, o próximo item é posicionado à direita do atual
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

class Tronco { 
  color c;
  float x;
  float y;
  final float ALTURA = 30; 
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
    rect(x, y, LARGURA_TRONCO, ALTURA, 3);
  }

  void move() {
    if (moveRight) {
      // Movimento para a DIREITA
      x += speed;
      // Reaparece na extrema esquerda, fora da tela.
      if (x > width) {
        // Usa o TAMANHO_MINIMO_ITEM para calcular o ponto de reinício, 
        // garantindo que haja espaço suficiente para 3 troncos + espaçamento
        x = -(TAMANHO_MINIMO_ITEM * 3); 
      }
    } else {
      // Movimento para a ESQUERDA
      x -= speed;
      // Reaparece na extrema direita, fora da tela.
      if (x < -LARGURA_TRONCO) {
        // Reinicia no lado direito com espaço suficiente
        x = width + (TAMANHO_MINIMO_ITEM * 3); 
      }
    }
  }
}
