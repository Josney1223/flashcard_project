import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';

class ScreenArgumentsFC {
  final Flashcard flashcard;
  final Deck deck;
  ScreenArgumentsFC(this.deck, this.flashcard);
}
