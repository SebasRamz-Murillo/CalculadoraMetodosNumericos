import 'package:calculadora_metodos/util.dart';
import 'package:flutter/material.dart';

class CalculadoraMetodosPad extends StatefulWidget {
  String tipo;
  Function(Map<String, dynamic>) calcula;
  CalculadoraMetodosPad({Key? key, required this.tipo, required this.calcula}) : super(key: key);

  @override
  _CalculadoraMetodosPadState createState() => _CalculadoraMetodosPadState();
}

class _CalculadoraMetodosPadState extends State<CalculadoraMetodosPad> {
  final TextEditingController _controllerf = TextEditingController();
  final TextEditingController _controllerX0 = TextEditingController();
  final TextEditingController _controllerY0 = TextEditingController();
  final TextEditingController _controllerN = TextEditingController();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  late FocusNode _focusNode;
  late ValueNotifier<int> _offsetNotifier;
  List<TextInputCustom> inputs = [];
  @override
  void initState() {
    super.initState();
    _buildInputs();
    _focusNode = FocusNode();
    _offsetNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    clear();
    _focusNode.dispose();
    _offsetNotifier.dispose();
    super.dispose();
  }

  static _CalculadoraMetodosPadState of(BuildContext context) {
    return context.findAncestorStateOfType<_CalculadoraMetodosPadState>()!;
  }

  void _buildInputs() {
    switch (widget.tipo) {
      case "rungeKutta":
        inputs = [
          TextInputCustom(
            labelText: "x0",
            controller: _controllerX0,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "y0",
            controller: _controllerY0,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "x en y(x)",
            controller: _controllerN,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "h",
            controller: _controllerA,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
        ];
        break;
      case "euler":
        inputs = [
          TextInputCustom(
            labelText: "x0",
            controller: _controllerX0,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "y0",
            controller: _controllerY0,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "x en y(x)",
            controller: _controllerN,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "h",
            controller: _controllerA,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
        ];
        break;
      case "newtonRaphson":
        inputs = [
          TextInputCustom(
            labelText: "x0",
            controller: _controllerX0,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
          TextInputCustom(
            labelText: "Máximo de iteraciones",
            controller: _controllerN,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
          ),
        ];
        break;
      default:
        inputs = [];
    }
  }

  void clear() {
    _controllerf.clear();
    _controllerX0.clear();
    _controllerY0.clear();
    _controllerN.clear();
    _controllerA.clear();
    _controllerB.clear();
  }

  Map<String, dynamic> _getValues() {
    switch (widget.tipo) {
      case "rungeKutta":
        return {
          "f": _controllerf.text,
          "x0": _controllerX0.text,
          "y0": _controllerY0.text,
          "xFinal": _controllerN.text,
          "h": _controllerA.text,
        };
      case "euler":
        return {
          "f": _controllerf.text,
          "x0": _controllerX0.text,
          "y0": _controllerY0.text,
          "xFinal": _controllerN.text,
          "h": _controllerA.text,
        };
      case "newtonRaphson":
        return {
          "f": _controllerf.text,
          "x": _controllerX0.text,
          "n": _controllerN.text,
        };
      default:
        return {};
    }
  }

  Exception? _validaciones() {
    switch (widget.tipo) {
      case "rungeKutta":
        if (double.parse(_controllerN.text) < double.parse(_controllerX0.text)) {
          return Exception("xFinal debe ser mayor que x0");
        }

        break;
      case "euler":
        if (double.parse(_controllerN.text) < double.parse(_controllerX0.text)) {
          return Exception("xFinal debe ser mayor que x0");
        }
        break;
      case "newtonRaphson":
        if (int.parse(_controllerN.text) < 1) {
          return Exception("El número de iteraciones debe ser mayor que 0");
        }
        break;
      default:
        return Exception("Error no conocido");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                switch (widget.tipo) {
                  case "rungeKutta":
                    _controllerf.text = "x * sqrt(y)";
                    _controllerX0.text = "1";
                    _controllerY0.text = "4";
                    _controllerN.text = "1.6";
                    _controllerA.text = "0.2";
                    break;
                  case "euler":
                    _controllerf.text = " 0.4 * x * y";
                    _controllerX0.text = "1";
                    _controllerY0.text = "1";
                    _controllerN.text = "2";
                    _controllerA.text = "0.1";
                    break;
                  case "newtonRaphson":
                    _controllerf.text = "x^3 - x - 1";
                    _controllerX0.text = "1";
                    _controllerN.text = "100";
                    break;
                  default:
                }
                setState(() {});
              },
              child: const Text("Ejemplo de input")),

          // Display Result
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: inputs.map((input) => input.build(context)).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _controllerf,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.tipo == "newtonRaphson" ? 'Inserta la función f(x) aquí' : 'Inserta la función f(x,y) aquí',
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                try {
                  if (_validaciones() != null) {
                    throw _validaciones()!;
                  }
                  widget.calcula(_getValues());
                } catch (e) {
                  msgErrors(context, e.toString());
                  return;
                }
                _focusNode.unfocus();
                setState(() {});
              },
              child: const Text('Calcular')),
        ],
      ),
    );
  }
}

class TextInputCustom {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  TextInputCustom({required this.labelText, required this.controller, required this.keyboardType, required this.maxLines});
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
