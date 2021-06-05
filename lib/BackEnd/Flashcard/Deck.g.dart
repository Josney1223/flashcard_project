// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) {
  return Deck(
    json['deckName'] as String,
    deck: json['deck'] == null
        ? null
        : FlashcardList.fromJson(json['deck'] as Map<String, dynamic>),
    grave: json['grave'] == null
        ? null
        : FlashcardList.fromJson(json['grave'] as Map<String, dynamic>),
    qtdFlashcards: json['qtdFlashcards'] as int,
  );
}

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'deck': instance.deck?.toJson(),
      'grave': instance.grave?.toJson(),
      'qtdFlashcards': instance.qtdFlashcards,
      'deckName': instance.deckName,
    };
