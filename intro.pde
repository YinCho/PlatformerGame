void intro () {
  textSize(10);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  rectMode(CENTER);

  myGifs[0].show();
  normalmap.show();
  bossmap.show();
  textSize(100);
  fill(stoneblock);
  text("PLATFORMER", 300, 200);


  if (normalmap.clicked) {
    mode = PLAY;
    loadWorld(level1);
    loadPlayer();
    zoom =1;
  } else if (bossmap.clicked) {
    mode = PLAY;
    loadWorld(level2);
    loadPlayer();
  }
}
