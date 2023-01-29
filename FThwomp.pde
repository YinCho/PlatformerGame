class FThwomp extends FGameObject {

  boolean down;
  int timer;
  int ymap2;
  FThwomp(float x, float y) {
    objectSettings("thwomp", true, x, y, true, L, 0);
    speed = 10;
  }

  void act() {
    animate(thwomp);
    thwompMove();
  }

  void thwompMove() {

    if (level == true) {
      if (player.getY() > getY()) {
        if (player.getX() > 180 && player.getX() < 200) {
          down = true;
        }
      }
      if (down == true) {
        timer++;
        if (player.getY() > getY()) {
          setPosition(getX(), getY() + 5);
        }
      }
      if (timer > 120) {
        timer = 0;
        down = false;
      }
      if (down == false && getY() > 800) {
        setPosition(getX(), getY() - 5);
      }
    } /////////////////////////////////////////////

    if (level == false) {
      if (player.getX() > getX()-40 && player.getX() < getX()+20 && player.getY() > 252) {
        down = true;
      }
      if (down == true) {
        timer++;
        if (600 > getY()) {
          setPosition(getX(), getY() + 5);
        }
      }
      if (timer > 120) {
        timer = 0;
        down = false;
      }
      if (down == false && getY() > 250) {
        setPosition(getX(), getY() - 5);
      }
      if (seconds >= limit) {
        if (getY() == 602) {
          bowserlives--;
          limit = 3000;
          seconds = 0;
        }
      }
    }
  }
}
