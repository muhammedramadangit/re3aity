class SelectCateModel {
  String? msg;
  List<Data?>? data;

  SelectCateModel({this.msg, this.data});

  SelectCateModel.fromJson(Map<String, dynamic> json) {
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
  Categories? categories;
  List<Subcategories?>? subcategories;

  Data({this.categories, this.subcategories});

  Data.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Categories({this.id, this.name, this.createdAt, this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subcategories {
  int? id;
  int? catId;
  int? userId;
  int? clinicPrice;
  int? homePrice;
  String? createdAt;
  String? updatedAt;
  User? user;

  Subcategories(
      {this.id,
        this.catId,
        this.userId,
        this.clinicPrice,
        this.homePrice,
        this.createdAt,
        this.updatedAt,
        this.user});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    userId = json['user_id'];
    clinicPrice = json['clinic_price'];
    homePrice = json['home_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['user_id'] = this.userId;
    data['clinic_price'] = this.clinicPrice;
    data['home_price'] = this.homePrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? imagebase;
  String? apiToken;
  String? phone;
  String? lat;
  String? lng;
  String? sex;
  String? address;
  String? googleToken;
  String? admin;
  String? desc;
  int? rate;
  int? confirmed;
  int? completed;
  int? active;
  int? status;
  String? createdAt;
  String? updatedAt;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

