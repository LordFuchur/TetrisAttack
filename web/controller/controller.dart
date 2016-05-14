import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import "../model/Command.dart";
import "../model/Playfield.dart";
import "view.dart";
import "GameKeyCommunicator.dart";
import "Config.dart";

class controller
{
  /**
   * Other Components
   */

  Playfield _currentField;

  View _view;

  GameKeyCommunicator _gamekey;

  /**
   * Periodic Timers
   */
  Timer timerPlaytime;

  Timer timerFieldAction;

  Timer timerFieldUp;

  Timer timerGravity;

  /**
   * Constants
   */

  static const configPath = "";

  static const levelJSonPath = "";

  static const timerPlaytimeDuration = const Duration(seconds: 1);

  static const timerFieldUpDuration = const Duration(seconds: 4);

  static const timerFieldActionDuration = const Duration(milliseconds: 250);

  static const timerGravityDuration = const Duration(seconds: 4);

  /**
   * Variables
   */

  bool isGameRunning = false;
  bool isPaused = false;

  /**
   * #####################################################################################
   *
   * Code below
   *
   * #####################################################################################
   */

  /**
   * Constructor
   */

  Controller()
  {
    // Create View and GameKeyCom
    _gamekey = new GameKeyCommunicator();
    _view = new View();

    // GameKey Connection

    // Load Config and Level Files

    throw new Exception("not implemented yet");
  }

  /**
   * Start a new Game.
   * Create a new Playfield with the data from the config
   */
  void newGame()
  {
    // create new play field with specific setting
    _currentField = new Playfield(config.fieldX,config.fieldY,config.cursor01,config.cursor02,null);
    // enable Events of the play field
    _currentField.allEvents.listen((e) => eventHandler(e));

    throw new Exception("not tested yet");
  }


  /**
   * #####################################################################################
   *
   * Events related Methods
   *
   * #####################################################################################
   */

  /**
   * Keyboard Event Methods (One Time Use)
   */
  void controlEvents()
  {
    window.onKeyDown.listen((KeyboardEvent ev)
    {
      // Escape from Event if no Game is running
      if(isGameRunning == false) return;

      // Settings of the used Controls
      switch (ev.keyCode)
          {
        case KeyCode.LEFT:
          _currentField.addCommand(new Command(Action.moveLeft));
          break;
        case KeyCode.RIGHT:
          _currentField.addCommand(new Command(Action.moveRight));
          break;
        case KeyCode.UP:
          _currentField.addCommand(new Command(Action.moveUp));
          break;
        case KeyCode.DOWN:
          _currentField.addCommand(new Command(Action.moveDown));
          break;
        case KeyCode.SPACE:
          _currentField.addCommand(new Command(Action.swap));
          break;
        case KeyCode.P:
          // toggle pause
          isPaused = !isPaused;
          // Stop the Timers if the game are running, or create new Timer to resume the game
          (isPaused) ? timerFieldAction.cancel() : timerFieldAction = new Timer.periodic(timerFieldActionDuration,(_) => _currentField.timerDoNextAction());
          (isPaused) ? timerPlaytime.cancel() : timerFieldAction = new Timer.periodic(timerPlaytimeDuration,(_) => _currentField.timerIncreaseLevelTime());
          (isPaused) ? timerFieldUp.cancel() : timerFieldAction = new Timer.periodic(timerFieldUpDuration,(_) => _currentField.timerFieldUp());
          (isPaused) ? timerGravity.cancel() : timerFieldAction = new Timer.periodic(timerGravityDuration,(_) => _currentField.timerApplyGravity());
          break;
      }
    });

    throw new Exception("not tested yet");
  }

  /**
   * Event handler for the Events from the play field (model)
   * event: eventType entry from Enum located by the play field
   */
  void eventHandler(eventType event)
  {
    // choose action for each eventType
    switch(event)
    {
      case eventType.GameOver:
        // execute Game Over Method
        gameOver();
        // set Flag game running
        isGameRunning = false;
        break;
      case eventType.Win:
      // execute Win Method
        win();
        // set Flag game running
        isGameRunning = false;
        break;
      case eventType.Loaded:
        // Create Timers etc.
        timerPlaytime = new Timer.periodic(timerPlaytimeDuration,(_) => _currentField.timerIncreaseLevelTime());
        timerFieldAction = new Timer.periodic(timerFieldActionDuration, (_) => _currentField.timerDoNextAction());
        timerFieldUp = new Timer.periodic(timerFieldUpDuration, (_) => _currentField.timerFieldUp());
        timerGravity = new Timer.periodic(timerGravityDuration, (_) => _currentField.timerApplyGravity());
        // set Flag game running
        isGameRunning = true;
        break;
    }

    throw new Exception("not tested yet");
  }

  /**
   * Called by Event handler after a Game Over was recognized
   */
  void gameOver()
  {
    throw new Exception("not implemented yet");
  }

  /**
   * Called by Event handler after the Level was successful ended
   */
  void win()
  {
    throw new Exception("not implemented yet");
  }
}