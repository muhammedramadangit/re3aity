abstract class ProviderConfirmForgetState{}

class ProviderConfirmForgetInitState extends ProviderConfirmForgetState{}

class ProviderConfirmForgetLoadingState extends ProviderConfirmForgetState{}

class ProviderConfirmForgetSuccessState extends ProviderConfirmForgetState{}

class ProviderConfirmForgetErrorState extends ProviderConfirmForgetState{
  String error;
  ProviderConfirmForgetErrorState(this.error);
}