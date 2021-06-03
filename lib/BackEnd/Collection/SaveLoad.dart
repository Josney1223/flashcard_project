import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../Flashcard/Deck.dart';

class SaveLoad {
  /*
    Classe que salva ou carrega um deck. 

    Métodos:
    -> void saveFile(String)
    -> String loadFile()
  */

  void saveFile(String jsonDecks) {
    // Salva a coleção de decks no computador
    writeOnFile(jsonDecks);
  }

  String loadFile() {
    // Carrega uma coleção de decks que está no computador
    String jsonContent;
    readFile().then((value) {
      jsonContent = value;
    });
    return jsonContent;
  }

  Future<String> get _localPath async {
    // Path dos documentos do PC/Android/iOS
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    // O arquivo que será salvo
    final path = await _localPath;
    final kado = 'KadoApp';
    final collection = 'collection.json';

    return File(p.join(path, kado, collection));
  }

  void writeOnFile(String content) async {
    final file = await _localFile;

    // Escreve no arquivo
    file.writeAsString(content);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }
}
