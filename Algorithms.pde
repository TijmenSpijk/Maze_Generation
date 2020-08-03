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

//Maze generated with the Randomized Prim's algorithm
public class Maze_Prim extends Maze {

    ArrayList<Wall> walls;

    public Maze_Prim (int rows, int cols) {
        super(rows, cols);
        this.walls = new ArrayList<Wall>();
    }

    void generate() {
        Wall cw;
        Cell next;
        int index;
        this.current = this.cells[(int) cols/2][(int) rows/2];
        this.current.visited = true;
        for (Wall wall : this.current.getWalls()) {
            this.walls.add(wall);
        }
        int size = this.walls.size();
        while (size > 0) {
            index = (int) random(size);
            cw = this.walls.get(index);
            this.current = this.cells[(int) cw.gridPos.x][(int) cw.gridPos.y];
            next = this.getNext(cw);
            if (next != null) {
                if (this.current.visited ^ next.visited) {
                    this.removeWalls(this.current.gridPos, next.gridPos);
                    this.history.add(this.current);
                    this.history.add(next);
                    next.visited = true;
                    for (Wall wall : next.getWalls()) {
                        this.walls.add(wall);
                    }
                }
            }
            this.walls.remove(index);
            size = this.walls.size();
        }
    }

    Cell getNext(Wall divider) {
        int x = (int) (divider.gridPos.x + divider.dir.x);
        int y = (int) (divider.gridPos.y + divider.dir.y);
        if (x >= 0 && x < cols && y >= 0 && y < rows) {
            return this.cells[x][y];
        } else {
            return null;
        }
    }

}

//Maze generated with the Randomized Kruskal's algorithm
public class Maze_Kruskal extends Maze {

    public Maze_Kruskal (int rows, int cols) {
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