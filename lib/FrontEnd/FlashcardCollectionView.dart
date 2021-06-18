import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard_Package.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArgumentsFC.dart';
import 'package:flashcard_project/FrontEnd/EditFlashcard.dart';
import 'package:flashcard_project/FrontEnd/NameDeck.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:provider/provider.dart';

// Ver todos os flashcards de um Deck
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
                    padding: EdgeInsets.only(
                        top: 50, bottom: 15, left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "EDITAR UM DECK",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<Collection>(
                          builder: (context, collection, child) {
                            return FlashCardListingView(
                                collection.getDeck(deck.getName()));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(245, 170, 180, 1),
                                  elevation: 8,
                                  shadowColor: Colors.grey,
                                  padding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: Text("Criar Flashcard"),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  EditFlashcard.routeName,
                                  arguments: ScreenArgumentsFC(deck, null),
                                );
                              },
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(245, 170, 180, 1),
                                  elevation: 8,
                                  shadowColor: Colors.grey,
                                  padding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: Text("Editar nome do deck"),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NameDeck.routeName,
                                  arguments: ScreenArguments(deck),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        GoBackButton(),
                      ],
                    )))));
  }
}

/// Enumeração das ações possíveis para um flashcard
enum selectedFlashcardActions { EDITAR, DELETAR }

// Ver todos os flashcards de um Deck
class FlashCardListingView extends StatelessWidget {
  FlashcardList flashcardList;
  Deck deck;

  FlashCardListingView(Deck deck) {
    this.flashcardList = deck.deck;
    this.deck = deck;
  }

  Future _askUser(BuildContext context, Flashcard flashcard) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Selecione uma opção:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedFlashcardActions.EDITAR);
                },
                child: const Text('Editar'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedFlashcardActions.DELETAR);
                },
                child: const Text('Deletar'),
              ),
            ],
          );
        })) {
      case selectedFlashcardActions.EDITAR:
        Navigator.pushNamed(
          context,
          EditFlashcard.routeName,
          arguments: ScreenArgumentsFC(deck, flashcard),
        );
        break;
      case selectedFlashcardActions.DELETAR:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Tem certeza que deseja remover esse flashcard?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<Collection>(context, listen: false)
                      .editDeck(this.deck.getName(), 0, flashcard);
                  Navigator.of(context).pop();
                },
                child: Text('Sim'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
      height: MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2.5),
        padding: EdgeInsets.only(top: 50),
        itemCount: flashcardList.lenght(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {_askUser(context, this.flashcardList.getCard(index))},
            child: Card(
              color: Color.fromRGBO(252, 210, 217, 1),
              child: Center(
                child: Text(
                  this.flashcardList.getCard(index).getFace(),
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
