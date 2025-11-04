class Player {
  //member var
  int x, y, w, h, lives, c1, speed;
  
  //constructor
  Player() {
    x= 250;
    y = 100;
    w= 6;
    h=12;
    lives =3;
    speed =5;
    c1= color(200,0,0);
  }
  
  void moveUp(int y) {
    y = y-speed;
  }
  void display() {
    rectMode(CENTER);
    rect(50,50,x,y);
  }
  boolean intersect(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    if(d<50) {
      return true;
    } else {
      return false;
    }
  }
}
