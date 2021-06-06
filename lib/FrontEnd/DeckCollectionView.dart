import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flashcard_project/FrontEnd/FlashcardCollectionView.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flashcard_project/FrontEnd/PersistDeck.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
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
                      child: Text("Criar Deck"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PersistDeck.routeName,
                          arguments: ScreenArguments(
                            null
                          ),
                        );
                        (context as Element).reassemble();
                      },
                    ),
                    SizedBox(width: 50,),
                    ElevatedButton(
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
                      child: Text("Importar Deck"),
                      onPressed: () {
                        
                      },
                    )
                  ],
                ),
                SizedBox(height: 20),
                GoBackButton(),
              ],
          )
        )
      )
    ));
  }
}

enum selectedDeckActions{VISUALIZAR, EDITAR, DELETAR, EXPORTAR}

class DeckListigView extends StatelessWidget {

  List<Deck> deckList;  

  DeckListigView() {
    Deck deck1 = new Deck('deck 1');
    Deck deck2 = new Deck('deck 2');
    deckList = [];
    deckList.add(deck1);
    deckList.add(deck2);

    Flashcard f = new Flashcard('albedo', 'calcinha');
    deckList[0].insertCard(f);
  }

  Future _askUser(BuildContext context, Deck deck) async {
    switch(
      await showDialog(
        context: context, 
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Selecione uma opção:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedDeckActions.VISUALIZAR); },
                child: const Text('Visualizar'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedDeckActions.EDITAR); },
                child: const Text('Editar'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedDeckActions.DELETAR); },
                child: const Text('Deletar'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, selectedDeckActions.EXPORTAR); },
                child: const Text('Exportar'),
              ),
            ],
          );
        }
      )
    ) {
      case selectedDeckActions.VISUALIZAR:
        Navigator.pushNamed(
          context,
          FlashcardCollectionView.routeName,
          arguments: ScreenArguments(
            deck
          ),
        );
        break;
      case selectedDeckActions.EDITAR:
        Navigator.pushNamed(
          context,
          PersistDeck.routeName,
          arguments: ScreenArguments(
            deck
          ),
        );
        break;
      case selectedDeckActions.DELETAR:
        showDialog(
          context: context, 
          builder: (_) => AlertDialog(
            title: Text('Tem certeza que deseja remover esse deck?'),
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
      case selectedDeckActions.EXPORTAR:
        print("exportar");
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
        itemCount: deckList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => {
              _askUser(context, this.deckList[index])
            },
            child: Card(
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
            ),
          );
        },     
      ),
    );
  }

}