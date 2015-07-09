class Cube extends Obj {
  String CubeLength = "";
  String Zero = "";

  float len;

  Mesher mesher;

  Cube(PrintWriter _writer, float _CubeLength) {
    super(_writer);
    mesher = new Mesher();


    this.CubeLength = mesher.double2e(_CubeLength);
    Zero = mesher.int2e(0);
    len = _CubeLength;
  }

  void drawObj() {
    beginShape();
    vertex(0, 0, 0);
    vertex(len, 0, 0);
    vertex(len, 0, len);
    endShape(CLOSE);
    beginShape();
    vertex(0, 0, 0);
    vertex(len, 0, len);
    vertex(0, 0, len);
    endShape(CLOSE);


    beginShape();
    vertex(0, 0, 0);
    vertex(len, 0, 0);
    vertex(len, len, 0);
    endShape(CLOSE);
    beginShape();
    vertex(0, 0, 0);
    vertex(len, len, 0);
    vertex(0, len, 0);
    endShape(CLOSE);



    beginShape();
    vertex(0, 0, 0);
    vertex(0, len, 0);
    vertex(0, len, len);
    endShape(CLOSE);
    beginShape();
    vertex(0, 0, 0);
    vertex(0, len, len);
    vertex(0, 0, len);
    endShape(CLOSE);


    beginShape();
    vertex(0, 0, len);
    vertex(len, 0, len);
    vertex(len, len, len);
    endShape(CLOSE);
    beginShape();
    vertex(0, 0, len);
    vertex(len, len, len);
    vertex(0, len, len);
    endShape(CLOSE);


    beginShape();
    vertex(0, len, 0);
    vertex(len, len, 0);
    vertex(len, len, len);
    endShape(CLOSE);
    beginShape();
    vertex(0, len, 0);
    vertex(len, len, len);
    vertex(0, len, len);
    endShape(CLOSE);

    beginShape();
    vertex(len, 0, 0);
    vertex(len, len, 0);
    vertex(len, len, len);
    endShape(CLOSE);
    beginShape();
    vertex(len, 0, 0);
    vertex(len, len, len);
    vertex(len, 0, len);
    endShape(CLOSE);
  }

  void outputSTLFile() {
    super.writer.println("solid Object");

    mesher.facet(super.writer, zero, minus, zero);
    mesher.vertex3(super.writer, Zero, Zero, Zero, CubeLength, Zero, Zero, CubeLength, Zero, CubeLength);
    mesher.facet(super.writer, zero, minus, zero);
    mesher.vertex3(super.writer, Zero, Zero, Zero, CubeLength, Zero, CubeLength, Zero, Zero, CubeLength);

    mesher.facet(super.writer, zero, zero, minus);
    mesher.vertex3(super.writer, Zero, Zero, Zero, CubeLength, Zero, Zero, CubeLength, CubeLength, Zero);
    mesher.facet(super.writer, zero, zero, minus);
    mesher.vertex3(super.writer, Zero, Zero, Zero, CubeLength, CubeLength, Zero, Zero, CubeLength, Zero);

    mesher.facet(super.writer, minus, zero, zero);
    mesher.vertex3(super.writer, Zero, Zero, Zero, Zero, CubeLength, Zero, Zero, CubeLength, CubeLength);
    mesher.facet(super.writer, minus, zero, zero);
    mesher.vertex3(super.writer, Zero, Zero, Zero, Zero, CubeLength, CubeLength, Zero, Zero, CubeLength);

    mesher.facet(super.writer, zero, zero, plus);
    mesher.vertex3(super.writer, Zero, Zero, CubeLength, CubeLength, Zero, CubeLength, CubeLength, CubeLength, CubeLength);
    mesher.facet(super.writer, zero, zero, plus);
    mesher.vertex3(super.writer, Zero, Zero, CubeLength, CubeLength, CubeLength, CubeLength, Zero, CubeLength, CubeLength);

    mesher.facet(super.writer, zero, plus, zero);
    mesher.vertex3(super.writer, Zero, CubeLength, Zero, CubeLength, CubeLength, Zero, CubeLength, CubeLength, CubeLength);
    mesher.facet(super.writer, zero, plus, zero);
    mesher.vertex3(super.writer, Zero, CubeLength, Zero, CubeLength, CubeLength, CubeLength, Zero, CubeLength, CubeLength);

    mesher.facet(super.writer, plus, zero, zero);
    mesher.vertex3(super.writer, CubeLength, Zero, Zero, CubeLength, CubeLength, Zero, CubeLength, CubeLength, CubeLength);
    mesher.facet(super.writer, plus, zero, zero);
    mesher.vertex3(super.writer, CubeLength, Zero, Zero, CubeLength, CubeLength, CubeLength, CubeLength, Zero, CubeLength);
    
    super.writer.println("endsolid");
  }
}

