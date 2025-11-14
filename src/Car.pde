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



