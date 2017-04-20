// Class to describe DNA
// Borrowed from 'Evolution EcoSystem'
// by Daniel Shiffman <http://www.shiffman.net> #codingrainbow

/* The DNA class creates a genotype DNA object containing an array of float values (or 'genes')
*  The genes are determined by predefined values & functions in the constructor
*  Each time the class is called, the values for the DNA created are appended to the "_settings.txt" file
*/

class DNA {

  float[] genes;  // 'genes' is an array of float values in the range (0-1)
  int numGenes;

  // Constructor (makes a random DNA)
  DNA() {
      numGenes = 34;
      genes = new float[numGenes];  // DNA contains an array called 'genes' with [34] float values

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
      // 17=radius_start (in units of 1/1000 of width, so if width = 1000, 1 = 1 pixel)
      // 18=radius_end (expressed as % of radius_start)
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
      // 31=lifespan (in units of 1/1000 of width, so if width = 1000, 100 = 100 frames)
      // 32=StripeSize
      // 33=StripeRatio
      
      genes[0] = 0;  // id
      
      //genes[1]= random(180, 260);   // 1=fill_H_start
      //genes[1]= random(360);   // 1=fill_H_start
      //genes[1]= 230;   // 1=fill_H_start
      genes[1]= gs.bkg_H;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + random(170, 210)) % 360;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + 240) % 360;   // 1=fill_H_start
      //genes[1]= (gs.bkg_H + 0) % 360;   // 1=fill_H_start
      //genes[2]= genes[1];   // 2=fill_H_end
      //genes[2]= genes[1] * random (0.80, 0.97);   // 2=fill_H_end
      //genes[2]= (gs.bkg_H + 10) % 360;   // 2=fill_H_end
      genes[2]= gs.bkg_H * random (0.75, 1.2);   // 2=fill_H_end
      //genes[2]= gs.bkg_H;   // 2=fill_H_end
      //genes[2]= 300;   // 2=fill_H_end

      //genes[3]= random(130,180);   // 3=fill_S_start
      genes[3]= 0;   // 3=fill_S_start
      //genes[3]= gs.bkg_S;   // 3=fill_S_start
      genes[4]= 0;   // 4=fill_S_end
      //genes[4]= gs.bkg_S;   // 4=fill_S_end
      //genes[4]= gs.bkg_S * random(0.5, 0.9);   // 4=fill_S_end
      
      //genes[5]= gs.bkg_B;   // 5=fill_B_start
      genes[5]= 128;   // 5=fill_B_start
      genes[6]= 255;   // 6=fill_B_end
      //genes[6]= gs.bkg_B * random(0.9, 1.1);   // 6=fill_B_end
      //genes[6]= gs.bkg_B * 0.5;   // 6=fill_B_end
      
      genes[7]= 15;   // 7=fill_A_start
      genes[8]= 35;   // 8=fill_A_end
      
      genes[9]= 0;   // 9=stroke_H_start
      //genes[9]= random(360);   // 9=stroke_H_start
      //genes[9]= gs.bkg_H;   // 9=stroke_H_start
      genes[10]= 0;   // 10=stroke_H_end
      //genes[10]= gs.bkg_H;   // 10=stroke_H_end
      
      genes[11]= 128;   // 11=stroke_S_start
      //genes[11]= gs.bkg_S;   // 11=stroke_S_start
      genes[12]= 255;   // 12=stroke_S_end
      
      genes[13]= 255;   // 13=stroke_B_start
      genes[14]= 255;   // 14=stroke_B_end
      
      genes[15]= 64;   // 15=stroke_A_start
      //genes[15]= random(5.5, 16.3);   // 15=stroke_A_start
      genes[16]= 255;   // 16=stroke_A_end
      
      //genes[17]= random(75, 200);   // 17=radius_start
      //genes[17]= 500/((gs.rows)*random(1, 2));   // 17=radius_start CARTESIAN GRID
      genes[17]= 500/gs.rows;   // 17=radius_start CARTESIAN GRID
      //genes[17]= random(25, 50);   // 17=radius_start
      
      genes[18]= 1;   // 18=radius_end
      //genes[18]= random(15, 30);   // 18=radius_end
      
      genes[19]= 100;   // 19=flatness_start
      //genes[19]= random (100, 120);   // 19=flatness_start
      genes[20]= 100;   // 20=flatness_end
      
      genes[21]= 0;   // 21=twist_start
      //genes[21]= random(0, 50);   // 21=twist_start
      genes[22]= 0;   // 22=twist_end
      //genes[22]= random(0, 50);   // 22=twist_end

      //genes[23]= 20;   // 23=noisePercent_start
      genes[23]= random(0,100);   // 23=noisePercent_start
      //genes[24]= 0;   // 24=noisePercent_End
      genes[24]= random(0,100);   // 24=noisePercent_end
      
      genes[25]= random(2, 4);   // 25=noise_vMax
      genes[26]= random(1, 6);   // 26=noise_tep
      genes[27]= random(1000);   // 27=noise_xOff
      genes[28]= random(1000);   // 28=noise_yOff
                  
      genes[29]= 65;   // 29=fertility
      //genes[29]= random(65,85);   // 29=fertility
      genes[30]= 2;   // 30=spawnLimit
      //genes[30]= random(1,3);   // 30=spawnLimit
      //genes[31]= random(100, 200);   // 31=lifespan
      //genes[31]= 100;   // 31=lifespan
      genes[31]= 150;   // 31=lifespan
      
      //genes[32]= random(20,60);   // 32=StripeSize
      genes[32]= 30000;   // 32=StripeSize
      //if (random(1)>0.4) {genes[32] = random(20,50);} else {genes[32] = 10000;} // 32=StripeSize
      genes[33]= 0.5;   // 33=StripeRatio
      //genes[33] = random(0.4, 0.8);  // 33=StripeRatio
   }

  DNA combine(DNA otherDNA_) { // Returns a new set of DNA consisting of randomly selected genes from both parents
    float[] newgenes = new float[genes.length];
    for (int i = 0; i < newgenes.length; i++) {
      if (random(1) < 0.5) {newgenes[i] = genes[i];}
      else {newgenes[i] = otherDNA_.genes[i];} // 50/50 chance of copying gene from either 'mother' or 'other'
    }
    return new DNA(newgenes);
  }

// This method accepts a float array called 'newgenes' and fills the 'genes' array with the values therein.
// It is used when the last line of the combine() method directly above returns a new DNA object to the Cell via the conception() method
  DNA(float[] newgenes) {
    genes = newgenes;
  }

}