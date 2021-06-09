import 'package:flutter/material.dart';
import 'Menu.dart';

/*
Tela de fim de jogo
*/
class EndGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/flash-cards.png'),
                width: 100,
              ),
              Text(
                'FIM DE JOGO!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 35),
              Text(
                'SEU SCORE FOI...',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 35),
              Text(
                'ACERTOS: ',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 5),
              Text(
                'ERROS: ',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 250),
              MenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  static const routeName = '/MenuButton';
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 100),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Menu.routeName);
          },
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
          child: Text('Voltar ao Menu'),
        ));
  }
}
