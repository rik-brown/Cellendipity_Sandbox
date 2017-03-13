class Colony {

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
    rand = 2;
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
 
    // Strain 1 = WHITE
    genepool.get(0).genes[1] = 0;
    genepool.get(0).genes[21] = 0;
    genepool.get(0).genes[2] = 255;
    genepool.get(0).genes[22] = 255;
    
    // Strain 2 = BLACK
    genepool.get(1).genes[1] = 0;
    genepool.get(1).genes[21] = 0;
    genepool.get(1).genes[2] = 0;
    genepool.get(1).genes[22] = 0;
   
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
        //DNA dna = genepool.get(0); // Get's a specific dna from the genepool
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
        
    
        // 18 = xOff (rnd 1000)
              
        // 20 = fillHend
        // 21 = fillSend
        // 22 = fillBend
        // 23 = fillAend
        
        //float xpos = random(width);
        //float ypos = random(height);
        //float xpos = ((c+1) * (height/(gs.cols+1))); // CARTESIAN ARRAY X
        //float ypos = ((r+1) * (width/(gs.rows+1)));  // CARTESIAN ARRAY Y
        //float xpos = (c * (height/gs.cols)); // CARTESIAN ARRAY X
        //float ypos = (r * (width/gs.rows));  // CARTESIAN ARRAY Y
        float xpos = width * map (c, 0, gs.cols, 0, 1);
        float ypos = height * map (r, 0, gs.rows, 0, 1);
        pos = new PVector(xpos, ypos);
        origin = new PVector(width/2, height/2);
        PVector distVect = PVector.sub(origin, pos); // Static vector to get distance between the cell & other
        float distMag = distVect.mag();       // calculate magnitude of the vector separating the balls
        //float xpos = p.x + width/2;                  // RADIAL ARRAY X
        //float ypos = p.y + height/2;                 // RADIAL ARRAY Y
        //dna.genes[0] = map(r, 0, gs.rows, 200, 260);         // 0 = fill Hue (0-360)
        //dna.genes[0] = map(distMag, 0, width*0.5, 240, 280); // 0 = fill Hue (0-360)
        //dna.genes[1] = map(c, 0, gs.cols, 128, 255);         // 1 = fill Saturation (0-255)
        //dna.genes[1] = map(xpos, 0, width, 64, 255);         // 1 = fill Saturation (0-255)
        //dna.genes[2] = map(ypos, 0, height, 192, 255);       // 2 = fill Brightness (0-255)
        //dna.genes[8] = width/(gs.rows*(map(c, 0, gs.cols, 1.8, 2.2))); // 8 = cellStartSize
        //dna.genes[8] = map(c, 0, gs.cols, 50, 350); // 8 = cellStartSize
        //dna.genes[8] = width/(gs.rows*map(distMag, 0, width*0.7, 1.6, 2.5));
        dna.genes[10] = width * map(distMag, 0, width*0.7, 0.18, 0.012); // 10 = lifespan (200-1000)
        //dna.genes[10] = map(c, 0, gs.cols, width*0.01, width*0.25); // 10 = lifespan (200-1000)
        //dna.genes[10] = width * map(r, 0, gs.rows, 0.1, 0.3); // 10 = lifespan (200-1000)
        //dna.genes[11] = map(c, 0, gs.cols, 75, 150); // 11 = flatness (50-200 %)
        //dna.genes[12] = map(c, 0, gs.cols, 45, 60); // 12 = spiral screw (-75 - +75 %)
        dna.genes[12] = map(distMag, 0, width*0.7, 15, 5); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[12] = map(a, 0, TWO_PI, 0, 10); // 12 = spiral screw (-75 - +75 %)
        //dna.genes[17] = map(ypos], 0, height, 0, 30); // 17 = noisePercent (0-100%)
        //dna.genes[17] = map(c, 0, gs.cols, 0, 100); // 17 = noisePercent (0-100%)
        dna.genes[17] = map(distMag, 0, width*0.7, 100, 50); // 17 = noisePercent (0-100%)
        //dna.genes[19] = map(r, 0, gs.rows, 0, 1); // 21 = yOff (rnd 1000)
        //dna.genes[0] = map(distMag, 0, width*0.7, 0, 180); // 20 = fillHstart
        //dna.genes[20] = dna.genes[20] * map(distMag, 0, width*0.7, 0.7, 1); // 21 = fillHend
        //dna.genes[0] = map(r, 0, gs.rows, 0, 360); // 20 = fillHstart
        //dna.genes[20] = map(c, 0, gs.cols, 360, 0); // 21 = fillHend
        //dna.genes[20] = map(c, 0, gs.cols, gs.bkg_H, gs.bkg_H*1.3); // 21 = fillHend
        //dna.genes[20] = gs.bkg_H * map(c, 0, gs.cols, 0.7, 1.0); // 21 = fillHend
        //dna.genes[22] = map(distMag, 0, width*0.7, 255, 20); // 25 = fillBend
        //dna.genes[22] = map(r, 0, gs.rows, 160, 220); // 25 = fillBend
        //dna.genes[22] = map(distMag, 0, width*0.7, 0, 255); // 25 = fillBend
        dna.genes[24] = dna.genes[20] * map(distMag, 0, width*0.7, 0.7, 1); // 21 = stroke_Hend
        dna.genes[26] = map(distMag, 0, width*0.7, 255, 20); // 25 = stroke_Bend
        //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
        for (int s = 0; s < gs.strainSize; s ++) {
          //v = PVector.random2D();   // Initial velocity vector is random & unique for each cell
          //if ( random(1) > 0.2) {cells.add(new Cell(v, dna));
		  cells.add(new Cell(pos, v, dna));
        }
      }
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