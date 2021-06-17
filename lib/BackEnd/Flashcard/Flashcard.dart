part of flashcard_package;

/// Classe que representa um flashcard
@JsonSerializable()
class Flashcard {
  /// Variavéis que guardam a frente e o verso do Flashcard
  String face, back;

  /// Método Construtor
  Flashcard(this.face, this.back);

  /// Altera a frente do Flashcard
  void setFace(String front) {
    this.face = front;
  }

  /// Altera o verso do Flashcard
  void setBack(String back) {
    this.back = back;
  }

  /// Retorna a frente do Flashcard
  String getFace() {
    return this.face;
  }

  /// Retorna o verso do Flashcard
  String getBack() {
    return this.back;
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) =>
      _$FlashcardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardToJson(this);
}
