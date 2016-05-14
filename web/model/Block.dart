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

  Block(this._color,this._Pos)
  {
    _dissolveCounter = 0;
    _isFalling = false;
    _isLocked = false;
  }
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
      dissolveList.add(this);
      dissolveList.add(playfield.getBlockFromField(new Point(_Pos.x - 1,_Pos.y)));
      dissolveList.add(playfield.getBlockFromField(new Point(_Pos.x + 1,_Pos.y)));
    }

    if(playfield.isValidCoords(new Point(_Pos.x,_Pos.y - 1)) &&
        playfield.isValidCoords(new Point(_Pos.x,_Pos.y + 1)) &&
        playfield.getBlockFromField(new Point(_Pos.x,_Pos.y - 1))._color == playfield.getBlockFromField(new Point(_Pos.x,_Pos.y+1))._color)
    {
      dissolveList.add(this);
      dissolveList.add(playfield.getBlockFromField(new Point(_Pos.x,_Pos.y - 1)));
      dissolveList.add(playfield.getBlockFromField(new Point(_Pos.x,_Pos.y + 1)));
    }
    //throw new Exception("not implemented yet");
  }
  void setPos(Point pos)
  {
    this._Pos = pos;
    //throw new Exception("not implemented yet");
  }
  Point getPos()
  {
    //throw new Exception("not implemented yet");
    return this._Pos;
  }

}