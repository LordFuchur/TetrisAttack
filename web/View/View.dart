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

  final infoBox = querySelector("infoArea");

  final levelBlockInfo = querySelector("blockInfoArea");

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


  void _writeInfoBox(int levelTime,int score, int levelNum)
  {
    String infoBoxString = "";

    infoBoxString += '<b>Level: ' + levelNum.toString() + '</b><br>';
    infoBoxString += '<b>Score: ' + score.toString() + '</b><br>';
    infoBoxString += '<b>Timeleft: ' + levelTime.toString() + ' Seconds</b><br>';

    infoBox.setInnerHtml(infoBoxString);
  }

  void update(Playfield model)
  {
    String tableString = "";

    printDebugMessage("pre for loop");
    for (int y = config.modelFieldY; y > 0; y--)
    {
      tableString += "<tr>";
      for (int x = 0; x < config.modelFieldX; x++)
      {
        printDebugMessage("printing Block :"+x.toString() + ":" + y.toString());
        Block temp = model.getBlockFromField(new Point(x,y));
        printDebugMessage("after var fetch");
        tableString += '<td id="TD' + x.toString() + 'g'+ y.toString() + '" bgcolor="' + ((temp == null) ? "#FFFFF" : model.getBlockFromField(new Point(x,y)).getColor() )+ '" class="tableCell"></td>';
      }
      tableString += "</tr>\n";
    }

    printDebugMessage("After create/before queryselector");
    gameplayTable.setInnerHtml(tableString);
    querySelector("#TD3g3").setAttribute("class","cursor");
    querySelector("#TD4g3").setAttribute("class","cursor");
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