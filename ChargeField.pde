ArrayList<ElectronSystem> systems;
//ArrayList<Electron> electrons;

// Choose the number of Cations and Anions
int numCat = 100;
int numAn = 100;

// Array of Anion and Cation objects
Anion[] anions;
Cation[] cations;

// Coulomb's Constant
final float K = 10; 

// Will store the x postion, y postion, and mass of atom
float[][] ionArray = new float[numCat + numAn][3];

// Colour Anion and Cation, respectively
color blue = color(0, 0, 255);
color yellow = color(229, 170, 61);

PrintWriter printWriter;
int firstTime = 1; // So the headings are only repeated once

void setup()
{
  fullScreen();
  
  printWriter = createWriter("OhmsLaw.csv");
  
  cursor(CROSS);
  
  // Initial arrays
  anions = new Anion[numAn];
  cations = new Cation[numCat];
  
  // Initialize array lists
  systems = new ArrayList<ElectronSystem>();
  //electrons = new ArrayList<Electron>();
  
  // Fill ionArray with a random x,y position and mass
  for (int i = 0; i < (numCat + numAn); i++)
  {
    for(int j= 0; j < 3; j++)
    {
      if(j == 0)
        ionArray[i][j] = random(width/4, 3*width/4);   // x-position
      else if(j == 1)
        ionArray[i][j] = random(height/4, 3*height/4); // y-position
      else
        ionArray[i][j] = random(10, 40); // mass
    }
  }
  
  // Assign the randomly determined x,y positions and mass to each anion/cation object
  for (int k = 0; k < (numCat + numAn); k++)
  {
    if(k < numAn)
      anions[k] = new Anion(ionArray[k][0], ionArray[k][1], ionArray[k][2], K);
    else
            //k - numAn will equal 0
      cations[k - numAn] = new Cation(ionArray[k][0], ionArray[k][1], ionArray[k][2], K);
  }
}

void draw()
{
  background(0);
  
  // Determining the random colour of elecrons
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);
  color randomColor = color(r, g, b);
  
  // Place the anions and initialize their vibration
  for (Anion an : anions)
  {
    an.vibrate();
    an.render(blue);
  }
  
  // Place the cations and initialize their vibration
  for (Cation cat : cations)
  {
    cat.vibrate();
    cat.render(yellow);
  }
  
  // For each electron system, run the system and apply repellers and attractors
  for(ElectronSystem es : systems)
  {
    es.run(randomColor);
    es.addElectron();
    for (Anion an : anions)
      es.applyRepeller(an);
    for (Cation cat : cations)
      es.applyAttractor(cat);
  }


    // Retrieve Data
    for (int i = 0; i < min(numAn, numCat); i++)
    {
      if (firstTime == 1) // Print headings only the first time
      {
        printWriter.append("Cation");
        printWriter.append(",");
        printWriter.append(",");
        printWriter.append("Anion");
        printWriter.println();
        printWriter.append("Distance");
        printWriter.append(",");
        printWriter.append("Force");
        printWriter.append(",");
        printWriter.append("Distance");
        printWriter.append(",");
        printWriter.append("Force");
        printWriter.println();
        firstTime++;
      }
      // Eliminate rows of zeros
      if (anions[i].distance != 0 && anions[i].forceMag != 0
      && cations[i].distance != 0 && cations[i].forceMag != 0)
      {
        printWriter.append(Float.toString(anions[i].distance));
        printWriter.append(",");
        printWriter.append(Float.toString(anions[i].forceMag));
        printWriter.append(",");
        printWriter.append(Float.toString(cations[i].distance));
        printWriter.append(",");
        printWriter.append(Float.toString(cations[i].forceMag));
        printWriter.println();
      }
    }
}

void mousePressed() 
{
  systems.add(new ElectronSystem(new PVector(mouseX, mouseY)));
}

void keyPressed() 
{ 
  if (key == 'n' || key == 'N')
  {
    for (Anion an : anions)
      an.noiseWalk();
    for (Cation cat : cations)
      cat.noiseWalk();
  }
  else if (key == 'l' || key == 'L')
  {
    for (Anion an : anions)
      an.levyWalk();
    for (Cation cat : cations)
      cat.levyWalk();
  }
  else if (key == 't' || key == 'T')
  {
    for (Anion an : anions)
      an.transport();
    for (Cation cat : cations)
      cat.transport();
  }
  else if (key == BACKSPACE)
  {
    background(0);
    systems.clear();
      //for(int i = 0; i < systems.size(); i++)
        //systems.remove(i);
  }
  else if (key == 's' || key == 'S')
  {
    printWriter.flush(); // Writes the remaining data to the file
    printWriter.close(); // Finishes the file
    exit(); // Stops the program
  }
  else
  {
    for(int j = 20; j < height; j += 50)
       systems.add(new ElectronSystem(new PVector(0, j)));
  }
}