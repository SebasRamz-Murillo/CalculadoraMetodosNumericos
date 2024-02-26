import 'package:calculadora_metodos/models/newton_raphson.dart';
import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:calculadora_metodos/views/RungeKutta/runge_kutta_result_graph.dart';
import 'package:flutter/material.dart';

class NewtonRaphsonResulWidget extends StatefulWidget {
  final NewtonRaphsonSolution result;

  const NewtonRaphsonResulWidget({Key? key, required this.result}) : super(key: key);

  @override
  State<NewtonRaphsonResulWidget> createState() => _NewtonRaphsonResulWidgetState();
}

class _NewtonRaphsonResulWidgetState extends State<NewtonRaphsonResulWidget> {
  bool _graph = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
/*         IconButton(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 20.0, // Ajusta el espacio entre las columnas según sea necesario
                  columns: const [
                    DataColumn(label: Text('x', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                    DataColumn(label: Text('f(x)', style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                    DataColumn(label: Text("f(x)'", style: TextStyle(fontFamily: 'Montserrat', fontSize: 11.0))),
                  ],
                  rows: _buildRows(),
                ),
              ),
            ))
      ],
    );
  }

  List<DataRow> _buildRows() {
    return List.generate(widget.result.x.length, (index) {
      return DataRow(
        cells: [
          DataCell(Text(widget.result.x[index].toString())),
          DataCell(Text(widget.result.fValue[index].toString())),
          DataCell(Text(widget.result.fDerivateValue[index].toString())),
        ],
      );
    });
  }
}
