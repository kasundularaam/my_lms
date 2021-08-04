part of 'bar_chart_cubit.dart';

@immutable
abstract class BarChartState {}

class BarChartInitial extends BarChartState {}

class BarChartLoading extends BarChartState {
  final List<BarChartModel> loadingList;
  final String unit;
  final double interval;
  BarChartLoading({
    required this.loadingList,
    required this.unit,
    required this.interval,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarChartLoading &&
        listEquals(other.loadingList, loadingList) &&
        other.unit == unit &&
        other.interval == interval;
  }

  @override
  int get hashCode => loadingList.hashCode ^ unit.hashCode ^ interval.hashCode;

  @override
  String toString() =>
      'BarChartLoading(loadingList: $loadingList, unit: $unit, interval: $interval)';
}

class BarChartLoaded extends BarChartState {
  final List<BarChartModel> loadedList;
  final double max;
  final String unit;
  final double interval;
  BarChartLoaded({
    required this.loadedList,
    required this.max,
    required this.unit,
    required this.interval,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarChartLoaded &&
        listEquals(other.loadedList, loadedList) &&
        other.max == max &&
        other.unit == unit &&
        other.interval == interval;
  }

  @override
  int get hashCode {
    return loadedList.hashCode ^
        max.hashCode ^
        unit.hashCode ^
        interval.hashCode;
  }

  @override
  String toString() {
    return 'BarChartLoaded(loadedList: $loadedList, max: $max, unit: $unit, interval: $interval)';
  }
}

class BarChartFailed extends BarChartState {
  final List<BarChartModel> failedList;
  final String unit;
  final double interval;
  BarChartFailed({
    required this.failedList,
    required this.unit,
    required this.interval,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarChartFailed &&
        listEquals(other.failedList, failedList) &&
        other.unit == unit &&
        other.interval == interval;
  }

  @override
  int get hashCode => failedList.hashCode ^ unit.hashCode ^ interval.hashCode;

  @override
  String toString() =>
      'BarChartFailed(failedList: $failedList, unit: $unit, interval: $interval)';
}
