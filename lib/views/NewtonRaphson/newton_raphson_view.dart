import 'package:calculadora_metodos/funciones_matematicas/ejemplos.dart';
import 'package:calculadora_metodos/models/newton_raphson.dart';
import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/NewtonRaphson/newton_raphson_resul_view.dart';
import 'package:calculadora_metodos/views/RungeKutta/runge_kutta_result_view.dart';
import 'package:calculadora_metodos/widgets/calculadoraMetodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';

class NewtonRaphsonView extends StatefulWidget {
  const NewtonRaphsonView({Key? key}) : super(key: key);

  @override
  State<NewtonRaphsonView> createState() => _NewtonRaphsonViewState();
}

class _NewtonRaphsonViewState extends State<NewtonRaphsonView> {
  late NewtonRaphsonSolution resultadoNR;

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
      double xAprx = double.parse(data['x']);
      String funcSt = data['f'];
      int maxN = int.parse(data['n']);
      // Calcular la solución
      NewtonRaphson newtonRaphson = NewtonRaphson(xAprx, funcSt, maxN);
      resultadoNR = newtonRaphson.solve();
      calculado = true;
      setState(() {});
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CalculadoraMetodosPad(
        tipo: "newtonRaphson",
        calcula: (Map<String, dynamic> data) {
          calcula1(data);
        },
      ),
      calculado
          ? NewtonRaphsonResulWidget(
              result: resultadoNR,
            )
          : Container()
    ]);
  }
}
