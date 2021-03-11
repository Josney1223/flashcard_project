class Flashcard {
  String _name, _face, _back;

  Flashcard(String inputName, String inputFace, String inputBack) {
    this._name = inputName;
    this._face = inputFace;
    this._back = inputBack;
  }

  String getFace() {
    return this._face;
  }

  String getBack() {
    return this._back;
  }

  String getName() {
    return this._name;
  }
}
