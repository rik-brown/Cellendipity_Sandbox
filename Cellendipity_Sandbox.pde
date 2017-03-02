/*
* Cellendipity_Sandbox
* Thursday 16th February 2016
* Template: p014a (26.10.2016 21:41)
*
* Main Goal: Work towards a generic 'multi-cellular playset' that
*  - consists of well-organized, easy-to-understand functional-modules
*  - is geared towards making future art-experiments easier to prototype
*
* Sub-Goals:
*  1) Introduce alternative "seed-patterns" (like x-y grid or polar array)
*  2) Architecture which supports parametric control of DNA relating to spawn position
*   a) Maybe this should be done inside the cell, using the information passed down from the DNA?
    b) Is it still meaningful to determine position in the DNA?
    c) Maybe this would open for different strains interpreting the parametrically controlled variables differently? INTERESTING!!!
    Something is not right with gene 25 in colony???
*  3) Introduce configurable stripes (initially 2 states - on/off)
*    NEED a good way of defining stripe colour
*    (is currently hard-coded in cell: stripe() )
*  d) Introduce a smart way of saving frames for gifs (configurable frame interval and intelligent file numbering)
* WHAT HAVE I DONE TO BREAK BRIGHTNESS? Is it linked to updateColourR()??

*/

Colony colony;                                     // A Colony object called 'colony'
Global_settings gs;                                // A Parameters object called 'p'

int runCycle = 1;
int maxCycles =10;
//int maxFrames = int(random(1300,1600));
int maxFrames = 5000;
int frameCounter = maxFrames;
String versionName = "sandbox";
String batchName = "batch-123";
String outputName = nf(runCycle, 3);
String pathName;
String screendumpPath; // Name & location of saved output (final image)
String framedumpPath; // Name & location of saved output (individual frames)
PrintWriter output;

void setup() {
  //frameRate(10);
  colorMode(HSB, 360, 255, 255, 255);
  rectMode(RADIUS);
  smooth();
  //size(200, 200);
  //size(500, 500);
  //size(1000, 1000);
  //size(1600, 1600);
  //size(2000, 2000);
  size(4000, 4000);
  //size(6000, 6000);
  //size(8000, 8000);
  pathName = "../../output/" + versionName + "/" + batchName + "/" + String.valueOf(width) + "x" + String.valueOf(width) + "/"; //local
  //pathName = "D:/output/" + versionName + "/" + String.valueOf(width) + "x" + String.valueOf(width) + "/" + batchName + "/"; //USB
  screendumpPath = pathName + versionName + "." + outputName + ".png";
  //screendumpPath = "../output.png";
  framedumpPath = pathName + "/frames/";
  output = createWriter(pathName + versionName + "." + outputName +"_settings.txt");
  ellipseMode(RADIUS);
  startSettingsFile();
  gs = new Global_settings();
  colony = new Colony();
  if (gs.greyscaleON) {background(gs.bkgColGrey); } else {background(gs.bkgColor);}
  //background (0,0,0,0);
  if (gs.debug) {frameRate(3);}
}

void draw() {
  if (gs.debug) {background(gs.bkgColor);}
  colony.run();
  String frameName = nf(frameCount, 5);
  //saveFrame(framedumpPath + frameName + ".jpg");
  if (colony.cells.size() == 0 || frameCounter < 0 ) {manageColony();}
  frameCounter --;
}

void manageColony() {
    saveFrame(screendumpPath);
    output.println("Total frames: " + (maxFrames - frameCounter));
    output.flush();
    output.close();
    //exit();
    colony.cells.clear();
    frameCounter = maxFrames;
    runCycle ++;
    if (runCycle > maxCycles) {exit();}
    outputName = nf(runCycle, 3);
    screendumpPath = pathName + versionName + "." + outputName + ".png";
    output = createWriter(pathName + versionName + "." + outputName +"_settings.txt");
    if (gs.greyscaleON) {background(gs.bkgColGrey); } else {background(gs.bkgColor);}
    startSettingsFile();
    gs = new Global_settings();
    colony = new Colony();
    if (gs.greyscaleON) {background(gs.bkgColGrey); } else {background(gs.bkgColor);}
}

void startSettingsFile() {
int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.
int h = hour();
int min = minute();
int sec = second();

output.println(outputName);
output.println(y + "" + m + "" + d + "-" + h + "" + min + "" + sec + "-" +versionName + "-" + width + "x" + height);
output.println(screendumpPath);
}