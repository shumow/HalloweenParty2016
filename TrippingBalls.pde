class TrippingBalls extends RunableSketch {
  float time;
  
  final float minCircleRadius = 40;
  final float maxCircleRadius = 100;
  final float minPeriod = 4;
  final float maxPeriod = 10;
  
  boolean draw_lines = false;
  
  class BreathingCircle {
    float phaseOffset;
    float period;
    float centerX;
    float centerY;
    float maxRadius;
    color clr;
    
    BreathingCircle(float x, float y, float offset, float per, float rad, color c) {
     centerX = x;
     centerY = y;
     phaseOffset = offset; 
     period = per;
     maxRadius = rad;
     clr = c;
    }
    
    void display(float t) {
      float diameter;
      diameter = maxRadius * (1 + 0.5*sin(TWO_PI*(phaseOffset + t)/period));
      fill(clr);  
      ellipse(centerX, centerY, diameter, diameter);
    }
    
  }
  
  int cntCircles = 40;
  
  BreathingCircle[] circles;
  
  color random_color() {
    return color(random(255), random(255), random(255));
  }
  
  TrippingBalls() {
   time = 0;
   circles = new BreathingCircle[cntCircles];
   for (int i = 0; i < cntCircles; i++) {
     float x = random(width);
     float y = random(height);
     float period = ((minPeriod + maxPeriod) + (maxPeriod - minPeriod)*randomGaussian()/2)/2;
     float phase = random(period);
     float radius = ((minCircleRadius + maxCircleRadius) + (maxCircleRadius - minCircleRadius)*randomGaussian()/2)/2;
     color c = random_color();
     circles[i] = new BreathingCircle(x,y,phase, period, radius, c);
   }
  }

  void update(float dt) {
    time += 1/frameRate;
  }
  
  void draw() {
    pushStyle();
      noStroke();
      clear();
      background(255);
      for (int i = 0; i < cntCircles; i++) {
        circles[i].display(time);
        if (draw_lines) {
          if (0 < i) {
            float x1 = circles[i-1].centerX;
            float y1 = circles[i-1].centerY;
            float x2 = circles[i].centerX;
            float y2 = circles[i].centerY;
            stroke(0,0,0);
            line(x1,y1,x2,y2);
            noStroke();
          }
        }
      }
    popStyle();
  }
}
