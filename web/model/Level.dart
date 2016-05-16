import "Block.dart";
import 'dart:math';

class Level
{
  List<String> _colors;
  List<String> _blocks;

  List<List<Block>> _startField;
  int _levelTimeSec;
  int _comboHoldTime;
  int _requiredScore;
  int _levelNum;

  /**
   * #####################################################################################
   *
   * Code below
   *
   * #####################################################################################
   */

  Level(this._colors, this._blocks, this._startField,this._levelTimeSec, this._comboHoldTime, this._requiredScore,this._levelNum) {}

  /**
   * #####################################################################################
   *
   * Getter Methods
   *
   * #####################################################################################
   */

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

  int getRequiredScore()
  {
    return _requiredScore;
  }

  int getLevelNumber()
  {
    return _levelNum;
  }

  /**
   * #####################################################################################
   *
   * Convert for JSON Methods
   *
   * #####################################################################################
   */

  static List<List<Block>> convertStartfieldMapToStartField(List<List<Map>> mapStartField)
  {
   List<List<Block>> field = new List<List<Block>>();

   for(int y = 0; y < mapStartField.length; y++)
   {
      field.add(new List<Block>());
      print("Y: " + y.toString());
      for(int x = 0; x < mapStartField[0].length; x++)
      {
        print("\tX: " + x.toString());
        field[y].add(new Block(mapStartField[y][x]["_color"],new Point(mapStartField[y][x]["_PosX"],mapStartField[y][x]["_PosY"])));
      }
   }

    return field;
  }

  Map convertLevelToMap()
  {
    Map retMap = new Map();
    List<List<Map>> convertedField = new List<List<Map>>();

    for(int y = 0; y < 4;y++)
    {
      convertedField.add(new List<Map>());

      for(int x = 0; x < 3; x++)
      {
        convertedField[y].add(_startField[y][x].convertBlock());
      }
    }

    retMap["_levelNum"] = _levelNum;
    retMap["_levelTimeSec"] = _levelTimeSec;
    retMap["_comboHoldTime"] = _comboHoldTime;
    retMap["_requiredScore"] = _requiredScore;
    retMap["_colors"] = _colors;
    retMap["_blocks"] = _blocks;
    retMap["_startField"] = convertedField;

    return retMap;
  }

  String toString()
  {
    String ret;

    ret = "Level: " + _levelNum.toString() +
        "\nLevel Time: " + _levelTimeSec.toString() +
        " s\nRequired Points: " + _requiredScore.toString() +
        "\nCombo Hold Time: " + _comboHoldTime.toString() +
        " s\nAllowed Colors: " + _colors.toString() +
        "\nAllowed Block Types: " + _blocks.toString() +
        "\nField Y: " + _startField.length.toString() +
        "\nField X: " + _startField[0].length.toString() + "\n";
    return ret;
  }
}