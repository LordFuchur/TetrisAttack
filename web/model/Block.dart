import 'dart:math';

class Block
{
  bool isFalling = false;
  Point coords;
  String color; // maybe store hex value

  // Constructor
  Block(this.color){}

  // Methods
  void falling(bool falling)
  {
    isFalling = falling;
  }
  bool operator ==(Block b)
  {
    return color == b.color;
  }
  Point getCoords () {
    return coords;
  }
  void setCoords (Point newCoords) {
    coords = newCoords;
  }
}