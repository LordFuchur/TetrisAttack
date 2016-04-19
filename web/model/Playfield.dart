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
  Cursor cursor;
  int comboValue;
  int levelTime;
  int level;
  int fieldUpSpeed;

  Playfield(this.height,this.width)
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
    //cursor = new Cursor(new Point(0,0))
  }
  void update(int timeMS)
  {

  }
  //performs the nextAction form the ActionQueue
  void doAction()
  {

  }
  void addRow()
  {

  }

  Block generateBlock()
  {

  }
  swapBlock()
  {
    //simple change with temp variable
    Block temp = playfield[cu][block1.x];
    playfield[block1.y][block1.x] = playfield[block2.y][block2.x];
    playfield[block2.y][block2.x] = temp;
  }
  void checkForDissolve()
  {

  }
}