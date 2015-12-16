class Frame {
   ArrayList<Pixel> pixels;
   JSONObject frame;
   JSONArray framePixels;
   int id;
   
   Frame(int _id, ArrayList<Pixel> _pixels) {
     this.pixels = _pixels;
     this.frame = new JSONObject();
     this.id = _id; 
     
   }
   
   Frame(int _id) {
     this.pixels = new ArrayList<Pixel>();
     this.id = _id;
     this.frame = new JSONObject();
     println("id: ", this.id);
     this.framePixels = new JSONArray();
     
     this.frame.setInt("id", this.id);
     //this.frame.setJSONArray("pixels", this.framePixels);
   }
   
   void addPixel(Pixel p) {
     JSONObject jp = p.getJSONPixel();
     framePixels.setJSONObject(this.pixels.size(), jp);
     this.pixels.add(p);
   }
   
   ArrayList<Pixel> getPixels() {
     return this.pixels; 
   }
   
   JSONObject getJSONframe() {
     println("Set framePixels length: ", this.framePixels.size());
     this.frame.setJSONArray("pixels", this.framePixels);
     return this.frame; 
   }
   
   int getID() {
     return this.id; 
   }
   
   /*void saveFrame() {
     this.frame.setJSONObject("pixels", this.framePixels);
   }*/
   
}