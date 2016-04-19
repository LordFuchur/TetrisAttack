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
          if((cursorBlock_left.y + config.getBlockSizeY()) < config.getFieldSizeY())
          {
            cursorBlock_left = new Point(cursorBlock_left.x,cursorBlock_left.y + config.getBlockSizeY());
            cursorBlock_right = new Point(cursorBlock_right.x,cursorBlock_right.y + config.getBlockSizeY());
          }
        break;
      case Direction.down:
          if((cursorBlock_left.y - config.getBlockSizeY()) > 0)
          {
            cursorBlock_left = new Point(cursorBlock_left.x,cursorBlock_left.y - config.getBlockSizeY());
            cursorBlock_right = new Point(cursorBlock_right.x,cursorBlock_right.y - config.getBlockSizeY());
          }
        break;
      case Direction.left:
          if((cursorBlock_left.x - config.getBlockSizeX()) > 0)
          {
            cursorBlock_left = new Point(cursorBlock_left.x - config.getBlockSizeX(),cursorBlock_left.y);
            cursorBlock_right = new Point(cursorBlock_right.x - config.getBlockSizeX(),cursorBlock_right.y);
          }
        break;
      case Direction.right:
          if((cursorBlock_right.x + config.getBlockSizeX()) < config.getFieldSizeX())
          {
            cursorBlock_left = new Point(cursorBlock_left.x + config.getBlockSizeX(),cursorBlock_left.y);
            cursorBlock_right = new Point(cursorBlock_right.x + config.getBlockSizeX(),cursorBlock_right.y);
          }
        break;
    }
  }
}