import 'package:calculadora_metodos/funciones_matematicas/diferenciales_nohomogeneas.dart';
import 'package:calculadora_metodos/funciones_matematicas/ejemplos.dart';
import 'package:calculadora_metodos/widgets/calculadora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class DiferencialesNoHomogeneasView extends StatefulWidget {
  const DiferencialesNoHomogeneasView({Key? key}) : super(key: key);

  @override
  State<DiferencialesNoHomogeneasView> createState() => _DiferencialesNoHomogeneasViewState();
}

class _DiferencialesNoHomogeneasViewState extends State<DiferencialesNoHomogeneasView> {
  TextEditingController _controllerCalculadora = TextEditingController();
  List<String> _result = [];
  EcuacionesDiferencialesNoHomogeneas ed = EcuacionesDiferencialesNoHomogeneas("");
  String _expression = '';
  EjemplosInputsCalculadora ejem = EjemplosInputsCalculadora("noHomogeneas");

  late SyntaxTree ast;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _clear();
    _controllerCalculadora.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    void calcula1() {
      ed.ecuacionDiferencial = _controllerCalculadora.text;
      _result = ed.solucionGeneral();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ejem.getEjemplos(
          (value) {
            _controllerCalculadora.text = value ?? "";
            setState(() {});
          },
        ),
        CalculadoraPad(_controllerCalculadora, _result),
        TextButton(
            onPressed: () {
              calcula1();
              setState(() {});
            },
            child: Text('Calcular')),
      ],
    );
  }
}
