class Phyllotaxis {

  // Is this a good way to keep different spawn patterns separate?
  // Probably not the best way, but worth a try...
  
  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  int colonyMaxSize = 200;
  int sf = 27;
  float c = width * 0.001 * sf; // Scaling factor
  //float c = 0; // Scaling factor
  PVector v;
  PVector pos;
  PVector origin;


  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Phyllotaxis() {
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    //v = PVector.random2D();
    
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
      
      PVector v = PVector.sub(pos, origin); // Static vector to get distance between the cell & other
      v.normalize();
      v.rotate(PI * 0.5);
      
      
      DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random dna from the genepool
      //dna.genes[8] = width * map(distance, 0, width*0.5, 0.02, 0.035); // 8 = cellStartSize
      //dna.genes[10] = map(distance, 0, width*0.5, 15, 55); // 10 = lifespan (200-1000)
      
      dna.genes[8] = width * 0.001 * map(n, 0, gs.seeds, sf*0.8, sf); // 8 = cellStartSize
      dna.genes[10] = width * 0.001 * map(n, 0, gs.seeds, 200, 10); // 10 = lifespan (200-1000)
      //dna.genes[12] = map(n, 0, gs.seeds, 5, 15); // 12 = spiral screw (-75 - +75 %)
      dna.genes[17] = map(n, 0, gs.seeds, 100, 0); // 17 = noisePercent (0-100%)
      
      //dna.genes[18] = map(xpos, 0, width, 0, 1); // 18 = xOff (0-1000)
      //dna.genes[19] = map(ypos, 0, height, 0, 1); // 19 = yOff (0-1000)
      
      //dna.genes[18] = map(n, 0, gs.seeds, 0, 10); // 18 = xOff (0-1000)
      //dna.genes[19] = map(n, 0, gs.seeds, 0, 10); // 19 = yOff (0-1000)
      
      //dna.genes[20] = gs.bkg_H + map(n, 0, gs.seeds, 0, 30); //
      //dna.genes[21] = gs.bkg_H + map(n, 0, gs.seeds, 10, 30); //
      
      //dna.genes[22] = map(n, 0, gs.seeds, 255, 64); //
      //dna.genes[23] = map(n, 0, gs.seeds, 16, 255); //
      
      //dna.genes[24] = map(n, 0, gs.seeds, 0, 255); //
      //dna.genes[25] = map(n, 0, gs.seeds, 192, 0); //
      
      //dna.genes[26] = map(n, 0, gs.seeds, 255, 0); //
      
      //dna.genes[29] = dna.genes[20] * map(distance, 0, width*0.7, 0.7, 1); // 21 = stroke_Hend
      
      //dna.genes[33] = map(distance, 0, width*0.7, 255, 20); // 25 = stroke_Bend
      
      for (int s = 0; s < gs.strainSize; s ++) {
        cells.add(new Cell(pos, v, dna));
      }
     //c *= 1.0015;
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