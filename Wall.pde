public class Wall {

    PVector gridPos, dir;
    PVector a, b;
    boolean visible;

    public Wall (PVector gridPos, PVector a, PVector b, PVector dir) {
        this.gridPos = gridPos;
        this.dir = dir;
        this.a = a;
        this.b = b;
        this.visible = true;
    }

    void show() {
        if (this.visible) {
            line(this.a, this.b);
        }
    }

}
