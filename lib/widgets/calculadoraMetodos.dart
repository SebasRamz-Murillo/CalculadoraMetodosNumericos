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
      default:
        return {};
    }
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Inserta la funcion f(x,y) aquí',
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                widget.calcula(_getValues());
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
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
