import gab.opencv.*;
import java.util.ArrayList;
import processing.video.*;

Capture camera;
OpenCV cv;
PImage img, thresh, dest;

ArrayList<Contour> contours;


void setup() {
  size(640, 360); //1280, 720
  background(255,255,255);
  
  img = createImage(width, height, RGB);
  thresh = createImage(width, height, RGB);
  dest = createImage(width, height, RGB);
  
  camera = new Capture(this, 640, 360);
  //cv = new OpenCV(this, 1280/2, 720/2);
  
  camera.start();
}


void draw() {
  if(camera.available()) {
    img.copy(camera, 0, 0, camera.width, camera.height, 0, 0, camera.width, camera.height);
    camera.read();
  }
  img.loadPixels();
  
  cv = new OpenCV(this, img);
  cv.threshold(80);
  thresh = cv.getSnapshot();
  
  dest = cv.getOutput();
  

  contours = cv.findContours();
  print("found " + contours.size() + " contours");
  image(thresh, 0, 0);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  
}