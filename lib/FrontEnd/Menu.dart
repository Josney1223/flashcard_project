import 'package:flutter/material.dart';
import 'Components/MenuButtonWithIcon.dart';

/*
* Tela Menu principal
*/
class Menu extends StatelessWidget {
  static const routeName = '/menu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(children: <Widget>[
                  Image(
                    image: AssetImage('assets/flash-cards.png'), filterQuality: FilterQuality.medium,
                    width: 100,
                  ),
                  SizedBox(height: 10),
                  Text('KADO APP', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 45),
                  MenuButtonWithIcon('JOGAR', Color.fromRGBO(245, 170, 180, 1),
                      'assets/play-button-colorful.png', '/deckSelection'),
                  SizedBox(height: 25),
                  MenuButtonWithIcon(
                      'COLEÇÃO',
                      Color.fromRGBO(183, 235, 209, 1),
                      'assets/folders.png',
                      '/deckCollection'),
                  SizedBox(height: 25),
                  MenuButtonWithIcon('SOBRE', Color.fromRGBO(255, 224, 162, 1),
                      'assets/information-colorful.png', '/sobre'),
                ]))));
  }
}
