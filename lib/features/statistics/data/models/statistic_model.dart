class StatisticModel {
  final int? id;
  final String? name;
  final int? total;
  final WeeklyData? weekly;
  final MonthlyData? monthly;
  final YearlyData? yearly;

  StatisticModel({
    this.id,
    this.name,
    this.total,
    this.weekly,
    this.monthly,
    this.yearly,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      id: json['id'],
      name: json['name'],
      total: json['total'],
      weekly:
          json['weekly'] != null ? WeeklyData.fromJson(json['weekly']) : null,
      monthly: json['monthly'] != null
          ? MonthlyData.fromJson(json['monthly'])
          : null,
      yearly:
          json['yearly'] != null ? YearlyData.fromJson(json['yearly']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'total': total,
      'weekly': weekly?.toJson(),
      'monthly': monthly?.toJson(),
      'yearly': yearly?.toJson(),
    };
  }
}

class WeeklyData {
  final int sunday;
  final int monday;
  final int tuesday;
  final int wednesday;
  final int thursday;
  final int friday;
  final int saturday;

  WeeklyData({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory WeeklyData.fromJson(Map<String, dynamic> json) {
    return WeeklyData(
      sunday: json['sunday'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunday': sunday,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
    };
  }
}

class MonthlyData {
  final int week1;
  final int week2;
  final int week3;
  final int week4;

  MonthlyData({
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      week1: json['1'],
      week2: json['2'],
      week3: json['3'],
      week4: json['4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1': week1,
      '2': week2,
      '3': week3,
      '4': week4,
    };
  }
}

class YearlyData {
  final int jan;
  final int feb;
  final int mar;
  final int apr;
  final int? may;
  final int jun;
  final int jul;
  final int aug;
  final int sep;
  final int oct;
  final int nov;
  final int dec;

  YearlyData({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
      this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.dec,
  });

  factory YearlyData.fromJson(Map<String, dynamic> json) {
    return YearlyData(
      jan: json['jan'],
      feb: json['feb'],
      mar: json['mar'],
      apr: json['apr'],
      may: 
      json['may'] != null ? json['may'] as int : null,
      jun: json['jun'],
      jul: json['jul'],
      aug: json['aug'],
      sep: json['sep'],
      oct: json['oct'],
      nov: json['nov'],
      dec: json['dec'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jan': jan,
      'feb': feb,
      'mar': mar,
      'apr': apr,
      'may': may,
      'jun': jun,
      'jul': jul,
      'aug': aug,
      'sep': sep,
      'oct': oct,
      'nov': nov,
      'dec': dec,
    };
  }
}
