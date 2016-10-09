import g4p_controls.*;

double k; //electrostatic constant
double eMinus = -1.6*Math.pow(10, -19); //electron charge
double eMass = 9.11*Math.pow(10, -31); //mass of electron
double miu0; //magnetic permiability of free space
int scalingConstant;
double timeScale;
double spaceScale;
double time;

DVect center;
Particle electron;
Magnet guideCoil;
Dplate plates;

double[] property = {17000000d, eMinus, eMass}; //voltage charge mass



void setup(){
  size(900, 700);
  k = 9*pow(10, 9);
  center = new DVect(3, 35/6);
  spaceScale = 60; //60 pixles/meter, based on the radius of D plates being 5 meters(300pixles)
  inject(property[0], property[1], property[2]);
  consolSetup();
}

double pMag = 0;
double error = 0;
void draw() {
  
  if(electron.p.dist(center)<5.05){
    background(#ffffff);
  ellipseMode(CENTER);
  plates.draw();
  electron.move();
  time += timeScale;
  displayConsol();
  }
  //println(mouseX +", "+mouseY);
}


void inject(double voltage, double charge, double mass){
  time = 0;
  electron = new Particle(charge, mass, new DVect(0,-10), new DVect(center.x+0.1, center.y+0.1));
  //B=vm/rq with initial orbit 10^-5, v = sqrt(2qV/m)
  guideCoil = new Magnet(Math.sqrt(2*voltage*mass/Math.abs(charge))/Math.pow(10, -1));
  double period = 2*PI*mass/(Math.abs(charge)*guideCoil.B); //period = 2*PI*m/(q*B)
  timeScale = period*0.01;
  //V = 0.5*m*v^2*(% increase^2-1)/q
  plates = new Dplate(voltage, 0.2, period, time);
}

void keyPressed(){
  if(keyCode == ENTER){
    inject(property[0], property[1], property[2]);
  }
}
