// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:studify/core/constants/routes_name.dart';
import '../../../services/firebase/auth/sign_up_fun.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<Signup>(_signUp);
    on<GoToLogin>(_goToLogin);
    on<OnPasswordToggle>(_onPasswordToggle);
    on<OnRadioChange>(_onRadioChange);
  }
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool secure = true;
  String selectedRadio = "student";

  FutureOr<void> _signUp(Signup event, Emitter<SignupState> emit) {
    emit(SignupLoading());
    try {
      signUpFun(username.text, email.text, password.text, selectedRadio);
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError());
    }
  }

  FutureOr<void> _goToLogin(GoToLogin event, Emitter<SignupState> emit) {
    Get.offAllNamed(AppRoutes().signUp);
  }

  FutureOr<void> _onPasswordToggle(
      OnPasswordToggle event, Emitter<SignupState> emit) {
    secure = !secure;
    emit(SignupInitial());
  }

  FutureOr<void> _onRadioChange(
      OnRadioChange event, Emitter<SignupState> emit) {
    selectedRadio = event.value;
    emit(SignupInitial());
  }
}
