import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  Category({this.id, this.name, this.slug, this.isSelected});

  final int? id;
  final String? name;
  final String? slug;
  bool? isSelected;

  @override
  List<Object?> get props => [id, name, slug, isSelected];
}
