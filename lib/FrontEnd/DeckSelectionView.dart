import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/GameplayLoop.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'InGame.dart';

/*
* Tela de seleção de deck (Selecione um Deck) com listagem dos decks
*/
class DeckSelectionView extends StatelessWidget {
  //cria a tela de seleção  de deck com os decks importandos da coleção
  static const routeName = '/DeckSelectionView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 50, bottom: 15, left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "SELEÇÃO DE DECKS",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<Collection>(
                          builder: (context, collection, child) {
                            return DeckListView(collection.decks);
                          },
                        ),
                        Row(),
                        SizedBox(height: 20),
                        GoBackButton(),
                      ],
                    )))));
  }
}

class DeckListView extends StatelessWidget {
  List<Deck> deckList;

  DeckListView(List<Deck> dl) {
    deckList = dl;
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
          return InkWell(
            onTap: () async {
              Provider.of<GameplayLoop>(context, listen: false)
                  .setDeck(this.deckList[index]);
              if (this.deckList[index].getQtd() < 1) {
                // Fazer alguma coisa se nn tiver cartas no deck
              } else {
                Navigator.pushNamed(context, InGame.routeName);
              }
            },
            child: Card(
              color: Color.fromRGBO(252, 210, 217, 1),
              child: Center(
                child: Text(
                  this.deckList[index].getName(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
