/*
* Cellendipity_Sandbox
*
* Is a generic 'multi-cellular playset'
*  - consisting of well-organized, easy-to-understand functional-modules
*  - for easy prototyping & documentation of exploratory art-experiments
*  RB 09.apr.2017
*
* Development Goals:
*
*  d) Improve functionality for saving frames for gifs (configurable frame interval and intelligent file numbering)

*  g) Introduce a new spawn-pattern of concentric rings

*  i) Cell style could be a variant of it's DNA, based on a single DNA (e.g. striped/stepped/nucleus) EXPLORE

*  j) Nucleus should be moved to the DNA
*    1) Nucleus colour might need to be hard-coded, to avoid yet more DNA. or?
*    2) Same goes for stripe colour

*  k) Populate the library with some 'favourite' cell genotypes from older sketches
*  l) Try to recreate the twitter/tumblrbot classic styles?
*  m) DNA modifiers need to take spwan-pattern into account (e.g. centered)
*
*  n) Cell 'gets' it's DNA according to strain ID (which is passed to the cell in a function)
*  o) SPAWNING new cells - does it still work?
*    1) Add recombined DNA to the genepool?
*  
*  p) Use an image in /data as a seed for colours at spawn positions
*    1) This reference includes most of what I need: https://processing.org/tutorials/pixels/
*    2) Alt.i) When colony spawns a cell, it pulls the colours from image sample (image = colour palette)
*    3) Alt.ii) When colony spawns a cell, it does so only in areas of the image having colour X (image =spawn-pattern)
*    4) Add a new class to handle this?
*    5) The output of one iteration could provide the input for the next?
*
*/

Colony colony;        // A Colony object called 'colony'
Global_settings gs;   // A Global_settings object called 'gs'
Genepool gpl;          // A Genepool object called 'gpl'
PImage img;

String batchName = "batch-157.0";
int maxCycles = 15;
int runCycle = 1;


int maxFrames = 5000;
//int maxFrames = int(random(1300,1600));
int frameCounter;

String iterationNum;
String applicationName = "sandbox";
String pathName;
String screendumpPath; // Name & location of saved output (final image)
String framedumpPath;  // Name & location of saved output (individual frames)
PrintWriter output;    // Object for writing to the settings logfile

void setup() {
  //img = loadImage("output.png");
  //size(200, 200);
  //size(500, 500);
  //size(1000, 1000);
  //size(1500, 1500);
  //size(2000, 2000);
  size(4000, 4000);
  //size(6000, 6000);
  //size(8000, 8000);
  
  colorMode(HSB, 360, 255, 255, 255);
  //blendMode(DIFFERENCE);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  smooth();
  getReady();
  if (gs.debug) {frameRate(5);}
}

void draw() {
  if (colony.population.size() == 0 || frameCounter < 0 ) {manageColony();}
  if (gs.debug) {background(gs.bkgColor);} // Refresh the background on every frame to simplify debugging
  //background(gs.bkgColor);
  colony.run();
  //frameSave(); // Saves each frame as a .png (for GIFs etc.)
  frameCounter --;
}

// What happens when the colony goes extinct
void manageColony() {
    saveFrame(screendumpPath); // Save an image 
    saveFrame("/data/output.png"); // Save a duplicate image to the /data folder to be used in next iteration
    endSettingsFile(); // Complete the settings logfile & close
    //exit();
    //colony.population.clear(); //Kill all cells. Still necessary?
    if (runCycle == maxCycles) {exit();}
    else {
    // get ready for a new cycle
    runCycle ++;
    getReady();
    }
    //screendumpPath = pathName + "/png/" + applicationName + "." + iterationNum + ".png";
    //output = createWriter(pathName + applicationName + "." + iterationNum +"_settings.txt");
}

void getReady() {
  img = loadImage("output.png");
  frameCounter = maxFrames;
  iterationNum = nf(runCycle, 3);
  pathName = "../../output/" + applicationName + "/" + batchName + "/" + String.valueOf(width) + "x" + String.valueOf(height) + "/"; //local
  //pathName = "D:/output/" + applicationName + "/" + batchName + "/"+ String.valueOf(width) + "x" + String.valueOf(height) + "/"; //USB
  
  screendumpPath = pathName + "/png/" + batchName + "-" + iterationNum + ".png";
  //screendumpPath = "../output.png"; // For use when running from local bot
  framedumpPath = pathName + "/frames/";
  
  output = createWriter(pathName + "/settings/" + batchName + "-" + iterationNum +".settings.log"); //Open a new settings logfile
  
  startSettingsFile();
  gs = new Global_settings();
  gpl = new Genepool();
  colony = new Colony();
  background(gs.bkgColor);
  image(img,0,0);
}

void startSettingsFile() {
String timeStamp = (year() + "" + month() + "" + day() + "-" + hour() + "" + minute() + "" + second());
output.println("Iteration: " + iterationNum + " " + timeStamp);
output.println(screendumpPath);
}

void endSettingsFile() {
  output.println("Total frames: " + (maxFrames - frameCounter)); // Update the log with the number of frames used
  output.flush(); 
  output.close(); //Flush and close the settings file
}

void frameSave() {
  String frameName = nf(frameCount, 5);
  saveFrame(framedumpPath + frameName + ".jpg");
}