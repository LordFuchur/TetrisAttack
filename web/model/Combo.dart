import "dart:math";
import "dart:collection";

import "Block.dart";

class Combo
{
  List<Block> comboList;
  Combo()
  {
    comboList = new List<Block>();
  }
  void addBlockToCombo(Block addToCombo)
  {
    this.comboList.add(addToCombo);
  }
  List<Block> getComboList()
  {
    return comboList;
  }
}