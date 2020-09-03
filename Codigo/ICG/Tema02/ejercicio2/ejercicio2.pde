void setup(){
  size(720,480);
  loadPixels();
  for( int x=0; x<width; x++){
    for( int y=0; y<height; y++){
      color c = color(((720-x)/720.0)*255);
      pixels[x+y*width] = c;
    }
  }
  updatePixels();
}

void draw(){

}
