import 'package:calculadora_metodos/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/tex.dart';

class CustomTeXDisplay extends StatefulWidget {
  final TextEditingController controller;
  List<String> resultado;

  CustomTeXDisplay(this.controller, this.resultado, {super.key});

  @override
  _CustomTeXDisplayState createState() => _CustomTeXDisplayState();
}

class _CustomTeXDisplayState extends State<CustomTeXDisplay> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChange);
  }

  void _onTextChange() {
/*     printAst(ast.greenRoot);
 */
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text("Ecuación:"),
                    SelectableMath.tex(
                      widget.controller.text,
                      mathStyle: MathStyle.text,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    if (widget.resultado.isNotEmpty) ...[
                      const Divider(
                        thickness: 3,
                      ),
                      Text("Resultados:"),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var resultado in widget.resultado) ...[
                              Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.centerLeft,
                                child: Text("Paso: ${widget.resultado.indexOf(resultado) + 1}"),
                              ),
                              SelectableMath.tex(
                                resultado,
                                mathStyle: MathStyle.text,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                            ]
                          ],
                        ),
                      ))
                    ]
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Inserta la ecuación aquí',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ErrorNode(String s) {
    print("Error: $s");
  }
}
