import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:provider/provider.dart';

/*
* Tela de persistencia de decks
*/
class NameDeck extends StatelessWidget {
  static const routeName = '/persistDeck';

  Deck finalDeck;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    final Deck deckReceived = args.deck;
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyCustomForm(deckReceived),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  Deck deckReceived;

  MyCustomForm(Deck deckReceived) {
    this.deckReceived = deckReceived;
  }

  @override
  PersistDeckBody createState() => PersistDeckBody(this.deckReceived);
}

class PersistDeckBody extends State<MyCustomForm> {
  var myController = TextEditingController();
  String oldName;
  Deck deckReceived;

  PersistDeckBody(Deck deckReceived) {
    this.deckReceived = deckReceived;

    if (deckReceived != null) {
      myController.text = this.deckReceived.getName();
      oldName = this.deckReceived.getName();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
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
              "EDITAR/CRIAR DECK",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: TextField(
                controller: myController,
                maxLength: 25,
                decoration: InputDecoration(
                  labelText: 'Nome do deck',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createDeck(this.deckReceived);
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
  void createDeck(Deck deckReceived) {
    myController.text = myController.text.trimLeft();
    myController.text = myController.text.trimRight();

    if (deckReceived == null && myController.text != '') {
      Provider.of<Collection>(context, listen: false)
          .createDeck(myController.text);
    } else if (myController.text != '') {
      Provider.of<Collection>(context, listen: false)
          .setDeckName(oldName, myController.text);
    }
  }
}
