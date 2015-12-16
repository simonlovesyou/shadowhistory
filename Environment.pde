import java.io.FileWriter;
import java.io.IOException;

class Environment {
  ArrayList<Shadow> shadows;
  boolean recording;
  String fileLocation;
  JSONArray JSONshadows;
  
  Environment() {
    this.shadows = new ArrayList<Shadow>();
    this.recording = false;
    this.fileLocation = "/Users/simon/Documents/ShadowHistory/data/shadows.json";
    this.JSONshadows = new JSONArray();
    //saveJSONObject(obj, this.fileLocation);
  }
  
  int newShadow(int _id) {    

    Shadow s = new Shadow(_id);
    
    this.shadows.add(s);
    return this.shadows.size();
  }
  
  void completeShadow() {
    
    this.shadows.get(shadows.size()-1).complete();
    //this.shadows.get(shadows.size()-1).saveShadow(this.fileLocation);
  }
  
  void addShadow(Shadow s) {
    this.shadows.add(s);
  }
  
  void addFrameToShadow(Frame f) {
    this.shadows.get(shadows.size()-1).addFrame(f); 
    //f.saveFrame(this.fileLocation);
  }
  
  int getNumberOfShadows() {
    return this.shadows.size();
  }
  
  ArrayList<Shadow> getShadows() {
    return this.shadows;
  }
  
  void saveJSON() {
    JSONObject js = shadows.get(shadows.size()-1).getJSONShadow();
    JSONshadows.setJSONObject(0, js);
    saveJSONArray(JSONshadows, this.fileLocation);
  }
  
}