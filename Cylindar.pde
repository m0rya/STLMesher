class Cylindar extends Obj {
  double numData[][];
  String strData[][];
  PVector dataForDraw[];

  float bottom = 0.0;
  float top;

  String Bottom;
  String Top;

  int resolution;
  float radius;

  Mesher mesher;

  Cylindar(PrintWriter _writer, float _radius, float CylindarHeight, int _resolution) {
    super(_writer);
    mesher = new Mesher();

    this.top = CylindarHeight;
    this.resolution = _resolution;
    this.radius = _radius;

    numData = new double[(int)360/resolution + 1][2];
    strData = new String[(int)360/resolution + 1][2];

    Bottom = mesher.double2e(0.0);
    Top    = mesher.double2e(CylindarHeight);

    setNumData();
  }




  void setNumData() {
    for (int i=0; i< (int)360/resolution+1; i++) {
      if (i*resolution == 180) {
        numData[i][0] = 0.0;
      } else {
        numData[i][0] = sin(radians(i*resolution)) * radius;
      }

      if (i*resolution == 90 || i*resolution == 270) {
        numData[i][1] = 0.0;
      } else {
        numData[i][1] = cos(radians(i*resolution)) * radius;
      }
    }
  }



  void drawObj() {
    for (int i=0; i< (int)360/resolution; i++) {

      //BottomMesh
      beginShape();
      vertex(bottom, bottom, bottom);
      vertex((float)numData[i][0], (float)numData[i][1], bottom);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], bottom);
      endShape(CLOSE);

      //TopMesh
      beginShape();
      vertex(bottom, bottom, top);
      vertex((float)numData[i][0], (float)numData[i][1], top);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], top);
      endShape(CLOSE);

      //SideMesh
      beginShape();
      vertex((float)numData[i][0], (float)numData[i][1], top);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], bottom);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], top);
      endShape(CLOSE);

      beginShape();
      vertex((float)numData[i][0], (float)numData[i][1], bottom);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], bottom);
      vertex((float)numData[i][0], (float)numData[i][1], top);
      endShape(CLOSE);
    }
  }

  void convertNumToStr() {
    for (int i=0; i< (int)360/resolution+1; i++) {
      strData[i][0] = mesher.double2e(numData[i][0]);
      strData[i][1] = mesher.double2e(numData[i][1]);
    }
  }

  void outputSTLFile() {
    convertNumToStr();
    super.writer.println("solid Object");

    for (int i=0; i< (int)360/resolution; i++) {
      //bottomMesh
      mesher.facet(super.writer, super.zero, super.zero, super.minus);
      mesher.vertex3(super.writer, super.zero, super.zero, super.zero, strData[i][0], strData[i][1], Bottom, strData[i+1][0], strData[i+1][1], Bottom);

      //topMesh
      mesher.facet(super.writer, super.zero, super.zero, super.plus);
      mesher.vertex3(super.writer, super.zero, super.zero, Top, strData[i][0], strData[i][1], Top, strData[i+1][0], strData[i+1][1], Top);

      //sideMesh

      //make normal vector
      PVector vtxx[][] = new PVector[2][2];
      vtxx[0][0] = new PVector(int(strData[i][0]), int(strData[i][1]), int(Bottom));
      vtxx[0][1] = new PVector(int(strData[i+1][0]), int(strData[i+1][1]), int(Bottom));
      vtxx[1][0] = new PVector(int(strData[i][0]), int(strData[i][1]), int(Top));
      vtxx[1][1] = new PVector(int(strData[i+1][0]), int(strData[i+1][1]), int(Top));

      PVector nor1 = mesher.normalVec(vtxx[0][0], vtxx[0][1], vtxx[1][0]);
      PVector nor2 = mesher.normalVec(vtxx[1][0], vtxx[0][1], vtxx[1][1]);

      String nml[][] = new String[2][3];
      nml[0][0] = str(nor1.x);
      nml[0][1] = str(nor1.y);
      nml[0][2] = str(nor1.z);

      nml[1][0] = str(nor2.x);
      nml[1][1] = str(nor2.y);
      nml[1][2] = str(nor2.z);

      mesher.facet(super.writer, nml[0][0], nml[0][1], nml[0][2]);
      mesher.vertex3(super.writer, strData[i][0], strData[i][1], Bottom, strData[i+1][0], strData[i+1][1], Bottom, strData[i][0], strData[i][1], Top);

      mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
      mesher.vertex3(super.writer, strData[i][0], strData[i][1], Top, strData[i+1][0], strData[i+1][1], Bottom, strData[i+1][0], strData[i+1][1], Top);
    }
    super.writer.println("endsolid");
  }
}

