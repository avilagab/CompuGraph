/// Daniel Sanabria - 6000420

class Parabola{
  
  float y;
  float x;
  float velocidadInicial;
  float angulo;
  
  Parabola(float _velocidad, float _angulo, float _x, float _y){
    velocidadInicial = _velocidad;
    angulo = _angulo;
    x = _x;
    y = _y;
  }
  
  public void dibujar (float wid){
    for(int t = 0; t <= wid; t++){
      float xt = x + ( velocidadInicial * cos(radians(angulo)) * t);
      float yt = y - (velocidadInicial* t * sin(radians(angulo)) + ((-9.8 * pow(t,2)/2)));
      
      ellipse(xt,yt,10,10);
    } 
  }
  
}
