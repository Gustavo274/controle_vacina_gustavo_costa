import 'package:flutter/material.dart';
import 'package:web_api_vacinacao/view/lista_vacinacao.dart';

void main() {
  runApp(VacinacaoApp());
}

class VacinacaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[800],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaVacinacao(),
    );
  }
}
