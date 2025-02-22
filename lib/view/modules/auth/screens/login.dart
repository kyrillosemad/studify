import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/auth/login/login_bloc.dart';
import 'package:studify/view/modules/auth/widgets/login_form.dart';
import 'package:studify/view/modules/auth/widgets/login_welocme.dart';
import 'package:studify/view/modules/auth/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Column(
              children: [
                SizedBox(height: 5.h),
                const LogoSection(),
                const WelcomeTextSection(),
                Expanded(
                  child: SizedBox(
                    width: 90.w,
                    child: const LoginForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
