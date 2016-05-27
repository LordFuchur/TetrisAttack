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

  final infoBox = querySelector("#infoArea");

  final levelBlockInfo = querySelector("#levelBlockInfoDiv");

  final tableDiv = querySelector("#tableDiv");

  final mainmenu = querySelector("#MainMenu");

  final TableElement gameplayTable = querySelector("#gameplayField");

  HtmlElement get StartButton => querySelector('#StartButton');

  Platformtype platform;

  List<List<HtmlElement>> genField;

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

  void update(Playfield model)
  {
    List<List<Block>> field = model.getPrintablePlayfield();
    Block currentBlock;

    for(int row = (field.length - 1); row > 0; row--)
    {
      for(int column = 0; column < field[0].length; column++)
      {
        // get block
        currentBlock = field[row][column];
        // check if block exist and set color
        if(model.getCursor().getPosCursor1() == new Point(column,row) || model.getCursor().getPosCursor2() == new Point(column,row))
          genField[row][column].setAttribute("class","cursor");
        else
          genField[row][column].setAttribute("class","tableCell");
        if(currentBlock != null)
        {
          genField[row][column].setAttribute("bgcolor",currentBlock.getColor());
        }
        else
        {
          genField[row][column].setAttribute("bgcolor","#FFFFF");
        }
      }
    }

    _writeInfoBox(model.getTimeleft(),model.getCurrentScore(),model.getCurrentLevelNumber(),model.getLevelScore());
  }

  void generateField(int fieldX, int fieldY)
  {
    String tableString = "";
    for(int row = fieldY; row >= 0; row--)
    {
      tableString += "<tr>";
      for(int column = 0; column < fieldX; column++)
      {
        if(row != 0)
        {
          tableString += '<td id="TDRow' + row.toString() + 'gTDCol' + column.toString() + '" bgcolor="#FFFFF" class="tableCell"></td\n>';
        }
        else // unusable Rows
        {
          tableString += '<td id="TDRow' + row.toString() + 'gTDCol' + column.toString() + '" bgcolor="#FFFFF" class="lastCell"></td\n>';
        }
      }
      tableString += "</tr>\n";
    }

    gameplayTable.innerHtml = tableString;

    // create Shortcut table
    genField = new List<List<HtmlElement>>(fieldY);

    for(int row = fieldY - 1; row > 0; row--)
    {
      genField[row] = new List<HtmlElement>();

      for(int column = 0; column < fieldX; column++)
      {
        genField[row].add(querySelector(("#TDRow" + row.toString() + "gTDCol" + column.toString())));
      }
    }

  }


  void showScore(Map<String,int> scoreList)
  {
  }

  void printDebugMessage(String msg)
  {
    debugOverlay.appendText(msg + "\n");
  }

}