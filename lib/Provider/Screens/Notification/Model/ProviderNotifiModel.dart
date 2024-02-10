class ProviderNotificationModel {
  String? msg;
  List<Data?>? data;

  ProviderNotificationModel({this.msg, this.data});

  ProviderNotificationModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? ownerId;
  String? commission;
  String? content;
  String? title;
  String? body;
  int? reservationId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.ownerId,
        this.commission,
        this.content,
        this.title,
        this.body,
        this.reservationId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    commission = json['commission'];
    content = json['content'];
    title = json['title'];
    body = json['body'];
    reservationId = json['reservation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['commission'] = this.commission;
    data['content'] = this.content;
    data['title'] = this.title;
    data['body'] = this.body;
    data['reservation_id'] = this.reservationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
