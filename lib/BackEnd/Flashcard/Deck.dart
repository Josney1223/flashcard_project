import 'Flashcard.dart';
import 'FlashcardList.dart';

import 'package:json_annotation/json_annotation.dart';
part 'Deck.g.dart';

@JsonSerializable(explicitToJson: true)
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

  @JsonKey(required: true, disallowNullValue: true)
  FlashcardList deck;
  @JsonKey(required: false, disallowNullValue: true)
  FlashcardList deckCopy;
  @JsonKey(required: true, disallowNullValue: true)
  int qtdFlashcards;
  @JsonKey(required: true, disallowNullValue: true)
  String deckName;

  Deck(this.deckName, {this.deck, this.qtdFlashcards}) {
    this.deck = (deck == null) ? new FlashcardList() : deck;
    this.qtdFlashcards =
        (qtdFlashcards == null) ? this.deck.lenght() : qtdFlashcards;
    this.deckCopy = new FlashcardList.fromJson(this.deck.toJson());
  }

  void reset() {
    //Reseta o deck
    print(this.deck.lenght().toString() +
        " " +
        this.deckCopy.lenght().toString());
    this.deck.setFlashcardList(this.deckCopy.getFlashcardList());
  }

  void insertCard(Flashcard card) {
    // Insere um Flashcard em this._deck
    this.deck.add(card);
    this.qtdFlashcards++;
  }

  void insertCards(FlashcardList cards) {
    for (var i = 0; i < cards.lenght(); i++) {
      this.deck.add(cards.getCard(i));
    }
  }

  void removeCard(Flashcard card) {
    // Remove um Flashcard em this._deck
    this.reset();
    this.deck.remove(card);
    this.qtdFlashcards--;
  }

  String getName() {
    // Retorna o nome do baralho
    return this.deckName;
  }

  void setName(String newName) {
    // muda o nome do baralho
    this.deckName = newName;
  }

  int getQtd() {
    // Retorna o tamanho do baralho
    return this.qtdFlashcards;
  }

  Flashcard pullRandomCard() {
    // Remove um Flashcard aleatoriamente do this._deck, insere ele no this._grave e o retorna
    if (this.deck.lenght() == 0) {
      return null;
    }
    Flashcard card = this.deck.getRandomCard();
    this.deck.remove(card);
    return card;
  }

  Flashcard pullCard() {
    // Remove um Flashcard do this._deck, insere ele no this._grave e o retorna
    if (this.deck.lenght() == 0) {
      return null;
    }
    Flashcard card = this.deck.getNextCard();
    this.deck.remove(card);
    return card;
  }

  bool checkContains(Flashcard card) {
    // Retorna true caso tenha encontrado uma cópia identica do Flashcard
    // dentro do deck
    this.reset();
    return this.deck.checkContains(card);
  }

  FlashcardList getCopy() {
    this.reset();
    return this.deck;
  }

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);

  Map<String, dynamic> toJson() => _$DeckToJson(this);
}
