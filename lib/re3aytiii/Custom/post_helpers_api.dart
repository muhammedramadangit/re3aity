// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// // import 'package:lastre3ayty/models/client_model/client.dart';
// // import 'package:lastre3ayty/exceptions/exceptions.dart';
// // import 'package:lastre3ayty/models/client_model/client.dart';
// // import 'package:lastre3ayty/models/client_model/client_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PostHelperApi {
//   SharedPreferences sharedPreferences;
//   String token;
//
//   Map<String, String> headers = {
//     'Accept': 'application/json',
//   };
//
//   Future<dynamic> completeData({
//     String name,
//     String sex,
//     String title,
//     List<Map<String, dynamic>> categories,
//     String lat,
//     String long,
//     String userID,
//     String desc
//   }) async {
//     Map<String, String> body = {
//       'name': name,
//       'sex': sex,
//       'lat': lat,
//       'lng': long,
//       'address': title,
//       'user_id': userID,
//       'categories': jsonEncode({"categories": categories}),
//       'desc':desc
//     };
//
//     http.Response response =
//         await http.post(ApiUtl.POST_COMPLETE_DATA, headers: {}, body: body);
//
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         Client client = Client.fromJson(body);
//         return client;
//         break;
//
//       case 401:
//         throw LoginFailed();
//         break;
//
//       case 404:
//         throw ResourceNotFound('Register');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//
//   Future<dynamic> signIn({
//     String phone,
//     String password,
//     String notificationToken,
//   }) async {
//     Map<String, String> body = {
//       'phone': '966' + phone,
//       'password': password,
//       'google_token': notificationToken,
//     };
//
//     http.Response response =
//         await http.post(ApiUtl.POST_SIGN_IN, headers: headers, body: body);
//
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         Client client = Client.fromJson(body);
//
//         return client;
//         break;
//
//       case 401:
//         throw LoginFailed();
//         break;
//
//       case 404:
//         throw ResourceNotFound('Sign in');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//    Future<dynamic> verifyCode(String verifyCode,String token) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     // token = sharedPreferences.get('verified_token');
//
//     Map<String, String> verifyCodeHeader = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ' + token,
//     };
//     Map<String, String> body = {
//       'code': verifyCode,
//     };
//     http.Response response = await http.post(ApiUtl.POST_VERIFY_CODE,
//         headers: verifyCodeHeader, body: body);
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         var data = body['data'];
//         var verifyMessage = body['msg'];
//         token = data['api_token'];
//         return verifyMessage;
//         break;
//
//       case 422:
//         throw UnProcessedEntities();
//         break;
//
//       case 404:
//         throw ResourceNotFound('verify_code');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//
//  Future<dynamic> signUp({
//     String phone,
//     String password,
//     String notificationToken,
//   }) async {
//     Map<String, String> body = {
//       'phone': '966' + phone,
//       'password': password,
//       'confirmpass': password,
//       'google_token': notificationToken,
//     };
//
//     http.Response response =
//         await http.post(ApiUtl.POST_SIGN_UP, headers: headers, body: body);
//
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         Client client = Client.fromJson(body);
//
//         return client;
//         break;
//
//       case 401:
//         throw LoginFailed();
//         break;
//
//       case 404:
//         throw ResourceNotFound('Sign up');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//   Future<dynamic> editPersonalPage({
//     String userID,
//     File file,
//     String name,
//     String phone,
//     String title,
//     String lat,
//     String long,
//   }) async {
//
//
//     FormData data = FormData.fromMap({
//       'user_id': userID,
//       'name': name,
//       'phone': phone,
//       'address': title,
//       'lat': lat,
//       'lng': long,
//     });
//
//     if (file != null) {
//
//       data.files.add(MapEntry('image', await MultipartFile.fromFile(
//         file.path,
//       )));
//     }
//
//
//     Dio dio = new Dio();
// //    dio.options.headers['Accept'] = 'application/json';
//
//     final response = await dio.post(
//       ApiUtl.POST_EDIT_PERSONAL_PAGE,
//       data: data,
//     );
// //        .then((response) => print(response))
// //        .catchError((error) => print(error));
//     print(response);
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//
//         var body = jsonDecode(response.data);
//         return body['msg'];
//         break;
//
//       case 422:
//         throw UnProcessedEntities();
//         break;
//
//       case 404:
//         throw ResourceNotFound('edit personal page');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//
//   Future<String> removeReservation({String reservationID}) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     token = sharedPreferences.get('api_token');
//
//     final Map<String, String> removeReservationHeaders = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ' + token,
//     };
//
//     Map<String, String> body = {
//       'reservation_id': reservationID,
//     };
//
//     http.Response response = await http.post(
//       ApiUtl.POST_REMOVE_RESERVATION,
//       headers: removeReservationHeaders,
//       body: body,
//     );
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         return body['msg'];
//         break;
//
//       case 422:
//         throw UnProcessedEntities();
//         break;
//
//       case 404:
//         throw ResourceNotFound('removeReservation');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//
//   Future<String> updateReservation({String reservationID}) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     token = sharedPreferences.get('api_token');
//
//     final Map<String, String> updateReservationHeaders = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ' + token,
//     };
//
//     Map<String, String> body = {
//       'reservation_id': reservationID,
//     };
//
//     http.Response response = await http.post(
//       ApiUtl.POST_UPDATE_RESERVATION,
//       headers: updateReservationHeaders,
//       body: body,
//     );
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         return body['msg'];
//         break;
//
//       case 422:
//         throw UnProcessedEntities();
//         break;
//
//       case 404:
//         throw ResourceNotFound('updateReservation');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
// Future<String> logout({String reservationID}) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     token = sharedPreferences.get('api_token');
//
//     final Map<String, String> updateReservationHeaders = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ' + token,
//     };
//
//     Map<String, String> body = {
//       'user_id': reservationID,
//     };
//
//     http.Response response = await http.post(
//       "https://mycare.pro/api/upstatus",
//       headers: updateReservationHeaders,
//       body: body,
//     );
//     print("sadasdsa");
//     print(response.body);
//     switch (response.statusCode) {
//       case 200:
//       case 201:
//         var body = jsonDecode(response.body);
//         return body['msg'];
//         break;
//
//       case 422:
//         throw UnProcessedEntities();
//         break;
//
//       case 404:
//         throw ResourceNotFound('updateReservation');
//         break;
//
//       case 301:
//       case 302:
//       case 303:
//         throw RedirectionFound();
//         break;
//
//       default:
//         return null;
//         break;
//     }
//   }
//   Stream<T> fetchDataOf<T>(
//       String cacheStore,
//       T Function(Map<String, dynamic> data) itemDecoder,
//       String Function(T data) itemEncoder,
//       T Function(Map<String, dynamic> data) jsonBuilder,
//       dynamic body,
//       ) async* {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var strData = prefs.getString(cacheStore);
//     bool gotCache = false;
//     if (strData != null) {
//       T cacheResults = itemDecoder(jsonDecode(strData));
//       yield cacheResults;
//       gotCache = true;
//     }
//     try {
//       http.Response response = await http.post(
//         ApiUtl.POST_PERSONAL_PAGE_DATA,
//         headers: headers,
//         body: body,
//       );
//       switch (response.statusCode) {
//         case 200:
//           var body = jsonDecode(response.body);
//           T responseItem = jsonBuilder(body);
//           if (responseItem != null) {
//             prefs.setString(
//               cacheStore,
//               itemEncoder(responseItem),
//             );
//             yield responseItem;
//           }
//           break;
//         case 404:
//           throw ResourceNotFound('fetchData');
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
//   Stream<ClientData> fetchClientData() async* {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var userID = sharedPreferences.get('user_id');
//     print(userID);
//     final Map<String, String> fetchClientDataBody = {
//       'user_id': userID.toString(),
//     };
//
//     yield* fetchDataOf(
//       ApiUtl.POST_PERSONAL_PAGE_DATA,
//           (data) => ClientData.fromJson(data),
//           (ClientData clientData) {
//         return jsonEncode(clientData.toJson());
//       },
//           (data) {
//         Client client = Client.fromJson(data);
//         return client.data;
//       },
//       fetchClientDataBody,
//     );
//   }
// }
