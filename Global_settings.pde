// Global settings that apply equally to all cells in the colony

class Global_settings {
  boolean debug;
  boolean centerSpawn;
  boolean screendumpON;
  boolean fillDisable;
  boolean strokeDisable;
  boolean greyscaleON;
  boolean nucleus;
  boolean stepped;
  boolean wraparound;

  int strainSize;
  int numStrains;
  int rows;
  int cols;
  int stepSize;
  int stepSizeN;
  int stripeSize;
  float stripeRatio;

  int bkgColGrey;
  float bkg_H;
  float bkg_S;
  float bkg_B;
  color bkgColor;
  color nucleusColorU;
  color nucleusColorF;

  int fill_HTwist;
  int fill_STwist;
  int fill_BTwist;
  int fill_ATwist;

  int stroke_HTwist;
  int stroke_STwist;
  int stroke_BTwist;
  int stroke_ATwist;
  
  float gene_18;
  float gene_19;

  Global_settings() {
    debug = false;
    centerSpawn = true;  // true=initial spawn is width/2, height/2 false=random
    screendumpON = true;
    wraparound = false;
    
    //gene_18 = random(width);
    //gene_19 = random(height);
    gene_18 = width/2;
    gene_19 = height/2;

   
    //numStrains = int(random(1, 3)); // Number of strains (a group of cells sharing the same DNA)
    numStrains = 1;
    //strainSize = int(random(1,4)); // Number of cells in a strain
    strainSize = 1;
    //rows = int(random(1, 9));
    rows = int(random (4,24));
    //rows = int(random(9,21));
	  //rows = 19;
    cols = rows;
    //cols = 12;

    stepped = false;
    stepSize = 30;
    stepSizeN = 50;
    
    stripeSize = 20000; // last 10
    stripeRatio = 0.85;

    greyscaleON = false;
    bkg_H = random(360);
    //bkg_H = 240;
    //bkg_S = random(128,164);
    bkg_S = 200; // last 105, 55, 255
    //bkg_B = random(180,220);
    bkg_B = 100; // last 160, 50, 128
    bkgColor = color(bkg_H, bkg_S, bkg_B);
    //bkgColor = 0; // Black
    //bkgColor = 360; // White
    //bkgColGrey = int(random(128, 360));
    //bkgColGrey = 0; // Black
    bkgColGrey = 360; // White

    nucleus = false;
    nucleusColorU = color(0, 0, 255); // White
    //nucleusColorU = color(0, 255, 255); // Red
    nucleusColorF = color(0, 255, 0); // Black

    fillDisable = false;
    //fill_HTwist = int(random(12,48)); // (0-360)
    fill_HTwist = 0;
    fill_STwist = 0; // (0-255)
    fill_BTwist = 0; // (0-255) last: 100
    fill_ATwist = 0; // (0-255)

    strokeDisable = true;
    stroke_HTwist = 0; // (0-360)
    stroke_STwist = 0; // (0-255)
    stroke_BTwist = 0; // (0-255)
    stroke_ATwist = 0; // (0-255)
    
    logSettings();
  }
  
  void logSettings() {
    output.println("centerSpawn = " + centerSpawn);
    output.println("screendumpON = " + screendumpON);
    output.println("fillDisable = " + fillDisable);
    output.println("strokeDisable = " + strokeDisable);
    output.println("greyscaleON = " + greyscaleON);
    output.println("nucleus = " + nucleus);
    output.println("stepped = " + stepped);
    output.println("wraparound = " + wraparound);
    output.println("strainSize = " + strainSize);
    output.println("numStrains = " + numStrains);
    output.println("rows = " + rows);
    output.println("cols = " + cols);
    output.println("stepSize = " + stepSize);
    output.println("stepSizeN = " + stepSizeN);
    output.println("stripeSize = " + stripeSize);
    output.println("stripeRatio = " + stripeRatio);
    output.println("bkgColGrey = " + bkgColGrey);
    output.println("bkg_H = " + bkg_H);
    output.println("bkg_S = " + bkg_S);
    output.println("bkg_B = " + bkg_B);
    output.println("bkgColor = " + bkgColor);
    output.println("nucleusColorU = " + nucleusColorU);
    output.println("nucleusColorF = " + nucleusColorF);
    output.println("fill_HTwist = " + fill_HTwist);
    output.println("fill_STwist = " + fill_STwist);
    output.println("fill_BTwist = " + fill_BTwist);
    output.println("fill_ATwist = " + fill_ATwist);
    output.println("stroke_HTwist = " + stroke_HTwist);
    output.println("stroke_STwist = " + stroke_STwist);
    output.println("stroke_BTwist = " + stroke_BTwist);
    output.println("stroke_ATwist = " + stroke_ATwist);
  }
}