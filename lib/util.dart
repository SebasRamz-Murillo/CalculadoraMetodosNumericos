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
