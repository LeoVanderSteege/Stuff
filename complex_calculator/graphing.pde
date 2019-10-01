float[][] functionGraph(float[][] i, float r, float s) {
  float[][] u = new float[int(r/s)+1][2];
  float[][] d = i;
  for (float x = 0; x < r; x += s) {
    float[] a = null;
    float[] y = {x, 0, 1};
    i = d;
    println(x, i[2].length);
    i[1] = (i[1][2] == 1) ? y : i[1];
    i[2] = (i[2][2] == 1) ? y : i[2];
    if (i[0][0] == 0) {
      a = addNums(i[1], i[2]);
    }
    if (i[0][0] == 1) {
      a = subNums(i[1], i[2]);
    }
    if (i[0][0] == 2) {
      a = mulNums(i[1], i[2]);
    }
    if (i[0][0] == 3) {
      a = divNums(i[1], i[2]);
    }
    if (i[0][0] == 4) {
      a = powNums(i[1], int(i[2][0]));
    }
    u[int(x/s)] = a;
  }
  return u;
}
