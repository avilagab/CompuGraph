void setup(){
  size(720,480);    //size(Ancho, Alto);
}

void draw(){
  loadPixels();     //Aviso a Processing que necesito la informacion de pixeles
  for(int y = 0; y<height; y++){
    for(int x = 0; x<width; x++){
      int pos = x + y*width;       //Se calcula la posición en el vector basado en el ancho y el alto de la imagen
      float rand = random(255);    //Valor aleatorio entre 0 y 255
      color c = color(rand);       //Se crea una variable de tipo color y se inicializa con el valor aleatorio
      pixels[pos] = c;
    }
  }
  updatePixels();   //Terminé de modificar los pixeles, ahora actualícelos
}
