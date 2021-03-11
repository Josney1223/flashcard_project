import 'Flashcard.dart';
import "dart:core";
import "dart:math";

class FlashcardList {
  /* 
  Classe que contém uma lista para armazenar Flashcards. Ao invés de usar 
  diretamente uma lista, criar uma classe especifica limitaria as opcoes sobre
  o que podemos fazer com a lista, deixando o código mais simples.

  A unica variável dentro dessa classe é a lista (this._flashcardList)

  Métodos:
  -> void add(Flashcard card)
  -> void remove(Flashcard card)
  -> bool checkContains(Flashcard card)
  -> int lenght()
  -> Flashcard getCard(int index)
  -> Flashcard getRandomCard()
  */

  List<Flashcard> _flashcardList;

  FlashcardList() {
    this._flashcardList = new List<Flashcard>();
  }

  void add(Flashcard card) {
    // Adiciona um Flashcard na lista
    this._flashcardList.add(card);
  }

  void remove(Flashcard card) {
    // Remove todas as instancias de um Flashcard da lista
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
    // Valida se já existe um Flashcard X na lista
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
    // Retorna um int com o tamanho atual da lista
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
