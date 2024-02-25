import 'package:calculadora_metodos/funciones_matematicas/ejemplos.dart';
import 'package:calculadora_metodos/models/euler_mejorado_result.dart';
import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/euler_mejorado_result_view.dart';
import 'package:calculadora_metodos/views/runge_kutta_result_view.dart';
import 'package:calculadora_metodos/widgets/calculadoraMetodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';

class EulerMView extends StatefulWidget {
  const EulerMView({Key? key}) : super(key: key);

  @override
  State<EulerMView> createState() => _EulerMViewState();
}

class _EulerMViewState extends State<EulerMView> {
  late EulerMejoradoSolution resultadoEM;

  EjemplosInputsCalculadora ejem = EjemplosInputsCalculadora("em");
  bool calculado = false;
  late SyntaxTree ast;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void calcula1(Map<String, dynamic> data) {
      double x0 = double.parse(data['x0']);
      double y0 = double.parse(data['y0']);
      double xFinal = double.parse(data['xFinal']);
      double h = double.parse(data['h']);
      String funcSt = data['f'];

      // Calcular la solución
      EulerMejorado eulerMejorado = EulerMejorado(h, y0, x0, xFinal, funcSt);
      EulerMejoradoSolution solution = eulerMejorado.calcular();
      resultadoEM = solution;
      calculado = true;
      setState(() {});
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CalculadoraMetodosPad(
        tipo: "euler",
        calcula: (Map<String, dynamic> data) {
          calcula1(data);
        },
      ),
      calculado
          ? EulerMResultWidget(
              result: resultadoEM,
            )
          : Container()
    ]);
  }
}
