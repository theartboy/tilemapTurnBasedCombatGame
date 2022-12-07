//tilemap
////1 is wall
////0 is floor
//int [] maprow = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int [][] tilemap = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 1, 0, 0, 1, 0, 1},
  {1, 1, 0, 0, 1, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 0, 1, 1, 0, 1},
  {1, 1, 0, 1, 0, 0, 0, 1, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 1, 1, 1, 0, 1},
  {1, 0, 0, 0, 0, 1, 0, 1, 0, 1},
  {1, 0, 1, 0, 0, 0, 0, 1, 0, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
};
int rows, cols;
int cellWidth, cellHeight;

Player p;
//Enemy e;
Enemy[] enemies;
boolean left, up, right, down;

PImage playerArt, enemyArt;
PImage largeP, largeE;
PFont eightBitFont;

String gameState;
Enemy currentEnemy;
int score;

void setup() {
  size(640, 640);
  //rows = 10;
  //cols = 10;
  rows = tilemap.length;
  cols = tilemap[0].length;
  cellWidth = 64;
  cellHeight = 64;

  p = new Player();
  //e = new Enemy(createRandomEnemyStart());
  enemies = new Enemy[10];
  for (int i = 0; i < enemies.length; i++) {
    enemies[i] = new Enemy(createRandomEnemyStart());
  }

  left = false;
  up = false;
  right = false;
  down = false;

  playerArt = loadImage("data/unicorn.png");
  enemyArt = loadImage("data/characters2x.png");
  largeP = loadImage("data/uniBig.png");
  largeE = loadImage("data/enemyBig.png");

  eightBitFont = createFont("data/8-Bit-Madness.ttf", 64);
  textFont(eightBitFont);

  gameState = "GAME";
  //currentEnemy = enemies[0];/////DELETE LATER
  score = 0;
  noStroke();
}//end setup

void draw() {
  if(gameState=="GAME"){
    playGame();
  }else if (gameState=="COMBAT"){
    playCombat();
  }else if (gameState == "WIN"){
    playWin();
  }else if (gameState == "LOSE"){
    playLose();
  }
}//end draw

int[] createRandomEnemyStart() {
  //random row
  int ty = floor(random(tilemap.length));
  int tx = floor(random(tilemap[0].length));
  //println("ty:"+ty+" tx:"+tx);
  while (tilemap[ty][tx] != 0) {
    ty = floor(random(tilemap.length));
    tx = floor(random(tilemap[0].length));
  }
  //println("rev ty:"+ty+"rev tx:"+tx);

  int[]pixelPosition = {ty*cellHeight, tx*cellWidth};
  return pixelPosition;
}//end function

void checkWallCollisions(Player s) {
  String collisionSide = "none";
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (tilemap[i][j] == 1) {//checking if it is a wall
        //distance on x-axis
        int distX = floor((s.x + s.w/2)-(j*cellWidth+cellWidth/2));
        //distance on y-axis
        int distY = floor((s.y + s.h/2)-(i*cellHeight+cellHeight/2));
        //combined halfs
        int combinedHalfW = floor(s.w/2+cellWidth/2);
        int combinedHalfH = floor(s.h/2+cellHeight/2);
        //check for x overlap
        if (abs(distX) < combinedHalfW) {
          //check for y overlap
          if (abs(distY) < combinedHalfH) {
            //calculate actual overlaps
            int overlapX = combinedHalfW - abs(distX);
            int overlapY = combinedHalfH - abs(distY);
            //look for smallest overlap
            if (overlapX >= overlapY) {
              //correct y position
              if (distY > 0) {
                collisionSide = "TOP";
                s.y += overlapY;
              } else {
                collisionSide = "BOTTOM";
                s.y -= overlapY;
              }//end y corrections
            } else {
              //correct x position
              if (distX > 0) {
                collisionSide = "LEFT";
                s.x += overlapX;
              } else {
                collisionSide = "RIGHT";
                s.x -= overlapX;
              }
            }//end overlap adjustments
            println(collisionSide);
          }//end y overlap
        }//end x overlap
      }//end tilemap
    }//end cols
  }//end rows
}//end function

void checkWallCollisions(Enemy s) {
  String collisionSide = "none";
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (tilemap[i][j] == 1) {//checking if it is a wall
        //distance on x-axis
        int distX = floor((s.x + s.w/2)-(j*cellWidth+cellWidth/2));
        //distance on y-axis
        int distY = floor((s.y + s.h/2)-(i*cellHeight+cellHeight/2));
        //combined halfs
        int combinedHalfW = floor(s.w/2+cellWidth/2);
        int combinedHalfH = floor(s.h/2+cellHeight/2);
        //check for x overlap
        if (abs(distX) < combinedHalfW) {
          //check for y overlap
          if (abs(distY) < combinedHalfH) {
            //calculate actual overlaps
            int overlapX = combinedHalfW - abs(distX);
            int overlapY = combinedHalfH - abs(distY);
            //look for smallest overlap
            if (overlapX >= overlapY) {
              //correct y position
              if (distY > 0) {
                collisionSide = "TOP";
                s.y += overlapY;
              } else {
                collisionSide = "BOTTOM";
                s.y -= overlapY;
              }//end y corrections
            } else {
              //correct x position
              if (distX > 0) {
                collisionSide = "LEFT";
                s.x += overlapX;
              } else {
                collisionSide = "RIGHT";
                s.x -= overlapX;
              }
            }//end overlap adjustments
            println(collisionSide);
          }//end y overlap
        }//end x overlap
      }//end tilemap
    }//end cols
  }//end rows
}//end function

void renderMap() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      switch (tilemap[i][j]) {
      case 0:
        fill(80);
        rect(j*cellWidth, i*cellHeight, cellWidth, cellHeight);
        break;
      case 1:
        fill(114, 188, 128);
        rect(j*cellWidth, i*cellHeight, cellWidth, cellHeight);
        break;
      default:
        println("something is wrong with the map.");
      }//end switch
    }//end for cols
  }//end for rows
}//end renderMap

void keyPressed() {
  //ASCII
  //println(keyCode);
  if (keyCode==37) {
    left = true;
  } else if (keyCode==38) {
    up = true;
  } else if (keyCode==39) {
    right = true;
  } else if (keyCode==40) {
    down=true;
  }
}
void keyReleased() {
  //ASCII
  //println(keyCode);
  if (keyCode==37) {
    left = false;
  } else if (keyCode==38) {
    up = false;
  } else if (keyCode==39) {
    right = false;
  } else if (keyCode==40) {
    down=false;
  }
}

boolean rectangleIntersect(Player s1, Enemy s2) {
  //dist apart on x-axis
  float distanceX = (s1.x + s1.w/2) - (s2.x + s2.w/2);
  //dist apart on y-axis
  float distanceY = (s1.y + s1.h/2) - (s2.y + s2.h/2);
  //combined half-widths
  float combinedHalfW = s1.w/2 + s2.w/2;
  //combined half-heights
  float combinedHalfH = s1.h/2 + s2.h/2;
  //fill(0);
  //String s;
  //s = "distX: "+distanceX +"\n";
  //s += "distY: "+distanceY +"\n";
  //s += "combHalfW: " + combinedHalfW + "\n";
  //s += "combHalfH: " + combinedHalfH;
  //textSize(24);
  //text(s, 50, 50);

  //check for overlap of x-axis
  if (abs(distanceX) < combinedHalfW) {
    //we know they are overlapping on x
    if (abs(distanceY) < combinedHalfH) {
      //they are also overlapping on y
      return true;
    }//end y if
  }//end x if

  return false;
}//end rectangleIntersect
