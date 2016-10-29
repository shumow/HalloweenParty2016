class SpiderWeb3 extends RunableSketch {

  class QuadLoc {
    public int r, c;
    
    public color clr;
    
    QuadLoc(int r, int c, color clr) {
      this.r = r;
      this.c = c;
      
      this.clr = clr;
    }
  }
  
  final int minimum_number_radii = 5;
  final int maximum_number_radii = 9;
  
  final int minimum_number_circ = 4;
  final int maximum_number_circ = 11;
  
  final float minimum_circ_length = 40;
  
  final float time_to_move_quad = 0.666;
  
  int number_circ;
  int number_radii;
  
  float[] radii;
  
  float[][] circs;
  
  Vector[][] nodes;
  
  int number_quads = 2;
  
  QuadLoc[] qs;

  float qt;

  private void drawQuadLoc(QuadLoc ql) {
    pushStyle();
      noStroke();
      fill(ql.clr);
      Vector n1 = nodes[ql.r][ql.c];
      Vector n2 = nodes[ql.r+1][ql.c];
      Vector n3 = nodes[ql.r+1][ql.c+1];
      Vector n4 = nodes[ql.r][ql.c+1];
      quad(n1.x,n1.y,n2.x,n2.y,n3.x,n3.y,n4.x,n4.y);
    popStyle();
  }
  
  private void drawQuadLocs() {
    for (QuadLoc q: qs) {
      drawQuadLoc(q);
    }
  }
  
  private void advanceQuadLoc(QuadLoc ql) {
    int next_r, next_c;
    int[] ds = {-1, 0, 1};
    do {
      next_r = ds[(int)random(0,ds.length)] + ql.r;
      next_c = ds[(int)random(0,ds.length)] + ql.c;
    } while (!((0 <= next_r) && (next_r < (number_radii-1)) && (0 <= next_c) && (next_c < (number_circ-1))));
    
    ql.r = next_r;
    ql.c = next_c;
  }
  
  private void advanceQuads() {
    for (QuadLoc q : qs) {
      advanceQuadLoc(q);
    }
  }
  
  SpiderWeb3() {
    number_circ = (int)random(minimum_number_circ, maximum_number_circ);
    number_radii = (int)random(minimum_number_radii, maximum_number_radii);
    
    radii = new float[number_radii];
    
    for (int i = 0; i < number_radii; i++) {
      radii[i] = random(i*(TWO_PI/number_radii), (i+1)*(TWO_PI/number_radii));
    }
    

    float[] scalars = new float[number_circ];
    
    for (int i = 0; i < number_circ; i++) {
      scalars[i] = random(0,1);
    }
    
    scalars = sort(scalars);
        
    nodes = new Vector[number_radii][number_circ];
          
    for (int i = 0; i < number_radii; i++) {
      float s = sin(radii[i]);
      float c = cos(radii[i]);
      for (int j = 0; j < number_circ; j++) {
        nodes[i][j] = new Vector((width/2)+scalars[j]*(width/2)*c,(height/2)+scalars[j]*(height/2)*s);
      }
    }
    
    
    qs = new QuadLoc[number_quads];

    for (int i = 0; i < number_quads; i++) {    
      color c = color(random(255),random(255),random(255));
      qs[i] = new QuadLoc((int)random(0,number_radii-1),(int)random(0,number_circ-1), c);
    }
    
    qt = 0;
  }
  
  void update(float dt) {
    qt += dt;

    if (time_to_move_quad <= qt) {
      advanceQuads();
      qt = 0;
    }    
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
    drawQuadLocs();
  }
}
