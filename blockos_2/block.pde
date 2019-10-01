class block {
  float x, y, w, h, mox, moy, off;
  boolean[] ports = new boolean[4];
  block[] stuck = new block[2];
  block parent, pot;
  int pi = -1, type, lfs;
  String name, code, value, pre;
  boolean glow = false, edit = false;
  color c;
  block(float xp, float yp, float wid, float hei, boolean[] ps1, boolean[] ps2, color co, String nam, String cod, int typ, boolean edi, String pr, boolean stat) {
    x = xp; 
    y = yp; 
    w = wid; 
    h = hei; 
    c = co;
    ports[0] = ps1[0];
    ports[1] = ps1[1];
    ports[2] = ps2[0];
    ports[3] = ps2[1];
    name = nam;
    code = cod;
    type = typ;
    value = name;
    edit = edi;
    pre = pr;
    off = (stat) ? 0 : 1;
  }
  block dupe() {
    boolean[] f = {ports[0], ports[1]},
              g = {ports[2], ports[3]};
    return new block(x, y, w, h, f, g, c, name, code, type, edit, pre, off == 0 ? true : false);
  }
  void sticks() {
    if (selected == null && pot != null && pot.parent == null) {
      stuck[pi] = pot;
      pot.parent = this;
      move(pot, blocks.indexOf(this));
      pot = null;
    }
    if (selected != null) {
      boolean r = true;
      if (ports[0] && selected.ports[2] && mouseX-(xoff*off) > x+w && mouseX-(xoff*off) < x+w+50 && mouseY-(yoff*off) > y && mouseY-(yoff*off) < y+h) {
        noFill();
        stroke(120, 200, 0);
        rect(x+w+(xoff*off), y+(yoff*off), 50, h);
        pot = selected;
        pi = 0;
        r = false;
      }
      if (ports[1] && selected.ports[3] && mouseX-(xoff*off) > x && mouseX-(xoff*off) < x+w && mouseY-(yoff*off) > y+h && mouseY-(yoff*off) < y+h+30) {
        noFill();
        stroke(120, 200, 0);
        rect(x+(xoff*off), y+h+(yoff*off), w, 50);
        pot = selected;
        pi = 1;
        r = false;
      }
      if (r) {
        pot = null;
      }
    }
  }
  void show() {
    strokeWeight(5);
    stroke(selected == this ? color(255, 255, 0) : editing == this ? green : 255);
    fill(glow ? green : c);
    rect(x+(xoff*off), y+(yoff*off), w, h);
    fill(complimentary(c));
    textAlign(CENTER);
    text(pre+value, x+(xoff*off)+(w/2), y+(yoff*off)+(h/2)+(textAscent() - textDescent())/2);
  }
  boolean hit(int button) {
    if (mouseX-(xoff*off) >= x && mouseX-(xoff*off) < x+w && mouseY-(yoff*off) >= y && mouseY-(yoff*off) < y+h && mousePressed && mouseButton == button && reactive) {
      return true;
    }
    return false;
  }
  void update() {
    sticks();
    if (edit && editing == this) {
      value = editText.getText();
    }
    if (!mheld && hit(LEFT) && selected == null) {
      mox = mouseX-x;
      moy = mouseY-y;
      selected = this;
    }
    if (!mousePressed || mouseButton != LEFT && sel) {
      selected = null;
      
    }
    if (stuck[0] != null) {
      stuck[0].x = x+w;
      stuck[0].y = y;
    }
    if (stuck[1] != null) {
      stuck[1].x = x;
      stuck[1].y = y+h;
    }
    if (selected == this && parent != null) {
      if (parent.stuck[0] == this) {
        parent.stuck[0] = null;
        parent = null;
      }
      if (parent != null && parent.stuck[1] == this) {
        parent.stuck[1] = null;
        parent = null;
      }
    }
    if (mousePressed && mouseButton == LEFT) {
      if (selected == this) {
        x = mouseX-mox;
        y = mouseY-moy;
      }
    }
  }
}
