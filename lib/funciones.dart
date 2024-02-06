import 'dart:math' as math;

import 'package:calculadora_metodos/diccionarios.dart';
import 'package:calculadora_metodos/util.dart';
import 'package:calculus/calculus.dart';

double resuelveEulerMejorado(double x0, double y0, double h, double xn, Function f) {
  int n = ((xn - x0) / h).round();
  double y = y0;
  for (int i = 0; i < n; i++) {
    double k1 = h * f(x0, y);
    double k2 = h * f(x0 + h, y + k1);
    y += (k1 + k2) / 2;
    x0 += h;
  }
  return y;
}

Map<String, double> obtenerCoeficientes(String ecuacionDiferencial) {
  // Inicializa el mapa para almacenar los coeficientes de 'a', 'b', y 'c'
  Map<String, double> coeficientes = {'a': 0.0, 'b': 0.0, 'c': 0.0};

  // Define la expresión regular para buscar los coeficientes y las derivadas
  // La expresión regular maneja correctamente los signos y los coeficientes implícitos
  RegExp exp = RegExp(r"([+-]?\s*\d*)y(\'{0,2})");

  // Busca todas las coincidencias de la expresión regular en la ecuación dada
  var matches = exp.allMatches(ecuacionDiferencial);

  // Itera sobre cada coincidencia encontrada
  for (var match in matches) {
    print(match.group(0));
    // Obtiene el coeficiente como un string, maneja el caso de coeficiente implícito (1 o -1)
    String coefStr = match.group(1)!;
    double coeficiente;
    if (coefStr.isNotEmpty) {
      coefStr = coefStr.replaceAll(' ', ''); // Elimina espacios para asegurar una correcta conversión
      coeficiente = double.parse(coefStr);
    }

    if (coefStr == '') {
      // Si no hay número ni signo, implica un coeficiente de 1
      coeficiente = 1.0;
    } else if (coefStr == '-' || coefStr == '+') {
      // Si el coeficiente es solo un signo, asigna -1 o 1 respectivamente
      coeficiente = coefStr == '-' ? -1.0 : 1.0;
    } else {
      // De lo contrario, parsea el coeficiente como un número, incluyendo su signo
      coeficiente = double.parse(coefStr);
    }

    // Determina a qué término corresponde la derivada y asigna el coeficiente
    String derivada = match.group(2)!;
    if (derivada == "''") {
      coeficientes['a'] = coeficiente;
    } else if (derivada == "'") {
      coeficientes['b'] = coeficiente;
    } else {
      coeficientes['c'] = coeficiente;
    }
  }

  // Devuelve el mapa de coeficientes
  return coeficientes;
}

double resuelveRungeKutta(double x0, double y0, double h, double xn, Function f) {
  int n = ((xn - x0) / h).round();
  double y = y0;
  for (int i = 0; i < n; i++) {
    double k1 = h * f(x0, y);
    double k2 = h * f(x0 + h / 2, y + k1 / 2);
    double k3 = h * f(x0 + h / 2, y + k2 / 2);
    double k4 = h * f(x0 + h, y + k3);
    y += (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    x0 += h;
  }
  return y;
}
//func prueba
//y'' + 7y' + 12y = 3x^2 + 2e^{3x} + 2\cos(2x) + 5

class EcuacionesDiferencialesNoHomogeneas {
  String _ecuacionDiferencial;
  String parteIzquierda = "";
  String parteDerecha = "";
  EcuacionesDiferencialesNoHomogeneas(String ecuacionDiferencial) : _ecuacionDiferencial = ecuacionDiferencial {
    _dividirEcuacion();
  }

  String get ecuacionDiferencial => _ecuacionDiferencial;

  set ecuacionDiferencial(String nuevaEcuacion) {
    _ecuacionDiferencial = nuevaEcuacion;
    _dividirEcuacion();
  }

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

  List<String> solucionGeneral() {
    Map<String, double> coeficientes = {'a': 1, 'b': 0, 'c': 0};
    // Consigue los coeficientes de y'', y' y y
    // Asumiendo que la ecuación está en la forma ay'' + by' + cy = d
    coeficientes = obtenerCoeficientes(parteIzquierda);
    // Calcular las raíces
    List<double> raices = calcularRaices(coeficientes['a'] ?? 0, coeficientes['b'] ?? 0, coeficientes['c'] ?? 0);
    // Calcular la solución complementaria
    String yc = solucionYC(raices);
    // Calcular la solución particular
    String yp = 'yp = ${calculaYp(parteDerecha)}';

    return [yc, yp, 'Error', 'Tu eres el error', 'Cambiar y a yp y sus derivadas', 'Calcular variables'];
  }

  List<double> calcularRaices(double a, double b, double c) {
    // Calcular discriminante
    double discriminante = b * b - 4 * a * c;
    if (discriminante > 0) {
      // Raíces reales y diferentes
      double r1 = (-b + math.sqrt(discriminante)) / (2 * a);
      double r2 = (-b - math.sqrt(discriminante)) / (2 * a);
      return [r1, r2];
    } else if (discriminante == 0) {
      // Raíces reales y repetidas
      double r = -b / (2 * a);
      return [r, r];
    } else {
      // Raíces complejas
      double parteReal = -b / (2 * a);
      double parteImaginaria = math.sqrt(-discriminante) / (2 * a);
      print("['$parteReal + ${parteImaginaria}i', '$parteReal - ${parteImaginaria}i']");
      return [parteReal, parteImaginaria];
    }
  }

  bool verificaRaices(List<double> raices, List<double> coeficientes) {
    // Verificar si las raíces son correctas

    return coeficientes[1] == raices[0] + raices[1] && coeficientes[2] == raices[0] * raices[1];
  }

// Función para formar la solución complementaria yc
  String solucionYC(List<double> raices) {
    // Asumiendo que las raíces son reales
    dynamic r1 = formatNumber(raices[0]);
    dynamic r2 = formatNumber(raices[1]);
    String yc = 'y_c = c1e^\{${r1}x} + c2e^\{${r2}x}';
    return yc;
  }

  String solucionYP(String parteDerecha) {
    String yp = '';
    if (parteDerecha.isEmpty) {
      return '';
    }

    return yp;
  }

  Map<String, String> derivadar(String yp) {
    Map<String, String> derivadas = {'yp': 'Error', 'yp_': 'Error', 'yp__': 'Error'};
    if (yp.isEmpty) {
      return derivadas;
    }
    //Parte derecha   3x^2 + 2e^{3x} + 2\cos(2x) + 5

    return derivadas;
  }

  String derivar(String ecuacion) {
    String derivada = '';
    if (ecuacion.isEmpty) {
      return '';
    }

    return derivada;
  }

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

    // Iterar sobre cada término de la ecuación
    for (String termino in terminos) {
      String ypTermino = '';
      if (termino.contains('x^2')) {
        ypTermino = dicReglasYp['X^2']!;
      } else if (termino.contains('e')) {
        String exponente = termino.substring(termino.indexOf('^') + 1);
        ypTermino = dicReglasYp['e^X']!.replaceAll('X', exponente);
      } else if (termino.contains('cos') || termino.contains('sin')) {
        String funcion = termino.contains('cos') ? 'cosX' : 'sinX';
        String argumento = termino.substring(termino.indexOf('(') + 1, termino.indexOf(')'));
        ypTermino = dicReglasYp[funcion]!.replaceAll('X', "($argumento)");
        print(ypTermino);
      } else if (termino.contains('x')) {
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
}
