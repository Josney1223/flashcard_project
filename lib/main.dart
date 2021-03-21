// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard APP',
      home: Menu(),
    );
  }
}

/*
* Tela Menu
*/
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage('assets/flash-cards.png'),
                width: 100,
              ),
              SizedBox(height: 10),
              Text('KADO APP'),
              SizedBox(height: 45),
              MenuButtonWithIcon(
                'JOGAR', 
                Color.fromRGBO(245, 170, 180, 1), 
                'assets/play-button.png'
              ),
              SizedBox(height: 25),
              MenuButtonWithIcon(
                'COLEÇÃO', 
                Color.fromRGBO(183, 235, 209, 1), 
                'assets/paper.png'
              ),
              SizedBox(height: 25),
              MenuButtonWithIcon(
                'SOBRE', 
                Color.fromRGBO(255, 224, 162, 1), 
                'assets/information.png'
              ),
            ]
          )
        )
      )
    );
  }
}

/*
* Botão sem img, tem sombra
*/
class SimpleButton extends StatelessWidget {
  final String _title;
  final Color _color;
  VoidCallback _action;

  SimpleButton(this._title, this._color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: _color, 
          elevation: 10, 
          shadowColor: Colors.grey, 
          padding: EdgeInsets.all(10),
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )
        ),
        child: Text(_title),
      )
    );
  }
}

/*
* Botão com img
*/
class MenuButtonWithIcon extends StatelessWidget {
  final String _title;
  final Color _color;
  //VoidCallback _action;
  final String _imgPath;

  MenuButtonWithIcon(this._title, this._color, this._imgPath);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100),
      child: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(
          primary: _color, 
          elevation: 8, 
          shadowColor: Colors.grey, 
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )
        ),
        child: IconAndTextBox(this._title, this._imgPath),
      )
    );
  }
}

/*
* Caixa que possui uma Imagem e um Botão, alinhados verticalmente
*/
class IconAndTextBox extends StatelessWidget {
  final String _title;
  final String _imgPath;

  IconAndTextBox(this._title, this._imgPath);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(this._imgPath), width: 50.0, height: 50.0),
          SizedBox(height: 10),
          Text(this._title),
        ],
      )
    );
  }
}