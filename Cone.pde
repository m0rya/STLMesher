class Cone extends Obj {
  double numData[][];
  String strData[][];
  String coneTop;
  String coneBottom;
  float top;
  float bottom = 0.0;
  int resolution;
  float radius;


  Cone(PrintWriter _writer, float _radius, float ConeHeight, int _resolution) {
    super(_writer);

    this.top = ConeHeight;
    this.resolution = _resolution;
    this.radius = _radius;
    coneTop = super.mesher.double2e(top);
    coneBottom = super.mesher.double2e(bottom);

    numData = new double[(int)360/resolution+1][2];
    strData = new String[(int)360/resolution+1][2];
    
    setNumData();
  }

  void setNumData() {
    for (int i=0; i< (int)360/resolution+1; i++) {
      if (i*resolution == 180) {
        numData[i][0] = 0.0;
      } else {
        numData[i][0] = sin(radians(i*resolution))* radius;
      }

      if (i*resolution == 90 || i*resolution == 270) {
        numData[i][1] = 0.0;
      } else {
        numData[i][1] = cos(radians(i*resolution))*radius;
      }
    }
  }


  void drawObj() {
    for (int i=0; i< (int)360/resolution; i++) {
      //bottomMesh
      beginShape();
      vertex(bottom, bottom, bottom);
      vertex((float)numData[i][0], (float)numData[i][1], bottom);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], bottom);      
      endShape(CLOSE);

      //sideMesh
      beginShape();
      vertex((float)numData[i][0], (float)numData[i][1], bottom);
      vertex((float)numData[i+1][0], (float)numData[i+1][1], bottom);
      vertex(bottom, bottom, top);
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
      mesher.vertex3(super.writer, super.zero, super.zero, super.zero, strData[i][0], strData[i][1], super.zero, strData[i+1][0], strData[i+1][1], super.zero);


      //sideMesh

      //make normal vector
      PVector vtxx[] = new PVector[3];
      vtxx[0] = new PVector(int(strData[i][0]), int(strData[i][1]), int(super.zero));
      vtxx[1] = new PVector(int(strData[i+1][0]), int(strData[i+1][1]), int(super.zero));
      vtxx[2] = new PVector(int(super.zero), int(super.zero), int(coneTop));

      PVector nor = mesher.normalVec(vtxx[0], vtxx[1], vtxx[2]);

      String nml[] = new String[3];
      nml[0] = str(nor.x);
      nml[1] = str(nor.y);
      nml[2] = str(nor.z);

      mesher.facet(super.writer, nml[0], nml[1], nml[2]);
      mesher.vertex3(super.writer, strData[i][0], strData[i][1], coneBottom, strData[i+1][0], strData[i+1][1], coneBottom, coneBottom, coneBottom, coneTop);
    }
    super.writer.println("endsolid");
  }
}
