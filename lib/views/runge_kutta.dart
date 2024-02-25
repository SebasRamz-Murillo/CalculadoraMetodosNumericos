import 'package:calculadora_metodos/funciones_matematicas/ejemplos.dart';
import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/runge_kutta_result_view.dart';
import 'package:calculadora_metodos/widgets/calculadoraMetodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';

class RungeKuttaView extends StatefulWidget {
  const RungeKuttaView({Key? key}) : super(key: key);

  @override
  State<RungeKuttaView> createState() => _RungeKuttaViewState();
}

class _RungeKuttaViewState extends State<RungeKuttaView> {
  late RungeKutta4Solution resultadoRK4;

  EjemplosInputsCalculadora ejem = EjemplosInputsCalculadora("noHomogeneas");
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
      RungeKutta4 rungeKutta4 = RungeKutta4();
      RungeKutta4Solution solution = rungeKutta4.rungeKutta4(funcSt, x0, y0, xFinal, h);
      resultadoRK4 = solution;
      calculado = true;
      setState(() {});
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CalculadoraMetodosPad(
        tipo: "rungeKutta",
        calcula: (Map<String, dynamic> data) {
          calcula1(data);
        },
      ),
      calculado
          ? RungeKuttaResultWidget(
              result: resultadoRK4,
            )
          : Container()
    ]);
  }
}
