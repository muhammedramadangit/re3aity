import 'package:re3aity/User/models/Category_model/All_category.dart';
import 'package:re3aity/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionController {
  NetworkUtil _util = NetworkUtil();
  AllCategories _categoryDataModel = AllCategories();
  bool isLoading = true;

  Future<AllCategories> getSection() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
    };

    final data = await _util.get("selectcat", headers: header);

    print(data);
    if (data == null) {
      _categoryDataModel = AllCategories();
      return _categoryDataModel;
    } else {
      _categoryDataModel = AllCategories.fromJson(data.data);
      print(data.data);
      return _categoryDataModel;
    }
  }
}
