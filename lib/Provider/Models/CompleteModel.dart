class CompleteModel {
  String msg;
  Data data;

  CompleteModel({this.msg, this.data});

  CompleteModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String image;
  String imagebase;
  String apiToken;
  String phone;
  String lat;
  String lng;
  String sex;
  String address;
  String googleToken;
  String admin;
  String desc;
  int rate;
  int confirmed;
  int completed;
  int active;
  int status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.image,
        this.imagebase,
        this.apiToken,
        this.phone,
        this.lat,
        this.lng,
        this.sex,
        this.address,
        this.googleToken,
        this.admin,
        this.desc,
        this.rate,
        this.confirmed,
        this.completed,
        this.active,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    imagebase = json['imagebase'];
    apiToken = json['api_token'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    sex = json['sex'];
    address = json['address'];
    googleToken = json['google_token'];
    admin = json['admin'];
    desc = json['desc'];
    rate = json['rate'];
    confirmed = json['confirmed'];
    completed = json['completed'];
    active = json['active'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['imagebase'] = this.imagebase;
    data['api_token'] = this.apiToken;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['sex'] = this.sex;
    data['address'] = this.address;
    data['google_token'] = this.googleToken;
    data['admin'] = this.admin;
    data['desc'] = this.desc;
    data['rate'] = this.rate;
    data['confirmed'] = this.confirmed;
    data['completed'] = this.completed;
    data['active'] = this.active;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
