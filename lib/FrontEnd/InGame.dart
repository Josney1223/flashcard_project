import 'package:flashcard_project/BackEnd/Flashcard/Deck.dart';
import 'package:flashcard_project/FrontEnd/Components/ScreenArguments.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:flip_card/flip_card.dart';

/*
* Tela de dentro do jogo
*/
class InGame extends StatelessWidget {
  static const routeName = '/InGame';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    final Deck deck = args.deck;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    'FLASHCARD:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: 10),
                  Text(
                    'SCORE:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 30),
                  FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(110),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 224, 162, 1),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 8),
                        ],
                      ),
                      child: Text('Front',
                          style: Theme.of(context).textTheme.headline2),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(110),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(183, 213, 229, 1),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 8),
                        ],
                      ),
                      child: Text('Back',
                          style: Theme.of(context).textTheme.headline2),
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
                        onPressed: () {},
                        child: Text("Acertei!"),
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
                        child: Text("  Errei!  "),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
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
