import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

/// Salva a coleção de decks no celular.
Future<void> save(String jsonDecks) async {
  await _writeOnFile(jsonDecks);
}

/// Carrega a coleção de decks que está no celular.
Future<String> load() async {
  File file = await _localFile;
  return _readFileFromPath(file);
}

Future<File> _writeOnFile(String content) async {
  // Escreve no arquivo
  final file = await _localFile;

  return file.writeAsString(content);
}

Future<String> _readFileFromPath(File file) async {
  try {
    // Le o arquivo
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    // Se encontrou um erro, retorna string vazia

    return '';
  }
}

Future<String> get _localPath async {
  // Path dos documentos do Android e iOS
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  // O arquivo que será salvo ou lido no celular
  final path = await _localPath;
  final collection = 'KadoCollection.json';
  final completePath = p.join(path, collection);

  File newFile = new File(completePath);
  return newFile;
}
