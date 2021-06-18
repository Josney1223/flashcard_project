part of flashcard_package;

/// Classe que gerencia um baralho completo de Flashcards
@JsonSerializable(explicitToJson: true)
class Deck {
  /// O baralho
  @JsonKey(required: true, disallowNullValue: true)
  FlashcardList deck;

  /// Uma cópia do baralho
  @JsonKey(required: false, disallowNullValue: true)
  FlashcardList deckCopy;

  /// Quantidade de Flashcards no baralho
  @JsonKey(required: true, disallowNullValue: true)
  int qtdFlashcards;

  /// Nome do baralho
  @JsonKey(required: true, disallowNullValue: true)
  String deckName;

  /// Método construtor
  Deck(this.deckName, {this.deck, this.qtdFlashcards}) {
    this.deck = (deck == null) ? new FlashcardList() : deck;
    this.qtdFlashcards =
        (qtdFlashcards == null) ? this.deck.lenght() : qtdFlashcards;
    this.deckCopy = new FlashcardList.fromJson(this.deck.toJson());
  }

  /// Reinicia o deck usando como parametro o deckCopy
  void reset() {
    this.deck.setFlashcardList(this.deckCopy.getFlashcardList());
  }

  /// Insere um Flashcard em deck e em deckCopy
  void insertCard(Flashcard card) {
    this.deck.add(card);
    this.deckCopy.add(card);
    this.qtdFlashcards++;
  }

  /// Insere uma lista de Flashcards em deck e em deckCopy
  void insertCards(FlashcardList cards) {
    for (var i = 0; i < cards.lenght(); i++) {
      this.deck.add(cards.getCard(i));
    }
  }

  /// Remove um Flashcard do deck e do deckCopy
  void removeCard(Flashcard card) {
    this.reset();
    this.deck.remove(card);
    this.deckCopy.remove(card);
    this.qtdFlashcards--;
  }

  /// Retorna o nome do baralho
  String getName() {
    return this.deckName;
  }

  /// Altera o nome do baralho
  void setName(String newName) {
    this.deckName = newName;
  }

  /// Retorna o tamanho do baralho
  int getQtd() {
    return this.qtdFlashcards;
  }

  /// Remove um Flashcard aleatoriamente do deck e o retorna
  Flashcard pullRandomCard() {
    if (this.deck.lenght() == 0) {
      return null;
    }
    Flashcard card = this.deck.getRandomCard();
    this.deck.remove(card);
    return card;
  }

  /// Remove o proximo Flashcard do deck e o retorna
  Flashcard pullCard() {
    if (this.deck.lenght() == 0) {
      return null;
    }
    Flashcard card = this.deck.getNextCard();
    this.deck.remove(card);
    return card;
  }

  /// Valida se há uma cópia identica do Flashcard card dentro do deck
  bool checkContains(Flashcard card) {
    this.reset();
    return this.deck.checkContains(card);
  }

  /// Retorna uma copia do deck
  FlashcardList getCopy() {
    this.reset();
    return this.deck;
  }

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);

  Map<String, dynamic> toJson() => _$DeckToJson(this);
}
