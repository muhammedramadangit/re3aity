class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? apiToken;
  String? phone;
  String? lat;
  String? lng;
  String? type;
  String? sex;
  String? address;
  String? admin;
  String? desc;
  String? about;
  int? rate;
  int? confirmed;
  dynamic homeprice;
  dynamic clincprice;

  int? active;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.apiToken,
    this.phone,
    this.lat,
    this.lng,
    this.type,
    this.sex,
    this.address,
    this.admin,
    this.desc,
    this.about,
    this.rate,
    this.confirmed,
    this.homeprice,
    this.clincprice,
    this.active,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    apiToken = json['api_token'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    type = json['type'];
    sex = json['sex'];
    address = json['address'];
    admin = json['admin'];
    desc = json['desc'];
    about = json['about'];
    rate = json['rate'];
    confirmed = json['confirmed'];
    homeprice = json['home_price'];
    clincprice = json['clinic_price'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['api_token'] = this.apiToken;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['type'] = this.type;
    data['sex'] = this.sex;
    data['address'] = this.address;
    data['admin'] = this.admin;
    data['desc'] = this.desc;
    data['about'] = this.about;
    data['rate'] = this.rate;
    data['confirmed'] = this.confirmed;
    // data['price'] = this.price;
    data['active'] = this.active;
    return data;
  }
}
