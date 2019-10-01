import controlP5.*;

void setup() {
  fullScreen();
  DEFAULTFONT = createFont("arial", 20);
  m = new Button(0, 0, 100, 30, "menu").setColor(color(255), color(180), color(155), color(200, 255, 0));
  E = new Button(0, 0, 30, 30, "").setColor(color(255), color(255, 220, 0), color(155), color(180));
  A = new Button(0, 40, 30, 30, "").setColor(color(255), color(200, 50, 0), color(155), color(180));
  D = new Button(0, 80, 30, 30, "").setColor(color(255),color(0, 0, 200), color(155), color(180));
  O = new Button(0, 120, 30, 30, "").setColor(color(255), color(0, 255, 50), color(155), color(180));
  DR = new Button(0, 160, 30, 30, "").setColor(color(255), color(200, 0, 200), color(155), color(180));
  C = new Button(0, 200, 30, 30, "").setColor(color(255), color(0, 100, 200), color(155), color(180));
  Compile = new Button(0, height-40, 100, 30, "Compile").setColor(color(255), color(180), color(155), color(0, 0, 0));
  Menu.add(events);
  Menu.add(actions);
  Menu.add(data);
  Menu.add(operations);
  Menu.add(drawing);
  Menu.add(control);
  events.addAll(loadAll("blocks/events.xml", color(255, 220, 0)));
  actions.addAll(loadAll("blocks/actions.xml", color(200, 50, 0)));
  data.addAll(loadAll("blocks/data.xml", color(0, 0, 200)));
  operations.addAll(loadAll("blocks/operations.xml", color(0, 255, 50)));
  drawing.addAll(loadAll("blocks/drawing.xml", color(200, 0, 200)));
  control.addAll(loadAll("blocks/control.xml", color(0, 100, 200)));
  cp = new ControlP5(this);
  editText = cp.addTextfield("edit").setPosition(-500, -500)
    .setSize(80, 80)
    .setFont(DEFAULTFONT)
    .setAutoClear(false)
    .keepFocus(true);
}

color complimentary(color c) {
  return color(255-red(c), 255-green(c), 255-blue(c));
}

ArrayList<block> loadAll(String path, color c) {
  XML e = loadXML(path);
  int in = 0;
  ArrayList<block> r = new ArrayList<block>();
  for (XML i : e.getChildren("block")) {
    boolean[] z = new boolean[4], y = new boolean[4];
    int zs = int(i.getChild("args").getContent());
    int ys = int(i.getChild("stick").getContent());
    boolean[][] u = {ARGS, NOARGS, ARGSWE, NOARGSWE};
    z = u[zs];
    y = u[ys];
    r.add(new block(70, in*110+50, 200, 80, z, y, c, i.getChild("name").getContent(), i.getChild("code").getContent(), int(i.getChild("type").getContent()), boolean(int(i.getChild("edit").getContent())), i.getChild("pre").getContent(), true));
    in++;
  }
  return r;
}

PFont DEFAULTFONT;

boolean mheld = false, sel = false, kheld = false, nb = false;

final boolean[] ARGS = {true, true}, 
  NOARGS = {true, false}, 
  ARGSWE = {false, true}, 
  NOARGSWE = {false, false};

final color red = color(200, 0, 0), 
  green = color(0, 200, 0), 
  blue = color(0, 0, 200);

block selected = null, choice = null, editing = null, iret = null, rem = null;

Button m, E, A, D, O, DR, C, Compile;

Textfield editText;

ControlP5 cp;

boolean menu = false, recording = false, reactive = true;
int section = 0, xoff = 0, yoff = 0;

ArrayList<block> blocks = new ArrayList<block>();

ArrayList<ArrayList<block>> Menu = new ArrayList<ArrayList<block>>();

ArrayList<block> events = new ArrayList<block>(), 
  actions = new ArrayList<block>(), 
  data = new ArrayList<block>(),
  operations = new ArrayList<block>(),
  drawing = new ArrayList<block>(),
  control = new ArrayList<block>();



void updateBlocks() {
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).update();
  }
  for (int i = 0; i < blocks.size(); i++) {
    blocks.get(i).update();
  }
  for (int i = blocks.size()-1; i > -1; i--) {
    blocks.get(i).show();
  }
  for (block i : blocks) {
    if (i.hit(RIGHT)) {
      nb = false;
    }
  }
}

void saveProgramm() {
  reactive = false;
  iret = new block(width/3, height/3, width/3, height/3, ARGS, ARGS, color(72), "", "", 0, true, "", true);
  editing = iret;
  editText.setText("");
}

void mouseDragged() {
  if (selected == null && mouseButton == LEFT) {
    xoff += mouseX - pmouseX;
    yoff += mouseY - pmouseY;
  }
}

void mouseReleased() {
  println(selected != null);
  if (selected != null && mouseX > width-50 && mouseY > height-50) {
    rem = selected;
  }
}

void mousePressed() {
  if (mouseButton == RIGHT && choice != null && nb && reactive) {
    boolean n = true;
    for (block i : blocks) {
      if (i.hit(RIGHT)) {
        editing = (editing != i && i.edit) ? i : null;
        editText.setText(editing == i ? i.value : "");
        n = false;
      }
    }
    if (n) {
      blocks.add(0, choice.dupe());
      blocks.get(0).x = mouseX-xoff;
      blocks.get(0).y = mouseY-yoff;
      blocks.get(0).off = 1;
    }
  }
}

void move(block o, int i) {
  blocks.remove(o);
  blocks.add(i, o);
}

void held() {
  mheld = mousePressed;
  kheld = keyPressed;
}

void menu() {
  noStroke();
  fill(120);
  rect(0, 0, 300, height);
  stroke(200, 255, 0);
  line(300, 0, 300, height);
  section = E.update() ? 0 : section;
  section = A.update() ? 1 : section;
  section = D.update() ? 2 : section;
  section = O.update() ? 3 : section;
  section = DR.update() ? 4 : section;
  section = C.update() ? 5 : section;
  if (Compile.update()) {
    thread("saveProgramm");
  }
  for (block i : Menu.get(section)) {
    i.show();
    if (i.hit(LEFT)) {
      choice = i;
    }
  }
}

void draw() {
  if (reactive) {
    nb = true;
    if (selected != null) {
      move(selected, 0);
    }
    sel = false;
    background(51);
    rect(width-50, height-50, 50, 50);
    updateBlocks();
    if (menu) {
      menu();
      m.setPosition(305, 0);
    } else {
      m.setPosition(6, 0);
    }
    if (m.update()) {
      menu = !menu;
    }
    held();
  } else {
    editing = iret;
    iret.update();
    iret.show();
    if (keyPressed && (key == ENTER || key == RETURN)) {
      ArrayList<block> o = Strings();
      String[] c = {compileStrings(o)};
      String n = editText.getText();
      saveStrings(n+"/"+n+".pde", c);
      reactive = true;
    }
  }
  if (rem != null) {
    blocks.remove(rem);
    rem = null;
  }
}
