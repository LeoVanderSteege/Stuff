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
  Button setColor(color fgc, color bgc, color acc) {
    fg = fgc;
    bg = bgc;
    ac = acc;
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
    boolean r = false;
    if (mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && !mHeld) {
      r = true;
      mHeld = true;
    }
    //(3);
    fill(sh);
    stroke(sh);
    rect(x-5, y, w+5, h+5);
    fill((r) ? ac : bg);
    stroke((r) ? ac : bg);
    rect(x, y, w, h);
    fill(fg);
    textAlign(CENTER);
    textFont(font);
    text(text, x+w/2, y+h/2+(textAscent() - textDescent())/2);
    return r;
  }
}

class chooseKey {
  float x, y, w, h;
  color bg, fg, ac, sh;
  PFont font = DEFAULTFONT;
  String ckey, label, keyt;
  int align = CENTER;
  boolean rec;
  chooseKey(float xp, float yp, float wi, float he, String k, String l) {
    x = xp; 
    y = yp; 
    w = wi; 
    h = he;
    bg = color(0);
    fg = color(255);
    ac = color(120);
    sh = color(120);
    ckey = k;
    label = l;
  }
  chooseKey setFGColor(color c) {
    fg = c;
    return this;
  }
  chooseKey setBGColor(color c) {
    bg = c;
    return this;
  }
  chooseKey setActiveColor(color c) {
    ac = c;
    return this;
  }
  chooseKey setColor(color fgc, color bgc, color acc) {
    fg = fgc;
    bg = bgc;
    ac = acc;
    return this;
  }
  chooseKey setPosition(float xp, float yp) {
    x = xp; 
    y = yp;
    return this;
  }
  chooseKey setSize(float wi, float he) {
    w = wi; 
    h = he;
    return this;
  }
  chooseKey setFont(PFont f) {
    font = f;
    return this;
  }
  chooseKey setAlign(int a) {
    align = a;
    return this;
  }
  void update() {
    keyt = (ckey.charAt(0) != 'm') ? str(ckey.charAt(1)) : ckey;
    if (keyt.charAt(0) == ' ') {
      keyt = "space";
    }
    if (mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && !mHeld) {
      rec = true;
      mHeld = true;
    }
    if (!mHeld && rec) {
      if (whatPressed() != "") {
        ckey = whatPressed();
        rec = false;
        saveControls();
      }
    }
    //(3);
    fill(sh);
    stroke(sh);
    rect(x-5, y, w+5, h+5);
    fill((rec) ? ac : bg);
    stroke((rec) ? ac : bg);
    rect(x, y, w, h);
    fill(fg);
    textAlign(align);
    textFont(font);
    text(keyt, x+w/2, y+h/2+(textAscent() - textDescent())/2);
    textAlign(RIGHT);
    fill(bg);
    text(label, x-20, y+h/2+(textAscent() - textDescent())/2);
  }
}

class textField {
  float x, y, w, h;
  String entry, label;
  color fg, bg, ac, sh;
  PFont font = DEFAULTFONT;
  int align = CENTER;
  boolean sel = false;
  boolean onlyNums;
  textField(float xp, float yp, float wi, float he, String la, String e, boolean on) {
    x = xp; 
    y = yp; 
    w =wi; 
    h = he; 
    label = la; 
    entry = e;
    bg = color(0);
    fg = color(255);
    ac = color(120);
    sh = color(120);
    onlyNums = on;
  }
  textField setFGColor(color c) {
    fg = c;
    return this;
  }
  textField setBGColor(color c) {
    bg = c;
    return this;
  }
  textField setActiveColor(color c) {
    ac = c;
    return this;
  }
  textField setColor(color fgc, color bgc, color acc) {
    fg = fgc;
    bg = bgc;
    ac = acc;
    return this;
  }
  textField setPosition(float xp, float yp) {
    x = xp; 
    y = yp;
    return this;
  }
  textField setSize(float wi, float he) {
    w = wi; 
    h = he;
    return this;
  }
  textField setFont(PFont f) {
    font = f;
    return this;
  }
  textField setAlign(int a) {
    align = a;
    return this;
  }
  void update() {
    if (mousePressed && !mHeld) {
      if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
        recording = true;
        sel = true;
        mHeld = true;
      }
      else {
        recording = false;
        sel = false;
      }
    }
    fill(sh);
    stroke(sh);
    rect(x-5, y, w+5, h+5);
    fill(bg);
    stroke(bg);
    if (sel && recording && keyPressed && !kHeld) {
      stroke(sh);
      kHeld = true;
      if (key == BACKSPACE) {
        String y = "";
        for (int i = 0; i < entry.length()-1; i++) {
          y += str(entry.charAt(i));
        }
        entry = y;
      } else {
        if (key != CODED) {
          if (!onlyNums) {
            entry += str(key);
          } else {
            if (key == '0' || key == '1' || key == '2'|| key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8'|| key == '9') {
              entry += str(key);
            }
            //if (key == '.' && entry.indexOf(".") == -1) {
            //  entry += str(key);
            //}
          }
        }
      }
    }
    rect(x, y, w, h);
    textFont(font);
    textAlign(RIGHT);
    text(label, x-20, y+h/2+(textAscent() - textDescent())/2);
    fill(fg);
    textAlign(align);
    text(entry, x+w/2, y+h/2+(textAscent() - textDescent())/2);
  }
}

class Toggle {
  float x, y, w, h;
  boolean state;
  color fg, bg, ac, sh;
  PFont font = DEFAULTFONT;
  String label;
  Toggle(float xp, float yp, float wi, float he, String la, boolean st) {
    x = xp; 
    y = yp; 
    w =wi; 
    h = he; 
    label = la;
    state = st;
    bg = color(0);
    fg = color(255);
    ac = color(120);
    sh = color(120);
  }
  Toggle setFGColor(color c) {
    fg = c;
    return this;
  }
  Toggle setBGColor(color c) {
    bg = c;
    return this;
  }
  Toggle setActiveColor(color c) {
    ac = c;
    return this;
  }
  Toggle setColor(color fgc, color bgc, color acc) {
    fg = fgc;
    bg = bgc;
    ac = acc;
    return this;
  }
  Toggle setPosition(float xp, float yp) {
    x = xp; 
    y = yp;
    return this;
  }
  Toggle setSize(float wi, float he) {
    w = wi; 
    h = he;
    return this;
  }
  Toggle setFont(PFont f) {
    font = f;
    return this;
  }
  void toggle() {
    if (state) {
      state = false;
    } else {
      state = true;
    }
  }
  void update() {
    if (mousePressed && !mHeld && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      mHeld = true;
      toggle();
    }
    fill(sh);
    stroke(sh);
    rect(x-5, y, w+5, h+5);
    fill((state) ? ac : bg);
    stroke(bg);
    rect(x, y, w, h);
    textAlign(RIGHT);
    fill(bg);
    text(label, x-20, y+h/2+(textAscent() - textDescent())/2);
  }
}
