import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/RungeKutta/runge_kutta_result_graph.dart';
import 'package:flutter/material.dart';

class RungeKuttaResultWidget extends StatefulWidget {
  final RungeKutta4Solution result;

  const RungeKuttaResultWidget({Key? key, required this.result}) : super(key: key);

  @override
  State<RungeKuttaResultWidget> createState() => _RungeKuttaResultWidgetState();
}

class _RungeKuttaResultWidgetState extends State<RungeKuttaResultWidget> {
  bool _graph = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
/*           IconButton(
              onPressed: () {
                setState(() {
                  _graph = !_graph;
                });
              },
              icon: Icon(_graph ? Icons.table_rows : Icons.bar_chart)),
 */
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.9,
              child: !_graph
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 20.0, // Ajusta el espacio entre las columnas según sea necesario
                        columns: const [
                          DataColumn(label: Text('x', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('y', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('y+1', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('k1', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('k2', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('k3', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                          DataColumn(label: Text('k4', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                        ],
                        rows: _buildRows(),
                      ),
                    )
                  : RungeKuttaResultGraph(
                      solution: widget.result,
                    )),
        ],
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List.generate(widget.result.xValues.length - 1, (index) {
      return DataRow(
        cells: [
          DataCell(Text(widget.result.xValues[index].toString())),
          DataCell(Text(widget.result.yValues[index].toString())),
          DataCell(Text(widget.result.yValues[index + 1].toString())),
          DataCell(Text(widget.result.k1Values[index].toString())),
          DataCell(Text(widget.result.k2Values[index].toString())),
          DataCell(Text(widget.result.k3Values[index].toString())),
          DataCell(Text(widget.result.k4Values[index].toString())),
        ],
      );
    });
  }
}
