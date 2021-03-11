class Flashcard {
  String _name, _face, _back;

  Flashcard(String inputFace, String inputBack) {
    this._face = inputFace;
    this._back = inputBack;
  }

  String getFace() {
    return this._face;
  }

  String getBack() {
    return this._back;
  }
}
