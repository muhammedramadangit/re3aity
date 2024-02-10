class SocialModel{
  String? socialId;
  String? name;
  String? phone;
  String? password;
  String? email;
  String? googleToken;

  SocialModel({
    this.socialId,
    this.name,
    this.phone,
    this.password,
    this.email,
    this.googleToken,
  });

  SocialModel.fromJson(Map<String, dynamic> json) {
    socialId = json['social_id'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    googleToken = json['google_token'];
  }

  Map<String, dynamic> login() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['social_id'] = this.socialId;
    data['google_token'] = this.googleToken;
    return data;
  }

  Map<String, dynamic> register() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['social_id'] = this.socialId;
    data['password'] = this.password;
    data['google_token'] = this.googleToken;
    return data;
  }

  printData() {
    print('ID >>> ${this.socialId}');
    print('Email >>> ${this.email}');
    print('Name >>> ${this.name}');
    print('Phone >>> ${this.phone}');
  }
}