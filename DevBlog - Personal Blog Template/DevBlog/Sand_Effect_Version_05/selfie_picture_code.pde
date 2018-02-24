//this one should decay somewhat slowly
Particle[] particles;
int pixelStartSize= 1;
int pixelateThreshold = 15;
int particleIndex=width*height-100-1;
int vy = 0;
boolean isPixelated = false;
boolean startFall = false;
PImage img;
float timer= 300;
float startTime;
void setup() {
  size(700, 500);
  img = loadImage("Sand_Effect_Version_05/vk.jpg");
  startTime = millis();
  particles = new Particle [width*height-100];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  background(255);
}

void draw() {
  background(255);

  if (pixelStartSize<pixelateThreshold) {
    if(millis()-startTime>timer){
         pixelStartSize++;
    if(!startFall){
     pixelate(pixelStartSize); 
      }
     startTime= millis(); 
   }
    
  } else {
    startFall = true; 
    for (int i=0; i<particles.length; i++) {
      particles[i].speed = particles[i].accel;
    }
  }   


  int i = 0;
  for (int x=0; x<img.width; x+=pixelStartSize) {
    for (int y=0; y<img.height; y+=pixelStartSize) {
      color c = img.get(x, y);
      particles[i].display(pixelStartSize, c);
      i++;
    }
  }
}

void pixelate(int pxSize) {
  noStroke();
  int i = 0;
  for (int x=0; x<img.width; x+=pxSize) {
    for (int y=0; y<img.height; y+=pxSize) {
      particles[i].update(x, y);
      i++;
    }
  }
}
class Particle {
  float x;
  float y;  
  int colorID;
  int sizeID;
  float speed;
  float accel;
  
  Particle() {
    x = 0;
    y = 0;
    accel = pow(10,(random(0.0001, 2)-2));
    speed = 0;
  }
  
  void update(int xpos, int ypos){
   
   x = xpos;
   y = ypos;
  }

  void display(int size, int c) {
    noStroke();
    //color c = img.get(int(xpos),int(ypos));
    fill(c);
    if(startFall){
      y += speed;
    }
    
    colorID = c; 
    sizeID = size;
    rect(x, y, size, size);
  }
}