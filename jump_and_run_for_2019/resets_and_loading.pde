int setPhase(int p) {
  phase = p;
  unload_all();
  return p;
}

void saveControls() {
  String[] cont = {left.ckey, right.ckey, up.ckey, down.ckey, jump.ckey, ability.ckey, grab.ckey};
  saveStrings("data/settings.txt", cont);
}

boolean loadLevel(int ln, int lw) {
  XML level = loadXML("data/levels/level_"+ln+"-"+lw+".xml");
  if (level == null) {
    return false;
  }
  int in = 0;
  XML[] z = level.getChildren("solid");
  for (XML i : z) {
    blocks[in] = new block(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), float(i.getChild("wi").getContent()), float(i.getChild("he").getContent()), boolean(int(i.getChild("ki").getContent())), float(i.getChild("rc").getContent()));
    in++;
  }
  XML k = level.getChild("goal");
  if (k != null) {
    levelGoal = new goal(float(k.getChild("xp").getContent()), float(k.getChild("yp").getContent()), float(k.getChild("wi").getContent()), float(k.getChild("he").getContent()));
  }
  in = 0;
  XML[] p = level.getChildren("switch");
  for (XML i : p) {
    switches[in] = new colorSwitch(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), boolean(int(i.getChild("st").getContent())), color(int(i.getChild("rc").getContent()), int(i.getChild("gc").getContent()), 200));
    in++;
  }
  XML[] a = level.getChildren("gate");
  for (XML i : a) {
    gates[in] = new gate(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), float(i.getChild("wi").getContent()), float(i.getChild("he").getContent()), boolean(int(i.getChild("st").getContent())), color(int(i.getChild("rc").getContent()), int(i.getChild("gc").getContent()), 200));
    in++;
  }
  in = 0;
  XML[] e = level.getChildren("boost");
  for (XML i : e) {
    boosts[in] = new boostPad(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), float(i.getChild("wi").getContent()), float(i.getChild("he").getContent()));
    in++;
  }
  in = 0;
  XML[] g = level.getChildren("ball");
  for (XML i : g) {
    balls[in] = new ball(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), float(i.getChild("ra").getContent()), boolean(int(i.getChild("ki").getContent())), float(i.getChild("xs").getContent()));
    in++;
  }
  in = 0;
  XML[] u = level.getChildren("trigger");
  for (XML i : u) {
    triggers[in] = new trigger(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()), float(i.getChild("wi").getContent()), float(i.getChild("he").getContent()), boolean(int(i.getChild("st").getContent())), color(int(i.getChild("rc").getContent()), int(i.getChild("gc").getContent()), 200));
    in++;
  }
  in = 0;
  XML[] l = level.getChildren("cannon");
  for (XML i : l) {
    cannons[in] = new cannon(float(i.getChild("xp").getContent()), float(i.getChild("yp").getContent()));
    in++;
  }
  return true;
}

void loadControls() {
  SETTINGS = loadStrings("data/settings.txt");
}

int loadSlot(int slot) {
  loadState(slot);
  unload_all();
  background(black);
  setPhase(3);
  return 0;
}

void loadGame() {
  if (p1 == null || blocks == null || levelGoal == null) {
    xOffset = 0;
    yOffset = 0;
    blocks = new block[100];
    switches = new colorSwitch[20];
    gates = new gate[60];
    boosts = new boostPad[20];
    balls = new ball[20];
    triggers = new trigger[20];
    cannons = new cannon[20];
    loadLevel(currentState[0], currentState[1]);
    if (levelGoal == null) {
      levelGoal = new goal(2000, height-580, 40, 400);
    }
    startFrame = frameCount;
    p1 = new player(60, 800, levelGoal);
  }
  if (startFrame != 0 && frameCount - startFrame < 90) {
    levelStartScreen(currentState[0], currentState[1]);
  } else {
    if (p1.x > 930) {
      xOffset = p1.x-930;
    } else {
      xOffset = 0;
    }
    if (p1.y < 510) {
      yOffset = 510-p1.y;
    } else {
      yOffset = 0;
    }
    levelGoal.update();
    p1.update();
  }
}

void loadState(int slot) {
  String[] u = loadStrings("data/slot"+str(slot)+".txt");
  currentState[0] = int(u[0]);
  currentState[1] = int(u[1]);
}

void unload_all() {
  play = null;
  settings = null;
  exit_game = null;
  left = null;
  right = null;
  up = null;
  down = null;
  jump = null;
  ability = null;
  grab = null;
  slot1 = null;
  slot2 = null;
  slot3 = null;
  blockTool = null;
  test = null;
  objectWidth = null;
  objectHeight = null;
  p1 = null;
  blocks = null;
  levelWorld = null;
  levelNum = null;
  loadL = null;
  levelGoal = null;
}

void saveLevel() {
  StringList z = new StringList();
  z.append("<level>");
  for (block i : blocks) {
    if (i != null) {
      z.append("<solid>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<wi>"+str(i.w)+"</wi>");
      z.append("<he>"+str(i.h)+"</he>");
      z.append("<ki>"+str((i.kill) ? 1 : 0)+"</ki>");
      z.append("<rc>"+str(i.r)+"</rc>");
      z.append("</solid>");
    }
  }
  for (colorSwitch i : switches) {
    if (i != null) {
      z.append("<switch>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<rc>"+str(red(i.sc))+"</rc>");
      z.append("<gc>"+str(green(i.sc))+"</gc>");
      z.append("<st>"+str((i.ostate) ? 1 : 0)+"</st>");
      z.append("</switch>");
    }
  }
  for (gate i : gates) {
    if (i != null) {
      z.append("<gate>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<wi>"+str(i.w)+"</wi>");
      z.append("<he>"+str(i.h)+"</he>");
      z.append("<rc>"+str(red(i.c))+"</rc>");
      z.append("<gc>"+str(green(i.c))+"</gc>");
      z.append("<st>"+str((i.ostate) ? 1 : 0)+"</st>");
      z.append("</gate>");
    }
  }
  for (boostPad i : boosts) {
    if (i != null) {
      z.append("<boost>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<wi>"+str(i.w)+"</wi>");
      z.append("<he>"+str(i.h)+"</he>");
      z.append("</boost>");
    }
  }
  for (ball i : balls) {
    if (i != null) {
      z.append("<ball>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<ra>"+str(i.r)+"</ra>");
      z.append("<xs>"+str(i.xs)+"</xs>");
      z.append("<ki>"+str((i.kill) ? 1 : 0)+"</ki>");
      z.append("</ball>");
    }
  }
  for (trigger i : triggers) {
    if (i != null) {
      z.append("<trigger>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("<wi>"+str(i.w)+"</wi>");
      z.append("<he>"+str(i.h)+"</he>");
      z.append("<rc>"+str(red(i.sc))+"</rc>");
      z.append("<gc>"+str(green(i.sc))+"</gc>");
      z.append("<st>"+str((i.ostate) ? 1 : 0)+"</st>");
      z.append("</trigger>");
    }
  }
  for (cannon i : cannons) {
    if (i != null) {
      z.append("<cannon>");
      z.append("<xp>"+str(i.x)+"</xp>");
      z.append("<yp>"+str(i.y)+"</yp>");
      z.append("</cannon>");
    }
  }
  z.append("<goal>");
  z.append("<xp>"+str(levelGoal.x)+"</xp>");
  z.append("<yp>"+str(levelGoal.y)+"</yp>");
  z.append("<wi>"+str(levelGoal.w)+"</wi>");
  z.append("<he>"+str(levelGoal.h)+"</he>");
  z.append("</goal>");
  z.append("</level>");
  saveStrings("data/levels/level_"+levelNum.entry+"-"+levelWorld.entry+".xml", z.array());
  currentState[1] = int(levelWorld.entry);
  currentState[0] = int(levelNum.entry);
  Testing = true;
}

void loadPauseMenu(boolean b) {
  int i = 0;
  if (exit_game == null || resume == null) {
    exit_game = new Button(width/2, height/2+((b) ? 80 : 10), 200, 50, "MAIN MENU").setColor(black, white, white);
    resume = new Button(width/2, height/2-60, 200, 50, "RESUME").setColor(black, white, white);
    if (b) {
      create = new Button(width/2, height/2+10, 200, 50, "BUILDER").setColor(black, white, white);
    }
  }
  phase = (resume.update()) ? 3 : phase;
  i = (exit_game.update()) ? setPhase(0) : 0;
  if (b && create != null) {
    i = (create.update()) ? setPhase(4) : 0;
  }
}

//-------------------------------------------------------------------------------------------------||-------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------_||_------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------\  /------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------\/-------------------------------------------------------------------------------------------------------------------------

void loadBuilder() {
  if (blockTool == null || test == null || objectWidth == null || objectHeight == null || blocks == null || deleteTool == null || levelWorld == null || levelNum == null || loadL == null) {
    Testing = false;
    xOffset = 0;
    yOffset = 0;
    rotation = 0;
    triggerTool = new Button(width/2-100, height-120, 200, 30, "TRIGGER").setColor(black, white, white);
    cannonTool = new Button(width/2-310, height-120, 200, 30, "CANNON").setColor(black, white, white);
    ballTool = new Button(width/2-100, height-80, 200, 30, "BALL").setColor(black, white, white);
    switchTool = new Button(width/2-310, height-80, 200, 30, "SWITCH").setColor(black, white, white);
    gateTool = new Button(width/2-100, height-40, 200, 30, "GATE").setColor(black, white, white);
    boostTool = new Button(width/2-310, height-40, 200, 30, "BOOST").setColor(black, white, white);
    goalTool = new Button(width/2+110, height-80, 200, 30, "GOAL").setColor(black, teal, teal);
    blockTool = new Button(width/2+110, height-120, 200, 30, "BLOCK").setColor(black, teal, teal);
    deleteTool = new Button(width/2+110, height-40, 200, 30, "DELETE").setColor(black, teal, teal);
    test = new Button(width-110, height-110, 100, 100, "TEST").setColor(black, white, white);
    loadL = new Button(width-220, height-110, 100, 100, "LOAD").setColor(black, white, white);
    objectHeight = new textField(100, height-60, 200, 50, "HEIGHT", "2", true).setColor(black, white, white);
    objectWidth = new textField(100, height-120, 200, 50, "WIDTH", "2", true).setColor(black, white, white);
    redColor = new textField(400, height-120, 200, 50, "RED", "255", true).setColor(black, white, white);
    greenColor = new textField(400, height-60, 200, 50, "GREEN", "255", true).setColor(black, white, white);
    levelWorld = new textField(width-350, height-60, 100, 50, "WORLD", str(currentState[1]), true).setColor(black, white, white);
    levelNum = new textField(width-350, height-120, 100, 50, "NUM", str(currentState[0]), true).setColor(black, white, white);
    blocks = new block[100];
    switches = new colorSwitch[20];
    gates = new gate[100];
    boosts = new boostPad[20];
    balls = new ball[20];
    triggers = new trigger[20];
    cannons = new cannon[20];
    killBlock = new Toggle(width-470, height-120, 40, 40, "KILL", false).setColor(black, white, teal);
    if (!loadLevel(currentState[0], currentState[1])) {
      blocks[0] = new block(0, height-180, 2000, 20000, false, 255);
      blocks[0].ground = true;
    }
    if (levelGoal == null) {
      levelGoal = new goal(2000, height-580, 200, 200);
    }
  }
  int iterval = 5;
  if (keys.hasValue("left") && xOffset >= 100 && frameCount - lcm >= iterval) {
    xOffset -= 100;
    lcm = frameCount;
  }
  if (keys.hasValue("right") && frameCount - lcm >= iterval) {
    xOffset += 100;
    lcm = frameCount;
  }
  if (keys.hasValue("down") && yOffset >= 100 && frameCount - lcm >= iterval) {
    yOffset -= 100;
    lcm = frameCount;
  }
  if (keys.hasValue("up") && frameCount - lcm >= iterval) {
    yOffset += 100;
    lcm = frameCount;
  }
  for (int i = 0; i < height; i += 100) {
    stroke(200);
    //(1);
    line(0, i, width, i);
  }
  for (int i = 0; i < width; i += 100) {
    stroke(200);
    //(1);
    line(i, 0, i, height);
  }
  for (boostPad i : boosts) {
    if (i != null) {
      i.update();
    }
  }
  for (block i : blocks) {
    if (i != null) {
      i.update();
    }
  }
  for (colorSwitch i : switches) {
    if (i != null) {
      i.update();
    }
  }
  for (gate i : gates) {
    if (i != null) {
      i.update(true);
    }
  }
  for (ball i : balls) {
    if (i != null) {
      if (i.kill) {
        fill(red);
        stroke(maroon);
        ellipse(i.x-xOffset, i.y+yOffset, i.r, i.r);
      } else {
        fill(cyan);
        stroke(blue);
        ellipse(i.x-xOffset, i.y+yOffset, i.r, i.r);
      }
    }
  }
  for (trigger i : triggers) {
    if (i != null) {
      i.update();
    }
  }
  for (cannon i : cannons) {
    if (i != null) {
      i.update();
    }
  }
  levelGoal.update();
  float gridFactor = 100;
  float w = float(objectWidth.entry)*100;
  float h = float(objectHeight.entry)*100;
  float x = (rotation == 0) ? mouseX : (rotation == 1) ? mouseX : (rotation == 2) ? mouseX-w : mouseX-h;
  float y = (rotation == 0) ? mouseY : (rotation == 1) ? mouseY-w : (rotation == 2) ? mouseY-h : mouseY;
  float rw = (rotation == 0 || rotation == 2) ? w : h;
  float rh = (rotation == 0 || rotation == 2) ? h : w;
  x = int((x)/gridFactor)*gridFactor;
  y = int((y)/gridFactor)*gridFactor;
  if (selectedTool != 2) {
    fill(grey);
    stroke(white);
    if (selectedTool != 4 && selectedTool != 7 && selectedTool != 9) {
      rect(x, y, rw, rh);
    } else {
      rect(x, y, 100, 100);
    }
  }
  fill(grey);
  stroke(black);
  rect(0, height-130, width, 150);
  killBlock.update();
  selectedTool = (blockTool.update()) ? 1 : selectedTool;
  selectedTool = (deleteTool.update()) ? 2 : selectedTool;
  selectedTool = (goalTool.update()) ? 3 : selectedTool;
  selectedTool = (switchTool.update()) ? 4 : selectedTool;
  selectedTool = (gateTool.update()) ? 5 : selectedTool;
  selectedTool = (boostTool.update()) ? 6 : selectedTool;
  selectedTool = (ballTool.update()) ? 7 : selectedTool;
  selectedTool = (triggerTool.update()) ? 8 : selectedTool;
  selectedTool = (cannonTool.update()) ? 9 : selectedTool;
  objectWidth.update();
  objectHeight.update();
  levelWorld.update();
  levelNum.update();
  redColor.update();
  greenColor.update();
  blockTool.setBGColor(teal);
  deleteTool.setBGColor(teal);
  goalTool.setBGColor(teal);
  switchTool.setBGColor(white);
  gateTool.setBGColor(white);
  boostTool.setBGColor(white);
  ballTool.setBGColor(white);
  triggerTool.setBGColor(white);
  cannonTool.setBGColor(white);
  if (!test.update()) {
    switch(selectedTool) {
    case 1:
      blockTool.setBGColor(cyan);
      break;
    case 2:
      deleteTool.setBGColor(cyan);
      break;
    case 3:
      goalTool.setBGColor(cyan);
      break;
    case 4:
      switchTool.setBGColor(cyan);
      break;
    case 5:
      gateTool.setBGColor(cyan);
      break;
    case 6:
      boostTool.setBGColor(cyan);
      break;
    case 7:
      ballTool.setBGColor(cyan);
      break;
    case 8:
      triggerTool.setBGColor(cyan);
      break;
    case 9:
      cannonTool.setBGColor(cyan);
      break;
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 1) {
      mHeld = true;
      place = false;
      for (int i = 0; i < blocks.length; i++) {
        if (!place && blocks[i] == null) {
          place = true;
          blocks[i] = new block((x+xOffset), (y-yOffset), rw, rh, killBlock.state, float(redColor.entry));
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 3) {
      mHeld = true;
      levelGoal = new goal((x+xOffset), (y-yOffset), rw, rh);
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 2) {
      mHeld = true;
      place = false;
      for (int i = 0; i < blocks.length; i++) {
        if (!place && blocks[i] != null) {
          if (mouseX+xOffset > blocks[i].x && mouseX+xOffset < blocks[i].x+blocks[i].w && mouseY-yOffset > blocks[i].y && mouseY-yOffset < blocks[i].y+blocks[i].h && blocks[i] != blocks[0]) {
            place = true;
            blocks[i] = null;
          }
        }
      }
      for (int i = 0; i < gates.length; i++) {
        if (!place && gates[i] != null) {
          if (mouseX+xOffset > gates[i].x && mouseX+xOffset < gates[i].x+gates[i].w && mouseY-yOffset > gates[i].y && mouseY-yOffset < gates[i].y+gates[i].h) {
            place = true;
            gates[i] = null;
          }
        }
      }
      for (int i = 0; i < switches.length; i++) {
        if (!place && switches[i] != null) {
          if (mouseX+xOffset > switches[i].x && mouseX+xOffset < switches[i].x+100 && mouseY-yOffset > switches[i].y && mouseY-yOffset < switches[i].y+100) {
            place = true;
            switches[i] = null;
          }
        }
      }
      for (int i = 0; i < boosts.length; i++) {
        if (!place && boosts[i] != null) {
          if (mouseX+xOffset > boosts[i].x && mouseX+xOffset < boosts[i].x+boosts[i].w && mouseY-yOffset > boosts[i].y && mouseY-yOffset < boosts[i].y+boosts[i].h) {
            place = true;
            boosts[i] = null;
          }
        }
      }
      for (int i = 0; i < balls.length; i++) {
        if (!place && balls[i] != null) {
          if (mouseX+xOffset > balls[i].x-50 && mouseX+xOffset < balls[i].x+50 && mouseY-yOffset > balls[i].y-50 && mouseY-yOffset < balls[i].y+50) {
            place = true;
            balls[i] = null;
          }
        }
      }
      for (int i = 0; i < triggers.length; i++) {
        if (!place && triggers[i] != null) {
          if (mouseX+xOffset > triggers[i].x && mouseX+xOffset < triggers[i].x+triggers[i].w && mouseY-yOffset > triggers[i].y && mouseY-yOffset < triggers[i].y+triggers[i].h) {
            place = true;
            triggers[i] = null;
          }
        }
      }
      for (int i = 0; i < cannons.length; i++) {
        if (!place && cannons[i] != null) {
          if (mouseX+xOffset > cannons[i].x && mouseX+xOffset < cannons[i].x+100 && mouseY-yOffset > cannons[i].y && mouseY-yOffset < cannons[i].y+100) {
            place = true;
            cannons[i] = null;
          }
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 4) {
      mHeld = true;
      place = false;
      for (int i = 0; i < switches.length; i++) {
        if (!place && switches[i] == null) {
          place = true;
          switches[i] = new colorSwitch((x+xOffset), (y-yOffset), !killBlock.state, color(int(redColor.entry), int(greenColor.entry), 200));
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 5) {
      mHeld = true;
      place = false;
      for (int i = 0; i < gates.length; i++) {
        if (!place && gates[i] == null) {
          place = true;
          gates[i] = new gate((x+xOffset), (y-yOffset), rw, rh, killBlock.state, color(int(redColor.entry), int(greenColor.entry), 200));
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 6) {
      mHeld = true;
      place = false;
      for (int i = 0; i < boosts.length; i++) {
        if (!place && boosts[i] == null) {
          place = true;
          boosts[i] = new boostPad((x+xOffset), (y-yOffset), rw, rh);
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 7) {
      mHeld = true;
      place = false;
      for (int i = 0; i < balls.length; i++) {
        if (!place && balls[i] == null) {
          place = true;
          balls[i] = new ball((x+xOffset)+50, (y-yOffset)+50, 60, killBlock.state, 16);
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 8) {
      mHeld = true;
      place = false;
      for (int i = 0; i < triggers.length; i++) {
        if (!place && triggers[i] == null) {
          place = true;
          triggers[i] = new trigger((x+xOffset), (y-yOffset), rw, rh, !killBlock.state, color(int(redColor.entry), int(greenColor.entry), 200));
        }
      }
    }
    if (mousePressed && !mHeld && mouseY < height-130 && selectedTool == 9) {
      mHeld = true;
      place = false;
      for (int i = 0; i < cannons.length; i++) {
        if (!place && cannons[i] == null) {
          place = true;
          cannons[i] = new cannon((x+xOffset), (y-yOffset));
        }
      }
    }
  } else {
    saveLevel();
    setPhase(3);
  }
  if (loadL != null && loadL.update()) {
    currentState[0] = int(levelNum.entry);
    currentState[1] = int(levelWorld.entry);
    unload_all();
  }
}

void loadMainMenu() {
  int i = 0;
  if (play == null || settings == null || exit_game == null || create == null) {
    play = new Button(width/2-100, height/2-95, 200, 50, "PLAY").setColor(black, white, white);
    create = new Button(width/2-100, height/2-25, 200, 50, "CREATE").setColor(black, white, white);
    settings = new Button(width/2-100, height/2+45, 200, 50, "SETTINGS").setColor(black, white, white);
    exit_game = new Button(width/2-100, height/2+115, 200, 50, "EXIT").setColor(black, white, white);
  }
  i = (play.update()) ? setPhase(1) : i;
  i = (create != null && create.update()) ? setPhase(4) : i;
  i = (settings != null && settings.update()) ? setPhase(2) : i;
  i = (exit_game != null && exit_game.update()) ? setPhase(-1) : i;
}

void loadSaveSlotMenu() {
  int i = 0;
  if (play == null || settings == null || exit_game == null) {
    slot1 = new Button(width/2-100, height/2-95, 200, 50, "SAVE SLOT 1").setColor(black, white, white);
    slot2 = new Button(width/2-100, height/2-25, 200, 50, "SAVE SLOT 2").setColor(black, white, white);
    slot3 = new Button(width/2-100, height/2+45, 200, 50, "SAVE SLOT 3").setColor(black, white, white);
  }
  i = (slot1.update()) ? loadSlot(1) : i;
  i = (slot2 != null && slot2.update()) ? loadSlot(2) : i;
  i = (slot3 != null && slot3.update()) ? loadSlot(3) : i;
}

void loadSettings() {
  if (left == null || right == null || up == null || down == null || jump == null || ability == null || grab == null) {
    loadControls();
    left = new chooseKey(width/2, height/2-235, 100, 50, SETTINGS[0], "LEFT").setColor(black, white, red);
    right = new chooseKey(width/2, height/2-165, 100, 50, SETTINGS[1], "RIGHT").setColor(black, white, red);
    up = new chooseKey(width/2, height/2-95, 100, 50, SETTINGS[2], "SPRINT").setColor(black, white, red);
    down = new chooseKey(width/2, height/2-25, 100, 50, SETTINGS[3], "INTERACT").setColor(black, white, red);
    jump = new chooseKey(width/2, height/2+45, 100, 50, SETTINGS[4], "JUMP").setColor(black, white, red);
    ability = new chooseKey(width/2, height/2+115, 100, 50, SETTINGS[5], "ABILITY").setColor(black, white, red);
    grab = new chooseKey(width/2, height/2+185, 100, 50, SETTINGS[6], "GRAB").setColor(black, white, red);
  }
  left.update();
  right.update();
  up.update();
  down.update();
  jump.update();
  ability.update();
  grab.update();
}

void levelStartScreen(int w, int n) {
  background(black);
  fill(white);
  text(str(w)+"-"+str(n), width/2, height/2);
}

boolean isPressed(String k) {
  switch (k.charAt(0)) {
  case 'm':
    if (mousePressed) {
      switch(mouseButton) {
      case LEFT:
        if (k.charAt(1) == '0') {
          return true;
        }
        break;
      case CENTER:
        if (k.charAt(1) == '1') {
          return true;
        }
        break;
      case RIGHT:
        if (k.charAt(1) == '2') {
          return true;
        }
        break;
      }
    } else {
      return false;
    }
    break;
  case 'k':
    if (keys.hasValue(str(k.charAt(1)))) {
      return true;
    }
    break;
  }
  return false;
}

String whatPressed() {
  String k = "";
  if (mousePressed) {
    switch(mouseButton) {
    case LEFT:
      k = "m0";
      break;
    case CENTER:
      k = "m1";
      break;
    case RIGHT:
      k = "m2";
      break;
    }
  }
  if (keyPressed && key != CODED) {
    k = "k"+str(key);
  }
  return k;
}
