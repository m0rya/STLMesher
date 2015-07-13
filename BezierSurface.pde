
class BezierSurface extends Obj {

  //controll point
  PVector P03, P13, P23, P33;
  PVector P02, P12, P22, P32;
  PVector P01, P11, P21, P31;
  PVector P00, P10, P20, P30;

  PVector[][] ctrlPoint = new PVector[4][4];
  PVector[][] Point;
  PVector[][] P = new PVector[4][4];
  PVector[][] S;

  //resolution
  int un, vn;

  float[][] weight = new float[4][4];

  float Height=50;
  float bottom;


//output STLFile
  String Bottom = "";
  String[][][] strData;
  Mesher mesher;



  BezierSurface(PrintWriter _writer, int resolution, int Width, int Depth, float _Height, float _weight) {
    super(_writer);
    mesher = new Mesher();
    

    this.Height = _Height;


    P[0][0] = new PVector(-Width/2, 40, Depth/2);
    P[0][1] = new PVector(-Width/2, 0, Depth/6);
    P[0][2] = new PVector(-Width/2, 0, -Depth/6);
    P[0][3] = new PVector(-Width/2, 40, -Depth/2);

    P[1][0] = new PVector(-Width/6, 0, Depth/2);
    P[1][1] = new PVector(-Width/6, -40, Depth/6);
    P[1][2] = new PVector(-Width/6, -40, -Depth/6);
    P[1][3] = new PVector(-Width/6, 0, -Depth/2);

    P[2][0] = new PVector(Width/6, 0, Depth/2);
    P[2][1] = new PVector(Width/6, -40, Depth/6);
    P[2][2] = new PVector(Width/6, -40, -Depth/6);
    P[2][3] = new PVector(Width/6, 0, -Depth/2);

    P[3][0] = new PVector(Width/2, 40, Depth/2);
    P[3][1] = new PVector(Width/2, 0, Depth/6);
    P[3][2] = new PVector(Width/2, 0, -Depth/6);
    P[3][3] = new PVector(Width/2, 40, -Depth/2);

    this.bottom = _Height + 40;
    Bottom = mesher.double2e(bottom);


    //set weight
    for (int i=0; i<4; i++) {
      for (int j=0; j<4; j++) {
        weight[i][j] = 1.0;
      }
    }

    for (int i=1; i<3; i++) {
      for (int j=1; j<3; j++) {
        weight[i][j] = _weight;
      }
    }
    println(weight);


    //set resolution
    un = 16;
    vn = 16;

    un = resolution;
    vn = resolution;
    strData = new String[un][vn][3];

    S = new PVector[un+1][vn+1];
    for (int i=0; i<un+1; i++) 
      for (int j=0; j<vn+1; j++)
        S[i][j] = new PVector();


    makePoint(color(0));
  }



  float B30(float t) { 
    return (  (1-t)*(1-t)*(1-t)      );
  }
  float B31(float t) { 
    return (3*      (1-t)*(1-t)    *t);
  }
  float B32(float t) { 
    return (3*            (1-t)  *t*t);
  }
  float B33(float t) { 
    return (                    t*t*t);
  }


  void makePoint(color c) {

    stroke(0, 255, 255);

    for (int uu=0; uu<=un; uu+=1) {

      for (int vv=0; vv<=vn; vv+=1) {
        //noStroke();
        stroke(0);
        float u = (float)uu/un;
        float v = (float)vv/vn;



        float sum = B30(u)*(weight[0][0] * B30(v) + weight[0][1] * B31(v) + weight[0][2] * B32(v) + weight[0][3] * B33(v))
          +B31(u)*(weight[1][0] * B30(v) + weight[1][1] * B31(v) + weight[1][2] * B32(v) + weight[1][3] * B33(v))
            +B32(u)*(weight[2][0] * B30(v) + weight[2][1] * B31(v) + weight[2][2] * B32(v) + weight[2][3] * B33(v))
              +B33(u)*(weight[3][0] * B30(v) + weight[3][1] * B31(v) + weight[3][2] * B32(v) + weight[3][3] * B33(v));

        // Please add Weights


        S[uu][vv].x = (B30(u)*(B30(v)*weight[0][0]*P[0][0].x + B31(v)*weight[0][1]*P[0][1].x + B32(v)*weight[0][2]*P[0][2].x + B33(v)*weight[0][3]*P[0][3].x)
          +B31(u)*(B30(v)*weight[1][0]*P[1][0].x + B31(v)*weight[1][1]*P[1][1].x + B32(v)*weight[1][2]*P[1][2].x + B33(v)*weight[1][3]*P[1][3].x)
          +B32(u)*(B30(v)*weight[2][0]*P[2][0].x + B31(v)*weight[2][1]*P[2][1].x + B32(v)*weight[2][2]*P[2][2].x + B33(v)*weight[2][3]*P[2][3].x)
          +B33(u)*(B30(v)*weight[3][0]*P[3][0].x + B31(v)*weight[3][1]*P[3][1].x + B32(v)*weight[3][2]*P[3][2].x + B33(v)*weight[3][3]*P[3][3].x)) /sum;      

        S[uu][vv].y = (B30(u)*(B30(v)*weight[0][0]*P[0][0].y + B31(v)*weight[0][1]*P[0][1].y + B32(v)*weight[0][2]*P[0][2].y + B33(v)*weight[0][3]*P[0][3].y)
          +B31(u)*(B30(v)*weight[1][0]*P[1][0].y + B31(v)*weight[1][1]*P[1][1].y + B32(v)*weight[1][2]*P[1][2].y + B33(v)*weight[1][3]*P[1][3].y)
          +B32(u)*(B30(v)*weight[2][0]*P[2][0].y + B31(v)*weight[2][1]*P[2][1].y + B32(v)*weight[2][2]*P[2][2].y + B33(v)*weight[2][3]*P[2][3].y)
          +B33(u)*(B30(v)*weight[3][0]*P[3][0].y + B31(v)*weight[3][1]*P[3][1].y + B32(v)*weight[3][2]*P[3][2].y + B33(v)*weight[3][3]*P[3][3].y)) /sum;      

        S[uu][vv].z = (B30(u)*(B30(v)*weight[0][0]*P[0][0].z + B31(v)*weight[0][1]*P[0][1].z + B32(v)*weight[0][2]*P[0][2].z + B33(v)*weight[0][3]*P[0][3].z)
          +B31(u)*(B30(v)*weight[1][0]*P[1][0].z + B31(v)*weight[1][1]*P[1][1].z + B32(v)*weight[1][2]*P[1][2].z + B33(v)*weight[1][3]*P[1][3].z)
          +B32(u)*(B30(v)*weight[2][0]*P[2][0].z + B31(v)*weight[2][1]*P[2][1].z + B32(v)*weight[2][2]*P[2][2].z + B33(v)*weight[2][3]*P[2][3].z)
          +B33(u)*(B30(v)*weight[3][0]*P[3][0].z + B31(v)*weight[3][1]*P[3][1].z + B32(v)*weight[3][2]*P[3][2].z + B33(v)*weight[3][3]*P[3][3].z)) /sum;
      }
    }

    //return S;
  }



  void drawObj() {
    for (int uu=0; uu<=un; uu+=1) {
      // v=0; 
      for (int vv=0; vv<=vn; vv+=1) {
        if (uu>0 && vv>0) {
          stroke(0);

          beginShape();
          vertex(S[uu][vv].x, S[uu][vv].y, S[uu][vv].z);
          vertex(S[uu-1][vv  ].x, S[uu-1][vv  ].y, S[uu-1][vv  ].z);
          vertex(S[uu-1][vv-1].x, S[uu-1][vv-1].y, S[uu-1][vv-1].z);
          endShape(CLOSE);

          beginShape();
          vertex(S[uu  ][vv  ].x, S[uu  ][vv  ].y, S[uu  ][vv  ].z);
          vertex(S[uu-1][vv-1].x, S[uu-1][vv-1].y, S[uu-1][vv-1].z);
          vertex(S[uu  ][vv-1].x, S[uu  ][vv-1].y, S[uu  ][vv-1].z);
          endShape(CLOSE);
        }
      }
    }

    for (int i=1; i<vn+1; i++) {
      //First Side
      beginShape();
      vertex(S[0][i-1].x, S[0][i-1].y, S[0][i-1].z);
      vertex(S[0][i-1].x, bottom, S[0][i-1].z);
      vertex(S[0][i].x, S[0][i].y, S[0][i].z);
      endShape(CLOSE);

      beginShape();
      vertex(S[0][i-1].x, bottom, S[0][i-1].z);
      vertex(S[0][i].x, S[0][i].y, S[0][i].z);
      vertex(S[0][i].x, bottom, S[0][i].z);
      endShape(CLOSE);

      //Second Side
      beginShape();
      vertex(S[i-1][0].x, S[i-1][0].y, S[i-1][0].z);
      vertex(S[i-1][0].x, bottom, S[i-1][0].z);
      vertex(S[i][0].x, S[i][0].y, S[i][0].z);
      endShape(CLOSE);

      beginShape();
      vertex(S[i][0].x, S[i][0].y, S[i][0].z);
      vertex(S[i-1][0].x, bottom, S[i-1][0].z);
      vertex(S[i][0].x, bottom, S[i][0].z);
      endShape(CLOSE);

      //Third Side
      beginShape();
      vertex(S[vn][i-1].x, S[vn][i-1].y, S[vn][i-1].z);
      vertex(S[vn][i-1].x, bottom, S[vn][i-1].z);
      vertex(S[vn][i].x, S[vn][i].y, S[vn][i].z);
      endShape(CLOSE);

      beginShape();
      vertex(S[vn][i].x, S[vn][i].y, S[vn][i].z);
      vertex(S[vn][i-1].x, bottom, S[vn][i-1].z);
      vertex(S[vn][i].x, bottom, S[vn][i].z);
      endShape(CLOSE);

      //Forth Side
      beginShape();
      vertex(S[i-1][vn].x, S[i-1][vn].y, S[i-1][vn].z);
      vertex(S[i-1][vn].x, bottom, S[i-1][vn].z);
      vertex(S[i][vn].x, S[i][vn].y, S[i][vn].z);
      endShape(CLOSE);

      beginShape();
      vertex(S[i][vn].x, S[i][vn].y, S[i][vn].z);
      vertex(S[i-1][vn].x, bottom, S[i-1][vn].z);
      vertex(S[i][vn].x, bottom, S[i][vn].z);
      endShape(CLOSE);
    }

    //bottom Face
    beginShape();
    vertex(S[0][0].x, bottom, S[0][0].z);
    vertex(S[vn][0].x, bottom, S[vn][0].z);
    vertex(S[0][vn].x, bottom, S[0][vn].z);
    endShape(CLOSE);

    beginShape();
    vertex(S[vn][0].x, bottom, S[vn][0].z);
    vertex(S[0][vn].x, bottom, S[0][vn].z);
    vertex(S[vn][vn].x, bottom, S[vn][vn].z);
    endShape(CLOSE);
  }



  void setStrData() {
    for (int i=0; i<vn; i++) {
      for (int j=0; j<un; j++) {
        strData[i][j][0] = mesher.double2e(S[i][j].x);
        strData[i][j][1] = mesher.double2e(S[i][j].y);
        strData[i][j][2] = mesher.double2e(S[i][j].z);
      }
    }
  }



  void outputSTLFile() {
    setStrData();


    super.writer.println("solid Object");
  
    //bottom Face
    mesher.facet(super.writer, zero, plus, zero);
    mesher.vertex3(super.writer, strData[0][0][0], Bottom, strData[0][0][2], strData[vn-1][0][0], Bottom, strData[vn-1][0][2], strData[0][vn-1][0], Bottom, strData[0][vn-1][2]);
    mesher.facet(super.writer, zero, plus, zero);
    mesher.vertex3(super.writer, strData[vn-1][0][0], Bottom, strData[vn-1][0][2], strData[0][vn-1][0], Bottom, strData[0][vn-1][2], strData[vn-1][vn-1][0], Bottom, strData[vn-1][vn-1][2]);

   

    //4 side faces
    for (int i=1; i<vn; i++) {
      

        //one
        PVector vtxx[][] = new PVector[2][2];
        vtxx[0][0] = new PVector(int(strData[0][i-1][0]), int(strData[0][i-1][1]), int(strData[0][i-1][2]));
        vtxx[0][1] = new PVector(int(strData[0][i-1][0]), int(Bottom), int(strData[0][i-1][2]));
        vtxx[1][0] = new PVector(int(strData[0][i][0]), int(strData[0][i][1]), int(strData[0][i][2]));
        vtxx[1][1] = new PVector(int(strData[0][i][0]), int(Bottom), int(strData[0][i][2]));

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
        mesher.vertex3(super.writer, strData[0][i-1][0], strData[0][i-1][1], strData[0][i-1][2], strData[0][i-1][0], Bottom, strData[0][i-1][2], strData[0][i][0], strData[0][i][1], strData[0][i][2]);

        mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
        mesher.vertex3(super.writer, strData[0][i-1][0], Bottom, strData[0][i-1][2], strData[0][i][0], strData[0][i][1], strData[0][i][2], strData[0][i][0], Bottom, strData[0][i][2]);
    }
    for(int i=1; i<vn; i++){
      
      
        //two
        PVector vtxx[][] = new PVector[2][2];
        vtxx[0][0] = new PVector(int(strData[i-1][0][0]), int(strData[i-1][0][1]), int(strData[i-1][0][2]));
        vtxx[0][1] = new PVector(int(strData[i-1][0][0]), int(Bottom), int(strData[i-1][0][2]));
        vtxx[1][0] = new PVector(int(strData[i][0][0]), int(strData[i][0][1]), int(strData[i][0][2]));
        vtxx[1][1] = new PVector(int(strData[i][0][0]), int(Bottom), int(strData[i][0][2]));

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
        mesher.vertex3(super.writer, strData[i-1][0][0], strData[i-1][0][1], strData[i-1][0][2], strData[i-1][0][0], Bottom, strData[i-1][0][2], strData[i][0][0], strData[i][0][1], strData[i][0][2]);
        
        mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
        mesher.vertex3(super.writer, strData[i][0][0], strData[i][0][1], strData[i][0][2], strData[i-1][0][0], Bottom, strData[i-1][0][2], strData[i][0][0], Bottom, strData[i][0][2]);
    }

      
      
    for(int i=1; i<vn; i++){
       //third
        PVector vtxx[][] = new PVector[2][2];
        vtxx[0][0] = new PVector(int(strData[vn-1][i-1][0]), int(strData[vn-1][i-1][1]), int(strData[vn-1][i-1][2]));
        vtxx[0][1] = new PVector(int(strData[vn-1][i-1][0]), int(Bottom), int(strData[vn-1][i-1][2]));
        vtxx[1][0] = new PVector(int(strData[vn-1][i][0]), int(strData[vn-1][i][1]), int(strData[vn-1][i][2]));
        vtxx[1][1] = new PVector(int(strData[vn-1][i][0]), int(Bottom), int(strData[vn-1][i][2]));

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
        mesher.vertex3(super.writer, strData[vn-1][i-1][0], strData[vn-1][i-1][1], strData[vn-1][i-1][2],  strData[vn-1][i-1][0], Bottom, strData[vn-1][i-1][2], strData[vn-1][i][0], strData[vn-1][i][1], strData[vn-1][i][2]);
        
        mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
        mesher.vertex3(super.writer, strData[vn-1][i-1][0], Bottom, strData[vn-1][i-1][2], strData[vn-1][i][0], strData[vn-1][i][1], strData[vn-1][i][2], strData[vn-1][i][0], Bottom, strData[vn-1][i][2]);
    }
    
    for(int i=1; i<vn; i++){
      //fourth
        PVector vtxx[][] = new PVector[2][2];
        vtxx[0][0] = new PVector(int(strData[i-1][vn-1][0]), int(strData[i-1][vn-1][1]), int(strData[i-1][vn-1][2]));
        vtxx[0][1] = new PVector(int(strData[i-1][vn-1][0]), int(Bottom), int(strData[i-1][vn-1][2]));
        vtxx[1][0] = new PVector(int(strData[i][vn-1][0]), int(strData[i][vn-1][1]), int(strData[i][vn-1][2]));
        vtxx[1][1] = new PVector(int(strData[i][vn-1][0]), int(Bottom), int(strData[i][vn-1][2]));

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
        mesher.vertex3(super.writer, strData[i-1][vn-1][0], strData[i-1][vn-1][1], strData[i-1][vn-1][2], strData[i-1][vn-1][0], Bottom, strData[i-1][vn-1][2], strData[i][vn-1][0], strData[i][vn-1][1], strData[i][vn-1][2]);
        
        mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
        mesher.vertex3(super.writer, strData[i-1][vn-1][0], Bottom, strData[i-1][vn-1][2], strData[i][vn-1][0], strData[i][vn-1][1], strData[i][vn-1][2], strData[i][vn-1][0], Bottom, strData[i][vn-1][2]);
        
      
        
    }
      
 

    //top face

    for (int i=1; i<un; i++) {
      for (int j=1; j<un; j++) {

        PVector vtxx[][] = new PVector[2][2];
        vtxx[0][0] = new PVector(int(strData[i-1][j][0]), int(strData[i-1][j][1]), int(strData[i-1][j][2]));
        vtxx[0][1] = new PVector(int(strData[i][j][0]), int(strData[i][j][1]), int(strData[i][j][2]));
        vtxx[1][0] = new PVector(int(strData[i-1][j-1][0]), int(strData[i-1][j-1][1]), int(strData[i-1][j-1][2]));
        vtxx[1][1] = new PVector(int(strData[i][j-1][0]), int(strData[i][j-1][1]), int(strData[i][j-1][2]));

        PVector nor1 = mesher.normalVec(vtxx[0][0], vtxx[0][1], vtxx[1][0]);
        PVector nor2 = mesher.normalVec(vtxx[1][0], vtxx[0][1], vtxx[1][1]);

        String nml[][] = new String[2][3];
        nml[0][0] = str(nor1.x);
        nml[0][1] = str(nor1.y);
        nml[0][2] = str(nor1.z);

        nml[1][0] = str(nor2.x);
        nml[1][1] = str(nor2.y);
        nml[1][2] = str(nor2.z);

        mesher.facet(super.writer, nml[0][0], nml[0][1], nml[0][1]);
        mesher.vertex3(super.writer, strData[i-1][j][0], strData[i-1][j][1], strData[i-1][j][2], strData[i][j][0], strData[i][j][1], strData[i][j][2], strData[i-1][j-1][0], strData[i-1][j-1][1], strData[i-1][j-1][2]);

        mesher.facet(super.writer, nml[1][0], nml[1][1], nml[1][2]);
        mesher.vertex3(super.writer, strData[i][j][0], strData[i][j][1], strData[i][j][2], strData[i-1][j-1][0], strData[i-1][j-1][1], strData[i-1][j-1][2], strData[i][j-1][0], strData[i][j-1][1], strData[i][j-1][2]);
      }
    }





    super.writer.println("endsolid");
  }
}

