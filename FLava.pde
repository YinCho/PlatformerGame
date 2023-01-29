class FLava extends FGameObject {

  FLava(float x, float y) {
    super();
    objectSettings("lava", true, x, y, true, R, 0);
  }


  void act() {
    animate(lava);
  }
}
