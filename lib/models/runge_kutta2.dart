import 'dart:math';
import 'package:function_tree/function_tree.dart';

class RungeKutta4 {
  // Función para calcular la aproximación de y(x) usando Runge-Kutta de 4to orden
  RungeKutta4Solution rungeKutta4(String funcSt, double x0, double y0, double xFinal, double h) {
    var f = funcSt.toMultiVariableFunction(['x', 'y']);

    List<double> xValues = [x0];
    List<double> yValues = [y0];
    final k1Values = <double>[];
    final k2Values = <double>[];
    final k3Values = <double>[];
    final k4Values = <double>[];
    while (x0 < xFinal) {
      final k1 = f({'x': x0, 'y': y0}).toDouble();
      final k2 = f({'x': x0 + h / 2, 'y': y0 + k1 * h / 2}).toDouble();
      final k3 = f({'x': x0 + h / 2, 'y': y0 + k2 * h / 2}).toDouble();
      final k4 = f({'x': x0 + h, 'y': y0 + k3 * h}).toDouble();
      double yNext = y0 + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

      x0 += h;
      y0 = yNext;

      xValues.add(x0);
      yValues.add(y0);
      k1Values.add(k1);
      k2Values.add(k2);
      k3Values.add(k3);
      k4Values.add(k4);
    }

    return RungeKutta4Solution(xValues, yValues, k1Values, k2Values, k3Values, k4Values);
  }
}

class RungeKutta4Solution {
  final List<double> xValues;
  final List<double> yValues;

  final List<double> k1Values;
  final List<double> k2Values;
  final List<double> k3Values;
  final List<double> k4Values;

  RungeKutta4Solution(this.xValues, this.yValues, this.k1Values, this.k2Values, this.k3Values, this.k4Values);
}
