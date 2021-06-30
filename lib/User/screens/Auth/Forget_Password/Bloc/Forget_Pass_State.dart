abstract class ForgetPassState{}

class ForgetPassInitState extends ForgetPassState{}

class ForgetPassLoadingState extends ForgetPassState{}

class ForgetPassSuccessState extends ForgetPassState{}

class ForgetPassErrorState extends ForgetPassState{
  String error;
  ForgetPassErrorState(this.error);
}