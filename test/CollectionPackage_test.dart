import 'dart:convert';
import 'dart:io';

import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    // Create a temporary directory.
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

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
      int remover = Collection.REMOVER,
          adicionar = Collection.INSERIR,
          modificar = Collection.MODIFICAR;
      Flashcard card = new Flashcard('Gato', 'Felis catus'),
          newCard = new Flashcard('Lobo', 'Canis lupus');

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
      int adicionar = Collection.INSERIR;
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

    test('Collection: Validar o métodos que salvam e carregam', () async {
      Collection colecao = new Collection();
      int inserir = Collection.INSERIR;
      Flashcard card1 = new Flashcard('Cachorro', 'Canis lupus familiaris'),
          card2 = new Flashcard('Pega-rabuda', 'Pica Pica'),
          card3 = new Flashcard('Gato', 'Felis silvestris catus'),
          card4 = new Flashcard('火', 'Fogo'),
          card5 = new Flashcard('水', 'Água'),
          card6 = new Flashcard('月 ', 'Lua');
      var cards = [card1, card2, card3, card4, card5, card6];

      colecao.createDeck('Taxonomia');
      colecao.createDeck('Kanji');

      // Adicionar uma carta ao deck
      colecao.editDeck('Taxonomia', inserir, card1);
      colecao.editDeck('Taxonomia', inserir, card2);
      colecao.editDeck('Taxonomia', inserir, card3);

      colecao.editDeck('Kanji', inserir, card4);
      colecao.editDeck('Kanji', inserir, card5);
      colecao.editDeck('Kanji', inserir, card6);

      // Salvar
      colecao.saveFile();

      // Criar um deck novo que irá carregar as informações
      Collection colecaoCarregada = new Collection();

      // Carrega
      await colecaoCarregada.loadFile();

      // Compara os dois decks para ver se são iguais
      expect(colecaoCarregada.decks.length, colecao.decks.length);
      for (int i = 0; i < colecaoCarregada.decks.length; i++) {
        expect(colecaoCarregada.decks[i].getName(), colecao.decks[i].getName());
        expect(colecaoCarregada.decks[i].getQtd(), colecao.decks[i].getQtd());
        for (int k = 0; k < cards.length; k++) {
          expect(colecaoCarregada.decks[i].deck.checkContains(cards[k]),
              colecao.decks[i].deck.checkContains(cards[k]));
        }
      }
    });

    test('Collection: Validar o métodos que importam e exportam', () {
      Collection colecao = new Collection();
      int inserir = Collection.INSERIR;
      Flashcard card1 = new Flashcard('Cachorro', 'Canis lupus familiaris'),
          card2 = new Flashcard('Pega-rabuda', 'Pica Pica'),
          card3 = new Flashcard('Gato', 'Felis silvestris catus'),
          card4 = new Flashcard('火', 'Fogo'),
          card5 = new Flashcard('水', 'Água'),
          card6 = new Flashcard('月 ', 'Lua');
      String exportedDeck1 = 'Taxonomia';

      colecao.createDeck(exportedDeck1);
      colecao.createDeck('Kanji');

      // Adicionar uma carta ao deck
      colecao.editDeck(exportedDeck1, inserir, card1);
      colecao.editDeck(exportedDeck1, inserir, card2);
      colecao.editDeck(exportedDeck1, inserir, card3);

      colecao.editDeck('Kanji', inserir, card4);
      colecao.editDeck('Kanji', inserir, card5);
      colecao.editDeck('Kanji', inserir, card6);

      String exportString = colecao.exportDeck(exportedDeck1);

      Map<String, dynamic> jsonExported =
          jsonDecode(utf8.decode(base64.decode(exportString)));

      Deck exportedDeck = Deck.fromJson(jsonExported);

      expect(exportedDeck1, exportedDeck.deckName);
      expect(true, exportedDeck.deck.checkContains(card1));
      expect(true, exportedDeck.deck.checkContains(card2));
      expect(true, exportedDeck.deck.checkContains(card3));
      expect(false, exportedDeck.deck.checkContains(card4));
      expect(false, exportedDeck.deck.checkContains(card5));
      expect(false, exportedDeck.deck.checkContains(card6));
    });
  });
}
