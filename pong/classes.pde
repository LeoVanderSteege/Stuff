class hitbox {
  float x; float y; float w; float h; int index;
  paddle p;
  hitbox(float xp, float yp, float wi, float he, int i) {
    x = xp; y = yp; w = wi; h = he; index = i;
    hboxs[i] = this;
  }
  hitbox(float xp, float yp, float wi, float he, int i, paddle pa) {
    x = xp; y = yp; w = wi; h = he; index = i; p = pa;
    hboxs[i] = this;
  }
}

class paddle {
  float x; float y; float w; float h; int index; color c;
  hitbox sh;
  paddle(float xp, float yp, float wi, float he, color pc, int i) {
    x = xp; y = yp; w = wi; h = he; index = i; c = pc;
    sh = new hitbox(x, y, w, h, i, this);
    sh.p = this;
  }
  void show() {
    fill(c);
    stroke(c);
    rect(x, y, w, h);
  }
  void update(String up, String down) {
    this.show();
    sh.x = x; sh.y = y;
    if (keys.hasValue(up)) {
      y -= 10;
    }
    if (keys.hasValue(down)) {
      y += 10;
    }
  }
}

class ball {
  float x; float y; float r; float xd; float yd; float s;
  color c = color(255);
  ball(float xp, float yp, float ra, float speed) {
    x = xp; y = yp; r = ra; s = speed;
    xd = random(0.3, 0.7);
    yd = (1 - xd) * random(-1, 1);
    if (int(random(2)) == 1) {
      xd *= -1;
    }
  }
  void show() {
    fill(c);
    stroke(c);
    ellipse(x, y, r, r);
  }
  void update() {
    this.show();
    x += xd*s;
    y += yd*s;
    if (x < 0) {
      p2p++;
      player = "Player 2";
      point_scored();
    }
    if (x > 1920) {
      p1p++;
      player = "Player 1";
      point_scored();
    }
    if (y < 0 || y > 1080) {
      yd *= -1;
    }
    for (hitbox i : hboxs) {
      if (i != null) {
        if (x > i.x && x < i.x+i.w && y > i.y && y < i.y+i.h) {
          xd *= -1;
          if (i.p != null) {
            c = i.p.c;
          }
        }
      }
    }
  }
}

class button {
  float x;
  float y;
  float w;
  float h;
  int val;
  button(float xp, float yp, float wi, float he) {
    x = xp;
    y = yp;
    w = wi;
    h = he;
  }
  button(float xp, float yp, float wi, float he, int v) {
    x = xp;
    y = yp;
    w = wi;
    h = he;
    val = v;
  }
  boolean check() {
    if (mouseX >= x &&  mouseX <= x+w && mouseY >= y && mouseY <= y+h && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
