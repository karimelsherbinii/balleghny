import 'package:equatable/equatable.dart';

class DateRange extends Equatable {
  const DateRange({this.startDate, this.endDate});

  final String? startDate;
  final String? endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}
