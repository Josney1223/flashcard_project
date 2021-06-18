import 'package:flashcard_project/BackEnd/Flashcard/Flashcard_Package.dart';

/// Classe que passa informações para outras telas
class ScreenArgumentsFC {
  final Flashcard flashcard;
  final Deck deck;
  ScreenArgumentsFC(this.deck, this.flashcard);
}
