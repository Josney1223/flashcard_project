import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';

/*
* Tela SOBBRE do aplicativo
*/
class Sobre extends StatelessWidget {
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
                    SizedBox(height: 10),
                    Text('KADO APP'),
                    SizedBox(height: 30),
                    SizedBox(height: 30),
                    Text(
                      'SOBRE O APP',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    SizedBox(height: 5),
                    Text('Aplicação criada para o curso de'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('Arquitetura de Software'),
                    SizedBox(height: 30),
                    SizedBox(height: 5),
                    Text('Grupo:'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('Caroline Yumi Uehara'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('José Augusto Barros Minhoto'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('Leonardo Lessa Lopes de Fonseca'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('Lucas Kenji Uezu'),
                    SizedBox(height: 5),
                    SizedBox(height: 30),
                    Text(
                      'CRÉDITOS',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    SizedBox(height: 5),
                    Text('ÍCONES'),
                    SizedBox(height: 0),
                    SizedBox(height: 0),
                    Text('"Icons made by Freepik from www.flaticon.com"'),
                    SizedBox(height: 40),
                    GoBackButton(),
                  ],
                ))));
  }
}
