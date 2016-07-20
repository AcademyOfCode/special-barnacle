class PictureBlock {
  int xPos;
  int yPos;
  int rectWidth;
  int rectHeight;
  PImage image;
  boolean selected = false;
  int pictureNumber;

  PictureBlock(PImage _image, int _pictureNumber) {
    rectWidth = width/4;
    rectHeight = height/4;
    xPos = (int) random(rectWidth, width-rectWidth);
    yPos = (int) random(rectHeight, height-rectHeight);
    pictureNumber = _pictureNumber;
    image = _image;
    image.resize(rectWidth, rectHeight);
  }


  void run() {
    display();
  }

  void display() {
    rectMode(CENTER);
    imageMode(CENTER);
    image(image, xPos, yPos);
  }

  void isTouchingCircle(int circleXPos, int circleYPos, int radius) {
    if ( circleXPos > xPos - rectWidth/2 && circleXPos < xPos + rectWidth/2 && circleYPos > yPos - rectHeight/2 && circleYPos < yPos + rectHeight/2) {
      selected = true;
    } else {
      selected = false;
    }
  }
  
  
}