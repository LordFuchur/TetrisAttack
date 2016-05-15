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

  final debugOverlay = querySelector('#DebugConsole');

  final debugHeader = querySelector('#DebugHeader');

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

  View(this.platform)
  {

  }
  void update(Playfield model)
  {

  }

  void showScore(List<String> scoreList)
  {

  }

  void generateField()
  {
    String tableString;
    for (int y = config.getFieldSizeY();y>0;y--)
    {
      tableString += "<tr>";
      for (int x = 0;x<config.getFieldSizeX();x++)
      {
        tableString += "<td></td>";
      }
      tableString += "</tr>\n";
    }
    gameplayTable.setInnerHtml(tableString);
  }

  void printMessage(String msg)
  {
    debugOverlay.appendHtml(msg + "<hr><br>");
  }

}