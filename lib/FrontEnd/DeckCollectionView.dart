import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flutter/material.dart';

/*
* Tela de visualização de decks
*/
class DeckCollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 15, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Text(
                  "COLEÇÃO DE DECKS",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DeckListigView(),
                GoBackButton(),
              ],
          )
        )
      )
    ));
  }
}

class DeckListigView extends StatelessWidget {

  List<Deck> deckList;

  DeckListigView() {
    Deck deck1 = new Deck('deck 1');
    Deck deck2 = new Deck('deck 2');
    deckList = [];
    deckList.add(deck1);
    deckList.add(deck2);
    deckList.add(deck2);
    deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2); deckList.add(deck2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height:MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
        padding: EdgeInsets.only(top: 50),
        itemCount: deckList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Color.fromRGBO(252, 210, 217, 1),
            child: Center(
              child: 
                Text(
                  this.deckList[index].getName(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
            ),
          );
        },     
      ),
    );
  }

}