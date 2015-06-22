// from http://stackoverflow.com/questions/9287063/does-dart-have-sprintf-or-does-it-only-have-interpolation

static String format(String fmt,List<Object> params) {
  int matchIndex = 0;
  String replace(Match m) {
    if (matchIndex<params.length) {
      switch (m[4]) {
        case "f":
          num val = params[matchIndex++];
          String str;
          if (m[3]!=null && m[3].startsWith(".")) {
            str = val.toStringAsFixed(int.parse(m[3].substring(1)));
          } else {
            str = val.toString();
          }
          if (m[2]!=null && m[2].startsWith("0")) {
             if (val<0) {
               str = "-"+str.substring(1).padLeft(int.parse(m[2]),"0");
             } else {
               str = str.padLeft(int.parse(m[2]),"0");
             }
          }
          return str;
        case "d":
        case "x":
        case "X":
          int val = params[matchIndex++];
          String str = (m[4]=="d")?val.toString():val.toRadixString(16); 
          if (m[2]!=null && m[2].startsWith("0")) {
            if (val<0) {
              str = "-"+str.substring(1).padLeft(int.parse(m[2]),"0");
            } else {
              str = str.padLeft(int.parse(m[2]),"0");
            }
          }
          return (m[4]=="X")?str.toUpperCase():str.toLowerCase();
        case "s":
          return params[matchIndex++].toString(); 
      }
    } else {
      throw new Exception("Missing parameter for string format");
    }
    throw new Exception("Invalid format string: "+m[0].toString());
  }