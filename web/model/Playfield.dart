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
  GameOver
}


class Playfield
{
  static int unusableRows = 1;
  List<List<Block>> _field;
  Queue<Command> _actionQueue = new Queue<Command>();
  StreamController _eventController = new StreamController.broadcast();

  double _currentScore;
  int _currentLevelTime; // in seconds
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
   * Triggered periodic by a Timer from the Controller, and push the
   * complete field up and check afterwards of Game Over
   */
  void timerFieldUp()
  {
    // Move the Field up and update the Position of the Blocks
    for(int y = (_fieldY - 1); y >= 0; y--)
    {
      for(int x = 0; x < _fieldX; x++)
      {
        // move block [x][y] up
        _field[x][y + 1] = _field[x][y];
        // update the Position of the moved Block
        _field[x][y + 1].setPos(new Point(x,y + 1));
        // delete Block at the old Position
        _field[x][y] = null;
      }
    }

    // check for Game Over
    for(int r = 0; r < _fieldX; r++)
    {
      if(_field[r][_fieldY] != null)
      {
        // a Block reached the upper Border of the play field
        // Raise Game Over Event
        fetch(eventType.GameOver);
      }
    }

    throw new Exception("not tested yet");
  }

  /**
   * Triggered periodic by a Timer from the Controller, and increase
   * the Level Time and check for Win or Game Over
   */
  void increaseLevelTime()
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
        fetch(eventType.Win);
      }
      else
      {
        // Raise Game Over Event
        fetch(eventType.GameOver);
      }
    }

    throw new Exception("not tested yet");
  }

  /**
   * Triggered periodic by a Timer from the Controller, check at
   * every Block if this Block can fall and move it down.
   */
  void timerApplyGravity()
  {
    bool somethingFalling = false;
    //
    for(int y = (1 + unusableRows); y < _fieldY; y++)
    {
      for(int x = 0; x < _fieldX; x++)
      {
        // check if the block can fall
        if(isValidCoords(new Point(x,y - 1)))
        {
          if(_field[x][y - 1] == null)
          {
            _field[x][y].setFalling(true);
            _field[x][y].setIsLocked(true);
          }
        }

        // if block falling
        if(_field[x][y].isFalling())
        {
          // move Block down (falling)
          _field[x][y - 1] = _field[x][y];
          // delete old Block Position
          _field[x][y] = null;

          // check if under the new position of the moved block a other block available
          if(isValidCoords(new Point(x,y - 2)))
          {
            if(_field[x][y - 2] != null)
            {
              // Only remove states if locked and falling both true,
              // secure the option if blocks are locked cause of a combo
              if(_field[x][y - 1].isFalling() && _field[x][y - 1].isLocked())
              {
                _field[x][y - 1].setFalling(false);
                _field[x][y - 1].setIsLocked(false);
              }
            }
          }
          // at least one block is still falling
          somethingFalling = true;
        }
      } // end of for loop

      // Only execute the dissolve trigger if no more blocks are falling
      if(!somethingFalling) _triggerDissolve();
    }

    throw new Exception("not implemented yet");
  }

  /**
   * Check a coordinate are valid
   * coordinate: the coordinate which shall be checked as Point
   * return: bool
   */
  bool isValidCoords(Point coordinate)
  {
    bool valid = false;

    ((coordinate.x >= 0 + unusableRows) && (coordinate.x < _fieldX)) ? valid = true : valid = false;
    ((coordinate.y >= 0 + unusableRows) && (coordinate.y < _fieldY)) ? valid = true : valid = false;

    throw new Exception("not tested yet");

    return valid;
  }


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
          _field[currentBlockPos.x][y].setIsLocked(true);
        }

        // add Points to Score
        _currentScore += b.getDissolveCounter();

      }
    }
    _toDissolve = null;

    throw new Exception("not tested yet");
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
    for(int r = 0; r < _fieldX; r++)
    {
      // choose a random Block Type and Color
      rngBlock = rng.nextInt(blockNameList.length);
      rngColor = rng.nextInt(colors.length);

      // create a Block of the chosen Type with random Color
      // NOTE: Need to be changed if new BlockTypes are Available in Block.dart !!!
      switch(blockNameList[rngBlock])
      {
        case "normalBlock":
            newBlock = new Block(colors[rngColor],new Point(r,0));
          break;

        default:
          newBlock = new Block(colors[rngColor],new Point(r,0));
          throw new Exception("Playfield:addRow => BlockType was not detected!");
          break;

      } // end switch case

      // insert the new Block into the Field
      _field[r][0] = newBlock;

    } // end for loop

    throw new Exception("not tested yet");
  }

  /**
   * Get a Block on this Position
   * coord: a Position on the field as Point
   * return: Block or Null
   */
  Block getBlockFromField(Point coord)
  {
    return (isValidCoords(coord)) ? _field[coord.x][coord.y] : null;
  }

  /**
   * Fetch Method for the Event Stream. This method is raised in this class
   * to created a Custom Event which are declared and defined in this Method and
   * in the eventType Enum.
   */
  fetch(eventType type)
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
    }
  }

  /**
   * Stream who send Custom Events which are declared in the fetch method.
   */
  Stream get allEvents => _eventController.stream;

}