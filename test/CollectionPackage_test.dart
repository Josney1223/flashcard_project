import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:english_words/english_words.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'dart:convert';

void main() {
  group('Collection', () {
    test('Collection: Validar o método createDeck', () {
      Collection colecao = new Collection();
      String deckName = 'Nome do Deck';

      Deck result = colecao.getDeck(deckName);
      expect(result, null);

      colecao.createDeck(deckName);
      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 0);
    });

    test('Collection: Validar o método deleteDeck', () {
      Collection colecao = new Collection();
      String deckName = 'Nome do Deck';
      Deck result;

      colecao.createDeck(deckName);
      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 0);

      colecao.deleteDeck(deckName);

      result = colecao.getDeck(deckName);
      expect(result, null);
    });

    test('Collection: Validar o método editDeck', () {
      Collection colecao = new Collection();
      String deckName = 'Nome do Deck';
      Deck result;
      int remover = 0, adicionar = 1, modificar = 2;
      Flashcard card = new Flashcard('Gato', 'Felis catus'),
          newCard = new Flashcard('Lobo', 'Canis lupus');
      Collection resultObject;

      colecao.createDeck(deckName);
      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 0);

      // Adicionar uma carta ao deck
      colecao.editDeck(deckName, adicionar, card);

      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 1);
      expect(result.checkContains(card), true);

      // Modificar uma carta do deck
      colecao.editDeck(deckName, modificar, card, replaceCard: newCard);

      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 1);
      expect(result.checkContains(card), false);
      expect(result.checkContains(newCard), true);

      // Remover uma carta do deck
      colecao.editDeck(deckName, remover, newCard);

      result = colecao.getDeck(deckName);
      expect(result.getName(), deckName);
      expect(result.getQtd(), 0);
      expect(result.checkContains(newCard), false);
    });

    test('Collection: Validar as conversoes de Json', () {
      Collection colecao = new Collection();
      String deckName = 'Nome do Deck';
      int adicionar = 1;
      Flashcard card = new Flashcard('Gato', 'Felis catus');
      Collection resultObject;

      Map<String, dynamic> resultMap = colecao.toJson();
      Map<String, dynamic> json = {
        'decks': [],
      };
      expect(resultMap, json);

      colecao.createDeck(deckName);
      resultMap = colecao.toJson();
      json = {
        'decks': [
          {
            "deckName": deckName,
            "qtdFlashcards": 0,
            "deck": {"flashcardList": []},
            "grave": {"flashcardList": []},
          }
        ],
      };
      expect(resultMap, json);

      resultObject = new Collection.fromJson(resultMap);
      expect(resultObject.decks.length, colecao.decks.length);
      for (int i = 0; i < resultObject.decks.length; i++) {
        expect(resultObject.decks[i].getName(), colecao.decks[i].getName());
        expect(resultObject.decks[i].getQtd(), colecao.decks[i].getQtd());
      }

      colecao.editDeck(deckName, adicionar, card);
      json = {
        'decks': [
          {
            "deckName": deckName,
            "qtdFlashcards": 1,
            "deck": {
              "flashcardList": [
                {"face": 'Gato', 'back': 'Felis catus'}
              ]
            },
            "grave": {"flashcardList": []},
          }
        ],
      };
      resultMap = colecao.toJson();
      expect(resultMap, json);

      resultObject = new Collection.fromJson(resultMap);
      expect(resultObject.decks.length, colecao.decks.length);
      for (int i = 0; i < resultObject.decks.length; i++) {
        expect(resultObject.decks[i].getName(), colecao.decks[i].getName());
        expect(resultObject.decks[i].getQtd(), colecao.decks[i].getQtd());
      }
    });
  });
}
