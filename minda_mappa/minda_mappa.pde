import controlP5.*;

public ControlP5 cp5;

public float dr = 255;
public float dg = 255;
public float db = 255;
public float dtr = 0;
public float dtg = 0;
public float dtb = 0;

public minda_mappa tis = this;

public PFont font;

public blob idleBlob = new blob(-500, -500, 1, 1, "", false);

public blob selected = idleBlob;

boolean h = true;

void mouseReleased() {
  h = true;
  sb.hold = false;
  selected = idleBlob;
  for (int i = 0; i < 100; i++) {
    blobs[i].hold = false;
  }
}

public int tool = 0;

public int bi = 1;
public blob[] blobs = new blob[100];

blob sb;

void setup() {
  fullScreen();
  frameRate(200);
  font = createFont("arial", 20);
  cp5 = new ControlP5(this);
  cp5.addTextfield("text")
    .setPosition(1, 156)
    .setSize(150, 40)
    .setFont(font)
    .setAutoClear(false);
  cp5.addSlider("R")
    .setPosition(1, 96)
    .setSize(223, 20)
    .setRange(0, 255);
  cp5.addSlider("G")
    .setPosition(1, 116)
    .setSize(223, 20)
    .setRange(0, 255);
  cp5.addSlider("B")
    .setPosition(1, 136)
    .setSize(223, 20)
    .setRange(0, 255);
  cp5.addToggle("change Text color")
    .setPosition(280, 0)
    .setSize(30, 30);
  cp5.addTextfield("open file")
    .setPosition(1920/2-150, 1080/2-20)
    .setSize(300, 40)
    .setFont(font)
    .setAutoClear(false)
    .setColorCaptionLabel(color(255, 0, 0));
  sb  = new blob(1920/2, 1080/2, 240, 120, "", true);
  for (int i = 0; i < 100; i++) {
    if (i == 0) {
      blobs[i] = sb;
    } else {
      blobs[i] = new blob(-500, -500, 1, 1, "", false);
    }
  }
}

StringList getldata(String path) {
  print(path);
  BufferedReader reader = createReader(path);
  String line = null;
  StringList text = new StringList();
  try {
    while ((line = reader.readLine()) != null) {
      text.append(line);
    }
    reader.close();
    return text;
  } catch (IOException e) {
    e.printStackTrace();
    return null;
  }
}

void mouseWheel(MouseEvent e) {
  if (e.getCount() > 0) {
    tool--;
  }
  if (e.getCount() < 0) {
    tool++;
  }
  if (tool > 5) {tool = 0;}
  if (tool < 0) {tool = 5;}
}

button saj = new button(0, 240, 64, 64);

button sal = new button(0, 304, 64, 64);

button oal = new button(0, 368, 64, 64);

button rtb = new button(150, 156, 36, 40);

button rtw = new button(186, 156, 36, 40);

button defaulter = new button(225, 0, 50, 80);

button ofc = new button(1920/2+50, 1080/2+25, 100, 40);
button cof = new button(1920/2+100, 1080/2-80, 33, 33);

boolean ofm = false;

blob getByCode(String code) {
  for (blob i : blobs) {
    if (code == i.code) {
      return i;
    }
  }
  return idleBlob;
}

void draw() {
  ofc.hi = true;
  cof.hi = true;
  cp5.get(Slider.class, "R").show();
  cp5.get(Slider.class, "G").show();
  cp5.get(Slider.class, "B").show();
  cp5.get(Toggle.class, "change Text color").show();
  cp5.get(Textfield.class, "text").show();
  cp5.get(Textfield.class, "open file").setPosition(-500, -500);
  strokeWeight(5);
  background(180);
  PImage ob = loadImage("/gui/open_file.png");
  image(loadImage("/gui/tool_"+str(tool)+".png"), 0, 0);
  image(loadImage("/gui/save_as_jpeg.png"), 0, 240);
  image(loadImage("/gui/save_as_ldata.png"), 0, 304);
  image(loadImage("/gui/open_ldata.png"), 0, 368);
  float r = cp5.get(Slider.class, "R").getValue();
  float g = cp5.get(Slider.class, "G").getValue();
  float b = cp5.get(Slider.class, "B").getValue();
  fill(r, g, b);
  noStroke();
  rect(96, 64, 128, 32);
  fill(0);
  rect(150, 156, 36, 40);
  fill(255);
  rect(186, 156, 36, 40);
  stroke(0);
  fill(dr, dg, db);
  ellipse(width-40, height-20, 80, 40);
  fill(dtr, dtg, dtb);
  textAlign(CENTER);
  text("ABC", width-40, height-13);
  fill(255, 0, 0);
  rect(225, 0, 50, 80);
  fill(255);
  if (rtb.check()) {
    cp5.get(Slider.class, "R").setValue(0);
    cp5.get(Slider.class, "G").setValue(0);
    cp5.get(Slider.class, "B").setValue(0);
  }
  if (rtw.check()) {
    cp5.get(Slider.class, "R").setValue(255);
    cp5.get(Slider.class, "G").setValue(255);
    cp5.get(Slider.class, "B").setValue(255);
  }
  if (defaulter.check()) {
    dr = selected.r;
    dg = selected.g;
    db = selected.b;
    dtr = selected.tr;
    dtg = selected.tg;
    dtb = selected.tb;
  }
  if (saj.check()) {
    background(180);
    stroke(0);
    cp5.get(Slider.class, "R").hide();
    cp5.get(Slider.class, "G").hide();
    cp5.get(Slider.class, "B").hide();
    cp5.get(Toggle.class, "change Text color").hide();
    cp5.get(Textfield.class, "text").hide();
  }
  if (sal.check()) {
    String y = "";
    for (blob i : blobs) {
      y += i + " ";
      y += str(i.x)+" ";
      y += str(i.y)+" ";
      y += i.text+" ";
      y += str(i.r)+" ";
      y += str(i.g)+" ";
      y += str(i.b)+" ";
      y += str(i.tr)+" ";
      y += str(i.tg)+" ";
      y += str(i.tb)+" ";
      for (blob o : i.con) {
        y += o+"|";
      }
      y += ",";
    }
    String[] list = y.split(",");
    saveStrings("../mindmap.ldata", list);
  }
  if (oal.check()) {
     ofm = true;
  }
  if (ofm) {
    cof.hi = false;
    cp5.get(Textfield.class, "open file").setPosition(1920/2-150, 1080/2-20);
    selected = new blob(0, 0, 1, 1, "", false);
    ofc.toggle();
  }
  if (cof.check()) {
    ofm = false;
  }
  if (ofc.check()) {
    String u = cp5.get(Textfield.class, "open file").getText();
    println(r);
    StringList f = getldata(u);
    for (int i = 0; i < 100; i++) {
      blobs[i] = new blob(-500, -500, 240, 120, "", true);
    }
    int lbi = 0;
    for (String i : f) {
      String[] h = i.split(" ");
      blobs[lbi].code = h[0];
      blobs[lbi].x = float(h[1]);
      blobs[lbi].y = float(h[2]);
      blobs[lbi].text = h[3];
      blobs[lbi].r = float(h[4]);
      blobs[lbi].g = float(h[5]);
      blobs[lbi].b = float(h[6]);
      blobs[lbi].tr = float(h[7]);
      blobs[lbi].tg = float(h[8]);
      blobs[lbi].tb = float(h[9]);
      lbi++;
    }
    for (int i = 0; i < blobs.length; i++) {
       String[] h = f.get(i).split(" ");
       String[] l = h[h.length-1].split("|");
       blob[] c = new blob[100];
       for (int o = 0; o < 100; o++) {
         c[o] = getByCode(l[o]);
       }
       blobs[i].con = c;
     }
  }
  for (int i = 0; i < 100; i++) {
    blobs[i].clicked();
  }
  for (int i = 0; i < 100; i++) {
    blobs[i].lines();
  }
  for (int i = 0; i < 100; i++) {
    blobs[i].update();
  }
  if (saj.check()) {
    saveFrame("../mindmap.jpg");
  }
  if (ofm) {
    image(ob, 1920/2+50, 1080/2+25);
    image(loadImage("/gui/close.png"), 1920/2+100, 1080/2-80);
  }
  if (mousePressed && mouseButton == RIGHT) {
    if (tool == 2 && h) {
      h = false;
      blobs[bi] = new blob(mouseX, mouseY, 240, 120, "", true);
      bi++;
    }
  }
}
