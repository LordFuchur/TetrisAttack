import "Block.dart";
import 'dart:math';
import "../controller/config.dart";

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
    for(int row = 0; row < config.modelFieldY; row++)
    {
      field.add(new List<Block>());
      //print("Y: " + y.toString());
      for(int column = 0; column < config.modelFieldX; column++)
      {
        //print("\tX: " + x.toString());
        field[row].add(null);
      }
    }
    //first get a list with the correct dimensions filled with nulls
    for(List<Map> elem in mapStartField)
    {
      for(Map element in elem)
      {
        field[element["y"]][element["x"]] = new Block(element["_color"],new Point(element["x"],element["y"]));
      }
    }
    //and then replace entries, that are not meant to be null
    return field;
  }

  Map convertLevelToMap()
  {
    Map retMap = new Map();
    List<List<Map>> convertedField = new List<List<Map>>();

    for(int row = 0; row < 4;row++)
    {
      convertedField.add(new List<Map>());

      for(int column = 0; column < 3; column++)
      {
        convertedField[row].add(_startField[row][column].convertBlock());
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