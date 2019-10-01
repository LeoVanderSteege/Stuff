class Button {
  float x, y, w, h;
  color bg, fg, ac, sh;
  PFont font = DEFAULTFONT;
  String text;
  int align = CENTER;
  Button(float xp, float yp, float wi, float he, String t) {
    x = xp; 
    y = yp; 
    w = wi; 
    h = he;
    bg = color(0);
    fg = color(255);
    ac = color(120);
    sh = color(120);
    text = t;
  }
  Button setFGColor(color c) {
    fg = c;
    return this;
  }
  Button setBGColor(color c) {
    bg = c;
    return this;
  }
  Button setActiveColor(color c) {
    ac = c;
    return this;
  }
  Button setShadowColor(color c) {
    ac = c;
    return this;
  }
  Button setColor(color fgc, color bgc, color acc, color sha) {
    fg = fgc;
    bg = bgc;
    ac = acc;
    sh = sha;
    return this;
  }
  Button setPosition(float xp, float yp) {
    x = xp; 
    y = yp;
    return this;
  }
  Button setSize(float wi, float he) {
    w = wi; 
    h = he;
    return this;
  }
  Button setFont(PFont f) {
    font = f;
    return this;
  }
  Button setAlign(int a) {
    align = a;
    return this;
  }
  boolean update() {
    fill(sh);
    stroke(sh);
    rect(x-5, y, w+5, h+5);
    fill(bg);
    stroke(bg);
    boolean r = false;
    if (mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && !mheld && reactive) {
      r = true;
    }
    if (mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      fill(ac);
      stroke(ac);
    }
    rect(x, y, w, h);
    fill(fg);
    textAlign(CENTER);
    textFont(font);
    text(text, x+w/2, y+h/2+(textAscent() - textDescent())/2);
    return r;
  }
}
