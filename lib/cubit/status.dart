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

class AddDose extends Status {}

class EditDose extends Status {}

class DeleteDose extends Status {}
