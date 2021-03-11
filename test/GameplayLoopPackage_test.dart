import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flashcard_project/BackEnd/GameplayLoop/GameplayLoop.dart';
import 'package:flutter_test/flutter_test.dart';

int main() {
  group("Gameplay", () {
    GameplayLoop game;

    test("Validar a criacao de um GameplayLoop", () {
      Deck deck = new Deck("StarterDeck");
      Flashcard card = new Flashcard("Face", "Back");
      deck.insertCard(card);

      game = new GameplayLoop(deck);
      bool result = false;

      if (game is GameplayLoop) {
        result = true;
      }

      expect(result, true);
    });

    test("Validar o metodo setDeck", () {
      Deck newDeck = new Deck("SecondDeck");
      Flashcard card = new Flashcard("Face2", "Back2");
      newDeck.insertCard(card);
      game.setDeck(newDeck);
      expect(game.nextCard().getBack(), "Back2");
    });

    test("Validar o metodo nextCard", () {
      Flashcard nextCard = game.nextCard();

      bool result = false;

      if (nextCard.getFace() == "Face2" && nextCard.getBack() == "Back2") {
        print(nextCard.getFace());
        result = true;
      }

      expect(result, true);
    });

    test("Validar o metodo getScore", () {
      expect(game.getScore(), 0);
    });
  });
}
