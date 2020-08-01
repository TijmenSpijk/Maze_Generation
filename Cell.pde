public class Cell {

    PVector gridPos;
    Wall top, right, left, buttom;
    boolean visited;
    color f;

    public Cell (int x, int y) {
        this.gridPos = new PVector(x,y);

        PVector	a = new PVector(x*w,y*w);
        PVector	b = new PVector((x+1)*w, y*w);
        PVector	c = new PVector(x*w,(y+1)*w);
        PVector	d = new PVector((x+1)*w,(y+1)*w);

        this.top = new Wall(this.gridPos, a, b);
        this.right = new Wall(this.gridPos, b, d);
        this.left = new Wall(this.gridPos, a, c);
        this.buttom = new Wall(this.gridPos, c, d);

        float r = map(x, 0, cols, 10, 200);
        float g = map(y, 0, rows, 10, 200);
        this.f = color(150); //color(r, g, 50);
    }

    void show() {
        if (this.visited) {
            push();
            noStroke();
            fill(f);
            rect(this.gridPos.x*w, this.gridPos.y*w, w, w);
            pop();
        }
        this.top.show();
        this.right.show();
        this.left.show();
        this.buttom.show();
    }

    Wall[] getWalls() {
        Wall[] walls = new Wall[4];
        walls[0] = this.top;
        walls[1] = this.right;
        walls[2] = this.left;
        walls[3] = this.buttom;
        return walls;
    }
}
