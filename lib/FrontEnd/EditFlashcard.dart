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
    final deck = args.deck;

    return Scaffold(
      backgroundColor: Colors.white,
      body: MyCustomForm(deck, flashcardReceived),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  Deck deck;
  Flashcard flashcardReceived;

  MyCustomForm(Deck deck, Flashcard flashcardReceived) {
    this.deck = deck;
    this.flashcardReceived = flashcardReceived;
  }

  @override
  EditFlashcardBody createState() =>
      EditFlashcardBody(this.deck, this.flashcardReceived);
}

class EditFlashcardBody extends State<MyCustomForm> {
  var myControllerFrente = TextEditingController();
  var myControllerVerso = TextEditingController();

  String oldNameFrente;
  String oldNameVerso;
  Flashcard flashcardReceived;
  Deck deck;

  EditFlashcardBody(Deck deck, Flashcard flashcardReceived) {
    this.flashcardReceived = flashcardReceived;
    this.deck = deck;

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
    myControllerFrente.dispose();
    myControllerVerso.dispose();
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
                createFlashcard();
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
  void createFlashcard() {
    myControllerFrente.text = myControllerFrente.text.trimLeft();
    myControllerFrente.text = myControllerFrente.text.trimRight();
    myControllerVerso.text = myControllerVerso.text.trimLeft();
    myControllerVerso.text = myControllerVerso.text.trimRight();

    if (flashcardReceived == null &&
        myControllerFrente.text != '' &&
        myControllerVerso.text != '') {
      Provider.of<Collection>(context, listen: false).editDeck(
          this.deck.getName(),
          1,
          new Flashcard(myControllerFrente.text, myControllerVerso.text));
    } else if (myControllerFrente.text != '' && myControllerVerso.text != '') {
      Provider.of<Collection>(context, listen: false)
          .editDeck(this.deck.getName(), 0, this.flashcardReceived);
      Provider.of<Collection>(context, listen: false).editDeck(
          this.deck.getName(),
          1,
          new Flashcard(myControllerFrente.text, myControllerVerso.text));
    }
  }
}
