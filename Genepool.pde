class Genepool {

  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  Table genetable; // A table of gene data
  
  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Genepool() {
    genepool = new ArrayList<DNA>();
    Table genetable = loadTable("genepool.csv", "header");
    int numGenes = genetable.getColumnCount();
    int numRows = genetable.getRowCount();
    //TableRow row = genetable.getRow(2);
    int rowCount = 0;
    
    println ("#rows: " + numRows);
    println ("#cols: " + numGenes);
    for (TableRow row : genetable.rows()) {
      for( int col = 0; col < genetable.getColumnCount(); col++) {  
        String Colname = genetable.getColumnTitle(col);
        float value = row.getFloat(col);
        println ("Row: " + rowCount + " Col: " + Colname + " Value: " + value);
      }
      rowCount ++;
    }
    
        // Here is the code which fills the 'genepool' arraylist with some preset DNA-strains.
    genepool.add(0, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna0 = genepool.get(0);
    // PURE BLACK
                   
    // 0=ID,
    // 1=fill_H_start, 2=fill_H_end, 3=fill_S_start, 4=fill_S_end, 5=fill_B_start, 6=fill_B_end, 7=fill_A_start, 8=fill_A_end,
    // 9=stroke_H_start, 10=stroke_H_end, 11=stroke_S_start, 12=stroke_S_end, 13=stroke_B_start, 14=stroke_B_end, 15=stroke_A_start, 16=stroke_A_end,
    // 17=radius_Start, 18=radius_End, 19=flatness_start, 20=flatness_end, 21=twist_Start, 22=twist_End,
    // 23=noisePercent_Start, 24=noisePercent_End, 25=noise_vMax, 26=noise_Step, 27=noise_xOff, 28=noise_yOff,
    // 29=fertility, 30=spawnLimit, 31=lifespan, 32=StripeSize, 33=StripeRatio  
    
    // BLACK turning grey
    float [] genes0 = {0,
                       0, 0, 0, 0, 0, 180, 255, 255,
                       0, 0, 0, 0, 128, 255, 0, 0,
                       500/gs.rows, 5, 100, 100, 10, 20,
                       0, 0, random(2, 4), random(1, 6), random(1000), random(1000),
                       65, 1, random(100, 250), 10000, 0.5};
    dna0.genes = genes0;
    
    genepool.add(1, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna1 = genepool.get(1);
    // PURE WHITE
    //float [] genes1 = {1, 120, 120, 0, 0, 255, 255, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 10000, 0.5};
    // WHITE turning grey
    float [] genes1 = {1,
                      120, 120, 0, 0, 255, 220, 255, 255,
                        0,   0, 0, 0,   0, 128,   0,   0,
                      500/gs.rows, 5, 100, 80, 0, 30,
                      0, 0, random(2, 4), random(1, 6), random(1000), random(1000),
                      65, 1, random(100, 200), 10000, 0.5};
    dna1.genes = genes1;
    
    genepool.add(2, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna2 = genepool.get(2);
    // GREY
    //float [] genes2 = {2, 240, 240, 0, 0, 0, 255, 255.0, 255.0, 0.0, 0.0, 0.0, 0.0, 0.0, 128.0, 0.0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 52.318718, 0.5};
    // BLUE with red stripes
    //float [] genes2 = {2, 240, 240, 255, 255, 128, 255, 255, 255, 0, 0, 255, 255, 128, 255, 0, 0.0, 107.01311, 5.0, 300.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7383308, 3.411943, 233.01321, 522.7996, 65.0, 1.0, 225.5199, 52.318718, 0.5};
    // PALE BLUE with white stripes
    float [] genes2 = {2,
                       240, 180, 55, 55, 160, 255, 255, 255,
                       0, 0, 0, 0, 255, 255, 0, 0,
                       500/gs.rows, 5.0, 100.0, 200.0, 30.0, 60.0,
                       0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000),
                       65.0, 1.0, random(100, 200), random(20,60), 0.5};
    dna2.genes = genes2;
    
    genepool.add(3, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna3 = genepool.get(3);
    // noFill WHITE
    float [] genes3 = {3,
                       240, 180, 55, 55, 160, 255, 0, 0,
                       0, 0, 0, 0, 255, 255, 12, 44,
                       500/gs.rows, 5.0, 100.0, 200.0, 30.0, 60.0,
                       0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000),
                       65.0, 1.0, random(100, 200), random(20,60), 0.5};
    dna3.genes = genes3;
    
    genepool.add(4, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna4 = genepool.get(4);
    // White to black
    float [] genes4 = {4,
                       240, 180, 0, 0, 255, 0, 255, 255,
                       0, 0, 0, 0, 255, 255, 12, 12,
                       500/gs.rows, 5.0, 100.0, 200.0, 30.0, 60.0,
                       0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000),
                       65.0, 1.0, random(100, 200), 10000, 0.5};
    dna4.genes = genes4;
    
    genepool.add(5, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna5 = genepool.get(5);
    // Black to white
    float [] genes5 = {5,
                       240, 180, 0, 0, 0, 255, 255, 255,
                       0, 0, 0, 0, 0, 0, 24, 12,
                       500/gs.rows, 5.0, 100.0, 200.0, 30.0, 60.0,
                       0.0, 0.0, random(2, 4), random(1, 6), random(1000), random(1000),
                       65.0, 1.0, random(100, 200), 10000, 0.5};
    dna5.genes = genes5;
    
    genepool.add(6, new DNA()); // Add new DNA object to the genepool in position 0
    DNA dna6 = genepool.get(6);
    // Thin filaments with noise development
    float [] genes6 = {6,
                      240, 240, 0, 0, 0, 255, 255, 255,
                        0,   0, 0, 0,   0,   0,   0,   0,
                      width/((gs.rows)*2*1.5), 1, 100, 100, 50, 25,
                      100, 20, random(2, 4), random(1, 6), random(1000), random(1000),
                      65, 1, 300, 10000, 0.5};
    dna6.genes = genes6;
    
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
  }

}