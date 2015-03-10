Map map;
Cell seedCell;

void setup() {
  size(800, 800);
  map = new Map(8, 8, width, height);
  setSeeds();
}

void setSeeds() {
  map.getCell((int)random(4), (int)random(4)).setHighlighted(true);
  map.getCell((int)random(4) + 4, (int)random(4) + 4).setHighlighted(true);
}

void draw() {
  background(255);
  noFill();
  stroke(0);
  map.draw();
}

void keyPressed() {
  if (key == 's') {
    map.clearHighlights();
    setSeeds();
    
  } else {
    for (Cell cell : map.getHighlightedCells () ) {
      int n = (int)random(4);
      if (cell.neighborExists(n)) {
        cell.getNeighbor(n).setHighlighted(true);
      }
    }
  }
}

//void mouseMoved(){
//  Cell currCell = map.containingCell(mouseX, mouseY);
//  Cell prevCell = map.containingCell(pmouseX, pmouseY);
//  prevCell.highlightNeighbors(false);
//  currCell.highlightNeighbors(true);
//}

