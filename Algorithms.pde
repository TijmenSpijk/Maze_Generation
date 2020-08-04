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
    ArrayList<Set> sets;

    public Maze_Kruskal (int rows, int cols) {
        super(rows, cols);
        this.walls = new ArrayList<Wall>();
        this.sets = new ArrayList<Set>();
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
                Set<Cell> c = new HashSet<Cell>();
                c.add(this.cells[i][j]);
                this.sets.add(c);
                this.walls.add(this.cells[i][j].top);
                this.walls.add(this.cells[i][j].right);
                this.walls.add(this.cells[i][j].left);
                this.walls.add(this.cells[i][j].buttom);
            }
        }
        Collections.shuffle(this.walls);
    }

    void generate() {
        for (Wall wall : this.walls) {
            this.current = this.cells[(int) wall.gridPos.x][(int) wall.gridPos.y];
            this.current.visited = true;
            Cell next = this.getNext(wall);
            if (next != null) {
                Set<Cell> currentSet = this.getSet(this.current, this.sets);
                Set<Cell> nextSet = this.getSet(next, this.sets);
                int indexNext = this.sets.indexOf(nextSet);
                if (currentSet.addAll(nextSet)) {
                    this.removeWalls(this.current.gridPos, next.gridPos);
                    this.sets.remove(indexNext);
                    this.history.add(this.current);
                    this.history.add(next);
                }
            }
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

    Set<Cell> getSet(Cell cell, ArrayList<Set> sets) {
        for (Set set : sets) {
            if (set.contains(cell)) {
                return set;
            }
        }
        return null;
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

//Maze generated with Wilson's algorithm
public class Maze_Wilson extends Maze {

    public Maze_Wilson (int rows, int cols) {
        super(rows, cols);
    }

    void generate() {
        // step 1: chose arbitrary cell to be part of the maze
        // step 2: chose arbitrary starting cell to start the walk form
        // step 3: perform random walks all cells have been visited
        // step 4: perform random walk until you reach another part of the maze
        // step 5: at every step check if a loop has been created (reached own path)
        // step 6: check if you reached another part of the maze
        Cell next = new Cell(0, 0);
        int countVisited = 0;
        int total = rows*cols;
        ArrayList<Cell> path = new ArrayList<Cell>();
        //step 1;
        this.current = this.cells[(int) random(cols)][(int) random(rows)];
        this.current.visited = true;
        countVisited++;
        //step 2:
        this.current = this.cells[(int) random(cols)][(int) random(rows)];
        while (this.current.visited) {
            this.current = this.cells[(int) random(cols)][(int) random(rows)];
        }
        this.current.visited = true;
        countVisited++;
        path.add(this.current);
        //step 3:
        while (countVisited < total) {
            //step 4:
            boolean foundMaze = false;
            while(!foundMaze) {
                next = this.getNext();
                //step 5
                if (path.contains(next)) {
                    this.current = next;
                } // step 6
                else if (next.visited) {
                    this.removeWalls(this.current.gridPos, next.gridPos);
                    this.history.add(this.current);
                    this.history.add(next);
                    foundMaze = true;
                } else {
                    this.removeWalls(this.current.gridPos, next.gridPos);
                    this.history.add(this.current);
                    this.history.add(next);
                    this.current = next;
                    this.current.visited = true;
                    countVisited++;
                    path.add(this.current);
                }
            }
            //step 2
            path = new ArrayList<Cell>();
            this.current = this.cells[(int) random(cols)][(int) random(rows)];
            while (this.current.visited) {
                this.current = this.cells[(int) random(cols)][(int) random(rows)];
            }
            this.current.visited = true;
            countVisited++;
            path.add(this.current);
        }
        this.history.add(this.current);
        this.history.add(next);
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