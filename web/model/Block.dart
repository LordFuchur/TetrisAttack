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
    //check left and right
    Block leftBlock = playfield.getBlockFromField(new Point(_Pos.x-1,_Pos.y));
    Block rightBlock = playfield.getBlockFromField(new Point(_Pos.x+1,_Pos.y));
    if(leftBlock != null && rightBlock != null && !leftBlock.isLocked() && !rightBlock.isLocked())
    {
      if(leftBlock.getColor() == this.getColor() && rightBlock.getColor() == this.getColor())
      {
        dissolveList.add(this);
        dissolveList.add(leftBlock);
        dissolveList.add(rightBlock);
        _dissolveCounter++;
      }
    }
    Block topBlock = playfield.getBlockFromField(new Point(_Pos.x,_Pos.y+1));
    Block downBlock = playfield.getBlockFromField(new Point(_Pos.x,_Pos.y-1));
    if(!(topBlock == null || downBlock == null ||topBlock.isLocked() || downBlock.isLocked()))
    {
      if(topBlock.getColor() == this.getColor() && downBlock.getColor() == this.getColor())
      {
        dissolveList.add(this);
        dissolveList.add(topBlock);
        dissolveList.add(downBlock);
        _dissolveCounter++;
      }
    }
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
  Map convertBlock()
  {
    Map retMap = new Map();
    retMap["_color"] = _color;
    retMap ["_PosX"] = _Pos.x;
    retMap ["_PosY"] = _Pos.y;
    return retMap;
  }
  String toString()
  {
    return this._color.substring(0,1);
  }
}