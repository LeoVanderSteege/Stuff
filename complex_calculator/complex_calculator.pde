import controlP5.*;

float[][] graph;

float zoom = 350;

float m = 0.4;

int sx = -700, sy = -500;

ControlP5 cp5;

color depth(float d) {
  //return color(d>255 ? 255 : 0,map(d, 18, 36, 0, 255),map(d, 0, 18, 0, 255));
  return color(map(d, 0, 3, 0, 255),map(d, 3, 6, 0, 255),map(d, 6, 9, 0, 255));
}

float[] u = number(4, 6);
float[] z = number(0.25, 1);

float execute(float[] c, int d, int n) {
  float[] z = {0, 0};
  for (int i = 0; i < d; i++) {
    z = powNums(z, n);
    z = addNums(z, c);
    if (dist(0, 0, z[0], z[1]) > 2) {
      return i;
    }
  }
  return d;
}

void setup() {
  size(1400, 1000);
  noLoop();
}

void draw() {
  background(51);
  translate(-sx, -sy);
  for (float x = sx/zoom; x < (sx+width)/zoom; x+=1/zoom) {
    for (float y = sy/zoom; y < (sy+height)/zoom; y+=1/zoom) {
      float[] c = {x, y};
      float p = execute(c, 400, 2);
      set(int(x*zoom)-sx, int(y*zoom)-sy, depth(p*m));
    }
  }
  translate(sx, sy);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}
