class Colony {

// position is no longer passed in to the constructor as a vector, but as values in the DNA
// this is not ideal, but better than before (when it didn't work)

  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  int colonyMaxSize = 200;
  PVector v;
  PVector p;
  PVector pos;
  PVector origin;
  float a;
  float rand;

  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Colony() {
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    //rand = random(0,2);
    rand = 0;
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
    genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
    //float col0 =gs.bkg_H + 0; 
    //if (col0 > 360) {col0 -= 360;}
    //genepool.get(0).genes[0] = col0;
    //genepool.get(0).genes[1] = gs.bkg_S;
    //genepool.get(0).genes[2] = gs.bkg_B;
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
      //a = map(r, 0, gs.rows, 0, TWO_PI);
      a = map(r, 0, gs.rows, 0, PI*rand);
      p = PVector.fromAngle(a);
      v = PVector.fromAngle(0).mult(1);
      p.mult(width/4);
      
      for (int c = 0; c <= gs.cols; c++) {
        DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random dna from the genepool
        //DNA dna = genepool.get(0); // Get's a random dna from the genepool
        // DNA gene mapping (32 genes)
            
      // 3 = fill Alpha (0-255)
      // 4 = stroke Hue (0-360)
      // 5 = stroke Saturation (0-255)
      // 6 = stroke Brightness (0-255)
      // 7 = stroke Alpha (0-255)
      
      // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)  
      
      // 13 = fertility (70-90%)
      // 14 = spawnCount (1-5)
      // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
      // 16 = step (Noise) (1 - 6 * 0.001?)  (cellendipity/one uses 0.001-0.006)
      
      // 18 = seedPosX (0-width)
      // 19 = seedPosY (0-height)
      // 20 = originX (0-width)
      // 21 = originY (0-height)
      // 22 = xOff (rnd 1000)
            
      // 26 = fillSstart
      // 27 = fillSend
      // 28 = fillBstart
      
      // 30 = fillAstart
      // 31 = fillAend
      //dna.genes[18] = random(width);
      //dna.genes[19] = random(height);
        //dna.genes[18] = ((c+1) * (height/(gs.cols+1))); // CARTESIAN ARRAY X
        //dna.genes[19] = ((r+1) * (width/(gs.rows+1)));  // CARTESIAN ARRAY Y
        //dna.genes[18] = (c * (height/gs.cols)); // CARTESIAN ARRAY X
        //dna.genes[19] = (r * (width/gs.rows));  // CARTESIAN ARRAY Y
        dna.genes[18] = height * map (c, 0, gs.cols, -0.2, 1.2);
        dna.genes[19] = width * map (r, 0, gs.rows, -0.2, 1.2);
        pos = new PVector(dna.genes[18], dna.genes[19]);
        origin = new PVector(width/2, height/2);
        PVector distVect = PVector.sub(origin, pos); // Static vector to get distance between the cell & other
        float distMag = distVect.mag();       // calculate magnitude of the vector separating the balls
        //dna.genes[18] = p.x + width/2;                  // RADIAL ARRAY X
        //dna.genes[19] = p.y + height/2;                 // RADIAL ARRAY Y
        //dna.genes[0] = map(r, 0, gs.rows, 200, 260); // 0 = fill Hue (0-360)
        //dna.genes[0] = map(distMag, 0, width*0.5, 240, 280); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[1] = map(c, 0, gs.cols, 128, 255); // 1 = fill Saturation (0-255)
        //dna.genes[1] = map(dna.genes[18], 0, width, 64, 255); // 1 = fill Saturation (0-255)
        //dna.genes[2] = map(dna.genes[19], 0, height, 192, 255); // 2 = fill Brightness (0-255)
        //dna.genes[8] = width/(gs.rows*(map(c, 0, gs.cols, 1.8, 2.2))); // 8 = cellStartSize
        //dna.genes[8] = map(c, 0, gs.cols, 50, 350); // 8 = cellStartSize
        dna.genes[10] = width * map(distMag, 0, width, 0.4, 0.001); // 10 = lifespan (200-1000)
        //dna.genes[10] = map(c, 0, gs.cols, width*0.01, width*0.25); // 10 = lifespan (200-1000)
        //dna.genes[10] = width * map(r, 0, gs.rows, 0.1, 0.3); // 10 = lifespan (200-1000)
        //dna.genes[11] = map(c, 0, gs.cols, 75, 150); // 11 = flatness (50-200 %)
        //dna.genes[12] = map(c, 0, gs.cols, 45, 60); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[12] = map(distMag, 0, width*0.5, 0, 10); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[12] = map(a, 0, TWO_PI, 0, 10); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[17] = map(dna.genes[19], 0, height, 0, 30); // 17 = noisePercent (0-100%)
        //dna.genes[17] = map(c, 0, gs.cols, 0, 100); // 17 = noisePercent (0-100%)
        dna.genes[17] = map(distMag, 0, width*0.7, 100, 50); // 17 = noisePercent (0-100%)
        //dna.genes[23] = map(r, 0, gs.rows, 0, 1); // 23 = yOff (rnd 1000)
        //dna.genes[24] = map(distMag, 0, width*0.5, 0, 360); // 24 = fillHstart
        //dna.genes[25] = map(distMag, 0, width*0.5, 0, 360); // 25 = fillHend
        //dna.genes[24] = map(r, 0, gs.rows, 0, 360); // 25 = fillHend
        //dna.genes[25] = map(c, 0, gs.cols, gs.bkg_H, gs.bkg_H*1.3); // 25 = fillHend
        //dna.genes[25] = gs.bkg_H * map(c, 0, gs.cols, 0.7, 1.0); // 25 = fillHend
        //dna.genes[29] = map(distMag, 0, width*0.5, 255, 0); // 29 = fillBend
        //dna.genes[29] = map(r, 0, gs.rows, 160, 220); // 29 = fillBend
        //dna.genes[29] = map(distMag, 0, width*0.7, 0, 255); // 29 = fillBend
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