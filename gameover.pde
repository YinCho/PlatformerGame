void gameover() {

  background(stoneblock);
  textSize(120);
  stroke(stoneblock);
  fill(white);
  if (bowserlives == 0) text("YOU WIN", width/2, height/2-100);

  else if (bowserlives > 0)  text("GAMEOVER", width/2, height/2-100);

  Restart.show();

  if (Restart.clicked) {
    setup();
    bowserlives = 3;
    seconds = 0;
    player.lives = 3;
  }
}
