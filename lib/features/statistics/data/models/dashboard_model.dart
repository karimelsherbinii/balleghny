class DashboardModel {
  int? total;
  int? newCases;
  int? inProgress;
  int? closed;
  int? muslims;
  int? nonMuslims;

  DashboardModel({
    this.total,
    this.newCases,
    this.inProgress,
    this.closed,
    this.muslims,
    this.nonMuslims,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      total: json['total'] as int?,
      newCases: json['new'] as int?,
      inProgress: json['in_progress'] as int?,
      closed: json['closed'] as int?,
      muslims: json['muslims'] as int?,
      nonMuslims: json['non_muslims'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'new': newCases,
        'in_progress': inProgress,
        'closed': closed,
        'muslims': muslims,
        'non_muslims': nonMuslims,
      };
}
