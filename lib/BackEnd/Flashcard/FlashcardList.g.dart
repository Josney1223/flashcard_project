// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlashcardList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashcardList _$FlashcardListFromJson(Map<String, dynamic> json) {
  return FlashcardList(
    flashcardList: (json['flashcardList'] as List)
        ?.map((e) =>
            e == null ? null : Flashcard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FlashcardListToJson(FlashcardList instance) =>
    <String, dynamic>{
      'flashcardList':
          instance.flashcardList?.map((e) => e?.toJson())?.toList(),
    };
