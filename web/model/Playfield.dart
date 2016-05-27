import "dart:collection";
import "dart:async";
import "Command.dart";
import "Block.dart";
import "dart:math";
import "Level.dart";
import "Cursor.dart";

enum eventType
{
  Win,
  GameOver,
  Loaded,
  BlockGravity
}


class Playfield
{
  static int unusableRows = 1;
  List<List<Block>> _field;
  Queue<Command> _actionQueue = new Queue<Command>();
  StreamController _eventController = new StreamController.broadcast();

  int _currentScore = 0;
  int _currentLevelTime = 0; // in seconds
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
    _fieldY += unusableRows;//adding the extra rows, which  have to be visible

    _cursor = new Cursor(cursor01,cursor02,this);

    if(level != null)
    {
      this._level = level;
      List<List<Block>> temp = level.getStartField();
      // set start field
      //_field = _level.getStartField();
      //_field.insert(_field.length,new List<Block>(_fieldX));

      _field = new List<List<Block>>(_fieldY);
      for(int row = 0;row < _field.length;row++)
      {
        _field[row] = new List<Block>();
        for (int column = 0; column < x; column++)
        {
          if(row != 0)
          {
            _field[row].add(temp[row-1][column]);
          }
          else
          {
            _field[row].add(null);
          }
        }
      }

    }
    else
    {
      // Sandbox Mode without Level

      _field = new List<List<Block>>(_fieldY);
      for(int row = 0;row < _field.length;row++)
      {
        _field[row] = new List<Block>();
        for (int column = 0; column < x; column++)
        {
          _field[row].add(null);
        }
      }
    }

    // Raise Event that the Field is ready
    raise(eventType.Loaded);

  }

  List<List<Block>> getPrintablePlayfield()
  {
    return _field;
    List<List<Block>> retList = new List<List<Block>>();
    for(int row = _fieldY - 1; row >= 0 ;row--)
    {
      retList.add(_field[row]);
    }
    return retList;
  }
  /**
   * Add a Command Object to the Action Queue
   * cmd: take a Command object
   */
  void addCommand(Command cmd)
  {
    _actionQueue.add(cmd);
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
    //timerApplyGravity(); //atm only for dissolving
  }

  /**
   * Triggered periodic by a Timer from the Controller, and push the
   * complete field up and check afterwards of Game Over
   */
  void timerFieldUp()
  {
    // Move the Field up and update the Position of the Blocks
    //-2 here, because we need to skip the first row in the array from top
    for(int row = (_fieldY - 2); row >= 0; row--)
    {
      for(int column = 0; column < _fieldX; column++)
      {
        // move block [x][y] up
        _field[row + 1][column] = _field[row][column];
        // update the Position of the moved Block
        _field[row + 1][column]?.setPos(new Point(column,row + 1));
        // delete Block at the old Position
        _field[row][column] = null;
      }
    }

    // check for Game Over
    for(int column = 0; column < _fieldX; column++)
    {
      if(_field[_fieldY-1][column] != null)
      {
        // a Block reached the upper Border of the play field
        // Raise Game Over Event
        raise(eventType.GameOver);
        clearField();
      }
    }
    addRow(_level.getBlocks(),_level.getColors());
    //TODO CHECKED MANUAL NEED TO CHECK IN RUNTIME timerFieldUp()
  }

  /**
   * Triggered periodic by a Timer from the Controller, and increase
   * the Level Time and check for Win or Game Over
   */
  void timerIncreaseLevelTime()
  {
    // Count the Level Time up
    _currentLevelTime++;

    // Check if the end of the level reached
    if(_currentLevelTime >= _level.getLevelTime())
    {
      // Check if the required score reached
      if(_currentScore >= _level.getRequiredScore())
      {
        // Raise Win Event
        raise(eventType.Win);
        clearField();
      }
      else
      {
        // Raise Game Over Event
        raise(eventType.GameOver);
        clearField();
      }
    }

  }

  /**
   * Triggered periodic by a Timer from the Controller, check at
   * every Block if this Block can fall and move it down.
   */
  void timerApplyGravity()
  {

    raise(eventType.BlockGravity);
    bool columnFalling = false;
    for(int column = 0;column < _field[0].length;column++)
    {
      columnFalling = false;
      for(int row = unusableRows;row <_field.length; row++)
      {
        if(_field[row][column] == null)
          columnFalling = true;
        else
        {
          _field[row][column].setFalling(columnFalling);
          _field[row][column].setIsLocked(columnFalling);
        }
      }
    }
    for(int column = 0;column < _field[0].length;column++)
    {
      for(int row = 0;row <_field.length; row++)
      {
        if(_field[row][column]!= null && _field[row][column].isFalling() && isValidCoords(new Point(column,row-1)))
        {
          _field[row-1][column] = _field[row][column];
          _field[row-1][column].setPos(new Point(column,row-1));
          _field[row][column] = null;
          for(int columnChecker = row-1;columnChecker > 0;columnChecker--)
          {

            _field[row-1][column].setFalling(false);
            _field[row-1][column].setIsLocked(false);
            if(_field[columnChecker][column] == null)
            {
              _field[row-1][column].setFalling(true);
              _field[row-1][column].setIsLocked(true);
            }
          }
        }
      }
    }
    _triggerDissolve();
    //TODO TESTED MANUALLY NEED TO CHECK IN RUNTIME timerApplyGravity()
  }

  /**
   * Check a coordinate are valid
   * coordinate: the coordinate which shall be checked as Point
   * return: bool
   */
  bool isValidCoords(Point coordinate)
  {
    bool valid,valid2 = false;

    ((coordinate.x >= 0 ) && (coordinate.x < _fieldX)) ? valid = true : valid = false;
    ((coordinate.y >= 0 + unusableRows ) && (coordinate.y < _fieldY)) ? valid2 = true : valid = false;

    return valid && valid2;
  }


  /**
   * Trigger dissolve method by every Block on the field, get all dissolves and add score
   */
  void _triggerDissolve()
  {
    _toDissolve = new List<Block>();
    Point currentBlockPos;
    // trigger at every Block the dissolve methods
    for(int row = 0; row < _fieldY; row++)
    {
      for(int column = 0; column < _fieldX; column++)
      {
        _field[row][column]?.checkNeighbour(_toDissolve,this);
      }
    }

    // work off the dissolve list and add points to score
    for(Block b in _toDissolve)
    {
      currentBlockPos = b.getPos();

      // check if the block exist (could be that block are member of two combos)
      if(_field[currentBlockPos.y][currentBlockPos.x] != null)
      {
        // set all Blocks over current Block falling
        for(int row = currentBlockPos.y; row < _fieldY; row++)
        {
          _field[row][currentBlockPos.x]?.setFalling(true);
          _field[row][currentBlockPos.x]?.setIsLocked(true);
        }

        // add Points to Score
        _currentScore += b.getDissolveCounter();

      }
      _field[currentBlockPos.y][currentBlockPos.x] = null;
    }
    _toDissolve = null;
    //TODO TESTED MANUALLY NEED TO CHECK IN RUNTIME _triggerDissolve()
  }

  /**
   * Create and add a new Row into the play field.
   * blockNameList: a List of the available Blocks for this Level as String
   * colors: a List of available Colors for Blocks in this Level as String(Hex)
   */
  void addRow(List<String> blockNameList,List<String> colors)
  {
    Block newBlock;
    var rng = new Random();
    int rngBlock;
    int rngColor;

    // create new Blocks till the length of the play field
    for(int column = 0; column < _fieldX; column++)
    {
      // choose a random Block Type and Color
      rngBlock = rng.nextInt(blockNameList.length);
      rngColor = rng.nextInt(colors.length);

      // create a Block of the chosen Type with random Color
      // NOTE: Need to be changed if new BlockTypes are Available in Block.dart !!!
      switch(blockNameList[rngBlock])
          {
        case "normalBlock":
          newBlock = new Block(colors[rngColor],new Point(column,0));
          break;

        default:
          newBlock = new Block(colors[rngColor],new Point(column,0));
          break;

      } // end switch case

      // insert the new Block into the Field
      _field[0][column] = newBlock;

    } // end for loop
    //TODO TESTED MANUALLY NEED TO CHECK IN RUNTIME addrow()
  }

  /**
   * Get a Block on this Position
   * coord: a Position on the field as Point
   * return: Block or Null
   */
  Block getBlockFromField(Point coord)
  {
    if(!isValidCoords(coord))
      return null;
    return _field[coord.y][coord.x];
  }

  /**
   * Take a Block in insert it into the play field on this position which are set
   * in the Block.
   * block: block which shall insert into play field
   */
  void setBlockIntoField(Block block ,[Point nullArg = null])
  {
    if(nullArg != null)
    {
      if(isValidCoords(nullArg))
      {
        _field[nullArg.y][nullArg.x] = null;
      }
    }
    else if(isValidCoords(block.getPos()))
    {
      _field[block.getPos().y][block.getPos().x] = block;
    }
  }

  /**
   * Fetch Method for the Event Stream. This method is raised in this class
   * to created a Custom Event which are declared and defined in this Method and
   * in the eventType Enum.
   * type: the eventType which are defined in eventType Enum
   */
  raise(eventType type)
  {
    // create a new Event and push it on the Stream
    switch(type)
    {
      case eventType.GameOver:
        _eventController.add(eventType.GameOver);
        break;

      case eventType.Win:
        _eventController.add(eventType.Win);
        break;
      case eventType.Loaded:
        _eventController.add(eventType.Loaded);
        break;
      case eventType.BlockGravity:
        _eventController.add(eventType.BlockGravity);
        break;
    }
  }

  /**
   * Stream who send Custom Events which are declared in the fetch method.
   */
  Stream get allEvents => _eventController.stream;

  /**
   * Get which time is left for this level
   * return: int (seconds)
   */
  int getTimeleft()
  {
    return _level.getLevelTime() - _currentLevelTime;
  }

  /**
   * Get the current Score
   * return: int
   */
  int getCurrentScore()
  {
    return _currentScore;
  }

  int getLevelScore()
  {
    return _level.getRequiredScore();
  }

  /**
   * Return the Number of the Level
   * return: int
   */
  int getCurrentLevelNumber()
  {
    return _level.getLevelNumber();
  }
  Cursor getCursor()
  {
    return this._cursor;
  }

  void clearField()
  {
    for(int row = 0; row < _fieldY; row++)
    {
      for(int column = 0; column < _fieldX; column++)
      {
        _field[row][column] = null;
      }
    }
  }


}