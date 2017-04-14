class Genepool {

/* The Genepool class creates and manages an ArrayList for all the DNA available to the Colony
*  The genepool consists of:
*  1) A fixed number of predefined genotypes (DNA objects), stored in /data/genepool.csv
*  2) A configurable number of genotypes, created by iteratively applying the DNA constructor
*  3) Any new genotypes that might arise during the lifetime of a colony
*
*  TO DO:
*  A) Iterate through the following for all the rows in /data/genepool.csv:
*    a) Fill an array with the data from one row in the table <DONE>
*    b) Create a new DNA object using this array <DONE>
*    c) Add this DNA object to the Genepool arraylist <DONE>
*
*  B) Add new DNA to the table in csv format. CONSIDER CHANGING THIS TO A SEPERATE "OUTPUT" FILE?
*    1) Get the first 'added-later' DNA from the genepool arraylist
*    2) Append a new row to the end of the table
*    3) Fill the new row with the data the genes array in the DNA object
*/

  // VARIABLES
  ArrayList<DNA> genepool;  // An arraylist for all the strains of dna
  Table genetable; // A table of gene data
  
  // CONSTRUCTOR: Create a 'Colony' object containing a genepool and an initial population of cells
  Genepool() {
    genepool = new ArrayList<DNA>();
    
    Table genetable = loadTable("genepool.csv", "header");
    
    for (TableRow row : genetable.rows()) {
      float[] newgenes = new float[genetable.getColumnCount()];
      // Iterate through all the columns, getting each value and add it to newgenes[]
      for(int col = 0; col < genetable.getColumnCount(); col++) {  
        float value = row.getFloat(col);
        newgenes[col] = value; //Add the value pulled from the table to it's respective position in the array
      }
      
      // This code is needed to inject some random into specific genes in the DNA stored in genepool.csv
      newgenes[17]= 500/gs.rows;
      newgenes[25]= random(2, 4);   // 25=noise_vMax
      newgenes[26]= random(1, 6);   // 26=noise_tep
      newgenes[27]= random(1000);   // 27=noise_xOff
      newgenes[28]= random(1000);   // 28=noise_yOff
      newgenes[31]= random(100, 200);   // 31=lifespan

      // Add a new DNA object to the genepool using the array newgenes[] with data from .csv row
      genepool.add(new DNA(newgenes));
      
    }
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      DNA newDNA = new DNA(); // Create a new DNA object from the constructor template (id gene[0] will always be =0)
      TableRow newRow = genetable.addRow();
      int rows = genetable.getRowCount()-1;
      newDNA.genes[0] = rows; // Set id gene[0] to a value equal to the number of the new row (subtracting 1 for the header)
      newRow.setFloat(0, rows); // Add id to the first column
      // Iterate through the remaining rows of the table, starting at column 1
      for (int i = 1; i < newDNA.genes.length; i++) {
        float value = newDNA.genes[i];
        newRow.setFloat(i, value);
      }
      genepool.add(newDNA); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
    String newFileName = pathName + "/csv/" + batchName + "-" + iterationNum +".genepool.csv";
    saveTable(genetable, newFileName);
    
    if (gs.debug) {
      for (int i = 0; i < genepool.size(); i++) {
        DNA debugDNA = genepool.get(i); //get the DNA that you just put in back out again
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[0]);
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[17]);
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[25]);
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[26]);
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[27]);
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[28]);
      }
    }
    
    
    
    
  }

}