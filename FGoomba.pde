class FGoomba extends FGameObject {

  FGoomba(float x, float y) {
    super();
    objectSettings("goomba", false, x, y, false, L, 0);
    speed = 50;
  }

  void act() {
    animate(goomba);
    collide("wall");
    move();
  }
}
