class player {
  float x, y, xd, xs, ys, px, py, sx, sy;
  boolean grounded = true;
  boolean roofed = false;
  boolean moving = false;
  boolean end = false;
  boolean death = false;
  int wall = 0;
  int lwj = 0;
  int chainJumps = 0;
  float[][] steps;
  goal lg;
  block ground;
  float[] stopStep;
  player (float xp, float yp, goal g) {
    x = xp; 
    y = yp;
    px = x; 
    py = y;
    sx = x; 
    sy = y;
    ys = 0;
    xs = 0;
    lg = g;
    float[][] isteps = {{x, y}, {x, y}, {x, y}, {x, y}};
    steps = isteps;
  }
  void die() {
    x = sx;
    y = sy;
    xs = 0;
    ys = 0;
    chainJumps = 0;
    for (colorSwitch i : switches) {
      if (i != null) {
        i.state = i.ostate;
      }
    }
    for (trigger i : triggers) {
      if (i != null) {
        i.state = !i.ostate;
      }
    }
  }
  void update() {
    for (int i = 0; i < steps.length; i++) {
      steps[i][0] = x+(xd*(xs/steps.length)*(i+1));
      steps[i][1] = y+((ys/steps.length)*(i+1));
    }
    grounded = false;
    roofed = false;
    moving = false;
    stopStep = null;
    death = false;
    wall = 0;
    for (float[] o : steps) {
      if (o[0]+30 > lg.x && o[0]+30 < lg.x+lg.w && o[1]+30 > lg.y && o[1]+30 < lg.y+lg.h) {
        stopStep = o;
        delay(1000);
        end = true;
      }
    }
    for (boostPad i : boosts) {
      if (i != null) {
        i.update();
        for (float[] o : steps) {
          if (o[0]+65 > i.x && o[0]+65 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null ||stopStep == o)) {
            wall = 1;
            stopStep = o;
            xd *= -1;
          }
          if (o[0]-5 > i.x && o[0]-5 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null || stopStep == o)) {
            wall = -1;
            stopStep = o;
            xd *= -1;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+i.w && o[1]+61 > i.y && o[1]+61 < i.y+i.h && (stopStep == null ||stopStep == o) && !roofed) {
            stopStep = o;
            ys = -50;
          }
        }
      }
    }
    for (block i : blocks) {
      if (i != null) {
        i.update();
        for (float[] o : steps) {
          if (o[0]+65 > i.x && o[0]+65 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null ||stopStep == o)) {
            wall = 1;
            stopStep = o;
            xs = 0;
            death = (i.kill) ? true : death;
          }
          if (o[0]-5 > i.x && o[0]-5 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null || stopStep == o)) {
            wall = -1;
            stopStep = o;
            xs = 0;
            death = (i.kill) ? true : death;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+i.w && o[1]-1 > i.y && o[1]-1 < i.y+i.h && (stopStep == null ||stopStep == o)) {
            roofed = true;
            ground = i;
            stopStep = o;
            ys = 0;
            death = (i.kill) ? true : death;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+i.w && o[1]+61 > i.y && o[1]+61 < i.y+i.h && (stopStep == null ||stopStep == o) && !roofed) {
            grounded = true;
            ground = i;
            stopStep = o;
            ys = 0;
            death = (i.kill) ? true : death;
          }
        }
      }
    }
    for (colorSwitch i : switches) {
      if (i != null) {
        i.update();
      }
    }
    for (gate i : gates) {
      if (i != null) {
        i.update(false);
        for (float[] o : steps) {
          if (o[0]+65 > i.x && o[0]+65 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null ||stopStep == o) && i.state) {
            wall = 1;
            stopStep = o;
            xs = 0;
          }
          if (o[0]-5 > i.x && o[0]-5 < i.x+i.w && o[1]+30 > i.y && o[1]+30 < i.y+i.h && (stopStep == null || stopStep == o) && i.state) {
            wall = -1;
            stopStep = o;
            xs = 0;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+i.w && o[1]-1 > i.y && o[1]-1 < i.y+i.h && (stopStep == null ||stopStep == o) && i.state) {
            roofed = true;
            ground = new block(i.x, i.y, i.w, i.h, false, 255);
            stopStep = o;
            ys = 0;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+i.w && o[1]+61 > i.y && o[1]+61 < i.y+i.h && (stopStep == null ||stopStep == o) && !roofed && i.state) {
            grounded = true;
            ground = new block(i.x, i.y, i.w, i.h, false, 255);
            stopStep = o;
            ys = 0;
          }
        }
      }
    }
    for (ball i : balls) {
      if (i != null) {
        i.update();
        if (i.x > x && i.x < x+60 && i.y > y && i.y < y+60 && i.kill) {
          death = true;
        }
      }
    }
    for (cannon i : cannons) {
      if (i != null) {
        i.update();
        for (float[] o : steps) {
          if (o[0]+65 > i.x && o[0]+65 < i.x+100 && o[1]+30 > i.y && o[1]+30 < i.y+100 && (stopStep == null ||stopStep == o)) {
            wall = 1;
            stopStep = o;
            xd *= -1;
          }
          if (o[0]-5 > i.x && o[0]-5 < i.x+100 && o[1]+30 > i.y && o[1]+30 < i.y+100 && (stopStep == null || stopStep == o)) {
            wall = -1;
            stopStep = o;
            xd *= -1;
          }
          if (o[0]+30 > i.x && o[0]+30 < i.x+100 && o[1]+61 > i.y && o[1]+61 < i.y+100 && (stopStep == null ||stopStep == o) && !roofed) {
            stopStep = o;
            grounded = true;
            ground = new block(i.x, i.y, 100, 100, false, 255);
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
    if (!moving) {
      xs /= 2;
      xd = abs(xd);
    }
    if (isPressed(SETTINGS[0]) && !isPressed(SETTINGS[1]) && wall != -1) {
      xd = -1;
      xs = 10;
      moving = true;
    }
    if (isPressed(SETTINGS[1]) && !isPressed(SETTINGS[0]) && wall != 1) {
      xd = 1;
      xs = 10;
      moving = true;
    }
    if (isPressed(SETTINGS[2]) && moving) {
      xs *= 1.6;
    }
    if ((grounded || (wall != 0 && lwj != wall)) && isPressed(SETTINGS[4])) {
      chainJumps = (chainJumps > 3) ? 2 : chainJumps+1;
      ys = (chainJumps == 3) ? -40 : -30;
      lwj = (wall != 0) ? wall : lwj;
    }
    if (roofed) {
      y = ground.y+ground.h+1;
    }
    if (grounded && ys == 0) {
      lwj = 0;
      x = steps[steps.length-1][0];
      y = ground.y-60;
      if (!isPressed(SETTINGS[4])) {
        chainJumps = 0;
      }
    }
    if (y > height) {
      death = true;
    }
    for (colorSwitch i : switches) {
      if (i != null) {
        if (x+30 > i.x && x+30 < i.x+100 && y+30 > i.y && y+30 < i.y+100 && isPressed(SETTINGS[3]) && !kHeld) {
          kHeld = true;
          i.toggle(false);
        }
      }
    }
    for (trigger i : triggers) {
      if (i != null) {
        if (x+30 > i.x && x+30 < i.x+i.w && y+30 > i.y && y+30 < i.y+i.h) {
          i.toggle();
        }
      }
    }
    if (x < 0) {
      x = 0;
    }
    fill(cyan);
    stroke(blue);
    rect((x-xOffset), (y+yOffset), 60, 60);
    if (death) {
      delay(500);
      die();
    }
    if (end) {
      setPhase(0);
    }
  }
}
