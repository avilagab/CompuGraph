/*
Información tomada de:
https://www.youtube.com/watch?v=jQvRA-GiwwA
https://www.youtube.com/watch?v=Sgql6bvOjSE&t=387s
*/




int lineas = 5;
int dentro=0, izquierda=1, derecha=2, abajo=4, arriba=8;
int x_max=450, y_max=400, x_min=150, y_min=200;

int findCode(double x, double y) {
  int code = dentro;

  if (x < x_min){
    code = code|izquierda;}
  else if (x > x_max){
    code = code|derecha;}
    
  if (y < y_min){
    code = code|arriba;}
  else if (y > y_max){
    code = code|abajo;}

  return code;
}

void line_clipping(double x1, double y1, double x2, double y2) {
  
 
  int code1 = findCode(x1, y1);
  int code2 = findCode(x2, y2);

  print(x1 + " " + y1 + " ");
  println(code1);
  print(x2 + " " + y2 + " ");
  println(code2);
  
  boolean isLine = false;

  while (true) {
    if ((code1==0) && (code2==0)) {
      isLine=true;
      break;
    } else if ((code1 & code2)!=0) {
      break;
    } else {
      int resultado;
      double x=0, y=0;

      if (code1!=0)
        resultado = code1;
      else
        resultado = code2;

      if ((resultado & abajo)!=0)
      {
        x = x1 + (x2 - x1) * (y_max - y1) / (y2 - y1); 
        y = y_max;
      } 
      else if ((resultado & arriba)!=0) 
      {  
        x = x1 + (x2 - x1) * (y_min - y1) / (y2 - y1); 
        y = y_min;
      } 
      else if ((resultado & derecha)!=0) 
      {  
        y = y1 + (y2 - y1) * (x_max - x1) / (x2 - x1); 
        x = x_max;
      }
      else if ((resultado & izquierda)!=0) 
      {  
        y = y1 + (y2 - y1) * (x_min - x1) / (x2 - x1); 
        x = x_min;
      }

      if (resultado==code1) {
        x1 = x;
        y1 = y;
        code1 = findCode(x1, y1);
      } else {
        x2 = x;
        y2 = y;
        code2 = findCode(x2, y2);
      }
    }
  }
  if(isLine==true){
    stroke(255, 0, 0);
    strokeWeight(2);
    stroke(255, 0, 0);
    line((float)x1, (float)y1, (float)x2, (float)y2);
  }
}

  void setup() {

    size(600, 600);
  }
  
void draw(){
  
    frameRate(1);
    background(51);
    strokeWeight(2);
    stroke(255);
    rectMode(CENTER);
    noFill();
    rect(width/2, height/2, 300, 200);

    strokeWeight(0.3);
 
    for (int i=0; i<lineas; i++) {
      int x1 = int(random(0, width));
      int y1 = int(random(0, width));
      int x2 = int(random(0, height));
      int y2 = int(random(0, height));

      strokeWeight(0);
      stroke(255);
      line(x1, y1, x2, y2);
      line_clipping(x1, y1, x2, y2);
    }

}  
