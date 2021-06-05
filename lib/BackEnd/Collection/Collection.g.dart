// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection(
    decks: (json['decks'] as List)
        ?.map(
            (e) => e == null ? null : Deck.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'decks': instance.decks?.map((e) => e?.toJson())?.toList(),
    };
