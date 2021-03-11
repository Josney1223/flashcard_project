import 'Flashcard.dart';
import "dart:core";
import "dart:math";

class FlashcardList {
  // Classe que contém uma lista
  List<Flashcard> _flashcardList;

  FlashcardList() {
    this._flashcardList = new List<Flashcard>();
  }

  void add(Flashcard card) {
    this._flashcardList.add(card);
  }

  void remove(Flashcard card) {
    int i = 0;
    while (i < this._flashcardList.length) {
      if (card == this._flashcardList[i]) {
        this._flashcardList.removeAt(i);
      } else {
        i++;
      }
    }
  }

  bool checkContains(Flashcard card) {
    int i = 0;
    bool contains = false;
    while (i < this._flashcardList.length && contains == false) {
      if (card.getFace() == this._flashcardList[i].getFace() &&
          card.getBack() == this._flashcardList[i].getBack()) {
        contains = true;
      }
      i++;
    }
    return contains;
  }

  int lenght() {
    return this._flashcardList.length;
  }

  Flashcard getCard(int index) {
    // Retorna o Flashcard que está na posicao 'index' da List
    return this._flashcardList[index];
  }

  Flashcard getRandomCard() {
    // Retorna um Flashcard aleatório da List
    Random random = Random();
    int randomNumber = random.nextInt(this._flashcardList.length);
    return this._flashcardList[randomNumber];
  }
}
