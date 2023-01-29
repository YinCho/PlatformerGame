class FBowser extends FGameObject {
  int i = 120;
  int counter = 0;
  int threshold = 120;
  boolean bulletMove;
  int place = -1000;
  float fireY;
  int lives = 3;
  FBowser(float x, float y) {
    super();
    attachImage(bowser);
    objectSettings("bowser", false, x + 850, y+550, true, L, 0);
    counter = 0;
    threshold = i;
  }

  void act() {
    if (bowserlives == 0) {
      mode = GAMEOVER;
    }
    counter++;
  }
}
