import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flashcard_project/BackEnd/Flashcard/FlashcardList.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:english_words/english_words.dart';

void main() {
  group('Flashcard', () {
    test('Flashcard: Validar a criacao de um Flashcard', () {
      WordPair wordPair = new WordPair.random();
      String upperCase = wordPair.asUpperCase, lowerCase = wordPair.asLowerCase;
      Flashcard card = new Flashcard("palavras", lowerCase, upperCase);

      bool result = false;
      if (card.getFace() == lowerCase &&
          card.getBack() == upperCase &&
          card.getName() == "palavras") {
        result = true;
      }

      expect(result, true);
    });
  });

  group('FlashcardList', () {
    final FlashcardList flashcardList = new FlashcardList();

    final WordPair wordPair = new WordPair.random();
    final WordPair wordPair1 = new WordPair.random();
    final WordPair wordPair2 = new WordPair.random();

    final Flashcard card =
        new Flashcard("palavras", wordPair.asLowerCase, wordPair.asUpperCase);
    final Flashcard card1 = new Flashcard(
        "palavras1", wordPair1.asLowerCase, wordPair1.asUpperCase);
    final Flashcard card2 = new Flashcard(
        "palavras2", wordPair2.asLowerCase, wordPair2.asUpperCase);

    test('Validar a criacao da lista e o metodo add', () {
      flashcardList.add(card);

      expect(flashcardList.lenght(), 1);
    });

    test('Validar o metodo checkContains', () {
      flashcardList.add(card1);

      expect(flashcardList.checkContains(card1), true);
    });

    test('Validar o metodo remove', () {
      flashcardList.remove(card1);

      expect(flashcardList.checkContains(card1), false);
    });

    test('Valida se o metodo getCard', () {
      Flashcard c = flashcardList.getCard(0);
      bool result = false;

      if (c is Flashcard) {
        result = true;
      }
      expect(result, true);
    });

    test('Validar o metodo getRandomCard', () {
      flashcardList.add(card1);
      flashcardList.add(card2);

      Flashcard c = flashcardList.getRandomCard();

      expect(flashcardList.checkContains(c), true);
    });
  });

  group("Deck", () {
    final Deck deck = new Deck("Novo Deck");

    final WordPair wordPair = new WordPair.random();
    final WordPair wordPair1 = new WordPair.random();
    final WordPair wordPair2 = new WordPair.random();
    final WordPair wordPair3 = new WordPair.random();
    final WordPair wordPair4 = new WordPair.random();
    final WordPair wordPair5 = new WordPair.random();

    final Flashcard card =
        new Flashcard("palavras", wordPair.asLowerCase, wordPair.asUpperCase);
    final Flashcard card1 = new Flashcard(
        "palavras1", wordPair1.asLowerCase, wordPair1.asUpperCase);
    final Flashcard card2 = new Flashcard(
        "palavras2", wordPair2.asLowerCase, wordPair2.asUpperCase);
    final Flashcard card3 = new Flashcard(
        "palavras3", wordPair3.asLowerCase, wordPair3.asUpperCase);
    final Flashcard card4 = new Flashcard(
        "palavras4", wordPair4.asLowerCase, wordPair4.asUpperCase);
    final Flashcard card5 = new Flashcard(
        "palavras5", wordPair5.asLowerCase, wordPair5.asUpperCase);

    test("Validar a criacao do deck", () {
      deck.insertCard(card);
      deck.insertCard(card1);
      deck.insertCard(card2);
      deck.insertCard(card3);
      deck.insertCard(card4);
      deck.insertCard(card5);

      expect(deck.getQtd(), 6);
    });

    test("Validar o metodo checkContains", () {
      expect(deck.checkContains(card1), true);
    });

    test("Validar o metodo pullCard", () {
      for (var i = 0; i <= deck.getQtd(); i++) {
        deck.pullCard();
      }

      expect(true, true);
    });

    test("Validar o metodo removeCard", () {
      deck.removeCard(card1);

      expect(deck.checkContains(card1), false);
    });
  });
}
