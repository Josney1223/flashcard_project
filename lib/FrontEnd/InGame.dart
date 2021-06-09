import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/BackEnd/Flashcard/Flashcard.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';

/*
* Tela de dentro do jogo
*/
class InGame extends StatelessWidget {
  static const routeName = '/InGame';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    final Deck deck = args.deck;
    int score = 0;
    Flashcard card = deck.pullCard();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    deck.getName(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'SCORE: ' + score.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      constraints: BoxConstraints(
                          minWidth: 349,
                          maxWidth: 350,
                          minHeight: 349,
                          maxHeight: 350),
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 224, 162, 1),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 8),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        card.getFace(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    back: Container(
                      constraints: BoxConstraints(
                          minWidth: 349,
                          maxWidth: 350,
                          minHeight: 349,
                          maxHeight: 350),
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(183, 213, 229, 1),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 8),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        card.getBack(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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
                                borderRadius: BorderRadius.circular(80.0)),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          score++;
                          card = deck.pullCard();
                        },
                        child: Text('Acertei!'),
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
                                borderRadius: BorderRadius.circular(80.0)),
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {},
                        child: Text('  Errei!  '),
                      ),
                    ],
                  ),
                  SizedBox(height: 49),
                  GoBackButton(),
                ]))));
  }
}

class sim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
