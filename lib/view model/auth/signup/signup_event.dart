part of 'signup_bloc.dart';

sealed class SignupEvent {}

class Signup extends SignupEvent {}

class GoToLogin extends SignupEvent {}

class OnPasswordToggle extends SignupEvent {}

class OnRadioChange extends SignupEvent {
  String value;
  OnRadioChange(this.value);
}
