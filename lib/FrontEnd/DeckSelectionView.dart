import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flutter/material.dart';

/*
* Tela de seleção de deck (Selecione um Deck) com listagem dos decks
*/
class DeckSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Text(
                      "SELECIONE UM DECK",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 25),
                    //TODO listagem de decks
                    DeckNameView(),
                    GoBackButton(),
                  ],
                ))));
  }
}

class DeckNameView extends StatelessWidget {
  List<Deck> deckList;

  DeckNameView() {
    Deck deck1 = new Deck('"nome do deck"');
    Deck deck2 = new Deck('"nome do deck"');
    deckList = [];
    //deckList.add(deck1);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2.5),
        padding: EdgeInsets.only(top: 50),
        itemCount: deckList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Color.fromRGBO(252, 210, 217, 1),
            child: Center(
              child: Text(
                this.deckList[index].getName(),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
