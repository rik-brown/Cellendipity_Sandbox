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
  boolean savePNG;
  boolean makePDF;
  boolean makeGIF;
  boolean makeMPEG;
  
  boolean nucleus;
  boolean stepped;

  float borderWidth;
  float borderHeight;

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
  
  float bkg_H;
  float bkg_S;
  float bkg_B;
  color bkgColor;
  
  color nucleusColorU;
  color nucleusColorF;
  
  float maxRadius;
  float maxLifespan;
  

  Global_settings() {
    
    debug = false;
    savePNG = true;
    makePDF = false;
    makeGIF = false;
    makeMPEG = false;
    
    borderWidth = 0.5;
    borderHeight = 0.5;
           
    //patternSelector = int(random(1,5)); // 0 = centered, 1 = random,  2 = cartesian, 3 = cartesian_alt, 4 = phyllotaxic
    patternSelector = 0; // 0 = centered, 1 = random, 2 = cartesian, 3 = cartesian_alt, 4 = phyllotaxic
   
    //numStrains = int(random(1, 4)); // Number of strains (a group of cells sharing the same DNA)
    numStrains = 1;
    //strainSize = int(random(2,5)); // Number of cells in a strain
    strainSize = 1;
    populationMaxSize = 200;  // Not really used when 'breeding' is disabled
    
    seeds = 25;
    
    //rows = int(random(1, 9));
    //rows = int(random (4,12));
    //rows = int(random(4,118));
	  rows = 12;
    cols = 12;
    //cols = 12;
    
    //orx = int(width * random (0.3, 0.7));  // Random but kept roughly within the pattern
    //ory = int(height * random (0.3, 0.7)); // Random but kept roughly within the pattern
    //orx = int(width * random (0.4, 0.6));  // Random but kept roughly within the pattern
    //ory = int(height * random (0.4, 0.6)); // Random but kept roughly within the pattern
    //orx = int(width * random (1));  // Fully random
    //ory = int(height * random (1)); // Fully random
    orx = int(width * 0.5);  // Centered
    ory = int(height * 0.5); // Centered
    //orx = 0; // @origin
    //ory = 0; // @origin
    

    // I kept this as a boolean because if size was set to zero to disable it looked steppy
    stepped = false;
    stepSize = 20;
    
    
    //bkg_H = random(360);
    bkg_H = 240;
    //bkg_S = random(128,164);
    bkg_S = 0; // last 105, 55, 255, 225
    //bkg_B = random(120,180);
    bkg_B = 255; // last 160, 50, 128, 255
    bkgColor = color(bkg_H, bkg_S, bkg_B);
    //bkgColor = 0; // Black
    //bkgColor = 360; // White

    // I kept this as a boolean to avoid unnecessary work when nucleus is not required
    nucleus = false;
    stepSizeN = int(random (55, 82));
    nucleusColorU = color(0, 0, 255, 255); // White
    //nucleusColorU = color(0, 255, 255); // Red
    nucleusColorF = color(0, 255, 0, 255); // Black
    
    maxRadius = width * 0.5;
    maxLifespan = width * 0.5;
    
    logSettings();
  }
  
  void logSettings() {
    output.println("borderWidth = " + borderWidth);
    output.println("borderHeight = " + borderHeight);
    output.println("Pattern = " + patternSelector);
    output.println("numStrains = " + numStrains);
    output.println("strainSize = " + strainSize);
    output.println("maxSize = " + populationMaxSize);
    output.println("seeds = " + seeds);
    output.println("rows = " + rows);
    output.println("cols = " + cols);
    output.println("or.x = " + orx);
    output.println("or.y = " + ory);
    output.println("stepped = " + stepped);
    output.println("stepSize = " + stepSize);
    output.println("nucleus = " + nucleus);
    output.println("stepSizeN = " + stepSizeN);
    output.println("bkg_H = " + bkg_H);
    output.println("bkg_S = " + bkg_S);
    output.println("bkg_B = " + bkg_B);
    output.println("makePDF = " + makePDF);
    output.println("makeGIF = " + makeGIF);
    output.println("maxRadius = " + maxRadius);
    output.println("maxLifespan = " + maxLifespan);
  }
}