import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/data/models/bar_chart_model.dart';
import 'package:my_lms/presentation/screens/widgets/bar_titels.dart';

class BarChartWidget extends StatelessWidget {
  final double max;
  final List<BarChartModel> barchartModelList;
  final String unit;
  final double interval;
  const BarChartWidget({
    Key? key,
    required this.max,
    required this.barchartModelList,
    required this.unit,
    required this.interval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: max + 2,
          minY: 0,
          groupsSpace: 3.w,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: BarTitles.getTopBottomTitles(
                barchartModelList: barchartModelList),
            leftTitles: BarTitles.getSideTitles(unit: unit, interval: interval),
            rightTitles:
                BarTitles.getSideTitles(unit: unit, interval: interval),
          ),
          gridData: FlGridData(
            checkToShowHorizontalLine: (value) => value % interval == 0,
            getDrawingHorizontalLine: (value) {
              if (value == 0) {
                return FlLine(
                  color: const Color(0xff363753),
                  strokeWidth: 3,
                );
              } else {
                return FlLine(
                  color: const Color(0xff2a2747),
                  strokeWidth: 0.8,
                );
              }
            },
          ),
          barGroups: barchartModelList
              .map(
                (data) => BarChartGroupData(
                  x: data.id,
                  barRods: [
                    BarChartRodData(
                      y: data.y,
                      width: 6.w,
                      colors: [data.color],
                      borderRadius: data.y > 0
                          ? BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            )
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      );
}
