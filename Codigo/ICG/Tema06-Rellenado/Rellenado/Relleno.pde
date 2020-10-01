class Relleno{
  
void Relleno1( int x, int y, int red,int green, int blue, int redb, int greenb, int blueb ) {
  color a=color(redb,greenb,blueb);
  color b=color(red,green,blue);
  color comparador=get(x,y); 
  //loadPixels();
  println(b+"   "+pixels[x+(y*width)]);
  
if ( color(pixels[x+(y*width)]) != color(a) && color(pixels[x+(y*width)]) != color(b)) {

pixels[x+(y*width)]=b;
updatePixels();
Relleno1( x+1, y, red, green, blue , redb, greenb,blueb );
Relleno1( x, y+1, red, green, blue , redb, greenb,blueb );
Relleno1( x-1, y, red, green, blue , redb, greenb,blueb );
Relleno1( x, y-1, red, green, blue , redb, greenb,blueb );
}
updatePixels();
}
}
