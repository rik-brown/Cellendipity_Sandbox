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
      for( int col = 0; col < genetable.getColumnCount(); col++) {  
        float value = row.getFloat(col);
        newgenes[col] = value; //Add the value pulled from the table to it's respective position in the array
      }

      // Add a new DNA object to the genepool using the array newgenes[] with data from .csv row
      genepool.add(new DNA(newgenes));
      
    }
    
    // Here is the code which fills the 'genepool' arraylist with a given number (gs.numStrains) of different DNA-strains.
    for (int g = 0; g < gs.numStrains; g++) {
      genepool.add(new DNA()); // Add new DNA object to the genepool. numStrains = nr. of unique genomes
    }
    
    if (gs.debug) {
      for (int i = 0; i < genepool.size(); i++) {
        DNA debugDNA = genepool.get(i); //get the DNA that you just put in back out again
        println("Genepool entry " + i + ": contains ID value" + debugDNA.genes[0]);
      }
    }
    
    
    
    
  }

}