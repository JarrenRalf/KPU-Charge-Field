class Anion extends Vibration
{
  final float K;
  PVector location;
  float charge;
  float distance;
  float forceMag;

  Anion(float x, float y, float mass, float k)
  {
    super(x, y, mass);
    location = new PVector(x, y);
    K = k;
    charge = mass; // Our assumption is that the charge and mass are equal
  }
  
  // Calculate a force to push particle away from repeller
  PVector repel(Electron e)
  {
    PVector force = PVector.sub(location, e.location);
    float d = force.mag();
    distance = d;
    force.normalize(); 
    d = constrain(d, 5.0, width); 
    float strength = -1 * (K * charge * e.charge) / (d * d);
    force.mult(strength);
    forceMag = force.mag();
    return force;
  }
}