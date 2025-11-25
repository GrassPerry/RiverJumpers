class Lane {
  float y;
  String type;

  ArrayList<Car> cars = new ArrayList<Car>();
  ArrayList<Trunk> trunks = new ArrayList<Trunk>();

  Lane(float y, String type) {
    this.y = y;
    this.type = type;

    if (type.equals("ROAD")) generateCars();
    if (type.equals("RIVER")) generateTrunks();
  }

  void generateCars() {
    boolean dir = random(1) > 0.5;

    for (int i = 0; i < 3; i++) {
      float startX = -200 * i;
      cars.add(new Car(startX, y, dir));
    }
  }

  void generateTrunks() {
    boolean dir = random(1) > 0.5;
    float speed = random(1.5, 2.5);

    for (int i = 0; i < 3; i++) {
      float startX = -size_log * i * 2;
      trunks.add(new Trunk(startX, y, dir, speed));
    }
  }

  void update() {
    if (type.equals("ROAD")) {
      for (Car c : cars) {
        c.move();
        if (abs(p1.y - y) < 10 && abs(p1.x - c.x) < 25)
          p1.loseLife();
      }
    }

    if (type.equals("RIVER")) {
      boolean onLog = false;

      for (Trunk t : trunks) {
        t.move();
      }
      for (Trunk t : trunks) {
        boolean isOnTrunk = (p1.x + p1.size/2 > t.x) && (p1.x - p1.size/2 < t.x + width_log);
        if (abs(p1.y - y) < 10 && isOnTrunk) {
          p1.x += (t.moveRight ? t.speed : -t.speed);
          onLog = true;
          break;
        }
      }

      if (abs(p1.y - y) < 10 && !onLog)
        p1.loseLife();
    }
    p1.x = constrain(p1.x, 0, width);
  }

  void display() {
    if (type.equals("START")) fill(0, 200, 0);
    else if (type.equals("SAFE")) fill(80, 200, 80);
    else if (type.equals("ROAD")) fill(50);
    else if (type.equals("RIVER")) fill(40, 80, 180);

    rect(0, y - laneHeight/2, width, laneHeight);
    if (type.equals("ROAD") || type.equals("DOUBLE_ROAD")) {
      stroke(255, 255, 0);
      strokeWeight(4);

      // Linha tracejada
      for (int i = 0; i < width; i += 40) {
        line(i, y, i + 20, y);
      }

      stroke(0);
      strokeWeight(1.5);
    }

    if (type.equals("ROAD"))
      for (Car c : cars) c.display();

    if (type.equals("RIVER"))
      for (Trunk t : trunks) t.display();
  }
}
