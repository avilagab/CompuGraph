
class Dda {
    int x1,x2,y1,y2,size;
    String pen;
    float ax, ay, x, y, variacion;
    Dda(int _x1, int _y1, int _x2, int _y2,int _size) {
        this.x1 = _x1;
        this.y1 = _y1;
        this.x2 = _x2;
        this.y2 = _y2;
        this.size=_size;
        
        this.print();
    }
    private void print() {
        //si la variacion en x es mayor o igual que la variacion en y
        if (abs(x2 - x1) >= abs(y2 - y1)) {
            variacion = abs(x2 - x1);
        } else {
            //si la variacion en y es mayor que la variacion en x
            variacion = abs(y2 - y1);
        }
        ax = (x2 - x1) / variacion; //el valor a aumentar en x
        ay = (y2 - y1) / variacion; //el valor a aumentar en y

        x = (float) x1;
        y = (float) y1;
        int i = 0;
        
        while (i <= variacion) {
            //point(round(x), round(y));
            //point(x,y);
            stroke(0,0,0);
            //point((int)x,height-(int)y);
            pixels[int(x)+(int(y)*width)]=color(0,0,0);
            x = x + ax;
            y = y + ay;
            i++;
        }
    }
}
