abstract class RemoveState{}

class RemoveInitState extends RemoveState{}

class RemoveLoadingState extends RemoveState{}

class RemoveSuccessState extends RemoveState{}

class RemoveErrorState extends RemoveState{
  String error;
  RemoveErrorState(this.error);
}

class GetReservationSuccessState extends RemoveState{}