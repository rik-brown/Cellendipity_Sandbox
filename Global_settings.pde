// Global settings that apply equally to all cells in the colony

class Global_settings {

  boolean debug;
  boolean screendumpON;
  boolean fillDisable;
  boolean strokeDisable;
  boolean nucleus;
  boolean stepped;

  int strainSize;
  int numStrains;
  int colonyMaxSize;
  
  int rows;
  int cols;
  int seeds;
  
  int stepSize;
  int stepSizeN;
  int stripeSize;
  float stripeRatio;

  float bkg_H;
  float bkg_S;
  float bkg_B;
  color bkgColor;
  color nucleusColorU;
  color nucleusColorF;
  
  float orx;
  float ory; 

  Global_settings() {
    
    debug = false;
    screendumpON = true;
   
    //numStrains = int(random(1, 4)); // Number of strains (a group of cells sharing the same DNA)
    numStrains = 2;
    //strainSize = int(random(1,4)); // Number of cells in a strain
    strainSize = 1;
    colonyMaxSize = 200;  // Not really used when 'breeding' is disabled
    
    seeds = 500;
    
    //rows = int(random(1, 9));
    //rows = int(random (4,12));
    //rows = int(random(9,21));
	  rows = 18;
    cols = rows;
    //cols = 12;
    
    //orx = width * random (0.3, 0.7);  // Random but kept roughly within the pattern
    //ory = height * random (0.3, 0.7); // Random but kept roughly within the pattern
    orx = width * random (1);  // Fully random
    ory = height * random (1); // Fully random
    //float orx = width * 0.5;  // Centered
    //float ory = height * 0.5; // Centered

    stepped = false;
    stepSize = 15;
    stepSizeN = int(random (55, 82));
    
    stripeSize = 20050; // last 10
    stripeRatio = 0.70;

    bkg_H = random(360);
    //bkg_H = 240;
    //bkg_S = random(128,164);
    bkg_S = 0; // last 105, 55, 255, 225
    //bkg_B = random(180,220);
    bkg_B = 200; // last 160, 50, 128, 255
    bkgColor = color(bkg_H, bkg_S, bkg_B);
    //bkgColor = 0; // Black
    //bkgColor = 360; // White

    nucleus = false;
    nucleusColorU = color(0, 0, 255); // White
    //nucleusColorU = color(0, 255, 255); // Red
    nucleusColorF = color(0, 255, 0); // Black

    fillDisable = false;
    strokeDisable = false;
    
    logSettings();
  }
  
  void logSettings() {
    output.println("screendumpON = " + screendumpON);
    output.println("fillDisable = " + fillDisable);
    output.println("strokeDisable = " + strokeDisable);
    output.println("nucleus = " + nucleus);
    output.println("stepped = " + stepped);
    output.println("strainSize = " + strainSize);
    output.println("numStrains = " + numStrains);
    output.println("rows = " + rows);
    output.println("cols = " + cols);
    output.println("seeds = " + seeds);
    output.println("stepSize = " + stepSize);
    output.println("stepSizeN = " + stepSizeN);
    output.println("stripeSize = " + stripeSize);
    output.println("stripeRatio = " + stripeRatio);
    output.println("bkg_H = " + bkg_H);
    output.println("bkg_S = " + bkg_S);
    output.println("bkg_B = " + bkg_B);
    output.println("bkgColor = " + bkgColor);
    output.println("nucleusColorU = " + nucleusColorU);
    output.println("nucleusColorF = " + nucleusColorF);
    output.println("orx = " + orx);
    output.println("ory = " + ory);
  }
}