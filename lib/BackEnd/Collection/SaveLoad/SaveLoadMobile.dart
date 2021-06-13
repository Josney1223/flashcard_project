import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

Future<void> save(String jsonDecks) async {
  // Salva a coleção de decks no celular
  await writeOnFile(jsonDecks);
}

Future<String> load() async {
  File file = await _localFile;
  return readFileFromPath(file);
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
