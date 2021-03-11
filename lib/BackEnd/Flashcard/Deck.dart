import 'Flashcard.dart';
import 'FlashcardList.dart';

class Deck {
  FlashcardList _deck;
  FlashcardList _grave;
  int _qtdFlashcards;
  String _deckName;

  Deck(String name) {
    this._deckName = name;
    this._deck = new FlashcardList();
    this._grave = new FlashcardList();
    this._qtdFlashcards = this._deck.lenght() + this._grave.lenght();
  }

  void reset() {
    for (var i = 0; i < this._grave.lenght(); i++) {
      this._deck.add(this._grave.getCard(i));
    }
    this._grave = new FlashcardList();
  }

  String getName() {
    return this._deckName;
  }

  int getQtd() {
    return this._qtdFlashcards;
  }

  Flashcard pullCard() {
    if (this._deck.lenght() == 0) {
      reset();
    }
    Flashcard card = this._deck.getRandomCard();
    this._deck.remove(card);
    this._grave.add(card);
    return card;
  }

  void insertCard(Flashcard card) {
    this._deck.add(card);
    this._qtdFlashcards++;
  }

  void insertCards(List<Flashcard> cards) {
    for (var i = 0; i < cards.length; i++) {
      this._deck.add(cards[i]);
    }
  }

  void removeCard(Flashcard card) {
    reset();
    this._deck.remove(card);
    this._qtdFlashcards--;
  }

  bool checkContains(Flashcard card) {
    reset();
    return this._deck.checkContains(card);
  }
}
