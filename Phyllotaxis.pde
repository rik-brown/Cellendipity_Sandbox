class Phyllotaxis {

  // Is this a good way to keep different spawn patterns separate?
  // Probably not the best way, but worth a try...
  
  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  int colonyMaxSize = 200;
  float c = width * 0.008; // Scaling factor
  PVector v;
  PVector pos;
  PVector origin;


  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Phyllotaxis() {
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
           
    // Here is the code which fills the 'cells' arraylist with cells at given positions
    for (int n = 0; n <= gs.seeds; n++) {      
      float a = n * radians(137.5);
      float r = c * sqrt(n);
      float xpos = r * cos(a) + width * 0.5;
      float ypos = r * sin(a) + height * 0.5;
      pos = new PVector(xpos, ypos);
      origin = new PVector (width * 0.5, height * 0.5);
      float distance = dist(xpos, ypos, width*0.5, height*0.5);
      
      //v = PVector.sub(origin, pos).mult(1); // Static vector to get distance between the cell & other
      
      
      DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random dna from the genepool
      //dna.genes[8] = width * map(distance, 0, width*0.5, 0.02, 0.035); // 8 = cellStartSize
      //dna.genes[10] = map(distance, 0, width*0.5, 15, 55); // 10 = lifespan (200-1000)
      
      dna.genes[8] = width * map(n, 0, gs.seeds, 0.004, 0.04); // 8 = cellStartSize
      dna.genes[10] = map(n, 0, gs.seeds, 15, 65); // 10 = lifespan (200-1000)
      dna.genes[12] = map(n, 0, gs.seeds, 25, 5); // 12 = spiral screw (-75 - +75 %)
      //dna.genes[17] = map(n, 0, gs.seeds, 100, 50); // 17 = noisePercent (0-100%)
      
      //dna.genes[20] = map(n, 0, gs.seeds, 0, 360); //
      dna.genes[21] = dna.genes[20] + map(n, 0, gs.seeds, 30, 0); //
      
      //dna.genes[22] = map(n, 0, gs.seeds, 0, 255); //
      dna.genes[23] = map(n, 0, gs.seeds, 64, 255); //
      
      //dna.genes[24] = map(n, 0, gs.seeds, 0, 255); //
      dna.genes[25] = map(n, 0, gs.seeds, 255, 128); //
      
      //dna.genes[26] = map(n, 0, gs.seeds, 255, 0); //
      
      //dna.genes[29] = dna.genes[20] * map(distance, 0, width*0.7, 0.7, 1); // 21 = stroke_Hend
      
      //dna.genes[33] = map(distance, 0, width*0.7, 255, 20); // 25 = stroke_Bend
      
      for (int s = 0; s < gs.strainSize; s ++) {
        cells.add(new Cell(pos, v, dna));
      }
     c *= 1.002;
    }
  }

// Spawn a new cell
  void spawn(PVector pos, PVector vel, DNA dna_) {
    cells.add(new Cell(pos, vel, dna_));
  }

// Run the colony
  void run() {
    if (gs.debug) {colonyDebugger();}
    for (int i = cells.size()-1; i >= 0; i--) {  // Iterate backwards through the ArrayList because we are removing items
      Cell c = cells.get(i);                     // Get one cell at a time
      c.run();                                   // Run the cell (grow, move, spawn, check position vs boundaries etc.)
      if (c.dead()) {cells.remove(i);}           // If the cell has died, remove it from the array

      // Iteration to check collision between current cell(i) and the rest
      if (cells.size() <= colonyMaxSize && c.fertile) {         // Don't check for collisons if there are too many cells (wait until some die off)
        for (int others = i-1; others >= 0; others--) {         // Since main iteration (i) goes backwards, this one needs to too
          Cell other = cells.get(others);                       // Get the other cells, one by one
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
    text("frames" + frameCount + " Nr. cells: " + cells.size() + " MaxLimit:" + colonyMaxSize, 10, 18);
  }

}