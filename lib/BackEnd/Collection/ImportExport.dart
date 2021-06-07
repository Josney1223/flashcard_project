import 'dart:convert';

import '../Flashcard/Deck.dart';

class ImportExport {
  /*
    Classe que gerencia a importação e exportação de deck. 

    Métodos:
    -> Deck importDeck(String path)
    -> bool exportDeck(Deck deck)
  */

  Map<String, dynamic> importDeck(String base64Deck) {
    // Importa um deck apartir de um arquivo json em base64.
    String stringDeck = utf8.decode(base64.decode(base64Deck));

    return jsonDecode(stringDeck);
  }

  String exportDeck(Map<String, dynamic> chosenDeck) {
    // Cria uma String em base64 com base no Json do Deck para exportá-lo.
    String jsonDeck = jsonEncode(chosenDeck);

    return base64Encode(utf8.encode(jsonDeck));
  }
}
