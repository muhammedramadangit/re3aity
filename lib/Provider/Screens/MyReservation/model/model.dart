class ReversationsModel {
  String msg;
  List<Data> data;

  ReversationsModel({this.msg, this.data});

  ReversationsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String userName;
  String lat;
  String lng;
  String address;
  String sex;
  String phone;
  String image;
  String place;
  String date;
  String time;

  Data(
      {this.userName,
        this.lat,
        this.lng,
        this.address,
        this.sex,
        this.phone,
        this.image,
        this.place,
        this.date,
        this.time});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    sex = json['sex'];
    phone = json['phone'];
    image = json['image'];
    place = json['place'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['place'] = this.place;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
