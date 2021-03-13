import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../Flashcard/Deck.dart';

class SaveLoad {
  /*
    Classe que salva ou carrega um deck. 

    Métodos:
    -> void saveFile(List<Deck>)
    -> List<Deck> loadFile()
  */

  void saveFile(List<Deck> decks) {
    // salva a coleção de decks no computador
    Deck a = new Deck('a');
  }

  List<Deck> loadFile() {
    // carrega uma coleção de decks que está no computador
    List<Deck> a = [];
    return a;
  }
}
