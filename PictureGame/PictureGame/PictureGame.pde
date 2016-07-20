ArrayList<PictureBlock> pictures = new ArrayList<PictureBlock>();
GameBoard game;

boolean mouseIsPressed = false;
boolean mouseIsTouching = false;
PImage bird;

void setup() {
  size(600, 600);

  bird = loadImage("birdImage.jpg");
  bird.resize(width, height);

  game = new GameBoard(width/2, height/2, 3*width/4, 3*height/4, 3, 3);
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      pictures.add(new PictureBlock(bird.get(j*width/3, i*height/3, width/3, height/3), j + i*3 ) );
    }
  }
}

void draw() {
  background(0);
  game.run();

  for (int i = 0; i < pictures.size(); i++) {
    pictures.get(i).run();
  }
  for (int i = pictures.size()-1; i >= 0; i--) {
    if (mouseIsPressed) {
      if (pictures.get(i).selected == true) {
        pictures.get(i).xPos = mouseX;
        pictures.get(i).yPos = mouseY;
        break;
      }
    }
  }
  
  if ( winGame() ) {
    background(0);
  }
}

void mousePressed() {
  mouseIsPressed = true;
  for (int i = 0; i < pictures.size(); i++) {
    pictures.get(i).isTouchingCircle(mouseX, mouseY, 0);
  }
  for (int i = 0; i < game.snapPoints.size(); i++) {
    for (int j = 0; j < pictures.size(); j++) {
      if (dist(pictures.get(j).xPos, pictures.get(j).yPos, game.snapPoints.get(i).x, game.snapPoints.get(i).y) < 50) {
        game.snapPoints.get(i).occupied = false;
      }
    }
  }
}

void mouseReleased() {
  mouseIsPressed = false;
  for (int i = 0; i < game.snapPoints.size(); i++) {
    for (int j = 0; j < pictures.size(); j++) {
      if (game.snapPoints.get(i).occupied == false) {
        if (dist(pictures.get(j).xPos, pictures.get(j).yPos, game.snapPoints.get(i).x, game.snapPoints.get(i).y) < 50) {
          pictures.get(j).xPos = (int) game.snapPoints.get(i).x;
          pictures.get(j).yPos = (int) game.snapPoints.get(i).y;
          game.snapPoints.get(i).occupied = true;
          game.snapPoints.get(i).pictureNumber = pictures.get(j).pictureNumber;
        }
      }
    }
  }
}

boolean winGame() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if ( !(game.snapPoints.get(i+3*j).pictureNumber == game.snapPoints.get(i+3*j).snapNumber) ) {
        return false;
      }        
    }
  }
  return true;
}