import 'dart:math';

class Block
{
  bool isFalling = false;
  String color; // maybe store hex value

  // Constructor
  Block(this.color){}

  // Methods
  void falling(bool falling)
  {
    isFalling = falling;
  }
}