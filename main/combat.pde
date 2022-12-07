void playCombat() {
  background(255, 138, 230);
  noStroke();
  image(largeP, 0, 300);
  image(largeE, 320, 100);

  //UI elements
  fill(82, 211, 227);
  rect(0, 0, width, 70);
  //red health bar
  fill(255, 0, 0);
  rect(0, 70, width, 24);
  fill(105, 0, 255);
  rect(300, 70, 40, 24);

  //player health
  fill(255, 0, 213);
  rect(0, 70, p.health, 24);

  //enemy health
  fill(116, 28, 155);
  int offset = 300 - currentEnemy.health;
  rect(340+offset, 70, currentEnemy.health, 24);

  //button
  fill(62, 26, 149);
  rect(320, 500, 180, 70);
  fill(171, 123, 203);
  rect(330, 510, 160, 50);
  //button text
  fill(255);
  textSize(48);
  text("ATTACK", 410, 545);

  //text
  fill(255);
  textAlign(CENTER);
  textSize(128);
  text("FIGHT", width/2, 64);
}//end playGame

void fight() {
  int playerAtk = floor(random(100));
  int enemyAtk = floor(random(50));
  if (playerAtk >= enemyAtk) {
    currentEnemy.health -= playerAtk;
  } else {
    p.health -= enemyAtk;
  }//end if
  println("player atk:"+playerAtk+"  enemy atk:"+enemyAtk);
  fill(0, 0, 200);
  rect(0, 94, width, height);

  //player success
  if (currentEnemy.health <= 0) {
    currentEnemy.die();
    score++;
    if (score >= enemies.length) {
      gameState = "WIN";
    } else {
      gameState = "GAME";
    }
  }
  //player failure
  if (p.health <= 0){
    gameState = "LOSE";
  }
}//end fight

void mousePressed() {
  if (gameState=="COMBAT"&&mouseX<500&&mouseX>320&&mouseY<570&&mouseY>500) {
    //fill(255,255,0,100);
    //rect(0,0,width,height);
    fight();
  }
}//end mousePressed
