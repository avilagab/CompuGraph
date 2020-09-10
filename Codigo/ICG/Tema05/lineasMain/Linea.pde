class Linea{
  private Vector2 m_start; //Inicio de la línea - Punto más a la izquierda
  private Vector2 m_end; //Final de la línea - Punto más a la derecha
  private int m_weight; //Grosor de la línea
  private color m_color; //Color de la línea
  private int m_type;

  //Constructoras
  Linea(int x1, int y1, int x2, int y2){
    m_start = new Vector2(x1, y1);
    m_end = new Vector2(x2, y2);
    m_weight = 1;
    m_color = color(0);
    m_type = 0;
  }
  
  //Accesoras
  Vector2 getStart(){
    return m_start;
  }
  
  Vector2 getEnd(){
    return m_end;
  }
  
  int getWeight(){
    return m_weight;
  }
  
  color getColor(){
    return m_color;
  }
  
  int getType(){
    return m_type;
  }
  
  //Modificadoras
  void setStart(Vector2 s){
    m_start = s;
  }
  
  void setEnd(Vector2 e){
    m_end = e;
  }
  
  void setWeight(int w){
    m_weight = w;
  }
  
  void setColor(color c){
    m_color = c;
  }
  
  void setType(int t){
    m_type = t;
  }
  
  //Analizadoras
  float length(){ //Retorna la longitud
    int x1 = m_start.getX();
    int y1 = m_start.getY(); 
    int x2 = m_end.getX();
    int y2 = m_end.getY(); 
    float l = sqrt( pow(x2-x1,2) + pow(y2-y1,2) );
    return l;
  } 
  
  float getSlope(){
    int x1 = m_start.getX();
    int y1 = m_start.getY(); 
    int x2 = m_end.getX();
    int y2 = m_end.getY(); 
    if(x1 != x2){
      return (y2-y1)/(float)(x2-x1);
    }
    else{
      return Float.POSITIVE_INFINITY;
    }
  }
  
  void dibujar(){
    float x1 = m_start.getX();
    float y1 = m_start.getY(); 
    float x2 = m_end.getX();
    float y2 = m_end.getY(); 
    
    if(x1>x2){
      float x1Temp = x1;
      float y1Temp = y1;
      x1 = x2;
      x2 = x1Temp;
      y1 = y2;
      y2 = y1Temp;
    }
    
    float slope = getSlope();
    if(abs(slope)>=1){
        if(slope != Float.POSITIVE_INFINITY){
          while(x1<=x2){
            if(slope>0){            //Si la pendiente es positiva usar DDA
              x1 += 1/slope;
              y1 += 1;
            }else{
              x1 -= 1/slope;        //Si la pendiente es negativa, se resta. - ( - pendiente ). X se mueve de derecha a izquierda.
              y1 -= 1;
            }
            plumilla((int)x1, (int)y1);
          }
        }
        else{ 
          y1 += 1;
        }
    }
    else{
        while(x1<=x2){
          x1 += 1;
          y1 += slope;
          plumilla((int)x1, (int)y1);
        }
    }
  }
  
  void plumilla(int x, int y){
    int xActual;
    int yActual;
    stroke(random(255));
    switch(m_type){
      case 0:    //PLUMILLA CUADRADA
        xActual = x - (m_weight-1);
        yActual = y - (m_weight-1);
        for(int i=0; i<m_weight*2; i++){
          for(int j=0; j<m_weight*2; j++){
            point(xActual+j, yActual+i);            
          }
        }
      break;
      case 1:    //PLUMILLA EN CRUZ
        xActual = x - (m_weight-1);
        yActual = y - (m_weight-1);
        for(int i=0; i<m_weight*2; i++){
          point(xActual+i, y);
          point(x, yActual+i);
        }
      break;
    }
  }
}
