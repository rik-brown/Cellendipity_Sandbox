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
*
*  2) Architecture which supports parametric control of DNA relating to spawn position
*   a) Maybe this should be done inside the cell, using the information passed down from the DNA?
*   Started this in batch-142.
*   Next step is to move the 'dna-modifiers' into cell
*
*   c) Maybe this would open for different strains or cell-types, each interpreting the parametrically controlled variables differently? INTERESTING!!!
*
*   d) Introduce a smart way of saving frames for gifs (configurable frame interval and intelligent file numbering)
*
*/

Colony colony;        // A Colony object called 'colony'
//Phyllotaxis colony;   // A Phyllotaxis object called 'colony'
Global_settings gs;                                // A Global_settings object called 'gs'

int runCycle = 1;
int maxCycles = 1;
//int maxFrames = int(random(1300,1600));
int maxFrames = 5000;
int frameCounter = maxFrames;
String versionName = "sandbox";
String batchName = "batch-144.5";
String outputName = nf(runCycle, 3);
String pathName;
String screendumpPath; // Name & location of saved output (final image)
String framedumpPath; // Name & location of saved output (individual frames)
PrintWriter output;

void setup() {
  //frameRate(10);
  colorMode(HSB, 360, 255, 255, 255);
  //blendMode(DIFFERENCE);
  rectMode(RADIUS);
  smooth();
  //size(200, 200);
  //size(500, 500);
  //size(1000, 1000);
  //size(1500, 1500);
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
  //colony = new Phyllotaxis();
  background(gs.bkgColor);
  //background (0,0,0,0);
  //background (0,0,255); //white
  if (gs.debug) {frameRate(3);}
}

void draw() {
  //if (gs.debug) {background(gs.bkgColor);}
  //background(gs.bkgColor);
  colony.run();
  String frameName = nf(frameCount, 5);
  //saveFrame(framedumpPath + frameName + ".jpg");
  if (colony.population.size() == 0 || frameCounter < 0 ) {manageColony();}
  frameCounter --;
}

void manageColony() {
    saveFrame(screendumpPath);
    output.println("Total frames: " + (maxFrames - frameCounter));
    output.flush();
    output.close();
    //exit();
    colony.population.clear();
    frameCounter = maxFrames;
    runCycle ++;
    if (runCycle > maxCycles) {exit();}
    outputName = nf(runCycle, 3);
    screendumpPath = pathName + versionName + "." + outputName + ".png";
    output = createWriter(pathName + versionName + "." + outputName +"_settings.txt");
    background(gs.bkgColor);
    //background (0,0,0,0);
    //background (0,0,255); //white
    startSettingsFile();
    gs = new Global_settings();
    colony = new Colony();
    //colony = new Phyllotaxis();
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