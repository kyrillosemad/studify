import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/view%20modules/auth/widgets/login_form.dart';
import 'package:studify/view/view%20modules/auth/widgets/login_welocme.dart';
import 'package:studify/view/view%20modules/auth/widgets/logo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String selectedRadio = "student";
  bool secure = true;

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
                height: 5.h,
              ),
              const LogoSection(),
              const WelcomeTextSection(),
              Expanded(
                child: SizedBox(
                  width: 90.w,
                  child: LoginForm(
                    loginForm: loginForm,
                    email: email,
                    password: password,
                    secure: secure,
                    onPasswordToggle: () {
                      setState(() {
                        secure = !secure;
                      });
                    },
                    selectedRadio: selectedRadio,
                    onRadioChange: (value) {
                      setState(() {
                        selectedRadio = value.toString();
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
