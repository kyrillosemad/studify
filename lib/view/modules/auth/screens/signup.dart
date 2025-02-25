import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/auth/signup/signup_bloc.dart';
import 'package:studify/view/modules/auth/widgets/logo.dart';
import 'package:studify/view/modules/auth/widgets/signup_form.dart';
import 'package:studify/view/modules/auth/widgets/signin_welcome.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Builder(
        builder: (context) {
          var controller = context.read<SignupBloc>();
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    const LogoSection(),
                    const SignupWelcome(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SignUpForm(controller: controller),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
