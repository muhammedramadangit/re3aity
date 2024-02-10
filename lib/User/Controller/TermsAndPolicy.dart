import 'package:re3aity/User/models/TermsAndPolicy.dart';
import 'package:re3aity/common/NetworkUtil.dart';

class TermsAndPolicyController {
  NetworkUtil _util = NetworkUtil();
  TermsAndPolicyModel _termsAndPolicy = TermsAndPolicyModel();

  Future<TermsAndPolicyModel> getTerms () async {
    final data = await _util.get("settinginfo",);
    if(data.statusCode != 200){
      _termsAndPolicy = TermsAndPolicyModel();
      return _termsAndPolicy;
    }else {
      _termsAndPolicy = TermsAndPolicyModel.fromJson(data.data);
      return _termsAndPolicy;
    }
  }
}