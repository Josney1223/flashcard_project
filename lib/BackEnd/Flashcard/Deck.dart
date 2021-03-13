import 'Flashcard.dart';
import 'FlashcardList.dart';

class Deck {
  /*
    Classe que gerencia um baralho completo de Flashcards, sendo esse composto 
    por um número X de Flashcards (this._qtdFlashcards). Ele possue um nome 
    (this._deckName) para facilitar identificacao e se compoe por duas
    FlashcardList (this._deck e this.grave).

    Métodos:
    -> void reset()
    -> String getName()
    -> int getQtd()
    -> Flashcard pullCard()    
    -> void insertCard(Flashcard card)
    -> void insertCards(List<Flashcard> cards)
    -> void removeCard(Flashcard card)
    -> bool checkContains(Flashcard card)
  */

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
    // Coloca todos os Flashcards contidos em this._grave em this._deck e
    // reinicia o this.grave
    for (var i = 0; i < this._grave.lenght(); i++) {
      this._deck.add(this._grave.getCard(i));
    }
    this._grave = new FlashcardList();
  }

  String getName() {
    // Retorna o nome do baralho
    return this._deckName;
  }

  int getQtd() {
    // Retorna o tamanho do baralho
    return this._qtdFlashcards;
  }

  Flashcard pullCard() {
    // Remove um Flashcard do this._deck, insere ele no this._grave e o retorna
    if (this._deck.lenght() == 0) {
      reset();
    }
    Flashcard card = this._deck.getRandomCard();
    this._deck.remove(card);
    this._grave.add(card);
    return card;
  }

  void insertCard(Flashcard card) {
    // Insere um Flashcard em this._deck
    this._deck.add(card);
    this._qtdFlashcards++;
  }

  void insertCards(FlashcardList cards) {
    for (var i = 0; i < cards.lenght(); i++) {
      this._deck.add(cards.getCard(i));
    }
  }

  void removeCard(Flashcard card) {
    // Remove um Flashcard em this._deck
    reset();
    this._deck.remove(card);
    this._qtdFlashcards--;
  }

  bool checkContains(Flashcard card) {
    // Retorna true caso tenha encontrado uma cópia identica do Flashcard
    // dentro do deck
    reset();
    return this._deck.checkContains(card);
  }
}
