import 'dart:math';

import 'package:calculadora_metodos/models/euler_mejorado_result.dart';
import 'package:calculadora_metodos/models/newton_raphson.dart';
import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/creditos.dart';
import 'package:calculadora_metodos/views/euler_mejorado_view.dart';
import 'package:calculadora_metodos/views/runge_kutta.dart';
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
    Text(
      'Newton Rapson',
    ),
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
        backgroundColor: Colors.blue,
        title: const Text('Metodos Numericos'),
        actions: [
          TextButton.icon(
              onPressed: () {
                String stEcuacion = "x^3-x-1";
                double x0 = 1;
                NewtonRaphson newton = NewtonRaphson(x0, stEcuacion);
                NewtonRaphsonSolution sol = newton.solve();
                print(sol.fValue);
                for (var i in sol.x) {
                  print(i);
                }
              },
              icon: Icon(Icons.calculate_outlined),
              label: Text("Formulario")),
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
        backgroundColor: Colors.blue,
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
