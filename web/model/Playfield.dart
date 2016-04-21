import 'dart:collection';
import 'dart:math';
import 'Block.dart';
import 'Action.dart';
import 'Cursor.dart';

class Playfield
{
  //not im UML yet
  int height;
  int width;
  //end of not in UML

  List<List<Block>> playfield;
  Queue<Action> actionQueue;
  int comboValue;
  int levelTime;
  int level;
  int fieldUpSpeed;
  // new
  int overheadRows;
  int distanceBetweenCursorPoints;
  Cursor cursor;


  Playfield(this.height,this.width,this.overheadRows,this.distanceBetweenCursorPoints)
  {
    //nonPrimitives
    playfield = new List<List<Block>>();
    actionQueue = new Queue<Action>();
    //primitives
    comboValue = 0;
    levelTime = 0;
    level = 0;
    fieldUpSpeed = 0;
    // calc cursor start pos
    int middlePointCursor = ((this.width/2).abs());
    int middleFieldY = ((this.height-this.overheadRows)/2).abs();
    // Example distance 3 -> 3/2 = 1,5 -> abs(1.5) = 1, round(1,5) = 2 -> 2+1= 3
    Point point_left = new Point(middlePointCursor - (this.distanceBetweenCursorPoints/2).abs(),middleFieldY);
    Point point_right = new Point(middlePointCursor - (this.distanceBetweenCursorPoints/2).round(),middleFieldY);
    cursor = new Cursor(point_left,point_right);
  }
  void update(int timeMS)
  {

  }
  //performs the nextAction form the ActionQueue
  void doAction()
  {
    // get next queue element
    Action nQElement = actionQueue.dequeue();
    // switch for all actions
    switch(nQElement)
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
    return new Block(colors[rng.nextInt(colors.lenght)]);
  }

  swapBlock(Point block1,Point block2)
  {
    //simple change with temp variable
    Block temp = playfield[block1.y][block1.x];
    playfield[block1.y][block1.x] = playfield[block2.y][block2.x];
    playfield[block2.y][block2.x] = temp;
  }
  void checkForDissolve()
  {

  }
}