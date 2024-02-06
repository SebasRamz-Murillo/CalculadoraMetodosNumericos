import 'package:flutter/material.dart';

class CreditosView extends StatelessWidget {
  Map<String, String> librerias = {
    "function_tree": "https://pub.dev/packages/function_tree",
    "flutter_math_fork": "https://pub.dev/packages/flutter_math_fork",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
            'Manuel Sebastian Ramirez Murillo\n',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Universidad Tecnologica De Torreon\n',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Matricula: 20170134\n',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Librerias Utilizadas:"),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: librerias.length,
                    itemBuilder: (ctx, index) {
                      return Row(
                        children: [
                          Text(librerias.keys.elementAt(index)),
                        ],
                      );
                    },
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
