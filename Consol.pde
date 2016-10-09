import java.text.*;
double c = 299792458;
double ev = 1.602*Math.pow(10, -19);
double frequency;

PVector loc;

void consolSetup(){
  frequency = 1/plates.T;
}
  
  
void displayConsol(){
  loc = new PVector(500, 50);
  fill(#000000);
  textAlign(LEFT, CENTER);
  
  //particle data
  textSize(20);
  text("Particle", loc.x, loc.y);
  textSize(12);
  text("Charge: "+(float)electron.charge+" C", loc.x+20, loc.y+20);
  text("Mass: "+(float)electron.mass+" kg", loc.x+20, loc.y+40);
  double KE = 0.5*electron.mass*Math.pow(electron.v.mag(),2);
  text("KE: "+new DecimalFormat("0.00E0").format(KE)+" J", loc.x+20, loc.y+60);
  text("speed: " +(int)(electron.v.mag()/c)+" c", loc.x+20, loc.y+80);
  loc.y+= 100;
  textSize(15);
  text("Relativistic", loc.x+10, loc.y);
  textSize(12);
  //work sort of and add the initial KE
  double work = (0.5*electron.mass*100)+Math.abs(electron.charge)*Math.abs(plates.Vmag)*2*time/plates.T; //w=qE2c c is revolutions, time/period
  text("KE: "+new DecimalFormat("0.00E0").format(work)+" J", loc.x+20, loc.y+20);
  text("KE: "+new DecimalFormat("0.00E0").format(work/ev)+" eV", loc.x+20, loc.y+40);
  text("mass: "+new DecimalFormat("0.00E0").format((work+(electron.mass*c*c))/(c*c))+" kg", loc.x+20, loc.y+60);
  float relVel = (float)Math.sqrt(c*c*(1-Math.pow(1/(1+(work/(electron.mass*c*c))), 2)));
  text("speed: "+relVel/c+" c", loc.x+20, loc.y+80);
  
  loc.y += 120;
  textSize(20);
  text("Magnetic field", loc.x, loc.y);
  textSize(12);
  text("Magnetic field strength: "+(float)guideCoil.B+" A/m", loc.x+20, loc.y+20);
  text("Current: "+guideCoil.current+" A", loc.x+20, loc.y+40);
  text("Voltage: "+guideCoil.voltage+" V", loc.x+20, loc.y+60);
  
  loc.y += 100;
  textSize(20);
  text("Dees", loc.x, loc.y);
  textSize(12);
  text("Frequency: "+(float)frequency+" Hz", loc.x+20, loc.y+20);
  text("Period: "+(float)plates.T+" s", loc.x+20, loc.y+40);
  text("Voltage: "+Math.abs(plates.Vmag)+" V", loc.x+20, loc.y+60);
  text("distance: "+(float)plates.d+" m", loc.x+20, loc.y+80);
  
  loc.y += 120;
  textSize(20);
  text("Time elapsed since injection", loc.x, loc.y);
  textSize(12);
  text(new DecimalFormat("0.00E0").format(time) + "s", loc.x+20, loc.y+20);
  
}


