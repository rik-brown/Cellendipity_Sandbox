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
      numGenes = 32;
      genes = new float[numGenes];  // DNA contains an array called 'genes' with [32] float values

      // DNA gene mapping (32 genes)
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
      // 22 = xOff (rnd 1000)
      // 23 = yOff (rnd 1000)
      // 24 = fillHstart
      // 25 = fillHend
      // 26 = fillSstart
      // 27 = fillSend
      // 28 = fillBstart
      // 29 = fillBend
      // 30 = fillAstart
      // 31 = fillAend


      // RANDOMIZED VALUES
            //genes[0] = random(360);    // 0 = fill Hue (0-360)
            genes[0] = 0;    // 0 = fill Hue (0=RED)
            //genes[0] = gs.bkg_H + random(170, 210);    // 0 = fill Hue (0-360)
            //genes[0] = gs.bkg_H + random(5, 15);    // 0 = fill Hue (0-360)
            //if (genes[0] > 360) {genes[0] -= 360;}
            //genes[1] = random(130,180);  // 1 = fill Saturation (0-255)
			      genes[1] = 0;
            genes[2] = 255;    // 2 = fill Brightness (0-255)
            genes[3] = 255;   // 3 = fill Alpha (0-255)
      
            genes[4] = random(360);    // 4 = stroke Hue (0-360)
            genes[5] = 100;    // 5 = stroke Saturation (0-255)
            genes[6] = 255;    // 6 = stroke Brightness (0-255) 0 = BLACK
            //genes[7] = random(5.5, 16.3);    // 7 = stroke Alpha (0-255)
            genes[7] = 0;
      
            //genes[8] = width/((gs.rows)*random(2, 4));   // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
            genes[8] = width/((gs.rows)*2.0);
            //genes[9] = random(15, 30);   // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
            genes[9] = 10;
            //genes[10] = width * random(0.1, 0.3);  // 10 = lifespan (200-1000)
            //genes[10] = width * 0.5; // last * 0.09, 0.2, 0.5
            genes[10] = 200;
            //genes[11] = random (100, 110); // 11 = flatness (50-200 %)
            genes[11] = 100;
            //genes[12] = random(0, 30);  // 12 = spiral screw (-75 - +75 %)
            genes[12] = 0;
            
            //genes[13] = random(65,85);  // 13 = fertility (70-90%)
			      genes[13] = 65;
            //genes[14] = random(2,3);   // 14 = spawnCount (1-5)
            genes[14] = 1;
            
            genes[15] = random(2, 4);      // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
            genes[16] = random(1, 6);   // 16 = step (Noise) (1 - 6 * 0.001?)  (cellendipity/one uses 0.001-0.006)
            //genes[17] = random(60,100);  // 17 = noisePercent (0-100%)
            genes[17] = 30;
            
            genes[18] = (width*0.5);
            genes[19] = (height*0.5);
            genes[22] = random(1000);
            genes[23] = random(1000);
            
            genes[24] = gs.bkg_H;  // fillHstart
            //genes[24] = 0; //RED
            //genes[25] = gs.bkg_H * random (0.85, 0.97);  // fillHend
            genes[25] = gs.bkg_H;
            
            //genes[26] = gs.bkg_S;// fillSstart
            genes[26] = 192;
            //genes[27] = gs.bkg_S;// fillSend
            genes[27] = 0;// fillSend LAST: 128
            //genes[27] = gs.bkg_S * random(0.5, 0.9);// fillSend
            
            genes[28] = 128;// fillBstart
            //genes[28] = gs.bkg_B;// fillBstart
            genes[29] = 255;// fillBend last: 180
            //genes[29] = gs.bkg_B * random(0.9, 1.1);// fillBend
            
            genes[30] = 255;// fillAstart
            genes[31] = 255;// fillAend
                       
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