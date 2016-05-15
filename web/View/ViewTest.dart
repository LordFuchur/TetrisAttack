import "dart:html";
import "../model/Playfield.dart";
class view
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


  /**
   * #####################################################################################
   *
   * Code below
   *
   * #####################################################################################
   */

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