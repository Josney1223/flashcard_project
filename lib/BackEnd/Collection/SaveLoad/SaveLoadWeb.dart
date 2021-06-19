import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';

/// Faz o download de uma coleção de decks no computador.
Future<void> save(String jsonDecks) async {
  // Inicializa as variaveis para fazer o download
  final bytes = utf8.encode(jsonDecks);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'KadoCollection.json';
  html.document.body.children.add(anchor);

  // Download do arquivo
  anchor.click();

  // O download acabou, então limpa
  html.document.body.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

/// Carrega uma coleção de decks que está no computador.
Future<String> load() async {
  FilePickerResult result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
  String jsonString = '';
  if (result != null) {
    try {
      jsonString = new String.fromCharCodes(result.files.first.bytes);
    } catch (e) {
      // Se não foi enviado nada ou der um erro de conversão retornar ''
    }
  }
  return jsonString;
}
