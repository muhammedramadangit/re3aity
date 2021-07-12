import 'package:lastre3ayty/User/models/Category_model/All_category.dart';
import 'package:lastre3ayty/User/models/Category_model/Category_data.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionController {
  NetworkUtil _util = NetworkUtil();
  AllCategories _categoryDataModel = AllCategories();

  Future<AllCategories> getSection() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    Map<String, dynamic> header = {
      "Accept": "application/json",
    };

    final data = await _util.get("selectcat", headers: header);
    if (data == null) {
      _categoryDataModel = null;
      return _categoryDataModel;
    } else {
      _categoryDataModel = AllCategories.fromJson(data.data);
      print(data.data);
      return _categoryDataModel;
    }
  }
}

// class GetHelperApi {
//   static Stream<List<T>> fetchListOf<T>(String url,
//       String cacheStore,
//       T Function(Map<String, dynamic> data) itemDecoder,
//       String Function(T data) itemEncoder,
//       List<T> Function(Map<String, dynamic> data) jsonBuilder,
//       Map<String, String> headers,) async* {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var strList = prefs.getStringList(cacheStore);
//     bool gotCache = false;
//     if (strList != null) {
//       List<T> cacheResults =
//       strList.map((String s) => itemDecoder(jsonDecode(s))).toList();
//       yield cacheResults;
//       gotCache = true;
//     }
//     try {
//       NetworkUtil _util = NetworkUtil();
//       Response response = await _util.get(url, headers: headers);
//       switch (response.statusCode) {
//         case 200:
//           var body = jsonDecode(response.data);
//           List<T> responseItems = jsonBuilder(body);
//           if (responseItems != null) {
//             prefs.setStringList(
//                 cacheStore, responseItems.map(itemEncoder).toList());
//             yield responseItems;
//           }
//           break;
//         case 404:
//           throw ResourceNotFound('fetchList');
//
//         case 301:
//         case 302:
//         case 303:
//           throw RedirectionFound();
//
//         default:
//           break;
//       }
//     } catch (e) {
//       if (!gotCache) {
//         throw e;
//       }
//     }
//   }
//
//   static Stream<List<CategoryData>> fetchCategories() async* {
//     print('::::::::::::::');
//     final Map<String, String> categoryHeaders = {
//       'Accept': 'application/json',
//     };
//
//     final url = "https://mycare.pro/api/selectcat";
//
//     yield* fetchListOf(
//       url,
//       'categories',
//           (data) => CategoryData.fromJson(data),
//           (CategoryData categoryData) {
//         return jsonEncode(categoryData.toJson());
//       },
//           (data) {
//         AllCategories ac = AllCategories.fromJson(data);
//         return ac.data;
//       },
//       categoryHeaders,
//     );
//   }
// }
