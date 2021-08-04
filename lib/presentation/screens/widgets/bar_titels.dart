import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/bar_chart_model.dart';
import 'package:sizer/sizer.dart';

class BarTitles {
  static SideTitles getTopBottomTitles(
          {required List<BarChartModel> barchartModelList}) =>
      SideTitles(
        showTitles: true,
        getTextStyles: (value) =>
            TextStyle(color: MyColors.accentColor, fontSize: 10.sp),
        margin: 10,
        getTitles: (double id) => barchartModelList
            .firstWhere((element) => element.id == id.toInt())
            .name,
      );

  static SideTitles getSideTitles(
          {required String unit, required double interval}) =>
      SideTitles(
        showTitles: true,
        getTextStyles: (value) =>
            TextStyle(color: MyColors.accentColor, fontSize: 8.sp),
        rotateAngle: -45,
        interval: interval,
        // reservedSize: 30,
        getTitles: (double value) => value == 0 ? '0' : '${value.toInt()}$unit',
      );
}
