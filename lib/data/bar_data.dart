import 'package:flutter/material.dart';
import 'package:my_lms/data/models/bar_chart_model.dart';

class BarData {
  static List<BarChartModel> barData = [
    BarChartModel(
      id: 0,
      name: 'Mon',
      y: 15,
      color: Color(0xff19bfff),
    ),
    BarChartModel(
      name: 'Tue',
      id: 1,
      y: 12,
      color: Color(0xffff4d94),
    ),
    BarChartModel(
      name: 'Wed',
      id: 2,
      y: 11,
      color: Color(0xff2bdb90),
    ),
    BarChartModel(
      name: 'Thu',
      id: 3,
      y: 10,
      color: Color(0xffffdd80),
    ),
    BarChartModel(
      name: 'Fri',
      id: 4,
      y: 5,
      color: Color(0xff2bdb90),
    ),
    BarChartModel(
      name: 'Sat',
      id: 5,
      y: 17,
      color: Color(0xffffdd80),
    ),
    BarChartModel(
      name: 'Sun',
      id: 6,
      y: 5,
      color: Color(0xffff4d94),
    ),
  ];
}
