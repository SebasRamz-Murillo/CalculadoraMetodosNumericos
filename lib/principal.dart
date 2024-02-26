import 'dart:math';

import 'package:calculadora_metodos/models/newton_raphson.dart';
import 'package:calculadora_metodos/views/EulerMejorado/euler_mejorado_view.dart';
import 'package:calculadora_metodos/views/NewtonRaphson/newton_raphson_view.dart';
import 'package:calculadora_metodos/views/RungeKutta/runge_kutta_view.dart';
import 'package:calculadora_metodos/views/creditos.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    //DiferencialesNoHomogeneasView(), //TODO PENDIENTE
    EulerMView(),
    RungeKuttaView(),
    NewtonRaphsonView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Metodos Numericos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
/*           TextButton.icon(
              onPressed: () {
                String f = "f(x) = 2x^2 + 3x + 5";
              },
              icon: Icon(Icons.calculate_outlined),
              label: Text("Formulario")),
 */
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreditosView(),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Euler Mejorado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Runge Kutta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Newton Rapson',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
