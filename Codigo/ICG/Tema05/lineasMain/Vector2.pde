class Vector2{
  private int m_x;
  private int m_y;
  
  Vector2(){
    m_x = 0;
    m_y = 0;
  }
  
  Vector2(int x, int y){
    m_x = x;
    m_y = y;
  }
  
  int getX(){
    return m_x;
  }

  int getY(){
    return m_y;
  }
  
  void setX(int x){
    m_x = x;
  }
  
  void setY(int y){
    m_y = y;
  }
  
  void setVector2(int x, int y){
    m_x = x;
    m_y = y;
  }
}
