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
