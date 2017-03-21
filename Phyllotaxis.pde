class Phyllotaxis {

  // Is this a good way to keep different spawn patterns separate?
  // Probably not the best way, but worth a try...
  // Should ultimately boil down to a simple 'position and velocity pattern' (with all the rest taken care of by the cell & it's dna)
  
  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  
  int colonyMaxSize = 200;  // Not really used when 'breeding' is disabled
  
  float w = width * 0.001;  // For convinience
  float c = w * 8; // Scaling factor
  
  PVector v;
  PVector pos;
  PVector origin;
  float orx = width * random (0.3, 0.7);  // Random but kept roughly within the pattern
  float ory = height * random (0.3, 0.7); // Random but kept roughly within the pattern
  //float orx = width * 0.5;  // Centered
  //float ory = height * 0.5; // Centered


  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Phyllotaxis() {
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    //v = PVector.random2D(); // All cells get the same random velocity vector
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
           
    // Here is the code which fills the 'cells' arraylist with cells at given positions
    for (int n = 0; n <= gs.seeds; n++) {
      
      // Simple Phyllotaxis formula:
      float a = n * radians(137.5);
      float r = c * sqrt(n);   
      float xpos = r * cos(a) + width * 0.5;
      float ypos = r * sin(a) + height * 0.5;
      pos = new PVector(xpos, ypos);
      
      origin = new PVector (orx, ory);
      PVector v = PVector.sub(pos, origin); // Static velocity vector pointing from cell position to the arbitrary 'origin'
      v.normalize();
      v.rotate(PI * 1.5); // Velocity is rotated 270 degrees (to be at right-angle to the radial 'spoke')

      //DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random strain of dna from the genepool
      DNA dna = genepool.get(0);                            // Get's a specific strain of dna from the genepool
      
      dna.genes[28] = n; //n is transferred to gene 28
      
      for (int s = 0; s < gs.strainSize; s ++) {
        cells.add(new Cell(pos, v, dna));
      }
     c *= 1.002;
     //c += width * 0.00003;
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