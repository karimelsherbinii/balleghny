import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Courses extends Equatable {
  Courses({this.id, this.title, this.isSelected});

  final int? id;
  final String? title;

  bool? isSelected;

  @override
  List<Object?> get props => [id, title, isSelected];
}
