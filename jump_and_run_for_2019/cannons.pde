class cannon {
  float x, y;
  float[][] pellets = new float[20][3];
  int sf, ls;
  cannon(float xp, float yp) {
    x = xp; y = yp; sf = -1; ls = 0;
  }
  void shoot() {
    for (float[] i : pellets) {
      if (i == null) {
        float z = (x+50)-p1.x;
        if (z < 0) {
          float[] o = {x-10, y+20, -1};
          i = o;
        }
        if (z < 0) {
          float[] o = {x+110, y+20, 1};
          i = o;
        }
      }
    }
  }
  void update() {
    if (sf == -1) {
      sf = frameCount;
    }
    if (frameCount - sf > 90) {
      if (frameCount - ls > 120 || ls == 0) {
        ls = frameCount;
        shoot();
      }
    }
    for (float[] z : pellets) {
      if (z != null) {
        z[0] += z[2]*20;
        ellipse(z[0]-xOffset, z[1]+yOffset, 20, 20);
      }
    }
    fill(red);
    stroke(maroon);
    beginShape();
    vertex(x-xOffset,y+yOffset);
    vertex(x-xOffset,y+40+yOffset);
    vertex(x+20-xOffset,y+40+yOffset);
    vertex(x-xOffset, y+100+yOffset);
    vertex(x+100-xOffset, y+100+yOffset);
    vertex(x+80-xOffset, y+40+yOffset);
    vertex(x+100-xOffset, y+40+yOffset);
    vertex(x+100-xOffset, y+yOffset);
    endShape(CLOSE);
  }
}
