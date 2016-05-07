import "dart:collection";
import "Command.dart";
import "Block.dart";
import "dart:math";

class Block
{
  String _color;
  int _dissolveCounter; //beim auswerten auch gleichzeitig der punktwert für diesen block(bei bedarf eventuell abbildungsfunktion?)
  bool _isFalling;
  Point _Pos;

  String getColor()
  {
    throw new Exception("not implemented yet");
    return "";
  }
  bool isLocked()
  {
    throw new Exception("not implemented yet");
    return true;
  }
  bool isFalling()
  {
    throw new Exception("not implemented yet");
    return false;
  }
  void setToDissolve()
  {
    throw new Exception("not implemented yet");
  }
  void checkNeighbour(List<Block> dissolveList)
  {
    throw new Exception("not implemented yet");
  }
  void setPos(Point pos)
  {
    throw new Exception("not implemented yet");
  }
  Point getPos()
  {
    throw new Exception("not implemented yet");
    return new Point(-1,-1);
  }

}