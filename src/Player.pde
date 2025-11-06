class Player {
  //member var
  int x, y, w, h, lives, c1, speed;
  int currentLane;
  //constructor
  Player() {
    currentLane =1;
    x= 250;
    y = laneY[currentLane];
    w= 6;
    h=12;
    lives =3;
    speed =5;
    c1= color(200,0,0);
  }
  
  void display() {
    rectMode(CENTER);
    rect(x,y,w,h);
  }
  
  void moveLane(int direction) {
    if(direction == 1&& currentLane >0) {
      currentLane--;
    } else if(direction ==-1&&currentLane<2) {
      currentLane++;
    }
    
    y = laneY[currentLane];
  }
  
  boolean intersect(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    if(d<e.diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
