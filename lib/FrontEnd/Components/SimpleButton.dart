import 'package:flutter/material.dart';

/// Classe que cria um botão simples sem imagem, tem sombra
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
              )),
          child: Text(_title),
        ));
  }
}
