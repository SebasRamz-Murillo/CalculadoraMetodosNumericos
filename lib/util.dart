import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';

void printAst(GreenNode node, [String indent = '']) {
  try {
    // Imprimir la información del nodo actual
    print('$indent${node.encodeTeX()}: ${node.toJson().toString()}');

    // Si el nodo tiene hijos, recorrerlos también
    /* if (node.children.isNotEmpty) {
      for (var child in node.children) {
        printAst(child!, '$indent  ');
      }
    } */
  } catch (e) {
    print(e);
  }
}

String formatNumber(double number) {
  // Verificar si el número es un entero
  if (number == number.toInt().toDouble()) {
    // Es entero, convertir a int para eliminar el '.0'
    return number.toInt().toString();
  } else {
    // Tiene decimales, convertir a String manteniendo los decimales
    return number.toString();
  }
}

Map<String, double> obtenerCoeficientes2(String ecuacion) {
  Map<String, double> coeficientes = {'a': 0, 'b': 0, 'c': 0};
  String parteIzquierda = ecuacion.split('=')[0];
  String parteDerecha = ecuacion.split('=')[1];
  // Consigue los coeficientes de y'', y' y y
  // Asumiendo que la ecuación está en la forma ay'' + by' + cy = d
  RegExp exp = RegExp(r'([+-]?[0-9]*[.]?[0-9]*)([A-Za-z])');
  Iterable<RegExpMatch> matches = exp.allMatches(parteIzquierda);
  for (RegExpMatch match in matches) {
    if (match.group(2) == 'y') {
      coeficientes['c'] = double.parse(match.group(1) ?? '0');
    } else if (match.group(2) == 'y\'') {
      coeficientes['b'] = double.parse(match.group(1) ?? '0');
    } else if (match.group(2) == 'y\"') {
      coeficientes['a'] = double.parse(match.group(1) ?? '0');
    }
  }
  return coeficientes;
}
