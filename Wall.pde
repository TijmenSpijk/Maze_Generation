public class Wall {

    PVector a, b;
    boolean visible;

    public Wall (PVector a, PVector b) {
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
