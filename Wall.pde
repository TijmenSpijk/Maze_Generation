public class Wall {

    PVector gridPos;
    PVector a, b;
    boolean visible;

    public Wall (PVector gridPos, PVector a, PVector b) {
        this.gridPos = gridPos;
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
