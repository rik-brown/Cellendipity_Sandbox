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

  int bkgColGrey;
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
    fillDisable = false;
    strokeDisable = false;
    greyscaleON = false;
    nucleus = false;
    wraparound = false;
    
    //gene_18 = random(width);
    //gene_19 = random(height);
    gene_18 = width/2;
    gene_19 = height/2;

   
    //numStrains = int(random(1, 4)); // Number of strains (a group of cells sharing the same DNA)
    numStrains = 2;
    strainSize = 1; // Number of cells in a strain
    //rows = int(random(1, 9));
    //rows = int(random (3,9));
    rows = int(random (3,6));
    cols = rows;
    //cols = 3;

    stepped = false;
    stepSize = 55;
    stepSizeN = 50;

    bkgColor = color(random(360), 10, 255); // Background colour = white
    bkgColGrey = int(random(128, 360));
       
    nucleusColorU = color(0, 255, 255); // Red
    nucleusColorF = color(0, 255, 0); // Black

    fill_HTwist = 0; // (0-360)
    fill_STwist = 100; // (0-255)
    fill_BTwist = 0; // (0-255)
    fill_ATwist = 0; // (0-255)

    stroke_HTwist = 0; // (0-360)
    stroke_STwist = 0; // (0-255)
    stroke_BTwist = 10; // (0-255)
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
    output.println("stepSize = " + stepSize);
    output.println("stepSizeN = " + stepSizeN);
    output.println("bkgColGrey = " + bkgColGrey);
    output.println("bkgColor = " + bkgColor);
    //output.println("nucleusColorU = " + nucleusColorU);
    //output.println("nucleusColorF = " + nucleusColorF);
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