class Phyllotaxis {

  // Is this a good way to keep different spawn patterns separate?
  // Probably not the best way, but worth a try...
  
  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  ArrayList<Cell> cells;    // An arraylist for all the cells //<>//
  int colonyMaxSize = 200;
  float w = width * 0.001;
  float sf = 20000/gs.seeds;
  //float c = w * sf; // Scaling factor
  float c;
  //float c = 0; // Scaling factor
  int picker = int(random(gs.seeds*0.5, gs.seeds*0.9));
  int picked;
  PVector v;
  PVector pos;
  PVector origin;


  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Phyllotaxis() {
    println("Picker = " + picker);
    genepool = new ArrayList<DNA>();
    cells = new ArrayList<Cell>();
    //v = PVector.random2D();
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
    // Strain 1 = WHITE
    genepool.get(0).genes[0] = 128;
    genepool.get(0).genes[20] = 64;
    genepool.get(0).genes[1] = 0;
    genepool.get(0).genes[21] = 60;
    genepool.get(0).genes[2] = 255;
    genepool.get(0).genes[22] = 128;
    genepool.get(0).genes[3] = 255;
    genepool.get(0).genes[23] = 255;
    
    // Strain 2 = BLACK
    genepool.get(1).genes[0] = 94;
    genepool.get(1).genes[20] = 158;
    genepool.get(1).genes[1] = 60;
    genepool.get(1).genes[21] = 0;
    genepool.get(1).genes[2] = 128;
    genepool.get(1).genes[22] = 255;
    genepool.get(1).genes[3] = 255;
    genepool.get(1).genes[23] = 255;
    genepool.get(1).genes[7] = 8;
    
           
    // Here is the code which fills the 'cells' arraylist with cells at given positions
    for (int n = 1; n <= gs.seeds; n++) {      
      int str = (n % gs.numStrains);
      c = map(n, 1, gs.seeds, 0, w * sf * 0.3);
      //c = n*0.2;
      float a = n * radians(137.5);
      float r = c * sqrt(n);
      float xpos = r * cos(a) + width * 0.5;
      float ypos = r * sin(a) + height * 0.5;
      pos = new PVector(xpos, ypos);
      origin = new PVector (width * 0.5, height * 0.5);
      float distance = dist(xpos, ypos, width*0.5, height*0.5);
      
      PVector v = PVector.sub(pos, origin); // Static vector to get distance between the cell & other
      //v = new PVector(1, 0); // Static vector to get distance between the cell & other
      v.normalize();
      v.rotate(PI * 0.5);
      //v.rotate(PI * str * 0.15);
      
      
      //DNA dna = genepool.get(int(random(gs.numStrains))); // Get's a random dna from the genepool
      //DNA dna = genepool.get(str); // Get's alternating dna from the genepool
      if (n == picker) {picked = 1;} else {picked = 0;}
      DNA dna = genepool.get(picked); 
      
      //dna.genes[8] = n;
      //dna.genes[8] = width * map(distance, 0, width*0.5, 0.02, 0.035); // 8 = cellStartSize
      //dna.genes[10] = map(distance, 0, width*0.5, 15, 55); // 10 = lifespan (200-1000)
      dna.genes[10] = w * map(n, 1, gs.seeds, 12, 80); // 10 = lifespan (200-1000)
      //dna.genes[10] = w * map(str, 0, gs.numStrains, 50, 150); // 10 = lifespan (200-1000)
      dna.genes[12] = map(n, 1, gs.seeds, 0, 30); // 12 = spiral screw (-75 - +75 %)
      dna.genes[17] = map(n, 1, gs.seeds, 0, 50); // 17 = noisePercent (0-100%)
      
      //dna.genes[8] = w * map(n, 1, gs.seeds, 1, 20); // 8 = cellStartSize
            
      if (picked == 1) {dna.genes[8] = w * map(n, 1, gs.seeds, 1, 40);} else {dna.genes[8] = w * map(n, 1, gs.seeds, 1, 20);} // 10 = lifespan (200-1000)  
      //if (picked == 1) {dna.genes[10] = map(n, 1, gs.seeds, 20, 400);} else {dna.genes[10] = map(n, 1, gs.seeds, 5, 100);} // 10 = lifespan (200-1000)
      //if (picked == 1) {dna.genes[12] = map(n, 1, gs.seeds, 0, -10);} else {dna.genes[12] = map(n, 1, gs.seeds, 0, 10);} // 12 = spiral screw (-75 - +75 %)
      //if (picked == 1) {dna.genes[17] = map(n, 1, gs.seeds, 0, 0);} else {dna.genes[17] = map(n, 1, gs.seeds, 0, 50);} // 17 = noisePercent (0-100%)
      //if (picked == 1) {dna.genes[18] = random(1000);}
      
      //dna.genes[18] = map(xpos, 0, width, 0, 1); // 18 = xOff (0-1000)
      //dna.genes[19] = map(ypos, 0, height, 0, 1); // 19 = yOff (0-1000)
      
      //dna.genes[15] = map(n, 0, gs.seeds, 5, 2); // 18 = xOff (0-1000)
      //dna.genes[16] = map(n, 0, gs.seeds, 1, 6); // 19 = yOff (0-1000)
      
      //dna.genes[0] = map(n, 0, gs.seeds, 230, 240); //
      //dna.genes[20] = map(n, 0, gs.seeds, 240, 250); //
      
      //dna.genes[1] = map(n, 0, gs.seeds, gs.bkg_S, gs.bkg_S*0.9); //
      //dna.genes[1] = map(n, 0, gs.seeds, 255, 128); //
      //dna.genes[1] = map(n, 0, gs.seeds, 220, 255); //
      //dna.genes[21] = map(n, 0, gs.seeds, 200, 180); //
      //dna.genes[21] = map(n, 0, gs.seeds, 64, gs.bkg_S); //
      
      //dna.genes[2] = map(n, 0, gs.seeds, 100, 125); //
      //dna.genes[22] = map(n, 0, gs.seeds, 255, 200); //
      
      //dna.genes[3] = map(n, 0, gs.seeds, 0, 255); //
      //dna.genes[23] = map(n, 0, gs.seeds, 224, 192); //
      
      //dna.genes[4] = map(n, 0, gs.seeds, 255, 0); //
      //dna.genes[24] = dna.genes[20] * map(distance, 0, width*0.7, 0.7, 1); // 21 = stroke_Hend
      
      //dna.genes[26] = map(distance, 0, width*0.7, 255, 20); // 25 = stroke_Bend
      
      dna.genes[28] = str; //StrainID is transferred to gene 28
      
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