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
      numGenes = 34;
      genes = new float[numGenes];  // DNA contains an array called 'genes' with [32] float values

// ID, fill_H_start, fill_H_end, fill_S_start, fill_S_end, fill_B_start, fill_B_end, fill_A_start, fill_A_end, stroke_H_start, stroke_H_end, stroke_S_start, stroke_S_end, stroke_B_start, stroke_B_end, stroke_A_start, stroke_A_end, radius_start, radius_end, flatness_start, flatness_end, twist_Start, twist_End, noisePercent_Start, noisePercent_End, noise_vMax, noise_Step, noise_xOff, noise_yOff, fertility, spawnLimit, lifespan, StripeSize, StripeRatio

      // DNA gene mapping (29 genes)
      // 0=ID

      // 1=fill_H_start
      // 2=fill_H_end
      // 3=fill_S_start
      // 4=fill_S_end
      // 5=fill_B_start
      // 6=fill_B_end
      // 7=fill_A_start
      // 8=fill_A_end
      
      // 9=stroke_H_start
      // 10=stroke_H_end
      // 11=stroke_S_start
      // 12=stroke_S_end
      // 13=stroke_B_start
      // 14=stroke_B_end
      // 15=stroke_A_start
      // 16=stroke_A_end
      
      // 17=radius_start
      // 18=radius_end
      
      // 19=flatness_start
      // 20=flatness_end
      
      // 21=twist_Start
      // 22=twist_End
      
      // 23=noisePercent_Start
      // 24=noisePercent_End
      
      // 25=noise_vMax
      // 26=noise_Step
      // 27=noise_xOff
      // 28=noise_yOff
      
      // 29=fertility
      // 30=spawnLimit
      // 31=lifespan
      
      // 32=StripeSize
      // 33=StripeRatio
      
      genes[0] = 0;  // ID
      
      genes[1]= random(200, 240);   // 1=fill_H_start
      //genes[1]= 230;   // 1=fill_H_start
      //genes[1]= gs.bkg_H;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + random(170, 210)) % 360;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + 240) % 360;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + 0) % 360;   // 1=fill_H_start
      genes[2]= genes[1];   // 2=fill_H_end
      //genes[2]= (gs.bkg_H + 10) % 360;   // 2=fill_H_end
      //genes[2]= gs.bkg_H * random (0.85, 0.97);   // 2=fill_H_end
      //genes[2]= gs.bkg_H;   // 2=fill_H_end
      //genes[2]= 300;   // 2=fill_H_end

      genes[3]= random(130,180);   // 3=fill_S_start
      //genes[3]= 255;   // 3=fill_S_start
      //genes[3]= gs.bkg_S;   // 3=fill_S_start
      genes[4]= 128;   // 4=fill_S_end
      //genes[4]= gs.bkg_S;   // 4=fill_S_end
      //genes[4]= gs.bkg_S * random(0.5, 0.9);   // 4=fill_S_end
      
      //genes[5]= gs.bkg_B;   // 5=fill_B_start
      genes[5]= 64;   // 5=fill_B_start
      genes[6]= 200;   // 6=fill_B_end
      //genes[6]= gs.bkg_B * random(0.9, 1.1);   // 6=fill_B_end
      //genes[6]= gs.bkg_B * 0.5;   // 6=fill_B_end
      
      genes[7]= 255;   // 7=fill_A_start
      genes[8]= 255;   // 8=fill_A_end
      
      genes[9]= 0;   // 9=stroke_H_start
      //genes[9]= random(360);   // 9=stroke_H_start
      //genes[9]= gs.bkg_H;   // 9=stroke_H_start
      genes[10]= 0;   // 10=stroke_H_end
      //genes[10]= gs.bkg_H;   // 10=stroke_H_end
      
      genes[11]= 0;   // 11=stroke_S_start
      //genes[11]= gs.bkg_S;   // 11=stroke_S_start
      genes[12]= 0;   // 12=stroke_S_end
      
      genes[13]= 0;   // 13=stroke_B_start
      genes[14]= 64;   // 14=stroke_B_end
      
      genes[15]= 0;   // 15=stroke_A_start
      //genes[15]= random(5.5, 16.3);   // 15=stroke_A_start
      genes[16]= 0;   // 16=stroke_A_end
      
      //genes[17]= width * 0.001 * random(75, 200);   // 17=radius_start
      //genes[17]= width/((gs.rows)*random(2, 4));   // 17=radius_start CARTESIAN GRID
      genes[17]= width/((gs.rows)*2);   // 17=radius_start CARTESIAN GRID
      //genes[17]= width * 0.001 * random(25, 50);   // 17=radius_start
      
      genes[18]= 5;   // 18=radius_end
      //genes[18]= random(15, 30);   // 18=radius_end
      
      genes[19]= 200;   // 19=flatness_start
      //genes[19]= random (100, 120);   // 19=flatness_start
      genes[20]= 100;   // 20=flatness_end
      
      genes[21]= 90;   // 21=twist_start
      //genes[21]= random(0, 30);   // 21=twist_start
      genes[22]= 0;   // 22=twist_end

      genes[23]= 20;   // 23=noisePercent_start
      //genes[23]= random(60,100);   // 23=noisePercent_start
      genes[24]= 0;   // 24=noisePercent_End
      
      genes[25]= random(2, 4);   // 25=noise_vMax
      genes[26]= random(1, 6);   // 26=noise_tep
      genes[27]= random(1000);   // 27=noise_xOff
      genes[28]= random(1000);   // 28=noise_yOff
                  
      genes[29]= 65;   // 29=fertility
      //genes[29]= random(65,85);   // 29=fertility
      genes[30]= 1;   // 30=spawnLimit
      //genes[30]= random(2,3);   // 30=spawnLimit
      //genes[31]= width * 0.001 * random(200, 300);   // 31=lifespan
      genes[31]= width * 0.001 * 100;   // 31=lifespan
      //genes[31]= 20;   // 31=lifespan
      
      genes[32]= random(20,60);   // 32=StripeSize
      //genes[32]= 30;   // 32=StripeSize
      //if (random(1)>0.4) {genes[32] = random(20,50);} else {genes[32] = 10000;} // 32=StripeSize
      genes[33]= 0.5;   // 33=StripeRatio
      //genes[33] = random(0.4, 0.8);  // 33=StripeRatio

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