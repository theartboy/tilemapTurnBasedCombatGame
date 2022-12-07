class Enemy {
  //props
  int x, y, w, h;

  int currentFrame, offsetX, offsetY, totalFrames, row, sx, sy;
  int hold, delay;

  boolean moveLeft, moveUp, moveRight, moveDown;

  int speed, vx, vy;
  
  int health;
  boolean dead;

  //constructor
  Enemy(int[]pos) {
    w = 32;
    h = 32;
    x = pos[1]+w/2;//width/2;
    y = pos[0]+h/2;//height/2;

    currentFrame = 0;
    offsetX = 6 * w;
    offsetY = 4 * h;
    totalFrames = 3;
    row = 0;
    sx = 0;
    sy = 0;

    hold = 0;
    delay = 4;

    moveLeft = false;
    moveUp = false;
    moveRight = false;
    moveDown = false;

    speed = 1;
    vx = 0;
    vy = 0;
    
    health = 300;
    dead = false;
  }
  //methods
  void reset(){
   int[] newPos = createRandomEnemyStart();
   x = newPos[1]+w/2;
   y = newPos[0]+h/2;
   health = 300;
   dead = false;
  }
  void die(){
    dead = true;
  }
  
  void update() {
    ////////chase behavior
    float distanceApart = dist(p.x+p.w/2, p.y+p.h/2, x+w/2, y+h/2);
    //fill(255);
    //text("distance apart:"+distanceApart, 50, 50);
    if (distanceApart < 200) {
      //close largest gap
      if (abs(p.x-x) < abs(p.y-y)) {
        //text("closing vertical gap", 200, 50);
        if (y < p.y) {
          moveUp = false;
          moveDown = true;
        } else {
          moveUp = true;
          moveDown = false;
        }//end y
      } else {
        //text("closing horizontal gap", 200, 50);
        if (x < p.x) {
          moveLeft = false;
          moveRight = true;
        } else {
          moveLeft = true;
          moveRight = false;
        }//end x
      }//end gap closing
    } else {
      //kill all moves
      moveLeft = false;
      moveUp = false;
      moveRight = false;
      moveDown = false;
    }//end distanceApart

    ///////update position
    if (moveLeft && !moveRight) {
      vx = -speed;
      //vy = 0;
      row = 1;
    }
    if (moveRight && !moveLeft) {
      vx = speed;
      //vy = 0;
      row = 2;
    }
    if (!moveLeft && !moveRight) {
      vx = 0;
    }

    if (moveUp && !moveDown) {
      vy = -speed;
      //vx = 0;
      row = 3;
    }
    if (moveDown && !moveUp) {
      vy = speed;
      //vx = 0;
      row = 0;
    }
    if (!moveUp && !moveDown) {
      vy = 0;
    }

    if (!moveLeft && !moveUp && !moveRight && !moveDown) {
      vx = 0;
      vy = 0;
      currentFrame = 1;
    }

    x += vx;
    y += vy;

    ///////animation stuff
    sx = currentFrame * w;
    sy = row * h;
    hold = (hold+1)%delay;
    if (hold == 0) {
      currentFrame = (currentFrame+1)%totalFrames;
    }//end hold
  }//end update
  void display() {
    //fill(121, 255, 254, 80);
    //rect(x, y, w, h);
    //fill(0);
    //rect(x+w/2, y+h/2, 1, 1);
    copy(enemyArt, sx+offsetX, sy+offsetY, w, h, x, y, w, h);
  }
}
