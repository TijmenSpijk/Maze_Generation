import java.util.Stack;

Cell current, next;
int rows, cols;
int w;
Maze maze;
boolean running = false;

void setup() {
    fullScreen();
    // size(400, 400);
    background(50);
    
    w = 20;
    rows = height/w - 1;
    cols = width/w - 1;
    
    // translate(w/2, w/2);
    maze = new Maze_AB(rows, cols);
    maze.generate();
}

void draw() {
    if (running) {
        translate(w/2, w/2);
        for (int i = 0; i < 5; ++i) {
            if (maze.history.size() > 1) {
                current = maze.history.get(0);
                next = maze.history.get(1);
                maze.history.remove(0);
                maze.history.remove(0);
                current.show();
                next.show();
            } else {
                noLoop();
                break;
            }
        }
    }
}

void keyPressed() {
    if (key == ' ') {
        running = true;
    }    
}

void drawGrid() {
    push();
    translate(w/2, w/2);
    stroke(255);
    noFill();
    for (int j = 0; j < rows; j++) {
        for (int i = 0; i < cols; i++) {
            rect(i*w, j*w, w, w);
        }
    }
    pop();
}

void line(PVector a, PVector b) {
    push();
    stroke(255);
    line(a.x, a.y, b.x, b.y);
    pop();
}
