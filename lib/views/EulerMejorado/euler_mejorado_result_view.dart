import 'package:calculadora_metodos/models/euler_mejorado_result.dart';
import 'package:flutter/material.dart';

TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 11.0);

class EulerMResultWidget extends StatelessWidget {
  final EulerMejoradoSolution result;

  const EulerMResultWidget({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columnSpacing: 20.0, // Ajusta el espacio entre las columnas según sea necesario
            columns: [
              DataColumn(label: Text('x', style: style)),
              DataColumn(label: Text('yn', style: style)),
              DataColumn(label: Text('y aproximado', style: style)),
              DataColumn(label: Text('y real', style: style)),
              DataColumn(label: Text('Error', style: style)),
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
          DataCell(Text(result.yAproximadoValues[index].toString(), style: style)),
          DataCell(Text(result.yRealValues[index].toString(), style: style)),
          DataCell(Text(result.errorAbsolutoValues[index].toString(), style: style)),
        ],
      );
    });
  }
}
