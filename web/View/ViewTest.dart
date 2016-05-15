import "dart:html";
import "../model/Playfield.dart";
class view
{
  Playfield _playfieldRef;
  int _playFieldWidth;
  int _playFieldHeight;
  int _division;
  int _offset;
  view(this._playFieldHeight,this._playFieldWidth,this._division)
  {
    _offset = 0;
  }


  void showMenu()
  {

  }
  void showScore()
  {
    //TODO print the highscore (only accesible from the mainMenu)
  }
  void updateModel(Playfield model)
  {
    _playfieldRef = model;

    //TODO print out the rest of the website...
  }
  void incOffset()
  {
    //let the offset circle around (0;divisionValue)
    _offset = ++_offset % _division;
  }
}