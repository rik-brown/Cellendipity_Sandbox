// Class to describe DNA
// Borrowed from 'Evolution EcoSystem'
// by Daniel Shiffman <http://www.shiffman.net> #codingrainbow

// Settings apply equally to all cells in a strain
// Adding genes for position. All cells in a strain will share the same start position

class DNA {

  float[] genes;  // 'genes' is an array of float values in the range (0-1)
  int numGenes;

  // Constructor (makes a random DNA)
  DNA() {
      numGenes = 22;
      genes = new float[numGenes];  // DNA contains an array called 'genes' with [12] float values

      // DNA gene mapping (18 genes)
      // 0 = fill Hue (0-360)
      // 1 = fill Saturation (0-255)
      // 2 = fill Brightness (0-255)
      // 3 = fill Alpha (0-255)
      // 4 = stroke Hue (0-360)
      // 5 = stroke Saturation (0-255)
      // 6 = stroke Brightness (0-255)
      // 7 = stroke Alpha (0-255)
      // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
      // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
      // 10 = lifespan (200-1000)
      // 11 = flatness (50-200 %)
      // 12 = spiral screw (-75 - +75 %)
      // 13 = fertility (70-90%)
      // 14 = spawnCount (1-5)
      // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
      // 16 = step (Noise) (1 - 6 * 0.001?)  (cellendipity/one uses 0.001-0.006)
      // 17 = noisePercent (0-100%)
      // 18 = seedPosX (0-width)
      // 19 = seedPosY (0-height)
      // 20 = originX (0-width)
      // 21 = originY (0-height)


      // RANDOMIZED VALUES
            genes[0] = 0;    // 0 = fill Hue (0-360)
            genes[1] = 105;  // 1 = fill Saturation (0-255)
            genes[2] = 0;    // 2 = fill Brightness (0-255)
            genes[3] = 24;   // 3 = fill Alpha (0-255)
      
            genes[4] = 0;    // 4 = stroke Hue (0-360)
            genes[5] = 0;    // 5 = stroke Saturation (0-255)
            genes[6] = 0;    // 6 = stroke Brightness (0-255)
            genes[7] = random(5.5, 6.3);    // 7 = stroke Alpha (0-255)
      
            genes[8] = width * 0.1;   // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
            genes[9] = 25;   // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
            genes[10] = width * 0.45;  // 10 = lifespan (200-1000)
            genes[11] = 125; // 11 = flatness (50-200 %)
            genes[12] = 30;  // 12 = spiral screw (-75 - +75 %)
            genes[13] = 73;  // 13 = fertility (70-90%)
            genes[14] = 3;   // 14 = spawnCount (1-5)
            
            genes[15] = random(2, 4);      // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
            genes[16] = 4;   // 16 = step (Noise) (1 - 6 * 0.001?)  (cellendipity/one uses 0.001-0.006)
            genes[17] = 85;  // 17 = noisePercent (0-100%)
            
            genes[18] = width/2;
            genes[19] = height/2;

            logDNA();
   }

  void logDNA() {
    for (int n = 0; n < numGenes; n++) {
      output.println("gene[" + n + "] = " + genes[n]);
      }
  }

  DNA(float[] newgenes) {
    genes = newgenes;
  }

  DNA combine(DNA otherDNA_) { // Returns a new set of DNA consisting of randomly selected genes from both parents
    float[] newgenes = new float[genes.length];
    for (int i = 0; i < newgenes.length; i++) {
      if (random(1) < 0.5) {newgenes[i] = genes[i];}
      else {newgenes[i] = otherDNA_.genes[i];} // 50/50 chance of copying gene from either 'mother' or 'other'
    }
    return new DNA(newgenes);
  }

}