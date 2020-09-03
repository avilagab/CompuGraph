//CIRCULO DE RADIO 50 CON CENTRO EN 50,50
void setup(){
  float x, y, r=50;
  int centroX = 50, centroY = 50;
  for(int i=0; i<360; i++){
    x = r*cos( radians( i ) );
    y = r*sin( radians( i ) );
    point(x+centroX,y+centroY);
  }
}
