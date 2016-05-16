import "dart:math";
import "Playfield.dart";
import "Block.dart";

enum Direction
{
  up,
  right,
  down,
  left
}
class Cursor
{
  Point<int> _cursor1;
  Point<int> _cursor2;
  Playfield playfield;

  Cursor(Point<int> cursor1, Point<int> cursor2, Playfield field)
  {
    this._cursor1 = cursor1;
    this._cursor2 = cursor2;
    this.playfield = field;
  }
  Point getPosCursor1()
  {
    return _cursor1;
  }
  Point getPosCursor2()
  {
    return _cursor2;
  }
  void move(Direction dir)
  {
    Point<int> up = new Point(_cursor1.x, _cursor1.y+1);
    Point<int> right = new Point(_cursor2.x+1, _cursor2.y);
    Point<int> down = new Point(_cursor1.x, _cursor1.y-1);
    Point<int> left = new Point(_cursor1.x-1, _cursor1.y);

    switch (dir) {

      case Direction.up :
        if(playfield.isValidCoords(up))
        {
          this._cursor1 = new Point(_cursor1.x, _cursor1.y+1);
          this._cursor2 = new Point(_cursor2.x, _cursor2.y+1);
        }
        break;

      case Direction.right :
        if(playfield.isValidCoords(right))
        {
          this._cursor1 = new Point(_cursor1.x+1, _cursor1.y);
          this._cursor2 = new Point(_cursor2.x+1, _cursor2.y);
        }
        break;

      case Direction.down :
        if(playfield.isValidCoords(down))
        {
          this._cursor1 = new Point(_cursor1.x, _cursor1.y-1);
          this._cursor2 = new Point(_cursor2.x, _cursor2.y-1);
        }
        break;

      case Direction.left :
        if(playfield.isValidCoords(left))
        {
          this._cursor1 = new Point(_cursor1.x-1, _cursor1.y);
          this._cursor2 = new Point(_cursor2.x-1, _cursor2.y);
        }
        break;
    }

  }
  void swap()
  {
    Block fCursor01;
    Block fCursor02;
    // switch Positions inside the Blocks
    fCursor01 = playfield.getBlockFromField(_cursor1);
    fCursor01?.setPos(_cursor2);
    fCursor02 = playfield.getBlockFromField(_cursor2);



    fCursor02?.setPos(_cursor1);
    // set into the Field from Cursor 01

    playfield.setBlockIntoField(fCursor01,(fCursor01 == null)?new Point(_cursor2.x,_cursor2.y):null);
    // set into the Field from Cursor 02
    playfield.setBlockIntoField(fCursor02,(fCursor02 == null)?new Point(_cursor1.x,_cursor1.y):null);
  }
}