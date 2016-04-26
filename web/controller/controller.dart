import "../model/Action.dart";
import "../model/Playfield.dart";
import "config.dart";

class controller
{
  Playfield currentField;

  // Methods
  /**
   *
   */
  void moveCursor(String direction)
  {
    switch(direction)
    {
      case "up":
        queueAction(new Action(Actions.moveCursorUp));
        break;
      case "down":
        queueAction(new Action(Actions.moveCursorDown));
        break;
      case "left":
        queueAction(new Action(Actions.moveCursorLeft));
        break;
      case "right":
        queueAction(new Action(Actions.moveCursorRight));
        break;
      default:
        break;
    }
  }

  /**
  *  swap the current blocks where the cursor is pointing
  */
  void swapBlock()
  {
    queueAction(new Action(Actions.swapBlock));
  }

  /**
   * Start a new Game.
   * Create a new Playfield with the data from the config
   */
  void newGame()
  {
    this.currentField = new Playfield(config.fieldY,config.fieldX,config.cursor01,config.cursor02);
  }

}