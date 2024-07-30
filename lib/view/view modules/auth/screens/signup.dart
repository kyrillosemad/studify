import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/view%20modules/auth/widgets/logo.dart';
import 'package:studify/view/view%20modules/auth/widgets/signin_form.dart';
import 'package:studify/view/view%20modules/auth/widgets/signin_welcome.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool secure = true;
  String selectedRadio = "student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              const LogoSection(),
              const SignupWelcome(),
              Expanded(
                child: SizedBox(
                  width: 90.w,
                  child: SignUpForm(
                    signUpForm: signUpForm,
                    username: username,
                    email: email,
                    password: password,
                    secure: secure,
                    selectedRadio: selectedRadio,
                    onSecureChanged: (value) {
                      setState(() {
                        secure = value;
                      });
                    },
                    onRadioChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
