class Character {
  Cell position;
  Cell destination;
  Map map;
  HashMap<Cell, Cell> pathMap;
  

  Character(Map map, Cell position) {
    this.map = map;
    this.position = position;
  }

  void setPosition(Cell cell) {
    this.position = cell;
  }

  void setDestination(Cell cell) {
    this.destination = cell;
  }
  
  void buildPathMap(){
    SimpleQueue<Cell> frontier = new SimpleQueue<Cell>();
    frontier.put(this.position);
    println(this.position.col + "x" + this.position.row);
    pathMap = new HashMap<Cell, Cell>();
    while(!frontier.isEmpty()){
      Cell current = (Cell)frontier.get();
      for(Cell neighbor : current.connectedNeighbors()){
        if(!pathMap.containsKey(neighbor)){
          println(neighbor.col +"x" +neighbor.row);
          frontier.put(neighbor);
          pathMap.put(neighbor, current);
        }
      }
    }
  }
  
  ArrayList<Cell> getPath(){
    Cell current = this.destination;
    
    println("position: " + position.col + "x" + position.row);
    println("current: " + current.col + "x" + current.row);
    ArrayList<Cell> path = new ArrayList<Cell>();
    path.add(current);
    while(current != null &&  !current.equals(this.position)){
      current = pathMap.get(current);
      if(current != null){      
        path.add(current);
      }
    }
    
    return path;
  }

  void draw() {
    pushMatrix();
    pushStyle();
    stroke(0);
    fill(0, 0, 255);
    translate(map.cellPosition(this.position).x, map.cellPosition(this.position).y);
    ellipse(50, 50, 50, 50);
    popMatrix();
    pushMatrix();
    translate(map.cellPosition(this.destination).x, map.cellPosition(this.destination).y);
    line(0, 0, 100, 100);
    line(0, 100, 100, 0);
    popStyle();
    popMatrix();
  }
}

