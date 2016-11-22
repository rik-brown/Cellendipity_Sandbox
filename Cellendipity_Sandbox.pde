/*
* Cellendipity_Sandbox
* Sunday 20th November 2016
* Template: p014a (26.10.2016 21:41)
*
* Main Goal: Work towards a generic 'multi-cellular playset' that 
*  - consists of well-organized, easy-to-understand functional-modules
*  - is geared towards making future art-experiments easier to prototype
*
* Sub-Goals:
*  a) Introduce a 'genepool' array so I can first populate a number of different DNA-variants which can later be selected when seeding the canvas
*  b) Introduce alternative "seed-patterns" (like x-y grid or polar array)
*/

Colony colony;                                     // A Colony object called 'colony'
Global_settings gs;                                // A Parameters object called 'p'

int runCycle = 1;
int maxCycles = 10;
int maxFrames = int(random(1300,1600));
int frameCounter = maxFrames;
String versionName = "sandbox";
String batchName = "batch-062";
String outputName = nf(runCycle, 3);
String pathName;
String screendumpPath; // Name & location of saved output (final image)
String framedumpPath; // Name & location of saved output (individual frames)
PrintWriter output;

void setup() {
  //frameRate(10);
  colorMode(HSB, 360, 255, 255, 255);
  smooth();
  //size(200, 200);
  //size(500, 500);
  size(1000, 1000);
  //size(1600, 1600);
  //size(2000, 2000);
  //size(4096, 4096);
  //size(6000, 6000);
  //size(8000, 8000);
  pathName = "../../output/" + versionName + "/" + String.valueOf(width) + "x" + String.valueOf(width) + "/" + batchName + "/"; //local
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
  if (gs.debug) {frameRate(15);}
}

void draw() {
  if (gs.debug) {background(gs.bkgColor);}
  colony.run();
  String frameName = nf(frameCount, 5);
  //saveFrame(framedumpPath + frameName + ".jpg");
  manageColony();
  frameCounter --;
}

void manageColony() {
  if (colony.cells.size() == 0 || frameCounter < 0 ) {
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
  }
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