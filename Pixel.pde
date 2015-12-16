class Pixel {
  float x,
        y;
  color c;
  
  JSONObject pixel;
  Pixel(float _x, float _y) {
    this.c = color(0,0,0);
    this.x = _x;
    this.y = _y;
    this.pixel = new JSONObject();
    this.pixel.setInt("x", int(_x));
    this.pixel.setInt("y", int(_y));
  }
  
  JSONObject getJSONPixel() {
    return this.pixel;
  }
}