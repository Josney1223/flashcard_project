import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';

Future<void> save(String jsonDecks) async {
  // prepare
  final bytes = utf8.encode(jsonDecks);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'KadoCollection.json';
  html.document.body.children.add(anchor);

  // download
  anchor.click();

  // cleanup
  html.document.body.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

Future<String> load() async {
  FilePickerResult result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['json']);
  String jsonString = '';
  if (result != null) {
    try {
      jsonString = new String.fromCharCodes(result.files.first.bytes);
    } catch (e) {
      // Se não foi enviado nada ou der um erro de conversão retornar vazia
    }
  }
  return jsonString;
}
