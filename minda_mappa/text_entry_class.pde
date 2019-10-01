class entry {
  float x;
  float y;
  boolean limit;
  float w = 0;
  float h = 0;
  float textsize;
  boolean border;
  boolean selected;
  String text = "";
  boolean wr = false;
  entry(float xp, float yp, float wid, float hei, boolean bor, float ts) {
    x = xp;
    y = yp;
    w = wid;
    h = hei;
    textsize = ts;
    border = bor;
    limit = true;
  }
  entry(float xp, float yp, float wid, float hei, boolean bor) {
    x = xp;
    y = yp;
    w = wid;
    h = hei;
    textsize = 20;
    border = bor;
    limit = true;
  }
  entry(float xp, float yp,  boolean bor, float ts) {
    x = xp;
    y = yp;
    textsize = ts;
    border = bor;
    limit = false;
  }
  void update() {
    if (limit) {
      stroke(110);
      fill(255);
      fill(0);
      textSize(textsize);
      text(text, x+10, (y+h/2));
    }
    if (mousePressed && mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
      selected = true;
      wr = true;
    }
    if (mousePressed && !(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)) {
      selected = false;
    }
    if (selected && keyPressed && wr && key == CODED) {
      println(1);
      if (keyCode == DELETE) {
        println(2);
        text = split(text, text.charAt(text.length()))[0];
      }
    }
    if (selected && keyPressed && wr && !(key == CODED)) {
      println(key);
      text += str(key);
      wr = false;
    }
  }
}
