class DVect {
  double x,y;
  DVect(double x, double y){
    this.x = x;
    this.y = y;
  }
  
  DVect(DVect value){
    this.x = value.x;
    this.y = value.y;
  }
  
  DVect(){
    x=0;
    y=0;
  }
  
  void mult(double value){
    x *= value;
    y *= value;
  }
  
  void div(double value){
    x /= value;
    y /= value;
  }
  
  void norm(){
    double scale = mag();
    x /= scale;
    y /= scale;
  }
  
  void rotate(double theta){
     double px, py;
     px = x;
     py = y;
     x = px * Math.cos(theta) - py * Math.sin(theta);
     y = px * Math.sin(theta) + py * Math.cos(theta);
  }
  
  double mag(){
    return Math.sqrt((x*x)+(y*y));
  }
  
  double dist(DVect value){
    DVect r = new DVect(this);
    r = r.sub(value);
    return r.mag();
  }
  
  DVect add(DVect vect){
    return new DVect(x + vect.x, y + vect.y);
  }
  
  DVect sub(DVect vect){
    return new DVect(x - vect.x, y - vect.y);
  }
  
  void print(){
    println("[" + x + " , " + y + "]");
  }
}
