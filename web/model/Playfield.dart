import 'dart:collection';
import 'dart:math';

import 'Block.dart';
import 'Action.dart';
import 'Cursor.dart';
import '../controller/config.dart';

class Playfield
{

  //not im UML yet
  int height;
  int width;
  //end of not in UML

  //the dimension [0][n]
  //the [0][n] are the blocks, that are currently pushed into the accessible playfield
  //hence cant be used in part of a dissolve
  List<List<Block>> playfield;
  //block, which are added to this list, are part of a dissolve , so the wont be used
  //again while checking the other blocks of the same combo
  List<Point> comboPartList;
  Queue<Action> actionQueue;
  Cursor cursor;
  int comboValue;
  int levelTime;
  int level;
  int fieldUpSpeed;
  // new


  Playfield(this.height,this.width,Point cursor1,Point cursor2)
  {
    //nonPrimitives
    playfield = new List<List<Block>>();
    actionQueue = new Queue<Action>();
    //get startValues from Config
    //primitives
    comboValue = 0;
    levelTime = 0;
    level = 0;
    fieldUpSpeed = 0;
    cursor = new Cursor(cursor1,cursor2);
  }
  void update(int timeMS)
  {

  }
  //performs the nextAction form the ActionQueue
  void doAction()
  {
    // get next queue element
    Action nQElement = actionQueue.removeFirst();
    // switch for all actions
    switch(nQElement.getAction())
    {
      case Actions.moveCursorUp:

        break;
      case Actions.moveCursorDown:

        break;
      case Actions.moveCursorRight:

        break;
      case Actions.moveCursorLeft:

        break;
    }
  }
  void addRow()
  {

  }

  Block generateBlock(List<String> colors)
  {
    /*
      Bis jetzt nur einfache generierung für einfache Blöcke mit einer Farbliste.
      TODO: Erweiterbarkeit fehlt für spezial Blöcke. Eventuelle Liste von möglichen Blöcken ???
     */
    var rng = new Random();
    // rng number betwenn 0 - colors.length
    return new Block(colors[rng.nextInt(colors.length)]);
  }

  swapBlock(Point block1,Point block2)
  {
    //simple change with temp variable
    Block temp = playfield[cursor.getPointLeftY()][cursor.getPointLeftX()];
    playfield[cursor.getPointLeftY()][cursor.getPointLeftX()] = playfield[cursor.getPointRightY()][cursor.getPointRightX()];
    playfield[cursor.getPointRightY()][cursor.getPointRightY()] = temp;
  }
  void checkForDissolve()
  {
    //TODO change color, so that it can be generic
    Block actualBlock = new Block("black");

    //we have to start at row 1 rather than on row 0, because row 0 is the row of blocks, which are not yet part of the playfield

    //loop over all blocks of the field, to find dissolvable constructions
    //we just have to check every block, thats above, or right of the current looked at block
    //otherwise, we would do some unneeded checks
    //TODO optimization here, by excluding the borderblocks of the whole playfield. Code here is just, so it can run
    for(int y = 1;y<playfield.length;y++)
    {
      for(int x = 0;x<playfield[y].length;x++)
      {
        //make sure, we wont get an index out of bounds exception
        if(!((y+1) == height))
        {
          
        }
      }
    }
  }
}