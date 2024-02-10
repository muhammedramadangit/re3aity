abstract class ProviderLoginState{}

class ProviderLoginInitState extends ProviderLoginState{}

class ProviderLoginLoadingState extends ProviderLoginState{}
class ProviderSocialLoginLoadingState extends ProviderLoginState{}

class ProviderLoginSuccessState extends ProviderLoginState{}

class ProviderLoginErrorState extends ProviderLoginState{
  String error;
  ProviderLoginErrorState(this.error);
}