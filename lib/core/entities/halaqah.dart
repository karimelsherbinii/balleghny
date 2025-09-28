import 'package:equatable/equatable.dart';
import 'time_slot.dart';

class Halaqah extends Equatable {
  const Halaqah({
    this.id,
    this.slug,
    this.title,
    this.instructorId,
    this.instructorName,
    this.isDailyBool,
    this.isDailyText,
    this.forChildren,
    this.forGenderText,
    this.forGender,
    this.price,
    this.currency,
    this.seatsNumber,
    this.availableSeats,
    this.subscriptionType,
    this.level,
    this.type,
    this.description,
    this.timeSlots,
    this.thumbnail,
    this.shareUrl,
    this.days,
    required this.allowJoin,
    this.allowRenew,
    this.showCoterie,
    this.reason,
  });

  final int? id;
  final String? slug;
  final String? title;
  final int? instructorId;
  final String? instructorName;
  final int? isDailyBool;
  final String? isDailyText;
  final int? forChildren;
  final String? forGenderText;
  final String? forGender;
  final int? price;
  final String? currency;
  final int? seatsNumber;
  final int? availableSeats;
  final int? subscriptionType;
  final String? level;
  final String? type;
  final String? description;
  final List<TimeSlot>? timeSlots;
  final String? thumbnail;
  final String? shareUrl;
  final List<String>? days;
  final bool allowJoin;
  final bool? allowRenew;
  final bool? showCoterie;
  final String? reason;

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        instructorId,
        instructorName,
        isDailyBool,
        isDailyText,
        forChildren,
        forGenderText,
        forGender,
        price,
        currency,
        seatsNumber,
        availableSeats,
        subscriptionType,
        level,
        type,
        description,
        timeSlots,
        thumbnail,
        shareUrl,
        days,
        allowJoin,
        allowRenew,
        showCoterie
      ];
}

// class TimeSlot {
//   TimeSlot({
//     this.id,
//     this.fromHour,
//     this.toHour,
//   });

//   int? id;
//   String? fromHour;
//   String? toHour;

//   factory TimeSlot.fromJson(Map<String?, dynamic> json) => TimeSlot(
//         id: json["id"],
//         fromHour: json["from_hour"],
//         toHour: json["to_hour"],
//       );

//   Map<String?, dynamic> toJson() => {
//         "id": id,
//         "from_hour": fromHour,
//         "to_hour": toHour,
//       };
// }
