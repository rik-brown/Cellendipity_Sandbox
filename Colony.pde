class Colony {

  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> population;    // An arraylist for all the cells //<>// //<>//
  
  PVector vel;
  PVector pos;
  PVector origin;
  
  float a;

  float w = width * 0.001;  // For convinience
  float c = w * 30; // Scaling factor

  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Colony() {
    genepool = new ArrayList<DNA>();
    population = new ArrayList<Cell>();
    
    // Here is the code which fills the 'genepool' arraylist with some preset DNA-strains.
    genepool.add(0, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna0 = genepool.get(0);
    // PURE BLACK
    //                   0, 1, 2, 3, 4, 5, 6,     7,     8,   9,  10,  11,  12,  13,    14,  15,  16,        17,  18,    19,  20,  21,  22,  23,  24,        25,       26,        27,       28,   29,  30,       31,    32,  33;               
    //float [] genes0 = {0, 0, 0, 0, 0, 0, 0, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 10000, 0.5};
    // BLACK turning grey
    float [] genes0 = {0, 0, 0, 0, 0, 0, 64, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, width/((gs.rows)*2), 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(200, 400), 10000, 0.5};
    dna0.genes = genes0;
    
    genepool.add(1, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna1 = genepool.get(1);
    // PURE WHITE
    //float [] genes1 = {1, 120, 120, 0, 0, 255, 255, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 10000, 0.5};
    // WHITE turning grey
    float [] genes1 = {1, 120, 120, 0, 0, 255, 240, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, width/((gs.rows)*2), 5.0, 100.0, 100.0, 0.0, 20.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(100, 200), 10, 0.5};
    dna1.genes = genes1;
    
    genepool.add(2, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna2 = genepool.get(2);
    // GREY
    //float [] genes2 = {2, 240, 240, 0, 0, 0, 255, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 52.318718, 0.5};
    // BLUE with red stripes
    //float [] genes2 = {2, 240, 240, 255, 255, 128, 255, 255, 255, 0, 0, 255, 255, 128, 255, 0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 52.318718, 0.5};
    // PALE BLUE with white stripes
    float [] genes2 = {2, 240, 180, 55, 55, 160, 255, 255, 255, 0, 0, 0, 0, 255, 255, 0, 0.0, width/((gs.rows)*2), 5.0, 100.0, 200.0, 30.0, 60.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(100, 200), random(20,60), 0.5};
    dna2.genes = genes2;
    
    genepool.add(3, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna3 = genepool.get(3);
    // noFill
    float [] genes3 = {3, 240, 180, 55, 55, 160, 255, 0, 0, 0, 0, 0, 0, 255, 255, 12, 24, width/((gs.rows)*2), 5.0, 100.0, 200.0, 30.0, 60.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(100, 200), random(20,60), 0.5};
    dna3.genes = genes3;
    
    genepool.add(4, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna4 = genepool.get(4);
    // White to black
    float [] genes4 = {4, 240, 180, 0, 0, 255, 0, 255, 255, 0, 0, 0, 0, 255, 255, 12, 12, width/((gs.rows)*2), 5.0, 100.0, 200.0, 30.0, 60.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(100, 200), 10000, 0.5};
    dna4.genes = genes4;
    
    genepool.add(5, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna5 = genepool.get(5);
    // Black to white
    float [] genes5 = {4, 240, 180, 0, 0, 0, 255, 255, 255, 0, 0, 0, 0, 0, 0, 24, 12, width/((gs.rows)*2), 5.0, 100.0, 200.0, 30.0, 60.0, 0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000), 65.0, 1.0, width * 0.001 * random(100, 200), 10000, 0.5};
    dna5.genes = genes5;
    
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
    if (gs.patternSelector == 0) {random_pattern();}
    else
    if (gs.patternSelector == 1) {center_pattern();}
    else
    if (gs.patternSelector == 2) {cartesian_pattern();}
    else
    if (gs.patternSelector == 3) {cartesian_pattern_alt();}
    else {phyllotaxic_pattern();}
  }

// 0) Spawn cells in a random pattern
void random_pattern() {
  // Here is the code which fills the 'cells' arraylist with cells at random positions
  for (int n = 0; n <= gs.seeds; n++) {
    pos = new PVector(random(width), random(height)); // random position
    origin = new PVector (gs.orx, gs.ory);
    PVector vel = PVector.sub(origin, pos); // Static velocity vector pointing from cell position to the arbitrary 'origin'
    vel.normalize();
    //vel.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')

    DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random strain of dna from the genepool
    //DNA dna = genepool.get(0);                            // Get's a specific strain of dna from the genepool
    dna.genes[0] = n; //n is transferred to gene 0
    
    for (int s = 0; s < gs.strainSize; s ++) {
      population.add(new Cell(pos, vel, dna));
    }
  }
}

// 1) Spawn cells at the center of the screen
void center_pattern() {
  // Here is the code which fills the 'cells' arraylist with cells at the center of the screen
  for (int n = 0; n <= gs.seeds; n++) {
    pos = new PVector(width*0.5, height*0.5); // random position
    vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
    origin = new PVector (gs.orx, gs.ory);
    //PVector vel = PVector.sub(pos, origin); // Static velocity vector pointing from cell position to the arbitrary 'origin'
    //vel.normalize();
    //vel.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')

    DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random strain of dna from the genepool
    //DNA dna = genepool.get(0);                            // Get's a specific strain of dna from the genepool
    dna.genes[0] = n; //n is transferred to gene 28
    
    for (int s = 0; s < gs.strainSize; s ++) {
      population.add(new Cell(pos, vel, dna));
    }
  }
}

// 2) Spawn cells in a cartesian grid pattern
void cartesian_pattern() {
  //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell

  // Here is the code which fills the 'cells' arraylist with cells at given positions
  int n = 0;
  for (int r = 0; r <= gs.rows; r++) {      
    //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
    //a = map(r, 0, gs.rows, 0, TWO_PI);
    //vel = PVector.fromAngle(0).mult(1);
    
    for (int c = 0; c <= gs.cols; c++) {
      //DNA dna = genepool.get(int(random(gs.numStrains+3))); // Get's a random strain of dna from the genepool
      DNA dna = genepool.get(2);                        // Get's a specific strain of dna from the genepool
      dna.genes[0] = n; //n is transferred to gene 0
      n ++;
      float xpos = width * map (c, 0, gs.cols, 0, 1);
      float ypos = height * map (r, 0, gs.rows, 0, 1);
      pos = new PVector(xpos, ypos);
      
      origin = new PVector (gs.orx, gs.ory);

      //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
      vel = PVector.sub(pos, origin); // Static velocity vector pointing from cell position to the arbitrary 'origin'
      vel.normalize();
      //vel.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')

      for (int s = 0; s < gs.strainSize; s ++) {
        //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
        //if ( random(1) > 0.2) {population.add(new Cell(pos, vel, dna));
        population.add(new Cell(pos, vel, dna));
      }
    }
  }
}

// 3) Spawn cells in a cartesian grid pattern with alternating strains
void cartesian_pattern_alt() {
  //vel = PVector.random2D();   // Initial velocity vector is random & identical for each cell

  // Here is the code which fills the 'cells' arraylist with cells at given positions
  int n = 0;
  for (int r = 0; r <= gs.rows; r++) {      
    //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
    //a = map(r, 0, gs.rows, 0, TWO_PI);
    //vel = PVector.fromAngle(0).mult(1);
    
    for (int c = 0; c <= gs.cols; c++) {
      int str = ((r + c) % 2) + 3;
      DNA dna = genepool.get(str); // Get's the appropriate strain of dna from the genepool
      //DNA dna = genepool.get(0);                        // Get's a specific strain of dna from the genepool
      dna.genes[0] = n; //n is transferred to gene 0
      n ++;
      float xpos = width * map (c, 0, gs.cols, 0, 1);
      float ypos = height * map (r, 0, gs.rows, 0, 1);
      pos = new PVector(xpos, ypos);
      
      origin = new PVector (gs.orx, gs.ory);

      //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
      vel = PVector.sub(pos, origin); // Static velocity vector pointing from cell position to the arbitrary 'origin'
      vel.normalize();
      //vel.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')

      for (int s = 0; s < gs.strainSize; s ++) {
        //vel = PVector.random2D();   // Initial velocity vector is random & unique for each cell
        //if ( random(1) > 0.2) {population.add(new Cell(pos, vel, dna));
        population.add(new Cell(pos, vel, dna));
      }
    }
  }
}

// 4) Spawn cells in a phyllotaxic spiral pattern
void phyllotaxic_pattern() {
  // Here is the code which fills the 'cells' arraylist with cells at given positions
  for (int n = 0; n <= gs.seeds; n++) {
    
    // Simple Phyllotaxis formula:
    float a = n * radians(137.5);
    float r = c * sqrt(n);   
    float xpos = r * cos(a) + width * 0.5;
    float ypos = r * sin(a) + height * 0.5;
    pos = new PVector(xpos, ypos);
    
    origin = new PVector (gs.orx, gs.ory);
    PVector vel = PVector.sub(pos, origin); // Static velocity vector pointing from cell position to the arbitrary 'origin'
    vel.normalize();
    //vel.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')
    int str = ((n) % 2) + 1;
    //DNA dna = genepool.get(int(random(gs.numStrains+3))); // Get's a random strain of dna from the genepool
    DNA dna = genepool.get(str); // Get's a random strain of dna from the genepool
    //DNA dna = genepool.get(0); // Get's a specific strain of dna from the genepool
    
    dna.genes[0] = n; //n is transferred to gene 0
    
    for (int s = 0; s < gs.strainSize; s ++) {
      population.add(new Cell(pos, vel, dna));
    }
   c *= 1.0015;
   //c += width * 0.00003;
  }
}



// Spawn a new cell
  void spawn(PVector pos, PVector vel, DNA dna_) {
    population.add(new Cell(pos, vel, dna_));
  }

// Run the colony
  void run() {
    if (gs.debug) {colonyDebugger();}
    for (int i = population.size()-1; i >= 0; i--) {  // Iterate backwards through the ArrayList because we are removing items
      Cell c = population.get(i);                     // Get one cell at a time
      c.run();                                   // Run the cell (grow, move, spawn, check position vs boundaries etc.)
      if (c.dead()) {population.remove(i);}           // If the cell has died, remove it from the array

      // Iteration to check collision between current cell(i) and the rest
      if (population.size() <= gs.populationMaxSize && c.fertile) {         // Don't check for collisons if there are too many cells (wait until some die off)
        for (int others = i-1; others >= 0; others--) {         // Since main iteration (i) goes backwards, this one needs to too
          Cell other = population.get(others);                       // Get the other cells, one by one
          if (other.fertile) { c.checkCollision(other); }       // Only check for collisions when both cells are fertile
        }
      }
    }
  }


  void colonyDebugger() {  // Displays some values as text at the top left corner (for debug only)
    noStroke();
    fill(0);
    rect(0,0,230,40);
    fill(360);
    textSize(16);
    text("frames" + frameCount + " Nr. cells: " + population.size() + " MaxLimit:" + gs.populationMaxSize, 10, 18);
  }

}