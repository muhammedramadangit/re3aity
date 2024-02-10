abstract class NewPassState{}

class NewPassInitState extends NewPassState{}

class NewPassLoadingState extends NewPassState{}

class NewPassSuccessState extends NewPassState{}

class NewPassErrorState extends NewPassState{
  String error;
  NewPassErrorState(this.error);
}