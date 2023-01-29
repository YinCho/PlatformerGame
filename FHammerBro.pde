class FHammerBro extends FGameObject {
  int speed = 50;
  int counter = 0;
  int threshold = 120;
  FHammerBro(float x, float y) {
    objectSettings("hammer", false, x, y, true, L, 0);
  }

  void act() {
    animate(hammerbro);
    collide("stone");
    hammers();
  }

  void hammers() {

    if (counter >= threshold) {
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(this.getX(), this.getY());
      b.setVelocity(-100, -600);
      b.setAngularVelocity(50);
      b.setSensor(true);
      b.setStatic(false);
      world.add(b);
      b.attachImage(hammer);
      b.setName("hammer");
      counter = 0;
    }

    counter++;
  }
}
