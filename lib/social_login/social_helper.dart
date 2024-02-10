import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:re3aity/social_login/social_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<SocialModel> loginWithGoogle() async {
  final SocialModel _model = SocialModel();
  final GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication _googleAuth =
  await _googleUser!.authentication;
  _model.socialId = _googleUser.id;
  _model.name = _googleUser.displayName;
  _model.email = _googleUser.email;
  _model.phone = "+966 ";
  _model.password = _googleAuth.accessToken;
  _model.googleToken = await FirebaseMessaging.instance.getToken();
  _model.printData();
  return _model;
}