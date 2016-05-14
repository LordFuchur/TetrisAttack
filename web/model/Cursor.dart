import "dart:math";
import "Playfield.dart";

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

  void move(Direction dir)
  {
    Point<int> up = new Point(_cursor1.x, _cursor1.y+1);
    Point<int> right = new Point(_cursor2.x+1, _cursor2.y);
    Point<int> down = new Point(_cursor1.x-1, _cursor1.y-1);
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
    Point<int> temp = new Point(_cursor1.x, _cursor1.y);
    _cursor1 = new Point(_cursor2.x, _cursor2.y);
    _cursor2 = new Point(temp.x, temp.y);
  }
}