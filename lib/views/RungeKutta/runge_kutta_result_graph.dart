import 'package:calculadora_metodos/models/runge_kutta2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RungeKuttaResultGraph extends StatelessWidget {
  final RungeKutta4Solution solution;

  const RungeKuttaResultGraph({Key? key, required this.solution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CartesianSeries<dynamic, dynamic>> chartData = [];
    void _buildChartData() {
      chartData = [
        LineSeries<dynamic, dynamic>(
          dataSource: solution.yValues,
          xValueMapper: (dynamic data, _) => data[0],
          yValueMapper: (dynamic data, _) => data[1],
          name: "y(x)",
        ),
      ];
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.9,
      child: SfCartesianChart(
        title: const ChartTitle(text: "Runge-Kutta 4 Solution Graph"),
        primaryXAxis: const NumericAxis(
          title: AxisTitle(text: "x"),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: "y(x)"),
        ),
        series: chartData,
      ),
    );
  }
}
