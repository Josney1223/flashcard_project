import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flashcard_project/FrontEnd/FlashcardCollectionView.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flashcard_project/FrontEnd/NameDeck.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_project/BackEnd/Collection/Collection.dart';
import 'package:clipboard/clipboard.dart';

/*
* Tela de visualização de decks
*/
class DeckCollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                              child: Text("Importar Deck"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => SimpleDialog(
                                          title: Text("Cole o deck aqui",
                                              textAlign: TextAlign.center),
                                          children: [
                                            Flex(direction: Axis.horizontal, children: [Expanded(child: PasteBox()),],),
                                            SizedBox(height: 25,),
                                            Flex(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              direction: Axis.horizontal,
                                              children: [
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(maxWidth: 100),
                                                  child: ElevatedButton(
                                                    onPressed: () {}, child: Text("Salvar"),
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.red.shade300,
                                                    ),
                                                  )),
                                              ],
                                            )
                                            
                                          ],
                                        ));
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoBackButton(),
                            SizedBox(width: 35),
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
                              child: Text("     Salvar    "),
                              onPressed: () {
                                Provider.of<Collection>(context, listen: false)
                                    .saveFile();
                              },
                            ),
                          ],
                        )
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
        showDialog(
            context: context,
            builder: (_) => SimpleDialog(
                  title: Text("Copiar para área de transferência",
                      textAlign: TextAlign.center),
                  children: [
                    Column(children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 100),
                        child:
                        Text(deck.getName(),
                            style: TextStyle(
                                fontWeight:
                                    FontWeight.bold)),
                      ), //texto que será copiado
                      SizedBox(
                        height: 10,
                      ),
                      CopyBox(Provider.of<Collection>(context)
                          .exportDeck(deck.getName())),
                    ]),
                  ],
                ));
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

class CopyBox extends StatefulWidget {
  String s;

  CopyBox(String s) {
    this.s = s;
  }
  @override
  _CopyBoxState createState() => _CopyBoxState(this.s);
}

class _CopyBoxState extends State<CopyBox> {
  String s;

  _CopyBoxState(String s) {
    this.s = s;
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            FlutterClipboard.copy(this.s)
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Copiado com sucesso"),
                      ),
                    ));
          },
          child: Container(
            margin: EdgeInsets.only(top: 5),
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(15)),
            child: Center(child: Text('Copiar')),
          ),
        ),
      ],
    );
  }
}

class PasteBox extends StatefulWidget {
  @override
  _PasteBoxState createState() => _PasteBoxState();
}

class _PasteBoxState extends State<PasteBox> {
  TextEditingController field = TextEditingController();
  String pasteValue = '';
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: TextFormField(
            controller: field,
            decoration: InputDecoration(hintText: 'Cole'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            FlutterClipboard.paste().then((value) {
              setState(() {
                if (value.isNotEmpty) {
                  field.text = value.trim();
                  pasteValue = value.trim();
                }
              });
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 5),
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(15)),
            child: Center(child: Text('Colar')),
          ),
        ),
      ],
    );
  }
}
