abstract class ProviderVerifyState{}

class ProviderVerifyInitState extends ProviderVerifyState{}

class ProviderVerifyLoadingState extends ProviderVerifyState{}

class ProviderVerifySuccessState extends ProviderVerifyState{}

class ProviderVerifyErrorState extends ProviderVerifyState{
  String error;
  ProviderVerifyErrorState(this.error);
}