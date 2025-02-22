part of 'login_bloc.dart';

sealed class LoginEvent {}

class Login extends LoginEvent {

}

class GoToSignUp extends LoginEvent {}

class OnPasswordToggle extends LoginEvent {}

class OnRadioChange extends LoginEvent {
  String value;
  OnRadioChange(this.value);
}
