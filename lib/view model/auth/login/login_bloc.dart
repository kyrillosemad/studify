import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:studify/core/constants/routes_name.dart';
import 'package:studify/services/firebase/auth/login_fun.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_login);
    on<GoToSignUp>(_goToSignUp);
    on<OnPasswordToggle>(_onPasswordToggle);
    on<OnRadioChange>(_onRadioChange);
  }

  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedRadio = "student";
  bool secure = true;

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await loginFun(email.text, password.text, selectedRadio);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError());
    }
  }

  void _goToSignUp(GoToSignUp event, Emitter<LoginState> emit) {
    Get.offAllNamed(AppRoutes().onboarding1);
  }

  void _onPasswordToggle(OnPasswordToggle event, Emitter<LoginState> emit) {
    secure = !secure;
    emit(LoginInitial());
  }

  void _onRadioChange(OnRadioChange event, Emitter<LoginState> emit) {
    selectedRadio = event.value;
    emit(LoginInitial());
  }
}
