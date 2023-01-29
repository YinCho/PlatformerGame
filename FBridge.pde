class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super();
    attachImage(bridge);
    objectSettings("bridge", true, x, y, true, L, 0);
  }

  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
    }
  }
}
