import 'package:calculadora_metodos/principal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Métodos Numéricos',
      home: const PrincipalPage(),
    );
  }
}
