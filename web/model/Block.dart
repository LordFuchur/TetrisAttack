import "dart:collection";
import "Command.dart";
import "Block.dart";
import "dart:math";
import "Playfield.dart";


List<String> typedList = <String>["normalBlock"];


class Block
{
  String _color;
  int _dissolveCounter; //beim auswerten auch gleichzeitig der punktwert für diesen block(bei bedarf eventuell abbildungsfunktion?)
  bool _isFalling;
  bool _isLocked;
  Point _Pos;



  String getColor()
  {
    //throw new Exception("not implemented yet");
    return _color;
  }
  bool isLocked()
  {
    //throw new Exception("not implemented yet");
    return _isLocked;
  }
  void setIsLocked(bool value)
  {
    this._isLocked = value;
  }
  bool isFalling()
  {
    //throw new Exception("not implemented yet");
    return _isFalling;
  }
  void setFalling(bool value)
  {
    this._isFalling = value;
  }
  int getDissolveCounter()
  {
    return this._dissolveCounter;
  }
  void setToDissolve()
  {
    //throw new Exception("not implemented yet");
    _dissolveCounter++;
  }
  void checkNeighbour(List<Block> dissolveList,Playfield playfield)
  {
    //first check left & right
    if(playfield.isValidCoords(new Point(_Pos.x - 1,_Pos.y)) &&
                               playfield.isValidCoords(new Point(_Pos.x + 1,_Pos.y)) &&
                               playfield.getBlockFromField(new Point(_Pos.x -1,_Pos.y))._color == playfield.getBlockFromField(new Point(_Pos.x+1,_Pos.y))._color)
    {
      dissolveList.add
    }
    //throw new Exception("not implemented yet");
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