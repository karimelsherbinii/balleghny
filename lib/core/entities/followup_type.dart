import 'package:equatable/equatable.dart';

class FollowupType extends Equatable {
  const FollowupType({this.id, this.name, this.slug, this.isSelected});

  final int? id;
  final String? name;
  final String? slug;
  final bool? isSelected;

  @override
  List<Object?> get props => [id, name, slug, isSelected];
}
