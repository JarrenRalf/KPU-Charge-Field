class Electron
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float charge;
  float mass;

  Electron(PVector l)
  {
    location = l.copy();
    velocity = new PVector(1, 0);
    //velocity = new PVector(1, random(-0.5, 0.5));
    acceleration = new PVector(0.5, 0);
    mass = 10;
    charge = 10;
  }

  void run(color c)
  {
    update();
    display(c);
  }

  void applyForce(PVector force)
  {
    PVector f = force.copy();
    f.div(mass);   
    acceleration.add(f);
  }

  // Method to update location and velocity
  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display(color c)
  {
    pushMatrix();
    stroke(255);
    strokeWeight(2);
    fill(c);
    ellipse(location.x, location.y, mass, mass);
    popMatrix();
  }

  boolean isDead()
  {
    // Off screen
    if (location.x > width + mass || location.y < 0 || location.y > height + mass) 
      return true;
    else
      return false;
  }
}