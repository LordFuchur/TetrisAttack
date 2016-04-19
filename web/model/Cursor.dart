import 'dart:math';
import 'controller/config.dart';
// Directions for the Cursor
enum Direction
{
  up,
  down,
  left,
  right
}

class Cursor
{
  // Pointers for two blocks
  Point cursorblock01;
  Point cursorblock02;

  // Constructor
  Cursor(this.cursorblock01,this.cursorblock02) {}

  // Method for move Cursor
  move(Direction cursorDirection)
  {
    switch(cursorDirection)
    {
      case Direction.down:
          cursorblock01.y
        break;
      case Direction.up:
        break;
      case Direction.left:
        break;
      case Direction.right:
        break;
    }
  }

}