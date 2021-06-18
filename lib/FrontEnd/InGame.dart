import 'dart:async';
import 'package:flashcard_project/BackEnd/GameplayLoop.dart';
import 'package:flashcard_project/FrontEnd/EndGame.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';
import 'package:provider/provider.dart';

/// Classe que gera o StatefulWidget para ser usado como base pela classe _InGameState
class InGame extends StatefulWidget {
  static const routeName = '/InGame';
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  _InGameState createState() => _InGameState();
}

/// Classe que faz a tela do jogo com o nome do deck, score, o flashcard com animação e as opções de acertar ou errar e botão de voltar
///
/// Cria um ToggleButton para escolher entre ordem aleatória ou ordenada do deck
/// Cria uma carta interativa com animação para representar o FlashCard virando
/// Mostra dois novos botões após virar a primeira vez a carta para falar se acertou ou errou
class _InGameState extends State<InGame> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isVisible = false;
  List<bool> isSelected = [false];

  void CheckEndGame(BuildContext context) {
    if (isSelected[0]) {
      Provider.of<GameplayLoop>(context, listen: false).nextRandomCard();
    } else {
      Provider.of<GameplayLoop>(context, listen: false).nextCard();
    }
    if (Provider.of<GameplayLoop>(context, listen: false).getEnd()) {
      Navigator.pushNamed(context, EndGame.routeName);
    }
  }

  Future<void> WidgetState(bool hit) {
    if (hit) {
      Provider.of<GameplayLoop>(context, listen: false).increaseHit();
    } else {
      Provider.of<GameplayLoop>(context, listen: false).increaseMiss();
    }

    if (!cardKey.currentState.isFront) {
      cardKey.currentState.toggleCard();
      new Timer(new Duration(milliseconds: 300), () {
        CheckEndGame(context);
      });
    } else {
      CheckEndGame(context);
    }

    this.isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(children: <Widget>[
                      Visibility(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                Provider.of<GameplayLoop>(context)
                                    .getDeckName(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              ToggleButtons(
                                children: <Widget>[
                                  Icon(Icons.shuffle),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    isSelected[index] = !isSelected[index];
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ]),
                      ),
                      SizedBox(height: 40),
                      Consumer<GameplayLoop>(
                        builder: (context, gameplayLoop, child) {
                          return Text(
                            'SCORE: ' + gameplayLoop.getHit().toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      SizedBox(height: 40),
                      Consumer<GameplayLoop>(
                        builder: (context, gameplayLoop, child) {
                          return FlipCard(
                            key: cardKey,
                            direction: FlipDirection.VERTICAL,
                            onFlip: () async {
                              setState(() {
                                if (!this.isVisible) {
                                  this.isVisible = true;
                                }
                              });
                            },
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
                                gameplayLoop.getFlashcardFace(),
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
                                gameplayLoop.getFlashcardBack(),
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Visibility(
                        visible: this.isVisible,
                        child: Row(
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
                              onPressed: () async {
                                setState(() {
                                  WidgetState(true);
                                });
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
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () async {
                                setState(() {
                                  WidgetState(false);
                                });
                              },
                              child: Text('  Errei!  '),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 49),
                      GoBackButton(),
                    ])))));
  }
}
