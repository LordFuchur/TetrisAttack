import "dart:collection";
import "Command.dart";
import "Block.dart";
import "dart:math";
import "Level.dart";
import "Cursor.dart";

class Playfield
{
  List<List<Block>> _field;
  Queue<Command> _actionQueue;
  //Streamcontroller hier kommt der eventhandler hin
  double _currentScore;
  int _currentLevelTime;
  List<Block> _toDissolve;
  int _fieldX;
  int _fieldY;
  Level _level;
  Cursor _cursor;

  Playfield(int x,int y,Point cursor01,Point cursor02, Level level)
  {
    this._fieldX = x;
    this._fieldY = y;
  }
  void addCommand(Command)
  {throw new Exception("not implemented yet");}
  void timerDoNextAction()
  {}
  void timerFieldUp()
  {throw new Exception("not implemented yet");}
  void DecreaseLevelTime()
  {throw new Exception("not implemented yet");}
  void timerApplyGravity()
  {throw new Exception("not implemented yet");}
  bool isValidCoords()
  {
    throw new Exception("not implemented yet");
    return false;
  }
  void _raiseEvent()
  {throw new Exception("not implemented yet");}
  void _triggerDissolve()
  {throw new Exception("not implemented yet");}
  void addRow(List<String> blockNameList)
  {throw new Exception("not implemented yet");}

}