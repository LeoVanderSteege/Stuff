class colorSwitch {
  float x, y;
  boolean state, ostate;
  color sc;
  int la = 0;
  colorSwitch(float xp, float yp, boolean s, color c) {
    x = xp; 
    y = yp;
    state = s;
    ostate = s;
    sc = c;
  }
  void toggle(boolean ba) {
    if ((ba && frameCount - la > 20) || !ba) {
      state =  !state;
      la = frameCount;
    }
  }
  void update() {
    fill(sc);
    stroke(sc);
    //(3);
    rect(x-xOffset, y+yOffset+100-20, 100, 20);
    if (!state) {
      fill(black);
    }
    ellipse(x-xOffset+50, y+yOffset+20, 40, 40);
  }
}

class trigger {
  float x, y, w, h;
  boolean state, ostate;
  color sc;
  trigger(float xp, float yp, float wi, float he, boolean s, color c) {
    x = xp; 
    y = yp;
    w = wi;
    h = he;
    state = !s;
    ostate = s;
    sc = c;
  }
  void toggle() {
    state = ostate;
  }
  void update() {
    fill(200);
    stroke(sc);
    rect(x-xOffset, y+yOffset, w, h);
    fill(sc);
    noStroke();
    if (!ostate) {
      noFill();
      stroke(sc);
    }
    strokeWeight(5);
    ellipse(x-xOffset+(w/2), y+yOffset+(h/2), 40, 40);
    strokeWeight(3);
  }
}

class gate {
  float x, y, w, h;
  boolean state, ostate;
  color c;
  gate(float xp, float yp, float wi, float he, boolean s, color sc) {
    x = xp; 
    y = yp; 
    w = wi; 
    h = he;
    c = sc;
    state = s;
    ostate = s;
  }
  void update(boolean t) {
    boolean ao = true;
    for (colorSwitch i : switches) {
      if (i != null && i.sc == c && !i.state) {
        ao = false;
      }
    }
    for (trigger i : triggers) {
      if (i != null && i.sc == c && !i.state) {
        ao = false;
      }
    }
    if (ao) {
      state = !ostate;
    } else {
      state = ostate;
    }
    stroke(c);
    if (t) {
      fill(200);
      rect((x-xOffset), (y+yOffset), w, h);
      strokeWeight(5);
      line((x-xOffset), (y+yOffset), (x-xOffset)+w, (y+yOffset)+h);
      strokeWeight(3);
    }
    fill(c);
    if (state) {
      rect((x-xOffset), (y+yOffset), w, h);
    }
  }
}
