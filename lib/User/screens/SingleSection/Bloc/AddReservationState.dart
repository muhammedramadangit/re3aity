abstract class AddReservationState{}

class AddReservationInitState extends AddReservationState{}

class AddReservationLoadingState extends AddReservationState{}

class AddReservationSuccessState extends AddReservationState{}

class AddReservationErrorState extends AddReservationState{
  String error;
  AddReservationErrorState(this.error);
}