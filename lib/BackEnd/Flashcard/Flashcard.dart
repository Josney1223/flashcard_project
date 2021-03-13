class Flashcard {
  /*
  Classe que contém um flashcard, para ajudar na identificacao e reduzir o 
  número de duplicatas, ele contém sue frente (this._face) e seu verso
  (this._back).  

  Métodos:
  -> String getFace()
  -> String getBack()
  */

  String _face, _back;

  Flashcard(String inputFace, String inputBack) {
    this._face = inputFace;
    this._back = inputBack;
  }

  void setFace(String front) {
    // Retorna a frente do Flashcard
    this._face = front;
  }

  void setBack(String back) {
    // Retorna o verso do Flashcard
    this._back = back;
  }

  String getFace() {
    // Retorna a frente do Flashcard
    return this._face;
  }

  String getBack() {
    // Retorna o verso do Flashcard
    return this._back;
  }
}
