float[] number(float r, float c) {
  float[] z = {r, c, 0};
  return z;
}

float[] variable() {
  float[] z = {0, 0, 1};
  return z;
}

float[] addNums(float[] n1, float[] n2) {
  float[] z = {n1[0]+n2[0], n1[1]+n2[1]};
  return z;
}

float[] subNums(float[] n1, float[] n2) {
  float[] z = {n1[0]-n2[0], n1[1]-n2[1]};
  return z;
}

float[] mulNums(float[] n1, float[] n2) {
  float[] z = {(n1[0]*n2[0])+(n1[1]*n2[1])*-1, (n1[0]*n2[1])+(n1[1]*n2[0])};
  return z;
}

float[] divNums(float[] n1, float[] n2) {
  float[] z = {(n1[0]/n2[0])+(n1[1]/n2[1])*-1, (n1[0]/n2[1])+(n1[1]/n2[0])};
  return z;
}

float[] powNums(float[] n1, float a) {
  float[] u = new float[2];
  u = n1;
  for (int i = 1; i < a; i++) {
    u = mulNums(u, n1);
  }
  return u;
}
