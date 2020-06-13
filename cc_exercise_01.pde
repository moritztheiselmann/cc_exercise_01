/* rules:
  select 2 random colors from predefined color pallete
  draw a grid of a 2d primitive shape (f.e. rectangle)
  define a random cell in the first
  find a way from the top cell to bottom, each cell from the current row needs to
  touch a cell in the previous and next row
  connect all selected cells with a line
*/

color colors[];
int cellSize = 40;
color cA;
color cB;
int firstCell = 0;
int xTiles;
int yTiles;
int updateRate = 60;

void setup() {
  size(1000, 1000);
  
  colors = new color[4];
  colors[0] = color(232, 144, 125);
  colors[1] = color(250, 198, 140);
  colors[2] = color(244, 246, 199);
  colors[3] = color(171, 205, 190); 
  
  init(); 
  drawGrid();
}

void draw() {
  if(frameCount % updateRate == 0) {
    init();
    drawGrid();
  }
}

void mouseReleased() {
  init();
  drawGrid();
}

void init() {
  int cAIndex = (int)random(colors.length);
  int cBIndex;
  // choose 2 random colors from palette
  // don't use the same value twice
  do {
    cBIndex= (int)random(colors.length);
  } while(cAIndex == cBIndex);
    
  cA = colors[cAIndex];
  cB = colors[cBIndex];
  
  xTiles = width / cellSize;
  yTiles = height / cellSize;
  
  firstCell = (int)random(xTiles);
}

void drawGrid() {
  background(cB);
  int curCell = firstCell;
  int nextCell = 0;
  noStroke();
  beginShape();
  
  for(int y = 0; y < yTiles; y++) {
    boolean found = false;
    if(curCell == yTiles-1) {
      if(random(1) < 0.5) {
        nextCell = curCell-1;
      }
      else {
        nextCell = curCell;
      }
    }
    else if( curCell == 0) {
      if(random(1) < 0.5) {
        nextCell = curCell;
      }
      else {
        nextCell = curCell+1;
      }
    }
    else {
      if(random(1) < 0.5) {
        nextCell = curCell-1;
      }
      else {
        nextCell = curCell+1;
      }
    }
    
    for(int x = 0; x < xTiles; x++) {
      // find the random selected cell in the first row
      fill(cA);
      if(y == 0) {
        if(x == firstCell) {
          fill(cB);
          vertex(x*cellSize+cellSize/2, y*cellSize+cellSize/2);
        }
      }
      else {
        if(!found && nextCell == x) {
          found = true;
          fill(cB);
          curCell = nextCell;
          vertex(x*cellSize+cellSize/2, y*cellSize+cellSize/2);
        }
      }
      circle(x*cellSize+cellSize/2, y*cellSize+cellSize/2, cellSize);
    }
  }
  stroke(100);
  strokeWeight(cellSize/10);
  noFill();
  endShape();
}
