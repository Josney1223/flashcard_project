// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['deck', 'qtdFlashcards', 'deckName'],
      disallowNullValues: const ['deck', 'qtdFlashcards', 'deckName']);
  return Deck(
    json['deckName'] as String,
    deck: json['deck'] == null
        ? null
        : FlashcardList.fromJson(json['deck'] as Map<String, dynamic>),
    qtdFlashcards: json['qtdFlashcards'] as int,
  );
}

Map<String, dynamic> _$DeckToJson(Deck instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deck', instance.deck?.toJson());
  writeNotNull('qtdFlashcards', instance.qtdFlashcards);
  writeNotNull('deckName', instance.deckName);
  return val;
}
