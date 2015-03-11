Map map;
Cell seedCell;
boolean clickToExpand = false; // set in seed functions
String strategyName = "strategyName";
boolean saveFrames = true;

void setup() {
  size(800, 800);
  map = new Map(8, 8, width, height);
  setSeeds();
}

void setSeeds() {

  connectedRooms();
  //   lineStart();
  //   twoSeeds();
}

// Begin seed strategies  ====================

void connectedRooms() {
  strategyName = "Connected Rooms";
  clickToExpand = false;
  Cell room1 = map.getCell((int)random(8), (int)random(8));
  Cell room2 = map.getCell((int)random(8), (int)random(8));
  Cell room3 = map.getCell((int)random(8), (int)random(8));

  room1.setHighlighted(true);
  room2.setHighlighted(true);
  room3.setHighlighted(true);
  
  room1.highlightNeighbors(true);
  room2.highlightNeighbors(true);
  room3.highlightNeighbors(true);
  
  room1.connectToCell(room2);
  room1.connectToCell(room3);
  room2.connectToCell(room3);
}

void lineStart() {
  strategyName = "Line Start";

  clickToExpand = true;
  Cell cell = map.getCell((int)random(8), (int)random(8));

  int dir = 0; // vertical
  float r =  random(1);
  if ( r > 0.33 && r < 0.66) {
    dir = 1; // horizontal
  } else {
    dir = 2;
  }

  for (int i = 0; i < 8; i++) {
    if (dir == 0) {
      map.getCell(cell.getCol(), i).setHighlighted(true);
    } 
    if (dir == 1) {
      map.getCell(i, cell.getRow()).setHighlighted(true);
    }
  }

  if (dir == 2) {

    boolean up = (random(1) > 0.5);

    for (int col = 0; col < map.cols; col++) {
      for (int row = 0; row < map.rows; row++) {
        if (onDiagonal(cell, map.cells[col][row], up)) {
          map.cells[col][row].setHighlighted(true);
        }
      }
    }
  }
}

void twoSeeds() {
  strategyName = "Two Seeds";

  clickToExpand = true;
  map.getCell((int)random(4), (int)random(8)).setHighlighted(true);
  map.getCell((int)random(4) + 4, (int)random(8)).setHighlighted(true);
}

boolean onDiagonal(Cell cell1, Cell cell2, boolean up) {
  if (up) {
    return (cell1.row - cell2.row) == (cell1.col - cell2.col);
  } else {
    return (cell2.row - cell1.row) == (cell1.col - cell2.col);
  }
}


void draw() {
  background(255);

  noFill();
  stroke(0);
  map.draw();

  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(-2, -2, 175, 20);
  fill(0);
  text("Start: "+ strategyName, 5, 12);
}

void keyPressed() {
  if (key == 's') {
    if(saveFrames){
      saveFrame("samples/"+strategyName+"-####.png");
    }
    map.clearHighlights();
    setSeeds();
  } else {
    if (clickToExpand) {
      for (Cell cell : map.getHighlightedCells () ) {
        int n = (int)random(4);
        if (cell.neighborExists(n)) {
          cell.getNeighbor(n).setHighlighted(true);
        }
      }
    }
  }
}

