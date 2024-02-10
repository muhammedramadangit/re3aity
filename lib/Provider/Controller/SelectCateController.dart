import 'package:re3aity/Provider/Models/SelectCateModel.dart';
import 'package:re3aity/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SelectCateController {
  NetworkUtil _util = NetworkUtil();
  SelectCateModel _selectCateModel = SelectCateModel();

  Future<SelectCateModel> getSelectCate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept" : "application/json",
    };
    var data = await _util.get('selectcat', headers: header);
    print(data);
    if (data == null || data == "internet") {
      _selectCateModel = SelectCateModel();
      return  _selectCateModel;
    } else {
      _selectCateModel = SelectCateModel.fromJson(data.data);
      return  _selectCateModel;
    }
  }
}