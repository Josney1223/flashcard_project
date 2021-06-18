import 'package:flutter/material.dart';

/// Classe que cria um botão com imagem
class MenuButtonWithIcon extends StatelessWidget {
  final String _title;
  final Color _color;
  final String _action;
  final String _imgPath;

  MenuButtonWithIcon(this._title, this._color, this._imgPath, this._action);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 100),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(this._action);
          },
          style: ElevatedButton.styleFrom(
              primary: _color,
              elevation: 8,
              shadowColor: Colors.grey,
              padding: EdgeInsets.all(20),
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          child: IconAndTextBox(this._title, this._imgPath),
        ));
  }
}

/// Classe que cria uma caixa que possui uma Imagem e um Botão, alinhados verticalmente
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
            Image(
              image: AssetImage(this._imgPath),
              width: 50.0,
              height: 50.0,
              filterQuality: FilterQuality.medium,
            ),
            SizedBox(height: 10),
            Text(this._title),
          ],
        ));
  }
}
