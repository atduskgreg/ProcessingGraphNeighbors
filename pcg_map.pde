Map map;

void setup(){
  size(800,800);
  map = new Map(8,8, width, height);
}

void draw(){
  background(255);
  noFill();
  stroke(0);
  map.draw();
}

void mouseMoved(){
  Cell currCell = map.containingCell(mouseX, mouseY);
  Cell prevCell = map.containingCell(pmouseX, pmouseY);
  prevCell.highlightNeighbors(false);
  currCell.highlightNeighbors(true);
}
