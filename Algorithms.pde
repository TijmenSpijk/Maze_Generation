public class Maze_DFS extends Maze {
    
    Stack<Cell> stack;

    public Maze_DFS (int rows, int cols) {
        super(rows, cols);
        this.stack = new Stack<Cell>();
        this.stack.push(this.cells[0][0]);
    }

    void generate() {
        while (!this.stack.empty()) {
            this.current = this.stack.pop();
            this.current.visited = true;
            Cell next = this.getNext();
            if (next != null) {
                this.stack.push(this.current);
                this.removeWalls(this.current.gridPos, next.gridPos);
                this.history.add(this.current);
                this.history.add(next);
                this.stack.push(next);
            }
        }
    }

}

//Maze generated with the Randomized Kruskal's algorithm
public class Maze_Kruskal extends Maze {

    ArrayList<Wall> walls;

    public Maze_Kruskal (int rows, int cols) {
        super(rows, cols);
        this.walls = new ArrayList<Wall>();
    }

    void generate() {
        this.current = this.cells[(int) random(cols)][(int) random(rows)];
        for (Wall wall : this.current.getWalls()) {
            this.walls.add(wall);
        }
        while (this.walls.size() > 0) {

        }
    }

}

//Maze generated with the Randomized Prim's algorithm
public class Maze_Prim extends Maze {

    public Maze_Prim (int rows, int cols) {
        super(rows, cols);
    }

}

//Maze generated with Wilson's algorithm
public class Maze_Wilson extends Maze {

    public Maze_Wilson (int rows, int cols) {
        super(rows, cols);
    }

}

//Maze generated with the Recursive division algorithm
public class Maze_AB extends Maze {

    int countVisited, total;

    public Maze_AB (int rows, int cols) {
        super(rows, cols);
        this.countVisited = 1;
        this.total = rows*cols;
    }

    void generate() {
        this.current = this.cells[(int) random(cols)][(int) random(rows)];
        this.current.visited = true;
        while(countVisited < total) {
            Cell next = this.getNext();
            if (!next.visited) {
                next.visited = true;
                countVisited++;
                this.removeWalls(this.current.gridPos, next.gridPos);
                this.history.add(this.current);
                this.history.add(next);
            }
            this.current = next;
        }
    }

    Cell getNext() {
        ArrayList<Cell> neighbours = new ArrayList<Cell>();
        int x = (int) this.current.gridPos.x;
        int y = (int) this.current.gridPos.y;
        //top
        if (y - 1 >= 0) {
            neighbours.add(this.cells[x][y-1]);
        } //right
        if (x + 1 < cols) {
            neighbours.add(this.cells[x+1][y]);
        } //left
        if (x - 1 >= 0) {
            neighbours.add(this.cells[x-1][y]);
        } //buttom
        if (y + 1 < rows) {
            neighbours.add(this.cells[x][y+1]);
        }
        return (neighbours.get((int) random(neighbours.size())));
    }
}