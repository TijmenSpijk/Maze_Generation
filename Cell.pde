public class Cell {

    PVector gridPos;
    private PVector a,b,c,d;
    boolean isTop,isRight,isLeft,isButtom;
    boolean visited;
    boolean backtracked;
    color f;

    public Cell (int x, int y) {
        this.gridPos = new PVector(x,y);
        this.a = new PVector(x*w,y*w);
        this.isTop = true;
        this.b = new PVector((x+1)*w, y*w);
        this.isRight = true;
        this.c = new PVector(x*w,(y+1)*w);
        this.isLeft = true;
        this.d = new PVector((x+1)*w,(y+1)*w);
        this.isButtom = true;
        float r = map(x, 0, cols, 10, 200);
        float g = map(y, 0, rows, 10, 200);
        this.f = color(150); //color(r, g, 50);
    }

    void show() {
        if (this.visited && this.backtracked) {
            push();
            noStroke();
            fill(0,0,255);
            rect(this.a.x, this.a.y, w, w);
            pop();
        }
        else if (this.visited) {
            push();
            noStroke();
            fill(f);
            rect(this.a.x, this.a.y, w, w);
            pop();
        }
        if (this.isTop) {
            line(this.a,this.b);
        }
        if (this.isRight) {
            line(this.b,this.d);
        }
        if (this.isLeft) {
            line(this.a,this.c);
        }
        if (this.isButtom) {
            line(this.c,this.d);
        }
    }

    void highlight(color c) {
        push();
        noStroke();
        fill(c);
        rect(this.a.x, this.a.y, w, w);
        pop();
    }
}
