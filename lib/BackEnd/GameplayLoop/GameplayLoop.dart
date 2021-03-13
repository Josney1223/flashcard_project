import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flutter/cupertino.dart';
import '../Flashcard/Deck.dart';

class GameplayLoop extends ChangeNotifier {
  Deck _deck;
  int _score;
  Flashcard _actualFlashcard;

  GameplayLoop(Deck startDeck) {
    this._deck = startDeck;
    this._score = 0;
  }

  void setDeck(Deck newDeck) {
    this._deck = newDeck;
    notifyListeners();
  }

  int getScore() {
    return this._score;
  }

  Flashcard nextCard() {
    this._actualFlashcard = this._deck.pullCard();
    return this._actualFlashcard;
  }
}
