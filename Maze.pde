public class Maze {

    Cell[][] cells;
    Cell current;
    ArrayList<Cell> history;

    public Maze (int rows, int cols) {
        this.cells = new Cell[cols][rows];
        this.history = new ArrayList<Cell>();
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
                this.cells[i][j] = new Cell(i, j);
            }
        }
    }

    void show() {
        for (int j = 0; j < rows; j++) {
            for (int i = 0; i < cols; i++) {
                this.cells[i][j].show();
            }
        }
    }

    void generate() {
        
    }

    Cell getNext() {
        ArrayList<Cell> neighbours = new ArrayList<Cell>();
        int x = (int) this.current.gridPos.x;
        int y = (int) this.current.gridPos.y;
        //top
        if (y - 1 >= 0) {
            if (!this.cells[x][y-1].visited) {
                neighbours.add(this.cells[x][y-1]);
            }
        } //right
        if (x + 1 < cols) {
            if (!this.cells[x+1][y].visited) {
                neighbours.add(this.cells[x+1][y]);
            }
        } //left
        if (x - 1 >= 0) {
            if (!this.cells[x-1][y].visited) {
                neighbours.add(this.cells[x-1][y]);
            }
        } //buttom
        if (y + 1 < rows) {
            if (!this.cells[x][y+1].visited) {
                neighbours.add(this.cells[x][y+1]);
            }
        }
        int size = neighbours.size();
        if (size > 0) {
            return (neighbours.get((int) random(size)));
        } else {
            return null;
        }
    }

    void removeWalls(PVector from, PVector to) {
        PVector dir = PVector.sub(from, to);
        int fromx = (int) from.x;
        int fromy = (int) from.y;
        int tox = (int) to.x;
        int toy = (int) to.y;
        // to the right
        if (dir.x == -1) {
            this.cells[fromx][fromy].right.visible = false;
            this.cells[tox][toy].left.visible = false;
        // to the left    
        } else if (dir.x == 1) {
            this.cells[fromx][fromy].left.visible = false;
            this.cells[tox][toy].right.visible = false;
        // to the buttom
        } else if (dir.y == -1) {
            this.cells[fromx][fromy].buttom.visible = false;
            this.cells[tox][toy].top.visible = false;
        // to the top
        } else if (dir.y == 1) {
            this.cells[fromx][fromy].top.visible = false;
            this.cells[tox][toy].buttom.visible = false;
        }
    }
}
