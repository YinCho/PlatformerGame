class FPlayer extends FGameObject {
  FPlayer() {
    super();
    objectSettings("player", false, 50, 0, false, R, 0);
    lives = 3;
    invincibilityTimer = 120;
    f = 0;
  }
  void act() {
    animate(action);
    input();
    checkLives();
  }
  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();


    if (isTouching("door")) {
      setup();
    }

    if (abs(vy) < 0.1) {
      action = idle;
    }
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (wkey) {
      if ((isTouching("stone") || isTouching("bridge") || isTouching("ice")) || isTouching("lava") || isTouching("spike") || (isTouching("wall"))) {
        setVelocity(vx, -400);
      }
    }
    if (abs(vy) > 0.1) {
      action = jump;
    }
  }
  void checkLives() {
    invincibilityFrames();
    if (isTouching("spike")  && invincibility == false) livesSubtract();
    if (isTouching("lava")   && invincibility == false) livesSubtract();
    if (isTouching("thwomp") && invincibility == false) livesSubtract();
    if (isTouching("hammer") && invincibility == false) livesSubtract();
    if (isTouching("fireball") && invincibility == false) livesSubtract();


    if (lives == 0) {
      gameover();
    }
  }
  void livesSubtract() {
    lives--;
    invincibility = true;
  }
}
