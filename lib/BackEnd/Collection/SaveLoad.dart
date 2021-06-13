import 'SaveLoad/SaveLoadMobile.dart'
    if (dart.library.html) 'SaveLoad/SaveLoadWeb.dart';

class SaveLoad {
  /*
    Classe que salva ou carrega um deck. 

    Métodos:
    -> void saveFile(String)
    -> Future<String> loadFile()
  */

  void saveFile(String jsonDecks) {
    // Salva a coleção de decks no aparelho
    save(jsonDecks);
  }

  Future<String> loadFile() async {
    // Carrega uma coleção de decks que está no aparelho
    return await load();
  }
}
