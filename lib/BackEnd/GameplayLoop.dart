import 'package:flutter/cupertino.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard_Package.dart';

class GameplayLoop extends ChangeNotifier {
  Deck _deck;
  int _miss, _hit;
  bool _end;
  Flashcard _flashcard;

  GameplayLoop() {
    reset();
  }

  void reset() {
    this._miss = 0;
    this._hit = 0;
    this._end = false;
    this._flashcard = null;
  }

  void increaseHit() {
    this._hit++;
    notifyListeners();
  }

  void increaseMiss() {
    this._miss++;
  }

  void nextRandomCard() {
    this._flashcard = this._deck.pullRandomCard();
    if (this._flashcard == null) {
      this._deck.reset();
      this._flashcard = this._deck.pullRandomCard();
      this._end = true;
      this._deck.reset();
    }
    notifyListeners();
  }

  void nextCard() {
    this._flashcard = this._deck.pullCard();
    if (this._flashcard == null) {
      this._deck.reset();
      this._flashcard = this._deck.pullCard();
      this._end = true;
      this._deck.reset();
    }
    notifyListeners();
  }

  void setDeck(Deck deck) {
    this._deck = deck;
    this._deck.reset();
    reset();
    nextCard();
  }

  int getHit() {
    return this._hit;
  }

  int getMiss() {
    return this._miss;
  }

  bool getEnd() {
    return this._end;
  }

  String getFlashcardFace() {
    return this._flashcard.getFace();
  }

  String getFlashcardBack() {
    return this._flashcard.getBack();
  }

  String getDeckName() {
    return this._deck.getName();
  }
}
