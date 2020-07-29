float t = 0;
float noiseMax = 2*(cos(t)+2);
float start = 2*(cos(0)+2);
int c = 0;

void setup() {
  size(800, 600);
}

void shape(int col, float phase, float sc){
  //params: color, phase (nosie position), scale
  pushMatrix();
  stroke(col,0,col);
  noFill();
  scale(sc);
  beginShape();
  
  float[] noiseValues = new float[200];

  int counter = 0;
  for (float a = 0; a < TWO_PI; a+=0.01*PI){
    float xOffset = map(cos(a+t),-1,1,0,noiseMax);
    float yOffset = map(sin(a+t),-1,1,0,noiseMax);
    noiseValues[counter] = map(noise(xOffset+phase, yOffset+phase), 0, 1, 100, 200);
    counter++;
  }
  
  //since it's moving in a circular path in noise space,
  //the last index and the first index have the same value.
  //so we can fill the noise array from 0-200, then move backwards from 200-0
  
  for (float a = 0; a < TWO_PI; a+=0.01*PI) {
    counter--;
    float x = noiseValues[counter]*cos(a);
    float y = noiseValues[counter]*sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  int minVal = 0;
  int maxVal = 191;
  
  int increment = 3;
  
  for (int i = minVal; i < maxVal; i+=increment){
    //`i` is the color values (min & max must be mod 255)
    //`phase` is a 1D offset for the noise values. This ensures all distortions are different.
    //`scale value` is what shrinks or enlarges the circles.
    float phase = map(i,minVal,maxVal,0,100);
    float scaleValue = map(i,minVal,maxVal,1.75,0.01);
    shape(i, phase, scaleValue);
  }
  
  //save frame code. Uncomment to use
  //note, it assumes a folder `frames` exists in the current directory.
  /*saveFrame("frames/frame"+nf(c,5)+".png");
  c++;
  if (noiseMax == start && t > 0.01*PI){
    exit();
  }
  */
  
  noiseMax=3*(cos(t/2)+2); //noise max will oscillate between 9 and 3
  t+=0.01*PI;
  println(noiseMax);
}
