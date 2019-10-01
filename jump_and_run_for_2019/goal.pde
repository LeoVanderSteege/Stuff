class goal {
  float x, y, w, h;
  goal(float xp, float yp, float wi, float he) {
    x = xp;
    y = yp;
    w = wi;
    h = he;
  }
  void update() {
    fill(teal);
    stroke(green);
    rect((x-xOffset), (y+yOffset), w, h);
  }
}
