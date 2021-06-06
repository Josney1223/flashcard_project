import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/FlashcardList.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';

class FlashcardCollectionView extends StatelessWidget {

  static const routeName = '/flashcardCollection';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    final Deck deck = args.deck;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 15, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Text(
                  "EDITAR UM DECK",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlashCardListingView(deck),
                SizedBox(height: 20),
                GoBackButton(),
              ],
          )
        )
      )
    ));
  }
}

enum selectedFlashcardActions{EDITAR, DELETAR}

class FlashCardListingView extends StatelessWidget {

  FlashcardList flashcardList;

  FlashCardListingView(Deck deck) {
    this.flashcardList = deck.deck;
  }

  Future _askUser(BuildContext context) async {
    switch(
      await showDialog(
        context: context, 
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Selecione uma opção:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedFlashcardActions.EDITAR); },
                child: const Text('Editar'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedFlashcardActions.DELETAR); },
                child: const Text('Deletar'),
              ),
            ],
          );
        }
      )
    ) {
      case selectedFlashcardActions.EDITAR:
        break;
      case selectedFlashcardActions.DELETAR:
        showDialog(
          context: context, 
          builder: (_) => AlertDialog(
            title: Text('Tem certeza que deseja remover esse flashcard?'),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Sim'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Não'),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height:MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
        padding: EdgeInsets.only(top: 50),
        itemCount: flashcardList.lenght(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              _askUser(context)
            },
            child: Card(
              color: Color.fromRGBO(252, 210, 217, 1),
              child: Center(
                child: 
                  Text(
                    this.flashcardList.getCard(index).getFace(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ),
            ),
          );
        },     
      ),
    );
  }
}