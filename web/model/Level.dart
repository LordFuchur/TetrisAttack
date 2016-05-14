import "Block.dart";
class Level
{
  List<String> _colors;
  List<String> _blocks;

  List<List<Block>> _startField;
  int _levelTimeSec;
  int _comboHoldTime;
  double _requiredScore;

  Level()
  {

  }

  List<String> getColors ()
  {
    return _colors;
  }

  List<String> getBlocks()
  {
    return _blocks;
  }

  List<List<Block>> getStartField()
  {
    return _startField;
  }

  int getLevelTime()
  {
    return _levelTimeSec;
  }

  int getComboHoldTime()
  {
    return _comboHoldTime;
  }

  double getRequiredScore()
  {
    return _requiredScore;
  }
}