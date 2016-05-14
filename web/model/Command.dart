
enum Action
{
  moveUp,
  moveDown,
  moveLeft,
  moveRight,
  swap
}
class Command
{
  Action _cmd;

  /**
   * Constructor
   * Take a Action to storage.
   * Info: Used for communication between Controller and Model (Playfield)
   */
  Command(this._cmd){}

  /**
   * Return a stored Action
   * return: a Enum Intro from Type Action
   */
  Action getAction()
  {
    return _cmd;
  }

}