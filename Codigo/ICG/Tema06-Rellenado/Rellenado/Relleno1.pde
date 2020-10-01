class Relleno2{
  int color_re=250;
  int bp=0;
  color pink = color(255, 102, 204);
  
  Relleno2(int Ancho,int Alto){
    point(309,209);
loadPixels();
color a;
color b;
/*
for(int y=0;y<height;y++){
  for(int x=0;x<width;x++){
    a=get(x,y);
    b=get(x+1,y);
    println("Color= "+a+" pixel # "+y*x);
    
    if(int(a)!=-1&&bp==0&&int(b)!=-1){
    bp=1;
    }
    else{
      if(int(a)!=-1&&bp==1&&int(b)!=-1){
    bp=0;
    println("bbbb");
    }
    }
    if(bp==1&&int(b)!=-1){
    stroke(130,40,10);
    point(x,y);
    println("aaaaaaa");
    }
    if(int(a)!=-1&&bp==0&&int(b)!=-1){
    bp=1;
    }
  }
}
*/
int t=0;
for(int i=0;i<Ancho*Alto;i++){
   
    println("Color= "+pixels[i]+"  contador: "+i+" "+bp);
    if(t<Ancho*Alto-1){
      t++;
    }
      if(pixels[i]!=-1&&bp==0&&pixels[t]!=-1){
    bp=1;
    }
    else{
      if(pixels[i]!=-1&&bp==1&&pixels[t]!=-1){
    bp=0;
    }
    }
    if(bp==1){
    fill(color_re);
    pixels[i]=pink;
    }
  }
updatePixels();
}
}
