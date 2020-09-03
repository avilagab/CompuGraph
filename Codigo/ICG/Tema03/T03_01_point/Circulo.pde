class Circulo{
  float cX;
  float cY;
  float rX;
  float rY;
  
  Circulo(float x, float y, float r){
    cX = x; 
    cY = y; 
    rX = rY = r;
  }
  
  void dibujar(){
    strokeWeight(10);
    for(int i=0; i<360; i++){
      point(cX+rX*cos(radians(i)), cY+rY*sin(radians(i)));
    }
    strokeWeight(1);
  }
}
