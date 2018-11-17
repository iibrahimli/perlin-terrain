// idea from:
// Daniel Shiffman
// http://codingtra.in


int cols, rows;
int scl = 20;
int w = 3000;
int h = 4000;

float flying = 0;

float[][] terrain;

float green = 0;
float c = 0;

void setup() {
  size(800, 600, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
}


void draw() {

  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -150, 150);
      xoff += 0.1;
    }
    yoff += 0.1;
  }

  if(frameCount % 30 < 1) println(frameRate);

  background(0);
  // stroke(255, 50);
  noStroke();
  
  green = map(sin(c), -1, 1, 0, 200);
  c += 0.01;

  translate(width/2, height/2+50);
  rotateX(PI/2.2);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      fill(map(terrain[x][y], -100, 100, 0, 255), green, 255 - map(terrain[x][y], -100, 100, 0, 255));
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}
