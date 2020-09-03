void setup(){
  size(640, 480);
  point(20, 60);
  line(0,10,50,100);
  quad(50,80,250,100,300,300,100,300);
  fill(50, 50);
  triangle(50,50,100,100,0,100);
  stroke(150);
  rect(350, 100, 50, 10);
  ellipse(350, 350, 20, 50);
  
  Circulo c = new Circulo(width/2,height/2,width/4);
  c.dibujar();
}
