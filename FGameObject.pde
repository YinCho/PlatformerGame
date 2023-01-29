class FGameObject extends FBox {

  final int L = -1;
  final int R = 1;
  int speed, lives, frame, direction, invincibilityTimer;

  FGameObject() {
    super(gridSize, gridSize);
  }

  void act() {
    invincibilityFrames();
  }

  boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i<contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
  void objectSettings(String names, boolean truefalse, float x, float y, boolean truefalse2, int d, int f) {
    setName(names);
    setRotatable(truefalse);
    setPosition(x, y);
    setStatic(truefalse2);
    direction = d;
    frame = f;
  }

  void animate(PImage[] images) {
    if (frame >= images.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(images[frame]);
      else if (direction == L) attachImage(reverseImage(images[frame]));
      frame++;
    }
  }

  void collide(String name) {
    if (isTouching(name)) {
      direction*= -1;
      setPosition(getX() + direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else if (invincibility == false) {
        player.lives--;
        invincibility = true;
      }
    }
  }
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void invincibilityFrames() {
    if (invincibility == true) {
      f = f + 1;
    }
    if (f >= invincibilityTimer) {
      f = 0;
      invincibility = false;
    }
  }
}
