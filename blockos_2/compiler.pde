ArrayList<block> Strings() {
  ArrayList<block> s = new ArrayList<block>();
  for (block i : blocks) {
    if (i.type == 0 || i.type == 3) {
      s.add(i);
    }
  }
  return s;
}

block argument(int in, block b) {
  block h = b.stuck[1];
  for (int i = 0; i < in; i++) {
    h = h.stuck[1];
  }
  return h;
}

//String compileBlock(block i) {
//  String c = "import java.util.Map.*;\n";
//  if (i.type == 0) {
//    c += "void "+i.code+"() {";
//  }
//  if (i.type == 1 || i.type == 3) {
//    String[] s = split(i.code, '§');
//    for (String o : s) {
//      if (o.length() == 1) {
//        block d = argument(int(o), i);
//        String[] h = split(d.code, '§');
//        for (String p : h) {
//          if (p.length() > 0 && p.charAt(0) == 'V') {
//            c += d.value;
//          } else {
//            c += p;
//          }
//        }
//      } else {
//        c += o;
//      }
//    }
//  }
//  c += "\n";
//  return c;
//}

String compileBlock(block i) {
  String c = "";
  if (i.type == 0) {
    c += i.code+" {";
  }
  if (i.type == 1 || i.type == 3) {
    String[] s = split(i.code, '§');
    for (String o : s) {
      if (o.length() == 1) {
        block d = argument(int(o), i);
        String[] h = split(d.code, '§');
        for (String p : h) {
          if (p.length() > 0 && p.charAt(0) == 'V') {
            c += d.value;
          } else {
            c += p;
          }
        }
      } else {
        c += o;
      }
    }
  }
  c += "\n";
  return c;
}

String compileStrings(ArrayList<block> a) {
  String c = "";
  for (block i : a) {
    block j = i;
    boolean t = true;
    while (t) {
      c += compileBlock(j);
      if (j.stuck[0] != null) {
        j = j.stuck[0];
      } else {
        t = false;
      }
    }
    if (i.type == 0) {
      c += "}\n";
    }
  }
  return c;
}
