class Vibration
{
  PVector location;
  PVector noff;
  float mass;

  Vibration(float x, float y, float m)
  {
    location = new PVector(x, y);
    mass = m;
    noff = new PVector(random(1000), random(1000));
  }

  void render(color c)
  {
    pushMatrix();
    stroke(0);
    fill(c);
    ellipse(location.x, location.y, 2*mass, 2*mass);
    popMatrix();
  }

  // Randomly move up, down, left, right, or stay in one place i.e. Vibrate
  void vibrate()
  {
    float vx = random(-2, 2);
    float vy = random(-2, 2);
    location.x += vx;
    location.y += vy;

    // Stay on the screen
    location.x = constrain(location.x, 0, width - 1);
    location.y = constrain(location.y, 0, height - 1);
  }
  
  void noiseWalk()
  {
    location.x = map(noise(noff.x), 0, 1, 0, width);
    location.y = map(noise(noff.y), 0, 1, 0, height);
    noff.add(0.01, 0.01, 0);
  }
  
  void levyWalk()
  { 
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);
    
    float stepsize = montecarlo()*50;
    stepx *= stepsize;
    stepy *= stepsize;
    
    location.x += stepx;
    location.y += stepy;
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
  }
  
  void transport()
  { 
    float stepsize;
    float stepx = random(-1, 1);
    float stepy = random(-1, 1);    
    
    if(randomGaussian() > 2.5)
      stepsize = 300;
    else
      stepsize = 1;
      
    stepx *= stepsize;
    stepy *= stepsize;
    
    location.x += stepx;
    location.y += stepy;
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
  }
  
  float montecarlo()
  {
    while (true)
    {
      float r1 = random(1);  
      float probability = pow(1.0 - r1, 8);  
  
      float r2 = random(1);  
      if (r2 < probability)  
        return r1;
    }
  }
}