import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SaveLoad {
  /*
    Classe que salva ou carrega um deck. 

    Métodos:
    -> void saveFile(String)
    -> String loadFile()
  */

  void saveFile(String jsonDecks) {
    // Salva a coleção de decks no computador
    writeOnFile(jsonDecks).then((value) => null);
  }

  Future<String> loadFile() {
    // Carrega uma coleção de decks que está no computador
    String jsonContent;

    return readFile();
  }

  Future<String> get _localPath async {
    // Path dos documentos do PC/Android/iOS
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    // O arquivo que será salvo
    final path = await _localPath;
    final collection = 'KadoCollection.json';
    final completePath = p.join(path, collection);

    File newFile = new File(completePath);
    return newFile;
  }

  Future<File> writeOnFile(String content) async {
    final file = await _localFile;

    // Escreve no arquivo
    return file.writeAsString(content);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Le o arquivo
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // Se encontrou um erro, retorna string vazia
      return '';
    }
  }
}
