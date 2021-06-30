abstract class ConfirmForgetState{}

class ConfirmForgetInitState extends ConfirmForgetState{}

class ConfirmForgetLoadingState extends ConfirmForgetState{}

class ConfirmForgetSuccessState extends ConfirmForgetState{}

class ConfirmForgetErrorState extends ConfirmForgetState{
  String error;
  ConfirmForgetErrorState(this.error);
}