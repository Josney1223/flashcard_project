import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';

import 'Flashcard.dart';
import "dart:core";
import "dart:math";

import 'package:json_annotation/json_annotation.dart';
part 'FlashcardList.g.dart';

@JsonSerializable(explicitToJson: true)
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

  List<Flashcard> flashcardList;

  FlashcardList({this.flashcardList}) {
    if (this.flashcardList == null) {
      this.flashcardList = new List<Flashcard>();
    }
  }

  void add(Flashcard card) {
    // Adiciona um Flashcard na lista
    this.flashcardList.add(card);
  }

  void remove(Flashcard card) {
    // Remove todas as instancias de um Flashcard da lista
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

  bool checkContains(Flashcard card) {
    // Valida se já existe um Flashcard X na lista
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

  int lenght() {
    // Retorna um int com o tamanho atual da lista
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

  factory FlashcardList.fromJson(Map<String, dynamic> json) =>
      _$FlashcardListFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardListToJson(this);
}
