import 'package:calculadora_metodos/funciones.dart';
import 'package:calculadora_metodos/widgets/calculadora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class EulerMejorado extends StatefulWidget {
  const EulerMejorado({Key? key}) : super(key: key);

  @override
  State<EulerMejorado> createState() => _EulerMejoradoState();
}

class _EulerMejoradoState extends State<EulerMejorado> {
  TextEditingController _controllerCalculadora = TextEditingController();
  List<String> _result = [];
  EcuacionesDiferencialesNoHomogeneas ed = EcuacionesDiferencialesNoHomogeneas("");
  String _expression = '';

  late SyntaxTree ast;

  @override
  void initState() {
    super.initState();
    ast = SyntaxTree(greenRoot: EquationRowNode(children: []));
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
      setState(() {
        ast = SyntaxTree(greenRoot: TexParser(_controllerCalculadora.text, TexParserSettings()).parse());
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
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
