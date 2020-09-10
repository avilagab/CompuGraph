Linea miLinea;
Vector2 temp;

void setup(){
  size(500, 500);
  background(255);
  temp = new Vector2(width, height);
  miLinea = new Linea(0, 0, temp.getX(), temp.getY());
  miLinea.setType(1);
  miLinea.setWeight(20);
  println(miLinea.length());
  println(miLinea.getSlope());
}

void draw(){
  background(255);
  temp.setVector2(mouseX, mouseY);
  miLinea.setEnd(temp);
  miLinea.dibujar();

}

void mouseClicked(){
  Vector2 temp2 = new Vector2(mouseX, mouseY);
  miLinea.setStart(temp2);
  //miLinea.setWeight(miLinea.getWeight()+1);
  println(miLinea.getStart().getX(), miLinea.getStart().getY(), miLinea.getEnd().getX(), miLinea.getEnd().getY() );
}
