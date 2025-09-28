import 'package:equatable/equatable.dart';

class QuranSurah extends Equatable {
  const QuranSurah({this.id, this.title, this.aya, this.isSelected});

  final int? id;
  final String? title;
  final String? aya;
  final bool? isSelected;

  @override
  List<Object?> get props => [id, title, aya, isSelected];
}
