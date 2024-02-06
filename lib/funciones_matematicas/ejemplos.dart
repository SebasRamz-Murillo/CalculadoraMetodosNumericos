import 'package:flutter/material.dart';

class EjemplosInputsCalculadora {
  final String tipoOperacion;
  EjemplosInputsCalculadora(this.tipoOperacion);

  final List<String> _noHomogeneas = [r" y'' - 2y' - 15y = 4x^2 + 6x + 10 + 2\cos(2x)", r"y'' + 7y' + 10y = 2x^2 + 7x + 9", r"y'' + 2y' - 8y = 2x^2 + 5x + 7"];
  final List<String> _homogeneas = [r"y'' - 2y' - 15y = 0", r"y'' + 7y' + 10y = 0", r"y'' + 2y' - 8y = 0"];
  final List<String> _eulerMejorado = [r"y'' - 2y' - 15 = 4x^2 + 6x + 10 + 2\cos(2x)", r"y'' + 7y' + 10 = 2x^2 + 7x + 9", r"y'' + 2y' - 8 = 2x^2 + 5x + 7"];
  final List<String> _rungeKutta = [r"y'' - 2y' - 15 = 4x^2 + 6x + 10 + 2\cos(2x)", r"y'' + 7y' + 10 = 2x^2 + 7x + 9", r"y'' + 2y' - 8 = 2x^2 + 5x + 7"];

  List<String> _getEjemplos() {
    switch (tipoOperacion) {
      case 'noHomogeneas':
        return _noHomogeneas;
      case 'homogeneas':
        return _homogeneas;
      case 'eulerMejorado':
        return _eulerMejorado;
      case 'rungeKutta':
        return _rungeKutta;
      default:
        return [];
    }
  }

  //Dropdown con lista de los ejemplos
  Widget getEjemplos(Function(String?) onTap) {
    return Column(
      children: [
        const Text("Ejemplos:"),
        DropdownButton<String>(
          items: _getEjemplos().map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            onTap(value);
          },
        )
      ],
    );
  }
}
