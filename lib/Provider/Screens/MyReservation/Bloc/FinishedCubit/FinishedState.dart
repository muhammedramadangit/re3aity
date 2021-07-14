abstract class FinishedState{}

class FinishedInitState extends FinishedState{}

class FinishedLoadingState extends FinishedState{}

class FinishedSuccessState extends FinishedState{}

class FinishedErrorState extends FinishedState{
  String error;
  FinishedErrorState(this.error);
}

class GetReservationSuccessState extends FinishedState{}