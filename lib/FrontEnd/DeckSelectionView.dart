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
              Text("SELECIONE UM DECK"),
            ],
          )
        )
      )
    );
  }
}