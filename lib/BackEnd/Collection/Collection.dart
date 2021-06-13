import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import '../Flashcard/Deck.dart';
import 'SaveLoad/SaveLoadMobile.dart'
    if (dart.library.html) 'SaveLoad/SaveLoadWeb.dart';

import 'dart:convert';
part 'Collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection extends ChangeNotifier {
  /*
    Classe que gerencia a coleção dos decks de Flashcards do usuário (this._decks). 

    Métodos:
    -> void createDeck(String deckName)
    -> void deleteDeck(String deckName)
    -> void editDeck(String deckName)
    -> void importDeck(String path)    
    -> void exportDeck(String deckName, String path)
    -> void saveFile(List<Deck> decks)
    -> List<Deck> loadFile()
    -> int findDeck(String deckName)
  */

  List<Deck> decks;
  static const REMOVER = 0, INSERIR = 1, MODIFICAR = 2;

  Collection({this.decks}) {
    if (this.decks == null) {
      this.decks = [];
    }
    loadFile();
  }

  void createDeck(String deckName) {
    // Cria um deck novo para o usuário utilizando o nome escolhido
    // o nome escolhido não pode ser repetido

    // Se já não existe um deck com o mesmo nome, adicione no final
    this.decks.add(new Deck(_correctName(deckName)));
    notifyListeners();
  }

  void deleteDeck(String deckName) {
    // Deleta um deck da coleção

    int index = findDeck(deckName);

    if (index >= 0) {
      this.decks.removeAt(index);
      notifyListeners();
    }
  }

  void editDeck(String deckName, int operacao, Flashcard card,
      {Flashcard replaceCard}) {
    // Edita um deck da coleção, dando as opções de selecionar, remover,
    // adicionar ou modificar um flashcard, ou voltar para a coleção

    int index = findDeck(deckName);

    if (index >= 0) {
      switch (operacao) {
        // Remover flashcard
        case REMOVER:
          if (this.decks[index].checkContains(card)) {
            this.decks[index].removeCard(card);
          }
          break;

        // Inserir flashcard
        case INSERIR:
          this.decks[index].insertCard(card);
          break;

        // Modificar flashcard
        case MODIFICAR:
          if (this.decks[index].checkContains(card)) {
            if (replaceCard != null) {
              this.decks[index].removeCard(card);
              this.decks[index].insertCard(replaceCard);
            }
          }
          break;
      }
    }

    notifyListeners();
  }

  void importDeck(String jsonDeck) {
    Deck deck;

    try {
      deck = Deck.fromJson(jsonDecode(utf8.decode(jsonDeck.codeUnits)));
    } catch (e) {
      try {
        deck = Deck.fromJson(jsonDecode(jsonDeck));
      } catch (e) {
        notify("Náo foi possivel carregar o deck");
      }
    }

    // Se existir um deck com os parametros
    if (deck != null) {
      deck.setName(_correctName(deck.getName()));
      this.decks.add(deck);
    } else {
      notify('O deck não foi reconhecido');
    }
    notifyListeners();
  }

  String exportDeck(String deckName) {
    // Chama a função exportDeck da classe ImportExport
    int index = findDeck(deckName);
    String encodedDeck;

    if (index >= 0) {
      encodedDeck = jsonEncode(this.decks[index].toJson());
    } else {
      // O deck com o deckName não foi encontrado
      notify('O deck não foi encontrado');
    }
    return encodedDeck;
  }

  void saveFile() {
    // Chama a função saveFile da classe SaveLoad
    save(jsonEncode(this.decks));
  }

  Future<void> loadFile() async {
    // Chama a função loadFile da classe SaveLoad

    String jsonLoaded = await load();
    if (jsonLoaded == '') {
      notify('Arquivo não encontrado');
    } else {
      try {
        List<dynamic> dynamicList =
            jsonDecode(utf8.decode(jsonLoaded.codeUnits));
        List<Deck> collectionList = [];

        for (var item in dynamicList) {
          collectionList.add(Deck.fromJson(item));
        }
        this.decks = collectionList;
      } catch (e) {
        notify('Arquivo corrompido');
      }
    }
    notifyListeners();
  }

  int findDeck(String deckName) {
    // Procura um deck na lista de decks e retorna o index, se não existir então
    // a posição -1 é retornada
    int index = -1;

    int tam = this.decks.length;
    bool found = false;

    if (tam > 0) {
      // Varre a lista procurando alguém com o mesmo nome
      while (index < tam - 1 && !found) {
        index++;
        if (this.decks[index].getName() == deckName) found = true;
      }
    }

    // Se saiu do loop, mas não achou então muda pra o index pra -1
    if (!found) {
      index = -1;
    }
    return index;
  }

  Deck getDeck(String deckName) {
    // Retorna um deck da lista de decks com o nome deckName

    int index = findDeck(deckName);

    if (index >= 0) {
      return this.decks[index];
    }
    return null;
  }

  void setDeckName(String deckName, String newDeckName) {
    int index = findDeck(deckName);

    if (index >= 0) {
      this.decks[index].setName(newDeckName);
    }
    notifyListeners();
  }

  String _correctName(String nome) {
    // Verifica se já existe um deck com o nome e existe, então mude o nome

    // Se existir um deck com mesmo nome, então muda o nome
    if (findDeck(nome) >= 0) {
      int copies = 1;
      bool exist = true;
      while (exist) {
        if (findDeck(nome + '$copies') < 0) {
          exist = false;
          nome = nome + '$copies';
        } else {
          copies++;
        }
      }
    }
    return nome;
  }

  // Funções de Json
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  void notify(String error) {
    //Avisa que deu um erro
  }
}
