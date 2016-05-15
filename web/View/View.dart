import "dart:html";
import "../model/Playfield.dart";
import "../controller/controller.dart";
import "../controller/Config.dart";
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

    for (int y = config.modelFieldY; y > 0; y--)
    {
      tableString += "<tr>";
      for (int x = 0; x < config.modelFieldX; x++)
      {
        model.getBlockFromField(new Point(x,y)).getColor();
        tableString += '<td id="' + x.toString() + ':'+ y.toString() + '" bgcolor="' + model.getBlockFromField(new Point(x,y)).getColor() + '" class="tableCell"></td>';
      }
      tableString += "</tr>\n";
    }
    gameplayTable.setInnerHtml(tableString);
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