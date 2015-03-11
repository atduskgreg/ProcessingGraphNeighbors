class Map {
  int cols;
  int rows;
  int width;
  int height;
  Cell[][] cells;

  Map(int cols, int rows, int w, int h) {
    this.width = w;
    this.height = h;
    this.cols = cols;
    this.rows = rows;
    cells = new Cell[this.rows][this.cols];

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        cells[col][row] = new Cell(this, col, row);
      }
    }
  }

  Cell containingCell(int x, int y) {
    return getCell(x/squareSize(), y/squareSize());
  }

  Cell getCell(int col, int row) {
    return cells[col][row];
  }
  
  Cell randomCell(){
    return getCell((int)random(cols), (int)random(rows));
  }

  int squareSize() {
    return this.width/this.cols;
  }
  
  Cell randomHighlightedCell(){
    ArrayList<Cell> highlightedCells = getHighlightedCells();
    return highlightedCells.get(random(highlightedCells.size()));
  }

  ArrayList<Cell> getHighlightedCells() {
    ArrayList<Cell> result = new ArrayList<Cell>();
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        Cell cell = cells[col][row];
        if (cell.isHighlighted()) {
          result.add(cell);
        }
      }
    }
    return result;
  }

  void clearHighlights() {
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        cells[col][row].setHighlighted(false);
      }
    }
  }

  PVector cellPosition(Cell cell){
    return new PVector(cell.col*squareSize(), cell.row*squareSize());
  }

  void draw() {
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        pushMatrix();
        translate(cellPosition(cells[col][row]).x, cellPosition(cells[col][row]).y);
        cells[col][row].draw();
        popMatrix();
      }
    }
  }
}

class Cell {
  int col;
  int row;
  Map map;
  boolean highlighted = false;
  static final int E = 0;
  static final int S = 1;
  static final int W = 2;
  static final int N = 3;
  static final int SE = 4;
  static final int NE = 5;
  static final int NW = 6;
  static final int SW = 7;
  int[][] dirs;

  Cell(Map map, int col, int row) {
    this.map = map;
    this.col = col;
    this.row = row;
    this.dirs = new int[][] {
      {
        1, 0
      }
      , {
        0, 1
      }
      , {
        -1, 0
      }
      , {
        0, -1
      }
      // add these for diagonal connectivity
      , {
        1, 1
      }
      , {
        1, -1
      }
      , {
        -1, -1
      }
      , {
        -1, 1
      }
    };
  }

  int getCol() {
    return col;
  }

  int getRow() {
    return row;
  }

  Cell getNeighbor(int d) {
    return map.getCell(this.col + dirs[d][0], this.row + dirs[d][1]);
  }

  boolean isHighlighted() {
    return highlighted;
  }

  boolean neighborExists(int d) {
    return neighborExists(dirs[d]);
  }

  boolean neighborExists(int[] d) {
    if (this.col == (map.cols-1) && d[0] > 0 ) {
      return false;
    }
    if (this.row == (map.rows-1) && d[1] > 0) {
      return false;
    }
    if (this.col == 0 && d[0] < 0) {
      return false;
    }
    if (this.row == 0 && d[1] < 0) {
      return false;
    }

    return true;
  }

  ArrayList<Cell> getNeighbors() {
    ArrayList<Cell> result = new ArrayList<Cell>();
    for (int i = 0; i < dirs.length; i++) {
      if (neighborExists(dirs[i])) {
        result.add(map.getCell(this.col + dirs[i][0], this.row + dirs[i][1]));
      }
    }

    return result;
  }
  
  ArrayList<Cell> connectedNeighbors() {
    ArrayList<Cell> result = new ArrayList<Cell>();
    for (int i = 0; i < dirs.length; i++) {
      if (neighborExists(dirs[i])) {
        Cell neighbor = map.getCell(this.col + dirs[i][0], this.row + dirs[i][1]);
        if(this.highlighted == neighbor.highlighted){
          result.add(neighbor);
        }
      }
    }

    return result;
  }

  void setHighlighted(boolean bool) {
    this.highlighted = bool;
  }

  void highlightNeighbors(boolean bool) {
    for (Cell neighbor : getNeighbors ()) {
      neighbor.setHighlighted(bool);
    }
  }

  void connectToCell(Cell other) {
    int i = this.col;
    if (this.col != other.col) {
      int colDir = (other.col - this.col)/abs((this.col - other.col));
      i = this.col;
      while (i != other.col) {
        i += colDir;
        map.getCell(i, this.row).setHighlighted(true);
      }
    }

    if (this.row != other.row) {
      int rowDir = (other.row - this.row)/abs((this.row - other.row));
      int j = this.row;
      while (j != other.row) {
        j += rowDir;
        map.getCell(i, j).setHighlighted(true);
      }
    }
  }
  
  Boolean equals(Cell cell){
    return this.col == cell.col && this.row == cell.row;
  }

  void draw() {
    pushMatrix();
    pushStyle();
    if (highlighted) {
      fill(255, 0, 0);
      stroke(125);
      rect(0, 0, map.squareSize(), map.squareSize());
      strokeWeight(2);
      stroke(0);
      if (neighborExists(Cell.N) && !getNeighbor(Cell.N).isHighlighted()) {
        line(0, 0, map.squareSize(), 0);
      }
      if (neighborExists(Cell.E) && !getNeighbor(Cell.E).isHighlighted()) {
        line(map.squareSize(), 0, map.squareSize(), map.squareSize());
      }

      if (neighborExists(Cell.S) && !getNeighbor(Cell.S).isHighlighted()) {
        line(0, map.squareSize(), map.squareSize(), map.squareSize());
      }

      if (neighborExists(Cell.W) && !getNeighbor(Cell.W).isHighlighted()) {
        line(0, 0, 0, map.squareSize());
      }
    }

    popStyle();
    popMatrix();
  }
}

