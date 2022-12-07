void playGame() {
  noStroke();
  background(120);
  renderMap();
  fill(255);
  textSize(36);
  textAlign(LEFT);
  text("Score: "+score, 32, 50);

  p.update();
  checkWallCollisions(p);
  //e.update();
  p.display();
  //e.display();
  for (int i = 0; i < enemies.length; i++) {
    if (enemies[i].dead == false) {
      enemies[i].update();
      checkWallCollisions(enemies[i]);
      enemies[i].display();
      if (rectangleIntersect(p, enemies[i]) == true) {
        fill(255, 255, 0, 70);
        rect(0, 0, width, height);
        currentEnemy = enemies[i];
        gameState = "COMBAT";
      }//end intersect
    }//not dead
  }//end for
}
