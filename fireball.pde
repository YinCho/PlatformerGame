class FFireball extends FGameObject {
  int counter;
  int threshold;

  boolean b = true;
  FFireball(float x, float y) {
    objectSettings("thwomp", false, x, y, false, L, 0);
    threshold = 100;
    counter = 0;
    speed = 10;
  }

  void act() {
    seconds = seconds + 2;
    attachImage(fireball);
    counter++;
    if (b) {
      setPosition(this.getX() - speed, this.getY());
    }
    if (counter >= threshold && seconds >= 0 && seconds <= limit) {
      setPosition(940-speed, 740.1002-speed);
      counter = 0;
    }
    if (seconds == 500) {
      speed = 11;
      threshold = 80;
    }
    if (seconds == 1000) {
      threshold = 60;
      speed = 13;
    }
    if (seconds == 1500) {
      threshold = 60;
      speed = 15;
    }
    if (seconds >= limit) {
      setPosition(x, y);
    }
  }
}
