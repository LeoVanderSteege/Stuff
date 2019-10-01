public hitbox[] hboxs = new hitbox[10];

public StringList keys = new StringList();

ball b;

paddle p1;
paddle p2;

paddle p3;
paddle p4;

public int p1p = 0;
public int p2p = 0;

boolean uf = true;

String stage = "menu";

public String player = "";

button normal_mode;
button four_pl_mode;

int mode;

void point_scored() {
  stage = "score";
}

void timer(int s) {
  text(str(s), 1920/2, 1080/2+30);
  delay(1000);
}

void keyPressed() {
  if (!keys.hasValue(str(key))) {
    keys.append(str(key));
  }
}

void keyReleased() {
  keys.remove(keys.index(str(key)));
}

void setup() {
  fullScreen();
  normal_mode = new button(1920/2-60, 1080/2-30, 120, 40);
  four_pl_mode = new button(1920/2-70, 1080/2+30, 140, 40);
}

void normal_mode_setup() {
  b = new ball(1920/2, 1080/2, 20, 15);
  p1 = new paddle(50, 1080/2-75, 30, 150, color(255, 0, 0), 0);
  p2 = new paddle(1920-50-30, 1080/2-75, 30, 150, color(0, 0, 255), 1);
}

void four_player_mode_setup() {
  b = new ball(1920/2, 1080/2, 20, 15);
  p1 = new paddle(50, 1080/2+20, 30, 150, color(255, 0, 0), 0);
  p2 = new paddle(1920-50-30, 1080/2+20, 30, 150, color(0, 0, 255), 1);
  p3 = new paddle(50, 1080/2-170, 30, 150, color(255, 200, 0), 2);
  p4 = new paddle(1920-50-30, 1080/2-170, 30, 150, color(0, 255, 0), 3);
}

void draw_field() {
  background(0);
  b.show();
  p1.show();
  p2.show();
  if (p3 != null) {
    p3.show();
    p4.show();
  }
}

void draw() {
  if (uf) {
    background(0);
  }
  textSize(60);
  strokeWeight(5);
  stroke(255);
  if (stage == "menu") {
    textAlign(CENTER);
    textSize(70);
    text("PONG!!!", 1920/2, 400);
    textSize(30);
    fill(0);
    rect(1920/2-60, 1080/2-30, 120, 40);
    rect(1920/2-70, 1080/2+30, 140, 40);
    fill(255);
    text("Normal", 1920/2, 1080/2);
    text("4 Player", 1920/2, 1080/2+60);
    if (normal_mode.check()) {
      stage = "score";
      mode = 0;
      normal_mode_setup();
    }
    if (four_pl_mode.check()) {
      stage = "score";
      mode = 1;
      four_player_mode_setup();
    }
  }
  if (stage == "wait") {
    draw_field();
    delay(2000);
    stage = "game";
  }
  if (stage == "game") {
    textSize(60);
    textAlign(LEFT);
    fill(255);
    text(str(p1p), 50, 65);
    text(str(p2p), 1920-50-30, 65);
    b.update();
    p1.update("w", "s");
    p2.update("i", "k");
    if (p3 != null) {
      p3.update("t", "g");
      p4.update("ü", "ä");
    }
  }
  if (stage == "score") {
    stage = "wait";
    if (mode == 0) {
      normal_mode_setup();
    }
    if (mode == 1) {
      four_player_mode_setup();
    }
    draw_field();
  }
}
