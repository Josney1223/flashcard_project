import 'Flashcard.dart';
import "dart:core";
import "dart:math";

class FlashcardList {
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
      }
      i++;
    }
  }

  bool checkContais(Flashcard card) {
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
    return this.flashcardList[index];
  }

  Flashcard getRandomCard() {
    Random random = Random();
    int randomNumber = random.nextInt(this.flashcardList.length);
    return this.flashcardList[randomNumber];
  }
}
