class Trunk { 

  PImage trunkIm;

  float x;

  float y;

  final float height = 25;

  float speed;

  boolean moveRight;

  boolean moveLeft;





  Trunk(float x, float y, boolean direcao, float velocity) {

    this.x = x;

    this.y = y;

    this.moveRight = direcao;

    this.moveLeft = direcao;

    trunkIm = loadImage("trunk.png");

    this.speed = velocity;

  }



  void display() {

    image(trunkIm, x, y+6, width_log, 70);

  }



  void move() {

    if (moveRight) {

      x += speed;

      if (x > width + width_log)

        x = -(size_log * 3);

    } else {

      x -= speed;

      if (x < -(width_log * 2))

        x = width + (size_log * 3);

    }

  }

}
