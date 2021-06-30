import 'package:lastre3ayty/User/models/TermsAndPolicy.dart';
import 'package:lastre3ayty/common/NetworkUtil.dart';

class TermsAndPolicyController {
  NetworkUtil _util = NetworkUtil();
  TermsAndPolicyModel _termsAndPolicy = TermsAndPolicyModel();

  Future<TermsAndPolicyModel> getTerms () async {
    final data = await _util.get("settinginfo",);
    if(data == null){
      _termsAndPolicy = null;
      return _termsAndPolicy;
    }else {
      _termsAndPolicy = TermsAndPolicyModel.fromJson(data.data);
      return _termsAndPolicy;
    }
  }
}