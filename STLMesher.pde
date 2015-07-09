class Mesher {

  PrintWriter writer;
  String tab = "    ";  //3 spaces

  //int2e(); double2e();
  int data_d2e[] = new int[10];
  int int2eCount=0;
  int double2eCount = 0;
  int digit;

  Mesher(){
  }
  Mesher(PrintWriter _writer) {
    this.writer = _writer;
  }


  //Function
  //=========writing STL==============
  void facet(PrintWriter writer, String x, String y, String z) {
    writer.println(tab + "facet normal " + x + " " + y + " " + z);
  }

  void vertex3(PrintWriter writer, String x1, String y1, String z1, String x2, String y2, String z2, String x3, String y3, String z3) {
    writer.println(tab+tab + "outer loop");
    writer.println(tab+tab+tab + "vertex " + x1 + " " + y1 + " " + z1);
    writer.println(tab+tab+tab + "vertex " + x2 + " " + y2 + " " + z2);
    writer.println(tab+tab+tab + "vertex " + x3 + " " + y3 + " " + z3);
    writer.println(tab+tab + "endloop");
    writer.println(tab + "endfacet");
  }


  //========Util============
  // convert integer to exponent notaion(String)
  String int2e(int num) {
    if (num == 0) return "0.000000e+00";


    while (num > 0) {
      data_d2e[int2eCount] = num%10;
      num /= 10;
      int2eCount ++;
    }

    String ans = new String();
    digit = int2eCount-1;
    int2eCount --;
    ans += data_d2e[int2eCount] + ".";
    int2eCount--;

    while (int2eCount >= 0) {
      ans += data_d2e[int2eCount];
      int2eCount --;
    }
    ans += "e+0" + digit;
    return ans;
  }

  // convert double to exponent notaion(String)
  String double2e(double num) {
    double2eCount = 0;
    if (num == 0.0 ) return "0.000000E+00";
    if (num < 0.1E-05 && num > -0.1E-010) return "0.000000E+00";


    if (num >= 10) {
      while (num > 10) {
        num /= 10;
        double2eCount ++;
      }

      String Ans = nf((float)num, 1, 6);
      Ans += "E+0";
      Ans += str(double2eCount);

      return Ans;
    } else if (num >= 0.1) {


      String Ans = nf((float)num, 1, 6);
      Ans += "E+0" + str(double2eCount);

      return Ans;
    } else if (num < 0.1 && num > -0.1) {

      while ( num > -0.1 && num < 0.1) {
        num *= 10;
        double2eCount++;
      }
      String Ans = nf((float)num, 1, 6);
      Ans += "E-0" + str(double2eCount);
      return Ans;
    } else if (num <-0.1 && num > -10) {

      String Ans = nf((float)num, 1, 6);
      Ans += "E+0" + str(double2eCount);

      return Ans;
    } else if (num < -10) {
      while ( num < -10) {
        num /= 10;
        double2eCount++;
      }

      String Ans = nf((float)num, 1, 6);
      Ans += "E+0" + str(double2eCount);
      return Ans;
    } else {
      return null;
    }
  }
  
  void triMesh(PVector point1, PVector point2, PVector point3){
    beginShape();
    vertex(point1.x, point1.y, point1.z);
    vertex(point2.x, point2.y, point2.z);
    vertex(point3.x, point3.y, point3.z);
    endShape(CLOSE);
  }


  //make normal Vector
  PVector normalVec(PVector a, PVector b, PVector c) {
    PVector v1 = PVector.sub(b, a);
    PVector v2 = PVector.sub(c, b);

    PVector ans = v1.cross(v2);
    ans.normalize();
    return ans;
  }




  //=====Object=======



  //Bezier Surface


  //Trigonal Pyramid



  //Sphere
  //
}

