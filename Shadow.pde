class Shadow {
  ArrayList<Frame> frames;
  boolean complete;
  boolean played;
  int id;
  JSONObject shadow;
  JSONArray jframes;
  
  Shadow(int _id) {
    this.frames = new ArrayList<Frame>();
    this.complete = false;
    this.played = false;
    this.id = _id;

    this.shadow = new JSONObject();
    this.shadow.setInt("id", _id);
    this.jframes = new JSONArray();
  }
  
  void complete() {
    this.complete = true; 
  }
  
  void addFrame(Frame frame) {
    //JSONObject jf = frame.getJSONframe();
    
    //shadow.setJSONObject("frames", jf);
    this.frames.add(frame);
  }
  
  JSONObject getJSONShadow() {
    return this.shadow;
  }
  
  int getNumberOfFrames() {
    return this.frames.size();
  }
  
  Frame getFrame(int index) {
    return this.frames.get(index);
  }
  
  boolean isComplete() {
    return this.complete; 
  }
  
  void setPlayed(boolean b) {
    this.played = b; 
  }
  
  boolean isPlayed() {
    return this.played;
  }
  
  
  void saveShadow(String location) {
    saveJSONObject(shadow, location); 
  }
}