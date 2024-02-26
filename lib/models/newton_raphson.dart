import 'package:calculadora_metodos/funciones_matematicas/derivadas.dart';
import 'package:function_tree/function_tree.dart';

class NewtonRaphson {
  final double _initialGuess;
  final String _fSt;
  final int _maxIterations;

  NewtonRaphson(this._initialGuess, this._fSt, this._maxIterations);

  NewtonRaphsonSolution solve() {
    var f = _fSt.toSingleVariableFunction('x');
    Derivada _derivSt = Derivada(_fSt);
    var fDerivative = _derivSt.resultado.toSingleVariableFunction('x');

    double x = _initialGuess;
    List<double> xValues = [];
    List<double> f1Values = [];
    List<double> f2Values = [];

    for (int i = 0; i < _maxIterations; i++) {
      double fValue = f(x).toDouble();
      double fDerivativeValue = fDerivative(x).toDouble();

      if (fDerivativeValue.abs() < 1e-10) {
        throw Exception('La derivada es demasiado pequeña. Newton-Raphson no puede continuar.');
      }

      x = x - (fValue / fDerivativeValue);
      xValues.add(x);
      f1Values.add(fValue);
      f2Values.add(fDerivativeValue);

      if (fValue.abs() < 1e-10) {
        return NewtonRaphsonSolution(xValues, f1Values, f2Values);
      }
    }

    throw Exception('Newton-Raphson no convergió después de 100 iteraciones.');
  }
}

class NewtonRaphsonSolution {
  final List<double> x;
  final List<double> fValue;
  final List<double> fDerivateValue;

  NewtonRaphsonSolution(this.x, this.fValue, this.fDerivateValue);
}
