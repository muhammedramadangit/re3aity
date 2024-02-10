import 'package:re3aity/User/models/Category_model/user.dart';

class Subcategory {
  int? id;
  int? catId;
  int? userId;
  dynamic homeprice;
  dynamic clincprice;
  User? user;

  Subcategory(
      {this.id,
        this.catId,
        this.userId,
        this.homeprice,
        this.clincprice,
        this.user});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    userId = json['user_id'];
    homeprice = json['home_price'];
    clincprice = json['clinic_price'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['user_id'] = this.userId;
    data['home_price']=this.homeprice;
    data['clinic_price']=this.clincprice;
    // data['price'] = this.price;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}