import 'dart:math' as math;
import 'package:calculadora_metodos/funciones_matematicas/derivadas.dart';
import 'package:calculadora_metodos/funciones_matematicas/diccionarios.dart';
import 'package:calculadora_metodos/util.dart';

/// Clase que maneja ecuaciones diferenciales no homogéneas y encuentra sus soluciones.
class EcuacionesDiferencialesNoHomogeneas {
  String _ecuacionDiferencial;
  String parteIzquierda = "";
  String parteDerecha = "";

  /// Constructor que toma la ecuación diferencial como entrada.
  EcuacionesDiferencialesNoHomogeneas(this._ecuacionDiferencial) {
    _dividirEcuacion();
  }

  // Getters y setters
  String get ecuacionDiferencial => _ecuacionDiferencial;

  set ecuacionDiferencial(String nuevaEcuacion) {
    _ecuacionDiferencial = nuevaEcuacion;
    _dividirEcuacion();
  }

  /// Divide la ecuación diferencial en su parte izquierda y derecha basada en el signo '='.
  void _dividirEcuacion() {
    if (_ecuacionDiferencial.isEmpty) return;
    try {
      List<String> partes = _ecuacionDiferencial.split('=');
      if (partes.length != 2) {
        throw Exception('Formato de ecuación incorrecto.');
      }
      parteIzquierda = partes[0].trim();
      parteDerecha = partes[1].trim();
    } catch (e) {
      throw Exception('La ecuación diferencial no está bien definida: $e');
    }
  }

  /// Encuentra la solución general de la ecuación diferencial no homogénea.
  List<String> solucionGeneral() {
    Map<String, double> coeficientes = _obtenerCoeficientes(parteIzquierda);
    List<double> raices = calcularRaices(coeficientes['a'] ?? 0, coeficientes['b'] ?? 0, coeficientes['c'] ?? 0);
    List<String> yc = solucionYC(raices);
    String ypValue = calculaYp(parteDerecha);
    String yp = 'yp = ${ypValue.isEmpty ? "0" : ypValue}';
    Derivada derivadasYP = Derivada(ypValue, cantDerivadas: 2);
    //SIGUIENTE PASO, DERIVADAS POR COEFICIENTES
    String sigPaso = "${coeficientes['a']}(${derivadasYP.resultados[1]}) + ${coeficientes['b']}(${derivadasYP.resultados[0]}) ${coeficientes['c']}(${ypValue})";
    Derivada sigPasoForm = Derivada(sigPaso, formatear: true);
    return [yc[0], yp, "yp' = ${derivadasYP.resultados[0]}", "yp'' = ${derivadasYP.resultados[1]}", sigPasoForm.resultado];
  }

  /// Calcula las raíces de la ecuación característica asociada a la parte homogénea.
  List<double> calcularRaices(double a, double b, double c) {
    double discriminante = b * b - 4 * a * c;
    if (discriminante > 0) {
      double r1 = (-b + math.sqrt(discriminante)) / (2 * a);
      double r2 = (-b - math.sqrt(discriminante)) / (2 * a);
      return [r1, r2];
    } else if (discriminante == 0) {
      double r = -b / (2 * a);
      return [r, r];
    } else {
      double parteReal = -b / (2 * a);
      double parteImaginaria = math.sqrt(-discriminante) / (2 * a);
      return [parteReal, parteImaginaria];
    }
  }

  /// Forma la solución complementaria de la ecuación diferencial homogénea asociada.
  List<String> solucionYC(List<double> raices) {
    dynamic r1 = formatNumber(raices[0]);
    dynamic r2 = formatNumber(raices[1]);
    String yc = 'y_c = c_1 ex^{$r1} + c_2 ex^{$r2}';
    return [yc, 'c_1 ex^{$r1} + c_2 ex^{$r2}'];
  }

  /// Calcula la solución particular de la ecuación diferencial no homogénea.
  String calculaYp(String parteDerecha) {
    if (parteDerecha.isEmpty) {
      return '';
    }

    Map<String, bool> variablesUsadas = {};
    for (var vari in dicVariables) {
      variablesUsadas[vari] = false;
    }

    // Dividir la ecuación en términos utilizando una expresión regular que maneje '+' y '-'
    List<String> terminos = parteDerecha.split(RegExp(r'(?=[+-])'));

    // Contenedor para las partes de la solución particular
    List<String> ypTerminos = [];

    bool xExponente = false;
    // Iterar sobre cada término de la ecuación
    for (String termino in terminos) {
      String ypTermino = '';
      if (termino.contains('x^2')) {
        xExponente = true;
        ypTermino = dicReglasYp['X^2']!;
      } else if (termino.contains('e')) {
        String exponente = termino.substring(termino.indexOf('^') + 1);
        ypTermino = dicReglasYp['e^X']!.replaceAll('X', exponente);
      } else if (termino.contains('cos') || termino.contains('sin')) {
        String funcion = termino.contains('cos') ? 'cosX' : 'sinX';
        String argumento = termino.substring(termino.indexOf('(') + 1, termino.indexOf(')'));
        ypTermino = dicReglasYp[funcion]!.replaceAll('X', "($argumento)");
      } else if (termino.contains('x') && !xExponente) {
        ypTermino = dicReglasYp['X']!;
      }

      // Sustituir los símbolos de variables no usadas
      ypTermino = ypTermino.replaceAllMapped(RegExp(r'_'), (match) {
        var term = dicVariables.firstWhere((element) => !variablesUsadas[element]!, orElse: () => '').toString();
        variablesUsadas[term] = true;
        return term;
      });

      if (ypTermino.isNotEmpty) {
        ypTerminos.add(ypTermino.trim());
      }
    }
    // Unir los términos sin agregar un '+' al final
    return ypTerminos.join(' + ').trim();
  }

  /// Obtiene los coeficientes 'a', 'b', y 'c' de la parte izquierda de la ecuación diferencial.
  Map<String, double> _obtenerCoeficientes(String ecuacionDiferencial) {
    Map<String, double> coeficientes = {'a': 0.0, 'b': 0.0, 'c': 0.0};
    RegExp exp = RegExp(r"([+-]?\s*\d*)y(\'{0,2})");
    var matches = exp.allMatches(ecuacionDiferencial);

    for (var match in matches) {
      String coefStr = match.group(1)!.replaceAll(' ', '');
      double coeficiente = coefStr.isEmpty ? 1.0 : double.parse(coefStr);
      String derivada = match.group(2)!;
      if (derivada == "''") {
        coeficientes['a'] = coeficiente;
      } else if (derivada == "'") {
        coeficientes['b'] = coeficiente;
      } else {
        coeficientes['c'] = coeficiente;
      }
    }
    return coeficientes;
  }
}
