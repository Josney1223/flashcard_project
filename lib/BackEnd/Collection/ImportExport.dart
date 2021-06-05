import 'dart:convert';

import '../Flashcard/Deck.dart';
import '../Flashcard/Flashcard.dart';
import '../Flashcard/FlashcardList.dart';

class ImportExport {
  /*
    Classe que gerencia a importação e exportação de deck. 

    Métodos:
    -> Deck importDeck(String path)
    -> bool exportDeck(Deck deck)
  */

  Deck importDeck(String path) {
    // Importa um deck que está localizado no computador
    Deck a = new Deck('a');
    return a;
  }

  bool exportDeck(String jsonSent) {
    // Exporta um deck para algum local no computador
    Map<String, dynamic> json = jsonDecode(jsonSent);

    for (int i = 0; i < 0; i++) {}

    return true;
  }
}
