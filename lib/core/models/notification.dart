class NotificationData {
  int? id;
  String? title;
  String? body;
  String? priority;
  String? iconClass;
  bool? isRead;
  String? soundUrl;
  DataArray? dataArray;
  String? mode;
  int? itemId;
  String? createdAtDate;
  String? createdAtTime;

  NotificationData(
      {this.id,
      this.title,
      this.body,
      this.priority,
      this.iconClass,
      this.isRead,
      this.soundUrl,
      this.dataArray,
      this.mode,
      this.itemId,
      this.createdAtDate,
      this.createdAtTime});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    priority = json['priority'];
    iconClass = json['icon_class'];
    isRead = json['is_read'];
    soundUrl = json['sound_url'];
    dataArray = json['data_array'] != null
        ? DataArray.fromJson(json['data_array'])
        : null;
    mode = json['mode'];
    itemId = json['item_id'];
    createdAtDate = json['created_at_date'];
    createdAtTime = json['created_at_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['priority'] = priority;
    data['icon_class'] = iconClass;
    data['is_read'] = isRead;
    data['sound_url'] = soundUrl;
    if (dataArray != null) {
      data['data_array'] = dataArray!.toJson();
    }
    data['mode'] = mode;
    data['item_id'] = itemId;
    data['created_at_date'] = createdAtDate;
    data['created_at_time'] = createdAtTime;
    return data;
  }
}

class DataArray {
  String? mode;
  int? itemId;
  DataArray({this.mode, this.itemId});

  DataArray.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mode'] = mode;
    data['item_id'] = itemId;
    return data;
  }
}
