void playWin() {
  background(62, 26, 149);
  fill(255);
  textAlign(CENTER);
  textSize(128);
  text("Winner", width/2, height/2);

  //button
  fill(250, 91, 184);
  rect(230, 350, 180, 70);
  fill(171, 123, 203);
  rect(240, 360, 160, 50);
  //button text
  fill(255);
  textSize(48);
  text("Again?", 320, 400);
  if (mousePressed&&mouseX>230&&mouseX<410&&mouseY>350&&mouseY<420) {
    reset();
  }
}

void playLose() {
  background(91, 250, 211);
  fill(255);
  textAlign(CENTER);
  textSize(128);
  text("GAME OVER", width/2, height/2);

  //button
  fill(250, 91, 184);
  rect(230, 350, 180, 70);
  fill(171, 123, 203);
  rect(240, 360, 160, 50);
  //button text
  fill(255);
  textSize(48);
  text("Again?", 320, 400);
  if (mousePressed&&mouseX>230&&mouseX<410&&mouseY>350&&mouseY<420) {
    reset();
  }
}

void reset() {
  p.reset();
  score = 0;
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].reset();
  }
  gameState = "GAME";
}
