abstract class EditProviderState{}

class EditProviderInitState extends EditProviderState{}

class EditProviderLoadingState extends EditProviderState{}

class EditProviderSuccessState extends EditProviderState{}

class EditProviderErrorState extends EditProviderState{
  String error;
  EditProviderErrorState(this.error);
}