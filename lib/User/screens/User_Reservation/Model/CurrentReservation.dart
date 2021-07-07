class CurrentModel {
  String msg;
  List<Data> data;

  CurrentModel({this.msg, this.data});

  CurrentModel.fromJson(Map<String, dynamic> json) {
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
  String catName;
  String place;
  String address;
  String date;
  String time;
  String lat;
  String lng;

  Data(
      {this.userName,
        this.catName,
        this.place,
        this.address,
        this.date,
        this.time,
        this.lat,
        this.lng});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    catName = json['cat_name'];
    place = json['place'];
    address = json['address'];
    date = json['date'];
    time = json['time'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['cat_name'] = this.catName;
    data['place'] = this.place;
    data['address'] = this.address;
    data['date'] = this.date;
    data['time'] = this.time;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
