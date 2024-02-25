import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:math_expressions/math_expressions.dart' as math;
import 'package:math_expressions/math_expressions.dart';

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

String eliminarCerosInutiles(String expresion) {
  // Dividir la expresión en partes basadas en espacios para facilitar el análisis.
  var partes = expresion.split(' ');

  // Lista para almacenar las partes de la expresión después de eliminar ceros inútiles.
  List<String> partesModificadas = [];

  for (int i = 0; i < partes.length; i++) {
    String parte = partes[i];

    // Eliminar '0' solo si no es el único elemento o no está seguido por un número o paréntesis (caso de multiplicación o función).
    if (parte == '0') {
      bool eliminar = false;

      // Verificar si el '0' se debe eliminar basado en el contexto.
      if (i > 0 && (partes[i - 1] == '+' || partes[i - 1] == '-')) {
        eliminar = true;
      } else if (i < partes.length - 1 && (partes[i + 1] == '+' || partes[i + 1] == '-')) {
        eliminar = true;
      }

      // Si el '0' no se debe eliminar, añadirlo a la lista modificada.
      if (!eliminar) {
        partesModificadas.add(parte);
      }
    } else {
      // Añadir partes no '0' a la lista modificada.
      partesModificadas.add(parte);
    }
  }

  // Reconstruir la expresión como un string.
  return partesModificadas.join(' ');
}

math.Expression parseExpression(String expression) {
  // Crear un analizador léxico y un analizador sintáctico para la expresión
  math.Parser p = math.Parser();
  math.Expression exp = p.parse(expression);

  return exp;
}
