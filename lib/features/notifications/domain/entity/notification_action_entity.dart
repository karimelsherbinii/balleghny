import 'package:equatable/equatable.dart';

class NotificationActionEntity extends Equatable {
  final String? mode;
  final int? itemId;

  const NotificationActionEntity({this.mode, this.itemId});
  @override
  List<Object?> get props => [
        mode,
        itemId,
      ];
}
