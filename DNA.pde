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
      numGenes = 29;
      genes = new float[numGenes];  // DNA contains an array called 'genes' with [32] float values

      // DNA gene mapping (29 genes)
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
      
      // 20 = fill_Hend
      // 21 = fill_Send
      // 22 = fill_Bend
      // 23 = fill_Aend
      
      // 24 = stroke_Hend
      // 25 = stroke_Send
      // 26 = stroke_Bend
      // 27 = stroke_Aend
      
      // 28 = Strain id

      // RANDOMIZED VALUES
            //genes[0] = random(360); // 0 = fill Hue (0-360)
            //genes[0] = 230; // 0 = fill Hue (0=RED)
            genes[0] = gs.bkg_H; // 0 = fill Hue 
            //genes[0] = (gs.bkg_H + random(170, 210)) % 360; // 0 = fill Hue (0-360)
            //genes[0] = (gs.bkg_H + 240) % 360; // 0 = fill Hue (0-360)
            //genes[0] = (gs.bkg_H + 0) % 360; // 0 = fill Hue (0-360)
            //genes[1] = random(130,180); // 1 = fill Saturation (0-255)
            genes[1] = 0; // 1 = fill Saturation (0-255) LAST:50
			      //genes[1] = gs.bkg_S; // 1 = fill Saturation (0-255)
            //genes[2] = gs.bkg_B;    // 2 = fill Brightness (0-255)
            genes[2] = 0;    // 2 = fill Brightness (0-255)
            genes[3] = 255;   // 3 = fill Alpha (0-255)

            //genes[20] = (gs.bkg_H + 10) % 360;  // 20 = fill_Hend
            //genes[20] = gs.bkg_H * random (0.85, 0.97);  // 20 = fill_Hend
            //genes[20] = gs.bkg_H;
            //genes[20] = genes[0];
            genes[20] = 300;
            
            //genes[21] = gs.bkg_S; // fill_Send
            //genes[21] = gs.bkg_S * random(0.5, 0.9);// fill_Send
            genes[21] = 0;// fill_Send LAST: 128, 220
            
            //genes[22] = gs.bkg_B * 0.5;// fillBstart
            //genes[22] = gs.bkg_B * random(0.9, 1.1);// fillBend
            genes[22] = 255;// fill_Bend last: 180

            genes[23] = 255;// fill_Aend

            //genes[4] = random(360);    // 4 = stroke Hue (0-360)
            //genes[4] = gs.bkg_H;  // stroke_Hstart
            genes[4] = 0;  // stroke_Hstart
            genes[5] = 0;    // 5 = stroke Saturation (0-255)
            //genes[5] = gs.bkg_S;  // stroke_Sstart
            genes[6] = 0;    // 6 = stroke Brightness (0-255) 0 = BLACK
            //genes[6] = 0;  // stroke_Bstart
            //genes[7] = random(5.5, 16.3);    // 7 = stroke Alpha (0-255)
            genes[7] = 0;  // strokeAstart
            
            //genes[24] = gs.bkg_H;  // stroke_Hend
            genes[24] = 0;  // stroke_Hend            
            genes[25] = 0;  // stroke_Send
            genes[26] = 0;  // stroke_Bend
            genes[27] = 0;  // strokeAend
      
            //genes[8] = width/((gs.rows)*random(2, 4));   // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
            genes[8] = width * 0.001 * 100;
            //genes[8] = width/((gs.rows)*2);
            //genes[9] = random(15, 30);   // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
            genes[9] = 15;
            //genes[10] = width * random(0.1, 0.3);  // 10 = lifespan (200-1000)
            genes[10] = width * 0.05; // last * 0.09, 0.2, 0.5
            //genes[10] = 20;
            //genes[11] = random (100, 110); // 11 = flatness (50-200 %)
            genes[11] = 100;
            //genes[12] = random(0, 30);  // 12 = spiral screw (-75 - +75 %)
            genes[12] = 0;
            
            //genes[13] = random(65,85);  // 13 = fertility (70-90%)
			      genes[13] = 65;
            //genes[14] = random(2,3);   // 14 = spawnCount (1-5)
            genes[14] = 2;
            
            genes[15] = random(2, 4);      // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
            //genes[15] = 2.8731356;
            genes[16] = random(1, 6);   // 16 = step (Noise) (1 - 6 * 0.001?)  (cellendipity/one uses 0.001-0.006)
            //genes[16] = 4.848875;
            //genes[17] = random(60,100);  // 17 = noisePercent (0-100%)
            genes[17] = 0; // 17 = noisePercent (0-100%)
            
            genes[18] = random(1000); // 18 = xOff (rnd 1000)
            genes[19] = random(1000); // 19 = yOff (rnd 1000)
            
            //genes[18] = 648.2952; // 18 = xOff (rnd 1000)
            //genes[19] = 728.6432; // 19 = yOff (rnd 1000)
            
            genes[28] = 0;  // strain ID

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