import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/functions/validator.dart';
import 'package:studify/view%20model/auth/login/login_bloc.dart';
import 'package:studify/view/modules/auth/widgets/role.dart';
import 'package:studify/view/shared_widgets/custom_text_form_field.dart';
import 'package:lottie/lottie.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        var controller = context.read<LoginBloc>();
        return Form(
          key: controller.loginForm,
          child: Column(
            children: [
              SizedBox(height: 2.h),
              CustomTextFormField(
                name: "Email",
                controller: controller.email,
                validatorFunction: (value) => validator(value, 30, 3, "email"),
                textInputType: TextInputType.emailAddress,
                obscure: false,
                icon: Icons.email,
                suffixIcon: null,
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                name: "Password",
                controller: controller.password,
                validatorFunction: (value) =>
                    validator(value, 50, 3, "password"),
                textInputType: TextInputType.text,
                obscure: controller.secure,
                icon: Icons.password,
                suffixIcon: InkWell(
                  onTap: () => controller.add(OnPasswordToggle()),
                  child: Icon(
                    controller.secure ? Icons.visibility_off : Icons.visibility,
                    color: MyColors().mainColors,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  "Sign in as",
                  style:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                ),
              ),
              RoleSelection(
                selectedRadio: controller.selectedRadio,
                onRadioChange: (value) {
                  controller.add(OnRadioChange(value.toString()));
                },
              ),
              SizedBox(height: 1.h),
              InkWell(
                onTap: () {
                  if (controller.loginForm.currentState!.validate()) {
                    controller.add(Login());
                  }
                },
                child: Container(
                  width: 80.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: MyColors().mainColors,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: state is LoginLoading
                        ? Lottie.asset(
                            'assets/Animation - 1740512529205.json',
                            height: 15.h,
                            fit: BoxFit.contain,
                          )
                        : Text(
                            "Login",
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.white),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                        fontSize: 13.sp, color: MyColors().mainColors),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.add(GoToSignUp());
                    },
                    child: Text(
                      "Sign UP",
                      style: TextStyle(
                          fontSize: 13.sp, color: MyColors().mainColors),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
