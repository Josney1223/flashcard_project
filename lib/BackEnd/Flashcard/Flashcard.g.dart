// GENERATED CODE - DO NOT MODIFY BY HAND

part of flashcard_package;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flashcard _$FlashcardFromJson(Map<String, dynamic> json) {
  return Flashcard(
    json['face'] as String,
    json['back'] as String,
  );
}

Map<String, dynamic> _$FlashcardToJson(Flashcard instance) => <String, dynamic>{
      'face': instance.face,
      'back': instance.back,
    };
