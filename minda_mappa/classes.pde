class blob {
  float x;
  float y;
  float w;
  float h;
  float r = dr;
  float g = dg;
  float b = db;
  float tr = 0;
  float tg = 0;
  float tb = 0;
  String text;
  boolean movable;
  boolean hold = false;
  int action = 0;
  blob pot = this;
  blob[] con = new blob[100];
  int cbi = 0;
  String code;
  blob(float xp, float yp, float wid, float hei, String t, boolean m) {
    x = xp; y = yp; text = t; movable = m; w = wid; h = hei;
    for (int i = 0; i < 100; i++) {
      con[i] = this;
    }
  }
  void update() {
    if (hold && action == 0) {
      x = mouseX;
      y = mouseY;
    }
    if (hold && action == 1) {
      line(x, y, mouseX, mouseY);
      for (blob i : blobs) {
        if (mouseX > i.x - i.w/2 && mouseX < i.x + i.w/2 && mouseY > i.y - i.h/2 && mouseY < i.y + i.h/2) {
          pot = i;
        }
      }
    }
    if (!hold) {
     if (pot != this) {
       boolean h = true;
       boolean p = false;
       int u = 0;
       for (int i = 0; i < 100; i++) {
         if (con[i] == pot) {
           h = false;
           u = i;
         }
         if (pot.con[i] == this) {
           h = false;
           p = true;
           u = i;
         }
       }
       if (h) {
          con[cbi] = pot;
          cbi++;
          pot = this;
        } else {
          if (p) {
            pot.con[u] = pot.con[pot.cbi - 1];
            pot.con[pot.cbi - 1] = pot;
            pot.cbi--;
          } else {
            con[u] = con[cbi - 1];
            con[cbi - 1] = this;
            cbi--;
          }
          pot = this;
        }
      }
    }
    fill(r, g, b);
    stroke(0);
    ellipse(x, y, w, h);
    fill(tr, tg, tb);
    textAlign(CENTER);
    textSize(24);
    text(text, x, y+8);
  }
  void lines() {
    for (blob i : con) {
      line(x, y, i.x, i.y);
    }
  }
  void clicked() {
    if (mousePressed && mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2 && selected == idleBlob) {
      if (movable) {
        if (mouseButton == LEFT) {
          selected = this;
          hold = true;
          action = 0;
        }
      }
      if (mouseButton == RIGHT) {
        if (tool == 0) {
          selected = this;
          action = 1;
          hold = true;
        }
        if (tool == 1) {
          selected = this;
          action = 2;
          text = cp5.get(Textfield.class, "text").getText();
          if (cp5.get(Toggle.class, "change Text color").getBooleanValue()) {
            tr = cp5.get(Slider.class, "R").getValue();
            tg = cp5.get(Slider.class, "G").getValue();
            tb = cp5.get(Slider.class, "B").getValue();
          }
        }
        if (tool == 3) {
          selected = this;
          action = 3;
          int u = 0;
          for (int i = 0; i < 100; i++) {
            if (blobs[i] == this) {
              u = i;
            }
          }
          x = -500;
          y = -500;
          con = new blob[100];
          for (int i = 0; i < 100; i++) {
            con[i] = this;
          }
          blob o = blobs[bi - 1];
          blobs[bi - 1] = this;
          blobs[u] = o;
          bi--;
        }
        if (tool == 4) {
          selected = this;
          action = 4;
          r = cp5.get(Slider.class, "R").getValue();
          g = cp5.get(Slider.class, "G").getValue();
          b = cp5.get(Slider.class, "B").getValue();
        }
        if (tool == 5) {
          selected = this;
          action = 5;
          cp5.get(Slider.class, "R").setValue(r);
          cp5.get(Slider.class, "G").setValue(g);
          cp5.get(Slider.class, "B").setValue(b);
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
  String vals;
  boolean hi = false;
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
  button(float xp, float yp, float wi, float he, String v) {
    x = xp;
    y = yp;
    w = wi;
    h = he;
    vals = v;
  }
  void toggle() {
    if (hi) {
      hi = false;
    } else {
      hi = true;
    }
  }
  boolean check() {
    if (mouseX >= x &&  mouseX <= x+w && mouseY >= y && mouseY <= y+h && mousePressed && !hi) {
      return true;
    } else {
      return false;
    }
  }
}
