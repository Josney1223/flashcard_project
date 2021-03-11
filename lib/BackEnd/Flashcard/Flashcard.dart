class Flashcard {
  /*
  Classe que contém um flashcard, para ajudar na identificacao e reduzir o 
  número de duplicatas, ele contém um nome (this._name), além da sua frente 
  (this._face) e sua parte de tras (this._back).  

  Métodos:
  -> String getFace()
  -> String getBack()
  -> String getName()
  */

  String _name, _face, _back;

  Flashcard(String inputName, String inputFace, String inputBack) {
    this._name = inputName;
    this._face = inputFace;
    this._back = inputBack;
  }

  String getFace() {
    // Retorna a frente do Flashcard
    return this._face;
  }

  String getBack() {
    // Retorna o verso do Flashcard
    return this._back;
  }

  String getName() {
    // Retorna o nome do Flashcard
    return this._name;
  }
}
