class Dplate {
  double Vmag; //potential diffarence, positive when field is left to right
  double d; //distance in between(the gap)
  double T; //period of square wave
  double lastCycle; //time of the biggining of this cycle
  Dplate(double Vmag, double d, double T, double time){
    this.Vmag = Vmag;
    this.d = d;
    this.T = T;
    lastCycle = time;
  }
  
  DVect force(DVect p, double charge, double time){
    if(p.x > center.x-0.1 && p.x < center.x+0.1 && p.y > center.y-5 && p.y < center.y+5){
      DVect Fe = new DVect(1,0);//standard field direction with positive voltage
      Fe.mult(V(time)); //voltage
      Fe.mult(-charge); //charge
      Fe.div(d);
      return Fe;
    }else{return new DVect(0,0);}
  }
  
  double V(double time){
    if(time - lastCycle < T/2){ //first half of cycle
      return Vmag;
    } else if(time-lastCycle < T){ //reached end of cycle
      return -Vmag;
    } else{  //new cycle
      lastCycle = time; 
      return Vmag;
    }
  }
  
  void draw(){
    line(260, 400, 260, 550); //right plate line
    noFill();
    beginShape(); //left plate line
    vertex(100, 400);
    vertex(100, 670);
    vertex(260, 670);
    vertex(260, 650);
    endShape();
    textSize(10);
    fill(#000000);
    text((float)Math.abs(plates.Vmag)+" V", 102, 550);
    text(-(float)Math.abs(plates.Vmag)+" V", 102, 650);
    if(V(time) > 0){
      fill(#7191FF);//blue, -
    }else{fill(#F24043);}//red, +
    arc((float)((center.x-0.1) *spaceScale), (float)(center.y *spaceScale), 300, 300, PI/2, 3*PI/2, CHORD);//left plate
    if(V(time) < 0){
      fill(#7191FF);//blue, -
    }else{fill(#F24043);}  //red, +
    arc((float)((0.1+center.x) *spaceScale), (float)(center.y *spaceScale), 300, 300, -PI/2, PI/2, CHORD); //right plate
    fill(#985A26);
    ellipse((float)((center.x+0.1) *spaceScale), (float)((center.y+0.1) *spaceScale), 2, 5); //injector
    squareWave();
  }
  
  void squareWave(){
    int i = 0;
    int sign = (int)Math.signum(V(time)); //gets current voltage sign
    float t = (float)time;
    float halfT = (float)lastCycle;
    float x = 210;
    float px = x;
    
    int y = sign*45+600; //first 50% wave, cuttoff
    if(t-halfT <= T/2){
      x += (float)(((halfT+(T/2)-t)*100/T));
    } else {
      x += (float)(((halfT+T-t)*100/T));
    }
    line(px, y, x, y);
    line(x, 555, x, 645);  
      
    while(i < 11){ //all the other waves
      sign *= -1; //flip voltage
      y = sign*45+600;
      px = x;
      x += 50;
      line(px, y, x, y);
      line(x, 555, x, 645);
      i++;
    }
    
    sign *= -1;
    y = sign*45+600; //last 50% wave cuttoff
    px = x;
    line(x, y, 810, y);
    
  }
}
