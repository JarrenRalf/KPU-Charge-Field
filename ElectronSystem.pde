class ElectronSystem
{
  ArrayList<Electron> electrons;
  PVector origin;

  ElectronSystem(PVector location)
  {
    origin = location.copy();
    electrons = new ArrayList<Electron>();
  }

  void addElectron()
  {
    electrons.add(new Electron(origin));
  }

  // A function to apply a force to all Particles
  void applyForce(PVector f)
  {
    for (Electron e: electrons)
      e.applyForce(f);
  }

  // Apply repeller
  void applyRepeller(Anion a)
  {
    for (Electron e: electrons)
    {
      PVector force = a.repel(e);        
      e.applyForce(force);
    }
  }
  
  // Apply attractor
  void applyAttractor(Cation c)
  {
    for (Electron e: electrons)
    {
      PVector force = c.attract(e);        
      e.applyForce(force);
    }
  }

  void run(color c)
  {
    for(int i = electrons.size() - 1; i >= 0; i--)
    {
      Electron e = electrons.get(i);
      e.run(c);
      if (e.isDead())
        electrons.remove(i);
    }
  }
}