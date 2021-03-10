import 'Flashcard.dart';
import 'FlashcardList.dart';

class Deck {
  FlashcardList deck;
  FlashcardList grave;
  int qtdFlashcards;
  String deckName;

  Deck(String name) {
    this.deckName = name;
    this.deck = new FlashcardList();
    this.grave = new FlashcardList();
    this.qtdFlashcards = this.deck.lenght() + this.grave.lenght();
  }

  void reset() {
    for (var i = 0; i < this.grave.lenght(); i++) {
      this.deck.add(this.grave.getCard(i));
    }
    this.grave = new FlashcardList();
  }

  String getName() {
    return this.deckName;
  }

  int getQtd() {
    return this.qtdFlashcards;
  }

  Flashcard pullCard() {
    return this.deck.getRandomCard();
  }

  void insertCard(Flashcard card) {
    this.deck.add(card);
  }

  void insertCards(List<Flashcard> cards) {
    for (var i = 0; i < cards.length; i++) {
      this.deck.add(cards[i]);
    }
  }

  void removeCard(Flashcard card) {
    this.deck.remove(card);
  }
}
