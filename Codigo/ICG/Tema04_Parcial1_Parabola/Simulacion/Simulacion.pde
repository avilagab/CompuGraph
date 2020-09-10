/// Daniel Sanabria - 6000420

void setup(){
  
  size(1280,720);
  line(0,height/2,width,height/2);
  line(100,0,100,height);
  Parabola p = new Parabola(100,45,100,height/2);
  
  p.dibujar(width);
}
