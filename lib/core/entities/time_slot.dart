import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  const TimeSlot({
    this.id,
    this.fromHour,
    this.toHour,
  });

  final int? id;
  final String? fromHour;
  final String? toHour;

  @override
  List<Object?> get props => [id, fromHour, toHour];
}
