public class Cell {

    PVector gridPos;
    Wall[] walls;
    boolean visited;
    color f;

    public Cell (int x, int y) {
        this.gridPos = new PVector(x,y);

        this.walls = new Wall[4];
        PVector	a = new PVector(x*w,y*w);
        PVector	b = new PVector((x+1)*w, y*w);
        PVector	c = new PVector(x*w,(y+1)*w);
        PVector	d = new PVector((x+1)*w,(y+1)*w);
        this.walls[0] = new Wall(a,b);
        this.walls[1] = new Wall(b,d);
        this.walls[2] = new Wall(a,c);
        this.walls[3] = new Wall(c,d);

        float r = map(x, 0, cols, 10, 200);
        float g = map(y, 0, rows, 10, 200);
        this.f = color(150); //color(r, g, 50);
    }

    void show() {
        if (this.visited) {
            push();
            noStroke();
            fill(f);
            rect(this.a.x, this.a.y, w, w);
            pop();
        }
        for (Wall wall : this.walls) {
            walls.show();
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
