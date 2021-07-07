abstract class EditProfileState{}

class EditProfileInitState extends EditProfileState{}

class EditProfileLoadingState extends EditProfileState{}

class EditProfileSuccessState extends EditProfileState{}

class EditProfileErrorState extends EditProfileState{
  String error;
  EditProfileErrorState(this.error);
}