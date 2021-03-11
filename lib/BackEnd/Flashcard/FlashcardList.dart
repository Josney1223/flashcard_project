import 'Flashcard.dart';
import "dart:core";
import "dart:math";

class FlashcardList {
  // Classe que contém uma lista
  List<Flashcard> flashcardList;

  FlashcardList() {
    this.flashcardList = new List<Flashcard>();
  }

  void add(Flashcard card) {
    this.flashcardList.add(card);
  }

  void remove(Flashcard card) {
    int i = 0;
    while (i < this.flashcardList.length) {
      if (card == this.flashcardList[i]) {
        this.flashcardList.removeAt(i);
      } else {
        i++;
      }
    }
  }

  bool checkContains(Flashcard card) {
    int i = 0;
    bool contains = false;
    while (i < this.flashcardList.length && contains == false) {
      if (card == this.flashcardList[i]) {
        contains = true;
      }
      i++;
    }
    return contains;
  }

  int lenght() {
    return this.flashcardList.length;
  }

  Flashcard getCard(int index) {
    // Retorna o Flashcard que está na posicao 'index' da List
    return this.flashcardList[index];
  }

  Flashcard getRandomCard() {
    // Retorna um Flashcard aleatório da List
    Random random = Random();
    int randomNumber = random.nextInt(this.flashcardList.length);
    return this.flashcardList[randomNumber];
  }
}
