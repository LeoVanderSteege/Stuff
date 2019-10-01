public PFont DEFAULTFONT;

public boolean mHeld = false;
public boolean kHeld = false;

public boolean recording = false;

public StringList keys = new StringList("");

final public color white = color(255);
final public color black = color(0);
final public color grey = color(80);
final public color blue = color(0, 0, 255);
final public color cyan = color(0, 200, 255);
final public color red = color(255, 30, 30);
final public color maroon = color(150, 50, 0);
final public color green = color(0, 255, 0);
final public color teal = color(0, 240, 120);

public int phase = 0;

public String[] SETTINGS;

public int[] currentState;

public boolean Testing = false;

//main menu
Button play;
Button create;
Button settings;
Button exit_game;

//Settings
chooseKey left;
chooseKey right;
chooseKey up;
chooseKey down;
chooseKey jump;
chooseKey ability;
chooseKey grab;

//save slot menu
Button slot1;
Button slot2;
Button slot3;

//game
player p1;
boostPad[] boosts;
block[] blocks;
colorSwitch[] switches;
gate[] gates;
ball[] balls;
trigger[] triggers;
cannon[] cannons;
goal levelGoal;
public float xOffset = 0;
public float yOffset = 0;

//builder
Button blockTool;
Button deleteTool;
Button goalTool;
Button switchTool;
Button gateTool;
Button boostTool;
Button test;
Button loadL;
Button cannonTool;
Button triggerTool;
Button ballTool;
Toggle killBlock;
textField objectWidth;
textField objectHeight;
textField redColor;
textField greenColor;
textField levelWorld;
textField levelNum;
int selectedTool = 1;
boolean place = false;
int rotation = 0;
int lcm = 0;

//pause menu
Button resume;

//levelStartScreen
float startFrame = 0;

void mouseWheel(MouseEvent e) {
  if (e.getCount() > 0) {
    rotation--;
  }
  if (e.getCount() < 0) {
    rotation++;
  }
  if (rotation < 0) {
    rotation = 3;
  }
  if (rotation > 3) {
    rotation = 0;
  }
}

void mouseReleased() {
  mHeld = false;
  if (recording) {
    println(recording);
  }
}

void keyPressed() {
  String k = "";
  if (key == ESC) {
    key = 0;
    switch (phase) {
    case 0:
      exit();
      break;
    case 4:
      saveLevel();
    case 2:
      loadControls();
    case 1:
      setPhase(0);
      break;
    case 3:
      phase = 5;
      break;
    case 5:
      phase = 3;
    }
  } else {
    if (key != CODED) {
      k = str(key);
    } else {
      if (keyCode == UP) {
        k = "up";
      }
      if (keyCode == DOWN) {
        k = "down";
      }
      if (keyCode == RIGHT) {
        k = "right";
      }
      if (keyCode == LEFT) {
        k = "left";
      }
    }
    if (!keys.hasValue(k)) {
      keys.append(k);
    }
  }
}

void keyReleased() {
  kHeld = false;
  String k = "";
  if (key != CODED) {
    k = str(key);
  } else {
    if (keyCode == UP) {
      k = "up";
    }
    if (keyCode == DOWN) {
      k = "down";
    }
    if (keyCode == RIGHT) {
      k = "right";
    }
    if (keyCode == LEFT) {
      k = "left";
    }
  }
  if (keys.index(k) != -1) {
    keys.remove(keys.index(k));
  }
}

void setup() {
  fullScreen();
  DEFAULTFONT = createFont("arial", 20);
  SETTINGS = loadStrings("data/settings.txt");
  currentState = new int[2];
  loadState(1);
}

void draw() {
  strokeWeight(3);
  switch(phase) {
  case -1:
    exit();
    break;
  case 0:
    background(black);
    loadMainMenu();
    break;
  case 1:
    background(black);
    loadSaveSlotMenu();
    break;
  case 2:
    background(black);
    loadSettings();
    break;
  case 3:
    background(black);
    loadGame();
    break;
  case 4:
    background(black);
    loadBuilder();
    break;
  case 5:
    loadPauseMenu(Testing);
    break;
  }
  println(phase);
  if (p1 != null) {
    println("x: "+str(p1.x));
    println("y: "+str(p1.y));
  }
}
