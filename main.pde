import controlP5.*;
import processing.opengl.*;

ControlP5 cp5;
ControlGroup messageBox;
String messageBoxString = "";

Obj obj;
PrintWriter writer;


void setup() {

  size(500, 500, P3D);
  writer = createWriter("tttttest.stl");


  cp5 = new ControlP5(this);
  createMessageBox();
  Button b = cp5.addButton("toggleBox", 1, 20, 20, 100, 20);
  b.setLabel("Toggle Box");

  textFont(createFont("", 100));


  obj = new Cylindar(writer, 10, 10, 20);
}

String cylindar = "cylindar";

void draw() {
  hint(ENABLE_DEPTH_TEST);
  background(255);


  pushMatrix();
  translate(width/2, height/2, width/2);
  rotateY(radians(frameCount));
  obj.drawObj();
  popMatrix();

  hint(DISABLE_DEPTH_TEST);
}



void createMessageBox() {

  //===MessageBox===//
  messageBox = cp5.addGroup("messageBox", width/2+20, 0, 300);
  messageBox.setBackgroundHeight(80);
  messageBox.setBackgroundColor(color(0, 100));
  messageBox.hideBar();


  //==TextLabel===//
  Textlabel l = cp5.addTextlabel("messageBoxLabel", "Coding Here.", 20, 20);
  l.moveTo(messageBox);

  //==TextField==//
  Textfield f = cp5.addTextfield("inputbox", 20, 36, 200, 30);
  f.captionLabel().setVisible(false);//***
  f.moveTo(messageBox);
  f.setColorForeground(color(20));
  f.setColorBackground(color(20));
  f.setColorActive(color(100));
}

void inputbox(String theString) {
  println("got something from the inputbox : " + theString);
  messageBoxString = theString;


  if (theString.equals("make")) {
    obj.outputSTLFile();
    writer.flush();
    exit();
  }


  String objName;
  String objArgments[];

  int s = theString.indexOf("(");
  int e = theString.lastIndexOf(")");

  objName = theString.substring(0, s);

  String argments = theString.substring(s+1, e);

  objArgments = argments.split(",");


  if (objName.equals("cylindar")) {
    obj = new Cylindar(writer, parseInt(objArgments[0]), parseInt(objArgments[1]), parseInt(objArgments[2]));
  } else if (objName.equals("cube")) {
    obj = new Cube(writer, parseInt(objArgments[0]));
  } else if (objName.equals("cone")) {
    obj = new Cone(writer, parseInt(objArgments[0]), parseInt(objArgments[1]), parseInt(objArgments[2]));
  }else if(objName.equals("BezierSurface")){
    obj = new BezierSurface(writer, parseInt(objArgments[0]), parseInt(objArgments[1]), parseInt(objArgments[2]), parseInt(objArgments[3]), parseInt(objArgments[4]));
  }

  println(objName);
  println(objArgments);

}

void toggleBox(int theValue) {
  if (messageBox.isVisible()) {
    messageBox.hide();
  } else {
    messageBox.show();
  }
}

void stop() {
  writer.close();
}

