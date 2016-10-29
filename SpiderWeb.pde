class SpiderWeb extends RunableSketch {
  
  final int minimum_number_radii = 5;
  final int maximum_number_radii = 9;
  
  final int minimum_number_circ = 4;
  final int maximum_number_circ = 11;
  
  final float minimum_circ_length = 40;
  
  int number_circ;
  int number_radii;
  
  float[] radii;
  
  float[][] circs;
  
  Vector[][] nodes;
  
  SpiderWeb() {
    number_circ = (int)random(minimum_number_circ, maximum_number_circ);
    number_radii = (int)random(minimum_number_radii, maximum_number_radii);
    
    radii = new float[number_radii];
    
    for (int i = 0; i < number_radii; i++) {
      radii[i] = random(0, TWO_PI);
    }
    
    radii = sort(radii);
    
    circs = new float[number_radii][number_circ];
    
    nodes = new Vector[number_radii][number_circ];
    
    for (int i = 0; i < number_radii; i++) {
      float s = sin(radii[i]);
      float c = cos(radii[i]);
      float cl = (height/2)*s*s + (width/2)*c*c;
      for (int j = 0; j < number_circ; j++) {
        circs[i][j] = random(minimum_circ_length, cl);
      }
      circs[i] = sort(circs[i]);
      for (int j = 0; j < number_circ; j++) {
        nodes[i][j] = new Vector((width/2)+circs[i][j]*cos(radii[i]),(height/2)+circs[i][j]*sin(radii[i]));
      }
    }   
  }
  
  void update(float dt) {
    
  }
  
  void draw() {
    clear();
    stroke(255);
    for (int i = 0; i < number_radii; i++) {
      Vector v1 = nodes[i][0];
      Vector v2 = nodes[i][number_circ-1];
      line(v1.x,v1.y,v2.x,v2.y);
      for (int j = 0; j < number_circ; j++) {
        v1 = nodes[i][j];
        v2 = nodes[(i+1)%number_radii][j];
        line(v1.x,v1.y,v2.x,v2.y);
      }
    }
  }
}
