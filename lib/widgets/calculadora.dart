import 'package:calculadora_metodos/widgets/customTeXDisplay.dart';
import 'package:calculadora_metodos/widgets/customTextField.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculadoraPad extends StatefulWidget {
  final TextEditingController controller;
  List<String> resultado;

  CalculadoraPad(this.controller, this.resultado, {Key? key}) : super(key: key);

  @override
  _CalculadoraPadState createState() => _CalculadoraPadState();
}

class _CalculadoraPadState extends State<CalculadoraPad> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late ValueNotifier<int> _offsetNotifier;
  List<List<Widget>> botones = [];
  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();
    _offsetNotifier = ValueNotifier<int>(0);
    buildBotonoes();
  }

  void buildBotonoes() {
    botones = [
      [
        BotonCalculadora('7'),
        BotonCalculadora('8'),
        BotonCalculadora('9'),
        BotonCalculadora('/'),
      ],
      [
        BotonCalculadora('4'),
        BotonCalculadora('5'),
        BotonCalculadora('6'),
        BotonCalculadora('*'),
      ],
      [
        BotonCalculadora('1'),
        BotonCalculadora('2'),
        BotonCalculadora('3'),
        BotonCalculadora('-'),
      ],
      [
        BotonCalculadora('.'),
        BotonCalculadora('0'),
        BotonCalculadora('+'),
        BotonCalculadora('='),
      ],
      [
        BotonCalculadora('sin', returnText: r'\sin'),
        BotonCalculadora('cos', returnText: r'\cos'),
        BotonCalculadora('x√', returnText: r'\sqrt[]{}'),
        BotonCalculadora('x/x', returnText: r'\frac{x}{x}'),
      ],
      [
        BotonCalculadora('√', returnText: r'\sqrt{}'),
        BotonCalculadora('^', returnText: r'^{}'),
        BotonCalculadora('1/x', returnText: r'\frac{1}{}'),
      ],
      [
        BotonCalculadora('∫', returnText: r'\int'),
        BotonCalculadora('d/dx', returnText: 'd/dx'),
        BotonCalculadora('e', returnText: r'e'),
        BotonCalculadora('C'),
      ]
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Display Result
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            alignment: Alignment.centerRight,
            child: CustomTeXDisplay(
              widget.controller,
              widget.resultado,
            ),
          ),
          ...botones.map(
            (fila) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: fila,
            ),
          ),
        ],
      ),
    );
  }

  String parseCalculadoraText(String textNorm) {
    String textParsed = widget.controller.text;
    bool caracterEspecial = false;
    switch (textNorm) {
      case 'C':
        textParsed = '';
        break;
      case '=':
        textParsed = textParsed.replaceAll('x', '*');
        Parser p = Parser();
        Expression exp = p.parse(textParsed);
        ContextModel cm = ContextModel();
        textParsed = exp.evaluate(EvaluationType.REAL, cm).toString();
        break;
      case '√':
        caracterEspecial = true;
        textParsed += '|';
        break;
      case '1/x':
        textParsed += r'\frac{1}{}';
        break;
      case '^':
        caracterEspecial = true;
        textParsed += r'^{}';
        break;
      default:
        textParsed += textNorm;
    }
    return textParsed;
  }

  Widget BotonCalculadora(String character, {String? returnText}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.controller.text = parseCalculadoraText(returnText != null ? returnText : character);
          print(widget.controller.text);
        });
      },
      child: SizedBox(
        width: 40,
        height: 50,
        child: Center(
          child: Text(
            character,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
