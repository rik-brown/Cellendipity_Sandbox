class Cell {

  //  Objects
  DNA dna;         // DNA

  // BOOLEAN
  boolean fertile;
  boolean stripe;

  // GROWTH AND REPRODUCTION
  float age;       // Age (nr. of frames since birth)
  float lifespan;
  float fertility; // Condition for becoming fertile
  float maturity;
  float spawnCount;

  // SIZE AND SHAPE
  float cellStartSize;
  float cellEndSize;
  float r;         // Radius
  float flatness;  // To make flatter ellipses (1 = circle)
  float growth;    // Radius grows by this amount per frame
  float drawStep;  // To enable spacing of the drawn object (ellipse)
  float drawStepN;
  float stripeStep;// Countdown to toggle between stripe and !stripe
  float size; // A value between 0-1 indicating how large the cell is proportional to it's limits

  // MOVEMENT
  PVector position; // cell's current position
  PVector home;     // cell's initial position
  PVector toHome;   // from current to initial (=sub(home, position) )
  PVector origin;   // arbitrary origin (e.g. center of screen)
  PVector toOrigin; // from current to initial (=sub(origin, position) )
  PVector velocityLinear;
  PVector velocityNoise;
  PVector velocity;
  float noisePercent;
  float spiral;
  float vMax;   // multiplication factor for velocity
  float xoff;       // x offset
  float yoff;       // y offset
  float step;       // step size
  float range;      // How far is the cell from it's home position?
  float remoteness; // How close is the cell to it's maximum range?
  float oDist;      // How far is the cell from the arbitrary origin?

  // FILL COLOUR
  color fillColor;   // For HSB you need Hue to be the heading of a PVector
  color fillStart;
  color fillEnd;
  color spawnCol;      // spawnCol needs to be a GLOBAL variable
  //float fill_H;         // Hue (HSB) / Red (RGB)
  //float fill_S;         // Saturation (HSB) / Green (RGB)
  //float fill_B;         // Brightness (HSB) / Blue (RGB)
  float fill_A;      // Transparency (HSB & RGB)
  float fill_Hstart;
  float fill_Hend;
  float fill_Sstart;
  float fill_Send;
  float fill_Bstart;
  float fill_Bend;
  float fill_Astart;
  float fill_Aend;

  // FILL COLOUR
  color strokeColor; // For HSB you need Hue to be the heading of a PVector
  color strokeStart;
  color strokeEnd;
  //float stroke_H;       // Hue (HSB) / Red (RGB)
  //float stroke_S;       // Saturation (HSB) / Green (RGB)
  //float stroke_B;       // Brightness (HSB) / Blue (RGB)
  float stroke_A;    // Transparency (HSB & RGB)
  float stroke_Hstart;
  float stroke_Hend;
  float stroke_Sstart;
  float stroke_Send;
  float stroke_Bstart;
  float stroke_Bend;
  float stroke_Astart;
  float stroke_Aend;
  
  // STRAIN
  int strainID;

  // CONSTRUCTOR: create a 'cell' object
  Cell (PVector pos, PVector vel, DNA dna_) {
  // OBJECTS
  dna = dna_;

  // DNA gene mapping (17 genes)
  // 0 = fill Hue (0-360)
  // 1 = fill Saturation (0-255)
  // 2 = fill Brightness (0-255)
  // 3 = fill Alpha (0-255)
  // 4 = stroke Hue (0-360)
  // 5 = stroke Saturation (0-255)
  // 6 = stroke Brightness (0-255)
  // 7 = stroke Alpha (0-255)
  // 8 = cellStartSize (10-50) (cellendipity/one uses 0-200)
  // 9 = cellEndSize (5 - 20 %) (cellendipity/one uses 0-50)
  // 10 = lifespan (200-1000)
  // 11 = flatness (50-200 %)
  // 12 = spiral screw (-75 to 75)
  // 13 = fertility (70-90%)
  // 14 = spawnCount (1-5)
  // 15 = vMax (Noise) (0-5) (cellendipity/one uses 0-4)
  // 16 = step (Noise) (0.005 - ?)  (cellendipity/one uses 0.001-0.006)
  // 17 = noisePercent (0-1) (0-100%)
  // 18 = xOff (rnd 1000)
  // 19 = yOff (rnd 1000)

  // BOOLEAN
  fertile = false; // A new cell always starts off infertile
  stripe = false; // A new cell always starts off displaying it's normal colour 

  // GROWTH AND REPRODUCTION
  age = 0; // Age is 'number of frames since birth'. A new cell always starts with age = 0. From age comes maturity
  lifespan = dna.genes[10];
  fertility = dna.genes[13] * 0.01; // How soon will the cell become fertile?
  maturity = map(age, 0, lifespan, 1, 0);
  spawnCount = dna.genes[14]; // Max. number of spawns

  // SIZE AND SHAPE
  cellStartSize = dna.genes[8];
  cellEndSize = cellStartSize * dna.genes[9] * 0.01;
  r = cellStartSize; // Initial value for radius
  flatness = dna.genes[11] * 0.01; // To make circles into ellipses
  growth = (cellStartSize-cellEndSize)/lifespan; // Should work for both large>small and small>large
  drawStep = 1;
  drawStepN = 1;
  stripeStep = gs.stripeSize;

  // MOVEMENT
  position = pos.copy();                // cell has current position
  home = pos.copy();                    // home= initial position
  toHome = PVector.sub(home, position); // static vector pointing from cell to home
  origin = new PVector(width*0.5, height*0.5); //arbitrary origin
  toOrigin = PVector.sub(home, origin); // static vector pointing from cell to home
  oDist = dist(pos.x, pos.y, origin.x, origin.y); // distance from pos to origin (also = toOrigin.mag() ?)
  velocityLinear = vel.copy(); //cell has unique basic velocity component
  spiral = dna.genes[12] * 0.01; // Spiral screw amount
  vMax = dna.genes[15]; // Maximum magnitude in velocity components generated by noise
  step = dna.genes[16] * 0.001; //Step-size for noise
  noisePercent = dna.genes[17] * 0.01; // How much influence on velocity does Perlin noise have?
  xoff = dna.genes[18]; //Seed for noise
  yoff = dna.genes[19]; //Seed for noise

  // COLOUR
  fill_Hstart = dna.genes[0];
  fill_Sstart = dna.genes[1];
  fill_Bstart = dna.genes[2];
  fill_Astart = dna.genes[3];
  fill_Hend = dna.genes[20];
  fill_Send = dna.genes[21];
  fill_Bend = dna.genes[22];
  fill_Aend = dna.genes[23];
  //fill_H = fill_Hstart;
  //fill_S = fill_Sstart;
  //fill_B = fill_Bstart;
  //fill_A = fill_Astart;
  fillColor = color(fill_Hstart, fill_Sstart, fill_Bstart); // Initial color is set
  fillStart = color(dna.genes[0], dna.genes[1], dna.genes[2]);
  fillEnd = color(dna.genes[20], dna.genes[21], dna.genes[22]);

  stroke_Hstart = dna.genes[4];
  stroke_Sstart = dna.genes[5];
  stroke_Bstart = dna.genes[6];
  stroke_Astart = dna.genes[7];
  stroke_Hend = dna.genes[24];
  stroke_Send = dna.genes[25];
  stroke_Bend = dna.genes[26];
  stroke_Aend = dna.genes[27];
  //stroke_H = stroke_Hstart;
  //stroke_S = stroke_Sstart;
  //stroke_B = stroke_Bstart;
  //stroke_A = stroke_Astart;  
  strokeColor = color(stroke_Hstart, stroke_Sstart, stroke_Bstart); // Initial color is set 
  strokeStart = color(dna.genes[4], dna.genes[5], dna.genes[6]);
  strokeEnd = color(dna.genes[24], dna.genes[25], dna.genes[26]);
  
  // STRAIN ID
  strainID = int(dna.genes[28]);
  }

  void run() {
    live();
    updatePosition();
    updateSize();
    updateFertility();
    updateFillColor();
    updateStrokeColor();
    if (stripe) {updateStripes();}
    if (gs.wraparound) {checkBoundaryWraparound();}
    display();
    //displayRect();
    //displayText();
    if (gs.debug) {cellDebugger();}
  }

  void live() {
    age ++;
    //maturity = map(age, 0, lifespan, 1, 0);
    drawStep --;
    float drawStepStart = map(gs.stepSize, 0, 100, 0 , (r *2 + growth));
    if (drawStep < 0) {drawStep = drawStepStart;}
    drawStepN--;
    float drawStepNStart = map(gs.stepSizeN, 0, 100, 0 , r *2);
    if (drawStepN < 0) {drawStepN = drawStepNStart;} // Stripe follows Nucleus Step interval
    stripeStep--;
    float stripeStepStart = map(gs.stripeSize, 0, 100, 0, r*2);
    if (stripe) {stripeStepStart *= gs.stripeRatio;} else {stripeStepStart *= (1-gs.stripeRatio);}
    if (stripeStep < 0) {stripeStep = stripeStepStart; stripe = !stripe;}
  }

  void updatePosition() { //Update parameters linked to the position
    float vx = map(noise(xoff),0,1,-vMax,vMax);
    float vy = map(noise(yoff),0,1,-vMax,vMax);
    velocityNoise = new PVector(vx,vy);
    xoff += step;
    yoff += step;
    velocity = PVector.lerp(velocityLinear, velocityNoise, noisePercent); //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    float screwAngle = map(maturity, 0, 1, 0, spiral * TWO_PI);
    velocity.rotate(screwAngle);
    position.add(velocity);
    toHome = PVector.sub(home, position); // static vector pointing from cell to home
    range = toHome.mag(); // range is how far the cell is from home at any time
    remoteness = map(range, 0, lifespan, 0, 1); // remoteness is a value between 0-1.
    maturity = map(range, 0, lifespan, 1, 0); // remoteness is a value between 0-1.
    //maturity = map(age, 0, lifespan, 1, 0); // remoteness is a value between 0-1.
    
  }

  void updateSize() {
    // I should introduce an selector-toggle here!
    PVector center = new PVector(width/2, height/2);
    PVector distFromCenter = PVector.sub(center, position); // static vector to get distance between the cell & the center of the canvas
    float distMag = distFromCenter.mag();                         // calculate magnitude of the vector pointing to the center
    //stroke(0,255);
    //r = map(remoteness, 0, 1, cellStartSize, cellEndSize);
    r = map(age, 0, lifespan, cellStartSize, cellEndSize);
    //r = ((sin(map(distMag, 0, 500, 0, PI)))+0)*cellStartSize;
    //r = (((sin(map(remoteness, 0, 1, 0, PI*0.5)))+0)*cellStartSize) + cellEndSize;
    //r = (((sin(map(age, 0, lifespan, 0, PI)))+0)*cellStartSize) + cellEndSize;
    //r -= growth;
    size = map(r, cellStartSize, cellEndSize, 0, 1); // size indicates how large the cell is in proportion to it's limits
  }

  void updateFertility() {
    if (maturity <= fertility) {fertile = true; } else {fertile = false; }
    if (spawnCount == 0) {fertility = 0;} // Once spawnCount has counted down to zero, the cell will spawn no more
  }

  void updateFillColor() {
    // START > END
    float fill_H = map(r, cellStartSize, cellEndSize, fill_Hstart, fill_Hend) % 360;
    float fill_S = map(r, cellStartSize, cellEndSize, fill_Sstart, fill_Send);
    float fill_B = map(r, cellStartSize, cellEndSize, fill_Bstart, fill_Bend);
    fill_A = map(size, 0, 1, fill_Astart, fill_Aend);
    fillColor = color(fill_H, fill_S, fill_B); //fill colour is updated with new values
    //fillColor = lerpColor(fillStart, fillEnd, size); //fill colour is proportional to size
  }
  
  void updateStrokeColor() {
    // START > END
    float stroke_H = map(r, cellStartSize, cellEndSize, stroke_Hstart, stroke_Hend) % 360;
    float stroke_S = map(r, cellStartSize, cellEndSize, stroke_Sstart, stroke_Send);
    float stroke_B = map(r, cellStartSize, cellEndSize, stroke_Bstart, stroke_Bend);
    stroke_A = map(size, 0, 1, stroke_Astart, stroke_Aend);    
    strokeColor = color(stroke_H, stroke_S, stroke_B); //stroke colour is updated with new values
    //strokeColor = lerpColor(strokeStart, strokeEnd, size); //stroke colour is proportional to size
  }

  void updateStripes() {
    fillColor = color(34, 255, 255); // RED
    //fillColor = strokeColor; // RED
    //fillColor = color(0, 0, 0); // BLACK
    //strokeColor = color(0, 0, 0);  
  }

  void checkBoundaryWraparound() {
    if (position.x > width + r * flatness) {
      position.x = -r * flatness;
    }
    else if (position.x < -r * flatness) {
      position.x = width + r * flatness;
    }
    else if (position.y > height + r * flatness) {
      position.y = -r * flatness;
    }
    else if (position.y < -r * flatness) {
      position.y = height + r * flatness;
    }
  }

  // Death
  boolean dead() {
    //if (age >= lifespan) {return true;} // Death by old age (regardless of size, which may remain constant)
    if (r < cellEndSize) {return true;} // Death by too little radius
    //if (r > (width*0.1)) {return true;} // Death by too much radius
    if (spawnCount <= 0) {return true;} // Death by too much babies
    //if (position.x > width + r * flatness || position.x < -r * flatness || position.y > height + r * flatness || position.y < -r * flatness) {return true;} // Death if move beyond canvas boundary
    else { return false; }
    //return false; // Use to disable death
  }

  void display() {
    strokeWeight(1);
    if (gs.strokeDisable) {noStroke();} else {stroke(hue(strokeColor), saturation(strokeColor), brightness(strokeColor), stroke_A);}
    if (gs.fillDisable) {noFill();} else {fill(hue(fillColor), saturation(fillColor), brightness(fillColor), fill_A);}

    float angle = velocity.heading();
    pushMatrix();
    translate(position.x,position.y);
    rotate(angle);
    if (!gs.stepped) {
      ellipse(0, 0, r, r * flatness);
      if (gs.nucleus && drawStepN < 1) {
        if (fertile) {
        fill(gs.nucleusColorF); ellipse(0, 0, cellEndSize/2, cellEndSize/2 * flatness);
        popMatrix(); //A
        //line(position.x, position.y, home.x, home.y);
        }
        else {fill(gs.nucleusColorU); ellipse(0, 0, cellEndSize/2, cellEndSize/2 * flatness); popMatrix();} //B
      }
      else {popMatrix();} //C
    }
    else if (drawStep < 1) { // stepped=true, step-counter is active for cell, draw only when counter=0
      ellipse(0, 0, r, r*flatness);
      if (gs.nucleus && drawStepN < 1) { // Nucleus is always drawn when cell is drawn (no step-counter for nucleus)
        if (fertile) {
          fill(gs.nucleusColorF); ellipse(0, 0, cellEndSize/2, cellEndSize/2 * flatness);
          popMatrix(); //D
          //line(position.x, position.y, home.x, home.y);
        }
        else {fill(gs.nucleusColorU); ellipse(0, 0, cellEndSize/2, cellEndSize/2 * flatness); popMatrix();} //E
      }
      else {popMatrix();} //F
    }
   else {popMatrix();} //G
  }

void displayRect() {
    strokeWeight(3);
    if (gs.strokeDisable) {noStroke();} else {stroke(hue(strokeColor), saturation(strokeColor), brightness(strokeColor), stroke_A);}
    if (gs.fillDisable) {noFill();} else {fill(hue(fillColor), saturation(fillColor), brightness(fillColor), fill_A);}

    float angle = velocity.heading();
    pushMatrix();
    translate(position.x,position.y);
    rotate(angle);
    if (!gs.stepped) {
      rect(0, 0, r, r * flatness);
      if (gs.nucleus && drawStepN < 1) {
        if (fertile) {
        fill(gs.nucleusColorF); rect(0, 0, cellEndSize/2, cellEndSize/2 * flatness);
        popMatrix(); //A
        //line(position.x, position.y, home.x, home.y);
        }
        else {fill(gs.nucleusColorU); rect(0, 0, cellEndSize/2, cellEndSize/2 * flatness); popMatrix();} //B
      }
      else {popMatrix();} //C
    }
    else if (drawStep < 1) { // stepped=true, step-counter is active for cell, draw only when counter=0
      rect(0, 0, r, r*flatness);
      if (gs.nucleus && drawStepN < 1) { // Nucleus is always drawn when cell is drawn (no step-counter for nucleus)
        if (fertile) {
          fill(gs.nucleusColorF); rect(0, 0, cellEndSize/2, cellEndSize/2 * flatness);
          popMatrix(); //D
          //line(position.x, position.y, home.x, home.y);
        }
        else {fill(gs.nucleusColorU); rect(0, 0, cellEndSize/2, cellEndSize/2 * flatness); popMatrix();} //E
      }
      else {popMatrix();} //F
    }
   else {popMatrix();} //G
  }

void displayText() {
    textSize(r*0.5);
    strokeWeight(1);
    if (gs.strokeDisable) {noStroke();} else {stroke(hue(strokeColor), saturation(strokeColor), brightness(strokeColor), stroke_A);}
    if (gs.fillDisable) {noFill();} else {fill(hue(fillColor), saturation(fillColor), brightness(fillColor), fill_A);}

    float angle = velocity.heading();
    pushMatrix();
    translate(position.x,position.y);
    rotate(angle);
    String word = gs.words.get(strainID);
    text(word, 0, 0);
    
   popMatrix();
  }



  void checkCollision(Cell other) {       // Method receives a Cell object 'other' to get the required info about the collidee
      PVector distVect = PVector.sub(other.position, position); // Static vector to get distance between the cell & other
      //float distMag = distVect.mag();       // calculate magnitude of the vector separating the balls
      //if (distMag < (r + other.r)) { conception(other, distVect);} // Spawn a new cell
  }

  void conception(Cell other, PVector distVect) {
    // Decrease spawn counters.
    spawnCount --;
    other.spawnCount --; //<>//

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
    childDNA.genes[0] = hue(childFillColor); // Get the  lerped hue value and map it back to gene-range
    childDNA.genes[1] = saturation(childFillColor); // Get the  lerped hue value and map it back to gene-range
    childDNA.genes[2] = brightness(childFillColor); // Get the  lerped hue value and map it back to gene-range
    childDNA.genes[4] = hue(childStrokeColor); // Get the  lerped hue value and map it back to gene-range
    childDNA.genes[5] = saturation(childStrokeColor); // Get the  lerped hue value and map it back to gene-range
    childDNA.genes[6] = brightness(childStrokeColor); // Get the  lerped hue value and map it back to gene-range

    childDNA.genes[8] = (r + other.r) / 2; // Child cellStartSize is set at average of parents current radii

    colony.spawn(position, spawnVel, childDNA);

    //Reduce fertility for parent cells by squaring them
    fertility *= fertility;
    fertile = false;
    other.fertility *= other.fertility;
    other.fertile = false;
  }

  void cellDebugger() { // For debug only
    int rowHeight = 15;
    fill(120, 0, 255);
    textSize(rowHeight);
    //text("r:" + r, position.x, position.y + rowHeight * 0);
    //text("pos:" + position.x + "," + position.y, position.x, position.y + rowHeight * 0);
    //text("stripeStep:" + stripeStep, position.x, position.y + rowHeight * 8);
    //text("Stripe:" + stripe, position.x, position.y + rowHeight * 0);
    text("hue " + hue(fillColor), position.x, position.y + rowHeight * 1);
    //text("sat " + saturation(fillColor), position.x, position.y + rowHeight * 2);
    //text("bri " + brightness(fillColor), position.x, position.y + rowHeight * 3);
    //text("range:" + range, position.x, position.y + rowHeight * 0);
    //text("dna.genes[10]:" + dna.genes[10], position.x, position.y + rowHeight * 6);
    //text("dna.genes[12]:" + dna.genes[12], position.x, position.y + rowHeight * 7);
    text("fill_Hstart:" + fill_Hstart, position.x, position.y + rowHeight * 3);
    text("fill_Hend:" + fill_Hend, position.x, position.y + rowHeight * 4);
    //text("cellStartSize:" + cellStartSize, position.x, position.y + rowHeight * 1);
    //text("cellEndSize:" + cellEndSize, position.x, position.y + rowHeight * 2);
    text("fill_H:" + hue(fillColor), position.x, position.y + rowHeight * 2);
    //text("fill_S:" + fill_S, position.x, position.y + rowHeight * 5);
    //text("fill_B:" + fill_B, position.x, position.y + rowHeight * 4);
    //text("growth:" + growth, position.x, position.y + rowHeight * 3);
    //text("age:" + age, position.x, position.y + rowHeight * 0);
    //text("maturity:" + maturity, position.x, position.y + rowHeight * 4);
    //text("fertile:" + fertile, position.x, position.y + rowHeight * 0);
    //text("fertility:" + fertility, position.x, position.y + rowHeight * 1);
    //text("spawnCount:" + spawnCount, position.x, position.y + rowHeight * 2);
    //text("x-velocity:" + velocity.x, position.x, position.y + rowHeight * 0);
    //text("y-velocity:" + velocity.y, position.x, position.y + rowHeight * 0);
    //text("velocity heading:" + velocity.heading(), position.x, position.y + rowHeight * 0);
  }

}