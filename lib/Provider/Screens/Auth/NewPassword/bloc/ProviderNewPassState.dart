abstract class ProviderNewPassState{}

class ProviderNewPassInitState extends ProviderNewPassState{}

class ProviderNewPassLoadingState extends ProviderNewPassState{}

class ProviderNewPassSuccessState extends ProviderNewPassState{}

class ProviderNewPassErrorState extends ProviderNewPassState{
  String error;
  ProviderNewPassErrorState(this.error);
}