import 'package:json_annotation/json_annotation.dart';
part 'Flashcard.g.dart';

@JsonSerializable()
class Flashcard {
  /*
  Classe que contém um flashcard, para ajudar na identificacao e reduzir o 
  número de duplicatas, ele contém sue frente (this._face) e seu verso
  (this._back).  

  Métodos:
  -> String getFace()
  -> String getBack()
  */

  String face, back;

  Flashcard(this.face, this.back);

  void setFace(String front) {
    // Retorna a frente do Flashcard
    this.face = front;
  }

  void setBack(String back) {
    // Retorna o verso do Flashcard
    this.back = back;
  }

  String getFace() {
    // Retorna a frente do Flashcard
    return this.face;
  }

  String getBack() {
    // Retorna o verso do Flashcard
    return this.back;
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) =>
      _$FlashcardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardToJson(this);
}
