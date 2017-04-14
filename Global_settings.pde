// Global settings that apply equally to all cells in the colony

/* The Global_settings object is simply a collection of global variables (available to the rest of the code)
*  It was originally required as the object associated with the dat.gui menu in the p5js version of cellendipity sandbox
*  Although this is no longer a requirement, it has felt convinient to organize all settings in one class
*  New values can be obtained by renewing the object & including random functions for relevant settings
*  The values used are written to the "..._settings.txt" file for posterity
*
*  Examples of variables & usage:
*  bkg_H  may be used in DNA to allow starting hue to match background hue
*  rows may be used in Genepool & DNA to calculate size as a function of #rows
*  debug is a global flag to indicate that debug mode is set
*/

class Global_settings {

  boolean debug;
  
  boolean nucleus;
  boolean stepped;

  float borderWidth;
  float borderHeight;
  float widthUsed;
  float heightUsed;

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
    
    debug = true;
    
    borderWidth = width * 0.2;   // Width of the vertical borders
    borderHeight = height * 0.2; // Height of the horisontal borders
    
    widthUsed = width - (2*borderWidth);    //Calculate width of usable area (inside border)
    heightUsed = height - (2*borderHeight); //Calculate height of usable area (inside border)
       
    //patternSelector = int(random(4)); // 0 = random, 1 = centered, 2 = cartesian, 3 = cartesian_alt, 4 = phyllotaxic
    patternSelector = 3; // 0 = random, 1 = centered, 2 = cartesian, 3 = cartesian_alt, 4 = phyllotaxic
   
    //numStrains = int(random(2, 4)); // Number of strains (a group of cells sharing the same DNA)
    numStrains = 3;
    //strainSize = int(random(2,5)); // Number of cells in a strain
    strainSize = 1;
    populationMaxSize = 500;  // Not really used when 'breeding' is disabled
    
    seeds = 10;
    
    //rows = int(random(1, 9));
    //rows = int(random (4,12));
    //rows = int(random(4,15));
	  rows = 14;
    cols = rows;
    //cols = 12;
    
    //orx = int(widthUsed * random (0.3, 0.7));  // Random but kept roughly within the pattern
    //ory = int(heightUsed * random (0.3, 0.7)); // Random but kept roughly within the pattern
    //orx = int(widthUsed * random (0.4, 0.6));  // Random but kept roughly within the pattern
    //ory = int(heightUsed * random (0.4, 0.6)); // Random but kept roughly within the pattern
    //orx = int(widthUsed * random (1));  // Fully random
    //ory = int(heightUsed * random (1)); // Fully random
    orx = int(widthUsed * 0.5)+1;  // Centered
    ory = int(heightUsed * 0.5)+1; // Centered

    stepped = false;
    stepSize = 15;
    stepSizeN = int(random (55, 82));
    
    //bkg_H = random(360);
    bkg_H = 230;
    //bkg_S = random(128,164);
    bkg_S = 100; // last 105, 55, 255, 225
    //bkg_B = random(120,180);
    bkg_B = 200; // last 160, 50, 128, 255
    bkgColor = color(bkg_H, bkg_S, bkg_B);
    //bkgColor = 0; // Black
    //bkgColor = 360; // White

    nucleus = false;
    nucleusColorU = color(0, 0, 255); // White
    //nucleusColorU = color(0, 255, 255); // Red
    nucleusColorF = color(0, 255, 0); // Black
    
    logSettings();
  }
  
  void logSettings() {
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