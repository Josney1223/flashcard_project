import 'package:flashcard_project/BackEnd/Flashcard/Flashcard_Package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'SaveLoad/SaveLoadMobile.dart'
    if (dart.library.html) 'SaveLoad/SaveLoadWeb.dart';

import 'dart:convert';
part 'Collection.g.dart';

/// Classe que gerencia a coleção dos decks de Flashcards do usuário
@JsonSerializable(explicitToJson: true)
class Collection extends ChangeNotifier {
  /*
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

  /// A lista contendo todos os decks na coleção
  @JsonKey(required: true, disallowNullValue: true)
  List<Deck> decks;

  /// Constantes utilizadas para as operações de editar o deck
  static const REMOVER = 0, INSERIR = 1, MODIFICAR = 2;

  /// Método construtor
  Collection({this.decks}) {
    if (this.decks == null) {
      this.decks = [];
    }
    loadFile();
  }

  /// Reseta o deck na lista
  void resetDeck(String deckName) {
    int index = findDeck(deckName);

    if (index >= 0) {
      this.decks[index].reset();
      notifyListeners();
    }
  }

  /// Cria um deck vazio novo para o usuário
  void createDeck(String deckName) {
    // O deck é adicionado no final da coleção
    this.decks.add(new Deck(_correctName(deckName)));
    notifyListeners();
  }

  /// Deleta um deck da coleção
  void deleteDeck(String deckName) {
    int index = findDeck(deckName);

    // Se o deck existe, então remove da coleção
    if (index >= 0) {
      this.decks.removeAt(index);
      notifyListeners();
    }
  }

  /// Edita um deck da coleção, podendo remover, adicionar ou modificar um
  /// flashcard
  void editDeck(String deckName, int operacao, Flashcard card,
      {Flashcard replaceCard}) {
    int index = findDeck(deckName);

    // Se o deck existe, então...
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

  /// Importa um deck, dado uma String
  void importDeck(String jsonDeck) {
    Deck deck;

    // Tenta transformar a String num deck
    try {
      deck = Deck.fromJson(jsonDecode(utf8.decode(jsonDeck.codeUnits)));
    } catch (e) {
      try {
        deck = Deck.fromJson(jsonDecode(jsonDeck));
      } catch (e) {
        notify("Náo foi possivel carregar o deck");
      }
    }

    // Se deu para criar um deck, então adiciona no fim da coleção
    if (deck != null) {
      deck.setName(_correctName(deck.getName()));
      this.decks.add(deck);
    } else {
      notify('O deck não foi reconhecido');
    }
    notifyListeners();
  }

  /// Exporta o deck como uma string que representa o JSON do deck
  String exportDeck(String deckName) {
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

  /// Salva a coleção no aparelho
  void saveFile() {
    // Chama a função save da classe SaveLoadWeb ou SaveLoadMobile
    save(jsonEncode(this.decks));
  }

  /// Carrega a coleção no aparelho
  Future<void> loadFile() async {
    // Chama a função load da classe SaveLoadWeb ou SaveLoadMobile

    String jsonLoaded = await load();
    if (jsonLoaded == '') {
      notify('Arquivo não encontrado');
    } else {
      // Se carregou algo, então tenta compreender o JSON
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

  /// Procura um deck na lista de decks e retorna o index, se não existir então
  /// a posição -1 é retornada
  int findDeck(String deckName) {
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

  /// Retorna um deck da lista de decks com o nome deckName
  Deck getDeck(String deckName) {
    int index = findDeck(deckName);

    if (index >= 0) {
      return this.decks[index];
    }
    return null;
  }

  /// Atribui um outro nome para um deck
  void setDeckName(String deckName, String newDeckName) {
    int index = findDeck(deckName);

    if (index >= 0) {
      this.decks[index].setName(newDeckName);
    }
    notifyListeners();
  }

  /// Verifica se já existe um deck com o nome e se existe então muda o nome
  String _correctName(String nome) {
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

  /// Transforma um Map em uma Collection
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  /// Transforma uma Collection em um Map
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  void notify(String error) {
    //Avisa que deu um erro
  }
}
