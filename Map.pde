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
  
  Cell containingCell(int x, int y){
    return getCell(x/squareSize(), y/squareSize());
  }
  
  Cell getCell(int col, int row){
    println(col + "," + row);
    return cells[col][row];
  }

  int squareSize() {
    return this.width/this.cols;
  }

  void draw() {
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        pushMatrix();
        translate(col*squareSize(), row*squareSize());
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

  Cell(Map map, int col, int row) {
    this.map = map;
    this.col = col;
    this.row = row;
  }

  ArrayList<Cell> getNeighbors(){
    int[][] dirs = new int[][] {{1, 0}, {0, 1}, {-1, 0}, {0, -1},{1,1}, {1,-1}, {-1,-1}, {-1,1}}; // diagonally adjacent: {1,1}, {1,-1}, {-1-1}, {-1,1};
    ArrayList<Cell> result = new ArrayList<Cell>();
    println(dirs.length);
    for(int i = 0; i < dirs.length; i++){
      // deal with boundary conditions
      println("i: " + i + " " + this.col + "x" + this.row + " d: " +dirs[i][0] +","+dirs[i][1]);
      if(this.col == (map.cols-1) && dirs[i][0] > 0 ){
        continue;
      }
      if(this.row == (map.rows-1) && dirs[i][1] > 0){
        continue;
      }
      if(this.col == 0 && dirs[i][0] < 0){
        continue;
      }
      if(this.row == 0 && dirs[i][1] < 0){
        continue;
      }
      
      
      result.add(map.getCell(this.col + dirs[i][0], this.row + dirs[i][1]));
    }
    
    return result;
  }
  
  void setHighlighted(boolean bool){
    this.highlighted = bool;
  }
  
  void highlightNeighbors(boolean bool){
    for(Cell neighbor : getNeighbors()){
      neighbor.setHighlighted(bool);
    }
  }

  void draw() {
    pushMatrix();
    pushStyle();
    if(highlighted){
      fill(255,0,0);
    }
    rect(0,0,map.squareSize(), map.squareSize());
    popStyle();
    popMatrix();
  }
}

