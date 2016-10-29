int minimum_sketch_time = 10;
int maximum_sketch_time = 15;

RunableSketch running_sketch;

int final_sketch_millis;

int num_runable_sketches = 3;


void newSketch() {
  
  float r = random(0, num_runable_sketches);
  
  final_sketch_millis = last_millis+1000*(int)random(minimum_sketch_time, maximum_sketch_time);

  if (r < 1) {
    running_sketch = (RunableSketch) new TrippingBalls();
  } else if (r < 2) {
    running_sketch = (RunableSketch) new TimeLines();
  } else if (r < 3) {
    running_sketch = (RunableSketch) new SpiderWeb3();
  }
  
}



int last_millis;

void setup() {
  size(800,600);
  noCursor();
  last_millis = millis();
  newSketch();
}

void draw() {
  int cur_millis = millis();
  float dt = (cur_millis - last_millis)/1000.0;
  last_millis = cur_millis;
  if (final_sketch_millis<cur_millis) {
    newSketch();
  } else {
    running_sketch.update(dt);
    running_sketch.draw();
  }
}
