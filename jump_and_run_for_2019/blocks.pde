class block {
  float x, y, w, h, r;
  boolean kill;
  boolean ground = false;
  block(float xp, float yp, float wi, float he, boolean k, float rc) {
    x = xp; y = yp; w = wi; h = he; r = rc;
    kill = k;
  }
  void update() {
    fill(r, 255, 200);
    stroke(r, 255, 200);
    if (kill) {
      fill(red);
      stroke(red);
    }
    rect((x-xOffset), (y+yOffset), w, h);
  }
}
