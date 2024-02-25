import 'package:calculadora_metodos/funciones_matematicas/derivadas.dart';
import 'package:function_tree/function_tree.dart';

class NewtonRaphson {
  final double _initialGuess;
  final String _fSt;

  NewtonRaphson(this._initialGuess, this._fSt);

  NewtonRaphsonSolution solve() {
    var f = _fSt.toSingleVariableFunction('x');
    Derivada _derivSt = Derivada(_fSt);
    var fDerivative = _derivSt.resultado.toSingleVariableFunction('x');

    double x = _initialGuess;
    List<double> xValues = [];
    for (int i = 0; i < 100; i++) {
      double fValue = f(x).toDouble();
      double fDerivativeValue = fDerivative(x).toDouble();

      if (fDerivativeValue.abs() < 1e-10) {
        throw Exception('La derivada es demasiado pequeña. Newton-Raphson no puede continuar.');
      }

      x = x - (fValue / fDerivativeValue);
      xValues.add(x);

      if (fValue.abs() < 1e-10) {
        return NewtonRaphsonSolution(xValues, fValue);
      }
    }

    throw Exception('Newton-Raphson no convergió después de 100 iteraciones.');
  }
}

class NewtonRaphsonSolution {
  final List<double> x;
  final double fValue;

  NewtonRaphsonSolution(this.x, this.fValue);
}
