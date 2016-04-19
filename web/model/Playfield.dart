import 'dart:collection';
import 'Block.dart';
import 'Cursor.dart';

class Playfield
{
  //not im UML yet
  int height;
  int width;
  //end of not in UML

  List<List<Block>> field;
  int comboValue;
  int levelTime;
  int level;
  int fieldUpSpeed;
  //fields, that have to be implemented
  /*
    Queue<Action> actionQueue;
  */


  Playfield(this.height,this.width)
  {
    field = new List<List<Block>>();
    comboValue = 0;
    levelTime = 0;
    level = 0;
    fieldUpSpeed = 0;
  }
  void update(int timeMS)
  {

  }
}