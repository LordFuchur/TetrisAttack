import 'dart:math';
import '../controller/config.dart';

enum Direction
{
  up,
  down,
  left,
  right
}

class Cursor
{
  Point cursorBlock_left;
  Point cursorBlock_right;

  // Constructor
  Cursor(this.cursorBlock_left,this.cursorBlock_right){}


  // Methods
  void move(Direction cursorDirection)
  {
    switch(cursorDirection)
    {
      case Direction.up:
          cursorBlock_left = new Point(cursorBlock_left.x,cursorBlock_left.y + 1);
          cursorBlock_right = new Point(cursorBlock_right.x,cursorBlock_right.y + 1);
        break;
      case Direction.down:
            cursorBlock_left = new Point(cursorBlock_left.x,cursorBlock_left.y - 1);
            cursorBlock_right = new Point(cursorBlock_right.x,cursorBlock_right.y - 1);
        break;
      case Direction.left:
            cursorBlock_left = new Point(cursorBlock_left.x - 1,cursorBlock_left.y);
            cursorBlock_right = new Point(cursorBlock_right.x - 1,cursorBlock_right.y);
        break;
      case Direction.right:
            cursorBlock_left = new Point(cursorBlock_left.x + 1,cursorBlock_left.y);
            cursorBlock_right = new Point(cursorBlock_right.x + 1,cursorBlock_right.y);
        break;
    }
  }
}