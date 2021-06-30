import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:lastre3ayty/re3aytiii/Custom/selectCateModel.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SelectCateController {
  NetworkUtil netWork = NetworkUtil();
  SelectCateModel _selectCateModel = SelectCateModel();
  Future<SelectCateModel> getSelectCate() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var data = await netWork.get('selectcat',
        headers: {
          'Accept':'application/json',
        });
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