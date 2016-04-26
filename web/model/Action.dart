//dostuff
enum Actions
{
  moveCursorUp,
  moveCursorRight,
  moveCursorDown,
  moveCursorLeft,
  swapBlock
}
class Action
{
  Actions _action;
  Action(_action) {}

  // getter
  Actions getAction()
  {
    return _action;
  }
}