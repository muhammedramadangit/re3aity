abstract class CompleteRegisterState{}

class CompleteRegisterInitState extends CompleteRegisterState{}

class CompleteRegisterLoadingState extends CompleteRegisterState{}

class CompleteRegisterSuccessState extends CompleteRegisterState{}

class CompleteRegisterErrorState extends CompleteRegisterState{
  String error;
  CompleteRegisterErrorState(this.error);
}