import 'dart:math';
import 'package:function_tree/function_tree.dart';

class EulerMejorado {
  final double _h;
  final double _y0;
  final double _x0;
  final double _xFinal;
  final String _fSt;

  EulerMejorado(this._h, this._y0, this._x0, this._xFinal, this._fSt);

  EulerMejoradoSolution calcular() {
    var _f = _fSt.toMultiVariableFunction(['x', 'y']);

    List<double> xValues = [];
    List<double> yValues = [];
    List<double> yAproximadoValues = [];
    List<double> yRealValues = [];
    List<double> errorAbsolutoValues = [];
    List<double> errorRelativoValues = [];
    List<double> errorPorcentualValues = [];
    double x = _x0;
    double y = _y0;

    while (x < _xFinal) {
      double yN = y + _h * _f({'x': x, 'y': y});
      double yAproximado = y + (_h / 2) * (_f({'x': x, 'y': y}) + _f({'x': x + _h, 'y': yN}));
      double yRealActual = _fActual(x + _h, yN);
      double errorAbsoluto = yRealActual - yAproximado;
      double errorRelativo = errorAbsoluto / yRealActual;
      double errorPorcentual = (errorRelativo * 100).abs();

      xValues.add(x);
      yValues.add(yN);
      yAproximadoValues.add(yAproximado);
      yRealValues.add(yRealActual);
      errorAbsolutoValues.add(errorAbsoluto);
      errorRelativoValues.add(errorRelativo);
      errorPorcentualValues.add(errorPorcentual);

      x += _h;
      y = yAproximado;
    }

    return EulerMejoradoSolution(
      xValues,
      yValues,
      yAproximadoValues,
      yRealValues,
      errorAbsolutoValues,
      errorRelativoValues,
      errorPorcentualValues,
    );
  }

  double _fActual(double x, double y) {
    var fActual = _fSt.replaceAll('y', y.toString()).toSingleVariableFunction('x');
    return fActual(x).toDouble();
  }
}

class EulerMejoradoSolution {
  final List<double> xValues;
  final List<double> yValues;
  final List<double> yAproximadoValues;
  final List<double> yRealValues;
  final List<double> errorAbsolutoValues;
  final List<double> errorRelativoValues;
  final List<double> errorPorcentualValues;

  EulerMejoradoSolution(
    this.xValues,
    this.yValues,
    this.yAproximadoValues,
    this.yRealValues,
    this.errorAbsolutoValues,
    this.errorRelativoValues,
    this.errorPorcentualValues,
  );
}
