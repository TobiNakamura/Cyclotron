class Magnet {
  float coreLength = 2; //total length of core, top and bottom magnet
  float p = 1.68*pow(10, -8); //ohms per meter at 20 deg celcius, resistivity of copper
  float gap = 0.03; //three cm gap between magnets, 5mm vaccume, 1 cm top and bottom Dee, 2.5mm top and bottom gap between dee and magnet
  float wireGage = 0.000004; //probubly thinnest wire
  float permZero = 4*PI*pow(10,-7); //magnetic permiability of space
  float perm; //magnetic permiability at field strength B
  float current;
  float voltage;
  
  double B; //magnetic field strength
  double I; //current 
  
  Magnet (double B){
    this.B = B;
    perm = (float)B/0.25; //0.25 magnetic permiability of iron 99.9%
    current = (float)(((coreLength/perm)+(gap/permZero))*B*wireGage/coreLength);
    
    float wireLength = 2*PI*2.5*coreLength/wireGage; //number of layers * circumfarence
    voltage = current*p*wireLength/pow(wireGage,2);
  }
  
  //cross product of magnetic field coming out of the page and the electric field of the particle
  DVect force(DVect p, DVect v, double charge){
    if(p.dist(center) < 2.5){ //2.5 is the radius of the cyclotron
      DVect F = new DVect(-1*v.y*Math.signum(charge), v.x*Math.signum(charge)); //dot product, cus 90 degrees
      F.norm();
      F.mult(charge*v.mag()*B); //F = qvB
      return F;
    }else{return new DVect(0,0);}
  }
  
}
