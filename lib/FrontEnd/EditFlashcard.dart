import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArgumentsFC.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:provider/provider.dart';

/*
* Tela de edição de flashcards
*/
class EditFlashcard extends StatelessWidget {
  static const routeName = '/editFlashcard';

  Deck finalDeck;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArgumentsFC;
    final Flashcard flashcardReceived = args.flashcard;
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyCustomForm(flashcardReceived),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  Flashcard flashcardReceived;

  MyCustomForm(Flashcard flashcardReceived) {
    this.flashcardReceived = flashcardReceived;
  }

  @override
  EditFlashcardBody createState() => EditFlashcardBody(this.flashcardReceived);
}

class EditFlashcardBody extends State<MyCustomForm> {
  var myControllerFrente = TextEditingController();
  var myControllerVerso = TextEditingController();

  String oldNameFrente; 
  String oldNameVerso;
  Flashcard flashcardReceived;

  EditFlashcardBody(Flashcard flashcardReceived) {
    this.flashcardReceived = flashcardReceived;

    if (flashcardReceived != null) {
      myControllerFrente.text = this.flashcardReceived.getFace();
      oldNameFrente = this.flashcardReceived.getFace();

      myControllerVerso.text = this.flashcardReceived.getBack();
      oldNameVerso = this.flashcardReceived.getBack();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerFrente.dispose(); myControllerVerso.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 15, left: 10, right: 10),
          child: Column(children: <Widget>[
            Text(
              "EDITAR/CRIAR FLASHCARD",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: TextField(
                controller: myControllerFrente,
                maxLength: 25,
                decoration: InputDecoration(
                  labelText: 'Frente',
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: TextField(
                controller: myControllerVerso,
                maxLength: 25,
                decoration: InputDecoration(
                  labelText: 'Verso',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //createFlashcard(this.flashcardReceived);
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(245, 170, 180, 1),
                  elevation: 8,
                  shadowColor: Colors.grey,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  // Cria ou altera o nome de um deck
  void createDeck(Flashcard flashcardReceived) {
    if (flashcardReceived == null) {
      //create flashcard
    } else if (myControllerFrente.text != '' && myControllerVerso.text != '') {
      //edit flashcard values
    }
  }
}
