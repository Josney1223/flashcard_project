import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import '../Flashcard/Deck.dart';
import 'ImportExport.dart';

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

  Collection({this.decks}) {
    if (this.decks == null) {
      this.decks = [];
    }
  }

  void createDeck(String deckName) {
    // Cria um deck novo para o usuário utilizando o nome escolhido
    // o nome escolhido não pode ser repetido

    // Se já não existe um deck com o mesmo nome, adicione no final
    if (findDeck(deckName) < 0) {
      this.decks.add(new Deck(deckName));
      notifyListeners();
    }
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
        case 0:
          if (this.decks[index].checkContains(card)) {
            this.decks[index].removeCard(card);
          }
          break;

        // Adicionar flashcard
        case 1:
          this.decks[index].insertCard(card);
          break;

        // Modificar flashcard
        case 2:
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

  void importDeck(String path) {
    // Chama a função importDeck da classe ImportExport
    ImportExport file = new ImportExport();

    Deck deck = file.importDeck(path);
    // Se o arquivo existir
    if (deck != null) {
      // e se não tiver um com mesmo nome, então bota o deck na coleção
      if (findDeck(deck.getName()) < 0) {
        this.decks.add(deck);
        notifyListeners();
      }
    } else {
      // O deck no caminho especificado
      notify('nao sei o padrao ainda');
    }
  }

  void exportDeck(String deckName, String path) {
    // Chama a função exportDeck da classe ImportExport
    ImportExport file = new ImportExport();
    int index = findDeck(deckName);

    if (index >= 0) {
      if (!file.exportDeck(jsonEncode(this.decks))) {
        // export deu errado
      }
    } else {
      // O deck com o deckName não foi encontrado
      notify('nao sei que mensagem mandar');
    }
  }

  void saveFile(List<Deck> decks) {
    // Chama a função saveFile da classe SaveLoad
  }

  List<Deck> loadFile() {
    // Chama a função loadFIle da classe SaveLoad
  }

  int findDeck(String deckName) {
    // Procura um deck na lista de decks e retorna o index, se não existir então
    // a posição -1 é retornada
    int index = -1;

    int tam = this.decks.length;
    bool found = false;

    if (tam > 0) {
      // Varre a lista procurando alguém com o mesmo nome
      while (index < tam && !found) {
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

  // Funções de Json
  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  void notify(String error) {
    //Avisa que deu um erro
  }
}
