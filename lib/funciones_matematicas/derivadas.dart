import 'package:calculadora_metodos/funciones_matematicas/diccionarios.dart';

class Derivada {
  final String ecuacion;
  int? cantDerivadas;
  String _resultado = "";
  List<String> _resultados = [];

  Derivada(this.ecuacion, {this.cantDerivadas}) {
    if (cantDerivadas != null) {
      _resultados = _derivadasXNivel();
    } else {
      _resultado = _formatearDerivada(derivarExpresion(ecuacion));
    }
  }

  String get resultado => _resultado;
  List<String> get resultados => _resultados;

  List<String> _derivadasXNivel() {
    List<String> derivadas = [];
    for (int i = 0; i < cantDerivadas!; i++) {
      derivadas.add(_formatearDerivada(derivarExpresion(i == 0 ? ecuacion : derivadas[i - 1])));
    }
    return derivadas;
  }

  String _formatearDerivada(String derivada) {
    // Usar expresiones regulares para manejar todos los reemplazos de manera más eficiente
    String resultadoFormateado = derivada
        .trim()
        // Reemplaza múltiples "+" seguidos (con o sin espacios entre ellos) por un solo "+"
        .replaceAll(RegExp(r'\s*\+\s*\+'), ' +')
        // Reemplaza " - +" con " - " para manejar casos como el de tu ejemplo
        .replaceAll(RegExp(r'\-\s*\+'), ' -')
        // Opcionalmente, reemplaza múltiples "-" seguidos (con o sin espacios entre ellos) por un solo "-"
        .replaceAll(RegExp(r'\s*\-\s*\-'), ' -');

    // Manejar el caso inicial si comienza con "+ " o "- "
    if (resultadoFormateado.startsWith("+ ")) {
      resultadoFormateado = resultadoFormateado.substring(2);
    } else if (resultadoFormateado.startsWith("- ")) {
      resultadoFormateado = "-" + resultadoFormateado.substring(2);
    }

    return resultadoFormateado;
  }

  String _eliminarCerosInnecesarios(String expresion) {
    // Primero, eliminamos cualquier espacio extra para normalizar la expresión
    String normalizada = expresion.replaceAll(RegExp(r'\s+'), '');

    // Eliminar sumas de 0, considerando casos al inicio, en medio y al final de la cadena
    String sinSumaCero = normalizada.replaceAll(RegExp(r'(?:\+0(?=\+|\-|$))'), '');

    // Eliminar restas de 0, si fuera necesario, con la misma consideración
    String sinRestaCero = sinSumaCero.replaceAll(RegExp(r'(?:\-0(?=\+|\-|$))'), '');

    // Añadir espacios alrededor de + y - para mejorar la legibilidad, si se desea
    String resultado = sinRestaCero.replaceAll(RegExp(r'(\+|\-)'), '  ');

    return resultado;
  }

  String _formatearExpresion(String expresion) {
    // Esta expresión regular busca coincidencias que empiecen con una letra (mayúscula o minúscula),
    // seguida por uno o más dígitos, y finalmente por la secuencia 'sin', 'cos', etc.
    final RegExp exp = RegExp(r'([a-zA-Z])(\d+)(sin|cos|tan|cot|sec|csc)\((.*?)\)');

    // Reemplaza las coincidencias encontradas utilizando una función que organiza los grupos capturados
    String reformatted = expresion.replaceAllMapped(exp, (Match m) {
      // Grupo 1: letra (D), Grupo 2: número (2), Grupo 3: función trigonométrica (sin), Grupo 4: argumento de la función (2x)
      return '${m[2]}${m[1]}${m[3]}(${m[4]})';
    });

    return reformatted;
  }

  /// Deriva una expresión compuesta por términos sumados o restados.
  String derivarExpresion(String expresion) {
    // Separa la expresión en términos individuales.
    List<String> terminos = expresion.split(RegExp(r'(?=[+-])'));

    // Deriva cada término individualmente.
    List<String> terminosDerivados = [];
    for (var termino in terminos) {
      termino = termino.trim(); // Elimina espacios en blanco al inicio y al final.
      String terminoDerivado = derivarTermino(termino);
      terminosDerivados.add(terminoDerivado);
    }

    // Une los términos derivados en una expresión final.
    return terminosDerivados.join(' + ').replaceAll(' + -', ' - ');
  }

  /// Deriva un término individual.
  String derivarTermino(String termino) {
    termino = termino.trim();

    // Caso para términos constantes (sin 'x')
    if (!termino.contains('x')) {
      return "0";
    }

    // Caso para términos lineales 'Bx' (sin exponente)
    if (termino.endsWith('x') && !termino.contains('^')) {
      String coeficiente = termino.substring(0, termino.length - 1).trim();
      return coeficiente.isEmpty ? "1" : coeficiente;
    }

    // Caso para términos polinomiales 'Ax^n'
    RegExp expPolinomial = RegExp(r'([+-]?\s*[A-Z])x\^(\d+)');
    var matchPolinomial = expPolinomial.firstMatch(termino);
    if (matchPolinomial != null) {
      String coeficiente = matchPolinomial.group(1)!.replaceAll(" ", "");
      int exponente = int.parse(matchPolinomial.group(2)!);
      return exponente == 2 ? "2${coeficiente}x" : "${exponente}${coeficiente}x^${exponente - 1}";
    }

    // Extendido para funciones trigonométricas con argumentos multiplicativos 'Dcos(kx)', 'Esin(kx)'
    RegExp expTrig = RegExp(r'([+-]?\s*)(\d*)(\s*[A-Z]*)(sin|cos)\((\d+)x\)');
    var matchTrig = expTrig.firstMatch(termino);
    if (matchTrig != null) {
      String signo = matchTrig.group(1)!.contains("-") ? "-" : "";
      // Corrección: Asegurar que el coeficiente incluya cualquier letra antes del número
      String coeficienteLetra = matchTrig.group(3)!.trim().replaceAll(" ", "").replaceAll(RegExp(r'\d'), "");
      String coeficienteNumero = matchTrig.group(2) ?? "";
      String funcion = matchTrig.group(4)!;
      String multiplicadorFunc = matchTrig.group(5) ?? "1"; // Asume 1 si no se especifica
      // Corrección: Aplicar correctamente el multiplicador a la derivada
      String derivadaFuncion = funcion == "sin" ? "cos" : "sin";
      String nuevoSigno = funcion == "cos" ? "-" : ""; // Invertir el signo para cos
      // Corrección: Multiplicar el coeficiente por el multiplicadorFunc para aplicar la regla de la cadena
      String resultado = "${signo}${coeficienteLetra}";
      if (!coeficienteNumero.isEmpty || !multiplicadorFunc.isEmpty) {
        int multiplicadorTotal = (int.tryParse(coeficienteNumero) ?? 1) * int.parse(multiplicadorFunc);
        resultado = "${signo}${multiplicadorTotal}${coeficienteLetra}"; // Ajustar el signo si es necesario
      }
      resultado += "${derivadaFuncion}(${multiplicadorFunc}x)";
      return resultado.startsWith("-") ? resultado : nuevoSigno + resultado; // Ajustar el signo si es necesario
    }

    throw Exception('No se puede derivar el término: $termino');
  }
}
