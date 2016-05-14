import "dart:collection";
import "Command.dart";
import "Block.dart";
import "dart:math";
import "Level.dart";
import "Cursor.dart";

class Playfield
{
  List<List<Block>> _field;
  Queue<Command> _actionQueue = new Queue<Command>();
  //Streamcontroller hier kommt der eventhandler hin
  double _currentScore;
  int _currentLevelTime;
  List<Block> _toDissolve;
  int _fieldX;
  int _fieldY;
  Level _level;
  Cursor _cursor;

  /**
   * Constructor
   * x: field size x
   * y: field size y
   * cursor01: Position of the first Cursor as Point
   * cursor02: Position of the second Cursor as Point
   * level: take a Level Object to set the parameter for this Level, set null for sandbox mode
   */
  Playfield(int x,int y,Point cursor01,Point cursor02, Level level)
  {
    // Set field size and create cursor
    this._fieldX = x;
    this._fieldY = y;
    _cursor = new Cursor(cursor01,cursor02,this);

    if(level != null)
    {
      this._level = level;
      // set start field
      _field = _level.getStartField();
    }
    else
    {
      // Sandbox Mode without Level
      _field = new List<List<Block>>();
      // Create field and fill with null
      for(int y = 0; y < _fieldY; y++)
      {
        _field.add(new List<Block>());
        for (int x = 0; x < _fieldX; x++)
        {
          _field[y].add(null);
        }
      }
    }


  }

  /**
   * Add a Command Object to the Action Queue
   * cmd: take a Command object
   */
  void addCommand(Command cmd)
  {
    _actionQueue.add(cmd);
    throw new Exception("not tested yet");
  }

  /**
   * Triggered periodic by a Timer from the Controller, dequeue next Command
   * from Action Queue and execute it.
   */
  void timerDoNextAction()
  {
    Command nextCmd;

    if(_actionQueue.isEmpty)
      return;

    nextCmd = _actionQueue.removeFirst();

    switch(nextCmd.getAction())
    {
      case Action.moveUp:
          _cursor.move(Direction.up);
        break;
      case Action.moveDown:
          _cursor.move(Direction.down);
        break;
      case Action.moveLeft:
          _cursor.move(Direction.left);
        break;
      case Action.moveRight:
          _cursor.move(Direction.right);
        break;
      case Action.swap:
          _cursor.swap();
        break;
    }

    //trigger gravity
    timerApplyGravity();

    throw new Exception("not tested yet");
  }

  /**
   * Triggered periodic by a Timer from the Controller, ...
   *
   */
  void timerFieldUp()
  {



    throw new Exception("not implemented yet");
  }


  void DecreaseLevelTime()
  {



    throw new Exception("not implemented yet");
  }


  void timerApplyGravity()
  {throw new Exception("not implemented yet");}

  /**
   * Check a coordinate are valid
   * coordinate: the coordinate which shall be checked as Point
   * return: bool
   */
  bool isValidCoords(Point coordinate)
  {
    bool valid = false;

    ((coordinate.x >= 0) && (coordinate.x < _fieldX)) ? valid = true : valid = false;
    ((coordinate.y >= 0) && (coordinate.y < _fieldY)) ? valid = true : valid = false;

    throw new Exception("not tested yet");

    return valid;
  }


  void _raiseEvent()
  {throw new Exception("not implemented yet");}


  /**
   * Trigger dissolve method by every Block on the field, get all dissolves and add score
   */
  void _triggerDissolve()
  {
    _toDissolve = new List<Block>();
    Point currentBlockPos;
    // trigger at every Block the dissolve methods
    for(int y = 0; y < _fieldY; y++)
    {
      for(int x = 0; x < _fieldX; x++)
      {
        _field[x][y].checkNeighbour(_toDissolve,this);
      }
    }

    // work off the dissolve list and add points to score
    for(Block b in _toDissolve)
    {
      currentBlockPos = b.getPos();
      _field[currentBlockPos.x][currentBlockPos.y] = null;

      // check if the block exist (could be that block are member of two combos)
      if(_field[currentBlockPos.x][currentBlockPos.y] != null)
      {
        // set all Blocks over current Block falling
        for(int y = currentBlockPos.y; y < _fieldY; y++)
        {
          _field[currentBlockPos.x][y].setFalling(true);
        }

        // add Points to Score
        _currentScore += b.getDissolveCounter();

      }
    }
    _toDissolve = null;

    throw new Exception("not tested yet");
  }


  void addRow(List<String> blockNameList)
  {
    var rng = new Random();

    for(int r = 0; r < _fieldX; r++)
    {
      
    }

    throw new Exception("not implemented yet");
  }

  Block getBlockFromField(Point coord)
  {
    return _field[coord.x][coord.y];
  }
}