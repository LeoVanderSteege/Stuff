class boostPad {
  float x, y, w, h;
  boostPad(float xp, float yp, float wi, float he) {
    x = xp; 
    y = yp; 
    w = wi; 
    h = he;
  }
  void update() {
    fill(green);
    stroke(grey);
    //(3);
    rect((x-xOffset), (y+yOffset), w, h);
  }
}

class ball {
  float x, y, r, xs, ys, xd;
  boolean grounded, roofed, moving, kill;
  float[] stopStep;
  boolean end = false;
  block ground;
  ball(float xp, float yp, float ra, boolean k, float s) {
    x = xp;
    y = yp;
    r = ra;
    xs = s;
    xd = -1;
    kill = k;
  }
  float[][] steps = {{x, y}, {x, y}, {x, y}, {x, y}};
  void update() {
    float[] p = {x,y};
    for (int i = 0; i < steps.length; i++) {
      steps[i][0] = x+(xd*(xs/steps.length)*(i+1)*((!grounded) ? 1.6 : 1));
      steps[i][1] = y+((ys/steps.length)*(i+1));
    }
    grounded = false;
    roofed = false;
    moving = false;
    stopStep = null;
    for (block i : blocks) {
      if (i != null) {
        for (float[] o : steps) {
          if (o[0] > i.x && o[0] < i.x+i.w && o[1]+(r/2) > i.y && o[1]+(r/2) < i.y+i.h && (stopStep == null ||stopStep == o)) {
            stopStep = o;
            grounded = true;
            ground = i;
          }
          if (o[0]+(r/2) > i.x && o[0]+(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o)) {
            xd = -1;
          }
          if (o[0]-(r/2) > i.x && o[0]-(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o)) {
            xd = 1;
          }
        }
      }
    }
    for (gate i : gates) {
      if (i != null) {
        for (float[] o : steps) {
          if (o[0] > i.x && o[0] < i.x+i.w && o[1]+(r/2) > i.y && o[1]+(r/2) < i.y+i.h && (stopStep == null ||stopStep == o) && i.state) {
            stopStep = o;
            grounded = true;
            ground = new block(i.x, i.y, i.w, i.h, false, 255);
          }
          if (o[0]+(r/2) > i.x && o[0]+(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o) && i.state) {
            xd = -1;
          }
          if (o[0]-(r/2) > i.x && o[0]-(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o) && i.state) {
            xd = 1;
          }
        }
      }
    }
    for (boostPad i : boosts) {
      if (i != null) {
        for (float[] o : steps) {
          if (o[0] > i.x && o[0] < i.x+i.w && o[1]+(r/2) > i.y && o[1]+(r/2) < i.y+i.h && (stopStep == null ||stopStep == o)) {
            stopStep = o;
            grounded = true;
            ground = new block(i.x, i.y, i.w, i.h, false, 255);
            ys = -50;
          }
          if (o[0]+(r/2) > i.x && o[0]+(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o)) {
            xd = -1;
          }
          if (o[0]-(r/2) > i.x && o[0]-(r/2) < i.x+i.w && o[1] > i.y && o[1]< i.y+i.h && (stopStep == null ||stopStep == o)) {
            xd = 1;
          }
        }
      }
    }
    for (colorSwitch i : switches) {
      for (float[] o : steps) {
        if (i != null) {
          if (o[0] > i.x && o[0] < i.x+100 && o[1] > i.y && o[1] < i.y+100) {
            i.toggle(true);
          }
        }
      }
    }
    if (stopStep == null) {
      stopStep = steps[steps.length-1];
    }
    if (!grounded) {
      x = steps[steps.length-1][0];
      y = steps[steps.length-1][1];
      ys += 1.5;
    }
    if (roofed) {
      y = ground.y+ground.h+1;
    }
    if (grounded) {
      ys = 0;
      x = steps[steps.length-1][0];
      y = ground.y-30;
    }
    if (kill) {
      fill(red);
      stroke(maroon);
    } else {
      fill(cyan);
      stroke(blue);
    }
    ellipse((x-xOffset), (y+yOffset), r, r);
  }
}
