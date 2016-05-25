import "dart:html";
import "../model/Playfield.dart";
import "../controller/controller.dart";
import "../controller/config.dart";
import "../model/Block.dart";
class View
{
  /**
   * #####################################################################################
   *
   * Query Selectors
   *
   * #####################################################################################
   */

  final debugOverlay = querySelector('#debugTextBox');

  final debugHeader = querySelector('#DebugHeader');

  final infoBox = querySelector("#levelInformationDiv");

  final levelBlockInfo = querySelector("#levelBlockInfoDiv");

  final TableElement gameplayTable = querySelector("#gameplayField");

  HtmlElement get StartButton => querySelector('#startButtonArea');

  Platformtype platform;
  /**
   * #####################################################################################
   *
   * Code below
   *
   * #####################################################################################
   */

  View(this.platform) {}


  void _writeInfoBox(int levelTime,int score, int levelNum, int levelScore)
  {
    String infoBoxString = "";

    infoBoxString += '<b>Level: </b>' + levelNum.toString() + '<br>';
    infoBoxString += '<b>Score: </b>' + score.toString() + ' / ' + levelScore.toString() + '<br>';
    infoBoxString += '<b>Timeleft: </b>' + levelTime.toString() + '<b> Seconds</b><br>';

    infoBox.setInnerHtml(infoBoxString);
  }
  bool once = false;
  void update(Playfield model)
  {

    if(once)
    {
      return;
    }
    once = !true;

    String tableString = "";
    List<List<Block>> retList = model.getPrintablePlayfield();

    for (int row = retList.length-1; row >=0; row--)
    {
      tableString += "<tr>";
      for (int column = 0; column < retList[0].length; column++)
      {
        Block temp = model.getBlockFromField(new Point(column,row));
        tableString += '<td id="TD' + column.toString() + 'g'+ row.toString() + '" bgcolor="' + ((temp == null) ? "#FFFFF" : model.getBlockFromField(new Point(column,row)).getColor() )+ '" class="tableCell"></td>';
      }
      tableString += "</tr>\n";
    }
    gameplayTable.setInnerHtml(tableString);
    //_writeInfoBox(model.getTimeleft(),model.getCurrentScore(),model.getCurrentLevelNumber());
    Point cur1 =  model.getCursor().getPosCursor1();
    Point cur2 =  model.getCursor().getPosCursor2();
    querySelector("#TD"+cur1.x.toString()+"g"+cur1.y.toString()).setAttribute("class","cursor");
    querySelector("#TD"+cur2.x.toString()+"g"+cur2.y.toString()).setAttribute("class","cursor");
    _writeInfoBox(model.getTimeleft(),model.getCurrentScore(),model.getCurrentLevelNumber(),model.getLevelScore());
  }

  void showScore(Map<String,int> scoreList)
  {
  }

  void generateField()
  {
    String tableString = "";
    for (int y = config.getFieldSizeY(); y > 0; y--)
    {
      tableString += "<tr>";
      for (int x = 0; x < config.getFieldSizeX(); x++)
      {
        tableString += '<td id="' + x.toString() + ':'+ y.toString() + '" bgcolor="#FFFFFF" class="tableCell"></td>';
      }
      tableString += "</tr>\n";
    }
    gameplayTable.setInnerHtml(tableString);
  }



  void printDebugMessage(String msg)
  {
    debugOverlay.appendText(msg + "\n");
  }

}