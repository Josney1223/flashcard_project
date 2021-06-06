import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';

/*
* Tela de persistencia de decks
*/


class PersistDeck extends StatelessWidget {

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

  MyCustomForm(Deck deckReceived){
    this.deckReceived = deckReceived;
  }

  @override
  PersistDeckBody createState() => PersistDeckBody(this.deckReceived);
}

class PersistDeckBody extends State<MyCustomForm> {
  var myController = TextEditingController();
  Deck deckReceived;

  PersistDeckBody(Deck deckReceived) {
    this.deckReceived = deckReceived;

    if(deckReceived != null){
      myController.text = this.deckReceived.getName();
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
            child: Column(
              children: <Widget>[
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
                    decoration: InputDecoration(
                      labelText: 'Nome do deck',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      createDeck(this.deckReceived);
                      Navigator.of(context).pushNamed('/deckCollection');
                    },
                    child: Text("Salvar"),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(245, 170, 180, 1), 
                      elevation: 8, 
                      shadowColor: Colors.grey, 
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ), 
              ]
            ),
          ),
        ),
      );
  }

  // Se for criado um novo deck = retorna um deck novo
  // Se o deck for editado, muda o nome e retorna null
  Deck createDeck(Deck deckReceived) {
    if (deckReceived == null) {
      Deck newDeck = new Deck(myController.text);
      return newDeck;
    } else if (myController.text != '') {
      deckReceived.setName(myController.text);
    }
    return null;
  }

}