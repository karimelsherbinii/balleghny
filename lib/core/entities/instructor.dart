import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Insructor extends Equatable {
  Insructor(
      {this.username,
      this.firstName,
      this.lastName,
      this.fullName,
      this.isSelected});

  final String? username;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  bool? isSelected;

  @override
  List<Object?> get props =>
      [username, firstName, lastName, fullName, isSelected];
}
