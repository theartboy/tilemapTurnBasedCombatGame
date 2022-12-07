class Player {
  //props
  int x, y, w, h;
  int vx, vy;
  
  int currentFrame, offsetX, offsetY, totalFrames, row, sx, sy;
  int hold, delay;
  
  int health;

  //constructor
  Player() {
    x = width/2;
    y = height/2;
    w = 32;
    h = 32;
    
    currentFrame = 0;
    offsetX = 0 * w;
    offsetY = 0 * h;
    totalFrames = 4;
    row = 0;
    sx = 0;
    sy = 0;
    
    hold = 0;
    delay = 4;
    
    health = 300;
  }
  //methods
  void reset(){
    x = width/2;
    y = height/2;
    health = 300;    
  }
  void update() {
    if (left && !right) {
      vx = -2;
      row = 1;
    }
    if (right && !left) {
      vx = 2;
      row = 0;
    }
    if (!left && !right) {
      vx = 0;
    }
    if (up && !down) {
      vy = -2;
      row = 2;
    }
    if (down && !up) {
      vy = 2;
      row = 3;
    }
    if (!up && !down) {
      vy = 0;
    }
    
    if(!left&&!up&&!right&&!down){
     currentFrame = 0;
     vx = 0;
     vy = 0;
    }
    
    x += vx;
    y += vy;
    
    //animate stuff
    sx = currentFrame * w;
    sy = row * h;
    
    hold = (hold+1)%delay;
    if(hold == 0){
      currentFrame = (currentFrame+1)%totalFrames;
    }
    //currentFrame++;
    //if(currentFrame == totalFrames){
    // currentFrame = 0; 
    //}
  }
  void display() {
    //fill(237, 121, 255, 100);
    //rect(x, y, w, h);
    //fill(0);
    //rect(x+w/2, y+h/2, 1, 1);
    copy( playerArt, 
          sx+offsetX, sy+offsetY, w, h, 
          x, y, w, h);
    
  }
}
