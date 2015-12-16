import gab.opencv.*;
import java.util.ArrayList;
import processing.video.*;

Capture camera;
OpenCV cv;
PImage img, thresh, dest;
Environment env = new Environment();
int shadowIndex;
int shadowStartFrame = -1;
int currentFrame = 0;
boolean playing = false;


void setup() {
  size(320, 180);
  background(255,255,255);
  
  img = createImage(width, height, RGB);
  thresh = createImage(width, height, RGB);
  dest = createImage(width, height, RGB);
  
  camera = new Capture(this, 640, 360);
  cv = new OpenCV(this, 640, 360);
  
  camera.start();
}


void draw() {
  println("");
  if(camera.available()) {
    img.copy(camera, 0, 0, camera.width, camera.height, 0, 0, camera.width, camera.height);
    camera.read();
  }
  img.loadPixels();
  
  cv = new OpenCV(this, img);
  cv.threshold(30);
  thresh = cv.getSnapshot();

  image(thresh, 0, 0);
  
  println("image size:" + thresh.pixels.length);
  
  int blackPixels = 0;
  if(!playing) {
    for(int i = 0; i < thresh.pixels.length; i++) {
      if(blackPixel(thresh.pixels[i])) {
        blackPixels++; 
      }
      if(!env.recording && blackPixel(thresh.pixels[i])) {
        println("Start recording frame, creating a new shadow.");
        env.newShadow(env.getNumberOfShadows());
        recordFrame(i, thresh);
        env.recording = true;
        break;
      } else if(env.recording && blackPixels == 0 && i == thresh.pixels.length-1) {
        println("Stop recording frame");
        env.recording = false;
        //env.saveJSON();
        env.completeShadow();
      } else if(env.recording && (i % 50000) == 0) {
        recordFrame(i, thresh); 
      }
      if(i == thresh.pixels.length-1) {
        println("blackPixels: " + blackPixels); 
      }
    }
  }
  ArrayList<Shadow> shadows = env.getShadows();
  
  for(int i = 0; i < shadows.size(); i++) {
    Shadow shadow = shadows.get(i);
    if(env.getShadows().get(i).isComplete() && !env.getShadows().get(i).isPlayed()) {
      playing = true;
      if(shadowStartFrame == -1) {
        shadowStartFrame = frameCount; 
      }
      print("Found a complete shadow that has not been played. ");
      background(255,255,255);
      if(currentFrame < shadow.getNumberOfFrames()) {
        print("Showing frame number " + currentFrame + " ");
        Frame f = shadow.getFrame(currentFrame);
        ArrayList<Pixel> framePixels = f.getPixels();

        for(int k = 0; k < framePixels.size(); k++) {
          Pixel p = framePixels.get(k);
          rect(p.x, p.y, 1, 1);
          fill(0, 0, 0);
        }
        currentFrame++;
      } else {
        println("Playing from regular webcam");
        env.getShadows().get(i).setPlayed(true); 
        playing = false;
      }
      
    } else {
      image(thresh, 0, 0); 
    }
  }
}

void recordFrame(int index, PImage img) {
  println("Add frame ", index);
  Frame f = new Frame(index);
  //println("Recording new frame");
  for(int i = 0; i < thresh.pixels.length; i++) {
    if(blackPixel(thresh.pixels[i])) {
      float x = i % width;
      float y = i / height;
      f.addPixel(new Pixel(x,y));
    }
  }
  //println("Adding new frame");
  env.addFrameToShadow(f);
}


boolean blackPixel(color c) {
  return (int(red(c)) == 0 && int(green(c)) == 0 && int(blue(c)) == 0);
  
}