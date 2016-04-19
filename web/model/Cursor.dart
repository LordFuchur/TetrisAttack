import 'IBlock.dart';
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
  Block cursorblock01;
  Block cursorblock02;

  // Constructor
  Cursor(this.cursorblock01,this.cursorblock02) {}

  // Method for move Cursor
  move(Direction cursorDirection)
  {
    switch(cursorDirection)
    {
      case Direction.down:
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