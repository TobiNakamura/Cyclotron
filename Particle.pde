class Particle{
  DVect v;
  DVect p;
  DVect a;
  double charge;
  double mass;
  ArrayList<PVector> pastPoints = new ArrayList<PVector>();
  
  Particle(double chg, double m, DVect v, DVect p){
    this.v = v;
    this.p = p;
    this.a = new DVect(0,0);
    charge = chg;
    mass = m;
    pastPoints.add(new PVector((float)p.x, (float)p.y));
  }
  
  void move(){
      DVect midP = new DVect(v);
      midP.mult(timeScale/2);
      DVect midV = new DVect(a);
      midV.mult(timeScale/2);
      DVect F = guideCoil.force(midP.add(p), midV.add(v), charge);
      F = F.add(plates.force(midP.add(p), charge, time));
      a = new DVect(F);
      a.div(mass);
      a.mult(timeScale);
      v = v.add(a);
      DVect deltaP = new DVect(v);
      deltaP.mult(timeScale);
      p = p.add(deltaP);
      pastPoints.add(new PVector((float)p.x, (float)p.y));
      path();
      fill(#FFF300);
      ellipse((float)(electron.p.x * spaceScale), (float)(electron.p.y *spaceScale), 2, 2);
  }
  
  void path(){
    noFill();
    beginShape();
    int i = 0;
    while(i < pastPoints.size()-1){
      PVector point = pastPoints.get(i);
      vertex((float)(point.x*spaceScale), (float)(point.y*spaceScale));
      i++;
    }
    endShape();
  }
}
