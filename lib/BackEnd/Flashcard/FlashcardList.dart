part of flashcard_package;

/// Classe que contém uma lista para armazenar Flashcards.
@JsonSerializable(explicitToJson: true)
class FlashcardList {
  /// A lista que contém os Flashcards
  List<Flashcard> flashcardList;

  /// Método Construtor
  FlashcardList({this.flashcardList}) {
    if (this.flashcardList == null) {
      this.flashcardList = [];
    }
  }

  /// Adiciona um Flashcard na lista
  void add(Flashcard card) {
    this.flashcardList.add(card);
  }

  /// Remove todas as instancias de um Flashcard da lista
  void remove(Flashcard card) {
    int i = 0;
    bool contains = false;
    while (i < this.flashcardList.length && contains == false) {
      if (card.getFace() == this.flashcardList[i].getFace() &&
          card.getBack() == this.flashcardList[i].getBack()) {
        this.flashcardList.removeAt(i);
        contains = true;
      } else {
        i++;
      }
    }
  }

  /// Substitui a lista de Flashcards por fl
  void setFlashcardList(List<Flashcard> fl) {
    this.flashcardList = List.from(fl);
  }

  /// Retorna a lista de Flashcards
  List<Flashcard> getFlashcardList() {
    return this.flashcardList;
  }

  /// Valida se já existe um Flashcard card na lista
  bool checkContains(Flashcard card) {
    int i = 0;
    bool contains = false;
    while (i < this.flashcardList.length && contains == false) {
      if (card.getFace() == this.flashcardList[i].getFace() &&
          card.getBack() == this.flashcardList[i].getBack()) {
        contains = true;
      }
      i++;
    }
    return contains;
  }

  /// Retorna o tamanho atual da lista
  int lenght() {
    return this.flashcardList.length;
  }

  /// Retorna o Flashcard da posicao 'index' da lista
  Flashcard getCard(int index) {
    return this.flashcardList[index];
  }

  /// Retorna o próximo Flashcard da List
  Flashcard getNextCard() {
    return this.flashcardList.first;
  }

  /// Retorna um Flashcard aleatório da List
  Flashcard getRandomCard() {
    Random random = Random();
    int randomNumber = random.nextInt(this.flashcardList.length);
    return this.flashcardList[randomNumber];
  }

  factory FlashcardList.fromJson(Map<String, dynamic> json) =>
      _$FlashcardListFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardListToJson(this);
}
