import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditosView extends StatelessWidget {
  Map<String, String> librerias = {
    "function_tree": "https://pub.dev/packages/function_tree",
    "flutter_math_fork": "https://pub.dev/packages/flutter_math_fork",
    "math_expressions": "https://pub.dev/packages/math_expressions",
    "calculus": "https://pub.dev/packages/calculus",
  };

  CreditosView({super.key});

  @override
  Widget build(BuildContext context) {
    void _launchURL(String urlSt) async {
      Uri url = Uri.parse(urlSt);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
/*         throw 'No se pudo abrir la URL: $url';
 */
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Créditos',
          style: TextStyle(color: Colors.white), // Ajustar color del texto
        ),
        backgroundColor: Theme.of(context).primaryColor, // Color de fondo
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Manuel Sebastian Ramirez Murillo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Universidad Tecnologica De Torreon',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Matricula: 20170134',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Librerias Utilizadas:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              // Expandir lista para llenar espacio disponible
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: librerias.length,
                itemBuilder: (context, index) {
                  final itemKey = librerias.keys.elementAt(index);
                  final itemValue = librerias.values.elementAt(index);
                  return ListTile(title: Text(itemKey), subtitle: Text(itemValue), trailing: const Icon(Icons.link), onTap: () => _launchURL(itemValue));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
