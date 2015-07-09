public class Obj {
  public String zero = "0.000000E+00";
  public String plus  = "1.000000E+00";
  public String minus = "-1.000000E+00";
  public PrintWriter writer;
  public Mesher mesher;
  
  
  Obj(PrintWriter _writer){
    this.writer = _writer;
    mesher = new Mesher();
  }
  
  public void setNumData(){};
  public void drawObj(){};
  public void outputSTLFile(){};
  
  
  
}
  
