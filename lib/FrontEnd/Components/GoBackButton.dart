import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  
  final String _title = 'Voltar';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(context);
        }, 
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(245, 170, 180, 1), 
          elevation: 8, 
          shadowColor: Colors.grey, 
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )
        ),
        child: IconAndTextBoxHoriz(this._title),
      )
    );
  }
}

/*
* Caixa que possui uma Imagem de Voltar e um Botão, alinhados horizontalmente
*/
class IconAndTextBoxHoriz extends StatelessWidget {
  final String _title;

  IconAndTextBoxHoriz(this._title);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 100),
      child: Row(
        children: [
          Image(image: AssetImage('assets/left-arrow.png'), width: 50.0, height: 20.0),
          SizedBox(height: 10),
          Text(this._title),
        ],
      )
    );
  }
}