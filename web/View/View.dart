import "dart:html";
import "../model/Playfield.dart";
import "../controller/controller.dart";
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

  }

  void printMessage(String msg)
  {
    debugOverlay.appendHtml(msg + "<hr><br>");
  }

}