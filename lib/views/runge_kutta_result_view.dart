import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:flutter/material.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 11.0);

class RungeKuttaResultWidget extends StatelessWidget {
  final RungeKutta4Solution result;

  const RungeKuttaResultWidget({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.8,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 20.0, // Ajusta el espacio entre las columnas según sea necesario
            columns: [
              DataColumn(label: Text('x', style: style)),
              DataColumn(label: Text('y', style: style)),
              DataColumn(label: Text('y+1', style: style)),
              DataColumn(label: Text('k1', style: style)),
              DataColumn(label: Text('k2', style: style)),
              DataColumn(label: Text('k3', style: style)),
              DataColumn(label: Text('k4', style: style)),
            ],
            rows: _buildRows(),
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List.generate(result.xValues.length - 1, (index) {
      return DataRow(
        cells: [
          DataCell(Text(result.xValues[index].toString(), style: style)),
          DataCell(Text(result.yValues[index].toString(), style: style)),
          DataCell(Text(result.yValues[index + 1].toString(), style: style)),
          DataCell(Text(result.k1Values[index].toString(), style: style)),
          DataCell(Text(result.k2Values[index].toString(), style: style)),
          DataCell(Text(result.k3Values[index].toString(), style: style)),
          DataCell(Text(result.k4Values[index].toString(), style: style)),
        ],
      );
    });
  }
}
