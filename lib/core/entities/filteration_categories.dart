import 'package:equatable/equatable.dart';
import 'instructor.dart';
import 'category.dart';

class FilterationCategories extends Equatable {
  const FilterationCategories({
    this.insructors,
    this.levels,
    this.types,
  });

  final List<Insructor>? insructors;
  final List<Category>? levels;
  final List<Category>? types;

  @override
  List<Object?> get props => [insructors, types, levels];
}
