import "dart:math";
import "Playfield.dart";
import "dart:async";


List<String> typedList = <String>["normalBlock"];


class Block
{
  String _color;
  int _dissolveCounter; //beim auswerten auch gleichzeitig der punktwert für diesen block(bei bedarf eventuell abbildungsfunktion?)
  bool _isFalling;
  bool _isLocked;
  Point _Pos;
  Playfield _playfield;

  Block(this._color,this._Pos)
  {
    _dissolveCounter = 0;
    _isFalling = false;
    _isLocked = false;
  }
  void subscribeEvents(Playfield playfield)
  {
    this._playfield = playfield;
    //_playfield.allEvents.listen((e)=> this.blockGravityApply());
  }
  String getColor()
  {
    return _color;
  }
  bool isLocked()
  {
    return _isLocked;
  }
  void setIsLocked(bool value)
  {
    this._isLocked = value;
  }
  bool isFalling()
  {
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
    if(topBlock != null
        && downBlock != null
        && !topBlock.isLocked()
        && !downBlock.isLocked()
        && playfield.isValidCoords(topBlock.getPos())
        && playfield.isValidCoords(downBlock.getPos()))
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

  bool blockGravityApply(Playfield playfield)
  {
    return false;
    this._isFalling = false;
    Point iteratorCoords = this._Pos;
    //iterate through all the blocks, which are under the current one, and determine if at least one is falling,
    // or if there is a null field(free space)

    while(iteratorCoords.y >1)
    {
      if(playfield.getBlockFromField(iteratorCoords) == null || playfield.getBlockFromField(iteratorCoords).isFalling() )
      {
        this._isFalling = true;
        break;
      }
      iteratorCoords = new Point(iteratorCoords.x,iteratorCoords.y-1);
    }
    if(this._isFalling)
    {
      this.setPos(new Point(this._Pos.x,this._Pos.y-1));
      playfield.setBlockIntoField(this,this._Pos);
    }
  }
  void setPos(Point pos)
  {
    this._Pos = pos;
  }
  Point getPos()
  {

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