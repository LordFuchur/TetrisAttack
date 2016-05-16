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

    printMessage("pre for loop");
    for (int y = config.modelFieldY; y > 0; y--)
    {
      tableString += "<tr>";
      for (int x = 0; x < config.modelFieldX; x++)
      {
        printMessage("printing Block :"+x.toString() + ":" + y.toString());
        Block temp = model.getBlockFromField(new Point(x,y));
        printMessage("after var fetch");
        tableString += '<td id="' + x.toString() + ':'+ y.toString() + '" bgcolor="' + ((temp == null) ? "#FFFFF" : model.getBlockFromField(new Point(x,y)).getColor() )+ '" class="tableCell"></td>';
      }
      tableString += "</tr>\n";
    }

    printMessage("After create/before queryselector");
    gameplayTable.setInnerHtml(tableString);
    querySelector("#3:3").setAttribute("class","cursor");
    querySelector("#4:3").setAttribute("class","cursor");
  }

  void showScore(List<String> scoreList)
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



  void printMessage(String msg)
  {
    debugOverlay.appendText(msg + "\n");
  }

}