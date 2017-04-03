// Global settings that apply equally to all cells in the colony

class Global_settings {

  boolean debug;
  boolean screendumpON;
  boolean fillDisable;
  boolean strokeDisable;
  boolean nucleus;
  boolean stepped;

  int patternSelector;
  int strainSize;
  int numStrains;
  int populationMaxSize;
  
  int rows;
  int cols;
  int seeds;
  int orx;
  int ory; 
  
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
  


  Global_settings() {
    
    debug = false;
    screendumpON = true;
    
    //patternSelector = int(random(4)); // 0 = random, 1 = centered, 2 = cartesian, 3 = phyllotaxic
    patternSelector = 3; // 0 = random, 1 = centered, 2 = cartesian, 3 = phyllotaxic
   
    numStrains = int(random(2, 4)); // Number of strains (a group of cells sharing the same DNA)
    //numStrains = 3;
    //strainSize = int(random(2,5)); // Number of cells in a strain
    strainSize = 1;
    populationMaxSize = 500;  // Not really used when 'breeding' is disabled
    
    seeds = 350;
    
    //rows = int(random(1, 9));
    //rows = int(random (4,12));
    rows = int(random(4,15));
	  //rows = 17;
    cols = rows;
    //cols = 12;
    
    //orx = int(width * random (0.3, 0.7));  // Random but kept roughly within the pattern
    //ory = int(height * random (0.3, 0.7)); // Random but kept roughly within the pattern
    //orx = int(width * random (0.4, 0.6));  // Random but kept roughly within the pattern
    //ory = int(height * random (0.4, 0.6)); // Random but kept roughly within the pattern
    orx = int(width * random (1));  // Fully random
    ory = int(height * random (1)); // Fully random
    //orx = int(width * 0.5);  // Centered
    //ory = int(height * 0.5); // Centered

    stepped = false;
    stepSize = 15;
    stepSizeN = int(random (55, 82));
    
    //bkg_H = random(360);
    bkg_H = 230;
    //bkg_S = random(128,164);
    bkg_S = 100; // last 105, 55, 255, 225
    //bkg_B = random(120,180);
    bkg_B = 240; // last 160, 50, 128, 255
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