abstract class Status {}

class intiState extends Status {}

class ChangePageState extends Status {}

class SignSuccessState extends Status {}

class SignLoadingState extends Status {}

class SignErrorState extends Status {
  final error;
  SignErrorState(this.error);
}

class ChangeType extends Status {}

class loginSuccessState extends Status {}

class loginLoadingState extends Status {}

class loginErrorState extends Status {
  final error;
  loginErrorState(this.error);
}

class LoadingDose extends Status {}

class AddDose extends Status {}

class AddDoseError extends Status {
  final error;
  AddDoseError(this.error);
}

class EditDose extends Status {}

class DeleteDose extends Status {}

class GetDosesSuccessfully extends Status {}

class GetDosesError extends Status {
  final error;
  GetDosesError(this.error);
}

class GetTime extends Status {}

class LoadingDeleteDose extends Status {}

class SuccessDeleteDose extends Status {}

class ErrorDeleteDose extends Status {
  final error;
  ErrorDeleteDose(this.error);
}

class LoadingUpdateDose extends Status {}

class SuccessUpdateDose extends Status {}

class ErrorUpdateDose extends Status {
  final error;
  ErrorUpdateDose(this.error);
}
