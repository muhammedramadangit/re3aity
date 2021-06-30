abstract class ProviderSignUpState{}

class ProviderSignUpInitState extends ProviderSignUpState{}

class ProviderSignUpLoadingState extends ProviderSignUpState{}

class ProviderSignUpSuccessState extends ProviderSignUpState{}

class ProviderSignUpErrorState extends ProviderSignUpState{
  String error;
  ProviderSignUpErrorState(this.error);
}