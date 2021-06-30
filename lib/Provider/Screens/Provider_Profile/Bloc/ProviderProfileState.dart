abstract class ProviderProfileState{}

class ProviderProfileInitState extends ProviderProfileState{}

class ProviderProfileLoadingState extends ProviderProfileState{}

class ProviderProfileSuccessState extends ProviderProfileState{}

class ProviderProfileErrorState extends ProviderProfileState{
  String error;
  ProviderProfileErrorState(this.error);
}