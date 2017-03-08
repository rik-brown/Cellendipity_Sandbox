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
      numGenes = 36;
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
      // 18 = xOff (rnd 1000)
      // 19 = yOff (rnd 1000)
      
      // 20 = fillHstart
      // 21 = fillHend
      // 22 = fillSstart
      // 23 = fillSend
      // 24 = fillBstart
      // 25 = fillBend
      // 26 = fillAstart
      // 27 = fillAend
      
      // 28 = stroke_Hstart
      // 29 = stroke_Hend
      // 30 = stroke_Sstart
      // 31 = stroke_Send
      // 32 = stroke_Bstart
      // 33 = stroke_Bend
      // 34 = stroke_Astart
      // 35 = stroke_Aend


      // RANDOMIZED VALUES
            genes[0] = random(360);    // 0 = fill Hue (0-360)
            //genes[0] = 0;    // 0 = fill Hue (0=RED)
            //genes[0] = gs.bkg_H + random(170, 210);    // 0 = fill Hue (0-360)
            //genes[0] = gs.bkg_H + random(5, 15);    // 0 = fill Hue (0-360)
            //if (genes[0] > 360) {genes[0] -= 360;}
            //genes[1] = random(130,180);  // 1 = fill Saturation (0-255)
			      genes[1] = 255;
            genes[2] = 255;    // 2 = fill Brightness (0-255)
            genes[3] = 255;   // 3 = fill Alpha (0-255)
      
            genes[4] = random(360);    // 4 = stroke Hue (0-360)
            genes[5] = 255;    // 5 = stroke Saturation (0-255)
            genes[6] = 255;    // 6 = stroke Brightness (0-255) 0 = BLACK
            //genes[7] = random(5.5, 16.3);    // 7 = stroke Alpha (0-255)
            genes[7] = 10;
      
            //genes[8] = width/((gs.rows)*random(2, 4));   // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
            genes[8] = 20;
            //genes[8] = width/((gs.rows)*2);
            //genes[9] = random(15, 30);   // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
            genes[9] = 10;
            //genes[10] = width * random(0.1, 0.3);  // 10 = lifespan (200-1000)
            genes[10] = width * 0.3; // last * 0.09, 0.2, 0.5
            //genes[10] = 20;
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
            genes[17] = 0;
            
            genes[18] = random(1000); // 18 = xOff (rnd 1000)
            genes[19] = random(1000); // 19 = yOff (rnd 1000)
            
            //genes[18] = 500; // 18 = xOff (rnd 1000)
            //genes[19] = 500; // 19 = yOff (rnd 1000)
            
            genes[20] = gs.bkg_H;  // fillHstart
            genes[21] = (gs.bkg_H + 60) % 360;  // fillHstart
            //genes[20] = random(360);  // fillHstart
            //genes[20] = 360; //BLUE
            //genes[21] = gs.bkg_H * random (0.85, 0.97);  // fillHend
            //genes[21] = gs.bkg_H;
            //genes[21] = genes[20];
            //genes[21] = 320;
            
            //genes[22] = gs.bkg_S;// fillSstart
            genes[22] = 0;
            //genes[23] = gs.bkg_S;// fillSend
            genes[23] = 0;// fillSend LAST: 128
            //genes[23] = gs.bkg_S * random(0.5, 0.9);// fillSend
            
            genes[24] = 255;// fillBstart
            //genes[24] = gs.bkg_B * 0.5;// fillBstart
            genes[25] = 160;// fillBend last: 180
            //genes[25] = gs.bkg_B * random(0.9, 1.1);// fillBend
            
            genes[26] = 0;// fillAstart
            genes[27] = 255;// fillAend

            //genes[28] = gs.bkg_H;  // stroke_Hstart
            genes[28] = 0;  // stroke_Hstart
            //genes[29] = gs.bkg_H;  // stroke_Hend
            genes[29] = genes[28];  // stroke_Hend            
            genes[30] = gs.bkg_S;  // stroke_Sstart
            genes[31] = gs.bkg_S;  // stroke_Send
            genes[32] = 0;  // stroke_Bstart
            genes[33] = 0;  // stroke_Bend
            genes[34] = 0;  // strokeAstart
            genes[35] = 0;  // strokeAend

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