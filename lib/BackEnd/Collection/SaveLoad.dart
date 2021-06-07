import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SaveLoad {
  /*
    Classe que salva ou carrega um deck. 

    Métodos:
    -> void saveFile(String)
    -> Future<String> loadFile()
  */

  void saveFile(String jsonDecks) {
    // Salva a coleção de decks no computador
    writeOnFile(jsonDecks).then((value) => null);
  }

  Future<String> loadFile() async {
    // Carrega uma coleção de decks que está no computador
    File file;
    if (kIsWeb) {
      // se está rodando na web
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
      if (result != null) {
        try {
          String jsonString =
              new String.fromCharCodes(result.files.first.bytes);
          return jsonString;
        } catch (e) {
          // Se não foi enviado nada ou der um erro de conversão
          return '';
        }
      }
    } else {
      file = await _localFile;
    }
    return readFileFromPath(file);
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

  Future<String> readFileFromPath(File file) async {
    try {
      // Le o arquivo
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // Se encontrou um erro, retorna string vazia

      return '';
    }
  }
}
