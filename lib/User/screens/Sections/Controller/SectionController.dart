import 'package:lastre3ayty/User/screens/Sections/model/SectionModel.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionController {
  NetworkUtil _util = NetworkUtil();
  SectionModel _sectionModel = SectionModel();

  Future<SectionModel> getSection() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
    };

    final data = await _util.get("selectcat", headers: header);
    if (data == null) {
      _sectionModel = null;
      return _sectionModel;
    } else {
      _sectionModel = SectionModel.fromJson(data.data);
      return _sectionModel;
    }
  }
}
