void setup() {
  size(800, 600);
}

void shape(int col, float phase, float sc){
  pushMatrix();
  stroke(col,0,col);
  noFill();
  scale(sc);
  beginShape();
  for (float a = 0; a < TWO_PI; a+=0.01) {
    float xOffset = map(cos(a+t),-1,1,0,noiseMax);
    float yOffset = map(sin(a+t),-1,1,0,noiseMax);
    float r = map(noise(xOffset+phase, yOffset+phase), 0, 1, 100, 200);
    float x = r*cos(a);
    float y = r*sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}

float t = 0;
float noiseMax = 2*(cos(t)+2);
float start = 2*(cos(0)+2);
int c = 0;
void draw() {
  background(0);
  translate(width/2, height/2);
  for (int i = 50; i < 255; i+=5){
    shape(i,map(i,50,255,0,100),map(i,50,255,1.75,0.01));
  }
  //saveFrame("frames/frame"+nf(c,5)+".png");
  c++;
  if (noiseMax == start && t > 0.01*PI){
    exit();
  }
  noiseMax=2*(cos(t)+2);
  t+=0.01*PI;
  println(noiseMax);
}
