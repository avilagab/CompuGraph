//Para cambiar el numero de lados del poligono use las teclas '+' y '-'
//Mantenga precionadas las teclas indicadas en el menu para dibujar cada figura
/*
Programa hecho por:
Jaime Alejandro Acero Vargas 6000374
Laura Sofia Medrano Ortiz 6000385
Laura Vanessa Ramos Castro 6000357
*/
PImage Lienzo;
PImage Menu;
PImage NoMenu;
PImage T;
PImage Color;
int poligon=3;
int grosor=1;
int aux=0;
int inicio=0;
int xo=-2000,yo=-2000,xf,yf,cy,cx,radio;
int auxX, auxY;
int EstadoSeleccion = 0;
void setup(){
  frameRate(60);
size(900,900);
background(255);
rect(0,0,900,100);
Menu = loadImage("menuphoto.png");
NoMenu = loadImage("nomenu.png");

}

void draw(){
 
 
  background(255);  //refresca la pantalla
  if(aux!=0){
  updatePixels();}
  //pone los pixeles en la pantalla
  noFill();
  image(Menu,0,0);
  textSize(32);
  text(grosor, 850, 95);
      textSize(15);
  text("# de lados= "+poligon, 530, 95);
  if(mouseY>150){  
  if(keyPressed){
    if(key == 't'){
  line(xo, yo, xf, yf);
  T = loadImage("t.png");
  image(T,0,0);}
  else
    if(key =='r'){
     rectMode(CORNER);
  T = loadImage("r.png");
  image(T,0,0);
  rect(xo, yo, xf-xo, yf-yo);}
  
  else
    if(key =='e'){
  T = loadImage("e.png");
  image(T,0,0);
  ellipseMode(CORNER);
  ellipse(xo, yo, xf-xo, yf-yo);}
  
    else
    if(key =='d'){;
      T = loadImage("d.png");
  image(T,0,0);
  point(xo, yo);}
  
      else
    if(key =='f'){;
      T = loadImage("f.png");
  image(T,0,0);
  triangle(xo,yo,xf,yf,xf,yo);}
       
      else
    if(key =='g'){;
      T = loadImage("g.png");
  image(T,0,0);
  triangle(xo,yo,xf,yf,((xf*2)-xo),yo);}
  
    else
  if(key =='c'){  
    T = loadImage("c.png");
  image(T,0,0);
    ellipseMode(CENTER);
  circle(cx, cy, radio);}

    else
  if(key =='v'){ 
    T = loadImage("v.png");
  image(T,0,0);   


  polygon(xo, yo, 100, poligon);

    }

    }
    }
  }

void keyPressed() {
  if (key == '1'){
   stroke(255,0,0);
 }
 if (key == '2') {
   stroke(0,0,255);
 }
 if (key == '3') {
   stroke(0,255,0);
 }
 if (key == '4') {
   stroke(0);}
   
 if (key == 'z') {
   grosor++; 
   strokeWeight(grosor);}  
 if (key == 'x') {
   if(grosor!=1){
   grosor--; 
   strokeWeight(grosor);}  
 }
  if (key == '+') {
   poligon++; 
   }  
 if (key == '-') {
   if(poligon>=3){
   poligon--;}  
 }
  if (key == '0') {
    image(NoMenu,0,0);
    saveFrame("Paint-######.png");} 
    
      if (key == '9') {
  background(255);
  image(Menu,0,0);
  loadPixels();
  updatePixels();} 
  
 }
 
void mousePressed() {
  
xo=mouseX; 
yo=mouseY;
xf=mouseX; 
yf=mouseY;
cx=mouseX; 
cy=mouseY;
 
}

void mouseClicked() {
cx=mouseX; 
cy=mouseY;
}

void mouseDragged() {
xo=mouseX; 
yo=mouseY;
radio=(cx-mouseX)*2;}

void mouseReleased() {
loadPixels(); //toma los pixeles de la pantalla
aux=1;
cx=-100; 
cy=-100;
xo=-100; 
yo=-100;
xf=-100; 
yf=-100;
radio=-100;
inicio=0;
 
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
