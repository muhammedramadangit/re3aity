import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteRegisterCubit extends Cubit<CompleteRegisterState>{
  CompleteRegisterCubit() : super(CompleteRegisterInitState());

  static CompleteRegisterCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String user_id, sex, lat, lng, address, name, desc;
  int catId, homePrice, clinicPrice;
  List catIds = [];
  List homePrices = [];
  List clinicPrices = [];
  List<Map<String, dynamic>> categories;

  Future<void> postCompleteRegister() async {
    emit(CompleteRegisterLoadingState());
    try{
      print("sex : $sex | lat : $lat | lng : $lng | address : $address | name : $name | desc : $desc | categories : $categories | user ID : $user_id");
      final url = "https://mycare.pro/api/completeadvertiserdata";
      SharedPreferences _pref = await SharedPreferences.getInstance();

      FormData formData = FormData.fromMap({
        "user_id" : "362",
        "sex" : "ذكر",
        "lat" : "31.04576019413228",
        "lng" : "31.391787752509117",
        "address" : "18 Gamal Al Din Al Afghani",
        "name" : "محمد رمضان",
        "desc" : "طبيب",
        "categories" : {"categories":[{"cat_id":1,"home_price":100,"clinic_price":200},{"cat_id":2,"home_price":100,"clinic_price":200},{"cat_id":3,"home_price":100,"clinic_price":200}]},
      });

      final Response response = await dio.post(url, data: formData);

      if(response.statusCode == 200 && response.data["msg"] == "success"){
        print(response.data);
        emit(CompleteRegisterSuccessState());
      }else if(response.statusCode == 200 && response.data["msg"] != "success"){
        emit(CompleteRegisterErrorState(response.data["msg"]));
        print("يا عممممممممممممممممممم");
      }

    }catch(e){
      if(e.response != null){
        print("يلا يا نجم");
        emit(CompleteRegisterErrorState(e.toString()));
      }
    }
  }
}

// {"categories":[{"cat_id":1,"home_price":100,"clinic_price":200},]}