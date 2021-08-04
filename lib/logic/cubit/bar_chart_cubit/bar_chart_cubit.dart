import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/data/models/bar_chart_model.dart';
import 'package:my_lms/data/repositories/firebase_repo.dart';

part 'bar_chart_state.dart';

class BarChartCubit extends Cubit<BarChartState> {
  BarChartCubit() : super(BarChartInitial());

  Future<void> loadBarChart() async {
    List<String> week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<BarChartModel> zeroDataList = [];
    int i = 0;
    week.forEach((day) {
      zeroDataList.add(
          BarChartModel(id: i, name: day, y: 0, color: MyColors.accentColor));
      i++;
    });
    try {
      emit(BarChartLoading(loadingList: zeroDataList, unit: "h", interval: 1));
      List<BarChartModel> rowList = await FirebaseRepo.getBarChartDataList();
      List<BarChartModel> loadedList = [];
      double max = 0;
      rowList.forEach((item) {
        if (max < item.y) {
          max = item.y;
        }
      });
      int j = 0;
      double generetedMax = 0;
      String unit = "h";
      double interval = ((generetedMax / 5) + 1).floor().toDouble();
      rowList.forEach((barData) {
        if (max < 60) {
          generetedMax = max;
          unit = "s";
          loadedList.add(BarChartModel(
              id: j, name: barData.name, y: barData.y, color: barData.color));
        } else if (max > 60 && max < 3600) {
          generetedMax = double.parse(
              ((max / 60) % 60).toStringAsFixed(2).padLeft(2, '0'));
          unit = "m";
          double minutesDoub = double.parse(
              ((barData.y / 60) % 60).toStringAsFixed(2).padLeft(2, '0'));
          loadedList.add(BarChartModel(
              id: j, name: barData.name, y: minutesDoub, color: barData.color));
        } else if (max > 3600) {
          generetedMax = double.parse(
              ((max / (60 * 60)) % 60).toStringAsFixed(2).padLeft(2, '0'));
          unit = "h";
          double hoursDoub = double.parse(((barData.y / (60 * 60)) % 60)
              .toStringAsFixed(2)
              .padLeft(2, '0'));
          loadedList.add(BarChartModel(
              id: j, name: barData.name, y: hoursDoub, color: barData.color));
        }
        j++;
      });
      emit(BarChartLoaded(
          loadedList: loadedList,
          max: generetedMax,
          unit: unit,
          interval: interval));
    } catch (e) {
      emit(BarChartFailed(failedList: zeroDataList, unit: "h", interval: 1));
    }
  }
}
