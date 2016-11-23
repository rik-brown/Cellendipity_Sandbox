class Colony {

// position is no longer passed in to the constructor as a vector, but as values in the DNA
// this is not ideal, but better than before (when it didn't work)

  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  int colonyMaxSize = 200;
  PVector v;
  PVector p;
  float a;

  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Colony() {
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
    genepool.add(new DNA()); // Add new Cell with DNA
    }
    
    float col0 =gs.bkg_H + 0; 
    if (col0 > 360) {col0 -= 360;}
    genepool.get(0).genes[0] = col0;
    genepool.get(0).genes[1] = gs.bkg_S;
    genepool.get(0).genes[2] = gs.bkg_B;
    //float col1 =gs.bkg_H + 200; 
    //if (col1 > 360) {col1 -= 360;}
    //genepool.get(1).genes[0] = col1;
    
    //genepool.get(1).genes[1] = 10;
    //genepool.get(1).genes[2] = 255;
    //genepool.get(2).genes[1] = 0;
    //genepool.get(2).genes[2] = 0;
    
    
    //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
    
    // Here is the code which fills the 'cells' arraylist with cells at given positions
    for (int r = 0; r <= gs.rows; r++) {
      
      //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
      //if (i == 0) {dna.genes[1] = 255; dna.genes[2] = 0;} else {dna.genes[1] = 0; dna.genes[2] = 255;}
      a = map(r, 0, gs.rows, 0, TWO_PI);
      //a = map(r, 0, gs.rows, 0, PI);
      p = PVector.fromAngle(a);
      v = PVector.fromAngle(a).mult(-1);
      p.mult(width/4);
      
      for (int c = 0; c <= gs.cols; c++) {
        DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random dna from the genepool
        //dna.genes[18] = ((r+1) * (width/(gs.rows+1)));  // CARTESIAN ARRAY X
        //dna.genes[19] = ((c+1) * (height/(gs.cols+1))); // CARTESIAN ARRAY Y
        dna.genes[18] = (r * (width/gs.rows));  // CARTESIAN ARRAY X
        dna.genes[19] = (c * (height/gs.cols)); // CARTESIAN ARRAY Y
        //dna.genes[18] = p.x + width/2;                  // RADIAL ARRAY X
        //dna.genes[19] = p.y + height/2;                 // RADIAL ARRAY Y
        //dna.genes[1] = map(dna.genes[18], 0, width, 64, 255);
        //dna.genes[2] = map(dna.genes[19], 0, height, 192, 255);
        dna.genes[10] = map(r, 0, gs.rows, width*0.09, width*0.01);
        //dna.genes[12] = map(dna.genes[18], 0, width, 0, 10);
        //dna.genes[12] = map(a, 0, TWO_PI, 0, 10);
        //dna.genes[17] = map(dna.genes[19], 0, height, 0, 30);
        //dna.genes[22] = map(c, 0, gs.cols, 0, 1);
        //dna.genes[23] = map(r, 0, gs.rows, 0, 1);
        //dna.genes[25] = map(c, 0, gs.cols, gs.bkg_H, gs.bkg_H*1.3);
        //dna.genes[29] = map(r, 0, gs.rows, gs.bkg_B, gs.bkg_B*2.0);
        //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
        for (int s = 0; s < gs.strainSize; s ++) {
          //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
          //if ( random(1) > 0.2) {cells.add(new Cell(v, dna));
		  cells.add(new Cell(v, dna));
        }
      }
    }
  }

// Spawn a new cell
  void spawn(PVector vel, DNA dna_) {
    cells.add(new Cell(vel, dna_));
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