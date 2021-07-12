import 'package:lastre3ayty/User/models/Category_model/Category.dart';
import 'package:lastre3ayty/User/models/Category_model/Sub_category.dart';

class CategoryData {
  Category categories;
  List<Subcategory> subcategories;

  CategoryData({this.categories, this.subcategories});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new Category.fromJson(json['categories'])
        : null;
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategory>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.toJson();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}