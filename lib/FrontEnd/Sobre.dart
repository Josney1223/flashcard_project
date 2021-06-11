import 'package:flutter/material.dart';
import 'package:flashcard_project/FrontEnd/Components/GoBackButton.dart';

/*
* Tela SOBBRE do aplicativo
*/
class Sobre extends StatelessWidget {
  //cria a tela que passa infromações do projeto e nome dos criadores do projeto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
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
                        SizedBox(height: 60),
                        Text(
                          'SOBRE O APP',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 35),
                        Text('Aplicação criada para o curso de'),
                        Text('Arquitetura de Software'),
                        SizedBox(height: 35),
                        Text('Grupo:'),
                        Text('Caroline Yumi Uehara'),
                        Text('José Augusto Barros Minhoto'),
                        Text('Leonardo Lessa Lopes de Fonseca'),
                        Text('Lucas Kenji Uezu'),
                        SizedBox(height: 35),
                        Text(
                          'CRÉDITOS',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 35),
                        Text('ÍCONES'),
                        Text('"Icons made by Freepik from www.flaticon.com"'),
                        SizedBox(height: 40),
                        GoBackButton(),
                      ],
                    )))));
  }
}
