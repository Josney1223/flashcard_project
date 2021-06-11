import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flashcard_project/FrontEnd/FlashcardCollectionView.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flashcard_project/FrontEnd/NameDeck.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_project/BackEnd/Collection/Collection.dart';

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
                    padding: EdgeInsets.only(
                        top: 50, bottom: 15, left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "COLEÇÃO DE DECKS",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<Collection>(
                          builder: (context, collection, child) {
                            return DeckListigView(collection.decks);
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
                              child: Text("  Criar Deck  "),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NameDeck.routeName,
                                  arguments: ScreenArguments(null),
                                );
                                (context as Element).reassemble();
                              },
                            ),
                            SizedBox(
                              width: 35,
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
                              child: Text("Salvar"),
                              onPressed: () {
                                Provider.of<Collection>(context).saveFile();
                              },
                            ),
                            SizedBox(
                              width: 35,
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
                              child: Text("Importar Deck"),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(height: 13),
                        GoBackButton(),
                      ],
                    )))));
  }
}

enum selectedDeckActions { EDITAR, DELETAR, EXPORTAR }

class DeckListigView extends StatelessWidget {
  List<Deck> deckList;

  DeckListigView(List<Deck> dl) {
    deckList = dl;
  }

  Future _askUser(BuildContext context, Deck deck) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Selecione uma opção:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedDeckActions.EDITAR);
                },
                child: const Text('Editar'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedDeckActions.DELETAR);
                },
                child: const Text('Deletar'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedDeckActions.EXPORTAR);
                },
                child: const Text('Exportar'),
              ),
            ],
          );
        })) {
      case selectedDeckActions.EDITAR:
        Navigator.pushNamed(
          context,
          FlashcardCollectionView.routeName,
          arguments: ScreenArguments(deck),
        );
        break;
      case selectedDeckActions.DELETAR:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Tem certeza que deseja remover esse deck?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<Collection>(context, listen: false)
                      .deleteDeck(deck.getName());
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
      case selectedDeckActions.EXPORTAR:
        print("exportar");
        break;
    }
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
            onTap: () => {_askUser(context, this.deckList[index])},
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
