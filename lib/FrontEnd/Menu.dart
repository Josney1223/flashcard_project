import 'package:flutter/material.dart';
import 'Components/MenuButtonWithIcon.dart';

/*
* Tela Menu principal
*/
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(children: <Widget>[
                  Image(
                    image: AssetImage('assets/flash-cards.png'),
                    width: 100,
                  ),
                  SizedBox(height: 10),
                  Text('KADO APP'),
                  SizedBox(height: 45),
                  MenuButtonWithIcon('JOGAR', Color.fromRGBO(245, 170, 180, 1),
                      'assets/play-button.png', '/deckSelection'),
                  SizedBox(height: 25),
                  MenuButtonWithIcon(
                      'COLEÇÃO',
                      Color.fromRGBO(183, 235, 209, 1),
                      'assets/paper.png',
                      '/deckCollection'),
                  SizedBox(height: 25),
                  MenuButtonWithIcon('SOBRE', Color.fromRGBO(255, 224, 162, 1),
                      'assets/information.png', '/sobre'),
                ]))));
  }
}
