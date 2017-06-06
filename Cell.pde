class Cell {

  float[] modulators;  // 'modulators' is an array of float values in the range (0-1)
  color[] colors; // 'colors' is an array of color objects (fillColor, strokeColor & possibly nucleusColor too) NOT YET IN USE!!!
  
  //  Objects
  DNA dna;         // DNA

  // BOOLEAN
  boolean fertile;
  boolean stripeON;
  boolean stepON;
  boolean drawCellON;
  boolean nucleusON;
  boolean drawNucleusON;
  
  // GROWTH AND REPRODUCTION
  int age;       // Age (nr. of frames since birth)
  //float lifespan;
  //float fertility; // Condition for becoming fertile
  float maturity;
  float spawnLimit;

  // SIZE AND SHAPE
  float r;
  //, radius_start, radius_end;
  float flatness; // To make flatter ellipses (1 = circle)
  //float flatness_start, flatness_end;
  float drawStep;  // To enable spacing of the drawn object (ellipse)
  float drawStepN;
  float stripeStep;// Countdown to toggle between stripeON and !stripeON
  float stripeSize;
  float stripeRatio;
  
  // SAWTEETH
  int period_1, period_2;

  // MOVEMENT
  PVector position; // cell's current position
  PVector home;     // cell's initial position
  PVector toHome;   // from current to initial (=sub(home, position) )
  PVector origin;   // arbitrary origin (e.g. center of screen)
  PVector toOrigin; // from current to initial (=sub(origin, position) )
  PVector velocityRef;
  PVector velocityLinear;
  PVector velocityNoise;
  PVector velocity;
  
  //float noisePercent, noisePercent_start, noisePercent_end;
  float noise_vMax;   // multiplication factor for velocity
  float noise_xoff, noise_yoff;   // y offset
  float noise_x, noise_y; // perlin noise modulators
  float noise_step;   // step size
  
  
  //float twist, twist_start, twist_end;
  
  float distanceFromHome;      // How far is the cell from it's home position?
  float remoteness; // How close is the cell to it's maximum range?
  float distanceFromOrigin;      // How far is the cell from the arbitrary origin?
  
  float directionDiff; // The difference between the current and the initial velocity heading. Range 0-1 where 1 = max diff. = 180 degrees

  // FILL COLOUR
  color fillColor;   // For HSB you need Hue to be the heading of a PVector
  //float fill_H_start, fill_H_end;
  //float fill_S_start, fill_S_end;
  //float fill_B_start, fill_B_end;
  //float fill_A_start, fill_A_end;

  // STROKE COLOUR
  color strokeColor; // For HSB you need Hue to be the heading of a PVector
  //float stroke_H_start, stroke_H_end;
  //float stroke_S_start, stroke_S_end;
  //float stroke_B_start, stroke_B_end;
  //float stroke_A_start, stroke_A_end;
  
  // PIXEL COLOR = color of pixel in source image at cell's current location
  color pixelColor;
  
  // STRAIN
  int id;

  // **************************************************CONSTRUCTOR********************************************************
  // CONSTRUCTOR: create a 'cell' object
  Cell (PVector pos, PVector vel, DNA dna_) {
    
    modulators = new float[6];
    colors = new color[2]; // 0 = fillColor, 1 = strokeColor NOT YET IN USE!!!
  
  // OBJECTS
  dna = new DNA();
  for (int i = 0; i < dna_.genes.length; i++) {
    dna.genes[i] = dna_.genes[i]; // Copy the contents of the referenced dnx genes into the local dna genes
  }
    
  // BOOLEAN
  fertile = false; // A new cell always starts off infertile
  drawCellON = true;
  drawNucleusON = false;
  stepON = gs.stepped;
  nucleusON = gs.nucleus;
  stripeON = false; // A new cell always starts off displaying it's normal colour
  
  // id
  id = int(dna.genes[0]);
  
  // GROWTH AND REPRODUCTION
  age = 0; // Age is number of frames a cell has existed. A new cell always starts with age = 0.
  spawnLimit = dna.genes[30]; // Max. number of spawns
  //lifespan = dna.genes[31] * gs.maxLifespan;
  //lifespan= dna.genes[31] * width * 0.001 * map(cycleGen, -1, 1, 0.3, 0.7);
  //fertility = dna.genes[29]; // How soon will the cell become fertile?

  // POSITION & MOVEMENT
  position = pos.copy();                // cell has current position
  home = pos.copy();                    // home = initial position
  origin = new PVector(gs.orx, gs.ory); //arbitrary origin
  
  toHome = PVector.sub(home, position); // static vector pointing from cell to home
  distanceFromHome = toHome.mag(); // distanceFromHome is how far the cell is from home at any time
  
  toOrigin = PVector.sub(origin, position); // static vector pointing from cell to origin
  distanceFromOrigin = toOrigin.mag(); // distance from pos to origin
  
  distanceFromOriginMods();
  
  //updateModulators();
  //dna.genes[17] = map(id, 0, 8, 0, 88);
  
  velocityLinear = vel.copy(); //cell has unique basic velocity component
  updateVelocity();
  velocityRef = velocity.copy(); //keep a copy of the inital velocity for reference
  
  //twist_start = dna.genes[21] * 0.01; // twist_start screw amount
  //twist_start = map(runCycle, 1, maxCycles, -2, 2); // twist_end screw amount
  //twist_start = map(cycleGen, -1, 1, 0, 1); // twist_end screw amount
  //twist_end = dna.genes[22] * 0.01; // twist_end screw amount
  //twist_end = map(runCycle, 1, maxCycles, -3, 3) * 0.01; // twist_end screw amount
  
  noise_vMax = dna.genes[25]; // Maximum magnitude in velocity components generated by noise
  noise_step = dna.genes[26] * 0.001; //Step-size for noise
  //noisePercent_start = dna.genes[23] * 0.01; // How much influence on velocity does Perlin noise have? (initial value)
  //noisePercent_end = dna.genes[24] * 0.01; // How much influence on velocity does Perlin noise have? (final value)
  //noisePercent_end =map(cycleGen, -1, 1, 0, 100);
  //noise_xoff = dna.genes[27] + dna.genes[0]; //Seed for noiseX
  //noise_xoff = map(runCycle, 1, maxCycles, 1, 2); //Seed for noiseX
  noise_xoff = map(cycleGen, -1, 1, 1, 1.5); //Seed for noiseX
  //noise_yoff = dna.genes[28]; //Seed for noise
  noise_yoff = map (dna.genes[0], 0, gpl.genepool.size(), 1, 1000) + map(cycleGen, -1, 1, 10, 10.5); //Strain ID is seed for noiseY
  
  // SIZE AND SHAPE
  //radius_start = dna.genes[17];
  //radius_end = dna.genes[17] * dna.genes[18];
  
  //r = modulator(maturity, radius_start, radius_end) * gs.maxRadius;
  updateSize();
  //println("New cell with id: " + id + " and size: " + r);
  //flatness_start = dna.genes[19] * 0.01; // To make circles into ellipses
  //flatness_end = dna.genes[20] * 0.01; // To make circles into ellipses
  drawStep = 1;
  drawStepN = 1;
  stripeSize = dna.genes[32];
  stripeRatio = dna.genes[33];
  stripeStep = map(stripeSize, 0, 100, 0, r*2);
  
  // SAWTOOTH WAVES (for Michael)
  period_1 = ceil(r);
  period_2 = ceil(r);
  
  //cartesianMods(); // Modulate some properties in a way that is appropriate to a cartesian spawn pattern
  //coralMods(); // Modulate some properties in a way that is similar to batch-144.8g (tragedy of the corals)
  
  cellDNALogger(); //Print the DNA for this cell
  }
  
  void distanceFromOriginMods() {
    dna.genes[17] *= map(distanceFromOrigin, 0, width*1.4, 0.1, 1.0);
    //radius_start *= map(distanceFromOrigin, 0, width*1.4, 0.1, 1);
  }

  void cartesianMods() {
  // MODULATED BY POSITION
  //radius_start *= map(distanceFromOrigin, 0, width, 0.5, 1);
  //dna.genes[19] *= map(distanceFromOrigin, 0, width, 0.4, 1.0);
  //lifespan *= map(distanceFromOrigin, 0, width, 0.7, 3);
  //noisePercent_start *= map(distanceFromOrigin, 0, width, 0.7, 0.5);
  //twist_start *= map(distanceFromOrigin, 0, width, 0.3, 0.5);
  //fill_H_end = (gs.bkg_H + map(distanceFromOrigin, 0, width, 40, 0));
  //fill_S_start *= map(position.x, 0, width, 1, 0);
  //fill_S_start *= map(distanceFromOrigin, 0, width, 0, 0);
  //fill_S_end *= map(position.x, 0, width, 1, 0);
  //fill_S_end *= map(distanceFromOrigin, 0, width, 0, 0);
  //fill_B_end = map(distanceFromOrigin, 0, width*0.5, 250, 48);
  //fill_B_start *= map(distanceFromOrigin, 0, width, 1, 0);
  //fill_B_start *= map(position.x, 0, width, 1, 0);
  //fill_B_end *= map(distanceFromOrigin, 0, width, 0.7, 0.2);
  //stripeSize *= map(distanceFromOrigin, 0, width, 1.0, 0.6);
  //stripeRatio = map(distanceFromOrigin, 0, width, 0.3, 0.7);
  
  // MODULATED BY POSITION (Cartesian/Random)
  //lifespan = width * 0.001 * map(distanceFromOrigin, 0, width*0.7, 18, 12);

  //twist_start = map(distanceFromOrigin, 0, width, 0, 15);
  //fill_B_end = dna.genes[5] * map(distanceFromOrigin, 0, width*0.7, 0.7, 1);
  //fill_A_start = map(distanceFromOrigin, 0, width*0.7, 255, 20);
  
  // MODULATED BY INDEX NUMBER
  //stripeSize = map(id, 0, gs.seeds, 60, 10);
  //lifespan *= map(id, 0, gs.numStrains, 0.1, 1);
  //radius_start = width * 0.001 * map(id, 0, gs.numStrains, 10, 50);
  //r = radius_start;
  //radius_end = radius_start * map(id, 0, gs.numStrains, 0.2, 0.05);
  //dna.genes[19] = map(id, 0, gs.rows * gs.cols, 1, 1.5);
  //lifespan = width * .001 * map(id, 0, gs.seeds, 1, 500);
  //twist_start = map(id, 0, gs.numStrains, -3, 3);
  //fill_H_start =  map(id, 0, gs.numStrains, 0, 360);
  //fill_H_end =  fill_H_start;
  }
  
  void coralMods() {
    // MODULATED BY POSITION
    //radius_start *= map(distanceFromOrigin, 0, width * 0.5, 0.01, 1);
    
    r = modulator(maturity, dna.genes[17], dna.genes[18]) * gs.maxRadius;
    //radius_end = radius_start * dna.genes[18] * 0.01;
    //r = radius_start; // Initial value for radius
    stripeStep = map(stripeSize, 0, 100, 0, r*2);
    //radius_start = map(distanceFromOrigin, 0, width * 0.5, 60, 30) * width * 0.001;
    //lifespan = map(distanceFromOrigin, 0, width * 0.5, 50, 100) * width * 0.001;
    //lifespan = r * 1.732;
    //noisePercent_start = map(distanceFromOrigin, 0, width * 0.5, 1, 0);
    //noisePercent_end = map(distanceFromOrigin, 0, width * 0.5, 0, 1);
    
    //stroke_H_start = map(distanceFromOrigin, 0, width * 0.5, 0, 360);
    //stroke_H_end = map(distanceFromOrigin, 0, width * 0.5, 0, 360);
    
    //fill_H_end = (gs.bkg_H + map(distanceFromOrigin, 0, width, 30, 0));
    //fill_B_start = map(position.x, 0, width, 128, 48);
    //fill_B_end = map(distanceFromOrigin, 0, width, 200, 255);
    //fill_B_end = fill_B_start * map(distanceFromOrigin, 0, width, 1, 2);
    //fill_S_start = map(position.x, 0, width, 255, 0);
    //fill_S_end = map(position.x, 0, width, 30, 0);
    //fill_S_start = map(distanceFromOrigin, 0, width, 255, 0);
    //fill_S_end = map(distanceFromOrigin, 0, width, 30, 0);
    //fill_S_end = fill_S_start * map(distanceFromOrigin, 0, width, 0.8, 0.6);
    //twist_start = map(distanceFromOrigin, 0, width, 0, 20) * 0.01;
    //twist_end = map(distanceFromOrigin, 0, width * 0.5, 250, 0) * 0.01;
    
  }

  void run() { //<>//
    updateModulators();
    updateVelocity();
    //updateVelocityByHue();
    updatePosition();
    updateSize();
    updateShape();
    updateFertility();
    updateFillColor();
    updateStrokeColor();
    //updateFillColorByDirection();
    //updateStrokeColorByDirection();
    //updateFillColorByPosition();
    //updateStrokeColorByPosition();
    if (stripeON) {updateStripeColor();}
    if (stepON) {updateSawtooth_1();}
    if (nucleusON) {updateSawtooth_2();}
    display();
    //displayLine();
    //displayText();
    if (gs.debug) {cellDebugger();}
    increment();
  }

  void increment() {
    age ++;
    noise_xoff += noise_step;
    noise_yoff += noise_step;
    drawStep--;
    drawStepN--;
    stripeStep--;
    period_1 --;
    period_2 --;
    position.add(velocity);
  }
  
  void updateModulators() {
    modulators[0] = map(age, 0, dna.genes[31] * gs.maxLifespan, 0, 1); // maturity is the driver tied to the aging process 'MATURITY'
    modulators[1] = map(distanceFromHome, 0, dna.genes[31] * gs.maxLifespan, 0, 1); // distanceFromHome = distance to seed-position (home). 'REMOTENESS'
    modulators[2] = map(distanceFromOrigin, 0, width, 0, 1);  // distanceFromOrigin = distance to origin. 'REMOTENESS2'
    modulators[3] = map(PVector.angleBetween(velocityRef, velocity), 0, PI, 0, 1); // MODULATOR in updateVelocity()
    modulators[4] = noise(dna.genes[27]*1000); // NOISE_X
    modulators[5] = noise(dna.genes[28]*1000); // NOISE_Y
    
    // Experiments...
    //remoteness = sq(map(distanceFromHome, 0, lifespan, 0, 1)); // remoteness is a value between 0-1.
    //remoteness = sq(map(distanceFromOrigin, 0, lifespan, 0, 1)); // remoteness is a value between 0-1.
    //r = map(hue(pixelColor), 360, 0, radius_start, radius_end); // Size from pixel brightness
    //r = ((sin(map(distMag, 0, 500, 0, PI)))+0)*radius_start;
    //r = (((sin(map(remoteness, 0, 1, 0, PI*0.5)))+0)*radius_start) + radius_end;
    //r = (((sin(map(age, 0, lifespan, 0, PI)))+0)*radius_start) + radius_end;
  }
  
  
  
  void updateSawtooth_1() {
    if (period_1 <1) {period_1 = ceil(r); drawCellON = true;} else {drawCellON = false;}
  }
  
  void updateSawtooth_2() {
    if (period_2 <1) {period_2 = ceil(r); drawNucleusON = true;} else {drawNucleusON = false;}
  }

  void updateVelocity() {
    //Update Perlin noise vector 
    //float vx = map(noise(noise_xoff),0,1,-noise_vMax,noise_vMax);
    //float vy = map(noise(noise_yoff),0,1,-noise_vMax,noise_vMax);
    float vx = modulator(modulators[4], -dna.genes[25], dna.genes[25]);
    float vy = modulator(modulators[5], -dna.genes[25], dna.genes[25]);
    velocityNoise = new PVector(vx,vy);
    
    //Update noisePercent
    float noisePercent = modulator(modulators[0], dna.genes[23], dna.genes[24]);
    
    //Update twistAngle
    float twist = radians(modulator(modulators[0], dna.genes[21], dna.genes[22]));
    
    //Interpolate between the linear and noise vectors
    velocity = PVector.lerp(velocityLinear.rotate(twist), velocityNoise, noisePercent);
    velocity.normalize(); // TEST. To see how this looks, velocity only contributes direction, is always a unit vector.
  }
  
  void updateVelocityByHue() {
    velocity = PVector.fromAngle(radians(hue(pixelColor)));
    float twist = radians(modulator(modulators[0], dna.genes[21], dna.genes[22]));
    velocity.rotate(twist);
  }
  
  
  void updatePosition() { //Update parameters linked to the position
    //position.add(velocity); //<>//
    
    //pixelColor = colony.pixelColour(position);
    
    toHome = PVector.sub(home, position); // static vector pointing from cell to home
    distanceFromHome = toHome.mag(); // distanceFromHome is how far the cell is from home at any time. MODULATOR
    
    toOrigin = PVector.sub(origin, position); // static vector pointing from cell to origin
    distanceFromOrigin = toOrigin.mag(); // distance from pos to origin. MODULATOR
  }

  void updateSize() {
    r = modulator(modulators[0], dna.genes[17], dna.genes[17] * dna.genes[18]) * gs.maxRadius;
  }

  void updateFertility() {
    if ((1-modulators[0]) <= dna.genes[29]) {fertile = true; } else {fertile = false; }
    if (spawnLimit == 0) {dna.genes[29] = 0;} // Once spawnLimit has counted down to zero, the cell will spawn no more
  }

  void updateShape() {
  //flatness = map(maturity, 0, 1, flatness_start, flatness_end);
  flatness = modulator(modulators[0], dna.genes[19], dna.genes[20]);
  }
  
  void updateFillColor() {
    // START > END
    float h = modulator(modulators[0], dna.genes[1], dna.genes[2]) * 255;
    float s = modulator(modulators[0], dna.genes[3], dna.genes[4]) * 255;
    float b = modulator(modulators[0], dna.genes[5], dna.genes[6]) * 255;
    float a = modulator(modulators[0], dna.genes[7], dna.genes[8]) * 255;
    fillColor = color(h, s, b, a); //fill colour is updated with new values
  }
  
  void updateStrokeColor() {
    // START > END
    float h = modulator(modulators[0], dna.genes[9], dna.genes[10]) * 255;
    float s = modulator(modulators[0], dna.genes[11], dna.genes[12]) * 255;
    float b = modulator(modulators[0], dna.genes[13], dna.genes[14]) * 255;
    float a = modulator(modulators[0], dna.genes[15], dna.genes[16]) * 255;
    strokeColor = color(h, s, b, a); //fill colour is updated with new values
  }


  //void updateFillColorByDirection() {
  //  float fill_H = map(directionDiff, 0, PI, fill_H_start, fill_H_end) % 360;
  //  float fill_S = map(directionDiff, 0, PI, fill_S_start, fill_S_end);
  //  float fill_B = map(directionDiff, 0, PI, fill_B_start, fill_B_end);
  //  float fill_A = map(maturity, 0, 1, fill_A_start, fill_A_end);
  //  fillColor = color(fill_H, fill_S, fill_B, fill_A); //fill colour is updated with new values
  //}
  
  //void updateStrokeColorByDirection() {
  //  float stroke_H = map(directionDiff, 0, PI, stroke_H_start, stroke_H_end) % 360;
  //  float stroke_S = map(directionDiff, 0, PI, stroke_S_start, stroke_S_end);
  //  float stroke_B = map(directionDiff, 0, PI, stroke_B_start, stroke_B_end);
  //  float stroke_A = map(maturity, 0, 1, stroke_A_start, stroke_A_end);
  //  strokeColor = color(stroke_H, stroke_S, stroke_B, stroke_A); //stroke colour is updated with new values
  //}
  
  void updateFillColorByPosition() {
  //fillColor = colony.pixelColour(position);
  //float fill_H = hue(pixelColor);
  //float fill_S = saturation(pixelColor);
  //float fill_B = brightness(pixelColor);
  //float fill_A = alpha(fillColor); // alpha from pixelColor is not used as it is always 100%
  fillColor = color(hue(fillColor), saturation(fillColor), brightness(pixelColor), alpha(fillColor)); //fill colour is updated with new values
  //fillColor = pixelColor;
  }
  
  void updateStrokeColorByPosition() {
    strokeColor = color(hue(pixelColor), saturation(pixelColor), brightness(pixelColor), alpha(strokeColor));
    //strokeColor = pixelColor;
  }

  void updateStripeColor() {
    //fillColor = color(34, 255, 255, 255); // RED
    //fillColor = strokeColor;
    fillColor = color(0, 0, 0, 255); // BLACK
    //fillColor = gs.bkgColor; // Background
    //fillColor = color(0, 0, 255); // WHITE
    //strokeColor = color(0, 0, 0);  
  }
  
  void updateNucleusColor() {
    if (fertile) {fillColor = gs.nucleusColorF;} else {fillColor = gs.nucleusColorU;}
    strokeColor = color(1,1,1,0);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    float angle = velocity.heading();
    rotate(angle);
    if (drawCellON) {drawSomething(fillColor, strokeColor, r, r*flatness, 1);}
    //if (drawNucleusON) {updateNucleusColor(); println("nucleus color = " + brightness(fillColor)); drawSomething(fillColor, strokeColor, dna.genes[18] * gs.maxRadius * 0.5, dna.genes[18] * gs.maxRadius * 0.5 * flatness, 1);}
    if (drawNucleusON) {updateNucleusColor(); ; drawSomething(fillColor, strokeColor, 10, 10, 1);}
    popMatrix(); 
  }
  
  void drawSomething(color fillCol, color strokeCol, float xSize, float ySize, int type) {
    strokeWeight(1);
    fill(fillCol);
    stroke(strokeCol);
    if (type == 1) {ellipse(0, 0, xSize, ySize);}
    if (type == 2) {rect(0, 0, xSize, ySize);}  
  }

void displayLine() {
  float radius_start = dna.genes[17] * gs.maxRadius;
  float t = constrain (r * 0.1, 2, radius_start);
  strokeWeight(t);
  fill(fillColor);
  stroke(fillColor);
  
  float angle = velocity.heading();
  pushMatrix();
  translate(position.x, position.y);
  rotate(angle);
  line(0, -r, 0, r);
  fill(0);
  noStroke();
  ellipse(0,-r, t, t);
  ellipse(0, r, t, t);
  //line(0, 0, 0, -r);
  popMatrix();
}

//void displayText() {
//    textSize(r*0.5);
//    strokeWeight(1);
//    stroke(strokeColor);
//    fill(fillColor);

//    float angle = velocity.heading();
//    pushMatrix();
//    translate(position.x,position.y);
//    rotate(angle);
//    String word = gs.words.get(id);
//    text(word, 0, 0);
    
//   popMatrix();
//  }



  void checkCollision(Cell other) {       // Method receives a Cell object 'other' to get the required info about the collidee
      PVector distVect = PVector.sub(other.position, position); // Static vector to get distance between the cell & other
      float distMag = distVect.mag();       // calculate magnitude of the vector separating the balls
      if (distMag < (r + other.r)) { conception(other, distVect);} // Spawn a new cell
  }

  void conception(Cell other, PVector distVect) {
    // Decrease spawn counters.
    spawnLimit --;
    other.spawnLimit --; //<>// //<>// //<>// //<>//

    // Calculate velocity vector for spawn as being centered between parent cell & other
    PVector spawnVel = velocity.copy(); // Create spawnVel as a copy of parent cell's velocity vector
    spawnVel.add(other.velocity);       // Add dad's velocity
    spawnVel.normalize();               // Normalize to leave just the direction and magnitude of 1 (will be multiplied later)

    // Combine the DNA of the parent cells
    DNA childDNA = dna.combine(other.dna);

    // Calculate new fill colour for child (a 50/50 blend of each parent cells)
    color childFillColor = lerpColor(fillColor, other.fillColor, 0.5);

    // Calculate new stroke colour for child (a 50/50 blend of each parent cells)
    color childStrokeColor = lerpColor(strokeColor, other.strokeColor, 0.5);

    // Genes for color require special treatment as I want childColor to be a 50/50 blend of parents colors
    // I will therefore overwrite color genes with reverse-engineered values after lerping:
    //childDNA.genes[1] = hue(childFillColor); // Get the  lerped hue value and map it back to gene-range
    //childDNA.genes[3] = saturation(childFillColor); // Get the  lerped hue value and map it back to gene-range
    //childDNA.genes[5] = brightness(childFillColor); // Get the  lerped hue value and map it back to gene-range
    //childDNA.genes[9] = hue(childStrokeColor); // Get the  lerped hue value and map it back to gene-range
    //childDNA.genes[11] = saturation(childStrokeColor); // Get the  lerped hue value and map it back to gene-range
    //childDNA.genes[13] = brightness(childStrokeColor); // Get the  lerped hue value and map it back to gene-range

    childDNA.genes[17] = (r + other.r) * 0.5 / gs.maxRadius; // Child radius_start is set at average of parents current radii

    colony.spawn(position, spawnVel, childDNA);

    //Reduce fertility for parent cells by squaring them
    dna.genes[29] *= dna.genes[29];
    fertile = false;
    other.dna.genes[29] *= other.dna.genes[29];
    other.fertile = false;
  }

  // Death
  boolean dead() {
    float radius_end = dna.genes[18] * gs.maxRadius;
    if (age >= dna.genes[31] * gs.maxLifespan) {return true;} // Death by old age (regardless of size, which may remain constant)
    if (r < dna.genes[17]*dna.genes[18]*gs.maxRadius) {return true;} // Death by too little radius
    //if (r > (width*0.1)) {return true;} // Death by too much radius
    if (spawnLimit <= 0) {return true;} // Death by too much babies
    //if (position.x > width + r * dna.genes[19] || position.x < -r * dna.genes[19] || position.y > height + r * dna.genes[19] || position.y < -r * dna.genes[19] {return true;} // Death if move beyond canvas boundary
    //if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {return true;} // Death if move beyond border
    else { return false; }
    //return false; // Use to disable death
  }

  void cellDebugger() { // For debug only
    int rowHeight = 15;
    fill(120, 0, 255);
    textSize(rowHeight);
    text("id: " + id, position.x, position.y + rowHeight * 0);
    text("age: " + age, position.x, position.y + rowHeight * 1);
    text("maturity:" + maturity, position.x, position.y + rowHeight * 2);
    text("r: " + r, position.x, position.y + rowHeight * 3);
    //text("period_1: " + period_1, position.x, position.y + rowHeight * 1);
    //text("drawCellON: " + drawCellON, position.x, position.y + rowHeight * 5);
    //text("period_2: " + period_2, position.x, position.y + rowHeight * 6);
    //text("drawNucleusON: " + drawNucleusON, position.x, position.y + rowHeight * 8);
    text("gene[17]:" + dna.genes[17], position.x, position.y + rowHeight * 4);
    text("gene[18]:" + dna.genes[18], position.x, position.y + rowHeight * 5);
    text("gene[17*18]:" + dna.genes[17]*dna.genes[17], position.x, position.y + rowHeight * 6);
    //text("pos:" + position.x + "," + position.y, position.x, position.y + rowHeight * 0);
    //text("stripeStep:" + stripeStep, position.x, position.y + rowHeight * 5);
    //text(stripeON:" + stripeON, position.x, position.y + rowHeight * 4);
    //text("distanceFromHome:" + int(distanceFromHome), position.x, position.y + rowHeight * 4);
    //text("fill_B_start:" + fill_B_start, position.x, position.y + rowHeight * 7);
    //text("fill_B_end:" + fill_B_end, position.x, position.y + rowHeight * 8);
    //text("radius_start:" + radius_start, position.x, position.y + rowHeight * 1);
    //text("radius_end:" + radius_end, position.x, position.y + rowHeight * 2);
    //text("fill_H:" + hue(fillColor), position.x, position.y + rowHeight * 1);
    //text("fill_S:" + saturation(fillColor), position.x, position.y + rowHeight * 2);
    //text("fill_B:" + brightness(fillColor), position.x, position.y + rowHeight * 6);
    //text("fill_A:" + alpha(fillColor), position.x, position.y + rowHeight * 4);
    //text("stroke_H:" + hue(strokeColor), position.x, position.y + rowHeight * 1);
    //text("stroke_S:" + saturation(strokeColor), position.x, position.y + rowHeight * 2);
    //text("stroke_B:" + brightness(strokeColor), position.x, position.y + rowHeight * 3);
    //text("stroke_A:" + alpha(strokeColor), position.x, position.y + rowHeight * 4);
    //text("lifespan:" + dna.genes[31] * gs.maxLifespan, position.x, position.y + rowHeight * 1);  
    //text("fertile:" + fertile, position.x, position.y + rowHeight * 4);
    //text("fertility:" + dna.genes[29], position.x, position.y + rowHeight * 3);
    //text("spawnLimit:" + spawnLimit, position.x, position.y + rowHeight * 4);
    //text("vel.x:" + velocity.x, position.x, position.y + rowHeight * 4);
    //text("vel.x:" + velocity.y, position.x, position.y + rowHeight * 5);
    //text("dirDiff:" + directionDiff, position.x, position.y + rowHeight * 2);
    //text("twist_Start:" + twist_start, position.x, position.y + rowHeight * 2);
    //text("twist_End:" + twist_end, position.x, position.y + rowHeight * 3);
    //text("twist:" + twist, position.x, position.y + rowHeight * 4);
    //text("distanceFromOrigin:" + distanceFromOrigin, position.x, position.y + rowHeight * 3);
    //text("noise%:" + noisePercent, position.x, position.y + rowHeight * 3);
    //text("noise%S:" + noisePercent_start, position.x, position.y + rowHeight * 4);
    //text("noise%E:" + noisePercent_end, position.x, position.y + rowHeight * 5);
  }
  
  void cellDNALogger() {
    if (gs.debug) {
        for (int i = 0; i < dna.genes.length; i++) {
          float value = dna.genes[i];
          output.println("Gene:" + i + ": has value " + value);
        }
    }
  }
  
  float modulator (float scalar, float start, float end) {
    float modulated = map (scalar, 0, 1, start, end);
    //if (gs.debug) {println("ID: " + id + " scalar = " + scalar + " start = " + start + " end = " + end + " MODULATED = " + modulated);}
    return modulated;
  }

}