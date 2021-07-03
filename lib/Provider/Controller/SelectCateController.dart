import 'package:lastre3ayty/Provider/Models/SelectCateModel.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
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
      _selectCateModel = null;
      return  _selectCateModel;
    } else {
      _selectCateModel = SelectCateModel.fromJson(data.data);
      return  _selectCateModel;
    }
  }
}