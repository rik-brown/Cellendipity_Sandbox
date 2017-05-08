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
*  d) Improve functionality for saving frames for gifs/mp4 videos:
    1) Configurable frame interval

*  g) Introduce a new spawn-pattern of concentric rings
*    1) Also variable spacing between rows/columns or rings (binomial, sine etc.)

*  i) Cell STYLE could be a variant of it's DNA, based on a single gene  EXPLORE
*    Examples could be:
*    1) Striped or not  (today handled by having stripe size > lifespan) (which incidentally is a neat way of calculating it)
*    2) Stepped or not (maybe stepsize could be managed in a similar way, so "always stepped" but "step interval is double the lifetime")
*    3) Show/don't show nucles (again, maybe it's just a question of interval size?)

*  j) Nucleus should be moved to the DNA
*    1) Nucleus colour might need to be hard-coded, to avoid yet more DNA. or?
*    2) Same goes for stripe colour

*  k) Populate the library with some 'favourite' cell genotypes from older sketches
*  l) Try to recreate the twitter/tumblrbot classic styles?
*
*  m) DNA modifiers need to take spawn-pattern into account (e.g. centered). What are the implications of this?
*
*  n) Cell 'gets' it's DNA according to strain ID (which is passed to the cell in a function)
*
*  o) SPAWNING new cells - does it still work?
*    1) Add recombined DNA to the genepool?
*  
*  p) Use an image file in /data as a seed for colours (or other parameters) at spawn positions
*    1) This reference includes most of what I need: https://processing.org/tutorials/pixels/
*    2) Alt.i) When colony spawns a cell, it pulls the colours from image sample (image = colour palette) <DONE AS DEMO 157.1>
*    3) Alt.ii) When colony spawns a cell, it does so only in areas of the image having colour X (image =spawn-pattern) <DONE AS DEMO 157.100 & 2>
*    4) Add a new class to handle this? Need to think about how to enable this feature.
*    5) The output of one iteration could provide the input for the next? <DONE AS DEMO 157.1>
*    6) Cell could sample for colour at it's current position for every draw cycle. <DONE AS 157.4>
*    6a) Could just use hue while allowing B & S to continue as normal <DONE>
*    7) Continue on original path until pixelColor hue is more than X degrees different. If diff>x, adopt new hue & direction
*
*  r) pixelHue at seed position determines initial velocity (direction) (hue is from 0/360, maps to -PI/PI <DONE>
*    .... which in turn influences later changes
*  s) pixelHue at current seed position determines heading (or heading offset from initial velocity) <DONE>
*
*  t) (If cell arrives at pixel of a given colour) {do this()} where this = die, spawn, stop moving, etc.
*
*  u) When (cell spawns or splits) {another cell dies}
*
*  v) REFACTORING: rather than size, remoteness, age etc should have "fillcolormodulator" "strokecolormodulator" "sizemodulator" "noisemodulator" "shapemodulator"
*      Each of these can in turn be linked to age, oDist, pixelColor etc.
*      e.g. fill_H = map(fillMod, 0, 1, fill_H_start, fill_H_end) % 360;
*      where fillmod could be map(range, 0, lifespan, 1, 0) or (age, 0, lifespan, 1, 0) etc. MORE ECONOMICAL
*
*  w) Mods in cell() are done to DNA before assignment to parameters, so values remain with the original range
*
*/

import processing.pdf.*;
import com.hamoid.*;

Colony colony;        // A Colony object called 'colony'
Global_settings gs;   // A Global_settings object called 'gs'
Genepool gpl;          // A Genepool object called 'gpl'
PImage img;
VideoExport videoExport;

String batchName = "batch-159.10";
int maxCycles = 120;
int runCycle = 1;
float cycleGen;


int maxFrames = 1000;
//int maxFrames = int(random(1300,1600));
int frameCounter;

String iterationNum;
String applicationName = "sandbox";
//String inputFile = "flower.jpg"; // First run will use /data/input.png, which will not be overwritten
String inputFile = "badger.jpg"; // First run will use /data/input.png, which will not be overwritten
//String inputFile = "sushi.jpg"; // First run will use /data/input.png, which will not be overwritten
//String inputFile = "bananas.jpg"; // First run will use /data/input.png, which will not be overwritten
//String inputFile = "input.png"; // First run will use /data/input.png, which will not be overwritten
String pathName;
String screendumpPath; // Name & location of saved output (final image)
String screendumpPathGIF1; // Name & location of saved output (final image) (reverse numbering for cyclic GIFs)
String screendumpPathGIF2; // Name & location of saved output (final image) (reverse numbering for cyclic GIFs)
String screendumpPathPDF; // Name & location of saved output (pdf file)
String framedumpPath; // Name & location of saved output (individual frames)
String videoPath; // Name & location of video output (.mp4 file)
PrintWriter output;    // Object for writing to the settings logfile

void setup() {
  colorMode(HSB, 360, 255, 255, 255);
  //blendMode(DIFFERENCE);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  smooth();
  getReady();
  //size(200, 200);
  //size(500, 500);
  //size(800, 800);
  size(1000, 1000);
  //size(1500, 1500);
  //size(2000, 2000);
  //size(4000, 4000);
  //size(5000, 5000);
  //size(6000, 6000);
  //size(8000, 8000);
  //background(gs.bkgColor); // TEST ONLY
  if (gs.debug) {frameRate(5);}
  videoExport = new VideoExport(this, videoPath + ".mp4");
  videoExport.setFrameRate(30);
  videoExport.setQuality(70, 128);
  videoExport.setDebugging(false);
  videoExport.startMovie();
}

void draw() {
  if (colony.population.size() == 0 || frameCounter <= 0 ) {manageColony();}
  if (gs.debug) {background(gs.bkgColor);} // Refresh the background on every frame to simplify debugging
  //background(gs.bkgColor);
  colony.run();
  //frameSave(); // Saves each frame as a .png (for GIFs etc.)
  //if (gs.makeMPEG) {videoExport.saveFrame();} // Use this to save every frame in the sketch
  frameCounter --;
}

// What happens when the colony goes extinct
void manageColony() {
  if (gs.savePNG) {saveFrame(screendumpPath);} // Save an image
  if (gs.makeGIF) {saveFrame(screendumpPathGIF1);saveFrame(screendumpPathGIF2);} // Save a duplicate image with alternative iteration number 
  //saveFrame("/data/output.png"); // Save a duplicate image to the /data folder to be used in next iteration
  if (gs.makePDF) {endRecord();}
  if (gs.makeMPEG) {videoExport.saveFrame();} // Use this to save one frame per iteration
  endSettingsFile(); // Complete the settings logfile & close
  //exit();
  if (runCycle >= maxCycles) {videoExport.endMovie(); exit();}
  else {
    // get ready for a new cycle
    runCycle ++;
    getReady();
  }
}

void getReady() {
  img = loadImage(inputFile);
  println("Iteration: " + runCycle);
  inputFile = "output.png"; // After 1st run, all iterations will use /data/output.png as the input file
  frameCounter = maxFrames;
  iterationNum = nf(runCycle, 3);
  cycleGen = sin(PI * map(runCycle, 1, maxCycles, 1.5, 3.5)); // cyclic generator value in range 0-1 
  String iterationNum2 = nf((maxCycles * 2 - runCycle), 3);
  pathName = "../../output/" + applicationName + "/" + batchName + "/" + String.valueOf(width) + "x" + String.valueOf(height) + "/"; //local
  //pathName = "D:/output/" + applicationName + "/" + batchName + "/"+ String.valueOf(width) + "x" + String.valueOf(height) + "/"; //USB
  
  screendumpPath = pathName + "/png/" + batchName + "-" + iterationNum + ".png";
  screendumpPathGIF1 = pathName + "/jpg/" + batchName + "-" + iterationNum + ".jpg";
  screendumpPathGIF2 = pathName + "/jpg/" + batchName + "-" + iterationNum2 + ".jpg";
  screendumpPathPDF = pathName + "/pdf/" + batchName + "-" + iterationNum + ".pdf";
  //screendumpPath = "../output.png"; // For use when running from local bot
  framedumpPath = pathName + "/frames/";
  videoPath = pathName + "/" + batchName + "-" + iterationNum;
  
  //videoExport = new VideoExport(this, videoPath + ".mp4");
  
  output = createWriter(pathName + "/settings/" + batchName + "-" + iterationNum +".settings.log"); //Open a new settings logfile
    
  startSettingsFile();
  gs = new Global_settings();
  if (gs.makePDF) {beginRecord(PDF, screendumpPathPDF);}
  gpl = new Genepool();
  colony = new Colony();
  background(gs.bkgColor);
  //image(img,(width-img.width)*0.5, (height-img.height)*0.5); // Displays the image file /data/output.png (centered)
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